Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B49606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y4K6Q1mF;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZRXW3XcB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A103810E0;
	Tue, 20 Oct 2026 13:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2fPQrWGLdvl; Tue, 20 Oct 2026 13:21:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4EB2810F0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792502496;
	b=QakTrRdUcFf4DX6ZOXgFhvCa3esIKv4pHA70lDMPJy2eYaSb8Zi2T/M5Z1kYIJyjQcuO
	 gwTpuvkCNTWau/i2TYW75bcPun9MDyHXS8AvKDY0w+hgjYUiMSY9vE3cf6eyOKy3WBsW2
	 ZKyIFE4H5SecwXsrHoHYnyIvZB2cyR6HXCt3xQ1/balnuGFVyLwtyVG/VOiLnuwlC5vXZ
	 /evGTRROq/V4BFp+USm00+Ua4RzTZrZK2cNGpwpDB0JDRmMZTpL4CHb7bv1oVPvXNbZVo
	 hUQ2weiVztgfBQCMYlcdFOq8q/9AYBxRGPOxl6+rVi6UcKPwJu8qiL66Gqf2i/5ztxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792502496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Virus-Scanned:X-Virus-Status:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GY4da0zRePqyOUdW/L3SBOszv0lme23nz+2d6QXQ8zo=;
	b=Opp8vM0mtIqBOpaAvsnoYJT1JF2/Sumo11V45iWY85rkMyd7GoX9kzY0rqSjeDi7dSSL
	 ePPatFIVTeOmDyX4BGEprFUBt+if/GS03XtWoD3Bs5N9qWeF2PaeIF1YQvXt9fXcWxmk2
	 HfKj6BycB0Xonfq1LGobQMD7gvexfZRXsYiTUJH74h3Z0LUKDlBzNHgYEzptsssisI5sq
	 OeP7edXQpigKZOVFbBITQqEaivR97rvuhbOhwoqev+dU+qMBAwv3VjQAL0KDex1MHvqw6
	 I9KmtaJeaTJMJciIOHe/yD855P+j9CB2RDoTGcl33itoMum09HVlPxYq5ocM7t9JEPw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792502496;
	bh=GY4da0zRePqyOUdW/L3SBOszv0lme23nz+2d6QXQ8zo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y4K6Q1mFhubHzVAY5zuQmgoCpgWynHL3Xupp5tMpQt7Q5BTcbfXELprWoIj9kDlFh
	 YCXFgSBp+eibHfLZsFRUX10PVDTEylzb2eg0d6uytGWzzlaIEGc9IrwEot4kUkRw9t
	 YU1eSYhFitvLrHF/Nn5k2WcX97yj70+E8wVZosaIAtEdAkwvOQUcw3lZ6hCSSDV8Ym
	 +ce0WDcraKIE63qqL35DVfcI/mn2MbbKwaUmvrAJXSP+iqktBXb2fH916E7fJ2V4Zb
	 b49T4Sk/2+HMrRnx0Q8ij2/mQvelhwi1RmsWIq4153rclVlWGu5pFi83/pw7klktZI
	 D2g341Z/CF/bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A4EB2810F0;
	Tue, 20 Oct 2026 13:21:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F1E83A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6467D40776
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KcUGiL1rmqsQ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6C63840770
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792487636;
 b=paFWIjzlRkTWlGW+oCPU3yh8vAZWct1yB0icMBKcegpuaLh0zFYsqdNuzoN/iCcqLzZU
 ITCm0ikjczOsySirtVkW2+GFYu5xRef5sOeu/UML9gdaUxLva4awn3UFPUGUoXV2s7zeI
 Tnjrsr2vcmxDAkXwaWon3TXiMHXDvYg9opvXlcXOtLGHOwpYZG9w2ro3YGg8kzmlG+m0f
 RgcL6rQ1YFPt8fTeKLs9LuU2llgmKgIUcxiLd9fUiBKUlB3BNm4pbGx7pwG6K+nkE2SE8
 0PYrPUOVSKjU3uEEa2CSPFmmeFCIjeaVq+ukfRXccikfWbe6weKVA0O4u6fdUqRM8Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792487636;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Virus-Scanned:X-Virus-Status;
 bh=GY4da0zRePqyOUdW/L3SBOszv0lme23nz+2d6QXQ8zo=;
 b=qNNPvvf45SDEphn3DE4bsuPROxY33JHn1xasKksioptbO73c0qyqyVZQK4E/cTkPiOzs
 P4gN+G/KEPOm2gmDo74I/5i+SGKXNk70HtbfvDy/aDNxHcyMZYalVwJ5WufFD9q3byTJ1
 6+NzslEcH6BdhWHkPcFRd9IEB7lx52qmb9YllT0i5RB42tVaTURO7uGBGwt3jWthKrzOF
 l4VP9Pyy86xVIIY2JKaQySLWoN2xewtZXhEpoMegP+s1Vp4TTHmWz6KR3PCeFix/zpQ4U
 4YmjS2rJ7jvoWAJSXYXr842yroSyVLOhd3nwReZAGCSW3LZkZ/xhsiKxB+qEk8y+aKw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 spf=fail smtp.mailfrom=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ZRXW3XcB; 
 arc=none smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=nimeshacharya197@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=ZRXW3XcB
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C63840770
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:13:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED758432A; Tue, 20 Oct 2026 11:13:52 +0200 (CEST)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607F4801E5
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 11:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nimeshacharya197@gmail.com
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3514b90bb89so7967237eec.1
 for <u-boot@lists.denx.de>; Tue, 20 Oct 2026 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792487623; x=1793092423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GY4da0zRePqyOUdW/L3SBOszv0lme23nz+2d6QXQ8zo=;
 b=ZRXW3XcBTatMgT5A5e539SfnQiGUFP+QPnOv5ky5V7Gzw7reKsGxmMea47jJLikf7I
 85yk7PJ5ySw26RjWuk0Zlq+jKLEQLpPa9Z6t9PmXgtMUdzTDMdh50ZC0vGXJKHw+4v5K
 BeJnAamGt1IreYkfKKOHIYeYwBf6QI38EWyz4QPXhgzE31en7uDjjgkA9uW6e6oCTbRI
 6FoBx01ESq2Dj2/tldhrhfY3Au2wd2g0AKy/Daf4R9n/tt/AINY5JcQyErd7imm1KowQ
 yMab+pctCVuSiUexLj55wr9AWsfZXxEm42uOM1BpMaNErvqQhRmTk+SL3iQFP0Hs0eU+
 6Heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792487623; x=1793092423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GY4da0zRePqyOUdW/L3SBOszv0lme23nz+2d6QXQ8zo=;
 b=hogJn6bLjzuErqfHOez0Vl0G/gMWrhFY0a/fWsUwyahjY80pQg/vF20fGpQPfFbj9t
 nsv69VAqD8MmskDr5TitAhsLBJbmOpUOOqV8fGxgfeOKy31VhdnR0+73dDKkZgwgFdLX
 fhMfMiV7mt5KuIoFambkZjciqT97GybvHAGhW5zzD3+AlgAEHmQrDsRr5UQQkyN6B3pC
 quOWezJe0mWmrR9lV3ww7sKkgjRTgdzQf0NU4iCcuRIxfTQzE/WiBOIlNZBRlM2ldBPh
 SVM2vvhzOkJXJU8S8MH8PzZw7VVldKi3Ut4xtqnEeu/VDwaJmVQ/kMo7TCuS2PEvkbTj
 iS0g==
X-Gm-Message-State: AFq9FYIklzrYdx17GwG/nPWWEl9xVHyEbQNHllSM3tXjr8ISaaiIzwFy
 tdxyI6BgPBK4zTt7caBr+lL8TPgx9JVlBqGcDAUmRp79T7VkR6w+LpugPb4JJD9/k7Q=
X-Gm-Gg: AYBFou0uVgLfOjEDCb0b0EEhNClEyq1FjfjFQCbFz2aMPB42FQWQrM4KXUHsniNXIKT
 zEy85ZJISX4N5jI5LoBOBwXFLOGWNV3NnJRYXpMh+Rnv7C6ExNehXhCm7NIV9i/nMOe7YFk0fAM
 HI3OqNFx+tpERu5t/F3Ln4G2CJXQ0Tmftw6U943kTQTK/2l+tCsBfoXm4417dyjlqTHRCCe+PjY
 rKyXujJNjaqZ3UhKQdI9HB6vA07vYM7srfrhY2TU0BKt8CYDNj9V0V5ikTwwPu5wvBwJqNEbBTX
 Dee0M7qx5MzuACbT/yMJAIWCxzQ29YNf8+llu6GbcfPNZUgYuenhCRgXVPk26eHIj3AzCWG+LdA
 qrCX4Rw7CAmprcy14OnXbsdjjXsYVI+kDlwKSmRM4cMmi3FcWwDZybM5NH4p5AXLHewten8IoYD
 y9TioNCLmtk8vBvPd7RHN/c6eVgyezgTTsFzDRY/h+s65uk+RYqXU0uzPZNNtT3dLrUSilzoI16
 4P6ZbgQaUeWU4WQa2BqkBq+Ce3IKM8y0xwfTJLHgogxcW0YjIWHs7nqir/PM/xo3QaENqw=
X-Received: by 2002:a05:7022:438d:b0:185:869a:8c64 with SMTP id
 a92af1059eb24-185869a8c8emr20612190c88.1.1792487623078; 
 Tue, 20 Oct 2026 02:13:43 -0700 (PDT)
Received: from arctic.nitk.ac.in ([2400:4f20:11:a00:c772:7333:c781:5856])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-183190aa411sm39196783c88.4.2026.10.20.02.13.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 02:13:42 -0700 (PDT)
From: Nimesh Acharya <nimeshacharya197@gmail.com>
To: u-boot@lists.denx.de
Cc: hsnaves@gmail.com, marek.vasut+socfpga@mailbox.org,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@altera.com,
 trini@konsulko.com, Nimesh Acharya <nimeshacharya197@gmail.com>
Subject: [PATCH v2] configs: socfpga_de10_standard: Fix raw partition booting
 from SDMMC
Date: Tue, 20 Oct 2026 14:41:25 +0530
Message-ID: <20261020091125.4015-1-nimeshacharya197@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 20 Oct 2026 13:21:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When using the default meta-intel-fpga configuration in Yocto
6.0 (Wrynose) for the Terasic DE10-Standard, SPL fails to load
U-Boot from the raw a2 partition on the SDMMC device.

This change configures SPL to locate the raw U-Boot image using the
partition type and data offset, rather than relying on the
default offset relative to the beginning of the SD card.

Signed-off-by: Nimesh Acharya <nimeshacharya197@gmail.com>
---
Changes in v2:
 - Remove CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION_TYPE=0xa2 since its already the default.

 configs/socfpga_de10_standard_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
index 04f9d6c8494..f01667420a0 100644
--- a/configs/socfpga_de10_standard_defconfig
+++ b/configs/socfpga_de10_standard_defconfig
@@ -70,3 +70,7 @@ CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 # CONFIG_SPL_WDT is not set
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+
+# SPL Fails to load UBOOT without these!
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET=0x200
-- 
2.56.0

