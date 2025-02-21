Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974CBC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C7A80F96;
	Fri, 21 Feb 2025 18:38:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cxo/RYSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D447880F5C; Fri, 21 Feb 2025 18:38:14 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A83A80F67
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220e6028214so54642485ad.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159491; x=1740764291; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O8kgzf/m2/1exicP/+UrxV77sTIQlCsajpf4vvXQ2qw=;
 b=cxo/RYSm4O+iuo4fmKpybWjkx4Ili//VOmvhrsPxc1+HNpQkLfBq5R54XY0SagWbjY
 TfJWB8v6NapgvwuVPk0J7r/rd8ypSJVqXEfB1W9v41mdMjSQvcZwW0wRqStYF3Gdou8V
 fORDLb01B8N0MbsgtCAdW8gxIkCy+IUhd2mTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159491; x=1740764291;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O8kgzf/m2/1exicP/+UrxV77sTIQlCsajpf4vvXQ2qw=;
 b=r/M0maadAo/iM6cbEehOGoD4ShWghNIBTr6mEhiZ2fyCusH321Ly1Uh58M8HtS3hIh
 sqpxAlQDt07QMxFSYPDrSiEhvE3MTLrJhJMgGluRWd14v7RofvEfGAjOQPPnpnhgYFAz
 BnYr8VMNOGv0QJrucKZI9v4FeHBe6sWYRbA/Q867pGXoo7q72X6duakgGZCHaZGTURh1
 2VnoO30Owm3yX6mHv2vWmCnm947srGsNIO42O6Q24Y2669jOQ/FWdEwE4pFpgmD9gJ6F
 jjcq3nBbjvMiVM4XqR2WLOZF3sJmYyUq9gBBxoNNCtESnMr1T5Hq5Op+qmOyCQoNjn0N
 mZcQ==
X-Gm-Message-State: AOJu0YwLEHRkgEdiCfKdP63JjWZF8hMGel3x2TWUZ2UVdO2ZQCK9IHX8
 I58yREBdV4b+Um617OLtg4rUHllftVLfMmgONP5EN5aF0C1iRjSV8DB7WsYgB4I=
X-Gm-Gg: ASbGnctXbYvBak5EjcdgEnFsZmkTtSg7IJJTs/rGlxl8wUetlH+B/XHJAhIpqwo3G3i
 fePszbrTvrHVSrc6XYN/HNYEBSM+WMACR73fd2ayilJiKGs06D4wqC1o4hUWTVPEnlyd4Hnhcgc
 h0gFgqfKoN5te31mp8AtpGW9cQ4H0k6MlQ/UmfmrEorbd1QSuFgnLuDb5TrOIlQBbfVsNHw1I12
 BL/+QTamRHyerOIC9vocYtska+Boc8+8MI5A6M9ap5i/oKCZJiJ+HKNNt1Brf80WboOU4ouQb1k
 4bzlH7UxffPW+ld9s6wFqzk=
X-Google-Smtp-Source: AGHT+IGpwqs3ZxwMJSl/+Z02yuyVliqH535VqJVwGQbYJOUIbe8jK8Z8YP2wtDgiSu0BHHVuidEowQ==
X-Received: by 2002:a05:6a21:339c:b0:1ee:c598:7a7d with SMTP id
 adf61e73a8af0-1eef3dab1bfmr7504945637.41.1740159491223; 
 Fri, 21 Feb 2025 09:38:11 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Love Kumar <love.kumar@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20250212222354.684526-1-trini@konsulko.com>
References: <20250212222354.684526-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py: Have test_usb.py raise an Exception with
 unsupported filesystems
Message-Id: <174015949028.3526942.1030161976823581032.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:10 -0600
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

On Wed, 12 Feb 2025 16:23:54 -0600, Tom Rini wrote:

> With a newer pylint we get a warning about how offset could be used
> before assigned. This is because when the underlying filesystem wasn't
> one that is supported we would have runtime test failures. Address this
> by raise'ing an Exception if fs is not supported.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


