Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB87E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E91A8022F;
	Tue, 17 Dec 2024 20:45:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fJsBTvjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE3780239; Tue, 17 Dec 2024 20:45:31 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD158022E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aab925654d9so773999066b.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464728; x=1735069528; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+ghkcVTwJIJAeUVmkqXj/TDrID7yqI1+024M7bxQ3/Q=;
 b=fJsBTvjQk5U8ptKF0ZSsiv0ozEq13F1BlE62uZr+h5pX+9EJGk2bFOwbI53AfDvNsV
 tx5b9uiGGB4sUzumc4ouiHbVxQSHGCHFEQaa26sAQMxBmPQceRrrzhrB9ERghgltCiCx
 gUxc7j2kuNoM6YDHCouslvIMdhD0O78hZ3qs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464728; x=1735069528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ghkcVTwJIJAeUVmkqXj/TDrID7yqI1+024M7bxQ3/Q=;
 b=Y5Z6JteA0JF1FPpPgnS94+uEld6PD557fn4kzXDhnZPtpQaVGHjnpBXEhbxtnHjMVf
 Uy/mzCNDRPMloCyYpQj2MqfXju0IOzD4FRAaBmz2+G/WD1Uolp6i31yVDuH6+OObXM/N
 bw5nXy8ahNgmp8kktkb0R22Evl3jQoBCoeury/PeqDA1xUs9g/H/iakgwZyY62BhjdWh
 UWKPouOKyYmzWVkesJpCEeiqjL4sHuo4raAAZaPvZksQF1tayuheAO2XeFBBm4hW+/J3
 W5bj6iY5IHAN6pVnXOZp7CDjKHwr7HXSDy097m2tiEWYgu5zUkhvfD52/6OIeVVLVxMu
 x6iQ==
X-Gm-Message-State: AOJu0YxQsbFHo1V/fcw4poxwwEN5iJn5hywv0hNx5JiYeO1pfnx6XBsr
 RyT1y6qncU6CYZKdSA9UqxJjuvSIh8odlURaME1f0EhaJu9Ux2G+CsBjPS/t230FCIFEdbYj9Wa
 u6YKBqSo4o7B1OPESZjyUF1WjDmyjizEh5UHPHX0asAhTc4Y=
X-Gm-Gg: ASbGncsLdNOvx0ixTwntsAyn5kCdGavdDErMypTgvp1iwZBoUgyLQBzM8Seek77Ujgv
 /pzYzk+xqWvQAiCLNGYXSA10qk2YInezXqmYfNu8=
X-Google-Smtp-Source: AGHT+IGxenmYE2teeO9RPa1mdrNSFVuWhUqGc0T/UyVACjS61VE4BjFEIZn0TZGrGCjDSPgh8s9IFRJ+tuJoKO6KGjI=
X-Received: by 2002:a17:907:7806:b0:aab:9342:290d with SMTP id
 a640c23a62f3a-aabdaf88114mr425956166b.8.1734464728482; Tue, 17 Dec 2024
 11:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20241127172247.1488685-1-trini@konsulko.com>
 <173325582729.4022967.77115780606088509.b4-ty@konsulko.com>
In-Reply-To: <173325582729.4022967.77115780606088509.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 12:45:16 -0700
Message-ID: <CAFLszThQv=3nDK+vS5T_qRPn+_Rh8JgqE7NR_TKuUWnhgg1H4g@mail.gmail.com>
Subject: Re: [v6 0/12] CI: Set up for an arm64 runner
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

On Tue, 3 Dec 2024 at 12:57, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, 27 Nov 2024 11:17:18 -0600, Tom Rini wrote:
>
> > Hey all,
> >
> > This is picking up Simon's v5 of the above-named series and making a few
> > more changes so that the follow-up series I have leads to arm64 being
> > supported for almost all jobs. To quote Simon's cover letter:
> >
> > All gitlab runners are currently amd64 machines. This series attempts to
> > create a docker image which can also support arm64 so that sandbox tests
> > can be run on it.
> >
> > [...]
>
> Applied to u-boot/next, thanks!

Applied to sjg/master, thanks!


- Simon
