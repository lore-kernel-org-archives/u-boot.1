Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255DFC3ABC0
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666EA8212F;
	Tue,  6 May 2025 15:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MCw6N9JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD7682153; Tue,  6 May 2025 15:23:53 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF970820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so8402751a12.0
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746537831; x=1747142631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qbUocN+KkbzwlQMHXPrA0QYaCHaNr8JEPHh6Q53HZwg=;
 b=MCw6N9JZ3idlyId5OXBB5wvV5LrDtdfD5MIKxuEfKVl4Mi+lo63DCzcWcB14uILJ6u
 0qjHyNoFx38oirGT17l2OsRrPtBveQmz8G5wu7f//vMaeRmwdfU6/PeqDsv6Fh2+E5yw
 M0DLrh4TtlOF35P3W865P4rHp02jQLO3OQneg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746537831; x=1747142631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qbUocN+KkbzwlQMHXPrA0QYaCHaNr8JEPHh6Q53HZwg=;
 b=BDlbs4IiG6Dkvk0adfxmHZj+2cm43CVVw+U3Rzu3IU3Yiuv1ZmqjfmKUzidCN0wV1O
 G1a1JvL4sereF5ypl2OH3HuVIx7uG27TaQ43MSbysT4sRLHrbkWe8P4UlB1H8i7Rnc/g
 M0VZtFvvHkixvYIyQQH+yoAKIaWq7EhJyrXn+KIBR9j7mWH/ZcUjxy7JaUnBAA2EHZBZ
 xkd6k4zQs9fdnTBXN1uuuAavGeRi9ESBbz4v1GFDYjeGbRUWpf7MxrjsFCWtTMEMDxJG
 5bE1qabe+G9eIndQdHiHqliuhdhcOMZrRxNjQx3WfBovioWrSINY9zygifkccmjNp5o3
 8sLg==
X-Gm-Message-State: AOJu0YxXGqGawc53MDaIRZXNLiHk59K6NkpaYcu2Q2KbgzuSqRXFYSAC
 UTzmgTcOAGoZiWTg2QIW4nn/uHJVKiIn1KZRlAfz/uNjontmUokMYLYgiPiEtG7wQ8iedN5LThH
 FALNFdeGqIenU5wKJd28iCaupfDXB79IgNsUgLU2OBADV+s2WI819KVr8SQ==
X-Gm-Gg: ASbGncv6AAwfnvXMRZjTG8Y3y8yz+P5Y+JP/SwE7Y0/mpWLzjNQeGbrxvEJmeISrB4s
 gIwvikS3VKGdJMOA391m3Uoy7BE9Axf/R+ltgQhgH7E16+iBtcC4JMJnBixPqSAbL5ClQbnxK++
 alKhAMYP6KEZwkkgFjjlz73LA=
X-Google-Smtp-Source: AGHT+IGz9GuQfgCrAp6CjYbtV2dJe0rgTqRr7rBHvu6nMT4zsvjbmjYFGG9Neh2obLofLMHCuxYIn5sUQ/xNEKWFvRY=
X-Received: by 2002:a05:6402:34d1:b0:5e0:892f:89ae with SMTP id
 4fb4d7f45d1cf-5fab056e588mr9635170a12.4.1746537831130; Tue, 06 May 2025
 06:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-2-sjg@chromium.org>
 <20250505203810.GM5430@bill-the-cat>
In-Reply-To: <20250505203810.GM5430@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 May 2025 15:23:39 +0200
X-Gm-Features: ATxdqUHb3Lt7FCcr7Sili9lwzamNoZVOWg0Ii8MV0lt8yj97KtwZdxGok7w-oh4
Message-ID: <CAFLszTgw6pP7SgRp=C-skUeA_cOhEfoVXD+YNKE9jP8vj0UPXw@mail.gmail.com>
Subject: Re: [PATCH v2 01/18] abuf: Add a helper for initing and allocating a
 buffer
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, 5 May 2025 at 22:38, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, May 01, 2025 at 07:37:01AM -0600, Simon Glass wrote:
>
> > This construct appears in various places. Reduce code size by adding a
> > function for it.
> >
> > It inits the abuf, then allocates it to the requested size.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch with a helper for initing and allocating a buffer
> >
> >  boot/cedit.c          |  3 +--
> >  boot/scene.c          |  3 +--
> >  boot/scene_textline.c |  3 +--
> >  include/abuf.h        | 11 +++++++++++
> >  lib/abuf.c            |  9 +++++++++
> >  lib/of_live.c         |  3 +--
> >  test/lib/abuf.c       | 22 ++++++++++++++++++++++
> >  7 files changed, 46 insertions(+), 8 deletions(-)
>
> This just made me look again at the abuf implementation itself and
> become filled with regret I didn't reject it back in 2021. We're
> introducing wrappers around standard functions and calling conventions /
> patterns with something homegrown (and so not intuitive to others) that
> mainly hides the "sysmem" challenge we also have  and I wish you were
> interested in revisiting how that part of sandbox works instead. And
> even if this is a better design, for the sake of argument, it's not
> something everyone else is used to. And that's important.
>
> If we *really* need something different / new here, I'd rather see us go
> and wrap common/dlmalloc.c with kmalloc/kfree/etc and so give people
> something even more familiar-looking.

The purpose of abuf is actually not about hiding sysmem - you can see
that if you look at lib/abuf.c and the tests. It provides an easy way
to manage buffers, which we do a lot in U-Boot, particularly with
standard boot. It deals with whether the buffer is allocated or not,
so freeing is easy. With expo I want to be able to manage a buffer
containing an autoboot string in high-level code, say, without
worrying whether it has to be realloced.

For sysmem, I don't see a viable alternative, which keeps can reliably
keep addresses consistent across multiple phases (e.g. sandbox_vpl).
Also, I don't believe addresses like 0x7ffff7fbc000 are
human-friendly, yet that is what we would see in tests if we dropped
the mapping. The point of sandbox is to test U-Boot, not expose the
system internals. But we could discuss it if you like?

In general I am sensing that there are a lot of things which bug you
about the direction of U-Boot. and that you feel very differently
about some things than you did in 2021. I have quite a few concerns
too. So how about we make time to discuss these and see if we can get
on the same page, at least somewhat?

Coming back to this patch though, this is really about a code-side
win, rather than anything else.

Regards,
Simon
