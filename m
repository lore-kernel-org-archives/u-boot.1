Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4217CAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 17:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D2C83C93;
	Mon,  6 Oct 2025 19:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dmrhXWNo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D92883CCA; Mon,  6 Oct 2025 19:43:08 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDAF983BD2
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 19:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-330b4739538so5305336a91.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759772583; x=1760377383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ziKhsHAm9t4Dx57vv3qEujEFteC3KoShO6xf52TyxwY=;
 b=dmrhXWNoRJ2Xj7wtqvhFMm6SW3JA4/9CKNjqExhN42/h5Z7F8A0SGwznTcBbGx6ai4
 EVKX/JXGcIMI6rT+PVTy8PtIwCCO4VSp+pOglqU4IWluustpd5jxsZCFkF1laUtOIEDG
 847XUhJV1f/YnmvWyOIWqafpYw+f5CNmXOzA2atlaUtXVzBGCeTqlhBjYaCiHGohuokB
 97/Oydd5lXs7hcOCuKvcRzQ5NixBpeluLtqkc//bW21vJb/P3aepzn3dGrwwLm2/PIWi
 lKsyPUN1XtSXZsmPOWDNzldHJzx5ZiJ6csRWgSgXQj3wNtChD8RliH2MT3utQPDXjBao
 /pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759772583; x=1760377383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ziKhsHAm9t4Dx57vv3qEujEFteC3KoShO6xf52TyxwY=;
 b=tzeRA14uTCY9EEjphSpXvw+Lq2XZ1rebpyyc8gBHUy6dSR7Tyx3Ww5XIT3So+h2pmk
 VQBfdLmiJ4G3OFNx4whUYENYrjbgaICgo/wVWWw6580zDmKNImqEAsv3RviE2GltLKpn
 r8O9AjzpJhmffcCWjZK+SP85NF1q6QdtlLYxy3zm9OIIgh9VQRo/tOxyBSX4P0/V4D41
 m45gwZXYwIxrjuz4TUlVmseobLtMu+JmONWt5Ab1Y5oerLJeLPKzuAvWui8gnOfmZKW0
 w/v2KlmGYSPJ+z/9IkFUX/jaTOWB8rf4+h9YN9ZGPByK4i3Gla9oFRu7HBIDRUZKqQr0
 maLQ==
X-Gm-Message-State: AOJu0YzOYJn9Y90Ynfn5hbPggXjoeq0ssolXetebs4jujNHBIVsqe+6s
 pQRAgTzr5bQ11K44YsOgYfBOmGmIamtrrfHP9Otwmw9YQzc4jH+YEC+Yb8667+vEt5bDP2Xv2Mn
 2bc9wTMy/JbiCpewOhPACprWT0xWmZlOYTJCjKrgClg==
X-Gm-Gg: ASbGncsKdAJx15/TgRYRshJHMeX5brJ72iuT/ZJjCog3euk9fX8nTHX+nSobxgDEbQP
 /H1XMPTTuX+xbDNfgBLkK44AecXaPOhULp4jnQGYBF/lWPTayTMfUYvJcF8jmBLkYkhC9LDeAF1
 2mYmhIDLE+KZB2QzNYFoZUHA58Lx/vlavp784sXg8esf9iQu+iJNwzagAoqrnd/D3TStHzbbSll
 VgQw+nsQDXWvmACBcAPUi2Fr0jd+1ouAc8w
X-Google-Smtp-Source: AGHT+IFo4H7+Fqe51V7nmNOHKgI4E/zd5ZnI4OwOp2yY2nKsrEUTgMvPY91gLo+SVaoM0akV18QhK9uqqRTUGocxBF0=
X-Received: by 2002:a17:90b:3e8b:b0:32e:8c1e:1301 with SMTP id
 98e67ed59e1d1-339c27cf1c6mr15321028a91.34.1759772583222; Mon, 06 Oct 2025
 10:43:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251003192222.767882-1-raymond.mao@linaro.org>
 <20251003201331.GS6093@bill-the-cat>
 <CAEfUkUJa=eTq4MkjosnN1SxA2Aq3ySTZrSiHj3474otN8VLjfw@mail.gmail.com>
In-Reply-To: <CAEfUkUJa=eTq4MkjosnN1SxA2Aq3ySTZrSiHj3474otN8VLjfw@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 6 Oct 2025 13:42:50 -0400
X-Gm-Features: AS18NWDnzRcIdViDpWJ8YGWlG5AF9egxMHZbttK4GtKNuTSht2P708xsUDgs8ew
Message-ID: <CAEfUkUJhYuLzRE5-UkmFY9P+RG5N0sgATzHf+2X-HAF1657_+Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Enable Firmware Handoff CI test on qemu_arm64
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

On Fri, 3 Oct 2025 at 22:04, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom,
>
> On Fri, 3 Oct 2025 at 16:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 03, 2025 at 12:22:14PM -0700, Raymond Mao wrote:
> >
> > > This patch series enable Firmware Handoff [1] CI tests on qemu_arm64 by:
> > > 1. fetch MbedTLS (v3.6), OP-TEE (v4.7.0) and TF-A (v2.13.0);
> > > 2. build bl1 and fip with both Firmware Handoff and Measured Boot
> > >    enabled;
> > > 3. pytest to validate the Firmware Handoff feature via bloblist by
> > >    checking the existence of expected FDT nodes and TPM events generated
> > >    and handed over from TF-A/OP-TEE.
> > >
> > > Pre-requisite u-boot-test-hooks patches [2] are required.
> > >
> > > [1] https://github.com/FirmwareHandoff/firmware_handoff
> > > [2] https://lore.kernel.org/u-boot/20251003191918.767698-1-raymond.mao@linaro.org/T/#t
> >
> > Generally, the changes look good, thanks! Specifically, did you trigger
> > a CI run where you pointed Azure at a fork of u-boot-test-hooks with
> > your changes? I'm a little concerned about the fiptool change and I
> > don't see a CI run where qemu_arm64_optee.. was triggered, only:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12044&view=results
> > where it's not. Thanks!
> >
>
> That PR is missing the last commit (adding the CI jobs) and still
> pointing to the original test hooks.
> I have tested with my local docker container (has a test.sh that
> simulates the one from azure.yml, and points to my test hooks working
> branch) and all works.
> But when I triggered it this afternoon at:
> https://github.com/u-boot/u-boot/pull/818, I did see the failures...
>
> Hmmm, I will compare the log with the one I got from the local docker
> container to find the cause.
>

The github CI seems to not build from the dockerfile, it always runs with:
```
2025-10-03T22:30:41.8339632Z Digest:
sha256:0d2cd4abea187f396a7e77041a6d9ce877314446a154cdcbfbbf546b09a58d09
2025-10-03T22:30:41.8352926Z Status: Downloaded newer image for
trini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025
```
That is the reason of failure.
Is there a way to hack the CI to build the container from the
dockerfile of the PR branch?

Regards,
Raymond


> Regards,
> Raymond
>
> > --
> > Tom
