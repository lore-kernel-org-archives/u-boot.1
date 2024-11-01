Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9052EE6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF341892CE;
	Fri,  1 Nov 2024 16:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RtBjAUxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79713892EA; Fri,  1 Nov 2024 16:34:05 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82686889A2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c935d99dc5so2826874a12.1
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475242; x=1731080042; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PHW07kmEIM5I0vN4S9smZNBJhihsFwPnsFjgZj6eTg4=;
 b=RtBjAUxi3zkL8Sx2F45xR87/B6Iljg1iUfRNXBlKdIHhxOdsswS5teWqu/HaeNf73e
 GzP5/49KwsqsvuYd4TZ4CcTTdzN8SkB6nGLv4dQMVSrpAUNxMOLgjYuDwHh5LFVOH9XA
 olM0YcsVsOjF/fof+KfY97WjfeNddqHG9YFWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475242; x=1731080042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PHW07kmEIM5I0vN4S9smZNBJhihsFwPnsFjgZj6eTg4=;
 b=oG8lS5J+5yOCnyrMh2/MeJpKMW97Zggu1WU5oyugjLQFnQKO2xUxbw7Ati2QGLz/3j
 +ek92F664bO73iwNjCfH0p9Pw92bs9H3N5bfiCLp1YfxLuWZBBOJwjqtcRBAQb23g1vZ
 lcfKwS7kSPRXL2GBtj4FwHgcom5/MNoS4d3Xgyuxv/uLWTPsO8o7jG7NJQopECMwneni
 jetR/QgyVE+P+o2Pl8givRa4o7Iu6zeE6CWHTxSEImJmppft1bK1rmLYf+ijlGZKp41x
 WYI4fbsZpkMWwr6Lxt1gYmIPg9UV5VHM7LGs4ikjsi3Z9WBVRHhkMXzQ73ek2Qt72B5y
 2mJQ==
X-Gm-Message-State: AOJu0YxfLaHG0MaZK8mJIOVaZctWhSBA8kbDF9hogToGZypCujQPFVoG
 71YeXYc8ymKj91cn1fIyWOxCYj+vjtYtFtdXI4cUhMQvpJlsuMcRZkB9OK460BQ3Lgt4lkpYIpj
 JAK8ThvZLtvcjJYlOa4LnnvL1+tDmdFhiEPDw
X-Google-Smtp-Source: AGHT+IGU+RKnFF7kuT8v8pI0owSmnEqKf3xAMH9h7Mh+Pnb08zsIEPda8/gPoACEhS4pg3cYz6pHAW86MKMxiFXrmlg=
X-Received: by 2002:a17:907:7ba1:b0:a99:509b:f524 with SMTP id
 a640c23a62f3a-a9de6331190mr2038466466b.57.1730475242378; Fri, 01 Nov 2024
 08:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-3-sjg@chromium.org>
 <20241029235303.GC2558755@bill-the-cat>
 <CAFLszThVsDEaFr2EYbfBi3u+MLp5D+OW7HkQKAgeJaAoei6gAw@mail.gmail.com>
 <20241031183416.GC3600562@bill-the-cat>
In-Reply-To: <20241031183416.GC3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:33:47 +0100
Message-ID: <CAFLszThHJ8vbL1qsEoL7sh82TFftcVL9LPn14685i-ybkHq9Pw@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] test: Release board after tests complete
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

On Thu, 31 Oct 2024 at 19:34, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 07:00:14PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Oct 09, 2024 at 07:51:36PM -0600, Simon Glass wrote:
> > >
> > > > When a board is finished with, the lab may want to power it off, or
> > > > perform some other function. Add a new script which is called when tests
> > > > are complete.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > >
> > > But please note I don't see an up to date version of the
> > > u-boot-test-hooks side of this which would include the release wrapper,
> > > and presumably files.
> >
> > Please see my patch from late August "Provide some basic scripts for
> > Labgrid integration"
>
> Yes. There was quite a long discussion on patch 3/3 and I'm not 100%
> sure where the next steps there are on what the next iteration should
> have. If the release script was it's own patch then I believe the first
> 3 patches could be merged today and then that leaves the actual labgrid
> stuff that conflicts with my setup to figure out.

I tested my patches with my non-Labgrid setup (pyttest, tbot) and it
still worked. That's not to say there aren't problems, but I am
hopeful that it will not affect you.

Regards,
Simon
