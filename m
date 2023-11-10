Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21705C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 13:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DAE98761C;
	Fri, 10 Nov 2023 14:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="R6tekrI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 916968761C; Fri, 10 Nov 2023 14:12:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83DDC87632
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 14:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1699621969; x=1700226769; i=xypron.glpk@gmx.de;
 bh=V+/oAle2Qb5W89CAdzyAJpxl6n+9yxUpcZKNIvIRSs0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=R6tekrI7V2FaCLY9dju8XH64kYrKmay5uH1BXGC20pvKxexhjklF6Dx9nuGSMGJ4
 FwARlUeCSKy98QBNCv4sgO0y7DdKSlC2gA47Uh4ew10bDPOxnr9rwrDD8tbT6t30X
 +RLc+NW95VxDxV7MHWgMdfpFfhgWdJdh/Zphb+KnI8cSf69VZ4r6w+l5H2cltrb0K
 tggKCw+rbf0cm+XB9LBloeRZ1AV4niXT+Tt6MqUFbDln9k1y2Gx9hbP9GgoQS0cAh
 qUKBAW0siZAICVIRdQNDW8OhGypA5lFd+AygZW5kHTA4jE/K4GZ+mxZwqFV7hpAr8
 WvNdg7wvVdyOPg50OQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mbir8-1rWumk3VsM-00dD6O; Fri, 10
 Nov 2023 14:12:48 +0100
Date: Fri, 10 Nov 2023 14:12:47 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: Fix UEFI variable error handling
User-Agent: K-9 Mail for Android
In-Reply-To: <CAC_iWjJHRtuy3M2o61+tkZ+cMPHrizrQQrx9-r_3LCzJgQBjUg@mail.gmail.com>
References: <20231109125541.10845-1-o451686892@gmail.com>
 <4d5b922a-b633-4892-9f36-78935c553bef@gmx.de>
 <CAC_iWjJHRtuy3M2o61+tkZ+cMPHrizrQQrx9-r_3LCzJgQBjUg@mail.gmail.com>
Message-ID: <67A55014-91EE-4C04-A228-52C5790DC910@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/IYWmazVzU4e+Z98E927QAYQx1mslh/j07up92wNzQn07tM+EED
 Olgt6CPl8/of45sYLVZG+44EWQWEZrQtamfS9FiUg2fhpkDyk7WUHMvK77puzzTZFls5r4C
 YuP4vvycfXHi7oS4aSnvihBo6dv6IKOUQVOjuS1x4BpmDhp+aAuCQoHQacyuwNujvZBGvoa
 Zha/lomSdp3sWoc36Ld4w==
UI-OutboundReport: notjunk:1;M01:P0:DpqJEhW4JVY=;Fp4UbtMuqeneCG9kMUCHeZlz8jB
 SmV9WQj7cfb/RG8gIvO86ex3VpzcBH9xkNgCMfj21WGWSIQXwx2RcXxOmofVgzlAQRHqABLHL
 Jfqv/v4EJ7Vl9KGNa9fEqqbcQjbpnrqzzOdzYc+qSuZWuJeCzNAo+bfLra2iONbVVlgTnQkWo
 yfPMnEBpFTVThXjBDNccMkSa6XQxEBdNBDf+sWrUt3KeI25giSLCbZplX8j9bF5ZEg/1kyH6b
 VWzwnpnzbaiRawbsRq8Bi6aD99J/2ZDj9sVOP2lqCKpMLWpeMuvQ4i8wntOvVMylMW8vLR4Tw
 k2M9uCSnlzAz7N7d8929kD+cthEmuqg8uwZKOJiMP7Jwxq6YQyCMQPfxIMkvxVVW6RA3J+j4C
 FSPcZoHbodl3AwVk3lh1+KfkxOxjuP4m7C2onZUuyay9nVRcvGzJ/g7g4nmVipQA48EVa6p7X
 6XD7E8k5YK00fBwbFCXcfYp6prP35EyllSj7JjZfasfArc9Cmf4vWe0l3c7F6iSsVV7kakpD2
 bGiRlQeZ92ujDvQ6dneF0S4GBYbiLDRQLyxVpPbMKW7GMYTsk5avODy8oLMPnOZvzxidAP1MD
 vyGO0ykR2PkN6zV5Itc3/MG0p56YQM0yhAks7okevv79lHT5t29LF1eeaIHe39ueQPAS6CLCI
 cdHMVxaPVmE7Tqy3hRwdJQ3blLWjZlQ1PxaUgzHmj0sKfFcLIZlA0rmFeVLybMbXLwt9JSEP8
 18YjMXNXnLRnQWYyTcTEGB81vmYqMacWbLBX/fWfJZ60521Z/WjIBZ6rk088LBzrOy/UnY6Os
 ld3YlL3LGeynciSv10r48xauum42Ir+Wvo/aj+jf1z7g8Q0r2mKXKpD4OUu3yw2drBM+RTdkx
 4kQv1AX6tioOOUX5fzbgHf9S9CAOAberQVyl+kalyKwGTWyrsHg4fGhKUOiBD6MzQVnL3siKE
 iMgDSCjxldFxYTZAuqSPHDi2qQc=
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



Am 10=2E November 2023 11:04:24 MEZ schrieb Ilias Apalodimas <ilias=2Eapal=
odimas@linaro=2Eorg>:
>Hi Heinrich, Weizhao
>
>On Thu, 9 Nov 2023 at 15:57, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>=
 wrote:
>>
>> On 11/9/23 04:55, Weizhao Ouyang wrote:
>> > Correct some UEFI variable error handing code paths=2E
>> >
>> > Signed-off-by: Weizhao Ouyang <o451686892@gmail=2Ecom>
>> > ---
>> >   lib/efi_loader/efi_var_file=2Ec | 1 +
>> >   lib/efi_loader/efi_variable=2Ec | 8 ++++----
>> >   2 files changed, 5 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/lib/efi_loader/efi_var_file=2Ec b/lib/efi_loader/efi_var=
_file=2Ec
>> > index 62e071bd83=2E=2Edbb9b1f3fc 100644
>> > --- a/lib/efi_loader/efi_var_file=2Ec
>> > +++ b/lib/efi_loader/efi_var_file=2Ec
>> > @@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
>> >               log_err("Invalid EFI variables file\n");
>> >   error:
>> >       free(buf);
>> > +     return ret;
>>
>> Hello Weizhao,
>>
>> thank you for looking into the error handling=2E
>>
>> U-Boot's UEFI variables can either be stored in file ubootefi=2Evar in =
the
>> ESP or in the RPMB (Replay Protected Memory Block) partition of the
>> eMMC=2E The suggested changes are about handling of errors when reading=
 or
>> writing the file ubootefi=2Evar=2E Security relevant variables (PK, KEK=
, db,
>> dbx) are never read from file=2E
>>
>> On first boot a file ubootefi=2Evar will not exist=2E It has to be crea=
ted
>> by U-Boot=2E If efi_var_from_file() would return an error if the file d=
oes
>> not exist or is corrupted, we would never be able to boot such a system=
=2E
>> This is why deliberately we return EFI_SUCCESS here=2E What is missing =
in
>> the code is a comment explaining the design decision=2E
>
>Yes, that's correct=2E The function description tries to explain that
>but is a bit vague=2E
>
>>
>> >   #endif
>> >       return EFI_SUCCESS;
>> >   }
>> > diff --git a/lib/efi_loader/efi_variable=2Ec b/lib/efi_loader/efi_var=
iable=2Ec
>> > index be95ed44e6=2E=2E13966297c6 100644
>> > --- a/lib/efi_loader/efi_variable=2Ec
>> > +++ b/lib/efi_loader/efi_variable=2Ec
>> > @@ -350,17 +350,17 @@ efi_status_t efi_set_variable_int(const u16 *va=
riable_name,
>> >
>> >       if (var_type =3D=3D EFI_AUTH_VAR_PK)
>> >               ret =3D efi_init_secure_state();
>> > -     else
>> > -             ret =3D EFI_SUCCESS;
>>
>> The two lines are unreachable code and should be removed=2E
>>
>> > +     if (ret !=3D EFI_SUCCESS)
>> > +             return ret;
>>
>> These new lines should only be reached if var_type =3D=3D EFI_AUTH_VAR_=
PK=2E
>>
>
>Yea agree here
>
>> I am not sure what Would be the right error handling if
>> efi_init_secure_state() fails:
>>
>> * Do we have to set PK to the old value?
>
>What do you mean by old value?

We are in SetVariable() and set, changed, or deleted PK in memory=2E But t=
his has lead to some inconsistency=2E Should the prior state be restored?

Regards

Heinrich

>
>> * Should we still persist PK to ubootefi=2Evar?
>
>I would argue that we don't really care about what happens in this
>case=2E Writing authenticated variables on a file is only supported if
>preseeding is disabled and it *never* gets restored=2E We basically
>allow that code to test EFI secure boot by writing PK, KEK, DB on the
>fly, but once we reboot those variables are gone=2E
>If preseeding is enabled we don't write that at all=2E We return
>EFI_WRITE_PROTECTED=2E  We could do that regardless=2E  But since we have
>those tests, the memory backend should still be allowed to write
>those=2E
>
>>
>> However we decide we should describe our decisions in a code comment=2E
>
>I think the logic here should be
>1=2E If variables are preseeded and restoring any authenticated
>variables fails, the EFI subsystem should refuse to start (which it
>already does)
>2=2E If preseeding is not configured we can continue as best effort and
>try to recover the board and rewrite variables=2E We don't trust
>variables stored in a file and we should keep it that way
>
>>
>> >
>> >       /*
>> >        * Write non-volatile EFI variables to file
>> >        * TODO: check if a value change has occured to avoid superfluo=
us writes
>> >        */
>> >       if (attributes & EFI_VARIABLE_NON_VOLATILE)
>> > -             efi_var_to_file();
>> > +             ret =3D efi_var_to_file();
>>
>> The discussion here should focus on the treatment of errors in the
>> file-system=2E
>>
>> The following error cases come to my mind:
>>
>> * ESP partition is missing
>> * ESP FAT file system is corrupted
>> * There is no space on the ESP=2E
>> * The medium (e=2Eg=2E SD card) is in write only mode
>>
>> The current code gives priority to enable booting in all adverse
>> situations=2E Do you think this is a bad choice?
>>
>> @Ilias: Please, chime in=2E
>
>I think we should continue doing that *unless* preseeding is enabled=2E
>If we preseed authenticated variables and the restoration of the
>switching of the secure boot mode fails we must stop the EFI
>subsystem=2E
>The first function that gets called is efi_init_variables()=2E
>commit 77bb14758dcb1 explains some of the logic in that file but in short
>- We load variables from a file first, excluding authenticated ones
>- We load preseeded variables=2E That step allows you to load PK, KEK,
>db etc that are stored as part of the u-boot binary=2E  We assume that
>in a sane design a chain of trust *will* authenticate u-boot prior to
>loading, so we 'trust' those variables=2E  If this fails which includes
>setting the secure state we correctly stop the EFI subsystem
>- efi_var_restore() is checking for duplicates=2E So a non-authenticated
>variable set by the file load won't be overwritten by built-in ones=2E
>This allows users to override built-in variables (apart from auth ones
>obviously)
>
>Cheers
>/Ilias
>
>
>
>
>
>
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> > -     return EFI_SUCCESS;
>> > +     return ret;
>> >   }
>> >
>> >   efi_status_t efi_query_variable_info_int(u32 attributes,
>>
