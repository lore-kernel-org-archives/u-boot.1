Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C014DE7716B
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 15:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD5C893F5;
	Wed,  4 Dec 2024 16:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cfsMqYzf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D0E89346; Wed,  4 Dec 2024 16:13:25 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34907896BF
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 16:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee989553c1so3477520a91.3
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733325202; x=1733930002; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QnvcWSrGVaCZhe+v+4uFnLReqMUTlMF9RskvjSbmC9s=;
 b=cfsMqYzfSanyJzl5yxYQntbBiXI5pareqzSHpOIXl59uTxNlPEAzuVgsZHTlPOmEdi
 qBd4sVMJyJizxHv+0TAjbRMjcSacA+ugPCewAXTPgXc2KXUZGcMR69oAkjaFRx3Cwzom
 LMrUQq3pGIweu/mAOAPmMcyzpQ4E0BpE1GQ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733325202; x=1733930002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QnvcWSrGVaCZhe+v+4uFnLReqMUTlMF9RskvjSbmC9s=;
 b=H1Ki2PbBpGzyo1GEOFoSgSnQldCWK15eaWf/aDidVJeQxHZUCR9PV23DFhT/sbn1TH
 mp80W1wFlu55t15XNRQAG0wFw3FGO8Sj6A9q8n2/v6iJ4puqJfWr7JELYFYmPEKAfb75
 I7PU2ZOFmJzt+nNCQ+FjP4apbBxkyX33VsXS7N8lu55r6jwens2ssGAuwl50KCdqgVtz
 NaU/mxVClHLnOioDKcjG2Jyr7789v3rMHrj1/cPQ+9zJAXijZ6RpW714O8RlczG9YxUe
 Ky7g9X5jbeAc+WwR8ZjZVgl2lGiJqWsI+M/62OMElezh6UE5OzKbcvOLVSxj2AUR5Dp4
 ydnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVUeD1e6pmu9x97L6I8PD7cqyJ9y3uyeH1ROUyC5u4Nr3IbgnU/DLokuqxDOL9d+Yj6xJZMCI=@lists.denx.de
X-Gm-Message-State: AOJu0YyXPUotq9YGDLIjfVDENrMfp1yx9f9g1Jf4fJpw28PZm27Tbs1N
 JAWjmFslS+fhjlRWOXvSqcgCRfQ/LiKRjVf9QcuMjoP7e0ji4ZV5Y1EtIpap1DTMKGR8VUs41dw
 5XWT0s510mOvV0iroGEs/rH5GCaIyU8yIfRRu
X-Gm-Gg: ASbGnctmiPoVv3RBupO+kWdz+Rt7i0fAK2b0b7wjg7HeSNdMpgLtriR5RmeZJ+3m+jQ
 P+0pjEXwXlBP0AsdNOrKnMY+2awkkuPFr
X-Google-Smtp-Source: AGHT+IHgSFyMVx3wA8lup37tWOCCfIVJaRGWYqPsgrLRowFgFRey16HNXYQPK7+jCKYP091FOIw6JKGCxP9NxuuS5w0=
X-Received: by 2002:a17:90b:3c4a:b0:2ee:e945:5355 with SMTP id
 98e67ed59e1d1-2ef012116camr10212152a91.19.1733325201622; Wed, 04 Dec 2024
 07:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
In-Reply-To: <20241204012907.GD2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Dec 2024 08:13:04 -0700
Message-ID: <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
>
> > From my side I'd like to change the conversation a little, to how to
> > land code, rather than why we should bother. "Code needs to land"
> > should be the motto. If someone has taken the time to create
> > something, our bias should be towards getting it in, with sufficient
> > changes to make it fit the project. There are cases where something is
> > just a bad idea, or should be done another way, but for people working
> > on major features or changes, biasing towards not landing the code is
> > just going to make them go elsewhere.
>
> This is the wrong approach I believe. The goal has always been and
> continues to be to have reviewed (whenever possible, our developer
> community is small) incremental change over time.

Yes, I agree with that, but it isn't what I said.

> Just because something
> has been posted a number of times does not mean it's ready to be merged.

I didn't say that either.

>
> Your challenge today is that on patchwork you have over 150 patches
> covering a wide variety of topics and of which many series have
> technically-merited feedback that needs to be addressed in a technical
> manner.

By my count I have about 10 series in progress, with a small number of
patches (< 10?) with pending feedback that isn't effectively just a
NAK. It isn't a particularly large number, if you add up the patches I
do in each cycle. It is in the nature of development and code review
that things are often not right the first time, or someone else has
another perspective, so I cannot see how this can be reduced.

Regards,
Simon
