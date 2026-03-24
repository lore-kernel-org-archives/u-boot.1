Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326E0E9A777
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:47:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97F0D80517;
	Tue, 24 Mar 2026 12:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HMuo1kip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D8B807C0; Tue, 24 Mar 2026 12:47:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F048C80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DBB1F60138;
 Tue, 24 Mar 2026 11:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB32C2BCB1;
 Tue, 24 Mar 2026 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774352835;
 bh=fq3vabrwh7P2bxrcmUgbMt9gzOeaDn8YgU0oxk6V3E8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HMuo1kipoBb0jYlKcQoblWE/vGz4tNO23DL5fjBfYvoyHOVIt7PJyttSBA+iuqibA
 GWCuaYLf7+VbmHgvzOMCJL+oPnW6gTCiaiABzJKz2o3OTiweM+pxMGtC9/jvdaVjoc
 0fzLEK0wJha0it5xZZw3axEyAA9iUbBqSS58iZjWd6yQv8RhKDkEzWFfj3SGjYj6xi
 mD5U3Vka2sXPWWu05GGzT0BWAySu0BcbeTU4TZyh5iPJym9LWFOCDZjLnxVagLXkez
 Xs1bwnMvmiz48Ph81/cjsvwc9pHLij35Rr+yG67a2ORm7TTPwHy88XIxkyVP9qISoi
 m0TDWUvFCHphA==
Date: Tue, 24 Mar 2026 17:17:08 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/3] mach-snapdragon: Enable OP-TEE support
Message-ID: <acJ5vEZ2F46NS_xV@sumit-xelite>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127062341.723966-1-sumit.garg@kernel.org>
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

Hey Casey,

On Tue, Jan 27, 2026 at 11:53:38AM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Introduce TF-A and OP-TEE config fragment
> 
> Recently upstream TF-A/OP-TEE has started gaining support for Qcom
> platforms. RB3Gen2 being the first one and more to come. U-Boot in
> corresponding boot flow is packaged as a position independent executable.
> 
> So, lets add a generic U-Boot config fragment for Qcom platforms to
> support TF-A/OP-TEE based TrustZone stack. Build command:
> 
> $ ./scripts/kconfig/merge_config.sh \
>        configs/qcom_defconfig \
>        board/qualcomm/tfa-optee.config
> $ make -j`nproc` DEVICE_TREE=qcom/qcs6490-rb3gen2
> 
> ---
> Changes in v3:
> - Incorporated misc. comments on patch #2.
> 

Can we get this patch-set applied as well? Have been waiting on the list
for approx. 2 months.

-Sumit

> Changes in v2:
> - Add new patch #1 to export OP-TEE message UID check API
> - Use OP-TEE message UID check API in order to perform the DT fixup for
>   OP-TEE.
> - Switch from new defconfig to a config fragment instead.
> 
> Sumit Garg (3):
>   tee: optee: Export OP-TEE message UID check API
>   mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
>   board/qualcomm: Introduce TF-A and OP-TEE config fragment
> 
>  arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
>  board/qualcomm/tfa-optee.config     |  4 ++++
>  drivers/tee/optee/core.c            |  5 +++++
>  include/tee/optee.h                 |  9 ++++++++
>  4 files changed, 53 insertions(+)
>  create mode 100644 board/qualcomm/tfa-optee.config
> 
> -- 
> 2.51.0
> 
