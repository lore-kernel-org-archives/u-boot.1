Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2B28C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:48:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9467680C69;
	Mon, 10 Feb 2025 17:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DmtGEJDK";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="fZcvktbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70BCC803CC; Mon, 10 Feb 2025 16:30:05 +0100 (CET)
Received: from a7-40.smtp-out.eu-west-1.amazonses.com
 (a7-40.smtp-out.eu-west-1.amazonses.com [54.240.7.40])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47186807D6
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 16:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=01020194f07b5820-3d5c46c6-bccc-42e7-856c-179e6f938eba-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1739201403;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=It9ThDyyptNEulxiBl/UxUtxpS2tP3iIjoyXhNx7pBM=;
 b=DmtGEJDKF4iktHox8Tuxe9D2HGSCXOy+7zFZgiTduZSVOriYK2HY41+GgyIFd/oo
 LKMdLOjEJ9JRi5S58bfpKei7SIPOuGUZMrZFshKPWH5RZqkidgEdEuPrE1rLg4vsngO
 rJicp6QcmfmX3wCoIl1qc2Zy2VvMNzwLy+UgEVNpprbnwdnb6u6sZHUmc1kQbZzS+px
 aURdfEePEXowA+A3I66NWiDw7HnCLWWasu69fUwtqHjQQaslki3ZBUrn8a2/yXNFIlN
 x0Bxqk9oEo9Ld85JiNi5LlULTX0z9B1sh3DGFlvVgQY/MfHaSebTOpA665SjoVCLSci
 E0QCm9oWdA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1739201403;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
 bh=It9ThDyyptNEulxiBl/UxUtxpS2tP3iIjoyXhNx7pBM=;
 b=fZcvktbgxe4zcZ2a4ETrrDO9JoDQH4dlCIiTRlA4foeSuTXbVzLrop0Kp+zrG0Y9
 whtQoY80gyv6Tbt7EWfMt4I86dfRbWj/hLWfwNJggdUOlYxTaQmr0teNnY73piEjM3A
 D2oPenWQmy2aZDb4eO2SRym3xOH5N6Q7GTchGaWA=
From: Arnaud Patard <arnaud.patard@collabora.com>
To: u-boot@lists.denx.de
Cc: Arnaud Patard <arnaud.patard@collabora.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 3/6] arch/arm/mach-rockchip/rk3399/rk3399.c: Add gadget device
 to boot devices
Date: Mon, 10 Feb 2025 15:30:02 +0000
Message-ID: <01020194f07b5820-3d5c46c6-bccc-42e7-856c-179e6f938eba-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210152947.3909357-1-arnaud.patard@collabora.com>
References: <20250210152947.3909357-1-arnaud.patard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2025.02.10-54.240.7.40
X-Mailman-Approved-At: Mon, 10 Feb 2025 17:47:57 +0100
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

Define the device node used when booting over usb, allowing to
use 'same-as-spl' boot entry.

Signed-off-by: Arnaud Patard <arnaud.patard@collabora.com>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 1ce43c6f0d4..681eecb1edd 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -27,6 +27,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe330000",
 	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff1d0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@fe320000",
+	[BROM_BOOTSOURCE_USB] = "/usb@fe800000/usb@fe800000",
 };
 
 static struct mm_region rk3399_mem_map[] = {
-- 
2.39.5

