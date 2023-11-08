Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ABFC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE818768F;
	Wed,  8 Nov 2023 05:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dMD2AW2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF10876E1; Wed,  8 Nov 2023 05:25:52 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73AED874E9
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-da2e786743aso6719082276.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417549; x=1700022349; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+UzCwLyHf1KNdS3YeIQrf6RAOa1/m+/N/eKjBfqpF8c=;
 b=dMD2AW2q5eEVp783yxiccr9NXwengIma8JB2xP/pV0p2r4QgOmIoZJc7HOtzUS7Vnw
 m1q4llF2esOAv+7Q9JEYtRigylfnnSCoVU47nu/t6vVWeYNYi+30kEUeW+7gYNu6qpsN
 sAmcn7pmiZlvmDqHH5r23fsQYtgjAdx96kzA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417549; x=1700022349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UzCwLyHf1KNdS3YeIQrf6RAOa1/m+/N/eKjBfqpF8c=;
 b=sTuItC0AL/NXx/MgjsGVOI2EIWOPrTKgrhpcMgk/3e9Ru9smeN82/pw/dAYeqjWVX7
 8WjLnNm7hXDTKJpIRxtQkwdMllFNi/vaxl5E2AAvAM90x89S02SNmyqfxAHcfyqZ+OeY
 QLoK72L3x+nikS04FtVZiEboSqDhZ9NskT3ruky62FcO+f7ES4NjVFggMmIkZICJV8QP
 OzjGM0VRyv6ZfwfQFCs112kbi9sTXt/EoXLS9ooVKlJtR7T2Xe1oPgG719+Gpe/5/YR+
 Z8tTpcpU+fK3Px1ZZo/nIx4EkXcLrqHzqbGywbqnEsVBJfrCSqUzT/C9ztWqutPtLt6A
 qpVQ==
X-Gm-Message-State: AOJu0YxZQDvykWWAzPMp8tnRO3EZb97+mspdtxffkElo0CdkeX800/3H
 KwOcwKUWuwibJ8cIaooZ95tbKQIir4/psRA0LhYJkQ==
X-Google-Smtp-Source: AGHT+IEw4vLel4f8EnljNqTW7tY+XVFO+U4E6VZjR+uDWXll3RuqY1HODfh4eNdL9B0ExqZ5f5VUA7Mi6iVLUiQu5K0=
X-Received: by 2002:a25:acd5:0:b0:da0:4a6d:bac with SMTP id
 x21-20020a25acd5000000b00da04a6d0bacmr950308ybd.0.1699417548796; Tue, 07 Nov
 2023 20:25:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
 <20231107190601.17151-4-semen.protsenko@linaro.org>
In-Reply-To: <20231107190601.17151-4-semen.protsenko@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:51 -0700
Message-ID: <CAPnjgZ2Ga96rqaM-c4NPo=wTLUKtXFt31ORTz30LLjeb+z9Szw@mail.gmail.com>
Subject: Re: [PATCH 3/4] serial: s5p: Use named constants for register values
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
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

Hi Sam,

On Tue, 7 Nov 2023 at 12:06, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Get rid of magic numbers in s5p_serial_init() when writing to UART
> registers. While at it, use BIT() macro for existing constants when
> appropriate.
>
> No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  drivers/serial/serial_s5p.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
