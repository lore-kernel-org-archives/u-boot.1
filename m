Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAB0E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 12:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5762863F8;
	Mon,  9 Oct 2023 14:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=londelec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=londelec-com.20230601.gappssmtp.com header.i=@londelec-com.20230601.gappssmtp.com header.b="q+DxFXo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CF5D8692B; Mon,  9 Oct 2023 14:46:04 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7308C863E3
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 14:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=londelec.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=alan@londelec.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59f4f80d084so53212337b3.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=londelec-com.20230601.gappssmtp.com; s=20230601; t=1696855557; x=1697460357;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIDIWImADYFPWv4z5lMZb1JLDIb1MwJ9Kt0/bcMsRQE=;
 b=q+DxFXo24qV9SM5E26V8XWr2D17u0qN7B73buimG3Xw8bbLXoBQntQqD4MmdV4KJkj
 f47CkBZ6a6NlwcU0IlyP8E9JX+0c582/AQW3oAVSd87GQTiTE802On+rjHbopnfw2czy
 sUqygBdY+/1vRGrKlJMzr8sVrTNCLkObvgYZ9YFcovg5enpUs4XnVuLTk1DZio7Uhzu6
 JbLJTIw0wegQq2c1bHuXpY15IVkS+PyG3ucbs+bj4dC2rqkUuvBgHNa+5xQAxHyF6/MO
 gGQHnH/wCgapi7KMwCHlj/OvKbXp4G3cc7OoJzMRA6SyHWTFDf+QdiwJ+VDaGI82H9eN
 jQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696855557; x=1697460357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HIDIWImADYFPWv4z5lMZb1JLDIb1MwJ9Kt0/bcMsRQE=;
 b=a0WHKZ1Jyjo8QaIpso29b8vGudnxkDxtmtRlGePuuz0SJBWIqt//wLGpvQ73bwxAB6
 d5/jqCPwZ2nXAIGHxvBmISdiB+OMazYXNpPbS4yBryZ8cyvOx+iOaddCXhqVcd2Ea0X0
 +SXVGFxtJb/Xq4pEQoQQzA7JUVf2fti8SGzDFX0ocPRzihBLm/2oDW6DF4ANOQeprxLl
 VG+1oXn4S8L3dmO9cidJK0i4g5d4sFAlMoyJmjYbvqmnnr7d3wgvFHbki/QUy9fHnMh8
 p0RiAS9HGEYkbWhXaXJknrdz8csmZfK02H5uvxEadLyK0UmtrofYu+m4DK5kN/BlIGvp
 UgRw==
X-Gm-Message-State: AOJu0YzodG9P/2ksnmaopNUboTOG+x4Is5vl1coOSnBZSCTLFyjAYAOi
 SgUU1N1NL7ZLVJD8roZV77nawXYTsp42F07MtjJJLw==
X-Google-Smtp-Source: AGHT+IE/rcxWs5eWRmsWgS5nUz7PyHg1UkM+OjDd5PxX5hkYb0Kgqf+hcxjlp6mJbQKlIykgcZEdwD2lXhC9QStUi3g=
X-Received: by 2002:a25:8d85:0:b0:d0c:110b:2f17 with SMTP id
 o5-20020a258d85000000b00d0c110b2f17mr12972027ybl.53.1696855556490; Mon, 09
 Oct 2023 05:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220830174932.96360-1-alan@londelec.com>
 <CAOMZO5BJyoxUTBuygdL7tOyzJfRGJT1BQHJ_r0qAD8jYfC+CbQ@mail.gmail.com>
 <20231009094924.56042353@wsk>
In-Reply-To: <20231009094924.56042353@wsk>
From: Alan Kay <alan@londelec.com>
Date: Mon, 9 Oct 2023 13:45:45 +0100
Message-ID: <CAFQdmxK-TdWajPzZnCGGNr_rWKbNL=6gYfmDOKBRxGd9nrHK1A@mail.gmail.com>
Subject: Re: [RFC PATCH] mxs: Don't enable 4P2 reg if mx28 is powered only
 from DCDC_BATT without 5V
To: Lukasz Majewski <lukma@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, cody@londelec.com,
 Stefano Babic <sbabic@denx.de>, 
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 09 Oct 2023 14:49:04 +0200
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

Hi Lukasz,

On Mon, Oct 9, 2023 at 8:49=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wrot=
e:
>
> Hi Fabio, Alan,
>
> > Hi Alan,
> >
> > [Adding Lukasz and Cody]
> >
> > On Tue, Aug 30, 2022 at 2:49=E2=80=AFPM Alan Kay <alan@londelec.com> wr=
ote:
> > >
> > > mxs_power_enable_4p2() was added to mxs_batt_boot() in
> > > 'commit a0f97610757d ("ARM: mxs: Enable DCDC converter for battery
> > > boot")' to enable DCDC converter when board is powered from 5V and
> > > has detected sufficient battery voltage.
> > > This involves enabling 4P2 regulator and there is a code
> > > in mxs_power_enable_4p2() that disables VDDIO, VDDA, VDDD outputs of
> > > the DCDC converter and enables BO for each power rail e.g.
> > >
> > >         setbits_le32(&power_regs->hw_power_vddioctrl,
> > >                 POWER_VDDIOCTRL_DISABLE_FET |
> > > POWER_VDDIOCTRL_PWDN_BRNOUT);
> > >
> > > In case the mx28 is powered by the 5V source and linear regulators
> > > are supplying power to the VDDIO, VDDA, VDDD rails there is no
> > > issue.
> > >
> > > However if the mx28 is powered by the DCDC_BATT source only without
> > > 5V, disabling the DCDC converter outputs causes brownout power down.
> > >
> > > The proposed solution is not to call mxs_power_enable_4p2() at all
> > > if the mx28 is powered by the DCDC_BATT source only. There is no
> > > reason to enable 4P2 regulator in this case and setup of all
> > > registers is done in mxs_batt_boot().
> > >
> > > Also there is no need to enable 5V brownout in
> > > mxs_power_init() in this case.
> > >
> > > Please consider if this is acceptable and I will submit a proper
> > > patch.
> > >
> > > Signed-off-by: Alan Kay <alan@londelec.com>
> >
> > Cody also sent a fix for this issue:
> >
> > https://patchwork.ozlabs.org/project/uboot/patch/20230703163340.101490-=
2-cody@londelec.com/
>
> Isn't this already addressed with:
> https://source.denx.de/u-boot/u-boot/-/commit/79230640cb4fb780e2be9bb9a47=
b31976b18cac4
>
> Please also look into the recent patches for imx287 (xea board for
> reference):
>
> tig -- arch/arm/cpu/arm926ejs/mxs/spl_power_init.c
>
> At least SHA1: 65b9b3462bec2966911658836983819ab4e4823e
>
>
> Best regards,
>
> Lukasz Majewski
>
> --
>
> DENX Software Engineering GmbH,      Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

The patch:
https://source.denx.de/u-boot/u-boot/-/commit/79230640cb4fb780e2be9bb9a47b3=
1976b18cac4
does fix the issue, please feel free to discard my patch, thank you.

Best regards,
Alan Kay
