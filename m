Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166F4CD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 16:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E15B8498B;
	Fri,  5 Jun 2026 18:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W0mtnJXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7353E8498C; Fri,  5 Jun 2026 18:52:42 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A0284987
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 18:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-3967725a77fso22092491fa.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780678360; cv=none;
 d=google.com; s=arc-20240605;
 b=V0X87a94X1FAk2O49jGL1kLn8AMauGwmhGC7XzUHk5jjIZ05+QwYZRIJEcV5fo7r7/
 Ynp787pjCJkPwCMs1bMcat2eCNQcE6s6p8R3ZU5l07JJ9q8i4p1KWOaanqn2u66VyRHn
 XbXlSqjDMJoZ2FzwQbt2aSU0EKV3EmAIG44pRcfRZNPvt8EN79eyYAGT+fAwQxqUQRob
 3JP91WiRGmoAExNS/pSjtVtcW+Okv0Y5w9UZXKm83cLxnCnrNGSNRnOvRzSXuZkq2ADq
 HUGnkvVCOKBfZYr4MOwVzyvjjbaLI1m+q7KLovUOHTZ5siFfX/dY3oJKrQucye+SNY4G
 pXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jcE1orvm9b5CaJm9eHtX/kGtogdEFX+Xm83VVB1D0Hg=;
 fh=Dm+MnoalM0Vy6VtubB7GM3vWRPsE9YYIdjIElyZRplo=;
 b=aIhDm9YH0ETWc5ukViKjjCBV5GWve/OA4vpHagr/eo/OSTqwDr+qzy2n+3BCOZHRI0
 ZXSZrXUzpMoqzwMkeNtKeQSxNt9Qn8iTEttmHZ9ZOkUNXLyuUz3RSHXcOKacCq24wiSG
 udpOzv4dnipT3enyY4lby+cguNmcVToIJtMGiHQi5Y/ChxipEvufw3TIXEBmMm7b90jC
 gQjpA+FcOOQ6M9EALlqudPdwwCP2mMuodhq8VAa24U9C3FjKCPHxXfr+rRQNsH3wV2FA
 mUNGma+ReuS8NZeibpQuO8Yxi3GmVcF+52d2UGJeXqvnDrnMCB694Us/EF3ZycO8UnX4
 CAAQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780678360; x=1781283160; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jcE1orvm9b5CaJm9eHtX/kGtogdEFX+Xm83VVB1D0Hg=;
 b=W0mtnJXDqzdbMjJJlAkrF3mWj9gewlonbsgXk1pASCLlSdK2vJBdcxqtvqL77MzLv8
 cqrYkIhT1n0mwE+Th8yATFiExue00RdunkPdbjUjv2rxr4Ob/hTMh095spvutz8DSjYs
 Eb2r+6Stfe+14YREhNguVpnVaQXPRixwm1wsPbKQu6aZ/NYHA6esDC87UpeFaLXXIDLi
 lNS+BnIWHSChC+t3xH5sqb1yG/+X9EWvYElwEaCEc2Rs43ZFYUthF4PSkTjKiXoDCcFF
 4JpPkHRezfGZR5mIMsYzFyVKOxwb5+RI0ZPkHr7IFaEE5NfZwhiZErRL6HE31xM6IyZ9
 PLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780678360; x=1781283160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jcE1orvm9b5CaJm9eHtX/kGtogdEFX+Xm83VVB1D0Hg=;
 b=lbPZOPBitpNCW1YSjQXXaAGOS+2riJ2pwkVHBNBkZyoBGfEXutIHD7NlvsRFlqlysS
 BjpsFnxTqLIqhifkqvm+2X90AsJEek+roAd8A52uj8kJiFj5u2wpw05gj2J6BZFqPWMW
 gEJMubuub5IVEWZI1wv3ZP7aeZf5H5KbBgIEeW+qYYXcU8+WVcBKHuY0O+UbSfqQcnbd
 n4I3RmoImNn9q0JAe89DX4QysGUJgNu5AwN7hEFTUDedbX73e+0f7jCiKMwsoLOQrqqx
 CeyR3r0Dny/NYcUlhgtmA1vWUJPT9J+73usUkMQRDUf/NzMMojAL9F+6DCla2UoMm9/7
 dZBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3WiOAW07zXcm2bY4eePwcjbDFNmasoDmzoA38nVNDxUp/U5HWsK8boO+u6PWLQ7OR82nI8ug=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1N26Ufy3/hWdWF/+wjO0xdERsJGdK0DoMP79kGf7W8GhBlzVV
 wNIutSOUikxR9A4ji/iyP6y8OinpT0hjI73F5spqJk9iiYB3ddgEE8LA2KgfUl32LGGzyqbfy/P
 lw1lx9ZcQnHrwtqHz9RrMb3NbqfSEKMY=
X-Gm-Gg: Acq92OFDImm30LMu75fC+Ia0zZaGrXon61TFEunc5y62mpAyoAQ/9srhYKtEs3X6BC3
 Fl0C1P9wrRCh+ATCW9eCZ6c3E21Ot11pn/UACvcCwA23cH9RP4Xo+vGmCqh9FAsvB0+7U35pJKZ
 GTKeinpezg+1WTMQe9CxbhB3BXSwRL8D++B076f/qN6+rbjzMuDcxuEZ89eZG35UyjmIxB1/oRG
 mq3Kgw+mQe3R9cp1M21230dQ0xooEftkE6e0ltwfblyxiybJ5dSzH41hO17a8Xu4ASfqxZRvV6/
 nNnftYszLMeU8Pig0ZBIPbBGdaqwuqwJp2tV2u063qwYsIrcClLw3hGP6oBD2jppa+HkpIKkgE3
 ro+t55w==
X-Received: by 2002:a05:651c:88d:b0:395:6085:a15f with SMTP id
 38308e7fff4ca-396d0800c3cmr13974011fa.9.1780678359409; Fri, 05 Jun 2026
 09:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 5 Jun 2026 13:52:25 -0300
X-Gm-Features: AVVi8CeyEf4mXqxxVXxu1eddtz9UZpxtQtHE7Z-hm3xVh1Rp8ZIVZZPBqnHxtPk
Message-ID: <CAOMZO5B8VbG8Yi4hc4XNiPJ2KK_Wo3dnsCr2WGBk4wv12Fri=A@mail.gmail.com>
Subject: Re: [PATCH 00/13] imx: Use livetree API and cleanup
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peng,

On Sat, May 23, 2026 at 9:23=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> This is a misc patchset mainly for supporting livetree API for i.MX9 and
> cleanup get_imx_type. While working on this patchset, there are a few
> minor other updates
>
> Patch 1: IMX_TMU depends on DM_THERMAL, so imply DM_THERMAL to make sure
>          IMX_TMU is selected.
> Patch 2: Update imx952 gpio reg.
> Patch 3-6: Cleanup get_imx_type
> Patch 7: Update ddr firmware name
> Patch 8-13: Enable OF_LIVE for i.MX9 and i.MX8M_EVK. With OF_LIVE, boot
> time could be saved.
>
> More information could be found in patch commit log.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

This series failed to apply against U-Boot next. Please rebase and resend.
