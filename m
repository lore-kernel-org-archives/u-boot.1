Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443B1C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B02EA8768D;
	Thu,  2 Nov 2023 23:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SMOaNl+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07072876AF; Thu,  2 Nov 2023 23:46:30 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF0587492
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so480634a12.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965180; x=1699569980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EVgT7gDY2kutR48ZJPk0hZoAoh9/bACys3Xvs7F+AW0=;
 b=SMOaNl+H3J/2axyN/0QNNus7HtgDBf2uTKfl2a842GdOUNe2dPR81frMb3si/jXF5C
 OqvLBfv2IGCrvfzYR4eeQJPVFPR5usckOdleof4mCEwP/VqakNdb97OAdeMPYRbxskdr
 4jbiHfEsrgKh/MbGu0iHgcrEvn3Yp2mMnylD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965180; x=1699569980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EVgT7gDY2kutR48ZJPk0hZoAoh9/bACys3Xvs7F+AW0=;
 b=S9Qp4RVNokHzPqCdND//3hXxVK/cLN00CopOCyYu1fX5HG4h57EHn9i5qtGEOd0xgX
 ZBknsAWZATgomVq5pQw6XGYoJcUqlSZ7p/hsUNjcGx7TItB/O3TNJtOUbGOj3XPgrmyg
 CDkO5S2+5DznhBAzTFox+OwhYj5TUHGBYXIOM3lDatZRgdJUSqpAA/JRTAWOLhBzgNbl
 R2KQC/4s795XSAJ5wo6euw+0J5XiHFzBL3+8c3Ud5nCx6kuGjy5lZtbnf1K+bZ1fU5P2
 AbH8eoV2VxTucycWh1fpmdy0Qby+l7rxjS9vfXTlPXPPQj28vdlj2YuB47QtUrq6tBQN
 d+Nw==
X-Gm-Message-State: AOJu0Yx6vjUUHGOkqm7ee6rN825hq2vbiyTdL68cyK83Owws3CtB44+K
 Vvpk0M0kPpBmDuqa7nEnNM29laDRojN7kfi5zx+QaY8XNp3Rh1qZ6T4=
X-Google-Smtp-Source: AGHT+IE3wRlhkSYHufiq0edkiZwqvtkdsuUX1PpR+go0OFfr4re7K+d91PmgKuQhB+UpGQbgJcFrtFDVbh5fOUaCEbQ=
X-Received: by 2002:a05:6402:74c:b0:53f:b964:ddb1 with SMTP id
 p12-20020a056402074c00b0053fb964ddb1mr17246905edy.37.1698965180098; Thu, 02
 Nov 2023 15:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231031051805.62430-1-samuel@sholland.org>
 <20231031051805.62430-5-samuel@sholland.org>
In-Reply-To: <20231031051805.62430-5-samuel@sholland.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Nov 2023 22:46:05 +0000
Message-ID: <CAPnjgZ1GiwFCz8E4OnThVjvT8_5WD7rfrTb7bNxC3oJvXr6j3A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] sunxi: Enable SPL FIT loading for 32-bit SoCs
To: Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>, 
 Jesse Taube <Mr.Bossman075@gmail.com>
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

On Tue, 31 Oct 2023 at 05:18, Samuel Holland <samuel@sholland.org> wrote:
>
> Now that 32-bit SoCs can load U-Boot proper (and possibly other
> firmware) from a FIT, use this method by default. SPL_FIT_IMAGE_TINY is
> required to stay within the 24 or 32 KiB SPL size limit on early SoCs;
> for consistency, enable it everywhere.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
>  - New patch for v2, split from the .dtsi changes
>
>  arch/arm/Kconfig   | 1 +
>  common/spl/Kconfig | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
