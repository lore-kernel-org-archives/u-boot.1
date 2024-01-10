Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100F8C47073
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 20:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08179878DF;
	Wed, 10 Jan 2024 21:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=aurel32.net header.i=@aurel32.net header.b="fOl36dCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA7E87985; Wed, 10 Jan 2024 21:27:00 +0100 (CET)
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A388A876F6
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 21:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=aurel32.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aurelien@aurel32.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
 ; s=202004.hall;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
 Content-Description:In-Reply-To:References:X-Debbugs-Cc;
 bh=WVUxbxdM5DJr7+RBiBvDWyBs1pHf7Z0tU8I/eJudM6c=; b=fOl36dCRoCYfSXbau15CyQjdBs
 tlns8paxmWH7anDu1pe2W6oQNzVUgfqcqpTwtRuv82xJEKN3EiHptwmLGL1N/X8R2ChfvwLrHONYI
 U3Haxy41x6Qs4NTXASGtKaQxxVPt4sKkgtyIochPW+OWf6YZPGBqmDqyX7C6QcCBPDGsHPABC/CWl
 TmiZJMZxXM7uuaSnWcpNDfpQZqS9NPX326oq8djKjupa2vBuW230y9zuGkRYk9wkKiLKjqbU2Vcdb
 Px5siQPJrr6ALymmSEFaAIfyxgHfFcgFoBcU8FHXP/d9SHe1qpq39uH6ZX4JoyOAAeT847cci1HUB
 sU4sHRag==;
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::2] helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <aurelien@aurel32.net>) id 1rNfAA-00DGhQ-0k;
 Wed, 10 Jan 2024 21:26:58 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: u-boot@lists.denx.de
Cc: Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] riscv: qemu: enable booting on a second virtio device
Date: Wed, 10 Jan 2024 21:26:53 +0100
Message-ID: <20240110202656.984622-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Jan 2024 21:51:41 +0100
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

QEMU RISC-V supports multiple virtio devices, but only tries to boot to
the first one. Enable support for a second virtio device, that is useful
for instance to boot on a disk image + an installer. Ideally that should
be made dynamic, but that's a first step.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 include/configs/qemu-riscv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
index 584559cfa3..2f594bfcfd 100644
--- a/include/configs/qemu-riscv.h
+++ b/include/configs/qemu-riscv.h
@@ -23,6 +23,7 @@
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(VIRTIO, virtio, 0) \
+	func(VIRTIO, virtio, 1) \
 	func(SCSI, scsi, 0) \
 	func(DHCP, dhcp, na)
 
-- 
2.42.0

