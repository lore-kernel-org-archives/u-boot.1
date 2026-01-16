Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C45D4A616
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 09:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D6383015;
	Fri, 16 Jan 2026 10:20:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aM7Fc3A9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4005D8309A; Fri, 16 Jan 2026 10:20:31 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3495482BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E255F6016B;
 Fri, 16 Jan 2026 09:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D60C116C6;
 Fri, 16 Jan 2026 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768555227;
 bh=cDdno93bUAsfHYuEllSv2ZoRMOWGI2z+g88CuUkXGWU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aM7Fc3A9fmv2I3UTulcDUpnYbEqo1W9TP4i7xAVIbAa/BP0eoHhmQfLjUocoR+yhE
 Z/3kuXtCAaggqU58I/mQ2Wu7GgiMBdrzocj+SCTJetA3LMjE/XMDKNHEE4ZSo+apeE
 s0XMhQGAkzQba2SArQ7MYczMzHZ5Bwi0hwdzXHCgmniwv17rit2jWHOhTtyN1lb2zp
 cGi9g7kXTX5Z2imnw3Vx4dXdI3m6Jc1cn6J0X6HGQNUDyScxN8MdK4++waLZdHyqGC
 uVQbePsdyd/v4lYzbDrtFrJG+QzmiWYyDRIANRJLwD9abKu6UnA05pIYnhdyjgR8p1
 vicC7j7XN7C2Q==
Date: Fri, 16 Jan 2026 14:50:19 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, ilias.apalodimas@linaro.org,
 jerome@forissier.org, marek.vasut+renesas@mailbox.org,
 christopher.obbard@linaro.org, me@samcday.com, michal.simek@amd.com,
 clamor95@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v5 0/5] Implement reset to EDL for qcs9100
Message-ID: <aWoC0wuoTzqHvbRC@sumit-xelite>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
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

On Tue, Jan 13, 2026 at 04:08:35PM +0530, Varadarajan Narayanan wrote:
> Using the 'reboot edl' command in Linux, the platform can reboot to the
> Emergency Download mode. Implement the same for U-Boot.
> 
> v5: * Update author and signed-off-by email id from quicinc.com to oss.qualcomm.com
>     * Add r-b tags
>     * Enable CONFIG_SYSRESET_QCOM_PSCI in qcom_defconfig instead of qcs9100_defconfig

Thanks for the patience with this patch-set.

Feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> v4: * Update documentation about '-edl' option
>     * Add API to check for support of PSCI functions
>     * Check if RESET2 is supported before issuing the command
>     * Fix compiler warnings
> 
> v3: * Introduce a sysreset op that will pass down the 'reset' command
>       arguments to registered handlers
>     * Handle 'reset to edl' alone in qcom-psci driver
> 
> v2: * Rebased to recent sources
>     * Dropped the first patch as it is not applicable anymore
>     * Bind the new driver from psci driver
> 
> Varadarajan Narayanan (5):
>   arm: psci: Add API to check for support of specific PSCI function
>   drivers: sysreset: Add sysreset op that can take arguments
>   sysreset: Implement PSCI based reset to EDL mode for QCOM SoCs
>   cmd: boot: Add '-edl' option to reset command documentation
>   qcom_defconfig: enable psci based sysreset
> 
>  arch/arm/cpu/armv8/fwcall.c           | 15 +++++++++
>  arch/arm/include/asm/system.h         |  1 +
>  cmd/boot.c                            |  3 ++
>  configs/qcom_defconfig                |  1 +
>  doc/usage/cmd/reset.rst               |  2 ++
>  drivers/firmware/psci.c               |  4 +++
>  drivers/sysreset/Kconfig              |  6 ++++
>  drivers/sysreset/Makefile             |  1 +
>  drivers/sysreset/sysreset-uclass.c    | 32 +++++++++++++++++++
>  drivers/sysreset/sysreset_qcom-psci.c | 45 +++++++++++++++++++++++++++
>  include/sysreset.h                    | 18 +++++++++++
>  11 files changed, 128 insertions(+)
>  create mode 100644 drivers/sysreset/sysreset_qcom-psci.c
> 
> -- 
> 2.34.1
> 
