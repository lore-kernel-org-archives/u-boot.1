Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B2CC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9060260749;
	Mon, 20 Jul 2026 18:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXxC3bgqaWnU; Mon, 20 Jul 2026 18:17:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B574E60711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571450;
	bh=Al0VJhs6H6CJr3GfJS9zeU8lp2gzsWUoMnPCnp2T+hM=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=frmnJ/FQiApPWx9XlNNMpjcZT3ZqcXzbyLMk2csE7PdiXHbyYxM0rz3VQFYp5ESVj
	 pQLflf4yovNnIjAUC72+mAJhHx/ZDJz2px1vFUheB29qD+Da/hZtSllzeBbXmaTBh/
	 +mWDCqpH+UOa3flHyYgBh1b74fJ//NnxfIQFGX2H/b585/U94s1wGkbFe6dIXVA4kP
	 jKbYy/Sqk/tsxVAU2QoT//QYJ7Hzj+rZ8a4/F1/L8e28YhVezm5+nPTQsTXPWO6MRa
	 f568jOOG/4PZNtZ8ut0zgd61AEwkPIyj19/xJP4cJVj7nyMzEITcrwwYM5ibrexObC
	 Wri2ehyCFFHGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B574E60711;
	Mon, 20 Jul 2026 18:17:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A678342A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C8AA606ED
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D9aGAHZUbmfS for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:17:28 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3B61C6069C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B61C6069C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B61C6069C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:28 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EDC844F6; Mon, 20 Jul 2026 20:17:26 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6AC780433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:17:23 +0200 (CEST)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-698e5859a3cso8283092a12.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571443; cv=none;
 d=google.com; s=arc-20260327;
 b=SjtwGTWND7nqq4wGlHawBAWBVjmTodggsnT4lId/To02z9sBvgVhLQwFFtS6W+mc8b
 o1QpMEH4Dem8wumK/O7N04WxclMbI3KznJaCAzHfEeOqXNCQ7Gy2MymQLVLUr8/MNG4V
 LSXdsmUxzyEYE0FAqN8IPa06xXmCtSxp03rerG8pqIwWlkSDGe4DYcbShE8p8Cd1a70d
 rbmnL3y1vMJHDK8mLF3qAUBvCtMlifSnwWQp4NErltAXpsFKT07Y4yJpCnKRR0zW8d+D
 wB4xXeHNimSkpoKVj5F9I+put8pX+HTXQhZ8iZ92JBrbB4manpkMtq1zX96WU6btTpMk
 tQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Al0VJhs6H6CJr3GfJS9zeU8lp2gzsWUoMnPCnp2T+hM=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=s7KcTzsJQrynH7DN4jCdCL/nzv8H/3+GhIOwAviZEP0Q/zZlxeEWnC0w/inejm5kBQ
 C32siStlDszKp9KvuGS/QvSnEC0BWcSthcMZ8GcgrzfhQoG/v+F7nlqaNgwFhMhYRr9p
 VEgutLJ/nwj3ydSCpbM2ctnKQO/psQaDYh9nopHxfxcVNI7QIlYkCwxMdeCzJYKBjAiB
 +OyQVuJ0Nw4vy3tzeFFHn3e5KhnrtX5a7A60iEOU7pe56bXhkywtCRLZ5XxcGJT1fbaw
 hcJeapJO+YHRk3zjw0YFIiibdl6UcbqjlXcn2CgS3/DoNVyhYloyEw7uNdwW1fGKowOz
 owTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571443; x=1785176243;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Al0VJhs6H6CJr3GfJS9zeU8lp2gzsWUoMnPCnp2T+hM=;
 b=gE6IQJH8l4k7r8eRgN9i47zIwTizGRKb2mFML81GPAO+1nA3LwqeMXLoMbGHBceSkf
 AbUkXibxok/n9YrCqTLPKfNKXfryTklsOl2/5r2HyiOrDc7GZuVenADITnN63xPKOtWc
 PmDbMF1FnwNq/LK0Xo3KONGNKWZoQtSBJVuYff49rce+OSd3yHA6V3C6O/EGPsLpKAHj
 BvDGZRcWLAxNZhwLxyuwuxEm7XP80/q2QhYX43rCnMYui5Ezi+JCjULqlcDr87rL10WS
 d9iA/QOn83kzIAgePeYAboniywoJ37SJSgQi/Z8cJGgyCCTHFlaa2L6MbJ4bou4241qn
 Y+MQ==
X-Gm-Message-State: AOJu0YzXpohKfCH74Y6fI4xRWrl4gIHKw84rAIkH0mSEzYwcgGZ9cQGD
 NLlLiWSPRFS0Er2ZYhvAs9uQ7IGDpOspk9BTMJ/THw0Xd6FX3xdL4SMz4AwT6BwQmB4qOrOhhgW
 XvPSPevHHPnvEdBZYkmsFLYMbDvFW1ZgoGMZwR2Cu
X-Gm-Gg: AR+sD10MaPhWCXi+2ED21J1rUK9MpEtIjkpKGX9LzBnmGXE12BYKiWDJWoOYfcBzuP3
 WFViXvNQYad+HWA7eesy45yoZjhXo50H8/7xfDQBl0eAEKaaCuZoNKjnri8H+rhzI+JZdrVAYx6
 L/eQJVQrdLMZsMUT+wz/LpFy/mg0FtEY7X1Dl0/H4PJ17Js5VbiAqtO5ce30TeRBO9WI+n9crxe
 jFTYFk+16YksZ+kwTGcJyxqt2wCIAglsTd04RrbK5dBDw9m6jYaE90EkA9L
X-Received: by 2002:a05:6402:4555:b0:69e:3822:98ac with SMTP id
 4fb4d7f45d1cf-69e64e58467mr4947681a12.18.1784571443324; Mon, 20 Jul 2026
 11:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-7-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-7-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:44 -0600
X-Gm-Features: AUfX_mwQnOb3ufaz68DKqZ-3WDyj7MfamiAwcRLZ8_Sod9dTvoUy4Jwt3EOncQk
Message-ID: <CAFLszTinG-50v-yUm09MEDaZJTmo3Kc4MhhKd496v89DAmw14A@mail.gmail.com>
Subject: Re: [PATCH NOT-FOR-UPSTREAM 7/8] bios_emulator: Support IO port reads
 for Aspeed VGA cards
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571443; x=1785176243; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Al0VJhs6H6CJr3GfJS9zeU8lp2gzsWUoMnPCnp2T+hM=;
 b=n7hBOISskDis9hdR3k4fbHAsHpKuHE6nuuhqCOJofttRhiDdhiXDU2DtB4G6bPKIqQ
 YDhDxasYqsS/XSiRgoRYvZIPmCiyfg0Dg3SwJ3pxAGuCmJISpn207KnaTv19IRrBh6sb
 mm57dIi3yPnhZqv+YRlZRgUozphEOVXyykEcM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=n7hBOISs
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="n7hBOISs";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: Support IO port reads for Aspeed VGA cards
>
> The Aspeed VGA PCI device exposes an MMIO region in BAR2 that is mirrors
> the same registers exposed by I/O ports. All the reads/writes done by
> the VBIOS to I/O ports can be forwarded to this region. This allows
> the probe to complete and we get video output in u-boot.

Please fix 'that is mirrors' and 'u-boot' (U-Boot). The 'probably not
the right way' remark belongs below the '---' cut (Patch-notes if you
are using patman), not in the committed message.

>
> This is probably not the right way to do this, and I'm open to feedback
> on how this should be done.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/atibios.c         | 30 ++++++++++++++++++++++++++++++
>  drivers/bios_emulator/besys.c           | 12 ++++++++++++
>  drivers/bios_emulator/include/biosemu.h |  5 +++++
>  3 files changed, 47 insertions(+)

> diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
> @@ -483,6 +485,34 @@ int biosemu_setup(struct udevice *pcidev, BE_VGAInfo **vga_infop)
> +     /*
> +      * ASPEED VGA devices expose a relocatable I/O BAR (BAR2, 128 bytes)
> +      * that maps the legacy VGA ports 0x380-0x3ff. Use it to forward VGA
> +      * port I/O to the real card on platforms without x86-style I/O
> +      * port access.
> +      */
> +     if (device_is_on_pci_bus(pcidev)) {
> +             u16 vendor;
> +             u32 bar;
> +
> +             dm_pci_read_config16(pcidev, PCI_VENDOR_ID, &vendor);
> +             if (vendor == 0x1a03) {

I don't think this is the right place. biosemu_setup() is the shared
entry point for all bios_emulator users and shouldn't carry
vendor-specific quirks. Please move this into the aspeed_vga driver
and expose a small helper, e.g.

    void biosemu_set_vga_mmio(void *mmio);

which the aspeed_vga probe calls after biosemu_setup() and before
biosemu_run(). That keeps atibios.c generic and drops the vendor-ID
check plus the extra includes. device_is_on_pci_bus() is also
redundant - biosemu_setup() already calls dm_pci_get_bdf()
unconditionally on pcidev a few lines above.

If you keep the raw hex vendor, please use PCI_VENDOR_ID_ASPEED from
include/pci_ids.h.

> diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
> @@ -483,6 +485,34 @@ int biosemu_setup(struct udevice *pcidev, BE_VGAInfo **vga_infop)
> +                     _BE_env.vga_mmio = \
> +                             dm_pci_io_to_virt( \
> +                                                     pcidev,
> +                                                     bar & PCI_BASE_ADDRESS_IO_MASK,
> +                                                     0x80,
> +                                                     MAP_NOCACHE);

The line-continuation backslashes are not needed inside parentheses
and the indentation is odd. Please reformat as:

    _BE_env.vga_mmio = dm_pci_io_to_virt(pcidev,
                                         bar & PCI_BASE_ADDRESS_IO_MASK,
                                         0x80, MAP_NOCACHE);

Also 0x80 should be a named constant (the window size - matches the
0x380..0x3ff comment), and please check the error return:
dm_pci_io_to_virt() can return NULL.

> diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
> @@ -483,6 +485,34 @@ int biosemu_setup(struct udevice *pcidev, BE_VGAInfo **vga_infop)
> +                             printf("videoboot: VGA I/O via IO BAR2 %p\n",
> +                                    _BE_env.vga_mmio);

I suggest demoting to log_debug() - the existing 'videoboot:' printfs
predate the log framework and we shouldn't add new ones.

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -268,6 +268,12 @@ static u8 VGA_inpb (const int port)
>  {
>       u8 val = 0xff;
>
> +     /* Forward to the real card via its memory-mapped VGA port window */
> +     if (_BE_env.vga_mmio) {
> +             val = readb(_BE_env.vga_mmio + (port - 0x380));
> +             return val;
> +     }
> +

The window base 0x380 appears here, in the outpb path and in atibios.c
- please define it once (e.g. VGA_MMIO_BASE_PORT) alongside the
vga_mmio field in biosemu.h.

Also, since IS_VGA_PORT() now starts at 0x3b4 (patch 5), any port
below 0x3b4 will never reach here, but the window physically covers
0x380..0x3ff - just to check, does the VBIOS ever touch 0x380..0x3b3,
and if so should IS_VGA_PORT() be widened further? Worth a sentence in
the commit message either way.

> diff --git a/drivers/bios_emulator/besys.c b/drivers/bios_emulator/besys.c
> @@ -358,6 +364,12 @@ to use.
>  static void VGA_outpb (int port, u8 val)
>  {
> +     /* Forward to the real card via its memory-mapped VGA port window */
> +     if (_BE_env.vga_mmio) {
> +             writeb(val, _BE_env.vga_mmio + (port - 0x380));
> +             return;
> +     }
> +

BE_inw()/BE_outw() decompose word accesses into two VGA_inpb/VGA_outpb
calls, so 16-bit port ops produce two separate MMIO byte accesses.
Probably fine for VGA index/data pairs, but please confirm the Aspeed
BAR2 window tolerates that (some VGA-alike windows require a single
16-bit access to latch index+data atomically).

Regards,
Simon
