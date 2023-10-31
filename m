Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6249CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 21:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7104887BA0;
	Tue, 31 Oct 2023 22:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RnqcBwTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E84D087B9D; Tue, 31 Oct 2023 22:21:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 104EA87633
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 22:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1698787265; x=1699392065; i=xypron.glpk@gmx.de;
 bh=C1Sop5sb1PwXVBIKHCWKVCKH1JyDtvlD/tUGTUxvffo=;
 h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
 In-Reply-To;
 b=RnqcBwTLhSmHYThG/ZNv5kHbVjytxHcGBLocKwvoWLfMY/aelA8l2zbwk+erqZ0H
 RpVhCd3ENDRhAVRpw5Pp6Avjx9nX8QruhDfiy6wCO+j6VIO9X5DmJ9K4gtXQp1zR4
 zVomrFOa69yRISWvURdJRSG1u6Jf69OAwCh8PFfr7sbef3KvC8HoU1qeNcTB9fquN
 5DnCLzcBUyGZoEmlCNAWOtuYOurwqnpTBHA9MQn5NfevoxesG+XhZHVeSBSC+HSoj
 /A/miH0+hzoAEOMKwOrCuj8FTSD0hChm3mC2tp6Gv65AHSoVKJ2sjp5iU1YJjoLMB
 Otb6/vPOGk6suP9hOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.29.1] ([159.148.28.2]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJmGP-1qiBVR3E4n-00KCWX; Tue, 31
 Oct 2023 22:21:04 +0100
Message-ID: <43bbfc5d-fbd5-4126-9485-5868a85b4926@gmx.de>
Date: Tue, 31 Oct 2023 23:21:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] configs: visionfive2: Enable JH7110 RNG driver
Content-Language: en-US, de-DE
To: Chanho Park <chanho61.park@samsung.com>
References: <20231030073204.150030-1-chanho61.park@samsung.com>
 <CGME20231030073229epcas2p1012dde729d0a79382c86a5a8bbc46ae5@epcas2p1.samsung.com>
 <20231030073204.150030-6-chanho61.park@samsung.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, u-boot@lists.denx.de
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231030073204.150030-6-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e7rMKbgN4Oi5u5M1aqc+esbwacnywWpKeeHitlXaxga2NKp+K1f
 pRdz2KTTBmK0dqnEblj1hO38GutxBsZpkZ9HAkq5lVCWRLowlQEiGXZmyWrZAvxFvY5Nzjq
 ZwYATt2UDrk+KfDI+GB+QEnjOnut2lA6LjCwRgSfLbuvSP99zHkEsEKVJnAe1jkNozt9uVY
 Q7JE3W+IRNHCaK9ydClIg==
UI-OutboundReport: notjunk:1;M01:P0:8DWlctrwL+M=;H+azMnEI1DCkG7mOZZJG2/rSq+Q
 J0cSa7Al+6f6FjL9avAQ31E0DFxpO8JnRKFc0rnN8oDQ8Tws4jPiR8led7PyzBqy6j4xlxiZI
 wBP4YrFaKPasLCLwWdGnzdoc6v4OzUw2pBG9i0h359zER5CbZrdaOK/Qcy29CSFxPwF73ypKg
 m2CcACkH4qMmDnoOLIT95zgc96EGXPvWdwlwF146WQ3zu4eurLXep2LJpQL9kidTMuyrs0CZk
 nlHjUxyek5tdGIydYO4srlZAkXYBHa4t0wdfu0VFb8p28nYHkVsp6MjasxKHnbnKK7IC7HKy3
 9lWQE4SX6ea3DahdGrwnRuHUf4AIDNHhSkqNGTUla7GzTQ8Y3gLVoI3bWp0+IQkgXAvcq4Edg
 OTHUICNe6bzTfHrAQvoh7Lz/im3aQCEvSicNuyNvs8aYtmhUlPFCCeGNF29ukowmgOCJHAckf
 W4ckL2r4YWHvs1UgFteSJz9SPnVydjzC8pz+eoTzhl32fagRWLNBdQ1T6/Xb6d8QZ8oQbl3qZ
 FdONSHHLFjU+uMGf1MZsNlAFIr+TG2uJWiVzuBlgjWhSt0FtCc2JECjl2ZIkEMHjAQL1wvICo
 i99U7QVlqObNwJWzJigPJK1FbKqHfXNA/jtSv/Z9t59A9mvV0zr7KFgDXQ1EEduFsToqltPFq
 AxxoNmWQbXlkP1DV8eHD13qJrkCpIWahtDa1nK4Zym5qAcPf7cO6iopFFAlrpElgIAdAU8NiT
 ZOTkbFg8pd+2qE0uRCdn7EbfZQKV8d25xEtIyqvBPOxqMzpEEpWCbmXkLrJKgdTRBooAYWKCA
 glX2QIx21A390VYGwnptXFlb19Cq32tZ9kwfupjAAIamJCOaal+ciZWIX+wNQTU7eT+cPRmEa
 niwyHmraf+YTOzukL4iP5bF0N5mV6k07fV71BJtiE1F9U1UrmDrVY4dBupbMCtKcSPc4Q1Se4
 5809dg==
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

On 10/30/23 09:32, Chanho Park wrote:
> Enables JH7110 RNG driver to visionfive2 board.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   configs/starfive_visionfive2_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_v=
isionfive2_defconfig
> index b21754feafce..b15e7d24db19 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -120,6 +120,8 @@ CONFIG_SPL_PINCTRL_STARFIVE=3Dy
>   CONFIG_SPL_PINCTRL_STARFIVE_JH7110=3Dy
>   CONFIG_PINCTRL_STARFIVE=3Dy
>   # CONFIG_RAM_SIFIVE is not set
> +CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_JH7110=3Dy
>   CONFIG_SYS_NS16550=3Dy
>   CONFIG_CADENCE_QSPI=3Dy
>   CONFIG_TIMER_EARLY=3Dy

