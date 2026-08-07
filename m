Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549B2C5AC82
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AB1E60AB0;
	Fri,  7 Aug 2026 16:13:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZleFn_xyGBD; Fri,  7 Aug 2026 16:12:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAB00607FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119177;
	bh=s+KGEm+1Xs7qyQSIhdkqfNxdX5bMBfJzZ+zwhhN97f0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w/ec5c8z15tbctKhZUDM8KI+X8FDrp7JQX1os3UUvuqAitpGjaGZq4aSGKQniuU0L
	 a/kCu+QI3Va+wqAsOpXbCTYn1awt11Mn3eSJ7Baxzc/mzmqdyyunkNnKag0ZosSIyX
	 ooPLtKHE2tfBd+nhsOA52SOfBxm+nzm9z5C39+VGpQ+5unlG8ReqzgaxWRR4aMVibG
	 cuGM1WBRfiThiSHkvOjYp2baHpVQsdvVpYdLlUGJZjsFEEpcPb84Yr0Dt2W7UOtdmX
	 GU3tFbcKrFtgDWPNuoKp3tfa80wgOLbYyPDAWc4zqfPIIqj36hKCy4N75YcxgRCd6K
	 lp6g7OcowdYoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAB00607FF;
	Fri,  7 Aug 2026 16:12:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 111F72F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:53:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03481400D1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hczaKIct7bn0 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 15:53:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0535E4008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0535E4008E
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0535E4008E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 15:53:27 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dfe910e9dso3605408a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 08:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786118007; cv=none;
 d=google.com; s=arc-20260327;
 b=WW1a6y9rhxNtYKtTx8+Ibtd9P8PLU1TFJ5fLp/4iMvi+qoSTiMzY16uWBYnq3VK9gn
 Dd7hsg8U9BUY9lk2rqrwMR6Z6sXvu19hFSDr6WYQzYQa0Vqb1LAYxhNeZ8tr7s3eTaAL
 8tV8q7HfrTiw2MFMnifHGvpVRT3xlIQyVAeLZND+ZiHTM2d/KCfIObjRH0F9U7jRpXFh
 4SEnh3WZu511RfPSVM47vcpa8dif9WbRraIPWd5zSBA2fioBa5pPkiYC68S46w1X3MST
 mevSBQe9O0AdgXkox5o0PEfWqzDlZYWjVSykMASmWACIjCdSPaRKl9DFAk9erYejaGK2
 3Pjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s+KGEm+1Xs7qyQSIhdkqfNxdX5bMBfJzZ+zwhhN97f0=;
 fh=IzScIBPEqXDc38dJAdsZ9BkhmTqefgr4mnMGLkLVUM0=;
 b=LHNvNxbci7TpDl5EEI/Twc2b5GvyiBLD5PWqUNGGDZ1Xq3G3YS2ctR1wgT/AmNAu8+
 KHuKTXgPxMcfwZUkrP8w/1MIySXa1tDd7DbIKgNTcqIdFnekG+GVwCW3MEbwv0PZAleD
 /b2q5/pusOiBnLgm/QHzx9fUGdlke7eSAePZE7OAf37YwPiBSwE8/ObqactV2Y4oTbO4
 x86yHRnfL5Qyy0Buk/J4S6nlTbBLxz6cTt4kCkKhsvWNYqnPqG//wBLePtIhgIBS6mi9
 Q6CMjhdrtqqjUy8nBjmixqdnLiuVIGhmAMXRuRAEdhxObTXPPa5XKef7bviy4kcs7Y5b
 7COw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118007; x=1786722807;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s+KGEm+1Xs7qyQSIhdkqfNxdX5bMBfJzZ+zwhhN97f0=;
 b=DDmH55yMT2YV4u+FyUf+4qqWcAoQJesuc5GMcxV7t5Vfvvv78i7680Z3v8CcoGKy3f
 5OfHSiktHimtkFKteKviifeHOLvhfK+c4J/VtebO5jAx+uRfadhzSisT+7IZS/eqy3c8
 XdhS4X8SfOGmrIAFdJFFSQVo4ObK94yrmNkLFJzVaNt7aPfVtVR9wrA101rqN0oKydEc
 kUbAuauFqhfk3RYYl/sn/PTuCju4AhvncjPGyR9wSGpL3jAWL5eEwsLPboi/mlHBGB6p
 eAXp7PIapM9e0nDLih0MGkgKkix4Sw54e1bDl+WlkO+rmm8m6Tv34Q7s23EYK0GJQkAF
 jEMQ==
X-Gm-Message-State: AOJu0YxSdfFwy74yzfOZK6JpOHf9OZWTlN2K5j/fIU8O48FeP+xct2wi
 B2P9lPAvsHQlbsVdiU7Iz8zbYcGIITxr1iX2fmfK/QvRXSvu8wpAEGT9+8S7OCx8gIvpd+nS7LL
 8MxifJ64Ys6fXEtSv1TUVjOrsq7CannCX5ym7IHin
X-Gm-Gg: AR+sD113lgLZfPY6xN+QiCzoSoJYN48DceLA3cVx40/4ZU50epK2qr7J8Rayd3P3jn/
 mTifOfk7n1bGSysmIsIivp/9sS1HH/3zqtno0Ztq0R7tXkAcpp7LP+YYuNv/nrKBJvjXgcvnhBc
 Z/HeXk5pw663U1MWYDyIzQsun/RUr3veG88bF08KoeMo1Kho0YVC5o4EvyLZ0i0oGA76Ce1EQkJ
 Fl6tES1lIuGSrh3AUV1aYblVOkXT+fGy3DGxTRfmEyKrvSwrCG13iROU/gUzv7SkLBNwI7gdOZo
 Irz/dt9h+KJqRqJDuDSqAGv42oACJky27nFVHrPhCsg=
X-Received: by 2002:a17:90b:528c:b0:380:9f17:6df3 with SMTP id
 98e67ed59e1d1-3903c5448dcmr24800032a91.4.1786118007188; Fri, 07 Aug 2026
 08:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-1-acb97c172993@flipper.net>
 <CAFLszTiAP1Bib=Xpg-OK=x=pJCuG=N8f_bnxE7dv=YdM4x2ZOQ@mail.gmail.com>
 <CAKTNdwHaxhnCy22VPMNnGo9Z=p3DF6zmQ8ixR-EsOpb9crO=Dw@mail.gmail.com>
 <CAKTNdwE1xG8d_x3KH6v5bQfWB_QQ1b6sHWxagz1JZ2GDyVOtgQ@mail.gmail.com>
In-Reply-To: <CAKTNdwE1xG8d_x3KH6v5bQfWB_QQ1b6sHWxagz1JZ2GDyVOtgQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 09:53:10 -0600
X-Gm-Features: AUfX_mxJZKIPewAZLmYEISTr9cbU7IMmZOlakd5ufu6NYI15ApgTuKuteVzLovI
Message-ID: <CAFLszTgGdE=ZeZhXGOy3bk2Yj3uokv=3VtafZpRk63GW3cnS8w@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] spl: Decide about Falcon mode boot only once
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Aug 2026 16:12:50 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786118007; x=1786722807;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s+KGEm+1Xs7qyQSIhdkqfNxdX5bMBfJzZ+zwhhN97f0=;
 b=XS5LTs4/2t9Lp2Xw486veadPsCt5ClzDeWpsyc+GCC5AbAAfGsXnLvOCwzrvjmRewy
 DOq4SMQ2TX5igbP4qz9KgfFpX3ovla+grZoVOsyVBx8dX8C9V3FNmscklGD6yUypsD92
 413QaBjwZGMMaNPdkWK6eETlJrk1XTWJKNtB4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XS5LTs4/
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On Fri, 7 Aug 2026 at 01:38, Alexey Charkov <alchark@flipper.net> wrote:
>
> Hi Simon,
>
> On Tue, Aug 4, 2026 at 5:29=E2=80=AFPM Alexey Charkov <alchark@flipper.ne=
t> wrote:
> >
> > Hi Simon,
> >
> > On Tue, Aug 4, 2026 at 5:02=E2=80=AFPM Simon Glass <sjg@chromium.org> w=
rote:
> > >
> > > Hi Alexey,
> > >
> > > On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> [...]
> > > > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > > > @@ -105,6 +105,24 @@ __weak int spl_start_uboot(void)
> > > > +bool spl_falcon_boot(void)
> > > > +{
> > > > +     static int falcon =3D -1;
> > >
> > > Minor - since the return type is bool, I'd find it cleaner to use two
> > > bools (result and 'decided'), or an enum, rather than overloading an
> > > int with a -1 sentinel. It also keeps the value out of .data, which
> > > matters a little in SPL.
> >
> > Sounds good, will adjust in the next version.
>
> Interestingly, the conversion to two bools on .bss turns out to be
> heavyweight enough to push the am335x_evm SPL image 8 bytes over its
> SRAM size [1]. The .data section shrinks by 3 bytes, but the .text
> section grows by 16 bytes compared to my v2 version, and it no longer
> fits :)
>
> I'm now thinking if it would make more sense to have the spl_atf
> handover function skip looking into the FIT contents and just trust
> that the loader selected the right one based on a one-off
> spl_start_uboot() reading - then I could skip the caching helper and
> wouldn't need to add any new global state, so there should not be any
> size impact. An edge case here would be a FIT containing BOTH a Linux
> kernel and a U-Boot proper (nothing technically prevents that, even
> though the binman template I'm adding as part of this series doesn't
> do that). There won't be any way to select which one to pick from the
> FIT at runtime anymore.

That seems reasonable to me - the edge case seems very unlikely and
possibly broken.

>
> Or somehow make the caching helper only apply to SPL_ATF devices
> (am335x_evm isn't one), although that sounds a bit cludgy.
>
> Any thoughts welcome!

Regards,
Simon

>
> [1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/j=
obs/62374
