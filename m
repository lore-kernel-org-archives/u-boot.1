Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E349C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 11:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39EF2887B9;
	Mon, 29 Jul 2024 13:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffRiqIMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB0E887B9; Mon, 29 Jul 2024 13:56:06 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C38E887D1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 13:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-368526b1333so933460f8f.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722254164; x=1722858964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aby4Ag03JF9p64tkUSZ0h+rfCqmOzhrnTyDqK5jbv2Y=;
 b=ffRiqIMp08MJMLTdmPPaJEY4kDOMfRLtJ8NFTiV2l6LatHKYaub6jR/r3hO2/dVhJo
 4HSsYnh5xcYzfXOdbKzMZHIsaV74Ds1GBCTFlC0pGSI7yN2VW2I3uUvrbMwZl4OH33W2
 eiPMdS3gCb6t3FRd6a/4efz2Zn/+II1m4ZzFiQhCeXBSc460iYFn0gjcvioslLahsUGm
 WfCbAfGhKNqOFC5/VCT4j9ebjvJJ8nRHGKaWTdW0dqDyLKceBsosnv3kVk/fflVsctZL
 4a3WHm8j8IjKdpr86XNp8fu7A/IqhoIU2KixjragovHRlTP1bZvl1j/6o6PWazCEQLpJ
 E0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722254164; x=1722858964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aby4Ag03JF9p64tkUSZ0h+rfCqmOzhrnTyDqK5jbv2Y=;
 b=bUUkMgDqxwEjO64nLW7/XpUL2gYYvV8Ck6OfbYr10BwuB8hXDhdEZT0oqBS1k6C5uE
 y+iG3TI2Eq6h2JkaO02aq63mVdWsmQU3BJ2lZysP5B4KiDHl223bQO3VwTLcvf9+uF62
 ZLR8DmyxZBoybr7pJXnGUK/NY3EDkZhgQWU7e39te++/c7Axzu5pqepT/6O3yTpRZ9Un
 Ve2W/7ZCkBN/mlI1UTd8w2xEADSYOBw772U/b8KV5axM1DmI0e7XChLTH4/eJTAOkU6u
 TTQcZ7Y5VsGu3nmxDt9iiZyK66Hqn/ASEr5qNrkZMIAWPqRrElpuYWrH2C0VbadslJ/z
 J5sQ==
X-Gm-Message-State: AOJu0YzEXMSBPtB4DsEMTWdRNpmMcv25nYckKiOemFIw/fl5G7Y8/U2S
 uMxlYVle9OM8mZz2QxZhhJ1FGQU1TD6U4QLHuHBE+SMaL74sHRTa9DNtoAoQQsV0uYlRLyeNWwl
 YvZ98SRlZDois+UuZ4JNWCaWShkg=
X-Google-Smtp-Source: AGHT+IHOJDMfOmgHiVQQwyhHcNRiYOrxQH2FrffrVH2TRxetrFber+bq70HzpD6UOh5B5D0HkR9IsK/WVnjyIMdz/1E=
X-Received: by 2002:a5d:6b86:0:b0:366:e9f5:781b with SMTP id
 ffacd0b85a97d-36b5d7d335bmr4786622f8f.21.1722254163483; Mon, 29 Jul 2024
 04:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240626235717.272219-1-marex@denx.de>
 <a73dffe5-87e3-4e96-965f-9d029f2af8ed@denx.de>
 <CAPVz0n0C6TPdBRUEvJmgAUGAKoetuzr1j=0cMXweP2EqMTwn=g@mail.gmail.com>
 <0910419d-e8ab-4bf9-a083-dc2783afaca1@denx.de>
 <4D07A6E5-F156-44C3-A26D-0F2D913CE92D@gmail.com>
 <18d84528-d2e5-41d6-ae1d-109ee30853b2@denx.de>
 <CAPVz0n2Jzfih0Z85TSQbnz-8OrX4D6UN=anKGTJ=hckRt8f3xA@mail.gmail.com>
 <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
In-Reply-To: <a95f0d60-2883-4c3d-8a53-ee3ef414cc32@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 29 Jul 2024 14:55:52 +0300
Message-ID: <CAPVz0n3Ji1sKQK+Lnq8rP3ZqwX3o-kXe2btj93UuVBa3T5C=qw@mail.gmail.com>
Subject: Re: [PATCH 1/4] power: regulator: Trigger probe of regulators which
 are always-on or boot-on
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

=D0=BF=D0=BD, 29 =D0=BB=D0=B8=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 13:42 Mare=
k Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 7/29/24 7:38 AM, Svyatoslav Ryhel wrote:
>
> [...]
>
> >> The PMIC is on I2C, DM_PMIC enabled in SPL, both buck4 and buck5
> >> regulators are enabled in SPL, have regulator-always-on and
> >> regulator-boot-on and bootph-pre-ram properties.
> >>
> >> This seems similar enough, right ?
> >>
> > Yes, though SPL must remain as small as possible and you propose add
> > there i2c driver,  PMIC driver, PMIC regulator drivers, PMIC GPIO
> > drivers along with relocation of all this stuff. It is not optimal at
> > all.
>
> Sure, if you do use DM_PMIC for PMIC on I2C bus, then you also need
> DM_I2C . You can also do non-DM PMIC configuration in SPL, non-DM in SPL
> is allowed.
>
Thanks for explaining an obvious stuff, it seems that we are talking
on different languages.

> >> What is the problem you observe on tegra 3 ?
> > i2c line fails since it probes in spl with your patch, but it does not
> > relocate and then probes once more after relocation. Probe fails along
> > with all devices on same line.
>
> Could it be that you either have to:
> - Add DM_I2C to tegra 3 SPL
> - Remove bootph-* from DT to remove the regulator node from SPL
> - /delete-property/ regulator-always-on; and /delete-property/
> regulator-boot-on; in -u-boot.dtsi to prevent the regulator from being
> enabled in SPL ?
>
Obviously NO, you propose nonsense. Same dts is used for both stages.
And I have to add hack-ish stuff just because you wanna introduce code
which causes known regressions.

> regulator-always-on means the regulator has to be enabled
> unconditionally, and the system software has no other way to test
> whether the regulator is enabled but access the PMIC, so that is why the
> regulator is probed, even if it is early.
Thanks for explaining an obvious stuff, it seems that we are talking
on different languages.

Anyway,

"We must not probe things as we go. There might be other
dependencies not yet bound. It may also take some time. This is not
following driver model design, sorry.

So please think of a way to do this properly."
