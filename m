Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C571C35FFF
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 11:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51CF810FE;
	Fri, 21 Mar 2025 12:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="kjOEsPpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F022081895; Fri, 21 Mar 2025 12:06:46 +0100 (CET)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D776808A2
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 12:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1742555199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzlB10e7/cRMkh5JAfQQqNyhfRgwtpcP9T6THDKeTHQ=;
 b=kjOEsPpEd2s31RwKlP3eh+Olr92c2RVP1YtkcZ63fwLsN1yBGwDjiT0Vl4aHSOZvJhq07d
 /VpB9q+ckY/zwKiJ4wq99yo00C1GeXHkiW9Wrv3NKE+MEpkduvUPYBNOBm2dlUDX3t9ol7
 seIW5rxDCr5PXDHm5f/jUNixy/ufKtWrPcZW0Wkv2iLibAaq/zSY+CIGsqW2WALhGG32ve
 2L747DjujEFfWlCwERABKFqlLI9ET1xmTdT22/Vl330xHVXuEiMd4HHhfXpIe/44VTBgfp
 U2TVY/3TdcP3IYBcL3KeftxQJr4RLvU4zFgbV3p+x+FsmdCLWvXhQDfrVE/yYQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 11:06:10 +0000
Message-Id: <D8LW969044RD.26NPQM1ZK8FXP@postmarketos.org>
To: <u-boot-amlogic@groups.io>, <avkrasnov@salutedevices.com>, "Tom Rini"
 <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>, "Michael Trimarchi"
 <michael@amarulasolutions.com>, "Lukasz Majewski" <lukma@denx.de>, "Mattijs
 Korpershoek" <mkorpershoek@baylibre.com>, "Marek Vasut" <marex@denx.de>,
 "Viacheslav Bocharov" <adeep@lexina.in>, "Sumit Garg"
 <sumit.garg@linaro.org>, "Simon Glass" <sjg@chromium.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Jerome Forissier"
 <jerome.forissier@linaro.org>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>,
 "Vitaliy Vasylskyy" <vitaliy.vasylskyy@globallogic.com>
Subject: Re: [PATCH v1 00/11] Amlogic: ADNL and Optimus protocols support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Cc: <u-boot@lists.denx.de>, <kernel@salutedevices.com>, <oxffffaa@gmail.com>
References: <20250319202045.1407-1-avkrasnov@salutedevices.com>
In-Reply-To: <20250319202045.1407-1-avkrasnov@salutedevices.com>
X-Migadu-Flow: FLOW_OUT
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

On Wed Mar 19, 2025 at 8:20 PM UTC, Arseniy Krasnov via groups.io wrote:
> This patchset adds support of two Amlogic firmware burning protocols:
> ADNL and Optimus. Each protocol is supported on the following SoC:
>
> axg, g12a, g12b, sm1 - Optimus.
> a1, s4, a5, c1, c2, c3, sc2, t3, t7, p1 - ADNL.
>

Out of curiosity, don't GXL and GXBB also support Optimus?  Or is it
completely different?

> Both work in fastboot manner, but significant feature is that they are
> supported by current Amlogic BootROMs. As transport both use USB:
> device is switched to gadget mode and then it can communicate with PC.
> On PC side protocols are supported by:
>
> 1) https://github.com/superna9999/pyamlboot (with some limitation)
>
>    For example:
>    pyamlboot/./ubt.py --img <image> --wipe all --reset
>
>    Note, image has special format, specific for Amlogic.

Awesome :)


Regards.
