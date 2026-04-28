Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2DAFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 18:20:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A48084692;
	Tue, 28 Apr 2026 20:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nh0yD/nA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93B23846B2; Tue, 28 Apr 2026 20:20:55 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0182F84686
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-bb91b426e40so48385966b.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:20:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400452; cv=none;
 d=google.com; s=arc-20240605;
 b=k2qdhyULWocQZPfmYor+guCGYgrodprMVK7uKY6ypVgZ6XODbSRmIAuL5SKLFBS+xX
 LEFqPKlWELNJfnKdFW9rFzUYiu4W5myDdbq46tojNe8ai3Ht/mLxSHRB1Wx2gMWy9Srb
 KrkHB3XXaDewtme6UfoojTL4Jm1JwFPMAcU9z3peotB7l1SFYzyJG4lvEJRfmb0CCPQR
 J9UuoGC9NrkLAM5MaxCL6mJg+Ddof4rtak19qGifQVQiz49nEUqQeAUKxtDCing9XPcM
 XnRxxnrKgrzpDoRhoHv94LMY2dJNje2QnapRQTzM/3qLEfEz+5xv6PI8NtHN7ltG0ip8
 l68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1pDTqgmjCa3ONi2WbpVOWSkNavIsxiYxP3cjbaMgikc=;
 fh=FSZLg1kBZKtmq7hkO96s8J8bywdf/NrVlQg027zGQAY=;
 b=Dwhwv4Baj11XzVXxAZarorvihf/nxkRA6ODzP+KQjpHMogoEgWFGdg5ND4OezAFX/G
 a+Di/cY5BcXZLFrnl5VobT/2pKB8O/1vXYEvV5zoRuvX+1WOs0rIG7+774YyocyTpDG4
 LM390xp1zbfsGjnieH9iGSUSgk6zoQTKn90kny2+OACq5I7jae4jQcNdSaoOMymLzfRR
 SIoZoMNImtdspij1Fifvlg7+ynYL8ohoD+4sYB46Q3RJB631IFhyYeS8ZmEIDJVm5hGR
 mqz3/08Z1pyzpNU8wjKt+tqwUtZ2nZv1bmjVKCTSwCO1yk9zaVLRpBQonW2RNxhqX4Lh
 7mgg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400452; x=1778005252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1pDTqgmjCa3ONi2WbpVOWSkNavIsxiYxP3cjbaMgikc=;
 b=nh0yD/nAATvzH6lj9rRzjsIt9xZnPG/Tfd+lFuLVpuBaX5B5u+qByMSTmVeTKC1Vgd
 GFCJxbPmFtwlvkXGupz8mdW3nAeiV0CHbDvYr7ZlJIjJWAEuWra8iEpgVJT4YGVkJlLT
 vMjLp6Q7m5Nm/Ej3dmou0ipVqUenhWKGxHqeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400452; x=1778005252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pDTqgmjCa3ONi2WbpVOWSkNavIsxiYxP3cjbaMgikc=;
 b=pH4GvUeqE2AztHsSVuhbNZJwW0v3YT0eBmFVf8wnQIfbL8RXNxUky/0wJvAY68G3GY
 N8qY7HOc+d8p3s+pbR3KUPzY0sf2/Ap8gCT1FrqrwpBzg5cFFXSEL43RRZCA+vVxc4oK
 +DU0nGpWf2osdd/G6BYXFBHT0EUu2D5cRiVSQ+wcgPbADaUpt1qompl9xp3lmLyrKECQ
 mAig2QEHfhTL8YJiCardbWZmoX9ewUJ32WgKg0XWgpbw1wYYn3SfJL/3nZcWJtf56D04
 3FnbX35uLQY/+hbhLYCBZgQr/fHyCcwiOC8qPaAXt/qBTSUjPKO1j5uNxMrauTwGWkP/
 /VOw==
X-Gm-Message-State: AOJu0YzlywaB6yqNEKoVnswPIHwP6pwZL0K6SBpMZf6VA2IM6v+OjyVR
 JfREqCJhBJGpcoJzNpS0eWZJfQbk+Q5nb8GErwJaslFymaQwHl8pxiyQhWgdAegysUssoreUXzE
 pTYZKEf50u1jjO/6EnTN1slmWmBbaKN/8IeE/wCHs
X-Gm-Gg: AeBDiesVRxqNQOF6nk9Q53ypGU3iQ/7p2HG4yPVYHCHCl01QU1LoVWO7R/e9uKc/Z2p
 IJQU5056Ph26SfZzWNcvpD7x8eYiGQLdvckF0tiKBOKYONlS8jMhV7jatILVSlVPCIiwzcGfFmN
 WYPWpJd+/2AvsxwuCVOwKtfaTbh59tMvXENCzVlVDpyUjaoiUSUFv9YxOkKsoFQlV8VtaaSxXg/
 vfVwFeBuxkGc8SyBH1Kj8XqAZVLIhChHq0eAnMPzrf3rVtggx5ENnb0asHTvqxwj30N1xY+sdv+
 p2ul8W3fOvkmvnuW
X-Received: by 2002:a17:907:93c3:b0:ba7:f5fd:edd2 with SMTP id
 a640c23a62f3a-bb93eb5124dmr21485266b.42.1777400452349; Tue, 28 Apr 2026
 11:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com>
 <20260427-fb_gpt-v2-2-9e7fe3c1649a@oss.qualcomm.com>
In-Reply-To: <20260427-fb_gpt-v2-2-9e7fe3c1649a@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:20:40 -0600
X-Gm-Features: AVHnY4LzCiSBJPtnzOfQSQcawaZVtaiMDef1jEH-jL2IekXwcrs20RL3s6rAx-M
Message-ID: <CAFLszTgHEW8ywXEtAqOs7rHHUPYFGXRmurAJFqVdORxr2vBGBQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fastboot: Add GPT/MBR partition table flashing
 helper functions
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
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

Hi Balaji,

On 2026-04-27T12:06:41, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> fastboot: Add GPT/MBR partition table flashing helper functions
>
> Add fastboot_flash_gpt_partition_table() and
> fastboot_flash_mbr_partition_table() helper functions that handle
> flashing of GPT and MBR partition tables to block devices.
>
> The MMC backend now uses these helper functions for GPT and MBR
> operations, simplifying the code while maintaining the same
> functionality.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
> drivers/fastboot/fb_common.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fastboot/fb_mmc.c    | 49 ++++-------------------
>  include/fastboot-internal.h  | 30 ++++++++++++++
>  3 files changed, 131 insertions(+), 42 deletions(-)

> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> @@ -245,3 +245,97 @@ void fastboot_init(void *buf_addr, u32 buf_size)
> +     dev_desc = blk_get_dev(interface, device);
> +     if (!dev_desc) {
> +             fastboot_fail("no such device", response);
> +             return;
> +     }

Looks like a regression for the MMC path: the current
fastboot_mmc_get_dev() rejects dev_desc->type == DEV_TYPE_UNKNOWN (mmc
driver present but no card) and reports 'invalid mmc device'. That
check is gone after this refactor, so an unprobed mmc falls through to
is_valid_gpt_buf() / write_mbr_and_gpt_partitions() with an unusable
dev_desc  - please add the DEV_TYPE_UNKNOWN check in both helpers so
the common path is at least as strict as the code it replaces.

> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> @@ -245,3 +245,97 @@ void fastboot_init(void *buf_addr, u32 buf_size)
> +#if CONFIG_IS_ENABLED(EFI_PARTITION)
> +/**
> + * fastboot_flash_gpt_partition_table() - Flash GPT partition table
> + * @interface: Block interface name (e.g., 'mmc', 'scsi')
> + * @device: Device number
> + * @download_buffer: Buffer containing GPT data
> + * @response: Fastboot response buffer
> + */
> +void fastboot_flash_gpt_partition_table(const char *interface,
> +                                     int device,
> +                                     void *download_buffer,
> +                                     char *response)

The two helpers are almost identical - only is_valid_*_buf(),
write_mbr_*() and a couple of printed strings differ. Please factor
the common parts (interface check, blk_get_dev(), DEV_TYPE_UNKNOWN
check, part_init() + okay) and have the GPT and MBR variants supply
just the validate/write step. As written, the fail-paths are
duplicated and will drift over time.

> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> @@ -245,3 +245,97 @@ void fastboot_init(void *buf_addr, u32 buf_size)
> +     if (is_valid_gpt_buf(dev_desc, download_buffer)) {
> +             printf("%s: invalid GPT - refusing to write to flash\n", __func__);

fb_common.c does not include <part.h> or <blk.h> even though it now
calls blk_get_dev(), is_valid_gpt_buf(),
write_mbr_and_gpt_partitions(), is_valid_dos_buf(), write_mbr_sector()
and part_init(). It builds today via a transitive include, but let's
add explicit includes.

> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> @@ -343,7 +343,7 @@ int fastboot_mmc_get_part_info(const char *part_name,
> -static struct blk_desc *fastboot_mmc_get_dev(char *response)
> +static struct blk_desc __maybe_unused *fastboot_mmc_get_dev(char *response)

The convention is 'static __maybe_unused struct blk_desc
*fastboot_mmc_get_dev(...)'

> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> @@ -245,3 +245,97 @@ void fastboot_init(void *buf_addr, u32 buf_size)
> +     if (!interface || !strcmp(interface, "")) {
> +             fastboot_fail("block interface isn't provided", response);
> +             return;
> +     }

The MMC caller passes the literal 'mmc', so this branch is dead on
that path. The check is really for the block backend in patch 3, where
the interface comes from CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME.
That validation belongs in the block caller (alongside the
parse_device_partition() call), not duplicated in both common helpers
- same reason fastboot_block_get_part_info() already does the check
itself.

Regards,
Simon
