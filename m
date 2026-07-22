Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84856C44532
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 00:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BB1B409A4;
	Thu, 23 Jul 2026 00:52:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dnqrkdEoYedm; Thu, 23 Jul 2026 00:52:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 503FF409A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784767938;
	bh=fuxli1FZNRrX8d/y2l8YufPm1KXZsfZLlMbEaE6R0ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VPZYhh9Wznzv0vmODgDltC9R+EZFOHo0jLGEacU6jAhTMv6I/d6rJqmIG34W9Cs+I
	 gThQ9Tb35wBh3V/sPNW9I6GMwQSBLyOkjXp9ENZyvogSeoTxrW7QXR18pOrqJnG/U1
	 r+SXQ9k6Xu7vPAGb4UuW31Prf7C+nrbDaOTsClZYA2AW0Crbo39mizV7KfbJ0+MOFE
	 xtWY7qcmYyHMRIRhPC7PdlND1MySYI5OlNPKrCadwu38PmOIYreiasOkVLZ68sVDNh
	 OWpOS9fKM6M2A3rPYHhSytrfvxfhqC1Gmwt/xWX0cQzkGOnGT80VOG9Sx6az3UknWf
	 cKeZ2p4xbryVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 503FF409A8;
	Thu, 23 Jul 2026 00:52:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED1EE788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE08C607C4
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:20:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DoC4zIHDG4IL for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:20:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=james.hilliard1@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8DBFF607C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8DBFF607C0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DBFF607C0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:20:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94E168494B; Wed, 22 Jul 2026 16:20:41 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAFB848BA
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 16:20:38 +0200 (CEST)
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-9674d727c0aso2936132241.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 07:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784730037; cv=none;
 d=google.com; s=arc-20260327;
 b=rGMXBUTws2FabaP/gyxrmd1nOmgrkusYRe5zTNad6IxJFTV070kb3ITh18jzE+NnnD
 nnoxHZfnfV7CfoGsyGfaYBkLP5mNQafK3+3n9oRDYXAl/VUjteeYVnjNqhZIn48q4wNs
 7GMBQcIsC1W07gdOBVpCef1tDSgziaZ2hasn+moX0raM2LqZiXd8ttsCiqLLD78yf+LB
 6v7lGHN7+u9aiXAyMV9kWQRYFPxGAtD793HBoNw7NteybhkVX+2PPVvxES29PK5yIzdA
 endChuEwKlELYhzG+iErAajxuMyhXRzLHDYlLA7JL0qjWzXYekWQ9Vqb9P48GnqjDaHl
 byNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fuxli1FZNRrX8d/y2l8YufPm1KXZsfZLlMbEaE6R0ao=;
 fh=IElcBSUcXgHjyAk+b6vONjshztWNgTmBO9oD7VfljVw=;
 b=c+d0/LV8PVrbnT9FR7+u21CqXgzxI+btvn3dD4IaNtvub37YNS6e2NdQJNX/z1yx5D
 XF3FYifSz0TR7P7zTIPno6daddXZFSFvGueRryrwjZFEayyLoEWAW+wk+E5fUuf3pnTr
 NmV3mQc4pNjQcJF/yazzRDcbSpfZsdARjob99BI07Ue8wajR95g4NDxtJ1SgTRbK/qDn
 FsAO7GKwxEZw94x7Agmm11xJWVejDDcb9NYiXb8qW8YeF1OJ1aqpZaTqqIKriTk0b8Xh
 WTAsK97b7y0iVkN1Nn+Twbw3dR90gbikLNJegUOZHkcnKgCN3PfmrwKbwv2ai3TiExI8
 01kA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730037; x=1785334837;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fuxli1FZNRrX8d/y2l8YufPm1KXZsfZLlMbEaE6R0ao=;
 b=tV/2VVmUb1ycg7I3TYGqR9YhMc37R6WHhQM02933zRAuT3R+8UXFh2Gmzdek3QQ7MA
 8ubXSQmVj9OgBAgj4XwSGDt68LioqjIgmyILeqynLKEDUPqHBdaL+KWx57HoKSzu6itq
 Q54imiX5P/uCYyvXeDOHF4XdDULhakl6jFpR19sOWqY+8IXpvYrBXmdIJ2YhmERqBx6d
 WyZm35PzsgUUkyGM5hoAkR/+qGhT0vtvtJWzzCe0bAh8dBhttMtkajsFZbvMZe5eI3aS
 PkpN9UM9xKWkXgyzbNIyFBGT6UJRT+a6VFIpYx+weOvMUHuCNIcYcZrOhGqrhBeNumLX
 wBWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYYe7g5MgRayNbCtbAATmaDGiCH70anbI0QU18hVYIVcx11y7YhTQ4aizW81DgVXHd7LEMksA=@lists.denx.de
X-Gm-Message-State: AOJu0YwJe/Rk2ZLgHDnYOLeBxvVrEGdGhujp4s3KiqpSlMZ0GjKqlG1f
 utE117zlfILbTKer9zbWUJiopU+dZXgHRHpjjkc2WvaEqe8OhhwzaLsNbpH80tg7IEq9l5MyyV/
 4pw1HaS+/Cz9in72HODCM1Dm9cvXZzSw=
X-Gm-Gg: AR+sD10sZdosjE1aYJhTDJoVtm3aHXRyB8YzWsvPZLOlDhGAvuf4T1+SBqocd+L2FsJ
 MWB5GY6x7n1tRacTiewng+Tj2TTxOR0Zn03Rg3L1EUQAjA0bF8/OmdZC23SI9qqQNI3FTD4encp
 YSyxXddRJ4v91O2AbyC9zBoDRifcnq1MgSF3knctHLWtDTK/1hwHVleY3xd5dqWYprN6vB2RcEe
 two9wTtSLZgkTD/NgAHr3icG4LqJwSnuQUJeac+/858GTDe4Oy+eUkVYK9iMA8ZN1G/L0bFUz0H
 3MRtWlFyrgQUxsZHolL8x0os5xckXtvdAMx18dpP2ysZnUdiPDZZ1uvoGK4j2qGZCkB72uokHcc
 42KNdg1IQOsIghIt2SXRdQinakuN9MyfsJGAtwQ==
X-Received: by 2002:a05:6102:2906:b0:737:b102:c1b4 with SMTP id
 ada2fe7eead31-74ad1637352mr1887396137.7.1784730036965; Wed, 22 Jul 2026
 07:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-2-3c41f66d4522@gmail.com>
 <20260720232409.GN749385@bill-the-cat>
In-Reply-To: <20260720232409.GN749385@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 22 Jul 2026 08:20:25 -0600
X-Gm-Features: AUfX_myHNHRangiN6QBU7ucnU3BajvcxAfLgAlW8k7qddFBIoZTejyfM1xqt7Eo
Message-ID: <CADvTj4q4mxds_DKzngq_ugHv+b2kteNPRy4_GH_-ZPyqm_KB9w@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] crypto: hash: use DM providers from hash command
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 00:52:16 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784730037; x=1785334837; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fuxli1FZNRrX8d/y2l8YufPm1KXZsfZLlMbEaE6R0ao=;
 b=Mu7k96ra9qc7CWDIqW6fjciPhPSKYUMN+mbE+uzSNIn0O3+nebow6Rqvc3hDlG6F+X
 JDs2JCDwF9AhlL1mPMkaW+HPIzR18MC4BGk1Ts3hiep6GrOJkyCzU1DGC9YEIiUM3B6A
 +n7a4nhzNGzLZJXCRhrgT1loQdZNfcMb7F1aNdsHDZuSwDXvOhafCfpEWcDQbk/qM+Qi
 ptB6gngqjEvpKrt8VSP9Ulzh0D/4IKb5Viu8u53Sri1i35kGwxXLOicFW8aV0f3w/LHT
 xbZGwoljAlLgALX9bdBE4b1iEFIZ2tJfk9TXXAdlxizNKA2OI2daOChtB2ws7hzD7Bmz
 P3cg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Mu7k96ra
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=james.hilliard1@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mu7k96ra"; 
 dkim-atps=neutral
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

On Mon, Jul 20, 2026 at 7:24=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sun, Jul 19, 2026 at 10:13:46PM -0600, James Hilliard wrote:
> > The hash command currently always uses the software implementation for
> > the selected algorithm, even when driver-model hash providers are
> > available.
> >
> > Add a hash_digest_wd_lookup() helper which probes UCLASS_HASH devices i=
n
> > order and uses the first provider supporting the requested algorithm.
> > Continue past unavailable providers and unsupported operations, but
> > propagate a hard digest failure once a provider accepts the operation.
> > Remember probe failures so they are not silently hidden by software
> > fallback when no later provider succeeds.
> >
> > Use the helper from the hash command and retain its software fallback
> > when no usable provider is present. Add sandbox tests covering provider
> > fallback and hard-error propagation.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v3 -> v4:
> >   - New patch
> >   - Try all registered hash providers instead of only device zero
> >   - Add provider-selection and error-propagation tests
> >   - Reserve -EINVAL for hard errors
> >   - Use -EOPNOTSUPP for unsupported algorithms
>
> Putting new features in an unrelated patch series makes things harder to
> merge. I don't know that Andre will be comfortable taking some generic
> changes + sunxi support, but he might be. But it's even easier when
> something like this is standalone and can be reviewed and picked up on
> its own (I'm going to have some size questions about this, once I review
> it globally..).

I went ahead and sent this separately here:
https://patchwork.ozlabs.org/project/uboot/patch/20260721031123.1949018-1-j=
ames.hilliard1@gmail.com/

>
> [snip]
> > diff --git a/drivers/crypto/hash/hash-uclass.c b/drivers/crypto/hash/ha=
sh-uclass.c
> > index 5d9f1e0d59b..30929412856 100644
> > --- a/drivers/crypto/hash/hash-uclass.c
> > +++ b/drivers/crypto/hash/hash-uclass.c
> > @@ -73,8 +73,8 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO a=
lgo,
> >  }
> >
> >  int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
> > -                const void *ibuf, const uint32_t ilen,
> > -                void *obuf, uint32_t chunk_sz)
> > +                        const void *ibuf, const uint32_t ilen,
> > +                        void *obuf, uint32_t chunk_sz)
> >  {
> >       struct hash_ops *ops =3D (struct hash_ops *)device_get_ops(dev);
> >
>
> This isn't correct spacing before, or after? So as part of sending this
> standlone this part should just be dropped I believe.

Dropped this change in v6 standalone patch.

>
> [snip]
> > @@ -29,8 +31,26 @@ int hash_digest(struct udevice *dev, enum HASH_ALGO =
algo,
> >               const void *ibuf, const uint32_t ilen,
> >               void *obuf);
> >  int hash_digest_wd(struct udevice *dev, enum HASH_ALGO algo,
> > -                const void *ibuf, const uint32_t ilen,
> > -                void *obuf, uint32_t chunk_sz);
> > +                        const void *ibuf, const uint32_t ilen,
> > +                        void *obuf, uint32_t chunk_sz);
>
> Same here.

Dropped in v6 as well

> --
> Tom
