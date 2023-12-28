Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B998C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 17:06:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81FE187B05;
	Thu, 28 Dec 2023 18:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fLFZorwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FDBE87B15; Thu, 28 Dec 2023 18:06:29 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB09E87AE5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 18:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703783185; x=1704387985; i=xypron.glpk@gmx.de;
 bh=2U2LVGmVme+jaP7CxrgyIRCUjdBpu+Dz2bkC/wI+018=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=fLFZorwxIL8pzupMTWXu2my0eCm5/KFrH3cH90UAbeOv/RULbh/iES/DPB0elT7i
 lOilGgN7jvCeD6GBsl7QJV2tygeSRuNHaqKp0CjwUlPJBkEbA2HD68EBxRFUscI25
 CpP4K72st4wC2tr3bm/ioPMKAzR3oys0EtEZwsJ3rAyPbTlxtdqvI5A+uzCAW4uKd
 xjIGOXZVIHcnI7yCHkhDWSDa5J474wo8dIuEDYsuWrTmpidWz5cv1lXmLJBvBbDaA
 SbBRVjn3JqPK1wCjOwgSgXVp0RWEbpi+5JzU8jHnjM9GqTbHAdD9LKqIghmuTUT7K
 pW746Uvzas0197hbBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.217]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GMk-1rEPmT1Cz2-014C50; Thu, 28
 Dec 2023 18:06:25 +0100
Date: Thu, 28 Dec 2023 18:06:23 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/5] test: unit test for smbios command
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTimwDXjbQrER+808pezWD_1UaMk+g56RzNmo9Bwc9Uuew@mail.gmail.com>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
 <20231223004429.247301-6-xypron.glpk@gmx.de>
 <CAFLszThrHODfu-ZhHEzRe5wT-nMpXAp=UCBJC3FipTi9owhajQ@mail.gmail.com>
 <f66c51bb-7dd8-432b-9579-598eb3619c04@gmx.de>
 <CAFLszTimwDXjbQrER+808pezWD_1UaMk+g56RzNmo9Bwc9Uuew@mail.gmail.com>
Message-ID: <15E00D56-2FB7-4905-832E-447090CF9EE3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tKX4H9FlmPFW1k+3ahJqm7n0LWuXGBsH+nV4IhJkD9f5rWOJTDg
 obxMNziA+hIdR8uQi2wDQZqyvhbNodqEBgdRjI3i/cv40pLne+wVM+b/1OzCU9WVvZl4aTi
 flhlCIQWJbnZL09U6llNgnvQButHir+O5pS4g4hiehLbIYjeMLL/j8x/EW6JzSm9UWjYo9+
 fq7egT3ENf2D4vLQqXRoA==
UI-OutboundReport: notjunk:1;M01:P0:PB5ZDXY14aI=;sXrCr3F/RDh8GHFeMZpNubd61r9
 75zCXI6zy/+TPZem+xZQoCWrcyh81z+IP4SOyq3e+Pz+8r1Sbb2o7e6TLJO0XVoZjkNd7+YjA
 1G6K4J11mdjUpYYCE+DVxH/94ZLrOcBIztl1MnrSddZF1G1EBCwxnEVFJSxA9voqHtDmuwrsI
 SeVR5UFeknFHuj5uh0nWZ9h686zR4XTEocCwedr7Hf2g7WN+fy8eL82RUoGQs19y8yJHd7/hk
 3njemag4Xf+FSWKqdSWfS6PNGL6Z26ntAJtyZWNlt9Qeh/roDJbGxXWKKu21eI4WY4BRBBrXR
 6G15nEjm6TXqDgm1pGoWI8sUT5SgBK8qATExRG6ICZqhupfR+bo21NRRysTfeLvagWWozPsq5
 A4eyVEubm74cBz3dyflk8CI2Jf+d8u7oS1u/ErkcMawODAnA3LrhELTFPjhp/LEqqc0nH0NHz
 bQbxvHiKIUrf9pBct5h21LiDTae1QjFMjaHfNOH8MgJED5CaXKwJidsLcdJb5ddLQ/byfbBzx
 4jFpFnIs9clo5P7PjkS4DMqPnt+4f5nxo378Vtdw1qIhOpDowrA/CbSEv555BHnSSlzbpAaBU
 xAWRi2ACWgHdq++0/IRPkk+NqwUDX5gZQIl6xQhvpRYw3HSEyuVt9AdmjelQsFnA2RQYFsnjr
 im51PiH7M8u06dtASLtRlBbojaOU+eozzosOFsvqZD4wHefMsmdQNMecUPnLQ64qF12xE/Aqs
 6Ii8sWeaACxbEUoeLn2NY5+ESafSZV9IOZpPzIzEzhDI369b41KEFgAtA0m40Jhbaps9jgCLN
 7qC4hoh8q+z6oXdVdch066bJXdo1oBUqTuJd8gW6F0mp3o6seuLPHiwxu4UwzEp00H4cpqVH7
 Co9kaSWLofrKBaqR7+bru9hlSFfSAfATMoSzTdhxlJRIxTilg/vpGUjt9LFuMCLix/zQ58bjI
 3g6pDwQ3YIbWhqZaUmfKK50LzmE=
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



Am 27=2E Dezember 2023 08:40:40 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Tue, Dec 26, 2023 at 10:11=E2=80=AFAM Heinrich Schuchardt <xypron=2Egl=
pk@gmx=2Ede> wrote:
>>
>> On 12/26/23 10:47, Simon Glass wrote:
>> > Hi Heinrich,
>> >
>> > On Sat, Dec 23, 2023 at 12:49=E2=80=AFAM Heinrich Schuchardt <xypron=
=2Eglpk@gmx=2Ede> wrote:
>> >>
>> >> Provide a unit test for the smbios command=2E
>> >>
>> >> Provide different test functions for QEMU, sandbox, and other system=
s=2E
>> >>
>> >> Signed-off-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> >> ---
>> >>   test/py/tests/test_smbios=2Epy | 47 ++++++++++++++++++++++++++++++=
++++++
>> >>   1 file changed, 47 insertions(+)
>> >>   create mode 100644 test/py/tests/test_smbios=2Epy
>> >
>> > Can you please write this test in C?
>> >
>> > Regards,
>> > Simon
>>
>> According to our documentation we can use either Python or C tests=2E
>> We generally use Python tests for testing the CLI=2E
>
>Not really=2E=2E=2Ethere are lots of C tests for the CLI=2E It is actuall=
y
>easier to code, in most cases=2E
>
>>
>> I cannot see any benefit in trying to write this in C=2E
>
>I did go to some effort to document this:
>
>https://docs=2Eu-boot=2Eorg/en/latest/develop/tests_writing=2Ehtml#test-t=
ypes

As described in that document C is most adequate for testing on the sandbo=
x=2E I want to run this test on QEMU and real boards with release U-Boot fi=
rmware, i=2Ee=2E without deviating configuration=2E

Best regards

Heinrich

>
>Regards,
>Simon
