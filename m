Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBCAC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 06:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F0F88099;
	Wed, 27 Mar 2024 07:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="sgHADxNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39D688103; Wed, 27 Mar 2024 07:49:45 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBC28803B
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 07:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
 s=s31663417; t=1711522180; x=1712126980; i=wahrenst@gmx.net;
 bh=crZuzloAX533dQZNQpboEHs69Fm4Vi8FTrDfuQuo1DI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=sgHADxNv1R2jV7dYW0rusV2TPYvtqGq88W9JJ3DC9PUxegqpT0XXgmf98wq9lZIw
 iH1eBbzUpeaUILsqPofEqHj5ZgBGb+vx/FHDx90OwTfkmVHCwRDiGjrxXh7o7MtgS
 6WiidxitfM/edforAFxhSNK4slPboCEN+CrYSMiVmuXc4/4bJLYNZNzRNj06VlzJX
 upM9aGxUcog4/2Zlw94jiZoxuqko+NHdfWzxVCR0DH5uhWChn9Z38URqJP3rZqSzc
 tv9Jq7h9fBE8y8Nsaiu+UI6EEbspRyDOpJ6CWKjQGSdywMc9nGT1Vt9SYlNk93cmK
 ohWrvKoARelvZ+pmdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1susD00wnq-016wdK; Wed, 27
 Mar 2024 07:49:40 +0100
Message-ID: <b044eec1-ae64-4de7-9ab0-e3fe756131ef@gmx.net>
Date: Wed, 27 Mar 2024 07:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] dt-bindings: arm: bcm:
 raspberrypi,bcm2835-firmware: Drive-by fixes
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Peter Robinson <pbrobinson@gmail.com>, "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Naushir Patuck <naush@raspberrypi.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Rob Herring <robh@kernel.org>, Scott Branden <sbranden@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240326195807.15163-1-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HTCEyS6nbqrJW2zqbhsneRS9PKm/tLlWHoagAOaiVutERTwDsJ5
 x72E1in5cgJaUOMRhvwrEEd12bm0cFXwtJIe6hQdGPTzwZ7ZFByYHmAM+oUkjorsSPtva3I
 d9GygI5Z19gqYiEq4aXVETw7uzR/U3UnODS+egjCvH+cTg/XROhgfL65T+C2b4I6gH2qQyF
 c6sRf36DkPDqbxkzs9gvg==
UI-OutboundReport: notjunk:1;M01:P0:UP68RPxLhm4=;XI8FGkWogFh2WjjrpvRbvgUncrr
 jG4meNcpkNF5nvlJNmPZYOIsP/mGCqn8y2FBjM7r0acfdYYz5wl+ylIeL2SWNwXc3fKXpbTIX
 sxo0RUFAuepu4k+PxAx+6nrpN8tyaL1+ZxUkSRt64pPiffXedWE+wdbDEgIjEYmW7I/HTEuGj
 aelHgGbobWq9nswpYdgziOmP+MzOErylgeLqJqoHVQ0435eEBYi08cEvLfmsVjquIGDhqSTF/
 FzZZa5oCpq8wXtLC4qyBwkv5WRmUysyfA5vCdU6WmfXeomZ7ZKVe6P0MYCxtqOg0iMBpD5chI
 /risVkvS/mgFpAT9WWpbsSnF+dEidzs+OdvWPEXQaVkO92lHpgS2LBdHxJeinmJOI1A0FDB8X
 rZn+FVElCWaiCdbl3tJx2nQbSTjfVAgdIGF6+dkvgH6sPlb/X5JpkjvVevVLQ9gWYGkoius20
 EwY6jBnHUXzGCWyiRMUG4qLsXRCbblckuTUImVCSHmL4r0SxTsbmXg2sU2z3Q/6lacY1XMa8X
 srRZJsCn1KlJTX0JZLiz/s5zIqEXDx/RmbuyteRZEpYl8XV7zdPUzmlhdLV2k6DIVt1SW+fde
 Ido1O2I+LAPBPcIr0PceevJ+IngCbJOkrqmVICu+CD88GQpt1nAJtgl521IrxWyarzSK1NT3r
 aV2GEI9YCUinrW1FxrLsX5uSbHz7YvcrhHlSVqLJ70x6hySCZL9LoHts9xxhSuPMm2Qb4uj1w
 mkS90HeIOfPlakd0SixMjkTpdWSdRxHokmnpF0/EL73ku3BDQfV2lwYX+uh+pT2eMn2LMRDYA
 sBqIPOo+0Md+cUMH5vuvhF8SmJPwUx7zFuIZujnpAgwvU=
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

[add Peter and Ivan]

Am 26.03.24 um 20:58 schrieb Laurent Pinchart:
> Hello,
>
> This small series includes a few drive-by fixes for DT validation
> errors.
>
> The first patch has been posted previously in v1 ([1], and now addresses
> a small review comment. I think it's good to go.
>
> The next two patches address the same issue as "[PATCH 1/2] dt-bindings:
> arm: bcm: raspberrypi,bcm2835-firmware: Add missing properties" ([2]),
> but this time with a (hopefully) correct approach. Patch 2/3 starts by
> fixing the raspberrypi-bcm2835-firmware driver, removing the need for DT
> properties that are specified in bcm2835-rpi.dtsi but not documented in
> the corresponding bindings. Patch 3/3 can then drop those properties,
> getting rid of the warnings.
since this series drops properties from the device tree, does anyone
have the chance to test it with a recent U-Boot?
>
> [1] https://lore.kernel.org/linux-arm-kernel/20240326004902.17054-3-laur=
ent.pinchart@ideasonboard.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20240326004902.17054-2-laur=
ent.pinchart@ideasonboard.com/
>
> Laurent Pinchart (3):
>    dt-bindings: arm: bcm: raspberrypi,bcm2835-firmware: Add gpio child
>      node
>    firmware: raspberrypi: Use correct device for DMA mappings
>    ARM: dts: bcm283x: Drop unneeded properties in the bcm2835-firmware
>      node
>
>   .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 30 +++++++++++++++++++
>   .../gpio/raspberrypi,firmware-gpio.txt        | 30 -------------------
>   arch/arm/boot/dts/broadcom/bcm2835-rpi.dtsi   |  4 ---
>   drivers/firmware/raspberrypi.c                |  7 +++--
>   4 files changed, 34 insertions(+), 37 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/gpio/raspberrypi,=
firmware-gpio.txt
>

