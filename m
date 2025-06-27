Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77249C77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 17:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A08082EA5;
	Fri, 27 Jun 2025 19:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1O7q7YM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AB70806D8; Fri, 27 Jun 2025 19:39:55 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD08382E34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 19:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40af40aee93so1554833b6e.0
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 10:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751045981; x=1751650781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Agq5U1/p67QVCS48LkgcRMvqYukd5Dt6ruzwVHj2cNc=;
 b=F1O7q7YMu8+FxMQ5HPdUmZ/X/QnyfP2c8GBj3heMAmnc7ahH8Mk4y31vkmMm76kJ2B
 30PAfJJ8jwslnXXR6IlD4Ex3yacgl1yf1u7lnQDc1UcJbqlKCvyb8Pp3Ro55yzsZq2Kt
 pJygPu1EJMd28NPUd0ZwG/1qpQ1BXQtfmeKyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751045981; x=1751650781;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Agq5U1/p67QVCS48LkgcRMvqYukd5Dt6ruzwVHj2cNc=;
 b=f5OYXWItSrg8z2rd6/93WzavhX1DimRMNRSKTVQp0dfnZubTKjH/L3yVjjE/Pss62B
 CK7Xl+E5S/JX4ekCOZuQoTYFfSK2inJ2zzhwWdWUZ0Li5szZd4AkjD606nq/4lD9/Co0
 PrI3N+ys3/Vst7BPyvbW9FG5MWG4z9/z3JicjkbWnxeW2GhvIqrnGEzHwCUU5y3YqNjN
 ZaA8Oq42T3JBHqgHWBkJ0s3oi/xweUSgCMV6FJoQcs/pc8rdlEZDt9v2mCFrPEHAOHkG
 iupjodyUgsgkU40GYr/DrpybGQiWxV8LfcxqMQGg8F4Qc6wucDX1X9uTBJHYGgHZIN62
 3M9Q==
X-Gm-Message-State: AOJu0Yy3j0h+3LnW6rjDsA5aEaQOhjJU97M1BH+tJGSrnivDE5O/wkfO
 5EHZ0nhUJmlSsoGhyJtB3TaPx5hi6uRDhZYjVfBLO2ReMF/s5oPcWSkzjZwrRuwPoVs=
X-Gm-Gg: ASbGncv3QvKDU6vGUBiSw4MrVn7tAhEzRWfYWKNodizRTB6hs/OksBbvDON6y7Gm7w3
 0gDVQGPNR9xFsty+fu5peTDXPNt3YmbkfQgEpgQ59l03CN+tyv6e51VDtdqP2yb6PANh5Cy0ycK
 UcVZBALaO7tmY+V+28p+ZOGMFOe6QqrA+jlbTEXK2xccXm8F+4hZl4xFO6qgZOYRY9d0yYFP5aS
 dHdCgPpYh6+9NXZehS0rAaLNqqDh1hucGBqX0hBMP8t6ArwhVz4B/eDpxOdSUa0OMRlu+ryx6FS
 0GTyzgDwHgMwNX8pMBTrKUsx0jRjwkMxQpy5vEIFZ4I/NwkJ+z70FGDZx9wWNd2YRMPzzBCK5TV
 oONBV+PYCSiMIqUAF9+RN+A==
X-Google-Smtp-Source: AGHT+IHupxBlolOGkNTBwv8JvnjDlYctBYQ3GusvK5B5A7o+Gcy4rJ/RDvoO8E+UsukOCfz0TFjfAw==
X-Received: by 2002:a05:6808:23d2:b0:401:e6f0:a8d4 with SMTP id
 5614622812f47-40b33c60e48mr2730306b6e.5.1751045981542; 
 Fri, 27 Jun 2025 10:39:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b322b5900sm442246b6e.18.2025.06.27.10.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 10:39:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Crispin <john@phrozen.org>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot-amlogic@groups.io, 
 u-boot-qcom@groups.io
In-Reply-To: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
References: <20250617081641.8385-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] drivers: pci: pcie_dw_common: Add
 dw_pcie_link_set_max_link_width()
Message-Id: <175104598026.3877702.9668053267112408385.b4-ty@konsulko.com>
Date: Fri, 27 Jun 2025 11:39:40 -0600
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

On Tue, 17 Jun 2025 10:16:27 +0200, Marek Vasut wrote:

> Add dw_pcie_link_set_max_link_width() implementation ported from Linux kernel
> as of commit 89db0793c9f2 ("PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling").
> This is common code which is already duplicated in multiple drivers.
> 
> 

Applied to u-boot/next, thanks!

[1/6] drivers: pci: pcie_dw_common: Add dw_pcie_link_set_max_link_width()
      commit: 4600b59568339602ef0c95377cc64f561132ebea
[2/6] pci: pcie_dw_meson: Use dw_pcie_link_set_max_link_width()
      commit: a83def86152d24cf22601844fc922593ad42492b
[3/6] pci: pcie_dw_qcom: Use dw_pcie_link_set_max_link_width()
      commit: 579ac25b175ae1c7dc46057022fff7e877b3e5b7
[4/6] pci: pcie_dw_rockchip: Use dw_pcie_link_set_max_link_width()
      commit: 17b5e8acfc93fd21371b694cc9e9951464d49d72
[5/6] pci: pcie-rcar-gen4: Add Renesas R-Car Gen4 DW PCIe controller driver
      commit: be3dd0dc2fd9020fa19cd96ea82753315f4084b0
[6/6] arm64: dts: renesas: r8a779g3: Enable PCIe/NVMe on Retronix R-Car V4H Sparrow Hawk board
      commit: d7c11487902127240be684174334a1b8ccebac03
-- 
Tom


