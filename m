Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D6DC02180
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A37BC8060C;
	Mon, 13 Jan 2025 20:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iIyU4Rhd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A80A80628; Mon, 13 Jan 2025 20:39:23 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D753A805E7
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:39:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so7831960a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736797160; x=1737401960; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wLPtpU3c1Cp37fYoyfwJ32JYadsMoIqywghzvsgGMsc=;
 b=iIyU4Rhdxw3omP/cIKGO20UmUlAAJiJoLRcH5sb/E4nDA8wLnNPq9Yvt9VD/EnrRlW
 BN7I4cwmhzU5mqJRqH7MTZxbwoN8jMpJ4KoM3pb8EF7b1rI4SX/q+962OrfHTR9jZ+AJ
 qty3ZxDIH6ypEwEtj0CIelIONLNQUgen4+TxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736797160; x=1737401960;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wLPtpU3c1Cp37fYoyfwJ32JYadsMoIqywghzvsgGMsc=;
 b=B4gCkiqQ+guYAc30pL/6T/AGfpc9RH2YO6/6yGV6RQLZ2ZjVoTDHjs/+e4brBotEot
 k/x5+VHEgFQrC/ggl/n+GewG3iC6KS23nI3hhgwieXg8bRk1wGog2F4kHodBzijOrbhF
 fEhHQ/wqHFiPVbQuLJ0UzrHKJg2GyCrEA0kfIxeVIKEfquHWT3e7sidEcXvkTa/A2v+e
 +aCN9WxtzhYvF78t4V4lFwjMON1msV60nZK0nifERu8TXp9Hztok1RP8/qGyvLgWy6OQ
 JBKYFWfus2nVQ6Utw36W6HjCQ0EKa2KP1bX2kuOydI6qeck2C0WYQXYaS0d2tdfwjaCs
 P7Ew==
X-Gm-Message-State: AOJu0YyqqWOzSsRtga1uEM8gUugF9DdEBjsa7FzyN5Ipcgb8I/gsYCMk
 J+gc2N51z5FuQ8t38/d7VUFExmKmiOcWx3bI876vwcO9aoZLf6ArkIYkynQA2SB6khyaiWsmjHf
 Y4bFvfD4weCBczWdka//cFbe6J6avhFb08NC0Jnf7tSXhmJM=
X-Gm-Gg: ASbGncvPorEpKLFglma73Nfg5CLK0hC+JRnxfeQAIDZ1jzGjMC0KuE3Jcz5xMesCr7/
 Wc1vLK6bVdM4SHzV25SzUpUklv47gKs+2eILh+Wg=
X-Google-Smtp-Source: AGHT+IF68H3t2fI6pU5vgluRcI+Mh7hkbgnN4dpaUOugKp7464Xq0Cpkf85SuBvT4U4d1JKMs1QFdNHHG6ZMX1kF+DM=
X-Received: by 2002:a17:906:7308:b0:ab2:faed:f180 with SMTP id
 a640c23a62f3a-ab2faedfd79mr1000317066b.33.1736797160309; Mon, 13 Jan 2025
 11:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20250113183409.GY3476@bill-the-cat>
 <CAFLszTjDx3bBwgnvB2v6ow70a4-XS-fR5UHFdFQNn7Fdytba8w@mail.gmail.com>
 <20250113193035.GA3476@bill-the-cat>
In-Reply-To: <20250113193035.GA3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jan 2025 12:39:08 -0700
X-Gm-Features: AbW1kvZNdyRW9bFarh7zbOYXpmenHkIgBYtXklzn_QETcLQ-HrdEsQgDefOLgoo
Message-ID: <CAFLszTjPdX1kORnMNUMEUdrjYmQwiVm043nZGBZEV591oXtzEQ@mail.gmail.com>
Subject: Re: [ANN / RFC] Regular community calls?
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Mon, 13 Jan 2025 at 12:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 13, 2025 at 12:10:35PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 13 Jan 2025 at 11:34, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > It's been suggested again a few times recently that we should try and
> > > have some sort of regular open call / video chat as that might help
> > > clear up some issues. To that end, I'd like to propose we have the first
> > > one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
> > > after the v2025.04-rc1 release, and I'll include a link in the release
> > > email. If this works out well, we can make it a regular thing for the
> > > day after a release and also try rotating the time, or having a second
> > > meeting much later in my day that's at a better time for other parts of
> > > the world.
> >
> > So do you mean the first one will be in two weeks (i.e. Tues 28th January
> > America/Europe, Wed for Asia?)
>
> Yes, thanks for the clarification.
>
> > Here are the running notes
> > <https://docs.google.com/document/d/1YBOMsbM19uSFyoJWnt7-PsOLBaevzQUgV-hiR88a5-o/edit?tab=t.0>
> > from the previous series.
>
> Meeting minutes are good, but perhaps we should send them out via email
> so they're more accessible.

Yes, I think Google docs has an option for that, but it would need to
be in text format.

Regards,
Simon
