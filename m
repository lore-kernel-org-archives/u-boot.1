Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1D5CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 14:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B14832AD;
	Sun, 26 Oct 2025 15:27:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gw+KbtoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3373C82E34; Sun, 26 Oct 2025 15:27:22 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55575836F0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 15:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b6d78062424so613710266b.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1761488840; x=1762093640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xhf/xWxE5dzKuGE0TqXaiuXVHCAftWwHU3uMNJKq8Ic=;
 b=Gw+KbtoWkABSUgS4JubgxgFXyKe68Iaum0LAHVghxU9PdEBDYEpCk6UAPAXEcCu+WG
 ZhI9612lhSvIgb3WVleYYuAxOPrTO7/y5Y3f4rxK7Wx0nh/DlRLw1D43ZQYmsCbRnHW+
 plE7oXdOcGTt8REtE3zTXZA/IhC2TBtxKSJdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761488840; x=1762093640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhf/xWxE5dzKuGE0TqXaiuXVHCAftWwHU3uMNJKq8Ic=;
 b=b5Mu+3jrsKkcE2oYEe7F4IN9jl+qgBSBfK73S4H6ZSTh2ArXg4ZdnWSyFyfXGlgrZ5
 DJHgznJmOVKpSojwIAmC2jX+chY77KYRLcIg0iFw/xBeh04W39lDLPEkQH8sOr7nJtUz
 pPUg/ltEEpJ0PEZ7Gof8yji3TNGDA9qlIqWGn6TgR2UktuZ7+CyJGVYxBdmSQdH90E52
 5rIeq/k5BSht8TdGpcexRSM/vXzZSp6LqQlwIbFj9n1q70obUPZBjMA4Q1WFWFap2Se+
 DOnuf03vCiVSjKUpFShFixm6PPIeR/j9wMUMmFbbS88c1FmRAvm1utRN8cG13B6iA6GQ
 S3Rw==
X-Gm-Message-State: AOJu0YyGCaLtkp7QwwpAKitOCyeu1YUENIUlg50CVQ274kE7XNPO9QPa
 qyNl5nbi26Ro7hUbhOWOHPF5Wg/I2qAOHYs0JR0XUplewqno9MmrCSqGvjCtwQSvK28u+45Cj4G
 oANay3wMzYVvrgOhmjDAlFuOWO8u2u8/q39J/J6yeodaQDHoJFyUMOQ==
X-Gm-Gg: ASbGncuXGNcE7Y+sHPsV95rkh0AlM4YfZvlii/pxXrUGKkLESEW6SsvRx6XEwJlhzuJ
 UycpsvyYQBWgOo1LBFAuifkb4/kJqaoe32E4CA1e2FWKsgsJEP8OeZ8xmgmuu8Boe4MntbQbULn
 GaejSX8Kr+nA8rN+3O28aWWg0ifaPaV3Ece9oyxARPOdfdGGd5KJBbSb58jPArHZS/TG9EfSE6f
 rwiqDrTIHAARr4RJHzVdDku91NKHIXzB9LDFXK6sRn7fel656benqZNG2yR9RTU0KXiSEU=
X-Google-Smtp-Source: AGHT+IF29V8nUJb2sAEd19ri9IhHJxrUni0Cf+NhwaBIooyyKgi2HSLnQFw/pz58GvkNoXDHtH6fVshaWVPxO95BEOw=
X-Received: by 2002:a17:906:c113:b0:afe:764d:6b22 with SMTP id
 a640c23a62f3a-b6472d5bc0cmr3621062466b.9.1761488839724; Sun, 26 Oct 2025
 07:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251024151219.100970-1-wolfgang.wallner@br-automation.com>
 <20251024151219.100970-5-wolfgang.wallner@br-automation.com>
In-Reply-To: <20251024151219.100970-5-wolfgang.wallner@br-automation.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 26 Oct 2025 14:27:01 +0000
X-Gm-Features: AWmQ_blRw-AVXG8-GrZWO1TsFjcjonp8iX8MP7__39VHhPz_pIrNIfF5Ox0GzeM
Message-ID: <CAFLszTh5ERw=ouRFwQ_DyDV8wgLDL7q5afynqwxu7M3OdKuEYw@mail.gmail.com>
Subject: Re: [PATCH 4/9] boot: kconfig: Fix typos
To: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Cc: u-boot@lists.denx.de, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
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

On Fri, 24 Oct 2025 at 16:12, Wolfgang Wallner
<wolfgang.wallner@br-automation.com> wrote:
>
> Fix typos in boot/Kconfig.
>
> Signed-off-by: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
>
>  boot/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
