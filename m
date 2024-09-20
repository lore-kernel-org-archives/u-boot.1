Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7682CCF58E7
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 08:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2726289444;
	Fri, 20 Sep 2024 10:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ck6JrXtA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CCC789436; Fri, 20 Sep 2024 10:13:33 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDF50893BE
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 10:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so2057312a12.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 01:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726820009; x=1727424809; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t75nPGp+HLjNQNLqqcJwJNLYwVOhsfQyUkV50PcqKzk=;
 b=ck6JrXtAiR91pLEQ/Ag675CHp8btMVGNz+QlDRdk12jeypPf69XMYUJk+kNusmS9/F
 Ss5je9zQ3T5lPdYOgIU6Fd/cAq47IxG3lgOkVIqlALwIzaZde+2nZKSYzi959Y2Ppd2w
 GTuNV6WSCAD4ruhO/85YaUUcLKs/OsW0wjdIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726820009; x=1727424809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t75nPGp+HLjNQNLqqcJwJNLYwVOhsfQyUkV50PcqKzk=;
 b=ttJuv6IWyhGT2Y1VNpLot32MOfo6IPXir0MU2W353Cc4MzweO3JVstGveI20o6SdP5
 XwakPB4PPWIKEfjOQGkmq+mZQEz3Gv0Z3jdb1MKViN7wg8YYrRTWxSGsU9w8aQ3uXsV4
 LS0XdoFOnXUwb8DKbU5/i3xu2oO+acTCTd6FgF8FWZqCtxeEaiocEnTW3PnH3eQZNkqm
 WpaQc1JpW0QfVk3JpJFwM94x3Yp4VKGVaHmwMtbrJliRYROMMx7O1ca8gLf3mvS89wCG
 F/+Z1LPhtGackDurrV+JH/7+cTgb5/USz+tZJVug3Upn4OEv6j5lbmIwTbd9vgVo/8SS
 u1/Q==
X-Gm-Message-State: AOJu0Yyfs0a99hkRi/nuDiH76X/cMHzKHj82Hf3VQW5JjtFxA3fk2Dhu
 ST/0I5AKJMiKaWXLtlmeUJo6ZCHAwsXCQs1vBxxqEA3sWpY462RQbY/N6xdjKXNEd4wZ8z9KUMB
 eAt+H
X-Google-Smtp-Source: AGHT+IFVe9orNGMjqxD2J3rwnq0cgjSbUrxqGOXM7ooZMe5F9uVXjnT7IjZ8OHckeKi1S7IkGPfguQ==
X-Received: by 2002:a05:6402:2347:b0:5c2:6343:8ddf with SMTP id
 4fb4d7f45d1cf-5c464df2910mr1247381a12.33.1726820009167; 
 Fri, 20 Sep 2024 01:13:29 -0700 (PDT)
Received: from chromium.org ([83.68.141.146]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bc88cf7sm6804447a12.90.2024.09.20.01.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 01:13:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/18] malloc: Provide a simple malloc for VPL
Date: Fri, 20 Sep 2024 10:12:45 +0200
Message-ID: <20240920081309.140426-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081309.140426-1-sjg@chromium.org>
References: <20240920081309.140426-1-sjg@chromium.org>
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

The VPL phase may want to use the smaller malloc() implementation, so
add an option for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/spl/Kconfig.vpl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index d06f36d4ee4..3dc0e95e09f 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -222,6 +222,15 @@ config VPL_SPI_FLASH_SUPPORT
 	  lines). This enables the drivers in drivers/mtd/spi as part of a
 	  VPL build. This normally requires VPL_SPI_SUPPORT.
 
+config VPL_SYS_MALLOC_SIMPLE
+	bool "Only use malloc_simple functions in the VPL"
+	default y
+	help
+	  Say Y here to only use the *_simple malloc functions from
+	  malloc_simple.c, rather then using the versions from dlmalloc.c;
+	  this will make the VPL binary smaller at the cost of more heap
+	  usage as the *_simple malloc functions do not re-use free-ed mem.
+
 config VPL_TEXT_BASE
 	hex "VPL Text Base"
 	default 0x0
-- 
2.43.0

