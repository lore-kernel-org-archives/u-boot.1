Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F74D10A1E7E
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8642181E18;
	Thu, 26 Mar 2026 12:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y8UjTIgF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28D15838BB; Thu, 26 Mar 2026 12:44:46 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99FDE80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:44:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b97bca3797dso129227766b.0
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774525482; cv=none;
 d=google.com; s=arc-20240605;
 b=iITtJ4OlaZ9m0r6j6JhK9qfec1NVuf9rwZlUk+2iw2KKwT2bSjWKP/H12IgFp44QLg
 8DlJUw82RwaHMi3jisAmXDDxhONMTcqEJTn+eneC/YEH9hTz9DYv1VvRQu1vOYiJ88WL
 T0OY4/kk9lAtVxK4/FggBBAEV2ClA2shRijzXZmYiLF3yuIsz8Z730qXzdnzM+63vibE
 MLh1TvuBIwVwWe7XMUG/WiUuCiG0rWPkQ1YepZXunSoMa4ylVywBgB743CeWX77/P6No
 EEzaJCBHxn0ZI298jSrqAUtCacvajt/dLtHi8RBjYJueDK8wzZLtZcjD3WX/AaKvoQKQ
 9QbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4y9y7lyP+1FRFZZcjs1d+YMhW7aJVaDfgNIAWRj3Frw=;
 fh=X+TXTfimi8ikLXygKYSNqmXeuVlv5IEYi0IesntAZJo=;
 b=B0a4knPmTlglOowluXOoRudUw48XbeIGozgBzwMjW7hbAvxsHT68TSH8TrrMQZuqOE
 SVOG9yW40jj67m4c/+QZrT8XuQjVZ33WN6aJWfy6b/vUs2X2aEWA2zs2EHnXjCZCQrso
 pvHrMkT9/+eHUCJgsKXjlGaN1DPdiiw369gJDQNPKRT/JJXFi4ejuCI2/Ih3SNdJRphE
 cDpZXftwXJko4X9ZTDUDiKgpPZNhR5N44Zo/OXY/tFV/jh926FFXUtYqwxtJizgODecm
 uxs2kNwqasHz9MM9r7E0S9Vs/tV/s6xFCia/ln8O0pDRl2tdBRI7wTgKeTxSp+U9hftP
 tOjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774525482; x=1775130282; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4y9y7lyP+1FRFZZcjs1d+YMhW7aJVaDfgNIAWRj3Frw=;
 b=Y8UjTIgFycOirUP6dfAyNiGlPLBeElzv33uABH3aH+Nn+Q7uehKHy5pz+yW6/8HK1q
 LYObEwjB507Mvc8iwV966FHgV31lIhg3vRHew21Qy+N9TSSXOAm2DuWfNA180poPTBfy
 Q1e0PoyPOIAAijtdciAN+h82kkdlq/x+WDMcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525482; x=1775130282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4y9y7lyP+1FRFZZcjs1d+YMhW7aJVaDfgNIAWRj3Frw=;
 b=oAl7eal9g1YglUoxSQ8yCGt0LnkVh0dP3douFTGzWo+OwECo3NKOcYcxoo7GbPeAQp
 nYnfHaKIHzCSQIFLj5iQrk+nkTl0qp8JiGzFST6uVFeYJiZe8ike70QBOW/vxkACFpg1
 f/rwfzA6Qy+RMWG/8/4J29zgk+QH3+zSbLdhvOowpGONuFkk96jiKl3wyzjEjLpjSPyz
 s/Ij4pU3/M+EXoStBI0uslNwqRpLUtZsntmgF7Ndp+TJ0ZkwU6fOWl/6+9XRhFnZxe4k
 /Yujb2t9uvMop16m3ATlu9abKhJs0A0SWOlM9nSJaCBLYO+pwn/vlTQUlVzI4Qs0zPgn
 ddlQ==
X-Gm-Message-State: AOJu0Yz74MjrfTPeh1HkdEbAa9i8VL+jFSQweyJWXVDuTfUQjXBvxSIF
 2O3prKlAAkAs/srg8DMH5usQdouk8e8FTjY7K7qX55FDXZRDfM4bqDV1PJb0B9Lg7vL7Bnk/5lI
 o4OZubXIj2UQ+JtA1qL4EePo08C901m9YBkjQMCqF
X-Gm-Gg: ATEYQzwvpyHWtQBWj6TPERAJuw55QHf3psRLnEdTS5K3ZbiazH3EO3WSFBvoiNNFAJY
 olX4Zb3MKxAkdOlzUt19WAPQqQjDAUDyqOdv5HvIi02L9kdrXFgZ1zLPvmv913MtAwRVf51RYMW
 crX5ZoVs/GH2DGzR2DVdBj6dkQkeKvJMDiUGg9QaUxhet6JHeDEXk7uEyc+avX0feZt++IhCgLv
 28BhM3gSUn6bSYl1K3K6OjuA8pPT9As5U5/zQdjPvCz1zD7mouKMKTIM9KJzc+beYaILM9v3HOo
 7m+Oqrg=
X-Received: by 2002:a17:907:1c9a:b0:b9b:1ea2:97d3 with SMTP id
 a640c23a62f3a-b9b1ea29afamr251235166b.35.1774525481810; Thu, 26 Mar 2026
 04:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
In-Reply-To: <20260325201806.GA3445024@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Mar 2026 05:44:29 -0600
X-Gm-Features: AQROBzBEyg8_WkNN4QJ5_pc5bMALHiIX5LjYCO7w2-pUJwLzVDqpgr9aVu7lZAA
Message-ID: <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
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

Hi Tom,

On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
>
> > Various updates:
> > - c4 lack signing so does not currently build
> > - samus hardware is non-functional
> > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> > A sample run is here:
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
> >
> > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > broken on -next
> >
> > The ff3399 board needs some investigation.
> >
> >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 36 insertions(+), 10 deletions(-)
>
> I have two sets of problems with this patch.
>
> One, it doesn't do, but perhaps I wasn't clear enough when bringing it
> up, change it so that failure to pass is a job failure (it's currently a
> warning). This in turn means people can't tell expected failure from new
> failure.

It looks the same as sage...can you post a snippet of what the rules should
be? It shows failure for me, when the lab fails.

>
> Two, when you had previously gone about adding at least colibrimx8 I
> noted that this extended how you were having labgrid build U-Boot in an
> even further non-upstreamable manner. As the sage lab yaml shows, we can
> bring in external binaries for buildman (and binman) to find and use.
> We'll need to extend that logic a bit, to be sure, but it's a solvable
> problem with the baseline already there.

Not quite. Buildman builds U-Boot, it's just kicked off by Labgrid (via a
U-Boot 'provider' class), with some pre-built Intel binaries for x86, plus
BL31, etc. put in as environment variables. My design approach is different
from Sage, in that I often connect to boards interactively, send U-Boot
over USB in some cases (so different files are needed depending on the
board) and at the moment I have all boards connected to a single server.

Labgrid has 90 open PRs, including my terminal one
<https://github.com/labgrid-project/labgrid/pull/1571> from over a year
ago. There definitely are PRs getting in though (20 so far this year). In
terms of upstreaming, my approach has been to break things down into
smaller PRs, but four of them are still outstanding after 18 months. I did
ask on irc a few times but didn't get a response.

Regards,
Simon
