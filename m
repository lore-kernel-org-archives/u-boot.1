Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B84FCAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 15:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 894618365C;
	Wed, 24 Sep 2025 17:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJ3bEKXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE0983071; Wed, 24 Sep 2025 16:34:02 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6154980107
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 16:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-8c0e2d1efd5so1650600241.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758724439; x=1759329239; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uy161euH7AND+5CTzsMFSqmHiUAviLps+Fe4/bb+UaE=;
 b=EJ3bEKXruXlV6yHycHOQfIGVuZv6UESUgtcYoTp2+8KdGB1DLi5TEjmvwjUSe9ziNF
 iTqfba1USL9g5aClKgAsx025vscwBCiQJxooDt7GtSjHuNN2wBaCxsyuDyUgj6KoTFVH
 IHVcDVz8ZrWj003mz/tctsgTJPDsY9BikNe4KbyPw9y8UcDzWg1Kv3kD3y4URoG533Lx
 4i2oKyR8l7VBJdy9YWhXIxXWVQwOuRZ5C2eRKa3Xk1ESoQOiMl7+Qx5qn9HGOkBw86pS
 QLhYDhk5aedOCG/xqhnhi/tbAcZ6v/07GPIJdpod2tAC37a7xaDai+bWaIpe9MDfzKoz
 WJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758724439; x=1759329239;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uy161euH7AND+5CTzsMFSqmHiUAviLps+Fe4/bb+UaE=;
 b=Nms/f1XmTAfyRafwLXRs1MWIv1Ff+OZhHgKWIZLU3n4fNm9d8BpcXZhh9uzQthLcI7
 4hD5RZY0FvvwNxhDEa1hBfFywdkVYxtg2X5UxFPgZ9GJw/ULcjexah3GilecKqiqaqhj
 YRUqeo6mSrNrhyPNNiB42+AoB0CWvGiTT5snNTiZU7X5isCMLoWamn7IjLXXe8A3NdBh
 GUUCewmIITNLt8tzJoHHsY9WYUxkwCCRmcHBjP/rEQq+DR+aGP6dPiEBcHTmsD+gQgQH
 OHln2Icv474fhkm9VgeQVsqaMVa4p2dwI4N1fGQXSzS9YXS4wvXr0jcpr/ZFUk88PJyx
 N7hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvWqTcHYGR+RszaAt1VOB3df3VOd41nDn8YpMBBM+ggVNeQR0bawSz07Fg2mbbqO7qBkhkNO4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz68iah0r4Vvtn2jykIYjTsGhLX9kfh3ng4Z7FyskDLWQhquNi
 nokYBLD3zhTYKjbGUZyAuOsYvuzQWNI1qZz55l58KlR6XbiE3cX5EeGGzyvTSCtnDUUZvnivkW1
 L+DzgHGV7bsseYb7nTOJVdNlxHvWRVhM=
X-Gm-Gg: ASbGnct0FNML8zpk+Nz0Tii6rgfV4Gdj6aBZzWASENXutysPWs23RBgdMztJujVDAHx
 ueMmm+pU91EVZ8MGPCeAUN10bbAcNe1jMmKa7M/DQtABbxTJe4Dquk/kcUN9teDZu2iwK8Aurzh
 WBZYCP1nYwd8FzSIMa+vRC2uuGzpAK/yrDAZZshvKEjVhMFbJG5I2ITl8dQ+GiOpdcIwYfjfeOT
 EJrNSY=
X-Google-Smtp-Source: AGHT+IH1zTDPqdpI9wGQW4k7xrIDWE2OSG6RC5lABWyS/yGxZe2d9ge2YXIZKxKw1Xo91L/pRiXdnxeLIWhFHZUZokU=
X-Received: by 2002:a05:6102:3f0e:b0:4f1:7946:ed52 with SMTP id
 ada2fe7eead31-5acc83fb099mr57800137.12.1758724438993; Wed, 24 Sep 2025
 07:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
 <20250924114317.742ae4ntrb4mvuyq@expert>
 <b07919da-f3fe-49ca-8f76-ab057d8af58a@freeshell.de>
 <20250924135139.GH197373@bill-the-cat>
 <20250924140524.fy46p7ifr4oxh5mc@uncooked>
In-Reply-To: <20250924140524.fy46p7ifr4oxh5mc@uncooked>
From: Aristo Chen <jj251510319013@gmail.com>
Date: Wed, 24 Sep 2025 22:33:22 +0800
X-Gm-Features: AS18NWBykcZsivNB520efiPnCZqq5piWVTo8j7Z9kpDh7_Ns8zy0M8vAl0_1aVQ
Message-ID: <CAJwFiG+M8v3RA9=E296s8xc+NnK3HxwBspw30LsXUBMpzB18ew@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
To: Nishanth Menon <nm@ti.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 u-boot@lists.denx.de, 
 sjg@chromium.org, alpernebiyasak@gmail.com, al.kochet@gmail.com, 
 paul.henrys_ext@softathome.com, bb@ti.com, y.moog@phytec.de, 
 w.egorov@phytec.de, francesco.dolcini@toradex.com, ggiordano@phytec.com, 
 n-francis@ti.com, afd@ti.com, d.schultz@phytec.de, d-gole@ti.com, 
 ravi@prevas.dk, carlos.lopezr4096@gmail.com, quentin.schulz@cherry.de, 
 alice.guo@nxp.com, Aristo Chen <aristo.chen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 24 Sep 2025 17:25:44 +0200
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

Nishanth Menon <nm@ti.com> =E6=96=BC 2025=E5=B9=B49=E6=9C=8824=E6=97=A5 =E9=
=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 07:51-20250924, Tom Rini wrote:
> > On Wed, Sep 24, 2025 at 06:31:23AM -0700, E Shattow wrote:
> > > Hi Aristo,
> > >
> > > On 9/24/25 04:43, Nishanth Menon wrote:
> > > > On 06:37-20250924, Nishanth Menon wrote:
> > > >> On 10:59-20250914, Aristo Chen wrote:
> > > >>> This patch series enhances FIT image robustness by adding **memor=
y
> > > >>> region overlap detection** to `mkimage` and fixing existing overl=
aps
> > > >>> in DTS files and `binman` tests.
> > > >
> > > > [...]
> > > >>>
> > > >>
> > > >> Looks like i see a build regression in linux-next after this serie=
s.
> > > >
> > > > I fat fingered that one.. sorry, I meant u-boot next.
> > > >
> > > >
> > > > Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f
> > > >
> > > >>
> > > >> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76
> > > >
> > > > I  believe there are outstanding comments on V1 that have'nt been
> > > > addressed either. Can we revert/drop this series for now while the
> > > > comments are addressed?
> > > >
> > >
> > > Similar to Nishanth, I am seeing a build regression, itb.map:
> >
> > Sorry for the noise all, I've reverted this in next now.
> >
>
> Thanks Tom.
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
> https://ti.com/opensource

Apology for introducing the regression, I will find time to fix them,
and thanks Tom for reverting my patch set to unblock others

For TIFS stub entries on AM6x platforms and the starfive visionfive2,
sounds like the image in the FIT will be selected during the runtime,
so they are not really overlapping each other. I will need to figure
out other way instead
