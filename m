Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8B0D2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F1F89215;
	Tue,  5 Nov 2024 17:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ashIb/3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62499891E8; Tue,  5 Nov 2024 17:02:31 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6278B891D0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c94a7239cfso3418194a12.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 08:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730822549; x=1731427349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jwE3j/mQoptv+3/683yQFy4D1NKo8ntzsL1wTBI/MpM=;
 b=ashIb/3ON2q/R5scPazZBY0ruFs6PCitTtgVfM/JYgXfEomGx+kPQBpoeG4Up/qVnm
 A88G7rGsPBI56QYQw1T5Ley+DiggEhtyJ8Fd3wm9qsPaHEyZEYl6Dabe4ET9v7TP+Gu+
 0VSV1oy6mwMupVkbD9jHch5K4npNXMjES0VF2APKWRkNpY0tWZzQalnv6UPo1dsWGMxf
 P8qgSekYPowHVcssuoWALwG6aRANo7GQT9JdrvLWyY4VKOGBibSM5U9yUsXvFcFRZNrz
 txEYhrNyIkiZKQ7PbM1lMpcQS0rGG/fSV8fCuSYB4nMnS2YHAdRVSTG3nxe03gduaE5S
 MB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730822549; x=1731427349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jwE3j/mQoptv+3/683yQFy4D1NKo8ntzsL1wTBI/MpM=;
 b=AQTXjVBW664cfOErulnh0gOuZEaHBOCWZu0GJHooIaXPKrGkdJ55hdfif4J4ZHBrbo
 tJVRrDEiYYbRcRoFpUchUK7JTS6Es4JuqtMTiXFCqCHu42T+IizYhHlJYJQG/O6mhK2y
 ajv7A4EsXAYF9SYZ1OzmRdD9tHB3stcGRICOoi4aXmhhw5vkAJL5m3DcngBYtwCkzufv
 KoDtCxwabVTcurCRqzNLOZTkbVzGlPTSReHvlSdvSDIyyJVfq9FcD/qIZw60hmiXGYzt
 OhZVAzEHjWfbtcU9JskngvWBFlAZ6/AF47IDTUNjXmLAicychxDxq0AN/vynVIbmjKGV
 Dtlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNhtNTQVNhsHsC0T/10eGXqTmFsTxcuFZ9E/e0eUz1p4jED+0f6QHFJPU4XatFh8m/WM0zE14=@lists.denx.de
X-Gm-Message-State: AOJu0YzmSJU6w+cXXJ9XQBQS7F3B0kfWhYn1UIOP7wL2hXdCHbuBk7lE
 /oc+iZk2Em1V1Ear3VoaqdQ4pueun8yglQ7XTieMWx0GSedy+bXKIjT42aW4l3P+45k94mYceCk
 XpI8LiHk8P4wT7/266PNEIDNsxFE=
X-Google-Smtp-Source: AGHT+IHylfGJDiGfRpy17p/tVyYBL4Po6HUbY75G1bv9KAoTKS9nx1owCEL00Pgjxjj1CQsVwV3XoaoDlJ5O+1qHvY0=
X-Received: by 2002:a05:6402:280f:b0:5ce:d435:c26d with SMTP id
 4fb4d7f45d1cf-5ced435c318mr10394315a12.19.1730822548424; Tue, 05 Nov 2024
 08:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
In-Reply-To: <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 5 Nov 2024 16:02:16 +0000
Message-ID: <CALeDE9Ps9hua1+AhZDkA+WtxG0phB_0E7j8RJJa8kY5eqn24NA@mail.gmail.com>
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

On Tue, 5 Nov 2024 at 15:15, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Tom,
> > >
> > > On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
> > > >
> > > > > Legacy TCP stack is bad. Here are some of the known issues:
> > > > >  * tcp packet from other connection can break a current one
> > > > >  * tcp send sequence always starts from zero
> > > > >  * bad tcp options processing
> > > > >  * strange assumptions on packet size for selective acknowledge
> > > > >  * tcp interface assumes one of the two scenarios:
> > > > >      - data downloading from remote host to a board
> > > > >      - request-response exchange with a small packets
> > > > >    so it's not possible to upload large amount of data from the
> > > > >    board to remote host.
> > > > >  * wget test generate bad tcp stream, test should fail but it passes instead
> > > > >
> > > > > This series of patches fixes all of the above issues.
> > > >
> > > > I know Peter asked on the last one, but I want to ask as well. With lwIP
> > > > merged, why do we want to add features to the old stack? I can see
> > > > fixing issues, but not adding new functionality as well. Thanks.
> > > >
> > >
> > > Let's apply this. It has tests and the old stack is still used by a
> > > lot of boards. At present lwip is only used on one. There is more work
> > > to do on the new stack, including finishing off the sandbox
> > > implementation.
> >
> > I agree with applying the fixes pieces, I do not agree with apply the
> > HTTP server pieces. This series should actually be split into 3
>
> But what is your objection?
>
> I would much rather just apply it ASAP. It has already gone through 12
> versions, during which lwip has been prepared and applied.

I highlighted my concerns about it all being together all the way back
in v1, the fact that it should be 3 separate sets of patches.

The fact that it's at v12 is irrelevant and should never be used as a
reason just merge a patch set, it makes no senses.

> The HTTP server is a useful feature and we should be able to use it to
> test networking in U-Boot in a more self-contained and performant
> manner.

LWIP has a HTTP server which is widely tested, that is what should be
used *if* we have to have one, I still have yet to see a useful
usecase, and no CI is not because ultimately how useful is testing
against ourselves, the fact is testing the HTTP client against apache
or nginx is a better real world usecase because the reality is that
U-Boot being the client and the server in that use case isn't really a
real world use case.
