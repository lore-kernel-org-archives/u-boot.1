Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C442AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E85B87250;
	Thu,  9 Nov 2023 02:16:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HuNhBOtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D0C86FB4; Thu,  9 Nov 2023 02:16:08 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB731871D0
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507adc3381cso370680e87.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HLACZD55+CYkbD5iEP73SFqFqiw5x/AXvJHrYyVjWSs=;
 b=HuNhBOtbmMHzq674pkklv+BZukYAVtm4tveM6UVKxq/t3NCH+HdsuICmUSutEIi81s
 db7K9wIBfMz0dVk+ixTdpUp6O6LaumKpUIjjQEK/zL0foMxsG3PCAPyXQZYMPSFFEAQ2
 rCIe0HBFLD0hS04C9zOvU/qB4RYXr4LfvSh08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HLACZD55+CYkbD5iEP73SFqFqiw5x/AXvJHrYyVjWSs=;
 b=SFOQjijX6vizUQwOoQiCQPMv3BekcHcq/E5UDZP/8qxgowUR8q7nOVGR05k5o2939O
 qCcIz3H/uUiNb7/91O5ER6W7BliU4EpzvZX8AUk9tsId6bNjFgGdrflM6jxhQah91jMo
 cMwXmGLDm2BqCqkMUQyvzVxp0X3SdYJFjjs5PAUzvis46VE6TE+e21NNf4ZBzY8p6V+5
 X1c4Xa6UIergATMhSkPmPOribV7qdDOEb3mjIviFjg0J6SvzKF3DjJEdt0+h/YZ01HEo
 M3p1PouxmHgc7loDnyyyxp/IBbJYZlnnTbU1lrC0C3jRqAh1x8yDIQQRuDGUIJppEh+/
 mylw==
X-Gm-Message-State: AOJu0YzHsjx9cxE/Cp1M+VsISR7k8IlnQXL3Bqeb05LheRX8QhKvINHc
 wvd5pkMAWHgesG0Q7IexDFB/dSPHD3mMxA0kh5wQZQ==
X-Google-Smtp-Source: AGHT+IHMPZW0R27exGkheyDLkoQOEAPFt+bUgs2UBMlJUM9Fwpw74w1KRTSR5lcd4gUptsOFXdxB08prCpneWTFzkkE=
X-Received: by 2002:ac2:48b9:0:b0:500:c292:e44e with SMTP id
 u25-20020ac248b9000000b00500c292e44emr139034lfg.54.1699492547792; Wed, 08 Nov
 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108192811.1844338-1-trini@konsulko.com>
In-Reply-To: <20231108192811.1844338-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:33 -0700
Message-ID: <CAPnjgZ2gPbx0Ga+6-u-k9JCzeM_GzVWmjcEAR59wfqw5OhhnYg@mail.gmail.com>
Subject: Re: [PATCH] scsi: Have scsi_init_dev_desc_priv() use memset
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Johan Jonker <jbx6244@gmail.com>
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

On Wed, 8 Nov 2023 at 12:28, Tom Rini <trini@konsulko.com> wrote:
>
> When we do not have CONFIG_BOUNCE_BUFFER enabled, inside of
> scsi_init_dev_desc_priv we never set the 'bb' field to false, we only
> initialize it to true when CONFIG_BOUNCE_BUFFER is set. Given that we
> have a number of other fields here we had been explicitly setting to
> zero, change to first calling memset to clear the struct and then
> initialize only the fields that need non-zero default values.
>
> Addresses-Coverity-ID: 467407 ("Uninitialized variables (UNINIT)")
> Fixes: 81bd22e935dc ("rockchip: block: blk-uclass: add bounce buffer flag to blk_desc")
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Johan Jonker <jbx6244@gmail.com>
> ---
>  drivers/scsi/scsi.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
