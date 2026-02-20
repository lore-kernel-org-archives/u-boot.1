Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E95BC5ACD4
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 16:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E6CB83D3D;
	Fri, 20 Feb 2026 17:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BujE6PqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112F583AC5; Fri, 20 Feb 2026 17:19:37 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF42A83CF5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 17:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-66f3e7d9eccso1184150eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 08:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771604374; x=1772209174; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwDT4mN8URlNxTA2XWbqyEcC4PLfIRmYYmca19areek=;
 b=BujE6PqYeXmRcNJ9Gjd3hRsyeJx6AXymSO3puyIXARzollEpgTb+ReqL1uAX1i75Nc
 Tq3LvC+w9skBdhHCJnc+e+lm52O88111XoqVQxYJA/Z2R7nCKE61pxcwX8uSaZ6cfijX
 jZrYIEI4eEk6pnk1B2pIJCgWG8aKZGzmr9YaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771604374; x=1772209174;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IwDT4mN8URlNxTA2XWbqyEcC4PLfIRmYYmca19areek=;
 b=UI/TPe02dfMGNH2dZfwUdtha0h70QloyaRiePCeure2T9ErvRqXo0R8ccYrgbaQnR9
 yxjSn2jIzyKXWF2Qhbm8tyVFKpWoqPOpXOCn+ZdBJzss90VP7EvY4ME+LgIG34LlVgEu
 VVOYGpnlAgq+09btqWuaRwvLs9zqkZNMBMtcDlLtU3qjxcwGUY/tz39gi6DrlM9obc7v
 Y3xeucv81sXEkQWSg4kR8kZn4diaFlH0dqKTLtaGlyZXlSzIguXLuewH6Fk7GtzU3Cp+
 G9fwir4oOQXQ26to4PpegT1PE4SbAmp60BhT+CxB874fXOuufq0jQZIm3OsnCTZDKdfr
 mGnA==
X-Gm-Message-State: AOJu0Yx8kHLElTfjYTcQJ/hZTray9HW7jpeck9dSIfL5H+PS5MSGE2IX
 Z6CyTQ/lxC7C7eAQhSFruH6RXtroUoD83I2Ue+2l9HVq7tp4Vg18v5SfM12y77SCZ/I=
X-Gm-Gg: AZuq6aKJN1MeT/evvu0U4fbEi60wvUitLRsv560UvzWoqJ9KAKWJgXvbeZvSODhzYb+
 R3gHo4QacjYse5rf7zkiUsSJhyHoB7tS/jeLuivDCDup7sgGfAQ2xE5h3He09RuDABtgmupsFkH
 qZkRmmejvFikgVLfEYGUVxHCzbN5mC1dV7lAGiPhYbGRruZdKBoMzpuULCmfVZTk/ttN8j2GpSt
 aiXm8sify4dFbOsOV7wRb/hJmYXfZ+d2/Dw2x56V7+PbgqB3xQQlq0hJe6B+JnVxQfEFzQMXS3Y
 E+qzI2Ye7B0YHPv9DaXNlVaCNqvvgfswNa20Ba3mnOaspjUjDwmtaQRBu0xd0cNs7eq+oJIzl2r
 nIuypXmGCAbhC6w2iRHzurqjeN0osE8O0j4utOxiXcZ42my7wPXqUoAdUtfSTThS6fACG/ouTyt
 QsJGSwPVOWfq2RKu7VNpAgmTSJ4dM7pzMyeD84r9Ni0o6wxN6iXW6FVUJxgojKAJ75n2dGWLYyR
 QOA6pmoReZ2UbPLlypNVgTMCN7xzdNEmRmtY/4YuDKp3H6UZw==
X-Received: by 2002:a4a:e909:0:b0:679:8861:f58c with SMTP id
 006d021491bc7-679c45080c7mr201224eaf.39.1771604373676; 
 Fri, 20 Feb 2026 08:19:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-676f444f315sm15499304eaf.1.2026.02.20.08.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 08:19:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, Dhruva Gole <d-gole@ti.com>, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
References: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
Subject: Re: [PATCH] board: ti: am64,j721*: use correct fdt if eeprom
 detection fails
Message-Id: <177160437258.83679.696756989288534929.b4-ty@konsulko.com>
Date: Fri, 20 Feb 2026 10:19:32 -0600
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

On Tue, 03 Feb 2026 15:30:20 +0530, Anshul Dalal wrote:

> We currently provide default board names for each board in their
> respective evm.c file. However for custom boards, this behaviour
> overwrites the default DT as set in the defconfig
> (CONFIG_DEFAULT_FDT_FILE or CONFIG_DEFAULT_DEVICE_TREE).
> 
> This patch changes the default name to be NULL which prevents this
> overwrite and allows ti_set_fdt_env to instead fallback to the correct
> DT as set in Kconfig.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: am64,j721*: use correct fdt if eeprom detection fails
      commit: 30b8c03d8c8f500b3e4cc51f7b7abf573180ea51
-- 
Tom


