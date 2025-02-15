Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B841CC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ED880EAF;
	Sat, 15 Feb 2025 18:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HWJ+UO+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D0380F0A; Sat, 15 Feb 2025 18:22:06 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3300780F56
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ab7e3d0921bso550450566b.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739640122; x=1740244922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=enHtP/eaVsG9UInIMxLTriRDLfueXa30XaekJlzvOZU=;
 b=HWJ+UO+1tytq67DMaaQCHC5SnI8L4kouM1XnkjuAnHOSPsGHWz6AT2gPdeIQuMqa4I
 nYJd+fu2gDpfM2HRyn09+N7b3Unl1gDmj/uVTu/fyOXqj70u+2zKvMeotR1dNA15VfPb
 0IsLfMysK8b9lV6ar43/oS2To7sAb8OGw/Qnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739640122; x=1740244922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=enHtP/eaVsG9UInIMxLTriRDLfueXa30XaekJlzvOZU=;
 b=ZApGE9SkTq/HkBIo2fyMEp1NhiVvV9obC5/JfAtSX3Zn0onTXieoOM5bdv6OJDX+8c
 29IoAAZtKfU9lMXx65o08C6etPfP8s1/u7BJwLNdi0U6R55S8tkTr38n/z6q6+9xDNyg
 rQlp0M4TgYJ1vNenHOFQyEpfwovUtZX0PINyXuP+wCGPlsE2ToPg6S+FrbZcSZOlCy+r
 RKl3GwceMZvU79wfkacqnIFHxHyVVTpkZ+GQ1BHrTvUlXcgDKHtFMhXAJwLBriwQp8hc
 PoSUwKrr4fsCyYpCMqrZA2P1tBc0nkwzfK2lMe2KbTMaNPrBxjiee4PuxmzahLW/Br7q
 Rpew==
X-Gm-Message-State: AOJu0YybhJbyiCJ/9veSwcpm0HXPG+cA2Aukrol4ElEQfy3uRPIg1io9
 /6RypXISdjUQquiNQcHHzrOgUZ9la6v49hcPQpPU5XNStSzC/tHco1erY5UJsE5Pum5ZpefJdUu
 bjtNUE/pE0stddi94J2hjVxI+oxuMJY42u80b
X-Gm-Gg: ASbGncvk3KGnSJ5ygDBUg1Po2RN4mng9kF73SuOMRFFBNVch5WI0mvQDLVT4x0pG4Jr
 chr0jcfmC1FiU7vTX+ErIhkSSta1QDIeboHvSVmk4rGZ2DIpEzL15FdL7Oyd6qGw9cHJ/HeQOfg
 ==
X-Google-Smtp-Source: AGHT+IGP3jKdDjrQso1nXAOO0GV+eO3gOb1cdOWr2Ves505TlKvJLDIhjj9n2fGCf18jIvawXbrJ6Rn0t2VimTFZLj0=
X-Received: by 2002:a17:907:9802:b0:ab7:e451:4834 with SMTP id
 a640c23a62f3a-abb70d2f6dbmr350364166b.19.1739640121613; Sat, 15 Feb 2025
 09:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-5-sjg@chromium.org>
 <20250125214443.GD60249@bill-the-cat>
 <CAFLszTiqhKn4DF0CQg7egocvvVTu_NhC4BgGaOV6j8zbDXkoxw@mail.gmail.com>
 <20250125225042.GH60249@bill-the-cat>
 <CAFLszTgc4=gFuDuZrN0LYRrN28w6QZPQRWdvKSzn4rq27RyEUQ@mail.gmail.com>
 <20250125230058.GL60249@bill-the-cat>
 <CAFLszThcg5imJQUiOccPYuJkVuQ2OmZd6K0BoLMkWj6-DPVGJg@mail.gmail.com>
 <20250215143759.GL1233568@bill-the-cat>
In-Reply-To: <20250215143759.GL1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 10:21:49 -0700
X-Gm-Features: AWEUYZld127WGqxEF0nlZYznQK2O4scC7qxS94Jg6UPdRa6uvt_lVd80wOK3ZaI
Message-ID: <CAFLszTiOd9MHmXPR9JJgrLYZ-N3N2qobT5HK5FDTf+2ox=zkkQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Love Kumar <love.kumar@amd.com>
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

On Sat, 15 Feb 2025 at 07:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 06:02:39AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 03:56:02PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sat, 25 Jan 2025 at 15:50, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Jan 25, 2025 at 03:47:26PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sat, 25 Jan 2025 at 14:44, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Jan 25, 2025 at 02:31:39PM -0700, Simon Glass wrote:
> > > > > > > > This fails on samus_tpl as there is no 'net' command.
> > > > > > > >
> > > > > > > >    => net list
> > > > > > > >    Unknown command 'net' - try 'help' !
> > > > > > > >
> > > > > > > > Fix it by adding a condition for the test.
> > > > > > >
> > > > > > > For this part,
> > > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > > >
> > > > > > > > Add a blank line to keep pylint happy.
> > > > > > >
> > > > > > > Can we silence that pylint? I don't look forward to the churn of adding
> > > > > > > more blanks everywhere especially since imo it doesn't improve
> > > > > > > readability either.
> > > > > >
> > > > > > Yes, but we would want to do it globally. But it isn't really a good
> > > > > > idea IMO. We are trying to use PEP8 which loads of tools expect...e.g.
> > > > > > my IDE shows warnings in this case. It might be better to just fix the
> > > > > > problems.
> > > > > >
> > > > > > As to readability, I'm on the fence...in practice it doesn't matter
> > > > > > much as few non-trivial programs have a lot of top-level functions. I
> > > > > > would rather keep the tool happy and use the Python style that people
> > > > > > expect when coming into the project.
> > > > >
> > > > > Yes, we should do it globally. Can we not globally also tell tools the
> > > > > deviations from PEP8? I remember back when people would argue about if
> > > > > we should tell file editors what to expect for whitespace, etc :)
> > > >
> > > > I'm sure we can do anything. But why deviate? Is it just that you want
> > > > to avoid churn, or do you actually not like this part of PEP8?
> > >
> > > I think it looks bad (personal preference) and we have that in almost
> > > none of our tests I suspect so adding blank lines to make PEP8 happy
> > > rather than adding hopefully a line to a common file normal tooling
> > > reads seems the wrong direction. But I don't care enough to not apply it
> > > if someone else does it. I'll add missing blank lines when needed
> > > assuming the pylint CI job complains once it's done.
> >
> > OK. I'm a bit confused about the double-line warning since pylint
> > doesn't actually show it! For now I've changed my IDE to use pylint
> > and disable pycodestyle so now I don't see these.
> >
> > The current Python files show up with lots of (other) warnings for me
> > and I would like to fix them. But it is quite time-consuming.
>
> Note that I posted a series this past week that, with one RFC'd
> exception, fixes everything "make pylint_err" complains about with
> current pylint.

OK, good.

Regards,
Simon
