Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D3DCAC59B
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 19:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4F90803CC;
	Tue, 16 Sep 2025 21:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkkksBES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707CB81E13; Tue, 16 Sep 2025 21:20:45 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7865B800C1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 21:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso11437887a12.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 12:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1758050443; x=1758655243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/g1VD9LXPRqtAVCKAnNDCBFCQ2WkcNfnjDWnawGEBto=;
 b=mkkksBESX6XnYG4NqrUfNDNOg6IKn/WFyGTzaDJFo8ySfsqGMV/ETqOfQVQGCKCNV3
 Z8WeFdjZr+gFofkvoaLTmRNHEn4MR5B3uOGBGhADn9VhNflscYxJg8bTGHqToVdkTR7u
 vlqa3ZTuwkmWAryzJ8l0NqlcBQiHkwlWhxBSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758050443; x=1758655243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/g1VD9LXPRqtAVCKAnNDCBFCQ2WkcNfnjDWnawGEBto=;
 b=YB1FMiala22rxmnXi8x5w9KnuALF94TopsNJexeTOmpO/mQ1LxJU45A7KINez7GF4c
 4amuao/jqBnulCsUn8IyPbzkVg4/Z5Wfu9toNRVqe1Lh53kvv36ULdkx0CsbBCSXLBR3
 n+q71gqI69zBEqAcxwu7ixB+w00WKiRlniZWrOMDBYh7ac8lgT5PemLEUyLkmNQjlkz/
 hnK2X9zbChvADClq1YMaUkoEEHglM4iwnBjY36CzGZWW0clj1ueO/DuWbGo99M9l4BgT
 O1f+TkiuKmaeSmaoBHSBDwZY8drWrlWyd6bvAzeIr8I+/E2cZazXyldGg3/6uUL0DUsz
 SjQQ==
X-Gm-Message-State: AOJu0YzlS1aI5qFMUekhe+engE8f07riHkhbo8FNJdI9HV5vpYGGFZOT
 a8eGvHH3/sVV3cnlnJBQ2ZBYpROMotWoCWbmFdkI3p6HCM2sSY4BG9r++cY5aEorcdeui0qlppX
 anYL6WFEA7N9nO71Udk2lG4pt50j3d0aERqhUJa5OFTC1DUzKSOoiKQ==
X-Gm-Gg: ASbGncvHZ3kE/GWrShcnvAvF0mv2WppDHGh1Sti1xJFkEEpEAXdm3jzfx4lrA45vhKJ
 TiErkoxB91x2uvoWZPTdSmqK9DkrvCxRF55QVZT4pUtSeviucH0zzhROdqaSAq3GrqqPfRjTwAr
 P/tM0XQ+xlwREjTbGGs+qMYc/alFpsjnQnrZD/lFNWCZaM6Oka4WsKVkKZqHUmh7CJ7Qs3y+GFM
 ooX2wgTcDpmgEQ0
X-Google-Smtp-Source: AGHT+IEM43k8YupUp3CSOa/TwEMJpq7haxSsg9EX+f54KYngpOevdtOd2kTU6u1bVnf1f+N4il+uVI4mNqE1W1VoY1Y=
X-Received: by 2002:a17:907:60c8:b0:afe:78c2:4d4a with SMTP id
 a640c23a62f3a-b07c381bb7cmr1979198866b.34.1758050442928; Tue, 16 Sep 2025
 12:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250916174402.GV124814@bill-the-cat>
 <CAFLszThagMr7f8tbAfeKTHsFc204TJN+z-B-SxR5qNqnM15Nzg@mail.gmail.com>
 <20250916185744.GG124814@bill-the-cat>
In-Reply-To: <20250916185744.GG124814@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 16 Sep 2025 13:20:30 -0600
X-Gm-Features: AS18NWAMF_S4Rq7CB08OqPHxettVzBc372qc4In4imghtrzfkNEYurNK8IJr4mg
Message-ID: <CAFLszThwMcwMJOyy=2=hGZj7ME_huL13Yb1T52R-2HCJYzdY2A@mail.gmail.com>
Subject: Re: Gitlab CI slowdown
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

On Tue, 16 Sept 2025 at 12:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Sep 16, 2025 at 12:56:04PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 16 Sept 2025 at 11:44, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > Currently, Gitlab CI runs are going to be extremely slow on the final
> > > world build on arm64 hardware task. While we had previously had 3 fast
> > > machines available here, one of them was decommissioned unexpectedly a
> > > number of weeks ago and the other day the UPS another one was on died
> > > unexpectedly. Currently this is expected to be restored in a few days.
> > > Our third machine was disabled for a number of months due to some issue
> > > with the machine itself that seems to have been resolved, however it
> > > also allows for multiple concurrent jobs so it will be slow when two or
> > > more pipelines try and world build at once. Thanks for your
> > > understanding and patience.
> >
> > Is my one (alex) in this list? If so, can I change the config to
> > resolve the concurrent issue?
>
> Yes, alex is the one I was talking about there, thanks!

OK, I've turned it back down to one job.

Regards,
Simon

>
> --
> Tom
