Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB2EA7941
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 18:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E6983B03;
	Wed,  4 Feb 2026 19:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qu7AnvkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E4E83A8E; Wed,  4 Feb 2026 19:41:49 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B76183A36
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 19:41:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d1851d85daso58573a34.1
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770230506; x=1770835306; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHGEywbxBc3dSzCYMbxIg7Lj6NWwVAlWj/hyiEhUszI=;
 b=Qu7AnvkRUh+4gpdOotjBolwVuwlj/KNRjXiw5NgRgIKkXrhDlBrt/ZS+TJj+F5GmWC
 k3mPDjVpz/VCImg0ygAkU1cSDiPJIXHihp36j0tzC43dHliHl6uDs8XPJAKRSmn6EB1H
 Q/HRDRUG4E1GS8A1FkJrhSuC963L8PSxMSYnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230506; x=1770835306;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHGEywbxBc3dSzCYMbxIg7Lj6NWwVAlWj/hyiEhUszI=;
 b=t16ZF7ARICuZUnowiaR+3Hv8nNRc4oJy0UDjcoD239LDzLBGT11frentyrcDYctAPJ
 qAQO4HRxgyVk5lqVrFpMNiAqK/wrX/40wxMVXUEvRpdhDyZMa2d0CQoELZTZKMrNpwtw
 1kIrjjx7wm3OTiVSPsCk1vGDy+KBoA1z0mwD2dRyVLHBJDwTr+GjJtl1Nk44yaINgohi
 9OB056J0ax+PIVBVrcVjmfE0XvfSLgHPBGZpOt6j0uiCKecc8FuWaPRSI5JTdUDan2zc
 jthezG/rC3IsJEGL66Mqz5tJJwMlZSmQbNEgyTo4yaxdCWtRjaU3x7ifATl5EC4w6O0O
 myYQ==
X-Gm-Message-State: AOJu0YyqyIUQvx0MyEpsH16kFEWAoNmfnx4sHm4Qu1blHH9CHCsEUpIR
 aqcK5DU/buX8WsP7EjXyd24ED3SfawFtDMvjDYNgWM6lB9ylONK2v2zRShtknxZ508A=
X-Gm-Gg: AZuq6aKqDxYPR73eDEZ6ALDp+5T/k/J7JAtjQ6JedOX8GE1dykNTf2eiQ2QCtsa/bhp
 H4JpcsAT5J+k0PdiOhBslNdrPy0sMGHL5T+FFHE/keNeo4gCT5FlEEMQG+/u9WX85VrGKzbJf4+
 mzqqxIbZ//C4jwMWNZHKuYy2uVjmsdbVparYLcjqCpehgp/EcEic9niroH/E42avxAy+u/LWk8u
 X2m+eE6GBgZfrn5pqpYY0BMcOmzhLYLh5wF/n+8A5zeMPrgRYr5B2uc+xzpRvbA5WNoTbQQ3x6U
 8GITpyMvAv2h++5e8Ch8SQguiFdUtyYzwz4duXeCozE0A+v0XKlvzsVhGqM9x5+AFx/qs3GxuUs
 VaX1swJBhTi+qwtnEg8RULuIfRpGgX1F+rlylDen5oybTlNF9qXvPUmIf4Cb8lsFOEWLQz3YMJZ
 6vvHuy3upi4u9eeZjc7e+iBJSgH0+3R1N7E/vpIEeZ5vX0SpKbAnuTfuO8v869uOzLvqTxdagIB
 J/5lZ7hRfzLvx82C7YEUu4PiOZP37bqIRg4Sg==
X-Received: by 2002:a05:6820:220d:b0:663:84d:396e with SMTP id
 006d021491bc7-66a23146232mr1716182eaf.62.1770230506272; 
 Wed, 04 Feb 2026 10:41:46 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-66a32bb1049sm1785776eaf.2.2026.02.04.10.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 10:41:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, George McCollister <george.mccollister@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Judith Mendez <jm@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20260130153856.2049575-1-george.mccollister@konsulko.com>
References: <20260130153856.2049575-1-george.mccollister@konsulko.com>
Subject: Re: [PATCH v2 0/6] arm: k3: j722s: add PCIe support
Message-Id: <177023050498.1801114.5061617137375248517.b4-ty@konsulko.com>
Date: Wed, 04 Feb 2026 12:41:44 -0600
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

On Fri, 30 Jan 2026 09:38:00 -0600, George McCollister wrote:

> This patch series brings over several changes from Linux that are required
> to get PCIe working on the j722s and also enables PCIe in
> j722s_evm_a53_defconfig. This allows Linux to be booted from an NVMe drive.
> 
> The J722S SoC provides pcie0 (using pcie_cdns_ti) thru serdes1
> (using phy-cadence-torrent) thru serdes_wiz1 (using phy-j721e-wiz). Changes
> to the three drivers needed to be ported from Linux to enable the REFCLK
> output which is used with this SoC. These changes should be tested on other
> platforms using these drivers by those with the hardware available to make
> sure no problems were introduced.
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] pci: skip unnecessary PCIe scanning
      commit: fbde868ba4aa05d6f04d4969a63e86607f725f59
[2/6] phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
      commit: d7817a20c9e59b6a534403e90417b6910bb4a7cc
[3/6] phy: cadence-torrent: Add support to drive refclk out
      commit: 88e3fcef7ff0ae96eb2a24affd0f074643499381
[4/6] pci: pcie_cdns_ti: Add support to provide refclk to PCIe connector
      commit: 3d07fe1390b352b897683f3eaf7ee62786474144
[5/6] pci: pcie_cdns_ti: Add PCIe support for J722S SoC
      commit: 795b1fd2dff8a8abc464c9f9a85e0b11966bbd1b
[6/6] configs: j722s_evm_a53_defconfig: enable PCIe
      commit: 0cf1b43dbbb317efbdacf144e050e1d4adf886d8
-- 
Tom


