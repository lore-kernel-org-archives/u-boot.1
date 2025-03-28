Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA25FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21964826F3;
	Fri, 28 Mar 2025 14:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHiu2Bzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB9D082845; Fri, 28 Mar 2025 14:08:56 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B4BF82824
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so160146739f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167332; x=1743772132; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dnP8/u/vaNlvPmDmEN2VVLbi5JujBJyqjEdwraHw98=;
 b=EHiu2BzuMuzsuv6kBdrMtm0nLrd1hjBMA7ziSWJ3StFFrnnTbFR4Ur9PI864Zqkxxv
 UOabyaa0jWOORizsbFUtV519ygl44d0bc3WNkO0Szx/7lYivCl8Jzu4rvNOTjQOOFBvI
 iFJ8BXHKQgVOh8x07+aFjSBp4ckGMylUSaWS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167332; x=1743772132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6dnP8/u/vaNlvPmDmEN2VVLbi5JujBJyqjEdwraHw98=;
 b=kaplMWLpC18fdQwCQCl177gzKA5Llk1ZZXsnnmOMaeP8R3vOnJkYjbFO5wQM0AO0Hl
 3Vg1owhmjRgjc3aJFfvtIBoztjx/S+f58F0/GFa+Bu8jCsG/reuoAB4NyH9yPZxFK9SY
 uyIY6UbZffn/bebqVg2kc9rIPQasW/2YSz99cfXVh+P9tChrpvYnrzdrrOUmRINXSiGC
 4S7OaMOidRnDLBqZWaDSd0UQa9nOrB0zcsHrT1rWlF/ctngdaOX+hIUiZjpylmm3ya30
 AHxYdgZP8XyJZBd1K5H2CKWCpU33bnsPlK4S3Gy7IBNgFbVnzVO/lKhf//bZ0xsHE9Ks
 mH4g==
X-Gm-Message-State: AOJu0YxnTvh5AguSKZ5uDX8afkVBkB/FjDJAOHPadX+YAmRW14uyRXiL
 9uN9V3q+j5stMaLSfVj/Oy70XZ4mLpkDa1mZ/kUkzL07opmzpd/gvd/+zu6KpfScS87k1ufJkOw
 =
X-Gm-Gg: ASbGncv3Lg/FgbsYs4wPIwFjcsBTslN9uS4ByaQYB+O2JWCTyRubt0v2dPcIynJCaf+
 MjRl48lEAsTrsZi4JVKM99Bnx8IY2R/pFk4uvtZDiSToXuhJhEujSokSBTNA+nK/qcOHrO3WRAl
 Tvzio4kikgteCiPgTIpYb8/rcWYMNGtMR23/QrcIohjA9NvathoI3M4ad+bwvzdHBGI4b86vZtn
 zcZB9+aFsLCm18lelsJYStAIRTlGKm0Mz9kns0OgYJRfEcRsUQkjdf/681snWmcBwYwXBG82qJo
 zE6ckpR1LQ+dWFo5kujEwdl+HYKbpvLQn446dPghOdGVRwqxeJ1VCYc4OHBTZ4jZbPuiEVsstfE
 ajxWxRg==
X-Google-Smtp-Source: AGHT+IHGDoKj44ywvEDD4/oqbo1O7nC49qC4DF+cQ8F0L8d4bFdUaGTlNDkBWig6OeNqn7Kl8ICGyA==
X-Received: by 2002:a05:6602:398c:b0:85b:43a3:66b2 with SMTP id
 ca18e2360f4ac-85e820ba808mr899716939f.7.1743167332343; 
 Fri, 28 Mar 2025 06:08:52 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 50/56] expo: Drop the render from expo_poll()
Date: Fri, 28 Mar 2025 07:06:37 -0600
Message-ID: <20250328130713.2612648-51-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

Within tests it is useful to be able to control rendering of the expo.
Drop the automatic call to expo_render() within expo_poll() and adjust
its callers to handle this instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c   | 1 +
 boot/expo.c    | 2 --
 cmd/bootflow.c | 1 +
 include/expo.h | 9 ++++++---
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index dbb2750c9f2..63392d97459 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -215,6 +215,7 @@ int cedit_run(struct expo *exp)
 	do {
 		struct expo_action act;
 
+		LOGR("cer", expo_render(exp));
 		ret = expo_poll(exp, &act);
 		if (!ret) {
 			cedit_do_action(exp, scn, vid_priv, &act);
diff --git a/boot/expo.c b/boot/expo.c
index bf2f1dfc68a..4f96b5ee973 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -320,8 +320,6 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 {
 	int ichar, key;
 
-	LOGR("ere", expo_render(exp));
-
 	ichar = cli_ch_process(&exp->cch, 0);
 	if (!ichar) {
 		int i;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 456f51760f1..1ccd473b267 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -114,6 +114,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 	LOGR("bhs", bootflow_menu_start(std, text_mode, &exp));
 
 	do {
+		LOGR("bhr", expo_render(exp));
 		ret = bootflow_menu_poll(exp, &bflow);
 	} while (ret == -EAGAIN);
 
diff --git a/include/expo.h b/include/expo.h
index dfecd6ed239..2addddd5012 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -1006,10 +1006,13 @@ int expo_build(ofnode root, struct expo **expp);
 int cb_expo_build(struct expo **expp);
 
 /**
- * expo_poll() - render an expo and see if the user takes an action
+ * expo_poll() - see if the user takes an action
  *
- * Thsi calls expo_render() and then checks for a keypress. If there is one, it
- * is processed and the resulting action returned, if any
+ * This checks for a keypress. If there is one, it is processed and the
+ * resulting action returned, if any.
+ *
+ * Note that expo_render() should normally be called immediately before this
+ * function so that the user can see the latest state.
  *
  * @exp: Expo to poll
  * @act: Returns action on success
-- 
2.43.0

