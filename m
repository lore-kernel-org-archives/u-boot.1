Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D880C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 11:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4656E80B33;
	Mon,  3 Aug 2026 11:34:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7QdLaoNneBZ2; Mon,  3 Aug 2026 11:34:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AF62808C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785756865;
	bh=NZngv2L2Fc2L3owDEgg8BPMNoHr5K/SQDxXjEMK/RVg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MCcqjF7NGuQ0t33TfdqyCAvl6SoXAUEignpNNTFNepLiLZa1ayAYNGlTPBoGeqn4S
	 uXXGKemgz0jplkBdL1NH0ukyawsGARVG5V1sT1IBzZMF0GabRtl3mHW+xx2ix3u7r+
	 a+kLS75+oMbrkpo7H5FqV2QOEIRFapszh95wQdC8XME+AVSNEsJCRLF56HSdzxwLkY
	 4rgIMlj50Mu/zLipLLYLMV0x61HCaOa7HCBXwGWzc+6X3MS8pr3e6GhDlMKiR+wdBN
	 i0ceR3wOu0w3jvv6QB6zyngRZ1sLkBtkd3zNlExcITSZLNWm3FZEKGXsqhJ4iQe1nC
	 Et6Quk7Cut54g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8AF62808C1;
	Mon,  3 Aug 2026 11:34:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E0A72AA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 11:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4422C60746
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 11:34:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOkHkGPZYipG for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 11:34:23 +0000 (UTC)
X-Greylist: delayed 331 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 03 Aug 2026 11:34:23 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D75E60745
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D75E60745
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=gregor.herburger@linutronix.de;
 receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D75E60745
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 11:34:22 +0000 (UTC)
From: Gregor Herburger <gregor.herburger@linutronix.de>
Date: Mon, 03 Aug 2026 13:28:40 +0200
Subject: [PATCH v2] rpi: copy /chosen/bootloader partition and set
 boot_partition
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-tryboot2-v2-1-30c071f2ee15@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGd7cGoC/0WMywrCMBBFf6XM2kge9oEr/0NcpOnUjmgik7RUS
 v/dVBG5qwPnngUiMmGEY7EA40SRgs+gdwW4wforCuoyg5a6ko00IvGrDSFp0bhSa2XqCksLWX8
 y9jR/UufLl+PY3tCl7b8ZPYeHSAOj/Sdr2fySYlIiz1h1sGhdX6vTnfyYOHia9x3Cur4BpB9AP
 a8AAAA=
X-Change-ID: 20260803-tryboot2-8c5221376e5a
To: u-boot@lists.u-boot-project.org
Cc: Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756526; l=1961;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=GV362VbkbCP8SaTnPApY53jBbOrIJ/pzS57NDIa1jEA=;
 b=9Vl3vJcoqPXWIGn71kgbAHfwTgKbi9Id2fuJBu0hqLJPb/awR8YV+pX7KvAZedhXYFD9MVByd
 l1/7EXtofosBQUv/g56Cc0YfvylPjPto2RHJXmYyFShdxAINhjFB0jd
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1785756526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZngv2L2Fc2L3owDEgg8BPMNoHr5K/SQDxXjEMK/RVg=;
 b=W//NWNNjTg7i7KTX3rts9X4P0vjzQ908fUjDhq06JP3eSIpAnR2bkWwqe+KtY79I//lMhv
 Ey3hLlwfvGUkY1YNxK8/VOfgp3WG+6fIt0zE0bWCA7ut6eUNWECVyo8fvIvKJAiZCzINoJ
 jkEVQHi4hdNBtkFIox+mg1cUsxPfSqzIy+t/RjszHOyaWATypktJ2KGpNVZ+pZUt6E3shK
 EEY93DRa8FJHBnKWXNLXaqPFsUx0m5679sI1KWsIjCOiHaiKbElKdwC4wCyYawP97p48g/
 xA8pa+jzltP7bwuKZp2DFJaQeURyaGSWdijyCxAgkYEc3KZxFOVkw9Y2uigeXg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1785756526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NZngv2L2Fc2L3owDEgg8BPMNoHr5K/SQDxXjEMK/RVg=;
 b=OlyXxfe/sd7i1fy1YDMP/EwDkNbxP2W+FWYab8A9O1lRxMTwyz4COtsUPefkCscdaZ2vt9
 rR4QpXtSF5TxvnBQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=linutronix.de
 header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=W//NWNNj; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=OlyXxfe/
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Raspberry Pi has the "tryboot" feature where it can boot from a
different partition enabling failsafe A/B updates. After boot the
firmware sets 'partition' property in /chosen/bootloader. Copy this
property to the device tree and set the env variable boot_partition.
This allows boards to create a bootcmd based on the boot partition.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
Changes in v2:
- update Reviewed-by tag
---
 board/raspberrypi/rpi/rpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1da5df92351c..7a2ff646ac8c 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -480,6 +480,20 @@ static void set_serial_number(void)
 	env_set("serial#", serial_string);
 }
 
+static void set_boot_partition_fdt(void)
+{
+	void *fdtp = (void *)gd->fdt_blob;
+	u32 partition;
+
+	partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
+	if (!partition) {
+		printf("Failed to the get partition property.\n");
+		return;
+	}
+
+	env_set_ulong("boot_partition", partition);
+}
+
 int misc_init_r(void)
 {
 	set_fdt_addr();
@@ -489,6 +503,7 @@ int misc_init_r(void)
 	set_board_info();
 #endif
 	set_serial_number();
+	set_boot_partition_fdt();
 
 	return 0;
 }
@@ -641,6 +656,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
 
 	/* copy uart clk as provided by the firmware */
 	copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
+
+	/* Copy the boot partition */
+	copy_property(fdt, fw_fdt, "/chosen/bootloader", "partition");
 }
 
 int ft_board_setup(void *blob, struct bd_info *bd)

---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260803-tryboot2-8c5221376e5a

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

