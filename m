Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C265C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B0687A73;
	Wed, 25 Oct 2023 08:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hAP7QXHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8B187A61; Wed, 25 Oct 2023 08:52:26 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E35187A72
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1c0fcbf7ae4so3840413fac.0
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216741; x=1698821541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=an9QRMoz3OuWqsNnFJdi718RRybO9m7G7/ZdMHC9HOM=;
 b=hAP7QXHOe5IT9IFMZ9oi8I4Du/epVdZKt4/LekwGugybnZQ6yaROphNJwjDAbqT8r7
 /8tugxKTxlnowotgX55wVRwujeUK/sqzJZdfpkz+KdI0TvQLh9DQktHuwHZQpX5YWDMh
 seU25ZG+VrfozO/6F11Rok/dWycwkapt6iINp7ZDtOvK9QI78S8iI7Q2K2Okjf7dkGa6
 i9VnNz/s11U4PlbG1Udo486ezdTBSP3B8SlOODyxH9rf5sWDXxSCU6cbIUI8rFx/HtbP
 2FTLD+Jj+14FV2P+xHz1nMBkk8Qbp12toXmMsCRuQgMiOQvUPdhfPH/sO92xLYaSa3yU
 DdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216741; x=1698821541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=an9QRMoz3OuWqsNnFJdi718RRybO9m7G7/ZdMHC9HOM=;
 b=cBiQLjbQW4YetbsLlbVdyiuXxeZCXCbqHYgvHdx9+vJqwEK3AxgKlwHD5xQXytNEfQ
 zuqKjY7Rj5Ptl0joX8INvBBl7ry5+23UrqpdnR9+KPfyR3wQx+qPpYpBomBMgMLvSFS8
 uo/FcpTkbkijjlAeBw7WVGKCB2lbVIs27nOA1TH6PaDipKtxDlLo9QAyOd4XgC5WD3yN
 dNR62193eVTkEkalAiM/9E03D0NDiLh+YhEuweO0r7pb6+NYgryZ4GCVMrsC9+EdafiI
 v0oGkiwOOTgoMynyfNuX2t8FIWPFKau0KrtGzAIoca3DOfozjVGzg86sQPsDh/OyJDsF
 W3hw==
X-Gm-Message-State: AOJu0Yy+IgOLIBG0j5s38GqxISZs3fEL06tNarbd0g3KPkYJRG8EKXc6
 X6KqVer7GnXEVgd6GabqgvvwNZhrNqDpF553Hl8=
X-Google-Smtp-Source: AGHT+IHWxL3lk0adizYSF8plKBQFAroL+gd5nZ4uJdUNWoxj3ACMckW+SVw0qZ2SiQ3WdNmxkHzBnA==
X-Received: by 2002:a05:6870:13c5:b0:1dc:d8c6:39f with SMTP id
 5-20020a05687013c500b001dcd8c6039fmr14848424oat.14.1698216741403; 
 Tue, 24 Oct 2023 23:52:21 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 l63-20020a638842000000b005a9b20408a7sm8256922pgd.23.2023.10.24.23.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:52:20 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com, ilias.apalodimas@linaro.org,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 2/3] board: developerbox: update old NOR flash layout build
 instruction
Date: Wed, 25 Oct 2023 15:51:02 +0900
Message-Id: <20231025065103.3101666-3-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
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

v2023.07 is the last version supporting old NOR flash layout
by default. The later versions of U-Boot, Developerbox is
configured to enable A/B update and new NOR Flash layout
by default.
This commit updates the documentation to pin the U-Boot
version for the old NOR flash layout. It is still useful
for the user wants to replace the factory default EDK II
firmware to U-Boot.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 doc/board/socionext/developerbox.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/board/socionext/developerbox.rst b/doc/board/socionext/developerbox.rst
index aa7080e26c..596cf9f908 100644
--- a/doc/board/socionext/developerbox.rst
+++ b/doc/board/socionext/developerbox.rst
@@ -42,9 +42,10 @@ Compile from source
 You can build U-Boot without any additinal source code.::
 
   cd u-boot
+  git checkout v2023.07
   export ARCH=arm64
   export CROSS_COMPILE=aarch64-linux-gnu-
-  make SynQuacer_defconfig
+  make synquacer_developerbox_defconfig
   make -j `noproc`
 
 Then, expand the binary to 1MB for preparing flash.::
-- 
2.34.1

