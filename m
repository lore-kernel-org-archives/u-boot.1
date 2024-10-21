Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA1D3C53F
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 06:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50708892CF;
	Mon, 21 Oct 2024 08:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gX2rWEdB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D774A892BA; Mon, 21 Oct 2024 08:31:25 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BF94890D1
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 08:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbe68f787dso25224756d6.2
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 23:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729492282; x=1730097082; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jAUhaNu2nJi6nCa/ovkAYx8FV9y+xdUjS87cXax8NDs=;
 b=gX2rWEdB8XsgvJ3kY7YcZhvpBK3l6jnmwZtPRDJpYzmKRNL6y8WMJSkclz+I90Dp8m
 e3Dkqm/4Njo+WEi+QA9I8vTc68uMkykk+hd2dht79Kzzg1WujOoqfkBUd+1LE8I7OKpX
 /Cm+/w3qwyN/sQpcTSF0BBRgpmStTkg4qsqgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729492282; x=1730097082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jAUhaNu2nJi6nCa/ovkAYx8FV9y+xdUjS87cXax8NDs=;
 b=prOO/dO8H29DY0hXQ/RI+l4FNWq+CvcCU+fy7eIXHIYrO7zKy9LfJQuGzwBPg6Nva4
 gRUJ0czjCfflLQ1xHpyHI5xzNjgMduZ9cuv8EdOxtNZForsIrs407YpDpqBIGTFhOYMB
 buH/QgnSG2Y0tKDa+xGtEqGjl580nTo9KVVAJ0AfXzeHR7qJjr75cy1uChJGSrSIikgQ
 +09Z+eP/FfCCQjBQX+jmovw20bpoBWZxZRAuamw+xHc9M3inFijyTDKft+zMG6qaWUVY
 dcqx6YSW4/ETqLBSMnxefsVZ38Y+HW2QQOBd6Rt8WGSDfF8TPvsD260paWvcurF5S2gr
 x+Hw==
X-Gm-Message-State: AOJu0YwbU3UFEa0GWxf3illzE5Ra8QL/qLGFmhym2nuxUP+2C/3TzsAt
 dq/KzrkVjThGIYNOxt63kvjhe1OJwkzPxyRc6qxiGqsYfeg0ieebZNBQkmQs2eS8aa47a6OMpaj
 Qacdp9g8As2E9NNijkMq6SZ8hgQ9bTgLFNIZt
X-Google-Smtp-Source: AGHT+IECgNSORS/zhjcL4diHIo99YVcqoh8w9/ZY1/i/ydbKLta90rkdvGeZsLkuVjcTcnuPr/Tqg8/St52XbgF1pfQ=
X-Received: by 2002:a05:6214:3a01:b0:6cb:e860:eae6 with SMTP id
 6a1803df08f44-6cde14b8d46mr130213496d6.5.1729492282109; Sun, 20 Oct 2024
 23:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241019152434.1017394-1-sjg@chromium.org>
 <20241019152434.1017394-7-sjg@chromium.org>
 <20241019175121.GA4959@bill-the-cat>
In-Reply-To: <20241019175121.GA4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 08:31:10 +0200
Message-ID: <CAFLszTgBzr_nYtFKFEuHBLBUUF8qq92y+i=bzsVaKsHyt-990Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] test: efi: boot: Set up an image suitable for EFI
 testing
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Alexander Gendin <agendin@matrox.com>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
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

On Sat, 19 Oct 2024 at 11:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 19, 2024 at 09:24:33AM -0600, Simon Glass wrote:
>
> > Create a new disk for use with tests, which contains the new 'testapp'
> > EFI app specifically intended for testing the EFI loader.
> >
> > Attach it to the USB device, since most testing is currently done with
> > mmc.
> >
> > Initially this image will be used to test the EFI bootmeth.
> >
> > Fix a stale comment in prep_mmc_bootdev() while we are here.
> >
> > For now this uses sudo and a compressed fallback file, like all the
> > other bootstd tests. Once this series is in, the patch which moves
> > this to use user-space tools will be cleaned up and re-submitted.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > ---
> > Here is the patch to avoid sudo and CI fallback:
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/
> > 20240802093322.15240-1-richard@nod.at/
> >
> > (no changes since v1)
> >
> >  arch/sandbox/dts/test.dts           |   2 +-
> >  test/boot/bootdev.c                 |  18 +++++++++-
> >  test/boot/bootflow.c                |   2 +-
> >  test/py/tests/bootstd/flash1.img.xz | Bin 0 -> 5016 bytes
>
> This I think best illustrates the problem with "BOOTSBOX.EFI". This
> image will work for CI up until I can figure out how to get access to
> free arm64 servers to run some tests on and then it will fail.

I don't believe so. Why do you think that?

BTW it would be good to get CI running on arm. I believe Linaro might
have some servers. I keep thinking of getting an Ampere device but so
far have resisted as it is UEFI with closed firmware...

>
> This is also an ext4 image and while the specification only says SHOULD
> for being FAT32 there are practical problems with using ext4 and not
> FAT32 for us (some missing features in our ext4 implementation that
> prevent variables from working) and so should be done as FAT32 and not
> ext4.

OK I'll update it.

IMO FAT32 is one of the things that will kill EFI eventually, if they
don't sort it out. It just isn't reliable enough for commercial use,
unless no one ever writes to it.

Regards,
Simon
