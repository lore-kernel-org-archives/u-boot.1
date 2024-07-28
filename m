Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372B0C3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB238875C;
	Sun, 28 Jul 2024 21:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mwCfZVbm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C6587B1A; Sun, 28 Jul 2024 21:36:15 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5C4F884C6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b5dfcfb165so15265956d6.0
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195372; x=1722800172; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dK6Y2erwwUmiWn8aaVa6Cu+ng+XOydtsEKEdR2UsPm8=;
 b=mwCfZVbmdRdaew4wcRyUarb6V0wgrP+F1c/OIZtj+k5RIUtoiZ/2VPst2zun/d2+tX
 G/58LPC1Efl17L6RR/azbbMnn+1pAT6j2SKeVAgU4TDFRmbUmieRdF9c+YNEOsRYKk/3
 SqJmV3fPJ/yEbdx7wAyG9pxzbkEKdzCH/q8FY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195372; x=1722800172;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK6Y2erwwUmiWn8aaVa6Cu+ng+XOydtsEKEdR2UsPm8=;
 b=Xi9yz+aiMwvGY38w5RqJVnwrTiF1YuJabhjQuiQ0rEuD9hU5QECHXBlTEic38JpsiA
 SBdYw/nmXMFP6r2U2BJeJmUuHXtoL8JZ9o9a56ZLSoL0yOmUxGRG8EmC92YEJpBKXMRN
 92c2a/M1zVmqIX44wOia79qA600efJZ7bYSTIl9ENIpiU7Kv5Dm3/a51p54L9OUJt5cC
 pXbb5GW/4dLvFJQqMsCgEB3VzUY6laIQDhX10Yt1VO6bu8iCHMk/egzrOVDtcYOg8qY9
 qScxJKPps3ArGTMT7Dam6w8XLgWXJLAmK1DjVJ1jmDnLfMqWPZWVPKcUNm4A6GkZwh9h
 otIA==
X-Gm-Message-State: AOJu0YxcWGLKmLYvwpZAMBnYf1s9wEFmmRwE2P7jqMbYSSudyUtGMJQz
 jMsOOCro+CQ6MG1xNRz08Ie9hAMlrDXR22QPYf4VthhAvQj6orSqhwI82K3b6/gWIr1FKaRKc2O
 wAYhc5jfyi6Gth0HVBrl5YOKGIU38mFvvtG0Dntt0y/98kcs=
X-Google-Smtp-Source: AGHT+IFAsCrNCBqzJMU2sxJIHreLatJwrNTmyxN963oCKNbEDTtPZ1TFTUoqOMuXZ1CPxUD+m47Ch1oab3t4Zbnk2ME=
X-Received: by 2002:a05:6214:509e:b0:6b9:5c1a:f737 with SMTP id
 6a1803df08f44-6bb55b32202mr82563366d6.51.1722195372652; Sun, 28 Jul 2024
 12:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240726190240.167338-1-computersforpeace@gmail.com>
In-Reply-To: <20240726190240.167338-1-computersforpeace@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:02 -0600
Message-ID: <CAFLszTjtOU3KOSYEw=UQ-=JD7HrvWbJxDGtgeDOAeh=nbeLCVQ@mail.gmail.com>
Subject: Re: [PATCH] patman: Resolve python string vs. regex escaping syntax
To: Brian Norris <computersforpeace@gmail.com>
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

On Fri, 26 Jul 2024 at 13:03, Brian Norris <computersforpeace@gmail.com> wrote:
>
> Python strings have their own notion of backslash-escaping, and that can
> conflict with the intentions for strings passed to the 're' module. In
> particular, I get warnings like this:
>
> tools/patman/../patman/commit.py:9: SyntaxWarning: invalid escape sequence '\s'
>   re_subject_tag = re.compile('([^:\s]*):\s*(.*)')
>
> We should use a raw string (r'...') so that all escaping is passed into
> the regex module, not interpreted within the string itself.
>
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---
>
>  tools/patman/commit.py      | 2 +-
>  tools/patman/patchstream.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
