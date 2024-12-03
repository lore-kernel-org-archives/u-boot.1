Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620FDE77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:50:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8FB896FA;
	Wed,  4 Dec 2024 00:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EBf53QVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFA62896F5; Wed,  4 Dec 2024 00:47:40 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CEE88F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so198989739f.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269656; x=1733874456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0iBc9rZUrZFtdY+XumUVUYCijopZZSx4HIM2bazzRo=;
 b=EBf53QVNatZyUb3CPO7IE1obhK6+/t792EzKAUBB8HPRBPvMA0sKiY5EHNg6EXGqSy
 9+la579oJZKU6sn5iHqlJctU9zf+8d3CzTs8LqVLFHzgOeiKsLxH35xsLCoTXYB68aD4
 GFItNLqR/VVO4XWqiykQSrPZNJHCq1gifUt8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269656; x=1733874456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0iBc9rZUrZFtdY+XumUVUYCijopZZSx4HIM2bazzRo=;
 b=OMVNg8yZPCd6pgK0lLaBc2GRICUaCNbYeQw/b1FgemrkkEBgT8Mni02DmmHY1v2TsH
 xpByTvnvF+SvmUXOg4+6w5ds+IEciwtTaSLiDjGbJ+ET0hVsfCD/i7ddY7Kzu/3f5E/I
 1X+qIq3zWc+y2F96CyWLP1f/5fs9bwGLHA/Zv7Yl838FeULWccfD1M08GTLpgkNDTCRk
 kyNPl3i5xCeN2m/m1L2IgUeB75ST/6wVFweDtpGhRbxub4YV4J/kzpeTXffv5dCMAymy
 2Q1W9EgysElCSWPtkfhLRgZdaP5lrj4xOQ4yqoPEInQpBsrC8unUJBr2cR09BHO6bc4l
 9UaQ==
X-Gm-Message-State: AOJu0YwzBfiT+/moWNQ69Uy6TOxhh/dAnnxKKkym0YA15BYL+PRvLBjk
 AUnn9R4Vf4ttawOqOvqpUfr1dpvXO6bLD4WO8HcBru/kI/1PYRd/KGVmF6WdzDm9ydSv5FlXOAI
 =
X-Gm-Gg: ASbGncugJ8GNLOYSE1fGOTiv2n9UCm8Qm0C0SqfHCYHrBSGTCqqbh9BsQBz8sVwIKol
 HjLG+n+ox4jDPz/YTcbAPmdbX6NBLxPTf9uvMF2qyMK5x4z72rS9VAe1cHN8I4adc7sbScLZkuA
 NTu+gCHREM2EhtlceBB97TpvX3eREDW4s73iX3brHqDK1UuRZWydwGx9q+CxMf6KGncG94iC3td
 sQ1FMt8Xh9+wqYLGY7Avooyn9vc4SQX7A19PEM3LisASVk7dtvjDRWIBGi8goKXydKDhi+vEsTI
 lkxFf/MwtsE=
X-Google-Smtp-Source: AGHT+IFSq3k9dSKCSrxK2kFFhY/rmKGcGcVGvX+Ll7ApFtRTNkUhp+5jJ9jjwJhZClnRTzL4bEknrw==
X-Received: by 2002:a05:6602:340e:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-8445b5ce126mr570350139f.10.1733269656472; 
 Tue, 03 Dec 2024 15:47:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 30/41] test: Update bootm test to restore silent_console
Date: Tue,  3 Dec 2024 16:45:48 -0700
Message-Id: <20241203234559.2938192-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

Unset this environment variable at the end of bootm_test_silent() et al
to avoid affecting subsequent tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/boot/bootm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index 9455f44884c..0dd8bc2979f 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -122,6 +122,9 @@ static int bootm_test_silent(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_SILENT));
 	ut_asserteq_str("console=ttynull something", buf);
 
+	/* restore settings */
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_silent, 0);
@@ -229,6 +232,8 @@ static int bootm_test_subst_var(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_SILENT));
 	ut_asserteq_str("some${var}thing console=ttynull", env_get("bootargs"));
 
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_var, 0);
@@ -246,6 +251,8 @@ static int bootm_test_subst_both(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_ALL));
 	ut_asserteq_str("some1234567890thing console=ttynull", env_get("bootargs"));
 
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_both, 0);
-- 
2.34.1

