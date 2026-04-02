Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03135D6AB10
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 23:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E69784056;
	Fri,  3 Apr 2026 01:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qNfZ1zRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D45FB84056; Fri,  3 Apr 2026 01:30:35 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE69839DF
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 01:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67bbea1e090so864121eaf.3
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775172632; x=1775777432; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9xn209HskEDpt/3irU0LktCdgZQoDrSklpTzgYC/6Y=;
 b=qNfZ1zROdq7sEvY1b0bfrUkDDDb7D71niw5+lLYSl9qWmIWtycubBky7eHVEWmmxhH
 YD1uzUUm0h9otDkQy+24dPdUXWa94GkM/9YvRkBZRPluK35WyoXqmsJkgEc693n0jlUY
 08qGmWiiTmfactXA2CU8Y/QhhObJ7TMyU9bkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775172632; x=1775777432;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9xn209HskEDpt/3irU0LktCdgZQoDrSklpTzgYC/6Y=;
 b=bthuNd7Cu/qha/aLuBaFpA1UMb0cUopxG6cuqkjOBKhy2Dbsi+oO7qL903vIfC2FiZ
 Hcy2nMXTe9FfpUWZGCDgn0ag5U7mMwzbqkY8jIPHbQCiqXJzcaaiqlRpf75KtDB77ilB
 y6calh42DhoHaQo2yyAK10MGaidqZ7QU6DylMaMDAUPGNNuTiIZ7mPNtZ5FVl1wanmwR
 svJsyXA5c2MILm8d/8ZWME9+8u+vVD4Mhj2A7MVbx7KYWwakHPdsS8Jzb3yAI7rhG3+Z
 ia0uyzy+Pu8DqRUCqvFfuaEzyyyTwj91XWabF19cjrhP1aYFUjYZwFyh3kZlOlGaOS2B
 AVYw==
X-Gm-Message-State: AOJu0YxCaZa9cn+r3RK/ChSzK1sO0a8GiYPteVUVjYXqcawBdCNSZLFt
 Xnx4whZexpbmWnph1aPwI4nyCkCVYL9Z8kvebW1tZMkawrjkE/IKMJfd6xgEog7EKyrOdzL7t81
 JSke7thw=
X-Gm-Gg: ATEYQzy5V+yPvsXs6NZEorOEn4kJ6XVuATwAGTJs4oHsu1reLpQMrmPkVSXtVebNJkG
 SlvSD0KUGfSBXCcCjtxsUVKmExvRpcCX88bv4uLSVenvS2kh6PN1lk3uasLllNJtuV2DvjWj4tl
 VpRzWtiUK2OgeFKZ8GwLpNPVXEBXJwsy+LsIXUpum8LVVBfMamHGNgoh9a+eH85O2+K6eO17Hxn
 Qie7DY+qo/c5qzoqW+3HDzhd+OUlUY1O3rTseCOZ2SA2vlU3/lD9g1EvmkZ0GXKTV3MfEk++G7q
 16Dp6PwxYLM88rs+435xXgCUb/ed/6eTnErMvqaaFzFbeMt13POLvlFvZQexyKgfZnC6GsbwBAZ
 mh0pMHklzTHa2enztGPKj5vEF/NEEHK+y9T/Eeta0Gc/jzUyzQWcKv7s+4uGSOA7fS1rVfXHMJx
 wub18x0UICnZYNauA9uXn8ToWfl1zts8WxBwrNrsKjnNytiH72MuCDsbGfifZ7Ha3GFOK1b7Q7h
 UbUC7c9xfaWhUZS+E1iPPas4XLsqeH86AHkcd9yacqQD5A=
X-Received: by 2002:a05:6820:210d:b0:67e:33a2:5963 with SMTP id
 006d021491bc7-6821d33c707mr672927eaf.15.1775172632250; 
 Thu, 02 Apr 2026 16:30:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-680a882d96dsm2817787eaf.9.2026.04.02.16.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 16:30:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Anshul Dalal <anshuld@ti.com>, Franz Schnyder <franz.schnyder@toradex.com>
In-Reply-To: <20260330140106.401876-1-ravi@prevas.dk>
References: <20260330140106.401876-1-ravi@prevas.dk>
Subject: Re: [PATCH] cmd: test: add bug-compatibility special case for
 'test -n'
Message-Id: <177517263142.1999166.6862793659438293352.b4-ty@konsulko.com>
Date: Thu, 02 Apr 2026 17:30:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 30 Mar 2026 16:01:06 +0200, Rasmus Villemoes wrote:

> It turns out that there is lots of code in the wild, including in the
> U-Boot tree itself, which used to rely on
> 
>   test -n $somevar
> 
> to yield false when $somevar is not defined or empty. See for example
> all the occurrences of 'test -n $fdtfile'. That was really only a
> quirk of the implementation that refused calls with argc < 3, and not
> because it was interpreted as
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] cmd: test: add bug-compatibility special case for 'test -n'
      commit: f7e7c55e53e80100c327b9cb0512c069acf80ab5
-- 
Tom


