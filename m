Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FF4CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416A08715A;
	Thu, 19 Oct 2023 15:56:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="dN56VZxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D39D8701D; Thu, 19 Oct 2023 15:56:06 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B8D68715A
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507b9408c61so4739704e87.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697723761; x=1698328561; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fd2cIk7WmF3IXDuhSs4lhZmOs8tbzxjMTa9xtWAD7DM=;
 b=dN56VZxem2hIDoOD0y8jlaYDCQBGQe27mu3JhBvPBRqJBGqhDS9mXMYbGNjf4WlGwf
 XNfmOOqqEa/gKLQUvP9BnSUvhZwBVtpai6tDLJD+c7S2bFRr2b/Oo1QnooHELcv2g6Ew
 TXl05f0k8SQKkLN7QS+0QkcpQhnzJegkFsZuFLndQsntTL3LpK5A6HGXKfZnOlS1R6Rt
 /lxD2tVoHluIU4wjI0++M6u9/PZw0nF3Uo5W70e7TuyV1NkJqHamt6BbyxNZx531T+XD
 tOWvPSU/srq+Z/ruNC8ge0iXo8zSPzfQWd36WXgU/VlZEfi+0/+bujc7ip+Uc6lRYl5L
 TJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697723761; x=1698328561;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fd2cIk7WmF3IXDuhSs4lhZmOs8tbzxjMTa9xtWAD7DM=;
 b=TPPBKGkXPZJ41ELfzXWr7m5ea0UDndS5MMSS02evcQ2O/litQHqmJAqgDXqtST7jDd
 JU7DpE/vcQJYs5+Gn8kWaNlVG0tjxfOLXGB2MLLL1ZvSpvWc1i7sQcaloqdUvEqd3gnk
 3nCV0uS7lqz3lRhBVstl/B/m1jRNpMBIomKFI4rWygWY/YC6tMk2TY1RodB4pVuZZWT9
 A3jp1hrCsUGh3qKp9Yl1xCGCuBW0NebgMD68QsiNe9IMG1SzHabZTq7+FLo/x5anzIZs
 XMygYUvM5J9Jne2BwG+qSbhVjJbu1Kv9bFN8/nYpkEo4E9vCR1dHPhweiXQV8n3qx6w2
 zMiw==
X-Gm-Message-State: AOJu0YySfey1YbGW9TopjXb86f8Z3sLlhUuXEkEAJENAE+mudsqsZmmw
 lO1i1IkBATR2faJVIMIuBtOpXFYWdVuyIN0nzMi4TEneKFf0d6ePAHg=
X-Google-Smtp-Source: AGHT+IGnofwfNiUXtYXYupr6NsrfApvSNePh2uNvsf9D4TwAHhdgWoXJHJxamQRRiLITFT4BbOy1FRkxOJC+uvF/Az8=
X-Received: by 2002:ac2:47fc:0:b0:500:b7ed:105a with SMTP id
 b28-20020ac247fc000000b00500b7ed105amr1553321lfp.29.1697723761266; Thu, 19
 Oct 2023 06:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
 <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
In-Reply-To: <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Thu, 19 Oct 2023 07:55:49 -0600
Message-ID: <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

On Wed, 18 Oct 2023 at 02:15, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 10/18/23 05:33, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Forward and backward compatibility of Linux kernel device-trees is
> >> sometimes missing. One solution approach is to load a kernel specific
> >> device-tree. This can either be done via a U-Boot scripts (like the one
> >> generated by Debian package flash-kernel or by a boot loader like GRUB.
> >> The boot loader approach currently requires to know the device-tree name
> >> before first boot which makes it unusable for generic images.
> >>
> >> Expose the device-tree file name as EFI variable FdtFile.
> >> This will allow bootloaders to load a kernel specific device-tree.
> >>
> >> The variable will not be exposed on ACPI based systems or if the
> >> environment variable fdtfile is not defined.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >> v2:
> >>          Use a unique GUID to enable future U-Boot independent
> >>          standardization.
> >>          Do not try to add the variable on ACPI based systems.
> >> ---
> >>   include/efi_loader.h       |  5 +++++
> >>   lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> >>   2 files changed, 35 insertions(+)
> >
> > I was too slow to reply to v1.
> >
> > Does grub load the DT? I was assuming that U-Boot would pass it on?
> > What is the interface between U-Boot and grub?
>
> The device-tree built into U-Boot is often out of date and not usable to
> boot current Linux. A single device-tree can be loaded by U-Boot from
> file and passed on as EFI configuration table. This device-tree may not
> be compatible with all kernel versions exposed by GRUB.
>
> GRUB provides a devicetree command. It is disabled if you use secure
> boot. At least in Debian and Ubuntu GRUB invokes the
> EFI_DT_FIXUP_PROTOCOL exposed by U-Boot to run U-Boot's device-tree
> fix-ups after loading a device-tree.
>
> Vendor scripts for GRUB like Ubuntu's /etc/grub.d/10_linux add
> devicetree commands to the boot options in grub.cfg.

Thanks. I wonder if you could document this somewhere? It seems like
there are a lot of options and it is quite complicated.

Back to the question, I suppose you are expecting grub to load the DT
using this filename? But why doesn't U-Boot load it instead? It seems
very convoluted.

Also, can we test this interface?

Regards,
Simon
