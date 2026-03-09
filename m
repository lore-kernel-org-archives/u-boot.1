Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D545FEA854A
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 03:08:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 585B18063E;
	Mon,  9 Mar 2026 04:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Sa7ZLSKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07785839DF; Mon,  9 Mar 2026 04:08:51 +0100 (CET)
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com
 [45.254.49.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B488080517
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 04:08:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [110.83.51.2])
 by smtp.qiye.163.com (Hmail) with ESMTP id 363091051;
 Mon, 9 Mar 2026 11:08:45 +0800 (GMT+08:00)
Message-ID: <37b24dcd-f75b-4c74-a199-1a7d9a1dacd9@rock-chips.com>
Date: Mon, 9 Mar 2026 11:08:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] rockchip: board: qnap-tsx33: add support for
 Qnap TS233 devices
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-13-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20260114082822.4007128-13-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cd0918cda03afkunm0b6ba77e162d84e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUJDVh9DGUNITRlJTx5DGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
 JLS1kG
DKIM-Signature: a=rsa-sha256;
 b=Sa7ZLSKF7xFMUwu6wxI0+98c3qLzdLGSvvxFFCgMIkFEDGn8OJAl8hV1zGtoegDczF/480KS7+qZ2SyrPB9moGVjozQN0KBOywKb5MAkD6ujvX1qqvLfgqz3LIl/fJWqsDdVmHTg34g9Fs9WaclXJgKSG5EP9e9hQrcxfFv9GN0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=8KFtVTCq9Ruic+EopWYoKOYtX7UeHT1X72VgMnaD8Jg=;
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

Hi Heiko,

On 2026/1/14 16:28, Heiko Stuebner wrote:
> The TS233 shares the same basic peripheral setup for
> SoC, DDR, EMMC, 3 USB-ports, 1G network interface, SoC-SATA ports,
> serial and maskrom access.
>
> It could just share the same U-Boot binary with the TS433, and the type-
> selection would take care of loading the right DTB for the operating
> system. But right now we can't select the correct DTB for inside U-Boot
> itself.
>
> So for the time being, add separate defconfig and documentation for it.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi |  6 ++
>   board/qnap/tsx33_rk356x/MAINTAINERS        |  2 +
>   board/qnap/tsx33_rk356x/board.c            |  4 +-
>   configs/qnap-ts233-rk3568_defconfig        | 85 ++++++++++++++++++++++
>   doc/board/qnap/ts233.rst                   | 37 ++++++++++

checking consistency... 
/builds/u-boot/custodians/u-boot-rockchip/doc/board/qnap/ts233.rst: 
WARNING: document isn't included in any toctree


Thanks,

- Kever

