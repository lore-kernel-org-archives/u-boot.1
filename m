Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB5AE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 024058021A;
	Fri, 20 Dec 2024 05:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IEf0wqNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E9B80379; Fri, 20 Dec 2024 05:01:54 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEEC98021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-844d67eb693so116591239f.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667309; x=1735272109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jUraezLlM5xOjrxnyE84hRnkTBS8FO8EfYz5CPtMvUY=;
 b=IEf0wqNtO9GKtX8b+W0oolYKi8+2Jx+03AfxOHYwz5KviV2NTkng5NhIvRHDiebz17
 1MrcuC5m3o8YVz0q25FHBfN1RA/L0C7CKouozY0rDk8/GfqVl1YNXvN843t33d+rFWXO
 5lh7UJjwjt5rrRpZzbd3hW3lybHclFlihbIcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667309; x=1735272109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUraezLlM5xOjrxnyE84hRnkTBS8FO8EfYz5CPtMvUY=;
 b=if99hcsfZToiIF+UCsAGmaDQSZnPj5Utr+wWMdYN06nXqHtBQQ2lGgFP8hrMmzTx4V
 xIBz4eGXaJpf5TDoUJCyBFmL1gRJXTowkAWxWLCbmrKn2cTmLPNT9dHCSWIWG+zyZeN1
 o8tn9q+NBlDhAd+NI1yjT+Kwe0xLDJRD8NbxEEw5ooFhOTU8JzLwKLwFJj7lA2+s7nWi
 AFxIBPWFzdrbdwOX1RsMqNzr7Qmdlqrk5OfpXMirSS+VaPLOixJ8sRAptggBbWGtpgAR
 aiIfGnHllh0c3Dr1g2gQY4x5yytDd4dVD1j7xxwhu/yJHZinAGDmKHhTSF6ixgbN7bcs
 3bsw==
X-Gm-Message-State: AOJu0YweupCeIjRxD7nez71jQa4CwzuuucbVwL5X/Y6s4qedKmEBXgjb
 vgfuOTaSz69KX7uRhg2i9s0OeMjEXNkCEi/7wX7UPO5oNYq8HlH5Fhwewa010t+hIESqGk10N1c
 =
X-Gm-Gg: ASbGncv6BMhr91HUz6HFEMpoUed25OcmyYbhLojbTAh9orFGqAa/FSQfZAaFzPifEQ9
 T95h3QCjdJb5moGgBA17uG5R9Jspn12H5AMpM2a5K+CaQuw8b5Awvc6jnelnyv/nkhT7gltws4+
 WCTmMslSg9nX5TtoMhemH0ooeiczR3BrC9rd2CUvvTW9XsAR0sLffw/mrQbMsiH5g7MM2uiPOPj
 s47fFlyJhHyFoSNkISfdi2pHS9y86QWQBD9ZAwJ7wv/L6zUma3e9EWtNc/haPEhNUR/S9TGuY1A
 jlY5tW11DaRiSUA18A==
X-Google-Smtp-Source: AGHT+IEneYlfwBxwZ8w7QxclSkpO3D3j3nJIal2v2lij4e488hdOU4GusHLzF7exdhdxdOHsZuB2YA==
X-Received: by 2002:a05:6602:2c8e:b0:841:8d66:8aea with SMTP id
 ca18e2360f4ac-8499e4a7804mr130234839f.2.1734667308926; 
 Thu, 19 Dec 2024 20:01:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c22213asm594723173.155.2024.12.19.20.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:01:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] pxe_utils: Support the SAY command
Date: Thu, 19 Dec 2024 21:01:20 -0700
Message-Id: <20241220040120.3245610-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220040120.3245610-1-sjg@chromium.org>
References: <20241220040120.3245610-1-sjg@chromium.org>
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

This shows a message for the user. Implement it to keep the user
informed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c         | 13 +++++++++++++
 test/boot/bootflow.c     |  1 +
 test/py/tests/test_ut.py |  1 +
 3 files changed, 15 insertions(+)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 5d52a5965d6..5a8fbbe57ad 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -890,6 +890,7 @@ enum token_type {
 	T_BACKGROUND,
 	T_KASLRSEED,
 	T_FALLBACK,
+	T_SAY,
 	T_INVALID
 };
 
@@ -924,6 +925,7 @@ static const struct token keywords[] = {
 	{"background", T_BACKGROUND,},
 	{"kaslrseed", T_KASLRSEED,},
 	{"fallback", T_FALLBACK,},
+	{"say", T_SAY,},
 	{NULL, T_INVALID}
 };
 
@@ -1388,6 +1390,17 @@ static int parse_label(char **c, struct pxe_menu *cfg)
 		case T_EOL:
 			break;
 
+		case T_SAY: {
+			char *p = strchr(s, '\n');
+
+			if (p) {
+				printf("%.*s\n", (int)(p - *c) - 1, *c + 1);
+
+				*c = p;
+			}
+			break;
+		}
+
 		default:
 			/*
 			 * put the token back! we don't want it - it's the end
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index db1af0e5729..7675d632884 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1536,6 +1536,7 @@ static int bootflow_extlinux_localboot(struct unit_test_state *uts)
 
 	/* read all the images, but don't actually boot */
 	ut_assertok(bootflow_read_all(bflow));
+	ut_assert_nextline("Doing local boot...");
 	ut_assert_nextline("1:\tlocal");
 	ut_assert_nextline("missing environment variable: localcmd");
 	ut_assert_nextline("Retrieving file: /vmlinuz");
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index b6b4717c834..89c765c0e6e 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -584,6 +584,7 @@ def setup_localboot_image(cons):
     script = '''DEFAULT local
 
 LABEL local
+  SAY Doing local boot...
   LOCALBOOT 0
 '''
     vmlinux = 'vmlinuz'
-- 
2.34.1

