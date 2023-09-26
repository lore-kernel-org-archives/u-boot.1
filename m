Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A6E7E63C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C429186EAD;
	Tue, 26 Sep 2023 16:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fybCmxaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC28186E5A; Tue, 26 Sep 2023 16:16:19 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351CE86E3A
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-79fa2125e19so254243739f.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737759; x=1696342559; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5Yk4L1KH6RfHc1snqaOqpHJIctWxMdKxur2KvHM/EI=;
 b=fybCmxawImvJan9jRy4pqK7DN3kp81t7teFdqYjncCYE3IKqMKtHRiNCrCUh2a++5y
 XFXbrT84hzEpL/r9JW0Ju7po8pYx0ku0DAnxdNRVgecIy4WsXT9hURJgKrXcsRyxX8Lw
 s2SMcCXXqS0Iyhw89ym3dfDwvofLQcFgp3KVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737759; x=1696342559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5Yk4L1KH6RfHc1snqaOqpHJIctWxMdKxur2KvHM/EI=;
 b=hRPEhd2VXjaPh+hGbmRxE4pS/2u8knzsRRx78JpOYo+SaF27zzlN9MLp9Uv3exisk3
 nbcoXWYA5d4SNxwyJRNNgilVGPAenHEAFSC5MyKmcFMx9pq6DykJET/xgk4TRYuBUcey
 tdolUXtySkp1h+Wm2K0Qe74yUCCSVbgLThLfU5WcHMPcw/kksPyU8OgHAcgbhCMR1I3o
 akDEs8anW8/sq/SD5v00WyUqTuUHBt7THV4un84rqrXY7cf/BZa8URGMN6BzbkJZ8gKM
 L7U0bnRt1JamJKAP5/M/aXC7zyxGh7E99T9V8ea/BV3jdxdQOrCWwo3ec3vEq+lD8fI0
 hwXQ==
X-Gm-Message-State: AOJu0YxfHt7vv6F0NMAUKUk58hqEV8sDodSC6DMAkcOMxgFdq/UxZVGA
 2Q+EE46UWKXnBL2fYqw9F+lWATUemkWa8zMleoM=
X-Google-Smtp-Source: AGHT+IFWahb0Fzxhf5oukPB+L+gqzVsitGTJfZ4jxX2IkzOe3jLGW/GA/IvbH9YSVv6w9uTbjy2iLQ==
X-Received: by 2002:a5d:948e:0:b0:795:1bbc:1fca with SMTP id
 v14-20020a5d948e000000b007951bbc1fcamr10027592ioj.7.1695737758819; 
 Tue, 26 Sep 2023 07:15:58 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 35/44] sandbox: Only read the state if we have a state file
Date: Tue, 26 Sep 2023 08:14:49 -0600
Message-ID: <20230926141514.2101787-36-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

We should not read this unless requested. Make it conditional on the
option being provided.

Add some debugging to show the state being written.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/cpu/start.c | 8 +++++---
 arch/sandbox/cpu/state.c | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sandbox/cpu/start.c b/arch/sandbox/cpu/start.c
index 8582f05162fa..2c8a72590b55 100644
--- a/arch/sandbox/cpu/start.c
+++ b/arch/sandbox/cpu/start.c
@@ -522,9 +522,11 @@ int sandbox_main(int argc, char *argv[])
 		state->ram_buf_fname = NULL;
 	}
 
-	ret = sandbox_read_state(state, state->state_fname);
-	if (ret)
-		goto err;
+	if (state->read_state && state->state_fname) {
+		ret = sandbox_read_state(state, state->state_fname);
+		if (ret)
+			goto err;
+	}
 
 	if (state->handle_signals) {
 		ret = os_setup_signal_handlers();
diff --git a/arch/sandbox/cpu/state.c b/arch/sandbox/cpu/state.c
index fcc0028ff4a2..e38bb248b7ff 100644
--- a/arch/sandbox/cpu/state.c
+++ b/arch/sandbox/cpu/state.c
@@ -521,6 +521,7 @@ int state_uninit(void)
 			printf("Failed to write sandbox state\n");
 			return -1;
 		}
+		log_debug("Wrote state to file '%s'\n", state->ram_buf_fname);
 	}
 
 	/* Delete this at the last moment so as not to upset gdb too much */
-- 
2.42.0.515.g380fc7ccd1-goog

