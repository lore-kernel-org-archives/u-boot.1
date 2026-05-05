Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58934CD343A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 10:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 908D98487C;
	Tue,  5 May 2026 12:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T1Le38Iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7293C8488A; Tue,  5 May 2026 12:11:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8CEA846D5
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 12:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9173160128;
 Tue,  5 May 2026 10:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B428BC2BCB4;
 Tue,  5 May 2026 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777975905;
 bh=g+VjJA1F1BltneXFI7+v5Wh+umGurvwVU6HLLKZRDfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T1Le38IyetRIul7CN8AeqdGHInE5n12t7jXSbqppPV24J6KFSPPhIAWhz/fXYIyWo
 4rWNMAE6s5N+kuDDPEUTxvaRpYaBUan75WIzIIiPVmCEBG3XpmkfJjJlWOyNufOTBM
 V7zS0vj/2HOhyCqNnUJYAMVjBLpV/ma0VX7a6Z/kU4+ST1102a+ievKBA4LKH504jF
 eV9csvoTYLgCOWxH5HVnaZ9RcjpkeoSzFlK0fOTCfZHkhblnhHiUj51SHkyrSPhzkf
 6E7OlWRk3iWeh22TjUdASJukLA5jHDKrEzkqOmoumOJnjb4hP/8T7NZit8aFf3/gAZ
 c6Mxgvgu3XvBw==
Date: Tue, 5 May 2026 15:41:33 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/15] qcom: smem: modernize SMEM in U-Boot
Message-ID: <afnCVT5JoeIdy-hQ@sumit-xelite>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
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

Hi Casey,

Thanks for the much needed re-spin of the SMEM patch-set.

On Mon, May 04, 2026 at 08:57:28PM +0200, Casey Connolly wrote:
> Smem is currently implemented a uclass in U-Boot. This carries with it
> some implicit limitations about how and when we can actually talk with
> it, since its modelled as a device.
> 
> The SMEM uclass is qualcomm specific and has no other users, smem is
> also largely useful for parsing the memory map and other tasks which we
> have to do before DM is alive anyway.
> 
> Let's drop the old smem code and replace it with a straight port from
> Linux, providing a familiar interface and enabling us to access it much
> earlier in the boot process than would be possible with a standard
> udevice.
> 
> Additionally, this will be easier to maintain going forwards since any
> patches from Linux can be more easily ported over.
> 
> With this new smem framework in place, we can now use SMEM to parse the
> memory map when it's not provided via some other mechanism and to read
> the serial number of the board.
> 
> Implement this functionality and split the snapdragon memory parsing off
> to its own file to try and organise things a bit better.
> 
> Since the memory map stored in SMEM doesn't already have some carveouts
> let's also be correct about unmapping reserved memory regions, we
> should eventually do this on all Qualcomm boards but it's particularly
> important when we aren't chainloading from ABL.

This was really needed to unmap reserved regions in U-Boot memory map to
increase robustness.

> 
> This depends on a fix for unmapping memory regions: https://lore.kernel.org/u-boot/20260504175511.585797-1-casey.connolly@linaro.org/
> 
> ---
> Changes in v2:
> - Ensure reserved regions are unmapped appropriately when using SMEM as
>   the source of truth for the memory map.
> - Support SMEM ram layout v0/v1 for older platforms using a header from
>   Qualcomm.

It would be better if you can provide proper attribution in the commit
to which this header is being picked up.

> - Set an environment variable (memmap_source) providing info about
>   where U-Boots memory map is from.
> - Correctly handle serial_num missing on msm8916
> - Link to v1: https://lore.kernel.org/r/20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org
> 

FWIW, I tested this patch-set on RB3Gen2 and lemans-evk after dropping
the U-Boot DT overrides, so feel free to carry:

Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I will give a proper review to this series soon.

-Sumit

> To: u-boot@lists.denx.de
> To: Sumit Garg <sumit.garg@kernel.org>
> To: u-boot-qcom@groups.io
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> Cc: Stefan Roese <stefan.roese@mailbox.org>
> Cc: Philip Molloy <philip.molloy@analog.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Marek Vasut <marek.vasut@mailbox.org>
> Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Cc: Rasmus Villemoes <ravi@prevas.dk>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> Cc: Antony Kurniawan Soemardi <linux@smankusors.com>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
> ---
> Casey Connolly (15):
>       Revert "dm: SMEM (Shared memory) uclass"
>       smem: drop drivers/smem
>       Revert "test: smem: add basic smem test"
>       Revert "drivers: smem: sandbox"
>       mach-snapdragon: fix reserved memory carveout
>       soc: qcom: import smem from Linux 6.11-rc2
>       soc: qcom: smem: adjust headers for U-Boot
>       soc: qcom: smem: adjust for U-Boot
>       soc: qcom: smem: get serial number from socinfo
>       soc: qcom: smem: stub functions
>       soc: qcom: smem: add build infra
>       mach-snapdragon: move memory parsing to its own file
>       mach-snapdragon: support parsing memory map from SMEM
>       mach-snapdragon: fetch serial# from SMEM
>       configs: add qcom_sm8650_defconfig and debug fragment
> 
>  MAINTAINERS                                  |   1 -
>  arch/arm/Kconfig                             |   3 +-
>  arch/arm/mach-snapdragon/Makefile            |   2 +-
>  arch/arm/mach-snapdragon/board.c             | 253 ++++-----
>  arch/arm/mach-snapdragon/dram.c              | 239 ++++++++
>  arch/arm/mach-snapdragon/qcom-priv.h         |  17 +
>  arch/arm/mach-snapdragon/rampart.h           | 194 +++++++
>  arch/sandbox/dts/test.dts                    |   4 -
>  board/qualcomm/debug-sm8650.config           |   5 +
>  configs/qcom_sm8650_defconfig                |  16 +
>  configs/sandbox64_defconfig                  |   2 -
>  configs/sandbox_defconfig                    |   2 -
>  drivers/Kconfig                              |   2 -
>  drivers/Makefile                             |   1 -
>  drivers/smem/Kconfig                         |  25 -
>  drivers/smem/Makefile                        |   7 -
>  drivers/smem/sandbox_smem.c                  |  44 --
>  drivers/smem/smem-uclass.c                   |  46 --
>  drivers/soc/qcom/Kconfig                     |   8 +
>  drivers/soc/qcom/Makefile                    |   1 +
>  drivers/{smem/msm_smem.c => soc/qcom/smem.c} | 777 ++++++++++++++++-----------
>  include/dm/uclass-id.h                       |   1 -
>  include/smem.h                               |  90 ----
>  include/soc/qcom/smem.h                      |  36 ++
>  include/soc/qcom/socinfo.h                   | 111 ++++
>  test/dm/Makefile                             |   1 -
>  test/dm/smem.c                               |  26 -
>  27 files changed, 1186 insertions(+), 728 deletions(-)
> ---
> base-commit: 2920b49fb117dd70b6219804bf0d298c96f184f2
> 
> // Casey (she/they)
> 
