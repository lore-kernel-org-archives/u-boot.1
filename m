Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830B3E6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 204FE88AAC;
	Tue,  3 Dec 2024 01:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BpOVW5rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26CEC88A0A; Tue,  3 Dec 2024 01:22:51 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1E28958B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aaddeso6146981a12.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185368; x=1733790168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vsnd9B8he1/jslioYgL6SpdZPXDGAXkjvnzIncotbZs=;
 b=BpOVW5rnfK2SIisEPrmoqXj3PsB6qVrlm9cYJ4oe6Pt81KvzO3qAUyR1gZ2ODTYdZd
 OaMeW/PBGo1aiU1ZVPaIb3B9tJ+7YUZPrzhArms0jrzVu2yIKC2lDm57yxNGU46Q5HD0
 QdVWCtKUsttXY3+QllutFvNwDfFuRyNF30lGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185368; x=1733790168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vsnd9B8he1/jslioYgL6SpdZPXDGAXkjvnzIncotbZs=;
 b=u8neE2vCXX1Djty/kVgC+jnHDvcnpip9FVLiN5yGzJekpT4phnCy6BkMh8IO/B+bGW
 ERGEE2wLBmcOzNjef5RkbO2llThCct5mvhV1kLWeZBrCrbr8vGHdeKm60lI83mCtx/49
 aroFLR2tT+Fw6W42LZBWnHMOdpXp7kovGjWMnExb8F66j+tzvGUlDclmzmTYFP9Q7pQw
 Jvr011EiQv6ewb15O54DMJvTVIbk6wLtKFlUdZ3sJe/IT9c9Ar+y9bX4eX60hhP3M7F6
 8UvkFGM7AGfMabEDog5FhiN9cIo03jHKsciJdi64VMbOgRFdTJlHYQBZgyoTmoQp5gpH
 xn/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8taeCk1MjwKiWvg9VCGKZsEctinK85UF5ja7uMPv7qkdYCcV56ghF4dyhF/nPvqCMaeELHF8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzi4Ah6r/Z3kb9VMusZdlJWtSwCKD+QZAENCPCt8DhTJphIAl0S
 nrcKnEeHWx1Q4R1JtwB5wff4gKHgpqx4FGqIFdwi9gEcrSXPxnXhWwSfeAw2yWjepv+st2eJ+sX
 ZRCEP+10h20pqsvOvG2l97fsBO/UnGOUqlyt9
X-Gm-Gg: ASbGncuIzk/tUO73+hwAIA/Xs4vSoQwZgDRmi9bt0tAcy1Ht0ahZdlbLU9/M0BrNlKY
 8hG6Ul5tsVXUeeFrSYbdgrn5iOwtOmiT1
X-Google-Smtp-Source: AGHT+IGC3reEkHjAcEZd8uhOW6lhVXtYLius1UZZUvQU4RffFarUiLUqlXJs+R7mL+gf0avOj3T+DqCO152hzyncHBk=
X-Received: by 2002:a17:906:4c2:b0:aa5:50b6:a600 with SMTP id
 a640c23a62f3a-aa5f7eefc64mr15065366b.44.1733185368330; Mon, 02 Dec 2024
 16:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
In-Reply-To: <20241202162239.GE2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:22:35 -0700
Message-ID: <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
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

On Mon, 2 Dec 2024 at 09:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 02, 2024 at 09:26:42AM -0500, Raymond Mao wrote:
> > Hi Simon,
> >
> > On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:
> >
> > > This stops coral, bob and kevin from booting.
> > >
> > > The correct way to do this was always to use a Kconfig option, so let's
> > > first revert this broken idea.
> > >
> > > OF_BOARD and BLOBLIST should be general and hardware agnostic,
> > do you have more information on why they don't work for a few boards?
> > Maybe the way to handle these logic within certain boards should be
> > changed other than to revert this?
>
> Yes, I'd like to understand the whole problem better since we had a
> forever-and-ever thread, compromised to what's in tree now and now you
> want to revert the compromise and bring is back to what was argued
> against for forever-and-ever, at least from a very quick read.

I'm sorry but I believe I have explained the problem in that forever
and-ever thread, so I don't really want to re-run it. It may be that I
was right all along?

Raymond, I cannot pass the DT in the bloblist from TPL to SPL on x86.
There is not enough cache-as-RAM, for a start. Plus the DT is in the
memory-mapped SPI flash, so it makes no sense...

The primary issue here (I believe) is the Linaro idea that U-Boot
should not have its own devicetree, because there is always a prior
stage of closed-source firmware (e.g. TF-A*). Perhaps I am wrong about
that, but that is the way I understand it now, as it explains why
OF_BLOBLIST caused such friction.

Regards,
Simon

* I've seen quite a few vendor-specific source trees and none has been
upstreamed
