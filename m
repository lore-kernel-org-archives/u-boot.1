Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E85C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25A6F87C69;
	Sat, 16 Dec 2023 04:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B7CpfZi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352B787B5B; Sat, 16 Dec 2023 04:15:19 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF5687B59
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7b701b75f36so57775339f.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696515; x=1703301315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVa4GGEzLXHzIlMJjYWf4Pv6ZLXSe9ySVZ+m3wV8MfI=;
 b=B7CpfZi7vzmG1D1OcL1Bm3JWRpsddXK6pyVtjQMBqhEloN9qSkicrXnJh2FMESEXJl
 OUoD1u/bZC0o0K4dKq8aJKEzW76Z2h2tsGza1TAxPplJ4XPnI3VsM9Yunget0yv5k/VF
 d4CjDpYXbpfYEnHB+Zdy4xFT8Bdn/bKHQre40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696515; x=1703301315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVa4GGEzLXHzIlMJjYWf4Pv6ZLXSe9ySVZ+m3wV8MfI=;
 b=FJyZL6SHQ2qCkY0BZifPRbndZrr+6TLCw6Ig+tSDlKleJfD/2rZd8fUISmTy5tGmMi
 7DJj6/Ay+v9hkGtmjQ50RnJJvfb0RNMi/HqduM/QBeDfcG1kdchHsBSCYfDjMZ1T/AAO
 iyAR02bRNMMHHz4Uy9/qlMEmQXIGFalqWohEA2GDVFMZM36y4579yTapYykbeJtQXw9s
 XvfeFTeSgy/xcr6O0fj0MBXUTf1pjGh+P9WO3aGEeM+gI19WGY5RBeQZKtcNRTZxb72v
 NvcGBz48ni6WWrGLtJnrYFGIvT3rZnEvkHQ0jP19iPOC6mG44F/EfJ+Hc/SqI9XkPe99
 mekg==
X-Gm-Message-State: AOJu0Yx8VV+BEFE5IuiqbIQlehkQ0t9fTtbz5T1658CaEyA7jhIO/S2P
 0q9jaI1OU04QW8MUsOB0haH7BxWJiqMmp3uBI1uWSQ==
X-Google-Smtp-Source: AGHT+IEonNA/ZTuzSBc/HZoHbOSWKIpGJiVD+nphJi28udT9hfw1VKbDaXt37zOSnWepd8iJyHhRjA==
X-Received: by 2002:a05:6e02:320f:b0:35f:847c:1e5b with SMTP id
 cd15-20020a056e02320f00b0035f847c1e5bmr4607527ilb.53.1702696514832; 
 Fri, 15 Dec 2023 19:15:14 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 08/22] bootm: Create a struct for argument information
Date: Fri, 15 Dec 2023 20:14:12 -0700
Message-ID: <20231216031446.2222362-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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

Some OS functions require the arguments to the 'bootm' command. This is
inconvenient for two reasons.

Firstly, there may not be any actual command, if CMDLINE is not enabled
and programmatic boot is being used.

Secondly, most functions don't require the arguments, so it is
inefficient to pass them when not needed. For example it increases code
size.

Create a new struct which holds the arguments, which can be used if
needed.

Add the images pointer as well, since this is commonly needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Split addition of struct bootm_info to its own patch

 include/bootm.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/bootm.h b/include/bootm.h
index f5229ea90b33..a6d5d5ceee8f 100644
--- a/include/bootm.h
+++ b/include/bootm.h
@@ -16,6 +16,20 @@ struct cmd_tbl;
 #define BOOTM_ERR_OVERLAP		(-2)
 #define BOOTM_ERR_UNIMPLEMENTED	(-3)
 
+/**
+ * struct bootm_info() - information used when processing images to boot
+ *
+ * @images: images information
+ * @argc: Number of arguments to the command (excluding the actual command).
+ *	This is 0 if there are no arguments
+ * @argv: NULL-terminated list of arguments, or NULL if there are no arguments
+ */
+struct bootm_info {
+	struct bootm_headers *images;
+	int argc;
+	char *const *argv;
+};
+
 /*
  *  Continue booting an OS image; caller already has:
  *  - copied image header to global variable `header'
@@ -39,7 +53,7 @@ typedef int boot_os_fn(int flag, int argc, char *const argv[],
 extern boot_os_fn do_bootm_linux;
 extern boot_os_fn do_bootm_vxworks;
 
-int do_bootelf(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_bootelf(struct cmd_tbl *cmdtp, int fglag, int argc, char *const argv[]);
 
 boot_os_fn *bootm_os_get_boot_func(int os);
 
-- 
2.43.0.472.g3155946c3a-goog

