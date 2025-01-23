Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1936CC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC0F801B0;
	Thu, 23 Jan 2025 15:38:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K2IczYiL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10CDD801B0; Thu, 23 Jan 2025 15:38:35 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEBF80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa679ad4265so431345866b.0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643112; x=1738247912; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xbrTppVMPxBu0HXxbLuaYeugMnGH1hJCJqP3jXLmdDA=;
 b=K2IczYiLOw38PFCwSQb7THqY2HDvWyNBOX43L7ycuGMPpsA1pV+R1dTRH9vrXlFmnY
 ba+HaF1H2OMQDzwz9Zny1ZcJKTt1vdimi5XOoNLYu8ZKIhvK1t7ExbUun4y6tisHypkA
 BdnwsvMtLkt3T7LwHqtbEEkdue+YdAL2XWF5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643112; x=1738247912;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xbrTppVMPxBu0HXxbLuaYeugMnGH1hJCJqP3jXLmdDA=;
 b=EAbGOYE6avTZUm4H1/Fj51kqOpxLVBxh7M/YazOoyQqhHOAFxkyxDPsQUPG5h60KpM
 yybP7qmoSPH1wtTu4DLDolMdrJl8Wb0u7rCTT0TY2lDqos4jFyMUXE2D7PzO6y/9+Te7
 F8i2On1fukrh6Mp5txGKGa/NGOPIhF3Lww1H7UtxWIQxIjyi0uMj4VEeJviTUWc84SsX
 SzSgnS78B9monweljdY5MXhG+1B0ze69nKUw0phUtYrgKuHMRhkSmr+WH4jsHDCLTOQL
 fu3DsYTFPxtxWOOX23DUPtafen4Ma4f+j3/a/LFDm9EVk2rnvWuzRUlybn+LKTqfqou3
 SenA==
X-Gm-Message-State: AOJu0YweIv0k44QBdHDAMgp29vB5ieZlr/M+m5Xswen+EvLciccM37cM
 jcEuZxobwHS/9qXsyxdKv/GQHG3cydvdiyJiy1QhgYVPmn11KqCDS7ItmHzpj8Ijas89tO+vji1
 aaX1TqNXZCwnHuRofqpZ/Fh/mZ5q8BBZqqAfx
X-Gm-Gg: ASbGncvoyvY91MHnCv+8p9stLnDUjwOYsU6S1b1mSCw81ZeCCsVmUqtieW093xSBN/Z
 ZoMruMQsLiBtzWSq2tHhjuRFCg6SNGU6RXPS6nb/rT2033tudCuygZ66v7k3o6Ow=
X-Google-Smtp-Source: AGHT+IE+ZJ17I6SShrwPYIR36wasuoOgEbr1X7ehSPWJiJY6b/xjoH3mcQqp08JVzSTGL6F4cSqO0QdSjDpEOtqb20g=
X-Received: by 2002:a17:907:961f:b0:aa5:53d4:8876 with SMTP id
 a640c23a62f3a-ab662a63bf3mr309614366b.20.1737643110976; Thu, 23 Jan 2025
 06:38:30 -0800 (PST)
MIME-Version: 1.0
References: <tencent_410F4F8FDC201D1B50F008D01066D0A4A006@qq.com>
In-Reply-To: <tencent_410F4F8FDC201D1B50F008D01066D0A4A006@qq.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:38:18 -0700
X-Gm-Features: AbW1kvZAud4z6jjgP1nPfD427KqfAp3n9BSgenmXUFJQawsMcc7jxw-utOuPDMA
Message-ID: <CAFLszTiZf7nwTX5cECz1JkVFG_s6dDK0d750sGFOFP1LQpG0jQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm: Remove redundant loading of image copy start offse
To: 1425075683@qq.com
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Tom Rini <trini@konsulko.com>
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

On Sat, 18 Jan 2025 at 18:05, <1425075683@qq.com> wrote:
>
> From: Liya Huang <1425075683@qq.com>
>
> Because the beginning is already computed
>
> Signed-off-by: Liya Huang <1425075683@qq.com>
> ---
>
> Changes in v2:
> - Due to an error, the patch was resubmitted, leaving the code unchanged
> - Sorry for the trouble; Due to the lack of understanding of the process,
> the previous patch information was Reviewed-by. Please refer to this patch
>
>  arch/arm/lib/relocate.S | 2 --
>  1 file changed, 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
> index 345e282e3e..bffadfecba 100644
> --- a/arch/arm/lib/relocate.S
> +++ b/arch/arm/lib/relocate.S
> @@ -83,8 +83,6 @@ relocate_base:
>         add     r1, r3                  /* r1 <- Run &__image_copy_start */
>         subs    r4, r0, r1              /* r4 <- Run to copy offset      */
>         beq     relocate_done           /* skip relocation               */
> -       ldr     r1, _image_copy_start_ofs
> -       add     r1, r3                  /* r1 <- Run &__image_copy_start */
>         ldr     r2, _image_copy_end_ofs
>         add     r2, r3                  /* r2 <- Run &__image_copy_end   */
>  copy_loop:
> --
> 2.25.1
>
