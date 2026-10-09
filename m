Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A55CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AFFB811F7;
	Fri,  9 Oct 2026 07:08:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wDORtQO71LIL; Fri,  9 Oct 2026 07:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2929D813A6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529737;
	b=rbK3CB26WcJkGeR6itCuwwc8vD47TwtG2mIwJlZ7iiPveir5i6lP44Lkikj5q7+AZ6bX
	 wMj5GzeEvv43y1jj6RtEhAIf7MbVCKkMqBrjCyZcx3vufj5jUX23CKRzLkVNWEOMGl2rH
	 VHaN6qaNe4r0VsfSxVYjljJpI6HpxI1EMUSSVsQqj2IKh0qA6es8U/DzSy2AsCWt+SWxK
	 0fA/thAlNPej60MA+rhW9XZPpHLHyXK1JFLc5sv1X7XUa5iC7cKVQfxbxqupklhi+tkc2
	 lVlnz/axWNKiFpCSyk0evSMrU9ZlZ3TAIMZ4QxS+X1u1mmicsg/RkB+ELwOPfylhJIQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0bcquIdNmYpk2QALjmgaIVVvUM7td1I0PpBFVckDvm4=;
	b=nl0iy2GR9b5F1NY8D63xi2OsJH9F7OvcdLwmW3gAkeCC52nnC31Spl1ZfQSTxj++uIJ0
	 4EM8wW0AtJla6EhDnJVu3S8io5E7NbKF6WfL+ehW4yifSfHaTcN8IVgjCEHCu+iQs4hUy
	 y7bmtIzHBnLgpbkMeGTXcFCf9yAcaYgwRxUjodCYUgv2IKCc6redvcT84sh4a7KfNk22E
	 739o/mDlZ2C4UEXaMoU7LO1pARypKqm6I+uq2fZnfjCfJ/eGC7TXYeBO7UhsbzeGSY8eg
	 AHjr2kqEFej0So/yTq2I2LYydFr5/MDHWKvLvwvWZnuj9pTgawN8UqWFAZfvEITjZ3Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529737;
	bh=0bcquIdNmYpk2QALjmgaIVVvUM7td1I0PpBFVckDvm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ZMMdbyTxO1BqeE728pId/XOV1wlWJhmonksVuK0GY2PNo4pSila6Hrg8h0F5HP9H
	 /Izhi0ZiPsVgaigiM+vG+mqvs85DWrWl4rqjuLfuHuYA4nqt0m5grqCW8lGYDs/bQJ
	 eDwqUeGu3OZabT4EnhtzHrtt57IcsPJiPkGyvRzqeGhB21pUA6WNSmfqW8uZnrNmPY
	 4+/K9YBYVCg4NMW9mXejOcJ7TesuL/IHYeRYqcUhKWDjxXmhKeVJKqhfmT7sAiJEJN
	 acv/AQt33YyMbgNARkws9FBnLhZ9leKy6MopVekYzMrwWpqKqyZk2JZzJ5GACJsRtP
	 hsQ/VOxRc6m3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2929D813A6;
	Fri,  9 Oct 2026 07:08:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F32E75
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 707BF606CC
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLg4Doc7Xlyh for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DC5260670
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529734;
 b=GGIndza0f1pLRKR/msvfoOEYyeXlpTXnTEiqxxy57632uKbynOOspmxxtEeC0/VMvj4t
 crJ/SyHlroay2Qw2xKathESh1k+hFEPFOiDxWki+Dte/0KTg1BJw+gorgezXL/AzGkQKN
 VdGzNkTuqZIh1lS7FkHQiEF4n9vEMmSBrCh8jRS7vcF042gcu72/4RVA59FsKscx3AKnj
 3OU3B2VCkPME7DDhftiYdg0RMawxVG4cdzfiKm9uJUTRrbG99aBysyIoTy0cfbrWtqxof
 L1QAj0KfLUExIqEPLZ9o6cfnM2OJI9UjS/KJr4vaDjEicQHxT4GCk85eBalYqz8g0qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529734;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=0bcquIdNmYpk2QALjmgaIVVvUM7td1I0PpBFVckDvm4=;
 b=pUExxQL1eeR7JwyoVxwWuqJ8FPv19a2rCoXjOl7LZRn9yxXQd1emPHB2KpN3L0ME2CCs
 tC/tE6nyc5Vfj/KKMi88bRVrwzGCPOGuPEFSiB2qDnbZWfXHquZk7mNhNh9lw4PPQqrHk
 F+Nq3n9SxwgFDy28JbTPiCnezgkm2UEaPr/D+dJirMNDb4nGpuMXmFWURjDPXlkwxRscn
 ZYLovvWG384IA2Fexoa/5VOjiNGBtFgkZUu3zdYctfo1pcY8wrbvsQfw9F91jZ2RtbS9E
 mr3vbvg75XO8b0Fruddkynh+jQSv5VGYNRNdzEldtZxb4dXemHC3SCr/5H0Fn1Js8Fw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h6OyYLIL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h6OyYLIL
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DC5260670
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:08:53 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6aa9164072cso3797390a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529732; cv=none;
 d=google.com; s=arc-20260327;
 b=NE+8Q0RcZHD2aQjLK1lwCPbD93S+OapFrwMW8gj9AhOrXfe7CQmJhZLeDWqr/p89LD
 JwC/bi8EL1OHR4vc23Uc8089pmNOFxUrD6DvXj6no6yf9KM1joY64m5DmUlC9oEBZ5Wg
 wsJgouzJ+TW1M1EOdeJKoq/Rp/YYXbuHLSIcldStdgC4jAC5lSVS73EYPSWgwxzVWlud
 EVQLr9YHLYOGAfgOHFW8Xtf7uXlYpF1HoFeW6UFsYmek7pwe5MzCDy1Cb0x7Rmr0BkRi
 e1gHvxRrg/QTnn6XaFXRdRhZz6AQJaC0qFWxCPETlczVOw8PmO7LLZIqmTHVWfIHH8It
 ix7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0bcquIdNmYpk2QALjmgaIVVvUM7td1I0PpBFVckDvm4=;
 fh=D+ymJ+Wilr832Htl4LFysBWEpWfEL2YdoYDBqUEwbLA=;
 b=PBKoy0y0RwVQXYDJc36NiUyvKGiZ2VvOWFYxN6Ooku6uOtHGgfl+gc+JJW/2bVWI34
 nff3DK3UpELPpb3qaGxGG8MAZE/NuzZYSWiYo84d/EoTKXo8+eUw3OODjMxxLJE4JEZs
 YrgKSEMWscKSxcnDDtXa5MreJ18efm+0E9CdP61uX4rKsZc8BOj/0LQeehH+DSSdxUsd
 0AcPNi5+GzGQDCfU4b9bK5iDAsmUCsJCTdbTWJsXFDr9JvxkYkOwIer+6LTV8yVXLoZR
 8CeNmK04DlxEXaFSlfD9M2tesunZPJvThAUEbPr3y+tW+b5hp/WGrNwXW8dWojyvW2wJ
 FFCw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791529732; x=1792134532;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0bcquIdNmYpk2QALjmgaIVVvUM7td1I0PpBFVckDvm4=;
 b=h6OyYLILkkve/JhYkPAfTt3QZ4VyKqGHdNyFPxrba8v/rxAhwkkePQltSxRgCniSpY
 JCbAwfwaQRSHQmPol4ruoaWTUF3guDEW72cBJZVqsRrtRofvqYiImMG0xvBAcMTnZiOA
 SNK07C4pkQP+Kai0F9tPhOtw9FPmpbHwzK5bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529732; x=1792134532;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0bcquIdNmYpk2QALjmgaIVVvUM7td1I0PpBFVckDvm4=;
 b=pSf3X+kpZUppZmPv0bCYlSmS7NneqT9Ng7i+7PFYcOxIrh2TZKsCdb9OnlhmtGruii
 qtPAG3JbWXjBu5EVHKUsVi41acSmV9SSNs9Duto742rxGsinTfeWi6heNUqk/5ESotDQ
 Sz17kvc2h9TeIZ5TY/N2vvHfzcC43KIIf1eZmvMhkgxRm2XMFW4NHXfpoMZIzALyIoxK
 0d4/xSKo3MSOHEhaEPoNXPliIMEJY+5xWJtljUJvWLh/l52Y+//0LsvSgPscFLkxOz55
 jnscBqV5D/juSQiLLVdxHSwXr3uCOe2VPA7aoobJ6HmMUe3NAPAWPEEBmfj9ZtN/SQzs
 LsLw==
X-Gm-Message-State: AFq9FYK8SGSSDQVBfd0uz7eXF4eWkH0Cge4Yr42kr0wr4i/g8emopCkl
 /ZjPB45zhDeTtqXgIolti9dMg7bghdhMuPvzco3p3w+Vlg15EHnSmk606rcRPca5+OYigu1mQ4M
 3ol+m4VO+Zl0veK7zHU4PBeASrCvyZxTDEPGzuehh
X-Gm-Gg: AYBFou2fwOO7GgkADeSSlNiMvtljZSY+B23ixtv4M9GO1dtHM0jPI6A+A6I2DSBOWM5
 oicLhixHJ5rUVMqeQft4gVlbBAKKeApaD9tcERg9jvVqjh/2JCWLMBxbEmbyWn63jKKIPR715VR
 5Pu6R3OV2uNwcN67CUDiav+p3AHyfndtWSvvTa9Mj+BDZIBrOF+WiyhTe0wS4cZh3ZjjV2//Ghv
 U7Tmpix4eXm3gXOT9j7nHzTRRPO3L5KR2BLv+iYgYoYchY45RXeGlZPGPbJpcTvAtVl8xZ1KX8F
 SMS0WZ3V8JPwOhGfI5nL9WSdKzYIEzLiGEUmfXrxj9iZ/lRaRVQ8Ue+ymNSTYfYEhA==
X-Received: by 2002:a05:6402:4486:b0:6ac:73f8:2e4f with SMTP id
 4fb4d7f45d1cf-6b17c268e61mr682285a12.29.1791529731883; Fri, 09 Oct 2026
 00:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-5-hs@nabladev.com>
In-Reply-To: <20261004040657.3156402-5-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:08:38 +0100
X-Gm-Features: AclHuK_Y8wk1_6ZcrdeibXW8ZLvUEw07YBYcg-Z-O5Irfgk5K4a0K1Ai7s_50bw
Message-ID: <CAFLszThWnBLQVZvpDAdD_zD_xDPe0x8ed4peMXpfFF6a13=rrQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] sandbox: spi: let a slave point at the emulation
 it needs
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Heiko,

On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> sandbox: spi: let a slave point at the emulation it needs
>
> sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
> on the sandbox SPI bus, whatever that slave is, so a device of another
> kind cannot be emulated and cannot be tested.
>
> As with I2C and PCI, a slave can point to an emulation node via a
> sandbox,emul phandle. Its compatible selects the driver. Without the
> property, the flash emulator remains bound to the slave node as before.
>
> Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
> here. It is no longer specific to SPI NOR, and the old name would
> mislead every new caller.
>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> drivers/mtd/spi/sandbox.c | 65 ++++++++++++++++++++++++++++++++++++++---------
>  include/spi_flash.h       |  2 +-
>  test/dm/sf.c              |  4 +--
>  test/dm/spi.c             | 10 ++++----
>  4 files changed, 61 insertions(+), 20 deletions(-)

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
>  #ifdef CONFIG_SPI_FLASH
> -int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
> -                      struct udevice *bus, ofnode node, const char *spec)
> +/**
> + * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave

The generic part (following the sandbox,emul phandle) now lives in the
SPI NOR emulator, inside #ifdef CONFIG_SPI_FLASH, as does the only
non-weak sandbox_spi_get_emul(). So emulating an SRAM, or anything
else that is not flash, needs SPI_FLASH and SPI_FLASH_SANDBOX enabled.
Please can you move the phandle lookup and sandbox_spi_get_emul() into
drivers/spi/sandbox_spi.c, replacing the __weak version? The flash
emulator can then supply just the fallback for nodes with no
sandbox,emul property.

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> +     if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
> +                                         &args)) {
> +             ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
> +             if (ret)
> +                     printf("Cannot bind emulator from node '%s' (err=%d)\n",
> +                            ofnode_get_name(args.node), ret);
> +
> +             return ret;
> +     }

lists_bind_fdt() returns 0 and sets *emulp to NULL when no driver
matches the compatible, e.g. with CONFIG_SPI_RAM_SANDBOX off. NULL is
then stored in state->spi[][].emul, sandbox_spi_get_emul() succeeds,
and sandbox_spi_xfer() gets -EINVAL from device_probe(NULL) with no
hint about the cause. sandbox_spi_unbind_emul() would also pass NULL
to device_remove(). Please check for a NULL device and return -ENOENT
with a message naming the node.

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> +static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
> +                                const char *spec, struct udevice **emulp)

This binds a device rather than looking one up, so the name is
misleading. Also, I2C and PCI do not bind on demand: their emulators
are bound by the normal DT scan under an emulation parent node, then
found with uclass_get_device_by_phandle(..., "sandbox,emul", ...). If
SPI did the same, you could drop the lists_bind_fdt() call, and tests
would no longer need to unbind the emulator by hand before devices are
destroyed. Here the emulator node is a child of the slave, so it would
also be bound twice if the SRAM driver (or the MTD uclass) ever
scanned its children. What do you think?

> diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
> @@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
> +int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
> +                      struct udevice *bus, ofnode node, const char *spec)

The unbind function is renamed because it is no longer specific to SPI
NOR, but this one, which now binds any emulator too, keeps the 'sf'
name. Please rename it to sandbox_spi_bind_emul() so the two stay
consistent.

> diff --git a/include/spi_flash.h b/include/spi_flash.h
> @@ -136,7 +136,7 @@ struct sandbox_state;
> -void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
> +void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs);

If this is now a generic SPI helper, it should be declared in
include/spi.h next to sandbox_spi_get_emul(), not in spi_flash.h under
DM_SPI_FLASH.

Regards,
Simon
