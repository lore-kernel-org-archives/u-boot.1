Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D09BF94CAA
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 20:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1529E805D7;
	Tue, 21 Apr 2026 22:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d3Jgd+LQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3606483BC8; Tue, 21 Apr 2026 22:41:06 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3843880433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 22:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso442521566b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 13:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776804064; cv=none;
 d=google.com; s=arc-20240605;
 b=SI6wCt2dLSQrXaUbRGTkiogZ4I1Hfm+AI0f7/3igY2pWA/Iqy2XEWyMT99MfLTAMiT
 XVpg70lErp8/dgVMJP3EniQWHl3ZmGyeRmjZl64MrF+RAqueLDek+oCmPIJEb16Kxl2i
 MMMYrzgL6iZaIzIdrDgPN8sKa82NCE29FFdgeTXlNMqD+pP/6VHN6aqGBFCp2qzMMk30
 iFQH+2HHWcfkJYtkSnNksL63uOlNN0F5AmhYa4zXKBepFGgOJYvA+NsQ+2ikzY5CJTNk
 /QnkpaAEn7Ovu90F7pvK/1vOS43ZBi5pikMc3H956AbPZzEeQZ+C0Xp5AhQpjDPoPkLq
 8XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CCEI8tAeQvo/lqqRVV60IhtT/AMxKbC0CNuj37fqjxw=;
 fh=waS3EJk31RVDeGVicECCeqlXRchlLuFxWeT8ek9mn1g=;
 b=ACklDe6nj27yJ4cocdzzQsd+chiuEIjUFqIcXv7GRSR9C/6wtulk9xswKtVyKci9GQ
 ZGM6ZcfHNr6uw6hFk7AEV8nD4ma3AhXHFCOrX2UvD3i43IJdzoAAsm4JPN6+uZl+zizM
 06AWTv2ea7P+Un73Iu5fIaCmjEwypOu4tgZe1OzwbDQceOsvrZvJbhwYcU045Jn0fAa+
 vvCppwnsOueQ4EEG/0b6e1xIro+XTEnw9+9cHqbmmEB1/OzKxOnpFcc/oP6VkxrUgd5y
 5DqCZdZwUBaf3ZIdgbjd/J778g5rHlkPO/9U9aLLOC8jPCJyLO+z/VMhDsX0GQAOGYST
 yAGg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776804064; x=1777408864; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CCEI8tAeQvo/lqqRVV60IhtT/AMxKbC0CNuj37fqjxw=;
 b=d3Jgd+LQKP4l2CdpSnB2acrYNFinJmsdwzIr/PuFFEYLo2GXdJMiqA1gY5yLcYNftT
 m00ZkTkT7y2nt/FY00ivGrtXdvY5mJYipZIqy8oQn+hpm0jolsDh0UfhWPjOu5mjVbEa
 28HTUVs9L+HzapiVV2g0UujZLznYxSJk2djQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776804064; x=1777408864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CCEI8tAeQvo/lqqRVV60IhtT/AMxKbC0CNuj37fqjxw=;
 b=MjltXHATp/HbKkCOr7buNfF0pGfC4uZvHs6OAU1teiKci5mVVPipGWe9UdhD6NUI+h
 /FY9eDaxLC/Ugavf4b3JT8Qugw1YubulNnu1lx6ox8kjI5wQUBLfCq9gtpjpo2qQqSL7
 jnuwqe9WdiwhCh2sQ9WArk5Kk0GdCmaewBUtJjBHnp8+fO8+TgyQNt+czAjzF0QIQfA/
 7lFVVu5VvlwiB5VkUggXiDwBAKc5rsaeqgJ/hf6WdOBmDtbbQs4Io1cWl4ovOkuO1zdx
 ys8NzJ1MXDgGgAXLrymvBQfg/RP2TeslIfygpji5c6xV9IA1IQLlfJrt3A8h8iLc2+qd
 nIGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RRIk9nvKF1PqoOfboPMX0ieS51CDTlisfqL0OjKQ3x3Bh5TTRs1DSpELM/CThf1mwWQRA4Yo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2G1EH3bzMNpez/1RESqTEjvzfe6zd8ebasqXqd7pyUT7Lsoww
 UsvIrjhpZrIFLfgGhPq13d3LR8NkdjeCbhef3rLGFcuWGqeAv+bBUBRh6GugxppMQcwYEe8bxkD
 OVOk9058MwQ8HWXKbtxSdtTJSAv9aRb37lRZooVItdyDpyRIQO/lhjw==
X-Gm-Gg: AeBDiet1Nere8dlliQYO0mZ6prqYT+6oAKAwx5VaLk0uBANfdxCBvCSSi00GioWk5KV
 EWh2YCAVb6Cgk/lJJeZzgbSx9KDWc8CPyOxTS47MwaV3YCiODCQ6L1kJ/rrqHuaqWDrC0rkD55f
 Ji6qO1OAGjF17cN5z5bpOgXNUm77Z/dVo32yXAgAKDaeIXvZWqFWEeyDE6A1ky1hwhZPixkGkZT
 AjP6gr7OVRS8IL45Pm0jx4SL9NeyeldolEOyYIhM2bjnT8m2Czvp/aKLWHRGgro8z9i3fceqgvl
 F/qiq8RYIG/SXD396/nv
X-Received: by 2002:a17:907:7f94:b0:baa:77ac:97a with SMTP id
 a640c23a62f3a-baa77ac0facmr102322666b.36.1776804063618; Tue, 21 Apr 2026
 13:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260420192520.1444749-1-rs@ti.com>
 <20260420192520.1444749-3-rs@ti.com>
In-Reply-To: <20260420192520.1444749-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 08:40:51 +1200
X-Gm-Features: AQROBzAUjeroKDli-DbiyaZviQPRrFL9rLle9PoHSJS73bheZ9_NDbJ0JqBGf0w
Message-ID: <CAFLszTggCLQPaJcRoxhjHOuRM10yW3pr8JjRj+LLA-ZupVOSjg@mail.gmail.com>
Subject: Re: [PATCHv4 2/6] boot_fdt_add_mem_rsv_regions: free old dtb
 reservations
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On 2026-04-20T19:25:18, Randolph Sapp <rs@ti.com> wrote:
> boot_fdt_add_mem_rsv_regions: free old dtb reservations
>
> Add a free flag and an initial call to free allocations covered by the
> global FDT. This assumes that all calls to boot_fdt_add_mem_rsv_regions
> occur before the transition to the new device tree, thus we can access
> the currently active device tree through the global data pointer.
>
> This allows us to clearly indicate to the user when a device tree
> reservation fails. How we handle this can still use some improvement.
> Right now we'll keep the default behavior and try to boot anyway.
>
> This functionality was broken in:
> 5a6aa7d ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
>
> arch/mips/lib/bootm.c |  2 +-
>  boot/bootm.c          |  2 +-
>  boot/bootm_os.c       |  2 +-
>  boot/image-board.c    |  2 +-
>  boot/image-fdt.c      | 57 +++++++++++++++++++++++++++++++++++----------------
>  include/image.h       |  2 +-
>  lib/lmb.c             |  2 +-
>  7 files changed, 45 insertions(+), 24 deletions(-)

> diff --git a/boot/image-fdt.c b/boot/image-fdt.c
> @@ -69,35 +69,51 @@ static const struct legacy_img_hdr *image_get_fdt(ulong fdt_addr)
> +static void boot_fdt_reserve_region(u64 addr, u64 size, u32 flags, bool free)
>  {
> -     long ret;
> +     int ret;

nit: perhaps keep this one 'long' since lmb_free() returns long ?

Regards,
Simon
