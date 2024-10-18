Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACE2D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC7178912A;
	Fri, 18 Oct 2024 05:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LjrAHlCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A8A891FD; Fri, 18 Oct 2024 05:40:36 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC33888BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1729222831; x=1729827631; i=xypron.glpk@gmx.de;
 bh=Gi8wUqkmEW5CH2BQBXciyxwUAhhtHxLQQHnpamojQTQ=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LjrAHlCMpNZRLLRRd9ry9WI3Lo+6ST6TMKPtUanGE+4k8ee5Rpr/c1xmvHtrTjlP
 O7Qu/r44hYiBvIveWYWf9jE/NbEqPleNJQEtamUAFRLcfjnOiNQydN0b1uTwCCM/B
 qDIigL/57+UZfIHV3kPNR9MiMwkIyYJ09Yjp61QNfAxcTtb9QKWAbmtIk3W0a+c4+
 HUi0PTPoQph7Aqq0/bv58LIk45vffr/y1X6myzAKelF2Ebesxm1/gREzc7plj+0sB
 9ypMhO5NdD/GlXMfIYm3DnvpVRj190KKBC7L5a/eFPSv6/kgQaTGrofCURgmud4yq
 fZCTwzNqCSZzBNjNjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt75H-1tu9JO2hXl-00yLIc; Fri, 18
 Oct 2024 05:40:31 +0200
Date: Fri, 18 Oct 2024 05:40:30 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_06/12=5D_efi=3A_Use_the_s?=
 =?US-ASCII?Q?ame_filename_for_all_sandbox_builds?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszThZY6fOOYovYV2KdQHpZ-1q9RK1HyZxrCY8AJ8MYceeXA@mail.gmail.com>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-7-sjg@chromium.org>
 <56ceb77c-efcb-40cb-a497-0952a8457950@gmx.de>
 <CAFLszThLt96h=+28HaD3LmUk-wgj6mnQFav40ndxTxXVZDQw7g@mail.gmail.com>
 <20241018001734.GR4959@bill-the-cat>
 <CAFLszThZY6fOOYovYV2KdQHpZ-1q9RK1HyZxrCY8AJ8MYceeXA@mail.gmail.com>
Message-ID: <F7608772-31A8-4F25-9FAB-3D4E194C0E88@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vSpXGRlTe9Oqqe1oXja4Nen34tKIRFB1cro/MD4r/JwyqlfZq2n
 7jtCM4hxrz8rEj8qCASosbC5lbKSRnw5ZiTXmNY3AdSDvIAvOIw+hpgvdZqERcA5PTtp19N
 G0G4nHujGVt1qL/+TFa2XFKxREqJYItd1+3w4n7rB/zv4fwCv5MxJwBnnqrh/KcU5bxFn9j
 vAw6+H66GWyTsOLTduOCw==
UI-OutboundReport: notjunk:1;M01:P0:EIF3zKyH7mU=;ePTxJmpg8IGLOcP6YJR4KqZEkkD
 h/b1GcamNxc97Yqtn+hh+mx+b/38NjUA9jgD7Uz7Crsnqot9fVXRlZJRUsvTjdaPHN7ZdKZEK
 EDOUa0mVFIzyxTlofxcaCFY/jLQaipH+IDTm5TjY9ar6iXaIGsTpwhD4or/6Er+Mm9pu3DfC7
 K4uX0ShXbh8YnvqrTd9EZH1+IpAihYZWv9TNCC3sFVavOPAGmeKQz+G5dWC6eh9DSalPwWxoM
 vhuP9DqhEXdwooFJU5rQoo8fh7dTnenDS9U8+EtY0bRI4gpeIdk7aDsXHqdA45v+0Wcxg0QCs
 LyoFGU3SHK8ZY2mpTHHTLzOuUrPUUReeT2GsPrT9ZApZHQA459uwl6pWDfdvVtAO4hHyu7XYj
 D5zTNIcY9r/sxyfGn14AKhu3h/Q7Np/fNJGdOBWxWNaYkpCvgKIqybES604MbvvuoQibIW3RW
 cNEGtdxS3SuNjbMU3t0X26S0pg2KSvvE3GLqGiiIt9EOU54Xl7oYuisJtnKVEUG9sk4Iqv2J2
 EguwRn2gcDD8NN1vLu+E3jxvsbo3rqPVSL/R/i4gNe4jAsqHtmq6O+10paZzQoeJQVTpQVnTj
 CmBO20ofD/uqw8QiKeF1RlUcz9lGjUFzcAF6pfQTnYPubzWpbqkQtoRjgZGJQ/xY9YAD36DXS
 3wC2UlGISqtuaXiYkOaqTGymscNDDyywrLb3/CNCbyybl1UEFdVP70EoiZ9HQKxXsmHKfRWmM
 GquINrZ7lb6plNl1W5xVr84SLEsIw+KOENE2iUyJJNCG0BeK3VQY8BVM8Z5Sn1vAi9Sh2Uy/4
 pFN37QmGPTnXnLPw+EjDLpjQ==
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



Am 18=2E Oktober 2024 05:05:08 MESZ schrieb Simon Glass <sjg@chromium=2Eor=
g>:
>Hi Tom,
>
>On Thu, 17 Oct 2024 at 18:17, Tom Rini <trini@konsulko=2Ecom> wrote:
>>
>> On Thu, Oct 17, 2024 at 05:23:19PM -0600, Simon Glass wrote:
>> > Hi Heinrich,
>> >
>> > On Mon, 30 Sept 2024 at 17:23, Heinrich Schuchardt <xypron=2Eglpk@gmx=
=2Ede> wrote:
>> > >
>> > > On 26=2E09=2E24 23:59, Simon Glass wrote:
>> > > > Sandbox is not a real architecture, but within U-Boot it is real =
enough=2E
>> > > > We should not need to pretend it is x86 or ARM anywhere in the co=
de=2E
>> > > >
>> > > > Also we want to be able to locate the sandbox app using a single
>> > > > filename, 'bootsbox=2Eefi', to avoid needing tests to produce dif=
ferent
>> > > > files on each host architecture=2E
>> > > >
>> > > > Drop the confusing use of host architecture and just let sandbox =
be
>> > > > sandbox=2E
>> > >
>> > > As I already wrote in
>> > > https://lore=2Ekernel=2Eorg/u-boot/ae1cf1fa-766e-46a0-8ef9-2c2c7af7=
3d9e@gmx=2Ede/
>> > > this patch should not be merged=2E
>> > >
>> > > bootsbx=2Eefi does not exist in the UEFI specification=2E
>> >
>> > If that is of concern I can get it added=2E Let me know=2E
>> >
>> > >
>> > > Without this patch I can test that shim work and grub are correctly
>> > > loaded from a distro image=2E This patch makes the sandbox misbehav=
e=2E
>> >
>> > Why don't you do that with QEMU?
>> >
>> > If we want sandbox to do this, I could add a way for sandbox to selec=
t
>> > its architecture=2E But this patch is correct, sorry=2E It is basical=
ly a
>> > revert of your patch:
>> >
>> > 3a0654ecd0d efi_loader: correctly identify binary name
>> >
>> > Let me know if you would like a selection mechanism and I'll see what=
 I can do=2E
>>
>> I'm confused=2E It sounds like Heinrich is using sandbox to test on
>> various hosts, how U-Boot behaves, without relying on "just test in
>> QEMU"=2E I don't see how this disconnects from your usual request on ho=
w
>> to use sandbox for further testing=2E What is breaking for you, Simon, =
by
>> us saying that the host instruction set determines what we load and run
>> (and so, is portable whereas saying "sandbox" is not, between x86 hosts=
,
>> arm64 hosts and riscv64 hosts)=2E
>
>This:
>
>Also we want to be able to locate the sandbox app using a single
>filename, 'bootsbox=2Eefi', to avoid needing tests to produce different
>files on each host architecture=2E

As I wrote before:=20

The UEFI specification prescribes the naming of the default boot binary=2E=
 Deviating from the specification should be avoided=2E

Anyway you need different images per host architecture=2E Writing a single=
 switch statement to derive the default EFI binary name from the OS archite=
cture does not look like an undue burden=2E

The sandbox should remain able to start GRUB from a distro image for the h=
ost architecture=2E

The sandbox is not a fake architecture but can be considered a valid testb=
ed for host native EFI binaries including GRUB, the kernel stub, the stubs =
of UKI images, and the EFI SCT=2E

Best regards

Heinrich


>
>The idea of using sandbox to run native EFI apps is new to me, but it
>sounds great, if it will get us more tests in this area=2E
>
>But sandbox is sandbox=2E It is not (x86, arm, riscv)=2E It is a fake
>architecture that we use in U-Boot=2E I've offered to create a way to
>get the behaviour that Heinrich wants, so let's see what he says=2E
>
>Regards,
>Simon
