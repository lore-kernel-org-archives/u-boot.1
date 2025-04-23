Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060DFC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:28:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5684F81F0D;
	Wed, 23 Apr 2025 14:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QBnSJScc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B1481B4B; Wed, 23 Apr 2025 14:28:42 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7776D80F9C
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ac345bd8e13so900093166b.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411320; x=1746016120; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ps0Zmg3qyDYB//Tyc6MHtewbtuN4+YaIbeoSqEDuqAo=;
 b=QBnSJSccbvhkcUsIDdMJeIU7CPvcltBYT/M/fUy9Q7I5XyZPPZ2OtNDuB8Wtdkyh0i
 HdVpjcxTm1IW/lcxLVNJ80C93dvoDWTdLVXqgR4khwCdIvgQ7bXVY07W4CFifqrV184w
 6x7gY40J2bXkQ+qsMMZl2OR+oTiZh5Sdu8Ivw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411320; x=1746016120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ps0Zmg3qyDYB//Tyc6MHtewbtuN4+YaIbeoSqEDuqAo=;
 b=X0leUnFoeYkkuyjZUJ6f+3HDZ/48jxi9SxFJYyAHYGOaYBEi5zNj4YK9uRmKbZOXxw
 McMOGOBmIfAiazA/MnX49CSN8d3XMkuq8sC9aCEnDNJ4EaS90WTh9EJuJF9MW0Ej26oZ
 9sxswEEMU35c4FI0IcFyUCXANTNWoTSYkoFB4WX6ZxVfBfLe3FjBTpQ3pzz4rBgCqy7X
 7tZJriVONJdds/6S+XriLmQSrwD9JmTeAXwpik96T3XcHl1oYi6ucYYsSnLn4/iQKopQ
 BmpFtNBZf5x27hOlCqDroHuj7zTjZ1Smf4PaswgDRVnqmS7kqi1xkiN7whQGBcdjw4uV
 jw+w==
X-Gm-Message-State: AOJu0YwQJfmF3GoaL9qGKznB5r0wCokJyRKxPZwKGMYqv0xsrjtVoy7k
 epYOKx2A/DeoHcSjZDNbApsoPMGpkfchGFztX6DPWGkv8fKWLBpLKGrKL+BuJ4VAXC3kKpqVDXR
 Fm+SEXuSk7whA4Ft+zL5T3bcIGxwWAYPuMzxGnapFqyepsBM=
X-Gm-Gg: ASbGncveidlAtHEWWrPiFKdnB5Gt77GpdQQy4CsGForBptMViygmuczmMniiHKYZ/Ld
 vbCW1VFP+df1m6mrOgKFbT4etXxoNIgZ314DQDiOqWJwVF3yAu1bdeqsGkw7o0pcMwWL+2slE0Q
 tt4i00Vp64uwDEosu+S3d0kqk=
X-Google-Smtp-Source: AGHT+IHBHF3Is+wngvN0+zDogHDgogc96u+EnaRN2sJssf9/aCp8pa+YDZzq/na3/XIqi7L2fAJ1cEMId1aZZ+xavfs=
X-Received: by 2002:a17:907:9496:b0:ac3:446d:142 with SMTP id
 a640c23a62f3a-acb74ad9369mr1398098766b.2.1745411319857; Wed, 23 Apr 2025
 05:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjnXQu3bwWt3Do7S_Vu0UO5si4HRUeW9bv0981WbUn_7Q@mail.gmail.com>
 <87a587fja8.fsf@kernel.org>
In-Reply-To: <87a587fja8.fsf@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:28:27 -0600
X-Gm-Features: ATxdqUGYOUZUfrHcVaMVCLrSeOSAMl5dyhTn3HnD2uxO11s5xWgBPYWUxPteybI
Message-ID: <CAFLszTiThPOHm+D=Zts9QP0mm4dYHE=kAqS1LAnfF1MLmc=QEg@mail.gmail.com>
Subject: Re: Maintenance of Python tools
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi Mattijs,

On Wed, 23 Apr 2025 at 01:07, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> Hi Simon,
>
> On mar., avril 22, 2025 at 17:39, Simon Glass <sjg@chromium.org> wrote:
>
> > Hi,
> >
> > Tom has indicated that he would like Patman to move out of his tree. I
> > suggested on another thread[1] that I maintain it in my 'sjg' tree, so
> > here is a new thread to discuss this.
> >
> > I have already done this for the qemu/efi/coreboot scripts as Tom has
> > NAK'ed patches for those.
> >
> > For the other tools there is going to be quite a bit of churn, as I
> > would like to resolve most of the many Python warnings.
> >
> > Given the shared source between the tools, it would be easier for me
> > to do the same for buildman, binman and qconfig. I am thinking that I
> > might try a move to allow Gitlab pull-requests for reviews on these as
> > well as the mailing list, if that is useful.
> >
> > For tools which need to sync back to Tom's tree (i.e. not patman), I
> > or Tom could do a pull request every now and then, omitting any
> > changes that relate to pylint.
> >
> > Please let me know your thoughts. The timing is good as I am going to
> > be sending out a new Patman feature in the next few weeks and it is a
> > few thousand more lines of code.
>
> I have a preference for binman staying in the U-Boot upstream (Tom's)
> tree. AFAIK, binman is used by the CI and is also very useful for composing
> "complex" bootloader images (For example for the TI k3 architecture).
> I don't know a good replacement of binman and I'm afraid that people
> will go back to ad-hoc scripts if binman gets removed from the tree :(
>
> On the other hand, patman is a workflow tool that's not (I think) that
> specific to U-Boot and is (to me) replaceable by b4.
>
> I understand that code sharing makes it more difficult to only move
> buildman out of upstream, but in a perfect world, I'd like binman to
> stay in upstream.

Just to clarify this, I'm not suggesting removing binman. It's just
the maintenance and development of new features that I'm referring to.
We would still sync source back to Tom's tree.

Regards,
SImon

> > [1] https://lore.kernel.org/u-boot/CAFLszTg7-yM0L8uuJyN7Jpsb1LbvOYO76cUWj+H719mfc97mMQ@mail.gmail.com/
