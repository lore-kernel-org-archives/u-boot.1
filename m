Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8ABC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A542587CC2;
	Mon, 12 Feb 2024 14:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ralzus5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36F287CB5; Mon, 12 Feb 2024 14:51:22 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A134187ED1
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 67AA0CE0FE5;
 Mon, 12 Feb 2024 13:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728D4C433C7;
 Mon, 12 Feb 2024 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707745876;
 bh=GWEhZ/u+vfVYczD45WDGEJtmyn0FGdiTJFZB29l0ZO8=;
 h=From:To:Cc:Subject:Date:From;
 b=ralzus5yJFJsZ9t+txE6MFk0vwHWk36HXn9wvER+sKuBLD3nZwjiF6UgRfSNbunG8
 IRI3V3giyjb8UvLbb6LXQAZJWYuj/97spydQIirqBlWJ5C6ceRT0V+WeYBexxBr5O4
 4G6L2oEpkokvbguzLQUh8OnghQpiGKwqoNIWMhBWqgPx5X1V6yxCX5f7YvzaNzjs9P
 z57ceAgGxXjIiqZIEnk66kbvo2iifwQW32SYFl+EJuKScxjdWQjpggoWh4lkPLsLPt
 5ux+fRBS2s8WqYyVKG3UyIA8EAZNyAj/JN0J5K0w0a9Ggve9qyhBg4bFbDrtJriqCk
 Ck3LjYb9v6+fA==
Received: by wens.tw (Postfix, from userid 1000)
 id 0C5895FBEA; Mon, 12 Feb 2024 21:51:13 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Deepak Das <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/5] rockchip: Read cpuid and generate MAC address from
 efuse for RK3328 and RK3399
Date: Mon, 12 Feb 2024 21:51:03 +0800
Message-Id: <20240212135111.1767734-1-wens@kernel.org>
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

This is v2 of my "read cpuid and generate MAC address from efuse on
RK3328 and RK3399 by default" series.

Changes since v1:
- Also imply "CONFIG_MISC"
- Add back unintentionally removed CONFIG_OF_LIBFDT_OVERLAY=y
- Remove ROCKCHIP_OTP from nanopi-r4s-rk3399_defconfig as requested by
  Jonas

This series enables ROCKCHIP_EFUSE and MISC_INIT_R by default for RK3328
and RK3399 so that the cpuid is read from the efuse and used to generate
a serial number and MAC addresses for all boards.

This stacks on top of the recent defconfig update series [1] from Jonas.

[1] https://lore.kernel.org/u-boot/20240207000301.3270722-1-jonas@kwiboo.se/

Chen-Yu Tsai (5):
  rockchip: rk3328: Read cpuid and generate MAC address from efuse
  rockchip: rk3399: Read cpuid and generate MAC address from efuse
  rockchip: rk3328: regenerate defconfigs
  rockchip: rk3399: regenerate defconfigs
  rockchip: nanopi-r4s: Drop ROCKCHIP_OTP

 arch/arm/mach-rockchip/Kconfig                | 6 ++++++
 configs/chromebook_bob_defconfig              | 3 ---
 configs/chromebook_kevin_defconfig            | 3 ---
 configs/eaidk-610-rk3399_defconfig            | 1 -
 configs/evb-rk3328_defconfig                  | 3 ---
 configs/evb-rk3399_defconfig                  | 1 -
 configs/firefly-rk3399_defconfig              | 3 ---
 configs/khadas-edge-captain-rk3399_defconfig  | 1 -
 configs/khadas-edge-rk3399_defconfig          | 1 -
 configs/khadas-edge-v-rk3399_defconfig        | 1 -
 configs/leez-rk3399_defconfig                 | 1 -
 configs/nanopc-t4-rk3399_defconfig            | 1 -
 configs/nanopi-m4-2gb-rk3399_defconfig        | 1 -
 configs/nanopi-m4-rk3399_defconfig            | 1 -
 configs/nanopi-m4b-rk3399_defconfig           | 1 -
 configs/nanopi-neo4-rk3399_defconfig          | 1 -
 configs/nanopi-r2c-plus-rk3328_defconfig      | 3 ---
 configs/nanopi-r2c-rk3328_defconfig           | 3 ---
 configs/nanopi-r2s-rk3328_defconfig           | 3 ---
 configs/nanopi-r4s-rk3399_defconfig           | 4 ----
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 3 ---
 configs/orangepi-r1-plus-rk3328_defconfig     | 3 ---
 configs/orangepi-rk3399_defconfig             | 1 -
 configs/pinebook-pro-rk3399_defconfig         | 3 ---
 configs/pinephone-pro-rk3399_defconfig        | 3 ---
 configs/puma-rk3399_defconfig                 | 3 ---
 configs/roc-cc-rk3328_defconfig               | 3 ---
 configs/roc-pc-mezzanine-rk3399_defconfig     | 3 ---
 configs/roc-pc-rk3399_defconfig               | 3 ---
 configs/rock-4c-plus-rk3399_defconfig         | 3 ---
 configs/rock-4se-rk3399_defconfig             | 3 ---
 configs/rock-pi-4-rk3399_defconfig            | 3 ---
 configs/rock-pi-4c-rk3399_defconfig           | 3 ---
 configs/rock-pi-e-rk3328_defconfig            | 3 ---
 configs/rock-pi-n10-rk3399pro_defconfig       | 2 --
 configs/rock64-rk3328_defconfig               | 3 ---
 configs/rock960-rk3399_defconfig              | 2 --
 configs/rockpro64-rk3399_defconfig            | 3 ---
 38 files changed, 6 insertions(+), 86 deletions(-)

-- 
2.39.2

