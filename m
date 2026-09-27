Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079E8C9832F
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 15:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9D308101F;
	Sun, 27 Sep 2026 15:02:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NgTyTDF0yi8w; Sun, 27 Sep 2026 15:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0960680FF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521354;
	b=pytz/jt/rXGMrGJkrD7Si6AFRrWlzcNhrOl2/HNvU1Ta2LvSPN8G4R4zemNdBnyllER1
	 +NP4AYVtbIuIOjDX/D4L+3ZZB1pUI/xc58NklTpUBmsjplpkyNV582PXedOjSzZTpDN90
	 D5qHb3euYIdCBGEUF2Cp4ETiLSdz1eGIqZD3U/MBO3ioTSo48qwR7A5Kgh6nJNnA4Y4ap
	 evB6sBQSm6dgKDtuouR/tjhA1GgGuoYleu79/mt8Hjp2HFMWVZ2iVz3AmB4PWsL4SwtxZ
	 GwzH3hl/LX0lkHGX7X//xo/WuoKldZ9O4tz3eh3XP+pMQ1FQ/2H+bTu8ip1sweEuorg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790521354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=gsSC0Hzq8skhVdbJmHgw6VwOo7kTfs+SfuqEkfXx/M4=;
	b=gctYJ0IO9b8/7melWZxM3Xf+1g+wxDrZYoB5f99nhHJuGGbPcbXFi5h1J9ejvUvYnnwm
	 5xcPZUUkrip37qbmXOKa7in7Z6hHNILh+Favf/P0W+D/eBJJ1Qbcr2bIn0Te+VnA91fyE
	 JOGe8bBNuajsGdsihsGZSeRrm8vwwMokEKEmM570lbZOng43wg4G4/uPj3wwJ59A3iQjN
	 NzaW4uERhD68DxFkK4kXB16VLRNMYyYtwGLutL4mIZkrxM12+68/Rbp14eK5K1uKFVxJE
	 b96F6JiYl2PsLa/txqbcgaKJM1mpAgkBNmMpKapiAnrepsjQc1+aLDz1Mb+RdhiTK1g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=StcdP2wW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790521354;
	bh=gsSC0Hzq8skhVdbJmHgw6VwOo7kTfs+SfuqEkfXx/M4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w6NmktGBPgO1XsQNz47agiM6NMmj5dpDtEAbQVmEGU5sezUL1ttQ1fxHzRUMyVXRr
	 t+4ig5lsOZtkLUzAe80lnpV2Hr68nJ1qZj371x85//ut7qiZCGD2Bc1/3KONVnRc4f
	 hZNOu90vG5Djpqaj4zyQUxm/4rnb+wt4bqDuDthWO/dw35Y5zNXnaqITqd+Aju0rRM
	 kxCjqiEteKlL5MayvAavr81mp7qbkqMH9JL+HdBtC+Thx7vp3K8VJsZxIyD0OpNW0o
	 seRNiAa9m6jnTQKH7SnSK2EMhsbSlb0aCnMjP3YdOV+lAJeCN9NBnO4jXo4zuJfFKD
	 T1ko05T6BpczA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0960680FF7;
	Sun, 27 Sep 2026 15:02:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D186E194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2B368100B
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:02:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rknY-U5DlPTa for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 15:02:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AB85780E12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790521351;
 b=cjleuw+Jb0fHIVVHPXwccmTH08Vv/eKeKNaqf8HJOmqllK+z4xfJCOHTCYC4x6VwdzV2
 MqbiyGZR+iuKDlUFGCBcGiFAaTo5Z0qu7KgfCGV0KM/QQRBcLqi56GDKgwOjniXZA95FN
 b0tnDjjMvr7lAauE/GFJSRd0GwEJkyEIwxC91/z4IYtK+X6guBS5Y8I9x5M1oAVAU5BRS
 3ope6MJ218yVVZJP2fC5BsToML2YCmuPCTjvwhKpVVsVVxyHiUSils392BJigxGgFOyk0
 q5wkFNTFlbK70T9NL46HssSgI8b4VuC0XIsMaB/Sz87aNGtVkbMz/Xhj1yr2tmQAUWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790521351;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=gsSC0Hzq8skhVdbJmHgw6VwOo7kTfs+SfuqEkfXx/M4=;
 b=boekADKdP33ySR2YmGHrYPqfVhpXxZfOBISQCfLcFaBi14Qhsrz5jfSimiFTpgBZbUX5
 RZZag4scQGg44Obd06TMdvGMxa1gQdl9kqFByNCk6DN08swRnWwGbDA82ykeFY02Utkby
 p3lHxFFF6W6SOEgz+66mxxf9UpbYapM6sH+KUMm1KW8FlnfIchDGEjWUTIk2qpLbN+1fk
 CpLFHmtJolT671ayI5xqdPwhfws4ri3ntk/OoQzq+DawTwf42TlACqM8zVEFznimFAdOf
 iQo1EeeEPmjohhV7TVsPmDolSupULQ4Y2SZM18UsapZRsR+FugfFcezv72IiVeQukWA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=StcdP2wW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::d;
 helo=mail-ed2-x0d.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=StcdP2wW
Received: from mail-ed2-x0d.google.com (mail-ed2-x0d.google.com
 [IPv6:2a00:1450:4864:33::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB85780E12
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 15:02:30 +0000 (UTC)
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6abc27842b6so1216269a12.3
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 08:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790521348; cv=none;
 d=google.com; s=arc-20260327;
 b=FfmukMipdDgJ4pRWNIoLu1QGXWIXlRfO7Bz1vL2bRA8h4KGDVnasn/SHXr7j+Q86xD
 5/wWELEWAa/6RONj5iW/51vw5Vkt5We5n7QLdCHOuXSLdeVZGF6PUk5l3jMJG9QgwKXC
 PoTmp8E/DHH1kjaasm2UbjLzP1/bgTPe+C6SMdZUVwynd/kKVU+BQycwEZ17ui1/dpvR
 pZzyJnYjRquS3H5zaHvJqW0plO2ajiboMV1dV0A3m+q/h9/GJUHKMshM6aRlKaLd2G0v
 5r8S/O4YTUyf+4NH/8A5wnuxhjcG0Cl3S+B/E3+3wB5KJbzCqHjdmXCFBroLp4YYVoh8
 LHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gsSC0Hzq8skhVdbJmHgw6VwOo7kTfs+SfuqEkfXx/M4=;
 fh=jqjcQu/8Zv/DoAQax8D9QEipdR7ikobnct1FkyP6pJA=;
 b=EzCWYHaMVHz1pkBieGcP9gHuBIiaP+Zr9TYRVG7Dhy9l8LHqMPsECa5XDzt55l1GEn
 A+nsxgCwL6SyiLRNnUbZmOl6aAXMtgcwtb4GcUnRu76gFneB7rVe/vVtOWJ2irCVmlpe
 8OKoNJN8K0i7WOLPyQLmvnj1JHroc7enjR335F2M63UqpfQuU6nGsobaMeeBrm2/M9XQ
 UkGeoKllz1SNjCf/p7b7wH+m0rNoi4CqYvYugSNuUd1PPKUiV4pOEmgsWvKFp/5N7tOp
 8CblwjvPKapz4D50ITLP7wo62pN3iOZZKggRPWChFpkFnd1FroTHrJveLONOj++raJfu
 kjBw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790521348; x=1791126148;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gsSC0Hzq8skhVdbJmHgw6VwOo7kTfs+SfuqEkfXx/M4=;
 b=StcdP2wWxQLzsLq6izK3TBxYft5fdCpBTyx5F+Gr5ZEvouFgAjyDZXu2TfoFWzFZvg
 EGtgugETQQ3r+elUAmvE4cCJtdJr3SBRP3rwRIGcjXCe6vyJCsqW3bD09ew2UVkSy9Js
 7PlyzAm9susqyq/ITC/Jen//B+niEhn4F84ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521348; x=1791126148;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gsSC0Hzq8skhVdbJmHgw6VwOo7kTfs+SfuqEkfXx/M4=;
 b=sBNHXU+KVGnDwgj1MaBFxn53uE/hJYvZK9yvRvtr4Hslaea6FT0YeZve2K3Nz8OFby
 WTFOY2Kyw7aURRNy9dN6Gq71wo/23jS9MDxrraBsVzNKLWKy/81ibgcv9Ry116xbReQB
 hwQe6nW5AfsHQIxkZsTRxWe2Hu+ZiNeW6Y5gBQM8SpGf7olqSWlC6yyyGhHc9MrbX6IU
 TaULW0cOcK8INdJf8vukN9DyiD+Rj+aHUW1fj7SnbuHB0/1exo/IcPE9LPANUQJPIe4R
 FinCzJu20ne7iLjI8dOfxxQtSipu35FI7ySVV0ksNa9HOvLZyqfrzjr1q1n4yKyYS2W8
 7EBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSHDOCknwX+FT7Hi6UYKqRxZYHvyL+kMbGrM31ymgAtA/c7ao2OVbntAEj+mGP+oWFrhfkv1g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIelSbG8RPkh8TfhSvY2LOCyKBsw2VqaUVkmcw9fp6PBHfInZ72
 j1DPyKrm/zRvoHmYdM1HDsjd7LUp6PamOaycDsB6qsLpneF/S5IwFBCstZ4tkC5j6m2oLr/60j+
 IYhw3p1EAHG6Ji9An5ZqYoYBS6hPxoYuQkyfhs+Hc
X-Gm-Gg: AYBFou0KICtxCF+/VA4qYLvTuluBNPKnnNSX09crW0rLyvKrJkSwD84c8PLqfmg4mk/
 Xz4jFOwelCigTVrluinU3sL0Dxg6gMUMXfeUXjIgLTIGHv74UF3Z3ZJZNdhi1Uxd+iBOUtIPYAI
 qZkbwcmqnZ65VEGKlf4mR2n3dPW+R6v06TnhPyAXG6ZrQIw1gHwOYhrZvg7Dk+Y3F02lUW5cqGU
 hZVoNEfLHONZzGGyQ5REq747UneOfOUWHAX9JC8QOBLo8brCtTQ99yFYqfymXc6pk00wtMYD69l
 mqbrvNxs8GOnxUMawIM0k67lI2lDd1JF0xUL6HU5CyxvR7KtS6u0mA==
X-Received: by 2002:a05:6402:2082:20b0:6aa:e37e:92b8 with SMTP id
 4fb4d7f45d1cf-6aae37ea7d5mr4515366a12.16.1790521348344; Sun, 27 Sep 2026
 08:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260925105432.0F27E68C4E@verein.lst.de>
 <20260925105619.991CE68CFE@verein.lst.de>
In-Reply-To: <20260925105619.991CE68CFE@verein.lst.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Sep 2026 09:02:16 -0600
X-Gm-Features: AclHuK-PGMyoseA7n_Ct7ZazORKlY5dzBsRiTjj8tijvBOZV1anIGx0l6Q6Nkzo
Message-ID: <CAFLszTiM+7vrjX6oy_KDe5T6SqOdbx51zGT4A=5iZYZp-wjNOw@mail.gmail.com>
Subject: Re: [PATCH 3/8] configs: enable NVMe on RPi4 and RPi5
To: duwe@lst.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Martin Schwan <m.schwan@phytec.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>, 
 Anders Roxell <anders.roxell@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>, 
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, u-boot@lists.denx.de, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 2026-09-25T10:54:32, Torsten Duwe <duwe@lst.de> wrote:
> configs: enable NVMe on RPi4 and RPi5
>
> Enable NVMe in the Raspberry Pi 64-Bit default config and scan for devices.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Tested-by: Peter Robinson <pbrobinson@gmail.com>
>
> configs/rpi_arm64_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
