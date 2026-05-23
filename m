Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574F8CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF620846DE;
	Sat, 23 May 2026 11:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J5dnEzkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D26846DF; Sat, 23 May 2026 11:18:39 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E8A846AD
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso16234518a12.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779527916; cv=none;
 d=google.com; s=arc-20240605;
 b=E3b44nnVuVvV626DvHzqMZ7JYmvQIYa7kzxbEMAvjvDbuc3GyLSsWGVLsLR59J/XVl
 d+cto+rTPf5bTVaX+tBn1cn0NHKvLwXlBxabPEJqb7R2NmyDfcaQ1RY3HuY4AgxBA9rq
 vJXfjzc7S047TaJCMvhSIGr46+7jb9gFB36Nlt6qXnrI/9FcdqgfxyDTFH0BbWosLzc6
 owYJmGyRUPWg+vZ4sFm/Ezr/zh9g03VSSjP7A295sr7dH+KpFlOyp7SYvQhz3MAroelz
 HgdSHduaVDiFUKyYLoqn3338Ctt/zqpci2/nQW2GlP6p1ldq4EN4Sd4aOiAfI4czsqfw
 NDyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6J3Q4/a+qIEvkJyOYz0+thsEbBM1MCRDjX/A2BVCPY0=;
 fh=eus/h/Wwn1Dgb5y8AuEJvlipQcHShBrTtHNhFHGg5Wo=;
 b=O2o6KbnSsNOUyePmZtUA0cqktgqgq7XBr824JMOEuXeNi1t5AFHNoPF/vFo/DICBAq
 dU0QB9S9gi429cOpIjDa4oCqLgxHNVrzGjDVv8lRH1HrPTGPyzBe1QQQM3EfmAL5Pkj1
 XSx8866FXNo5kJljUskYoux5g7nHOwMvpK4ILqfIMfIhfMR8h8ACZWKILSYa9/FOtFqa
 KQL1hNc75ns335zKtU87akS4FUrrJIzX6MEH0Li41lLXbOitGEJ576IudN0AJZoX/TvC
 kWuBlMjSlWcLCaP60mnuIgXzxlvxBq9LwbFOUbM4g0b8uO5bLWefXeo9ml+IcFMcebLs
 hjgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779527916; x=1780132716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6J3Q4/a+qIEvkJyOYz0+thsEbBM1MCRDjX/A2BVCPY0=;
 b=J5dnEzkR/ifzr5X4ldAoFW1ySkx4rVRFInwKqyP1WL3IFbvRFp9RZcEc3hqa3KsR6H
 RnSIquUc50KmzqYcfif8ALyhDR8PxgAIESYoGFpZ7m2qFFsgAEUWQZV+fcN7M3j1OVJ8
 BpcUMEVQwUEnFVKghIKbEoH7GhXn2G5S/gfyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779527916; x=1780132716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J3Q4/a+qIEvkJyOYz0+thsEbBM1MCRDjX/A2BVCPY0=;
 b=KdF8MoJsmf894SaCj3ngSN7pz8KT+C+mK61AXvrwtxnjwf4etVLFRt8YRVsYeZ3dhS
 y/3VH+3KXPY7LYHrhI5qjO9jCLNg10C820IE2M2yYuBZFYR+X3Z/gmoaM366rdTp0bIB
 3sOJEInz3SqxQ5MwEI+2IgzL3g4Aynsmej6C5neNFjK6JiIYcUCBEqv9Suh/oMtI2ezx
 a8Kc8I6Xue1pFXke0gjgVtlUhXwOHnlLtkDJ8HDtSmhT2YwjTAE6ri/LEwby5J2PeSPG
 61LtSSiOrdAgeU9v0Xod0yxelB/OPROY6A/tY0zVDDGQFrNJ4f55fX0Utwj4mKmhtLPl
 aadA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sCz0CaFN0UzTZ1JMu+4SLztMV1DpzAvYAh0Pffcp6SIjgECpzv/K6xNaa8y2FFHMt0vXTyGY=@lists.denx.de
X-Gm-Message-State: AOJu0YzdbAVaRFh0Ri2oAHyA5ABFFp/vfUyOAYHbwJkiK8MZ+4hyGpvs
 1Iq0u69Mg22cTu1sM4Hf6+DLkT4G4tth+tafk+T58BtL3EardxK6i9T365In2Ihs7G6lFZ7WfLO
 52dMPx0H15h3lC1U8Ah89bbd7J6Qbr49qhvvAHyZR
X-Gm-Gg: Acq92OHlEua4bhPNl5p0SBbZxvlu3TWzqng0tGtspr662hQnyMPZORIZo0mSx7Vyzgn
 oALElvTtNisPmtjlrQiluVVAWMAWbsnCqdWgu7UFbtfkTHhGTszehH4us31Y4a541K5unf0ywLb
 63/x9q+w8lUarzhELGv6OryDtXEu9rlfjsYgEr2FJl0RJQsBJh7Pgtl2ApgN3Gjt2l+M0nH1+JR
 UmT8ZmV5aQnMxzmN92HIxJzohJcuNft4NUDcgvY3TaC4flOYt1EFwJdoYkm0yNyXQDH3pGkZpmj
 IzQuwA==
X-Received: by 2002:a17:907:da5:b0:bdb:5c26:d499 with SMTP id
 a640c23a62f3a-bdc0181ccdbmr569239766b.22.1779527916382; Sat, 23 May 2026
 02:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
 <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
 <20260515182441.GI1858239@bill-the-cat>
 <CAFLszTjHaqck4gVDSiBw0M9V3yZLzUa8+EjaW94G9JcO=-Ny8Q@mail.gmail.com>
 <20260515184434.GJ1858239@bill-the-cat>
 <CAFLszTj616BX3ppdVLeR1mcRnXLJ41uUpQkC7gY0NOSn2ffkbw@mail.gmail.com>
 <20260518173002.GS1858239@bill-the-cat>
In-Reply-To: <20260518173002.GS1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:18:23 -0600
X-Gm-Features: AVHnY4JY3oN_-AvbTsA0FOZSzOp94_-a_UDyUzJSoMfCrjTIbFaPJsniYb3WS4k
Message-ID: <CAFLszThVwEOzRnNWpihXYx=rXLwcL8Z0qfpouTaA5D2P9NN+ag@mail.gmail.com>
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
To: Tom Rini <trini@konsulko.com>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 upstream@lists.phytec.de
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

On Mon, 18 May 2026 at 11:30, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, May 17, 2026 at 04:52:10PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 15 May 2026 at 12:44, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 15, 2026 at 12:32:30PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 15 May 2026 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, May 15, 2026 at 12:13:50PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> > > > > > > > >
> > > > > > > > > > A file like rm-cfg.yaml accidentally left in the source tree root
> > > > > > > > > > shadows the board-specific copy. binman builds the wrong YAML, the
> > > > > > > > > > resulting rm-cfg.bin may match a different SoC, and we end up with
> > > > > > > > > > the following error:
> > > > > > > > > >
> > > > > > > > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > > > > > > > >       Boot Notification response failed. ret = -110
> > > > > > > > > >
> > > > > > > > > > Move the board directory ahead of the srctree root so that the
> > > > > > > > > > most-specific match wins.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > > > > > > > ---
> > > > > > > > > >  Makefile | 2 +-
> > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > > > > > > > --- a/Makefile
> > > > > > > > > > +++ b/Makefile
> > > > > > > > > > @@ -1682,7 +1682,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
> > > > > > > > > >               build -u -d $(binman_dtb) -O . -m \
> > > > > > > > > >               --allow-missing --fake-ext-blobs \
> > > > > > > > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > > > > > > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > > > > > > > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> > > > > > > > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=$(of_list) \
> > > > > > > > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > > > > > > > >               -a atf-bl1-path=${BL1} \
> > > > > > > > >
> > > > > > > > > Why do we need to look in $(srctree) itself?
> > > > > > > >
> > > > > > > > See for example:
> > > > > > > >
> > > > > > > > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =
> > > > > > > > "arch/arm/mach-k3/keys/custMpk.pem";
> > > > > > >
> > > > > > > That's not great, I'm sorry I missed it at the time. I wonder how easy
> > > > > > > replacing that key is with a non-dummy key. Hopefully it's done in a way
> > > > > > > that doesn't encourage checking private keys in to repositories..
> > > > > >
> > > > > > Typically we would use an environment var passed in from the Makefile,
> > > > > > as we do with BL31, TEE, TI_DM, etc.
> > > > > >
> > > > > > >
> > > > > > > > Also, people sometimes put files in the source tree, e.g. BL31 images,
> > > > > > > > in the hope that they will be found.
> > > > > > >
> > > > > > > That's also a bad practice and what BINMAN_INDIRS is for.
> > > > > >
> > > > > > Yes, but that came quite a bit later with the bintool stuff (2021).
> > > > > >
> > > > > > Anyway, with a bit of work I believe we could drop the source dir.
> > > > > > Would you like to look at it, or should I?
> > > > >
> > > > > Well, the first step would be getting some more feedback on how people
> > > > > override some of these files for example. Even more environment files
> > > > > seems like a bad idea and I'm not sure what BINMAN_INDIRS can't cover
> > > > > today.
> > > >
> > > > Assuming you mean 'environment variables', we do need the actual
> > > > filename, not just the directory. We could have default filenames for
> > > > each entry type, I suppose. Some do already.
> > >
> > > Yes, I think moving that way is the right direction. I was going to use
> > > -scp-path=$(SCP) as an example of something to move away from, but it
> > > looks like that's already being done in a way BINMAN_INDIRS should
> > > handle.
> >
> > Yes, the idea is that '-a scp-path=$(SCP)' tells the scp entry-type
> > the filename to use. I'm pretty sure we could update the tests to set
> > that entry-arg, so we don't need the source dir in the path.
>
> But we shouldn't need anything at all if BINMAN_INDIRS is set to include
> that path. We currently just have "scp.bin" in the dts file. Adding
> -scp-path was a solution that made sense at the time, but as we've
> needed to deal with more blobs, we added a generic solution, and now
> just need to deprecate and remove the original per-blob solution.

We still need the SCP option in Makefile though, right? For BL31 we
often have different filenames - see the Rockchip rkbin directory, for
example. So we cannot always use the same filename.

But if you are just saying that we should define GetDefaultFilename()
in scp.py (to return 'scp.bin'), so as to avoid needing 'scp.bin' in
the DT node, then yes that should work.

>
> > But in any case this patch is correct for now.
>
> Agreed.

Regards,
Simon
