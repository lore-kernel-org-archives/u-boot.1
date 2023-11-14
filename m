Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84779C54E51
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 23:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D7F087254;
	Wed, 15 Nov 2023 00:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JCu+STtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C39842D0; Wed, 15 Nov 2023 00:31:29 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6868986489
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 00:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9e623356d5dso676308066b.3
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700004601; x=1700609401; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=loJdb2zrsLQFpswrYu/MGlkqQ13LAswznvx1Egy4fyE=;
 b=JCu+STtd67uW9g/F0IDA8OehQB/GUHjPrjS1YfSBV1NYHBF1qBVuuYhP0Ksk1ez8Hi
 4pMWSQNP1cTd6ffF1HZhid356M3Gs7rDST0BHlqVYAoN2DjLHZor0+75wTtJh6/i+lpb
 LJo5z4n8ny+nZ0CL/Puj6B9hJAn6J+v0Br9vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700004601; x=1700609401;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=loJdb2zrsLQFpswrYu/MGlkqQ13LAswznvx1Egy4fyE=;
 b=B2O9oAfm2ExpoVXnjDbkxK0eb2aQdYiY6hjq/rR2coj7Nq8cs6ttdCcGDQQDhz5/wH
 ivWpTBWs4p+NSL+Crwe+XsWuROyqweyCF4j9GV7GDAAf7P9TCABQ9yZoetReIEVYfCjp
 jDlj7QG5bgL7sItCLrIxgEZd0xLqZwrB6ipPZFdurdzKXpaHdUL4fA3KnZl4YPCS5I0k
 IIfZ1ExvM9GDNyjuYgJieXwzlIfaUxGyDq9/jC1n+Ztgn1teWpjyxFcj2otip0wausVm
 Y4yFj1WOiHd6WbVmJrpnKBnFOmiFgwqyXE3shFSByrUYTeY4bZRWgxAYzPXotMM8aVpZ
 Mb4g==
X-Gm-Message-State: AOJu0YyXE8Dc2xgHweNEW+EDwLIOrHzozuHjIPAGkGQAgNP0LXvUS3mA
 PKsa4WQJpdz6qNLfBdNfcIV/qnjHdRKla/NCGIW2fA==
X-Google-Smtp-Source: AGHT+IFAHUpqMXB7RXqH2TpEvH3T8efhoB9Nk/qYGHXHDAvDH1U7VRJl763tkq7tT7qRno+d7Jvza4d8alubREs70A4=
X-Received: by 2002:a17:907:7b8f:b0:9da:f85a:233f with SMTP id
 ne15-20020a1709077b8f00b009daf85a233fmr10698642ejc.28.1700004601438; Tue, 14
 Nov 2023 15:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20231114021428.531887-1-takahiro.akashi@linaro.org>
 <20231114021428.531887-3-takahiro.akashi@linaro.org>
In-Reply-To: <20231114021428.531887-3-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Nov 2023 16:29:45 -0700
Message-ID: <CAPnjgZ39BE4Hb=k+1OdjPWRiqRdLYCM3Uc04WcU1GzKkG0LnYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] firmware: scmi: support protocols on sandbox only
 if enabled
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, michal.simek@amd.com, 
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

On Mon, 13 Nov 2023 at 19:14, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> This change will be useful when we manually test SCMI on sandbox
> by enabling/disabling a specific SCMI protocol.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v9
> * use CONFIG_IS_ENABLED() rather than IS_ENABLED()
> * remove goto by introducing a not_supported() function
> ---
>  drivers/firmware/scmi/sandbox-scmi_agent.c   | 30 ++++++--
>  drivers/firmware/scmi/sandbox-scmi_devices.c | 78 ++++++++++++--------
>  2 files changed, 71 insertions(+), 37 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
