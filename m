Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D188C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 18:10:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 280E286A1D;
	Mon, 18 Sep 2023 20:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="eqa0Ecn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80AF86A23; Mon, 18 Sep 2023 20:10:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00CC8869EB
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 20:10:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1695060594; x=1695665394; i=frank-w@public-files.de;
 bh=zizYjkHbC0Y07mrzZ8MhCsb402M7zYD3TRT7/l6umqQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:References;
 b=eqa0Ecn27ApqDgsadT/Xcr08bej16ceg3SZHBUSp8Z8FzluXNzZ8IFXOXCjCaNELdDboFccEzU0
 MpGlwDVsgmXT6jGZSg0gKBGXKEFRjhUR+ZTf9xj5gHEJsVM/ITA7ia4c4yk0byjizxlRrQ+/snjtF
 XlGjwWJzHiuwZl+92NPa0TLfUD4RRj40/WgFMeGyC0ExgxF47CRwf8llyjjSahIBiantJ4yyMfU2a
 8BXq9OcDj8Wz/kx0mJeHMWAxdrJnbRMdYYwnG0iRynpWYQ19wCtxDMG+Mcun/Ir9WG6nauvGYXU0e
 eJhiw62tUJqfGUeVgiXhFe6rQxSdZCRSYiFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.158.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1r3GO62tlk-00PKvT; Mon, 18
 Sep 2023 20:09:54 +0200
Date: Mon, 18 Sep 2023 20:09:54 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: Mark Kettenis <mark.kettenis@xs4all.nl>, Frank Wunderlich <linux@fw-web.de>
CC: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se
Subject: Re: [PATCH v4] board: rockchip: Add Bananapi R2Pro Board
User-Agent: K-9 Mail for Android
In-Reply-To: <87wmwne5cw.fsf@bloch.sibelius.xs4all.nl>
References: <20230918173624.31464-1-linux@fw-web.de>
 <87wmwne5cw.fsf@bloch.sibelius.xs4all.nl>
Message-ID: <32AADEE4-360F-423A-BF6C-C8A934D86EF8@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kV3zJTqIg6J/XU3468pBXPAUzqTnZ1FIzJtRlvtRqa3+H4WgsJt
 15TLrC1JygM+OSmDNZxS3nv+/KvUtpli0ZVZY3NMMwb1v1Lbn1GGKhFBfJ1cj+wd5LqJ/OB
 boCms1M6oN8Gweg9nC8cW1v0+vB7e3AAu999vZDxJwen7tAhPekZW5luEyz5iA82Jzi0Pu7
 1rq9oO/2Qq3TcLCVn/eCg==
UI-OutboundReport: notjunk:1;M01:P0:DFfoGFV3TmA=;jG6yKY8awin3n4lMleaPxRGoved
 3zYSlFS4pQlkYEvLl+yt+d2kDCoHEHReYl0vCMJVKI0/S2q23iMnudWUjtTA6tzsS4HQa35Y4
 YtWU6UkegzV4kSoEth6aIsziJO8zYYJibYMkuC3Bdvxkaa+fYG+wYIbJalcQaPOi+m5Qg1YM9
 Kd6HLHTxiShJKQIGpgwpULUTB3cPThGLJUQsrlhWB1AzuEBQ/2x+2GXtXXfOlsC4DdKeKgwyS
 oueQ5KfJjUIIfZIxgLRjVQVa23GxmjVb15SCF5ObDIyljyRhxMSEyaSQebazixNPZ1lEd1t9T
 T5j/AK5a0AMR20qHfEOTGGPqVsBAwsWzU8Uo3aeQAwE/ICaUm1548WdX/bfiy2IxMwG1+BAu3
 jlY4qNq/T68YNbm+mVFn/PqD7crkrcAFuGG0Wrx9mXYwBAIrDUMzJhw3jRRlcvyZMzpYrKLN2
 VCfAfapCm3O3x1WXltw1gDCh9cESDmRkhXiKLbcI4sYDldNp92XYZiJpbe+FrdLH2Ym4TMJq4
 SlKJ7LavKwbaFkKVL3fW2t7thw7gA48NwumathtdF/gueZJZzPHgluVQ+0zxvceswSzyaWTkZ
 vX5pcEBGY8WsT4I9IUz2mhjLIMMRzjwPZKmcWwfxOz9AImqUB6IK+ChTOW6gzF+YW9zo/JGez
 ETykXvxbZG6911vROLkd5WaQZBjKkqcs+zRFNVukRkafJdr1Kp+O8YsT9zKmUo4KtQg/JBRZj
 l/vgy0toieDUJeF3zkGIxWofqiIEMsSH2Mpyku++WG3HEzf+Jf0kCX/Hu97Wjhoov5hOygLAQ
 U8RJfZ4Hz8lGmVGareFgJgMktJdv5LAjILXd063LHYVF5tFCFSZ/r+1JvkNNqP4rG92DoNtSw
 KUz0g4wsii8xDBoy6NV6wxjIkyoWe6U50yBKyt+RuAA5zxhfLzg7mE6JPXMqBUJbDncrmBPBl
 lHnv0CqGiDp3HS8Eb1n9rxT4hsg=
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

Am 18=2E September 2023 19:52:31 MESZ schrieb Mark Kettenis <mark=2Eketteni=
s@xs4all=2Enl>:
>> From: Frank Wunderlich <linux@fw-web=2Ede>
>> Date: Mon, 18 Sep 2023 19:36:24 +0200

Hi Mark,

>> --- /dev/null
>> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot=2Edtsi
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: GPL-2=2E0+
>> +/*
>> + * (C) Copyright 2021 Rockchip Electronics Co=2E, Ltd
>> + */
>> +
>> +#include "rk356x-u-boot=2Edtsi"
>> +
>> +/ {
>> +	chosen {
>> +		stdout-path =3D &uart2;
>> +	};
>> +};
>> +
>> +&uart2 {
>> +	clock-frequency =3D <24000000>;
>> +	bootph-pre-ram;
>> +	status =3D "okay";
>> +};
>> +
>> +&gmac0 {
>> +	status =3D "disabled";
>> +};
>> +
>> +/delete-node/ &{/ethernet@fe2a0000/mdio/switch@0};
>
>Why are you deleting the switch node?  This way an OS that uses the
>device tree provided by U-boot will not have a working switch=2E=2E=2E

Is there such an OS? Linux uses own dts=2E

The switch will also not work because the gmac0 is deactivated to fix the =
timeout in uboot because phy does not answer=2E

I can leave the switch-node, but i do not want the timeout on network acce=
ss on gmac0=2E

>> +&mdio0 {
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <0>;
>> +
>> +	switch@0 {
>> +		compatible =3D "mediatek,mt7531";
>> +		reg =3D <0>;
>> +
>> +		ports {
>> +			#address-cells =3D <1>;
>> +			#size-cells =3D <0>;
>> +
>> +			port@1 {
>> +				reg =3D <1>;
>> +				label =3D "lan0";
>> +			};
>> +
>> +			port@2 {
>> +				reg =3D <2>;
>> +				label =3D "lan1";
>> +			};
>> +
>> +			port@3 {
>> +				reg =3D <3>;
>> +				label =3D "lan2";
>> +			};
>> +
>> +			port@4 {
>> +				reg =3D <4>;
>> +				label =3D "lan3";
>> +			};
>> +
>> +			port@5 {
>> +				reg =3D <5>;
>> +				label =3D "cpu";
>> +				ethernet =3D <&gmac0>;
>> +				phy-mode =3D "rgmii";
>> +
>> +				fixed-link {
>> +					speed =3D <1000>;
>> +					full-duplex;
>> +					pause;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};


regards Frank
