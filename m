Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5D3FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 05:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDECC84106;
	Tue, 28 Apr 2026 07:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mvr+VdLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0868A84106; Tue, 28 Apr 2026 07:15:17 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E048E83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd8ef572aso4018696a34.1
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 22:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777353313; cv=none;
 d=google.com; s=arc-20240605;
 b=SlnRHSUdjhPYfwZ599xC1GwWapHF61Kb8Q2XfJ/waTMhR0pZ85J9LZNpIWbTps+yBm
 +JfQauOQOcwSnjGqwQIP1FsKwENFoZMyjcCZOVsEXAv9PwFZTrVDiub5hvQSIe7Q5etl
 Xz7B1T0StiRohMDY2duqpRxjdEml+214kBvx4otmVoJShdBfKYBTeO077jDSDIEcLebN
 T0xDKJnQOLrIxvCytRvG0Z067O7WazGqwOoEunJ6t+WcbQYlB/EfILZ+cdsH2QBb1Gn0
 502p6Eie5rr/ogGQFHKi49KFhlslJzxgb3QMnlqLs7SD47zCC/y5/SpQ433+pyw4w8Ll
 EteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0lfuwFkuvxwzFtHO8MoQWFeJmT02YiZPsvmxx9tAgGk=;
 fh=QMZdvVsxvWCHNNEpcAbJd4pzxODbhoOY9yjXiTqL0Z0=;
 b=AZ7zMZR82K4Fo+vPxh1CERFXM0KM5pt9nlLKzUxCZRXZfpkAiFaCXPWIvcfnHA9/9w
 OV4l8AIU1GWByj+JdtMbZyrNlq6uZaoPjcHO0NiOnM54epY87nBipOvasbELBSOIwx/P
 11JKfG8O46Rn1gCmRt8MagXG+XDlYD7MiaBoR68ZVuVaNXLOgIcG7wWRsep1/AdRFo9i
 XRzUfJN4HZemwAxjLBxgKJ1FJ0OIs6KjoVsFjMYsuHo4o6wa2yqZ6Cm7XoYB555PNiIe
 a47F1WVjzTlfkP/HwltZlZnqP7cSsLUU5THFy9vUEEXoTJ6CbtJ+KH4yAT1gHLfd+rvn
 h9+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777353313; x=1777958113; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lfuwFkuvxwzFtHO8MoQWFeJmT02YiZPsvmxx9tAgGk=;
 b=mvr+VdLQB4qcAYU5ftbdexqHdypYGVdHFDn/RMZtDAst9rz0k/vxfypcFdPpdEmNfx
 BB61H2+8/Lqq+qA27XvaBoOcvdjR1NzBUpLoZtvJDPsdsug38g2+LVWskjBlgFfQkNS5
 eg+6FYtkPN7UmZt7OHhT7NIETGGFoLlGfH7aiCgGtUvev/Cp77/LiaW3at7V3rExe8/P
 JIi0Unn3tquhNko3GJyEYaq+KXxafy1azQ2lMGmgdp5WGp07fVK2rIUuWTAwA8muUq+R
 cVO0z413U1EwbDzatKRVGQ/E8mPWvwerumPZOiqrIryr0Y+wr1McjAd+cSHw9ilW4T3z
 Ij2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777353313; x=1777958113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0lfuwFkuvxwzFtHO8MoQWFeJmT02YiZPsvmxx9tAgGk=;
 b=i0BPA1Dmg/O4EZHVAlnqeYSMiJkP76ADli+M2J0UiKZDtIpflrTYIR1q4GVN/sWAkO
 N+sJCb+awgvTD/4VHkeznTevXY9UETIoZRIz75ku7ol/jJR19IvGOFLOPx5rVEXAUXIr
 Y8dz2AjpONpm+cVVdcWMf8Bb81WmfVUaVUy6p7t2NzgRmEDcvNTghbROdHZyW810p4YE
 1mkxBRsgYGhzv9DrbWdX00/8p10x/aVAdnzo9rr0WuTO2RNWyOeHkxSgfR6YXMpLnMkf
 MmqHGKt7PrL8YJ78KCMLTXsEHByYk0OhaKPIrbuC4B3+2cMWnoAMW2ZQPIzG83qW3QS+
 JMeQ==
X-Gm-Message-State: AOJu0YyslDYEpBoLhhBBS2w8e9Fr0m5UEeDPje4M3fpWEn7fbuSy20ny
 HSQEoealayJS5oAGjv/s7AcX530FYEXcVLNmaXMI71WlxHs0ds+FW33tibLqrKziPJ7uJ2C5LlJ
 JJ9uMgpX9NNpaOB0RAP/3SBMFsRr1N4g=
X-Gm-Gg: AeBDieua7io17IDqL0idZPoisL1t8iW3AT4Nt4m+bioENWPbpknEu8EZKQpwH+8ewtU
 fSAqrw+/6gF1yLu2g6I270kFED5ohP+gRcA7wpRHv2t9S0tif/SZ9agIck0HVjm5k3fD7LEqkNv
 qgZlRny7xssHsoxtIJ9G/hJFc+MnmuM1IDE8KBWq76MpMeBD3LHu4Nr+Mi8y7b2TnY1qHMzreMP
 oD/m689PCQtLXFylEQhPSAQg6inmOYjzA6KALZZiQkAzkMun7mIJA9ivUsAcNGAONAQAvEkZuhc
 0qazU7il22TDzjO0vZUDw/s0AIA3bQ==
X-Received: by 2002:a05:6830:6d4e:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7de9a0cb4f8mr1037082a34.17.1777353313476; Mon, 27 Apr 2026
 22:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260428033230.7777-2-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 28 Apr 2026 13:15:01 +0800
X-Gm-Features: AVHnY4KHaUXgJme3jAO8pr-1U-Fy8UW0FZvXjwLU9JlCkp6YdVNET0ZFjvDV_qE
Message-ID: <CAN7C2SAx=J6a=z7TyrVW2PcZT14wtOvqSQDkFRBhxPJ_xgazHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Apr 28, 2026 at 11:32=E2=80=AFAM <alif.zakuan.yuslaimi@altera.com> =
wrote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Relocate the dram_bank_mmu_setup() implementation from misc_arria10.c to
> the common socfpga misc.c and update the function to correctly handle bot=
h
> pre-relocation and post-relocation cases for DRAM cache enabling for
> consistent MMU/dcache setup across Arria10 and CycloneV platforms.
>
> These changes help to improve maintainability and consistency of DRAM
> initialization as well as MMU configuration for Arria10 and CycloneV
> platforms.
>
> New Kconfig is introduced to enable this implementation only on the defau=
lt
> Arria10 and CycloneV boards as this will increase the SPL size which
> will exceed some Gen5 devices' SPL size limit.
>
> Fixes: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before reloca=
tion")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---

For GEN5 cyclone V:
Custom board
512x16 DDR3 die x 3
ECC supported to max Cyclone V allowed
No boot issue on soft / hard reset

log:
U-Boot SPL 2026.07-rc1-dirty (Apr 28 2026 - 13:09:08 +0800)
DDRCAL: Scrubbing ECC RAM (2048 MiB).
DDRCAL: SDRAM-ECC initialized success with 1057 ms
Trying to boot from MMC1


U-Boot 2026.07-rc1-dirty (Apr 28 2026 - 13:09:08 +0800)

Tested-by: Brian Sune <briansune@gmail.com>

>  arch/arm/mach-socfpga/Kconfig        |  1 +
>  arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++

>  3 files changed, 32 insertions(+), 26 deletions(-)
