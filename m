Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160E7E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 09:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1075D870AD;
	Mon,  2 Oct 2023 11:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="nGk6ecT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80978870E3; Mon,  2 Oct 2023 11:03:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8BB86D6C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 11:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1696237394; x=1696842194; i=frank-w@public-files.de;
 bh=X853hm40aNRRISuVznttoY+f+y57vlIuswyoJBHGb38=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nGk6ecT9cW+LYs87clwyMFHHGE1nY5SvN5o309BaxbKUtpCPaUb0yI/3aynt891t0+PHXUZkIzY
 p8lUGT2HNMnJ+NONITRMNG5pw/3JNgJnOXl3A8+hhnliqVAzzk8jamV+1JY9G5SB2jIdo4BfMNEJl
 Sy7Z4++Srq+iHDV7qXJs7FaboY2McpFn0PZVXpP0+LHRWziJCAYl/THtBZ+RXik65F7Giuq7Gb+LE
 i7BDwmGgIFmAZDFxvESMk2NfuiAidKlsgvaUNBHX5Et2w0bPNb9jYDJAkqjUTM10gU44eyqUwDFom
 rZybJLY6ebEU8N+oODlgvlicQLu2IwbKsIaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.132] ([217.61.157.132]) by web-mail.gmx.net
 (3c-app-gmx-bap51.server.lan [172.19.172.121]) (via HTTP); Mon, 2 Oct 2023
 11:03:14 +0200
MIME-Version: 1.0
Message-ID: <trinity-66df2c9f-38f5-45d0-b5c5-105a807a9975-1696237394239@3c-app-gmx-bap51>
From: Frank Wunderlich <frank-w@public-files.de>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Jon Lin <jon.lin@rock-chips.com>, FUKAUMI
 Naoki <naoki@radxa.com>, John Clark <inindev@gmail.com>,
 u-boot@lists.denx.de
Subject: Aw: Re:  Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe
 bifurcation
Content-Type: text/plain; charset=UTF-8
Date: Mon, 2 Oct 2023 11:03:14 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <3e3de175-33f3-1fc8-3406-4a3ee4db8830@kwiboo.se>
References: <20230802190424.2963185-1-jonas@kwiboo.se>
 <21678211-14b2-ce5c-820a-c69426725d65@kwiboo.se>
 <29f01214-04f4-8a38-96f3-75df13bda7fa@rock-chips.com>
 <2a605926-3d85-12fa-76db-2fa8d18b03dd@kwiboo.se>
 <20231001191150.pydmtyqg4wtbri5k@mercury.elektranox.org>
 <trinity-b84ddad3-528c-4117-8726-f211e21a42f6-1696231041552@3c-app-gmx-bap51>
 <3e3de175-33f3-1fc8-3406-4a3ee4db8830@kwiboo.se>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZG2BH6+dB+F0ltgoph8UBUvdb0DqVtSuoriJNyWpPOlRuxIM4glg2UB49upCJz/BydvPI
 xghjXK+C7j1JCOnbZV7WWQg6EpFHjDCj52/7R/BxBQKVoDl3VxfEfp11nnfdD0RurMkhQdoib9ol
 spvre4faktdzc1PcIlyk62RDcW9ufuXuwKcyaIH9a8YIb0Z5Vv6Vy3pUaAEQmH/B0a5sBNVVsHGK
 zORtd7jH5SXwCQR0UoBu/hasxfrfGcaCwzC2wg/HIC0eKkA2u/8T5P/GR8qDW5+6Yrl87J6iF7fm
 +I=
UI-OutboundReport: notjunk:1;M01:P0:cKLGTyJdu0s=;WzyMIZY+hPZAD75F4SDNXm/7pCm
 sJ3IBMjgEkpuUOkMEJ77qqnmHb1IrFMIOqUZHuc7gQp9Wy3WLqPrff0thbd5sWVGTtI+tN4HX
 p8ds1IPT/VnrvDjEcqOSfoQf0Y7037rbHWIs5L5WlSNOXxj3ds/uvblhM0RRqvQ5NRR/BpnMT
 h76AUq/0FSrqYfUOiujscUS9fSCph1348oAxuuduGH5EgcISVUSK6QFYIAxCxKo05asVX33uP
 SfBjh7HBqZ32p8yqMf3/xjHF+EmXTlaedMCAPHcyTqY2dpfp4Hez4GyvsQglHsxxgO7fYjrzO
 4IVrhazCoq5meB511Lp8JZldy7AT4JTVLIaps/Co+swZtqJmBFIMMCM+CZplB7AStQZCZWT/w
 J9Qu9RBHstIPuS931JCyAIYWhD5OuprKkOiR/mz+zVFVaCZnM/6CRQsTbg9y5oohMmme6MLpZ
 RflYEmM3FFAGIEGUVVS1uk9Jzj+VVhv/eWolWSkY4KO/Y9qCV7fj38QO/x+R6MZxT2tUyYzje
 CE67Pr4enEu7QiHQKPNV+YgnbIqGyz+7Uj+PgWpjWjXGmxJiqWt+D1hTDvjVsnhAufKkJiRmp
 3U8JYqpCsAjAozq2HNr1kZXjptaef80tEOZ9HNy+dVQX+t+7bZ85+ZUYPZfz7d3CcSeq0GSOF
 SkMohoSwmoxEy14WIrRHP/UWedoznhmCOSZZHw9p6BkZrSrjJBXQj7etxT8tu/96XPeYhxS9i
 q3atqRBq4BFO0H69LvRS6bkwhoCBElucxkckp5hs9wFlTn5dz6Ca3FVFmp3q9vHjZO1FjgaNp
 rtMJnvpO/IvbW1NVQDsKGADsGDlJARdDnA3ebtAAHSrww=
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

Hi Jonas,

> Gesendet: Montag, 02. Oktober 2023 um 10:33 Uhr
> Von: "Jonas Karlman" <jonas@kwiboo.se>
> An: "Frank Wunderlich" <frank-w@public-files.de>, "Sebastian Reichel" <s=
ebastian.reichel@collabora.com>
> Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Simon Glass" <sjg@chromiu=
m.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Eugen Hristev" <eug=
en.hristev@collabora.com>, "Jon Lin" <jon.lin@rock-chips.com>, "FUKAUMI Na=
oki" <naoki@radxa.com>, "John Clark" <inindev@gmail.com>, u-boot@lists.den=
x.de
> Betreff: Re: Aw: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bi=
furcation
>
> Hi Frank,
>
> On 2023-10-02 09:17, Frank Wunderlich wrote:
> > Hi,
> >
> >> Gesendet: Sonntag, 01. Oktober 2023 um 21:11 Uhr
> >> Von: "Sebastian Reichel" <sebastian.reichel@collabora.com>
> >> An: "Jonas Karlman" <jonas@kwiboo.se>
> >> Cc: "Kever Yang" <kever.yang@rock-chips.com>, "Simon Glass" <sjg@chro=
mium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Eugen Hristev" <=
eugen.hristev@collabora.com>, "Jon Lin" <jon.lin@rock-chips.com>, "FUKAUMI=
 Naoki" <naoki@radxa.com>, "John Clark" <inindev@gmail.com>, u-boot@lists.=
denx.de
> >> Betreff: Re: [PATCH v2 0/7] rockchip: rk3568: Fix use of PCIe bifurca=
tion
> >>
> >> Hi,
> >>
> >> On Wed, Sep 27, 2023 at 06:07:59PM +0000, Jonas Karlman wrote:
> >>> Above works with this series in U-Boot and also in mainline linux. N=
ot
> >>> sure the RK3588 bifurcation part of driver have been verified on rea=
l HW,
> >>> rk3588 boards available for testing have typicality not used bifurca=
tion.
> >>
> >> Upstream kernel bifurcation code looks ok to me. It's quite different
> >> from Rockchip vendor implementation, which might have confused Kever.
> >> I also missed this when having a quick look initially. As you said
> >> Rock 5A, Rock 5B and EVB1 do not use bifurcation, so no testing happe=
ned
> >> on our side.
> >
> > my Bananapi R2Pro (rk3568) uses bifurcation and it is working in mainl=
ine Linux, but not yet in uboot.
>
> The issue on your Bananapi R2Pro is most likely not related to the
> pcie bifurcation code added in this series.
>
> The coded added in this series works same/very similar as on mainline
> linux and fixes bifurcation use on devices such as Radxa E25 and NanoPi
> R5C/R5S.
>
> Please clarify if pcie work in mainline linux when booting with mainline
> u-boot, or does it only work when booting with vendor u-boot? (in case
> vendor u-boot set different/default pinconf).
>
> >
> > posted my test-results here:
> > https://patchwork.ozlabs.org/project/uboot/patch/20230918173624.31464-=
1-linux@fw-web.de/#3183519
>
> From your pci enum command I only see an expected pcie@fe270000 (ngff)
> link fail. Does it also print out link fail for pcie@fe280000 (minipcie)=
?

good catch, you're right, no message of mpcie, only ngff (no card)

#initial status (before enabling pcie-related regulators)
BPI-R2PRO> regulator status
Name                 Enabled            uV         mA Mode       Status
vdd_logic            enabled        900000          - -          0
vdd_gpu              enabled        900000          - -          0
vcc_ddr              enabled        500000          - -          0
vdd_npu              disabled       500000          - -          0
vcc_1v8              enabled       1800000          - -          0
vdda0v9_image        enabled        900000          - -          0
vdda_0v9             enabled        900000          - -          0
vdda0v9_pmu          enabled        900000          - -          0
vccio_acodec         enabled       3300000          - -          0
vccio_sd             enabled       3300000          - -          0
vcc3v3_pmu           enabled       3300000          - -          0
vcca_1v8             enabled       1800000          - -          0
vcca1v8_pmu          enabled       1800000          - -          0
vcca1v8_image        enabled       1800000          - -          0
vcc_3v3              enabled             0          - -          0
vcc3v3_sd            enabled             0          - -          0
dc_12v               enabled      12000000          - -          0
vcc3v3_sys           enabled       3300000          - -          0
vcc5v0_sys           enabled       5000000          - -          0
pcie30_avdd0v9       enabled        900000          - -          0
pcie30_avdd1v8       enabled       1800000          - -          0
vcc3v3_pcie          disabled      3300000          - -          0
vcc3v3_minipcie      disabled      3300000          - -          0
vcc3v3_ngff          disabled      3300000          - -          0
vcc5v0_usb           enabled       5000000          - -          0
vcc5v0_usb_host      disabled      5000000          - -          0
vcc5v0_usb_otg       disabled      5000000          - -          0
BPI-R2PRO> regulator dev vcc3v3_pcie
dev: vcc3v3_pcie @ vcc3v3-pi6c-05-regulator
BPI-R2PRO> regulator enable
BPI-R2PRO> regulator status
Regulator vcc3v3_pcie status:
 * enable:         1 (true)
 * value uV:       3300000
 * current uA:     No data available (err: -61)
 * mode id:        Function not implemented (err: -38)
BPI-R2PRO> regulator dev vcc3v3_minipcie
dev: vcc3v3_minipcie @ vcc3v3-minipcie-regulator
BPI-R2PRO> regulator status
Regulator vcc3v3_minipcie status:
 * enable:         0 (false)
 * value uV:       3300000
 * current uA:     No data available (err: -61)
 * mode id:        Function not implemented (err: -38)
BPI-R2PRO> regulator enable
BPI-R2PRO> regulator status
Regulator vcc3v3_minipcie status:
 * enable:         1 (true)
 * value uV:       3300000
 * current uA:     No data available (err: -61)
 * mode id:        Function not implemented (err: -38)

BPI-R2PRO> pci enum
pcie_dw_rockchip pcie@fe270000: PCIe-0 Link Fail
BPI-R2PRO> pci 1
Scanning PCI devices on bus 1
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
01.00.00   0x1d87     0x3566     Bridge device           0x04
BPI-R2PRO> pci 2
Scanning PCI devices on bus 2
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
02.00.00   0x14c3     0x7612     Network controller      0x80

so mpcie slot works so far as it detects the network-card (mt7612),
only need to find a way to enable the regulators (vcc3v3_pcie, vcc3v3_mini=
pcie, vcc3v3_ngff).

btw. is there a way to show overall status (like the first regulator statu=
s) after enabling
the regulators (only shows current regulator)?

> If not, try running "pci 1" and "pci 2" after an initial "pci enum" to
> see if the root complex and your minipcie device is detected.

sorry for confusion, have not done much with pcie in uboot yet.
so you can add my tested by

Tested-by: Frank Wunderlich <frank-w@public-files.de>

Thank you very much for your work.

regards Frank
