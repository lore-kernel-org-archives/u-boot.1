Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED9D0E6F1
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 11:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD40A88E59;
	Mon, 21 Oct 2024 13:13:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mB7YJ7oG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E7388EDA; Mon, 21 Oct 2024 13:13:04 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8018897F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 13:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6cbceb321b3so32223106d6.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 04:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729509180; x=1730113980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NZ9B5XKaDv7/kjFNJ4ZMSrDGKnRrw0dzjVy2eXFRF7o=;
 b=mB7YJ7oG7LSdhY5PemKjVr9Oj6y9WbsusXQt8aqKx47UIU/bB4izcUwvtItP+e+XIk
 YyEv+CAhjq096VLiK2mMzWOo9F8rT45tGzllDZ253HYjojNQnSA0HirFgWGGmUsq56x0
 mqUiWrD6lmK1Q4EbRuNxNEcis6abW4AmNOZwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729509180; x=1730113980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZ9B5XKaDv7/kjFNJ4ZMSrDGKnRrw0dzjVy2eXFRF7o=;
 b=CVYBNUma48F5hgNHH72ai5udXkzx8UbaryOnSrgJM1scQoDMA7DX2k+KYx+Ke3TFKR
 YrVADXXotA3pUnSiifjp0SUfKlaUIpeaYQtcs1zvONE8MG7bR2M52RZ49nJfEYL+jU4H
 U1pchPOZsF4dM1g19aneadGXOBNqIBhfX5OLK1gyU+hb/gfnGHnXwLRoofSoDwUQRPCc
 uZCRSl5DgGvovC9lDfGi2EOaAyIELevo+4VhlsSbv1JX3puDsCPsrGF8OAxhTvsGI3/6
 /6mCzzNACEvG4PDKOGUWVdR2uYf2rhG+0avU7dp9GwRWBbmuftn9l9NKs9htaiDTVqzY
 YQ2Q==
X-Gm-Message-State: AOJu0YzK4rqsFqP/K95VNDN+CDlddxrzmgSR9cDa8p+gzWnu22rv1yZp
 n4CrPgVscMavBVuz/P9Xnu3ogH5phTNE8ZdR6vFHqlN7vlFmJ9WZKE43kbkk+UxRhOZ0bGrOpRa
 amd9RWwfyqqoSBYY7iFjRfmF4fainfQXk504vf4qN44PjsFMwLiNA
X-Google-Smtp-Source: AGHT+IGYySjIQBA6JwUtunKXqD1hsXR5Gm5R6Tb3xRqiybyhu9guPCdZxCkhSDPtuRB5Dx1AEfVcHzGRp1KbKIZ1UNM=
X-Received: by 2002:a05:6214:5b03:b0:6c7:c7ff:958e with SMTP id
 6a1803df08f44-6cde150789amr161712156d6.18.1729509180243; Mon, 21 Oct 2024
 04:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241010015145.1977999-1-sjg@chromium.org>
In-Reply-To: <20241010015145.1977999-1-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 13:12:49 +0200
Message-ID: <CAFLszTjT+yh70hRQ-7chXbQdE4Q_wzU1+Rom39+UtUOPc6HfGg@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] labgrid: Provide an integration with Labgrid
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

On Thu, 10 Oct 2024 at 03:51, Simon Glass <sjg@chromium.org> wrote:
>
> Labgrid provides access to a hardware lab in an automated way. It is
> possible to boot U-Boot on boards in the lab without physically touching
> them. It relies on relays, USB UARTs and SD muxes, among other things.
>
> By way of background, about 4 years ago I wrong a thing called Labman[1]
> which allowed my lab of about 30 devices to be operated remotely, using
> tbot for the console and build integration. While it worked OK and I
> used it for many bisects, I didn't take it any further.
>
> It turns out that there was already an existing program, called Labgrid,
> which I did not know about at time (thank you Tom for telling me). It is
> more rounded than Labman and has a number of advantages:
>
> - does not need udev rules, mostly
> - has several existing users who rely on it
> - supports multiple machines exporting their devices
>
> It lacks a 'lab check' feature and a few other things, but these can be
> remedied.
>
> On and off over the past several weeks I have been experimenting with
> Labgrid. I have managed to create an initial U-Boot integration (this
> series) by adding various features to Labgrid[2] and the U-Boot test
> hooks.
>
> I hope that this might inspire others to set up boards and run tests
> automatically, rather than relying on infrequent, manual test. Perhaps
> it may even be possible to have a number of labs available.
>
> Included in the integration are a number of simple scripts which make it
> easy to connect to boards and run tests:
>
> ub-int <target>
>     Build and boot on a target, starting an interactive session
>
> ub-cli <target>
>     Build and boot on a target, ensure U-Boot starts and provide an interactive
>     session from there
>
> ub-smoke <target>
>     Smoke test U-Boot to check that it boots to a prompt on a target
>
> ub-bisect <target>
>     Bisect a git tree to locate a failure on a particular target
>
> ub-pyt <target> <testspec>
>     Run U-Boot pytests on a target
>
> Some of these help to provide the same tbot[4] workflow which I have
> relied on for several years, albeit much simpler versions.
>
> The goal here is to create some sort of script which can collect
> patches from the mailing list, apply them and test them on a selection
> of boards. I suspect that script already exists, so please let me know
> what you suggest.
>
> I hope you find this interesting and take a look!
>
> [1] https://github.com/sjg20/u-boot/tree/lab6a
> [2] https://github.com/labgrid-project/labgrid/pull/1411
> [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> [4] https://tbot.tools/index.html
>
> Changes in v7:
> - Rebase on testb series
> - Expand commit message
> - Rename option to --use-running-system
> - Rebase on broken-out testb series
>
> Changes in v6:
> - Rebase without an earlier patch
> - Avoid doing the special shutdown unless USE_LABGRID is enabled
> - Drop patch 'test: Pass stderr to stdout'
>
> Changes in v5:
> - Add a few more comments
> - Comment out the debugging, which might be useful later
> - Add a patch to support testing with two board-builds
>
> Changes in v3:
> - Split out most patches into two new series and update cover letter
>
> Changes in v2:
> - Only disable echo if a terminal is detected
> - Avoid running a docker image for skipped lab tests
>
> Simon Glass (11):
>   test: Allow signaling that U-Boot is ready
>   test: Release board after tests complete
>   test: Allow connecting to a running board
>   test: Introduce the concept of a role
>   test: Introduce lab mode
>   test: Improve handling of sending commands
>   test: Avoid double echo when starting up
>   test: Try to shut down the lab console gracefully
>   test: Add a section for closing the connection
>   test: Support testing with two board-builds
>   CI: Allow running tests on sjg lab
>
>  .gitlab-ci.yml                        | 153 ++++++++++++++++++++++++++
>  test/py/conftest.py                   |  73 ++++++++++--
>  test/py/u_boot_console_base.py        | 123 +++++++++++++++------
>  test/py/u_boot_console_exec_attach.py |  31 ++++--
>  test/py/u_boot_spawn.py               |  36 +++++-
>  5 files changed, 363 insertions(+), 53 deletions(-)
>
> --
> 2.34.1
>

Is there any news on these patches? I would dearly love to enable my
lab and this is what is needed...

Regards,
Simon
