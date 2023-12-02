Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF893C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 21:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A000E87879;
	Sat,  2 Dec 2023 22:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RjrATvXA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DE1C877FE; Sat,  2 Dec 2023 22:16:44 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5614887873
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 22:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a187cd4eb91so421560466b.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 13:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701551802; x=1702156602; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Go5AKdjKfLFldlgN4T2Mjcp7A9UML8un6SKDRHubGZQ=;
 b=RjrATvXAgeYHgrjhNlfyPia9N6fvx02QE4XtYOc9XS4dU6X2d8JpW459uTKqDE2zB2
 1mEiTuyBWl7eVgKEdmjVFID9/6eh2/q2LOHb12sgiLuLVa6I6OzPuJUF+wU60j2daZag
 4Z0XHJNOOjVFG3BSDW/Q0x1cwdkNmDyFM3W6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701551802; x=1702156602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Go5AKdjKfLFldlgN4T2Mjcp7A9UML8un6SKDRHubGZQ=;
 b=DTeTRZcWRrWtThJrwYvOqmLIwD0r7UxW/SITMkEl+2bfTE4zXQV8s8vZfuW7vwDycN
 NhymIkiOjfujzMxAD69q1CKJasKu2d/AmbEFVhlPt60XZyFWJqerxU8eqc5zKhUud4Cf
 GYRSlS+Arsvo38fForKrmzcNdGPRzd9CRPRX+2ABOENDDg1KIHx+R1if6iJgYrmRA280
 uWIxzEBtR/nLWt+7ZIzs/d/l2rL+zcF+0+3DjZiC32HQdlzKTVGjZOn4TjYgF92AbfCA
 AaeOAUUMr9+mSwxooe++htGQ5BBUphf8bK0MinQPLGpcQ3JVcImBsH5+FOxp3E3YLb0G
 ARAQ==
X-Gm-Message-State: AOJu0YxfHfA6hDEnsBcLztATBH21RzGj9Jql8LKgJ64TTN8SDBAQPRxD
 I62NR/hOp/lbHlF2zopdAu7T5qN8knp2JG/A2lv1kQ==
X-Google-Smtp-Source: AGHT+IFR71873QGi6ixpBBBh4AIOxs2njgfS0UVZHe+5TqR5tyeCcKBF7ruTiuZ4PGMzItb4SZ9enPh2YtHHrvbUePo=
X-Received: by 2002:a17:906:fcba:b0:a16:88e8:2de7 with SMTP id
 qw26-20020a170906fcba00b00a1688e82de7mr1122064ejb.23.1701551801711; Sat, 02
 Dec 2023 13:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20231125162705.1383401-1-devarsht@ti.com>
 <20231125162705.1383401-2-devarsht@ti.com>
In-Reply-To: <20231125162705.1383401-2-devarsht@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 14:16:29 -0700
Message-ID: <CAPnjgZ1wN4FtP1gAGVk6W9zfKxRmCSkGraGGLqmBqKPMLqJF3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] spl: Enforce framebuffer reservation from end of
 RAM
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

On Sat, 25 Nov 2023 at 09:27, Devarsh Thakkar <devarsht@ti.com> wrote:
>
> Add an API which enforces framebuffer reservation from end of RAM.
> This is done so that next stage can directly skip this region before
> carrying out further reservations.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2:
> No change.
>
> V3:
> Change spl_reserve_video to spl_reserve_video_from_ram_top
> which enforce framebuffer reservation from end of RAM.
>
> V4:
> Split this to an independent patch with more details added
> in comments for API in header file.
> ---
>  common/spl/spl.c | 19 +++++++++++++++++++
>  include/spl.h    | 10 ++++++++++

Reviewed-by: Simon Glass <sjg@chromium.org>
