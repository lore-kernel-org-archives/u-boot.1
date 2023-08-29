Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0EC6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 07:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE25864D2;
	Tue, 29 Aug 2023 09:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="jR1GfCgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ADA3864D2; Tue, 29 Aug 2023 09:58:21 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC2286420
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:58:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693295894; x=1693900694; i=xypron.glpk@gmx.de;
 bh=t+MZHvIptKJgpAiFMbTLcOGfrH9xk2iF5ONgvFubn38=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=jR1GfCgo0U4CiuoZDAUtuEKf+ZxwyghqvCOghxnlQ02+GLapHSX08iJjLMmCf4vOsMVXGA8
 J9eWHPntqVOI7o7iAT9dW7STAmUHixPShXov8RghbgKbMDgMxMCsZYglNLwbiwBVWCrQDmhyA
 Kw+7kqEWgZgab+Gn2CS99QCiFk4tZbIC7Z3sSTiMEB9k7Tngg3i/cDOreMw/sqttUUEd6SpGL
 YFBCo0HKWtZBag0DWENgW901psRZ+Oc/KtzHngVfcVezVxurO6qub2DTFSrTAikD7NczqgRK6
 91A8tLXlqSaI+7/dBSTJy5a34XeiifCEEhytlksaGdFqe53nOQsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1qMg8w00Dk-00N8oA; Tue, 29
 Aug 2023 09:58:14 +0200
Message-ID: <fe21b3f3-da2c-4783-ab8b-acd1fb9a959a@gmx.de>
Date: Tue, 29 Aug 2023 09:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] doc: board: toradex: minor documentation update
Content-Language: en-US, de-DE
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
References: <20230828220154.483362-1-marcel@ziswiler.com>
 <20230828220154.483362-2-marcel@ziswiler.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230828220154.483362-2-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:co6IfUwKyZWM+kZyok+gGeWNBgg4Kb1De/RpmnJK3hHbTSf9dJg
 +k4yLD6IxndOgQbploGnSmiO+uuijA12ouJR1S5QaQLRv80EAJXoP0nGPMVHIGjQaroYqK+
 eVQZYiGQAnTVd0lfRzkL+ifYuS8wfgUkFZE3gWPk+PM4L9DcawQ9F2m9x716jo+8OCTFgZa
 0dJjr+qAH0tgALSvMVbyQ==
UI-OutboundReport: notjunk:1;M01:P0:3c0qezaw2vg=;bTq8Y30d7ULiSehGhcFITq7XQgf
 KKgFiQ7tYUQuEp5Muh3nAkBlvqDQ1hIF/EM2U5i17SwozWwP3OQ1xAXDbelfNOpemVXlZw3S4
 CVzv3ajZHcmeBg7O55aQg7DcaMf1MaYsutltfLi3ksiUeYnSnaVpdJC0UP0RlEs0BtMk+T1Jt
 6Q+RXG6Wo9DK+BbFhJHaxP7JRCrk1gANctAqJcS+AjY8X2AVO6/AH+NoU/JEfgs/ApIJocsN5
 TgmFC8TIdnCav4uNnsMxM4hPP9+DWLXj5fpNUSkIun2AbME6L5W4c5Yfx4FoKZ0lvBdM/jV8a
 EISvzV7PCTeL8gx8UPC85tl81ZNh3j1Lpg5eM/BFUMx9EjVgbYZGwEmThszO8/wENl98yKO7G
 ynsd/W27Q/cWfD+if7pDN6ajScCuYop653u0K/rLAuueIh2F/HoukUYm1BidAZj1nPgv8Ps1O
 Z7rGHDXLzi2uOq7s84R4dqUqDftJNZuMzXcXRqbbQz60BRQ3TZfdNlveeTxl7kvkE6lA8spS7
 ea+sc/3SdM1cYa9nVVLOQ63l12SNjXEwKI3sxunr7jAQKpIMQBwPamDNzb18SSGjOKu9RTJt4
 oqFSZ2QJE2Vh3+WUTi83uSfAKYc19Cu9TPqNL2ltyTgSiCY1WaLS339dqkhr9gEyp+zXj/PpG
 XXVTowUTVP9e/fCHQ4ziR2sLtIMeYo3BbeWxo8mthz9uNLasuBnpxJGO2dKEMVZt3KyDY8plP
 B4Cuspo5kMNAJlzU2EBG5LxSC64+w5c1b8BrwqPtPOoUMadSMolAJkGfyyAn5nyC1C6HOickR
 HtEeP1keOyoytBR0nPWo1mwmJ30FUAPB4NrZ882T7Ix4k8JGXO7PlHHh+Zho2aMegs01DOso3
 SMUMu/R2QKoSKRCjtCYiCM/0C7zcq1BfWx4GnD0pv2rGGyHsnA5NZhJTYxL1ICPcsdjPlh5ne
 vWs6YeLfIKTd/BEVRUTGLpmOETw=
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

On 8/29/23 00:01, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> - Update SPDX-License-Identifier from obsolete GPL-2.0+ to
>    GPL-2.0-or-later.
> - Add links to product websites of SoM and carrier board where missing.
> - Add information about update U-Boot wrapper where missing.
> - Add sectionauthor where missing.
> - Update information about imx-seco from version 3.7.4 to 3.8.1.
> - Various minor grammatic and spelling fixes.
> - Improve whitespace by adding or removing new lines.
> - Change from code-block for output to just Output::.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>
>   doc/board/toradex/apalis-imx8.rst   | 22 +++++++++++++----
>   doc/board/toradex/colibri-imx8x.rst | 31 ++++++++++++++++-------
>   doc/board/toradex/colibri_imx7.rst  | 38 +++++++++++++++--------------
>   doc/board/toradex/verdin-am62.rst   |  8 +++---
>   doc/board/toradex/verdin-imx8mm.rst |  9 +++----
>   doc/board/toradex/verdin-imx8mp.rst |  9 +++----
>   6 files changed, 71 insertions(+), 46 deletions(-)
>
> diff --git a/doc/board/toradex/apalis-imx8.rst b/doc/board/toradex/apali=
s-imx8.rst
> index 849b1172bd4..ffc4c7d222a 100644
> --- a/doc/board/toradex/apalis-imx8.rst
> +++ b/doc/board/toradex/apalis-imx8.rst
> @@ -1,7 +1,11 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. sectionauthor:: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> -Apalis iMX8QM V1.0B Module
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +Apalis iMX8 Module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- SoM: https://www.toradex.com/computer-on-modules/apalis-arm-family/nx=
p-imx-8
> +- Carrier board: https://www.toradex.com/products/carrier-board/apalis-=
evaluation-board
>
>   Quick Start
>   -----------
> @@ -49,6 +53,7 @@ Copy the following firmware to the U-Boot folder:
>
>   Build U-Boot
>   ------------
> +
>   .. code-block:: bash
>
>       $ make apalis-imx8_defconfig
> @@ -61,8 +66,8 @@ Get the latest version of the universal update utility=
 (uuu) aka ``mfgtools 3.0`
>
>   https://community.nxp.com/external-link.jspa?url=3Dhttps%3A%2F%2Fgithu=
b.com%2FNXPmicro%2Fmfgtools%2Freleases
>
> -Put the module into USB recovery aka serial downloader mode, connect US=
B device
> -to your host and execute uuu:
> +Put the module into USB recovery aka serial downloader mode, connect th=
e USB
> +device to your host and execute ``uuu``:
>
>   .. code-block:: bash
>
> @@ -80,3 +85,10 @@ partition and boot:
>       setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0=
x200
>       mmc dev 0 1
>       mmc write ${loadaddr} 0x0 ${blkcnt}
> +
> +As a convenience, instead of the last three commands, one may also use =
the
> +update U-Boot wrapper:
> +
> +.. code-block:: bash
> +
> +    > run update_uboot
> diff --git a/doc/board/toradex/colibri-imx8x.rst b/doc/board/toradex/col=
ibri-imx8x.rst
> index 545568c844a..9e61d98c6b1 100644
> --- a/doc/board/toradex/colibri-imx8x.rst
> +++ b/doc/board/toradex/colibri-imx8x.rst
> @@ -1,7 +1,11 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. sectionauthor:: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> -Colibri iMX8QXP V1.0D Module
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +Colibri iMX8X Module
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- SoM: https://www.toradex.com/computer-on-modules/colibri-arm-family/n=
xp-imx-8x
> +- Carrier board: https://www.toradex.com/products/carrier-board/colibri=
-evaluation-board
>
>   Quick Start
>   -----------
> @@ -23,18 +27,19 @@ Get and Build the ARM Trusted Firmware
>
>   Get scfw_tcm.bin and ahab-container.img
>   ---------------------------------------
> +
>   .. code-block:: bash
>
>       $ wget https://github.com/toradex/i.MX-System-Controller-Firmware/=
raw/master/src/scfw_export_mx8qx_b0/build_mx8qx_b0/mx8qx-colibri-scfw-tcm.=
bin
> -    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-seco-3.7.4.bin
> -    $ sh imx-seco-3.7.4.bin --auto-accept
> +    $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/imx-seco-3.8.1.bin
> +    $ sh imx-seco-3.8.1.bin --auto-accept
>
>   Copy the following firmware to the U-Boot folder:
>
>   .. code-block:: bash
>
>       $ cp imx-atf/build/imx8qx/release/bl31.bin .
> -    $ cp imx-seco-3.7.4/firmware/seco/mx8qxc0-ahab-container.img mx8qx-=
ahab-container.img
> +    $ cp imx-seco-3.8.1/firmware/seco/mx8qxc0-ahab-container.img mx8qx-=
ahab-container.img
>
>   Build U-Boot
>   ------------
> @@ -51,8 +56,8 @@ Get the latest version of the universal update utility=
 (uuu) aka ``mfgtools 3.0`
>
>   https://community.nxp.com/external-link.jspa?url=3Dhttps%3A%2F%2Fgithu=
b.com%2FNXPmicro%2Fmfgtools%2Freleases
>
> -Put the module into USB recovery aka serial downloader mode, connect US=
B device
> -to your host and execute ``uuu``:
> +Put the module into USB recovery aka serial downloader mode, connect th=
e USB
> +device to your host and execute ``uuu``:
>
>   .. code-block:: bash
>
> @@ -61,7 +66,8 @@ to your host and execute ``uuu``:
>   Flash the U-Boot Binary into the eMMC
>   -------------------------------------
>
> -Burn the ``u-boot-dtb.imx`` binary to the primary eMMC hardware boot ar=
ea partition:
> +Burn the ``u-boot-dtb.imx`` binary to the primary eMMC hardware boot ar=
ea
> +partition and boot:
>
>   .. code-block:: bash
>
> @@ -69,3 +75,10 @@ Burn the ``u-boot-dtb.imx`` binary to the primary eMM=
C hardware boot area partit
>       setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} / 0=
x200
>       mmc dev 0 1
>       mmc write ${loadaddr} 0x0 ${blkcnt}
> +
> +As a convenience, instead of the last three commands, one may also use =
the
> +update U-Boot wrapper:
> +
> +.. code-block:: bash
> +
> +    > run update_uboot
> diff --git a/doc/board/toradex/colibri_imx7.rst b/doc/board/toradex/coli=
bri_imx7.rst
> index a30e721379e..6532878932c 100644
> --- a/doc/board/toradex/colibri_imx7.rst
> +++ b/doc/board/toradex/colibri_imx7.rst
> @@ -1,7 +1,11 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +.. sectionauthor:: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> -Colibri iMX7
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Colibri iMX7 Modules
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- SoM: https://www.toradex.com/computer-on-modules/colibri-arm-family/n=
xp-freescale-imx7
> +- Carrier board: https://www.toradex.com/products/carrier-board/colibri=
-evaluation-board
>
>   Quick Start
>   -----------
> @@ -21,11 +25,11 @@ Build U-Boot
>       $ make colibri_imx7_emmc_defconfig # For NAND: colibri_imx7_defcon=
fig
>       $ make
>
> -After build succeeds, you will obtain final ``u-boot-dtb.imx`` IMX spec=
ific
> -image, ready for flashing (but check next section for additional
> +After the build succeeds, you will obtain the final ``u-boot-dtb.imx`` =
IMX
> +specific image, ready for flashing (but check next section for addition=
al
>   adjustments).
>
> -Final IMX program image includes (section ``6.6.7`` from `IMX7DRM
> +The final IMX program image includes (section ``6.6.7`` from `IMX7DRM
>   <https://www.nxp.com/webapp/Download?colCode=3DIMX7DRM>`_):
>
>   * **Image vector table** (IVT) for BootROM
> @@ -34,21 +38,20 @@ Final IMX program image includes (section ``6.6.7`` =
from `IMX7DRM
>   * **Device configuration data**
>   * **User image**: U-Boot image (``u-boot-dtb.bin``)
>
> -
>   IMX image adjustments prior to flashing
>   ---------------------------------------
>
>   1. U-Boot for both Colibri iMX7 NAND and eMMC versions
>   is built with HABv4 support (`AN4581.pdf
>   <https://www.nxp.com/docs/en/application-note/AN4581.pdf>`_)
> -enabled by default, which requires to generate a proper
> +enabled by default, which requires generating a proper
>   Command Sequence File (CSF) by srktool from NXP (not included in the
>   U-Boot tree, check additional details in introduction_habv4.txt)
>   and concatenate it to the final ``u-boot-dtb.imx``.
>
> -2. In case if you don't want to generate a proper ``CSF`` (for any reas=
on),
> -you still need to pad the IMX image so i has the same size as specified=
 in
> -in **Boot Data** section of IMX image.
> +2. In case you don't want to generate a proper ``CSF`` (for any reason)=
,
> +you still need to pad the IMX image so it has the same size as specifie=
d in
> +the **Boot Data** section of the IMX image.
>   To obtain this value, run:
>
>   .. code-block:: bash
> @@ -78,11 +81,11 @@ and then pad the image:
>       $ objcopy -I binary -O binary --pad-to 0xa7c60 --gap-fill=3D0x00 \
>           u-boot-dtb.imx u-boot-dtb.imx.zero-padded
>
> -3. Also, according to requirement from ``6.6.7.1``, the final image
> -should have ``0x400`` offset for initial IVT table.
> +3. Also, according to the requirement from ``6.6.7.1``, the final image
> +should have ``0x400`` offset for the initial IVT table.
>
> -For eMMC setup we handle this by flashing it to ``0x400``, howewer
> -for NAND setup we adjust the image prior to flashing, adding padding in=
 the
> +For eMMC setup we handle this by flashing it to ``0x400``, however
> +for NAND setup we adjust the image prior to flashing, adding padding at=
 the
>   beginning of the image.
>
>   .. code-block:: bash
> @@ -97,7 +100,6 @@ boot area partition:
>
>   .. code-block:: bash
>
> -
>       =3D> load mmc 1:1 $loadaddr u-boot-dtb.imx.zero-padded
>       =3D> setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt=
} / 0x200
>       =3D> mmc dev 0 1
> @@ -117,8 +119,8 @@ Flash U-Boot IMX image to NAND
>   Using update_uboot script
>   -------------------------
>
> -You can also usb U-Boot env update_uboot script,
> -which wraps all eMMC/NAND specific command invocation:
> +You can also use U-Boot env update_uboot script,
> +which wraps all eMMC/NAND specific command invocations:
>
>   .. code-block:: bash
>
> diff --git a/doc/board/toradex/verdin-am62.rst b/doc/board/toradex/verdi=
n-am62.rst
> index 36db149cda0..ecc7e0777cb 100644
> --- a/doc/board/toradex/verdin-am62.rst
> +++ b/doc/board/toradex/verdin-am62.rst
> @@ -24,12 +24,14 @@ For an overview of the TI AM62 SoC boot flow please =
head over to:
>
>   Sources:
>   --------
> +
>   .. include::  ../ti/k3.rst
>       :start-after: .. k3_rst_include_start_boot_sources
>       :end-before: .. k3_rst_include_end_boot_sources
>
>   Build procedure:
>   ----------------
> +
>   0. Setup the environment variables:
>
>   .. include::  ../ti/k3.rst
> @@ -50,7 +52,7 @@ Set the variables corresponding to this platform:
>    $ export UBOOT_CFG_CORTEXR=3Dverdin-am62_r5_defconfig
>    $ export UBOOT_CFG_CORTEXA=3Dverdin-am62_a53_defconfig
>    $ export TFA_BOARD=3Dlite
> - $ # we dont use any extra TFA parameters
> + $ # we don't use any extra TFA parameters
>    $ unset TFA_EXTRA_ARGS
>    $ export OPTEE_PLATFORM=3Dk3-am62x
>    $ export OPTEE_EXTRA_ARGS=3D"CFG_WITH_SOFTWARE_PRNG=3Dy"
> @@ -75,9 +77,7 @@ Flash to eMMC
>   Boot
>   ----
>
> -Output:
> -
> -.. code-block:: none
> +Output::
>
>     U-Boot SPL 2023.10-rc1-00210-gb678170a34c (Aug 03 2023 - 00:09:14 +0=
200)
>     SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.1--v09.00.01 (Kool Koala)')
> diff --git a/doc/board/toradex/verdin-imx8mm.rst b/doc/board/toradex/ver=
din-imx8mm.rst
> index cc39030450f..6e150e9aec7 100644
> --- a/doc/board/toradex/verdin-imx8mm.rst
> +++ b/doc/board/toradex/verdin-imx8mm.rst
> @@ -46,6 +46,7 @@ Get the DDR Firmware
>
>   Build U-Boot
>   ------------
> +
>   .. code-block:: bash
>
>       $ export CROSS_COMPILE=3Daarch64-linux-gnu-
> @@ -61,7 +62,7 @@ Flash to eMMC
>       > setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} /=
 0x200
>       > mmc dev 0 1 && mmc write ${loadaddr} 0x2 ${blkcnt}
>
> -As a convenience, instead of the last two commands one may also use the=
 update
> +As a convenience, instead of the last two commands, one may also use th=
e update
>   U-Boot wrapper:
>
>   .. code-block:: bash
> @@ -71,16 +72,14 @@ U-Boot wrapper:
>   Boot
>   ----
>
> -ATF, U-Boot proper and u-boot.dtb images are packed into FIT image,
> +ATF, U-Boot proper and u-boot.dtb images are packed into a FIT image,
>   which is loaded and parsed by SPL.
>
>   Boot sequence is:
>
>   * SPL ---> ATF (TF-A) ---> U-Boot proper
>
> -Output:
> -
> -.. code-block:: none
> +Output::
>
>     U-Boot SPL 2021.10-rc2-00028-gee010ba1129 (Aug 23 2021 - 16:56:02 +0=
200)
>     Normal Boot
> diff --git a/doc/board/toradex/verdin-imx8mp.rst b/doc/board/toradex/ver=
din-imx8mp.rst
> index bdc4d0c2cb5..9ee605f64d5 100644
> --- a/doc/board/toradex/verdin-imx8mp.rst
> +++ b/doc/board/toradex/verdin-imx8mp.rst
> @@ -46,6 +46,7 @@ Get the DDR Firmware
>
>   Build U-Boot
>   ------------
> +
>   .. code-block:: bash
>
>       $ export CROSS_COMPILE=3Daarch64-linux-gnu-
> @@ -61,7 +62,7 @@ Flash to eMMC
>       > setexpr blkcnt ${filesize} + 0x1ff && setexpr blkcnt ${blkcnt} /=
 0x200
>       > mmc dev 2 1 && mmc write ${loadaddr} 0x0 ${blkcnt}

Thank you for keeping the documentation accurate.

The configuration for the board has:

SYS_PROMPT "Verdin iMX8MP # "
SYS_PROMPT_HUSH_PS2 "> "

I would not have expected the secondary prompt '> ' here.

Best regards

Heinrich

>
> -As a convenience, instead of the last two commands one may also use the=
 update
> +As a convenience, instead of the last two commands, one may also use th=
e update
>   U-Boot wrapper:
>
>   .. code-block:: bash
> @@ -71,16 +72,14 @@ U-Boot wrapper:
>   Boot
>   ----
>
> -ATF, U-Boot proper and u-boot.dtb images are packed into FIT image,
> +ATF, U-Boot proper and u-boot.dtb images are packed into a FIT image,
>   which is loaded and parsed by SPL.
>
>   Boot sequence is:
>
>   * SPL ---> ATF (TF-A) ---> U-Boot proper
>
> -Output:
> -
> -.. code-block:: none
> +Output::
>
>     U-Boot SPL 2022.04-rc1-00164-g21a0312611-dirty (Feb 07 2022 - 11:34:=
04 +0100)
>     Quad die, dual rank failed, attempting dual die, single rank configu=
ration.

