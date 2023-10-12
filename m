Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C2CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7537A86E8F;
	Thu, 12 Oct 2023 05:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FM9z8RFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F178586D12; Thu, 12 Oct 2023 05:44:31 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E2386EAF
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7b91faf40so6833627b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082267; x=1697687067; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VEK4SQtK0luYe0gZCWuxDb2RSe4nz/7nkEAEtEp2XGQ=;
 b=FM9z8RFcHLZsmg7kcKGS5pJpyq0iRu3bH2dBzIxk92s9aVBVPLDZrlXH7kiUU3QOTi
 TODp2s1R46CKnBA03vLk11EHjMkUJNaJoIErkRUlEucQZCI8dzcbpAEOOE7ePaVyHIY8
 gIXr2RoOsfpzBYZc8uXEgIcWPvBTGqgAJf5VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082267; x=1697687067;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VEK4SQtK0luYe0gZCWuxDb2RSe4nz/7nkEAEtEp2XGQ=;
 b=DEVYI0oZt+GM2wx1BllNMYH3GgRF1JfScscKamd5El+IQn6x9skZe32FdcOKdIq7Ux
 j7Sf/pf21/ZjNs6826JwQsKwXKoy0XfUr84ajxfuUdfxaU8Mun3Ssx1E3QZcUuCWNDzj
 PoR5/p0tNeG2aYTm1t6gM4oAMKpEkCO51kVRXPX9ZmyVV2T5Jqh/auwjiBJhrx0m7dEg
 2uanJKtMW/h2YupWB9/ar29c2LfrkLK7TVzY9wLSVnTeNk66R5RWXkvS1AYfyk26eYeo
 Xboec+e12q0XIHJMnL4eTYTLVoA4KFvU1dQMvcoqOdhwv4ZeN/HuxWWVvHdaTZBBZMuA
 vdmg==
X-Gm-Message-State: AOJu0YyJDligIpBoSqCrp0iu9Qal3sVmyIwMrLV7RbYqqaPp9qJGA2dr
 Q6qp6t7QDhjXDwioDzuzeWQBVF1pl32CS4caugN6nA==
X-Google-Smtp-Source: AGHT+IEZ12+iAIqLMADv7XgLhX0rWlzKp43Z0ohKSukj+kmmHVT4ii30CCQH4yvQ8tobRa0h/7Q0XhDW+518aN2G1LA=
X-Received: by 2002:a05:690c:ed0:b0:5a7:fc84:4314 with SMTP id
 cs16-20020a05690c0ed000b005a7fc844314mr791985ywb.40.1697082267062; Wed, 11
 Oct 2023 20:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-25-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-25-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:29 -0700
Message-ID: <CAPnjgZ2F-F=45-NEpzd36nyqYJ33JZsw5Vk3Thq2qxHDqHUe3w@mail.gmail.com>
Subject: Re: [PATCH 24/26] test: spl: Add a test for the NET load method
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> Add a test for loading U-Boot over TFTP. As with other sandbox net
> routines, we need to initialize our packets manually since things like
> net_set_ether and net_set_udp_header always use "our" addresses. We use
> BOOTP instead of DHCP, since DHCP has a tag/length-based format which is
> harder to parse. Our TFTP implementation doesn't define as many constants
> as I'd like, so I create some here. Note that the TFTP block size is
> one-based, but offsets are zero-based.
>
> In order to avoid address errors, we need to set up/define some additional
> address information settings. dram_init_banksize would be a good candidate
> for settig up bi_dram, but it gets called too late in board_init_r.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  arch/sandbox/cpu/spl.c           |   3 +
>  arch/sandbox/include/asm/spl.h   |   1 +
>  configs/sandbox_noinst_defconfig |   6 +-
>  test/image/Kconfig               |   9 ++
>  test/image/Makefile              |   1 +
>  test/image/spl_load_net.c        | 252 +++++++++++++++++++++++++++++++
>  6 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 test/image/spl_load_net.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
> index 09e3d10d6a5..8153df18d68 100644
> --- a/arch/sandbox/cpu/spl.c
> +++ b/arch/sandbox/cpu/spl.c
> @@ -126,6 +126,9 @@ void spl_board_init(void)
>  {
>         struct sandbox_state *state = state_get_current();
>
> +       gd->bd->bi_dram[0].start = gd->ram_base;
> +       gd->bd->bi_dram[0].size = get_effective_memsize();

These could use a common as to why they are needed here.

[..]

Regards,
Simon
