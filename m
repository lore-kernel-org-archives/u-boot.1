Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5BCC982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 17:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 985686075E;
	Mon, 21 Sep 2026 17:27:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SUYSGAq6S-PD; Mon, 21 Sep 2026 17:27:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A8F5560762
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790011672;
	b=gpVxmgnz2XdKZ2AMPyCaT/hP1WWfmDc8U5/h8OdQr73DuxewnItCiEhD0QdztoM1jMPy
	 bx0Lq9/YFZhvt5nL0QpdRnDycswkqN3Nt10uU1WYBDG2lulKFYKrH9yiHtF9bkvr8f61C
	 /meytR7hEl9hVBsUVRfv/vpuLUv7jfS5Y3SOL82oOABuNQSRQiYme6iZjj0wubT1/ftgu
	 adJrw9u4oe1GGcMGazgl368L3oLe3YSIho5AaAdHN2D3tAj6Ht0EBlkqAyEuri0vMW4kH
	 DF7LpHYCg1CNsGAJ5pceVIO/7NWN/a7YBbrPr/FwlFRnXxTOL31TkPTgLqYmBPK2XFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790011672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=U3OfprWndFXiNGGlnGARPAao/vEWy5PbXZ98yTS0LKs=;
	b=XQEyt7qF85fHSge/e30wXbO7yyxH5J1IHsqgxwqCioCBeDcLmCkLu7OxbgJDY0GXmEZl
	 /aXRVkuYcqAYToz2D17Ugl1sDGcSmnjRRbFFtM+y9vpCnQegTOlltemg3HH5p7HZp6dTH
	 gQTGhC26W/dQmmrasQOTSNmAEOPJvUa1xpjcLt+3qgl1UEC250x65OkoWOEu+loKdpy4A
	 IqDX4j2kgLEivWvMK+nXSI7UtBjXB+L/jlLNLbkPyBTupBMoAVnLdegHvWjsVq6Oi6R91
	 qmQQqFDDREfnsSrCrbLa1/gy406+WJw9w7gDY5Hzo1LrFlHrElqgTwbLXhnWDajnu0g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790011672;
	bh=U3OfprWndFXiNGGlnGARPAao/vEWy5PbXZ98yTS0LKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nnAR7eMI2VL3TdzB7bgtIpmsWZL3Gi3+QKE78RtRgDJq09qhR9BUHKlkjuChjOtAF
	 8S3z3kk21XJRyEsfV4G0qwAsng0gPPrDNon8MYQqTDZKGefeOP615LCB7GILWoqXvb
	 QhMrD6j2luoD+4ziZG9ph0dUx8HyRGNkUHf97TZvdgHnkZLjM4FsoaWse92Z59JRfk
	 TR/519xTjt3kiD5FgIaDvT66pUXglA8XzrJ9IW6wC/0NmiRFHUVo4sMpIuC2OUEKhW
	 6uQ/deHL4QeeEvTN8kfQ9ynC0vVCZtYM/IrswACKoMhBWR55Fqje1QRJn6jSsDIlEw
	 cK+QLlZVcL8tg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8F5560762;
	Mon, 21 Sep 2026 17:27:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C23F7909
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B48404005C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ZrU63ZPetgp for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 17:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5F3B6401ED
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790011669;
 b=lx4tgP5cQFxk9V5fVj3ReaqBTpCiCUeiLDxzQHbeKtkxHsCmPmbyD3vQtY+BN9Q3pXHT
 YP0qMu4FGrHXspeu9govd4o918gcuJ6itz9XjUU2wlbsk9ZOwaqLTlL6L1M9er54HT1cO
 l9XofZQPJoXsnYOL8k1Vcic4XzjEd9zsPr3o3b9Y+jpo7ruRte6+L/iwsXhb4u7PweRVM
 H26FFpdH9vbsB8Mf3OXxGVK7a5rRedOuQ5ywHnjcThDdwPEvoFFWj7xvkOIFTwjvUtPH6
 dOuhJd/rO6F6tRt3d0hFR+KLDA4kvn0pbRuDwnnGSoPtrYsbnHZEOHsiUfnFNg+pmqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790011669;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=U3OfprWndFXiNGGlnGARPAao/vEWy5PbXZ98yTS0LKs=;
 b=sAObVp5jHkAkqy9coTa028YfbonDxRM529mXY631MyVOSyjzMl2vUnTl0h/cCJT7g9ni
 aWbI/BHJLYOkV1mu6APbobd3Yiq1J30t8XP/kunWni7OPNmccg/eqd5IC4txvvM+4yMK8
 NRl+KuVUe9wup4ldN81yC4kpRhvuBOYVNt6cTePxfSsea44YCDbEZwEGpkAy2d/1n61bS
 Zs9QkfGUVUNFlkG75F6OhuyrvlpSm8cz+CHsjI/+04Q6dsMtHba19bQXc1WO7fWp7HyhX
 JczmIaw+pJtjKzxqsDxe2RrnvE5w+++O2BUldr/TMUG8+7lOO2NIC9c/pCAP3PQbpaA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=F6oNs7MW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=F6oNs7MW
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F3B6401ED
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 17:27:48 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c2a1a631f6aso383175966b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 10:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790011667; cv=none;
 d=google.com; s=arc-20260327;
 b=XwPMgfohqLMSv2RuSZXKJi8FNOU1mz9pT0+KcntT3HGmSYAl1MY3rb7S+Sv+e/rGsg
 M7aYeb53AEktv2iXMiMxChGqAXkc02mE3SXXjYwM98FfBpwPBdivGrjTUiBRExgPKgCb
 dMgUZ9vSZKB7GfgQfk5Vv1AU9jA9OxJjyEYxXUSYmH0HsQBBb8EeZt/A2jdKvg4K6hR6
 5jPZDJhc30A74wahS6zWRHDskm1l7FxJ9W4QaJcNSd+Lxv5WUaTMm7AX+gatJSSalT6a
 4VvnjI6RB/dDdoKakL4h0ZPhU2uaI6tgx4UXPbnkciIJ4tBs+6h49K8Q403e+uY8xPzp
 lPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U3OfprWndFXiNGGlnGARPAao/vEWy5PbXZ98yTS0LKs=;
 fh=yN5EkV1bX5gn46biCcKy8CxxGrktrizkViFyrs5V4Rk=;
 b=QbbOKW7ISqv/dFrovTwH8jpbgiJgAShH0Q3hwp2EsG/klsl7UdaF18XxpH9wLvCm0s
 wpDi1rrjVmb6bur/AGPkl4E2nnda5f30r/MwOBUVVVelinjlFVyLc0V4CYDbryTW1Bhz
 hlG+xghZBNHV03SYKbub89uXlsi9dAirV9wVo6s/1pwnb44J2dJlxXjpqzvgZvzZFJbv
 +VfC1RC8NIZBhSjpCRyMb7dZ37+NODFaDz+f0dko4fEJMgLEe62pDOeegP3G6h7JgheB
 HEt8PGYxY7jFq2knt3QuzWbhz6QHDCbCL3JjIdqz3BhR5pqfHJkpJEEny577RFB/Yt1o
 nTvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790011667; x=1790616467;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U3OfprWndFXiNGGlnGARPAao/vEWy5PbXZ98yTS0LKs=;
 b=F6oNs7MWb2bKFGz7pWOOI7Jax4G5t/h1A4wHJNm3SpX3aLBeQn8vbjVKDESkjF50l8
 D4LdF026iqo/YzraydUUQSCeQl9jvonERAmGoFjPIP+EPAHlT+QmqyJcw2sRJgmDpGjl
 gNJHeucNEwMqxLz701WU9RhRHNNNlGq6bgumD+HiF4jH1eOLMrRUIjGi/oNy7RteWm0O
 nNvf4niFD0zP3mCbNIU3XOvz8VQM7aJ0TcrdqUe5gZBEzUB3qIojO5AgTncIFl4Az/+f
 BSPY1Cvtj0WszZLTfMXdj/+LvaNi8BNGGl338DZlzAmNu+Ah260VI2sG8l8oWLbBpQBq
 qpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790011667; x=1790616467;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U3OfprWndFXiNGGlnGARPAao/vEWy5PbXZ98yTS0LKs=;
 b=SIJOoOQ9Pyj9a/u2Ne/6EaXOjYH0+vrble86Ca2RE/S+4o0DdjYpzDLlDbRlktIdov
 maigCBZzjuy3jUFZ6vZxmOBcHiD1IJ4BrYr0m0LYM6Suv4693xr4KvG5N3yxOlWSaxCI
 U8wrG1KX+2jc7f+YzV/aEP4SySGWaDMrODG6Jc3M3gqM9peMv9pkTMrdxcstByVKRD02
 h6Ikrp7dueTt8I1SLrbFQtf5oPq/w1iNG0tnmm3LkNUL5Xskt3J0d9eBV9Z73YIm5XoU
 ZFFpi+3MYQJDY//efL1EaKX8qMX4l0FHlohCBGVA6xJTMzAdYJRpK5U0ajOj2iwA/Ozs
 ITrw==
X-Gm-Message-State: AFuF++nXZMBu/uW8M17YciPFPuBYCD8vBxyiVHm27f6QOMNtAJU1Nw5W
 7A2KHRd5npr8uEwrngKoWWA5goxx5bbiAEO6oJxl7sUocku28wnqn7ebblI/OyB5R9zkiXj5IZA
 b6azelN4s55wXJIHmkuKczwEquuOFjAHr5trvisQ=
X-Gm-Gg: AYBFou3dHyWhSUzPoh/fDvt1nWE+DaeCSXLWguq8YevlXV0+CVJdqf8yAc2+/aGNXHS
 7sb09k/ugDGyJu1YqOB0H8K3FJU2PZs5pUDXe77lWQ+LS7RklCmdb4zT5RsRDtV0djXfQLjlyKX
 A8HqvXRESm2PeDNmkwqvHDko0FUZ0RBUpya6uZZbjr1q+6u9yexTiLFgRgU1GsrAv2GGQwMHkR5
 iEg0sW8hYtpL/Q6GtaFoaEerSP1PyBXvSN8J5uj279OoGOjGKPmb9YoFimS6S3F7LvEM3J3UfcZ
 rJsdaSI8vAhdmE6PGPQm3GNoj02oMN1anLoRHP+bGMAj7Ykt+G90DpOb
X-Received: by 2002:a17:906:100c:20b0:c2a:3473:6780 with SMTP id
 a640c23a62f3a-c2a34736d93mr438831466b.25.1790011666713; Mon, 21 Sep 2026
 10:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
In-Reply-To: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 21 Sep 2026 19:27:34 +0200
X-Gm-Features: AcwNN1W7Tf66Y-dNgGCVGU4gQFOBNYny9DiKMs8azadwprdn37myZfyF0DTMx-c
Message-ID: <CAC928HbNcYOK-ppp=oUewo2d4e+f6y2CBwnM=dMTyVPbDpVrbg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Avoid needless CONFIG_TPL_BUILD checks for U-Boot
 proper build
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
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

Hi,

Il giorno mar 8 set 2026 alle ore 19:05 Massimo Pegorer ha scritto:
>
> Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
> proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
> CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
> that CONFIG_TPL_BUILD is not set either, making its check needless.
>
> Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> ---
> Massimo Pegorer (2):
>       arch: arm: rockchip: Skip needless CONFIG_TPL_BUILD check
>       drivers: Skip needless CONFIG_TPL_BUILD check
>
>  arch/arm/mach-rockchip/Makefile | 2 +-
>  drivers/Makefile                | 2 +-
>  drivers/bus/Makefile            | 2 +-
>  drivers/mtd/Makefile            | 2 +-
>  drivers/mtd/nand/Makefile       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> ---
> base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
> change-id: 20260908-xpl-8c3ee1f3549e

Please, ignore the series, as these fixes are already addressed by [1].

Regards,
Massimo

[1] https://patch.msgid.link/20260708220540.3368825-2-jonas@kwiboo.se/

>
> Best regards,
> --
> Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>
