Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9995FC44516
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 00:08:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F0F383EEF;
	Sat, 18 Jul 2026 02:08:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iK41Kr4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C3D80433; Sat, 18 Jul 2026 02:08:00 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A0E180433
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 02:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-451a49abd8aso3172698fac.3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 17:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784333277; x=1784938077; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TJqjKcJagKDdVvj4z+WgyzXOBW8h2Kn48e5dk7r/ze8=;
 b=iK41Kr4bVxVkqBb65I2C+9CjO/W+uWNPiNyNZ1T+olKSLcRiVvYDwjZkvo6h76dWmV
 I6CBwnLY4xL3WzO0nlefLCkTR3VysXvHygJfWDOXLxe5VHn7bcevmaxvReMDJSPO9PqV
 feCSOa63hsjtPmfDLZSzZOf6wLqypHlpNb1fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784333277; x=1784938077;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJqjKcJagKDdVvj4z+WgyzXOBW8h2Kn48e5dk7r/ze8=;
 b=LsFm/hmLR9vrO2yLaOsJMSNVPrNgfFY/rynMDKugWh9RqxNK2eMPiSI3/TM/u8gLbY
 U3hXLx5xwhmAGFxSuwgRFF/Np1q5wQrNsm3atuOkX3JnD5mynoP7B3xRUBsB5RDCymiQ
 4l0cXNWHNPGkaP+pl/FnFfDYwAdF2h6gey6MRwU7OGp7QmtAXZ5K7F/+dxGqfUO2UDpV
 XUh2uFbQFq141ATzlr+QiDITr8AIpTg2q7Jv/USVbHEsaXAfTckEEMM1ciPhk9ee+PxC
 LaxDecb+nFk8B+BW/b6duQUeJsnLbGiGfFC8q5PpDZ1T1LtdJ08WRiDlOZk8eyCehSOn
 FJ6w==
X-Gm-Message-State: AOJu0YxQFWc4iudk2yvtvs74WGB8PxRL4E6i07ypPMdjC5HnLMsYcXQ6
 u1irwez7d7PkAqW1+GsPts6WoDXIoKYT196SR2MMx5GCm9r89yP7OuHcUHOXfznYv+4uKbBepie
 6Wfy8QWI=
X-Gm-Gg: AfdE7cmw/59k7lyP9b6Hy3Te5+a+BsXr6XYggeNn2LR8M9g27lqkLdS9mRG/yaelPE+
 Z9w/8gxZK84W9KtoeP+fG3zZMrqd8OUz+bmbzEanJKI5hWlf8oSBy81ZivTRgLRnhyKaxh1PbC1
 khKq1uREhfw6hR25Fxmhhcb9HVLweaZ2CSaPC2/ogFXTTPBPw3l+Mgd3sDEq5jH86JA/tOEBk0i
 LyMxzE+apIBDsVI7gci9f2aG5/MGNyvuBCYzeTcb774qIeNPCFevmsKt/rsY0pGdsC6wE06Q6Sz
 1+U+6QAXgoWTYP2tQGDrdq8FUGXD+BaF4eEm384taACbQmMQWCspmxXtBVOzsV6OYFXIV1j3qKY
 f0lJIdOt4tdXFX/ocsYTc/JcwpaEsM1AOmirjeLKoDBnI3OHivOt4oEqkRsSdV2sPH2xMqHVivZ
 S8KNuMcDFfoW6btkf5rgizJ8/OgvSD3NOjenbAuxMN8WcMiFUbH/vooRrYepUNZ/T3MWh/DSvZ6
 3T6/ZfBB7pMXMXFvYsQT2MZSA==
X-Received: by 2002:a05:6870:16c1:b0:43d:3092:cf06 with SMTP id
 586e51a60fabf-456901045aemr2547602fac.2.1784333277037; 
 Fri, 17 Jul 2026 17:07:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-93-175.totalplay.net.
 [187.190.93.175]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568e0be46asm2275893fac.2.2026.07.17.17.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 17:07:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Chintan Vankar <c-vankar@ti.com>, T Pratham <t-pratham@ti.com>
In-Reply-To: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
References: <20260713-am64x_sw_rst_fix-v2-1-3e0df7c88a96@ti.com>
Subject: Re: [PATCH v2] mach-k3: am64x: clear MCU_RST_SRC before reset
Message-Id: <178433327605.1719219.18313937187373613971.b4-ty@konsulko.com>
Date: Fri, 17 Jul 2026 18:07:56 -0600
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

On Mon, 13 Jul 2026 11:07:05 +0530, Anshul Dalal wrote:

> In warm reset, the value of CTRLMMR_MCU_RST_SRC was not being reset.
> 
> This leads to a reset-loop boot failure when a warm reset is triggered
> from the MAIN domain (by writing 0x2006 to MCU_RST_CTRL).
> 
> 

Applied to u-boot/main, thanks!

[1/1] mach-k3: am64x: clear MCU_RST_SRC before reset
      commit: 28d09d6ab68c4a3ac3b95c508a79dabbaa9d3e89
-- 
Tom


