Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE06F34C4E
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA25A839DF;
	Mon, 13 Apr 2026 15:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QLq3WXEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4275783DC9; Mon, 13 Apr 2026 15:35:47 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B11839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso1969327a12.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776087343; cv=none;
 d=google.com; s=arc-20240605;
 b=UnIqlQiSlb98+Lu39H7Fw5e0t5z2LofTjuoTAsOlNuSfiXqylayFbKT3Kjj2Epmrbz
 jKBCyvbqv1qSAe7Ahv9tzFo7APQ9s4z94xeHLQ5sQvsK98Y/ZqQj/hkGCyNiL0KbCvtS
 VB8XQFPFkyxEDeseD8kqQqZ/MmwWDuJKaR43aDwUyKiKemi9WOI6ytnADPTWluPsDl2N
 hryhYiATgns5MCAHneUuHFffuI06Fl9W9PGxxMB6lEWIOP65zu+j5Hhzt9ZGAAudHjtG
 IdjcbYggYChtj0hfSStrNe52hMOaWMzFfkAQESeBtgbLob7QqNn5s5C94zZOom979KME
 FTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z7ZzCNClvuGhPxwPhk06oJNAdC7Deo6tl10wkKnHgps=;
 fh=ZvTOplTg/Tb064jHRbjjpY73JyZzsX6EywF5EPWG8TY=;
 b=iZvrjRZg+Za+bHWv71qARwXnLsdwXSeZgpZtJpM2CbF+R6SSm3Mt6C0WKyp6URMn51
 01iBs0aLTkHbycM33eq6rgaxRD/LkQ7094O0qtlAS/45sYTbp6q9W1+TNo4Ttbj+e4iI
 sMUry6UfSNjK5hvSJ4hQBN8eVa/szDIG23Ifpg3Fj092ibRpTi4u/LJvHEUKsE1WoPN4
 iYw7y/G7KDmJsZBYi2mOKyt4wgeuTZLrpFnnoBQ8p+Arlrr4VXhoLYhNUEApWixX52rF
 fWKdX8B6e6O2GoJhcESJFq9JaI0DC9ZL+kecSEXjSKLuil9+XFHQV+bJPe3lsSsIRPlc
 4VkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776087343; x=1776692143; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z7ZzCNClvuGhPxwPhk06oJNAdC7Deo6tl10wkKnHgps=;
 b=QLq3WXEsgHlrJjukk4zmpTCG6t1DfCQB6Q7h8boJqbHls6k5kSM2KQhinNZr+Q6ZH4
 AVQkHdOzJ5g2W1yX7y8rSXAzAMM3ufLvG7OP2rITHSq0AujStKYsXl/HPL18dg5HuuHT
 OUusBetMvelwAbH/NGZ/MHv4STpDqhd8ZCreg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087343; x=1776692143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7ZzCNClvuGhPxwPhk06oJNAdC7Deo6tl10wkKnHgps=;
 b=YDgCsKyrzMzgSBEtIZcnWiHREnJDFHKWM7X4MQSKiQAudL8id8TPGlQUpAWWWQps3Q
 euGPgWBlrIjm1GwRQlABPWu5AFbTNv5Bkb+NoTqFlwIwLYaOs0iMzdIKmollB0m/eEjx
 Be7mksCZww7j613tOFygU3HJ6sLImIP55YZfszFZ8hq0mjnM/tD3BJSDL+5uA3OlTYcj
 aD2utm65XrjJ099yKngoNB0vle1pEyGG2lHI6Hmmv7BKGXHiG33gKq3rq1Krj0+9nsZ+
 LKKqTb3llvWANIwX2Zjdv+e/uE7EiKGb+VmNNf+WKL5T4wMQWvkgRAVv9T2l0WnV79ZU
 flCg==
X-Gm-Message-State: AOJu0Ywwbuk2s4fXsu98UWHL3103CNb4jvUMRFNsSkVMwM0Vcy3mGDd5
 UlWKQhOqGW+B+o7Ea2QVG9Mr/YnEGJZ9wVSCexr1SQOkhy9vblsX4FxCqysVh0Tssa8UyKrC1rc
 duC+4paL+hiJsNcZOMQXcjza054nxgnqhpWtqVJfO
X-Gm-Gg: AeBDiet24GVpUVJY/k1eg/HwQw+hag3XOoLzl0JKmR/90Sshq7S2yPCjn/q6NVLpXKB
 vEr2ERAzQpDOpFildSzCi0VGxc+7j0RTOnds808GLfuWFmPbgiagf0JDDmOiIWhx8nZakEZj4VJ
 zEWcww5yVtDHEF4pH4VTam3COBdwqFWMRnopnLr9ZKNBEobr9NOk8NHH3eQxtcBGHU8o3ycXgPT
 ZtnQ9f1N6BYsXYX6lUZuS2+hHamkeMInmVOh6/fgf1Kd0mwJOXa62eQKUwUXXhR+6hCiAPuihpP
 mez6fOTZTdRBFa6B
X-Received: by 2002:a05:6a00:1bcd:b0:82c:24d5:63e6 with SMTP id
 d2e1a72fcca58-82f0c169049mr13084199b3a.15.1776087343472; Mon, 13 Apr 2026
 06:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260413081322.2226374-1-ravi@prevas.dk>
In-Reply-To: <20260413081322.2226374-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 07:35:22 -0600
X-Gm-Features: AQROBzAXxe7JioZZJ7ozhD_1BGaI7FEq003X9j_VMpx7kfk_KBJSoj2FttCBJTE
Message-ID: <CAFLszTi6FO42hpyN=U=4OTEd1be12wR==OUL_s=dCMjLiwt+6w@mail.gmail.com>
Subject: Re: [PATCH] cmd: mmc: allow 'mmc rst-function' to show the current
 value
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>
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

Hi Rasmus,

On 2026-04-13T08:13:22, Rasmus Villemoes <ravi@prevas.dk> wrote:
> cmd: mmc: allow 'mmc rst-function' to show the current value
>
> Extend the 'mmc rst-function' subcommand so that lacking a value to
> set, it simply prints the current value, and its interpretation.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> cmd/mmc.c             | 36 +++++++++++++++++++++++++++---------
>  doc/usage/cmd/mmc.rst |  4 ++--
>  2 files changed, 29 insertions(+), 11 deletions(-)

> diff --git a/cmd/mmc.c b/cmd/mmc.c
> @@ -1032,6 +1026,30 @@ static int do_mmc_rst_func(...)
> +             switch (ext_csd[EXT_CSD_RST_N_FUNCTION]) {
> +             case 0x0: puts("(temporarily disabled)\n"); break;
> +             case 0x1: puts("(permanently enabled)\n"); break;
> +             case 0x2: puts("(permanently disabled)\n"); break;
> +             default: puts("(unknown)\n");
> +             }

We normally put case/default on their own line, as elsewhere in this file.

I'd even suggest putting this code in its own function.

Regards,
Simon
