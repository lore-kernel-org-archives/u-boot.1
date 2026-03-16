Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D8FF53D6E
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 16:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D9384106;
	Mon, 16 Mar 2026 17:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EsHZwGhF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83CB84118; Mon, 16 Mar 2026 17:34:52 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBF2840E0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 17:34:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-67bb3a6c6f3so2967626eaf.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773678889; x=1774283689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMca+iGKD/I/A82XWMM+slqt9Zf/852navkbd7YjT68=;
 b=EsHZwGhFWYLWVfqzGco6djlEg32Zscew5jY058r8J2Nx7t31jmjYc4Kwx+G8N2RXeX
 9trU20hxy0TS1XrRci4UjxJrI/hm/wLHCNO5wOL6cP+hxJEpzSHCnNk1At9A5UZbFmlw
 gbzxu1ycHiLIbEIh/2BQrTi6qnQ3BXhdcjbGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773678889; x=1774283689;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IMca+iGKD/I/A82XWMM+slqt9Zf/852navkbd7YjT68=;
 b=amHwRs09FvV4tEE9Lv4qPJiM4ApyG6B5xEjt6ehApGBXfunaMlDKX73RtzpnYNo8sS
 +kHXxgdYYdGcEo9akS1/rogNuD5lzoO/f4ZaTl/IZyqkKyWuMVhklfSLwrsO9Tot1qBU
 ZrXeDU+wqx+9rAi4VZLhC3p1JiLouSsnsd31ONM23Ua6xL7tmwjIj9aUFDvsJRcf4eOV
 nZqBdBz4gAP+CwXFusCzr0r7sX9beCSTrWLbX+X3cDOnHqZeWCg1NMEte2amXPvcUhKy
 vPOixBrosVIMrUO2NjRbRthy6XyPjPzFIIM/9mrdQjBwDga376BXzO7V6qBDLPAq2MOq
 wZDA==
X-Gm-Message-State: AOJu0YyyA8tUnk+QtMp5nTOd1d7gZpcJXYeZckJ7qFNNbxVaEnHa7Bnq
 az9YjzTiWwFrYDDA0zjmVkbuhI5i/ycgqJa4F/sE03TFZntC43BSyw5vTQdc/Unric8=
X-Gm-Gg: ATEYQzx0xiK9KI8JTOE5T3ZhTIAtODXO6wWK6/SW5YCgzcO33N5YASAE+igfmUDCMEw
 TZBjhaKR+VIOuPzI1tVC02oBZtZEfx98IoYhgwxQBssmnJGO/8woTA7PxS38AuerScELwSqIWs9
 kywIL4NICApDBDoViHeek2Soh1k6nAsyNVcX5CumkN4u3W46bYvF6M3AKujLG/SB/Xu7PVkQ+45
 cVQNAjrfN/3EyT9RcNtYNvMN8L8biY/7L8VrPqx653JcyKNsjq8l0TREmTI6Z4yTcIp1S5DRXTR
 Nvw6oKnWpZv1Xxd51SSaAOemnhJANv42XIqwHk5trVi/PNRiW3ElX9wRsjGNNNtxcHi/u53Xbih
 NCsSDiNioYY7LME1HQlZwXN0uGSRSCBBgiR1xgEA0M9XFHMccTJx1Z9mDwFmU+M9jJwW+5KQgxQ
 gNezK4xmKQ7Bdd0wqYTO79xHnsdN6rLJlkpzeTy+7F0dfDFqXEpWzBVICDXJVhgWpT9V5kgQwE+
 1HxX2hZO2C6h75GNk6v4U0lnvFKhGo1wHxKYgmzam5IcVc=
X-Received: by 2002:a05:6820:2288:b0:67b:f37d:1e6a with SMTP id
 006d021491bc7-67c04953318mr116426eaf.8.1773678888942; 
 Mon, 16 Mar 2026 09:34:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc91174fbsm9660143eaf.4.2026.03.16.09.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:34:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: m-chawdhry@ti.com, c-vankar@ti.com, neil.armstrong@linaro.org, 
 marek.vasut+renesas@mailbox.org, u-kumar1@ti.com, j-keerthy@ti.com, 
 semen.protsenko@linaro.org, afd@ti.com, anshuld@ti.com, peng.fan@nxp.com, 
 ahalaney@redhat.com, mkorpershoek@kernel.org, n-francis@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v5 00/10] Add PCIe Boot support for TI J784S4 SoC
Message-Id: <177367888764.2244648.17971723758371253024.b4-ty@konsulko.com>
Date: Mon, 16 Mar 2026 10:34:47 -0600
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

On Mon, 16 Feb 2026 15:58:28 +0530, Siddharth Vadapalli wrote:

> This series adds PCIe endpoint boot support for the TI J784S4 SoC.
> Series is based on commit
> f9ffeec4bdc board: toradex: Make A53 get RAM size from DT in K3 boards
> of the master branch of U-Boot.
> 
> v4 of this series is at:
> https://patchwork.ozlabs.org/project/uboot/cover/20251201110103.845413-1-h-salunke@ti.com/
> Changes since v4:
> - Addressed Udit's feedback:
>   i) Patch 6 has been updated by limiting changes to disabling CONFIG_SPL_PCI_ENDPOINT
>      and CONFIG_SPL_PHY (CONFIG_PCIE_CDNS_TI_EP, CONFIG_SPL_PHY_CADENCE_TORRENT and
>      CONFIG_SPL_PHY_J721E_WIZ don't need to be disabled as pointed out by Udit).
>   ii) Commit message of patch 8 has been updated to indicate that although PCIe Boot
>       is supported in Hardware for J742S2 SoC, it is not yet enabled in Software.
>   iii) Documentation in patch 10 has been updated with complete set of device-tree
>        changes included and the C Program to transfer bootloaders has also been
>        simplified and documented with the usage of appropriate variable names.
> 
> [...]

Applied to u-boot/next, thanks!

[01/10] arm: mach-k3: j784s4: Update SoC autogen data to enable PCIe boot
        commit: 0d5ddcc50b2900ddcbb32685525ad8ab60c696e8
[02/10] phy: cadence: Add config to enable Cadence Torrent PHY at SPL stage
        commit: 2a21f48771a2f4f0f05d9c76517212ffb94f3c35
[03/10] phy: ti: Add config to enable J721E WIZ SERDES wrapper at SPL stage
        commit: 35e1083fb930ba1fa3a3c5cd139bf8285043c191
[04/10] configs: j784s4_evm_r5_defconfig: Enable configs for PCIe boot
        commit: d83eefab8cfd58b8e4259734b2e19b30a8659461
[05/10] configs: j784s4_evm_a72_defconfig: Enable configs for PCIe boot
        commit: 3c28bf7719130158c2acd86c45df95262b6b8fa1
[06/10] configs: am69_sk_r5_defconfig: Disable PCIe boot configs
        commit: 014d9c5ac348cd7d11aa991df466b47428487c86
[07/10] configs: am69_sk_a72_defconfig: Disable PCIe boot configs
        commit: af3800c83dc216e8d3e951cfced7c7c27ee88530
[08/10] configs: j742s2_evm_r5_defconfig: Disable PCIe boot configs
        commit: 2abd957503eb423cc30535e6e20c2b113653f5a3
[09/10] configs: j742s2_evm_a72_defconfig: Disable PCIe boot configs
        commit: 078200f1ee1857d5a1be0c53313e9e4e6ce2a4a3
[10/10] docs: board: ti: j784s4_evm: Add PCIe boot documentation
        commit: 6230a595a733e381ecdbe35199d255f3d5801955
-- 
Tom


