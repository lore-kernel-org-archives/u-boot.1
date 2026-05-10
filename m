Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37819CD3427
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 19:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 992E2846CA;
	Sun, 10 May 2026 21:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62DD9846CB; Sun, 10 May 2026 21:44:40 +0200 (CEST)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF50846C7
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 21:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=legoll@online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
 (Authenticated sender: legoll@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 2D72C5FFB1;
 Sun, 10 May 2026 21:44:15 +0200 (CEST)
Message-ID: <3fe472bc-b9aa-49f6-ab75-a45547815c28@online.fr>
Date: Sun, 10 May 2026 21:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] riscv: spacemit: k1: add clock reset drivers, switch
 to upstream DT
To: Guodong Xu <guodong@riscstar.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peter Korsgaard
 <peter@korsgaard.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
Content-Language: en-US
From: Vincent Legoll <legoll@online.fr>
In-Reply-To: <20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello Guodong Xu,

On 5/10/26 14:06, Guodong Xu wrote:
> Currently U-Boot's SpacemiT K1 ships its own arch/riscv/dts/k1.dtsi and a
> spacemit,k1-reset binding that has no node in the upstream
> (kernel-mainline) K1 dts. After list discussion [1], this series
> moves U-Boot to the upstream DT before further K1 work lands.
>
> In the upstream DT, each K1 syscon provides both clocks and resets.
> The kernel's clock driver spawns the reset child via the auxiliary
> bus. This patchset does the same in U-Boot: each clock driver
> spawns a UCLASS_RESET sibling on the same ofnode.
>
> Patch 1/8 adds the K1 clock driver.
> Patch 2/8 adds a new syscon-bound reset driver with no DT of_match. At this
>            point, the legacy reset driver and local dts are still there.
> Patch 3/8 has each per-syscon clock driver spawn the reset child on the
>            same ofnode, the way the kernel uses auxiliary devices.
> Patch 4/8 enables the clock driver.
> Patch 5/8 switches BPI-F3 to dts/upstream/.
> Patch 6/8, 7/8 and 8/8 clean up the legacy reset driver and local dts files.
>
> Old and new reset drivers coexist from 2/8 through 6/8 so the series
> is bisectable.
>
> The K1 SPL bring-up [2] and PIN/SPI [3] series will be rebased on
> this and resent once it lands.
>
> Link: https://lore.kernel.org/u-boot/20260507140558.GU1614990@bill-the-cat/ [1]
> Link: https://lore.kernel.org/u-boot/20260325223232.1553212-1-raymondmaoca@gmail.com/ [2]
> Link: https://lore.kernel.org/u-boot/20260422143112.1329478-1-raymondmaoca@gmail.com/ [3]
>
> [...]
>
> ---
> base-commit: 24db98cdf911b6ca362209e674bf9412441c1095
> change-id: 20260510-b4-k1-clk-reset-upstream-dts-cbf1f3a79cfb


I tried to apply this locally but failed:

$ git log --oneline -1
24db98cdf91 (HEAD -> test) Merge tag 'u-boot-imx-next-20260318' of 
https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next

$ git status
On branch test
nothing to commit, working tree clean

$ wget 
https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/t.mbox.gz 
\

  -O ~/Downloads/PATCH-0-8-riscv-spacemit-k1-add-clock-reset-drivers-switch-to-upstream-DT.mbox.gz


$ gzip -dc 
~/Downloads/PATCH-0-8-riscv-spacemit-k1-add-clock-reset-drivers-switch-to-upstream-DT.mbox.gz 
| git am
Applying: riscv: spacemit: k1: add clock reset drivers, switch to 
upstream DT
error: No valid patches in input (allow with "--allow-empty")
Patch failed at 0001 riscv: spacemit: k1: add clock reset drivers, 
switch to upstream DT
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am 
--abort".
hint: Disable this message with "git config set advice.mergeConflict false"

I had a similar failure with the mbox downloaded with:

$ b4 mbox 
https://lore.kernel.org/u-boot/20260510-b4-k1-clk-reset-upstream-dts-v1-0-db0b0503ee44@riscstar.com/T/#t


I also tried to apply to master branch without success

Is there something I'm doing wrong ?

Regards

