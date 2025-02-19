Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0A1C021B0
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 15:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DB2801BE;
	Wed, 19 Feb 2025 16:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="HbEWi117";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7C60807C4; Wed, 19 Feb 2025 16:18:49 +0100 (CET)
Received: from mail-m155106.qiye.163.com (mail-m155106.qiye.163.com
 [101.71.155.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3824800D7
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 16:18:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [120.36.72.169])
 by smtp.qiye.163.com (Hmail) with ESMTP id b8f93a79;
 Wed, 19 Feb 2025 23:18:40 +0800 (GMT+08:00)
Message-ID: <4c88e6f2-6eb7-41ba-8a6d-361f4e74b033@rock-chips.com>
Date: Wed, 19 Feb 2025 23:18:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1
 hw revision
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250204213848.885712-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250204213848.885712-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQx1IVkJCTENJGUNJGB8ZTFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUtVSE1VTElVSk1CWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a951eca292103afkunmb8f93a79
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Ejo4FjITTi4RAkkMTSgL
 NB1PCiNVSlVKTEhCQkxDSElLTEJDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKSUtVSE1VTElVSk1CWVdZCAFZQUpKSU03Bg++
DKIM-Signature: a=rsa-sha256;
 b=HbEWi1176mQzeM9awyNDEZypkuC5ferW/TxZiAdsKtmjm9PgJMgFoz0FCT9RFrjzAQTk4wxYAmx0OPxT8s7Fws2ppiGziANAnMtXe/yM/k1UFK8V1nWu5pioRBRvcwYn+v29+AwDRSTuU0a6iPxtduC70myxmEqb3MGbPReiTic=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=67ZWuf2nhzpsDQjvqDkHM8qihgPhGaLcWmy8nG8JKlM=;
 h=date:mime-version:subject:message-id:from;
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

Hi Jonas,

     I'm not able to apply this patchset on top of master, maybe need a 
rebase.


Thanks,

- Kever

On 2025/2/5 05:38, Jonas Karlman wrote:
> Radxa ROCK S0 HW revision prior to v1.2 must pull GPIO4_D6 low to boot
> from sdmmc.
>
> This series pick a device tree fix that has landed in Linux v6.14-rc1,
> include required nodes in SPL and enable required Kconfig options to
> fix the sdmmc boot issue on HW revision v1.1 boards.
>
> Changes in v3:
> - Pick device tree changes from devicetree-rebasing v6.14-rc1-dts
> - Drop sdmmc_2030 and vcc_sd nodes from board u-boot.dtsi
>
> Changes in v2:
> - Rebased to fix clean apply on master
> - Collect r-b tags
>
> Jonas Karlman (2):
>    arm64: dts: rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards
>    rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw revision
>
>   arch/arm/dts/rk3308-rock-s0-u-boot.dtsi       | 12 +++++++++
>   configs/rock-s0-rk3308_defconfig              |  2 ++
>   .../src/arm64/rockchip/rk3308-rock-s0.dts     | 25 ++++++++++++++++++-
>   3 files changed, 38 insertions(+), 1 deletion(-)
>
