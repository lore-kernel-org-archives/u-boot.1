Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5967E7E0CA
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:21:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8D8683C61;
	Mon,  9 Feb 2026 12:21:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkJlUZdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EB583C5E; Mon,  9 Feb 2026 12:21:28 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A45A1805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:21:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59dd9aef51eso5750501e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 03:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770636086; cv=none;
 d=google.com; s=arc-20240605;
 b=dOhn3tVsEBnswXJZE2Ris/dRyGGQZF0cmO5I7HOIpmUqqvJxOVlnroNJTqlKDReXLB
 vtk8CUDerbf2GxnFaDib7x4pev9C+nkLFWUPjUS0WiL/mg479O3s5KEp3F7f9vzjmQ2Y
 ZQPam56m6lw92CRMUUPqohYH0cbyUrpFc7OTrcbc2WH/tVCmb8aLrVG7W3jchwlVocfA
 ugi/1VOC37Abo3BMT4Ey3FUMbjDy3Dajimz33daKPsy6NSSemSmf4t+G3E0EReJZ52x6
 c8Kk6dM/8bDbE36NdhYYpmTWjPPxIA3ZVvAjDBcZ219jJdN9ml3oNdYabBKLDyrxU3Mk
 RzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LaNfm1jEa2K5iFccdZzsnFrLZeg31M/9We8wBX0vEa8=;
 fh=0+56LioK9BJETWNlxYOX5hl/xglvXzhgnKOqAxHp2qs=;
 b=Ve90X/dmo9KqVecuDAcs65kT2LlwB1jSAyvgspgbI8G6hfHju2VLl56PHq2yGymBUA
 N1l16e6xQJ4u+VuswG3t/1uUZgQSS8XFJ6Zk/FygTILRxwRLBNqwCG9JpKep1gaOSSIN
 W93MV+mYmgRPG+fDzlVUAVNzqdQqRXimsJkO+BOZW5fsm2LiO0DzfUEMK9QIoJbmv8qa
 qyZbDatb8+7UQ/rntIcfEN8gyGJrKx7GPQiWh5JejZhfLgUWXxiFGz80Q8tPnKYQ02GV
 gsQcuUYIelk3EPruOMFGWmvb0fPJxv6J/V2pM4Cd9BGUChIpj9ulJnuw677K2mVJy3Ls
 XFfQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770636086; x=1771240886; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LaNfm1jEa2K5iFccdZzsnFrLZeg31M/9We8wBX0vEa8=;
 b=hkJlUZdj3/quUUHcdJ9k4V+Y9En0uIlpAJFe2ihTkVeSILuvOWCdju/ocVx1+puW8J
 dgTTu3TpjQbTi32d0gQB35X28MvquWLafYaYm5kJdeieqd8ACBMDktiOlfma89WzC8jc
 BVSBGplQHY2H2tJTDnx2MRXsni/0zY2EQD9+m/+f74G14irdQ2SfxLXAEz8a/CyI8eup
 xhiWGAjUfYWwXJspe9tMTNyp4QIuyI4iisVzzitDFJulwJqJNY1hMyHeDieavzAlOs7R
 v45SnIsBDQ7fpPSp0glIQGgmk0hsGLNsx4nfVugq094NPU1qAPKGao2OxCMQy5JhzH5R
 moTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770636086; x=1771240886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LaNfm1jEa2K5iFccdZzsnFrLZeg31M/9We8wBX0vEa8=;
 b=kC2MlTa5Q70T+l0dy4zf3p1C98YFcCMdg9x3fBcECKMY96aNP1FNaF/CTtIaDELOS9
 BtQaZY+zX5VsRAfJcP7qtXI+MjV+YPo+3WrrxgcLLffBgpcW5PZuFTsiJe6yH1IU9DQt
 awreZQu8Epwr74wcTpxOO0PmhVlV0F/USTVQfNT46B+O0P2tcl5QgUT7cP/96DwgITNk
 Vii1WOppo6hdSUECcov4V5AaKpwSJkyZwGglgSGoP4VN7bNaBDs8Eh1kT6viZuY1pFs0
 5SG24Xl9lP7+uxBQ2nkuqMeXMsWUWML0i2e7WavZ/o1tiRWTlBXGiGb1LopVVlnsrUWc
 qDrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3GBvAEy6MMHDvB2XOAowBqaNp2lz2LF27370M3tOsMayfQBjKuQ4pFShF7IfbcIWT3Ss/qPs=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy7ZtI7ZBfJ3W7ZCfNipxEYAz8QUs6zxZOcanN3fzuZfrAkWBJ
 gK3FafyGlxiViAQFUUQB/PBY+ZyAnzfUvTK4TMjq6A2JXCpQa0Q0x4IKcrPxXqWW6v11fkRhylC
 i+S+raw0oQRazbcR+MX5sKfrY9wbGL+Y=
X-Gm-Gg: AZuq6aKE0g3CBvBZAZE2sOXqdrDo2Us9ipV/R1iJam/L9oPuNA9EOFksct4Y5v8XjFn
 Pl61BaJgnADwV2YxhVrgJXvJw5UmZ302yuxpiY3DZGHca5pznWV1zIRnIrDtwjqzJuOrYIXikSY
 FEfCg9uDkgbXzqwU+t+hC8B9O6LZSp+qjK+N4PCoiP00nAa9huLC8lo/mFhQHhiD3N/fY9knbCj
 9nJh4pVdhLPI3/pDvmEvRIWbjImWHvoiezh/nJI/+1dhht73D7TJmfQUkI9vzTMNFhS244OobI9
 H44OVPPweswej27wWURWdzo11Mw=
X-Received: by 2002:a05:6512:10d4:b0:59e:21d5:9589 with SMTP id
 2adb3069b0e04-59e45019e04mr3541209e87.0.1770636085546; Mon, 09 Feb 2026
 03:21:25 -0800 (PST)
MIME-Version: 1.0
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
 <CAOMZO5C1KB+PyQ2Kgr58uCKLE9sJPtws+OYwShe4fgkm_ZdTSg@mail.gmail.com>
 <PAXPR04MB964454F2F0129B7B70FB9E88E265A@PAXPR04MB9644.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB964454F2F0129B7B70FB9E88E265A@PAXPR04MB9644.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Feb 2026 08:21:13 -0300
X-Gm-Features: AZwV_Qi170BJ9743SzBSKGz5fUkfo6lIEonanXmx6D0n19peAmu2C-isaeYc0GI
Message-ID: <CAOMZO5DkCKd+hjvevq468HfQr4cKaUEw9XR2ppdyUPrsxAWHGg@mail.gmail.com>
Subject: Re: [PATCH v1 07/12] arm: imx952: Add watchdog base address
 definitions
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, "Ross, Fedor" <fedor.ross@ifm.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Frank Li <frank.li@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Adam Ford <aford173@gmail.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
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

Hi Alice,

On Mon, Feb 9, 2026 at 7:24=E2=80=AFAM Alice Guo (OSS) <alice.guo@oss.nxp.c=
om> wrote:

> Hi Fabio,
>
> Thanks for the suggestion. Using the device tree would be cleaner, but th=
is patch follows the existing i.MX9 imx-regs.h pattern. I suggest we merge =
this patch to keep consistency with the current codebase. Thoughts?

If we always follow the existing codebase, we'll never improve it.

Please try retrieving the watchdog base from the devicetree, so we can
make the code better.

Thanks
