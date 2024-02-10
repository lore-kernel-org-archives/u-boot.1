Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD5EC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 09:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F9887EA7;
	Sat, 10 Feb 2024 10:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eW9WgvMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102B787EA8; Sat, 10 Feb 2024 10:06:07 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB49E87E90
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 10:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris.obbard@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1707555962;
 bh=/8aNqIJJcfVgr5I4URUpgO77LVooeu1QSSU1Vcm7s9Y=;
 h=Date:From:To:CC:Subject:In-Reply-To:References:From;
 b=eW9WgvMXubFBXE/iT4qsj2ehwh66uAtx8Zq7bOzJFs9EKqmwv0QekemPXrLd55v0U
 mxz5uSrJwjFL86axChGpJ1ut5LJu7fSVj6myhu9NlsCWt48Eafzr5lt4oF3zlFaVlQ
 /9gRPb1BuxaBPK/3S6gf/Jtt0f3kwC6WeAXchYFDFyWPLeFKBr/HhtwPkpIU17m1Qg
 FjkQqNw+NKXUyDEKIc6Fu+c3BsE5eymOA/chX/ILFW2LpBiuoL9XOT6LXF6axigIAK
 ujDraC34tC/x0mZixL82TDV7YAhVVeAktf1njNotKhynX2MPLplXo5I0Ts2bwH1ODk
 7O3WGyx/QsSDg==
Received: from [127.0.0.1] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: obbardc)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8D86637810F1;
 Sat, 10 Feb 2024 09:06:02 +0000 (UTC)
Date: Sat, 10 Feb 2024 09:06:01 +0000
From: Christopher Obbard <chris.obbard@collabora.com>
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
CC: Chen-Yu Tsai <wens@csie.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>, David Bauer <mail@david-bauer.net>,
 Xiaobo Tian <peterwillcn@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Loic Devulder <ldevulder@suse.com>, Jonas Karlman <jonas@kwiboo.se>,
 Levin Du <djw@t-chip.com.cn>, Suniel Mahesh <sunil@amarulasolutions.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/4=5D_rockchip=3A_Read_cpuid_and_genera?=
 =?US-ASCII?Q?te_MAC_address_from_efuse_for_RK3328_and_RK3399?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240210063252.1065611-1-wens@kernel.org>
References: <20240210063252.1065611-1-wens@kernel.org>
Message-ID: <6B0793F6-D4F6-4AA2-9416-B9BD8C0A7C00@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Chen-Yu,

For the entire series:

Reviewed-by: Christopher Obbard <chris=2Eobbard@collabora=2Ecom>

On 10 February 2024 06:32:46 GMT, Chen-Yu Tsai <wens@kernel=2Eorg> wrote:
>From: Chen-Yu Tsai <wens@csie=2Eorg>
>
>Hi folks,
>
>This series enables ROCKCHIP_EFUSE and MISC_INIT_R by default for RK3328
>and RK3399 so that the cpuid is read from the efuse and used to generate
>a serial number and MAC addresses for all boards=2E
>
>This stacks on top of the recent defconfig update series [1] from Jonas=
=2E
>
>[1] https://lore=2Ekernel=2Eorg/u-boot/20240207000301=2E3270722-1-jonas@k=
wiboo=2Ese/
>
>
>Chen-Yu Tsai (4):
>  rockchip: rk3328: Read cpuid and generate MAC address from efuse
>  rockchip: rk3399: Read cpuid and generate MAC address from efuse
>  rockchip: rk3328: regenerate defconfigs
>  rockchip: rk3399: regenerate defconfigs
>
> arch/arm/mach-rockchip/Kconfig                | 4 ++++
> configs/chromebook_bob_defconfig              | 2 --
> configs/chromebook_kevin_defconfig            | 2 --
> configs/evb-rk3328_defconfig                  | 2 --
> configs/firefly-rk3399_defconfig              | 2 --
> configs/nanopi-r2c-plus-rk3328_defconfig      | 2 --
> configs/nanopi-r2c-rk3328_defconfig           | 2 --
> configs/nanopi-r2s-rk3328_defconfig           | 2 --
> configs/nanopi-r4s-rk3399_defconfig           | 2 --
> configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 --
> configs/orangepi-r1-plus-rk3328_defconfig     | 2 --
> configs/pinebook-pro-rk3399_defconfig         | 2 --
> configs/pinephone-pro-rk3399_defconfig        | 2 --
> configs/puma-rk3399_defconfig                 | 2 --
> configs/roc-cc-rk3328_defconfig               | 2 --
> configs/roc-pc-mezzanine-rk3399_defconfig     | 2 --
> configs/roc-pc-rk3399_defconfig               | 2 --
> configs/rock-4c-plus-rk3399_defconfig         | 3 ---
> configs/rock-4se-rk3399_defconfig             | 3 ---
> configs/rock-pi-4-rk3399_defconfig            | 3 ---
> configs/rock-pi-4c-rk3399_defconfig           | 3 ---
> configs/rock-pi-e-rk3328_defconfig            | 2 --
> configs/rock-pi-n10-rk3399pro_defconfig       | 1 -
> configs/rock64-rk3328_defconfig               | 2 --
> configs/rock960-rk3399_defconfig              | 1 -
> configs/rockpro64-rk3399_defconfig            | 2 --
> 26 files changed, 4 insertions(+), 52 deletions(-)
>
>--=20
>2=2E39=2E2
>
