Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BCEC48297
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 19:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E94887E94;
	Fri,  9 Feb 2024 20:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="OU8gHyRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 118E887E93; Fri,  9 Feb 2024 20:21:09 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EBE87E99
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 20:21:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a389ea940f1so144738966b.3
 for <u-boot@lists.denx.de>; Fri, 09 Feb 2024 11:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707506466; x=1708111266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyPsxyfsr+GhFeMqDjDU39/apCmgTnD92IDQZWiCdoc=;
 b=OU8gHyRAckhKuy8TZw4UJKSQKWoGio+1+ZSA2e+lSyACvAxv74JqGfY5RjMXUeZr+X
 4BQoETUuuh1w4viuJUPI1oZP6rMqETypQD16fb0bXCjI/i0EvKMzGVlmJo+mPOI7amlb
 uBNZJ9B5am1rANToSVnxlUkLhu4Vq531OYtveNXOuwi+4i7dx8UuZOFUXPz1cP2VRJSu
 HISggjW/V50ozsFHa2UEhIuRKpOYEK5sIVApqCCqaCjT6OHCRjMTWmtXMqym/l658f3Q
 CY4kW8lIRRnMmPfsbvHR/A3sbPfN9s6yL+PcJtDFty3rwHtADSO/UaGdVyKcjD7cWbPg
 hz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707506466; x=1708111266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyPsxyfsr+GhFeMqDjDU39/apCmgTnD92IDQZWiCdoc=;
 b=Ilaas73agXOaKUPo15sMNSIMU9xG96ewSeiQ+PX2b3USnVrMwYy3UBbZgss05tlhbv
 1oiiAQ3XLekzM2J2CXGTaSnaJMbUZAaoVB8p4gVyK8k+vHenpdnqBqOACDPIM+b5qRyS
 UsZ2K3XamJQkQexO+Gm5KWIf1t0KEJjSvHoip0WSaGNWv0RKv5S4hYNkEK8L7DRrtgXp
 tog5BHXO+RNoZ9LR0YmWuVlVnJK9QKy9qg9d8mOU4x0oyu4Y+HwQ77fvlhYdiHJmTInw
 G9svum6WG6Rkm7BJJLJLgbIf2RD/zDqlJPcHw1dMCPleBxmy2T0Kj4oPZwP8eTa9Yj1d
 p1lw==
X-Gm-Message-State: AOJu0YwpKQKr7keFY/r/kGdfCX24gm8CSuHJ/7cyJfomKJ30WOhleHox
 Pi0tJDFQ/6G/p0/cQq3mPgvrm57AelLxhg1i1RTiBhmWeskgK/EA2Md/vapNP1UGn892obs4jUO
 TMlY=
X-Google-Smtp-Source: AGHT+IH85QBFpm6Y9LvPmwkAHHljNp+FFPw2SpXoHOrKkQjgAhdcnrEAYuVEQopbnAIfEU4Fgzl9PQ==
X-Received: by 2002:a17:906:358f:b0:a38:16f3:f25 with SMTP id
 o15-20020a170906358f00b00a3816f30f25mr58604ejb.14.1707506466212; 
 Fri, 09 Feb 2024 11:21:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Q+qE57JygVPNtRliR0wapWa4XkjmW6hhVF/X8GyTk7CrpubUQHnRwcq4yIgWJCoRLiMl3CGxg/h2oGRMPf2Rp2VDQ7MSe7cD/06nfKyMuGuOrIPY4rSjek8=
Received: from localhost ([185.186.156.113]) by smtp.gmail.com with ESMTPSA id
 y19-20020a17090668d300b00a36ed37683fsm1015579ejr.215.2024.02.09.11.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:21:05 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/7] cmd: avb: rework do_avb_verify_part
Date: Fri,  9 Feb 2024 20:20:44 +0100
Message-Id: <20240209192045.3961832-7-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
References: <20240209192045.3961832-1-igor.opaniuk@foundries.io>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Mattijs Korpershoek R-b tag applied

 cmd/avb.c | 50 +++++++++++++++++---------------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/cmd/avb.c b/cmd/avb.c
index 62a3ee18e7f..8fbd48ee5a2 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -250,6 +250,7 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
 	const char * const requested_partitions[] = {"boot", NULL};
 	AvbSlotVerifyResult slot_result;
 	AvbSlotVerifyData *out_data;
+	enum avb_boot_state boot_state;
 	char *cmdline;
 	char *extra_args;
 	char *slot_suffix = "";
@@ -287,18 +288,23 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
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
@@ -308,30 +314,8 @@ int do_avb_verify_part(struct cmd_tbl *cmdtp, int flag,
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

