Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9080C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F98D87B01;
	Thu, 14 Dec 2023 17:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ep7M8B4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E2B87AEF; Thu, 14 Dec 2023 17:51:54 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2887287AC7
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35f49b80192so2133855ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572710; x=1703177510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vfh3HkdL6JmAndTrZv0LtNkX5eUtH1t7ViVVIZAoJng=;
 b=ep7M8B4gn+bBYm0qPzaPw8YQ42XyIWNhDkj4Aur9oJaqiOWpI/EX1ir3l+c3ejFg8J
 t1/5b6+OouNCdDz0J6SHZpNSVaMnR1oeRSyOWEIPGEw0muEP1CULMLHJl/xJnkBVnd96
 LLouubwX49S4b/U6WVppMr8LFiLuM0wo+FDoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572710; x=1703177510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vfh3HkdL6JmAndTrZv0LtNkX5eUtH1t7ViVVIZAoJng=;
 b=eWYUEwNTMam+jFEdyxFoAMrDXGJoFWIZC2iodmCBhMOd1OnMtxpxr8eRj++WpWSHh0
 FeBD0fW6Ocm0Hs7Hvg5+k1ZjaJD0/6yuJADmCVQHQzEPyRYreepsfWLLoItFWVMt7Gq0
 WpUkMGKkVRIUezPSQNOtgXvEWys2wNo/KNrNmH5T9JcDaPKPKNtY5zSo/FvBzaSLJMuU
 /JXoA6rQO0bSyqv1nt3/vGcFpaObmbZrFVU+XH4m5H23D8TVfmqZiCmH/+gsXqkofS6d
 9AVAmgzf3YkLFMPq9b65jhvCBIC39PlEBo1YQSkfNdB7+R8tFmYvjiTDs0B7OgeP8u5G
 1eJw==
X-Gm-Message-State: AOJu0YwnocwJWzWrzGTmbyRojjSiAfX/lxZu8fcM8T+Hhog/mKbLD/lN
 jVQODj3CvIuHxQY5fQ9jiA1vdylmpc0oxy8e+xHEIw==
X-Google-Smtp-Source: AGHT+IFQyhx78HEKxZW8L5BOw/83fUrjDN15lSLuSmWzYw2h4NyxEK/kqxXEG81GJhL7FoJHwRckLA==
X-Received: by 2002:a05:6e02:1b0d:b0:35d:701a:bc5d with SMTP id
 i13-20020a056e021b0d00b0035d701abc5dmr7839739ilv.28.1702572710143; 
 Thu, 14 Dec 2023 08:51:50 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 08/21] bootm: Create a struct for argument information
Date: Thu, 14 Dec 2023 09:50:17 -0700
Message-ID: <20231214165112.2182274-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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
---

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

