Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0D7C4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 06:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A05C87E90;
	Sat, 10 Feb 2024 07:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RQmy4pCy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9434387E93; Sat, 10 Feb 2024 07:33:01 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AED87E8E
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 07:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 22CFA60670;
 Sat, 10 Feb 2024 06:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ED6C433F1;
 Sat, 10 Feb 2024 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707546776;
 bh=XvjJaoWG+F/Z1LFoehMSJsO52tjyVyfAhwUT/oYYMAc=;
 h=From:To:Cc:Subject:Date:From;
 b=RQmy4pCypTb/3gbgKXJLHkXMqrddfhbaEylXbMCjtoh3XGxsinKR69/sMkvOeidJo
 zlnMUj9391h/p+7+xNuHWNW+Om1nmQk8WEeX2GUh8ibdWbz8aSX3/qMvLVH+NdPhyO
 JWQ886j85eHJUd1b+hLwRCUCZPQdBnwdSelIwt9r7rGYfeCX3CC+MTvuIPiL25YwXp
 mliZ/Xb/Xg/chNM0soNOPflcKekdV+cResULbFz3EeScEmCRPgAgjWFLfWGa7XAGI8
 ATwBm4oWLbDWo8JTY7KUzqH2XgUicGtLxATHWwmJt8Z0YzkBglsYcLqB7eY1NRgxC9
 cBlVClg3vgazw==
Received: by wens.tw (Postfix, from userid 1000)
 id 9637A5FB5F; Sat, 10 Feb 2024 14:32:53 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/4] rockchip: Read cpuid and generate MAC address from efuse
 for RK3328 and RK3399
Date: Sat, 10 Feb 2024 14:32:46 +0800
Message-Id: <20240210063252.1065611-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chen-Yu Tsai <wens@csie.org>

Hi folks,

This series enables ROCKCHIP_EFUSE and MISC_INIT_R by default for RK3328
and RK3399 so that the cpuid is read from the efuse and used to generate
a serial number and MAC addresses for all boards.

This stacks on top of the recent defconfig update series [1] from Jonas.

[1] https://lore.kernel.org/u-boot/20240207000301.3270722-1-jonas@kwiboo.se/


Chen-Yu Tsai (4):
  rockchip: rk3328: Read cpuid and generate MAC address from efuse
  rockchip: rk3399: Read cpuid and generate MAC address from efuse
  rockchip: rk3328: regenerate defconfigs
  rockchip: rk3399: regenerate defconfigs

 arch/arm/mach-rockchip/Kconfig                | 4 ++++
 configs/chromebook_bob_defconfig              | 2 --
 configs/chromebook_kevin_defconfig            | 2 --
 configs/evb-rk3328_defconfig                  | 2 --
 configs/firefly-rk3399_defconfig              | 2 --
 configs/nanopi-r2c-plus-rk3328_defconfig      | 2 --
 configs/nanopi-r2c-rk3328_defconfig           | 2 --
 configs/nanopi-r2s-rk3328_defconfig           | 2 --
 configs/nanopi-r4s-rk3399_defconfig           | 2 --
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 --
 configs/orangepi-r1-plus-rk3328_defconfig     | 2 --
 configs/pinebook-pro-rk3399_defconfig         | 2 --
 configs/pinephone-pro-rk3399_defconfig        | 2 --
 configs/puma-rk3399_defconfig                 | 2 --
 configs/roc-cc-rk3328_defconfig               | 2 --
 configs/roc-pc-mezzanine-rk3399_defconfig     | 2 --
 configs/roc-pc-rk3399_defconfig               | 2 --
 configs/rock-4c-plus-rk3399_defconfig         | 3 ---
 configs/rock-4se-rk3399_defconfig             | 3 ---
 configs/rock-pi-4-rk3399_defconfig            | 3 ---
 configs/rock-pi-4c-rk3399_defconfig           | 3 ---
 configs/rock-pi-e-rk3328_defconfig            | 2 --
 configs/rock-pi-n10-rk3399pro_defconfig       | 1 -
 configs/rock64-rk3328_defconfig               | 2 --
 configs/rock960-rk3399_defconfig              | 1 -
 configs/rockpro64-rk3399_defconfig            | 2 --
 26 files changed, 4 insertions(+), 52 deletions(-)

-- 
2.39.2

