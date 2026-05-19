Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A8CCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F071584908;
	Wed, 20 May 2026 01:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nfBG+/Rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF668491C; Wed, 20 May 2026 01:33:07 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD127848F3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dea20cf21aso4150514a34.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233583; x=1779838383; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=858a9Bd/k3Q0531JG7BffvuFQi/L6Uh7Hn/ebXuUUpk=;
 b=nfBG+/RrK1EmHvfZJuub0hXmd6f/MWruQMqlMbY+7TkFbZ1dntJaWvCPS9Uo8TDZHs
 61TCeO6b+v1lmlbNJ28FpdA4p7cW80GcXXc9L8PEzJBRij8Mv10MLlGCOQ9/6HfzeSzx
 Dl6wOQT47omg4LLxeVPUo9Hl4Fk+3y+4R1l9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233583; x=1779838383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=858a9Bd/k3Q0531JG7BffvuFQi/L6Uh7Hn/ebXuUUpk=;
 b=EFrUFSJcANP3qxjpEpc8xnDjtFSeehqz968+scfFzF8lX5KSPYZHNB5hd2WEhKE8t6
 DURAFmK8psgH73oc86mFrAVl8ZMFsqpM4/P6zwpGuZgOcQV5lUs9ctPvQquf7ve50ciu
 OvKOz++1hPbUZz7e7XwiDNA+8JOKvEg+ZJZ2RamHK24ReW8beSTxP2z2VF/d4Bkilnrb
 CsMofWuLaZvo59+xS+POeD414faRVc3QcSB1G5KbrZDhLAe8l4IAFtlvlYD1NdNuwTwn
 7P2q5Lsb/togK8K6LvZrQFQ1moEtZzLPWRPlyT8QuTsERtzULvZUq252/PmF6GHIbwgZ
 ANpg==
X-Gm-Message-State: AOJu0YxEJXTD2oe+iYjv9XUW+MqI3RCcGC8B7EpBetmchXuq8GfTR8ZR
 dqBVtgSL1hBwomTM9FAwHQim/GfG2snWhFtx3L/4BlduJlPEREsxB0kZocZDWWe9oHOYTGJRRYR
 qmnJ1EG7D
X-Gm-Gg: Acq92OH1K9jToTrsRbZBfU4s4EyGsothagdMolJkJ1loMEXLQsJcYJNLLWJqwoFRxTy
 5CUxQIBflMYq5PMEz68xBjEFQJLaCvUFbRnFx5kPSbuL6XdzprGS3ewLjubFmwiGE926HcA1SbB
 V/D+jW1rZMS3IgsJjabLes9XkzF90V7caHfCGAocHclOClj4na9rrMFBhgekgncqEoOF5yNHy1Z
 RHLtZR8b7jtvQStIDTFL01ufF8lvwAjjeCTy5/7l5jbLUV+8AMfVPveoFsWi1bdR1yDvD/Ci3Z9
 pdqZUNoDwJbXVg/ZPUycq4Z2379p01/EwnPwet+9ESIo3If/lLuWNxvZdvJKTK/0gx39TL+CdMG
 xIuX8LwW799ubQZsH737HBNqK8T9QNbqLX1OjiuAYd/1dljHHUGVt1NvjciI2xRh0wSp3zWSFWm
 RQtoQmE29ao2tnuCqOKi4LCU/h97pq
X-Received: by 2002:a05:6820:80c1:b0:696:1450:ff24 with SMTP id
 006d021491bc7-69c9437c54dmr13340008eaf.36.1779233582840; 
 Tue, 19 May 2026 16:33:02 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:33:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 14/17] lib: getopt: Merge the optional and
 required-argument branches
Date: Tue, 19 May 2026 17:31:40 -0600
Message-ID: <20260519233207.2765755-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

Both branches start with the same 'argument in same argv[] element'
test and the same advance-to-next-element bookkeeping; only the
behaviour when the argument is missing differs. Fold them into one
sequence and decide between ':' (required) and gs->arg=NULL
(optional) at the single missing-argument point.

The four cases of the original optional-argument block (in-element
arg, last-element-no-arg, next-element-arg, next-element-dash) all
collapse onto the same code path used by the required-argument
branch, with the curoptp[2] check determining only the error vs
optional-absent outcome.

Saves about 80 bytes on sandbox, similar on arm64. No functional
change; the lib_test_getopt unit tests still pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/getopt.c | 49 ++++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/lib/getopt.c b/lib/getopt.c
index 5e907477e57..b3ad6968f8d 100644
--- a/lib/getopt.c
+++ b/lib/getopt.c
@@ -97,46 +97,19 @@ int getopt(struct getopt_state *gs, const char *optstring)
 		return '?';
 	}
 
-	if (*(curoptp + 1) != ':') {
+	if (curoptp[1] != ':') {
 		/* option with no argument. Just return it */
 		gs->arg = NULL;
 		gs->arg_index++;
 		return curopt;
 	}
 
-	if (curoptp[2] == ':') {
-		/* optional argument */
-		if (argv[gs->index][gs->arg_index + 1]) {
-			/* optional argument with directly following arg */
-			gs->arg = argv[gs->index++] + gs->arg_index + 1;
-			gs->arg_index = 1;
-			return curopt;
-		}
-		if (gs->index + gs->nonopts + 1 == argc) {
-			/* We are at the last argv[] element */
-			gs->arg = NULL;
-			gs->index++;
-			return curopt;
-		}
-		if (*argv[gs->index + 1] != '-') {
-			/*
-			 * optional argument with arg in next argv[] element
-			 */
-			gs->index++;
-			gs->arg = argv[gs->index++];
-			gs->arg_index = 1;
-			return curopt;
-		}
-
-		/* no optional argument found */
-		gs->arg = NULL;
-		gs->arg_index = 1;
-		gs->index++;
-		return curopt;
-	}
-
+	/*
+	 * Option takes an argument. The argument may be in the same argv[]
+	 * element (``-fXXX``) or in the next one (``-f XXX``); a ``::`` in
+	 * optstring marks the argument optional.
+	 */
 	if (argv[gs->index][gs->arg_index + 1]) {
-		/* required argument with directly following arg */
 		gs->arg = argv[gs->index++] + gs->arg_index + 1;
 		gs->arg_index = 1;
 		return curopt;
@@ -146,8 +119,14 @@ int getopt(struct getopt_state *gs, const char *optstring)
 	gs->arg_index = 1;
 
 	if (gs->index + gs->nonopts >= argc || argv[gs->index][0] == '-') {
-		gs->opt = curopt;
-		return ':';
+		if (curoptp[2] != ':') {
+			/* required argument is missing */
+			gs->opt = curopt;
+			return ':';
+		}
+		/* optional argument absent */
+		gs->arg = NULL;
+		return curopt;
 	}
 
 	gs->arg = argv[gs->index++];
-- 
2.43.0

