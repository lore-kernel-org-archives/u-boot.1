Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E4EC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:08:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B8B6807FE;
	Mon, 10 Feb 2025 14:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a7eZCdx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901D380AE1; Mon, 10 Feb 2025 14:08:46 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4376D803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f464b9a27so68909595ad.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192923; x=1739797723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wGGPRu+M20FtJJL0Kwd/TNmy4EkdgDgY+/ihmC3H7pg=;
 b=a7eZCdx6JtFOEZaBjMlrElcqvjyxP6bDvjM0V2ep0TxqA2vNN5tH1Ezc0jOwc/A7Kn
 aFALM+af6tv4/Ua+6ZHdFN6qB+y6d7IFXmjm6lOi+SXJRtYe3v/nkzXvNfAxr044mFNq
 fhAwhL9vvmzRSCZxISo48VedgcBh4iPfMxNMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192923; x=1739797723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGGPRu+M20FtJJL0Kwd/TNmy4EkdgDgY+/ihmC3H7pg=;
 b=jkuqEa35lv7xYTYp3yYdu+Npdrb5PRnZOakYtFD7McKwSYKhUKVBwyafSl1AgLbk2C
 ltTqEGDK6Y+xVjt7s/vnCIosI4igPr3feP5YmU1TuBe7AmBElJbhIyIc/hMHt6xUObet
 GdKSdSbOsdkSjT3JbX54xU20rDLPqy4QOLfgrQ+7sTpgK3nujuJK7lVdfs8UhM0lvzos
 hzjCFvylMx0n6nJGGrDFpRurZYjHxfhWNLcBGKwy0m274fmZtXJs4GQrzwTPUUXVqB22
 EgUch4daOW/6Lq8sMZ+oLn8gNTVyz8XiERYgR94OEt7fgKtwNQag2pHevOKCVvGA5nqy
 C9Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBTE7K8pD1e+yLAlnBvz5hzzudttQW7FPKX/JYPgESZo9RdwGbE4UWIFBxICtPhbd4sIay6WI=@lists.denx.de
X-Gm-Message-State: AOJu0YxDpEkDMEAvpoKHHfaOnygcZ0/sQVKoM2byJ36vRZD8odVTdfgq
 SyyYD9oK7V/JxMmraBSgBN6kjNfQQ6oKaIu7kA78kAb5/UTMz9FGo0Ye2h327TjfGkjtr3XJSPj
 zQvOdv3IYTfHGSS7PaXPRl9QDctDzFOhZkV2J
X-Gm-Gg: ASbGncuEq2NfzO19sOYoRvimKNDfsXmxtt7JbORRz+yuaNtoqJMADEVgCH2s3xee8pK
 8ZInOebbFjwChRCioB+hrD6sUzKyPz6NFsrJGfYTdHgB1qWaaYzOYHnF10mWphmYO+wojMK018A
 ==
X-Google-Smtp-Source: AGHT+IEFHpcGWOTkcEJiykgpHbDp/+6ZpIxCZ14H/YwePLEP5mm2kWLInvfPufoI7vtjlQkOZKl2RjELaUM6YTSFm4s=
X-Received: by 2002:a05:6a00:2992:b0:730:9446:4d8a with SMTP id
 d2e1a72fcca58-73094465302mr4172495b3a.16.1739192922825; Mon, 10 Feb 2025
 05:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:08:28 -0700
X-Gm-Features: AWEUYZlxceixk-WRsfptwT8UMyhQVGhG1hYOgjroTBhoR7FAplTV-ty2sQ9xsk8
Message-ID: <CAFLszTh7JYQYzAdW6-+EcaNj6tGy32QVQU3=n+dszFRmT6yFow@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Fix handling of optional blobs in binman
To: Yannic Moog <y.moog@phytec.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>, 
 Yashwanth Varakala <y.varakala@phytec.de>, upstream@lists.phytec.de,
 u-boot@lists.denx.de
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

Hi Yannic,

On Wed, 29 Jan 2025 at 03:30, Yannic Moog <y.moog@phytec.de> wrote:
>
> This series solves a contradiction regarding ext blobs packaged in
> binman. When they are marked as optional, by default they are faked, two
> messages are emitted. One says the image is not functional the other
> says the image is still functional. Both concern the same binman
> entry/blob. To solve this, don't emit a warning when an image is faked
> AND optional.
> Make binman tests consistent with this behaviour.
> Add regex to test cases checking that the non-functional
> message is indeed not emitted. Update the documentation to inform users
> of this interaction.
>
> Binman is set up to have fake external blobs in case they are missing.
> This is regardless on whether they are optional or not.
> The implementation does not allow different types of entries to override
> the faking decision; at least there wouldn't be much sense in doing so.
>
> Here is an example build output of a phycore-imx8mp:
>
>   BINMAN  .binman_stamp
> Image 'image' is missing optional external blobs but is still functional: tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Portable
>    Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin
>
> Image 'image' has faked optional external blobs and is still functional: tee.bin
>
>   OFCHK   .config
>
> The first patch makes binman test with --fake_ext_blobs by default to be
> consistent with the default make target when building U-Boot. This
> exposes an error as one test is failing where it should not (loadables).
> Then, fix some tests that must not fake ext blobs and thus failed due to
> the change.
> Further, fix the behaviour of binman itself as explained above. Fixing
> this bug also makes the loadables test pass again.
> Finally, add test coverage for this new case and extend the
> documentation.
>
> ---
> Yannic Moog (6):
>       tools: binman: ftest.py: fake ext blobs per default
>       tools: binman: ftest: pass allow_fake_blob to _DoReadFileDtb
>       tools: binman: ftest: fix tests that require non-faked ext blobs
>       binman: fix faked optional entry handling
>       binman: test: assert optional blobs don't cause non-functionality
>       binman: doc: update Optional entries
>
>  tools/binman/binman.rst |  9 ++++++++-
>  tools/binman/control.py | 19 ++++++++++++++++---
>  tools/binman/ftest.py   | 43 ++++++++++++++++++++++++++++++++-----------
>  3 files changed, 56 insertions(+), 15 deletions(-)
> ---
> base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
> change-id: 20250122-binman_faked_optional-5025f7046e25

Thank you for looking at this.

Regards,
SImon
