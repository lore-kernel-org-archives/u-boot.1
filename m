Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47CDCC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 13:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 501B28798D;
	Thu, 18 Jan 2024 14:40:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793F387887; Thu, 18 Jan 2024 14:40:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0CB138798D
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 14:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44ABC1042;
 Thu, 18 Jan 2024 05:41:12 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DE1E3F73F;
 Thu, 18 Jan 2024 05:40:25 -0800 (PST)
Date: Thu, 18 Jan 2024 13:40:21 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Cc: <j@jannau.net>, Anatolij Gustschin <agust@denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 0/6] video: Add UTF-8 support for UEFI applications
Message-ID: <20240118134021.5aeddddb@donnerap.manchester.arm.com>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 17 Jan 2024 23:24:26 +0100
Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org> wrote:

Hi Janne,

> Andre submitted 2 years ago DM_VIDEO improvements for UEFI applications
> using UEFI's EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL but did not follow with
> suggested changes. This series takes care of the UTF-8 support which
> required to draw symbol and box drawing characters used by UEFI
> applications like grub2 and sd-boot correctly.
> 
> Compared to Andre's version this version has the following changes:
> - use and extend existing conversion functions from lib/charset.c
> - convert first to UTF-32 to support the truetype console as well
> - conversion is conditional on CONFIG_EFI_LOADER
> - use escape sequences in tests as proposed by Heinrich

many thanks for picking this up, much appreciated!
In general this looks good, I will test this later this week, and have a
closer look, once I am on a device with video output.

Cheers,
Andre

> 
> Link: https://lore.kernel.org/u-boot/20220110005638.21599-1-andre.przywara@arm.com/
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Andre Przywara (2):
>       efi_selftest: Add international characters test
>       efi_selftest: Add box drawing character selftest
> 
> Janne Grunau (4):
>       lib: charset: Fix utf8_to_utf32_stream() return value doc string
>       video: console: Parse UTF-8 character sequences
>       lib/charset: Map cp437 low chars (0x01 - 0x1f) from unicode
>       efi_selftest: Add symbol character selftest
> 
>  drivers/video/console_normal.c             |  6 +++--
>  drivers/video/console_rotate.c             | 16 +++++++++-----
>  drivers/video/console_truetype.c           |  8 +++----
>  drivers/video/vidconsole-uclass.c          | 18 ++++++++++-----
>  drivers/video/vidconsole_internal.h        | 15 +++++++++++++
>  include/charset.h                          |  4 ++--
>  include/cp1250.h                           | 12 ++++++++--
>  include/cp437.h                            | 12 ++++++++--
>  include/video_console.h                    | 10 +++++----
>  lib/charset.c                              |  9 +++++---
>  lib/efi_loader/efi_unicode_collation.c     |  2 +-
>  lib/efi_selftest/efi_selftest_textoutput.c | 35 ++++++++++++++++++++++++++++++
>  12 files changed, 116 insertions(+), 31 deletions(-)
> ---
> base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
> change-id: 20240117-vidconsole-utf8-uefi-fa23b4ac65d6
> 
> Best regards,

