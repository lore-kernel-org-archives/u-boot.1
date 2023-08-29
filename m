Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65728C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 16:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7297086504;
	Tue, 29 Aug 2023 18:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eoCUhfSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 820AE8650E; Tue, 29 Aug 2023 18:38:41 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9943986504
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 18:38:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a49a42353so6402825a12.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693327118; x=1693931918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ggd3amgeOEjqtPKA539a0CKcUNz9ijeJ6u1wOAP5K9M=;
 b=eoCUhfSaWeWDyO3AGFDy9GaWBai9xsgrj+xNAEXvEHcWVxBRo9xG8k4sI0dRPiiok6
 xghcKqujgt4J/i3U0CDoDb6lrlQZrUvBnydgHX6hlYS5E/wDLhSaxmbUWo4x0OBOrLRe
 IS7oI8HCzVXwcLpVeoyZ11tzi/3OeIUf14u+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327118; x=1693931918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ggd3amgeOEjqtPKA539a0CKcUNz9ijeJ6u1wOAP5K9M=;
 b=RP83iLgMiTwXeeem7w//PMgzGjHn1G/HR+8ulwA+PAirjystlpO8etMbe9owBaVM5D
 F4Ct4GpuadPGgRYLpKRQSPcEIOF+oAU0yCxAePkQJCGmdQ+8NuKS2PG8lff2W/vtuUQV
 sjfEhN6vpyN3dot3IsUkQr9E54Y6+ok7WxIQsYSTy6WKhontUktsZVQJ3qda2IqsZW3/
 E7nUeJ+SoisvYYbtfkg7hwZMCf1LO/NE9tC9NDN3AG2AaLd3ebfT8L2HG+ajYeWCQqV3
 gf7xKICvxrTwbELJpoVwHw3jyDgJn/8DAsMsYEyF4e0BsZX8xy6Cfe45Ww8LGv8QHOG8
 DDQw==
X-Gm-Message-State: AOJu0Yw5Aj5uSEtn1FGE9BnkjqLl9OAhlh6A8ec/Wn0MhHtkhxTArkN0
 pkdrzQbAMOAC63Aza3jC0vmJqN6jyUwQkwaanfllrQ==
X-Google-Smtp-Source: AGHT+IFycOPLHSljj8LgoVV02jjHaFVB4CbMTGbc7rAgIar49ooRuuCPQjduYalDUJf0K3p1FiV+3HWWV82OoXd/kvQ=
X-Received: by 2002:aa7:cf09:0:b0:52a:1d54:2533 with SMTP id
 a9-20020aa7cf09000000b0052a1d542533mr15873840edy.9.1693327117883; Tue, 29 Aug
 2023 09:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230829042831epcas2p4a8a4cd85cdfe73e8dac914b274d5c351@epcas2p4.samsung.com>
 <20230829042803.2606011-1-chanho61.park@samsung.com>
In-Reply-To: <20230829042803.2606011-1-chanho61.park@samsung.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 29 Aug 2023 10:38:26 -0600
Message-ID: <CAPnjgZ0XSpoCRp20aOUQ7mwaCnkQGS3ois7kfkkMV064=QWtOA@mail.gmail.com>
Subject: Re: [PATCH v2] spl: bootstage: move bootstage_stash before jumping to
 image
To: Chanho Park <chanho61.park@samsung.com>
Cc: Nikhil M Jain <n-jain1@ti.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

Hi Chanho,

On Mon, 28 Aug 2023 at 22:28, Chanho Park <chanho61.park@samsung.com> wrote:
>
> Regarding IH_OS_OPENSBI, IH_OS_LINUX and IH_OS_TEE, there is no chance
> to stash bootstage record because they do not return to SPL after
> jumping to the image.
> Hence, this patch separates the final stage bootstage code into
> spl_bootstage_finish and call the function before jumping to the image.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
> Changes from v1
> - Separate the final stage bootstage code into spl_bootstage_finish.
> - As Simon suggests, call the function before jumping to the image.

I think you misunderstood me here. I mean, you cannot jump off
somewhere in your board code. You must change it so it returns
correctly, and the jump happens from spl.c's board_init_r() function.
The way it works is you set up the spl_image structure, then it SPL
jumps to it at the end of the functions.

Regards,
Simon
