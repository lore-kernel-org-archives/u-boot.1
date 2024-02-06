Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DB6C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 22:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C34C87CCD;
	Tue,  6 Feb 2024 23:32:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C3787CD4; Tue,  6 Feb 2024 23:32:13 +0100 (CET)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5904C87CCD
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 23:32:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-51149a45fd0so1019589e87.0
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 14:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258730; x=1707863530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFntEKDzB5kuz3X45i7pZauKhqnIlEs0alL5p3zKAvw=;
 b=aNXRP5d03MlwK9Ej1N7xxFefIbAKNIKSfaxCVGsmTgUfBm5nW4VTqUSBns9wjSEDoW
 +8POn8uoFbeoJV5FRyfLD/YcSS8OHymDi2x4TyI3r6IXihNV7ATHXbAgmF63YmXb6vWJ
 0B4D7L+vwMfKKApQn4bg1zfutbltVaimY/kP00oN8ZI+X+pTOrph3JlFBMWYCEU8Xis4
 OZtcLYwQgfPufIBO9dn3U66cXW1pkYBFzOVTcEuhYgPJWW+0ENIcUOfjIGWsnf1zfPUR
 FFlPptcgvQLWQu83PkHZYSRo6VeoZH6gsso+hoNpnzH1e2yFzO2BB0E5KtzS9r3l8ft2
 4M9A==
X-Gm-Message-State: AOJu0Yxw7Pzpu5R2pgVsIkTB8rSBChdgpedJt/RcQNjqZhxSUb2pwOb2
 CIgh1+tjjHtThK/NqvvVlc9WK+R9yTCxXTmb8B8CD1R+3WdjkOISDCKN74vedeOAvQ==
X-Google-Smtp-Source: AGHT+IENxV28LEF6MXP4gaDO7289h8bO+vn+BvwdOfpxnJLYc9axC1NRoaGs8Aq49+HAR4AR4lS1Mw==
X-Received: by 2002:a19:5f12:0:b0:511:4881:1b78 with SMTP id
 t18-20020a195f12000000b0051148811b78mr2403431lfb.4.1707258730166; 
 Tue, 06 Feb 2024 14:32:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUeDip/Atju+gqVDyHuawdFhlkDXJv3oHWK++Cc2HgOVEo7C838/3zCP3rhAsr8yUMHfMNgLLqj0lUGVbrcqNz3V/Vb0L0QB7gt7VmtKZEHuAyyHhLoXt6VaPo=
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 z4-20020ac24184000000b0050eebe0b7d2sm355084lfh.183.2024.02.06.14.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 14:32:09 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 6/7] cmd: avb: rework do_avb_verify_part
Date: Tue,  6 Feb 2024 23:31:52 +0100
Message-Id: <20240206223153.3060433-7-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
References: <20240206223153.3060433-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Igor Opaniuk <igor.opaniuk@gmail.com>

Use existing str_avb_slot_error() function for obtaining
verification fail reason details.
Take into account device lock state for setting correct
androidboot.verifiedbootstate kernel cmdline parameter.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

 cmd/avb.c | 50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/cmd/avb.c b/cmd/avb.c
index ae0012c0e79..e5fc202121f 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -239,6 +239,7 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 	const char * const requested_partitions[] = {"boot", NULL};
 	AvbSlotVerifyResult slot_result;
 	AvbSlotVerifyData *out_data;
+	enum avb_boot_state boot_state;
 	char *cmdline;
 	char *extra_args;
 	char *slot_suffix = "";
@@ -273,18 +274,23 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 				AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
 				&out_data);
 
-	switch (slot_result) {
-	case AVB_SLOT_VERIFY_RESULT_OK:
-		/* Until we don't have support of changing unlock states, we
-		 * assume that we are by default in locked state.
-		 * So in this case we can boot only when verification is
-		 * successful; we also supply in cmdline GREEN boot state
-		 */
+	/*
+	 * LOCKED devices with custom root of trust setup is not supported (YELLOW)
+	 */
+	if (slot_result == AVB_SLOT_VERIFY_RESULT_OK) {
 		printf("Verification passed successfully\n");
 
-		/* export additional bootargs to AVB_BOOTARGS env var */
+		/*
+		 * ORANGE state indicates that device may be freely modified.
+		 * Device integrity is left to the user to verify out-of-band.
+		 */
+		if (unlocked)
+			boot_state = AVB_ORANGE;
+		else
+			boot_state = AVB_GREEN;
 
-		extra_args = avb_set_state(avb_ops, AVB_GREEN);
+		/* export boot state to AVB_BOOTARGS env var */
+		extra_args = avb_set_state(avb_ops, boot_state);
 		if (extra_args)
 			cmdline = append_cmd_line(out_data->cmdline,
 						  extra_args);
@@ -294,30 +300,8 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 		env_set(AVB_BOOTARGS, cmdline);
 
 		res = CMD_RET_SUCCESS;
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION:
-		printf("Verification failed\n");
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_IO:
-		printf("I/O error occurred during verification\n");
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_OOM:
-		printf("OOM error occurred during verification\n");
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_METADATA:
-		printf("Corrupted dm-verity metadata detected\n");
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_UNSUPPORTED_VERSION:
-		printf("Unsupported version of avbtool was used\n");
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_ROLLBACK_INDEX:
-		printf("Rollback index check failed\n");
-		break;
-	case AVB_SLOT_VERIFY_RESULT_ERROR_PUBLIC_KEY_REJECTED:
-		printf("Public key was rejected\n");
-		break;
-	default:
-		printf("Unknown error occurred\n");
+	} else {
+		printf("Verification failed, reason: %s\n", str_avb_slot_error(slot_result));
 	}
 
 	if (out_data)
-- 
2.34.1

