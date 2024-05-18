Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048D6C25B74
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 21:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41FE6882E2;
	Sat, 18 May 2024 23:12:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="rMmlVvom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E53B8856C; Sat, 18 May 2024 23:12:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FE0F882E2
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 23:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1716066773; x=1716671573; i=xypron.glpk@gmx.de;
 bh=K8oRA5tex7czrn9YTPx6NlszbXhOM2Jii1UkaHLjarw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=rMmlVvom8BGMIElI1s+jeN5W7VifoxMRWJANIzM/hNTY6hLUEdVVDbvCC/iT+bwE
 FLzJT/KzjOaI1x2RbRuqJADVKDm3C8psl1qzNi1TyeBuqkl72z7GvEFbsBgaI8KIA
 itiKGg5ijl/z4JKw5ujXWkQDZQlvS8jn3dNXgVcQSdciO49ozdo2WQ9S53W4o3oUZ
 GcmZqW4bwDV+ZFnpaU3NrSAiZahQdwnF0+SjFmxxK1od3Z6Eq+E095UMvwpe3uhqN
 bYC5kZNXZZer5Ph+Rolm5TIVVsAzJFdMTjFU/yxaS5gj8U0zA81n4DTpquy5jEMRw
 rqufH5n6u68I8YcO/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPXdC-1rvqQ30bJa-00QE8C; Sat, 18
 May 2024 23:12:53 +0200
Message-ID: <eba8f022-5d09-4fa6-bd20-f33e1e4f4f7d@gmx.de>
Date: Sat, 18 May 2024 23:12:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Pull request efi-2024-07-rc3
To: Fiona Klute <fiona.klute@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>
References: <63cd77fe-73aa-48e2-af4b-a3de9ea09d0a@gmx.de>
 <d8175e23-f1c7-4301-bd2c-ac51ba4b103e@gmx.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <d8175e23-f1c7-4301-bd2c-ac51ba4b103e@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X/D9yhtdd3R7U37lCJdKdrqybWMVXDRzG9oJXFdTprtLGbAmRL0
 9jNthR4Jc8rHnSX72tA6z63eZ4xaoJ2CtEAvUuR+FF3ZRTKmysyQMpXn/WW8Eq+XKsKrUBh
 F8nJkYaxOQ6VXEaiV4lxU7okS8AUmta+MQ25rlc4zC+dHnwBuMm+swu4h1RhLTsYa9ure5v
 Uub/KuSxH2VjL1cQ0JYUw==
UI-OutboundReport: notjunk:1;M01:P0:mhoLjH6CY2E=;eBOcDVLHMPfSMi40MnOMPNPAJqf
 RH2vAYt2irQvMuhtw3rBIIwOh9V3YJsL2X0J9HpmNYDgCtNw1gOguQSLuWkxQa/wgKOGJ4I2Z
 7H4hIIQcYTkYTR8JAU/DC9t3xgoYLmPDyCYcB0gD6zikZlHZwrhNT0raTapdb8j8AO2yryS4x
 7t31puCWomT3jb0KnfVLJWsshhEeBIOqb578TvcZckbtRr35TRVCe7FUgxOLFE4PCxTCBHKZW
 fPLR86MfXOk5F4Q183a/G+lW2A8k47RkSg99b6YiuagHV2XzQqv+J5eDDmGy5akh0xAKwjxmu
 PvFuspMXz39EofOZWJAgcwgE5msFiurR07tV+hyOVZugE9M+oLXg/Z9oQkx4KLooX1HuYM6Dm
 xC0o0nJvC1ujWGTqiRP0vh+ZMeFS227UpFbRDNQPN1yI0IOnh+3OJdJnHWU4mUUdnwCK7BUkO
 7Vtm/QN8AvrxlSPZwjZ6KW0j2JRNmfi4nl/6FAmFXnZfzmx6mDmVKhM3BqmRO70pDpufEN+Vz
 wm5nZd/o/a6gNBca7w/eWRQ3jHfo1zVQehQoQlA7SJdOLGRtvJybljsxSJlF+ge5UivUkh3ln
 7kpw1anrJ5h13solyalxzpHhR04VYca6Gv8PdSGKv7hMmKEACZl9SEfao7m8Nyzd2/Vcl08P5
 t16keiWBQxQYABWA/Ni+bhes8RtAFYa4CzJhpf6phMCSz44/21Xt2gmZ8m7/B4adgRGB2rlBT
 A3MjyoeaWXjjOyFEpgjMoprU5QbekG7S4a0SJ1l76IiJjuu/DUd8t8FSzMf1d0b1QkgXv350C
 27eq/79y5YYYUFCn2qwZ9/NUpgK30pQZvQNGrbL6GsRiM=
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

On 5/18/24 23:04, Fiona Klute wrote:
> Hi Heinrich,
>
> Am 18.05.24 um 22:51 schrieb Heinrich Schuchardt:
>> Dear Tom,
>>
>> The following changes since commit
>> 3be9f399e911cfc437a37ac826441f1d96da1c9b:
>>
>> =C2=A0=C2=A0 Init virtio before loading ENV from EXT4 or FAT (2024-05-1=
7 13:18:43
>> -0600)
>>
>> are available in the Git repository at:
>>
>> =C2=A0=C2=A0 https://source.denx.de/u-boot/custodians/u-boot-efi.git
>> tags/efi-2024-07-rc3
>>
>> for you to fetch changes up to 41145d93556e3f1d38e5147f4a6fc65610229ab4=
:
>>
>> =C2=A0=C2=A0 doc: process.rst: Document device tree resync rules (2024-=
05-18
>> 10:36:59 +0200)
>>
>> Gitlab CI reported no issues:
>> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20753
>>
>> ----------------------------------------------------------------
>> Pull request efi-2024-07-rc3
>>
>> Documentation:
>>
>> * improve netconsole documenation
>> * document device tree resync rules
>>
>> UEFI:
>>
>> * correct handling of signed variable append
>>
>> ----------------------------------------------------------------
>> Fiona Klute (2):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: Detailed example for netconso=
le setup
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: Update netconsole examples, m=
ention stderr
>
> it seems the git branch contains v2 of the netconsole documentation
> patches, not v3 with the prompt formatting change you requested. Is that
> intentional?

Your v3 arrived after I created my branch.

So let me resend this pull request tomorrow with the v3.

Best regards

Heinrich

>
> Best regards,
> Fiona
>
>> Tom Rini (2):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: process.rst: Use subsubheadin=
g for "Phases of the
>> Development Process"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doc: process.rst: Document device =
tree resync rules
>>
>> Weizhao Ouyang (1):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_loader: Fix EFI_VARIABLE_APPEN=
D_WRITE hash check
>>
>> =C2=A0=C2=A0doc/develop/devicetree/control.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 +++--
>> =C2=A0=C2=A0doc/develop/process.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++++++++---
>> =C2=A0=C2=A0doc/usage/netconsole.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 49
>> +++++++++++++++++++++-----
>> =C2=A0=C2=A0lib/efi_loader/efi_variable.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ++--
>> =C2=A0=C2=A0test/py/tests/test_efi_secboot/conftest.py=C2=A0=C2=A0=C2=
=A0=C2=A0 | 10 ++++++
>> =C2=A0=C2=A0test/py/tests/test_efi_secboot/test_authvar.py |=C2=A0 4 +-=
-
>> =C2=A0=C2=A0test/py/tests/test_efi_secboot/test_signed.py=C2=A0 | 10 ++=
+---
>> =C2=A0=C2=A07 files changed, 83 insertions(+), 26 deletions(-)
>

