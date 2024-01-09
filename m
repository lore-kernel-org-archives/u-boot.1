Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4701C47073
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 09:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10EBD86C39;
	Tue,  9 Jan 2024 10:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UjFiWCBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DE58706B; Tue,  9 Jan 2024 10:07:42 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3769386611
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 10:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1704791258; x=1705396058; i=xypron.glpk@gmx.de;
 bh=Mt8bM8+UHC3ICzGKEGsilC2YJUDxsd6PaluEAIGWWK8=;
 h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
 b=UjFiWCBFgR65ODxMSMeLY9zZATL2qv/zV5SWadwZ+8EU9rpNOKaPwm1zUjtQESzG
 nZlR6RG0VxvqTYf/8h77MdkbhYhcX+tALcQIEcQ3sAEd1YU2Jz+9dYI177ACBVZyV
 kCSnb7h2YRJo96shh3OtBA9Qr32Jdab31I/oosv8Jvbl9byCBTs5Is7QVLDKQq6g6
 sAlwYeJZRFrFDSNN0q1qZU+wLFOj5YUno9iUqisxHpPoGdlKc7Q1pfIsShqo9VahB
 2RNOhxgseKkXle0/qsWnUHlRTs4MvSFC1zdc/pI+/22OICdYEeVWc4w8iHKeeA7bm
 Nbl1o2bsO/7JVaEyRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([178.202.40.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1rV8Zh2KzX-00Aqi7; Tue, 09
 Jan 2024 10:07:38 +0100
Message-ID: <44bea48c-b453-452a-84d1-9a5ae88c5f15@gmx.de>
Date: Tue, 9 Jan 2024 10:07:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Pull request rng-2024-04-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6KaFBFFoA9zRCASmaQJhzP6bfmFbZkZPZpifhes8dZDO40g1CEx
 tfN4/R71MijfMqusaRdObh0/VPcSW9Dck/J8WpeEimdS8vCdM8Hocu/gOic/mJ4MvK+JDTM
 7KasJN9SxE7inz9YAEBgPuEc1Y62nGbX4NWEQ0yJi1ewPLltrKQeJaHJbH283R58qSGnPAT
 W4c+JdcfOf/6WiQ1lPOIg==
UI-OutboundReport: notjunk:1;M01:P0:UM+tFEqvjLM=;uZLzsXTWAL3Sm0KzB8tJF2RxRuF
 0//qWgrfqdnyUN80pJH4dv1vlY77GOE4Kd/KF6+aKccM/J5VqenXGdI7uBmG1Sjj3DTWEj5gh
 wmq2Mh8tgomjdp+Cr3w4EORYzTLsufAf9ru2ZazX5ND9eRT1zJTm8WDuuk1TaWSq641dwojw7
 Ur2KnWJkWAZQsbNC6/jR4hffZfXf7LH/ClVq3Moqem9V3z8EuJeQbG6wM89rpU8y/vHNLM8E2
 NpB8NW5nZDxBO99TfLlEaddGAdICeHCJrVrCWk1EjsD0JQDdZA8NR6GZgGEUw5ZObZoaNLebi
 DuX0I5dAlWSIhAACLpfu2vJObRgfFhPCM2kU8EMLBuYl6EO3zi1rxnIXYJ8D+knfUg/tN+yOx
 a53Iw189EL51JPz3+XTYay3dHLv7G/MBXiEeWVREYQNy8Bp9+KzaqjYjRmY07EbrhUlDPHnh/
 kxjH6Mud8eFcY2bYyewWnnDeSCO8ew07zWj1zlqeQi7WmRD6LAiqWor5nSgS8p66gmIinfHhE
 veynFbFIYylY+XEZCxXnW00ARKGO0YD2JRbMtD13sAU7uDJaLUi/KPa9ptDWm6z6bVR0f8367
 uQIj74OTyhPx0C1SEBMgZ76Qzr4usZJZEQlbs8x6CBCVH4e3mQCxmE9ld/HxWLWV8+OZ6UupF
 p0kh+MQ3oLcRoEp8xwqPPpQAB4U33YC0/JeQauUsIlINBLkI+Gw12b2V37BviQh+hFv8nSvde
 JlPiPyRmwAaycPijRvTAoAtuFRGUIOOuFO9kWQw1jDtUciyhQjVkx1Kzi8F95kWZxZAcce83r
 7LZmAiWtjpsUHdj+jrNIZ9TUAIaXGXKAAOiS6QPX2mOGV8TCU18yGYEqhFa+V9c7e1feU6uL5
 Pp+w8KfsdJBt2bElliI2ojvzBrQYqFBxT2Bhv9Bt+tnHcZqmoy8eih4pvn4uo0j1+0Tx+lW+c
 0zA/domvF4DPR7fWg+9qYKthDnv6fqST54a9R3lWTB1mnft82Lirej7XLbFFBhb6SPU597wSQ
 Lt/CApmXlWpSTs3rC4=
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

Dear Tom,

The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb4=
d:

   Merge tag 'u-boot-imx-master-20240108' of
https://gitlab.denx.de/u-boot/custodians/u-boot-imx (2024-01-08 13:39:43
-0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-efi.git
tags/rng-2024-04-rc1

for you to fetch changes up to 1351cd3b4b1b18cafa4893a44378ca6b1d091c8e:

   rng: detect RISC-V Zkr RNG device in bind method (2024-01-09 07:37:05
+0100)

Gitlab CI showed no issues:
https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/19241

=2D---------------------------------------------------------------
Pull request rng-2024-04-rc1

QEMU does not provide information in the device-tree if the ARMv8.5 RNDR
or the RISC-V Zkr RNG have been enabled on the command line.

In different parts of our code we assume that the first RNG device is the
one to be used. Therefore it is preferable to detect the availability of
said devices already in the bind method.

There has been a related discussion if the U_BOOT_DRVINFO() macro should b=
e
used for architectural devices
(https://lore.kernel.org/u-boot/20231031125552.26698-1-heinrich.schuchardt=
@canonical.com/).
This aspect is not touched by this series.

=2D---------------------------------------------------------------
Heinrich Schuchardt (2):
       rng: fix ARMv8.5 RNDR driver
       rng: detect RISC-V Zkr RNG device in bind method

  drivers/rng/arm_rndr.c      |  6 +++---
  drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
  2 files changed, 29 insertions(+), 11 deletions(-)
