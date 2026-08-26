Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDFBC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 14:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F82A4054C;
	Wed, 26 Aug 2026 14:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RoTrCsfK1SrC; Wed, 26 Aug 2026 14:01:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787752883;
	bh=HaihveUB57n7z+1DY1Py7R0JzasjKGuUpfbjcX2/rLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HREPoZpHwjIo1Z8yFt0vSg23RDW7+EO0224bEe9m+oUGOPADNdUWTaUxZ7V9ONf7C
	 WiKPlDGJvfz3108Cc/hTQrZwvFo8STvyTfxT2ZDFvjqW6OaCPBV5rJZ3fepnRNpV0K
	 //Nv31rZ9MtjSwFd6C0f0SeyMnDRJL1bdle3rEt+JDxRPV/dKinNP9JB9FoYZyd0Yb
	 ArNHTWHF5m+VZDqG1hHlrY3qP9FTrksxOZUR9m/JXhhnOyGq4kyJBSHIzy71EZ3rX+
	 xPAu2rBEj2WMymtP1c58oM77wSJwnQZtGoWv9nZ0a36KD14n8CRs0tsyZOMS38E0R2
	 KT8X/fyvJUKEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E81F40546;
	Wed, 26 Aug 2026 14:01:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C7738F1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A2E94053F
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:01:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5npfCyZXW29 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 14:01:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=llZ5lH2u
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B89A640532
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 14:01:20 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-7dbcb505578so9895817b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 07:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787752879; cv=none;
 d=google.com; s=arc-20260327;
 b=CzRUFrO/hbJu/XtshriRWzro2R52xKvINvUsFYHDMMlWiqbDEG/V4Lhrd2fyZOeWjy
 2MEn7eicaVKAbwOnfFCGXih0xKhtMWoXHcpepB7QnPhqSjGtKA7w5S0zuTXtQsP1MwW3
 1zAPg4folw6qSldmPC3Y0j6FVpxmOz2+8WHRLK1d38HhSec7xMf29TbY9zgWsTVm3YNH
 eZu2vuWLRYZ8cBl94/xuCkk4n3pCuXDf/mDXKaVd3ADQ/Er3uHPu/1oSMLziP9VVbZub
 Y6EKXYGxnv2L00uggdDgmWUlShpkaz+FV8x9hjTMcRjQFEhXISU9IxWZKCpCPu0Zd2OH
 tgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HaihveUB57n7z+1DY1Py7R0JzasjKGuUpfbjcX2/rLE=;
 fh=2SflGqsDiYBlFNcTJ969Tz2TZ3f/ggOjp6JrahleBXE=;
 b=N2YP8IwZGC5BmtaIu3EGJJucAZXjTDg7g6Mvhe3xf/u4MXnaZ/fKqWEbvXIgelOOKK
 BBz7M/xRZ4djtTgRwg4SgkQ2+KZG51Z1MCT2hyPSlKuK6B0r/VwnGR0O9fCbFV5yVtOY
 WIJmR66UKy5Nlv98P6cSR7XTq9GpMs/PpkEkn4OFApRNKrbZ9I6qWecvKPVdZC1bIRwZ
 3BQNHNvyhGK5mO8AiQhfLK965BxFOywbsLiwFZK7bj8Wzrh/jwxfLZpqNlye+h59gnOp
 yavSO6LLxOjB//mtDHlrAi+bqjtSg16tSZoHjZWi8ujmBBPXuWxPMQXEKpjpeDqg0GEX
 ohoA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787752879; x=1788357679;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HaihveUB57n7z+1DY1Py7R0JzasjKGuUpfbjcX2/rLE=;
 b=llZ5lH2uIVPtGE1CTvDo0ldcarsRAl64kYE3E3Cp5aIOtCQIwQMSu7gDX81bDgHmsj
 q95yuVd+M2XtrrOGTiqD8xW0DHz6sCIATK9HULwOTVeOyMQqKFoOTBZOWAwWWdpG00am
 A06+l2ZeIZ1Ny/cAi/nSFs70zlzVQ9M/6DgIUXRtGuWnRYhMSSaPQzIl2BgWEKauIymw
 33H2RcouTT8smQYWYO5TLsT0MVOhHdsXsCW1ULSdxaDpCaXF6O7sAYaWFkGAcRbApwnQ
 qK1XYTriMxbe9PltbNwU8GNZDhx1l97LuwQx8VqyMn2i6HNrFkpsAoclBgxdi9hWHM+D
 30+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787752879; x=1788357679;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HaihveUB57n7z+1DY1Py7R0JzasjKGuUpfbjcX2/rLE=;
 b=o9mlUufBZmSAYd1enr3UGQSXBMj1USp4J2wZH0HfYlOXp1mRHsRrPoR2Mg1KeoRlHv
 FjDVzUouNjUlx4929Xt47cnFvgk3SH8L0ie/GUllwO40z7eq7eEvetUNZ3qM5XZLILtO
 GefCIMPxK8c4fhSN9nUfQQGEOJIBcsdWmf0xW9nVoiOUu/RSxsbDstWSLhZ4k4zhV0Sz
 wiqMc7qCcD7yspEVsiMWsBsjJgpRvsYQADrRzIJFin2Ipq5Ul1X6mD4Ntyf/F30eZ+cY
 v9oNrjJY0NkmUi9LQBOXEk3L4+8ZNE9btqGgzN/WszO3pljkzst9VR4c+ssjfU4ip4f8
 7qvA==
X-Gm-Message-State: AFuF++mn5eGT7rNEclWw/9vHZOXCPN+C9nPImngY7eLLLWC1KiG5eHz3
 slG/shyO8dwIfwsd8GfMreQMoBx1qkR8g6A4rFdiM63LI4YR8+GGNwS40yBKjd59ZlummwIpJcv
 LW81qtaE2akIPPY1cJIczEC+gBPtt+xg3mftrH+4TIH5lm0OZ0+Pqkd0WiA==
X-Gm-Gg: AR+sD12UpWZsxMXwBuEFU1XIMDXYdKQOigFs+HYGhS0OQVYVD3EdT1rKNCjMHwzdned
 +2eEYTIZMELc7Zy79VFMST6U4TZmax9XVnSNphMz0pQhIqMIBWdGRhsfaWDjRSxLBPbBANs2b7a
 dxMk9hIVCC9oSMIahznObiUd1Ig79WJBY2lhGSMEPAhOg6bPZYaYPP9HglYbfXfV5x660663gIV
 EPIEVMzSWobMqtOtxwA3WdWN9SWwMzC86Q0PZ1FBuiEBlIWZHp1PSXu7rpRiq/gxEf9RKF0D9vO
 sM+Grp3HAf9ckgSE5YQjnppC5S4X7cyFVvfNYG96ZVtiIxP6K8Uq9yocdS+o+YoiuUPFgnGq/Xq
 nq+loIn81xCinNZnwY+mUEGdqigzgyng3W8OsqVgRqO6c9/Y7ETqgywdSuOZ0dpPO/MV/qmJuKc
 i2xc7M4e1W9kLYeIzuTV1sWqxi8iK0pI74nG/YNtG1p26ZNdce0fP1RXucfw092/VIXoVQKuXm2
 Vcu/OPB9qqWDKqykvuYOg+zLMY80PRbwUPd3n1QBX5j1ks9/MIGCcjWIBwrUMOfUwE3RXJKta56
 ExKgWvhp1OXlI7V7sbZ/fyvMImnUrCbnqAAq4llWzsDGP+/KgXWHu5N5pN5WMcyvzEvTKYncFSC
 oJvnRJcAyueVS9yM7z6LwberVh+STJCflZt0ixwRhLdQ4
X-Received: by 2002:a05:690e:1306:b0:66c:f55f:cd9b with SMTP id
 956f58d0204a3-66d257cb144mr1929958d50.46.1787752878692; Wed, 26 Aug 2026
 07:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <067b90dbb09718c8c9b73a049702e2df30544849.1787745885.git.michal.simek@amd.com>
 <5908d1dcf2a650cac2b22d82e7f789b978f70748.1787745885.git.michal.simek@amd.com>
In-Reply-To: <5908d1dcf2a650cac2b22d82e7f789b978f70748.1787745885.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 26 Aug 2026 17:00:42 +0300
X-Gm-Features: AcwNN1WxvK6zGK4M819huODjSLPtHTM_OkMYxA9KgVMAWzqQ_q8B4GwSHnzZoM0
Message-ID: <CAC_iWjKrkp=T8nZitOZm0e7m8vsjxF2Xn7N1x2CvCpOj5DscZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] board: xilinx: versal-net: move
 platform_id/platform_version to .data
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.u-boot-project.org, git@amd.com, 
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 26 Aug 2026 at 15:05, Michal Simek <michal.simek@amd.com> wrote:
>
> From: Suraj Kakade <suraj.hanumantkakade@amd.com>
>
> platform_id and platform_version are plain uninitialized statics,
> placing them in .bss. U-Boot's linker script overlays .bss at the
> same address as .rela.dyn (the relocation table), which is safe only
> if nothing writes to .bss before relocation completes.
>
> soc_detection() writes these variables during early board_init_f(),
> well before relocation, corrupting live .rela.dyn entries. When
> relocate_code() later reads the corrupted entry, it writes to an
> invalid, unaligned address. QEMU 8.x tolerated this silently, QEMU
> 10.x enforces alignment checks and traps it, causing U-Boot to hang
> right after printing "DRAM:  2 GiB", never reaching the console
> prompt.
>
> Move both variables to .data via __section(".data") so they no longer
> share an address with the relocation table.
>
> Fixes: f6aebdf676ed ("arm64: versal-net: Add support for Versal NET platform")
> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
>  arch/arm/mach-versal-net/cpu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
> index 7df7c49ac711..1555751da2e8 100644
> --- a/arch/arm/mach-versal-net/cpu.c
> +++ b/arch/arm/mach-versal-net/cpu.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2021 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
>   *
>   * Michal Simek <michal.simek@amd.com>
>   */
> @@ -151,7 +151,8 @@ u8 __weak versal_net_get_bootmode(void)
>         return reg & BOOT_MODES_MASK;
>  }
>
> -static u32 platform_id, platform_version;
> +static u32 platform_id __section(".data");
> +static u32 platform_version __section(".data");
>
>  char *soc_name_decode(void)
>  {
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> branch: xnext/data_section
>
> --
> 2.43.0
>
