Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720AAC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE9A83423;
	Sat, 24 May 2025 06:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j0tyTiWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBB483438; Sat, 24 May 2025 06:29:24 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C1F833FA
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748060949; x=1748665749; i=xypron.glpk@gmx.de;
 bh=QlgIti9tfh0wLINiGWyqM/vEOSdTO1V3r+XIKnUU9Ao=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j0tyTiWh9uNWvRnPdgM5Nqz5uyXl4t1Avn4xC7Np0PZCppQdh8xAkqNFNWcXhdVR
 NyT2WogXAfMOzrFPRb2aYCpsoAeALioPyIDOAx59BiRam2iG3McncpeEElMCyb/Rv
 6ETgjCMXOylin/Vc6sEDFjcrAV31OTzUY3dN3/G42X0vu5MpmTAbBrFAuiSG+Zsnu
 w8ubqoaPFuoOkQeXrHq2keBuQXFQ8LuBtaxLBpBdljfQij8jU9qucaeKjVBuxq1MR
 tmq5FWD5P/+V7Y8Ar9OePggvYf2kA1l6tzv1NOaetzRl4HD8PoXM7ch19in51n+wy
 NadKao+hlIFqVPgsfw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.110.169]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fjb-1uFg5z4A0F-00HaiV; Sat, 24
 May 2025 06:29:09 +0200
Message-ID: <fbe649de-dc78-4ef3-8204-95020ff2cf45@gmx.de>
Date: Sat, 24 May 2025 06:29:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bootm: Pass SMP core ID and DTB address for ELF-formatted
 kernels
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, =?UTF-8?B?54mbIOW/l+Wujw==?=
 <Zone.Niuzh@hotmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>
References: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
 <CAFLszTgpYgVfrf4P189tcNM7xOvoiVjMu_sP1nrP+FGfAYHYSw@mail.gmail.com>
 <28BD711D-9449-46DA-AD38-8142B0CAF7AB@gmx.de>
 <20250523222926.GZ100073@bill-the-cat>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250523222926.GZ100073@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Ypz8sKDTj6SSaUeeEoQrEm2f2dG/xePpDR7P/HqowBI7MhrqRR
 Fhbs6LVwg19ukUuzqb4pQyUBtNI2miYjPICZoThpaslxD0iTFawiK6UEUrkKr0AGSs9RbCH
 MfAzT+PL++xcgA/3ptqnmcN7qCMdapXfo2CQCjUafA0uhEzb6XKjYI8G23kmVsx8jzmp8BC
 PmK6s2osj0b/BnZET4KtA==
UI-OutboundReport: notjunk:1;M01:P0:tes2lrT/mbo=;7ccdz5yiWlVCFi8XRfrB8dLEBk9
 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
 iE11CMQIiXGz31Gum2ZDiMvCC7chtl49yp
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

On 5/24/25 00:29, Tom Rini wrote:
> On Fri, May 23, 2025 at 07:04:46PM +0200, Heinrich Schuchardt wrote:
>> Am 23. Mai 2025 18:41:45 MESZ schrieb Simon Glass <sjg@chromium.org>:
>>> +Heinrich Schuchardt
>>>
>>> Hi,
>>>
>>> On Tue, 13 May 2025 at 13:28, =E7=89=9B =E5=BF=97=E5=AE=8F <Zone.Niuzh=
@hotmail.com> wrote:
>>>>
>>>> When booting RISC-V ELF-formatted kernel images (IH_TYPE_KERNEL + IH_=
OS_ELF),
>>>> explicitly pass SMP core/hart ID and DTB address to comply with moder=
n
>>>> SMP-enabled kernels' boot protocol requirements.
>>>>
>>>> Signed-off-by: Zone.N <zone.niuzh@hotmail.com>
>>>> ---
>>>>   boot/bootm_os.c | 5 +++++
>>>>   1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/boot/bootm_os.c b/boot/bootm_os.c
>>>> index a3c7cb5332e..a0f310b1359 100644
>>>> --- a/boot/bootm_os.c
>>>> +++ b/boot/bootm_os.c
>>>> @@ -402,6 +402,11 @@ static int do_bootm_elf(int flag, struct bootm_i=
nfo *bmi)
>>>>          if (flag !=3D BOOTM_STATE_OS_GO)
>>>>                  return 0;
>>>>
>>>> +#if defined(CONFIG_RISCV)
>>>> +       bmi->argc =3D gd->arch.boot_hart;
>>>> +       bmi->argv =3D (char **)bmi->images->ft_addr;
>>>> +#endif
>>>
>>> If this is a kernel, it should really be using a FIT.  The Elf entry
>>> is for general ELF files, not Linux. Perhaps RISC-V is special in some
>>> way?
>>
>> A defconfig kernel is booted via the booti command or via its EFI stub.
>>
>> Why would you use an ELF formatted kernel? What kernel configuration ar=
e you using to get such a kernel?
>=20
> This is I assume a non-Linux OS kernel being booted. So the question is,
> does anyone externally have some standard defined here which should be
> used?
>=20

https://docs.kernel.org/arch/riscv/boot.html describes the requirements:

"The RISC-V kernel expects:

         $a0 to contain the hartid of the current core.

         $a1 to contain the address of the devicetree in memory."

Both the bootm command and the bootelf command end up calling=20
bootelf_exec(). So the correction should probably be made in lib/elf.c=20
and not in /boot/bootm_os.c.

a0 and a1 are the the first and second arguments in the RISC-V calling=20
convention.

Using a0 and a1 as required by the kernel is completely incompatible=20
with the current design of the bootelf command where you can pass=20
arbitrary string arguments to an ELF binary.

CONFIG_CMD_ELF_FDT_SETUP allows to pass a device-tree address string as=20
argv[0].

It is unclear to me if there are use cases where we want to execute ELF=20
binaries that are not OS kernels via the bootelf or bootm command.

The RISC-V maintainers should review any change for RISC-V in the=20
handling of ELF binaries.

Best regards

Heinrich
