Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B09C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61A0888E7B;
	Wed, 21 Aug 2024 18:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cMWiLYsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E0E88E78; Wed, 21 Aug 2024 18:20:11 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EF888E93
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:20:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70943b07c2cso3863540a34.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724257207; x=1724862007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXAu/nWITCpVkwG4bskSb0j0F9uq6fCgjaniKudbjGk=;
 b=cMWiLYszmP8aiZslASyC4l1lTWcNsRfI9F62lX5b6o/IZp1WGwFQybvdrYJ4z8tJi7
 CKBOkS+iIPeAyHtvhhQNuLSJujnqzA7yt6j1nAzLmgJfyD+d/MDFcyrF5Mu15BKtH8n9
 yhjVaoGs7azDPyp+xoD5WS7jes1d9T2bo+W0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724257207; x=1724862007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZXAu/nWITCpVkwG4bskSb0j0F9uq6fCgjaniKudbjGk=;
 b=tJgmuStZAP3AWiGb086Cc4PmNB/YQ7AhvtMdNNhEOGWO6nVDmKPbgzDR8CXybKVjhV
 6YOTKcvoWA2hgzE8R1HhN6Kj128QLVCMMe3wVx1hjxvbwfss+45Fs7rKY3QlB5uuyFMw
 4JVwru2kITq9pqUQpvATyAQS95ihD4z115rSF8DFOBSakGqRDh5ndLPb/0UOWXTYQpaA
 +5f6YF8VZgyomFcJIaES5zPWx/x7ycM9cZurn+l/pKvuBMdfInz85Q6tqgBgb5MRpV/f
 F9eSCB8/aOmKr0kVLv2JVJ5ovOjK3IgTjbPb3rrQKDltJFDbBdsLGVnLErXzx3QwbaYE
 xvjg==
X-Gm-Message-State: AOJu0YzUKkSvNExbMCBToP9u05/Rt1uh5RkFD9CuknBcE0ceSCqKmqAN
 TN3iZWepxyoLi1s0wUdsj6iGzCByZqJsLgEXKhFFJffZVUzXfl6fPV2R/I2cQK2mXQKzlTi8dQA
 =
X-Google-Smtp-Source: AGHT+IH0asVtokJGGF3v0H1mtcXyEuOy4p4psdDDsO6NhhdndNqJpN8ETqLzk93YW7LpVnuFQvyMpg==
X-Received: by 2002:a05:6830:2641:b0:709:472d:f342 with SMTP id
 46e09a7af769-70df85e7f6emr2562180a34.6.1724257207106; 
 Wed, 21 Aug 2024 09:20:07 -0700 (PDT)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca6629792sm3222376a34.72.2024.08.21.09.20.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 09:20:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 35/35] doc: Add some guidelines about global data
Date: Wed, 21 Aug 2024 10:19:27 -0600
Message-Id: <20240821161927.695717-36-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821161927.695717-1-sjg@chromium.org>
References: <20240821161927.695717-1-sjg@chromium.org>
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

Update the documentation to provide a bit more information about how to
use global data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase to -next

 doc/develop/global_data.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/develop/global_data.rst b/doc/develop/global_data.rst
index d143f27eedd..2863154ea42 100644
--- a/doc/develop/global_data.rst
+++ b/doc/develop/global_data.rst
@@ -51,6 +51,31 @@ U-Boot. The value of gd has to be saved every time U-Boot is left and restored
 whenever U-Boot is reentered. This is also relevant for the implementation of
 function tracing. For setting the value of gd function set_gd() can be used.
 
+Guidelines
+----------
+
+The global_data structure is placed in some memory which is available very early
+after boot to allow for a minimum set of global variables during system
+initialisation (until the memory controller is set up and RAM can be used). It
+is the primary data structure passed from pre-relocation U-Boot to
+post-relocation, i.e. ``from board_init_f()`` ``to board_init_r()``.
+
+The global_data struct exists for the lifetime of U-Boot. Since the struct is
+used by all architectures, fields added should be useful for most architectures.
+Fields which are only needed on one or two architectures can be placed in the
+architecture-specific ``struct arch_global_data``.
+
+In any case the struct should be kept small, since it uses precious SRAM on
+many boards.
+
+SPL also uses global data, as well as U-Boot proper, so take care to avoid
+adding fields to SPL which are not actually used by SPL. You can create
+access functions or macros in the header file to avoid filling the C code with
+#ifdefs.
+
+A flags word is available, which provides a convenient means to track the state
+of various initialisation phases within U-Boot.
+
 Global data structure
 ---------------------
 
-- 
2.34.1

