Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE51C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 07:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DF986A43;
	Sat, 18 Nov 2023 08:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HgEETSI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9788701C; Sat, 18 Nov 2023 08:51:50 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6FF886828
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 08:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507b9408c61so3739836e87.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700293905; x=1700898705; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GbJSCZpfN6Sdzm2tvNAtvnKL92HcOkYrapU5S8AU6CI=;
 b=HgEETSI/MZlfxFVzHKXxHL/2+OAPhT9WOWdaoSzJJq1hUgexSlPt4/nL4LjXRFYGB1
 pS9toXul6uwQ7Ebi9togl/F6+FPhbgL5o+CiOfHtjEwiRF8WCK60UoBK4FPxU1Ixte0y
 F64+1MHK9U0Qcyvxt1fG13xmKyWlYPs0P2MqJID/faYCnp7mhSKSjDeSoTYn6UpPlcpj
 BFLGh93S1/Sk0kojE/qpCPiymXS56b8iMI5SCLBQMSqxNSv3NM9AH2LAguj6Yr7HtLYG
 2UwfMi2h2Wk4qebtqoeOgH0DKtcU/xjjvxnCwIGroSmebViyaZ6BXIwhdEMCKDH8KQsw
 EwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700293905; x=1700898705;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbJSCZpfN6Sdzm2tvNAtvnKL92HcOkYrapU5S8AU6CI=;
 b=RcVae1c3Mt36BPwNCArItT2SmNHBOusHZXFY6v6U3GwNPONituiMzXsdQROO1JdGsG
 h8KqoSewFd/L7chOjdZyCL9+wqiNEbRevquBGseqli4ZK++Ns+ab5TXjvCRxC1KDgt/J
 s8tkocl9MHNgTCuU395q7QvqMuih7W/ZebHH5iJuv76kRoMB3SosQB2PsbnCgY1/Dj9V
 Cy6Yl2SkkX3XitcUw4DuTpVUvyaYa01VfrqYt88NobKlOK5af37mLyGB0L19jmTTJ9kz
 pkbiU4MzLY+txzIG7pU8+0PVo7WvWuFIzWOqx2uh+padryG5NDPnLrzN/02d1oNySCBI
 XJtA==
X-Gm-Message-State: AOJu0YwtMK3zycOy3dnaCR06kG6v6xJAVTMHySFEN0HVX2tsUODqOsgI
 S9DuzfCI4cgFyYzOdKmPvmb7CdiunTfUMnB0Cup9GQ==
X-Google-Smtp-Source: AGHT+IFC8KoVjBz9NyU9VFjZ7hpi3VRKFMb/9sKjiCyr4924E6kfBC9rsYPlWRyQwJkZiUIC24JdmRTv6FGDHKTNeoA=
X-Received: by 2002:ac2:544f:0:b0:509:4587:bdd0 with SMTP id
 d15-20020ac2544f000000b005094587bdd0mr1517045lfn.7.1700293905058; Fri, 17 Nov
 2023 23:51:45 -0800 (PST)
MIME-Version: 1.0
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-6-sjg@chromium.org>
In-Reply-To: <20231116041043.362055-6-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 18 Nov 2023 09:51:08 +0200
Message-ID: <CAC_iWjLG6wWRb7E899KS7JqtWtNj5k+70yhtA8B4zewXiWBBWQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/32] bootstd: Add missing header file from bootdev.h
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

On Thu, 16 Nov 2023 at 06:11, Simon Glass <sjg@chromium.org> wrote:
>
> Add a dm/uclass-id.h to the bootdev header file, since it uses
> enum uclass_id
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>
> (no changes since v1)
>
>  include/bootdev.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/bootdev.h b/include/bootdev.h
> index b079a91b5b7f..c1362673d418 100644
> --- a/include/bootdev.h
> +++ b/include/bootdev.h
> @@ -7,6 +7,7 @@
>  #ifndef __bootdev_h
>  #define __bootdev_h
>
> +#include <dm/uclass-id.h>
>  #include <linux/list.h>
>
>  struct bootflow;
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
