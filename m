Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033E4C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27A6887873;
	Mon,  4 Dec 2023 01:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HVJEZhYR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EED878E2; Mon,  4 Dec 2023 01:32:55 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE7187873
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b844e3e817so2119348b6e.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649972; x=1702254772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iGFrB5moar0slnYQ9M5GQQHCJgvpc2aRC98Scqwyqw=;
 b=HVJEZhYRyakKNYbX9hnkzMlWlxWzR76oVtnPnPggvDKEXBtJcW81MbGdrUZKywsO94
 +s/PTB7EJ+KO9b8ZoYtP/xJl89SdMrEtJX4gQWiX2GvX1tauBFqUSMeCO6HiL3ncaNdb
 dj0huPUCSs+VVXFdEtZ8HJMpTyy3v1h6AtBJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649972; x=1702254772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9iGFrB5moar0slnYQ9M5GQQHCJgvpc2aRC98Scqwyqw=;
 b=tcjLQKir3wWstQR+iFf93V7cxMQUUD3FLPEOShYYYYrRSBKFnrJj8T490ZMa2T3vQ/
 I3N68ouMIsytcx+ph1fWMJbnVFsmFWD/DSdGxozG3fF5V/TNp6Gsdw0XVf9Dx1PIZ/Iz
 Lw1yAleKYJe00QL7FTua+EV44LclUvrsVwFSJ3IVjCI5NPm0JSAU3nl/JvJuaGae8682
 QyljzIqmURssBAnMaetT9ZldCbL4Mq87Y79Chyiro4MlX+XKuXb0BOrK+LEFEZ2VBn0a
 9UzNX+AbQXHehNS+eJ1vCmsl28eG40kmfm7Fn8rm3C4zkHtow1YckKBQ+RwP+jvtT07G
 nZtQ==
X-Gm-Message-State: AOJu0YzzgNMMOHZvz4ZGJl7D0j5EqnXo9CXOJMay5JzrdAZ8v0wviWxD
 /azMSPy8jFOh3u7F0fKmL5gWINJubYOEOAvTHfU8nA==
X-Google-Smtp-Source: AGHT+IFXyQJx4bpf9VyvSzFquEBggPMTDmnrHHCA6JHk8gQyoX6ZmTjA7iQnQKRdm2MVhPw8G6rQtw==
X-Received: by 2002:a05:6808:1b06:b0:3b8:b063:9b57 with SMTP id
 bx6-20020a0568081b0600b003b8b0639b57mr4773160oib.73.1701649972174; 
 Sun, 03 Dec 2023 16:32:52 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 07/14] bootm: Make cmdline optional with bootm_boot_start()
Date: Sun,  3 Dec 2023 17:31:31 -0700
Message-ID: <20231204003144.899097-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

Allow the default command line to be used when booting the OS. This is
needed by fastboot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 10 ++++++----
 include/bootm.h |  2 +-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f630b8c1a9c3..4a5da2a3bebf 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1187,10 +1187,12 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 
 	snprintf(addr_str, sizeof(addr_str), "%lx", addr);
 
-	ret = env_set("bootargs", cmdline);
-	if (ret) {
-		printf("Failed to set cmdline\n");
-		return ret;
+	if (cmdline) {
+		ret = env_set("bootargs", cmdline);
+		if (ret) {
+			printf("Failed to set cmdline\n");
+			return ret;
+		}
 	}
 	memset(&bmi, '\0', sizeof(bmi));
 	bmi.addr_fit = addr_str;
diff --git a/include/bootm.h b/include/bootm.h
index 1800ca32c264..8b0c907497ae 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -286,7 +286,7 @@ void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
  * bootm_boot_start() - Boot an image at the given address
  *
  * @addr: Image address
- * @cmdline: Command line to set
+ * @cmdline: Command line to set, NULL for default
  */
 int bootm_boot_start(ulong addr, const char *cmdline);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

