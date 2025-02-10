Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F06C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CAA880C72;
	Mon, 10 Feb 2025 21:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eHexSl3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 628AE80BAA; Mon, 10 Feb 2025 21:38:48 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9631C805D7
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6f9aa66cbe8so34557557b3.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219924; x=1739824724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADSjBY2/VYmY1J/CJ6IyVzrpAGQrGsBAW/aFSnbX8cY=;
 b=eHexSl3NzXSQucM5XHOzQC1X3NP+iFtX/WVYqcyRorDQpvD2bNKGNzA/film8dqnac
 wl7CBuH8neEDu4mWGDatKQt6FjWSwSl2ZFPBxze6C44an3ykuclGCW/7VVHBprzBVWoz
 8fNPq3dG6skjWepR4t9ICI5dQFxreWoFUkXLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219924; x=1739824724;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ADSjBY2/VYmY1J/CJ6IyVzrpAGQrGsBAW/aFSnbX8cY=;
 b=OC3yJkz/h4nR2Cf2KE6vWMqMgDU5STFA+X0N/c/Y7Msj76mVorzRlNk76uNfpa0fHh
 VEHv/GE35Qy1x2AQ+btJgiAeOZRaRbJqVS2oj3IMmya60OoP07csiALh+5IGQYJ4W/N1
 cLq7zLaPoboQ7F/1BD99jBHu47/PthofBYUi4X5ix/CGvNQgctc8TmTkWunGC2iuxy3J
 fEojLx4+orKguv/37xn3dOjNS/G6XXKZ0UWbyGd4iuM+SDCLix+dFZBEgc4icpMmiFd8
 ezs2ozPkbenLeYa1LywgB9mCS4FklHs+9mt9SqFdHk+DVzfwICX0MfM7o+F2v65yyKJu
 Inxw==
X-Gm-Message-State: AOJu0Yw/p6P/f+VPAxWjJG5OqCYnKYmyhFL8WmMT5Gn4FfsY9EBJy4bR
 Yyz123KHEz6mEUG8SI9mLnov/sDui99PrLNfOtqtuWghdO4BgEM3jjy/iRnQLxDOWOieHvYmU5j
 1
X-Gm-Gg: ASbGnctpDqnee8I47Te26jDzk4fgpJRNoEIVtd5PPiui+aX+/8nPU2D6mk0kiH7P7rs
 9O5LuR5EgeUBfrLT3tg1YP+OqgIcM1VNwOhtOkY9vIc61h6DyqalJXPH0KpQaBpMe+KzYdiBCPY
 7k3p27Xt5uvjElahW4XIpFAcMd6PyO6uUieSkomS1mpsRIDCjorAInWi/tNVvgadLLi7yIZtKUb
 Dpcqo3oAcd+Xd9frw3tPuoCr81VcJoZBzZXURhGbV0EP7O+Xj90T9oenxcSVqXl87WuemkYnCpV
 tY43XUJhwD9Fpw==
X-Google-Smtp-Source: AGHT+IGMomnpPz60k+CtHwAKysGK0ds/kI+W12buA1rcFh1ICYLwMf4iu/iZtqR4SjO+NHujZQCPEw==
X-Received: by 2002:a05:690c:9989:b0:6f7:5448:b5e0 with SMTP id
 00721157ae682-6f9b2879d4emr148322327b3.16.1739219924502; 
 Mon, 10 Feb 2025 12:38:44 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Joe Hershberger <joe.hershberger@ni.com>
In-Reply-To: <20250205143444.65146-1-marex@denx.de>
References: <20250205143444.65146-1-marex@denx.de>
Subject: Re: [PATCH] tools: mkenvimage: List -V parameter in help text
Message-Id: <173921992368.2921783.3724107656825283476.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:43 -0600
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

On Wed, 05 Feb 2025 15:34:28 +0100, Marek Vasut wrote:

> The -V version parameter is missing in the optional list of parameters
> in help text. Add it.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


