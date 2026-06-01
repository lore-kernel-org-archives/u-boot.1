Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68670CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 14:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05424848D8;
	Mon,  1 Jun 2026 16:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KpIsc3zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 963B6848E2; Mon,  1 Jun 2026 16:54:58 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B323E848D7
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 16:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68cc6c7df99so2927785a12.1
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 07:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780325696; cv=none;
 d=google.com; s=arc-20240605;
 b=iv1zYrCmrcWzqs6VNK0nPsUM9X9JlSd005KA4mHfS6vE9eca0q/lHAvAJJ/0pG9Q1L
 Jpdem/w8nbNt9xUTD4RGe+Y4PwcufU7o/e5B30mt/m6fEGOHj3PpYstKeDrFq7GPr9Ho
 59s/XScjJpQ4e2QSzrrrGcaFkhKR/YbY1doUnRLZFgQcGds4eRsIcF+Ta/1Gt7PCGKZH
 AgxD9dLnZDHLtzKWwlkm9hA5CdA7STb8FuGtxiD+6UoUnrFzhW4jiMK9QlwwqvS8hyYa
 oLh3bqJiaaP4BuxlukAvJpMzFvlCTaFNUsARU1px6O521vH6Bu9Q3mmy6C4A3zg0k0ix
 72+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9HbnTy1HBNm0fZQXE6IPP+RMyrkf8LJgq0ojLEpuZUE=;
 fh=DYMU3dRED0rmVKTDqXRHxrZw93vonVJHh6vC8tHyRiY=;
 b=aH0bD39dpf9xg6awQXjkKaq9BUe/70AqHGkiUX67LCssMB5aH2Kcmarii0y88PIcjZ
 YH+rpH2Nz9prDkmjC0hGo7vkDaTNbL280Qq0EqHk48TMQzVfXHeZNsQ6GxCF7QUY94zS
 w1NA4NJDIEEg8q+ljb29iEnDND98yYrR2kaROMQuZzxsq3FRFnvOWXFuRIKDR8kVydTG
 3PYdeccRf5I51ESB8HWuogkcRA/wBxttbxkEDfuybuPyiGEPsDxe6E2C95bPJsQVCjKS
 3R4kJs+rI6KWCsHua9VM7ussYszriaPobXeB70yh3J6YIdqTLSyyCfqPr3BWCgu9rgTT
 tedQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780325696; x=1780930496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9HbnTy1HBNm0fZQXE6IPP+RMyrkf8LJgq0ojLEpuZUE=;
 b=KpIsc3zktJjK8u4qnk9+5DNMHhBqbRlksJXO81QLnsxy5WsvHEDP/TLzTasTbsIFnb
 oexMScus7iZ/1rXz1kMwtahP2gaY5M6mLuOIPzog1B0sqvUuCA4y160q85cpJYqUDc2H
 TgTBCnOAIaZ2usk1Z6KkLBCD/6zhTA5kNiMek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780325696; x=1780930496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HbnTy1HBNm0fZQXE6IPP+RMyrkf8LJgq0ojLEpuZUE=;
 b=rNRjnhNWiGnn8pxfkA7eG6n4yEKD9XGAofVlh6KAszXKpzvdhbOlgGJUaJpXUpAaI9
 Xq/90Wp+Y+WYm5Yh96QoQePrTE84cCCMVnEXSefgZTgUvWEoDc7m3pGp7lytJhF3HOmG
 gkdKBR8U6PZeLHbiFJopeCzT/th4BnxoAl61KIIFMKq22yFGhK1bNAnPI+N4q0hHmmB8
 Z+CmzqZRMF4XG9zLa/vcOcnodPFv2RTSRmgoRYJKOX7geGP4KKY6OMR9SlANxYxJM59V
 dusj5qhp2IzQZmTDbLk1cC8Q6+EDhdJ2TjMdAGNWEKSBGhD7iL9PXeKde79YSBzOSYH9
 jeRg==
X-Gm-Message-State: AOJu0Ywz93w/P2cM6cb9jTyLUh4F7LOblL2ChCcVED8H+eNjXUeUdgG4
 7wnD/b85RX/fOQlyFDwyYr/r4pbPVbo5OjwLg+8jiOqj9DPZWSg8zjH74d1Z6ym3YLmgye9vRrZ
 0ZXSK6NTjDsFU65waZwPCRdmqNkjk4VgGN83z5nGx
X-Gm-Gg: Acq92OGlKBfGYt/YHFjFHsTB+XQmiE6V2YPEqkNPwch2azvU2TqdqCq3vSa07RzPZQ5
 fDratKjE0UDiWmUTTwqXzOxJhj1c8+aNBgvzG5lCOpWeI4LgO4Zgw3GKTVcGogKgGTb1jXSg1ZQ
 JSQh09qJKrJv9Sqcf2iYwr9rKsZCuLfUI931zrEgLMAayaYD9zx4zieZc+pkZ3rfYnr2uN9sQ12
 iQGOp7Tnvs/Grw27d428ytNFti1wg6+xznBkKymXzRW59vSELmKXY3MnXb7qSBMOOFTBdlqVKXZ
 hx/CfqsAwe4GsTBF
X-Received: by 2002:a17:907:96a8:b0:bee:ac9b:9abc with SMTP id
 a640c23a62f3a-beeac9b9d56mr69459466b.22.1780325696142; Mon, 01 Jun 2026
 07:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260529034839.2075806-1-dmukhin@ford.com>
 <20260529034839.2075806-4-dmukhin@ford.com>
In-Reply-To: <20260529034839.2075806-4-dmukhin@ford.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 1 Jun 2026 08:54:43 -0600
X-Gm-Features: AVHnY4KvEfgR_fOR1f-bskkx2KptriKX_-0QOOa-JldnHLh9CXrGyXoZxDrrvzM
Message-ID: <CAFLszTgonPmFx=6tnydZE-_q62=hCsdnUnLduBsJX+-drnW0YQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] reset: Print reset type on diagnostic console
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
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

Hi Denis,

On 2026-05-29T03:48:33, None <dmukhin@ford.com> wrote:
> reset: Print reset type on diagnostic console
>
> Add a diagnostic console trace indicating the reset type.
>
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>
> drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
> @@ -22,6 +22,22 @@
>  #include <linux/err.h>
>  #include <asm/global_data.h>
>
> +static const char *get_reset_type_str(enum sysreset_t reset_type)
> +{
> +     switch (reset_type) {
> +     case SYSRESET_WARM:
> +             return 'warm';
> +     case SYSRESET_COLD:
> +             return 'cold';
> +     case SYSRESET_POWER:
> +             return 'power';
> +     case SYSRESET_POWER_OFF:
> +             return "power off";
> +     default:
> +             return 'unknown';
> +     }
> +}
> +

This is placed outside the #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET)
block, but its only caller (do_reset()) is inside it. With
CONFIG_SYSRESET_CMD_RESET=n the static function becomes unused and
triggers -Wunused-function. Please move it inside the guard, next to
do_reset()

Regards,
Simon
