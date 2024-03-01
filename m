Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740DFC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 15:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC1A287DF6;
	Fri,  1 Mar 2024 16:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ejWVfi4o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F1D588153; Fri,  1 Mar 2024 15:54:03 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07FF87CB1
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 15:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7da763255b7so904858241.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709304839; x=1709909639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8a6gwz+4kECklsxG9tY4ZGKIuUUT3fCgDi4EGSlyEcc=;
 b=ejWVfi4ot5k9Vm408fjWFT5MXQM5HNj2kDVUepBcFXPdq+spr507AftxLiuLNVpCbF
 n5Gp8vd3wrCmvgr/rVaIQ5m+15ybcwH9VeaXNLedp+dd5mY+89KL+xtCpx5IMQAHMspP
 gdKwhxe5MngoygnTk5ta2Exj/zdX5y48mXR6OySlncfjx31bkywUfSbAYqJvZ1eekVUJ
 66yCCoX2RgYFd2Uj6kzQNdyQnAOLbsf5viSxmTrqWN2rR8YjU45wZlXF0nst1IfWgvNh
 z8CSmYUomLx5Ob9dfulbJWZJaikUZLwTt/bj9gWtYr6Mj0s6DtxUfMVxsfw7wNv9a5xw
 9VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709304839; x=1709909639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8a6gwz+4kECklsxG9tY4ZGKIuUUT3fCgDi4EGSlyEcc=;
 b=Nvwnt5xQ6+TYWmEboWGjTLgbOrJSy67csonVkjuQN5lxH//4x3SWrGIoWNV4FUmubn
 SPYbzI5QGZb8FYcW27da7lGhORYgM8ZzTm4zmpJhRwOmf128WZidVTMxmoyHZ72U8bbI
 vzzN6QL5TacstSRbXIo8ufcH1Ayor7G7ehhl0Y2jjlrRVwp5cMboS2F6WS1mmbLbUXWs
 enXmHIbR8NB+Ou7SP/xMCy/4t0MuwmZgPO9pLA12CsAQ3IhwE0Rtewnrpz+h09AVqjcN
 Q9va9Ve7d2oH9B56ObZqt/AQZohYxlGn/cSLsiEgLfP4P6MkuvmYbR6x4sL14luQUjbP
 Pe8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGxaEh8xYoFpm5D6IQbNFZcKIFw9QWsnz3rXV31Bc/sO23JFjmImmCB9vH1Qg5eLjEIH3FzEjQXNDF5ZT+UI0bqlO3jg==
X-Gm-Message-State: AOJu0YyZ+OreU6oeyw/uWFKpQupa+uhVWXVx1vhv07DJt8L+OW0eK/pd
 VbAk155bwpm0JsMKgzy52UxKqHeClZZZ+FZbDYmWCItlbJTuj4xWqn11lfVzqBTrDYMXxd3Ppw4
 grlAg55g+ZyAi1W1vK/Y0t8/7J17ahF/7w+IUvw==
X-Google-Smtp-Source: AGHT+IF9KjM5YPdbhw8JwwBKAju62yFFF+HvTtJ+ArTAhyqnA9ei87OXd9thQUazPbonvMBSlpwniskBzu7Bj+m68vk=
X-Received: by 2002:a05:6102:2758:b0:472:69ab:f7bf with SMTP id
 p24-20020a056102275800b0047269abf7bfmr1390880vsu.9.1709304839441; Fri, 01 Mar
 2024 06:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20240222093607.3085545-1-sumit.garg@linaro.org>
 <170929783825.70492.4756963077870833230.b4-ty@konsulko.com>
 <CAFA6WYMBMQH10cHnsfmC5efkkohfzftz=6u0N4RMXrVrByZzOw@mail.gmail.com>
 <0ef45d67-1428-4d8a-b157-2ee65a3c9948@linaro.org>
In-Reply-To: <0ef45d67-1428-4d8a-b157-2ee65a3c9948@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 1 Mar 2024 20:23:48 +0530
Message-ID: <CAFA6WYOb3B6unesNLMJrqQihJK7ydwUkJPO3Aa6kn0+SC6T2oA@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] An effort to bring DT bindings compliance within
 U-Boot
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, sjg@chromium.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org, 
 dgilmore@fedoraproject.org, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com, 
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com, 
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de, 
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl, festevam@gmail.com, 
 nm@ti.com, andre.przywara@arm.com, ijc@hellion.org.uk, 
 paul.barker.ct@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 01 Mar 2024 16:10:34 +0100
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

On Fri, 1 Mar 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
>
> On 01/03/2024 14:30, Sumit Garg wrote:
> > On Fri, 1 Mar 2024 at 18:27, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, 22 Feb 2024 15:05:56 +0530, Sumit Garg wrote:
> >>
> >>> Changes in v6:
> >>> --------------
> >>> - v6_dt: https://github.com/b49020/u-boot/tree/v6_dt
> >>> - Patch #3: Incorporate fix for sandbox CI failure.
> >>> - Patch #6: Incorporate shell script comments from Marek.
> >>> - Patch #8: Incorporate documentation review comments from Paul.
> >>>
> >>> [...]
> >>
> >> Applied to u-boot/next, thanks!
> >>
> >
> > Thanks Tom and everyone involved with the reviews. I hope we can carry
> > forward from this effort towards a healthy devicetree story for
> > U-Boot.
>
> Thanks Sumit!
>
> I'll try to submit patches for Amlogic GXL & G12A to switch to this!
>

Thanks Neil for your support to be the first volunteer for this
OF_UPSTREAM switch.

-Sumit

> Neil
>
> >
> > -Sumit
> >
> >> --
> >> Tom
> >>
> >>
>
