Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365B8D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADFE8891CA;
	Fri, 18 Oct 2024 01:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jPOyjfuU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37822891CE; Fri, 18 Oct 2024 01:18:29 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FEE3891D2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so9975136d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729207106; x=1729811906; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6FDSzJ8bhsF8vdcDCL94rN1SI/To9xp299yFHn5dIsI=;
 b=jPOyjfuUCwoa2iACaVSUBXgiQUMPh40oZbhjeJH4k0eV5VKEZ6lXhfUP5zyedfwRxq
 iFcPRCultoadTrZIjMyeeLWWL7fOdcjuWRCMO07zqjuX87+CMFfrxJozZQ/ptmzOEKgS
 oOJuRURoNhB+HYNOFtADLrkhbldRgIzMTjduU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729207106; x=1729811906;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FDSzJ8bhsF8vdcDCL94rN1SI/To9xp299yFHn5dIsI=;
 b=iHphkzdulT+oWvM7f76JQEpY3y5cmh09z7rcTWZBpqJKNkAyUjVXjmBzzc480pTwGC
 zqVD/HYsYxA7sHsTKfywlECr4J4KEuR/3OiOh89nDCi4P/e8RIdEgSpnvhpSK8G4h4+J
 KvJqdvLpYE4u9K3ENOQLm8gbRKOXboQkHLa6axoj0TLgCJV/TpKoPUHowQrEHULw58NX
 co4XH0msw7MGfQOTIY2n+1/q+usrodIMaT0xo0e0LpHsQxKKVUTGEZm+7fol99vqlnnG
 EyV71P3YXQpxvUhKHHCcMlur1uDwOwg9s5EoLJaAA5nOOMoj9pOjOGLTDsYgUk/sGDPs
 hfEw==
X-Gm-Message-State: AOJu0Yzv89u9zb5TPNiGSXYzflVsztbeTBs/A/YDEjX4WmGVgOT3SvwE
 0IrdfRNquveaVeZT1phFfnlb4l1ssl7yDlSveqiX4dDvEqGYdpAxF6D0NjZoy/MqSdW16i2LCnw
 4/MTfwxN08VvJkfZULGUK9WEAawrPQsDTb4yM
X-Google-Smtp-Source: AGHT+IGfp5gAE5G4KXGJWAqhtTz9SCjd92YYOnHa8m+fbXN9Ki68pFCs7qSpp+M8wRW+2iIS00tS/Yjx7pckeE5onug=
X-Received: by 2002:a05:6214:4808:b0:6cb:99db:bdbf with SMTP id
 6a1803df08f44-6cde160f1bdmr9758756d6.43.1729207106060; Thu, 17 Oct 2024
 16:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
 <20241016060523.888804-25-patrick.rudolph@9elements.com>
In-Reply-To: <20241016060523.888804-25-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Oct 2024 17:18:15 -0600
Message-ID: <CAFLszTh4Z8p-8d8ASrpUTnNdDhmijDm8fcct-wDWR1nRFxs5JA@mail.gmail.com>
Subject: Re: [PATCH v9 24/37] common: Enable BLOBLIST_TABLES on arm
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, linux-kernel@vger.kernel.org, 
 Tom Rini <trini@konsulko.com>
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

Hi Patrick,

On Wed, 16 Oct 2024 at 00:16, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allow to use BLOBLIST_TABLES on arm to store ACPI or other tables.
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
> Changelog v9:
> - default to BLOBLIST_ALLOC on arm
> - Move default for BLOBLIST_SIZE_RELOC up
> ---
>  common/Kconfig |  2 ++
>  lib/Kconfig    | 15 +++++++++------
>  2 files changed, 11 insertions(+), 6 deletions(-)
>

This is fine, but please disable it for snow since it needs the FIXED
option for now.

Regards,
Simon
