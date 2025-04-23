Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77627C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 07:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F4580BA8;
	Wed, 23 Apr 2025 09:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A64Wp7Gp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C01680EE5; Wed, 23 Apr 2025 09:53:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE49800D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 09:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C6FBB5C5EBD;
 Wed, 23 Apr 2025 07:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1C0C4CEEA;
 Wed, 23 Apr 2025 07:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745394823;
 bh=m1WZVVWRlqt3T29bTTAZoiV2LWdwa8KTq86bkjjSfJQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=A64Wp7GpHN2UVMnrfOukwb5HlgXvqN84WYDo5jb/n+xSA/j8VOspi/JS1f8Ea5aaZ
 xja8wEsGi/VXrEgJQVqwz1pvH5ubieS0JAYKswzUG1o04/hUUTAqJ/oN0Wfvj//3nL
 gk93s3WMFng3A+PzrnFT58nejf79PuyN4lFas/taBLJTeYKQRiL7QFmwz/bX+HAsEn
 KAS3BQr0Hu9koK8NTVtszCfI9AOd/o8vpitV5bnQX90c8YNcO1ntWdfQqTS161K1wN
 2dk6NMHFeQtAPArSbYuTy7pfiy7z1teRMfesfb1wLjd5DkyMhhZEAaCDHYjTgDLmKg
 KMK1BbD+iExYg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, Marek Vasut <marex@denx.de>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20250407170529.893307-1-vincent.stehle@arm.com>
References: <20250407170529.893307-1-vincent.stehle@arm.com>
Subject: Re: (subset) [PATCH 0/5] fix dfu alt buffer clearing
Message-Id: <174539482144.9635.14403377545840814436.b4-ty@kernel.org>
Date: Wed, 23 Apr 2025 09:53:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-7b9b9
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

Hi,

On Mon, 07 Apr 2025 19:05:24 +0200, Vincent Stehlé wrote:
> This patch series applies the same fix in five different locations (the
> detailed description of the fix is in the patches).
> 
> I did validate statically by looking at the assembly before/after for all
> five cases, using the following defconfigs:
> 
>   stm32mp15_defconfig
>   synquacer_developerbox_defconfig
>   xilinx_versal_virt_defconfig
>   xilinx_zynq_virt_defconfig
>   xilinx_zynqmp_kria_defconfig
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/5] fwu: developerbox: fix dfu alt buffer clearing
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/39a719dce59607d6abcac17cc2683aa9f2162539

--
Mattijs
