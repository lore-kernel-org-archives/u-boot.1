Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CACC46CA2
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D45187B69;
	Sat, 16 Dec 2023 19:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hsQMH0Gh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E0A387B48; Sat, 16 Dec 2023 19:47:03 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D89C8784E
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e2f45922easo12341427b3.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752420; x=1703357220; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1MkfGGNQYf87DW3Jb3x37RUncX2S7BmwfAUzTHGj4X8=;
 b=hsQMH0Gh+nZ/vKS7VoIDgeGh6E6b9NaB81ShbLU4YjRRGmWaSNuKx2O8j5C2SA8xu1
 si+gRC5CrAEBvnZk2iEXmP3Ezo9NZh2/kPLvdZQ5Sy4AE9lXtMQPncRO2Atza3vW/V5V
 ZF63li6nzP8uihIkf5SNcpJ4TxahNgdvyPstM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752420; x=1703357220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1MkfGGNQYf87DW3Jb3x37RUncX2S7BmwfAUzTHGj4X8=;
 b=JEsONu5zoJNBGg6Jr8xHoou00VEs3CcbDxMk1lDwlL0pthbK7C7PRgoxbRZcoeDXaD
 Fi9MWOH+Z5mE6pTNpKw3UfenkOWSrANWtvu9YcZnq+RcBj81oba0LA23BMk4n4BUifIj
 T41M7bnEXOPPuo+EmUG9AqeiEoaPTodtey/LbU/2d/MJukAp4yc3BNFF/IGUJcCbSLHZ
 q6DD3spOEiE8J5WUG8pPJXHrfolKi2SKuULkxzYJUol8/W0PvWNthQegXEEpggZ+IZBa
 81aFfPddlEjtXZOi6XcY05m5A+XmwB6A7kh4TIzBklA0UbIu6vJ4AM5b4+iHzraii7iX
 Aqlg==
X-Gm-Message-State: AOJu0YzsqidNXVyFZbzNfhd9JUublTjXnPMPBSgxktZh+MovDtxpJ4E9
 UsehOhxEop/HYUotDgcoXmflTa+2668obD64A4FHNg==
X-Google-Smtp-Source: AGHT+IFYUMIVzJCVLM9Hj4fpO3rYdhDUup0UpS0NlngckYYM3rjJYK9oQ8eyKUOG9k2K4ZaMaaCZyLZHXTWLv/0QMZ4=
X-Received: by 2002:a81:6f56:0:b0:5d7:1941:ab0 with SMTP id
 k83-20020a816f56000000b005d719410ab0mr10951337ywc.75.1702752419629; Sat, 16
 Dec 2023 10:46:59 -0800 (PST)
MIME-Version: 1.0
References: <20231216081200.7677-1-heinrich.schuchardt@canonical.com>
 <20231216081200.7677-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231216081200.7677-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:29 -0700
Message-ID: <CAPnjgZ2WdXAj=6=jTf1mYxDRR-8ow3OFr+tjrrvqKBNWJV78Qw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] acpi: use 64-bit addresses in FADT table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

On Sat, 16 Dec 2023 at 01:12, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
> to uintptr_t to fill these.
>
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored. We should not fill
> unused fields.
>
> See the field definitions in chapter "5.2.9 Fixed ACPI Description Table
> (FADT)" of the ACPI Specification 6.5.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/x86/cpu/baytrail/acpi.c | 9 +++------
>  arch/x86/cpu/quark/acpi.c    | 9 +++------
>  arch/x86/cpu/tangier/acpi.c  | 9 +++------
>  arch/x86/lib/acpi_table.c    | 9 ++-------
>  include/acpi/acpi_table.h    | 6 ++----
>  5 files changed, 13 insertions(+), 29 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
