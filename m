Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B725CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8EB386F67;
	Wed, 18 Oct 2023 05:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cFPsu6aS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C391F86F58; Wed, 18 Oct 2023 05:33:25 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA4F86F08
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9be7e3fa1daso638891466b.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697600003; x=1698204803; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v8DC7AvbM95UlA/rppGOgdfOEjGYRxyVq6913+mwooY=;
 b=cFPsu6aS6uaE89S/+Xfe4DGS1MbjuZP+Tcb1oyx7hRaq0DFrvdDMx/15l2IxtLlh2s
 3PEsElVpUfgWKwAMAmtmgP4uy0hOffCboPm682WtLupJ8brvntuynBDzE+s8IdPLK5c7
 6765Wt900qeyhvrinkVc6yCbUTo2D6kjeZnI7Ft4rKY2rf/ApXHFwJLGQvBmQNztNzpn
 vA9DulZhPB+zKIUaqPovIAYMKCn0VM0b9hgq/66kpfw0ptdSwsDAFyPS4+SrNYfWMLGU
 75lK9LTOVPOYTSjPgO8qysq87aIDPIfvruXi4fZqIhB+9ksE4ylq7p7bsU9cTYQHOrRO
 n3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697600003; x=1698204803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8DC7AvbM95UlA/rppGOgdfOEjGYRxyVq6913+mwooY=;
 b=RvkZdLWD5/b660LhJsMasAXVdvpjxl72dOElhP85ADtsxr7Oh4/QGdfGStyyfsesj4
 6qQDsh0fcLCAqACVVD0QDT2Lii1opkdmQoS/Ib9ODwtCwEsyEqjQKFzy0TGRp87MtArL
 av2k50FZ7i68uS22yusMZicLE+ym4z1dXrP/tRWhFLiE2roDAX7YwliqKOdvUnpjcEGa
 G5wBq5W2zRLzFvylm2auDxMAzlYytFAyTwlaVowyhXiatbPsTxZkYCRneBAsn/RB4h6J
 2a1loFO2gfWLkSvdKVEnl0BnJwdg/0rpy4ShVLr7PK5PX1VUC18Qy2mHCsUCH4mY/4UJ
 t9VQ==
X-Gm-Message-State: AOJu0Yz5PXh6h9rTf4HWfZmxjisxp+JcvHK29JUU240lsWe8yHgpe5zv
 WVW1ehofAkQKUZ23VZOMYORrT2121dZ/pW/sRHBftQ==
X-Google-Smtp-Source: AGHT+IFhS7KnbUzu8oNDwFt16KQJkUJTgzob4pT47xOFUIdJWX4dZaj/iRA9EBKVAzdKB3BhVqXjqCCq40rKSSAOoOU=
X-Received: by 2002:a17:907:9712:b0:9ae:50e3:7e40 with SMTP id
 jg18-20020a170907971200b009ae50e37e40mr3241323ejc.52.1697600003274; Tue, 17
 Oct 2023 20:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231017134951.26672-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 17 Oct 2023 21:33:09 -0600
Message-ID: <CAPnjgZ3fdWAUbZb7kbWfEZvFvuh79LmWpmbOdRhEk=qw2PTbcg@mail.gmail.com>
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

On Tue, 17 Oct 2023 at 07:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Forward and backward compatibility of Linux kernel device-trees is
> sometimes missing. One solution approach is to load a kernel specific
> device-tree. This can either be done via a U-Boot scripts (like the one
> generated by Debian package flash-kernel or by a boot loader like GRUB.
> The boot loader approach currently requires to know the device-tree name
> before first boot which makes it unusable for generic images.
>
> Expose the device-tree file name as EFI variable FdtFile.
> This will allow bootloaders to load a kernel specific device-tree.
>
> The variable will not be exposed on ACPI based systems or if the
> environment variable fdtfile is not defined.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Use a unique GUID to enable future U-Boot independent
>         standardization.
>         Do not try to add the variable on ACPI based systems.
> ---
>  include/efi_loader.h       |  5 +++++
>  lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)

I was too slow to reply to v1.

Does grub load the DT? I was assuming that U-Boot would pass it on?
What is the interface between U-Boot and grub?

Regards,
Simon
