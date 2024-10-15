Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D343D1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18F088966;
	Tue, 15 Oct 2024 21:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dmiFZy5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63654889AA; Tue, 15 Oct 2024 21:43:55 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504DB8888F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b10f298052so281188785a.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021432; x=1729626232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7Rc6GpVKFjQgQnREq+9XbHqjq5ZVl3Oi43GzOTQvKE=;
 b=dmiFZy5SwfPAk8Yt9pUTi+c1x6f+JerE8muDREdujDhA/j9Vdm27dm7rjU2xFfLi1n
 4HnC5O3muCzJZndqRCvzBtTeZs92PNBVIo4OkT8OwlPZo/mtFP9e+BlNLdqNwVyX5pTi
 Fbe5NuvyuDLmvGfBNLmpVLI9UlhBf91W7XiGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021432; x=1729626232;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7Rc6GpVKFjQgQnREq+9XbHqjq5ZVl3Oi43GzOTQvKE=;
 b=TfKyQGgrPXPkDGtt6gcbvPNeqDvOvZK0inmJfwhFJG9J9r+S48SuXW4X7cuNx6i7x/
 s6de3c4rfeCmewqLi+yeDW5lCBziPYEB95KeZPYIKD6Ra7BtJYqlW6VqyWu4XjzewjUT
 yQJ4y67ETOGsTL+DhQq8ENBgJRumXjlNBlp4fSDFn4pdCrtybnRGCbA7A2hmIOIAsb/2
 ch22wk6ovg/RuvBAvcjVTVi11k9OzXYdy4FgxSjDpL7rOxcTlBFWV2PrFztQDgmDdV/1
 uKXjaNerpjE/75go8rwD63WxmWdseXZfqKDNEEzUKbNnQfupbZgiGamKjYSmuh2ZMKMS
 32sw==
X-Gm-Message-State: AOJu0YxOzbOKTJbgcs048emvcEcF2Mt084f/GqfJX3N+JQmd0XOYxdmN
 rKaOEtXXWTZzChnW8hK/2pBkBA9dlDPZvrgLrhXOXAd3wSAomxOyl27OpGu1bN0=
X-Google-Smtp-Source: AGHT+IHq3890hvXnynv48LNWgJlwdNmBSzKxE4apMaN/gDG294haA/oQDjNOEPzIKtMPrfa1vhhGsA==
X-Received: by 2002:a05:620a:410c:b0:7a9:d115:90eb with SMTP id
 af79cd13be357-7b141875854mr216977285a.52.1729021432021; 
 Tue, 15 Oct 2024 12:43:52 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:43:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241008191834.2190270-1-jonas@kwiboo.se>
References: <20241008191834.2190270-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2] Revert "mmc: dw_mmc: Extract FIFO data transfer
 into a separate routine"
Message-Id: <172902143072.5381.2358206146998588625.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:50 -0600
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

On Tue, 08 Oct 2024 19:18:31 +0000, Jonas Karlman wrote:

> The commit 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a
> separate routine") unintentionally changed behavior of the FIFO data
> transfer routine.
> 
> When data is read and size reaches 0 the original loop would wait on
> DWMCI_INTMSK_DTO or timeout. The remaining size to read and buf position
> is no longer tracked across dwmci_data_transfer_fifo() calls and because
> of this an extra call to fifo() and dwmci_fifo_ready() may now trigger a
> FIFO underflow timeout error and slows down FIFO reading.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


