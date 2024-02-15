Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9DBC48BEB
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 13:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1C48785F;
	Thu, 15 Feb 2024 14:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ChEBAeyC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A6F87DDD; Thu, 15 Feb 2024 14:53:34 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42635869F7
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 14:53:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708005199; x=1708609999; i=xypron.glpk@gmx.de;
 bh=1zuYI2Hlm5cCxJ9HkiigX3A6/Ntc0T9CjI83+iliO+0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ChEBAeyCkNYbLYyixSZ+rnn6VQCrHy5TqGOcS49y2QvkXKdQr8GLr/76YoiND1qz
 5T5z0a9/GnTEi5mqqvQc/IdbDQaEhGaysMhiYjQGCL3zvQTLkDOP9/dQ3Vbcq7Eck
 lCejxXJHBUJJvrPPwpAWxMSLksM0FsmwV80yztldPY6XTxEX6I4yzP75oPhHPbuJ0
 KsPHlKMhfAnVlvSfFJ1RXsUUkbIUOHEHSiC3cBXAgw7905sDZVItOAmK9JB3mN2vk
 eQI5l32QSGOFZYILDTM+MOVW3Y+hZtiuxzAGiVs+GJPK8WY8rfjDEq31uPN8vrdhI
 UyzbfuQ1+gwA7cYBrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1rM5Ie0UBr-00NvJi; Thu, 15
 Feb 2024 14:53:19 +0100
Message-ID: <a2e98f0f-f28e-457a-af95-0a33b6a75c4a@gmx.de>
Date: Thu, 15 Feb 2024 14:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc: board: Add minimal documentation for Sielaff
 i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Kongyang Liu <seashell11234455@gmail.com>, Nishanth Menon <nm@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Yannic Moog
 <y.moog@phytec.de>, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215133527.216126-3-frieder@fris.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240215133527.216126-3-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dX82zUFs1WmAWZZf8oE+6KZNJkTDaa52lD55XPINlwcZ0rab4u5
 iyrpHPqx6DGJwybi+Ye+sAR91EpkmDl+4pp7A/KKkWu5WGhLMpyZCFYbspvtp1Tf+7GoB3X
 XbEbtyKQZCPoFL0Vx65nCzubW5hs1Fe605GFVWlEi/mLI74IIOXuWd90Vm4eKCvdM10NSEj
 7jocySGzW0NYlNPdsPVKg==
UI-OutboundReport: notjunk:1;M01:P0:nCsrwU9Xjig=;qFYPBvwAPUirKjv1wq5eS9eOi1Y
 voZGcdy08Qrab7mlgCeHfqcmm41BMIlM6txBAcrr0I5AoaBnwzVbCOiP5Khmi2jj5Zjr20Tmo
 lR4hIEfY5iuPssBnmPGwANzF6fqJ+2TaXZ7OLirq6b9XGnQEQrc9ktmW3QYdB56ugaIBhVumM
 0+1HQ1CDEQzs2ANgGetleEM/UVhhFHoRn/FWuvd4V7GJ1gSGIptqdfUVs5BV5Fyz6ad06/exL
 f87N0ye20CGbd/Rcc95ktG17KS/AIKnuqvwHj8YLe4nEPgipaB/Mq7e7yl9+2Kc7HuTFwV660
 rOwgrupTpNRbAGpxbnT2ACQ+clOud6YHg0XWklD+csDHgqIb/lUFhtWUWeMtnJLOk2sDQhj+t
 ju12nDTzQnNToZVKgUUyR5/MKprVFJ9rdOSUQui2RQJK24wGAOUiuN3iDn7r5sPRgTE0eZb6S
 7Sa6tSz6zDIKDzBXIRl3uE2Rx/LxeXiH1KZ08aaixo67BhcyK0ifzMjqeM4Mqa/UcwUmuNVOV
 h2MI0/YUR/k+9ionQq8G4FWMLFoOwQoFxJKDbEGYHx2U9CIlJVdC2VR6aZlUYdTcISCIb4x4e
 0ecYWNxZpm4Pi5LFXqv+u09n31tLLY6lwJa0Ov3w/d677buDtThQ4bmkKtg36EubceNLv2hHP
 BHTwIXM/hOUJ8tUDQeUwYyzGfk4DjTF1bzEjgI4VVAW0N1zSkRJD6Z3Zo1vTaHkIVk/MA6Kk0
 /0HLNzpbBH4KZDOkF2F07s2Q3AZRjkCjc+6ju4R3oQZCsCnvkNcHaVfAsk+a3+CeidGilatO5
 NGHZ8BmE1SIpVjAg7YsrGnXNKTg2A9L2yz6w90G9jidMI=
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

On 15.02.24 2:35 PM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> Describe how to build and boot for the Sielaff i.MX6 Solo board.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
> Changes in v3:
> * include docs in upper-level index
>
> Changes in v2:
> * none
> ---
>   doc/board/index.rst                  |  1 +
>   doc/board/sielaff/imx6dl-sielaff.rst | 32 ++++++++++++++++++++++++++++
>   doc/board/sielaff/index.rst          |  9 ++++++++
>   3 files changed, 42 insertions(+)
>   create mode 100644 doc/board/sielaff/imx6dl-sielaff.rst
>   create mode 100644 doc/board/sielaff/index.rst
>
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index d0f9f355d2e..62357c99388 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -42,6 +42,7 @@ Board-specific doc
>      renesas/index
>      rockchip/index
>      samsung/index
> +   sielaff/index
>      siemens/index
>      sifive/index
>      sipeed/index
> diff --git a/doc/board/sielaff/imx6dl-sielaff.rst b/doc/board/sielaff/im=
x6dl-sielaff.rst
> new file mode 100644
> index 00000000000..24dd67ccaef
> --- /dev/null
> +++ b/doc/board/sielaff/imx6dl-sielaff.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Sielaff i.MX6 Solo Board
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The Sielaff i.MX6 Solo board is a control and HMI board for vending
> +machines.

Thank you for providing the build instruction.

I had to look up the abbreviation:

%s/HMI/Human Machine Interface (HMI)/

> +
> +Quick Start
> +-----------
> +
> +- Build U-Boot
> +- Boot

These lines are not needed. We have a navigation tree on the left side
of the generated HTML page.

> +
> +Build U-Boot
> +^^^^^^^^^^^^
> +
> +.. code-block:: bash
> +
> +   $ make imx6dl_sielaff_defconfig
> +   $ make CROSS_COMPILE=3Darm-none-linux-gnueabihf-

U-Boot does not use floats.

make CROSS_COMPILE=3Darm-linux-gnueabi-

> +
> +Burn the flash.bin to SD card at an offset of 1 KiB:

Copy the flash.bin file to an SD card at an offset of 1 KiB:

> +
> +.. code-block:: bash
> +
> +   $ dd if=3Dflash.bin of=3D/dev/sd[x] bs=3D1K seek=3D1 conv=3Dnotrunc

Please, remove '$ '. It makes copy and paste more difficult.
Anyway $ is the wrong prompt. Only root can use dd.
If you really want a prompt, use:

.. prompt:: bash #

conv=3Dnotrunc has no effect on SD-cards but is needed when copying to an
image file.

Best regards

Heinrich

> +
> +Boot
> +^^^^
> +
> +Put the SD card in the slot on the board and apply power.
> diff --git a/doc/board/sielaff/index.rst b/doc/board/sielaff/index.rst
> new file mode 100644
> index 00000000000..a8376484d88
> --- /dev/null
> +++ b/doc/board/sielaff/index.rst
> @@ -0,0 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Sielaff
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   imx6dl-sielaff

