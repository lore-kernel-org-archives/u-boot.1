Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14FAC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3CC82FCA;
	Tue, 15 Jul 2025 01:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZII+mi90";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF3382B07; Tue, 15 Jul 2025 01:12:05 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64EFF82B07
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-73e586fcc28so125384a34.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534722; x=1753139522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFt5K7kEgpX1Dd7i7a7MOONCgctYxiIXAmtLzMErxFc=;
 b=ZII+mi90VoFX6+gDzHa1V6Qsq2bZLLoqw3YYpZBvIzT6WVz81BmiUyVpBBX/jiZR2l
 SGHVyMQ1pH5xrPVfQZYT3+4hV9EE0YP6XhgldAItyVDhnOQzkLjiOpV5DcMGhSTCouRu
 So9y37OM9JN4cKYBGXwmaFOef3k/VaUA/BQE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534722; x=1753139522;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFt5K7kEgpX1Dd7i7a7MOONCgctYxiIXAmtLzMErxFc=;
 b=dp7L6j9WziWVh7qt8hA5EmYjciSkfbEkceo18IcE0vr5OPmwn/nETsA4rlto5rIny2
 7EMIIhBpC86yIph71WyQHwPrmilOFy1zVcQtenbdV4OuCkHEQG0d8IEqvgJSKHf4kRUN
 /KytFr75iAaca4+mPRmXNqaJn5wycwMY3oZgzqhtW6H3SSlcdttNMs2NPnaB7C4/w8m3
 J7+VrKIyeZjuIWc0jhUj8Ng3x8JVMOfgzhjgI3UwxBfWNFkwdUajcmjlFCiZt7Gliab9
 PTQZ74QlVVo3vrPxJXFLmoCKamS14m+DfthwAAGecXpUaDqphKUU+Ai74CJGqw6cGWn5
 cAow==
X-Gm-Message-State: AOJu0YzzkvF55xwFW1d8+wXgywsefHDvs7dl6M/AR2oZz3AzCHvriSOv
 ltj6npSRWy8XT02rSNYEVhfJRPmamFOgKkamNHujBgBAFITstvo8hc9ZMSYfy2x7ih4=
X-Gm-Gg: ASbGncuaFlEhV3Ibr6D43mmSBl0wu5o0pFfz4tqr/ANni70CtZNbqnYkc1t+WxwCkQ7
 WmqrczhEClRrDIoGwUx/9HFK9Fz6cW5Rvyjs+zbQHC8ktSuIHEHqLwfS3nCQD9qX+CCWXqJ99fK
 M7J2Z5szxAP14qelsMMmA1ZRT47/jBYEPyBaZ+XH18FgNdOGhLJycLoR4OFMUC808T3yo18PjOI
 Z9+payAMmD+FqPBSL1dwEVNsKQUHJRrvpzjQErzLyVehtibwZVh5jTZyaXaRtDEYGJv/o1nRQ6Q
 zWfAgbo/zDk6HDsnaMW3lPAFS5fnj/emTFfpnpRCx1VoVHEy3qTu03zluz1aB7pVfab1eYR3jf/
 /n1Zfy/cD0Ur0esmCWh13OrukDiJd0v07H7O1WexNfa/YXaCPYJLYat0=
X-Google-Smtp-Source: AGHT+IHLMCnohynb0Yk4jYydcdxxCzWGxkYzZ4Rar5ddfNvkO5qi6wehSAnsu1UfpBpuAuzw42tp6w==
X-Received: by 2002:a9d:6e0a:0:b0:73e:5540:730e with SMTP id
 46e09a7af769-73e574a8a60mr978920a34.4.1752534721966; 
 Mon, 14 Jul 2025 16:12:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250703-cros_ec_sandbox_fix-v1-1-04ac442b8f69@linaro.org>
References: <20250703-cros_ec_sandbox_fix-v1-1-04ac442b8f69@linaro.org>
Subject: Re: [PATCH] cros_ec: sandbox: Use correct value for number of
 slots
Message-Id: <175253472104.280771.3737012856930705250.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 03 Jul 2025 11:00:33 +0100, Andrew Goodbody wrote:

> In the definition of struct ec_state the number of slots that are
> created is VSTORE_SLOT_COUNT (==4) but the value of req->slot is
> checked against EC_VSTORE_SLOT_MAX (==32) so this can lead to memory
> access beyond that allocated.
> Instead change the size check to use VSTORE_SLOT_COUNT to ensure it
> matches what has actually been allocated.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] cros_ec: sandbox: Use correct value for number of slots
      commit: bae3a34cb9e6b3ce6d01f68cdd34cdd45419f22f
-- 
Tom


