Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4476C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 23:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 180D987D70;
	Thu,  7 Mar 2024 00:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtgDTc9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC3287D70; Thu,  7 Mar 2024 00:49:11 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E75B8792D
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 00:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bob.wolff68@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so50144666b.1
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 15:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709768948; x=1710373748; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WFAPvqKQVZvM5ur/oaLHutu6yVjXtmpzzxwPJ2DPK9M=;
 b=RtgDTc9GS64TCAeeZIOY0fZUxwvGvdXg+v0G6VQHOMjSfQjn8XW8AD0hMng4fG707y
 T6Hp859/DMVO8WGygFputIrCiYxekTkRHZYoqLip73L5mke4gEk1JI0Y5dwg+iaCBhZ+
 LjGiXkDK8IdmgkHoZNqGmX7evocclNPkW8qrNbBw/BeZk6Yf45rMazTzFUzQzN5D7goH
 3l8FvUrx9z40WNgbldQx6Ba9NwMSliq7ACPR6D/7gR+mA9U3OHf64FVSTJsIAjX3p1rg
 DS6jxnqOvYzdd4P8wf2DaxHQUXPxGJYMxQ8mNau6I7IkV2k8J6X3K7YNOYjPjfKgYLGj
 3QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709768948; x=1710373748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFAPvqKQVZvM5ur/oaLHutu6yVjXtmpzzxwPJ2DPK9M=;
 b=EYvZNJA9a8Hu+90UITkD8Kt9Qbgbh6yt9VUsIC6or45eL3CJZW++eQxQljRQcQ44Ab
 /s0TTzkMuj6ZVeN74SFpL6b3hdrI6wxoxPhezfjN0dR5xUO7jGxkQ5PU8+LKSQfjSTQd
 yFPFBCQV+NpNHuHtq+q4xpC6heCBHQ1pxGw/b9ILtSGi3T+WD/3185cOsnDXn28MgzQi
 D8f1VduAKsbenLGCHhctl9b3lKh3eYVj8r4iPaADR090/PhpJF+hHbCp99b6RhbgVWk6
 HQcHBvqnIMG/t6Xs23b/ZD+KzGqV4gyAemauK/6GTxRjgXrTd/HOlsrCmAxaai6zwrmO
 CAyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfLHM90We7OfjHQkPzNXKzrQjnxIoTvnSUBoSrWAMuR+WpezxGR0XPeo+jgzNbjzecVlcLxEz/76kZsyteGJivZs4Paw==
X-Gm-Message-State: AOJu0YyhZcTJoQWTqAPe97+J/gRg+Zw91jvjv87RXsnoF3L9yJL6r8hR
 oEfShP2Dqj4UY0RYouF/v0uIeIqBrtBLBDc2B+oKAQAzEkQliBY/az1/QNFDkNfQU3lK7fw/4nx
 b3ebreS792jzwS0oIJHj/3h28uWXPovsl
X-Google-Smtp-Source: AGHT+IF50dubo7JAymNzfXdgqZAxW7ar8Hp2GXU2RY9jrUfwCGJFcpUXAjc+jHrCQJ1MilPQIYI5yNNavOxKUvqbNkY=
X-Received: by 2002:a17:906:e45:b0:a45:bea5:806a with SMTP id
 q5-20020a1709060e4500b00a45bea5806amr1876203eji.68.1709768948326; Wed, 06 Mar
 2024 15:49:08 -0800 (PST)
MIME-Version: 1.0
References: <CAF1iuRr6q15aApGB8zPb8M7yWrUahT8H0BjDHnWRp1_Q__KDng@mail.gmail.com>
 <CALeDE9MSQwGU0JXs96egk8y8rc=f+JxtNm3U6u4Fxb8L+jWtkg@mail.gmail.com>
 <CAF1iuRqyTu5xO9JJ-8__w8y7_uQ5SHNd6wunP1sND7QiT7K60A@mail.gmail.com>
 <a7a99523-3e8d-4fde-adf4-3cb6fdc2e94c@moroto.mountain>
In-Reply-To: <a7a99523-3e8d-4fde-adf4-3cb6fdc2e94c@moroto.mountain>
From: Bob Wolff <bob.wolff68@gmail.com>
Date: Wed, 6 Mar 2024 15:48:56 -0800
Message-ID: <CAF1iuRoByWEgvOxgSZTi7g+djksK81c2FwoQc-Wy9DDgSmd9dQ@mail.gmail.com>
Subject: Re: ECDSA related PRs
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hey all,
I'm not opposed to using the kernel ecdsa.c and have taken a quick look at
`ecdsa_verify()` - but I'd love if someone could point me in the right
direction for how to set up the context and public key. The
akcipher_request structure seems to address both the signature and the
digest, but I am not seeing how to take my public key data and get it
involved. Any examples of usage, possibly? Doing several google searches
did not bear fruit for me.

Thanks,
bob

On Wed, Feb 28, 2024 at 10:57=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org>
wrote:

> On Thu, Feb 22, 2024 at 03:07:01PM -0800, Bob Wolff wrote:
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
> change
> > the source files directly for such purposes so that updates could be
> > brought in with greater ease.
>
> Yeah.  For this kind of thing you wouldn't want to make a bunch of
> checkpatch changes.  They sometimes pull crypto and compression
> libraries into the Linux kernel pretty much unmodified as well for the
> same reason.
>
> Igor's proposal about pull this stuff from the Linux kernel instead
> seems like a good idea though.
>
> regards,
> dan carpenter
>
>
