Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880C9CEBF98
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 11:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CC48890EB;
	Fri, 27 Sep 2024 13:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TaSLo8R6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2A7890F3; Fri, 27 Sep 2024 13:08:16 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E451890C6
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 13:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-719ba0654f9so1679664b3a.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727435293; x=1728040093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wrJdDhVXT3ZVuMRX5avKU6IENjOD3rdb2IJr0aE7P5c=;
 b=TaSLo8R6DzNYyFmxIbnaRzn1kj2UL8WWjmuhKh7EIJAUoxe+d9l3Nl5PP90ZZTV4gI
 BMdTu5GEDEA8lE0H0FlGuKlsFJg7mgI7lumSaEzpmrM0i90TUqy7yrDJI57/lP84k0iB
 4AbZrPzkgOKfMR9FwLxA9YeH2uAi21JFyrgxgtzrnaEBdldyylvCkyQiA1PghAjsATIX
 N+V/sze2NjGYy7QgASlMy3f40KJ4s4gN3kxlZOXyMtt/1t7sEuOcdUKMuh6Y7Moinp3s
 qeLM8GRliEmMXkrQNNyedsmMaOmwyPciHQ1RD8FLElbKeO7VxE1QLTCr53AfulqO3L5H
 op/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727435293; x=1728040093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wrJdDhVXT3ZVuMRX5avKU6IENjOD3rdb2IJr0aE7P5c=;
 b=ocAyP8VLQP17KS+iI5BNCGsmlrjjkwaxUTuw3iv1fcKBROyVy+dslsATJR3q3tSIk2
 SGMOndYfN/LIOD+3UR7Z+uJB4sYBWk40JMEwklnukhbSGoHJbI4LIkDAxQeo8YreqWE7
 Qqz19Uu0Mhns+LWGmKUnt7YiU/NyMBeBc5Q2zXANGLTYWU9v9dw4N29yFSNbgPf3ivT3
 mMRrbMYAuUqPENyXYO0EJTpjaWgot0vLW1Ci+JV1kswW6KIaKQI9qXUBXQivvFM33rL9
 euYMVLpX/BBNhVmBMAH+3ZwLj8Iq88sG/KI1ifIntUx0WCaFONOtOu8EVtwY7QrxUkVM
 RopA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqY+/h3nfTtZEP8QOL5yHuqReadiO0pZEkeAVqg9KOHpdBN/6S6kgpK4JQCWsJmSZWJg0zkOQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzbKalb2FWwcZrBm99MVYLXtqw8zdQiC3SLEP5fypCymA3OmDDN
 +t9790GCEVz3/KeivPy8jQCopCxKl09KHLcCrWjLpYLmkLOQ44vX6zERZi1wrPq27XT5tZLGk2Y
 8a6mKFJ4blphlCLj/o5M1lMEP3ZrRRgn/Ry8jGw==
X-Google-Smtp-Source: AGHT+IGBtyQkhX/M0+YLEuMeNLmxZBACJ0C1+BWB/FyQjZ7tiGZxdW5CVgVdu3qeONfkG10uNt2EQl3kqtzmSrfrNa0=
X-Received: by 2002:a05:6a00:2e87:b0:717:9154:b5b6 with SMTP id
 d2e1a72fcca58-71b25f3dae9mr4272025b3a.7.1727435292520; Fri, 27 Sep 2024
 04:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
 <20240905082811.1585467-3-sughosh.ganu@linaro.org>
 <b83d04eb-bc3a-4387-b812-6973d851ae90@gmx.de>
 <CADg8p95VsW99mr=Y62_DYeRvrxBDT9zEz+H_nrt6oyYM76f1dA@mail.gmail.com>
 <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
In-Reply-To: <CAFLszTjitzss7SCPhO8_wuRdXWVmF20M4pbxWjkXO0Ef9nyiVA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 14:07:36 +0300
Message-ID: <CAC_iWj+c375QaygfGwbHBKCr7ruaksHe85so3Nx5rr144coo6g@mail.gmail.com>
Subject: Re: [PATCH 02/16] lmb: add a flag to allow suppressing memory map
 change notification
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Simon,

On Thu, 19 Sept 2024 at 17:12, Simon Glass <sjg@chromium.org> wrote:
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
> until we are actually starting an EFI app.

Can you explain how you plan to deal with EFI variables, the TPM
eventlog, measuring events when tables are added, capsules updates etc
etc, which expect certain EFI services to be up and running?

> The current approach of
> keeping parallel EFI tables everywhere is causing much confusion.

Apart from all of the above the EFI app can return. Which makes all of
the above just a burden

>
> For EFI, it should be enough to read the lmb tables at the end and add
> whatever parallel tables are needed to boot the app.

Yes apart from the fact that LMB has no idea about memory types or permissions.

> We should not
> need to keep things in sync through the life of U-Boot, since:
>
> 1. EFI pool-allocations should use malloc() until the app starts
> 2. EFI page allocations should not be allowed until the app starts
>
> This whole area needs a healthy dose of 'keep it simple'.
>
> Regards,
> Simon

Thanks
/Ilias
