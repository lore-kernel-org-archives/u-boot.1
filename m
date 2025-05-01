Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB66C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 21:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 414A0809A5;
	Thu,  1 May 2025 23:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="idw7JmvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2C080F03; Thu,  1 May 2025 23:02:01 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E458070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 23:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72b0626c785so1160437a34.2
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746133317; x=1746738117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nkdSKnNk4mLEQ87wo/HWrDeo+d9lCijbuhl6EcT7uZU=;
 b=idw7JmvYDJSIv6lAb+rdUQIUUorgfSU7HQKKXtHxt8c+qmswg18XAqMxKoXOmSUHtb
 tEahc4WgI8Tn+KQPp1lfDDN4dwlsDTsfcg9UaIRvzwazL28W8FZJrU1O6dfCryl7gs1r
 l6c79BUmtgWb6/kbDBtk12hIU6ovHq3y8mwDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133317; x=1746738117;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nkdSKnNk4mLEQ87wo/HWrDeo+d9lCijbuhl6EcT7uZU=;
 b=L5UdUepUxuAKgY1fWIrqoU44AKSXqNtq+vk1Lmqg7NSOiHsI7PqsvQnBj91c6zufus
 Rw21soyhXsVQrgf6ruwQgorTp9M0Nx3he8ffpsurMrV7zAPfD65Ei+hXDWTwZyUzbPAD
 rcGOhlvvcRA9Wf9UhKJrG1B9W1OFHqIhVAY2mZOJ0LID7F01pox0w8v8p8/OACkvxKXY
 jVsH+SNDbwsT6gwtnwuNcHu/adJZs+Y0XBRiEsgihfjxtiFUSFmKT6KnaUAbOqEY+Rc7
 4FOeyouEn1ZFqUohxdab1voqZHD2CQajsT9T905nUAH3rQ22ul68kM+ugRaZl4D+jzqw
 IptA==
X-Gm-Message-State: AOJu0YzcSh8qPEdsgiHU9ETs0bTBUoXRm4f7rKcqANjRZbfsml67oYEG
 cWmVrUliMrIM/vbxjV5Mo25w3A7lDyf3S1DOyZxyBt9PFHqq3gcwC9KaK8Fus2S1f/IYbrKqJ3U
 =
X-Gm-Gg: ASbGncs3giVrTZaMtF3X6rYhgrVW5djwKrRerpwPaHa/XwQfk1B6OAVS1/G3g+ue6JZ
 QsfmqZgDYP8UWTaNe3P2IS19IEdLjxOvEzCNj73NuzdYpFGpZQX+6ViLsuR2pUW7fN+heAAP+8m
 QUTRQ6VC8abknCwxTOarFP3ZfKl58MXYH9sOw6mKTNSZkxhR8attw2mW4brO84/Km3IKgR8P9di
 TLZk4RDAdO/b/mJW5NXhAggr96P+c+ZHuZ0D5Itk4qmhoiB2Ogf/CwNEPPyPbZD/0TyBWIWrG+G
 zsot7dbRrXPWMlsaPttzveLR7tIpAXYggmRMTw==
X-Google-Smtp-Source: AGHT+IEcEjfAXW8fEiQo5+1CtnsnV/VCFrp3r9Avngu4tdHmimvFfs8RY2r+gFS8JkbrleSy0xQ7+g==
X-Received: by 2002:a05:6830:1d44:b0:72b:aa94:6d26 with SMTP id
 46e09a7af769-731da1fb784mr181354a34.18.1746133316536; 
 Thu, 01 May 2025 14:01:56 -0700 (PDT)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d31cbc76sm253409a34.24.2025.05.01.14.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:01:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH] bloblist: Add maintainer
Date: Thu,  1 May 2025 15:01:42 -0600
Message-ID: <20250501210145.2011382-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Add myself as maintainer of bloblist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d7ef23f476..5005dd5951b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -936,6 +936,15 @@ F:	drivers/block/blkmap.c
 F:	include/blkmap.h
 F:	test/dm/blkmap.c
 
+BLOBLIST
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	cmd/bloblist.c
+F:	common/bloblist.c
+F:	doc/develop/bloblist.rst
+F:	include/bloblist.h
+F:	test/common/bloblist.c
+
 BOOTSTD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.43.0

base-commit: 9b9647c89cbe785fd935f70e16d08cf9812b9fda
branch: bloba
