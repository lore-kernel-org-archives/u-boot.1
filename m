Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489AEC2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 16:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38C4C86504;
	Sat, 16 Sep 2023 18:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="EBnq66D4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088C0864DD; Sat, 16 Sep 2023 18:45:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6EC3864DD
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 18:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1694882721; x=1695487521; i=frank-w@public-files.de;
 bh=filYroAw/FnOtGSvgVSDg+eDJoX2x6BJohORP7ncY7c=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:References;
 b=EBnq66D4BLY5Opm3NjP4gbgTWBpzfLNZsCJksonb9gEAs7tvI6YRbPn5t31XlG4UUWqhpBwq7cq
 +580eAKTeCpwbeOCBDqpODWty/cQtBmoDPxnHdL2PiXIRus5dBZ1KqXRngar6LQpSKfz0QRVAYvfR
 17JidPBXw2cPLPgBs/73nK9S8eelKYdpPcEJ48sxECvTMx7lt9ljALJExKvnoPqKMTNlkKPxQxs45
 P92Qdin5CuxUaIiN/dsv2qn0CecMyDVAw2o3SEYS1JQVetoDMRlOCVZOf2CoRVBGcJIRXLHnFvrD8
 aVd66NCKsas754Lg5zEfm5J1/oyvnPf6NW3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.145.236]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1rZEwH2Vci-00uMdl; Sat, 16
 Sep 2023 18:45:21 +0200
Date: Sat, 16 Sep 2023 18:45:21 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Marek Vasut <marex@denx.de>, Frank Wunderlich <linux@fw-web.de>,
 Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: Aw: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
User-Agent: K-9 Mail for Android
In-Reply-To: <f00dad5e-bbe7-7a4d-e955-ce317cefb932@denx.de>
References: <20230820160004.44880-1-linux@fw-web.de>
 <trinity-6cf108b4-a879-40e2-a04a-54451262d671-1694873885042@3c-app-gmx-bs23>
 <f00dad5e-bbe7-7a4d-e955-ce317cefb932@denx.de>
Message-ID: <E81B855A-F7F8-4405-B4A7-8261D55C075D@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qhMqJ1PDCk0NA+PhnRIzS3pSvpDQuc7+fgHHzxFZr1YSm007w/G
 a5K9wjZm43nAxl0ni1cF1z204Wple13DomfTW3gZfg37UrlOEQj+6kcmoaLImwJiDnkF8aG
 QYDpKo+lUX1dUgRS2DB+vDwVyEQzRzcdFyqKJqC9M3ZIeT6ocqozG8mckwR0N3Z7/dnmSiA
 DqD+YnMJ2aHoQVtdbs/Fw==
UI-OutboundReport: notjunk:1;M01:P0:PPL9tTG4LH8=;2TFw/1HYjp2/LWnIvvRBaV2Cqk3
 1PzAuJ/Ua4f5Dwiv2yIS4Ark9HSA28HJZYoz5CTEFOik0TfgZ54Gao9xFICqOO0o6WL8TtmPy
 E8FUdn8GsERlLdhjnByby+kQfg6CgZ8c0CTEySFNx3ZkR5amU/EqMwBgDb+Fxp1LIie1V83bp
 8/Qq1eP/fBUNO+VcvfNp51UYIuopyNnmIIRyHIdGf9chzixDFzr1ScXtnaLhuaIolt5WWe+hG
 gcaGxbk5lNVTgxBFGNLxuPDBUtA42zuo6l6owreOCBRnd1NcVgKRfWzrmEg++y7X5WQ+QDVCF
 dV4XyQU01QOXe1LupyACcjprqWeGLV/e/Q2odD7c+3JAPiNKRbBHPUEr5bt3nx3xfzzfW0k8c
 hQ2DPhOPg4mRRjiBcGhhzdKRJXdKaifEw6lDLj3Huh3b5chgSqe8mvb87bRfq9yEkeDinPpYZ
 ww3TVTO3ydrXECEi/HpQDhfBEWz5yQqheUI1LOf7kf6YIEc3mBbPp+3cdy7IaTA2S1QBq9yTm
 AWGUO6HbMXzq62ZSXHNxZTt0stDb+xZAHh0rvL+HigsMTzzgOjhBkkUoh/GQAgDznSngNdszb
 Zz9+kfHud67Bjoh45N2oUm8GMDAcX3lzxfF2V/iVIRmNggHn272T6qbIqtOSQe6mc3baxjFaK
 FEhA9noQcqRUCoxozQIOnOBDOEtOEnvSVll/j2dCgmyDqQsW74FvqW+EOScVbcZZW+KBY4iUx
 OZndY7z4STVBfxS3jufiSo/Ohl1JxalWAbYxbmeePX/0qVCr9u5mBV3knJoowhHTfZZt1dGWv
 w3Ivd93TG9oaPSCQtbJn96aW+6fSW8qmbh4wykuxdCss1uRcQlwPyM8IW8DtDC6Gbq50hw+6r
 mQ7Rt4btvLdqTWC5n5LwOAGx0qEGSyF3wHoHeCGyhExs/gCSQbLEgV2HbVKXUkJ/ZVbK8CLDc
 Zh/vpb3+zGvSdgCmjwPkIe31+24=
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
Reply-To: frank-w@public-files.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Am 16=2E September 2023 18:07:44 MESZ schrieb Marek Vasut <marex@denx=2Ede>=
:
>On 9/16/23 16:18, Frank Wunderlich wrote:
>> Hi,
>>=20
>> just a friedly reminder=2E would be great if it can be merged in next u=
boot-version=2E
>
>+CC Tom
>
>> regards Frank
>>=20
>>=20
>>> Gesendet: Sonntag, 20=2E August 2023 um 18:00 Uhr
>>> Von: "Frank Wunderlich" <linux@fw-web=2Ede>
>>> An: u-boot@lists=2Edenx=2Ede
>>> Cc: "Frank Wunderlich" <frank-w@public-files=2Ede>, "Simon Glass" <sjg=
@chromium=2Eorg>, "Philipp Tomsich" <philipp=2Etomsich@vrull=2Eeu>, "Kever =
Yang" <kever=2Eyang@rock-chips=2Ecom>, "Marek Vasut" <marex@denx=2Ede>, "Jo=
nas Karlman" <jonas@kwiboo=2Ese>
>>> Betreff: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
>>>=20
>>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>>=20
>>> Add Bananapi R2 Pro board=2E
>>>=20
>>> Till now evb dts could be used, but iodomain is different
>>> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
>>> and with iodomain driver this can cause hardware fault=2E
>>>=20
>>> Devicetree in mainline-Linux:
>>> https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Eg=
it/tree/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro=2Edts
>
>What would be real helpful is a commit ID from which the DT was copied , =
so it can be easily updated in the future=2E

It is no plain copy=2E=2E=2Ei removed parts not relevant for uboot now (fr=
om current linux version)=2E E=2Eg=2E switch driver is currently bundled in=
 mtk ethernet driver and using different devicetree structure than linux ds=
a driver=2E We have to separate it before we can use it on r2pro=2E But thi=
s will take some time=2E=2E=2Ealso pcie(-phy) does not have a driver yet,so=
 before adding dead code i dropped these parts for now=2E

regards Frank
