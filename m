Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A27D6207F
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FC989686;
	Wed, 20 Nov 2024 11:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iVZSAOTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19E8989681; Wed, 20 Nov 2024 11:02:36 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142F68964F
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-431548bd1b4so36896385e9.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096953; x=1732701753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uol12ilzrp93zqLCzBA5S29w8Sc3Lnbq6z2HdvzTkj8=;
 b=iVZSAOTUbViNwSl+AE7hw98ylEtyNouNJkTK/vyDaoq5gTneezKmUJTYUmDrcboOdH
 1QeCdmo4xdKDUn/20phL6dqDBs9XfiY1Y7RX/tuD2Akcqhr8olkcFAs4ED1BuHpTtnjn
 Vn4R12+J6rZ7UDtwz4sjcqFgojV9E3m93VHVfw9x6zwuvggP8TDv2RGrPaEDg91vLwD8
 yh9mU4CNSjo3cBbx4GcM5vJNEmbs3UMy56bqa4K7EaF3fixQ2UpHZEfZ8kXbXMOPwYv0
 F3ogD0FS7FMzMUmAVBb4BbZCcTz0OwiQv8JRNsSDR9fovwgvrHO1THZA4mVbyrpghvRr
 A9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096953; x=1732701753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uol12ilzrp93zqLCzBA5S29w8Sc3Lnbq6z2HdvzTkj8=;
 b=oVydGkxEQ3oR61EKlw/wD6sMvfyhYSaoMavxD/Tkb2UMpg/XxAByAOfxmfmY4Pxuv/
 s887j0oPNo15LiLTdL+h5L8ghX+mVWuES2IFX7YETmVv7pKSzeRR2G4hMr4g8BMvn9kG
 oNh51EocO1DtqdytrfZisjoLJsOG4VJFjMENNF33eWZQ/ZB0PhoCJl/Rj/YO0pUCnFBM
 aF6IL3l72q0TOv9ah4DCuns8y7vA82L3gJFoE9r770hVj/Kj3fgL+42KzclcI0Ruix+v
 mWxAkk8H75Km6F2jtPkrqP+WchUgZTamIMxHuBhayWxhSZKWp9lv1c/NTlUlw45/yn05
 LwMw==
X-Gm-Message-State: AOJu0YzQXvc3xzodagsTRiT1eEUZlrRBwgE/NX7cNDBtH2394/0lQ8v1
 sSsazXsZK2vhfL+0i+k03fCTbnceDbu09a2LiCmPZHVFqNrF7SFUoAmI7v4Qw8S5IKgBmeyhHfS
 CSFxk9w==
X-Google-Smtp-Source: AGHT+IFCrxqhw34JMoL16Jcfa8PoOus0RH2FzdDTyY+pwTrPfATKtQhjAwnwNHsFNPoDXodkCnhyZw==
X-Received: by 2002:a05:600c:3b9c:b0:431:5ba1:a513 with SMTP id
 5b1f17b1804b1-433489b596cmr20373425e9.10.1732096953524; 
 Wed, 20 Nov 2024 02:02:33 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45fa706sm13572655e9.16.2024.11.20.02.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 02:02:33 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/4] sandbox: select CONFIG_64BIT for sandbox
Date: Wed, 20 Nov 2024 10:01:55 +0000
Message-Id: <20241120100157.485418-3-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120100157.485418-1-andrew.goodbody@linaro.org>
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
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

Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
static analysis tools.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v3:
Updated commit title

Changes in v2:
Moved select of CONFIG_64BIT from SANDBOX64 to HOST_64BIT as
suggested by reviewer.

 arch/sandbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 1c8353d615..db29ca14bd 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -46,6 +46,7 @@ config HOST_32BIT
 
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
+	select 64BIT
 
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)
-- 
2.39.5

