Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36622D33987
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 16:02:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E3084211;
	Fri,  5 Dec 2025 17:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LaYBLIw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4D1D84212; Fri,  5 Dec 2025 17:02:06 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702F083FA7
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 17:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linusw@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CBE60441F7
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 16:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A978EC4AF09
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764950522;
 bh=7l/srbwvHl9FGnHsmXIrwEcUv+Sn+T1jdbB2EnokU14=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=LaYBLIw9aDlaCQcqN8eWM0yPtF4zU/Kf5sFCxGB4XxCPj1DfpnKicRQCJsbc1I142
 51Dr6dZrbvjdHCuYr2n1ssmlVJVMwKcMp0jXCnpF3/JIS7YM6AtvO/0ma8SKto/w5I
 uNfDweqDmDU0K/ur5OZs2LYEoenUSH6JYASxw3D/ooBLis9VgV5LGyrLrjU93Oq0So
 ijnYYjGAfuFJiITMxPzLj+GS7OaHZR6KIEjwcKjhNjz/wFuNFdHD+Cw3NrA0bfy0Ce
 iMFLI8YiOTMdLe5raTQ2duXRXkcnpPFj7q+z2LSyof8bXxaPEFCVjtBStKXYUNpbKR
 VlJWfTo4PZqfA==
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-644458ec093so788236d50.1
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 08:02:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyjSATuQBpGWOxEkY7bza0nNa4MJDc8dRcYzvjDjWYkNd9Y5E7f
 h2Am6euny3iJl13Jafu55BeHpDaCQVbqrzr8GPRn/ES9sIKwVulnnFcNNRv4mxIsmOQzd08jMPv
 FI5z6HLqhOD81f1wzVP4eaaSy6VetG3w=
X-Google-Smtp-Source: AGHT+IG2wMWEDQzgjWSqGu8DLHrgzoVEq6qhmVQulNFFT+pdGywP5burEvWlx5OW5WYpPmY4vhltHmX83ycqC9AQCfw=
X-Received: by 2002:a05:690e:12c1:b0:63f:b922:ed79 with SMTP id
 956f58d0204a3-64436f96e1fmr7547694d50.14.1764950521938; Fri, 05 Dec 2025
 08:02:01 -0800 (PST)
MIME-Version: 1.0
References: <20251205-linusw-kernel-org-v1-1-a36e342c4b97@kernel.org>
 <4160a1c7-a9f2-4ab5-a151-b580681e805f@cherry.de>
In-Reply-To: <4160a1c7-a9f2-4ab5-a151-b580681e805f@cherry.de>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 5 Dec 2025 17:01:49 +0100
X-Gmail-Original-Message-ID: <CAD++jLm7ZnhdROuhvCWxGa_MpxGYAF5SnBwpuW0QOScp1barUA@mail.gmail.com>
X-Gm-Features: AQt7F2qJpu4nlQpVzhNGBSB1jGIKIXb5BfRtmYG-ZevBYacMJZbVHDfD2CwAKEA
Message-ID: <CAD++jLm7ZnhdROuhvCWxGa_MpxGYAF5SnBwpuW0QOScp1barUA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update my email address
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>
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

On Fri, Dec 5, 2025 at 4:49=E2=80=AFPM Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
> On 12/5/25 2:53 PM, Linus Walleij wrote:
> > [You don't often get email from linusw@kernel.org. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > I am moving over to using my email address at kernel.org.
> > Change this in all the affected MAINTAINERS files.
> >
>
> We also have a .mailmap, is this something you'd like to add a change to
> as well maybe?

I wasn't even aware! I'll take a look and spin a v2.

> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!

Linus Walleij
