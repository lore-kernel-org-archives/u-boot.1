Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C261FD6A25C
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32D2A89354;
	Fri, 15 Nov 2024 15:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IuGz+WW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 151F0890B1; Fri, 15 Nov 2024 15:21:18 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFB089354
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso3069333e87.0
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731680474; x=1732285274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HsaQznxKvtS8wUj3Qh5q3J675UKiu0k+kzfXwmHbUKw=;
 b=IuGz+WW77KzY2wWWRcXxek9qoY6qZZ8ZOTXrhyv0Zk8UxaCItfYqT1lrrUUxLGwb9w
 fv2Zrv0qyllOa0GFT9Zh42A8b/IjwbrXFEJSOQifbo1gCCjbVLiDVRsIbqyo3E+brP+W
 Hw7uK2BX6z9z932K6IBpqSDGPU+eyuCsnBV9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731680474; x=1732285274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HsaQznxKvtS8wUj3Qh5q3J675UKiu0k+kzfXwmHbUKw=;
 b=m9NIziCg+zkhfc++Td41kPXddUUR/dOiwGq91aoRodNpa8g4q1mXY3GXz+K6eE19t9
 CwDNZggXDaGuuw2lRfVjtmyiXXZi7LFY1t1nmpR1YoB8st/Uc5+lH+W19Hed1sdo8GKI
 7Sgjom7ydQNQzcc0XSXh+EUsDvRdXHdk7CLogUnWpjB3tkycTygw9GHLsUhf4DrHA/fL
 Q8UXN/vauTsfxCWzWBGmFzepBmb7y5JZaLH5jeetB6zdneyCbf6m3QxqW+dIdig+RQl9
 tw0SEGGI0zNJ0dZDg2jGOgaLAe+DBJ5JwhHzQgp/PO402tMxlA2qhSlkiryCXUkQIsB6
 zokQ==
X-Gm-Message-State: AOJu0YxmGGRpxsmuZ80WAx3DTDBZmK1k5WroAd30yq0hFJrdT8/pEU9S
 atAkMzlOIA5mWi6MJwHGw5LGoit4wG3Oj5/TODGFAC/W4+gMi3WUYMxL/sB4RzkPYi44M010FEC
 JpWn0hpUuQf1FXMchaaEgj+q8DjTNgMkp8wgF
X-Google-Smtp-Source: AGHT+IGM17+omMXoRzPJur9QOqQHmKE3/wIpzcq+XhrHj/46ky/sLUPlgAxOxCMpdqihJRFCxqII7z6rJcGZQHAC088=
X-Received: by 2002:a05:6512:3e29:b0:53d:a86e:4200 with SMTP id
 2adb3069b0e04-53dab2a634emr2159520e87.21.1731680474216; Fri, 15 Nov 2024
 06:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20241030213404.2894247-1-ravi@prevas.dk>
 <87y11mn4sh.fsf@prevas.dk>
In-Reply-To: <87y11mn4sh.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Nov 2024 07:21:01 -0700
Message-ID: <CAFLszTga-7sdukCdXJ+KXEtDMbxPYjN+NvviVLvtzO1T8MHkBA@mail.gmail.com>
Subject: Re: [PATCH 0/3] teach 'env default' to optionally keep runtime
 variables
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>
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

Hi Rasmus,

On Wed, 13 Nov 2024 at 15:32, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Wed, Oct 30 2024, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> > Doing bringup of a board, part of my bootstrap logic is in U-Boot. So
> > when tweaking that logic, I was bitten by a previous completed
> > bootstrap having left a copy of the environment on the device, which
> > was imported and thus overrided the new logic.
> >
> > So I thought, "ok, I'll just make sure to put 'env default -a' as the
> > first part of the bootstrap logic so I'm not bitten again". Alas, my
> > logic also relies on certain variables that are set by C code
> > (e.g. for detecting board variant), and doing 'env default -a' also
> > eliminates those.
> >
> > Looking around, the hashtab code already supports a flag that does
> > exactly what I need, and exposing that is (morally) a one-liner.
> >

I didn't see the patch, but can you add a test?

Regards,
Simon
