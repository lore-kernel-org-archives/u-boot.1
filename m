Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3995CCF2DA
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 08:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA12980F61;
	Mon, 19 Oct 2026 08:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdGx3_WGmj6h; Mon, 19 Oct 2026 08:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0603A80EC7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792398797;
	b=o+FFTa1DcwwnRutDisUvpu+wZYwmqTxyag+ttwEF5OCGGbuVjX+ITCyHedfIhFu4Aa/w
	 3E4t3hv/DqipEXdIH1LRw/t83Vft1E5ExYupRW6ce2IbPQoSxtqlBPwEd5Z/yA2ZiELHA
	 uT4LkB2RVa+FOahAFW6G9h5hJQb0NnebezrSprB0EkWvuX7sJ0Ex8YgsoVlYu7/huYbhv
	 j+HfOEpEBEUqTNZ4qvqGRdE7Ye9AR8OpxiYGCfCFity58b8/YpFSYIVBXbdDy1vGedyno
	 uPv5AHe67FlX4qUikB4UfjcjrLL9StCvSg5if7VqopK2eppDWcJirVsoXnN2PRiBeaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792398797;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4Tel47GRGFh6qPC4e3rB0X+QnLVnVRsX1Q6+m63VD9o=;
	b=ZzheMGvUO5hmmXHSfw9uV4fi6JyUNWMxFRNl2/SGk6X2Lo6NUUqvk1Nm0xK1bf1tmGIH
	 Q6ZPRXHyy8csxKCENrhkIFbDFJ+fNLCl7f6fnTFr4yzSP4OyOZeZM8ZuPGA6EliwwZbBb
	 xW6tVw72OW3+loZryL/eVK64V9nDkC+/4yprdHvZpTmvJhFqR6Nq6RbxRz62+oAVrfHlq
	 12HpaAvEBz3SXc7wELUWWObfV7M5+4Vpa1odOHVL+i7k0INGxRBdYyYTgGi5s+MqbQFRK
	 PQKQjnbWlVdlpnqiR5M251y5qydzTn0qwe06q3QkCfzWpv20ROA3uPCmByMR8RzNayQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792398797;
	bh=4Tel47GRGFh6qPC4e3rB0X+QnLVnVRsX1Q6+m63VD9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ftmU3D8Gi5DAWxd/oqbPEyb+ZY+Pej+vyOX0C/t0Rh6QwYqea1xkmAoum1vRwezq6
	 I6cjlLmW9lmzQD9pkCSDp8NnuEPpDjzT2sldI+VmqQ1GOUQ66qfUCG+jJIJHyKqsPQ
	 vO359FS85HdS3GgbQaqfmhhTGndiuPPaQWOYFaKug6pYMU5pucIjH/HNflBO7zgSrP
	 Tfd9wtuHrWQr97v0qHhjFuV1PbAGoPC5AYuzk8dQTeebUolb2QDH43XT4qU6WlK2CU
	 amH8Q+3nfkgFsEbfW7SKqXiZFGGeqFANFD9ue3pRHmRwKZtI8eGDFdcv5CUQSIYPSs
	 Rw94/QKduiZrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0603A80EC7;
	Mon, 19 Oct 2026 08:33:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9BCE2279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 996F060612
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPQFVtX-rtRj for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 08:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D4AA605FA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792398794;
 b=s57aVd9xzVo9bgGgIzHulsL0c+HAXdpdpC1ZArDnFkMq94E4LIUOkM2T/5z1DOaVcaZC
 Uc7oMzwmfK18IFBgBdUUp1FKMrZ6Qb9ESUeBGhmlqoU0QsBj1MnLFf75NJR0H0GPdKKce
 n8yLNPk4kc5qmYEZEKkCyBQH2RpUR7GmGXkgbv2wL724OwGGtnFiqaath6MpCsypwPCzo
 TkiJqvb0QCOiMhqmnRE5QSfeBtRAD58MJw5R5+H6Nwtfsy00rovlsf2MyH7dcq0USVbIz
 EeFjpT3OgxXoUFJvLdbI2RtMzSevbM01flCsEdRnDwPpedVVwa9BS221a7EZRO5OsSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792398794;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=4Tel47GRGFh6qPC4e3rB0X+QnLVnVRsX1Q6+m63VD9o=;
 b=eApaKDavWlkcqiLP9azGN1+nIx7wONp1QRB9U4qDq64tlBO1NhGyeNbdFa5632PAp7+t
 9Ha5yTtPgajJ3kLM5HWXj2vPESbzSjU1UQT1bg0jEbO64qUX82BQN2m/1Ib/KVwkNH/Sv
 mf3ecCNxtYv6RTH84MKP4/1054BLl+kOpr8BDj/38kBzSg10iC9gItZFlaMcKEt+lZkSr
 G7sNp5B9La2HwDSXnY6WRgMbOFbHOqe2ot4oN1P2YDgK5RzI805TPlWJ5cP8wMUDcsBSv
 zLwA5hsR0savgkYUw4WiVsqygaN+uw3crRqJpkvnQcnLTxtaoTFxOh/miRF6r0aHlUA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=riscstar.com;
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=N51RyxfR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22a; helo=mail-lj1-x22a.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=N51RyxfR
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D4AA605FA
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 08:33:13 +0000 (UTC)
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3aae7df0971so12092841fa.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 01:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792398791; cv=none;
 d=google.com; s=arc-20260327;
 b=k/FIfGAo9jLhQWKjIQMqbModAE0NSFHjil+me4vc+LlAJPhXkyaGFhkhOrLHd0a3El
 Ua3CAj5C68ec05lpku5iG/2oCudNrWdzYtGUe/yuEPx/H2Cc2sY5yJ8FuFTkeFYYEpQ1
 vviL66s958G/aw2QL5r6qDcT5Lp7mEY++3nZNofvARv7BjPqe4or6vydbJbEhoB3kjT9
 U0YNSK5tcAra50VjILI8dPNpfppS+YZ1KQv4PK/NHzsctJ4yDFUgKvIqCOypdAxBlJX3
 fddmBBYVxj9FnvwXgx4flJ07TMODQQuXa0BWAkwNUg9wDv6w7gBm8+ososAyli7UWXbC
 kV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4Tel47GRGFh6qPC4e3rB0X+QnLVnVRsX1Q6+m63VD9o=;
 fh=PssCzfAZagILEbYV0uOcrKn/3Pne2m6Yt2vbWJ+c4C4=;
 b=qWT80zzNdSztBh04bafBr1Ne6M2swx6wjqE2wmxRI3ePiMo3cubQTG8yEopx0xnxoy
 ZdrNCydqPlKyf44wSBeu4QujGGDnyuxCCyKck9GQfrlM/YeVq/56sYzgCyy+5pCVv8mG
 U1E1dDVDGr7kdU5wrSfKe9RaWQ+Zmq50pUQOrWMNFwyypTfa3iTSMGn0xbbO1rPlvkhT
 RFbQPMJVMzZPYQYDRwt/AifoHQtF+oioeyw//DHrd7jwKE5g58AiFDSH/e/JOMO2Bm4k
 P8wpj492fcvPCZjCe8z4tTHvDrc+nCzlEjyQ1nWnvXOuax8SdPS/vuoE08DdwQnbKy48
 vj7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1792398791; x=1793003591;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4Tel47GRGFh6qPC4e3rB0X+QnLVnVRsX1Q6+m63VD9o=;
 b=N51RyxfRakKDrIv7s/R4ecgJH/0XYjb3shP0CXdnXZtBcyycKV/P9j6UzNCseHSTsI
 G75H2TeyBNalCjwFjsLrhURUfq2LXGLBtQdAOCmA/JvFrJjb7Uhli5Yz5Arr9YLyh8EG
 VuW7APEkbfF8XGHjVErr5bQQBzb4xNmo5Pwxr5xpg8S5QyFKSrRbm7kE0CwYppnPoMuv
 GMasFo1YAK8KqVan0vyRwlOAkp06lpr5nkz+BOywpIV5Hr4iSHw2F26XUM0SobOLZ/+N
 LvWNl+qBoRUXEEMm5dMQNr0WTZHVZ+le2VB+36RYogSDus1lrGouzD7EJBAqNxPdiByi
 owPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792398791; x=1793003591;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Tel47GRGFh6qPC4e3rB0X+QnLVnVRsX1Q6+m63VD9o=;
 b=Ha/mz09v/xR/XLy4dmus9oY1BtjytPpi6PXd2EEz3IV1Ei7ojkw8AykpiNpzNdrvrm
 zBYoxZymU495EARHdrNT0wA/vomj/Iz7U0APSDWpJrE6KqMCYvt3EfZToGQxHBSu0EtH
 pQvFlwTN9gi/exoCvpFAQrjX+TcJ1ZwoJO7wxFj7zCElusv9lfEBBDZGPS4wh+QhZKVr
 h1/OES9fZR8lSmfiGlS71HlpBN/IUV74FFCQ1Y/JCVnlJFc6tcv7IlXSWxEpoKKJbIhj
 qDdCrTRsD5s4Etp9X8gCeM8dGr1V1SiQ7sjQUnsjXaFPPqEsjBgCNGMrKvhrZTUUpKMQ
 DKUQ==
X-Gm-Message-State: AFq9FYKAE+/xHpfkunmCVfU/CFmL6hf/89IdEP1uyYg7uG5bnM6mGvyp
 2j2iyLaRYoCjvBR+ILsic52LQpWPeGFFZ7hDB2V5lXvVwtqydb5q9sHbrKKYpWP/QOcbSmnFxWk
 U+8liVwDcXu0Ha5ZDneurZ7qVhkT8ToMEsi++pb2uWQ==
X-Gm-Gg: AYBFou0mVMknJp4yZmgxp9p4Bqkee6x4W23tk7/E3/KLhfrs9wa7vQO7Ogns3Zv1imw
 +/Y+hIVi9o6Sgz6JhovpUb377E0lU7ESdcpg6k03OHx7MhiLU/W9e9fRh+sVjhxwKQFd2dwUo09
 TFcjjbMHr2CEdrvaos+wiODWIp8imeoCbOWz8qdLu8CbSwjjXNKg6D0Nks1ez+AWD8cIyecznRQ
 dd4QWikCaGR6/p9dmhQZUk3zYEq2xKSSsStrbwpnUKA9s1r1aJ/NuvctMlx7ZUdcV8oiUIuF0cP
 x5H7XXxYkduHR5e2QqBi7g4yMbWfaQZ8r/8o1iJOj0CiXKD7B0WV14Qf4/9pwNHVzuuSe/tuKEP
 H1MRj3siRY555yCoEo0Ycw/WEtGIMV4RGtBLYLjcpA37WS712cfyWArY5se0LOhdX5MpvuGzN/j
 7zhw0UHnJBSiLp
X-Received: by 2002:a05:651c:b0f:b0:3ab:3bf3:1610 with SMTP id
 38308e7fff4ca-3ab3bf31e89mr7176891fa.10.1792398791210; Mon, 19 Oct 2026
 01:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975598.git.DaveWK225@protonmail.com>
 <4220c9da3d3a427fcee593c333b856263d9d625c.1790975598.git.DaveWK225@protonmail.com>
In-Reply-To: <4220c9da3d3a427fcee593c333b856263d9d625c.1790975598.git.DaveWK225@protonmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 19 Oct 2026 16:32:59 +0800
X-Gm-Features: AclHuK9sgohkMOknWm5RXvzODuKZz1RqunmPv0s2fAcX-gNb2Th8NyFT45m18dc
Message-ID: <CAH22mJz66tQL_Drc4Q=zYKOPYTWm4gsk_wrU3-purs7GFX8VUg@mail.gmail.com>
Subject: Re: [PATCH 1/9] pci: spacemit: power the slot from vpcie3v3-supply
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: u-boot@lists.u-boot-project.org, Huan Zhou <pericycle.cc@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Yixun Lan <dlan@kernel.org>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Oct 3, 2026 at 5:30=E2=80=AFAM Dave Klotz <DaveWK225@protonmail.com=
> wrote:
>
> The driver takes the slot power switch from a "k1x,pwr_on" GPIO and a
> "power-on-status" polarity flag. Those are vendor properties: neither
> the spacemit,k1-pcie binding nor any upstream device tree has them. The
> binding describes the 3.3 V slot supply as a regulator, vpcie3v3-supply,
> on the root port node, and that is ignored. On boards whose M.2 slot
> sits behind a GPIO-switched regulator, such as the OrangePi RV2
> (GPIO 116), the slot is never powered and the link cannot train.
>
> Look up vpcie3v3-supply on the root port, falling back to the host
> bridge node where some board device trees also put it and where Linux's
> pcie-spacemit-k1 driver reads it, and enable it in place of the GPIO.
> PERST# is still held for 100 ms after the supply is turned on. Drop the
> vendor GPIO properties.
>
> Unlike Linux, only warn when the supply is described but cannot be
> found: the Banana Pi F3 and MUSE Pi Pro describe always-on fixed
> supplies, and spacemit_k1_defconfig does not build the fixed regulator
> driver, so failing the probe would break ports that work today.
>
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> ---
>  drivers/pci/pcie_dw_spacemit.c | 72 +++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/pci/pcie_dw_spacemit.c b/drivers/pci/pcie_dw_spacemi=
t.c
> index 09c56d8a4c..7ca5a5ad1a 100644
> --- a/drivers/pci/pcie_dw_spacemit.c
> +++ b/drivers/pci/pcie_dw_spacemit.c
> @@ -8,7 +8,6 @@
>   */
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> -#include <asm-generic/gpio.h>
>  #include <clk.h>
>  #include <dm.h>
>  #include <dm/device_compat.h>
> @@ -21,6 +20,7 @@
>  #include <log.h>
>  #include <pci.h>
>  #include <power-domain.h>
> +#include <power/regulator.h>
>  #include <reset.h>
>
>  #include "pcie_dw_common.h"
> @@ -39,8 +39,7 @@ struct pcie_dw_spacemit {
>         /* reset, clock resources */
>         struct clk_bulk         clks;
>         struct reset_ctl_bulk   rsts;
> -       struct gpio_desc                pwr_on_gpio;
> -       int                     power_on_status;
> +       struct udevice          *vpcie3v3;      /* slot supply, if descri=
bed */
>  };
>
>  static inline u32 spacemit_pcie_readl(struct pcie_dw_spacemit *pcie, u32=
 offset)
> @@ -185,30 +184,26 @@ static int pcie_dw_init_id(struct pcie_dw_spacemit =
*pci)
>         return 0;
>  }
>
> -static int k1x_power_on(struct pcie_dw_spacemit *pci, int on)
> +/*
> + * The binding describes the 3.3 V slot supply on the root port node. So=
me
> + * board device trees also, or only, put it on the host bridge node, whi=
ch
> + * is where Linux's driver looks for it.
> + */
> +static int spacemit_pcie_get_vpcie3v3(struct udevice *dev, ofnode port,
> +                                     struct udevice **supplyp)
>  {
> -       struct pcie_dw *dwp =3D &pci->dw;
> -       int gpio_val =3D 0;
> -
> -       if (on) {
> -               if (pci->power_on_status)
> -                       gpio_val =3D 1;
> -               else
> -                       gpio_val =3D 0;
> -       } else {
> -               if (pci->power_on_status)
> -                       gpio_val =3D 0;
> -               else
> -                       gpio_val =3D 1;
> -       }
> -
> -       if (dm_gpio_is_valid(&pci->pwr_on_gpio)) {
> -               dev_info(dwp->dev, "PCIe interface power %s, set gpio %d =
to %d\n",
> -                        on ? "on" : "off", pci->pwr_on_gpio.offset, gpio=
_val);
> -               dm_gpio_set_value(&pci->pwr_on_gpio, gpio_val);
> +       ofnode supply;
> +
> +       supply =3D ofnode_parse_phandle(port, "vpcie3v3-supply", 0);
> +       if (!ofnode_valid(supply))
> +               supply =3D ofnode_parse_phandle(dev_ofnode(dev),
> +                                             "vpcie3v3-supply", 0);
> +       if (!ofnode_valid(supply)) {
> +               *supplyp =3D NULL;
> +               return 0;
>         }
>
> -       return 0;
> +       return uclass_get_device_by_ofnode(UCLASS_REGULATOR, supply, supp=
lyp);
>  }
>
>  static int pcie_dw_spacemit_probe(struct udevice *dev)
> @@ -241,6 +236,13 @@ static int pcie_dw_spacemit_probe(struct udevice *de=
v)
>                 return -ENODEV;
>         }
>
> +       ret =3D spacemit_pcie_get_vpcie3v3(dev, port, &pci->vpcie3v3);
> +       if (ret) {
> +               /* e.g. an always-on fixed supply with no driver built in=
 */
> +               dev_warn(dev, "vpcie3v3 supply not available: %d\n", ret)=
;
> +               pci->vpcie3v3 =3D NULL;
> +       }
> +
>         ret =3D generic_phy_get_by_index_nodev(port, 0, &phy0);
>         if (!ret) {
>                 reg =3D spacemit_pcie_readl(pci, PCIECTRL_K1X_CONF_DEVICE=
_CMD);
> @@ -271,8 +273,15 @@ static int pcie_dw_spacemit_probe(struct udevice *de=
v)
>
>         pcie_set_mode(pci, DW_PCIE_RC_TYPE);
>
> -       /* power on the interface */
> -       k1x_power_on(pci, 1);
> +       /* Power the slot; PERST# stays asserted for 100 ms after this */
> +       if (pci->vpcie3v3) {
> +               ret =3D regulator_set_enable_if_allowed(pci->vpcie3v3, tr=
ue);
> +               if (ret) {
> +                       dev_err(dev, "failed to enable vpcie3v3 supply: %=
d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
>
>         spacemit_pcie_host_init(pci);
>         pcie_dw_setup_host(&pci->dw);
> @@ -356,17 +365,6 @@ static int pcie_dw_spacemit_of_to_plat(struct udevic=
e *dev)
>                 return ret;
>         }
>
> -       gpio_request_by_name(dev, "k1x,pwr_on", 0, &pcie->pwr_on_gpio,
> -                            GPIOD_IS_OUT);
> -       if (!dm_gpio_is_valid(&pcie->pwr_on_gpio))
> -               dev_info(dev, "has no power on gpio.\n");
> -
> -       ret =3D dev_read_u32(dev, "power-on-status", &pcie->power_on_stat=
us);
> -       if (ret) {
> -               dev_info(dev, "has no power-on-status flag, use default.\=
n");
> -               pcie->power_on_status =3D 1;
> -       }
> -
>         return 0;
>  }
>
> --
> 2.55.0
>
>

Reviewed-by: Eric Chung <eric.chung@riscstar.com>
