Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79985C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A0B8657E;
	Thu, 31 Aug 2023 05:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P/+Hn933";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C70A86586; Thu, 31 Aug 2023 05:53:36 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 450BE8654A
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34df9c800adso1586375ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454012; x=1694058812; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLSlKj3wohMIOei64oIxY5NWPaRmR9ogaStxSciVslc=;
 b=P/+Hn933LKhQuptw5PwEK7qQY2q2+W7+pgXHIMLwKvT48PTCpHjIZWX1WfIXeHxSWX
 yyVFaUPszB85zQdkCzdgUlEWB21CJlpYNLxM2nAU6DNLe+xjVG2vdlwFpohekoUVbY/v
 kG9PhXpR+6Lcxs40anJROUxxxvkegGQuvcaJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454012; x=1694058812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLSlKj3wohMIOei64oIxY5NWPaRmR9ogaStxSciVslc=;
 b=C14x6SBiUlLfQl7qKh4oQMO3vYAb4UcJ4TWmwqCLEdL4zF0D3106Q80Xf2UsxBwT2c
 c5x8wbNBB+A9gV/SQe7+RcX1t8o4Y1a+BCoe4ef1Wtf9z69eIDoL20kMKPcDhRwZJMoW
 6zzs1ikkknJynPIrtZjan5kjEUP4C9AVSVCz63LCK+BYWjgAlFIuV9M8NMeu/YLTvx+4
 cHFVZka9LeehlT7SsExtMbJ6H6ibwfM+0+1O55Yn4IXwoKuoYsJBcfnufVoCcO4y8e13
 cLi6/gRHDXMvn75QyswJpc9+3PAfi/QIyMfJ+pLXEF2nF9vZ3Fj/frFZ0yd8Khy5V0vq
 ksHw==
X-Gm-Message-State: AOJu0Yx4ZVoKywfxSf4XL89MihamB/rbefqL2WAX8jj1J43MhyAhAZoR
 bm8KGmmFMeo4gMNi6d3w5Aw47BlE44axfMeviXU=
X-Google-Smtp-Source: AGHT+IHKEo8+4MBmZOP9h1jYlxJB1mBWZw+hSpII3jKiE8QUwJMbmfKJ9vJNKdeDA+BcUaZXmfPPOw==
X-Received: by 2002:a05:6e02:1b84:b0:34c:ebe8:9900 with SMTP id
 h4-20020a056e021b8400b0034cebe89900mr5123151ili.3.1693454011928; 
 Wed, 30 Aug 2023 20:53:31 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 02/19] Kconfig: Move API into general setup
Date: Wed, 30 Aug 2023 21:52:56 -0600
Message-ID: <20230831035319.2316665-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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

This is perhaps not a commonly used feature so should not have its own
option in the main menu. Move it under general setup.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 91170bf8d223..0a2e97578dfc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -585,10 +585,10 @@ config MP
 	  This provides an option to bringup different processors
 	  in multiprocessor cases.
 
-endmenu		# General setup
-
 source "api/Kconfig"
 
+endmenu		# General setup
+
 source "boot/Kconfig"
 
 source "common/Kconfig"
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

