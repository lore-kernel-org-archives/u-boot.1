Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A06ACAC5B2
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 00:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B28AB88C91;
	Wed, 18 Sep 2024 02:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bn3YHiuc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 198A0887D1; Wed, 18 Sep 2024 02:47:13 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2577188C91
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 02:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso77710821fa.0
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 17:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726620430; x=1727225230; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oDhj8gXuoHjMhzSHwqB0Qu7v/om90a/GF6QIjgrifo=;
 b=bn3YHiucDvfwjPLsmHlSE3/1YYGJaTd49gvv1jH0HezXUOIWvNziPljXQU7UUyht4i
 kH/VaAKgfPqxFFEkur88MIEMMjpUKs59ri9pClI0Ls6IHAJ5jrBw8bQSziRN2foms9Ke
 nqcPYS4t/IhodgE6XUzBWtTr4V3ZjwcEQUXNs0JA1foSwmhJt69pm1HMrOKzpoAnmOCY
 KTZKWVyPm8jryF334BQ8a4BaqSl80+kpxirKOtJTD4yzC0tz7EMqPC9iRK3ZUHfnhRYb
 lZsabdYPbOmMt9XZ4P0+1PIyB4I3g9detwGTaLs1Lulf1gV4CCoC3c3wUpIqykT8aegy
 XmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726620430; x=1727225230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6oDhj8gXuoHjMhzSHwqB0Qu7v/om90a/GF6QIjgrifo=;
 b=rSPo0YLOgzMRq/iYX+FqvGlS0k+/X2a6SBVr4RpfAw32x9zmNUFVg2WjsF9evzpeDV
 oAMQye6Drb4ffv52aUqfw6K4S0uLF+UU3qiorLF/hGh96u8zH135GX1wTxfpGfdtsUqi
 WuaaXyQq7jrHZUH+Q6ojyJGnqznHyPFOQ18zhuLTgQoY8okAjCac/4hIcvrvbZLRo4Cl
 1CahV+HfRJLSkN42fv9JbGxYnik/eT/vKaUDPjL1+ApkbxbTYXnhaNh4va4cdIUxUEI2
 WlgITHRvQkqaFhPE6PuFL4mfUmbB/oWY4lWLIm1Y8LX8K/wyoWVKNObYnRtpIy4qPHy7
 +0Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbqrkHVUQ0yOBHSI7QQ79Frh+JNDE95tzdxx6U0hjhn4alKidD05MN/FU6OdRyiebwX1vGEVc=@lists.denx.de
X-Gm-Message-State: AOJu0YwzpjkzTIluvi8RC31gsZnGEG0lvgCqULDqyJF3gfqhWpl2J7u0
 zjvhzMhnh95ee2dbKLLjCd3LwOwAw8tIKZu8jIo0XSoVBmRHWMkk6iOjAUudbWXYV00ypluf9XC
 zKoYugwIJu9eGEkeoeC4yaPO616s=
X-Google-Smtp-Source: AGHT+IHPskD+DhoXQfpIGVAsz+0mE1FmrJKdeWym6Q3OfzbkbMFXZe7USENULO+xt+XBGbMrqHwAt0lwoY1CTascMwU=
X-Received: by 2002:a2e:4e11:0:b0:2f7:4f93:ef8 with SMTP id
 38308e7fff4ca-2f787da5213mr88323101fa.4.1726620430064; Tue, 17 Sep 2024
 17:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
 <CAOMZO5BzLSCTOpOz7vvp-uGfPQAjViuoCP-fyV3BZ3KnxeZm9Q@mail.gmail.com>
 <PAXPR04MB845979D1A524FC309F7A84CF88622@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB845979D1A524FC309F7A84CF88622@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 21:46:58 -0300
Message-ID: <CAOMZO5AN4i8n3BKBqKpU4M9AfVP0U80XA6+somUTM1MkSKXxuA@mail.gmail.com>
Subject: Re: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>, 
 dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
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

On Tue, Sep 17, 2024 at 9:21=E2=80=AFPM Peng Fan <peng.fan@nxp.com> wrote:

> The linux changes still in downstream as below:
>         /*
>          * For this spi-nor on M.2 card, need first enable the VPCIe_3.3v=
.
>          * Note, VPCIe_3.3v need about 1.74ms to change from 0v to 3.3v.
>          * U-boot already enable VPCIe_3.3v, so in linux, can ignore this
>          * 1.7ms, if u-boot do not eanble VPCIe_3.3v first, then need to
>          * take care of the 1.74ms delay, better to build the flexspi dri=
ver
>          * as module in driver to avoid spi-nor probe fail.
>          */
>         pinctrl-assert-gpios =3D <&pcal6524 13 GPIO_ACTIVE_HIGH>,  /* ena=
ble VPCIe_3v3 */

This 'pinctrl-assert-gpios' is a NXP hack. It only exists in the NXP kernel=
.
