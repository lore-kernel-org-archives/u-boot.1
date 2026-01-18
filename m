Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E55C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B9683981;
	Sun, 18 Jan 2026 14:47:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Haiv67Qx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 967068313B; Sun, 18 Jan 2026 09:52:28 +0100 (CET)
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E6082BF2
 for <u-boot@lists.denx.de>; Sun, 18 Jan 2026 09:52:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1768726275; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YOu2whBtrg0FPKQCckEfP+9SlxBhfyvKSGs4qYbUsXbRXG9NaGGueQDlO+1t8t9PzMe+7YE6sYfmRJ5pSKuOeodPqgwknKpghh0Ngt8ULlYnQcTUExkOrMz49ebNlimRQy4x7nEAxpEnqGvh8Mh4WgGvFGXtgP7m5vKDqo9d2nw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1768726275;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=TggExZ1GcIur80vFJRfitJbvadACQD62eIF2Hkv1nGA=; 
 b=cGhJZZvfVAkPQnvaT+7NFQ21z/dT6rCUciLcI0mOynC7mZMX4FXAo/0p3kK/trSbxsbdVQ9LAGilVTZmhuxTqW47zbxzMz0TRl97n2fHv77giv8ht27Gpg5TsQhyBvyRNjS8lPtCuyGUi3k7+Ie4lJ/aI/gR1PUJWWDtpd/vbbc=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768726275; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=TggExZ1GcIur80vFJRfitJbvadACQD62eIF2Hkv1nGA=;
 b=Haiv67Qx+ESswSCgLi6LruEkMCPGGLl2kdMz3ELbPaqNN5VcvjU4MgfvPVBOq4R4
 Iq6eRoIiZwAuIFp1nUtQHa8qzXMprzQQ/Ulx+QfMVNYPAGs29SPGKWPWOG9aEx/9tsB
 cJK/VC9ymsEmqsolADk6GhmoFMFENrFx8yB0WKQ4=
Received: by mx.zohomail.com with SMTPS id 1768726273139680.2181499475954;
 Sun, 18 Jan 2026 00:51:13 -0800 (PST)
Date: Sun, 18 Jan 2026 08:50:42 +0000
From: Yao Zi <me@ziyao.cc>
To: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Michal Simek <michal.simek@amd.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Yixun Lan <dlan@gentoo.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH 02/17] spacemit: k1: enable SPL with debug UART
Message-ID: <aWye4oHcHKihs11Z@pie>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
 <20260117190231.977686-3-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117190231.977686-3-raymondmaoca@gmail.com>
X-ZohoMailClient: External
X-ZohoMail-Owner: <aWye4oHcHKihs11Z@pie>+zmo_0_me@ziyao.cc
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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

On Sat, Jan 17, 2026 at 02:01:36PM -0500, Raymond Mao wrote:
> From: Raymond Mao <raymond.mao@riscstar.com>
> 
> Add SPL support featuring debug UART output for early boot
> diagnostics on K1 SoC.
> 
> Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> ---
>  arch/riscv/cpu/k1/Kconfig  |  2 ++
>  arch/riscv/dts/Makefile    |  1 +
>  arch/riscv/dts/k1-spl.dts  | 26 ++++++++++++++++++++++++++
>  arch/riscv/dts/k1.dtsi     |  2 +-
>  board/spacemit/k1/Makefile |  2 ++
>  board/spacemit/k1/spl.c    | 24 ++++++++++++++++++++++++
>  configs/k1_defconfig       | 21 ++++++++++++++++++++-
>  include/configs/k1.h       |  2 ++
>  8 files changed, 78 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/dts/k1-spl.dts
>  create mode 100644 board/spacemit/k1/spl.c

...

> diff --git a/configs/k1_defconfig b/configs/k1_defconfig
> index 0bdc3c800f0..f1a16735943 100644
> --- a/configs/k1_defconfig
> +++ b/configs/k1_defconfig
> @@ -3,7 +3,19 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
>  CONFIG_NR_DRAM_BANKS=2
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
> -CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
> +CONFIG_DEFAULT_DEVICE_TREE="k1-spl"
> +CONFIG_SPL=y
> +CONFIG_SPL_TEXT_BASE=0xC0801000

Please be consistent about cases in hex. Rest of the file uses
lowercases, and I think it's better to align.

> +CONFIG_SPL_MAX_SIZE=0x33000
> +CONFIG_SPL_BSS_START_ADDR=0xC0837000
> +CONFIG_SPL_BSS_MAX_SIZE=0x2000
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_HAVE_INIT_STACK=y
> +CONFIG_SPL_STACK=0xC0840000
> +CONFIG_SPL_SIZE_LIMIT=0x31000
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
> +CONFIG_STACK_SIZE=0x100000
>  CONFIG_SYS_BOOTM_LEN=0xa000000
>  CONFIG_SYS_LOAD_ADDR=0x200000
>  CONFIG_ARCH_RV64I=y
> @@ -23,3 +35,10 @@ CONFIG_PINCTRL_SINGLE=y
>  CONFIG_RESET_SPACEMIT_K1=y
>  CONFIG_SYS_NS16550=y
>  CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_BASE=0xD4017000
> +CONFIG_DEBUG_UART_CLOCK=14700000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_DEBUG_UART_NS16550=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y

Regards,
Yao Zi
