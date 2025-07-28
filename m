Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB80C83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 18:04:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8315582E52;
	Mon, 28 Jul 2025 20:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="bRoZILx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D930A82EB8; Mon, 28 Jul 2025 20:04:32 +0200 (CEST)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0261D82E34
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 20:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-61914ab3c66so1559444eaf.1
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1753725868; x=1754330668; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etIfJDF3Xscb5GzSs3WOYXorwKZafB8IbhIbN/dUvXk=;
 b=bRoZILx5uzNgIsNG/0zGPlNH1brp1D4F2o/6k3xGmEm6z4VnGx3TQtmT9M+b3rIS+T
 aOyWgOhipWhNH201dkV7YcjrhNR83NzPA8R7PNEyJkmdZYUY970wRKCkEn+3PZla9ZdT
 VS6GfKN7Lh0m8ICpVjIvAKPmDMR2H3Ed9TkJdBhujysSgKkavqR0sa+sO4m7TiraxmqK
 HQSrNcBOegDpU+MaRBFPNvYrUl3RRSTThLy0+sENOeSK3uzVzXXF1tYC4FCpQ49B/TBI
 Xk9qeSvhPCKD4tOW4L6Zizuz6JGHC7z3uCtR2rFhfjq6chWsjBP0xJksoZ2SGtQOHJZL
 YDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753725868; x=1754330668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etIfJDF3Xscb5GzSs3WOYXorwKZafB8IbhIbN/dUvXk=;
 b=S1usnIYBHoiIjXDFCC6I0UOg8sZSOIH8ACyrI3Gmk2sn5hO30t4werh1yxz3xl2NlT
 dNqAsgR2KxA89hHqZyWCTLaHMSmwkCzvkU1zZit6m5BZ/pxQIhOlgqzfi/e3MQpsIJhh
 O0HCEoEKDdBrR5F+6zelYmQWzbToXEEa6dGGSqpUiW6VAgNEet7Sfx+sjKYSEtSGzo36
 9exhesdD6xvJaqaxQFkbpZvT7phGoM3Jlrh5PhiALkjlLKRXwe3Gaxp2PUsCmZAqcBbh
 fApLm2OPYj9wCk7H44BkIg1h3E8nvitDEgDtdvr1XDJv2SBgdG5cyLHVbM8Z2+pAe73u
 8/CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKtwmTYFFeFadN9XZm35BdQi1C+TUUfpqVJGeAPkHSaYV5bNoqXjES1SkDHl/c7z0FSo7efRU=@lists.denx.de
X-Gm-Message-State: AOJu0YxmlFnUGRNtbjZM2zrZOyYYNwl3kCK7lRh21jJLIg5LU05ZrL1j
 ncDry4Emj/3uLOZx4mbDEg+1F2dKFYzpd6EvmTn0ag6qz/R2ipTfuYAstzlbwqdZWVCcUnKrQ2W
 cK8hSGb9f6Zqg5qawn48act67PugRxKd+0Dn2NjnWDA==
X-Gm-Gg: ASbGnctMWklPp19TyL2k0YrZ+8sW6Pv/wByEn8RUVzLVrgsIV2r6sGTDPJr8/O+dZBg
 Zi+ItYDkNe3IURMH3jCuQjKLwX2IADeGn93x2AL3+RnxUIdR8gcsXqtT8SZ6uaSD3BSxPKk/64v
 Y/6rdtp7HAKgjyOHZ1ZvD4NzUm/G2MG+eEx0kdeIfm928/CLjWnMp9Tnee/64QAbuggYZDHfdFC
 BLIMIQ=
X-Google-Smtp-Source: AGHT+IFMT4TiLODb3cIVLuoxBUylSWm4GU5HcmsnTYAXsPEgeDWVHu8lReE4acz6gzfmmp9K9MLOVyqSHVrb8yraNOI=
X-Received: by 2002:a05:6820:4dc3:b0:613:bd19:54fb with SMTP id
 006d021491bc7-6190c826745mr7125769eaf.2.1753725868313; Mon, 28 Jul 2025
 11:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250721180205.2696763-1-tharvey@gateworks.com>
 <20250724034438.GH18395@nxa18884-linux.ap.freescale.net>
In-Reply-To: <20250724034438.GH18395@nxa18884-linux.ap.freescale.net>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 28 Jul 2025 11:04:16 -0700
X-Gm-Features: Ac12FXzIEK8qW9mPFhgGPyZydiuUlK0klRtW2Ju6KK91auKtX526I-hKPDJqSLo
Message-ID: <CAJ+vNU0bm6ZB3cZP6Az45sNsMZ3QZJEVj7C20yFygF_YSqa5bA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: ehci-mx6: Add i.MX95 OTG support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Alice Guo <alice.guo@oss.nxp.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, peng.fan@nxp.com,
 Stefano Babic <sbabic@nabladev.com>, 
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
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

On Wed, Jul 23, 2025 at 7:34=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wro=
te:
>
> Hi Tim,
>
> On Mon, Jul 21, 2025 at 11:02:05AM -0700, Tim Harvey wrote:
> >When the usb node is defined dr_mode=3D"otg" ehci_usb_phy_mode() is call=
ed
> >to determine the mode from status registers.
> >
> >The IMX95RM does not currently define the USBNC STATUS register but it i=
s
> >assumed to be an omission as the first three registers are defined.
> >It has been expirimentally verified that the USBNC_PHY_STATUS register
> >at offset 0x23C bit4 (USBNC_PHYSTATUS_ID_DIG) reads 0 when USB_ID is GND
> >and 1 when floating.
> >
> >Use is_imx9() as this driver works for i.MX91, i.MX93 and i.MX95 and all
> >of these determine the role based on the USBNC_PHY_STATUS register.
>
> Just a question, does your board use USB2.0 port for SDP? And any public
> patches ready for that?
>

Hi Peng,

Yes, I am using the USB2.0 interface for SDP. Aside from this patch
the usb2 nodes need to be added to the dt (usbphynop, usb2, usbmisc
which are already in kernel but not yet in uboot dts/upstream).

However, unlike SDP on the USB3.0 interface which I was able to get
working, I was getting stuck somewhere between the ATF and U-Boot
proper on USB2.0. I can no longer boot software on my imx95_19x19_evk
after the changes merged for B0 so I'm unable to test and compare
notes at the moment.

Best Regards,

Tim


> >
> >Fixes: 801b5fafd35d "(usb: ehci-mx6: Add i.MX95 support")
> >Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>
> LGTM:
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
