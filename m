Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B57DC5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A72EE83285;
	Fri, 30 May 2025 13:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nn6wckD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F4DF82B8E; Fri, 30 May 2025 13:19:03 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A3283285
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:19:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6049431b0e9so2797273a12.0
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748603940; x=1749208740; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FFdXSWCwlx9eDeBmtaa8QqghEnJzWikosFmkoKgHyt4=;
 b=nn6wckD8leSspxylrlsnwZvtEqDzHqwJ1fawMrrn4NX7YbK3ZHJ6ENmvwn/8Pmeub8
 V1QuN5+zT8n94bKehEOBNvc/ax1v0IlcZnxJ6S/Edt8mfZITgqWBZgULsZP/Fa+5XKPr
 GjaipZMpdm3KjbTY9w+lfgGrKRJagpKiy+KIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603940; x=1749208740;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FFdXSWCwlx9eDeBmtaa8QqghEnJzWikosFmkoKgHyt4=;
 b=eJSSLYvx1w4JdHu8oSARgi6zLLOFAgKKmUJzQMPl+ZZ8ur/VD8LyE7XjZt+1LH1q/R
 KHP7ctVdAJ1NtZJ5K6jbS449z3ET8pgPmOEX+Zulp4xHMXLsuN4FeLbxHQczFVS64Ufx
 5ktrStFPWqYXys2yTOaZE1TIm2VRfG9MEYmnBaAEM36Xjc+aXMbr7NQApT2pZi2A/ttt
 CgctMUqzLMMgX4XfsNJFHDrL6quSEy0JAvLXsz6AsnRlOuyu1X6RdjjJGomOWHU7AKZJ
 nZ1oR1lFTqP+u/A4zKQT+UAhbMjisY2OhvivIQgDJPB/f+l2tvQUw2lC12FGUH9lVjvG
 rd7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGalM0Yc1l5K9tx9s1j8a6+Zt4JnxpjAaf67d/gooJk+S1GTY7j+I8ZT2QB43n0Lwa/EqNlMY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxd0Iz2Ch0yjDMmd/omTLPa8i3tOixGqVQ2FfBpQ1fZLRcBr59d
 1HFueVpY2cHI6CEyp2Fs/OdtATY1cEskvbjsFX2AsanYDSThFGMY7f/QXzUnFGV5TquJOJJr1Br
 8ehyBhOkLBYwv2RRxBJx2IalAU9gwiqncLLwA992v
X-Gm-Gg: ASbGncv3RuuqnYcjaVg3dlMTnsfx1ff+0cMIT/zMDDDg4hwi6MTGaDFkQpCYZ4I/aRE
 NPQin05q5bTo6sTpLAWv7nMYm4mOL/cyfH+9q5YaAheQ2YhF5GnBzj0qLV+PdV5kgMmk3YKsAe1
 B09utGwU2MkZyOk+kIqMRY+ZTP5CtvtglEiHDnMW+rFQ==
X-Google-Smtp-Source: AGHT+IEGAeg1kbs5HX5VA+vYFOTQ8zl8bHm3du1vuVkwVt5E9ITD2LkWfA5Vx13IoslVJaGjsH5oirPlGhaucomH23Q=
X-Received: by 2002:a05:6402:3483:b0:5fc:4045:7d79 with SMTP id
 4fb4d7f45d1cf-6057c604633mr1745129a12.22.1748603940349; Fri, 30 May 2025
 04:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:18:39 +0100
X-Gm-Features: AX0GCFsOeGdGOlw0BitU_DwH9dejEXc79n2uj4yeAIhvSG5jcTrn_jFkxn3Tuj4
Message-ID: <CAFLszTjEBdvSPiGCMSxSjMCnQWx2B9qpFZtPObaY-FncNYsLWA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] Fix handling of optional blobs in binman
To: Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
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

On Tue, 27 May 2025 at 14:24, Yannic Moog <y.moog@phytec.de> wrote:
>
> This series solves a contradiction regarding ext blobs packaged in
> binman. When they are marked as optional, by default they are faked, two
> messages are emitted. One says the image is not functional the other
> says the image is still functional. Both concern the same binman
> entry/blob.
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
> The output will stay to inform/warn the user, but in this case the

s/will stay/stays/

We should use present / imperative tense.

> tee-os entry will not be present in the final image.
>
> The first patch makes binman test with --fake_ext_blobs by default to be
> consistent with the default make target when building U-Boot. This
> exposes an error as one test is failing where it should not (loadables).
> Then, fix some tests that must not fake ext blobs and thus failed due to
> the change.

Again I'm still not sure why we need to change the default, but once
we have a bisectable series I will probably understand it better.

Please also rebase on -next

>
> ---
> Changes in v2:
> - mark as RFC due to failing tests. In current state, series is more of
>   a concept
> - Link to v1: https://lore.kernel.org/r/20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de
>
> ---
> Yannic Moog (8):
>       tools: binman: ftest: pass allow_fake_blob to _DoReadFileDtb
>       tools: binman: drop "faked" return value from check_fake_fname
>       tools: binman: mark optional missing blobs as absent
>       binman: replace _entries with GetEntries()
>       binman: rework dropping absent entries from packaged image
>       tools: binman: add faked optional entry case in CheckForProblems
>       tools: binman: ftest: fix tests that require non-faked ext blobs
>       binman: test: assert optional blobs don't cause non-functionality
>
>  tools/binman/binman.rst               |  7 ++++
>  tools/binman/control.py               | 27 +++++++++++----
>  tools/binman/entry.py                 | 17 ++++++----
>  tools/binman/etype/atf_fip.py         |  4 +--
>  tools/binman/etype/blob.py            |  9 ++---
>  tools/binman/etype/blob_ext_list.py   |  4 +--
>  tools/binman/etype/blob_phase.py      |  4 +--
>  tools/binman/etype/cbfs.py            | 15 +++++----
>  tools/binman/etype/efi_capsule.py     |  2 +-
>  tools/binman/etype/fit.py             |  4 +--
>  tools/binman/etype/mkimage.py         |  6 ++--
>  tools/binman/etype/nxp_imx8mcst.py    |  2 +-
>  tools/binman/etype/nxp_imx8mimage.py  |  2 +-
>  tools/binman/etype/section.py         | 62 ++++++++++++++++++++---------------
>  tools/binman/etype/ti_board_config.py |  8 ++---
>  tools/binman/ftest.py                 | 43 +++++++++++++++++-------
>  tools/binman/image.py                 |  4 ++-
>  17 files changed, 138 insertions(+), 82 deletions(-)
> ---
> base-commit: eeb5ff1a468b2303efa9deb2483b5edbebb568c6
> change-id: 20250122-binman_faked_optional-5025f7046e25
>
> Best regards,
> --
> Yannic Moog <y.moog@phytec.de>
>

Regards,
Simon
