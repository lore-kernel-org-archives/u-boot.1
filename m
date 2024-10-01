Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D4CE7CE3
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 07:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71D488BDE;
	Tue,  1 Oct 2024 09:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Db+jJopK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD85088C9C; Tue,  1 Oct 2024 09:49:53 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2D49885D1
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 09:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c71f1396e4so6634494a12.0
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727768990; x=1728373790; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aw29kNnX+uVxx/WlyKqFfWgdoa2DDQzAPKtMdh/VmKk=;
 b=Db+jJopKLsij9KcF1QToVfN6Ft2H4FSMgJu8oZowtvle3y4lWbuzishNQJ9DJKUtpu
 1D8OaeORMUMoc2sUhrj292u8RlLxPVNW/62+GggjzWJdIw7lhtJBiEKP2prKlHmJuHi2
 pbhEubWR9apfevjXVmv4iHSRWxS1y5EN0gQfiE3dHSUswDQ4TpcIejDJFAQWdI7T5nsr
 j9CAgGx1eXuPJZjpJwl+36FaFBx2EsuNNKMZksTFUxEYfPMLgb8Xl9KgXNevPXfRw6IC
 CiXkCPwBjHGhNAKejNyuX3x/Pkb1efuqKlO/uePY4m+XpHym3T1uf7pOe/u652TuqYqK
 hIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727768990; x=1728373790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aw29kNnX+uVxx/WlyKqFfWgdoa2DDQzAPKtMdh/VmKk=;
 b=d04077g3nHx+zv58EHc/42/UupGe5QVsCphypzgpOeDPBOHyHEh9nmlCpa5YknN9TL
 o/Vy2ptBRuFS30rORfZEnN2hhylW+eJeEoo5xgDsTIJ2b88vGH1UFBMTkfuf7x+sXZwF
 1tySvI0VmRWI5S5aYR46of+cr8bWnVpS4Q5stUCnbAmxPus9RpmFB8C6aaUZ+ZAB9YI8
 ewR2VT2GlYEzA3t0RqI+2rrSjIZ5YS/fAwSYPa1VIqVKbW9vwH9SJlPM2eTOK/e7PODn
 n/2aDtc7PD3HZtS8ZV5Fc4dOwXGJCJkyTvgwvSxpkKSaHrhBk3hdKb1MepzPqyxNICfM
 jgGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcBeaMoJTTA7ts1Dq0iiI0uYnPL0Mi6wPolErby7tNcnTORDQh20LppF2SQEtX7C3GQ4R0YJ8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2P0wuDnNRTtyVAxJD1vpzLEYLTDo7wO5n+9uuZVu+X7/+31hJ
 2t2Tcl8RuXO7H9Q/gIbt7waw9ECezZZM9+6amyqy8AuZ/UybMA5+erWR2egTlB2TbbYNXX4r/Av
 15+z7J9qq5+qq6SuipnTTAQMCHX0=
X-Google-Smtp-Source: AGHT+IHEfFa/Dvqy3PDWwoawhdFWyg/HfSi0VXOqPgXMH7YwIekhiIAle3opjyzMfd/MABbj0y5dTxE5OMOEbtgWtCs=
X-Received: by 2002:a05:6402:50d4:b0:5c5:c4b9:e68f with SMTP id
 4fb4d7f45d1cf-5c8824ccc1dmr13411961a12.5.1727768990232; Tue, 01 Oct 2024
 00:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
In-Reply-To: <20241001002442.GC4737@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 1 Oct 2024 08:49:26 +0100
Message-ID: <CALeDE9O0zys8UW+ZoTDoQr2hAJKG+d7AbNpsyMMxdbtVWzFxWA@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 1 Oct 2024 at 01:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
> > On 26.09.24 23:59, Simon Glass wrote:
> > > We don't want ANSI characters written in tests since it is a pain to
> > > check the output with ut_assert_nextline() et al.
> > >
> > > Provide a way to tests to request that ANSI characters not be sent.
> > >
> > > Add a proper function comment while we are here, to encourage others.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Please, consider prior review before resubmitting patches.
> >
> > As responded to all prior submissions:
> >
> > We want to test the code running on actual machines.
> > We don't want to have sandbox code everywhere.
> >
> > I cannot see any test that is not passing due to the current behavior.
>
> The pytests for the EFI selftests are unreliable for me, on Raspberry Pi
> 3, more often in 32bit mode than 64bit mode, but I feel like I see it
> there too. And when they fail, the console log is full of ANSI escape
> sequences. Is this specific test a test you run regularly on real
> hardware?

Is it possible there's a bug in the RPi support somewhere that's
causing these issues that is triggered more easily with the ASCI
codes?
