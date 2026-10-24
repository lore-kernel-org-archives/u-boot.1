Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC30B606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HtuReC4O;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YlEQRuRq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 560CF8175B;
	Sat, 24 Oct 2026 13:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfiXWnPvjzD1; Sat, 24 Oct 2026 13:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 121B081774
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847025;
	b=HBLzzh8MY4nDnNvcP48YmYAFzAwx1/E7dgis/UDsHXlShqyRTuemcuybCosjsr7J6kMh
	 ECKh9Xz5HwLISIE5Ey2yPWeXJ8G5QLoowt1cab0iRejAdYM9Kx+xizwsNIQu1PY7E4U0c
	 rD/PXdL8eMGg/iw1+N5Bptkh3v877e8fRHZirXtZeW3ZKA9fLA+jC/5VmkIbGJdLxAljP
	 WFudr/4xO/5Frg2XdNs85DjlldDEty04gStxNW5UHQHG5Sc5u0X9EYazhETRgIbtN6b3D
	 7r7zGqeYZOhSdH+TbRpA5ASMTPIGfN+frm0t4qZEPd3W94/WJAV5LndG+w4oMAqwjSw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NOzJODcaAtDrRFYcCg6s35EB4BAug3gZOcUmUfBjfBM=;
	b=HHF6zhWH7RM6qyqyIhtjjxYQK5BjFTsL05U5QLt1wvFF1JIebNK6RERPrj5KYrnQnx0S
	 fC4J9Yh68+7huaA+0tpoxJDWSUVdUhkvdnYV09fvzZvCWwK/QDsM2ic8Q+dIoE3c2Zs27
	 gqT1tb6i19LNp1/yqgxu2va88/LQWRmhE8fAd6KTHwuFxJTP1kWUI40zRbwsslnp2TjhG
	 GdftyHfMJS5AS+Nx/t6abrJxSvMwCSx48tV1bp95ph3oqNn3xKiZY2qzCDO/qaVwmGosa
	 ozh41DKMyLbpd9+FwsBhCyHhD7h/515gTjWXp+G0q26lB+xZtl9EzJHgauGhH0l/eAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YlEQRuRq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847025;
	bh=NOzJODcaAtDrRFYcCg6s35EB4BAug3gZOcUmUfBjfBM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HtuReC4OOGzgh5cI345deyNnqDRtmgS40RdcmasqjdyvqNFrFhDxwf8ZJ2fwo9aG5
	 yIuEH0j01MQRPOd0Cel4ADSonZ1pAYJWUsstbTtKWqJgX4TxCuyHcxPgdRC6Tq9u1W
	 CdGXP20dUISeaebFp82Xb0f5cxq7tAwZpkg9GhkrbrQGOaFivkfNY9+lRDe63oqye1
	 ok5B9O/eWkvoO2RqoSscIEV9X1LsGnvKP4aJr1Wc7WEF4SBKy/gGi1LbI1VPYRJEYh
	 CGWZ6pL3wF2UU6+qFym/LDy7NGXQghh8pEHvU228cCyei6vEEP8GnutCq/WWvGH4gi
	 vg0PqeDINMFyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 121B081774;
	Sat, 24 Oct 2026 13:03:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8F6243
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA9C68162E
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eim-5f8rgHQm for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A001E8127F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825231;
 b=Mp6qVOLppKOc2Ajv7ZzqVShzHMoGh24FGT9sghFWrVyUBoffwBlKlZwNF9rxMQw5axm2
 U1kCx3NsjEhcnwoq7Ye//0rRv6LZ6XR+8ICimmS8cx6nE7ORj/pz0vbuKc8HWWQUzlTc0
 ru8wGDlYCqZDnaNSUOzw9iiy/G4LjhCIm7h8f0dHQ80FRz9MRjs/5wk0uI6B+urxyTcbE
 x2RutU/pSKkTvFyr6U5aklJ7VChGHtL0iBnUL/gI2EZGHD7vSg9kXAIBWkzKpwyYL3pTG
 b6GWaxuFRygkZLTnYgSRoVccOchEfaKw5dD0Qzmrdq7V51gKZbe61JiNEI8oczg0aHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825231;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=NOzJODcaAtDrRFYcCg6s35EB4BAug3gZOcUmUfBjfBM=;
 b=FDbOTO025kQRCfEGZT3NrSwiLm0Pf9aCFGBC4e7+n6EeWHgC8ENd9vSUoTqctjqHYzmN
 TzZcO4tYWuNGtSd6WG19DRpONe+wUhEsKHld0fnvswF+7DXAJ8yBzpC/dwJkC+jEJe0Yy
 rC6alWHXeWL5iT0+TXpACqT1MIp4QYekxfgjKiSiEGzz8NDyCZFxXvVK+5Nmg1kfRMq4f
 tJW0SIbesIhWXXvZ09aCjbTebf7x0dt2hh/ub01Jp6Xxy45XJyjhPOR+3Fg+puZ8Hi7YL
 xu93MpNAbfS5UZJnOtE3PGSyGDgzzkenJfXcQN778ZOwD1rH+wD2n9Dh9w0gvIOK1FA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YlEQRuRq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=YlEQRuRq
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A001E8127F
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:30 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6ac76a02368so2023903a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825228; cv=none;
 d=google.com; s=arc-20260327;
 b=NlE3q51H3Yt+oxd+6a6Syswwutb7z0DRphQlnPzXq1VMHWkB0snTKvogiHrzVtSqQW
 2F9wLGgj1GulG705AgdiexvKMVmXqKn1Y/8GeGb7Eneks/cIo9OMqRMdkmDeIz7ceBm5
 gdrnYluEAjnBzAlBdDaEfVgXupNpJ9XJXkC8UN/hnb1RubcIfjb1Fe65MQfr7jF9We5l
 c8hGeoiGeVb9Nzxwq4AY4k+1zoWvip6Nr+pPqIBWQY219ywx/fOz88SM6X3tSbu7oTHk
 dOQ5MI9eu7C+G3FkaH30aaXes5845Xdako+Qmn8FKP7YTxOLa4WxKW2LIkdgcA9xWB1V
 H6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=NOzJODcaAtDrRFYcCg6s35EB4BAug3gZOcUmUfBjfBM=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=r611aZtIS08t6e3EsmSxkon+K+bV751pDPTKDF4ZjGq74Bh6xKMmXeduUHhQi9LSJ0
 Un8MXQd1pDoaA+XEPzizbYbEB5h5crtrdbvK9JA8YyrP3ZCn32L8PNuSdwUcMhshiATg
 zHb/O25mlrFJwKKt8kgJr++W6/f+tpuA5QUXeoeGhPeuf6FsA53vkHl7b8eS12tzdDVr
 1LY9SFIxgrvazWELVzrCeqNFjn/02/XPo5aXIoK4fW13ijZOmFzoE9IWJtmPEsvhgLRz
 /yjFRcmrN18yehMu1BtESoKtgHACQxckn9f1jJtnd6tsYPpv74vvAyI4ffhYQRIL2DbK
 zf6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825228; x=1793430028;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NOzJODcaAtDrRFYcCg6s35EB4BAug3gZOcUmUfBjfBM=;
 b=YlEQRuRqjROsfKDAiZ8UJ97hrNsCocWXuyeVeLgTsEjvRTWwpWWz9yy9goJ2OY3PQc
 N15JVA7qEjtfDc9aYRtbrHzH0FHA2duPH8uRuvD8FeuFOimVNyYM/VUnx6Vuc0/Uo+gc
 Mh6lNzDnSjZOtr85Y5OnSviC7ugRArBtYgVIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825228; x=1793430028;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NOzJODcaAtDrRFYcCg6s35EB4BAug3gZOcUmUfBjfBM=;
 b=wGHrRsSvTs1vMsWeA46mCzBj5o0gpnt4eZciK1Bbt/tsloRATkDnH7znRkAawyJ8I1
 eorDA7guQzoSi02ChlR7NbXO383uhL8z1xT0gtASqGR47GtHPUGrEQEZTnvGnCl9zQVj
 mqJ7OxP/1mDRDe9IAl7pWcQTjDCo9H1PTBVyYFOMd1L2eApk2GwCnG+4D83l03AOqODM
 3cPsYFyNOHr4YARhUlTHCBN8d+WzEFGhHWA9UMXIrLhOqh3Aj1SvhCxn5blf7m1iTbem
 6RSDjOVkXlPeX6WZyAeTLcZ1u9v7uUkSto5RnYIqTu1pREf4df5wvxmcDmAP2hqM4hRq
 yNyg==
X-Gm-Message-State: AFq9FYIwyYHq/aDJ1QnECxS1v6Gk2cFOhoAjjnTG54VmnYmO4kV5P5yy
 ih9Fsn9ZRz5hpEM0oHTkts0cKMZ1Tjb4df26Gttwz9r7tTEmyMX2TVjFEC93zlMr4mOvz/95N3w
 NO6fFX/uZyWIeUEJ7BpnOTl7YKvWzBOJMemnwTVI1
X-Gm-Gg: AYBFou2M3oCZhlU6GsKuSVqnkkcrFWCoOzXbMuuKYnRhMEV5mahwE9xiwdvAA86yzW6
 5CaCT243X9FfaoU18lzzw2P30w/dnAy3uA8t4vynfLY45pzhIL0EcnZwAR3O3Ow70+TevgPx/eN
 hn2enV7BSo1BX8qLL1sUBNr/SMGF+nFeZqO6YqlyLVfXLaW3WHTCvzZAcBh4EhBo3fpapPBY4Fs
 lZkgp/8bWDo2oBPUgIinYmYg+t4QDY5pc1332Vv13NVd4nvWqViqgEfz4vi07YmtnelgWHHJDU6
 tBp/fTIvzIMsLieBxOk9YSuC0S2SGPTwl4tqem9uWI6bHQP/2zTxeEUl8eTh0SLkaE+jWNqalxB
 f4q/TySxPPkaQVUlO327VxJPChHoZrv9bgVM=
X-Received: by 2002:a05:6402:4415:b0:6b4:1c18:7c92 with SMTP id
 4fb4d7f45d1cf-6b44301a590mr1656351a12.39.1792825227812; Sat, 24 Oct 2026
 00:00:27 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:25 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 08:16:32 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-12-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-12-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:25 -0700
X-Gm-Features: AclHuK_nJvz_figw1KAbYSEnVOv6xNh0NMRpHnWeo0trjFIXkTf10EqVMvil_tI
Message-ID: <CAFLszTjCGdQ1px1xyr6gpcOY-h9mb+3G-f5T5F_HMfK_427K4g@mail.gmail.com>
Subject: Re: [PATCH v3 12/23] test: spl: Cover FIT image decompression
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alexey,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Cover FIT image decompression
>
> Nothing exercises the decompression in load_simple_fit(): create_fit()
> only ever writes compression = "none", and the canned LZMA blob is only
> used on the legacy uImage path.
>
> Let create_fit() take a compression, and load a compressed FIT both ways:
> with the data inside the FIT and beside it, since only the latter stages
> it through CONFIG_SYS_LOAD_ADDR.
>
> Derive the compression from the image type in one helper, shared with the
> filesystem tests, so that adding an algorithm does not mean finding every
> place which assumes LZMA.
>
> Have image_supported() take the algorithm from the same helper and check
> it apart from the container, so that a compressed type needs no
> fallthrough of its own.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
>  include/test/spl.h        | 25 ++++++++++++++++++++++---
>  test/image/spl_load.c     | 47 +++++++++++++++++++++++++++++++----------------
>  test/image/spl_load_fs.c  | 23 ++++++++++++-----------
>  test/image/spl_load_nor.c |  2 ++
>  4 files changed, 67 insertions(+), 30 deletions(-)

> diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
> @@ -345,18 +347,19 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
>  	data = fs + fs_data + img_data;
> -	if (type == LEGACY_LZMA) {
> -		plain = malloc(plain_size);
> -		ut_assertnonnull(plain);
> +	if (compressed) {
>  		generate_data(plain, plain_size, "lzma");
> -		memcpy(data, lzma_compressed, lzma_compressed_size);
> +	payload = lzma_compressed;
>  	} else {
> -		plain = data;
>  		generate_data(plain, plain_size, test_name);
> +		payload = plain;
>  	}
> +	memcpy(data, payload, info_write.size);
>  	ut_asserteq(img_size, create_image(fs + fs_data, type, &info_write,
>  					   NULL));
>  	ut_asserteq(fs_size, create_fs(fs, img_size, filename, NULL));
> +	/* Compare against a copy, so that losing the payload can't go unseen */
> +	ut_asserteq_mem(payload, data, info_write.size);

This applies the change from 'test: spl: Keep the payload create_fit()
is handed' to spl_test_mmc_fs(), which that patch missed even though
its commit message says the callers compare against their own copy. No
compressed FIT is loaded through the filesystem tests in this series,
so apart from using image_compression() this has nothing to do with
decompression. Please can you move the copy-and-compare part (the
stack 'plain', the 'payload' pointer, dropping the malloc() and the
new ut_asserteq_mem()) into that earlier patch, so this one only
switches to the helper?

Regards,
Simon
