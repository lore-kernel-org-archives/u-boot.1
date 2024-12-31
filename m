Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2479E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F1C80383;
	Tue, 31 Dec 2024 05:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m8rxeowz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 363498039A; Tue, 31 Dec 2024 05:08:32 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F7C080352
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-467a37a2a53so115866311cf.2
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735618109; x=1736222909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4tBHvsMiNL+YFCk3VrrRv2pYV4/oyrWtthgJ6ISXbA=;
 b=m8rxeowzzKYAEQD9iwZB6M0hLL/EEdS1xtOGjuQ8MtCmjr3ox/sv38mwIpJ2jE+1N/
 Pkf4e9ogI0uY/BQwPewJHL6uag4g6rHiVkG0YzK+h89qxJYlFqgSR4DgpviYAc4wVtdw
 aXJ+lFPJvcNAPBrfLDWsjIfWWmNzMluh1lXJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735618109; x=1736222909;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4tBHvsMiNL+YFCk3VrrRv2pYV4/oyrWtthgJ6ISXbA=;
 b=mLn8cbjIUAqWt0lqZOkn60S+Dw4saA+lGu0o6wSFp5BLNNbuPqGy3TDDiAJkmWYM3H
 2OWlwvbNi9RgxjlemBcip2WLtcgas6tni9KPWXp7AZkOasGtakC8eUHCSnN7NuEUsoLu
 ctKUvGlWTrESixvqDvjOw8Wse/EVipbo4pDWQ+1ixONdcicAXmD80wf0cV8MsP5t2BzR
 ObzilHPj19vGOkSpDtqm9oWlNjm7SpEpn5mUbwfwz+DX591rYtDetmklawpsGZsemx6K
 XnnJqackY8Pq9jv9lxaAXWklUYStYhv0nP9MADVQMKp1TwWKy/bkBEsLwWtzGDFtOVhI
 t7YA==
X-Gm-Message-State: AOJu0Yyn7yv5NKblMIOLgTqwMR+Qje7IsTJo8v9IXwv1hNAYrxZzsOSI
 +2ytIdXPV7rsk2ogvUFnilILu3FbXRmz++R+KsK3TGAcdPvROasmJWu9p7Fzug8zpPC5lhVsIJX
 0
X-Gm-Gg: ASbGnctFlOshzoBgOlJ5SNbgHZ5FQL4F/NLszLObECiBlho8wrQU1ZOu9byT24m/2+m
 /Dh83cnT8O1ElyHw35GSmN2i9OI3iYXcpssxcyArldz30kfAmGKbq5TkNOA705DZnTr0gpM9NZp
 DH6/hWGua4cKcEVKnfZVMBnlxh7pxHDPga23xoX0QgVNREuiWuLE6m+AiAl7V67y0spXdfd4ZA6
 xvnqUwIdq8jYSX82qYzTPp9ovJNBoQO0E594ChMRCrS/UsQmKD/R9cH
X-Google-Smtp-Source: AGHT+IHRT6i+So+qz8Ee3xxo3WiASzcBwqdVxkmqM0Q8L4wuE5qA6tKRHb9yiv6YKRX/7ceWeA7W2A==
X-Received: by 2002:a05:622a:164e:b0:467:67ad:e2a6 with SMTP id
 d75a77b69052e-46a4a8efcabmr540242531cf.26.1735618108948; 
 Mon, 30 Dec 2024 20:08:28 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb30b46sm111735231cf.87.2024.12.30.20.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:08:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com, 
 marex@denx.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com, 
 u-kumar1@ti.com, seanga2@gmail.com, caleb.connolly@linaro.org, 
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net, 
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com, 
 git@amd.com
In-Reply-To: <20241230070206.2178551-1-venkatesh.abbarapu@amd.com>
References: <20241230070206.2178551-1-venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH v6] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Message-Id: <173561810664.258174.10529164601941469973.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 22:08:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 30 Dec 2024 12:32:06 +0530, Venkatesh Yadav Abbarapu wrote:

> Update the spi_nor_read() function based on the config SPI_FLASH_BAR
> and update the length and bank calculation by spliting the memory of
> 16MB size banks only when the address width is 3byte.
> Fix the read issue for 4byte address width by passing the entire
> length to the read function.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


