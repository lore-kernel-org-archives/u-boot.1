Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B2DC3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5BE98892F;
	Sat, 13 Jul 2024 17:16:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NL07Yi/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB298891F; Sat, 13 Jul 2024 17:16:21 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEBB88914
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c97aceb6e4so2280930a91.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883777; x=1721488577; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6bnfvCDU44k6svKF1lfDcohHePsSt9eNsyGVtdV4tZw=;
 b=NL07Yi/8vHasMzhl+E/dMf1NMziMbaygKR5nLtqPdYnsKn0T5Bvk3s+htOJRESagNf
 IATDnVcMmlW0Ztl63S9V+0aSzJ8i/w98HPSRqk1GtZmGduh1SjHTa6AGVVF1FkkKrbJB
 dJq7twzBF23u1HELrbrJMV04wEOnY1xNa4xo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883777; x=1721488577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6bnfvCDU44k6svKF1lfDcohHePsSt9eNsyGVtdV4tZw=;
 b=aiE5tWOt4baBCu9wkFLze3oA/TKdgwhjWRgtJofd4WFUb9lZYovjBZ8NzZszsS4vHI
 TK1ywXvyZrVVqzzr6vEHRaR1YaHDG3qXVGK0v4swZPiCU7gM0c4RfZILCIPz5dNMsoCw
 rZvdun6KSmyLqZEqgNA7ipPccdvLsqPw2rBcxpI55fDoNmD7w/156pBp3gFeqaJ+Wg4p
 EhKRnNodhMnv74hPlbt18TM1b42niHpwz/zFrrzdsqFb9r8MA0K3UmIaCtIgIz9DLj3+
 VX5W0G88rJRJJQBLm95SIKJ3a0fMuvUi0wFaiVRGs//eqc1Gnq6gpIlljmMsoXhHqRaP
 VCug==
X-Gm-Message-State: AOJu0Yx7AiugijsGExGAbqblQr+82WtDfl6wqWNDlWoFl64VLUj03qbw
 C1ObjfEpY0Az8jlRwcPJucJH7n5zsMvk0V5g18davLQ2TyWXcb7gCvPThlonVGy90VIXH7e5dgE
 y2CrfNYMxLauOexV/xzV4aHXyLjTyhr184mJw
X-Google-Smtp-Source: AGHT+IGUEeIAsRJyr8Z2Pb0h8y8OBJI3R0GVAVIaL79SEOd+CoKwPmH6uLVrF5GxvN9la2bBFFSwfei/FFoEtPpRyFc=
X-Received: by 2002:a17:90a:3882:b0:2c9:93a3:1db6 with SMTP id
 98e67ed59e1d1-2ca35c30e36mr12451011a91.11.1720883777448; Sat, 13 Jul 2024
 08:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-21-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-21-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:59 +0100
Message-ID: <CAFLszThEuHDgkMpEHyQyqce-zRXBeKKe9RF22OtKN79TS_9-_g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 20/48] lmb: reserve common areas during board init
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB module provides API's for allocating and reserving chunks of
> memory which is then typically used for things like loading images for
> booting. Reserve the portion of memory that is occupied by the U-Boot
> image itself, and other parts of memory that might have been marked as
> reserved in the board's DTB.
>
> Mark these regions of memory with the LMB_NOOVERWRITE flag to indicate
> that these regions cannot be re-requested or overwritten.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Mark the reserved regions as LMB_NOOVERWRITE.
> * Call the lmb_reserve_common() function in U-Boot proper after
>   relocation.
>
>  lib/lmb.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
