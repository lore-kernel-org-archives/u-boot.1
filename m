Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA392CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 14:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6E284688;
	Wed, 13 May 2026 16:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="H/SLgeu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC24C8460E; Wed, 13 May 2026 16:05:33 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5FB480F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 16:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-393da8f389bso69209951fa.1
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 07:05:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778681131; cv=none;
 d=google.com; s=arc-20240605;
 b=UAiLNrWTbNIQ8XLTar4MI3HzuYCzW1vN8i/+qtTimoYvBPv6gP+eFyBwT17BThX2kH
 TM+Om/NihywNrNlJVSodInNA3RqNdS9fg2QzuGolkfweO+bjKdqofOpJhtEPOr3cJifU
 n25AMAfgWiqb5VXwKO/lhCdckNYiXBb8mRWoZS+t7syEa6jU0RxQvYovHsbrOD2U6Wez
 9XSBNdoNcs+L7DKtvKh/7+Sb/aayJ3caJpt5IKUAp/J59OtH2+GF2fUDMlAxnLdJVN6h
 F12LVm2YXjil1KN6O3Xp56ojjdTZuPnRSh/vopHuUJ3iH5Mf8JB2Y4UW5Bc6lm0wOjOt
 MoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rKQzatD/o0LdgFG6PUif3FrbRHbZN6aZqoMEcOhmid4=;
 fh=o7sUg971Ngl6mgo5MSxn3xSPCveE/PUo3diUxw4WzeY=;
 b=h/SWKp5OlwtVfe3aHoEcxBTCDmp/fPyoSlRMx+iuiWancOBwu7WQ+JQbQpHWRoF6GH
 wpkjPvS8rhwgo5j5cXjanBsRQo9smxzrc+r0XvPNuNQcxNQ2suwadf7qYS0Wcr0Y8d5Y
 tE5FM9FBe1fc0GjDeOZyRkwpsa0+3bp7Omb526kBan70aMUVHHytOkYTTBn+zPCwzxUi
 kV3iaRuMxPy4NKGwGbCWh7N4oTF39rwUHu3vOgYXtYRqkjQvKDyoR7rbhZJxQ6rT6dxc
 8H5A49VDohgq1r0RluKFDCCBYfz86v5kgs7gQ9kuwdqrbJDoKp15e79iFhxpedetZ8DO
 8PCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1778681131; x=1779285931; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rKQzatD/o0LdgFG6PUif3FrbRHbZN6aZqoMEcOhmid4=;
 b=H/SLgeu1aHu66PPAurjDmdyCVxuWU3aJYSGU392L/tRlRYaldJsxVxcvChq889wiE5
 e2cRn7cRg/JpmVCLP9ysvTuJXOQ0GhVG8aeBD5WWjyUhnW8HJUmnTH4nhe3/0OsDgtxb
 1+QUkrFhL9B2nM/a2MNpI2K1IhBdc5X/3sTtcjm5Jl2GnQupy+Omehd7+UZejz9/JNJ/
 D/DHNKQjiB0yD+Hzq3JNmBYnb86mqK8S6MNjZVBdBtzCd9EI5f+Ihm7M6ViLBKXQXbYp
 EqhBnvUq3X41EQG+8UKAJ9uy+MZ1SMqj7H0dxBv3grG9QAgo8PMl/idA5S6D3MmEEEWD
 Kbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778681131; x=1779285931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rKQzatD/o0LdgFG6PUif3FrbRHbZN6aZqoMEcOhmid4=;
 b=kDm0gcheqzqSE+tYv5A7V9hn2peanbKxnfJJC5kID/4ZdYC+ZQ+nuVaMXUASP0MBWA
 B2sNhl8hHHkK3WQcAfcKGEPxaas0zew5LQmElufVweJde/gHNklqkOmHoGGPjFLfi/AV
 rik1GapMxrege3/GZAB/OFqCeIqqI9oQy7OqFZZcT9sN9E3PF3uhxETJyuM8M5b1oKHK
 sAUo4U6q7UlJbSWCjzJqVgwWcRTGZsg2yJ9zSZslnyiujfGCLvK7gLCUgrfeyuotmxcu
 BXMJH3oqJhWLbwJDO3rO1emdScDdZGQfBeyCoq12hfFRFyVtOeue/DSPIohAAzoLrHBC
 eKZw==
X-Gm-Message-State: AOJu0YwNE9aB7JJqUga2RNKzmGPSftxngUi/7NdEi50fDEmrr2yAdgGQ
 GKAHwBM3iBF/MsEd5rxfhBBpn66WjKW+5g1Urf6/EjyZIrUF4OwzMGehFGrci7ucAE+SQ2UfoYS
 au2vPdcuI+T+7DuQG2F6swKcEtzsmWjPn6I/NNyBLWQ==
X-Gm-Gg: Acq92OH2OFd7Dchk8e+GvDzNv6q/CjxgwT9Nm2Auv9Y+qvyHMff/oycKRQgNlXermot
 03goLymZgquF8wiI0yqPCupPlup0UIhd7bb6xdkXIPbDKxLazsOxJqU64+hFFamsnUJaTCHGarY
 o4BTNWo1U408BIbPixzTZ63qneREQlmVmgM6KvR1RV5JHbAvmOwqVBau0JTedNNg58cZinzUYEt
 K2GZmnhBcMwHXOcNhPP5YSr0p9A9kPTf6Od3pHjY+nkK4SvRxwp/VGuSEcNd6SEvZO9PbeSvN89
 wi8BG2c=
X-Received: by 2002:a05:6512:3ca5:b0:5a4:6f3:ddd with SMTP id
 2adb3069b0e04-5a8ef93a9ffmr1226240e87.13.1778681130818; Wed, 13 May 2026
 07:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-udc_ep-v1-1-8a783e44cf7f@hifiphile.com>
 <87h5obv9go.fsf@kernel.org>
In-Reply-To: <87h5obv9go.fsf@kernel.org>
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 13 May 2026 16:05:17 +0200
X-Gm-Features: AVHnY4LS04WPZJpCyL5AioNPTViqSMBIqUUm23KIvvlveaRZe9PVNvqEsI5tkJA
Message-ID: <CA+GyqebQKevme6u+tvp1LCKAhVxsSuKo7PQq-saQOx3dTBZ5hA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <zli@ogga.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailman-Approved-At: Wed, 13 May 2026 16:39:21 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Mattijs,

On Wed, May 13, 2026 at 1:24=E2=80=AFPM Mattijs Korpershoek <mkorpershoek@k=
ernel.org>
wrote:

>
> Also, I believe (but I may be wrong, please try it out) that we can
> maybe remove the whole if (!ep->desc) block from usba_ep_disable() since
> that should be handled by the enabled flag wrapper introduced by
> commit 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct
> usb_ep")
>
>
I agree we can remove the whole if block but it will desync with kernel
code.
Do you want me to send a patch ?

Best regards,
Zixun LI
