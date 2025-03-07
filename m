Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D0BC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 11:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D73F980E94;
	Fri,  7 Mar 2025 12:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="hG795J36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C02480F4C; Fri,  7 Mar 2025 12:20:37 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDBC8003E
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 12:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AFE2120559;
 Fri,  7 Mar 2025 12:20:34 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eC1kS63Fu75a; Fri,  7 Mar 2025 12:20:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741346430; bh=0y2unEbXFcFFHYwyRMupLhbOAMuK1ercvbw7EaLwdH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hG795J36MEtsKG6cc4xaqbiIGvdLtzVw58rqkJE6jBRdEK+e/+dekvVkHwAdTNjy4
 VzF+h1s01tvEroZniHoqU8Qyzuxy/CeOzwnxpvwQ2FL4iXZdNJiBy+Szy5Zh1Of1tZ
 5zhnPhX6sIu4ViGeAXQgyVR/tUN3E7jMtKF8Tav8mvy6VzSWCl3JoJ8HwGmNP9Yxea
 oGMME5lcRE+sNJQJmuQB6ub3iOlD9TS+bciXfNKLPyMjX+rHMp4ST7L7DYIscU/rGa
 atoHutHyOeteb0IJ5k/Brlg00/jo+EREZLRmQ/Ax5BzP1l5GUxxXCSF3h9bpKdWA0i
 AGBImftSG9Htg==
Date: Fri, 7 Mar 2025 11:20:20 +0000
From: Yao Zi <ziyao@disroot.org>
To: Leo Liang <ycliang@andestech.com>, <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>, <rick@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <Z8rWdGZgApM4INgH@pie.lan>
References: <Z8mShWelhde38haW@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8mShWelhde38haW@swlinux02>
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

On Thu, Mar 06, 2025 at 08:18:13PM +0800, Leo Liang wrote:
> Hi Tom,
> 
> The following changes since commit 409d37e869e91453d94319792e17d1d882259b49:
> 
>   led: Fix next Coverity scan error (2025-03-04 12:07:23 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git 
> 
> for you to fetch changes up to 6e71966fa8a5e667f53170165b36ee59a1dfc465:
> 
>   board: sifive: Remove duplicated board_fdt_blob_setup (2025-03-06 14:09:39 +0800)
> 
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot-riscv/-/pipelines/25004
> ----------------------------------------------------------------
> - starfive: simplify binman config
> - riscv: remove duplicated board_fdt_blob_setup
> - spacemit: update k1 uart compatible
> - sifive: unmatched: add 'nvme scan' to preboot
> ----------------------------------------------------------------
> Heinrich Schuchardt (5):
>       configs: SiFive Unmatched: add 'nvme scan' to preboot
>       riscv: dts: add OF_LIST handling to binman.dtsi
>       riscv: dts: no default configuration for MULTI_DTB_FIT
>       board: starfive: spl: strip off 'starfive/' prefix
>       riscv: dts: starfive: remove duplicate itb entries
> 
> Junhui Liu (1):
>       riscv: dts: spacemit: Update UART compatible for k1
> 
> Yao Zi (4):
>       riscv: lib: Add a default implementation of board_fdt_blob_setup
>       board: qemu: riscv: Remove duplicated board_fdt_blob_setup
>       board: starfive: Remove duplicated board_fdt_blob_setup
>       board: sifive: Remove duplicated board_fdt_blob_setup

These four patches may not be ready to be merged, see my reply here[1].

>  arch/riscv/dts/binman.dtsi                        | 10 ++-
>  arch/riscv/dts/k1.dtsi                            | 22 +++----
>  arch/riscv/dts/starfive-visionfive2-binman.dtsi   | 76 -----------------------
>  arch/riscv/lib/Makefile                           |  1 +
>  arch/riscv/lib/board.c                            | 19 ++++++
>  board/emulation/qemu-riscv/qemu-riscv.c           |  8 ---
>  board/sifive/unleashed/unleashed.c                | 11 ----
>  board/sifive/unmatched/unmatched.c                | 10 ---
>  board/starfive/visionfive2/spl.c                  |  4 ++
>  board/starfive/visionfive2/starfive_visionfive2.c | 10 ---
>  configs/sifive_unmatched_defconfig                |  2 +-
>  11 files changed, 43 insertions(+), 130 deletions(-)
>  create mode 100644 arch/riscv/lib/board.c
> 
>  Best regards,
>  Leo

Best regards,
Yao Zi

[1]: https://www.mail-archive.com/u-boot@lists.denx.de/msg538632.html
