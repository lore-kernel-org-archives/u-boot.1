Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D7CA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 12:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55F7D60666;
	Fri,  2 Oct 2026 12:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bp074_Sq3RdU; Fri,  2 Oct 2026 12:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 79446606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790945867;
	b=fspag0qWKUq6sjRlij5yTHmz+WVMZUCeqJqcEWGMgEex3WX4OgcRSAk33medTedZhOcs
	 ureMjMEmI4fusxDh7bbYSyE27CHpWgFR8KwgN9k9meQppzLeDtpwkbUsPUrtN6ZHQ3KwE
	 7gqc1k0EHQ8jiYUHJwVcstWgNCsUOMcGXJAaVLsXZDZtzKxOcK3vhgomYpB5oSjx5s3no
	 xAWJcGoW2nAw/9ZMI2NtmvA6OdilY7lU39rH1mWIeH2LnkhOa0RibpUqEksHMGrNNMLhx
	 Xr1FvYB4ix5XGP060Jrpbb6ubIfYqsE1i409o4SFcN7AnihmyZRKmMzX8N54HjT7www==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790945867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Aq/eTYM7l4HfOcragKzRIfKRuWjt99Dl+J6Nq4TnFiQ=;
	b=EQMqK9CJ49wFiYWWD8OnJHXzoWG417A8bL3RoiUJQzWklh2faUkLnxelAWqsw8phjyMK
	 +zK3iB6Wg9kNYPAha2I+YDEelooJP3Je6+X7dluH/bMh6LceGUPupKLQNsWMKIUPLSMKB
	 Gq9qhqhA4DqB4ASVDGnSEucU42EHQW0VbmV3JyfOyHPRiJfGF/gkZ0hSn5A1Kxc/f33fL
	 ruyzcrWDgvX3s6B6xzl8WX2rMxuExPP0h7s2PKtObh8KuezORosNwSXvueltetaeZaItb
	 3zL5j1+Lk8i/ozCqFzTdHQZ0Y7VhGz7r6C4uRTfu4z/DX3VdIYBQsQAta984KxF5Jfw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790945867;
	bh=Aq/eTYM7l4HfOcragKzRIfKRuWjt99Dl+J6Nq4TnFiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E1ZC5ul16auEEQoAOspfSNlA6lEliMaWWJxdK91YE1yG1/CSXjwkXX6pxRfEfqZxa
	 kJalt1VLIKNk3cidw9GUUPROn7xq6txAhvorZjxQyZwnx7mvTwkHUsUqUHHvxF8JzN
	 0CW9qDfW030KJrYsx9bvscV/az7eZlCEcg6kYqqxukZ2rUq80v/td6aKfJVgdvNude
	 5jbsldhtxrJ7+QAU3WCD9gKBwqiGo67A4y8AT6Ilwv1Iy4fbglrTfTlHRteVkXuqYr
	 2t8dynqPzbOvDiKaXChLQnPfqIkVTpi4NUki/VTaZ5XCoqc8F9jIenhegAd1xzQGJs
	 FY6x4dtxCN2jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79446606FD;
	Fri,  2 Oct 2026 12:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FCB73AC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 12:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90EDC80E0C
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 12:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tX0GVZIrsRH4 for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 12:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7936780D50
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790945865;
 b=muOCDhzPOR+oNd95m5XKmWptadtcZm+npjcq5McVYQF6JOyBnlAvZQVM0kGyxfJl2vV3
 VopHvqRVUKoOi4cAYcQvNoJ2N8mZg23KGevBGsyLqqSOvn7FHc52xd5QPb2v7EmV13mPn
 1ou6D8xsuPhAuapx+xf/69Pj9rNio21uZc2HOpUB70Coh2TlM0nCuMVrBwQP0OHvw83KG
 iWa87DW0PBH5J4dJw7iGdrzfRzzZUX5yYd1ZgLMDgpbmxzh+vaOKofoqCC2Abq+UB9nK7
 C1eAgrC4iqxDhPppzfI7TUo1GuWqMbJg4SiGrfP0KRevQYSxT2oUUr+vt1bs3gezlVA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790945865;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Aq/eTYM7l4HfOcragKzRIfKRuWjt99Dl+J6Nq4TnFiQ=;
 b=a1gljnAhYwPvev10aUmB7YA84E3XU+4iK7+wJ6+LviOPG/BJMWu/AjXOrusU7V/ATMxZ
 Nnh0zgilupHCWQIplHk4PWHXXrvH1yEvCLhu3xKcQomZcuMg6en1MPiwZ58rce36NtXZI
 Rquq+HABXnOJ+mCXAfKf3IzSL1Otke6OMIWq6EOTd+G4eUtMvx9Nype0/I+iTO8uhnau4
 hyC/DI4goHJ/h17vLWxdP/ZVhQVa4WOqazWpzXbzH5YDw9I+ho3uehE/aZBVMJzBt70Rk
 USXpjgwF6qsdDrS0w/zKItzzT4bj3TsstuKx1ZpqER1JiquXYbn+ROahPbaaBEaQtsw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ubkNavWv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=ubkNavWv
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7936780D50
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 12:57:44 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29703cb470so2546566b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 05:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790945862; cv=none;
 d=google.com; s=arc-20260327;
 b=Ka1EeFMWxKuUJgHHJMGsIzJlunv0oxNk7pfqaPSs0tOJ4UkzghNmbi8YLAQ20DpDIi
 qFbqywi9SC2asRbdaH+Mw96OJuDvfGti+ivv4fCPtCaCWrB/a3JROinzjunwZYGr2y8I
 yuKLXgaH5vhQgNm+DpXfrm3Q23EcsxLtOal0B8/fPSgN28KFZlJpmxrB0MoV6eUlcWcr
 LBd4yoxVlORIsgP6e2PTkFYskxIYU1vyYzl8XZPfER/noe4hp0VUp+bEvlc6KtV0ZR3N
 IySYad9Ub4ZMspLW8qgBR4EQy+LJrW9tYKIC1TJetG3PfwyFjX0iK9bap6AHzLuBx22J
 Gw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Aq/eTYM7l4HfOcragKzRIfKRuWjt99Dl+J6Nq4TnFiQ=;
 fh=k9kY7a1Wi14n0cNiG9IiAoGAT2s4BttBHc0XPc+Ktys=;
 b=a1c1n91BXz6UY3Vr2F4FGRFrOKYWIEF4Ttda0we47YGGsU0DJMaEkwi6T+RJwjSYqW
 L3DkVzKqoQaB3mFXP2lmq27S6mF4bvFeBSWGH2XUsHdxchJ+ixiQLnhWPCnkapKoy8PE
 Qt59IIR6E+s621WJSPPLQuKd2JAjOMEn8b5Ke3eW3/Hvlk3dYYAZ/hMswySzKFeOs2AB
 7JBPrC2MRvqTvq9V8/kbOs4bUZ7cQSZQyJY5U6akTH0Ra3Z4dZXDbaYMmMqTor0/mqvR
 Xzy962EATLSwhto+Qgty3fBlp3pPOwGzJIEU0bx7nh+thoa3dH3jEFl63NyKBVTJ6uPE
 IOOg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790945862; x=1791550662;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Aq/eTYM7l4HfOcragKzRIfKRuWjt99Dl+J6Nq4TnFiQ=;
 b=ubkNavWvHtpx76OahQfNJ6te4P4RucnWskC3iU7EcX8BWPpszzaJuPUpqYQ5j/PuKu
 XmGerYRHmGkAjv2XvVD9uVBaAlqXCBrraeID+A6FYGWZ+FaOCTxFMufnCNjThQAoejmN
 LbU6tSPpAi+V4qj+B8d3Gwm2aPmj5Ugj+1y4ij+zg7WQ54J6IbGf74GqvtJwk+CmFPda
 OYSodUwxLoISb39Ea4CpyHJZ1x7Sr3kpOfZ5/IgopBPeWIjc4sBQAysDNq3EnwGWhMfS
 HB2wL1bRNR5mFSzi0h3cXh++WMVeWTzTd/YXujPf3KZF9TstsPpoGgk9i+ZaHZ+8ecFN
 x4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790945862; x=1791550662;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Aq/eTYM7l4HfOcragKzRIfKRuWjt99Dl+J6Nq4TnFiQ=;
 b=GRRFMsXNd3o+hU2o5pWtywmQN6rm8rzG23YTbBK10gKDI0mlAWJh8uWkIaJkVp5GzT
 crePaPKe1J6BulXtpbZZrj5ZGruu4aLz+e3kVg+1mfEKeI6pgtWupAnHPuPCyIESViPx
 FlMVW7iJehSZ4Psou4qJTX7C3WYnkbhGXPEXtbiTt9rWsk7od1AiwzUQv+X5n5GM7MT/
 Gl4Tnk1G4aGVQ5qq8gAvtIbSoYaqOzKO5JCMtksaMakFNvz3MDMT0otY2cO4CmwSGrTe
 K+SEs5b0yqDEtqaU9QGSSESZuAZWiKSGbYwY5iJsr1bN3Ya3h47gEkPr1pYSAPp9fgFa
 wpxw==
X-Gm-Message-State: AFuF++nH1KOpd63n9cjtPxCysovPG897qTdDBo8J9H3O/tjU1i2I7sn9
 PJ0AVw76sMcXCrEBF6VJWF13EEvtl8OKS7Meaw3yG6J5roClKwKiJEpKN6U+G56jCm8BjOVS8AR
 4/Ph4PbjXdYnQkuF0HsiT4snHZAN0auNeXB6bHAIejQ==
X-Gm-Gg: AYBFou2ToNOp3qEzq9gKNMpyq9uZvAIrSncYhBI9ivKcg2o/1LlTcQqAKtP3rJWYZ/K
 0AMUlClSFejMOJtfd6Xxf5IjLW4Fl38HlMu8xYAQvet0pEV8qrX+y3zXZvC+bSAQFm8TBrk8Dbk
 GS1iHFUrj6pxJZy1HeH/b7NDAO7p8N4lBRZG/cvvxxsN+UkkyvvFzlNIKSPDiwvObtyslc8EwlL
 OOItOAYtAaqnUop9FdrfT/xXeu/J5a28cSf15Qy8gzZNKCKdn3YTK11wT3u0X0CLoJXs0nJDeYJ
 o/wY6kIE/VhmWSQZzEbGJ8NMEMKcnaaK1tHjdY8zID+sutGdJ9nA933JA9LgyqmLRLRU7cHyTjE
 qddE0Zhgmb2zJ
X-Received: by 2002:a17:907:9407:b0:c2e:3abd:aadd with SMTP id
 a640c23a62f3a-c2e4af4fce9mr219916766b.37.1790945861794; Fri, 02 Oct 2026
 05:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
 <57a4b7b0-2a4e-40c6-9680-de942d5fef65@cherry.de>
In-Reply-To: <57a4b7b0-2a4e-40c6-9680-de942d5fef65@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 2 Oct 2026 16:57:30 +0400
X-Gm-Features: AclHuK8vbbvhOIUyHM-3YrABaja8TRqQ49iofG7JISzL6t3YTM7bf5Qj9hB6m4A
Message-ID: <CAKTNdwFKEab4UNX1kMpjpfzZ5zaWjEfwpSUH6rndnsDycMYWhA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] spl: fit: Decompress any supported algorithm
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Quentin,

On Mon, Sep 21, 2026 at 7:27=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 9/18/26 12:52 PM, Alexey Charkov wrote:
> > load_simple_fit() open-codes gzip and lzma in two places, so a FIT buil=
t
> > with any of the other five algorithms image_decomp() implements is
> > silently copied to its load address without decompression and jumped in=
to,
> > causing a hang with nothing on the console to aid debugging.
> >
> > Call image_decomp() instead, which can handle all compression algorigth=
ms
> > enabled in the config, and will abort on an unknown one instead of tryi=
ng
> > to silently jump into it.
> >
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   common/spl/spl_fit.c | 27 +++++++++------------------
> >   1 file changed, 9 insertions(+), 18 deletions(-)
> >
> > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > index e02c746af5d3..9a93487bf0b2 100644
> > --- a/common/spl/spl_fit.c
> > +++ b/common/spl/spl_fit.c
> > @@ -6,7 +6,6 @@
> >
> >   #include <errno.h>
> >   #include <fpga.h>
> > -#include <gzip.h>
> >   #include <image.h>
> >   #include <log.h>
> >   #include <memalign.h>
> > @@ -260,7 +259,7 @@ static int load_simple_fit(struct spl_load_info *in=
fo, ulong fit_offset,
> >       ulong load_addr;
> >       void *load_ptr;
> >       void *src;
> > -     uint8_t image_comp =3D -1, type =3D -1;
> > +     u8 image_comp =3D IH_COMP_NONE, type =3D IH_TYPE_INVALID;
> >       const void *data;
> >       const void *fit =3D ctx->fit;
> >       bool external_data =3D false;
> > @@ -364,8 +363,7 @@ static int load_simple_fit(struct spl_load_info *in=
fo, ulong fit_offset,
> >               }
> >               read_offset =3D fit_offset + aligned_offset;
> >
> > -             if (spl_decompression_enabled() &&
>
> You remove this function in the previous patch so the previous patch is
> breaking bisectability. I'm guessing you want to replace it in the
> previous patch with CONFIG_IS_ENABLED(DECOMPRESSION).

Right, thanks for spotting that. That was a somewhat careless
fixup/autosquash combo.

> > -                 (image_comp =3D=3D IH_COMP_GZIP || image_comp =3D=3D =
IH_COMP_LZMA))
> > +             if (image_comp !=3D IH_COMP_NONE)
> >                       src_ptr =3D map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR=
, ARCH_DMA_MINALIGN), len);
> >               else
> >                       src_ptr =3D map_sysmem(ALIGN(load_addr, ARCH_DMA_=
MINALIGN), len);
> > @@ -429,25 +427,18 @@ static int load_simple_fit(struct spl_load_info *=
info, ulong fit_offset,
> >       if (CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS))
> >               board_fit_image_post_process(fit, node, &src, &length);
> >
> > -     load_ptr =3D map_sysmem(load_addr, length);
> > -     if (IS_ENABLED(CONFIG_SPL_GZIP) && image_comp =3D=3D IH_COMP_GZIP=
) {
> > -             size =3D length;
> > -             if (gunzip(load_ptr, CONFIG_SYS_BOOTM_LEN, src, &size)) {
> > -                     puts("Uncompressing error\n");
> > -                     return -EIO;
> > -             }
> > -             length =3D size;
> > -     } else if (IS_ENABLED(CONFIG_SPL_LZMA) && image_comp =3D=3D IH_CO=
MP_LZMA) {
> > -             size =3D CONFIG_SYS_BOOTM_LEN;
> > -             ulong loadEnd;
> > +     if (image_comp !=3D IH_COMP_NONE) {
> > +             ulong load_end;
> >
> > -             if (image_decomp(IH_COMP_LZMA, CONFIG_SYS_LOAD_ADDR, 0, 0=
,
> > -                              load_ptr, src, length, size, &loadEnd)) =
{
> > +             load_ptr =3D map_sysmem(load_addr, max_size);
> > +             if (image_decomp(image_comp, load_addr, (ulong)src, type,
>
> Because type is only assigned when
>            if (CONFIG_IS_ENABLED(FPGA) ||
>                (CONFIG_IS_ENABLED(OS_BOOT) &&
> CONFIG_IS_ENABLED(DECOMPRESSION)))
>
> we may pass type=3DIH_TYPE_INVALID (as initialized at the top of the
> function) to that function. I know because I reverted patch 1 in this
> series to see what it would print and it printed Invalid Image instead
> of Standalone Program. I'm not sure this is an issue, but it's for sure
> a bit odd.

I believe switching the initializer from -1 to IH_TYPE_INVALID is not
warranted after all. Without that, your test should print "Unknown
Image" instead of "Invalid Image", which probably makes more sense
(nobody said the image is invalid, because nobody checked it without
the CONFIG_IS_ENABLED(FPGA) || (CONFIG_IS_ENABLED(OS_BOOT) &&
CONFIG_IS_ENABLED(DECOMPRESSION)) combination).

I'll revert the type initialization to -1 in v3.

Best regards,
Alexey
