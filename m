Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B3FC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 23:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60DCE831E4;
	Wed,  6 Aug 2025 01:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NZyRcDvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 790CE83276; Wed,  6 Aug 2025 01:07:42 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80B0683102
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 01:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55b9855f671so348758e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 16:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754435256; x=1755040056; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rAdOngdloedR2NX+ImOvAsZTM4VxWzGx56vsPQxyuPc=;
 b=NZyRcDvzi2qhEwVROhWrFNKkR8eLbeiOFxUl/8U8pnWWq8rw2naAgLphjGbw415qZW
 dGAQEYWpLUrT4Mg21Ptp0eTiADc9UuYDLyIkW/sR2wLP6Nyn2WO4cMBHU3a0Hf/foUH5
 1bvmQ6TkHqjTfkG+hD9sNhiiD/pLwXj7cjRuGJRG/rjoPPSyxJBQpIzD4BIJzVRtH/cB
 RWSC0R52uHN9E9txhIFYSwzQKsQ4b/pt3Ci7AH7moCH7gBNHH442PgULeN/mJfcCv9F9
 hxyWT05d94SOWba4mch/krpcXHZ8j68+1pI7+4TCZvmVIB9plAsopZwn8DV+y/0mSpK3
 lN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754435256; x=1755040056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAdOngdloedR2NX+ImOvAsZTM4VxWzGx56vsPQxyuPc=;
 b=pNFl+ZWHf7Bm7IdZz00+bJzox0675c1n6Yh+vCmK/qpiz73UL+FnEs4NjhHB4E3AKD
 IljSkPFn42ffZ3GOnVxbu2uNdUE/8+gZIBGnd/Wzs5aDYcPsoDQCFOeFzSTrCzwLWce/
 iO1lXZQmwqVQpMzNfmaE5m3sGWtWALp17sNzNc4jxebPMafwvBLIKSZAAsGgTUd1mGgz
 sLFSIk+nfGnn3Vv0PJ3DR80OYQeO1027vOZuMhQApUtU9oTo/O5qjLvJkLxIebV6jheS
 dHA4NpAOXyNsOyUJiVVaZlHdfadl0KGCvLPLK+7ioeGcqJyb1Q8q5ZA1vShYZE+LkQf6
 zliw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwZFSCeHDCll8wrfoMgkSr/t2yrm+4m6ZtMCkqPBpZ/3p44A9Qx8/odUXqHZg1nf9lqK+H9WI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywap73oaMuhXYChFlz9c5osA+Q5Y2wygaxevrzK/3aiwuZe3vXY
 7u2pEFrlh3dcPG6twAKTEInRHc+/Fp28/4pFCo/cdaMhdfZy4pa1k6NXJTIRkSHDdNogkHIqegk
 MrFhBR9z6kiNT+4EANB2q7/9iYinDi2Q=
X-Gm-Gg: ASbGnct3jH8j0u8z5mMjzhQpFYYKK5dAB6brPMYe44nx3RhFiiAFGl7Dj0nE1wJfj7U
 GV2FMo6msxwEo81cNFANGOMxcU35DDzQ9DzegGBJ5xI5GsMS0jFngw71xo2lcwrCdjXnYTRFJd9
 ZbN8xox59LnEXbcOgdpkKiwHX+lST1PsVmkZ1gwy/07B9FNXgWFl1Ap+XeLNSSwvQSh/cgHnUaM
 lTBxq5nMbYWCZax2mnNjpA6/kn3LUm/58K3tp1ysnt/Wu5ocg==
X-Google-Smtp-Source: AGHT+IGqR1S5yYPTfOFBPgNun7An+0MzBJ/zSFjnQI+lFdMG+P0aA5VzyDG4O8VAlBIVnXvvec723WVuJWLbPUY+G+c=
X-Received: by 2002:ac2:51c9:0:b0:557:e3be:c7c5 with SMTP id
 2adb3069b0e04-55caf30ec2emr212446e87.28.1754435255478; Tue, 05 Aug 2025
 16:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DT=ua+vCX5OQq6sx1nfcFjFY0S1hJ8OmNE1RWCQAmxJg@mail.gmail.com>
 <e5c64596-b118-4394-87b6-1b121c801af2@kontron.de>
 <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
In-Reply-To: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Aug 2025 20:07:24 -0300
X-Gm-Features: Ac12FXzTYIYTPY1umki_DirNjhh0kpfX_ayYKJLl_5g2CMIdrwQopuxGPZbXvhA
Message-ID: <CAOMZO5C7-mYM2fOR8z_2xzOZ6cSMmG32PKvbjdP+bEhqv1cwcA@mail.gmail.com>
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>, Peng Fan <peng.fan@nxp.com>,
 Francesco Dolcini <francesco@dolcini.it>, Tim Harvey <tharvey@gateworks.com>, 
 Peng Fan <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
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

Hi Jo=C3=A3o,

On Thu, Jul 31, 2025 at 3:47=E2=80=AFPM Jo=C3=A3o Paulo Gon=C3=A7alves
<jpaulo.silvagoncalves@gmail.com> wrote:

> With this patch, I believe Peng's concerns are addressed, and it also
> works for our use case.
>
> What do you think?

It looks good. Please send a formal patch.

Thanks
