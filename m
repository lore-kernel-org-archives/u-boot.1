Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE6DCD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 21:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6468B8489F;
	Mon,  1 Jun 2026 23:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qrt6c4SP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30AC5848B3; Mon,  1 Jun 2026 23:11:43 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033B884894
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 23:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so239278166b.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 14:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780348300; cv=none;
 d=google.com; s=arc-20240605;
 b=ljqQaYZrCEbnfgRyM+GtaOQTaWk16bRMwu7vm0N7C8ZzFFppSBfQLgyEOFZIbfeyUM
 GqN0U8Fr1GmbUNHtZGnm1AnsPWd3nLZfdxZ39Pr4Iq1uZeWXjwzTgFyjR+five2EP/Eu
 p0yllmSwPJukYmn/JbYnqRCcpXJHOPWlbV1dtBChgB8jnQxbBaU5wPIBlKSd7MblPSse
 G3WBzbYfS7rjSrcNr23vmVxNRhXpGbmJ/6f5kB5ZHDhQUkaCbC8PRgAQu1cz2GDLiQkK
 cL9hvxXOZewf0VE0lWvZOoS4YhvBE+ukTCbHcByuHUKDh/QjF/FsfYF57HqPG8qAyXWz
 Jjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hRi1RvsX23siQigd00pJwd3K7sBwOa1kXX5UR8/bTAU=;
 fh=WzUe1c9rLyIzXzZzxVaaBPfRxSFjufZLeK6uPol/qOM=;
 b=RmACxGNPIlsTpv9twoDnWqTu7V1ZcUQW/SItntyqaJ3Mjw4tNF7xLhKgGMu+upg2KI
 2lmZMGjvnpSJT95zui1HxeHF5ldMpGqNN60tM2yiybk1UTXfabXS02DbMZ1CKdmfUAwx
 9akkhPcjhZfov0XvS0oyDkionqVUDIla6HUHpuQw2akzhzOE9HdsVZX2ViR1uVyrDtvs
 nRFIQtSN/RfFtg24oLHxpIFPq9qSswmz6aRKFIIyh7yvKUGBPb8LcgUjTv2IqdH3g4tR
 shdUG0KA2VTVprEqmXxgPzU0mVOeJRACVW7gnJNkk4gCYszwW1J6MSIx0ufLuEZZ4Hn1
 chjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780348300; x=1780953100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hRi1RvsX23siQigd00pJwd3K7sBwOa1kXX5UR8/bTAU=;
 b=Qrt6c4SPAO0sU8YVKb68o1dbOJ0n2j31GwHRu2/jJIpDaD6kqG3/kxM+68EWkH359x
 TsmK8GRrYZSzkOSMi/dkLEsImPoCKRfKxNxyiqs0L8YMs2oh1nvPK2wPrTS2+BDm54Cc
 ZmpQ+Dr+DEvdolDnqAivhCFu1npFdaKb+6AC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348300; x=1780953100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRi1RvsX23siQigd00pJwd3K7sBwOa1kXX5UR8/bTAU=;
 b=mvlKEhZC3p/AUISMF45U5v+Etn4YiKC4pxbbPPcoJupAcS4GFgDRvws7CVS3sJtuQO
 nUjt/wT/MaaVSdyPVcJE/RbT6jMEE26wBVlyUFvInTTmtu2tKcbQqk6QwSkRm3Ex2C4y
 vH+RzxKujmpm/ZegBLmFZ/nd3LuAz/m88kiLvqLot0A2TL+pBfoYKwwAdVWXB10QmYhB
 pyV3+UzJ3juIylq5067wfYA15EprazOWt5/EK6sO9LsPFY+pWCrICjeG+eyX81z+hIae
 5r5/lXiIVcBeIXPpBieCKP2bUFQP3ktaGo0LJDCZEchMq7/c9HRNlL443G3xC5WId0vf
 NX4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/uZgN/bZIlqu1FqmqJGxyiYuMUF7tS94ERwk69auWDTiCH1E1Zj3SXBDY6WwpYNZUn0q0C1oc=@lists.denx.de
X-Gm-Message-State: AOJu0YzJPfT8Tcrl95t4m4Re3d4qE5AIzZ8yvmX6enlOwDaHDH++FRRv
 zHfnD1DTKV5zPb3Z05DV1olMuYWPGoV1jlsS9I77Y4j/bFtB1IkM2LZv1RMeO3XXep9UMTvz/Ax
 hufyc+5qD+xq1tQkmiCUuMR3PebR5u0hWapz91m4V
X-Gm-Gg: Acq92OEjN4myf6MFdULYwW1IIA09HHchHZ7zU7/iyO+sQSRtqEcv2GYi2+TPnfSa+WT
 ZWmvwMtTz86yrH+uOLJVIxqLdT7u4k5Zort12+1K4dVmWtXOLUQyxzTRTuWWySrMYsav4loLRdt
 k7xkPXzQ47+sfQTRBAaCNRC64uMbxmV1ZrwBKo0ZR6c9pCIHo9AjsvQuacX5o9vCK4O2AG8EbhK
 POSsRxnQ9BGK4K2G2he42iLCajCq+YS1Nt73cGOVL9bH2CneNbu/QPLLAP7coXYgBs67Ovu90I8
 HUKcRidCHwug1Jpd
X-Received: by 2002:a17:907:b01:b0:bec:2a21:785a with SMTP id
 a640c23a62f3a-bec2a218259mr396025366b.18.1780348300373; Mon, 01 Jun 2026
 14:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260528081916.11355-1-philippe.reynes@softathome.com>
 <20260528081916.11355-2-philippe.reynes@softathome.com>
 <CAFLszTi6bciTi6AU-k6EU0LXEpJ+n4qbM-zdSQrHow4KNcD2-w@mail.gmail.com>
 <20260529153459.GA627328@bill-the-cat>
In-Reply-To: <20260529153459.GA627328@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 15:11:27 -0600
X-Gm-Features: AVHnY4JbHDd3mQzjPRQkiV_3TvvIZJPF4mU673iAmFaWsKF9YGy6Q_uuJnlXLic
Message-ID: <CAFLszTjg8cO4oAKgwHTOE_D625eL36kQ8-DAhq0kyM-wKnxnEQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] ecdsa: fix support of secp521r1
To: Tom Rini <trini@konsulko.com>
Cc: philippe.reynes@softathome.com, marko.makela@iki.fi, 
 jonny.green@keytechinc.com, raymondmaoca@gmail.com, simon.glass@canonical.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Fri, 29 May 2026 at 17:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 29, 2026 at 02:16:55AM -0500, Simon Glass wrote:
> > Hi Philippe,
> >
> > On 2026-05-28T08:19:01, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> > > ecdsa: fix support of secp521r1
> > >
> > > Current implementation of ecdsa only supports key len aligned on
> > > 8 bits. But the curve secp521r1 uses a key of 521 bits which is not
> > > aligned on 8 bits. In this commit, we update the keys management
> > > for ecdsa to support keys that are not aligned on 8 bits.
> > >
> > > Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
> > > Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
> > >
> > > lib/ecdsa/ecdsa-libcrypto.c | 65 +++++++++++++++++++++++++++++++++++++++++++--
> > >  lib/ecdsa/ecdsa-verify.c    | 65 ++++++++++++++++++++++++++++++++++++++++++---
> > >  lib/fdt-libcrypto.c         |  2 +-
> > >  tools/image-sig-host.c      |  7 +++++
> > >  4 files changed, 132 insertions(+), 7 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > questions / nits below
> >
> > > diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> > > @@ -41,10 +43,26 @@ struct ecdsa_public_key {
> > > +static char *memdup(char *buf, size_t size)
> > > +{
> > > +     char *dup;
> > > +
> > > +     dup = malloc(size);
> > > +     if (dup)
> > > +             memcpy(dup, buf, size);
> > > +
> > > +     return dup;
> > > +}
> >
> > Please match the U-Boot signature: void *memdup(const void *src,
> > size_t len) (see include/linux/string.h). Making buf const lets the
> > call sites lose the (char *) casts. Also note that fdt_get_key() now
> > hands back malloc'd buffers - please spell out the caller's free
> > responsibility in a function comment.
>
> Simon, I've noticed of late that you're providing a lot of Reviewed-by
> tags in the same email that you provide a lot of substantial and
> non-trivial feedback. This would normally negate the Reviewed-by tag, so
> can you please refrain from providing both the tag and feedback in the
> same email? Thanks.

I add the tag when the changes I am requested are not critical,
particularly when we are already several versions in. The honest
answer is that I don't really want to look at a series again :-) I am
already spending a lot of time on reviews, to help code land.

I will see if I can only add the tag when I have minor feedback.

Regards,
Simon
