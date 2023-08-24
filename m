Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7A3C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E6886A51;
	Thu, 24 Aug 2023 21:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MlrdRZRX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B49869E9; Thu, 24 Aug 2023 21:56:22 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862DF869E5
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7927f36120cso1483039f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906978; x=1693511778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JEuypTXF35O4EMeI9lCzfAZATvhNKpQlPnlrIIuF+vM=;
 b=MlrdRZRXMYxvsoWK+zYmp7XtJbJxvhdwP4t0qN2eJxUXKyIweLqARI0YBAjaWZHUa2
 /bhoj2CSPtzEEIiIIZG+omPyxrERbz1dsU0nT10ueUTV4/HkxJI5ysW915Gzyg7hNlE1
 2au2L14dmFkdeGlhkLa595DJ7vIskBVooBf9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906978; x=1693511778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JEuypTXF35O4EMeI9lCzfAZATvhNKpQlPnlrIIuF+vM=;
 b=CkOmY4mUugT7mmYP05p01ijSbXSZn8ukX5zf2YjND+t7ydny5GQlzMOKOUiNt5mtrS
 qrXooEP3x84QD0FFRzGtraBoO6+4H/DZgHL7onneYyaa64JtEcMjnFHcEBsMR9NTm0pT
 H5GRBrZhnmKwG+vTvZUQu8GlD/uIzpO4FD/Pwc42Se2WjeGyaqRmezpOpuJSUWKIL+rv
 VTd41rfM0pHyZJsSolOnuKGBvs4iiFLuLycyuOFnHvsHO+1daMutxyvCjZ9tVSquOLm5
 ejHiKhKfn/T+W03VvEJnb3npYIRT0ciCE+QZcRkc3Hvr8Wr9vhD9dX6RSgGzkueGVG2r
 pmUA==
X-Gm-Message-State: AOJu0YzFfejD4mDW0tFhQm8E0UcIJ0hZZOsUf8hgetxXOsmmS8Kgn+vY
 o4p12goBlu6MLwQYofrj29fXUfuLl03iCRs6gOo=
X-Google-Smtp-Source: AGHT+IHaSBgeqfCI77J/xQslsoL4C65/zZlF+TTkYptuPFoOKdZttLw0izSgEfKMpHL3JFRWwaFYyA==
X-Received: by 2002:a6b:da09:0:b0:787:34d:f1ea with SMTP id
 x9-20020a6bda09000000b00787034df1eamr7142551iob.8.1692906978211; 
 Thu, 24 Aug 2023 12:56:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/23] CI: Add ChromiumOS utilities
Date: Thu, 24 Aug 2023 13:55:46 -0600
Message-ID: <20230824195553.1685996-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

We need cgpt and futility for building test images. Add them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/docker/Dockerfile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 3d2b64a355f3..6e6ae9ebed40 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -39,6 +39,7 @@ RUN apt-get update && apt-get install -y \
 	binutils-dev \
 	bison \
 	build-essential \
+	cgpt \
 	clang-16 \
 	coreutils \
 	cpio \
@@ -115,6 +116,8 @@ RUN apt-get update && apt-get install -y \
 	util-linux \
 	uuid-dev \
 	virtualenv \
+	vboot-kernel-utils \
+	vboot-utils \
 	xxd \
 	zip \
 	&& rm -rf /var/lib/apt/lists/*
-- 
2.42.0.rc1.204.g551eb34607-goog

