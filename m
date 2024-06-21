Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D3BC41513
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67ED088577;
	Fri, 21 Jun 2024 16:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+u8j2rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F5988572; Fri, 21 Jun 2024 16:58:06 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE3008854E
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6aedd5167d1so8631416d6.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981883; x=1719586683; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XK2lTqJt1N8PmFf+T8FRUVru4STX7Hvmj2ZRXiWg2TM=;
 b=O+u8j2rbNtvUr8oi17d2vsDcOKDGETEICAQA75wJnh9xH27SPM/J2ua+eS6rbrwuSZ
 0aBN1nQlBsCTmqxkq8JL5VPASHgCV4+CI0yhDudnU0OY8VB2vWk9KTj3DdvzRFQW2aB7
 xgBQDHLsDS4isfKIKrTWnXEvmPkm2oO610LoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981883; x=1719586683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XK2lTqJt1N8PmFf+T8FRUVru4STX7Hvmj2ZRXiWg2TM=;
 b=fu+nG6gvxuvoU4+ffp9NxRD7DjOTm/+xSoWazvk5r131sEpjPkp2z5OjK2ddpAQuJz
 JEcbEXPIVOqY1FiHSDFSKJK9lIQk4p7bnQDCgYCnIDqcurzeBpqzwEn8uC12Vh8sEdy0
 mFMgjnC48nS0j4KR138idduQl2y7LzJoEqr+LwXhBliHmAUoIEyv5jige8VYa5NdTtOp
 fKHhT1RIzkya3UL60VLJDNS/AzG84Sks3+aqmB8L0s4oR8fCITCZJi1583NqXKq5Pj/I
 DW1kqVpD+pi6KhvW+MlZzIbEJgdLibZHsvdcdzRTVoCioAqDzuU5UeRvneGF7InuCAjr
 F0qA==
X-Gm-Message-State: AOJu0YyhNKIydOa7rklTEFPiqk9U2HLaGv9dL3OakmbV0zUtzwcuQ1gl
 QQvgyCSFNSVYM8ppABhN0sqirsmELxkjdqPFsZ/nif5gwpRzrB1bTFfWsal67Er/ZK2ahZlsuxO
 ef0SMnlvA7mYIgQ+aomsnOE2zgEpzPgjiys7N
X-Google-Smtp-Source: AGHT+IFRcWOprQYBFPgwj7R0IbIs5zjOflJkuLrl3rsvl9cxyd5kMCkpbJihwb3M0TTOq4mZnbnIk8LSnGg/JpUgwMM=
X-Received: by 2002:a0c:dd92:0:b0:6b2:b0e1:e362 with SMTP id
 6a1803df08f44-6b501ebb6c8mr88904116d6.55.1718981882747; Fri, 21 Jun 2024
 07:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240620133346.1135479-1-sjg@chromium.org>
 <20240620143950.GO68077@bill-the-cat>
 <CAFLszThPrA3_B1cwcX208OFZT_GgXrHH4L5NuY9O5sDQwXKyLg@mail.gmail.com>
 <20240620231521.GS68077@bill-the-cat>
In-Reply-To: <20240620231521.GS68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:52 -0600
Message-ID: <CAFLszThac79TJzfT9fH0xi6p8DGtt8ySNRWNqwQ++dkyHS0QWw@mail.gmail.com>
Subject: Re: [PATCH] RFC: Add a tag for the world builds
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, 20 Jun 2024 at 17:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 20, 2024 at 05:05:26PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 20 Jun 2024 at 08:39, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 07:33:46AM -0600, Simon Glass wrote:
> > >
> > > > Currently the world builds run on all runners, including faster and
> > > > slower ones.
> > > >
> > > > The difference can be quite dramatic, with some builders 4x as fast as
> > > > others, resulting in just one world build taking between 20 minutes and
> > > > an hour and 20 minutes.
> > > >
> > > > Add a tag so that we can select which builders run these CPU-intensive
> > > > jobs.
> > > >
> > > > With this tag we can also increase CPU utilisation by running multiple
> > > > QEMU tests in parallel. Currently these tests leave most machines fairly
> > > > idle, since we cannot run more than one world build on a machine.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > This conflicts I think with Jiaxun's desire to make our GitLab job
> > > runnable on the public runners too, and where we'll end up with 10 world
> > > build jobs ala Azure.
> >
> > It probably doesn't actually conflict, although I am not sure if one
> > can add a tag to jobs that run on public runners.
>
> I mean conceptually at least as it will likely be slower to build the
> world as 10 jobs than as 4 jobs.

Yes I've noticed that the per-board build time reduces as the number
of boards increases. For example moa varies between about 0.53 builds
per second (for ~100 boards), to 0.59 (for ~400 or ~600). But there
are 64 threads, so we need at least a few hundred to get to a steady
state.

Regards,
Simon


>
> --
> Tom
