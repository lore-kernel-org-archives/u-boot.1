Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A256C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 21:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6027987E9F;
	Tue, 23 Jul 2024 23:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TDeoH8wM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C54087E9F; Tue, 23 Jul 2024 23:04:17 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39308841BC
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 23:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5d569902626so1920165eaf.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721768652; x=1722373452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/oNoSVFGuJnkOic0wB+G4kDMmVZFKQeGFVSSxZe/Dw=;
 b=TDeoH8wMGPEZ0PIgdBo6OoUsisvro1tipopMzq1n/Dh1LFsiGdqI0Mcf6CJxym1CC8
 4kBOYoj8XGw4RMAnw2+3j9OGtb9VKpvXRBRUShCCI0oaaZnQYj/ojP4Uphzd0PaeJPBY
 oBPzePiNbkncPLIRL2Go8nj6Xkajd8ozLRIY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721768652; x=1722373452;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S/oNoSVFGuJnkOic0wB+G4kDMmVZFKQeGFVSSxZe/Dw=;
 b=fGSowucO30zqAJkWQEAYpw/Z1zdxQ8GizVb0g1WpW1BIFBFyQbBodqlPLUEZhMGxL2
 HiBE8UyyZ8nttnfHwsMB7facK/xIbIZ4fONWX3lJHjYYUQwvuIpsGypBS3AvpbE0QPtZ
 3+z+7YV5dnFyONqnN/72vMnnN4aS389wyH8tf15z19DiXMMADumvBCaslnxFLgGO+gDn
 oQsq9bJs/dVr/4qgk6QtSt/rGu0+p0Hieb0OfDV1PWK48Od1OmiQe5+533fIAtqQNnWz
 eG09jMh++3yOfMvAr9rO8kDTz6MuAeLqgpz12rgJAAPnrCPpXamt/xZVQk7+1yGNiATI
 uJDQ==
X-Gm-Message-State: AOJu0YwWkUtL1jSthN+6VcCA5z2qKxiu4KCzJS6zhdKDCnl99JMecbMK
 p1ftHxTjuAd9M5wF0DKMJ5NuCivQR/54GQmSzloMlF+O2EVbSMFbs+23s2bOT4M=
X-Google-Smtp-Source: AGHT+IFN5V/r5msh9N5BMwxSjmJCD4ms4hKmtrjuKPdELRtBYTgG2WAqTChkXlRJLkK5STRuaEcJTQ==
X-Received: by 2002:a05:6820:c85:b0:5c4:6068:6ae4 with SMTP id
 006d021491bc7-5d565038c03mr14247361eaf.7.1721768651924; 
 Tue, 23 Jul 2024 14:04:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d59f04938bsm61321eaf.33.2024.07.23.14.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 14:04:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Daniel Schultz <d.schultz@phytec.de>
Cc: w.egorov@phytec.de, t.remmet@phytec.de, d-gole@ti.com
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
Subject: Re: [PATCH v2 0/9] Generalize PHYTEC Overlay Handling
Message-Id: <172176865100.2258489.17653678600653873182.b4-ty@konsulko.com>
Date: Tue, 23 Jul 2024 15:04:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 16 Jul 2024 22:11:25 -0700, Daniel Schultz wrote:

> The overlays are specified in the bootenv.txt file that is loaded into
> the environment. Then these overlays get loaded and applied via a script.
> These scripts for loading and applying devicetree overlays are identical
> for many phytec boards.
> Create a common overlays.env that can be included.
> Add support for devicetree overlays to phycore-imx8mp and include the
> overlays.env for phycore-imx93.
> Rename existing environment variables according to bootstd doc.
> Move MMC boot logic into a common k3_mmc.env file and include the new
> overlays.env file as well.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


