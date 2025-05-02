Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E6FC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3F882B41;
	Fri,  2 May 2025 16:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h93o+yRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B3A82C49; Fri,  2 May 2025 16:49:13 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8156E8214F
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-861b1f04b99so85578639f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197350; x=1746802150; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jw/9RgSl1g8Telv371xqAuuCoDEdJDL27o8B+lXStM=;
 b=h93o+yRCCkr4xA6LUMKE57jUcf5cj4VCnnRrv7d2b52lno9m9sEiy9SNnblK5jriOd
 MDeYt+oJjWsNflOv86BmvdXZDxsUU4azAycNgWOvihr9gLFNW4GnHix+r6Y+t3mH0KWz
 ZzlwbOAMt+MzIWh650O6cCB0zOvXIOCy/dKqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197350; x=1746802150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jw/9RgSl1g8Telv371xqAuuCoDEdJDL27o8B+lXStM=;
 b=AZjzsfDnBYJgOH/cIZ/vPtHLvDhYQNYAD1V9GUflX34PIvaT0u7BjthL9YvLnBZphV
 8vY5u1frClnk1qYFJTEIBGEvSHbGpTimuxlQl036YlsprNMyPDQnelpgXl5gsLJwzqgP
 8wTJTyCb5i7L+bkmtRUN7bn8typP4EA/tN0bEdA1lQ9szJaRZmaMcBpqpEgNqLY3qb6l
 nyFSrFcCLdUEoGORbX1TdLNA+hvRdXIGSnv5E0DhdA7DElCvAc8pMqRxd6HZ663HdKVB
 L+gfIG3tF8X7U2n8FbQRknq3tfRbpq46TDSBn+zUlH+8OoJ0m1G78MH+TnjryWUcoklj
 l34A==
X-Gm-Message-State: AOJu0YziD+sYqhN+l14qZWs8+LxlPCQMerHoA8LWaxGkcG7veVmEixNq
 +ml/lDCzDZbN370H2XiZ5qR6SVw8lqCv3Ci4GvUMzLPaoxVmB9Hpiet7kS8Azr4zKIbU0r4IGtI
 =
X-Gm-Gg: ASbGncsZ2NOc4M6L0l02L5zB2kxarMq+OuA6Rq0fYNVU6BJGPSQBvspxJ2gWTleub2h
 wG2H/4ibvpGM2wxN0wJP+EMdVwbxA/cfQbUklNyWdzZRlyk1KLqROTNRu/srr0BRUPesNipQ4aZ
 Eeny51UyRZNispvjyAsHCbkIQo1WTuR5NtORC2YiZJ+eo9K/Jf+pdYUvMmb7TxWux37xF5F6QRr
 T9TV8xOF2piJlao/D3lzlRve9/rc7W6AtvTECTm0ORESxe3CGmgDSqBdAMoYpDoqAp6GZMJywr8
 YkE2B2ZeRHmLZ/LwtuCPfASPMlUNvUqTPljrJjM8SbIGIyTy3BE9MsKjrnyoMoX76LxvUXGhj/U
 OgQ==
X-Google-Smtp-Source: AGHT+IHcWW1gYOYyiq2Av4sHUYweoy6IscNd7HPEvIrQuxjZ4pvGeJqlmVRhfCTvYSUZVGXqxiwjsw==
X-Received: by 2002:a05:6602:4899:b0:864:4a66:f4df with SMTP id
 ca18e2360f4ac-8669f9b5d70mr474928539f.6.1746197349730; 
 Fri, 02 May 2025 07:49:09 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 54/60] expo: Drop the render from expo_poll()
Date: Fri,  2 May 2025 08:46:52 -0600
Message-ID: <20250502144718.313633-55-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

 boot/cedit.c   | 4 ++++
 boot/expo.c    | 4 ----
 cmd/bootflow.c | 3 +++
 include/expo.h | 9 ++++++---
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 8faf230a9e2..56dc7c6af15 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -219,6 +219,10 @@ int cedit_run(struct expo *exp)
 	do {
 		struct expo_action act;
 
+		ret = expo_render(exp);
+		if (ret)
+			return log_msg_ret("cer", ret);
+
 		ret = expo_poll(exp, &act);
 		if (!ret)
 			cedit_do_action(exp, scn, vid_priv, &act);
diff --git a/boot/expo.c b/boot/expo.c
index ee8ffaf8920..94413acd381 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -320,10 +320,6 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 {
 	int ichar, key, ret;
 
-	ret = expo_render(exp);
-	if (ret)
-		return log_msg_ret("ere", ret);
-
 	ichar = cli_ch_process(&exp->cch, 0);
 	if (!ichar) {
 		int i;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 6b43bd50410..dda5742db73 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -116,6 +116,9 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 		return log_msg_ret("bhs", ret);
 
 	do {
+		ret = expo_render(exp);
+		if (ret)
+			return log_msg_ret("bhr", ret);
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

