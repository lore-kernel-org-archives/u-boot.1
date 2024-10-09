Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65ECDCF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:52:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBE88901B;
	Wed,  9 Oct 2024 03:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ISkcqyAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513C98902F; Wed,  9 Oct 2024 03:51:31 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37CE189034
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7ea03ecf191so2544838a12.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438686; x=1729043486; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AUWHV/g3FuElHzZctLcz5RHa8LediNUv1sgqzVpkADE=;
 b=ISkcqyAgK/CnhpoME5xsRcX6I2p8GCso8KOcDCFag/eBQkCNqoxX5JGmOu3pnmmoj6
 RdGHlTN5Zy42QjoQyNooUhG/QFJxuRi6VXOD0Zai/UIfs5TIaRpW9+6N4mvhu41esNFA
 slvetf/COU8GYEaM8uboE3yaqyacAovZnd4g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438686; x=1729043486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUWHV/g3FuElHzZctLcz5RHa8LediNUv1sgqzVpkADE=;
 b=cf2FClEcq0fsp992l3F4tivYmHeWGVl8V3DN65o1DOCVHXGnkvGBZHGAqd9W34yPFW
 Box4qZxZthpXPY5n9TtbubSd/1ggwiaNJGszS3Z9YskX0/enuc+foE/UpFN2m9ghKoTt
 7UGkCGBWmN8Z5QdlgsQvlfSwquNo2CU78daD7lMfTtHTJX/nbAlijjUjOMbLgvGa9xp3
 tUfr2YbhF/0FKkmorbJERkgPK4B9ludqWIoIB3ziYnbigvdk2dJzoKI7ExtemtLPpv18
 Ez3+kz4mssZQtBjnk+WrFxmI0HB1EVX5PvT+mojRcW9A4ysUpACSyN5XwVF4sAPpi/U5
 jdsA==
X-Gm-Message-State: AOJu0Yx5yq2y7KE63y+SNDHyxc5W+/ike7dv9pypY/yL9uKxGI4PnOqq
 XlDojUD5i98aneyKLMEP4sLLl61h+rTr5N2WoSibzsrHqvzCD9uKjNnqZQ9KRUDfyNikkHCoTzB
 FssLc3hrEH0GhYlFyHmpoCYZzZ7F60Y7IGIMW
X-Google-Smtp-Source: AGHT+IG1Yz5MkCJolqIx2Km1tLwqNeYteU9Sz9HDHp1NtI4BxMaJFnizcU4+XAN2GcQiVJqmquSOzUwqwbl7NjgiyCM=
X-Received: by 2002:a05:6a20:c78d:b0:1d6:fb1b:d08c with SMTP id
 adf61e73a8af0-1d8a3c3d1bdmr1174496637.39.1728438685808; Tue, 08 Oct 2024
 18:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1727968902.git.jerome.forissier@linaro.org>
 <c32debd7420b430fdc6cc35695825bf01a5b7b0d.1727968902.git.jerome.forissier@linaro.org>
In-Reply-To: <c32debd7420b430fdc6cc35695825bf01a5b7b0d.1727968902.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:10 -0600
Message-ID: <CAFLszTix5QG2mnvsrgSuFvg8vdN_7MYWjE9fA4YyXgrQLoWdxw@mail.gmail.com>
Subject: Re: [PATCH v11 02/29] Make AVB_VERIFY depend on FASTBOOT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>, 
 Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jagan Teki <jagan@amarulasolutions.com>
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

On Thu, 3 Oct 2024 at 09:23, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Note: Patch posted separately [0].
>
> [0] http://patchwork.ozlabs.org/project/uboot/patch/20241002144845.1439316-1-jerome.forissier@linaro.org/
>
> AVB_BUF_ADDR, which is under "if AVB_VERIFY", defaults to
> FASTBOOT_BUF_ADDR. Therefore AVB_VERIFY should depend on FASTBOOT.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  common/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/common/Kconfig b/common/Kconfig
> index 957de0c5c02..c011ab6e820 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -850,6 +850,7 @@ config AVB_VERIFY
>         depends on LIBAVB
>         depends on MMC
>         depends on PARTITION_UUIDS
> +       depends on FASTBOOT
>         help
>           This option enables compilation of bootloader-dependent operations,
>           used by Android Verified Boot 2.0 library (libavb). Includes:
> --
> 2.40.1
>
