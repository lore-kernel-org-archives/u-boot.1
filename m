Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F38C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 18:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E7F829B2;
	Tue,  3 Jun 2025 20:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="efhNtplJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C688C82AF6; Tue,  3 Jun 2025 20:22:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777D6828BC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 20:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1748974951; x=1749579751; i=xypron.glpk@gmx.de;
 bh=AyfzTw71oI3y9zDLU4AIqdj2yEoNW31ZmasddNM9pBI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=efhNtplJrt79QjKqhI5AhlKe6s2KNFTGfqiE66XyYHQCuqPMG/RX+HIGqtt/Ms4Q
 1Xq1q8sSMxMzMIzJIkopFKJsRZOT1QtvKDzqpkwxtFgUU/7Us2z5lpI41OSfXpA0M
 KUvrliCDUg50X2Q/bjvakcUmjCMtRi87LnjP4u9uYgN7BkpONe5+ikZ//dUQEuW9h
 0lD0wdzGWIrb3JvNirNIiBMQ5/Zd/znFgT4KNoAj+Q06TivPCKKks30EjD/dDHGv2
 Z0Tud4hy7K9guQcW8Ihe9fZwBha5zsVawE84KMr7gDXbLrAMGkEsAMqTL2S1lz61u
 BJB5cCCS8Bv5QsH/Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.169.206]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1uX0vM3g3G-00OIhn; Tue, 03
 Jun 2025 20:22:31 +0200
Date: Tue, 03 Jun 2025 20:22:27 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Simon Glass <sjg@chromium.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/6=5D_lmb=3A_replace_the_l?=
 =?US-ASCII?Q?mb=5Falloc=28=29_and_lmb=5Falloc=5Fbase=28=29_API=27s?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250603162246.GJ1382132@bill-the-cat>
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-3-sughosh.ganu@linaro.org>
 <CAC_iWjL+0bwPS9eXfvnFjN8UcAta+zgHz8vfDWz5YvVwoE9tsA@mail.gmail.com>
 <CADg8p96yFhzabfzZEhNzWX+kEwBuOsih0kVL+0d=ZLt=F2JNDQ@mail.gmail.com>
 <CADg8p977sXJRS1CM6Lnmep0_gc3jc9b3yFg1A-qkVn5Gswr_=Q@mail.gmail.com>
 <20250603162246.GJ1382132@bill-the-cat>
Message-ID: <9E314CBB-F00A-4331-B49F-5ECE6B74CF69@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nxXvoXDUy+v7ZVxlMNMTTDJ8ZiYVlRPr9Z0aYxMLGDEmlQFELvN
 W+KXHGYQuVWrieOLnsbzYtFNLKd3pu9thYfABpoH+Ye57D6WM8ILySG/Qokhst+F3R5ykiM
 xnUXYW6Wg0aMXArCdMcya/4Pcwc6il3dbnIMnaNSa3cH7iJsDxpwcrb5EqGupYQ+0t3Jm6K
 bzfpEfzy7RR8pkCOSONrA==
UI-OutboundReport: notjunk:1;M01:P0:AiPVRKSGYs8=;4Xp/zp6G3Sy8nF1356KyNmzjIs/
 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
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

Am 3=2E Juni 2025 18:22:46 MESZ schrieb Tom Rini <trini@konsulko=2Ecom>:
>On Tue, Jun 03, 2025 at 12:14:44PM +0530, Sughosh Ganu wrote:
>> On Fri, 30 May 2025 at 15:41, Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg=
> wrote:
>> >
>> > On Fri, 30 May 2025 at 13:17, Ilias Apalodimas
>> > <ilias=2Eapalodimas@linaro=2Eorg> wrote:
>> > >
>> > > > +static phys_addr_t lmb_alloc(phys_size_t size)
>> > > > +{
>> > > > +       int ret;
>> > > > +       phys_addr_t addr;
>> > > > +
>> > > > +       /* All memory regions allocated with a 2MiB alignment */
>> > > > +       ret =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr, si=
ze, LMB_NONE);
>> > > > +       if (ret)
>> > > > +               return 0;
>> > > > +
>> > > > +       return addr;
>> > > > +}
>> > > > +
>> > >
>> > > I think we  need a better naming for these=2E Right now we have
>> > > lmb_alloc() here and in tests, addr_alloc() in snapdragon code=2E
>> > > I'd say either export them as API if you think they would be useful=
,
>> > > or get rid of the wrappers=2E
>> >
>> > I kept these functions as is to reduce the amount of change resulting
>> > from introducing the API=2E Also, the newly introduced API has
>> > parameters which are common across all the callers, which also was wh=
y
>> > I kept a wrapper=2E This is especially true in the tests, where it wo=
uld
>> > be required to change the function names in a bunch of places without
>> > much benefit=2E
>> >
>> > >
>> > > [=2E=2E=2E]
>> > >
>> > > > +static phys_addr_t lmb_alloc(phys_size_t size, ulong align)
>> > > > +{
>> > > > +       int err;
>> > > > +       phys_addr_t addr;
>> > > > +
>> > > > +       err =3D lmb_alloc_mem(LMB_MEM_ALLOC_ANY, align, &addr, si=
ze, LMB_NONE);
>> > > > +       if (err)
>> > > > +               return 0;

Would lmb ever allocate at (phys_addr_t)-1 ?

I guess this should work for all systems as error indicator=2E

Best regards

Heinrich=20

>> > >
>> > >
>> > > This tends to blow up in random ways=2E See
>> > > commit 67be24906fe=2E TL;DR 0 is a valid address in some systems=2E
>> >
>> > Yes, I see your point=2E I think the calling function will have to be
>> > re-written such that the env variables get stored only when the API
>> > returns successfully=2E Then at least the platform will not have an e=
nv
>> > variable with some junk value=2E
>>=20
>> Thinking about this a bit, I think in these two instances, returning a
>> value of 0 might not be an issue if the DRAM memory does not start at
>> 0x0=2E Don't get me wrong, what you are suggesting is definitely
>> correct=2E I am only thinking about increasing code size on these
>> platforms if 0x0 is not a valid address, and moreover since the
>> platforms were already setting 0x0 in case of an error=2E If it is okay
>> to increase code size on these platforms, I will change the calling
>> function, such that the variable does not get set in case of an error=
=2E
>> Maybe Casey and Mark can comment? Thanks=2E
>
>Systems where 0x0 is not valid memory are common enough I think, yes=2E
>You can see what the size growth is by checking say j721e_evm_a72
>before/after, and if you haven't been using buildman for size
>comparisons already, I posted
>https://source=2Edenx=2Ede/u-boot/u-boot-extras/-/blob/master/contrib/tri=
ni/u-boot-size-test=2Esh?ref_type=3Dheads
>a while back now=2E Thanks=2E
>

