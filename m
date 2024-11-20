Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34238D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9F789673;
	Wed, 20 Nov 2024 14:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VHAAtL8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD08895CF; Wed, 20 Nov 2024 14:47:23 +0100 (CET)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D746F89649
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ee020ec76dso1647888a12.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110439; x=1732715239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eSTN98drquJiuSJXwRJtDGlxYjkgorKxnkz1gvE4zBU=;
 b=VHAAtL8J6MHrOeWzuvbYp0hrkcbzS45/Nj8DbeMtp0G142hvax9mjhWd7RYNTSHWlz
 6HrpXBy/ZL7iAax2FrEt3DiSRzi0O0soYW+7PC4A7cE0IqYvzfdUbrX9WHb7q8ZbqGmB
 KRMhKmQ4c9VPg2X9RCFxE2yRRpfELI7MH+ksw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110439; x=1732715239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eSTN98drquJiuSJXwRJtDGlxYjkgorKxnkz1gvE4zBU=;
 b=dcN+k11zwQcP912BIZ7WEZgdkfkyP2+onOEfPM6pHm+mDIbqRCL+soOLswh2oezWJA
 QK/a85eMvVx99ww9R8nPc2Xue48CeCndCYipUKFJ6DAqVG4eLtWPZjiN25BbPLVNs5gi
 qzwoz7wJhZ8UJ2Y6rEMzPhY+OFUxMJQJ7Ja6BxenYJbAyov7Ii0iFXJdoFyhpNF5Y1ek
 Q/NzuomwAatN458xwwdIlR3bfg8KPLn3GcND5IbQya4OaTwks9pu0KURy5ezMRj8U33l
 7H2WpMLe0pbTEofFNy1d4wIiYtVWiHsmG/DuVyax60x+CJ9T3Gv/sNpp04KAy2xjmZds
 2qSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFpfA/r/y6fDsP+Mpli4FpAYfnm7dcr89IDzL+3d3HferGkThUUjVzLRYmUVLeWqXttzawy1I=@lists.denx.de
X-Gm-Message-State: AOJu0YyYLxMYlb9F107PG6Mglxdq6sKo7kj9Ln340L49KHAOkdTdFHa5
 Fvp3ei7Wx4b0MduXnOdq77SkdTCtf7hxi155tiXaFFWP7Ke1UQ7XLwKk6NUeZp/03W9S1s8yOno
 GbkzhrI3sBnEcaGLWjLQE4goCXLnmYnf2vMlt
X-Google-Smtp-Source: AGHT+IHBXyYnYhz4AM2EzFUvyZBj6dB21n2simImJt1tAQmdlhL794ef3IB6RUFuWuEW6hx7QOrsg3TLsFPW//wKi28=
X-Received: by 2002:a05:6a20:2453:b0:1dc:792f:d274 with SMTP id
 adf61e73a8af0-1ddae4e24c6mr3090398637.17.1732110439447; Wed, 20 Nov 2024
 05:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-2-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-2-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:46:52 -0700
Message-ID: <CAFLszTgDQtZ-0t2oNQ6PCZoL2Y95vx1jw=JS3iYWy=4zfoeSAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] dm: core: implement oftree variant of
 parse_phandle OPs
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
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

On Sun, 10 Nov 2024 at 04:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement oftree variant of parse_phandle OPs.
>
> There is currently a very hidden and laten BUG with parse_phandle OPs
> that doesn't permit the support of multiple DTS in a system. One usage
> example if sandbox with the usage of other.dts
>
> The BUG is only present on live scenario where of_... OPs are used and
> it's not present when fdt... OPs are used.
>
> This is caused by an assumption made in __of_parse_phandle_with_args,
> with the of_find_node_by_phandle call that pass the first arg as NULL.
>
> This makes of_find_node_by_phandle use the default root node of the
> system and doesn't permit the usage of alternative tree. This is correct
> for normal system and also for the linux kernel where it's assumed a
> single device tree.
>
> It's problematic if other device tree needs to be used.
>
> To fix this, introduce __of_root_parse_phandle_with_args to define a
> root device tree for of_find_node_by_phandle.
>
> Introduce all the variant OPs for this and in ofnode, the oftree OPs
> following how it's done for other OPs with similar task.
>
> For FDT scenario, ofnode_from_fdtdec_phandle_args is reworked to accept
> a new variable, node and noffset_to_ofnode is used instead of
> offset_to_ofnode. This is required to support multiple FDB blob to
> calculate the correct of_offset of the ofnode.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/core/of_access.c | 61 ++++++++++++++++++++--------
>  drivers/core/ofnode.c    | 51 ++++++++++++++++++++++--
>  include/dm/of_access.h   | 86 ++++++++++++++++++++++++++++++++++++++++
>  include/dm/ofnode.h      | 66 ++++++++++++++++++++++++++++++
>  4 files changed, 244 insertions(+), 20 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
