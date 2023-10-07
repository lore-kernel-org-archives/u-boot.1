Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BD8E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E6E86977;
	Sun,  8 Oct 2023 01:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ia+qY0CH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11048869C8; Sun,  8 Oct 2023 01:11:04 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E8EA864F3
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59c215f2f4aso40847287b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720260; x=1697325060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lL819t3gd8px05N94FOlv21EIXce4/A/mwOrpduVHMQ=;
 b=Ia+qY0CHnHzsGDH1PxtvRVrRKxKcDhDbgslz75mt8lYotyGbzfnAsz7lE4YcR1gxDr
 xKi7pvjwm1YCsMlbBGXYeAEf6/7lo4qTziwJ6uvCId1TT2dUgxUywoPTGwCxUjZoViR4
 hTiluyHPN0kv5lKukfQa2dwUyH9PmgERkIGeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720260; x=1697325060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lL819t3gd8px05N94FOlv21EIXce4/A/mwOrpduVHMQ=;
 b=tCe8/kz4xcK12VkaCID33GU/hJCIkJgoesUXEUkH+yO206B15MHz8UzJxU0wth8EjR
 Mj69V7XYuoF0P++CqXQxIXYz77xR9VTgIoykxjdM6pDwTZz1/R3qtJA3pPBGBTOuz+Yk
 Nrz8ilG2xw1En8GCEec707WacUHC+znbYTyEVnP2L+cVpwti/KfKv3QCo1PujA7VdLjD
 759roF96IUj5ASeuVKYTZB5wZskeRHUi8ahl6ofllM+tmx5AGjneZp8TS1J2N3WrphXq
 PR/OEKxGsx3b+scgDFw2PQpbb1DZZMIFkIOg5uPdTHuC3o43iobJjeyKc6GEJFPreuze
 TXOw==
X-Gm-Message-State: AOJu0YwoSZq9FMjsWCIH/g/Vc/oEK0YUI1awT71pa4a1qgL8qykrHOdi
 B8DepQAPnVHPO4yYHN03yU5bjZcGcpKclnQU6oPMqw==
X-Google-Smtp-Source: AGHT+IFru68tZpnzuGkz1Zbb5pd0pcevHZNewXKEpgpwGKQb9g8JZ3k9U6BN60bDUAGVfmxStDmTvkQ56bpWEzZUw/Q=
X-Received: by 2002:a81:9c14:0:b0:598:5bb5:1801 with SMTP id
 m20-20020a819c14000000b005985bb51801mr10686686ywa.50.1696720260069; Sat, 07
 Oct 2023 16:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231004112722.416877-1-sughosh.ganu@linaro.org>
 <20231004112722.416877-3-sughosh.ganu@linaro.org>
In-Reply-To: <20231004112722.416877-3-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 7 Oct 2023 17:09:47 -0600
Message-ID: <CAPnjgZ1a+7GQQgOSjGPV2_0s+En1F+NpJDpnPaVBGYf9z3diUw@mail.gmail.com>
Subject: Re: [PATCH 2/5] doc: capsule: Add documentation for the capsule dump
 feature
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

On Wed, 4 Oct 2023 at 05:27, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add documentation to explain the printing of the capsule headers
> through the mkeficapsule tool.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
