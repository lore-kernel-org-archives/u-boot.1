Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790B5CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65AC86996;
	Sat, 23 Sep 2023 20:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Qlp6L5gA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB83486A0A; Sat, 23 Sep 2023 20:41:49 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 030408641B
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695494506; x=1696099306; i=xypron.glpk@gmx.de;
 bh=xh9E9q1DYn+pSxsBfm4mnSoYVrdCY8U59PzXIjHuO14=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=Qlp6L5gAMmYp0p0hcPFwDekWGYy1p3Nxcy6t5yHYjaTXZXtu/F9kwnKttLW6Z03XrSdco663N6H
 uuchG7Vk9FtmKrHI/0DsH1STeq2i82EGmt6HbDykBi5fbcVZv/6ujaZgqXMzYhhCHKfhz5S6UtAMc
 ES4nopkmIEKR181+abJT/WqhAyIfhiw+qxg3Pd2UX8AGUm9iMjMXnt7JHNEtwHbEzNZLunziXirMT
 I4yCl9bYnxUhnIj8k5ucg2Ep8hxWfNvzwJnK0rufqxnPwbM+thTJc+IGZqp6SUc2euvvLK0X28LRx
 XlKDE0WVS40BvuWVkK3P/5M0syoxi758SCDw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1rE70z1PTH-00VeGB; Sat, 23
 Sep 2023 20:41:46 +0200
Date: Sat, 23 Sep 2023 20:41:45 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: Reading from ISO9660 in U-Boot
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ1CEBbeQzKNJBYtQx=rVZayJyZVwo1CPW-ZgFiKNbT6hQ@mail.gmail.com>
References: <CAPnjgZ2mhRhOWoObKbw0R+8jmFT0QY4THpXR=f2s1svi6cwEvQ@mail.gmail.com>
 <e43c5b16-e626-4c7a-9bef-44f192d2a703@gmx.de>
 <CAPnjgZ1CEBbeQzKNJBYtQx=rVZayJyZVwo1CPW-ZgFiKNbT6hQ@mail.gmail.com>
Message-ID: <D5CA48E9-78C1-4E92-979A-E9C346A42AAE@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vlnPhpDbX9pasukG8O8oAKyat8A266vyHbGWQOX/BUTV5Drsvlk
 eUHKe7w3BJAHCa5cxECyMjUBXR3wuLH5VgkBJ+okGKsJrAe08VshHYtSiZEQGpXrNIDSD0Z
 rnqy4/dcvWFdmiRtNMM6I4difDFiP0u8UIBKe3bPDucTQgDSiZuv2jcRm/8/xUhW5E8Xd9A
 eFNhRGCL7P7yuypG3ycEg==
UI-OutboundReport: notjunk:1;M01:P0:FJ0qTvGYjaE=;PJp7PM7/zh9h6D+vq7NfR3cKNAG
 uCUcxqv0jyKzitRsdpB8k4w+kciveAhZzVroGYFwCpWYVIqhqgt7VEa2+imR+lHYNUqlNcEc1
 sCEXxMIWhLdznS3wNrt8g1NuKNMaVzhboF10wzXfkAXpqJm5vbcuZhPygGN6Gp2IcdwgyO+jg
 gipa9iruVyu+0s94//Knp4iZg0Z70p2Py6fNb7oNvGq6vJR6777kzkhGGpiZjnPf9FscRjLzf
 EmufGwEbi726/il1t74aMi12hwp9JQv52hBOegzsigMvWx9XVPuv2ADHVat9YvYeTAunEXcsd
 scYB39M9mIpbCIt3Jz6VPRZ2BiRt6To6iMrDmyFrb10DP1+yGJoif3XIF1inBgnZaOZW3gaQk
 A1K4F8YquV+cef/fE/OqTr1nx5DP1NHv/3D7drXl/BJWkXhqV3Hal3c3sVjomnnL0lTuwD8cm
 gowO9WsXScPy9bQJR/fLdX4PzMgXN8ai3EHTfuwH5OFymDhBpmG/Csk8H/INvvda6nM0OPeqs
 Jhq9A10ckCKOo7vC47TVlTxWDZOIR+9Nunf+dXt1QPBRSkvYl5geQpJICG5pzM300erYoMCxo
 UK6chqJNEJel3h3AfXXtcLAUTdaBXF1+FHStdU3vJClV+/qX5yMUHa4gGSPqwzWWzdOEob+hw
 TzwmxOliSQZbQYPNsxO5Rto87LKjzru0pejhg8SVt5QPneDPdVkuL/U/jbcs0kY26fPayOrLN
 1/6Pi/ZAtidKMxgCLkZoJIbyYZKa5VN8kzXrWKj27/dC/+GxCXVS0NZ7+1/wBFUVGj9dyZc3A
 44YWkPt6AzYXVZRUAD/DD8C+vfWrnQv7uRBnYUOLekflsCRJKVKEmh7TNG93RoVKktrMWQO1L
 OVmv+vrKME3X3a304Kq+hfBzHtdp+I4g1yzHIX8qdR6P8iQmu2Zou/rh8gXnj8tmf/vEFQcvQ
 pbiazA==
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



Am 23=2E September 2023 16:36:32 MESZ schrieb Simon Glass <sjg@chromium=2E=
org>:
>Hi Heinrich,
>
>On Fri, 22 Sept 2023 at 19:38, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ed=
e> wrote:
>>
>> On 9/23/23 00:13, Simon Glass wrote:
>> > Hi Heinrich & Bin,
>> >
>> > I'd like to be able to figure out in U-Boot what OS is on a USB stick=
=2E
>> > For example, with the Ubuntu installer, I can boot it (through grub),
>> > but I cannot see how to read anything useful from the USB stick that
>> > would indicate that it is Ubuntu, what version it is, etc=2E
>> >
>> > Does U-Boot need an ISO9660-filesystem driver for that? Is there any =
other way?
>> >
>> > With Debian I can see the actual files (linux and initrd) , so it is =
a
>> > bit easier=2E
>> >
>> > Regards,
>> > SImon
>>
>> U-Boot only needs to support reading the ESP to boot=2E GRUB comes with=
 a
>> 9660 driver=2E
>
>Yes, but this is not about booting, it is about visibility into what
>is being booted=2E Perhaps Ubuntu could put some information in
>partition 2?
>
>>
>> On Ubuntu server installer images linux and initrd are in directory
>> casper/ in the ISO9660 file-system=2E
>>
>> There is also a file dists/mantic/Release
>>
>> $ cat dists/mantic/Release
>> Origin: Ubuntu
>> Label: Ubuntu
>> Suite: mantic
>> Version: 23=2E10
>> Codename: mantic
>> Date: Tue, 19 Sep 2023 23:07:01 UTC
>> Architectures: amd64 i386
>> Components: main restricted
>> Description: Ubuntu Mantic 23=2E10
>> Acquire-By-Hash: yes
>>
>
>That would be useful info=2E Ideally we would have a standard format for
>this file across all distros, perhaps something that VBE can help
>with=2E

What problem do you want to solve? During installation you should know wha=
t you have downloaded=2E

Afterwards UEFI boot options should receive reasonable labels=2E

Best regards

Heinrich


>
>Regards,
>Simon
