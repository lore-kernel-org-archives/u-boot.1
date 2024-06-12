Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30049C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C27F88871;
	Wed, 12 Jun 2024 22:24:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FD9OCCE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C5A8887A; Wed, 12 Jun 2024 22:24:41 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7791D88863
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6ce533b643dso204427a12.3
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223877; x=1718828677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GnXTfdsHuRONW1Pw5spYDnwyf0eiNoFrlbAQKdsdQYk=;
 b=FD9OCCE2JdibDeFhDRL3veWb3JRgYBlQSlozUp4ceumAuBGCRggpLIqk8jkj/lRCRn
 vcqiVVgs8W7fgLGYel+ZyqLwnfmeh1leLPieLsvfQFcolcRVQ8xgmLfGUdWuD9hvY/7N
 lBKAgbj7jP3H0u5RPaik1a0rPZvB2TEUcIKkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223877; x=1718828677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GnXTfdsHuRONW1Pw5spYDnwyf0eiNoFrlbAQKdsdQYk=;
 b=HLqWAj/uGa5VZ0Km+e2kTHj3Sf1BmXb16XN8w4gPIxaDHdBZZy4Vx0wnyUysTHLCvj
 YnlF9x/AZ19gKpzV5FnmhTVW5FkSf0qdWXrNAA8woHcgKV6XV2pwFWEX0ecn5ki+t3pT
 UnmHt9p2iClBfa8GNr+obVqenlMi7vgt4MdYKLhHNbjSqoZoJi8JPoj99gwFyFRAKTYr
 gwoow4onD6qUw9dLuTwKDQ+Mj1CnT3HQnQGA7u6H5c0peYz+KtvOy3UGdpWpCNIcdyZP
 mfrITJHqRP+9t3/qswFs5jXxVTZ6635hZwGcYBIltEKVnlrM82PbmoxFySP07oDdlaj+
 YECg==
X-Gm-Message-State: AOJu0YxvGUvgdQJoBYK9SgGyuGIqEF4tPV+uOu8eR63iJBagbjPgykqx
 fEuhpmA1QfNSDkLPB3OD/92eO1BA/kc5uEhKEIzAdPkczvnH4wF4TtOAazDpUAl1KLEPDmclAy9
 qbhIIiBE55Hbv/fJMeQB9GiItLo5W6cUpyFDFn7b5GNB6w+Y8jA==
X-Google-Smtp-Source: AGHT+IEmqdK56llfY4/+VLoHpmN0XA3bhxY8LhHyiLsAe3zyhTT1WgMjTkHpupCz9xOchKI6Kz6pvI6PgrUHRx1Znzo=
X-Received: by 2002:a17:90a:130d:b0:2c1:9cd4:665b with SMTP id
 98e67ed59e1d1-2c4a7650f0dmr2893597a91.28.1718223876877; Wed, 12 Jun 2024
 13:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240611200156.2245525-1-sjg@chromium.org>
 <20240611200156.2245525-24-sjg@chromium.org>
 <20240612160257.GA68077@bill-the-cat>
In-Reply-To: <20240612160257.GA68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:23 -0600
Message-ID: <CAFLszTjgD_9-qAeXER=DGwYkPGS8ZO6_RRYThu-OKzB2cxj-kw@mail.gmail.com>
Subject: Re: [PATCH 23/42] test: Release board after tests complete
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 12 Jun 2024 at 10:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 11, 2024 at 02:01:37PM -0600, Simon Glass wrote:
>
> > When a board is finished with, the lab may want to power it off, or
> > perform some other function. Add a new script which is called when tests
> > are complete.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  test/py/u_boot_console_exec_attach.py | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
>
> Given that all of my wrapper scripts include a "turn it all on" and then
> catch for "turn everything off", this sounds very handy.

Yes I ruined some batteries due to lack of this.

I also added a way to tell Labgrid the end state to move to, which
also manages to turn off the board, unless something goes wrong in
Labgrid.

Regards,
Simon
