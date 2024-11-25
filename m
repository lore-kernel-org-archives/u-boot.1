Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CABD3B7DB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 05:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1040589A22;
	Mon, 25 Nov 2024 06:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mkKMVpU2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3CA89A26; Mon, 25 Nov 2024 06:47:21 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21D2C8955B
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 06:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-85709529823so2230454241.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732513638; x=1733118438; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmUnDyxG011ezCXZozn2JfugaaOyZkQCHxkyPu28pG4=;
 b=mkKMVpU2MZ9hzg/7RHVfLznLwWHqbCMRlxFKfzaMYosfl42d50AKxjDQf54oqLMM9b
 Qv/Lfx407MqxGajy0pPhejwpOSZnS74jQFBR/mfuVpIpkK13IYtJyZ7W3FFNM5QEJttC
 ds0PcscbxhY/ssTysKOCMhWdYJQuIbZ6WCjfWR1dDxJjhPS+jG9YuXZ7L4Q3gDnmNmui
 /I9UcBS1Ts46ZSFXZHF1HC7TxFVGrqbnBczFXubTtKfbOQCZPfQEEUxOH7Q1wti5d/kJ
 CJ1AHsjc+46WFeRuH/4KWV9S5e0jYBjVJ+jX3F347sHzGVepQiMgZ+JTtXVehedICAd5
 9TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732513638; x=1733118438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmUnDyxG011ezCXZozn2JfugaaOyZkQCHxkyPu28pG4=;
 b=Nl31LbxWI4C0/keVYyy95CdcPHL0KLCxRfmPZKF7vKfCTYkNcIDyPnbVBMdbb5B/kD
 5UCgIjEyGqhpyP02/hUDf873HWbDSQx7nsOLDJ2HygxKuJzW5aSbTx9xiX2YaQxUDm0N
 WZdSsKk7fGXznDxueDvV79vgf9O6wop3xtH/p4xZvyfpmcqN8fpqldEBw7v6IiaADdpK
 2hUGyE9W2QKR6y4Jpl5siiJem8pbpy6mtNttBDgumqTk6pMAxNEJn0tHsaxkLP4/eLP2
 u0Km50sdEdHBTvQMRxtCrCvelGV9O14Gnnn4rs3JGkPI+s19oQM4i+hGxKhYhM5rbNaY
 +1pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0eTFBK87fabd1YYxQRxh6tvQpkcO6Ac+vdyiFdfOg63qtPnEL2QP1YcqzJdY3XpGlrbFuRI0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/ZZUwlHNFNqt8Xq5pSrmYqcDeS/DtQBSwC7t3DoCmK1we6/vf
 mVPJiFdtdGQDijvj2xuvFAkFX8v0CyClwVzFN3ee6UpfRvAEXrantXMNF57ZVupFOsqZhEZxVVM
 41TJgXLPtsChaUI1gr+DetnKy5woE/ZecET5okg==
X-Gm-Gg: ASbGncuOQbp+8ClSNAquiKTTbf1QMOefOkMA+wJVskAeb1Hs2PjI6XPrTqodh2DrYly
 Z3tdEXUNJociHoOw5gefv4lJ113PHWhG+dA==
X-Google-Smtp-Source: AGHT+IFStyYy47lB2rMFmIR2Z6qyRe7bTiC1xIQEr4pfUtneSqgm1mCHxhrEG2XEPYbKAvqQoQrvZ9850P+gjNdSEDE=
X-Received: by 2002:a67:f3cc:0:b0:4af:f45:d360 with SMTP id
 ada2fe7eead31-4af0f45eeb6mr3146846137.5.1732513637903; Sun, 24 Nov 2024
 21:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20241119020425.51989-1-hal.feng@starfivetech.com>
 <20241119020425.51989-3-hal.feng@starfivetech.com>
 <CAFA6WYOLxG68O4FYrDPt9q13dR=H3c2LcRVKhx4sRMBhy8dCTg@mail.gmail.com>
 <CANV2PTNAqxrPYypHwuDa6Dz5LUO_kzRGV0PzOand-tOo_peMCg@mail.gmail.com>
 <CAFA6WYPciEc-WJNc73j=C5AoGb5bbQ139p6=m7a_xqCVD4uYSA@mail.gmail.com>
 <CANV2PTPuKLnn3+0d-hqEogq9aE0iat9NhXjC-CxE40m5ht9SPw@mail.gmail.com>
In-Reply-To: <CANV2PTPuKLnn3+0d-hqEogq9aE0iat9NhXjC-CxE40m5ht9SPw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 25 Nov 2024 11:17:06 +0530
Message-ID: <CAFA6WYNDMS0zzebMKjS7YT36+=L2HcR2mQd7ccVixq4DOH+v0w@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] riscv: dts: jh7110: Make u-boot device trees
 adapting to upstream DT
To: E Shattow <lucent@gmail.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Nam Cao <namcao@linutronix.de>, 
 Bo Gan <ganboing@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 23 Nov 2024 at 17:43, E Shattow <lucent@gmail.com> wrote:
>
> On Thu, Nov 21, 2024 at 11:44=E2=80=AFPM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> >
> > On Fri, 22 Nov 2024 at 12:12, E Shattow <lucent@gmail.com> wrote:
> > >
> > > On Mon, Nov 18, 2024 at 8:06=E2=80=AFPM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, 19 Nov 2024 at 07:35, Hal Feng <hal.feng@starfivetech.com> =
wrote:
> > > > >
> > > > > Add u-boot features to the U-Boot device tree.
> > > > >
> > > >
> > > > For follow-up work, I would suggest minimizing U-Boot specific DT
> > > > bits. You can either re-use what's available in upstream DT or push
> > > > U-Boot specific changes (eg. bootph-* properties etc.) upstream.
> > > >
> > > > FWIW:
> > > >
> > > > Acked-by: Sumit Garg <sumit.garg@linaro.org>
> > > >
> > > > -Sumit
> > >
> > > Sumit, with the whole series applied this U-Boot specific DT addition
> > > is confined (with exception of what I comment on below for rx delay
> > > values on VF2 1.3b) to a single include file. Looking at linux-next
> > > there is a bit of re-organization since the Framework / DeepComputing
> > > JH7110 mainboard moved more nodes out of the common file and into
> > > board specific dts. When upstream dts settles again then there will b=
e
> > > some more work to update this anyways. Is it any blocker for you now?
> > >
> >
> > No, it's not really a blocker for me. Actually it will make life
> > further easier for the board maintainers in future if they upstream
> > everything in *-u-boot.dtsi to Linux DT. This will ensure that no more
> > rework is needed when DT is synced from Linux and rather U-Boot uses
> > the same DT as Linux does.
> >
> > -Sumit
>
> Does the "snps,dw-mshc" override of compatible belong here or should
> the driver in U-Boot be amended to accept "starfive,jh7110-mmc" as in
> upstream dts?
>

It's better to make U-Boot drivers compatible with upstream DTS as we
do need to maintain a stable DT ABI upstream.

-Sumit

> -E
