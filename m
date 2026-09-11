Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9BEC88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 994B46069F;
	Fri, 11 Sep 2026 13:33:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vWQeWTjy3mlI; Fri, 11 Sep 2026 13:33:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9D1766066A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133592;
	b=X/FDEoglK6dp0PSCvaqkKc4EfKbi3Eyn2Htn+6iwVRNlGfTZFU9T6EHvaIWdrP8CgmQJ
	 e+iatP4TuwymfshD4/ZLBsgMzJijuSjTaDTETP9APQ7dp222BMR9JWUdfNuDDfUeOlGJu
	 aTBqFCioV4VBy1QVxpLwmlaaEcoj1w8lz0N2zEGcxtAdCT9TGPHyB82zREPlCP85JNWzi
	 cmi8EZkcjwVOAP7ZNAHyp1YVfjpmblhJz9Zns3NldODm3uIEpvM0fTpjeJibgPLH13XzM
	 4yGkQHAPm4aqLCgcqLAHjUsDFn5R/GCQ2kt0Nw1n0/VAT02+uUMucl0cuL3eiH8P0Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2qXHynI+WFLPEVaeP5+2rbd5KpwatC8dqIACJBnW0l0=;
	b=lJ5av4YBa4jJQWGuwzvY9dFDBAOXQgkWH/E4qldxIC7A7ABf2Sj8/G6XyfyZr3DsR7de
	 prYfMGS1ITmX7xJFvJAzJGL8EoENwu2FKeiq5k52xlYDQMhGSPbg3p4/hXH7h2hQIIckq
	 LO8QCSB3VoSzNJ3WhOahiwbDZcAQSW5miT0CwD2WpCHo23xrDjlErnaFTRwutkAqGFmZW
	 jHX6n8cxLkv7p2GCztN8wCXl3kU14Uz6NnC+dLr/hWYVC29J/AqoofdCDfJqhDS3W4Jrz
	 VJWB1SCFE/822211DWLRn8Se/vi2Xu2q+vNFbMdMtof3qRQRJih0iSlvLxix085E4iQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133592;
	bh=2qXHynI+WFLPEVaeP5+2rbd5KpwatC8dqIACJBnW0l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jCw8EOLhtywK8IWg8YyGiMAE8UWmSiic+eV7cwQEw+ncfRY5anz8yS16bPyw3BHMr
	 /H74771nts2PrR4NAa7KqQxIZ14vFHSBZCnOxTDHNwx1RszZ6ravqWMyez3CuFepqj
	 2Voi7gWphMvd9n0/pARIBnx8dqpoucAzCrivIumMfXPjVqYh3gfXy3GwRCn0dhb+PG
	 BbwUgls+J5QoxeZaKaJ/0rLNn0Fewq2t+TVSlM2189PnIGWimQtkJ8HExOhXkT6nI8
	 7kmsEcJmunEEuIW/aYnbFGaZjlGUAZ0pblt3SYbUViLnc6vg8XXimya3HB2RIOO6Ry
	 Aa6q77sWsSywA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D1766066A;
	Fri, 11 Sep 2026 13:33:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25A1A786
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BE784081A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:33:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SvnjMxtuKFyP for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:33:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 701944081F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789133590;
 b=tGePkgVtdEimGl5MZMjgb4MIvE5vbmv6gprkARmtoS33iEFJYN6mEQVyQXbFMjyx532v
 qT6ZhWxsW8H0pw/ufl3ouIBZdk0+UYFkRCAkyRAvnkR17HspIfHcDHhYtfa52VA2oBiwd
 NaaV8VJgBy1jjxKLjbcDUPS6hEvPncJbnSUW7V+AR4bUrOGmWfyP5IViyZhIF1wwq87fA
 SLyZJwg0USAR9Xj3J3iXcTLft+bR/45eK/ni7n7vQP02W0jbx+bCtk5T3qK5As9gqQmrL
 aY47GoPVsaMkyd0gUpso9DDyeP78uo6UiPB/Niz0UxnPszQxHIRNoHLvXB6RpzQhD7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133590;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=2qXHynI+WFLPEVaeP5+2rbd5KpwatC8dqIACJBnW0l0=;
 b=Qz0EgR3eNAmrwnVP9L4gfgqA1eoonRVpKUCLNCXjOkNan5s/My+wZi1eTi16ykObUxUF
 AjfZ2hiFTvX1Jy2uk4pqW5QQJKft2azLHuJSTI50F0wrEAoxZz/gi87xYll2f6APJGgIp
 Qa/3e//j5cw3/hSpEuvt0buU13ntNjKHIuCrPOZC5POUErWuETjE7507ZNhnwoG291puT
 ReC7y0G5HKemA5rk6b/yvsUqGN4XeT5csx9Tyfd07S/Zst5I5aBLIvOLwtcbT2R2l8xMi
 jSUWbWVHkcavftOX4h7ls5gOcGtg7NKEvmjq7E1pJWMIxTJzru8jNls1WXEUF1JyPEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=pDOpFpxi; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=pDOpFpxi
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 701944081F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:33:07 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso13977335e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789133585; x=1789738385;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2qXHynI+WFLPEVaeP5+2rbd5KpwatC8dqIACJBnW0l0=;
 b=pDOpFpxiOv+RXNd779zfMH3uLigsxLiXlKXdOhAshpnDaZgdf5mKzJEBL69elI2wIN
 jxExc4jNaKWSzmJ6ruHieHd35sks1qLXHhwAh8v34bTzFz7qagPfydJUTGFjG0AgfoL9
 R9bEbD6DFGMr66Rb4/6ukxlDyVKD7lSIAfp+SrQK1ttGC3U31BJMvG2issI62c6Bz2cQ
 wXmBUele4clmdVwiBDb/1lNfkBE7JSNEfFL4k29r54rxdo7ST5/pwsAAjawN7QTAhd8h
 tNcigLlhhE7dv3hdOxz0Jvw/6or9DhVrKLtENzm7rMzFds6cMDI1+HF4PTEYdWEPNPcO
 1pPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789133585; x=1789738385;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2qXHynI+WFLPEVaeP5+2rbd5KpwatC8dqIACJBnW0l0=;
 b=XmqsXpCwCJYH06d2kfu8aB2TGAX62F/6NudqrXhnvRaYV5HnAB+K+iDFG1hnVJlorT
 QNuzXVJ2BgtMNBTFba3SQemvIzCqZRmgHNUZgTT1S+20za4IWklOj0piIs9pkQnSarRl
 0/VGNjwx6AUGVvRS+CtfTLMXeklA1OwgU+sPsrNCWSOdZwE6Vwr1u0n/7L4XcySpOBNH
 Kdh3tujts5N656o/6RhtHtm1ImygDxSjqiiqlpqio3FQS7X4z5UVLqpNCynxio9s3inH
 IdWO3Q90Ul7AE7/oyB5XH5MO1+88waO4/ddd4GII1ONqGoQewyugiMoQzWEa5s68AcA6
 4oBA==
X-Gm-Message-State: AFuF++luxKFDAjFrn2cUWjDsKd8tSwA7hlRQxBFZIcLyg5Qy0ROFO8X3
 K+lAPYFWRy2vw/Xurfh4AGASJO2YVxHNn7OdgkhXzHlfMTF0pP1jV5um3Bd68I/ccqo=
X-Gm-Gg: AYBFou3kNvlxdDtStIlpyAB01Ds28lsvMHKLGyGZcmkfuVJ+VeR+8PhZHUpAb9v5BTR
 9QnR2+oT4KwOGJ088nzbEE5+NqRA95G9uCsjooVeHkRD/PnTsyV3MJFHjywQclTfbPDV6++kf6O
 BQzHWH/AAVmZlr1XQ0tHD+loJkzyFKAcNPmKqvGJhGJ+ReW/8ENcBFDcFhcgR7zsRLBMUNxjwEd
 5eEM++iSM0oJlXAEfYjIJTw1FrgY+GRtQbBmOlMZIYG9hYvTgUiADb2n/nWua4hWs3M2IbfXLkf
 AYN6x2RMGQ+nAwQYcUb+odbTHAXwFDa6xwb7dd+3PH7+VE6SOjxXHoGGtXDFR6VeaHZbuGeJV0W
 srNNRjlHHYRBguL90CD4MQ13BR7CBkN4Cuq+k7Lzy8dpn61snQLXof/zq5MWbScSCDCjm92voai
 7BcMQaWXoCjCJS8TqzzfhrZPRQa41lM+AePQpY7zPVSVR66+E03V4nkYEhn5aNzI0BxoKPvBeis
 n86pJKDNWRb3S73IG5HqwWRvPdGtEYZc9V5hNmhEyvKpO2FNvTOMBXZ4Bfg0bVWsjL+GNP1EvNt
 V9eN1pbiLwW1z/OV
X-Received: by 2002:a05:600c:3104:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-49e6188899fmr52178545e9.3.1789133585326; 
 Fri, 11 Sep 2026 06:33:05 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm264168565e9.6.2026.09.11.06.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:33:04 -0700 (PDT)
Date: Fri, 11 Sep 2026 15:33:02 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 1/5] fastboot: factor out the USB session runner
Message-ID: <aqQCQWUtmHiW-Ifs@macbook.homenet.telecomitalia.it>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-1-023516e77321@baylibre.com>
 <xhkdbfqzg3r14.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhkdbfqzg3r14.fsf@mkorpers-koolstof.csb>
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

On Fri, Sep 11, 2026 at 14:34:47 +0100, Mattijs Korpershoek wrote:
> Hi Carlo,
> 
> Thank you for the patch.
> 
> compared with v3, v5 introduced some new changes which I don't
> understand.
> 
> Please see below.

Yeah, sorry about that. I received an off-list review so the changes are
probably result of fixing those comments.

[...]
> > --- /dev/null
> > +++ b/drivers/fastboot/fb_usb.c
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> Why is this GPL-2.0-or-later? In v3 it was GPL-2.0+ which is what's
> present in cmd/fastboot.c

There was a suggestion to move to GPL-2.0-or-later because GPL-2.0+ is
currently deprecated see https://spdx.org/licenses/GPL-2.0+.html

> > +/*
> > + * Copyright 2026 BayLibre SAS
> 
> This was also not present in v3 and does not seem an appropriate
> addition to me since we are just copying code around. Why should it have
> a new copyright?

Totally fair point, I'll remove this.

Thanks!

--
Carlo Caione
