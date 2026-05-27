Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79DECD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DAC48491D;
	Wed, 27 May 2026 03:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hVEpV3v6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B17A84869; Wed, 27 May 2026 03:17:42 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E10C18493A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bd8f9725b30so1237954566b.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844659; cv=none;
 d=google.com; s=arc-20240605;
 b=KpHiqb6WMGV1wSoVyHfDPMMHhqPZKBNoSRmMEcd+7yXWcbtn4eeUG7Y7Yky9QhRJKE
 KjVdrpeBwxEa7QVpUMyDJLPLiI3Kpb2MEhCQkWpoElYz+YI4BHHkbUCc8A9U8+mZcDPk
 oJBguRzwCqptlyDTWRHoqeWDjzMJTjJ+z9RObgPf7YKN8S18E359xJaRzem5+4dett8u
 31kTE9H3t8+xda9gl43mDIU58MUA7vX1MGahxs0g/bn5F4DQT7AN+z9ioI6mJ0Co+pkg
 iveDjBWCZItIHkgqZcJP4OnQTCA29OnT7dYp9EWnfM47DWZPqmPbCXFo3bUlRbZM2CVi
 JveA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3lLrrA6YfEN/j4ue/cCG1PzmF8Qsq+LLI9EVd19QCoY=;
 fh=7HzJ9BBBx4iZa4XdRLXOksY74UmWuqL7h1CjcfaRqlM=;
 b=ToWXnGeBOaQ4gutXmLjn7isIH2ZnY6p72vXxpUx+un04WOFIbbDZg++wkbxf2G+ZbA
 VvtKtlPYAR3BHkUmGRdGkiWztyieuOMMYtt5MX8sPuwR1taWjJgekld45qcQDz/to06d
 aJrUaGOAB/YYgPBLdyl6ahGyZnhV6ka3HjZMtzA+UOLn83cGi/aqrlb7YFGJI/AGzoZ8
 5ah3vqxre9hB4TmfxUwecuMP5HLWAG8ihiQbto2xawLqXcwCfVmZGwQhjqQ308j0MTxe
 uayytWS/cmZkCQ5oyalnptjuLzl/9dpC+V90/5yfIV7CZ/HHOILPnAXCoXh6Dma4bFhx
 E1BA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844659; x=1780449459; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3lLrrA6YfEN/j4ue/cCG1PzmF8Qsq+LLI9EVd19QCoY=;
 b=hVEpV3v68Kx7jzThmxH9mIYvHNp4hzjAhhiq9VD7vEihLo6B0OksY/w9CuGL5g9c5Q
 +gMD3ueRyE0eU/ROTBh2qLHqmTaWHLZgov/TeFYM15Wi7qn+QrGFgFFulNTuINGl5pT7
 Vzri8RpUHkHUDiNtfHz2wBpr8QBJSaPxGcN40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844659; x=1780449459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lLrrA6YfEN/j4ue/cCG1PzmF8Qsq+LLI9EVd19QCoY=;
 b=b/ymrkFvE9zzQWTMB7+BalVYlOZQn32Q+GAR7NiEuLORImyNgRXD9Af4Xi8woE7TTH
 4jAxVzU6D71dql6rPAuU4fe1x2XC0/7WtcLWrjYLBOEc3s7OcRFGDJ2SUAYxXUCt/E6L
 MxDzx9oTXU0leeeG3CbXSaFaOPwrlpn2VwrixvtF3gTf9BRCLkTb6lSPvY/0aEEnQgum
 m2OpcU+Y1sry4i2RkXS3gtlANjPoW8oWG4iWmOl9/6Cg/8hSg+dgy4dXgAfFTXQJ1TSd
 +X64651x4wU525GHqIhDPHTDIbJ0VOD9uizH8Jq2Vkfz+pex9BmbkjAmtOQxfZw3PiDj
 Cckw==
X-Gm-Message-State: AOJu0YyXn6K5q16VQDnFC93aRN/+og4UBws9xptgEyik9/UiuCaNkmkQ
 MBwWHWwqTY+IMgkYiTC52vZMEOH8dokrEThITP3XUKIvVoWaRms9wADTckPRqB/+jIks5+oLBPI
 enHZREdVTw920Nxf4IhARqAeXbZLz23KEW2gXCj4o
X-Gm-Gg: Acq92OFcmHmgactglSo4F9EwvuOj9e1x77TGzfMZPADr+VI8Vpt/gSQoao3BGq5nFHm
 DX4paSj+2UL/2aZB18gnNuexay2KOEOcNyRpstWP1V3P+/WF1E5i9JS/TppIgjUXUpI6VRgtNIP
 MsNwNZUuJj/jOGXy41QBx/gh2beEprw83AjX5T2xpoZZzdLtdKfVmyHQnIn+lEp7zizM9CB9dGa
 Fvw8VSiW64pCTp/1vGxBC/2TeL5RKpz1QG7rIvoB0bmCfJaTckQK5hGtNhkssteF9kyx5jClvav
 ahObuQ==
X-Received: by 2002:a17:906:8a67:b0:bc2:1dab:3ea0 with SMTP id
 a640c23a62f3a-bdd282a4824mr964952166b.8.1779844659343; Tue, 26 May 2026
 18:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-3-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-3-be3597b85b5e@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:17:16 -0500
X-Gm-Features: AVHnY4JsItC8ZIbdRZZK-dpW1Jq_jhzj7dG2dSkiY5_cJ7EclAayQE9LIXfKTJ8
Message-ID: <CAFLszTjJEzQSA3U=Yr0aKc-ZrH1FT1Z5voyNqYsH2sh-mSOHqg@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: calxedaxgmac: Use dev_read_addr()
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
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

On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> net: calxedaxgmac: Use dev_read_addr()
>
> Use dev_read_addr() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>
> drivers/net/calxedaxgmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
