Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CC2E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 14:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C102B80241;
	Wed, 18 Dec 2024 15:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NCTfsF+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F52980269; Wed, 18 Dec 2024 15:50:48 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ADD88022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 15:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6ef9b8b4f13so54172617b3.2
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 06:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734533445; x=1735138245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e8/Sly9B4Tr+tcj2wR3QoXP8eQ0+5Xl2fBUDdLnT528=;
 b=NCTfsF+RI42s0IRzVbj5pbYihY7HtvOp/KNi6p9ku4yZ8ybwTYZi571/wTmz2XmRCq
 WeRSpeEN9GZQPO7YNbPgGQ+tBn8po+KZe02Fj3Gz39Sb5Dd6PdrZKM4y1FAKxgRJ5Z72
 aRNYvUUUT/9LQpXnTSt1cRrWbbN9r9aHf3AcWQEvGG95p352EevvlgJvbf9j0s1wGO90
 U+9pZNs0eEfmgjlN9GDqc9B2yuqrxUfBzmpUdYLIIA5/sF2berlIuSxJKaOCSi/Tds3M
 kMxpjN/zTsxuFU8a0mL0xe2I7QYBAxUmNGrT9mAbr8ujrDUqgOZdPlHWUj55QPT70UWU
 YT6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533445; x=1735138245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8/Sly9B4Tr+tcj2wR3QoXP8eQ0+5Xl2fBUDdLnT528=;
 b=B62STDI03umCAuciuPVs8+mf59NCP/BoOFOvvgZwscS5k6Fkhf7IjBbvFxKByALesI
 bCNDRNFu+dpHgiwqdzruQ+iiFMIuxdJfN0nkIY+ckg4MoZhA2rca7UHJTi43lsbRsydH
 PThiVTulZNQOXjFdWNB9w1weNOgpfJrBoe+A5e0CKXFWTJ5Iki9IkCBLUwN1tVEQH/DM
 OpDkPzQk8X8oZW6mv3ZJkoZF2xax9AxenrEBVMJ8tX42/0HxcQmMi7uz1K3tIFNqCMPq
 rkJ2xdzFLInTujDkqVTHzzPq5ZR/6Q2FLKZI9vUVZapaFThb96GI9ILDlnxfOJVgiJrj
 vbhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4uLdcMBcPwAS74t01fpDMJHZ4HihvZaqMxDreg9CBNrCNnnJ2Q7x2HZJyGPigWKqxCLoTyCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzz2PTFfzqWkduM4+feWvBBG8xHxL5feWm5uMEvk6JYWE38sInF
 /66UVgP1pWqg0MR2tBudqDn4uSQTxpRgG6tl068mP7tkT3Dr+6zH4b1hSARxI86iLOvhvZEKD4d
 pt1EEu2MFAbYThql+Gi0XeFZbk2nxjkwfHpHczFDkA2HQCD96
X-Gm-Gg: ASbGnctUUegwW7RAgBQNqT4sZAWvCYxLQdK/rDfy4sjzpPd+yiQeBh55CaBmjec6j6C
 9tKfI7xeApPxpt6EpEOtPfx7HhGFvsPrltJisfQ==
X-Google-Smtp-Source: AGHT+IHrTKGO/dKlvuYOmrwjsM9JXiUWXOmrSdvyJZum6zLtqXpJcbEE8hRDdiI0aEfgVphO6n9h5Nn+OiMj4+1ipWs=
X-Received: by 2002:a05:690c:4d09:b0:6ef:7fdb:7d68 with SMTP id
 00721157ae682-6f3ccc1c080mr23938317b3.3.1734533444981; Wed, 18 Dec 2024
 06:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20241218090007.692815-1-ilias.apalodimas@linaro.org>
 <93a5b107-63c7-4d44-a0f4-f4079935f8e8@kontron.de>
 <CAC_iWjJxi9mkaAbR6DFHCZ13FNSnkWKSkFLZa_PLpvDOuZq9bw@mail.gmail.com>
 <20241218143440.GA1505244@bill-the-cat>
In-Reply-To: <20241218143440.GA1505244@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Dec 2024 16:50:09 +0200
Message-ID: <CAC_iWj+Tdayh_YNkMA1xvfG0MujXPwvyUdaL209RH2Ch93ShdA@mail.gmail.com>
Subject: Re: [PATCH] imx: Fix usable memory ranges for imx8m SOCs
To: Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Vitor Soares <vitor.soares@toradex.com>, 
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Wed, 18 Dec 2024 at 16:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 18, 2024 at 11:24:45AM +0200, Ilias Apalodimas wrote:
> > Thanks Frieder
> >
> > On Wed, 18 Dec 2024 at 11:17, Frieder Schrempf
> > <frieder.schrempf@kontron.de> wrote:
> > >
> > > On 18.12.24 10:00 AM, Ilias Apalodimas wrote:
> > > > commit e27bddff4b97 ("imx8m: Restrict usable memory to space below 4G boundary")
> > > > tried to adjust the usable memory limits on a 4GB boundary.
> > >
> > > I would be nice to also mention 74f88b72219e ("ARM: imx: imx8m: Fix
> > > board_get_usable_ram_top()") which actually introduces the value of
> > > 0xFFFF_FFFF. I guess it would even qualify for another Fixes tag.
> >
> > Ah thanks, Tom can you amend it or want me to send a v2?
>
> patchwork / b4 will pickup a Fixes tag, but if you want to
> further-reword things instead do a v2 please.

Great, I am fine with the current commit message unless someone has a
better idea.

Cheers
/Ilias
>
> --
> Tom
