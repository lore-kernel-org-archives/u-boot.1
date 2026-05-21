Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0573DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 00:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555F384659;
	Thu, 21 May 2026 02:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GcN6TsJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F4DB847E1; Thu, 21 May 2026 02:38:31 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2654084659
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 02:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bd0209f25c1so946429566b.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 17:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779323908; cv=none;
 d=google.com; s=arc-20240605;
 b=h4t6iaQFtqa3p8IrL+toZi9rFQbb5Yqs73B6WBneIZkAsWESUKXI0hP2dK0lTHmiFs
 i9nSFuaeIyV9ea5TKPW14Iduj9YjjeP4TgY+ecG1bmo4KHQM83dyKorAr53FwEwG1XsC
 qnF2fLH6Y9byt6VVO21+rHa8uAQPBBNTN5qtF1P4T35y8E5tebQ/fgV/wNClBoYPtcZh
 sQvlQxe07lAbEBp7I7VKUFBBO5OK6rfR1ruoid0JDDpBvyVXsQE3z9oRL9NQzye8XF0d
 YiDMrTiqk2r/gzl+oNbY3uMC/08TFPUfrxYpcwH9/bdHSjaLkV3JyoKyLujIN7OA8m0+
 0e7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gPd3W8N25ogtZ+CgJ5456/4yICeuKPyBwM019zCwVhY=;
 fh=1Rj5Iy6AYTVFICKN1ytNA1aIol2wPtRnCaE60wRA0L4=;
 b=g3TR+ZOxRTWjHnTpJBS4qVWo0tydItjdpi1oag9aqFfybytZJ4ySHyRvHIyULl9RSI
 ulBq4SL9MI/FG+XUUfLPtqGUEeDXJD43EtSku0z37lvGnwgRurJJKoW5N0Inw1iK5lhC
 5WMUGya/yrjYYQt+aoXnJA8HGdZJYTB0U2BWVYAMZ9eSBdeSVyaBNRfw/LJ7EmqkixJi
 PzDlzeb5xqh5FoWd2z3zH1CRTFRT3Z7LGgyjc4WKWCugXeND5uIY8HnL8oGUJPx5BZrP
 RxIwdnLv3gQOnmYv0P1s5HEUZmr2IObO3kbKQ0eNhLOKU8egBxvWgReMW4mp6hyBXWf2
 S4+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779323908; x=1779928708; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gPd3W8N25ogtZ+CgJ5456/4yICeuKPyBwM019zCwVhY=;
 b=GcN6TsJHcHDgWmDATgqZhSyBs8je439S3rqrAwHdJGw3OebpY3l0w33hbVfhqK1+BF
 aKpuhONmvc7fZk2vP6AiLbPqSv4tDFtpBHjr+hVrb8ecjv/TRxj6EpeAsmcLmwa7Tj1t
 CFxAVzG57SU3XXXwlresOdaOMNiK7EGCEiNrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779323908; x=1779928708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPd3W8N25ogtZ+CgJ5456/4yICeuKPyBwM019zCwVhY=;
 b=ILHoGz0qtCmZEQcDC9af+M+FNxqfWEhu2EH3nKmgVsvqqFEczJpZbmbVSLW8Sa2Tbi
 beswJePok01scP8V+pzpNUf4yOU1z7tAt2TF85sA3fH2xaYXHXeGOaV3F/ldRIc5Mnba
 HKRnXPi7Bw+SkJ0QcRGNf4Qkbi1LTuXW2sU+3mbrPN5EP+W40z3YVlA8yU6hpTQpw6Id
 xFefu1L/XFPQQ7rNUt04Wa3hj+SbRdpwxGMOS/atzqxfoYG2AZMZ/bPg3K6vzkkIScXc
 dBPvy8ugsJggZOK8ocDT5A3/KlP5SOlYVSqlOxlVJIilnXGEirO+6smgc1nwsLHK5Qkt
 hM8A==
X-Gm-Message-State: AOJu0YwHaoUO5JImmJG+UuSX1b9y9NC2+JN8GAdabX7nY6d7pRRoGExz
 EnEEgsUrAh7CQwQkg+8DHANnl11rcmsgMX2va/dmN+Whjs7CRoRIld1yHAp/pVYexfjWRUNw0uB
 gM5lUOjlYuVnG+0mt0N7DAUvWNFlHKZWNoIj+6tz4ygZQvmn8uaE=
X-Gm-Gg: Acq92OFBR57NT3AER4BowrfDOkcCLwXSifd5waYDRgdfk11p1O0HqsFOTUSZnpK6S9q
 ToVPwmQ45iomgkgNygIVRx/15MYM8Appe3NdGGtzvruYq+2js2pgAN1SiG09BQ0sCrkv/dSYnv8
 BpTssC+BCU7/ixm1NSNdpB/N/JWBf3oGk7iqbPrNed13AJZ1DOgTFBqC39dA55bbkvzLbLVqHfc
 U3pvtA20JuF+eKhYU0EVgENaudHOz1B1C7GUCo1loz3SOhfyEOs/CSFfAA+Ph0fSNR0tz5LHq7o
 Zvz0TC3+x8IVGYepqixiaWpMPDj/xPbKCD/HSjS3
X-Received: by 2002:a17:907:60d3:b0:bc1:5d96:78f9 with SMTP id
 a640c23a62f3a-bdc15c30d04mr22101366b.5.1779323908098; Wed, 20 May 2026
 17:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
In-Reply-To: <CAFLszTjeQ2mvnkPeVPsWwK7ay4Ac-+h=3pApff6CUxaaHq45JA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 19:38:17 -0500
X-Gm-Features: AVHnY4K2jDcwkQnpTNgOHEFoIATYgc-ReUWiR09bdwWiPjHzw-fU6mc1HrAWVHI
Message-ID: <CAFLszThnDQzMDNZsarpio-RM4KZpyNo93SjUwCij=wXSPPJjdA@mail.gmail.com>
Subject: Re: In-tree Python tools (patman, buildman, binman, etc.)
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

On Mon, 4 May 2026 at 07:16, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> As you know, I maintain several tools which are part of the U-Boot tree.
>
> Tom has previously suggested that it would be better to move patman
> out of the U-Boot tree, e.g. to its own Github project. It is a
> general tool which can be used with Linux and other
> mailing-list/patchwork-based projects. I have never been keen on
> taking on the extra effort required, but I've recently added more
> features and am wondering whether now might be a good time to do this.
>
> Buildman is quite obviously designed specifically for U-Boot. I have
> made some improvements recently (a large code refactor and distributed
> builds). I would like to push those changes to mainline. Do people
> think it should be in a separate tree somewhere?
>
> Binman was written with U-Boot in mind but supports other projects
> (such as Zephyr). It is generic enough that it could be separated. The
> impact would be harder code review.
>
> We also have smaller things like qconfig (which I have substantially
> rewritten to make it fast) and dtoc, which is very tailored to U-Boot.
>
> What do people think? Of all of these, patman would be the easiest to
> move, with the least impact on existing workflows.

Thank you to those who have commented on this thread.

Quentin, I think there is a mailing-list patch for the pygit2 problem. For
qconfig, your feature should be easy enough to implement. If you suggest a
syntax I could take a look.

I am considering moving all the major tools I wrote out of U-Boot, each
into its own project. As Neha points out, Binman is useful as a general
tool. Patman clearly is too. This leaves Buildman which is U-Boot-specific
in many ways, but it hardly seems sensible to keep just that one in-tree,
plus I have a substantial code-refactor and new feature to figure out how
to upstream. With some adjustments it could be used in other projects. The
qconfig tool is in a similar boat, particularly now that it can rebuild the
database in two seconds instead of a minute.

I also have some other tools I have written recently, both of which might
have generic application:
- pickman, an AI-powered cherry picker which could be applied to other
projects such as Linux (but it currently is tied to gitlab)
- codman, a simple source-code analyser which tells you what files and code
lines are actually built for a board

If I do take this path, I will need to figure out a way to make it easy to
install the tools for use with U-Boot. This could involve using 'pip
install, cloning a repo, or some other mechanism. I could use a PR workflow
rather than the mailing list, if that is easier.

Please do continue to send your thoughts on this. I cannot attend the call
next week but hope to join the next one.

Regards,
Simon
