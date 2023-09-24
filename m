Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63993CE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79CA486A43;
	Sun, 24 Sep 2023 21:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ESXuNcMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C3186B1D; Sun, 24 Sep 2023 21:26:30 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E838F86A38
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so170416039f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583577; x=1696188377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5Yk4L1KH6RfHc1snqaOqpHJIctWxMdKxur2KvHM/EI=;
 b=ESXuNcMROEtqH/Mpp3gMCcF7RJm8kZxbcLXRxWIFbcu7sOr0T1+Veq0BSIHIu8mDOw
 CF6hjUxJPXtCCFY/oVnq6GzAAnJOeU8m82RziCfV3kDPwS3GgpD6DN+uZrvXDbMwR5i/
 sYP8kWOYRE6hnluFcKxfUHb3MaMezKrOKZH7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583577; x=1696188377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5Yk4L1KH6RfHc1snqaOqpHJIctWxMdKxur2KvHM/EI=;
 b=o6h6gL3ERPGfKV49/xFkHb2tV3h88BfDSt69lXTAtpX+Wp/cXS/tJL0NVCDkghymKL
 Xg28uWipCUHfUtm4PXrr6c+uTYswTP3oHq7SDVBFUYK3cetLudVAlq4igewLw40vd7ie
 zcMFgWJin47p0PwUnUW+5i2MlJd6Nu3rBQx8tD4FIg7MENVLAZB272iVKYIvg6n148ZU
 fuzF4hWp3/x09/ozUJ2tC+7NoHV35k26AJq0UivPwcfYhnHNf+ZdfP8Gfjx27vJeZ4PA
 Q+lbpJPFO/BVPxKPq3DT+NontTcoX6WWCUeLgLDpMBrBaysqJTWK1E4XYvWocHzM1n2E
 dy8g==
X-Gm-Message-State: AOJu0Yxt+/xJHBwxeQZ+yP5xpR9w7bAAkTAVSAA5410jV04fa0mDUWvV
 H491BKTY3FbDu2KHdpeHUZBBkCAb0ss5k7DVMLg=
X-Google-Smtp-Source: AGHT+IG7uDaOIjpvDUeugNkltWG/joWnZuywEzuVZIe5HIrpj0Uv7FYBL8zuZ1IA5EC7YleJ9fHJEg==
X-Received: by 2002:a5d:9c17:0:b0:79f:9eb4:3ea1 with SMTP id
 23-20020a5d9c17000000b0079f9eb43ea1mr5720962ioe.3.1695583577637; 
 Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 33/38] sandbox: Only read the state if we have a state file
Date: Sun, 24 Sep 2023 13:25:18 -0600
Message-ID: <20230924192536.1812799-34-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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

