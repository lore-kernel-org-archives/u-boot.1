Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FFFC3DA66
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 02:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B2E8652A;
	Thu, 24 Aug 2023 04:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YrUWHD+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768338652D; Thu, 24 Aug 2023 04:11:26 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6849864FA
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 04:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692843078; x=1693447878; i=xypron.glpk@gmx.de;
 bh=AxHDkWsYZVVi3k87npgtIgvhCphqtL6k74s8NIr6aAw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=YrUWHD+heMqXVX0jqGnn90S4f5I8CDAXQesVDfwhFNmAXzgI7+t2QxhH4CLIgtIO1p+z2eq
 gszXJkwTzRLyKd9ceVdK3IGtri2/vOkA09y2PFGYu0uam4YasLq5YzGrYIebxl7Pdw94iWjHd
 UadCuD4RJ6VrwLyVFWg3p2pdiNrVOFB04USfgr1txKM19Xx/va2faDArXtg0YfwTUORek2HmW
 gyaknDbgI6MOX5a3ii2QbRsv4JIbYU/h3bnQi9FdVkiJVLuCnhjztc+IGErPgEcQC/URsWNuG
 wXQCC/RqoTNQR6zZLvV2rL4NP8d5gRWu4NiOrN7A/aAOHMRr+hOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1qCT000t2Q-00VQQL; Thu, 24
 Aug 2023 04:11:18 +0200
Date: Thu, 24 Aug 2023 04:11:16 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
CC: Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 7/8] spl: x86: Avoid starting up PCI automatically in SPL
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPnjgZ3i9EDe3CyU64WRpE+oR0-xS2iffQR=2hVBZRzA2KkC6Q@mail.gmail.com>
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-8-sjg@chromium.org>
 <6f1ea3e9-7284-22d3-e2ee-071523b7dbac@gmx.de>
 <CAPnjgZ3i9EDe3CyU64WRpE+oR0-xS2iffQR=2hVBZRzA2KkC6Q@mail.gmail.com>
Message-ID: <2058DF5A-619E-4B47-A80E-4B5C56FC3573@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NmIzdMu5fuRcmzTIlcyI2UmARsDwrSIxflS7eI0AuIr4puhAAzp
 l7YqMHLQZsLKCNX3IVIfIo0gXvH/BAjND1A3v+cjYw7ws/WsUwA/Jn0OXsjmCjXm41Py6ZO
 UqOSQHyvIAOs+CjGvHXUUZwFKv8lPI/NFlkEJgNiKtk5sjk+p3aeb1GR5jXJ7D9C85D0+zu
 ykg0OPRC14pm7bLb3lplA==
UI-OutboundReport: notjunk:1;M01:P0:+ZEPn0bLe7M=;x4MnnIIq7N9N9rb1po1InLd7K5P
 tr1WHBaD76v4WLiXA5SaMb2ZMjkcOD24hQY2zV+sWJcNdZiGbv/QesfA4kxbq8ua4dOy26fZJ
 auu41vYzRlCw3YBhTVBA5cZY1wfLPGMnk+DWXnPlnv++dw+lcuGGxhtc2ULtKQJkQN/DKm/rp
 e+xfHSITzQ5ItagAdrRXEO+EbLQJAJLYnf+8ZE9Q1/bmFei29ZAQhGUS0zQF//Y/LT1lzUSJg
 QBzwgcUpYwRbKLabkY7rdgVxfwGAD6ORVWLyM2MN4Y9vUDgZhVjeQho/V+oy0lKQlaaYM6Hpy
 hc2zVVj79w/e+lhjw509Sf7fMTsnZsUkunZOSudxcKevu0P3sMwuy070ftz2LGz2MRb/14HkL
 ZOlo3XjRKb4dE5/+A7usFnGq+2np4ddFacI3/zStQAv6axJ9mTK+DCOUmTIjfXauXV0U8HAnt
 SDzouAgd26rbjWdeJ6ddkWGxhy+JEPmvj4U/ZXBpHt8s1xqH6fqsJRxymJBA/eTew11ofxJaR
 HnNeYxmmhmY8lLyx2QqG+n2u9DSk2VX1wxN2iCnB2ubMx6xmF/wZ1gCvlyGb1D9EsD1+ZiVxk
 WqWQd+QcLFVsm+YMvob1SG9v9zy9MhEwiC8fsdGirYfKydaboM6eLrhT5svhy39LdYdn+n9QB
 Je1RHRTek9zj10cPqMa7XvU604k3Dwsc7qIrTwV9qIsHYUYT/GKHmrf/hV5571IjMuQuaoAzX
 YC+S2RENQzwaEt32CuNVwdQSO+uapYyNVUGmkXfjsI9qTpvZZdd5WmMoYNxgtOQpz/KMIXUiC
 fNAB4YlGtAmdyiMHTFnyCBgCyIhRvQSTUyhxgBrwe+LEb9DjtPkFT+8sY7FdJRiL3L/VjRCxa
 gPuwH/k/wuSBje4NfOOLExA+2ASmAXRspq9kRccIKZtj2yn87IlVtQ4vC1esKouC3Fl5zoXXD
 lausA4I9J/lCbZdRrb3IEzwFmJw=
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



Am 24=2E August 2023 01:57:55 MESZ schrieb Simon Glass <sjg@chromium=2Eorg=
>:
>Hi Heinrich,
>
>On Wed, 23 Aug 2023 at 14:19, Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede=
> wrote:
>>
>> On 8/23/23 20:47, Simon Glass wrote:
>> > For x86 platforms, PCI is core to their operation and is managed in
>> > arch-specific code=2E Each platform has its own way of doing this=2E =
For TPL
>> > and some SPL implementations, the full driver model PCI is not used=
=2E
>> >
>> > A recent change enabled full PCI in TPL/SPL for all boards=2E This br=
eaks
>> > some x86 boards, so adjust it to skip that for x86=2E
>>
>> Could you, please, give some more detail?
>>
>> * Which boards are broken?
>
>For example, chromebook_samus and chromebook_samus_tpl
>
>> * Don't these boards have a pci_init() function?
>
>Yes, the same one you are calling=2E
>
>> * In what way does calling pci_init() lead to a failure?
>
>It probes and sets up PCI devices and uses a lot of pre-alloc RAM=2E
>
>>
>> It would be preferable to have all architectures and boards use the sam=
e
>> high level API=2E Excluding x86 here looks more like a (necessary) hack
>> than like a target state=2E
>
>Fair enough, but on x86 we access PCI long before driver model is up=2E
>Generally we don't fully enumerate it in SPL as it is expensive=2E It is
>also pointless, since U-Boot proper does it again later=2E
>
>Regards,
>Simon
>

Acked-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

>
>>
>> Best regards
>>
>> Heinrich
>>
>> >
>> > Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>> > ---
>> >
>> >   common/spl/spl=2Ec | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/common/spl/spl=2Ec b/common/spl/spl=2Ec
>> > index 0062f3f45d9=2E=2E13d7b1a742f 100644
>> > --- a/common/spl/spl=2Ec
>> > +++ b/common/spl/spl=2Ec
>> > @@ -800,7 +800,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>> >           IS_ENABLED(CONFIG_SPL_ATF))
>> >               dram_init_banksize();
>> >
>> > -     if (CONFIG_IS_ENABLED(PCI)) {
>> > +     if (CONFIG_IS_ENABLED(PCI) && !IS_ENABLED(CONFIG_X86)) {
>> >               ret =3D pci_init();
>> >               if (ret)
>> >                       puts(SPL_TPL_PROMPT "Cannot initialize PCI\n");
>>
