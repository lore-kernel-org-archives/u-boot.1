Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7EEDC7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 19:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7CDD82E40;
	Thu, 26 Jun 2025 21:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NkPFzZg3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C3982E17; Thu, 26 Jun 2025 21:32:55 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D1982E40
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 21:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-735b2699d5dso751717a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750966364; x=1751571164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7jVAVdNFAF9NO2hSKo9mNLXsHR9d0CwlOy2hGzrCAQ=;
 b=NkPFzZg36qBwyMWbd19TIlE5gAT8bEAvfzm8E0QDj3Arzve8CnA3tMSceoZPfT7oDh
 LwwRwjL+JceGaa4k35v9heTw/tAd6nm/vtDBF8Dj6V26xDiEobOy0Q6LRfn21WI/ui5V
 pH9gYbpr3yNY4UdW3BbjOvZxC0yQGHzbCqREc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750966364; x=1751571164;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7jVAVdNFAF9NO2hSKo9mNLXsHR9d0CwlOy2hGzrCAQ=;
 b=ri3J/c5MFn1UoJqxsTlFHZJtV4n/xTSoi2waVQk6t5Dk2k6sCNMD5T08RgfcIp8pNv
 5sF9Rxf5EiI8m+RwQX7s/1s4jJ0n3HLxhqE+xWyC9ixhggiyuIgpnshcC6KKMFFSZGWS
 WCJ0aOmGsdJxsILNs35RfFoHAvckBdS3eMOrDt0RheG544E/I2Rj4UPdQyIl98bFbJtq
 BHgMRqvPSb+ya2cyPSxlf+d2UaqBzH+W60E1KdFl14SV2LB9mgfdogMchenc5I0U3WaA
 6C6SFqmGjR3PwkkpfrBAKjFZR/Wb5nh7Q0KvX30OP9Enz5O/Gg4k2jY8ZMTRLlMOO3je
 /e4w==
X-Gm-Message-State: AOJu0YwAbCQEpsQCit2THMt/w9UaV2Qn/4h6GdFXW9c6ftkD83BI0qxT
 BJakYFiQEYsjg1vU27Q6tYLi2LYe0AHNNzpKhtuPXLH2T1VtoUaV/akpnITDjQTCXJ9P97zkfwL
 fHcJvpl0=
X-Gm-Gg: ASbGncsApJoJ8YpJn+SfvKn+EC9IQcLNqCgzE2O9r2dcUT8v8++SadqPU/weN4/OxT5
 SuXcn52z/AN+D7FQw1YG5I8Ms7JSJdhDm5pkzW/C0/BVOpRNQsSXifFqYjkeLdindgN1t0C3pL/
 pjxwq9/gMvb7BnXz0Cl9Kcj0dCIOanO+woGfR3M1QE5zab6O7L33XrIGV/zYLHYsWHkHk+rThsk
 ARktkn2XTTT4fb6+7zMYXyXL2O7wSAN477xI5HsvO+2vjVNwO1Ec6sytCdCpCHuTeMSe2fO5XT9
 DnZA2jC9RkhWXCyopKzN1q+InKQ8Kqq5knrTIj5Ch+tbpjsI1XHkUx/IoTvWixkinPDGEZUVp+O
 Zq5yoqi8oYl8Q1qBqVCWlhdL9cH6ETU9q
X-Google-Smtp-Source: AGHT+IEknM+dPsLKHhiv6ZnKuBuFfuUNAve9jw4FsrvDCasC3+gg4xZTEK7NozkxwwersB4BC907zw==
X-Received: by 2002:a05:6871:78d:b0:2ea:7d72:23f7 with SMTP id
 586e51a60fabf-2efed500ee0mr198879fac.16.1750966364591; 
 Thu, 26 Jun 2025 12:32:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eab4e3sm511958fac.4.2025.06.26.12.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:32:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250610-pylibfdt-license-v1-1-fcb69e3d6a96@cherry.de>
References: <20250610-pylibfdt-license-v1-1-fcb69e3d6a96@cherry.de>
Subject: Re: [PATCH] pylibfdt: correct license information (further)
Message-Id: <175096636362.1890320.2935415662066614972.b4-ty@konsulko.com>
Date: Thu, 26 Jun 2025 13:32:43 -0600
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

On Tue, 10 Jun 2025 15:17:56 +0200, Quentin Schulz wrote:

> Since commit 51ec8db23280 ("pylibfdt: correct license information"), the
> License classifiers are gone so I assume setuptools now extract the
> license from the license argument to setuptools.setup() function.
> 
> It's always been incorrect as far as I could tell, so let's fix this
> with the appropriate info from the SPDX License identifier at the top of
> the file. It was missing GPL-2.0-or-later and we disambiguate by using
> BSD-2-Clause instead of simply BSD.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] pylibfdt: correct license information (further)
      commit: 5f732b4bb0946b4d1a32add4ec5595eb9846cd26
-- 
Tom


