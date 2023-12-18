Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2519C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 16:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB284871CE;
	Mon, 18 Dec 2023 17:19:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XS8dRO06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B4BD8718A; Mon, 18 Dec 2023 17:19:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F46D86F1E
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 17:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702916363; x=1703521163; i=xypron.glpk@gmx.de;
 bh=Zrt1niySZQqQlT4+1FWYJyzs/nU8h1/DqI+/ORzGKlg=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:
 References;
 b=XS8dRO06oub9cUVKsU95ZbhCZYTH7uzXWWR09wEShDa0BFyDuPfny1NTfXh1B0wf
 hn1Tiupgwqg+38yPrTmx1pAEKFsfUR18KEtlDBZ4pjnpeBoqoUxT0Znke4KwVo8fK
 r0E/uCFYKOE9Dt11Q0H4+qa0YBsmNH+Yc/chb9LT9RtYvAfSYat6oBjhmJIMjkj1r
 lu5qWXY0L0tHsJIhN4+2j2rEamDLunvNL9HiurdsKqcfUcnYPSO3Mv43ThcT7PVe3
 H4VGxE+JoYl7ojxTc262R0EnfSuJsB/FOkZAoCD7PMjKdiZsdV5pTUipKqctEyPnV
 FOHpX0s4iD4Au+kK0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1qmF370nBe-00fVTm; Mon, 18
 Dec 2023 17:19:23 +0100
Date: Mon, 18 Dec 2023 17:19:22 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Booting fails on the sandbox
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1X50hb63FdSWJVnN1-2OOao38C0qtWVTr5HfmmWF8Smw@mail.gmail.com>
References: <acfe7ea1-a25a-4293-9e05-bfe4ed7c2a05@gmx.de>
 <CAPnjgZ1CmmEHxOKPRVbo1zjQ8FDQ1HxdU9ww6c5fJBFc7+Dtjw@mail.gmail.com>
 <6d926cc2-6100-4b1a-8ee1-11a19ac36f35@gmx.de>
 <CAPnjgZ1X50hb63FdSWJVnN1-2OOao38C0qtWVTr5HfmmWF8Smw@mail.gmail.com>
Message-ID: <C5A1BDC3-5A7A-4815-9CFF-BEEA35AFB29C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6cKGiEltbmrQ0MnPGam1c6LCGXJHnMgpLmm1NrAuJjlYmtG0Guw
 yECNPQ7g4Q80cNRN64JQGi05iVFJoYbb6l7Cgofjn5KsNOWafoxpkKrrTA5ToYzspAhgsJJ
 BpDkO1uC7uzNbaleVtgK/ZIMn3UCVZ68LlHNsZyP/ggaaq/cXWnrEO3X6sw/GwGFN7MXdAm
 hLUsB1V11Z1/UV/Pp/QCA==
UI-OutboundReport: notjunk:1;M01:P0:7jiE2SfduxU=;8bYXdNU6sn3E7RG2b/NERc/W2vP
 IgkNfGtlvm6G4xn4JB9z0QFYLbu+WRvfhVInaqpjfHuEoYMCNxG2m2GmEkLGdHis7TFDMdC8D
 g6YtfwOP2x9ZATn1Tk35RUN8hmdEZwXyQfrZFI6ijAK8W2w0mJyVfdmZr0kV/+A0Vg1hcCqIS
 VDIs0vJv7ghp1Z+sDL6mJGa4kjYXiiDw6jichEEU2b8cTA9Zy6LQ7jvSyyT9In91iFPOQ3X18
 EfLUqjbsvdwKSAIlMoGbf08th58kbXBdi7MVuv6145D6hIUntw2HRv+egHnpsbK7zVjS+se/K
 J/SacSAtkQwKvz7WHIOr7iS30tTIGgd//b0IuBMlUet0F7sxNoJOVo1cmotiwGMF7b6lUrOwg
 tB579++qiC99gjghpTUKwFwT/Q7lD0m0dLPKbsv36tczMHb6I7L1jJDUOGbZg+j/+7lpKiD4G
 3PNBHyibW8DDGeR5RaT97JKkmAHHLcfgj9eFo2fGjKRj7FSgJBqGhaMUoh4wibv/0JZOs9m0z
 TZhD8y6mWwDIzROuO39dEStQWm68K/CjwoCz493V7BKaB+gFjEROWnXHu6gaoaMEiLQSZmFiu
 UCFINdm53KGJf7Xz8HDUMz7xMh/sSW6y94gw4S7AdVw6ds4Y1g7NlGpefoVVITTx/UGpoEtv5
 8Kbv9bHaqVapmUQIY6TSRjWer2DHpVto+opaiQEcnu2RtQ1zax/QmVWnGPUtU4sqIR8E0jN66
 /ALnP0JI7rIi19F88pTSPOD+VL8xUyeQz3lt5SMHXle7g7+l/gms+3PoQQHVwngr9l+63ufqD
 OLpsPY7OgpVvDq7lBkV09Y1+9LgBNsVnJovnTj2SMgdWE//vYUrXdnntBfpcp8f3ZxyNjYOdO
 +SydkDQQIvcGREFVK8CUqYNJfqM39WWjv2SPlYkt2NXEp3Mt6K5lIDZetAc3KXOsTx8UhFnOq
 /V5jiGR/plfmcXQfWsugEHHqUx4=
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



Am 18=2E Dezember 2023 16:01:36 MEZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Heinrich,
>
>On Sat, 16 Dec 2023 at 14:08, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 12/16/23 19:45, Simon Glass wrote:
>> > Hi Heinrich,
>> >
>> > On Sat, 16 Dec 2023 at 07:50, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede> wrote:
>> >>
>> >> Hello Simon,
>> >>
>> >> I have built sandbox_defconfig with PREBOOT=3D'host bind 0 =2E=2E/sc=
t=2Eimg'
>> >>
>> >> On the image I have an ESP with file EFI/BOOT/BOOTX64=2EEFI=2E
>> >>
>> >> I would expect the sandbox to boot from the ESP=2E
>> >>
>> >> But when starting the sandbox is does not boot=2E Instead it shows a=
 menu
>> >> with some Fedora related entry:
>> >>
>> >> Fedora-Workstation-armhfp-31-1=2E9 Boot Options=2E
>> >> 1:      Fedora-Workstation-armhfp-31-1=2E9 (5=2E3=2E7-301=2Efc31=2Ea=
rmv7hl)
>> >>
>> >> This makes absolutely no sense on an x86_64 system=2E Could you, ple=
ase,
>> >> fix sandbox_defconfig to boot according to distroboot=2E
>> >
>> > What sort of 'fix' are you thinking of? You should be able to discove=
r
>> > all the options with 'bootflow scan' and then use 'bootflow select' o=
r
>> > 'bootflow menu' to choose which one you want=2E
>> >
>> > The Fedora thing is used for testing and development=2E
>>
>> I want to autoboot the sandbox without manual intervention=2E This
>> requires a sane state=2E
>
>Well, stop doing that :-)
>
>Really, sandbox is for development and CI testing=2E It is not designed
>to boot anything automatically=2E

It is the fastest way to run the UEFI SCT=2E But that requires an EFI comp=
liant dandbox=2E

How do you want to test the EFI bootflow on the sandbox  when wrecking it?

>
>>
>> If that Fedora thingy is only needed in CI, can't we put it into a
>> config segment that only used by the CI scripts and have the sandbox in
>> a generally usable state? Or can we let the Python tests add the
>> otherwise not needed bootflow?
>
>Yes, we could=2E We have some extra mmc devices which are manually
>enabled in tests=2E
>
>But it is handy to be able to try out a distro without doing anything
>special=2E I suppose we could add a sandbox command to enable an mmc
>device in test=2Edts
>
>If you have ideas / patches that is fine=2E=2E=2Eit's just that I do want=
 to
>be able to use sandbox for basic development and trying things out=2E
>
>Regards,
>Simon
