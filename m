Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABD5C3ABA3
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 04:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F7E68059D;
	Fri,  2 May 2025 06:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LMhwP4Hk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F118070C; Fri,  2 May 2025 06:13:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1651803CC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 06:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1746159218; x=1746764018; i=xypron.glpk@gmx.de;
 bh=G0LPoZleHOO0MHMVhkG/MUI4CNAbPWjyo1UitKl/CIE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LMhwP4HkX/gyuzYFzCQl5Li9G5AqwMRrUls9WpQV1TIswWmABhZbFy25hxZWeqNs
 4pe75840wrs00G9Wu/q0ZH9GM3wzJvUjsh9eRlR1Xfn6jeKBRC2P818vDjFJFTnxd
 XsXjbVcWmfiwIo0M3VV8KMooGIB97qGMJx79VDXTMZV0LSVeFT0vUjWQZZgCHIn/W
 prR6HNmMVMaz5rG6WVBKV7ZxTE8dA5P49fGFKJT8s5tTp+olSUFvEo7cFDPGvqb0X
 pa7OVjXVadQSBUAusfz78q6GAwWC/RuuoPg5Papz0XEzW6cFcwra16iocmtGilH+E
 HxO5AAEObqHDbgqU/g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.105.83]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8XPn-1v6IWu3o13-016ryX; Fri, 02
 May 2025 06:13:38 +0200
Date: Fri, 02 May 2025 06:13:35 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Hal Feng <hal.feng@starfivetech.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: Re: Lab failure on JH7110 (StarFive VisionFive 2)
User-Agent: Thunderbird for Android
In-Reply-To: <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
References: <CAFLszTgi8FxpM=uCe5vZ4rWR81W9fnc77KxjrQ4-+yijXb5a=w@mail.gmail.com>
 <ZQ2PR01MB13077BEB7F27422FA9AF07A6E619A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CAFLszTg6sdcvB-qfbBJ23JORsxvjTgL9ozvcu_oKFkJrfL=9hQ@mail.gmail.com>
Message-ID: <283D503E-D02E-4D66-8218-6857911B5B78@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NeqOmBxfsOPj/gh5OBynMHjhYGNseKoQgulKtFbyFCzLhs5jslc
 c1pjhaeAtCDhdz7DAtIlivkyBv/t22OQrxqcPjiGIdG5IPxME8eChDg662Y7jcP0DVfbey1
 JBUgnSC9p9wivW53EFEWs/t4F2Vc4/O8X6APDclSlyjGFrbLPxvNtUPxJfwuZAMDVzNcOTI
 Qn6krGk1RHAg0apJvk7PA==
UI-OutboundReport: notjunk:1;M01:P0:I6mHy2iRRZY=;u1uW1JC6rjcPDQL8F2YtC77cf4A
 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
 96xwDw+tEOl80EbWf3pOGA=
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

Am 2=2E Mai 2025 03:38:36 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi,
>
>On Tue, 14 Jan 2025 at 23:56, Hal Feng <hal=2Efeng@starfivetech=2Ecom> wr=
ote:
>>
>> > On 09=2E01=2E25 20:37, Simon Glass wrote:
>> > Hi,
>> >
>> > I am seeing a lab failure on this board with the test_dm_compat test[=
1]:
>> >
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > 559________________________________ test_dm_compat
>> > ________________________________
>> > 560test/py/tests/test_dm=2Epy:20: in test_dm_compat
>> > 561 assert not bad_drivers
>> > 562E AssertionError: assert not {'starfive_gpio'}
>> >
>> > Would you have time to take a look, please? A patch to fix a similar =
problem
>> > on another board is [2]=2E
>> >
>> > Regards,
>> > Simon
>> >
>> > [1] https://ci=2Eu-boot=2Eorg/u-boot/u-boot/-/jobs/14394
>> > [2]
>> > https://patchwork=2Eozlabs=2Eorg/project/uboot/patch/20240611200156=
=2E224552
>> > 5-19-sjg@chromium=2Eorg/
>>
>> I will take a look=2E Thanks=2E
>
>I just wanted to check if you sent a patch and if so, if you have a
>link to it please?
>
>Regards,
>SImon

Hello Simon,

The error in the log [1] is

"Writing U-Boot using method riscv
cat: /sys/class/block/sdaa13/size: No such file or directory"

I would expect a partition on a block device to be called sda13 not sdaa13=
=2E

Could this be a bug in your lab test script?

(Ubuntu uses partition 13 on the SD-card for U-Boot SPL=2E)

Best regards

Heinrich=20



