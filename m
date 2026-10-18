Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2195CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 10:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 100C181285;
	Sun, 18 Oct 2026 10:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2265jLru5AS; Sun, 18 Oct 2026 10:52:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3E914811EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792320768;
	b=PODgayxIYYYa/Vccs6xpTKn0AYfwVNxESdfdEyrN7GCNVMRJkaGglHI3d1eHQvMKf4V1
	 LOQ8kMA4SeLbxssLdyc3fRBkhtV1VjYd+L1XCnqf8u0i3/a/QELeW31oLIXJ0DnmdsK1R
	 3Ay1I/4QamUyKuOTJ4L6EKiXMqWI9oifr+KvIntE/6uq/vYZK7h6nEj9UvBYzRjO9oHMX
	 agOIz6OkcRCAWcTcu3oBaclrO8Jrir4G5fv2kHNYiXxRdvCBiefueIDndCy7v8aJkL5ma
	 o9XU7PLpdECvZdwwniCc/9GCWhpiOJ13F0IKUWmLS+jeBqUtxaaBobTJYtyljaKusTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792320768;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=suizmsdmiQrQmGozcyVPkKXsXdgJz0551pSTIfFn42c=;
	b=TLoKJ2++CljHoZfRIUUtduTnHI08mGV/+hw2+KVbSl6i68zfo+ZHfK6NkEd8dNhNXE5l
	 unzKNMDk7mz4ngpXpz4sIliEsVKzog7xcOWogNFfgxhEILbFXALLrgbUnG6yMeISmmkS7
	 osJaz+MBs1E11BaSODBeT+aJT4tJDfZZAnggEl5R7ckvtFYeguDnUlOeHrfn7hqOyTm2N
	 ufGq784iGOAe7Ahc3IMGAmEMm1kj5wOYMXFeFaNrCPKAbDGueJpT9i350va72+h5FdNsX
	 9XFBeA6HB+TujwQahYIzIUy71m9vdXTOj551LZc9nii1OrpF8/OFyFMmMMH+gU3zgYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=M4YgqUoK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792320768;
	bh=suizmsdmiQrQmGozcyVPkKXsXdgJz0551pSTIfFn42c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nstHIin/GOGWT6pZep5f3ZE5r9T0kK/l90mD+YQSp+0bCSdXv/zEjjjfXx/WASzTz
	 VOXKKEItaWjAoPpSCQpLF4jkfe4yUH54wwdSt1ijEvZd/9J3N2B9I12lvqtLLpMVRC
	 3cUWNbcrGbvVPOtnIeZc2vL+3lj8pEbeHm4s2Rulij3WHsgerPlsA6r2HB1PJxZq1O
	 7mrOjLPLT14CDncbL1GNu2gqhGGqU0w7yv78lk0vHlAr2fYmKGFN0qtbFXmQiRe0DP
	 bSz9QMdXDIBTe1Qh+PA3ckrt+yJVbQLFxWzCWei1Kf+aqaryPUHF/Oad4XR0s8fkt7
	 ZvF9zLg1NTmAw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E914811EC;
	Sun, 18 Oct 2026 10:52:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C4E0D769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB3F2811E7
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDcJP_ykmz42 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 10:52:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2B139811EC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792320765;
 b=ElcwAOGtV7XrC5IxkWHIbgj3+AEJWnbwX8IxPiVjRSzYQIHUrJXgCn4+kqXJuHfl3vvD
 po367S+tsv/LDDu0SuYKj1lO3WSamY6IhbioqFwOkxlQOCWZfpLeh6fjGMNo+3PLW4TOe
 zKEXImeSN6LR5xTro3Yaol14+hMK0/BbiKkvynyNev3aEtWYVcjEF69PlnHrMaFkptFgd
 FRdpfZpslpVErolW4ax91rUhJXOKpCwUxz76Qzvletm/7JM2umu7jUAfYyCJHv+Xiks70
 gnO98Z+ZYmIwSGCWkIU6YrUInDTZKXxWQFfS+LTZjgjsunEaVXr0faJgckD5VNllxig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792320765;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=suizmsdmiQrQmGozcyVPkKXsXdgJz0551pSTIfFn42c=;
 b=j7g+z4f0JUQNZ+UUtGMwpSsq4eUS06eznGXOsGiOMJXRgoxQOaybE0LixjTKiZQTWhQU
 BDMidTTQgLE6pWcbIdUjVcYHAu7649PSxIr+498Hb+lqOFKe5r4DF+bS0zRvwuLzbQob3
 ntpSCXUHLIuj+Ep1gydNPEPyKCjhSe9dUvWHzqm8agFFja1Hm7x6yuAONMi2CABENT9JW
 bWtGQjtMQ6FrhqiQy337z1k0+EhteYQYjYgXlk/Y4lukIWbz1IGm2MdUFLoOaPmtXrdpO
 vVG4rLIhIyeOQ766Q/Wic/gotEthfcsYLFenfI94LKYx3CMMh2uzRjzSQOPj5/i6R1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=M4YgqUoK; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-202610181052399de03e02d7000207ab-9lnmfn@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=M4YgqUoK
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B139811EC
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:52:42 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202610181052399de03e02d7000207ab
 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 12:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=suizmsdmiQrQmGozcyVPkKXsXdgJz0551pSTIfFn42c=;
 b=M4YgqUoKM+8UijjqszRSwQ4iuuWHXnDsBZo2yKPl8kbm9Qp4BGogV2LTDWntDpk9QtckNP
 Ybkp4St8dQnbwC2vzvtFjssZhOgpzUem/tZ7d8h1TiLk30OY5/YEJmYz9Bb+Br1Cj59R6lZr
 ensAoKRB2CxIP64kJCpvIyjSD/5vMQ3zKEsMSODwzCJfia6kDqN0uUuXz+bjhKlERiV/4+JT
 CHur0LIl+2Cml0EGU/dePUA7qYcOhEMlMZXdOfl9Axr3CLDbzpri0ThymCPqyDTaehYi7fh/
 bgQZxLRHCw1AIOdeJuNygfaW8GnidW+XC9E9YrbEqXFkhqlanFkpfmTw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v4 3/3] board: qemu: arm/riscv: Probe watchdogs late
Date: Sun, 18 Oct 2026 12:52:36 +0200
Message-ID: <f2b9184f9b2977824a978ff5a5e86f66b7c5010c.1792320756.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
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
Reviewed-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode
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

