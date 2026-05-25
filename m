Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14A1CD5BC8
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:44:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC51B84948;
	Tue, 26 May 2026 00:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g1A9i6AM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2ED3848C5; Tue, 26 May 2026 00:43:27 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE87684903
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e6201aeb2aso2525536a34.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779749004; x=1780353804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+o3hW6YHNYvBJLk7HRKjS22MCd9tbEVCzFkBWvBxl0=;
 b=g1A9i6AMRSx+3hH7aaDg+ERdtCk5JvoV0WyhD54LKrDxuTBXmTzkqxMOSwomw3+8YY
 276CfTI2LHEdwtNluJbA8s05PFnr5GyRY4PDeSvgl++s1urzLUTvn0vd5GXwR3pKvt8V
 atDRXoNJnPkDEEDi9uPbIhd3iloEYSE66meM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779749004; x=1780353804;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p+o3hW6YHNYvBJLk7HRKjS22MCd9tbEVCzFkBWvBxl0=;
 b=nxKRnufGldFFlWks4Lz2BjkYiLr//XmBGZWOBlQz2u+DFSfAxB+/qnDGmLUtzQkDee
 GHqPVvuD3CVa3cM0aXvdEYtP6wW4keBjrXUIH/ot7gI7tF88Djj04qMVMJ3SUUEc2grp
 5XON26S+xXgJyzpSRhWKCu4yIcyBiphWcIH/afGuNu02+igeVpC6rdlPE+FQEGGR9ab8
 EmDpSpg+UXf9W6JNnDTgR4jv8lsG/mKf9u+D6pxmHDzkS+mwSfOGpEeuiFjycMPxopVR
 bcSE8dh5/enS2ppGc0WtsLo5B+B5lI8m1kra3gq8foLLGQKNR97xLh5X1vj3gaFqFU5G
 jdiQ==
X-Gm-Message-State: AOJu0YwOw0tguOS7unDj1DuTM54BafiEl8fqBODxLefKPPNNJEwWrYN7
 Qum+HD29xKMVeaQ1b/OSW8f1mYpKjcvDHQ2M1LdfwP0TR73n/Z/u1t49p9EtlNJBEM0=
X-Gm-Gg: Acq92OGfGHmvsk7ldPu9/PUZymvX9r1lJt2raBrHXY2qVGhjpKOOlndQgSffti1D9J2
 OWVsqsWO4acpi5Tnxo6zj1uLXxveX3YHPOgjjFfZgKdvDW2Mh1AUN2Vhs3hUgPGwmIDIu2mfJRC
 +Nboz6OokZaGFzkY+tasPZgHu9YbDeizCEDCqP057qFnxRqlKNmNFsCHD0VbTj8eLRYghAzLxu2
 4GiWzhu5y3W4fzKZwk++lMnaqdEraDt0A09bAKh2j/ZxTsSK7nUHxxuFzCDOI/UR9IbtmCZqkmp
 vsUh8ClA0TV0guk/CBy+t9/33XnMtF2Iu2H0Xcb9O0uMl5AzIY+/3BiBa0L3uFyaMKs3Z43RNDO
 mXXVi1Kto7D72I4ZPvOLIDiSwDvItbm6WMhFFTjD3OIRQXYmuMyz6SxnFVH4TLMCVUErPvAVpub
 /boGiBayGEhIgzoExSQ2rxFz+8Dr91wNFCfCsq+fCFmkrVv084v+Z++tb/vPUiyAcZU/hKyzf5K
 GBG05rhZhG0dRwntnI+ssjp5YUeKsiU4BrOoAI4eb/D
X-Received: by 2002:a05:6830:82bd:b0:7e5:6f53:5bee with SMTP id
 46e09a7af769-7e5fee6e654mr10080688a34.21.1779749004642; 
 Mon, 25 May 2026 15:43:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:43:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Matthias Winker <matthias.winker@de.bosch.com>, 
 Philip Oberfichtner <pro@denx.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Fabio Estevam <festevam@denx.de>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 David Lechner <dlechner@baylibre.com>, Michael Walle <mwalle@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>
In-Reply-To: <20260511182036.50453-1-james.hilliard1@gmail.com>
References: <20260511182036.50453-1-james.hilliard1@gmail.com>
Subject: Re: [PATCH v3 1/2] env: migrate static flags list to Kconfig
Message-Id: <177974900309.3696278.15923789428849833604.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 11 May 2026 12:20:25 -0600, James Hilliard wrote:

> Environment callbacks can already be configured from Kconfig with
> CONFIG_ENV_CALLBACK_LIST_STATIC, but static environment flags still
> require board headers to define CFG_ENV_FLAGS_LIST_STATIC.
> 
> Add CONFIG_ENV_FLAGS_LIST_STATIC and use it as the only board-provided
> static environment flags list. Convert the remaining default-config users
> from CFG_ENV_FLAGS_LIST_STATIC to defconfig settings and drop the legacy
> header macro from ENV_FLAGS_LIST_STATIC.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] env: migrate static flags list to Kconfig
      commit: 5e41a5deb4b843808f3c892f2f54f1b9c76b3da1
[2/2] doc: remove configuration settings from README
      commit: e11b0c5cab44817b3c1cb4fd29339010b4db4321
-- 
Tom


