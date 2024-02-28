Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7305EC5478C
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 19:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909A588078;
	Wed, 28 Feb 2024 20:52:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="FcFkHarS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC7E687F73; Wed, 28 Feb 2024 20:52:06 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC4D88094
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 20:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5131be81f12so44575e87.3
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1709149924; x=1709754724; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6CVVF6dBELaAzB/Ql8nj3Ifz3WTq5iPumxLXx4MlAWM=;
 b=FcFkHarSgjEhxc7C0t6/+r3I37gLOKBOfOTDqsdW+wt9jFV557HJVtK069/XaibURM
 NZ3IFLplnHaBHpvJFSV0vxFKRUGNFMm+/mGT6gtO0z/wIIQgA1m0cm60H4+EtE/0j99H
 O134AsN60uCLi6fwVkl5UTWK5dcAQUAMasBZRBfOc/lKGtmQ9/e/oO/b46E6ddTn9aZN
 SdvcoDYdNyCN6lykXESjG0QNHeZtw3CFo4UArF4cTZFwPzPGIs+kfhic0xhWxMLb4Bb8
 tAg8zHFv+ub2uK1hKGyAIfsGZ182VnseE0107jPEEdQhgePssTw5/VHEhSYV+fz6euGq
 0hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709149924; x=1709754724;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6CVVF6dBELaAzB/Ql8nj3Ifz3WTq5iPumxLXx4MlAWM=;
 b=ognjv3nfH74cgCMwQ7idGbG4pwv3XAbUJWWB1nqqRXA+eZqso2T7+m2iOp0kCzdlR2
 XbjduV/i30IkTQpuHsbCa8NAzl27z5lS9Ycku5vRM2rOz5UU4cMZnmGIIgGg0hyrdmmn
 /OgqY/xA2MmbKuOpzN0OpjgxO0F2/3R4bXCpYzCZPQJaIf7+YLjNlDjvKQozCY/8nXjg
 i6PfOup0s8QB/60S4YhCVET0AU9tt/o76T7cCprlx7wmBlAdsB5ETxy8CJJxqVMoY8as
 akhLQIjHvskRiUHOk6byVGMvkp5jmJ+uYEQYGhtI4w4Fsfg49pmkIHpICpHBskwR2NUz
 76vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVykDgSbDL97OdZCiU7jOijKejrx2Uw6WlMXfm+lPC4uYXkTf7TLLp55XIBwcRMLUKq30+Y2nZGhImyIdcJQ4kK8vLcMQ==
X-Gm-Message-State: AOJu0YxH3e6zmVk7249wDT7Aiz36GHGsfuU+7RVvUSVKetNwxLCpZbOB
 PHAat2ZBYRgHRK8Vgr0rcf0ciKfn0mnO3Qd9jKhyx8qfj1rxT2TwYAmJl8RKwQ5OUkrsvM2DhfW
 0dDZ+gZ/ze5WRe6mMFf3zhvv19sol6q3oJ2uTTw==
X-Google-Smtp-Source: AGHT+IFygCEwe/GGXk7loLZHnQjcMPRX0mBN4A6gMchtqtbpgXeFoYA2fGxiBSKNfkIIIl00sIyXmvxi+E9GRUn/5RA=
X-Received: by 2002:a05:6512:473:b0:513:1817:189e with SMTP id
 x19-20020a056512047300b005131817189emr407322lfd.9.1709149923727; Wed, 28 Feb
 2024 11:52:03 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
 <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
 <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
 <CAF1iuRr5CfOuKJk_SDUwurKb74vpsb_N8Ke_Gw+TLFE2E5kNmA@mail.gmail.com>
In-Reply-To: <CAF1iuRr5CfOuKJk_SDUwurKb74vpsb_N8Ke_Gw+TLFE2E5kNmA@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Wed, 28 Feb 2024 20:51:52 +0100
Message-ID: <CAL6CDMFDOrRza-O3BhKS3DnjH1TR5vb=USmBuh5fzpFyeBruPw@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Bob Wolff <bob.wolff68@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
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

Hi Bob,

On Wed, Feb 28, 2024 at 7:14=E2=80=AFPM Bob Wolff <bob.wolff68@gmail.com> w=
rote:
>
> Any thoughts on how to proceed with the issue mentioned about tinycrypt
> warnings/checks?
>
> Also, I'd like your advice - I was thinking for the larger patch that I'd
> do it in two commits. The first would be the addition of the tinycrypt
> files and the second is the actual changes and additions to support ecdsa
> verification. I doubt that's controversial. However when I run a trial
> `patman` against the tinycrypt commit, I geta huge number of issues:
>     *checkpatch.pl <http://checkpatch.pl> found 186 error(s), 380
> warning(s), 481 checks(s)*
>
> What's your advice on this? I would tend to think we'd want to /not/ chan=
ge
> the source files directly for such purposes so that updates could be
> brought in with greater ease.

I didn't form any opinion on that, hence asking.
Why not to backport existing ECC/ECDSA implementation from
Linux kernel (crypto/ecc.c, ./crypto/ecdsa.c), like it was already done
for RSA, X509 parser, ASN.1 decoder. Pulling the whole library into the
U-Boot source tree only just for ECDSA is a bit overkill IMO.


>
>
> On Thu, Feb 22, 2024 at 3:07=E2=80=AFPM Bob Wolff <bob.wolff68@gmail.com>=
 wrote:
>
> > Peter,
> > Thanks for helping lead me down the right path here.
> >
> > WRT tinycrypt, the license is quite permissive.
> > https://github.com/intel/tinycrypt
> >
> > Also, I'd like your advice - I was thinking for the larger patch that I=
'd
> > do it in two commits. The first would be the addition of the tinycrypt
> > files and the second is the actual changes and additions to support ecd=
sa
> > verification. I doubt that's controversial. However when I run a trial
> > `patman` against the tinycrypt commit, I geta huge number of issues:
> >     *checkpatch.pl <http://checkpatch.pl> found 186 error(s), 380
> > warning(s), 481 checks(s)*
> >
> > What's your advice on this? I would tend to think we'd want to /not/
> > change the source files directly for such purposes so that updates coul=
d be
> > brought in with greater ease.
> >
> > Let me know your thoughts.
> >
> > Thanks,
> > Bob Wolff
> >
> >
> >
> > On Wed, Feb 21, 2024 at 6:03=E2=80=AFAM Peter Robinson <pbrobinson@gmai=
l.com>
> > wrote:
> >
> >>
> >>
> >> On Wed, 21 Feb 2024, 11:30 Bob Wolff, <bob.wolff68@gmail.com> wrote:
> >>
> >>> Hi there,
> >>> I have two separate but related pull requests I'd like to contribute.
> >>> They
> >>> both have to do with ECDSA support.
> >>> - The simple one is a lack of null-pointer check that can cause a cra=
sh
> >>> in
> >>> certain situations. Easy peasy.
> >>>
> >>
> >> Just send that one on it's own
> >>
> >> - The less simple one (and hopefully not too controversial) adds an ec=
dsa
> >>> verify driver (UCLASS_ECDSA) which utilizes tinycrypt to do the crypt=
o
> >>> work.
> >>>
> >>
> >> Do we already use tiny crypt in the project, if not things like licens=
e
> >> need to be taken into account in the context of the GPLv2
> >>
> >> Please advise on how best to proceed. Happy to work within the confine=
s of
> >>> what works best for the larger group.
> >>>
> >>> Thanks,
> >>> Bob Wolff
> >>>
> >>



--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
