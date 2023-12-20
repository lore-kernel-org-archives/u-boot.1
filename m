Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327FBC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:02:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F096876B2;
	Wed, 20 Dec 2023 11:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VvIrBdXB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C833A876C4; Wed, 20 Dec 2023 11:02:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14648876B2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5843A61573;
 Wed, 20 Dec 2023 10:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F38C433C7;
 Wed, 20 Dec 2023 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1703066546;
 bh=mJnnqnUZxRxY5jE3oWwx/PhjMgVf0Fdq2+8DKxFCpWU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VvIrBdXBOqViLcWmZ5Jw/IrQZreeJJh9qy6qG9rju8k0P/LzWherqyC9fbZtozYWv
 i9AMvXhp+LunyTZbu7ZWfydPohBozfunMhB1jBKZ1wIrkEJgsllDQzTJiUvueGPOrp
 u7B8wxB6oX22AozQHe4V3Y/fPOWSgbk9TmITuZ4v/0ijtpJO71t6mzwQ9QmsR8jeg1
 bpFlymYU+gnZoeXHmnEqMDsf1lf5CFm6Tywp5W2tLvnbSqvLhUiNsX7S0DEXdDR+a0
 H8oIIF7uBu5t04/tHGrh8mQq/05Uj8BCppOW937nvWL7zCtge7PtfjXOpaEjnT73T5
 b8Xc2EztDWHaQ==
Message-ID: <4a831eea-ce70-46b9-9e30-cc57a0182630@kernel.org>
Date: Wed, 20 Dec 2023 12:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/16] configs: am65x_evm_a53_defconfig: add
 SPL_LOAD_FIT_APPLY_OVERLAY
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Maxime Ripard <mripard@kernel.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, srk@ti.com, r-gunasekaran@ti.com
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-15-danishanwar@ti.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231219103418.3445886-15-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 19/12/2023 12:34, MD Danish Anwar wrote:
> We want SPL to apply DTB overlays (e.g. NAND card overlay) so
> enable SPL_LOAD_FIT_APPLY_OVERLAY.
> Increase SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ and
> SPL_STACK_R_MALLOC_SIMPLE_LEN. Without this SPL hangs.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  configs/am65x_evm_a53_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
> index e79a961317..2755d7082f 100644
> --- a/configs/am65x_evm_a53_defconfig
> +++ b/configs/am65x_evm_a53_defconfig
> @@ -70,6 +70,9 @@ CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_PCI=y
>  CONFIG_CMD_REMOTEPROC=y
> +CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
> +CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ=0x100000
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x1000000

This change to 16MB is not required. I suppose default is 4MB.
Did you face issues with it?

>  CONFIG_CMD_USB=y
>  CONFIG_CMD_TIME=y
>  CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0"

-- 
cheers,
-roger
