Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62AFCF58CB
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 04:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 370F18920B;
	Fri, 20 Sep 2024 06:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xr3AhtxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8617892DA; Fri, 20 Sep 2024 06:33:58 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE87E89141
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 06:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c44e1cde53so1899711a12.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 21:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726806836; x=1727411636; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NRUq7M4GWZB7Xh1ar0VPfbYO6HthwKVnlGiKEYCKTiI=;
 b=xr3AhtxCo1OAHdDFG1nD+xeXHH27TG0KijSLHDgLhr0GTeFvLmJzAbXKkUFnS5UcXh
 +QyFjdHhVmMQydtv4P+qKjPJjxGmDu0K/BviA0m0pSdYxXzJXxAMRkAQi6RD9zmSEtAi
 8W2tT46ky2uzC9EozyqzOW922MlnmmqHyMOZKxAXJk8X6wySyvTwn5hbH9FOIwAwAARc
 /dzgQm46/o+pTCbN7JE27+Rl2x2rFTZ3JBpoS8hZfX82FZJsIQI2TCrbX3ShR0jf0Q1W
 g+kF6aeF17Y6d0s9jXmozU8aK2DTL74rXPpQvasZ5zOao7e7nUfAzw6bXuJwmdqsLIta
 vtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726806836; x=1727411636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRUq7M4GWZB7Xh1ar0VPfbYO6HthwKVnlGiKEYCKTiI=;
 b=SIj4m6Zd8hV0E+F6dzdhzDkxOUuAF58gmSONrl3+SPg0qU6oOKoCh1E3sHI2o3JcQg
 E/QZAXaa+fLp3dwjfm0hTWkVsPvHDuh6qIrxQ3PJNj+5XcC+DxcPzR9axTIZAazRon70
 5LNjbLxcL5OhgeWBKHkUX8CB6kxg02EjCuu34BfAcFHS6f5DIaadJH7Z3iEGVt0TQZEt
 KpYVThEDx61LU/SpuDNW8Ks3sdY9InpOugDiSMABubehO5C0ZGdwBC3UwePOT9ZeGler
 7U1vjKps/GPokf0BqaWFBybszrSKF6u0xRKfuU4jTJS/lvg2jxwsdknK//QuV/l75vGc
 fq0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZBCRAGTLbenvBzs/Xsq3h7oMGp6mdFtfjy5G1R/LPx3E2wFAfxaV0rgLWW1qFPunY+dhe06Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmw039PdM/c3c9RDgS5DyxPcfdZuuaC+4FE7RPTm1batTTl8cr
 T+X6IMxfkBinAJZQDlspCqUyLRnlXP6rwUn6QoKrcWpOBqhbDz8nfbGVOuIjiV1tl2ogMC7PuVc
 8xrLtSQBUVx5mSh49GIbWVYfJGwYHsz41jigP5A==
X-Google-Smtp-Source: AGHT+IEHwGA4SURU40XHpA7idBECNgZ5LB+weJN47UijA0Qcg4Ej4yT1dXKsFuyfS0ay5asSahnwQNwu+FTM46Cf2IU=
X-Received: by 2002:a05:6402:51c9:b0:5c4:1320:e5a3 with SMTP id
 4fb4d7f45d1cf-5c464a3f71emr778556a12.16.1726806836146; Thu, 19 Sep 2024
 21:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
 <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
 <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
 <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
In-Reply-To: <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 20 Sep 2024 10:03:45 +0530
Message-ID: <CADg8p96c161nrDDky70k_z+Qjza5Z8ktrvdaDrn6kruMxZsrAQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Thu, 19 Sept 2024 at 19:42, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Tue, 17 Sept 2024 at 13:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Sat, 14 Sept 2024 at 20:14, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 9/5/24 10:27, Sughosh Ganu wrote:
> > > > Add a flag LMB_NONOTIFY that can be passed to the LMB API's for
> > > > reserving memory. This will then result in no notification being sent
> > > > from the LMB module for the changes to the LMB's memory map.
> > >
> > > You seem to be using this in patch 3 and 7.
> > >
> > > Please, describe in this patch why you want to be able to suppress
> > > notification.
> >
> > Will add the reasoning behind this flag in the commit message.
> >
> > >
> > > In the EFI context we should use LMB notification to notify the
> > > EFI_EVENT_GROUP_MEMORY_MAP_CHANGE event.
> > >
> > > See chapter 7.1.2 EFI_BOOT_SERVICES.CreateEventEx() in the UEFI
> > > specification.
> >
> > So, do you want me to use the EFI event signaling mechanism for this
> > purpose ? Is my understanding correct ? If so, this will mean that we
> > have an event notification specifically for EFI, and there might be
> > one needed for any other consumers of this event. Currently there
> > aren't any other consumers of the LMB memory map change event other
> > than EFI, but using the U-Boot's event notification mechanism means
> > that the same notification mechanism can be used if there were any
> > additional consumers of this event in the future. In that case, we
> > would have two separate event notifications, one for EFI, and one for
> > non-EFI consumers.
>
> As I have previously said, none of this is necessary.
>
> Essentially all of the EFI setup that is done in U-Boot can be delayed
> until we are actually starting an EFI app. The current approach of
> keeping parallel EFI tables everywhere is causing much confusion.
>
> For EFI, it should be enough to read the lmb tables at the end and add
> whatever parallel tables are needed to boot the app. We should not
> need to keep things in sync through the life of U-Boot, since:
>
> 1. EFI pool-allocations should use malloc() until the app starts
> 2. EFI page allocations should not be allowed until the app starts
>
> This whole area needs a healthy dose of 'keep it simple'.

Except, the current implementation proposed by the patch *is* actually
much more simpler than syncing the maps when the app starts. Because
there is another scenario when the map needs to be synced, when the
user issues a 'efidebug memmap' command, which dumps the efi memory
map.

Syncing the map from lmb means that the efi memory map first has to be
generated afresh. And that is much more complicated than the method
incorporated in the patch series. Apart from the ram/conventional
memory type, we also need to include other memory types that might
have been added to the memory map. So, this would mean, create a new
memory map, add entries for conventional memory as have been obtained
from lmb followed by other entries, and then discard the old memory
map. And this has to be carried out every time a need for a memory map
update is needed.

-sughosh

>
> Regards,
> Simon
