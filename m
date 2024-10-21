Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33C8D15DBA
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:33:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2440888F5B;
	Mon, 21 Oct 2024 18:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IT6z+i1x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FD4B88F70; Mon, 21 Oct 2024 18:33:04 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5510A88F91
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a3dc089d8so651880666b.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528380; x=1730133180; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ig02ea4MBymdJfHa2Cmo69sPgYpwKCU0OXTZ59a6kd8=;
 b=IT6z+i1xqJX4v8MWcgfqqeKT7cyt5xld+o45eKgm3kVxIb2+aQX90GAcbdcs0wGCf9
 eqBt4ps2g8ZH0541ssOjLdgbzzZVPDS0T9yaEh9nTKKUhBNoiQ3Lzuz1T/KyAiGQh22u
 bCSuozWJR3PzyyZxMcZk/LcF4NMrlCRILBYj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528380; x=1730133180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ig02ea4MBymdJfHa2Cmo69sPgYpwKCU0OXTZ59a6kd8=;
 b=V8/R2JUSCo1sI1hCvuDsPbHvpDEP8so4UJ3AOjaBWfXKHqxwT5nKMFnBrV9R6BFlBE
 xZ7NEhVIHhXWhAiRmd9VJvw4XS6BJafqEsbLPViLI8dp7mWmq2bBBDtys82J88gQFROI
 TOQ2Y/FPvIj6Ay46FgX1/XRYRNdx7LzLS8/TSPwUlyGP5DNat38ufpPBWtWj7cQIH+pa
 kDhp0vmfgCWyZIiZEP8bg/Zm5f89au+nUyP0MF0/SPb2LkR/gKQhep86pFARAoZhXmNO
 XoyzFsvDxHJTwL756WtsA6Nub8rRju57lnbyCPuslQVEj32bkVg36NhjVHGwIYxPflKX
 OwtA==
X-Gm-Message-State: AOJu0YxhjrndQSO3GrYnZGveUuGa5G3GX4xcwfdOasq0lJV+1RJRQ0GT
 T5X+5BSR9RNbJmx0W9cNMycLOLJguB4pU+2ncCJ4RM9VgUm38MNyCYaAwUSf/cDjDVoRdl4/k5h
 4nOCrI5D2cOjiTkZ9qxn3NDHYnpmhSvwiFYuj
X-Google-Smtp-Source: AGHT+IF9RfTB7GI6d9z8xW3IE4ybcyJjUpcBZneALuCYKmEpYe9WaiWHGv5eb7qd58UVV6dTKNvXp0DUMWP0aB/B6Ts=
X-Received: by 2002:a17:907:7e97:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a9a69a7b3bamr1269106766b.27.1729528380364; Mon, 21 Oct 2024
 09:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20241021142040.2981390-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241021142040.2981390-1-andriy.shevchenko@linux.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:49 +0200
Message-ID: <CAFLszTh5qepermWtFRH3AcvPwa_YzSuPNyai_DrJLTJLY8RLSQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mtd: Drop superfluous const qualifier
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Mon, 21 Oct 2024 at 16:20, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The compiler will ignore it anyway:
>
>   include/linux/mtd/mtd.h:342:15: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/mtd/mtd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 6751fb52c5a5..3ffcd40807d0 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -339,7 +339,7 @@ static inline void mtd_set_ofnode(struct mtd_info *mtd, ofnode node)
>         dev_set_ofnode(mtd->dev, node);
>  }
>
> -static inline const ofnode mtd_get_ofnode(struct mtd_info *mtd)
> +static inline ofnode mtd_get_ofnode(struct mtd_info *mtd)
>  {
>         return dev_ofnode(mtd->dev);
>  }
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>
