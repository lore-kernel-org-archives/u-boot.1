Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4AC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:40:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B47D48881F;
	Mon, 15 Jul 2024 13:39:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aD1wvOuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08EC888872; Mon, 15 Jul 2024 13:39:47 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 777D588853
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b5f90373d4so44004746d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043583; x=1721648383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1kt2+kTbmXLbCAxYtWZmHb3GHUlwu/yXLWfuCHgU3Rw=;
 b=aD1wvOuvG/CqmpqFRs6/+rYQ6PGNO4p0pC8zmD84nqhz8OzEq4aXCOqXijf3IPWGTw
 ESmAhBLj0KzOjn9jyTDpwZzvOBdhH7uovhNiu/NA7AXfP20rM2JkVwBM+O8rZ0iItsCe
 qT7M3HNXEMYtcKnTkRtNocRqE0ZKsB1LI1RWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043583; x=1721648383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1kt2+kTbmXLbCAxYtWZmHb3GHUlwu/yXLWfuCHgU3Rw=;
 b=UTZT08QVGyQZ2aAolemlJY8WcgtDVVYWSPzXXEXCz8zMx/RUcFOEkYdWmWQUpX3Nll
 6aF95ExBnzwOAuCchuAm+pNgM5IFprq0usUm2IwtTcqM0zqVNANvjiRyc9cG8NmPI7oE
 e8h2A7WsEfcgQConSQ3j/0eV86F9zUod5WE5hQBK6WlKzsQ/zO2J+GPEBiohRqkbOreB
 212yrzsvcNx2yjEw7ULGxTcNSqoqGPVOX/BpZGN4AoG1C4wiAa3HMA7oeWtt8TjE9Wiq
 pFEX899mkjUIFV1z51mxOpWzVulPdP8dzmEClkVkmpItFLI0CQqm5nPBwULgYaggB6si
 LH7w==
X-Gm-Message-State: AOJu0YyhVqG9Uf3AaYzvW7+CnLLPgGJXYp1JKtpD3zJRtcg+ZsCSCqNQ
 Hl8QGEOj5DN8zpSD9Pf8x7gWHOYrC87S+VCiBA9OOUFmJaU86/FWqwKvpIYiFPL2Qu3SkufX6vz
 hcUzHHvjI/8LRifEVsUSavIySaBcSKziWr5D4+nYsuLxGGi8=
X-Google-Smtp-Source: AGHT+IECUO64RflWdaxnkOq0MiwFZoloOav27AdQVJNnYgcvW53J8Qo6bmfzCyVtQcLp5XUBYqhWy4ayq+AZzBP+Wnc=
X-Received: by 2002:a05:6214:622:b0:6b5:684:2d5 with SMTP id
 6a1803df08f44-6b754d225f6mr171934956d6.4.1721043583400; Mon, 15 Jul 2024
 04:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
 <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
In-Reply-To: <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:32 +0100
Message-ID: <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sughosh,

On Mon, 15 Jul 2024 at 10:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > There are events that would be used to notify other interested modules
> > > of any changes in available and occupied memory. This would happen
> > > when a module allocates or reserves memory, or frees up memory. These
> > > changes in memory map should be notified to other interested modules
> > > so that the allocated memory does not get overwritten. Add an event
> > > handler in the EFI memory module to update the EFI memory map
> > > accordingly when such changes happen. As a consequence, any subsequent
> > > memory request would honour the updated memory map and only available
> > > memory would be allocated from.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Handle the addition of memory to the LMB memory map.
> > > * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
> > >   based on the type of operation.
> > >
> > >  lib/efi_loader/Kconfig      |  1 +
> > >  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > >
> >
> > This is getting complicated and I don't believe it is needed.
> >
> > EFI should not be allocating memory 'in free space' until it starts
> > up. For the very few (if any) cases where it does, it can do an lmb
> > allocation.
>
> EFI memory module is not allocating memory at all now. This patch is
> adding an event handler for updating the EFI memory map, whenever the
> LMB memory map changes. All the EFI allocations are now being routed
> through the LMB API's.

OK

>
> >
> > As to the lmb allocations themselves, EFI can simply call look through
> > the lmb list and call efi_add_memory_map_pg() for each entry, when it
> > is ready to boot. There is no need to do it earlier.
>
> So in this case, I believe that rather than adding code in multiple
> places where the EFI memory module would have to get the LMB map and
> then update it's own, I think it is easier to update the EFI memory
> map as and when the LMB map gets updated. Else, we have a scenario
> where the EFI memory map would have to be updated as part of the EFI
> memory map dump function, as well as before the EFI boot. Any new code
> that would be subsequently introduced that might have a similar
> requirement would then be needed to keep this point in mind(to get the
> memory map from LMB).

That doesn't hold water in my eyes. I actually like the idea of the
EFI memory map being set up before booting. It should be done in a
single function called from one place, just before booting. Well, I
suppose it could be called from the memory-map-dump function too. But
it should be pretty simple...just add some pre-defined things and then
add the lmb records. You can even write a unit test for it.

>
> This is not an OS file-system kind of an operation where performance
> is critical, nor is this event(LMB memory map update) going to happen
> very frequently. So I believe that it would be better to keep the EFI
> memory map updated along with the LMB one.

I really don't like that idea at all. One table is enough for use by
U-Boot. The EFI one is needed for booting. Keeping them in sync as
U-Boot is running is not necessary, just invites bugs and makes the
whole thing harder to test.

Regards,
Simon
