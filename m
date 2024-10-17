Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B172D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:24:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D398919E;
	Fri, 18 Oct 2024 01:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jLE6VNRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E3689083; Fri, 18 Oct 2024 01:23:36 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A235D8911B
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cbe9914487so9492496d6.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207413; x=1729812213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l125lq/t3uWntRaKdZQnVeiietmfS2kJKF8yCfY+rUQ=;
 b=jLE6VNRU/rJsIZymgkOweGu1ltoDjpQLkmqxWuKSRj4/V5CX1oCWovCPpe86j3rgB+
 dRkLCsCRB5agt6xWF+if9P8aLgEYhahvQJxgIHOL8mZ75B2/kESxJtdBx2qxi7HESrjA
 g/gh5CjYua9JezDWbwlx5kufO1s6UIylHxQ3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207413; x=1729812213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l125lq/t3uWntRaKdZQnVeiietmfS2kJKF8yCfY+rUQ=;
 b=TRf3kiPDzqyb75Z+xtnVeS4RVC5WEFuxDe6BE33Qye/Dic+iAo8+uO4FGkQqq6Abrv
 d/4UAInf4L3cQP9OiNzZaTanVzQBTt6/WplNzqu63j9TP48LXZnq2xz9Tw5s9h0El+zn
 8tUL/JKZjsR/TcuvlSTbW80D9pss7dBc9LFYSvSFWbo2Wn+WZvr3QaI/qwglP5HSuW1u
 exh1qSUnfgyjfvPLKk8Vvr5O0Jaa7QE9L9zQvdlrCwNVLlpepeK0Atu07V2O9xKSiRLx
 Rgh+9TsXsl32+8ealfqK1Xe2J9D+zaLPqHGWKY3FdcygZPsjpjSk9FLixLG6dm9kcIie
 56EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0IDGcr9MXp0jq1h14Ts3LjGWl9UqbcM0tDzsS+/0f9yVDm+f/zZWY7DvMLnSwNP7o2YnbKBo=@lists.denx.de
X-Gm-Message-State: AOJu0YzRBO+Vn9qbgz6DfRXSDYxr7QUWp6fPVNZtMSPupOTosUIbwoZB
 UklYu4KsZi18cp6hAw7WflcnEsGTMcT5h+7/mCtcf/s799MU2Wq9UxmHL+m+6a12kbjRf/HSSnS
 +8yKqzp5Zy9+RSQEilDL+zBfPIR/DnNdD6++n
X-Google-Smtp-Source: AGHT+IEZoc3tZRGVRtkNS1Z0wxC5zoS8gq5wH4IEaCjnaD2/OBfbAy8q1g6ZL9jRN/lVKLBNeroJpi+KNMves9mfYF0=
X-Received: by 2002:a05:6214:578a:b0:6cb:39f0:e5a5 with SMTP id
 6a1803df08f44-6cde1604c20mr5354836d6.45.1729207413578; Thu, 17 Oct 2024
 16:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241008223219.105369-1-heinrich.schuchardt@canonical.com>
 <875xpyhfz7.fsf@baylibre.com>
In-Reply-To: <875xpyhfz7.fsf@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:23:23 -0600
Message-ID: <CAFLszThR-qMK0e9f6nsSTVh+t-rkfN1KF+OWYWixYR7ds_soHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sandbox: add bootmethod EFI boot-manager
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
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

On Fri, 11 Oct 2024 at 08:27, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Hi Heinrich,
>
> Thank you for the patch.
>
> On mer., oct. 09, 2024 at 00:32, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>
> > The EFI boot-manager is the default method to boot EFI binaries.
> > We should be able to use it on the Sandbox.
> >
> > * Enable EFI boot-manager bootmethod on the sandbox.
> > * Adjust unit tests to reflect the additional boot method.
> >
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> > ---
> >  arch/sandbox/dts/test.dts |  4 ++++
> >  test/boot/bootmeth.c      | 28 +++++++++++++++++-----------
> >  2 files changed, 21 insertions(+), 11 deletions(-)
> >

This produces the following output on sandbox, for me:

=> bootfl scan
efi_set_blk_dev_to_system_partition() No EFI system partition
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables
efi_set_blk_dev_to_system_partition() No EFI system partition
     efi_var_to_file() Failed to persist EFI variables

Perhaps we need to make this option, e.g. with a 'bootstd' command to enable it?

Regards,
Simon
