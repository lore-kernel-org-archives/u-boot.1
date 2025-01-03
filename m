Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E420CE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC25802EF;
	Fri,  3 Jan 2025 02:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SdKFi25g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6478D8031D; Fri,  3 Jan 2025 02:40:24 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A12F80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so1300216766b.1
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735868421; x=1736473221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uyar4fbe1IwkVTKdXiO6nJo5kGokgatIAr/o5WoycxM=;
 b=SdKFi25gP7L/cbQ5qjoEQrRuIsPCvBMI+/WKxHl/c9p9kc04L3P3FoIEbL0nsyGFN+
 IQk0w9qPUnbcnoPx4I9Y3aWZkS7A0ivULSUI4RdqjOw+gW49KinH7zbF71y6J1dtzdeO
 g4QcA9sspcI/2hHivClH7byuWzMGpRa9VS9sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868421; x=1736473221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uyar4fbe1IwkVTKdXiO6nJo5kGokgatIAr/o5WoycxM=;
 b=LDHykzPr0ImD2AUdTtq1omfjnlUfUL8HkWuBljmrLRoSBnpUaTXNxNIgkvvfwwb58+
 8B7SFkbfSfK2hNU1R+zHNpguEUHz6MD8yCeXVucY/HLuM5rhrpRkxSFMYMr8wIbhVBV8
 JbPoorzXqHOa/wSmjbA0ELlVQAihR8O4wZd3Pi2UcjDUA3VhaJCLPPMUR/B5BzQA6cvc
 wGR64NfKG0j3z0MDdD9+/haj9DvD7PNrPa58ngxVy0fbYKiHDBxl9GxSh46laZvIfUWs
 JMNVu60ejU1tVwlV3tJrXSw88ogqDl+BP5P8bAs+mSr0PrjSDrHGORajZfb8t8zyzE7d
 cSeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR+LcIXObrVShTJxmXyHPrPNYXoT7RFt2s5kijgIxP7FPfRsJ0t0SVYsqx2MU92gcD5YtF4GQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwYjhIL1aZcGjG5OQ+asfaxe8lRtAkM0J0I1nvdws8gKjYe8wJw
 4NYNPlHG39P+WD5S/QLBpzzUGGsOMNKLs++nZuvzhAL+e9VQAID2rnJ5hqqy656QxZZgtp9E8Wa
 WxxatKiIsBg9yPpSyZaCdqZtELhQktstugepA
X-Gm-Gg: ASbGnctHLle4C2pSlVJ2fHbQW83baTrAAd+e1V23GD4KHzXhrYDFJGJg9o9JIHcGMth
 ysILWjRFa1D4BdTzWR6GH0nn9nRt3lhhAim06OsTf
X-Google-Smtp-Source: AGHT+IEi3RQpQ2/Lt8d15BoSAluGI6H5Xpk5Ds/GkQlrUMMRJfVE3PyvJF8G3BVerU9iAhDvhXoAdV1vfHnnL9wG+p0=
X-Received: by 2002:a17:907:a708:b0:aae:8495:e064 with SMTP id
 a640c23a62f3a-aae8495e124mr3789794966b.40.1735868421584; Thu, 02 Jan 2025
 17:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250102181133.378867-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 14:40:12 +1300
Message-ID: <CAFLszTggvw3ioB=r3yNcjFCZxU612AOtS2B+tBNE1Lf+TABQQw@mail.gmail.com>
Subject: Re: [PATCH 0/4] efi_loader: enable running the debug UEFI shell
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Fri, 3 Jan 2025 at 07:11, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently running the SCT fails on x86. The EFI shell overrides U-Boot's
> Simple Text Output Protocol. When ConsoleLoggerPrintWithPageBreak() is
> invoked with ConsoleInfo == NULL a crash occurs.
>
> Debugging requires running the debug version of the UEFI shell.
> We can use `add-symbol-file` in gdb to point to
> Build/Shell/DEBUG_GCC/X64/ShellPkg/Application/Shell/Shell/DEBUG/Shell.dll
> and the load address of Shell.efi.
>
> The debug version of the UEFI shell checks several requirements and
> fails to run without them:
>
> * HOB list (only on x86)
> * HII configuration protocol
> * DXE services table
>
> Implement the missing requirements.
>
> When starting image add the image load address to the debug output.
>
> Heinrich Schuchardt (4):
>   efi_loader: implement a HOB list
>   efi_loader: build with HII configuration protocol
>   efi_loader: install DXE services table
>   efi_loader: print image load address in StartImage
>
>  include/efi_dxe.h               |  54 ++++++++++
>  include/efi_hob.h               |  32 ++++++
>  include/efi_loader.h            |  16 +++
>  lib/efi_loader/Kconfig          |  15 +++
>  lib/efi_loader/Makefile         |   4 +-
>  lib/efi_loader/efi_boottime.c   |   7 +-
>  lib/efi_loader/efi_dxe.c        | 176 ++++++++++++++++++++++++++++++++
>  lib/efi_loader/efi_hii_config.c |   4 -
>  lib/efi_loader/efi_hob.c        |  33 ++++++
>  lib/efi_loader/efi_root_node.c  |   3 +
>  lib/efi_loader/efi_setup.c      |  13 +++
>  11 files changed, 349 insertions(+), 8 deletions(-)
>  create mode 100644 include/efi_dxe.h
>  create mode 100644 include/efi_hob.h
>  create mode 100644 lib/efi_loader/efi_dxe.c
>  create mode 100644 lib/efi_loader/efi_hob.c

Please can you document how to actually run UEFI like this? Also, is
it possible to add a test for this new code?

Regards,
Simon
