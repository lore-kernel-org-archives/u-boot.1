Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556D5D6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 21:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A057A895AC;
	Tue, 19 Nov 2024 22:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=vodafonemail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=vodafonemail.de header.i=@vodafonemail.de header.b="V2n7hNY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D4A988E63; Tue, 19 Nov 2024 22:02:08 +0100 (CET)
Received: from mr6.vodafonemail.de (mr6.vodafonemail.de [145.253.228.166])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337A888DC6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 22:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=vodafonemail.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yuriz@vodafonemail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
 s=vfde-mb-mr2-23sep; t=1732050126;
 bh=ewfF4GImWBs4lIc5QAeUDXym7xuvjdtlJeneoBe8rPw=;
 h=From:To:Subject:Date:Message-Id:X-Mailer:From;
 b=V2n7hNY4Khe6pAVDcYmG9fYMAybJF1fXsW7CvFTxUCquETRiErVZhUbK8bmwh6CaY
 KUMXuOE3xQSw2K3JrxSC1VIaiF+4iSo8nrLpfPfD7L7Wn6jw2mKrJ5yb9phvtHjINc
 2uV1K25j7D71mXTL4M48gALXugRGkiIjlD9jP5kQ=
Received: from smtp.vodafone.de (unknown [10.0.0.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mr6.vodafonemail.de (Postfix) with ESMTPS id 4XtH4G0FSKz1xyC
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 21:02:06 +0000 (UTC)
Received: from tachyon.qrv-systems.net
 (ip-095-222-025-162.um34.pools.vodafone-ip.de [95.222.25.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 4XtH465j6xz9rw1;
 Tue, 19 Nov 2024 21:01:55 +0000 (UTC)
Received: by tachyon.qrv-systems.net (Postfix, from userid 516)
 id 7D1C32E01AA; Tue, 19 Nov 2024 22:01:55 +0100 (CET)
From: Yuri Zaporozhets <yuriz@vodafonemail.de>
To: u-boot@lists.denx.de
Cc: Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: [PATCH] configs: enable CONFIG_PCI_REGION_MULTI_ENTRY=y in
 sifive_unmatched_defconfig
Date: Tue, 19 Nov 2024 21:59:59 +0100
Message-Id: <20241119205959.13579-1-yuriz@vodafonemail.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 1107
X-purgate-ID: 155817::1732050121-DA511466-C2E6518A/0/0
X-Mailman-Approved-At: Tue, 19 Nov 2024 22:50:44 +0100
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Currently, the PCI subsystem selects the small "region 2" (which starts at 0x7000000)
as bus_addr/phys_addr. As a consequence, the BAR0 on PCIe video card cannot be initialized,
because it simply doesn't fit into 0x1000000 bytes size of "region 2".

U-Boot should use "region 1" instead (the one which starts at 0x60090000), because
it has much bigger size (0xFF70000), and easily accomodates BAR0 of the video card.
Linux kernel also uses 0x60090000 as bus_start/phys_start.

Signed-off-by: Yuri Zaporozhets <yuriz@vodafonemail.de>
---
 configs/sifive_unmatched_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index 058e5fab68..d5c7d5bfa3 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -36,6 +36,7 @@ CONFIG_DISPLAY_BOARDINFO=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_ID_EEPROM=y
 CONFIG_PCI_INIT_R=y
+CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_SPL_MAX_SIZE=0x100000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SYS_MALLOC=y
-- 
2.39.5

