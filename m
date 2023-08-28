Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BC5C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 21:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5F18647F;
	Mon, 28 Aug 2023 23:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="coJGTX76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C21786482; Mon, 28 Aug 2023 23:52:46 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C717086456
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 23:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpewhacker@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2bcbfb3705dso56542691fa.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693259563; x=1693864363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THWex494xl73pru4OAcFD+SewB1I/CAZsz8epWI6tag=;
 b=coJGTX76u1k1qpeKvl/OpPrji8QYNtXsmRGhQOC7CP4nLCY7M1OdXIJBoggoVBfw0I
 BYDYh3KHBaVgoaBGnmANBRt880SuMjB89mib3M3RWVBK93DcEAnnLaYoZUul8O/jYkrN
 q8BhjYvq3jQ4dx6eEdvHjRiApc4mYuqHBqtkidJCU0ijukWbI4IDMlcihca6Rve/Qn+b
 Tmf7McZPoLp2u14SyhvbVYT2xVe8jTcraAPq5cuGzZ6ZFouAF5KAXbCvvjNPpJd5rqwZ
 9u2s3I09NmbkK0+I92U7QCNjk9Qg1/8EZW1W35bbFhX14Uk0YwntJP6grTpNVNH07MEh
 Mgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693259563; x=1693864363;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THWex494xl73pru4OAcFD+SewB1I/CAZsz8epWI6tag=;
 b=SH5j2Q8hV7oX04BDJD9hkmTtab67JqJ08Gye8R1tduThOVanSmOES5wUgNIsJZMH6p
 FfYtdXjo/Ze/Q4XkDkUZqwiDy+utK7AOdAuyjpdibxm6RiiaZgWnWCJehtXqOU7bjc2q
 HDM8RMcmIoH+CiRgAyXcQY6sz2JEo6D1RyYNlrldyMlVPftUHnllipO6IDcn33SbwNxM
 jRXTT9EfK1KqPwiTOntwXYeAGZa/psOmnvdcv+ysSY5DlI4jYPmrwDacwmq58J/DE15U
 2gDOzu5O11Is2JDD3n/sG+Q/vU++5NqY2fHnpe64zmYLCi57FDAkc7TS5YpeiXmAP6JP
 aUzA==
X-Gm-Message-State: AOJu0Yxy2n2QW8RccJK+Ebs6iRvHe3GULwx/5nOZ6tD6fWnug+Qd9Yi/
 bPSpNwCpTdHYCvdEME/xVOcs4Mx46MHENig3XYw=
X-Google-Smtp-Source: AGHT+IERymDDTO9SpceTVq22XfjXJsuXuGuT912sN6dKMMtV15REFE70AMks2A4i6HSJXNsO7t8rUAS3DYlxCRoIqHo=
X-Received: by 2002:a2e:9818:0:b0:2bc:db70:b563 with SMTP id
 a24-20020a2e9818000000b002bcdb70b563mr11888508ljj.32.1693259562826; Mon, 28
 Aug 2023 14:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230823164755.2874792-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-1-JPEWhacker@gmail.com>
 <20230825193830.2753640-3-JPEWhacker@gmail.com>
 <CAPnjgZ2Ko-eEJbwdK70G8HNzTahmJdkiHsT0Cws+ZWUP-scWCg@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Ko-eEJbwdK70G8HNzTahmJdkiHsT0Cws+ZWUP-scWCg@mail.gmail.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 28 Aug 2023 15:52:30 -0600
Message-ID: <CAJdd5GZ+AenQL_GtNMWPb3S3jKzLbn3AcvYF5y5ZoCJ28CL8yg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] doc: Add gpt command documentation
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, Aug 25, 2023 at 5:53=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Joshua,
>
> On Fri, 25 Aug 2023 at 13:38, Joshua Watt <jpewhacker@gmail.com> wrote:
> >
> > Adds initial documentation for the gpt command
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> >  doc/usage/cmd/gpt.rst | 141 ++++++++++++++++++++++++++++++++++++++++++
> >  doc/usage/index.rst   |   1 +
> >  2 files changed, 142 insertions(+)
> >  create mode 100644 doc/usage/cmd/gpt.rst
>
> I don't see a change log?

Sorry, I didn't realize patman was a thing until I just looked now;
I've just been using git send-email, and I'm not really sure how to
switch over to patman now; I'll start with it next time though.

>
> Reviewed-by: Simon Glass <sjg@chromium.org>
