Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06026CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16724845E9;
	Tue, 12 May 2026 21:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rRyCWthV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E0583E76; Tue, 12 May 2026 21:31:50 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A058341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dca4debedaso5661840a34.2
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614307; x=1779219107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tp7qQnAkuqWPZMo8jfNjF7UK/+mKF011JosgrRlKKSA=;
 b=rRyCWthVqwcFU+Edj70G/glMAP3kBSkhw/XYLD9inMVziVbt+PB2YG2y3asfH9D5Vf
 2re340Ltp/2cqhPGdfL3gDP1mJynPepS9zr0H0rYVRtfoNWs+DzPBIJmS5EUGNzEiy82
 HlEitJKe/UnRwN+ECaeWc7SNL7WAYySM96j48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614307; x=1779219107;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tp7qQnAkuqWPZMo8jfNjF7UK/+mKF011JosgrRlKKSA=;
 b=EGCxeusfxnEoTO7uUe2h3BemtEGJ+f7+7NzK/5Xt7BLSmYPXP2nJSQ+9Yx42tX42LD
 fsdtmA0GQci9IQV22Eua/6fZ5mwmlsprxg7CM9ZKs/G8dOgrmfMhxfd2xK7z7MTHyc3E
 4gs+HF+JavpVkeObfwj3TORgrza47dLqUEBOcNZ2dvqdD+kwFBol6czY/HXG7C14Hdtj
 B2eUlBSUQ7eiObAWwBirnGsC0syCAQue5VVVk+4AliEs1WlpqUwUHXsQd4TBtLuFHyzX
 MXAotl4f34WWjGq4GxZuy1ovHUcEI8yJH3lkdHcOptyeyt8YjvVI3NC2IXS5ENInP/rm
 hRjw==
X-Gm-Message-State: AOJu0YxgBfs7ivBGJCfrKq2rDX1IX/ncPSz3NiEZCi3h2ndYFtjqH2op
 NWHJa4Ru6P6b9gIndSM0iQcKL9J3vn/nPV3S5ytz1xjk3g1HlPX/bMhTR7bcwPhAx7E4/0aMgcF
 moDR3SDAOrhak
X-Gm-Gg: Acq92OFpmzR3DVDFbSWq4USqaiYYb2bAgOaqoSLLrwaGH+YnoGze+7+4dCPvobptB0F
 q3hqXTKoGI6gAbWsdCi45nAwVBzdRRISsjSIbH/+DssJ43znxudr9jDHi0MdHvdvAnqBnyw1g7y
 zKe4V4Dhgc19PuZC/JVHlnAdRpNTlP4vGjXgnN+mOEy9izTj3eJIHhBrlbpriUVY+g6GUR3LjlF
 KKgnIUDtUsMVRwG2N5CacEcj5X4NXAOvRufKBPczVBi3XMGbFo3bWw6MmAYf8IjjURyz8KlhuXA
 1tEk3Sw61WwnJ+M4UCeCRN96SE+YL3K4mZ5G0yx1TeanWaAP9VxCeWNCuprDNLj/GkW65B5A/q1
 Psy7vZcPqAUtM8D9KmvLjsCpWHiRxuE/i/45btCHtTcHIPM9iyz1CmqIcUr5rkVVMn4nOvSElEV
 mJIrFlMIBrMiSFUZMEEFcnnEcECsp198PwfBNKtSM9C1wy5r7plNEWolP853XQFYI80833YV56u
 xU3YkkLJNviHKZIQuY2Y+gPw7vupVuXvwc2ZY8HKj8Q6Kfaqw==
X-Received: by 2002:a05:6830:6515:b0:7dc:e53a:638 with SMTP id
 46e09a7af769-7e3da0a5633mr45495a34.8.1778614307318; 
 Tue, 12 May 2026 12:31:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260430-apple-compat-power-v1-1-0889d4334a7f@jannau.net>
References: <20260430-apple-compat-power-v1-1-0889d4334a7f@jannau.net>
Subject: Re: [PATCH] power: domain: apple: Add "apple,t8103-pmgr-pwrstate"
 compatible
Message-Id: <177861430667.3279584.5433065862110522961.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:46 -0600
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

On Thu, 30 Apr 2026 23:31:28 +0200, Janne Grunau wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pmgr-pwrstate" anymore [1]. Use
> "apple,t8103-pmgr-pwrstate" as base compatible as it is the SoC driver
> and bindings were originally written for.
> The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
> compatible as fallback instead of "apple,pmgr-pwrstate".
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] power: domain: apple: Add "apple,t8103-pmgr-pwrstate" compatible
      commit: 39117feb21a357207c29490b679cfca0fbbd1a54
-- 
Tom


