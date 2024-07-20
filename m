Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F69C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C39188883;
	Sat, 20 Jul 2024 14:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PyQm4Us9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7014886F0; Sat, 20 Jul 2024 14:36:25 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC4188669
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b7af49e815so9674166d6.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 05:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721478982; x=1722083782; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SWjQcrL98v58MaalI+UkMbgVYNeykD5S3YdRQyAjuqo=;
 b=PyQm4Us9CTvQ1+DoiZDFOetAGdPDwNYgjGD/vXfDJIR5N2hxi4WcWuEKVkedL8fF4J
 OeY/hWrvfdkznNs39+2T2w85nOcBFyXX2/tbNqUx5S9/tKQpuSB0G9+gLBtmBv5rOUrM
 MCxz55gJJir8sQRRGTVwtolMOnVXjwaFFcVi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721478982; x=1722083782;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SWjQcrL98v58MaalI+UkMbgVYNeykD5S3YdRQyAjuqo=;
 b=vxSYRmEcHAB4gmSqXBD5b2mcmheZFy0SJXJAKBJEUWpB4KlKAWu/NefAMtPjlWOPGM
 gsVvojWAoWOleP8cMv+HY59ENMNhqMjmxob90FKHC9rgzWIX6G+OkmdzcG+hmb6A99Y1
 0J+OoygMPV9+ybhKUZeI3Eel9WA1YOZf3EPkDfIqai3cJd/oFXkBX1iMdug3qXlC8EJD
 GK8Lf6HUF8daR+loAjFOir80xkXhoneKEhYgDN2s2vGIofDIc3bAuRjDyH5f0JL7oNHf
 oV7PueuZjO97CzqoWQjDOItHTQ8M3BMP2ht5G5yVKtC34+B3afPK/rczAXka3u5tZQkY
 AkcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjG6sQUzAcePUHKx3/QSplO2FqCjQAWWR9exy5+LDnYFw1KtU6ouvWkK2vavLwj2YHIpIAHxThyk6MvpgS+bbnKWaq3g==
X-Gm-Message-State: AOJu0Yzc25+d7LASVJrpy226QtifFmZv0+KwGNkPZl7maOJfIiOqu826
 DfzDsUgfzWxecTqq4gD4LseFbm8L4b1sei2s9/wK1JgfsUEQtX4PZpXlaWFrLGcpeIcGuknq6aE
 Fd6bOsx3UmXKC8tDUWOpI83dwL2WsTy8enVdy
X-Google-Smtp-Source: AGHT+IF8Qx49Mbt84RKj0rSzLgYFlTGDGju84zjZ33nKFACQTf3GfDdOkDbEwEljjTL8x+3XxHXJvu5n4b/up1fmr/s=
X-Received: by 2002:a05:6214:4018:b0:6b5:e202:bd78 with SMTP id
 6a1803df08f44-6b95a74df3amr29478616d6.44.1721478982528; Sat, 20 Jul 2024
 05:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240713070055.2172883-1-sjg@chromium.org>
 <20240713070055.2172883-11-sjg@chromium.org>
 <e3e22587-b573-4d07-8bbf-725802ba3036@gmx.de>
In-Reply-To: <e3e22587-b573-4d07-8bbf-725802ba3036@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 20 Jul 2024 13:36:11 +0100
Message-ID: <CAFLszTiejdjetr4VcOy7g5trfcxkm3BKmgT5ze+zzr5cUGiQng@mail.gmail.com>
Subject: Re: [PATCH v2 10/21] upl: Add support for reading a upl handoff
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>, 
 Lean Sheng Tan <sheng.tan@9elements.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 18 Jul 2024 at 15:53, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 13.07.24 09:00, Simon Glass wrote:
> > Universal Payload provides a standard way of handing off control between
> > two firmware phases. Add support for reading the handoff information into
> > a structure.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   MAINTAINERS               |   7 +
> >   boot/Kconfig              |  19 ++
> >   boot/Makefile             |   3 +
> >   boot/upl_common.c         |  60 ++++
> >   boot/upl_common.h         |  24 ++
> >   boot/upl_read.c           | 588 ++++++++++++++++++++++++++++++++++++++
> >   configs/sandbox_defconfig |   1 +
> >   include/upl.h             | 352 +++++++++++++++++++++++
> >   8 files changed, 1054 insertions(+)
> >   create mode 100644 boot/upl_common.c
> >   create mode 100644 boot/upl_common.h
> >   create mode 100644 boot/upl_read.c
> >   create mode 100644 include/upl.h
> >
[..]

> > diff --git a/boot/upl_read.c b/boot/upl_read.c
> > new file mode 100644
> > index 00000000000..2d8caa6ef11
> > --- /dev/null
> > +++ b/boot/upl_read.c
> > @@ -0,0 +1,588 @@

[..]

> > +/**
> > + * decode_root_props() - Decode root properties from the tree
> > + *
> > + * @upl: UPL state
> > + * @node: Node to decode
> > + * Return 0 if OK, -ve on error
> > + */
> > +static int decode_root_props(struct upl *upl, ofnode node)
> > +{
> > +     int ret;
> > +
> > +     ret = read_uint(node, UPLP_ADDRESS_CELLS, &upl->addr_cells);
> > +     if (!ret)
> > +             ret = read_uint(node, UPLP_SIZE_CELLS, &upl->size_cells);
>
> Why do we need a special handling of addr_cells and size_cells?
> The device-tree provided by UPL follows the device-tree specification
> which requires to set these properties in the parent of the node.

This is just decoding the information so it can be used later as
needed. For example, we might want to validate that it is correct
before using the data.

[..]

Regards,
Simon
