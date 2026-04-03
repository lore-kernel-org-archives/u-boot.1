Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72924E8538E
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD5F84189;
	Fri,  3 Apr 2026 21:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Odn6jtGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 860A083F9D; Fri,  3 Apr 2026 21:47:20 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BEB584101
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d86eb7c854so1162300a34.3
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245637; x=1775850437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7ROH8XT6g+5qqx58nEM9DvQAgwdCI0AeVgVkNIkP5E=;
 b=Odn6jtGp24ILdtd9jKrKRKyQW+appZzc+aPjkiXdfyo8IPie0pwUr/oq4Yv0fJBB2/
 DC3waZ+bzgggQ0xp8BOQwHjbBCljTiTTa7CRKDrTtZfm9PpcdaUY5wK/czbGe+PBotwc
 7dD7VGef3MmXALkxwjj2IDq2J8RWEaq5HsNZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245637; x=1775850437;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r7ROH8XT6g+5qqx58nEM9DvQAgwdCI0AeVgVkNIkP5E=;
 b=KzeoEiShnbz+X8gHbgosx9Vx36GKmEVMdT1hiporNEIj1lTTYHemeuOmG6DTUBr+wB
 lxgWjhbjFiZEdywsmso+vMs934LGlAMN+gLOMNZMV024og25f7wVY4mc0AccaWh21DSN
 HF1WtdSEkkNpz6/+DJ/JYVlncVO4SKjRYsEPGQmy4CuS4TF+zOuHv1im3ISbXeM/O4b2
 XBKg/rHz2xDzwBz8ZQV6DPbNNNM8FUenqUTthbkfXHyE5efHMmcZsmoUTY3tsvTS+k6h
 k/p3DKG/JQXtHznlkuusumb1DoB9M3lCQ0IA7oL9D2eFQ2NZkosIF0jisfLyULsmrY8q
 oYcQ==
X-Gm-Message-State: AOJu0Yx8syvKf/6xTnexGm2to9UmJaxBCxJSfpArOooazITY2DdBJHc0
 UadvWobtSMZBGM6PMYLvihTX8z51ylhm5wMZ2eplRWbLTjjkYZD+CmC8wmCFnm2Ldig=
X-Gm-Gg: ATEYQzx8Xyp5TYmkdjsFZzrHa9w0EQYcvmnGLi9rE9c5E3b2GjqslDBP5jcDQZ6cHKU
 BkqzjQdHbIjZU4sTvYyqRIURY79iYCyll92R7d2AV3zm641jpFpVWpzhWtN6pEiJi0+jKUFJljI
 wfV9DWSnm6QNf2lU7ey7zd51ZEu2//AkNNpWcYQIFQxWCAKahjszb9AFrWpxZJOGkDFLcDxURXY
 p+QD1XJAjzsMpBqkN0VUqk8u7L+pJf+6bvC2zFooZ9VC3sGw4q5iKLgR/3Vsb/cFJwIVKEPlZAK
 gRm09oE613jkv46KJmiMoxxmJEytanx6FyGu7W3liIoqpWrgDqmALLS3UyLFz0UHQ23dJYU0N2e
 x6dd/BPISSH9ranXBD2hvgBYeFQpTRiU8bO0IMStaShmpDVgeXLHxQh1R4tn+H6Q40xLfjRePm6
 pvWchku1H0A2i4EPMDN7RB/+AkWFQ8BCvwt+KGDoYVfSNPv3nIJ/P4RPia8uzSF1wYYnGpxxsnc
 fLzuajQC2Fkj6myA+G4MBhHbrhw6FPL31G98Ao80oW586Q=
X-Received: by 2002:a05:6830:3783:b0:7d7:ef35:2c4e with SMTP id
 46e09a7af769-7dbb7110fdamr2572240a34.15.1775245637161; 
 Fri, 03 Apr 2026 12:47:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205334.3788743-1-trini@konsulko.com>
References: <20260320205334.3788743-1-trini@konsulko.com>
Subject: Re: [PATCH] rtc: Update Kconfig dependencies
Message-Id: <177524563658.2281750.15289643085956757063.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:16 -0600
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

On Fri, 20 Mar 2026 14:53:34 -0600, Tom Rini wrote:

> Update the dependencies for RTC drivers which did not express a
> requirement on DM_RTC, or in some cases on DM_RTC being disabled. In a
> few cases, when DM_RTC is disabled we also require DM_I2C to also be
> disabled or for POWER_LEGACY to be enabled.
> 
> 

Applied to u-boot/next, thanks!

[1/1] rtc: Update Kconfig dependencies
      commit: 99bc9d07b7304f9db08abd6c86229043441ea0b8
-- 
Tom


