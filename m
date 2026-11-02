Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2F606B1E1
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bSE4D+xW;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=EL+p9QGX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 537CB607C9;
	Mon,  2 Nov 2026 15:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqnQnGfuZ3MO; Mon,  2 Nov 2026 15:10:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 392B960669
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793632218;
	b=OQauQepeDHAvKifqXVzRi+5N0e8Z1hwClpVULS09R0Zzhv1UJAHVgOGEEXuGchLKbPSH
	 PjJ6bu2QvilsG9xn0abbtxUH9tmhz42rb+G68wHBfaGcuu9Ex5JYEnM2j+eVAR97LPh73
	 G8+myMtNDXSqFEwp5e6MjiT3DtJ7OmbBW5m+epXkfAMdUOv2EWscEW9yUPi8rUKKxO/I2
	 BtsrV6yqGs+gY6A58mLAuw/xQ2BDkgOdRrllf+ZTPmJutESy9kYy++Ki+AFhMoG0MeXKs
	 141gLOXqdDhS9rMdpVIW8QQ5gSlvPGYcjSIPiDwkardOpWDyRScXLQwYsKMbjc5veQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793632218;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pX8ExUw0ZYAZIPhjn/ZvCKlh2n1xIlmgDvuPqTgFEss=;
	b=Br0l9KLzhEYfKp42nG2tT0oW+ZmNXI7ILCE29a9jLL8JwLZdf3ja51eIeKyFwTmqhGyK
	 8JfAGrmAR8zTtca9Op/vygp1W2+KNiwSz6qKZsDCeuU9WoCxnaTwYdas3r78BGUdCswh8
	 MU111YLNN0yOCtjt+sG3YyC5z7NR3DkK7ZYdNb3qiWEG7gsiFzRKSdHHGSJFlr6dVbatA
	 48n5PufAkI+n9a9rcRrh5nLQx+QEJo5eEs5gkKnaP6AMIyLwZxdfKc4y+aDeGHhFVP0wi
	 Duo9aNh2D550rt2NPYfEsVNUhj/jC0ilNB/SoMjlXCu6u1NDkGWNAcTUVXee99KsVzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=EL+p9QGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793632218;
	bh=pX8ExUw0ZYAZIPhjn/ZvCKlh2n1xIlmgDvuPqTgFEss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bSE4D+xWYmU7rAiv6t3OwgTYAyjm/j9SKrF1Ji8bFL5Ur4xRSJz5OH0GgTtEFLkTl
	 iRvFkLpsqv5E14JQ8NxKzbgnnlhFPZ1+XnUA1zWMAHS3/jRqvXu8YpHNOweNaTcqeV
	 bZNvzbsdsDBxPtHk4oFzoRanncXEdZMVpAj8XMto4b7k3ZYNK5PHeJTPA9Ph9RUgEa
	 Tl5fDSs3d0TqKPk3x088GMZZap1x9qPyEsqZXs1LMMArbRS+tljzE4FnsLuR8ReJ/o
	 2tUr7JmSw9FtXpXvxYScIrEMoIKmYl3tejzryoBba/3yUpslS+m6QGeeJcBIf59Idi
	 yFTx89xwp5UiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 392B960669;
	Mon,  2 Nov 2026 15:10:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBD0AD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:10:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D182F60669
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:10:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7nW7H4HqZIdq for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 15:10:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 39F496060B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793632215;
 b=TQ2+WOEWw4VE9I7CnjUPZXmPW5H0wnESkwhevpB6LsokyGVpByCXBIskjtSDEiSzJONY
 wWmONAdZKlWPHp8rVdX65Aos35bmTDENLeu9uaEfX4xvQe3SRpm1bnlEIKjMcHCt+ZXVg
 MMA4zjHE/Qi1xZB52vfuvP/E/LihZdw9Gkv9RjFpzNll6yNidb8g2cjesOf9I2Uld524/
 N6LPiJGVDWrlxoK03W/05L7XW+rBdR2vZJ5LarKtjthf4vbslINTq2nE63KAOk0VVYp5o
 QdxQ9GWp2CkkrnZTwE/OepxNkZ9TG+PI4ili1z4cgjwjz0a7J7EWgwRODhp931WYSFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793632215;
 h=Received-SPF:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding;
 bh=pX8ExUw0ZYAZIPhjn/ZvCKlh2n1xIlmgDvuPqTgFEss=;
 b=jjnjbPfa9uS71r4NH5pq1tGKlRhVZfQ2hsJF7ILJrHwwmvtl5ksXPuVAWNuZXJJmng24
 uFZP67Z/U1wEv+be/9k7b7wKUy9F0h6+wx6jQ7QIAXZFmSOQUEhJKPKHyqbWCTOii5YUg
 JU5hx1Cedqxlq8TSuwohmLfvcuRqojlS/vrkf527vsEJ0RNFAINubwJEttlwUHlgB3CAB
 4cTTXNGQtAwj1MhLcMIToSnFOdeDypAQlf9GgJuh+Mad0eZ3T66Dahaocsq/KkHWyyhFo
 EtGmHvajAVMy7FaIuG1QUmYOhYZKiUmuGqyMHNC0JBZdHBkH6eZRE2n18Kskmsh1caQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=freeshell.de;
 dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=EL+p9QGX; 
 arc=none smtp.remote-ip="2a01:4f8:231:482b::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:231:482b::2;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=EL+p9QGX
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39F496060B
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1793632179;
 bh=pX8ExUw0ZYAZIPhjn/ZvCKlh2n1xIlmgDvuPqTgFEss=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EL+p9QGX9OcecPgXxFyhjh+tqLXkk13kzSF6BMb2pnL1MfTqfzlldblvJ1lYJH4Fn
 Egq0uDhGVvY0u5wjMAyD2rNwnYPV4y8SZBshqOzUksJmF9uRLJxJIs3+fkLEpGjjgQ
 /NB5qPza6TdrXWi+c4k/xD3LY8te5H9dLON0CtNkFtivbmgaypb619Sae9Z7g211dr
 fOO32TDkut4d+m4aAcXwn8jx+vuoTWABIC2axsd0boxmteFyzS9OPz11+WCUAfZpqr
 W3yXhXcF2M1ORZf04BqJbdiO9Zw/vuBKkQ8ZJDAXv6HkOTDHVlbwCRA7guDg9UWUjj
 0XICsicoq0WmA==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id B3572B220DFF;
 Mon,  2 Nov 2026 16:09:37 +0100 (CET)
Message-ID: <9a9f37da-2aaf-4770-8a3e-3d946ca4e275@freeshell.de>
Date: Mon, 2 Nov 2026 07:09:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] u-boot-riscv/main
To: Leo Liang <leo.liang@sifive.com>, trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, tim609@andestech.com,
 zhuxu_ran@zohomail.com, nwhitehorn@pa.msu.edu, nikita.shubin@maquefel.me,
 pengpeng@iscas.ac.cn, me@ziyao.cc, jamie.gibbons@microchip.com,
 gaohan@iscas.ac.cn
References: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <auhMhKazXaCGNf9g@lliang-1876.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Leo, and Tom,

On 11/2/26 00:40, Leo Liang wrote:
> Hi Tom,
> 
> The following changes since commit ee9fc27f2a2a43f253a6fe18d7a6f7c4eb0cda3b:
> 
>   cmd: mdio: check argc for extended mode (2026-11-01 13:35:30 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv.git main
> 
> for you to fetch changes up to 22c3818159190cfd6dd378b7a628c0b339ab1c3b:
> 
>   clk: sophgo: cv1800b: Drop legacy compatible string (2026-11-01 19:16:36 -0800)
> 
> Ci result shows no issue: https://git.u-boot-project.org/u-boot/custodians/u-boot-riscv/-/pipelines/1815
> ----------------------------------------------------------------
> - riscv: sophgo: Use upstream devicetrees for CV18xx boards
> - riscv: mpfs: move system controller configs to CPU Kconfig
> - arch/riscv: Allow booting from NET
> - riscv: mpfs: Read and store FPGA design information on MPFS hardware
> - MAINTAINERS: Make RISC-V entry cover all paths containing the keyword
> - Fixes:
>   - riscv: timer: Fix M-mode early timer support
>   - riscv: thead: fix D-cache flushing
>   - doc: board: starfive: update jh7110 build output description
>   - riscv: mpfs: imply the CoreQSPI driver
> ----------------------------------------------------------------
> E Shattow (1):
>       doc: board: starfive: update jh7110 build output description
> 
> Han Gao (1):
>       riscv: thead: fix D-cache flushing
> 
> Jamie Gibbons (3):
>       board: microchip: mpfs_generic: drop system controller Kconfig selects
>       board: beagle: beaglev_fire: drop system controller Kconfig selects
>       riscv: mpfs: move system controller config to CPU Kconfig
> 
> Nathan Whitehorn (1):
>       riscv: mpfs: Read and store FPGA design information on MPFS hardware.
> 
> Nikita Shubin (4):
>       riscv: Fix IPI not initialized in riscv_cpu_setup()
>       arch/riscv: Allow booting from NET
>       riscv: timer: Make RISCV_TIMER definitions weak
>       riscv: timer: Enable early timer for M‑mode
> 
> Pengpeng Hou (1):
>       riscv: mpfs: imply the CoreQSPI driver
> 
> Yao Zi (1):
>       MAINTAINERS: Make RISC-V entry cover all paths containing the keyword
> 
> Zhuxu Ran (7):
>       clk: sophgo: cv1800b: Add SoC-specific compatible strings
>       mmc: cv1800b: Add SG2002 compatible string
>       riscv: milkv_duo: Use upstream devicetree
>       riscv: licheerv_nano: Use upstream devicetree
>       riscv: milkv_duo_256m: Use upstream devicetree
>       riscv: dts: sophgo: Drop local CV18xx devicetrees
>       clk: sophgo: cv1800b: Drop legacy compatible string
> 
>  MAINTAINERS                                     |   6 +-
>  arch/riscv/cpu/cpu.c                            |   3 +-
>  arch/riscv/cpu/mpfs/Kconfig                     |   6 +-
>  arch/riscv/dts/Makefile                         |   3 -
>  arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi    |  35 ++++
>  arch/riscv/dts/cv1800b-milkv-duo.dts            |  64 -------
>  arch/riscv/dts/cv1800b.dtsi                     |  22 ---
>  arch/riscv/dts/cv18xx.dtsi                      | 232 ------------------------
>  arch/riscv/dts/sg2002-licheerv-nano-b.dts       |  45 -----
>  arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi |  16 ++
>  arch/riscv/dts/sg2002-milkv-duo256m.dts         |  46 -----
>  arch/riscv/dts/sg2002.dtsi                      |  34 ----
>  arch/riscv/include/asm/spl.h                    |   1 +
>  arch/riscv/lib/thead_cmo.c                      |   2 +-
>  board/beagle/beaglev_fire/Kconfig               |   4 -
>  board/microchip/mpfs_generic/Kconfig            |   4 -
>  board/microchip/mpfs_generic/mpfs_generic.c     |  26 +++
>  board/sophgo/milkv_duo/MAINTAINERS              |   3 +-
>  board/sophgo/milkv_duo_256m/MAINTAINERS         |   1 +
>  configs/milkv_duo_256m_defconfig                |   6 +-
>  configs/milkv_duo_defconfig                     |   3 +-
>  configs/sipeed_licheerv_nano_defconfig          |   3 +-
>  doc/board/sophgo/milkv_duo_256m.rst             |   2 +-
>  doc/board/starfive/jh7110_common.rst            |  10 +-
>  drivers/clk/sophgo/clk-cv1800b.c                |   3 +-
>  drivers/misc/mpfs_syscontroller.c               |  55 ++++++
>  drivers/mmc/cv1800b_sdhci.c                     |   1 +
>  drivers/timer/Kconfig                           |   9 +-
>  drivers/timer/riscv_timer.c                     |  16 +-
>  include/mpfs-mailbox.h                          |   2 +
>  30 files changed, 183 insertions(+), 480 deletions(-)
>  create mode 100644 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/cv1800b-milkv-duo.dts
>  delete mode 100644 arch/riscv/dts/cv1800b.dtsi
>  delete mode 100644 arch/riscv/dts/cv18xx.dtsi
>  delete mode 100644 arch/riscv/dts/sg2002-licheerv-nano-b.dts
>  create mode 100644 arch/riscv/dts/sg2002-milkv-duo256m-u-boot.dtsi
>  delete mode 100644 arch/riscv/dts/sg2002-milkv-duo256m.dts
>  delete mode 100644 arch/riscv/dts/sg2002.dtsi
> 
>  Best regards,
>  Leo

There's one more patch I'd like to see in this late PR:

"[PATCH v2] configs: starfive: enable mtdparts on visionfive2"
https://lore.kernel.org/u-boot/20261022110913.1415753-1-e@freeshell.de/

We reviewed a similar patch for SpacemiT K3 and with the benefit of that
discussion I improved on this patch for starfive from v1 to v2 based on
what we discovered, so I am confident it is ready to apply.

Thanks,

-E
