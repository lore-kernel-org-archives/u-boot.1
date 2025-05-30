Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F5DC5AD49
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 22:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8DEC82B5B;
	Sat, 31 May 2025 00:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gm7kiUaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEAA82B8E; Sat, 31 May 2025 00:25:56 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A98382B0F
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 00:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5533c562608so1293073e87.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 15:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748643953; x=1749248753; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FXq4MZRD/+OqBmWGv/9OByDP4QiQItWxYxlvfup+0Xg=;
 b=gm7kiUaKQrQ4JChyUChEmyfpi5goz5v2P2yMamN/4cpjEzj5IFDWbG+omMKUbJXBZW
 lQQmJnHWeRvXty1vDJb0DMuyvdr4g9k5IHq8ZvhucADJb0jUEtEG2b65ER4HcIyj4GSQ
 cJ3xiloaEE5z+8VxTNcyWMP3T3WKtUt2ffI6zaPsTmTCP1NprdsVu/fHT3h5PJ5HNFGn
 rx3QZk8FLGgoN1Ok8FqlSIKz2VZDVvaM2yLCGBpsNwc7QhkY0k53TbGMWUJKpFhzAx36
 in1QPC3wa+PYDBKVSZfhrDKPE4CaVcQCS8w2ZkFxKBeBvEjgFtcQxbo9kGRIHFhDj0sc
 4sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748643953; x=1749248753;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXq4MZRD/+OqBmWGv/9OByDP4QiQItWxYxlvfup+0Xg=;
 b=q0mv2sUgjneVBY/qnoVyL5Zze6vLAbBCp1NdWQCDg3eh+DWhFpzgJ06/ByXLSv9WQB
 4Cw6e2M9p5MYJigUC8+rT76uu5LWgBZtXoYsnf5I4pNf8ZMyeeYCseHJ0F4OXB5A/XA1
 W0VJP38+CVHifGqK2zYd/ZzMbHKUs0bs7VKA5CuxgkGZD5MJIg8Lrw2EUV0ragIqrgzS
 fVNTzp3kTbADXyRqvn9cdJ0SK6m4PcHublxlcPs0tPOOgN8WdhqIlkmWBFtsnFiONp0n
 pJLMLVhKYM8AQCbysHiqKPgkjFyaro4DYLVi8bTwijB5wV+ILRsCN+QUJpObZWTJjdjh
 hkkw==
X-Gm-Message-State: AOJu0YysodHo5azW+TvBlkRagEeZ9+HuPmjtvtoXVf9e9UnJgNK+D24v
 RIZvWMXvhbIZKyguWti6T99yoq95PP+Koc4Lqxis+jsWvwXY+/DySQxMshc5z1yP+h5PHJZpLE/
 PV4Rt+JaYCT5iBJPm8qpgpBb4BHI8rRg=
X-Gm-Gg: ASbGncuwjwKQg/1lOcgQr15MNLpF83G09JLfap++VAeyCxqnH742GJ3EijrT7+wzP68
 LHkM5jjndAljvkRq0Zav2vbwgVBnZL9B1xwNTe3+SA2RvvdbaKm3jH4UZzNE5sM/BoPcodAxYZW
 Lo2ah5ONldn2Yfs8VLu77L7qtxmlfG1BM5IoPwLciw6KLxnanoAzB11ftv7zmRgdTv
X-Google-Smtp-Source: AGHT+IHBHy532hXscfK29ybO1EVjHEXtPdocG7pgF28aHFr43VZQIW1OBr5iTmk+pDu1Tkc7G5dmnKfpWg0YbBjuUzY=
X-Received: by 2002:a05:6512:b96:b0:553:3073:c38b with SMTP id
 2adb3069b0e04-5533d14f123mr1278368e87.1.1748643953023; Fri, 30 May 2025
 15:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250527182510.1247662-1-michael@amarulasolutions.com>
In-Reply-To: <20250527182510.1247662-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 30 May 2025 19:25:41 -0300
X-Gm-Features: AX0GCFtL795IViBiRgUIsyHq9MfADrFILOhn676RFs6oNQyfgKoBd29j4_GAW8I
Message-ID: <CAOMZO5Bay0_acjF-964qbuptGvW-ih0dhZze2pk+dcjSPR4Yjg@mail.gmail.com>
Subject: Re: [PATCH v2] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2B board
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Sven.Dembianny@bshg.com, Simon.Holesch@bshg.com, 
 dario.binacchi@amarulasolutions.com, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, 
 Michael Bode <michael.bode@bshg.com>, 
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Wolfgang Birkner <wolfgang.birkner@bshg.com>
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

On Tue, May 27, 2025 at 3:44=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> --- a/board/bsh/imx6ulz_smm_m2/MAINTAINERS
> +++ b/board/bsh/imx6ulz_smm_m2/MAINTAINERS
> @@ -3,4 +3,5 @@ M:      Michael Trimarchi <michael@amarulasolutions.com>
>  S:     Maintained
>  F:     board/bsh/imx6ulz_smm_m2/
>  F:     include/configs/imx6ulz_smm_m2.h
> -F:     configs/imx6ulz_smm_m2_defconfig
> +F:     configs/configs/imx6ulz_smm_m2_defconfig
> +F:     configs/configs/imx6ulz_smm_m2b_defconfig

This still causes CI to fail:

$ ./tools/buildman/buildman --maintainer-check
fatal: detected dubious ownership in repository at
'/builds/u-boot/custodians/u-boot-imx'
To add an exception for this directory, call:
 git config --global --add safe.directory /builds/u-boot/custodians/u-boot-=
imx
WARNING: no maintainers for 'imx6ulz_smm_m2'
WARNING: no maintainers for 'imx6ulz_smm_m2b'

These 'configs/configs' entries are incorrect.

Please trigger a CI job to catch these errors before submitting a v3.
