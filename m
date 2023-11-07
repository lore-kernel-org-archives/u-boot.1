Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73171C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 01:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F6786F1F;
	Tue,  7 Nov 2023 02:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mV2rrzkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC048870C4; Tue,  7 Nov 2023 02:09:22 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D92886F1F
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 02:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so8795894a12.0
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 17:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699319360; x=1699924160; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nbsg0bwrNJxSUezHOf3l0cMr1ujsgt5ZsaJrj3sL6zI=;
 b=mV2rrzkg3T8tw2O28JxO3Oj9fZ+B95N53vitmgmGFHFUpIWdXmqNGXN2wSowJM/WnY
 EUMTxkXHw596PTkdmsQKwr1ncbiIiBTWnqlDSJM/ignejNGv685zHoi6AqgbpSDNSuwR
 14zLzxF9fYb64Qs9VVi5ruahUABMPx0Ad5KDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699319360; x=1699924160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nbsg0bwrNJxSUezHOf3l0cMr1ujsgt5ZsaJrj3sL6zI=;
 b=SNblWUE/DH6et5XDhbID0AZ5VoyIDv88bqc1GwIxNqi9XhWf4XUM+ozTWQ/gFI4wgb
 7J+N6MgSsBc0wN0iq6v0Tdiwon43nSmiCl+Wyrr/+pV4FWrl6XikZmo8xC2zDPvsk1yI
 1EI14OMArjZ9zD9FsT8FjThpnROKHf9R+Bj9aSDZys/djAJSWi6Qn+6Ls0cX5ZPK1Bpe
 j9JxJ2dHpdiAs7nk3Afi66bB5o4mhUogXK3W3Mxl8ZkeTY8Zkfr75aeE2fu7ISmfbYXd
 T747wIuY2yZweqWYQZZAomgcURYYj73LTOVMhM6/8oVBVuTa8Wcv6sfE3VI/OXHcVg0H
 KK/g==
X-Gm-Message-State: AOJu0YzYxNqZHXx8B/p6kEz7tZrmjTUiTIrQAHByfi5EbCTbdoYnVfqE
 y9PKeq4+iu04i60+Y3/7LJSJ9XfQHzWExnicmx3O6A==
X-Google-Smtp-Source: AGHT+IEV5gwkopltZ3nTJlXpGq4CbQ1iAaSmDnruH9KsVFGkETSfty92hRBhOdvKnzJXbogJX9Zbbr94dnADWVUrvi4=
X-Received: by 2002:a05:6402:2031:b0:532:c08a:eac0 with SMTP id
 ay17-20020a056402203100b00532c08aeac0mr25856704edb.26.1699319359917; Mon, 06
 Nov 2023 17:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20231105200453.1887418-1-sjg@chromium.org>
 <20231105130351.1.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231105211910.GE496310@bill-the-cat>
 <CAPnjgZ26DyfvayO8BgQvCoEVDfmxotG7A7GMWc9T0wK0Okho8w@mail.gmail.com>
 <20231106183020.GB496310@bill-the-cat>
 <CAPnjgZ20ZY3SO3sXWjNk6uAvgBKcNK+XRRs+k0MmrTcj6A1zjw@mail.gmail.com>
 <20231106201553.GF496310@bill-the-cat>
In-Reply-To: <20231106201553.GF496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 01:09:08 +0000
Message-ID: <CAPnjgZ2KffTHNYGjD_fwL7nS=FFLBRxetGcYO2gPVRTPL5OaPA@mail.gmail.com>
Subject: Re: [PATCH 1/4] bootm: Allow ignoring the load address with
 kernel_noload
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

On Mon, 6 Nov 2023 at 13:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 06, 2023 at 12:58:46PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> >
> > On Mon, 6 Nov 2023 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Nov 06, 2023 at 10:25:00AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 5 Nov 2023 at 14:19, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Nov 05, 2023 at 01:03:51PM -0700, Simon Glass wrote:
> > > > >
> > > > > > This image type is supposed to ignore the load address. But at present
> > > > > > it fails if the load address is missing. If it is zero, the image is
> > > > > > loaded at address 0, which may not work on all boards.
> > > > > >
> > > > > > Make use of the kernel_addr_r environment variable, instead, since this
> > > > > > seems to be a more reliable final address for the kernel.
> > > > > >
> > > > > > Another option would be to create a new Kconfig for this, or to use a
> > > > > > region of memory known to be free, e.g. calculated from the DRAM banks.
> > > > > > But in any case we should try to avoid conflicting with the
> > > > > > kernel_addr_r variable. So the approach in this patch seems reasonable
> > > > > > to me.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > How are you creating the image in question here? A noload FIT is
> > > > > supposed to just supposed to go from where it is. Where do things fall
> > > > > down later?
> > > >
> > > > The image is Image.gz built by Linux, for example. So compression =
> > > > "gzip" which means that it has to be decompressed.
> > > >
> > > > Things fall down as soon as U-Boot looks at the image, since it
> > > > doesn't have the ARM64 magic.
> > >
> > > Can you provide logs and env? "booti" is supposed to handle this case
> > > already, and if it's not we should figure out when / why it broke.
> >
> > Do you mean booti handles compression? Yes, I can see that in the code.
>
> Yes, you use "booti" with an Image.gz.
>
> > But in my case I am using bootm, since it is a FIT.
>
> Shouldn't this be handled by the normal compression = "foo" logic? And in
> turn is that what's not working? If so, the commit messages aren't
> clear.

We are on the wrong commit here. See this one:

https://patchwork.ozlabs.org/project/uboot/patch/20231105130351.2.Ie34b75c75347a1c04bffa780220afe9011b0e2bb@changeid/

Perhaps this is supposed to work some other way, but to me it seems
quite broken at present.

Regards,
Simon
