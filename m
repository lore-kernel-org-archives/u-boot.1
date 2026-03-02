Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53540EA4E04
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAAA83F2D;
	Mon,  2 Mar 2026 15:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdvRjtxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13E383F30; Mon,  2 Mar 2026 15:46:19 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5DE383F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so40359085e9.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 06:46:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772462777; cv=none;
 d=google.com; s=arc-20240605;
 b=Ts4b79ffz2Ql3e0oorWr7HZOQc5saut9qcva+gdz9xKDz8beiXu4ceIxWxJP8fiOmU
 xT7Q+oQjRd2aLfYNwfLFTN3uBZx1n2Ca/o76/hM9PkKEZmEmn6yMW51MeQo7a2drq+dX
 X9E+MhwIbfnC50bRdqQXGtSFLXe3LSaNk7M6gK7RTCXD5ZviplADEOMCbo47Bf24wxT5
 y4ijrGOf87HbnL6jUR4VbN9rIiDSbAgLFGeNuFPl5auMaqIWUOMiCyYEtoQTF9nyVjxH
 NvfE7QK/J6O2k+cHT4dGmnYIU579VzYNI+zBn+cyf4NhotFhG9LzcHIViXWH28CQQhQ7
 kDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WdKCf++aKONJeC9NnvPX07T+IMTGqacsRQed4Hk4G1I=;
 fh=MzOTD4Jyp7DqRKVk1Fn9Q2oUhuNCYAKEgf6KuGKrnS0=;
 b=YyJJQrfgI+ntKJDYVsZTu0aEb5pf0B18YpQVIaoOXIAtVoG2KOUvsrGXN+um9PkOgR
 gXaR71XRwfBV+7UZ1v2Ee+NXCP0Tm2Gdf8547e5oE+g+lWjAdZLrldLiTEMuCM4mfxtP
 G9MWusSxS2hFgYnNBqkcLgybYya3La71JS5b7Jq235PGiNbrWNoFRVKtuO699rc4CjdP
 X0aq0P8U0Eo2UAXVUmpeensZyGQFakkwvQRhBKf9XxHeB0F+zpn9PHm2WOO0B2AmdKa4
 j3der0+CGLfOCJuGVrE9UEYzsKYKc1+Dh0m4U09+5l0ekJmG7siK5P+657aKQF7n60B9
 k1Ug==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772462777; x=1773067577; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WdKCf++aKONJeC9NnvPX07T+IMTGqacsRQed4Hk4G1I=;
 b=BdvRjtxIgiRu+iQKq1EnCtqDZ5C1IXDnSBvgpp7HM6GR+PDXcf92aTIxXa2fdPTM7k
 BbnR1pboF79YKg3ZghtmBCR9JawGwznhe7zotpimHmdyzfO3gFPxHM48pG08M3TQPkb5
 uwJClD72xeZIoRYZquwGW9ZD/0RNslVx3sbukutl0XqvTB2X7eecQGM4nStlSEaeLd7s
 aKYdTLowXO1hGWGuDTrI0UE+P1eT5B0HO7MbLhM2a6zyEdPzjZ73EeiREv1+4hIUacw/
 aG0k900F+k+3+Rd/sKNg858XnnoFo9tAv/KmAD5nWAbEaoYsFnEtFkcwjvSZU6nr50C4
 ewfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772462777; x=1773067577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WdKCf++aKONJeC9NnvPX07T+IMTGqacsRQed4Hk4G1I=;
 b=klaozw1SQxzuTp9Us0Cqul1Qwbt05pqEQU1GfTk9qYtUnoLFWxAbXgTWy17Xu39L15
 FpwZhpSXzjHRsr/+q8ohEeDgcHLJBDleFzAWUSAojjyLz7qgiNA3b6vF//BKlJwBh/Oj
 s9LCgGdT9L8J5vj3pr1ZdUJa8+t7S+PtYbTVFE/Soh8JxwcaKyEjSjE5MkLRCl95em84
 1EX3u7oHG6YWB1u7LQinkFFEQiOk8S7otCPKWKNPW6yWulYiW7zyljES3vd7IrdnbMjt
 hFKH+RKSxyrRWwgDyCeNXfHY1jLshm06iCcESrkE2WxjThtxbH1BqiCte6EusrMsfYfM
 7dPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Jt/6xbSoua9a3I/MJLnXhIqN3bdZRkrdwo3erN33W72xFULZwejkWYI+91PUzk70YLcmA3A=@lists.denx.de
X-Gm-Message-State: AOJu0Yye2QEJcXuzpdQAjeAqts7o59xTH2rNGWAV5iQnkTDCMvSqQ0AS
 bCmKLxKfu50pQ2ve75V8MqtitFffiC/PFKz5tJ6QBeqkf/SIF0BkwHO4RVzMnqd3sv6Mj4HBq+f
 LGmeYt5UhF0AQ+Ymz2UrCFFa62zdX4jU=
X-Gm-Gg: ATEYQzwNAXXVIT1qkQAG/r8rSWwYCsSX+c+9Eb35u3N2cu0yKl2vAalGUfG179JZCrr
 xGtA40kUGBAeSrhy2oJq0i4d+Coi+G2G9e7C+anTKahrlSz0dy2OkfgK/lXBrFA7cBz66fNbIZR
 NDbclBHZC4jKda+HVGoPB1IDkkRJEnL7ed9X4oOlT8aHAZ3gVbClw0U8iO+8pyxtiAQ5t7f6b53
 k/heygKM45+5hRoTW6r6Kpzj9yjaycOv7LliLemgyF4PKJfOYhpvQLkF7aThJ6djQmnRPXjv/rI
 oXSwmdB5
X-Received: by 2002:a05:600d:15a:10b0:47e:e452:ec12 with SMTP id
 5b1f17b1804b1-483c33eb068mr216665045e9.15.1772462776956; Mon, 02 Mar 2026
 06:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20260209183948.34807-1-clamor95@gmail.com>
 <20260209183948.34807-2-clamor95@gmail.com>
 <564aefbb-f2cc-4409-a9ed-a599f517fe51@cherry.de>
 <CAPVz0n1xP_HV70RZaBNXMgNdyo+nEbMc2DcfTeDPoXUweH6Dzg@mail.gmail.com>
 <811c948b-2314-4025-b0a3-af36f48d54a8@cherry.de>
In-Reply-To: <811c948b-2314-4025-b0a3-af36f48d54a8@cherry.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 2 Mar 2026 16:46:05 +0200
X-Gm-Features: AaiRm52261Dt6LfydwHNnKGsW_uZGRFZ9-OvKoGAbSWXCvowC_mvqzl0pK99QUo
Message-ID: <CAPVz0n0R06iS9MPktBW85LTdO2u+z-XwSJo7C5VnLRO_9iwHSQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] power: pmic: enable sysreset function with device
 tree property
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.denx.de, 
 Andy Yan <andyshrk@163.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, 
 Christian Hewitt <christianshewitt@gmail.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>
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

=D0=BF=D0=BD, 2 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 16:38 Quent=
in Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On 3/2/26 3:24 PM, Svyatoslav Ryhel wrote:
> > =D0=BF=D0=BD, 2 =D0=B1=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 16:13 Q=
uentin Schulz <quentin.schulz@cherry.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hi Svyatoslav,
> >>
> >> On 2/9/26 7:39 PM, Svyatoslav Ryhel wrote:
> >>> Add a condition to enable the PMIC sysreset function via the
> >>> system-power-controller device tree property in addition to the exist=
ing
> >>> Kconfig dependency, provided the PMIC supports it.
> >>>
> >>
> >> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # RK8xx
> >>
> >> I've added in Cc people who have contributed to devices that will lose
> >> support for sysreset once this gets merged.
> >>
> >> Because they are missing a system-power-controller property in the RK8=
xx
> >> PMIC Device Tree node, the following device trees will be impacted:
> >>
> >> dts/upstream/src/arm64/amlogic/meson-g12b-odroid-go-ultra.dts
> >> dts/upstream/src/arm64/rockchip/rk3326-anbernic-rg351m.dtsi
> >> dts/upstream/src/arm64/rockchip/rk3326-odroid-go.dtsi
> >> dts/upstream/src/arm64/rockchip/rk3399-evb-ind.dts
> >> dts/upstream/src/arm64/rockchip/rk3566-anbernic-rgxx3.dtsi
> >> dts/upstream/src/arm64/rockchip/rk3566-powkiddy-rk2023.dtsi
> >> dts/upstream/src/arm64/rockchip/rk3566-powkiddy-x55.dts
> >> dts/upstream/src/arm64/rockchip/rk3588-coolpi-cm5.dtsi
> >> dts/upstream/src/arm64/rockchip/rk3588s-coolpi-4b.dts
> >> dts/upstream/src/arm64/rockchip/rk3588s-indiedroid-nova.dts
> >>
> >> If it's an oversight, you may want to add the property in a -u-boot.dt=
si
> >> and upstream the property to the kernel DTS to avoid carrying it
> >> forever. From my side, this patch does what's expected based on the
> >> (lack of) presence of the property so this is a green light for me
> >> regardless if the above Device Trees are actually wrong.
> >>
> >> As far as I could tell, the sysreset driver only implements the powero=
ff
> >> functionality which can be called by either the poweroff CLI command o=
r
> >> the efi_reset_system_boottime function (no clue when/where this is
> >> called, some EFI thing I guess).
> >>
> >
> > I actually expected such an outcome. If you are fine with it, I will
> > drop the Rockchip PMIC change for now. It would be quite unpleasant if
> > a bunch of devices suddenly lose their reset function, especially
> > since updating upstream trees can be a long process. Once the trees
> > are updated, anyone working with Rockchip can submit a similar patch.
> >
>
> Well, how does one know whether the property is not there because it
> shouldn't be there (the PMIC shouldn't/isn't capable of controlling the
> system's power state) or because it's missing?
>
> As far as I'm concerned, we can keep the RK8xx part in this patch. We
> shouldn't need to account for broken Device Trees so we can only assume
> the aforementioned DTSes are correct. The U-Boot-specific Device Trees
> all contain the system-power-controller property so those are fine.
>
> As for the DTSes coming from the kernel, they probably would have
> noticed by now since the kernel also adds a poweroff (sys_off) handler
> (and for a few PMICs a restart handler too) when this property is
> present. Thus, this patch syncs behavior between Linux's and U-Boot's
> implementation.
>
> I'm fine keeping this, I just notified other users in case they didn't
> know about the property and want to add it to their device. It shouldn't
> block this patch though in my opinion.
>
> Note I am only speaking about devices with RK8xx PMICs, I haven't
> checked for the other PMICs touched by this patch.
>

Ok, then I will keep the RK8xx part. Regarding the other PMICs, those
were added by me, and the devices that use them are also managed by
me. Additionally, adding system-power-controller complies with the DT
schema for the affected PMICs.

> Cheers,
> Quentin
