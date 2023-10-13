Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDDBCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FDB986E5E;
	Fri, 13 Oct 2023 17:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gf37WI70";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D3586E2F; Fri, 13 Oct 2023 17:49:30 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E7B86E04
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a645e54806so354355566b.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697212167; x=1697816967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0bnZkslZSjlxIynQ4E63BQI9lu7vMywc3+6SEq/rveY=;
 b=gf37WI70XPf64/q3zdvg0LNTEPg/IwXg0mRNjNbPnhS2NXMES8Op/uuUEBIx6JznY7
 kr7Un7Hh5UlmUzG4/5EtCCC76Wt9Wev75zihErr2uHoJxSJX8GILtfLPy8nYVoUNwSoL
 T0aODZikQJE4ifY1NvzF/e8QbDdAHTPbIS+RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697212167; x=1697816967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0bnZkslZSjlxIynQ4E63BQI9lu7vMywc3+6SEq/rveY=;
 b=BalA8tUhinsAXKFDjJA2bnder7K0ivSRGY7r1us5T3CAHeepl62iVEEa//04eZKmgi
 5ZgxjxS0jRh2RLbxSBlA+aWQwhfr6qgstmGCpzvN8gCmT+Epqct1+ORws2jEurzvxa9P
 1m59bOy2LHbwIGEhixu2RdtYwBX6/lWeATyO211rs89BEOfs7g8jBKzMoKdRJLuKT5Mu
 E/ab1g1UK4mqoNZ7MnemSR7Ub7hZDR+5cPR13zBPl0i/2HV4sbb/5WlXK9qjG9L4Yq6s
 qSqp8M4B6fZlcIil+uNS0hm5FI2pXeqsJlpnVQjgYk2OVPpNXE6cAlhdGw4QJ0GJYe6d
 Yosw==
X-Gm-Message-State: AOJu0YwMrFF+u8aLbBB7+5kpqKA54E5UcPCOXUKMbd8TNuLUs5M+v8Kt
 VU9xAtwUaMUBK1vwVuFSP5JXlxGnh5Yt+m4mGDqSaa0NemHSW8BjtnY=
X-Google-Smtp-Source: AGHT+IFCinG0lHv9DaS4aDy7YtemKL4P6SP7d5B81TN05KfBLVNG8oYtrUBm9ODleK0C/2fBiPI9816bFa/gT3hnPPI=
X-Received: by 2002:a17:907:77c5:b0:9ad:e180:16e3 with SMTP id
 kz5-20020a17090777c500b009ade18016e3mr23540923ejc.37.1697212166692; Fri, 13
 Oct 2023 08:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230359.2005249-1-trini@konsulko.com>
 <CAPnjgZ0dHBBAAYLx-jLr7nHSMBcTonH2cHgMJpb1KasbY=V55A@mail.gmail.com>
 <20231013151614.GK3119521@bill-the-cat>
In-Reply-To: <20231013151614.GK3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 08:49:13 -0700
Message-ID: <CAPnjgZ3+u+oBe-fAdB1rhH6WdC3qSudgSGME1frqy9DVWFMs+w@mail.gmail.com>
Subject: Re: [PATCH 1/7] checkpatch.pl: Make common.h check boarder
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

On Fri, 13 Oct 2023 at 08:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 13, 2023 at 08:15:00AM -0700, Simon Glass wrote:
> > On Thu, 12 Oct 2023 at 16:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > At this point in time we should not add common.h to any new files, so
> > > make checkpatch.pl complain.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > >
> > > This causes a bunch of patman tests, for checkpatch, to now fail and I
> > > don't really understand why, at all.  And that was before I added a test
> > > for the new error, which I had hoped would clear up the problem.
> > > ---
> > >  scripts/checkpatch.pl           | 8 +++++++-
> > >  tools/patman/test_checkpatch.py | 7 ++++++-
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> It can't be reviewed, as I can't actually apply it, as it causes CI to
> fail as patman tests now fail, and I don't know why.

Well the code looks OK to me. I will take a look.

Regards,
Simon
