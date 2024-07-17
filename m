Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7456C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 07:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52FD8886D7;
	Wed, 17 Jul 2024 09:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GD6POkBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94BD885F4; Wed, 17 Jul 2024 09:59:03 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1812288606
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso9946707a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721203136; x=1721807936; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=31vV5qEif+SpIv8RyWlOOx7NAcPZUjX1udzlxg2MyPA=;
 b=GD6POkBziQ2jW4up9w8VBpxMuVvHWRJiD4QZcLeh90AvgD85O7Ujn5lIk7/UcqguHt
 OoxzSUX+SLvpgZGmW0eeQpZdqXb6vKa1PAA/NpL9g82IPZXkfRtXPanqmcEGWP+vPtT9
 2d5GkDgGCmLdFALyUCtkEJ/QKAgmWmduk/kxTfBy5yEl8dzB9K1GFx7UQbo04XF0I91o
 26GPCo6MLdPPfI6psVZnvniRLDP9f1OjRvN9Hr6/SYctMam8nKTPolFQrqDhxmRU1p0R
 Pz79w1HheoEMhrlEoeNWhYb2QtYYx9OH4Oh9DFhOANz0lHpnNV5zaVzGf780/+r61ohr
 B3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721203136; x=1721807936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31vV5qEif+SpIv8RyWlOOx7NAcPZUjX1udzlxg2MyPA=;
 b=YSWgPhUvCYfRiSE/12WaTxR7rL+gbrG8cSZTe2b7cENgXpJ68wO8bO3jpTKc3+Di1q
 JPE89bic960cqFEnWcIeTrktnuWnEdi5LcyPXE0q3Ffl1xlZfMt9lYD3kIQ+xSFYaco2
 OfQ7c+q7LLoOngUOx6sFXTzBxudQQPHXhQrmoOW2dnByHVhyGvK0vv35YHZcmPayoj2a
 eCNuXpLILIiOfm6tsj1UB0t9FsfzSN746dD/5Y1KcxSFnN91Q3XrNf6dxk2khiKEUWYx
 7CUlmy0Ud3GFePbLe+bQHXv/E+bFTYHs86B6+IudO6OpRLz5zXM+bkpW/Cm9ev/oDJRX
 yaTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkZxI5BBSJnDpaCczLWi8ZiLMcJPcePTBP6BOA+OWFtZ4ejxw6YOV6ZmrCRfmSbWrexLTsgPlsHftYZcKuvdfU82DIcA==
X-Gm-Message-State: AOJu0YzTGrbOiylo0m5pTx4hIsJHyRaLRw+VKuCluazcK6rAMPfPZfON
 3p4LOe/EnGka8xUdZqMxoDvUhiX19jsKPnZEKqn2iHrkYGoVgU+KpCl8dyHq0DoTdK3KS/tjalN
 R8uFJHsjQ/5uLiKTmjdkgBW4202Z6XCUZsZ5p6g==
X-Google-Smtp-Source: AGHT+IGEviBsSextmovdSSjybPKQQMyD9f+vFte0qh7y6z4lAHNnvhVMmPr8RUrHKnj09htcE/KtiyJXhGrtdXWAHNI=
X-Received: by 2002:a50:ccd8:0:b0:59e:dbb4:f8f8 with SMTP id
 4fb4d7f45d1cf-5a05d3d4862mr643897a12.28.1721203136325; Wed, 17 Jul 2024
 00:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
 <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
 <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
 <20240715190534.GA561963@bill-the-cat>
 <CADg8p972kWS9DY_xmNm2uBAz5-y_LtSy0dq2eRTf5dJMCranCw@mail.gmail.com>
 <20240716170028.GF561963@bill-the-cat>
In-Reply-To: <20240716170028.GF561963@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 17 Jul 2024 13:28:45 +0530
Message-ID: <CADg8p94M0ZCfsnUuzThMTMfyV7eyrzHK72LO32FO2a72RKdJag@mail.gmail.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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

On Tue, 16 Jul 2024 at 22:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jul 16, 2024 at 11:55:10AM +0530, Sughosh Ganu wrote:
> > On Tue, 16 Jul 2024 at 00:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Jul 15, 2024 at 12:39:32PM +0100, Simon Glass wrote:
> > > > Hi Sughosh,
> > > >
> > > > On Mon, 15 Jul 2024 at 10:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > hi Simon,
> > > > >
> > > > > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Sughosh,
> > > > > >
> > > > > > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > > > >
> > > > > > > There are events that would be used to notify other interested modules
> > > > > > > of any changes in available and occupied memory. This would happen
> > > > > > > when a module allocates or reserves memory, or frees up memory. These
> > > > > > > changes in memory map should be notified to other interested modules
> > > > > > > so that the allocated memory does not get overwritten. Add an event
> > > > > > > handler in the EFI memory module to update the EFI memory map
> > > > > > > accordingly when such changes happen. As a consequence, any subsequent
> > > > > > > memory request would honour the updated memory map and only available
> > > > > > > memory would be allocated from.
> > > > > > >
> > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > > ---
> > > > > > > Changes since V1:
> > > > > > > * Handle the addition of memory to the LMB memory map.
> > > > > > > * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
> > > > > > >   based on the type of operation.
> > > > > > >
> > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > >  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
> > > > > > >  2 files changed, 35 insertions(+)
> > > > > > >
> > > > > >
> > > > > > This is getting complicated and I don't believe it is needed.
> > > > > >
> > > > > > EFI should not be allocating memory 'in free space' until it starts
> > > > > > up. For the very few (if any) cases where it does, it can do an lmb
> > > > > > allocation.
> > > > >
> > > > > EFI memory module is not allocating memory at all now. This patch is
> > > > > adding an event handler for updating the EFI memory map, whenever the
> > > > > LMB memory map changes. All the EFI allocations are now being routed
> > > > > through the LMB API's.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > >
> > > > > > As to the lmb allocations themselves, EFI can simply call look through
> > > > > > the lmb list and call efi_add_memory_map_pg() for each entry, when it
> > > > > > is ready to boot. There is no need to do it earlier.
> > > > >
> > > > > So in this case, I believe that rather than adding code in multiple
> > > > > places where the EFI memory module would have to get the LMB map and
> > > > > then update it's own, I think it is easier to update the EFI memory
> > > > > map as and when the LMB map gets updated. Else, we have a scenario
> > > > > where the EFI memory map would have to be updated as part of the EFI
> > > > > memory map dump function, as well as before the EFI boot. Any new code
> > > > > that would be subsequently introduced that might have a similar
> > > > > requirement would then be needed to keep this point in mind(to get the
> > > > > memory map from LMB).
> > > >
> > > > That doesn't hold water in my eyes. I actually like the idea of the
> > > > EFI memory map being set up before booting. It should be done in a
> > > > single function called from one place, just before booting. Well, I
> > > > suppose it could be called from the memory-map-dump function too. But
> > > > it should be pretty simple...just add some pre-defined things and then
> > > > add the lmb records. You can even write a unit test for it.
> > > >
> > > > >
> > > > > This is not an OS file-system kind of an operation where performance
> > > > > is critical, nor is this event(LMB memory map update) going to happen
> > > > > very frequently. So I believe that it would be better to keep the EFI
> > > > > memory map updated along with the LMB one.
> > > >
> > > > I really don't like that idea at all. One table is enough for use by
> > > > U-Boot. The EFI one is needed for booting. Keeping them in sync as
> > > > U-Boot is running is not necessary, just invites bugs and makes the
> > > > whole thing harder to test.
> > >
> > > Doesn't that ignore the issue of EFI being re-entrant to us? Or no,
> > > because you're suggesting we only update the EFI map before entering the
> > > EFI loader, not strictly "booting the OS"? In which case, maybe that
> > > does end up being both cleaner and smaller? I'm not sure.
> >
> > And that is my concern here about having to update the EFI map at
> > multiple call points, instead of keeping it updated -- I feel this is
> > more prone to being buggy. And to add to this, there might be code
> > paths added subsequently which might need an updated EFI map where
> > this gets missed. The only downside to the current design is that it
> > might be slower since the EFI map gets updated on every change to the
> > LMB map. But I am not sure if the LMB map changes are going to be that
> > frequent.
>
> To me the question really is, do we have a single entry point to the EFI
> loader that must always be used (and is before EFI loader must know for
> sure it has up to date memory reservations) or are there two or more
> points? If there's two or more points then yes, your current approach is
> best as we don't want to introduce problems down the line. If there's
> one (which is what I hope), then we can just make that entry point be
> where the resync happens.

There are a couple of places where the memory map gets used, one from
the external get_memory_map API, and one from the 'efidebug memmap'
command. But they do call the same internal function to get the memory
map. So that function can be the common point of getting the current
memory map from lmb. This will mean that we expose the lmb structures
into the efi memory module. I will put out an implementation and we
can see about it at that point. This will be part of the second part
of the patches that I will be sending. Will work on getting the lmb
patches out first.

-sughosh
>
> --
> Tom
