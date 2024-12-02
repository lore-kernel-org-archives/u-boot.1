Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E23ED10DCF
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 09:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420AE8953C;
	Mon,  2 Dec 2024 10:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tDELhIbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E178F8953B; Mon,  2 Dec 2024 10:54:16 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8BD8952E
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 10:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ffa97d99d6so41304961fa.1
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733133254; x=1733738054; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=m2HOGmJDcPbpnPkqFamYbZtSfxfwy23S8rp+N/C0ji8=;
 b=tDELhIbcufuBu9DHtxlXPZT43VePhG0IQKx523ZzRJk8PapwkSO/lfFkTfzHahyQ29
 a+sVLxn39c0GwxFKjFOaZhlZq6EKRha7LGNix8WrHsOMiCZCHZaSOTZkKzlLOr0yAYcz
 PUxbyzTawIMllRXGWsGSpPqwjPDQFeHJEZQTlr40JYjlxVGIx0S8Dx/48rNorKAPa3Ib
 HCIc2aw2XhBV7eewHrev2tHVhOpMApLy2hDpczJjpzzSkupIodJXZZEICPa2qGCyahNR
 +Frq4bNvYWhEnAlFvX/zKZEuoTqVclQ1wNcb6nB+RiR8eZvLFgD5oM4AaEWdIfpKYueH
 UDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733133254; x=1733738054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m2HOGmJDcPbpnPkqFamYbZtSfxfwy23S8rp+N/C0ji8=;
 b=fjjtIrzW2ENi7SSLLKYpr7iLJxKepui5rEfuYK3aL3gnx7kv8iaYVj/3jjkq5VEiJD
 Ia4I7z4eXkydubxrv5bGdynTDX6Ywz4jDrtF7u35GtUCm9Od+87GFSl/DG8OIspmjJVz
 pKzY/ilKQJG/hpIFwOBMeI18CgJDvUmmHoINU6SnIIuGCzRbIqVSNuYTDgEri3vFky0n
 UwyX9ONSzui82Icl6Fb6jX1ZkinZ6Y7/y6cvwrqIGQaL++Rfm4BpcU9R63xxhqKJvROb
 0WVlrzayBR/0cI3yaY96uMoRGEUFddzn/IejuqRF9dkvZgO6gb2A+BaVOFbysjx3t9fF
 4ngA==
X-Gm-Message-State: AOJu0Yy1crPFwgtHzLu1mfCm4bUzYSKKjOv4pktORrPg6FzALXKvft7R
 2i3/CcI7aQ/9xUK8Bt5Cp9ysT4YrodryVqjBvA8lwW/R4JdGiJQISi6XoXY0/Oo+TEHLUV2KTRa
 QRMmwy2B/KLAuOQyTWrUOGRBw+zD456giONr1JA==
X-Gm-Gg: ASbGnctLgkCt1HkEPxV5gYK8Y9yZMWwOeMRE50mFY677bDsxaCo5SUCVLon/BUnUc4T
 9iT6xDo51J+SGmtAXO6yKaRSHOq1fPjyE
X-Google-Smtp-Source: AGHT+IF7dYOdtHIw1EWg45UlYq1orQjLIYk8cGGBgElzVFXajSzN5oFCHZFJr4w2iSlFeP/kvJ7Widdpmksg6Kol1Rk=
X-Received: by 2002:a2e:a547:0:b0:2ff:c027:cf5c with SMTP id
 38308e7fff4ca-2ffd60ab5fdmr94355851fa.16.1733133253584; Mon, 02 Dec 2024
 01:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20241025111411.165904-1-sughosh.ganu@linaro.org>
 <20241025111411.165904-2-sughosh.ganu@linaro.org>
 <CAFLszTgpUOpjMogv5q0EhLHe-i=VBYHtdaGyBp6as99BkbE0pg@mail.gmail.com>
 <CADg8p95SAYvhTaAYWOSHmZXNbyuNdB2=_2Mhwdn8eU+aBtNioQ@mail.gmail.com>
 <CAFLszTjXS9XQmENZ29saUzsmcz9jHw7kowvUWa1jzCvfPVix5A@mail.gmail.com>
In-Reply-To: <CAFLszTjXS9XQmENZ29saUzsmcz9jHw7kowvUWa1jzCvfPVix5A@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 2 Dec 2024 15:24:02 +0530
Message-ID: <CADg8p95BZosOvS2vY+sSSHzcq5GQzqNYJUAaeUTa5PX3KYsfMA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fdt: add support for adding pmem nodes
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Mon, 28 Oct 2024 at 22:32, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 28 Oct 2024 at 12:29, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Sun, 27 Oct 2024 at 20:30, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Fri, 25 Oct 2024 at 13:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > From: Masahisa Kojima <kojima.masahisa@socionext.com>
> > > >
> > > > One of the problems OS installers face, when running in EFI, is that
> > > > the mounted ISO after calling ExitBootServices goes away. For some
> > > > distros this is a problem since they rely on finding some core packages
> > > > before continuing the installation. Distros have works around this --
> > > > e.g Fedora has a special kernel command line parameter called
> > > > inst.stage2 [0].
> > > >
> > > > ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> > > > don't have anything in place for DTs. Linux and device trees have support
> > > > for persistent memory devices. So add a function that can inject a pmem
> > > > node in a DT, so we can use it when launhing OS installers with EFI.
> > > >
> > > > [0]
> > > > https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/installation_guide/chap-anaconda-boot-options#sect-boot-options-installer
> > > >
> > > > Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  boot/fdt_support.c    | 41 +++++++++++++++++++++++++++++++++++++++--
> > > >  include/fdt_support.h | 13 +++++++++++++
> > > >  2 files changed, 52 insertions(+), 2 deletions(-)
> > >
> > > Can you please use the ofnode interface for this? We are trying not to
> > > add more of this kind of fixup, as it means someone will have to port
> > > it over later.
> > >
> > > See EVT_FT_FIXUP
> >
> > Are you suggesting using the EVT_FT_FIXUP interface for adding the
> > pmem node? If so, how does this work on platforms which enable
> > livetree? Looking at the code, I see that the EVT_FT_FIXUP gets called
> > only when the livetree is not active. However, I am not able to find
> > any place where the livetree is getting disabled. We do have a
> > function, oftree_to_fdt() which flattens a livetree, but I don't see
> > it getting called from anywhere except from a 'upl' command. The
> > of_root pointer does get set in initr_of_live(), but apart from
> > dm_test_pre_run(), I do not see where we disable the livetree and set
> > of_root to NULL.
> >
> > So on platforms which do enable livetree, how does this fixup work?
> > What am I missing?
>
> It isn't implemented yet for OF_LIVE in image_setup_libfdt(). Most of the code is there though. It just needs to be hooked up - see oftree_to_fdt() and oftree_from_fdt().
>
> The idea would be to remove the of_live_active() check, so the event is always sent (will need to 'select EVENT' for OF_LIVE).
>
> Then in that same code, after the event, call oftree_to_fdt() and copy the fdt back to blob.

Sorry, I got pulled into other tasks, so could not reply to this
earlier. Looking at the code, I don't think that using livetree is a
good use-case in this context. What is happening here is that the
image_setup_libfdt() function gets called for fixing up the devicetree
before the OS is called. However, in this case, we cannot assume that
the FDT that is being passed to the OS is the same as the livetree.
What that means is that it would be required to first convert the FDT
to a livetree, apply the fixup's and then again convert the livetree
back to FDT. I can understand why you would want to convert a FDT to a
livetree during init, and then use the livetree for driver model init.
But why do we need this transformation to and back from livetree in
this context, only for adding a node to the FDT.

-sughosh

>
> If you have time, it should be a nice mini project and will allow us to migrate more things to the ofnode API.
>
> Regards,
> Simon
