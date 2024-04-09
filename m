Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0846AC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 03:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456D487EB4;
	Tue,  9 Apr 2024 05:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="F8xn/Tpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BB0880DB; Tue,  9 Apr 2024 05:30:09 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4F487D08
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 05:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1712633402; x=1713238202; i=xypron.glpk@gmx.de;
 bh=TBchfOGo3gS5YPh4bRWh24eZJ/EIUaydQ1x40QVr1D4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=F8xn/Tpjjgr/k8kbp7PQFaKOghelFPbKqq1dWDOpS3yn5clb6sVD6JGAv7vIA1mf
 lw19SaTT12pKWV4CY+7Yh9Oc4c1e6nnbmXCeJmH1B4lHd7GZVqpW4O8cwLXGm3GkC
 pzCzTwEtcOJZX1SnZpuG/lXmS1GMu1BEaE/iPZk/gyjl1lgNRFK7906cyLlnERChl
 aO9zpmESyJnN+w4pKD61gnBNJ+Ryc8DAgSPW4xSC0r++8zGXorVKFEIlGC3tc0/yB
 3mT9lPtNndrVrv+VUaKPi0CIRbPJO84GC/6Y7KTZKf5KaMGaF5mXasgMqzoh2eupC
 HZWOvUrsIzcFBx8Jxw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MyKHc-1shRy94Bmm-00yjny; Tue, 09
 Apr 2024 05:30:02 +0200
Message-ID: <3da9c43a-c3d4-44d1-b8d3-4850d24c48c4@gmx.de>
Date: Tue, 9 Apr 2024 05:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] EFI: capsule: ti: enable authenticated capsules
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Davis <afd@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240408213349.96610-1-j-humphreys@ti.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240408213349.96610-1-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/iD9TAYJ6hr227muHSXJNWiOEi/8zJsVnnhSc4b3IFqjuMDXx/f
 TSW9zsAFBMq6nTXuzlB2GdWyJOi1LYpnn3aZi/LPcY1Zgn/s/YZQ9z8WZxhKWoUkKNRMhEu
 jco7rgu7Ch0QEf/rgbbjBFeW5ILX/z/qaky1UFx798P7fLuMOMgnb0+vmMv1xSAAZBagsm4
 HvFKSUmmdx4oaF6mjoVsA==
UI-OutboundReport: notjunk:1;M01:P0:w9XAVpsQMAc=;x/f9AyW8hY4s8qoMalpaiQn+qZS
 OCXi8A7Mbqmrd/6bSyHlOVHyPjiZISfcVS1zFNIc+w43wWFnYOtuoAtR8+RvwFeFNuL62TjHx
 NdAF+H6flgnM7z+DLIfGJ5r8Fg69NoUIVbHvtJ3WZTAz8/JZd7LFjaxT6qWXuXGXKdjgR36k2
 OcIW/roJA0XJYSmQPN6T8KEFY6m3IzrRYi/L9wERoJ95BOjmKFD46n7vzzcE8GsLPwILNGM3A
 LAM3It2x5yeFDwIKHz7gjwBaAchNaIxS/J8ZPuv00EVp4S0bpRxrOsJNn/IioahV9SBdAz0bU
 MhxzyGUdOX3BQxOReZK5vUCdcAL0hz3rQdAnFIhnusV8d+nmqbSC+bGIRqlgmZPNxdccowfrM
 rm0qAkl1oHm7KbpyOyKi/SLsS/n/JQe24uyotb/UYlTRXKqySfS4VUddnfoDNpbwHX+LAHFQo
 dhJIHZoJiQByZyfXxkcgzp8UI9J9siC0BK0aNRG/sqs0ABWkILACKUmEOt5LtXpsLU7pTn1AZ
 G1cxqJZtOxThm/Mi4YYjBhkNwo8NWe4C/FiLlmItO0bAtZkL22gN3peWy2+Xgu6BBUDhyHD+L
 oOHj+6q+Ytayp/BW5jaXFtFo80CANBc+DyOK/WV0yZ59Z2BlmVLUlcigt+ejtPYSTsaC15Zea
 pLpx2Kotta52iQQm2/5ouON+C0g2sQJ8yDBYVklBxzOq5OdjUMZnDVc0Ha+K55dhXRTGqY3vJ
 ZvTpIPXR6Z9GEia3Ah6qlX/IVSRqwxILo45y+owwk4Nsi2LeRocvcAkkgQxb6sWM8MZyOvrDP
 K3o8JbnQUq7q4zExCHFKuUz3D6QRKCJU3sZp5wkNfFCEs=
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

On 4/8/24 23:33, Jonathan Humphreys wrote:
> Create an EFI signature list (.esl) file based on the TI dummy key.
> Enable capsule authentication for several TI SoC based platforms: AM64, =
AM62,
> AM62p, BeaglePlay, J7, and BeagleboneAI.

Hello Jonathan,

with the patch a capsule update will not be possible if the capsule is
not signed with the private key matching the ESL signature key in patch
1/13.

Why should a user want to lock down their board to a private key over
which he has no control? Wouldn't it be in their best interest to create
a key pair themselves?

I would have expected a documentation change explaining this to the users.

Best regards

Heinrich

>
> Jonathan Humphreys (13):
>    ti:keys Add EFI signature list
>    configs: am64x: Set capsule update signature list file
>    configs: am64x: Enable capsule authentication
>    configs: j721e: Set capsule update signature list file
>    configs: j721e: Enable capsule authentication
>    configs: beagleplay: Set capsule update signature list file
>    configs: beagleplay: Enable capsule authentication
>    configs: am62px: Set capsule update signature list file
>    configs: am62px: Enable capsule authentication
>    configs: am62x: Set capsule update signature list file
>    configs: am62x: Enable capsule authentication
>    configs: beagleboneai64: Set capsule update signature list file
>    configs: beagleboneai64: Enable capsule authentication
>
>   arch/arm/mach-k3/keys/custMpk.esl          | Bin 0 -> 1523 bytes
>   configs/am62px_evm_a53_defconfig           |   2 ++
>   configs/am62x_beagleplay_a53_defconfig     |   2 ++
>   configs/am62x_evm_a53_defconfig            |   2 ++
>   configs/am64x_evm_a53_defconfig            |   2 ++
>   configs/j721e_beagleboneai64_a72_defconfig |   2 ++
>   configs/j721e_evm_a72_defconfig            |   2 ++
>   7 files changed, 12 insertions(+)
>   create mode 100644 arch/arm/mach-k3/keys/custMpk.esl
>

