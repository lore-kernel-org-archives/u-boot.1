Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67952C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4B08785C;
	Wed, 13 Dec 2023 21:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YsEnmH+3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D744987869; Wed, 13 Dec 2023 21:41:18 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA3D8784D
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1fae88e66eso407507566b.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702500076; x=1703104876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1cAHZUN/YiFKJcw2Ebtcl+7jhvrTtgeR68hspfMmDk=;
 b=YsEnmH+3pgLj9bAhu3lUhnO2vE8Wb47mnyujtgpfe6vma+35ooZBNPHElciqM/SA20
 vALqpV40uoGdJAVodyU8ugG9A4KviyQifmHKMtCWthl+6iu4tJV41qYn52MzCKwOKEAG
 3vCJDx9Mk5Z+fHL8eYXrWFeJLi4uJ5zFUKWzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500076; x=1703104876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1cAHZUN/YiFKJcw2Ebtcl+7jhvrTtgeR68hspfMmDk=;
 b=flIBQxcrO+Z8mdU31uXvbblMp9AYP0je6kE9xthPz9ZFMROThL1R+JgKd4LJjUobRz
 KC3nigbzg/0Akg3hifdkc8ctscTqOXmtlVmxDcQkVMBiE/KiA2h3fg8AzZsQdXC3kKGm
 yAv/j32D/NNPFiBneS+an18KFMt/hvqeTys9CyewQeCcN5DVUQuiV6GMSDoZbYI1I1zW
 Y98S0hv5hpXO4Qv2DQBwWdAix3yNEh4nUeoWSQ+Q7qp0QEpilvheFYvBYzygdA8AzEfl
 J4kV00qvqggfs+tr+fQlgoZuBhT0OeNUkm5E5ydNz7qd0dURHuWDtyF70Xhw+fLPXoSF
 9m4g==
X-Gm-Message-State: AOJu0YzJSER0TB67p3+LO2or0coouGVsxQeNRQcyaw23DPD5/rmhlU20
 wf9/g13a+KI4gmAAiFg7P3nHZTCUZchzW90t940xfQ==
X-Google-Smtp-Source: AGHT+IFzmIeFRmZ+h6cTVDZa29ZcnqWfH6P9aWS/v36ffQSvFeBux/iItXzZ8QhCizgoek8ZelKFh5RmHNW5mtx5PCk=
X-Received: by 2002:a17:906:8e:b0:a22:dca4:26dd with SMTP id
 14-20020a170906008e00b00a22dca426ddmr1613580ejc.142.1702500075916; Wed, 13
 Dec 2023 12:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
In-Reply-To: <20231213201655.GF2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 13:41:04 -0700
Message-ID: <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com, 
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com, 
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
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

On Wed, 13 Dec 2023 at 13:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 12:51:33PM -0700, Simon Glass wrote:
> > Hi Ilias,
> >
> > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > In order to fill in the SMBIOS tables U-Boot currently relies on a
> > > "u-boot,sysinfo-smbios" compatible node.  This is fine for the boards
> > > that already include such nodes.  However with some recent EFI changes,
> > > the majority of boards can boot up distros, which usually rely on
> > > things like dmidecode etc for their reporting.  For boards that
> > > lack this special node the SMBIOS output looks like:
> > >
> > > System Information
> > >         Manufacturer: Unknown
> > >         Product Name: Unknown
> > >         Version: Unknown
> > >         Serial Number: Unknown
> > >         UUID: Not Settable
> > >         Wake-up Type: Reserved
> > >         SKU Number: Unknown
> > >         Family: Unknown
> > >
> > > This looks problematic since most of the info are "Unknown".  The DT spec
> > > specifies standard properties containing relevant information like
> > > 'model' and 'compatible' for which the suggested format is
> > > <manufacturer,model>. Unfortunately the 'model' string found in DTs is
> > > usually lacking the manufacturer so we can't use it for both
> > > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> > >
> > > So let's add a last resort to our current smbios parsing.  If none of
> > > the sysinfo properties are found, scan for those information in the
> > > root node of the device tree. Use the 'model' to fill the 'Product
> > > Name' and the first value of 'compatible' for the 'Manufacturer', since
> > > that always contains one.
> > >
> > > pre-patch:
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: Unknown
> > >         Product Name: Unknown
> > >         Version: Unknown
> > >         Serial Number: 100000000bb24ceb
> > >         UUID: 30303031-3030-3030-3061-613234636435
> > >         Wake-up Type: Reserved
> > >         SKU Number: Unknown
> > >         Family: Unknown
> > > [...]
> > >
> > > and post patch:
> > > Handle 0x0001, DMI type 1, 27 bytes
> > > System Information
> > >         Manufacturer: raspberrypi
> > >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> > >         Version: Unknown
> > >         Serial Number: 100000000bb24ceb
> > >         UUID: 30303031-3030-3030-3061-613234636435
> > >         Wake-up Type: Reserved
> > >         SKU Number: Unknown
> > >         Family: Unknown
> > > [...]
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > > Simon, I'll work with tou on the refactoring you wanted and
> > > remove the EFI requirement of SMBIOS in !x86 platforms.
> > > Since this code has no tests, I'll add some once the refactoring
> > > is done
> > >
> > > Changes since v2:
> > > - Spelling mistakes
> > > - rebase on top of patch #1 changes
> > > Changes since v1:
> > > - Tokenize the DT node entry and use the appropriate value instead of
> > >   the entire string
> > > - Removed Peters tested/reviewed-by tags due to the above
> > >  lib/smbios.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 89 insertions(+), 5 deletions(-)
> >
> > Can we add a Kconfig to enable this?
>
> Why? This is the default option that we want moving forward in order to
> get the fields populated.

The model name is fine. The manufacturer is in lower case (using the
DT vendor name), so not in the right format.

It only populates two fields, so far as I can tell.

Regards,
Simon
