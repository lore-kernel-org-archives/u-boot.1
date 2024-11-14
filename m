Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDA3D65C69
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 10:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D27895F5;
	Thu, 14 Nov 2024 11:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iKwwSsOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6EE289601; Thu, 14 Nov 2024 11:12:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 791AF895F0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 11:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1731579096; x=1732183896; i=xypron.glpk@gmx.de;
 bh=zByxoEOy94sy6gZc6YAnTEKdgy2Gq1X4Rm+5GXbmavA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=iKwwSsOebHEHubUHgzpxTnFmeO6FmPtJZ6ZbSrjynbMqKUBh1MaRn/DrBPCQ8Gja
 yHHYTGPOaGHUyol/m6fMK/PzXJA5ljCyuUhhATiZqRe3F/sGpQ6/wgHr1oDUurdRD
 G0/oKaqOLM3pdTZmVOPZummHF6MBSiJBWgeCs3fHpWkGQthzQ4hhUwPxLs8N+pIlr
 /E/aRgh09PgwcqrWlPqUePjiGcD1apbcSIN4jGixAMRF+Se3389xNJWfC6bXSekCS
 /rgMc6BV3qovNZa54Gy9yn1TEJwjy1tocR0hcjb2ldUZgiQypVmeHuRJDz7fNJvNX
 +gicl1AZROW/UZi3pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1tQroV43xY-00MMgU; Thu, 14
 Nov 2024 11:11:36 +0100
Message-ID: <14ba45f7-0941-4a1b-96e1-5423644313cc@gmx.de>
Date: Thu, 14 Nov 2024 11:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] doc: spacemit: bananapi_f3: document Banana Pi F3
 board
To: Huan Zhou <pericycle.cc@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.denx.de
References: <20241114-pickup-bpif3-v3-0-98a45802ab79@gmail.com>
 <20241114-pickup-bpif3-v3-2-98a45802ab79@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241114-pickup-bpif3-v3-2-98a45802ab79@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ktqeahcA8UZGtVp2a+wJ1BPajwx2fI4WJ728wf0uOXlMiB+HAmd
 22LBVYRQsr4tgQbdPY4HegON9O7y7O/Gs4ywkROtVnxno4ECJsiohKUGpV53z29bLjPiSW+
 ywk8LiZnENvlo93MtosinSR9MxGmPeOr5ONW/OFylP+JKoZrOXd8dFTzqwkaCUcReY2vLTE
 RzpSIU+E3AREpMyLd6KmQ==
UI-OutboundReport: notjunk:1;M01:P0:v/KEVUWF6eM=;zvF8nmnicfDhs7MU02MNME+HXHO
 s0xZXHpooBMGs0ZN0Bcb6HmlMnDTGla59pKO1m2+MAeH+li6HSr+shKhhBlHWPs0bS7m0JSVU
 pAPb4ydJXxJPDmAhM019VqCzcQuDl9TJVGZ6PQmbwYqet2LMEvUGVJPI9SPHOE6dS23bszRmN
 1tGuyCUocxPSeu8XRciBwbOzD0iufABrhRLqPhxFsMwuLvYcAN2D7qctDYBZMUcFf58IyFRte
 BHKAs5e+9OnU3DgmSNPHsVkdPkwMfGDbEIhzAKZg2uT/T/b1AEEaS1lO/UM30SwwdnI6bkZ1F
 w7fIclffqY68NKLERrFNMM8qCULrhs7MiBG0HNubyKi3SLGic3Mse8Uq+6QQTEIfErITYRnnm
 bWo4z+DGYpOmoJI+lZp7aUl6TNmnRj0cBOQl3BYmAnwkU028JAPh8TA5ROYiEguIqxErYBtwZ
 34HbtL8sW9aWxNKeFFyOExpySkdk1H1lrXSqKDKaiSahdXgrjy8+dZoO2/4HxfnUG8a1W3CCI
 DgDfmPcmDx+aqZhI8VUCd1j+47h5PLosZ7SbiCm+khgU8aEmuePLNbOby5lMCtT9kFms/lLCJ
 jiKlNtcbs1wPckHflVWBpqiih2EKEb3yvDg5ZI1i1ro3hBX65H/Gk9lD5PBOzLA4V2ROdCgT6
 ZF20sNp6SJet7QXHUUU93TvlbSuNAbsPN+OI2mrdtDkRNmwWNItk2gUqaTZVeNTO7UnIBYxKa
 Ug+VQS91iRdKl6AVYQJl+jhefR5zd3qsOtqFXY7okPhNVPGJKxtW72VuIrcKZS7IOvQjysD4Z
 14vTNf0G8B2iey5bzTq0JyR6qPu117TUf4/LKdXCBbJgnW9eauNjYU7ojBFXjokLKOo4E4eh2
 7Djd1qg+ClHXYic38jgbxtYHSQUrL4Dr6VKQBzYPCMCTMQkHD5KYys0bi
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

On 11/14/24 08:21, Huan Zhou wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
>
> Add document for Banana Pi F3 board which based on SpacemiT's K1 SoC.
>
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
> ---
>   doc/board/index.rst                |  1 +
>   doc/board/spacemit/bananapi-f3.rst | 78 ++++++++++++++++++++++++++++++=
++++++++
>   doc/board/spacemit/index.rst       |  8 ++++
>   3 files changed, 87 insertions(+)
>
> diff --git a/doc/board/index.rst b/doc/board/index.rst
> index 417c128c7af6ad2267ef1bc743c7f10ae70b6de7..367da2d62316d4cab25ecc53=
f852ef742eba13dd 100644
> --- a/doc/board/index.rst
> +++ b/doc/board/index.rst
> @@ -51,6 +51,7 @@ Board-specific doc
>      sipeed/index
>      socionext/index
>      sophgo/index
> +   spacemit/index
>      st/index
>      starfive/index
>      ste/index
> diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/ban=
anapi-f3.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..ae98a784a7f19a28658b2d6a=
cad0679cf0a4faa3
> --- /dev/null
> +++ b/doc/board/spacemit/bananapi-f3.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Banana Pi F3
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +About This
> +----------

Thank you for documenting the new board.

For such a short article we don't need three levels of sections:

Banana Pi F3
|- About This
|  |- Building
|  |- Booting.

The 'About This' title could be completely removed. Otherwise, please,
put it on the same level as the other sub-sections.

> +Banana Pi F3 board is a industrial grade RISC-V development board, it
> +design with SpacemiT K1 8 core RISC-V chip, CPU integrates 2.0 TOPs AI
> +computing power. 4G DDR and 16G eMMC onboard. 2x GbE Ethernet port, 4x =
USB
> +3.0 and PCIe for M.2 interface, support HDMI and Dual MIPI-CSI Camera.
> +
> +Building
> +~~~~~~~~
> +1. Add the RISC-V toolchain to your PATH.

If we use CROSS_COMPILE, the toolchain does not need to be on the PATH.
You could use an absolute path like

CROSS_COMPILE=3D/home/user/my_tools_dir/riscv64-linux-gnu-

> +2. Setup ARCH & cross compilation environment variable:

Environment variable ARCH is not used when building U-Boot.
The only usage is in scripts/decodecode.

> +
> +.. code-block:: console
> +
> +   export CROSS_COMPILE=3D<riscv64 toolchain prefix>
> +
> +3. Before building U-Boot, OpenSBI should be built first. OpenSBI can b=
e
> +built for SpacemiT K1 SoC as below:
> +
> +.. code-block:: console
> +
> +   git clone https://github.com/cyyself/opensbi -b k1-opensbi
> +   cd opensbi
> +   make PLATFORM=3Dgeneric
> +
> +4. Then build U-Boot as following:
> +
> +.. code-block:: console
> +
> +   cd <U-Boot-dir>
> +   make bananapi-f3_defconfig
> +   make OPENSBI=3D<OpenSBI-dir>/build/platform/generic/firmware/fw_dyna=
mic.bin
> +
> +This will generate u-boot.itb
> +
> +Booting
> +~~~~~~~
> +Currently, we use a modified vendor's U-Boot SPL to load a FIT image th=
at
> +includes OpenSBI and U-Boot. Fully describing how to boot into U-Boot i=
s a
> +challenging task. And the booting method will be added after the SPL
> +support is available.

Could you, please, describe how to build and use the 'modified vendor's
U-Boot SPL' so that others can test and contribute.

Best regards

Heinrich

> +
> +Sample boot log from Banana Pi F3 board
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +.. code-block:: none
> +
> +   U-Boot 2024.07-00686-g608f2d51760c (Jul 08 2024 - 14:53:51 +0800)
> +
> +   DRAM:  4 GiB
> +   Core:  18 devices, 7 uclasses, devicetree: separate
> +   Loading Environment from nowhere... OK
> +   In:    serial@d4017000
> +   Out:   serial@d4017000
> +   Err:   serial@d4017000
> +   Net:   No ethernet found.
> +   bananapi_f3# cpu detail
> +     0: cpu@0      spacemit,x60
> +      ID =3D 0, freq =3D 0 Hz: MMU
> +     1: cpu@1      spacemit,x60
> +      ID =3D 1, freq =3D 0 Hz: MMU
> +     2: cpu@2      spacemit,x60
> +      ID =3D 2, freq =3D 0 Hz: MMU
> +     3: cpu@3      spacemit,x60
> +      ID =3D 3, freq =3D 0 Hz: MMU
> +     4: cpu@4      spacemit,x60
> +      ID =3D 4, freq =3D 0 Hz: MMU
> +     5: cpu@5      spacemit,x60
> +      ID =3D 5, freq =3D 0 Hz: MMU
> +     6: cpu@6      spacemit,x60
> +      ID =3D 6, freq =3D 0 Hz: MMU
> +     7: cpu@7      spacemit,x60
> +      ID =3D 7, freq =3D 0 Hz: MMU
> +   bananapi_f3#
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..3fb7d804ac8fc8dd4c7ee67f=
fc877f9ad323162d
> --- /dev/null
> +++ b/doc/board/spacemit/index.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +.. toctree::
> +   :maxdepth: 1
> +
> +   bananapi-f3
>

