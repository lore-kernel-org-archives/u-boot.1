Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF76E674A7
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 06:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7328887A;
	Fri,  1 Nov 2024 07:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="uBLF8ALT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6FA088DEA; Fri,  1 Nov 2024 07:02:57 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 963D488360
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 07:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1730440957; x=1731045757; i=xypron.glpk@gmx.de;
 bh=J8Vfu4CG2wWGISpjWVcRupsnbxlmhnyvbv4l4jTOHMY=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=uBLF8ALT/TMPCqQNBh3tZXu4lwscTgTk1hD+eF4yrbmR6FaalGKZHO7zRHd1iwXI
 gjyx6HgwpBzn+JpCrgmoq2jRr1tyXZHouqVG0pqv7jHYwHOvhVq42RWiei7KLAFi6
 18cBOQHz4n6WqWjUkMTN+houJWKyG8OTxgsGNNLwCXYkE6VVqZdUULrIZcHuzuewq
 O7d9O3T2iAUWuKoY7Lxd5V58Cwd73/Sip/UZzkfAcKT7pWrmKx/O0ccHuvgAFbWne
 5ElK2uK/SfnM/zSLcZr0ciP+BXUsovFV+PU6OA3J3KX4pQMJmnXxp68YhrQPTKDkB
 jZhgELRzxey97c4SKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([87.215.50.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTiPv-1tGoOe1L4f-00VDTa; Fri, 01
 Nov 2024 07:02:37 +0100
Date: Fri, 01 Nov 2024 07:02:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Raymond Mao <raymond.mao@linaro.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>, Stefan Roese <sr@denx.de>, 
 Alexander Gendin <agendin@matrox.com>, Michal Simek <michal.simek@amd.com>,
 Jonas Karlman <jonas@kwiboo.se>, Caleb Connolly <caleb.connolly@linaro.org>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_6/8=5D_armv8=3A_Add_generic_?=
 =?US-ASCII?Q?smbios_information_into_the_device_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTijXQCcFo5k5y6G8KUYvQQOLGAYZzNe5GQkt9fpGBam1Q@mail.gmail.com>
References: <20241022200543.116343-1-raymond.mao@linaro.org>
 <20241022200543.116343-7-raymond.mao@linaro.org>
 <CAFLszTjY=BwM8jUk_uRp-PnNu7=cXTdw0=znJwS4XDooWmNJjg@mail.gmail.com>
 <CAEfUkULBfQNz5XwWU0oY4S9tPGrYf06yByaOj-tRiua0x7WfWQ@mail.gmail.com>
 <CAFLszTijXQCcFo5k5y6G8KUYvQQOLGAYZzNe5GQkt9fpGBam1Q@mail.gmail.com>
Message-ID: <6BCB1F10-588F-4BAB-9FED-1DBFF9273DB4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vHi5E5BONngLjXXcvIH2/hzqlHrWJufiLac5Fhn1WiglubxBYt8
 FhZXrmgkLSnSW18Yi8g5bwm+ZOhbZYyJWkU65POWrvG1hc1G6AlLhGqrLUJ3skIN6jz6oWf
 9zstPrEWr90Myolcc9ud0qlYRoTURM3yKQWS4mTpmNbp/QK55DRwhhs8ck94a+HnShlqa7U
 WayvOgnBkJ56wIquyjKrA==
UI-OutboundReport: notjunk:1;M01:P0:RQDQowa1xas=;Or05FKW/1lSBoj1Rk39/3tuxIgz
 3x6dwxJOuKub8/gABhaUP2HWUxiijVLiFHw28MhSoMKkf0bYHdC5lC+G1JANj365JHkr9/nEu
 M80LL0sgQhpr9w1SDqBksBz6HvYshrDJ/3kXzVDa+aBEKCTErvK5CZof/UvUJ13mrD0VJS9QM
 9FZdnkWq8Xu4cENMzFIEyqty22iiR9IHE158RGMnwmODSRFF1lnW75GBwxMJrGKjBZHkCEldH
 3Th9xyYFVkM7RnatiUoXcWoT7RF4aAyS/Mk+dUbZ1hvcv3IgvubfjrIP2ksZRhyWWsAElVFUj
 izwcHFvfcj30eqd2298aTX5FzwnyTwg9Cu84e75gIkWtgxpxmqqRyP4gn6W9CjNEDRriUWQ3x
 J9kWgEjJTw01nvtx13KDtmKGJKUgd43tbofUIK2pPvFRMzfZ84kdu+VnpJalYVWjSyIXrCcVi
 iLnvAxFFLT4h2OSXSj+RT2byScFY1yezPVm5bRLPDGOcp0AlG+p4za9fBRvlXS3EahlNCz2Ex
 +nkA64mTBMLELE5cWzZ2aTUXu7Faz7MUgI6Jaj2tEo+mOistvV+tS6Q9CtI/0pmWD8zNkn0pH
 l3mVFam2st4Hn0YpmNvIk2i6UR+yq6owU188fi4BEMBGSvVWjndRfwOb3kdTW80LzsM3klaxz
 SbixUdpL0vzd1ybYQgdBzTR3AyASGX4bPsY+JHMiq5aBRdIkNiObwFFvBD67Ob7TEbwm6ui0H
 vBizQ7OpWgPYzQ9OTMTr+6iatDuvgzk8w5iEpPSmx2WG+/+ncPusx5C02a0PnZxSpfidIWj3s
 0HCoU1+vtFlm2kGrUlURYH+Q==
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



Am 29=2E Oktober 2024 16:45:44 MEZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>On Mon, 28 Oct 2024 at 21:00, Raymond Mao <raymond=2Emao@linaro=2Eorg> wr=
ote:
>>
>> Hi Simon,
>>
>> On Mon, 28 Oct 2024 at 13:05, Simon Glass <sjg@chromium=2Eorg> wrote:
>>>
>>> Hi Raymond,
>>>
>>> On Tue, 22 Oct 2024 at 22:07, Raymond Mao <raymond=2Emao@linaro=2Eorg>=
 wrote:
>>> >
>>> > Add common smbios information that can be used by all armv8
>>> > platforms and set it as default for qemu-arm64=2E
>>> > From now smbios library can load values from here for those fields
>>> > doesn't exist in the sysinfo driver=2E
>>> >
>>> > To run this with QEMU arm64, please dump the generated DTB
>>> > from QEMU first, merge it with the one we build and then re-run
>>> > QEMU with the merged DTB=2E
>>> > ```
>>> > qemu-system-arm -machine virt -machine dumpdtb=3Dqemu=2Edtb
>>> > cat  <(dtc -I dtb qemu=2Edtb) <(dtc -I dtb =2E/dts/dt=2Edtb | \
>>> >   grep -v /dts-v1/) | dtc - -o merged=2Edtb
>>> > qemu-system-arm -machine virt -nographic -bios u-boot=2Ebin \
>>> >   -dtb merged=2Edtb
>>>
>>> and please talk to Peter about accepting my patch[1]
>>>
>>>
>>> > ```
>>> > For details please take reference on dt_qemu=2Erst
>>> >
>>> > Signed-off-by: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>>> > ---
>>> > Changes in v2
>>> > - Initial patch=2E
>>> >
>>> >  arch/arm/dts/qemu-arm64=2Edts      |  4 ++
>>> >  arch/arm/dts/smbios_generic=2Edtsi | 82 +++++++++++++++++++++++++++=
+++++
>>> >  2 files changed, 86 insertions(+)
>>> >  create mode 100644 arch/arm/dts/smbios_generic=2Edtsi
>>> >
>>> > diff --git a/arch/arm/dts/qemu-arm64=2Edts b/arch/arm/dts/qemu-arm64=
=2Edts
>>> > index 096b3910728=2E=2E95fcf53ed74 100644
>>> > --- a/arch/arm/dts/qemu-arm64=2Edts
>>> > +++ b/arch/arm/dts/qemu-arm64=2Edts
>>> > @@ -7,5 +7,9 @@
>>> >
>>> >  /dts-v1/;
>>> >
>>> > +#if defined(CONFIG_SYSINFO_SMBIOS) && !defined(QFW_SMBIOS)
>>> > +#include "smbios_generic=2Edtsi"
>>> > +#endif
>>> > +
>>> >  / {
>>> >  };
>>> > diff --git a/arch/arm/dts/smbios_generic=2Edtsi b/arch/arm/dts/smbio=
s_generic=2Edtsi
>>> > new file mode 100644
>>> > index 00000000000=2E=2Ec9f07283403
>>> > --- /dev/null
>>> > +++ b/arch/arm/dts/smbios_generic=2Edtsi
>>> > @@ -0,0 +1,82 @@
>>> > +// SPDX-License-Identifier: GPL-2=2E0+
>>> > +/*
>>> > + * Default SMBIOS information for Arm64 platforms
>>> > + *
>>> > + * Copyright (c) 2024 Linaro Limited
>>> > + * Author: Raymond Mao <raymond=2Emao@linaro=2Eorg>
>>> > + */
>>> > +#include <config=2Eh>
>>> > +#include <smbios_def=2Eh>
>>> > +
>>> > +/ {
>>> > +       smbios {
>>> > +               compatible =3D "u-boot,sysinfo-smbios";
>>> > +
>>> > +               smbios {
>>> > +                       system {
>>> > +                               manufacturer =3D CONFIG_SYS_VENDOR;
>>> > +                               product =3D CONFIG_SYS_BOARD;
>>> > +                               version =3D "Not Specified";
>>> > +                               serial =3D "Not Specified";
>>>
>>> Does it make sense to add these strings? Perhaps if the property is mi=
ssing in the DT, it should be missing in the SMBIOS table? Is 'Not Specifie=
d' a special string in the SMBIO spec?
>>

The spec says:

"If a string field references no string, a null (0) is placed in  that str=
ing field=2E"

Please, remove the 'Not specified' values from the patch and do not provid=
e any property value in the device-tree instead=2E

Best regards

Heinrich


>>
>> This is not defined in the spec and actually those strings can be anyth=
ing=2E
>> As currently this is for qemu_arm64 only and we don't have real vendor-=
defined values,
>> "Not Specified" is used as a placeholder to show an example for other v=
endors if they
>> want to add similar properties=2E
>
>OK I see=2E
>
>Reviewed-by: Simon Glass <sjg@chromium=2Eorg>
