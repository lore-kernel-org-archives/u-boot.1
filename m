Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E85C5ACD1
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 21:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E958D60874;
	Fri,  7 Aug 2026 21:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QckIneBBGlH2; Fri,  7 Aug 2026 21:23:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00B5F6081C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786137835;
	bh=is11w3w0+pivtKdcKGRdg1C38zoLGukgKPk+vbibelw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwF7EZvgBqzz5fUufXjMwq/V+lwk4EDkjBdxX49bassWQwQ4wEviaHBxHJeW9t5pv
	 l4+Vh6/URjHPKCbsCLSXma2iaTUECaWz6DkPCxLK0ESCyFusqJgX8sSMohtEEeGNoj
	 tLH9eh7MitH86+/0ms2WIqYLVjDjytoOQ/p/ml8a0OfcpNkJ+WgYaZcrNsy8mwv+xq
	 Rr/Bv3va19xmvLIqtYG/YgGn2Gb80Y3vDW3AF6/0fu3ukLT2aS9WVdbLX/erqz3s7k
	 wnCzmP1QcJi1ehHwNIGYBjxTjp8PWTafslJB4YqZgvs8KzN/Q+SfeVfcbJzfhH9dko
	 Uao1p17GlzAJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00B5F6081C;
	Fri,  7 Aug 2026 21:23:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 964E41397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84F79607D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lU58nSxBZ__h for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 21:23:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AA36D607CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA36D607CE
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA36D607CE
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 21:23:51 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a082b3671fso4845825a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 14:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786137830; cv=none;
 d=google.com; s=arc-20260327;
 b=Az2/WXtQyaB/oebW1zutLi0hSgy+gYVRCUUq9SztseBpfZCqm3sxwUIIfQSAW9UfjQ
 3ja+nJIp247VFdsyXj621uZJD4IqXyDaw7d+vUhxKgPTagSWrGpkgUK8msrOVLzDefZF
 L51AXjIpH0jn3kKe/GQIwFzb+2VXBIY49JjeVnZN1hOOb0eMdfHbSPIijks3PUXkD8a/
 Ej8nAw2HrHh4DCo8zY40eyyPiXLgpbvuuAU45BoQoXJI+xOpaEYSGxUDpRLiOJPhOJVp
 Ga4P5GCyUv3amXuaCSWHdXdEK+nSyvHbPmv1tIS7pbhdpy4BXyNlVrgaCWkMsJAvPSgB
 q5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=is11w3w0+pivtKdcKGRdg1C38zoLGukgKPk+vbibelw=;
 fh=F1dB+JaFoGy1uMxPwXJWcyOtPWNI35IeK6lORFU48gg=;
 b=Zbt6bbkNGyyEKo9MLYOEa2nJEw+sa1XLpdHSgyKENyvyOtxlPOtBRBF7tv3p8neqU8
 Rg79+8ivad5OcmqlQ9ePhxkAedGl9y/d+fe4QQe2s8wa/8adQqOEAsI2f0+MXcfk3+Md
 cWPshZM5GiKvKIOrjdYb9mlcww5BG37Y6PgZizOYBQD6V7akkEfCPAWyttNpCngqVHAL
 o3MHcPtYBv6oYeFH2YE4Fpf71/85m/j6ByScHNmCvHb9fmzmbhJvJAW4HlthpOjYJolD
 dz9TmY2N4mylLGlKlD7EsTAJ4x0lEHHtQE1LgAi3gqai9TWkvgxpamD1yFhUg9vsc5Bj
 f8Bg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786137830; x=1786742630;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=is11w3w0+pivtKdcKGRdg1C38zoLGukgKPk+vbibelw=;
 b=Pu+jKa26VQBsyNDSKkOxuGdRu3xTFGBlrfcH/Y/EwwLA314HexIWHi6QPPP93LJN6z
 GWMBo+MZ/NAlh0w88ijWa4erQ4Ls7YMOh3Ew3vMbW651JPb0Tt62G011RJf8BnsB7LOv
 WgIdORERKEjbAXSbrB6pb4mPamEz7Yj4Z4gMQyKOSiVG9HG6QgkTVf7INtwkVl2gL9Co
 LbZyafkRK9VfEz7Y6M2K4EdojVZYJx6q3qZtGLgE1dUkStxxfpQry7i3BabKBrqKpzdK
 U7MGD0rCLo3vqj1+qCO+7ijlyL7x6/KHTJsZHaY7I+op/P0OZMqpVo1Zejl+ItDYYbYm
 NJBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiAhjsaNouOl/x/GnYSYB/3uw3iApNNVbUB2h0ANzTxH0hykEbASYSRdkzUw4c7zkFfZWAJaA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Ywb89n1lMGOWg2zJSPQP5ldT7oSxSi/eiUOGTSkOpJKJd82e87x
 GKl++BC9MCmLruJc79trbwQxYjHozuJLFlKPvT22BkujDy7eL5HrKGxjvmrEQvdjsyq/r8BcZHm
 uxG82TyZYlpIsg8XypHM8yhuHqk+fgvTo7cTqEC+d
X-Gm-Gg: AR+sD1234ICpgZDkT0RvaIl+qC1pl1Fj5dCewFnL5R55hYNJ50vB6Q5sXrk/rgOS2Ow
 FN77f/8KfatLMMz5SeJULd3KI+jSrtejqrtVzhfh6viwNAbZh0WikF0h9rPMVrraTD+6TxszLgN
 9nOAk5ymvUuFieeBhAM0e0og2l552/YKGUujwbBH3AfzaKRHTTGZv/Kjs+tsUSG4MbMlDhlTRjB
 RTi7qJ2W1l7AtaLY3ylyanuD47r9tsQhABnPfP3Pvs5Z0yBj1n3kRlTeX+4yXZxr/CKUzVofgOP
 +XPcnyHhv/+TvxjlD0A8fsyaRBLusvpMPnpHy7ir4ppVIlJAMm6S4g==
X-Received: by 2002:a05:6402:52cb:b0:6a1:b4ff:b755 with SMTP id
 4fb4d7f45d1cf-6a1b4ffc544mr5962144a12.5.1786137829767; Fri, 07 Aug 2026
 14:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-qemu-x86-pflash-v2-0-f3896316eb66@elliotjb.com>
 <20260807-qemu-x86-pflash-v2-3-f3896316eb66@elliotjb.com>
In-Reply-To: <20260807-qemu-x86-pflash-v2-3-f3896316eb66@elliotjb.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 15:23:37 -0600
X-Gm-Features: AUfX_mx5p7uf0oCZGyMQlapxKptiYhtCRjyR7ks3wy5x2ANJZdyLvizyWEEIGD4
Message-ID: <CAFLszTib1q+Q0jd-sKA+8bfFqn2f=ecDLeCX=V2HCbgoTjD5Cw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86: emulation: enable cfi flash drivers for DFU
To: elliotjb@elliotjb.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786137830; x=1786742630;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=is11w3w0+pivtKdcKGRdg1C38zoLGukgKPk+vbibelw=;
 b=QDQu/7QiQu/HVkOHGIL0feStlRxSmNoflK2nX9NXngGQBoiGW8M7AgyhLh10ggnKem
 4c7BmcVfNlxN1PjwAdE4jM/9s2NBoZHj7wAWMwPM3uF9hyaixMENkPH4I0bJFiNm1CAj
 spC0Mv+pZARMpOc0DQufixykySpZZLm5352mQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=QDQu/7Qi
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-07T18:07:09, Elliot Berman <elliotjb@elliotjb.com> wrote:
> x86: emulation: enable cfi flash drivers for DFU
>
> Enable CFI, MTD, and DFU so the pflash node just added for qemu-x86/
> qemu-x86_64 can be probed and used for device firmware upgrade testing.
>
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
>
> configs/qemu-x86_64_defconfig | 11 +++++++++++
>  configs/qemu-x86_defconfig    | 11 +++++++++++
>  2 files changed, 22 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
