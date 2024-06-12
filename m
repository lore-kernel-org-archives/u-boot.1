Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B61C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 05:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69286887B2;
	Wed, 12 Jun 2024 07:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="qd7wRXr9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84E3B887B3; Wed, 12 Jun 2024 07:55:55 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC8F88788
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 07:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718171749; x=1718776549; i=xypron.glpk@gmx.de;
 bh=lmmAK+xNWNWOJobZT63hhcjrQAEiwWZl8QV4tJUzx78=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qd7wRXr9crJw/hiH3+y5TNXoPkpBEXJHU3wjG0/JCQ7Bx5BDkZjbV13/WhEiUjN0
 nfGP1wRoMecUyduSK0Oz+UzKarZQGg/K/FLdyPqKkS+27uGiQb467a964y8s5vq3t
 Do98GQAISde+SJYRm9Hdn7ShqWUUk4YojPQcdkWAmS98evBbJTaqiPLozF4dpf7RL
 HjrVhTIQc8Xx5huoQLFoOs+7+WVccWX6gr1Az87IvL32VYQQah6A0G29LrnANsx2J
 8GyDzW1US3Vc7eZw9Clzs9SvmVIwfMVBpM9d7q/YjjFTNTdBoXU6vVZSrVpNOOt5t
 ylYzjZcM4f3/gcyEwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.176.212]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1Ycl-1sFLHq08OR-00EiyQ; Wed, 12
 Jun 2024 07:55:49 +0200
Date: Wed, 12 Jun 2024 07:55:47 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
CC: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 01/16] lib: fdtdec: Handle multiple memory nodes
User-Agent: K-9 Mail for Android
In-Reply-To: <CAFLszTiU17kEPC4JGX4j-KJG7Ff=-fFnV9i2Ua0yvi-v-n6zhA@mail.gmail.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
 <20240522-loongarch-v1-1-1407e0b69678@flygoat.com>
 <b723aa8e-1d29-4904-953d-160caf097136@gmx.de>
 <5bd109ff-73ef-4bda-8b5b-2ab583c064d8@app.fastmail.com>
 <CAFLszTiU17kEPC4JGX4j-KJG7Ff=-fFnV9i2Ua0yvi-v-n6zhA@mail.gmail.com>
Message-ID: <41DBCED9-6D86-4264-83E1-9173750B63A7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ws5JvrXfg9peOdxWxUS0nnViX/sITHINUjwsp3GqWCnjYOU5lk8
 C2eJJ9/6hxvUhmI3OpB2qmBRCHDjiNAVmDOXoZ9SaUtiqjhLd3gC+NYLOoOkScTju3nux+s
 0ghq+SiGTt6FVSa6r3TrMkmA6wDYxWY2ZU6hd0m8j8HlVboMfsQoiPLyUL2H+Ji11gwrLIm
 qEOTW9qCYxM/K+hPxpGYw==
UI-OutboundReport: notjunk:1;M01:P0:0ynDEQjE0DQ=;elKWpXGEPfvYxIry1SGPbMmrQ9B
 NM4g13pWyrOt3WSLEPAtuLIvMg9neWylYFrXaT4tu5gJNS32DRbcqmiOjW8Kexm1V+suoqTz9
 Uk3x8fPL809+GBw1DYuIn/oBq3HERloOwyuBY/tBZ1hNB6WMcp8+Qz6basJCGqE4HZP597ccO
 i6GXxhcOajfY5cr6t7j4obZ8lfTMGyrtfXI8uX3qKXyPZJeNrT8IZ0msVL9T5aJAquwroZsY7
 1wOZY0GclEsX/28j2jTXXyJfG9ujJSZC/78g9nJ2aMLYRH0B+OCo1ZCYxAc1Gc9u+Tmn4pvZe
 p5+Dsyk1C2a6balh4Mb49KhSBi+TJfpxz1Tp1Aqp6FHABeeUMC3FxGpG48AAm8gYJBccGJTHD
 /Zw//Vd35p6Ryd6DKlI1DyTi4sV7+S6re2lkbniq67vrI4A69TvWkl/4WFyWE/YtopqXvjq1Z
 Via4dzv7sauEnZhbio0vVxhm4pWptbdz1v2nCXAY1x5FYSVud+9EwRncBNocL7sgYnbRw5A9V
 c0CO5VSF9quwU+RnTVKlVjQIccvzDfRNQ7oEaOal+mPt18EAlzk+Gs4VWJyIoPV7ajVhquv83
 Hd6Z8SEEvWd1qF31CXYUvR+eQmRAxz9Dusby+DHfyzDLoN4UOSrGlz0iDL5ZU3KTf5wZNzYj2
 kZ6CXOG+XMMOpn6NRicsA4nVVM+FVSssA3itRZoPKrPe3CxjcpFOXGqXJOs2HKnyXM3jLCoYD
 s3x9uJsR1u/fGK4iQRF2jX7ck0qkpasO8eAKl53VyUeQKAzuFHB5qtdynU/IF5Dgr5yM7ZSIf
 N8vC6kcyCyPbtIxdCw/1FotjGq8FLmIc/3Eu3mEUsFa5k=
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



Am 11=2E Juni 2024 20:51:55 MESZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Hi Jiaxun,
>
>On Tue, 11 Jun 2024 at 07:48, Jiaxun Yang <jiaxun=2Eyang@flygoat=2Ecom> w=
rote:
>>
>>
>>
>> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=881:26=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
>> Hi Heinrich,
>>
>> Thanks for your comments, will fix most of them in next reversion=2E
>>
>> [=2E=2E=2E]
>> >> -            gd->bd->bi_dram[bank]=2Estart =3D (phys_addr_t)res=2Est=
art;
>> >
>> > The conversion is superfluous=2E
>>
>> This is necessary as phys_addr_t can be unsigned long or unsigned long =
long=2E

In C++ you would get an error=2E
In C an assignment to an integer type of different size does not lead to a=
 warning=2E

Best regards

Heinrich


>>
>> >
>> [=2E=2E=2E]
>> >> +    __maybe_unused const char *final_name;
>> >> +    __maybe_unused int final_reg;
>> >
>> > '__maybe_unused' is superfluous=2E
>>
>> This is necessary as when LOG_DEBUG is disabled these two variables won=
't
>> be referenced=2E Compilers would complain about it=2E
>>
>> >
>> >>
>> >>      gd->ram_base =3D (unsigned long)~0;
>> >
>> > gd->ram_base =3D ULONG_MAX;
>> >
>> >>
>> [=2E=2E=2E]
>>
>> Thanks
>> --
>
>Can you please add a test for this function? Perhaps test/dm/fdtdec=2Ec
>might be a good place?
>
>Regards,
>Simon
>
>> - Jiaxun
