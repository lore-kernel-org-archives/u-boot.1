Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB1DCC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3999581231;
	Thu, 15 Oct 2026 14:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y4p4Y7M5eFYB; Thu, 15 Oct 2026 14:23:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7412381218
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074217;
	b=h6XgSAlRhnPdUlaxa21zxmPHFBCQPXZnCRtk3jk6KwYLxvoTHTxpuggTEmFFlo6LZQnR
	 G8aZyMV74Lc/6DSIAaEeZGscreR+a2luENHj8xXFKm57PpZUh8K6znGKXbKniuB/rse66
	 6IZPonaE0L+SvoUhrUby8nJGDT9eukfMvMQZ3boOKusxabxZbPYZeHXM+OhiSqwi6MEYS
	 vn9AVS9ayV2qzf/+Hw+rR5zXN5RKxe3Ym+a4LDp5x3E4cTkYUDl0bulx6vWJr7C0DP/2/
	 JWGH1mL4cd7qMp5BQR8QKI2/jdXko8gu5lfV2ZdZg8eneIaDtPdy9awy4OuoQ5CdpVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
	b=IV57qdsYXo+0LCtJ/GqXL3+0bNIbJQ5COEnguDHQGgIEJUTtjBrJQ7p4hh24nk1z/8AS
	 WxLTiYXr7xKYp0E/JxZfDUXHjEW0yVbXNGlyTMCIY2nufh96PSfD5IsLn1+Oo617wCo9n
	 Q53Z9akekwwHDqIgyxw2l7abEM2bRd8GvTP3KcSCxGgFr5C9VrAS9dBwQKURSgWRB/jiL
	 ZpT/4DnWynaadncmZT3AhjVpUHzIbnz/LgBAX30gD4LzQMamXC1CAh7D+9wbxzopv1dX0
	 PdUuy5c+PSIgC8uphxIFs3i6rtKJemOnM4A1kN2m9ljvWCDB+y4cbH8XsgbOxmUYFjw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074217;
	bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehNMiN1nlYba4Y9DcZPrarSuNYHdi39KW2BH4sMmMmJQ+ucIrggjk0rVAPBClMLb0
	 VvB3dBDYuz720B4ktVnYK3oN2UUzij5B8tBPT6g5vYVa/VBvKDeSOL5o/ZgRqgu75S
	 RXdE5idjzLdTvTcjRY41reGI8W77ZVDFKLrAaWE2qD2wnh+96qoI1RfT9FO4avYzot
	 /sauC/GJE/N5xHm0IHPQe9Ou1H14YEtvsGMresYaKy9RYbIj9DWSXhIl7TdT6cRwJT
	 71ADfzhv4M/O678OaayolXkOgY3PpfJ6W5iGY3PFi0u//geH2gaUVDaRCKhQgngPqz
	 elzaJIlU+STGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7412381218;
	Thu, 15 Oct 2026 14:23:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B8CA2AC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4D8B5408FB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LW4F6mJoox-W for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:23:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E010408EB
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074215;
 b=E0kaj3GIAdhyVRxrVcJ3wXx/IPpVIpHpt3Yyz+fDwn6j0SeeE9l1bNLo3EgLCYfpk8r2
 PnkEh8e81+SGCGlFH9oz7l9yNw4+bTe72Pu4tfgtVjCKwQcNRSduqR24T5eQ6fGco+iml
 Hxd8XZuzY/oizXBtRpEERX8qWwJT6H4g7uGu2uEvoFse4/ChXa+a2aMlqEKEDfzU1UMA7
 zzIQnCuCiwwg0Rwzlp7vIh/nQ0vFtr7XIYjWDUBtQPwDq513wXuM7goh8D3HXchzOYM7y
 2f4G4V13Vogj22XR6dhEK3P52BpSY2DF2vu/jFluJybt3+PJJCPh1ZLlkLdXDyN455g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074215;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
 b=hr3JOz//3spcGr+uHzQJ5YoKBWgh11GTNF0Q91Dem4IvIZeIVbaDzPNH6pHlpeK5Ce7h
 K1aAIAkD8vAYz03UH2W032k0qK9ORcooXA+6XRyU9swdS6ZBFtu24xMl3KAAM+WF5v3vN
 E21f4Q3xpOWoPE2n3KsBsBNpaPTCgFaLlBkM9TEaxbXGdDPk49+MzCODDm6EcZzOsVbzg
 K2iz/9jac2PHgUf+1vup5l0mhRqo4YosD0y+82UeEUH1pAeFyE3Uhb/UsFTu4OdRRaRrG
 bfhXA2jppMoKnO2xupxjaW226ei4sAWBUYbaTQJiCFA7E8+Up0YpC9g4eUnhpM6Ihhg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=UkiilOwT; 
 arc=none smtp.remote-ip=185.136.64.228
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 14:23:35 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=UkiilOwT
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-294854-2026101514222960553478ba000207ed-vnfevx@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E010408EB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:23:35 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 2026101514222960553478ba000207ed
 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 16:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uKsXn4P4JYQ5oRmDjiLJnV9Xje5SpdSCNT51SpxYsg0=;
 b=UkiilOwTVnvH1aTWMW1vwR3v2Q0n72dm/bnhTlX2LmF+1M+maQizi+dNKYHDkeyE23OvZc
 iGqhQSQ6gzGSlr1J8tEAAN72qYdZIjA5jW9vbmKd9tLaZ8fmVCJcAk9te5n4q+MMdRckkMh9
 ChLw6V9TD4wlF4A1CZ4iGqXiEAlPudOQqDN2wcIklf9m8BfTj0kuQSRHKvgOzUIKuTB/5oGW
 iS4Pj0UwhPJTbtQyLTGd4rOSr+l7n93IJUZ/IwJjSW/rzcE8/3QMdNXwgolfwEcj81jtRinu
 jP8309aX68ZUgKqAmFpG/LUklt/lqommmr/a5uvhkyPZAcltDaQQ9rdw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 3/3] board: qemu: arm/riscv: Probe watchdogs late
Date: Thu, 15 Oct 2026 16:22:21 +0200
Message-ID: <69463bbb6e376894444103b6eaf478f854ac4c6f.1792074141.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1792074141.git.jan.kiszka@siemens.com>
References: <cover.1792074141.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

The only watchdog QEMU offers us on non-x86 virt platforms is the
i6300esb. This one is PCI-attached, but watchdog probing will happen
before PCI, so will miss it. Redo this late so that we gain autostart
support.

Deliberately limited to contemporary ARM and RISC-V.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/emulation/qemu-arm/qemu-arm.c     | 5 +++++
 board/emulation/qemu-riscv/qemu-riscv.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..529bffa3e49 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -14,6 +14,7 @@
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <wdt.h>
 
 #include <linux/kernel.h>
 #include <linux/sizes.h>
@@ -114,6 +115,10 @@ int board_late_init(void)
 	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
 		usb_init();
 
+	/* watchdog may come via PCI but was probed too early */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	return 0;
 }
 
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index ce5bc34ca71..5ed21b286ee 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -14,6 +14,7 @@
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
+#include <wdt.h>
 
 #if IS_ENABLED(CONFIG_MTD_NOR_FLASH)
 int is_flash_available(void)
@@ -38,6 +39,10 @@ int board_late_init(void)
 	 */
 	virtio_init();
 
+	/* watchdog may come via PCI but was probed too early */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	return 0;
 }
 
-- 
2.47.3

