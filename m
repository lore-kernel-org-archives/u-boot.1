Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAB1E784A4
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 07:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27BC787133;
	Mon,  2 Oct 2023 09:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="tf/oe9kr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D7CB87136; Mon,  2 Oct 2023 09:17:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 112168712C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 09:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696231041; x=1696835841; i=frank-w@public-files.de;
 bh=rIq6xYiyLGPyLFM0KFpx36P1bC1i9t6O6NTGOMiZ19U=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tf/oe9krsPZ6KreSRrcNXKiTqVJUTignefTowT7BTHToL7bhYw+99epVA+O9sRHdDabcVuk1voT
 UflGYoW5WMXIACePuuaHfc5rPq8oi+ArdNcKXa68P11SDcplVdETfegNIHcOgpaPZ5rwKoohzI/kr
 MrOx3rJ9OSEdi2CeRXjYMo4E93+u2nhw+g7zOrtLlNUkzrpYLZ5sCmEnIicOqt1sERaV3H6K/ss7G
 4jP7u68UpgZBwQE97U8z6BKvfu4x5NYV3UCOCVxkYpUfIjSacgnieQe9TwzZF4BIlS+HrvHiVahYh
 WU8OqibKGxvxa++DaB0tof5dFqjwLMscaxWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.132] ([217.61.157.132]) by web-mail.gmx.net
 (3c-app-gmx-bap51.server.lan [172.19.172.121]) (via HTTP); Mon, 2 Oct 2023
 09:17:21 +0200
MIME-Version: 1.0
Message-ID: <trinity-b84ddad3-528c-4117-8726-f211e21a42f6-1696231041552@3c-app-gmx-bap51>
From: Frank Wunderlich <frank-w@public-files.de>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jon Lin
 <jon.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, John Clark
 <inindev@gmail.com>, u-boot@lists.denx.de
Subject: Aw: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcation
Content-Type: text/plain; charset=UTF-8
Date: Mon, 2 Oct 2023 09:17:21 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20231001191150.pydmtyqg4wtbri5k@mercury.elektranox.org>
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
 <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
 <2a605926-3d85-12fa-76db-2fa8d18b03dd@kwiboo.se>
 <20231001191150.pydmtyqg4wtbri5k@mercury.elektranox.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:jOOIdHVM5jGyalPypcGW/AEhtAYk5JL5kd3ukav3r+yrZB8h199eIXoUP5XFs0A62LkJB
 0YtQC5Q1ZemLBdahmbHco8jluOSK9nJ4ue6Yc7tmNYh0hoxT0Iht7qAtkIrEJV1oGwz8sA9640Se
 1lgn1o99sHf2IkeF1Luvj/mkEunaHLCQfP67SL07tEPspYCLQkoJrBsHsCIHt6RXKTd45NCiHs9h
 XUlliD8OO/kkAhXZGynvjivqF4PDPnSkDzxCVoRKNxUyYtHFpitgWGx5XkByY5j2LeFAk34FSksF
 vw=
UI-OutboundReport: notjunk:1;M01:P0:Wc98hQ+o65Y=;5wBvyAgTYEryPOtpvcYuwvdmog+
 mCpwRZv3g6T/XGK/8dtgPARp7P/1iP49U2k/E418XaGaVxRnDHeQhZ+Py2430/qIxBWm0ZfQj
 LazIUrhQwKI4wzrQ+F/jG8eUaKYMDxn1wNqG1LjUeo4jJyRxjfh1VyscoGuot3KkW5VJfNnYn
 cLNXoAW8sBHkWFQzjEVrROFcXSSzJtXuhbF2JCnJbsuJE2cz1D6Xj1k2xkMYYtx5VDclUaYHw
 BQRdJaYJTCaGuOcGTV/n2EYEbS2CGNVl469MkNZ80Rd9ZDlBmhqD0wBLDijTYHTgRW+EAAaEW
 Nf5zBw5/nWCgyE87DbIPtLDzmsHMKOaNdyfiaDpiqj/6otuFRD7kQQnn8/S/9lvVzvzlfn1qu
 jdAsqqsQfd3SGUqH89WGHnSFH5mBN99Zd8Y7AYSSv3Jmrb6pIzyfjjekZwDtikdJFXLzcJCd4
 xXF11pFBUjhM+//kKJVm7xQB1YSsTPpLSmf8TiN7JdhChYRtfKXVTqsPl0Pk16Ee9y1wEhFLC
 h+MUONE1kTlgrHG5pj1obrQ0KeMNdZlaBMBPJSot8cy0niEzf/Kwzp12Vwdv1cMjVCnRrvpXj
 PgL8lTCe/VanoRGkwMrhfmHlrAUqeJHR3PjwnqLpto2SGvn6Gz3MHWYSaaSdsotzG+cXaW+sH
 iUoz3FD9gqbzFoJDqVTHVUGTQ04exNtYc1MD8/I0hm6OSlFxFNF7loQo63CXm4yTB2Zvotif2
 DdDajoKWZ5LuboOUDJygAgmChepS4YfbehFWz3mOBrCWkHAgnj6RgffMESjI6KeatPUH2fWxP
 XdBb9ugQZ//sW0Oowfumi8Jg==
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

Hi,

> Gesendet: Sonntag, 01. Oktober 2023 um 21:11 Uhr
> Von: "Sebastian Reichel" <sebastian.reichel@collabora.com>
> An: "Jonas Karlman" <jonas@kwiboo.se>
> Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Simon Glass" <sjg@chromiu=
m.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Eugen Hristev" <eug=
en.hristev@collabora.com>, "Jon Lin" <jon.lin@rock-chips.com>, "FUKAUMI Na=
oki" <naoki@radxa.com>, "John Clark" <inindev@gmail.com>, u-boot@lists.den=
x.de
> Betreff: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurcatio=
n
>
> Hi,
>
> On Wed, Sep 27, 2023 at 06:07:59PM +0000, Jonas Karlman wrote:
> > Above works with this series in U-Boot and also in mainline linux. Not
> > sure the RK3588 bifurcation part of driver have been verified on real =
HW,
> > rk3588 boards available for testing have typicality not used bifurcati=
on.
>
> Upstream kernel bifurcation code looks ok to me. It's quite different
> from Rockchip vendor implementation, which might have confused Kever.
> I also missed this when having a quick look initially. As you said
> Rock 5A, Rock 5B and EVB1 do not use bifurcation, so no testing happened
> on our side.

my Bananapi R2Pro (rk3568) uses bifurcation and it is working in mainline =
Linux, but not yet in uboot.

posted my test-results here:
https://patchwork.ozlabs.org/project/uboot/patch/20230918173624.31464-1-li=
nux@fw-web.de/#3183519

regards Frank


