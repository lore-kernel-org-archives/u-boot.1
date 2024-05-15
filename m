Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EF8C25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 05:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29015881AC;
	Wed, 15 May 2024 07:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="JCL4Gz7b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8806C881D6; Wed, 15 May 2024 07:04:23 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF5A88191
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 07:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1715749446; x=1716354246; i=xypron.glpk@gmx.de;
 bh=AlVCNhot3vBHgg4SUTjF9Lx3nrEHbrGlzYxaMpo2PQU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=JCL4Gz7bC3RpXZNnZ2zEeT5P/1HPnAfhCUWLXdtF2r0nIlVRJjNTBJ3XlC0zCWJT
 EeY/gXsf/HYTLMV/3h2bznjmpM74ffsu3B/72crulnwkRzn/T6PANYa6XXosWIRQo
 2U49+3hnxExuDri2wmBJDLbxtSubOYso7sb/Yci/2j/UUa8xl59PNtuWK0y8ERgrK
 pzmY6jPHu57Y1XKlAvH2xHqOGKlCxLhKqsfdr+/lMcQpEvu1CrA0MREdNJbCjguGK
 lBXgwwcRfVCXApZW3wdArhdn36PA9SXmzmGfhyGqc0lR3QpBli+sotEEIDNAABh/L
 Nq8msLZSNH6p5wzk6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.55.2.71] ([149.11.192.251]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mkpex-1srDPF0THT-00ihzq; Wed, 15
 May 2024 07:04:06 +0200
Message-ID: <b16b85dc-90bf-463b-a206-06d98c3c1f0e@gmx.de>
Date: Wed, 15 May 2024 07:03:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fdt: add kaslr-seed if DM_RNG is enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
References: <20240515002248.2920155-1-tharvey@gateworks.com>
 <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <039c0adc-3014-4ae7-99b3-0df9e5366b79@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D6V8OudDFphFmwhLTzyIFlhSMolpbfObVnLDz+m6w49+gaVqjq2
 UaEVsyQz5/BGSqE7sly1pliQgeDukjURt3KpHdEwONQUs2TtsGjexeAOjEscWO2m33uvNJw
 TMq3Zl4R5okAOtaGl+yXqpXf1znJm2GNsGuZml45iUkDLrdlFh4+9zZq55DwlItDtPM0OmY
 HnFQIHCHIYyXsz6ieZiHA==
UI-OutboundReport: notjunk:1;M01:P0:4/D2ZfIr14g=;kpLK1qWhzqQghBfwxkbWhqzKFoA
 DZ85gXXaWcEnrPil0XVZXe9yE0H7aE1kuAGzL/XZmqhXx8Fqvv6ZgmVEmRjg+htaCdbhtTnVc
 0rCRWmrVhNaz/5G/d63yU9vfaWdBNfk45ZsVjj5+csTnG1CHBODN5K73XDRKHq2aSoejddeGW
 nZeqkcqVegO/VW7h+Z4NLTsCkDDAv2zHUSOxHlYlu25oQklX/xcwVg7tE5x5Y2T97w9F5XpKY
 5S2QjgloxLGffSWPJ1lCF7gJmuCti85N0sUaRrPEjimkzj+pzRHvYm+D1FI+6zPz5N1d+Fbsv
 r8FF8FgwSuoXAOkLOov/wiaGHEWOQ9K9/jCBzu6M4WXPGC4pdQKSP771UIBS7WzS5bHsiaT1Y
 bhghjMe4TLPfRis1VZb1HPC//Hh5L8VmQzj7YZXO387l56vFAMb7/T7YzP9eyBsTYO5dTf/iB
 Nq0oCcehWkc31IRGmV3+BkVfd7eBhMwI8bibkXAtn3M+LaeFXebQpCc73fX7FsViuEdeakqo7
 Q2rW1Q4mwshUA1Yo5/QTIf5+LWufoca8QqnMWcx8KkO7nb9iF5z/2jIErg7wDxA6Dl9JtZJfN
 kOYFqcmSuCo1hfL/82TZtzAMKQ0z3pSPriTPpdxfNMo+EUzFD+uBzX9H7aCp8ByjLVJCcOlKZ
 /yZnjU1Rzvan3VAYthGadnIJi3EiiifbVDDq6JiB7fZ7pauuLGle3AJv63hzEL79ckhAOtkRG
 52sFwSXfIrLWT3TYAH6u/AdEuL9gdUK/ry+BsShBX0rzqVYOug3Q0Fut4PMpqD7Le6ip+RBKC
 SjcUB9mUN5+rvO6nozjG2ydsGyk3GQETETy1cRMj14roU=
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

On 5/15/24 02:50, Marek Vasut wrote:
> On 5/15/24 2:22 AM, Tim Harvey wrote:
>> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
>> randomize the virtual address at which the kernel image is loaded, it
>> expects entropy to be provided by the bootloader by populating
>> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
>
> Thanks for working on this one, this is really nice.

The general direction of always supplying a seed for KASLR is right. But
there are some items to observe:

We already have multiple places where /chosen/kaslr-seed is set, e.g.
arch/arm/cpu/armv8/sec_firmware.c and board/xilinx/common/board.c.

Some boards are using the kaslrseed command to initialize
/chosen/kaslr-seed from DM_RNG.

It does not make sense to set it multiple times from different sources
of randomness. I am missing the necessary clean-up in this patch.

For CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT=3Dy the right way forward could be
moving sec_firmware_get_random() into the driver model. Tom is the
maintainer for this code.

For Xilinx boards your patch obsoletes part of the code in
ft_board_setup() of board/xilinx/common/board.c. CCing Michal as maintaine=
r.

The kaslrseed command similarly becomes obsolete with your patch and
should be removed. 'git grep -n CMD_KASLR' indicates which defconfigs
would be impacted.

label_boot_kaslrseed() needs review too.

kaslr-seed is not compatible with measured boot if the device-tree is
measured. When booting via EFI in efi_try_purge_kaslr_seed() we can
safely remove the value because it is not used anyway; we provide the
EFI_RNG_PROTOCOL instead. We also support measured boot via the legacy
Linux entry point. See patch dec166d6b2c2 ("bootm: Support boot
measurement"). We should not populate kaslr-seed if
CONFIG_MEASURE_DEVICETREE=3Dy. CCing Eddie and Ilias as they have been
working on measured boot.

>
>> If we have DM_RNG enabled poulate this value automatically when

nits

%s/poulate/populate/

Best regards

Heinrich

>> fdt_chosen is called.
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>> =C2=A0 boot/fdt_support.c | 23 +++++++++++++++++++++++
>> =C2=A0 1 file changed, 23 insertions(+)
>>
>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>> index 874ca4d6f5af..cd3069baf450 100644
>> --- a/boot/fdt_support.c
>> +++ b/boot/fdt_support.c
>> @@ -7,10 +7,12 @@
>> =C2=A0=C2=A0 */
>> =C2=A0 #include <abuf.h>
>> +#include <dm.h>
>> =C2=A0 #include <env.h>
>> =C2=A0 #include <log.h>
>> =C2=A0 #include <mapmem.h>
>> =C2=A0 #include <net.h>
>> +#include <rng.h>
>> =C2=A0 #include <stdio_dev.h>
>> =C2=A0 #include <dm/ofnode.h>
>> =C2=A0 #include <linux/ctype.h>
>> @@ -300,6 +302,27 @@ int fdt_chosen(void *fdt)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nodeoffset < 0)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nodeoffse=
t;
>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_DM_RNG)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct udevice *dev;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t len =3D 0x8;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 *data;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data =3D malloc(len);
>
> Can you allocate this 8 byte array on stack , i.e. u64 data[2]; ?
>
> cmd/kaslrseed.c could use similar clean up (and
> lib/efi_loader/efi_dt_fixup.c and boot/pxe_utils.c ... uhhh). Maybe you
> can deduplicate this functionality into common code shared by all those
> duplicates before the duplication gets out of control ?
>
> lib/kaslrseed.c looks like a good place to put the common stuff.
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!data)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D uclass_get_device(U=
CLASS_RNG, 0, &dev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
 =3D dm_rng_read(dev, data, len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!err)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err=
 =3D fdt_setprop(fdt, nodeoffset, "kaslr-seed", data, len);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pri=
ntf("WARNING: could not set kaslr-seed %s.\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fdt_strerror(err));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn err;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> You're missing free() here, but it shouldn't be needed if you allocate
> the array on stack, which is better/simpler.

