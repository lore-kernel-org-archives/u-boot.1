Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4FC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 01:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7E686492;
	Fri, 25 Aug 2023 03:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RV4mBqb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00A4286993; Fri, 25 Aug 2023 03:22:37 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B60D58643B
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37P1MP8u108769;
 Thu, 24 Aug 2023 20:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692926545;
 bh=Kegq+fl2AjgJtmTRIAVRNZU7KFtAJ27etjWRTQgyE9E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RV4mBqb9a+d6UYweG0QQnXBdSFYYlvGlMVWSq4sFG0IlnThemrRz5ldIMuejLe2UO
 F+nFDjPDG1oTb5OHwUDcNsU+NAuSB8i3UAo008ExcxqlsbhT4bRTWtwW5lI32JX44S
 4aJ9Cl98gwrUIPZimOfklr+Lu47ZREoq4HuVGVfU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37P1MPlm022139
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 20:22:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 20:22:25 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 20:22:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37P1MOTx045730;
 Thu, 24 Aug 2023 20:22:24 -0500
Date: Thu, 24 Aug 2023 20:22:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Glass <sjg@google.com>
CC: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230825012224.ydk4332yb4qodrdb@unfazed>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 19:04-20230824, Simon Glass wrote:
> Hi Nishanth,
> 
> On Tue, 22 Aug 2023 at 12:43, Nishanth Menon <nm@ti.com> wrote:
> >
> > Add base documentation for BeaglePlay
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > Changes Since V3:
> > * Updated documentation to give a more clear overview of MMC partitions
> >   and flashing information.
> > * Added OpenOCD debug documentation
> > * Added LED status information and indication of various boot stages
> >
> > V3: https://lore.kernel.org/all/20230815164440.2713726-5-nm@ti.com/
> > V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
> > V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/
> >
> >  doc/board/ti/am62x_beagleplay.rst    | 256 ++++++++++
> >  doc/board/ti/img/beagleplay_emmc.svg | 697 +++++++++++++++++++++++++++
> >  doc/board/ti/k3.rst                  |   1 +
> >  3 files changed, 954 insertions(+)
> >  create mode 100644 doc/board/ti/am62x_beagleplay.rst
> >  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
> >
> > diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
> > new file mode 100644
> > index 000000000000..5adb7b4c9ace
> > --- /dev/null
> > +++ b/doc/board/ti/am62x_beagleplay.rst
> > @@ -0,0 +1,256 @@
> > +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> > +.. sectionauthor:: Nishanth Menon <nm@ti.com>
> > +
> > +AM62x Beagleboard.org Beagleplay
> > +================================
> > +
> > +Introduction:
> > +-------------
> > +
> > +BeagleBoard.org BeaglePlay is an easy to use, affordable open source
> > +hardware single board computer based on the Texas Instruments AM625
> > +SoC that allows you to create connected devices that work even at long
> > +distances using IEEE 802.15.4g LR-WPAN and IEEE 802.3cg 10Base-T1L.
> > +Expansion is provided over open standards based mikroBUS, Grove and
> > +QWIIC headers among other interfaces.
> > +
> > +Further information can be found at:
> > +
> > +* Product Page: https://beagleplay.org/
> > +* Hardware documentation: https://git.beagleboard.org/beagleplay/beagleplay
> > +
> > +Boot Flow:
> > +----------
> > +Below is the pictorial representation of boot flow:
> > +
> > +.. image:: img/boot_diagram_k3_current.svg
> > +  :alt: Boot flow diagram
> > +
> > +- On this platform, 'TI Foundational Security' (TIFS) functions as the
> > +  security enclave master while 'Device Manager' (DM), also known as the
> > +  'TISCI server' in "TI terminology", offers all the essential services.
> > +  The A53/M4F (Aux core) sends requests to TIFS/DM to accomplish these
> > +  services, as illustrated in the diagram above.
> > +
> > +Sources:
> > +--------
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_boot_sources
> > +    :end-before: .. k3_rst_include_end_boot_sources
> > +
> > +Build procedure:
> > +----------------
> > +0. Setup the environment variables:
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> > +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> > +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> > +
> > +Set the variables corresponding to this platform:
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> > +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> > +.. code-block:: bash
> > +
> > + $ export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
> > + $ export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"
> > + $ export TFA_BOARD=lite
> > + $ # we dont use any extra TFA parameters
> > + $ unset TFA_EXTRA_ARGS
> > + $ export OPTEE_PLATFORM=k3-am62x
> > + $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
> > +
> > +.. include::  am62x_sk.rst
> > +    :start-after: .. am62x_evm_rst_include_start_build_steps
> > +    :end-before: .. am62x_evm_rst_include_end_build_steps
> > +
> > +Target Images
> > +--------------
> > +Copy the below images to an SD card and boot:
> > +
> > +* tiboot3-am62x-gp-evm.bin from R5 build as tiboot3.bin
> > +* tispl.bin_unsigned from Cortex-A build as tispl.bin
> > +* u-boot.img_unsigned from Cortex-A build as uboot.img
> 
> I just noticed - I think this should be u-boot.img

Thank you for catching.

> 
> Also I tried the mmc instructions and managed to brick the board. Is
Hmm.. This is just documenting what Robert has in his scripts[1]

> there a recovery procedure?

Oopsie.. Sorry you had to hit that..

> 
> I suppose I should have tries it on an SD card first. I thought that
> was what I was doing, but I didn't know about the internal mmc...

Recovery currently involves booting off sd and flashing the emmc up :(
unfortunately.. USB DFU etc are still work in progress.

A ready to go image such as [2] emmc flasher image might help speed
things up.

[1] https://git.beagleboard.org/beagleboard/repos-arm64/-/blob/main/bb-u-boot-beagleplay-mainline/suite/bookworm/debian/install-emmc.sh
[2] https://rcn-ee.net/rootfs/debian-arm64-12-bookworm-xfce-v5.10-ti/2023-08-24/
emmc flasher image

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
