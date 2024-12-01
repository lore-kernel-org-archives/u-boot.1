Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE4AD49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D94D8960E;
	Sun,  1 Dec 2024 17:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ho/bd+id";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831A189491; Sun,  1 Dec 2024 17:13:23 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57DB0896E4
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:13:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-724e6c53fe2so2463332b3a.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069599; x=1733674399; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JV0iehQ/fcKcgLDDz4WRVP+2gJnwuWSdtpiPc1w/pAM=;
 b=ho/bd+idc6Bnfn0+3OM7u2zlBto7C0gu+C9v34uvynegl9tUig1IF4LTAqyjCTLIFj
 7wpKk+rzdFtm4Si1scrJJrd9Lw5TPstc4tq0mG1/EZxtrwFWabqKGWhyA7+0sof+aROG
 UwVZlMWMT1rTVymybUYd52LNs/4aLGrF6tuhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069599; x=1733674399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JV0iehQ/fcKcgLDDz4WRVP+2gJnwuWSdtpiPc1w/pAM=;
 b=wF1dodESJeBu9/iOiKvyIrNnENpXooEgkgJ/NiUhHt5D6Vaa8y0JPEchFDJrYVchPf
 EUn6GpCt/8v/rWAAJHi8KFLZVFjmZb05i7yim08XcnxzUnLFVBhudKHXe9BWTL7sTlZo
 Xx8QUbT/R8tImVZfKTp5ML5sAFgKEVifzOJk78lnAPDHc8G0zJtDMb7/ugo2sTCe2qBb
 VaZDeIjn2ZTTarVjgbXN9c5PoAPrArW+nNvpmP+sIiDl5GlL0eUWUAyaNNjlhCLuYQBZ
 8LUIlN/pdX4KPuGNucE3I3GBgOCnZYkhr8wpXIravc9915dJwSwqSY3c8fELEiGs8U1K
 4aig==
X-Gm-Message-State: AOJu0YxYmguxuIRSTcuS2DcSY2sasV9H/W5RVHHwoW5tsrm6zUv3dz3W
 tGuhLI96E3N1agGMMpawYtmM9pgsgH4pV+6OO2G5tn8cJZXl9X6/lwu9wr5hJnfcpWBomJabUME
 pMV/vdaH6oJOyCWRNxoOpq5MhKB/HuX0vQEbf
X-Gm-Gg: ASbGncu1TXwrfspKn7smHo3anM9qo8IC8uof06u8ZhK6KustB13ofkbeMWDMJ1pFvDD
 Rd9RciSTbIyWPN/Vz2nm2DNvAkjK/vA==
X-Google-Smtp-Source: AGHT+IEAGJfJWFTErCywkWm6+K4mvsP897mDMSCzt3gGnNwcMzXhCrIHLPAQkzKyTNmpMbqnt7+xUIvl2thDSuP29yk=
X-Received: by 2002:a17:90b:1d11:b0:2ee:8008:b583 with SMTP id
 98e67ed59e1d1-2ee8008b80bmr9626350a91.16.1733069597493; Sun, 01 Dec 2024
 08:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-6-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-6-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:12:44 -0700
Message-ID: <CAFLszTjCwT9+4KskDDjBYGB=04OTq5BwSyHBG+_Q-s=us_eGow@mail.gmail.com>
Subject: Re: [PATCH 05/10] Add EFI network driver
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Gabor Juhos <j4g8y7@gmail.com>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Romain Naour <romain.naour@smile.fr>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> Add a driver that makes use of the UEFI Simple Network Protocol to
> support network access when using the UEFI app implementation, and hook
> up the app code to instantiate it for probed devices.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  drivers/net/Kconfig    |   7 +++
>  drivers/net/Makefile   |   1 +
>  drivers/net/efi_net.c  | 110 +++++++++++++++++++++++++++++++++++++++++
>  include/efi.h          |  12 +++++
>  lib/efi/efi_app_init.c |  67 +++++++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/net/efi_net.c

Reviewed-by: Simon Glass <sjg@chromium.org>

You don't need to include config.h anymore
