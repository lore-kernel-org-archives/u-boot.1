Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930BCC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CD7E8867A;
	Wed, 29 May 2024 18:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mnNnXieh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5563088210; Wed, 29 May 2024 18:30:14 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C97738860B
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6ab9ce67eefso12963536d6.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000210; x=1717605010; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1mr1sO+/NUxu+dbpjvsZ65/TNbZKDQpsd7pEjrowvHo=;
 b=mnNnXiehSDPDp24ln6muYzaHSF0r5AAu71dLoUb06DRZmC335zw0tsXLU1ZvjHEcbV
 vsV3ca5dcIBv/O9j7koyCTg9DYOSsur/RY0IhQ+P1E7d/02ogLnk4geRWCshArov2toi
 afJrPG83LicGjxHHFhzGPV+2CeY1u90g99d00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000210; x=1717605010;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1mr1sO+/NUxu+dbpjvsZ65/TNbZKDQpsd7pEjrowvHo=;
 b=PRRPrqHlD8BjHR0gKgzdF9hDQlDoBmLVdiJmgVcFEf8kJ5axiQ3aW4I3Mf8q1N5ulM
 krmiqWVzExYE4cEJdaUJf9WnM9iihb/otILbDM7KLgsuhORL0ZliAs1KPpF2PufwanvC
 at/Y++MeCE0yA6AHkc+Qq2T1971Q3d76dp4gynl1dHdRcRhW6RpDtZIE81b3a737XoOF
 9Aof+/fiOIhRMEABv3EisfkDvHj/iKrGdBWWkR1+SxFhkHYYTCRprSLFOVsJtnVKJq9v
 2MlaPlkkiFJQL4s6jqN6Sz4DroFfs1XhTJViUXT+kG0UoMrF3YTTDRVeVXxT1NkxNqhG
 oO4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6RHhrh8ilqB5Ob8Z0N3NW7mlrV6BcnQd3RggHuJ39o8lvYIaVywEyglAC7U3KhG5Rggh+RKxuhyZsfCILzlteNvzopA==
X-Gm-Message-State: AOJu0YwAW2syBsY1Z9VgfP6InR7o9X8iAePdYRMbdFSD67wtGcLvvNE+
 xpTzz/Gpe6FXKdXzOlLusg5E16Wp+M2/yHBci7H/KVqdhxbB3pE5dfrx9FZeYQErY5MaPItIIY9
 Mbxhh+Q5blnx/IHind8lMXnuZDAEIzbnoINJW
X-Google-Smtp-Source: AGHT+IFsIey4LWsdMeosPaQmneDM8FCMmv3e2GtFsQSqU4owrYDqH43ov5iLTeHfoAEpVbP5efaGtyIJ0tv5w/V3+6s=
X-Received: by 2002:a05:6214:2dc8:b0:6ad:7b5c:6fe3 with SMTP id
 6a1803df08f44-6ad7b5c7128mr148424566d6.34.1717000210693; Wed, 29 May 2024
 09:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:30:00 -0600
Message-ID: <CAFLszTj8vfZVW+0YPqcg6ST3MndW=mFJkOz3dJXuFb=P1HP3kw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] efi: CapsuleUpdate: support for dynamic UUIDs
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

Hi Caleb,

On Wed, 29 May 2024 at 08:49, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> As more boards adopt support for the EFI CapsuleUpdate mechanism, there
> is a growing issue of being able to target updates to them properly. The
> current mechanism of hardcoding UUIDs for each board at compile time is
> unsustainable, and maintaining lists of GUIDs is similarly cumbersome.
>
> In this series, I propose that we adopt v5 GUIDs, these are generated
> by using a well-known salt GUID as well as board specific information
> (like the model/revision), these are hashed together and the result is
> truncated to form a new UUID.
>
> The well-known salt GUID can be specific to the architecture (SoC
> vendor), or OEM. It is defined in the board defconfig so that vendors
> can easily bring their own.
>
> Specifically, the following fields are used to generate a GUID for a
> particular fw_image:
>
> * namespace salt
> * board compatible (usually the first entry in the dt root compatible
>   array).
> * fw_image name (the string identifying the specific image, especially
>   relevant for board that can update multiple images).
>
> == Usage ==
>
> Boards can integrate dynamic UUID support as follows:
>
> 1. Adjust Kconfig to depend on EFI_CAPSULE_DYNAMIC_UUIDS if
>    EFI_HAVE_CAPSULE_SUPPORT.
> 2. Skip setting the fw_images image_type_id property.
> 3. Generate a UUID and set CONFIG_EFI_CAPSULE_NAMESPACE_UUID in your
>    defconfig.
>
> == Limitations ==
>
> * Changing GUIDs
>
> The primary limitation with this approach is that if any of the source
> fields change, so will the GUID for the board. It is therefore pretty
> important to ensure that GUID changes are caught during development.
>
> * Supporting multiple boards with a single image
>
> This now requires having an entry with the GUID for every board which
> might lead to larger UpdateCapsule images.
>
> == Tooling ==
>
> This series introduces a new tool: genguid. This can be used to generate
> the same GUIDs that the board would at runtime.
>
> This series follows a related discussion started by Ilias:
> https://lore.kernel.org/u-boot/CAC_iWjJNHa4gMF897MqYZNdbgjFG8K4kwGsTXWuy72WkYLizrw@mail.gmail.com/
>
> To: Tom Rini <trini@konsulko.com>
> To: Heinrich Schuchardt <xypron.glpk@gmx.de>
> To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> To: Simon Glass <sjg@chromium.org>
> To: Mario Six <mario.six@gdsys.cc>
> To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Richard Hughes <hughsient@gmail.com>
> Cc: u-boot@lists.denx.de
>
> Changes in v2:
> - Move namespace UUID to be defined in defconfig
> - Add tests and tooling
> - Only use the first board compatible to generate UUID.
> - Link to v1: https://lore.kernel.org/r/20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org
>
> ---
> Caleb Connolly (7):
>       lib: uuid: add UUID v5 support
>       efi: add a helper to generate dynamic UUIDs
>       doc: uefi: document dynamic UUID generation
>       sandbox: switch to dynamic UUIDs
>       lib: uuid: supporting building as part of host tools
>       tools: add genguid tool
>       test: lib/uuid: add unit tests for dynamic UUIDs
>
>  arch/Kconfig                                       |   1 +
>  board/sandbox/sandbox.c                            |  16 ---
>  configs/sandbox_defconfig                          |   1 +
>  configs/sandbox_flattree_defconfig                 |   1 +
>  doc/develop/uefi/uefi.rst                          |  31 +++++
>  include/sandbox_efi_capsule.h                      |   6 +-
>  include/uuid.h                                     |  21 ++-
>  lib/Kconfig                                        |   8 ++
>  lib/efi_loader/Kconfig                             |  23 +++
>  lib/efi_loader/efi_capsule.c                       |   1 +
>  lib/efi_loader/efi_firmware.c                      |  66 +++++++++
>  lib/uuid.c                                         |  81 +++++++++--
>  test/lib/uuid.c                                    |  90 ++++++++++++
>  .../test_efi_capsule/test_capsule_firmware_fit.py  |   2 +-
>  .../test_efi_capsule/test_capsule_firmware_raw.py  |   8 +-
>  .../test_capsule_firmware_signed_fit.py            |   2 +-
>  .../test_capsule_firmware_signed_raw.py            |   4 +-
>  test/py/tests/test_efi_capsule/version.dts         |   6 +-
>  tools/Makefile                                     |   3 +
>  tools/binman/etype/efi_capsule.py                  |   2 +-
>  tools/binman/ftest.py                              |   2 +-
>  tools/genguid.c                                    | 154 +++++++++++++++++++++
>  22 files changed, 481 insertions(+), 48 deletions(-)
> ---
> change-id: 20240422-b4-dynamic-uuid-1a5ab1486c27
> base-commit: 2e682a4a406fc81ef32e05c28542cc8067f1e15f
>

How about using the compatible string, instead of a GUID? Is that possible?

Regards,
Simon
