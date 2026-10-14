Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BFCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:48:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D35A80E6B;
	Wed, 14 Oct 2026 14:48:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ls3Yuil6wKlk; Wed, 14 Oct 2026 14:48:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C6B2980E33
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989323;
	b=XEKo9sDfGB9FceisIS26MrrHmjN+iKMyH/+Eyr8p6sI4LmPmZk6l36r2J2snOPD/yjH3
	 Cye/px/iCJHpjdvRm7K+/Us7BEFgUFeUMC+8KCSa3dBYIfinOjX2Uw5x6yzB09h0kPt3E
	 pKOC804C++AClriStxZeABetypq6iH5ldc0irND9y1N4/zHfJ3SwlW17NLWlglJY2Oan5
	 B2+h2l3H6iJeNosC4ocSYfH/zyuzzOLth8lHhUgzgguojoG6g/KqDa5eabAEgGeAg6/Ck
	 ReOvHk1sklEWWXBDkC29td9LBr9Uw4XsA9Ru6AmsT+N85GFXAOzoHM3xF422+Gvk/Og==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791989323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QuQCoIFO5S+67VtfxFrE+yxpSKgXo3G65TBj5MglsSo=;
	b=a/HUstxQIy6LhDBJKEZ2NCMhelLoaGrSXE8rp4HPOp/okmluKHEsb96MfM92AZZx5gOn
	 IHCcvhMCQUIdQ0LTsrXzgjfEPjfXhT6G7J4OcyoMtoejf8cyPtFfQqIyrD2HYyw6ci4Ys
	 2vQgVoyvF27wPAmEEnDgsQFPmuRPi1Iir5RhlDPoJDiz+VmYe12Jht2VQj3VUlGT4oUW5
	 gzFM0xH3dA52ibiQYUkby7K/G5fu0QV3ej1JpHUvRudVdy0L3AMapxMfovdWpzICg+tBf
	 +Hj4XjYHtUgUNRoz82E1BOg2fxW0pIejBNKqNcOZaiHBGjZcgZ9TfQHsJX6bbzSK1xQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791989322;
	bh=QuQCoIFO5S+67VtfxFrE+yxpSKgXo3G65TBj5MglsSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EkxGEXTCByMjqnpINenQQqJJGv116v7sUChI/vkNUw1yza0dmu7Rad0BJ5BbRn82J
	 jDpe10F56L6KWWeLtnAAPhBYQA4Sc2fGUYYzY+raG8+mT7kNLjEhHIoROESCSsPvrZ
	 goBFubOIFFi/baufbEjmjBSmn/lntV1vAojLZOdh1Jdb9GVgHIet7/+D8qenAyJwpK
	 2ZAQ2GW2AB7Vm27iDcOdCu82BQ28OrWrh/1i+vhAODbj/Mg/Rk8R7bnFtY8jw7mnMc
	 KikGK25w7+hz0d/0N4W19zInjSskRzoUR5wKyG0yjkJNNeqwFcNP1Ec+kXO240UP4E
	 RQXMUtU7MprDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6B2980E33;
	Wed, 14 Oct 2026 14:48:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 70420255
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61D0640753
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P-yo14c6tSas for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F71440752
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791989321;
 b=Rwrv5ueIJmIwJTatdIkwOIgpdfOAjskvDYMi3TCSOe6wTNQKNryiSJqaS9Y+f1mW2YMr
 ie7cgM2DKPROZCQEEtpT65xHQjaOagr15LTtI02u2+Fpjf96wJ69orURNt4Lxek1D52u+
 /+PFoeHZ0rAXuC9uJIgFQjMUiS8fvUcgFY8vEullnfVxAdLjHrUZZ5THtxoZXhkJW+sGE
 k2qI9apDl6XmrK7qjpuHGHSvHmBKCZ8uI8d+B9D00CC/Zpk6U/auKMdTi2MN1p2q2yEzv
 /yLZ2UM4NnTKfw4GKC+c3Zzg19AnWEA2AKtABpw4yc1SMVXT7kPPjeZjvaVQ082188w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791989321;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=QuQCoIFO5S+67VtfxFrE+yxpSKgXo3G65TBj5MglsSo=;
 b=TT4HOodUPi5VUEK1oVnxosv7RA8QyAvY7YCBrvgM3/OwTfeIUVimssUrdwXoZ3G9CrsZ
 3ngGSwZ9LYOh0WqAwmqXnp0F+eQajWPNJStZEEW1nXamFDFxC51x+7jNrHz7yTHw0egdF
 VpfeTWuEon8Cm1kxAayjD+aS3eE694yyMv+3S0Q8UgoI47I6SOTjzxiihQOUrg76b2tpt
 Vinbi923hDyeU8rV74uDSXC0KZ3g4Itv+dsRWEXtxDDxmW+6saeGhwcSctNH7kTQEu84B
 6lXyhuZ73I1XqlnjZfmGXjQ7hlnr6rO7xGVPD8HGI4X7KnN6hH1M1/2ogJ7bGVpcBxg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=lgta+v07; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=lgta+v07
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F71440752
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:48:39 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2674517f8f.2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791989317; cv=none;
 d=google.com; s=arc-20260327;
 b=ln8qK/kWmc5U+qXlNY6HJXMPx3aUASvx0UgQVTRovD7F2vyqAumhC3AZv9wQZABMyD
 JGjf34ZtgHxKRxT3bASwG8l7o5JwOH7umg59qyFIusfmwpJc22wa+AjDOIXhfmIgYCg/
 mWxAawN4k0IoIZoCve9xMQyRK+XTSs0laGE7i6936pCkvl9rQDJfyT2CRNNTg98m1D39
 iK58xsXBs9PhGoXRJWHwgCCAx1MBzNqHnJyY9Ds2Izda71bRvHyfhuIcPjteuVdPgdip
 h/z0zbkyaGr/uyphhXUzr16oQ1HjDRi9iWxpAdx2wifQmDevdl0uduoK2q44YO9+9nPE
 Pv0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QuQCoIFO5S+67VtfxFrE+yxpSKgXo3G65TBj5MglsSo=;
 fh=m+qtl7Ul2sjmxu66NvzHolC0Pa/mOnfSvbj8q/47ies=;
 b=UghhHuRvyrSxATejnIZPdWuFHVf024CM7ylfhS6KEF1fPebqD9568Dd5G0QVEK9hNr
 p4HjmylPrXoGnpy0MZ/ShWFZBJJ4eVHUHMG0n9CGVOMZqsZm/+qguOohnP/x4XfUc/79
 PhcGq9JtomerBm3FqjS+qQq3J3YTl70kogDDie7DtJZhx6YW4/REvAJ5XVypQvipaYCF
 YIdE1vPvIwu7lqD+Zk7KvLrHpq75NxwavdUy1JSCyur5DIr1Y6ZD+O5o5tpjCjeT+Z5R
 QcS3ghqWNfW3sV+d9ScLza2RvFMC2hH/FaTbdwmfMZrWDW0aqxFMNGkkC/FP1UHS9Z5O
 sxVg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791989317; x=1792594117;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QuQCoIFO5S+67VtfxFrE+yxpSKgXo3G65TBj5MglsSo=;
 b=lgta+v07cWY62CSB8xwIFBRa0e/3je93n43WDFsMkXBECv2Gcvyl+GWSIXoed/6d1y
 mr+qSBUDd6gyUMo5xWz6iHltR6IfiuTK1UtW00lm1O+WJtBd7yYCAjUjVI0nmIqUyqxU
 URXwk0Olh17voRqXpcsC0vJxwy9STQp+PLwuIOy8iAW8gozfwYj0csyZ30SnBUE8YMUt
 9Os8T1MhnHWL45uEqja0e5j9g1lYNfIMGjkeTu6jffooBIS1MeyE5yQg5tE/h4Yk6Pp2
 3sSRyj5ZqGK3C7abuFMPOp8bvUkZgXNovLXXC5Q1ZYMhDIstklgTRcrp37aeOD1vMuhw
 YgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791989317; x=1792594117;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QuQCoIFO5S+67VtfxFrE+yxpSKgXo3G65TBj5MglsSo=;
 b=Gk5896IlESuHtF5jwoAt8/f/yUPzPVUgsHW8UmYgroKHL88/suDH4SMDS7DWPE0I2i
 vjCF0WaVLsbO7+YODbrWWksx0BCUjMW/mJyIXgBw7ktUtAZ4KE4K4gNCHA9mhN5o9UzU
 ggIDQ3QbnXvAd7EGr9zk8/rlFbHH5jr4D7hYEu0S0Hz+7pmMBEb4kAFTe6ENv914/G6i
 j/SiETGKg48E8YyfuqwAK8ZFQWWZfaE/C4b5T/efV/US0aBKGw6GWfN7X0VwUdhA0MZh
 RwbWzGh4PlELvfniZl/fL36Uo2Obk48q+CBXf6TJJmQ5Mv9eHPO7Zzgilh3eh6ZPIdwp
 7wtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwkYLXdKuSWX7SLtRmTFZ8Nvhi1PVw4tkDHofYPjrJm97SD/beQS3a3DWCKwTFEo59Wv9K1J8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIb2owBmvK3Bc3L35Vay1O26Ah8NnRjSJtr7VnYVbeL03/ZQetA
 YVsA7v3Pkye0CeJz5y8xDBY/M+l/jU1UzhrEdvNqd7Ne4NxbV+SoYWVeCQgkgd/e39/apC374YX
 5pvfJMK5c8OHxXIxqOfWvc+GVtS6qJw4=
X-Gm-Gg: AYBFou08GVk65HkAZHlk1T3ubiwy4GINvpclmOjEXMB2oO2uFXHTvKlVrVRrxTlOZKt
 07+bkEzhI2EYbjuN3RcsTVL0KgnvUHe7HY+QiCfhcLYnSL1Au5YxlR3cBGYoZJjsu1KKdQpT9yT
 ZUo8djlYxlW4aLNOxtSHxr3Bj9sg6B/VOalDtdqh0lLFJcTNPM7UiI7jwCJT9vtVHEJoo6yaIE4
 W8LJ5gL6t6O9L84d9ZhX8i2EppM1EWuHsJ5TGBb1vC8dV7gBcWm58P8h4cY/LBqtBCw3gHc/tJ7
 n5vxG+xDymOZ+4fKG7NpcjdxF2i1RfIY/DyTC//y1JfA0w8ZC50MGSph0VSJeMxEahauGRtc93/
 xXQCZMaP5E55McmQ=
X-Received: by 2002:a05:6000:2303:b0:48d:f102:abaa with SMTP id
 ffacd0b85a97d-48df102adbdmr1489826f8f.26.1791989316946; Wed, 14 Oct 2026
 07:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
 <20261014140716.1181882-3-alan.tseng.cs@gmail.com>
In-Reply-To: <20261014140716.1181882-3-alan.tseng.cs@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 14 Oct 2026 22:48:20 +0800
X-Gm-Features: AclHuK8U9CFSA0yN0v4u8YLT7Fk3yd8sv_x7afqVn4jDOUBL8TWMR-7oPndROIg
Message-ID: <CAEUhbmW1-HSapP1S-wmxOi-bAGmRADnMmJ=2yG269032SXa2hQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: virtio: Mention the RTC device
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 14, 2026 at 10:07=E2=80=AFPM Hung-Chun Tseng
<alan.tseng.cs@gmail.com> wrote:
>
> The list of supported device types still only named network and block
> devices. Add the entropy, 9P and RTC devices, and note that the virtio
> RTC device needs QEMU v11.1.0 or later.
>
> Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> ---
>  doc/develop/driver-model/virtio.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>
