Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9954DC3ABAD
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 09:58:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8CB820E1;
	Sat,  3 May 2025 11:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="iFdtF52z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 327A6820E1; Sat,  3 May 2025 11:58:19 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 907EE81F7B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 11:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746266295; x=1746871095; i=xypron.glpk@gmx.de;
 bh=ugngViblpfRsbK9MZNUgCAe6AI+Zu0DkeZq86yvo/wo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iFdtF52zzoY5cVFsu+t1s+64AFmEKLwxdpEnxr7mwYgCaz8HUcOmdSN8UO6eEB7P
 naoQcaKkK9REhY4bNblZaB0xUnWkFuWhZwmmmnhOAafEa/mo4EevaQiQdoF23HC+H
 bQPgVoudK/MRA2ipC9Z03K1qtsKjdtbMYIDG8w1qY4gd0JOle7ElZIO3IeA0WLviR
 N6aMeQbybc4OHRs4GybcDehmVsyOPSqBte9o4L2pyqCX74l4p8GBdJkUn27j9m/KN
 JjNKZHzuB/gO0zZMisZftSeVgLKtLTEz08+ZNXna1GR6eud7HjSHLzPhuscwmDye3
 zXIl+OFjKNigxva8uQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.64]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv2xO-1v1kDn1sC8-00ttRE; Sat, 03
 May 2025 11:58:15 +0200
Message-ID: <45c4a2fc-28d1-48d6-a04e-88b72d92e0db@gmx.de>
Date: Sat, 3 May 2025 11:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lab failure on JH7110 (StarFive VisionFive 2)
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Minda Chen <minda.chen@starfivetech.com>
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
 <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
 <283D503E-D02E-4D66-8218-6857911B5B78@gmx.de>
 <CAFLszTjG3d2MeW9DiharpGwSTFucFRO56JWJiEcy7dofeG_e4g@mail.gmail.com>
 <fc3663bd-dfee-4928-8ae4-09f0bcc19f86@gmx.de>
Content-Language: en-US
In-Reply-To: <fc3663bd-dfee-4928-8ae4-09f0bcc19f86@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aad2jSZIG+mJqBNsTnRMFVFMX3gcBS6u+ZPFeOC1armn2OelnVD
 5L8LS3CaSlcJckNMs6Yi0PIBLQ7on0PBOkiLmqtJC+26EM0Eir0ia0RDxOTitY47OHdZAsL
 SD7BF6+qCS4Zm/rmv4/dWj7Geo0s+HMjULcnEQK12oTIbcJvSD7lOCZ1DGLCcUTVawsXUwo
 mcVWVoDLiJxxIqRvhEtvA==
UI-OutboundReport: notjunk:1;M01:P0:P3WH73QWQ00=;hjBZ8d7PvY8OvUgMQIQqlAmoaRf
 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
 R328u9pCnOIuk=
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

On 5/3/25 11:19, Heinrich Schuchardt wrote:
> On 5/2/25 16:50, Simon Glass wrote:
>> Hi Heinrich,
>>
>> On Thu, 1 May 2025 at 22:13, Heinrich Schuchardt <xypron.glpk@gmx.de>=
=20
>> wrote:
>>>
>>> Am 2. Mai 2025 03:38:36 MESZ schrieb Simon Glass <sjg@chromium.org>:
>>>> Hi,
>>>>
>>>> On Tue, 14 Jan 2025 at 23:56, Hal Feng <hal.feng@starfivetech.com>=20
>>>> wrote:
>>>>>
>>>>>> On 09.01.25 20:37, Simon Glass wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I am seeing a lab failure on this board with the test_dm_compat=20
>>>>>> test[1]:
>>>>>>
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>> 559________________________________ test_dm_compat
>>>>>> ________________________________
>>>>>> 560test/py/tests/test_dm.py:20: in test_dm_compat
>>>>>> 561 assert not bad_drivers
>>>>>> 562E AssertionError: assert not {'starfive_gpio'}
>>>>>>
>>>>>> Would you have time to take a look, please? A patch to fix a=20
>>>>>> similar problem
>>>>>> on another board is [2].
>>>>>>
>>>>>> Regards,
>>>>>> Simon
>>>>>>
>>>>>> [1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/14394
>>>>>> [2]
>>>>>> https://patchwork.ozlabs.org/project/uboot/=20
>>>>>> patch/20240611200156.224552
>>>>>> 5-19-sjg@chromium.org/
>>>>>
>>>>> I will take a look. Thanks.
>>>>
>>>> I just wanted to check if you sent a patch and if so, if you have a
>>>> link to it please?
>>>>
>>>> Regards,
>>>> SImon
>>>
>>> Hello Simon,
>>>
>>> The error in the log [1] is
>>>
>>> "Writing U-Boot using method riscv
>>> cat: /sys/class/block/sdaa13/size: No such file or directory"
>>>
>>> I would expect a partition on a block device to be called sda13 not=20
>>> sdaa13.
>>>
>>> Could this be a bug in your lab test script?
>>>
>>> (Ubuntu uses partition 13 on the SD-card for U-Boot SPL.)
>>
>> No, that's just something it prints when waiting for the device to
>> appear. Perhaps I should suppress it.
>>
>> The real error is below:
>>
>> ________________________________ test_dm_compat=20
>> ________________________________
>> 560test/py/tests/test_dm.py:20: in test_dm_compat
>> 561 assert not bad_drivers
>> 562E AssertionError: assert not {'starfive_gpio'}
>>
>> It would be *great* if someone could fix it, as it always fails in my
>> lab and I have to manually check it.
>>
>> Regards,
>> Simon
>=20
>=20
> With current upstream U-Boot when executed manually the output of dm=20
> tree is:
>=20
> gpio=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 [ + ]=
=C2=A0=C2=A0 starfive_gpio=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 |=C2=A0=C2=A0 `-- starfive_gpio
>=20
> The output of dm compat is:
>=20
> starfive_gpio
>=20
> According to the test description this should be just fine.
>=20
> Best regards
>=20
> Heinrich

In my lab the test passes on the VF2 board:

Accessing Gembird #1 USB device 002
Switched outlet 3 off
+u-boot-test-flash starfive_visionfive2 na
... /home/zfsdt/workspace/u-boot-build/u-boot-test/u-boot-test-flash ...
Accessing Gembird #1 USB device 002
Switched outlet 3 on
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D test=
 session starts=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
platform linux -- Python 3.12.3, pytest-7.4.4, pluggy-1.4.0
rootdir: /home/zfsdt/workspace/u-boot-build/denx/test/py
configfile: pytest.ini
plugins: cov-4.1.0, xdist-3.4.0
collected 763 items / 762 deselected / 1 selected=20


test/py/tests/test_dm.py .=20
                                    [100%]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 1 passed, 762 deselected in=
=20
12.73s =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+u-boot-test-release starfive_visionfive2 na
... /home/zfsdt/workspace/u-boot-build/u-boot-test/u-boot-test-release ...
Accessing Gembird #1 USB device 002
Switched outlet 3 off

Best regards

Heinrich
