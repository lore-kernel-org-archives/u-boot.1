Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499E2E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D82801A9;
	Thu, 12 Dec 2024 11:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ziswiler.com header.i=marcel@ziswiler.com header.b="DYYLTPZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F720801DA; Thu, 12 Dec 2024 11:34:55 +0100 (CET)
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC7F801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel@ziswiler.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziswiler.com;
 s=s1-ionos; t=1733999661; x=1734604461; i=marcel@ziswiler.com;
 bh=N2ThzU1uBBI725dbq7UUneTGzXYZ32khbcSrFNvDJuQ=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DYYLTPZ1Uvuy81nKpztESVFv+i5yhQ6sPW8pDOPpaxlmwTQlP39A69/vPwE4bmQb
 SwEWwz24mQ5yWnsDmhegdipj8JgLIrXB+vHv3A3I4i5cOafDqgrV5SHV9BExOlsOU
 74IjyYQHIgeEyVE6q7d+dBk/h6EzUZmj/KDppGpimVkaa/mKEWwpqPZLJH+BX1OiE
 a5HoxuRnrw5KGWYYZXsFX/C+zNg9l7F9wbjqlq1g1YqtnarL39x6w2ZcGbiL4JZ2p
 UhljyObBlXnDpGMfxaGK/fWDcQwVQZnP0FHjjwNTYhwcskQM/W6AjFG5ECp32pykt
 z8AL3I4TdsXhmoZF5A==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [10.10.1.204] ([194.230.241.203]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MgM1Q-1t0Hn83Yes-00JPEJ; 
 Thu, 12 Dec 2024 11:34:21 +0100
Message-ID: <1e5f3c0528a7c2e038ffb11c5b2dc7577162f3fa.camel@ziswiler.com>
Subject: Re: [PATCH v4 2/2] doc: spacemit: bananapi_f3: document Banana Pi
 F3 board
From: Marcel Ziswiler <marcel@ziswiler.com>
To: Huan Zhou <pericycle.cc@gmail.com>
Cc: Yixun Lan <dlan@gentoo.org>, u-boot@lists.denx.de, Ben Dooks	
 <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>, Dan Carpenter	
 <dan.carpenter@linaro.org>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heinrich Schuchardt	 <xypron.glpk@gmx.de>, Jonas Schw?bel
 <jonasschwoebel@yahoo.de>, Kever Yang	 <kever.yang@rock-chips.com>, Leo
 <ycliang@andestech.com>, Michal Simek	 <michal.simek@amd.com>, Nishanth
 Menon <nm@ti.com>, Padmarao Begari	 <padmarao.begari@microchip.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,  Randolph
 <randolph@andestech.com>, Rick Chen <rick@andestech.com>, Samuel Holland	
 <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, Yu Chien Peter Lin	
 <peterlin@andestech.com>, Kongyang Liu <seashell11234455@gmail.com>
Date: Thu, 12 Dec 2024 11:34:12 +0100
In-Reply-To: <20241212040015.ii6f6tklgulfwsqy@per1cycle.per1cycle>
References: <20241129-pickup-bpif3-v4-0-e99fabf66e33@gmail.com>
 <20241129-pickup-bpif3-v4-2-e99fabf66e33@gmail.com>
 <ad100a4f673759559a6047083713d379847894cb.camel@ziswiler.com>
 <20241204005808-GYA559515@gentoo>
 <cdf417bfba7bf57379d18eb114822195610ad99d.camel@ziswiler.com>
 <20241208065157.wd7jr4ltjtvbytld@per1cycle.per1cycle>
 <b7b51f70e6271ea38fe2257b8424c41bb3e6114e.camel@ziswiler.com>
 <20241212040015.ii6f6tklgulfwsqy@per1cycle.per1cycle>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
MIME-Version: 1.0
X-Provags-ID: V03:K1:CIeprUro0Lx6dvsfKiNnK/Fu/LgOjlaJ9MdwgjP2vg8elPLpMVL
 84l3Fi5xkpkYdaLPh8t3W/8P4TyRbU4koY46TV46fG9UYc5aK0oCwIxy2SjmXG+9RuNbt/Z
 2tkWHGxSqv9B2yyn1Yq687Sc4T1ORV+KqocqR6q6sgaRNiCh+MhrwboNQkO4dq2tKXT0dsG
 UeAU973GlBgEITPOQ67UA==
UI-OutboundReport: notjunk:1;M01:P0:YqoxprZhCeA=;qtHiygxdRUS7XuigDaK/6w0gLMt
 caXlDAsF/x0DpAVAleZlzjhpgbVRvkFH23JgbxzYnGXf73w0lDnNTtMkkOd7tuY9C0zPe8uoU
 vJ0noO+1FcHcvtVF4pfG+ix0EqOCAQlRRvupyIyEa6lWUmsZqkKXnBpF5Ua3EtM5WR+kBX30P
 2AA/1t1PEOO0u3bBS4eLSwyZKB5GtrYHGj3ESVXmdLNLA+hJpXHfLhXo+sPehDNRArf22ivS7
 QvhbNLggRLP2EUH1Mj67852TZGrPzk8vn3g6qVsgXaIU+2l3jowwwZ7ZnF9YkB6tYVCuDrWdU
 JsLJsGuHvn5aeimbONu9SHOh85jrFM6nZtetEQD6/obg77PbD81+wIEY8Dg0dkBMuIX4w1JqN
 Kuw9DfIPsieJuvx7OuuOWF/P5GNTYMGVi8f6UEeJpO9NIErieccpvmTR25WN2ER10sXrgs+1h
 r1KDfPWfuvhzHlDfuClZQxKlwJq4/itp1acBCdfHFZZAVfl4CLj7MfULFjmxwO7prMkW6uNzl
 H/DKjfeXgX9E3mObEneDyddyaF4QpFDRB83SXeGO7d9EMJTcDbJryKur307mSzJCzXscSdZ/O
 BhADb6jy7QDtDJZa7yzi+VUkPuC7ilc1OHQUc6yL3ehRm73IaavXGCaOHAqrHPmE/nRzKjr8O
 11fHAxt15fwZhjkDxGlxzDJ5Aj+b/TUw2y645QGbk9a6wivVgl+RVHd++HW6A3QPW4Mdn34qK
 hbBYMDlBoGRCCXkTGGAVW/StpJ6RgJSZ50uwJpmOsep/LJzJXq5SvedxMoP6qvH5U5Tn6nOfU
 8WN7Bz6ma7BEi4bqpABjQZJ1+vNIsILPjLt/kSxvvi0E7GleEq3PCdhiGH0EuJ0yrKWT9FzZ8
 NS3H7gww5ED0ox9hu9Ybv2O4QBXegYfagezZnZw7iadacX3piFNK98ceuJ6Wv7uTJZp4r2jpZ
 rtMbENEYjxP6KHWKcIawiA1LSCG1Xd5mnGBQqwUHQI3ehbED6qhw4lwz6cZ4A3RoPEkBHbC5U
 wlFDWUzhITCNDH4UROE00Reh1GPDLYSmQlLfNaX
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

Hi Huan

On Thu, 2024-12-12 at 12:00 +0800, Huan Zhou wrote:
> On Wed, Dec 11, 2024 at 09:35:12AM +0100, Marcel Ziswiler wrote:

[snap]

> > > > I tried and it seems to work fine, resp. the only difference I coul=
d spot is that instead of 'crc32+
> > > > OK' it
> > > > prints some random ASCII characters in the last line before any U-B=
oot output:
> > > do you mean the extra '\n'?
> >=20
> > No, it literally printed some random chars, but now it seems fine. Prob=
ably some unrelated glitch maybe
> > UART
> > related.
> i think it may be your baud rate setting problem?
> I use xshell and the baud rate is set to 115200 and the random char issue=
 never happens to me.

Yes, could indeed be. However, I do use a quality FTDI FT232R with proper v=
oltage-level translation circuitry
and also set it to 115200 baud. If I get time I will hook up my scope to se=
e what that tells us.

> > Actually, one out of five to ten boots it prints such random chars: =EF=
=BF=BD,=EF=BF=BD=EF=BF=BD&=EF=BF=BD%Hj=EF=BF=BDH=EF=BF=BD
> >=20
> > I tried cyyself opensbi again and after 10 boots it also printed simila=
r random chars. Actually, it even
> > always
> > prints the exact same ones when it happens. I guess, sooner than later,=
 somebody might need to debug into
> > what
> > exactly is happening there (;-p).
> >=20
> > [=C2=A0=C2=A0 0.579] ## Checking hash(es) for Image opensbi ...=EF=BF=
=BD,=EF=BF=BD=EF=BF=BD&=EF=BF=BD%Hj=EF=BF=BDH=EF=BF=BD
> >=20
> > Anyway, regular upstream opensbi seems to work just fine, good.

[snap]

Thanks!

Cheers

Marcel
