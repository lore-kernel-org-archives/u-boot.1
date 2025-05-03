Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ECAC369D9
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 09:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 177B281F7E;
	Sat,  3 May 2025 11:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qnD5JNVZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70193820E1; Sat,  3 May 2025 11:20:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB4E81F7B
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 11:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746263992; x=1746868792; i=xypron.glpk@gmx.de;
 bh=tHTMZfdmaaqFS3UMsTueh57DcRwk06jOyceUGVm0nJw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qnD5JNVZwPvzz8jSq+o4MgkXy6bpDD7y1TjRzxYEr8CR7KLCdMy42WdkjOOi58xm
 xYDoliWuWwx2vXuyvL7chzYti6ixRVCNHT2UkTrnd7UyEt48vBupfBobMK/GdPDOH
 SbWKFGKnbpoaXRV5hSrzyZ5Kgj726CJcz/xB2PNDdN2lxReFa2OUIz+aQiLimfPEd
 6vaYqVyS9hJJigpiOKGqPYEvft/ibaYvCd4iltqFpHgsLB0+MmaFxfmWJWyT9+56o
 71PfA8crC4VTHT/F5r34W6bMrsVBiKEalGs3XDCdnzbqK1XyGwvu9Nhok1iSBAJpc
 /Gd5fQXa+Ry2a2sdVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.143.105] ([46.114.111.64]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1v3vTk2Vku-00rhfX; Sat, 03
 May 2025 11:19:52 +0200
Message-ID: <fc3663bd-dfee-4928-8ae4-09f0bcc19f86@gmx.de>
Date: Sat, 3 May 2025 11:19:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Lab failure on JH7110 (StarFive VisionFive 2)
To: Simon Glass <sjg@chromium.org>
Cc: Hal Feng <hal.feng@starfivetech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Minda Chen <minda.chen@starfivetech.com>
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
 <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
 <283D503E-D02E-4D66-8218-6857911B5B78@gmx.de>
 <CAFLszTjG3d2MeW9DiharpGwSTFucFRO56JWJiEcy7dofeG_e4g@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTjG3d2MeW9DiharpGwSTFucFRO56JWJiEcy7dofeG_e4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MX2Q8Ft3TahXHYieORLf9PfReFXzoCJcls2Hmfxx/ins9GA2Xb4
 wfzMKdNTjPHCdhY4RPj5NsgugZNm0IY10RQq7jMJGoVwqumCVsZcD0Dzps9gfbSQIt0IrxO
 0DI2v3vUcunfr2AjC//ukZqqqYhc6A6yPT+4ah70bklImmzBbFjMzkg9iX6aR3WuXrmHa/l
 5fY30xKaHBdIgG2NGioMQ==
UI-OutboundReport: notjunk:1;M01:P0:9pjVLvUHIcE=;ZJ8MjUPG2TFWvxqCkriWrWmBNA3
 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
 WGUjpJHpuoOus48dxdvdkE=
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

On 5/2/25 16:50, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Thu, 1 May 2025 at 22:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
>>
>> Am 2. Mai 2025 03:38:36 MESZ schrieb Simon Glass <sjg@chromium.org>:
>>> Hi,
>>>
>>> On Tue, 14 Jan 2025 at 23:56, Hal Feng <hal.feng@starfivetech.com> wro=
te:
>>>>
>>>>> On 09.01.25 20:37, Simon Glass wrote:
>>>>> Hi,
>>>>>
>>>>> I am seeing a lab failure on this board with the test_dm_compat test=
[1]:
>>>>>
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> 559________________________________ test_dm_compat
>>>>> ________________________________
>>>>> 560test/py/tests/test_dm.py:20: in test_dm_compat
>>>>> 561 assert not bad_drivers
>>>>> 562E AssertionError: assert not {'starfive_gpio'}
>>>>>
>>>>> Would you have time to take a look, please? A patch to fix a similar=
 problem
>>>>> on another board is [2].
>>>>>
>>>>> Regards,
>>>>> Simon
>>>>>
>>>>> [1] https://ci.u-boot.org/u-boot/u-boot/-/jobs/14394
>>>>> [2]
>>>>> https://patchwork.ozlabs.org/project/uboot/patch/20240611200156.2245=
52
>>>>> 5-19-sjg@chromium.org/
>>>>
>>>> I will take a look. Thanks.
>>>
>>> I just wanted to check if you sent a patch and if so, if you have a
>>> link to it please?
>>>
>>> Regards,
>>> SImon
>>
>> Hello Simon,
>>
>> The error in the log [1] is
>>
>> "Writing U-Boot using method riscv
>> cat: /sys/class/block/sdaa13/size: No such file or directory"
>>
>> I would expect a partition on a block device to be called sda13 not sda=
a13.
>>
>> Could this be a bug in your lab test script?
>>
>> (Ubuntu uses partition 13 on the SD-card for U-Boot SPL.)
>=20
> No, that's just something it prints when waiting for the device to
> appear. Perhaps I should suppress it.
>=20
> The real error is below:
>=20
> ________________________________ test_dm_compat ________________________=
________
> 560test/py/tests/test_dm.py:20: in test_dm_compat
> 561 assert not bad_drivers
> 562E AssertionError: assert not {'starfive_gpio'}
>=20
> It would be *great* if someone could fix it, as it always fails in my
> lab and I have to manually check it.
>=20
> Regards,
> Simon


With current upstream U-Boot when executed manually the output of dm=20
tree is:

gpio          0  [ + ]   starfive_gpio         |   |   `-- starfive_gpio

The output of dm compat is:

starfive_gpio

According to the test description this should be just fine.

Best regards

Heinrich
