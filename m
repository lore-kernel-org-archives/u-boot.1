Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E11FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC741803C6;
	Fri,  1 May 2026 09:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a3hYRHpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173BB81E18; Fri,  1 May 2026 09:54:53 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED7580086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 297C341B0F;
 Fri,  1 May 2026 07:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B0CC2BCB4;
 Fri,  1 May 2026 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777622089;
 bh=V14rT+qhn0COMChyO0b+UyUMd/VMStcTKNQBhdZuyok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a3hYRHpGoQZlquxdZ6UcJnTVmhowhVyljlJr1BwwWUbBPq/n+TdZhESl/MvlOAxpD
 nq7l1fu8mLA3A+EbIzqiFdgANcpuLZUguNCbaSnNXT7cWiNkpuvrV2fLPY7Ng5qVMn
 eA8jIvg98sY0qjbWsyT9db2sNmVgc7rgAGN2GjkURgETnrMOwXE4G65/I5rj0CYWrN
 t/ywnljkDcdc2c5+EXOxCpjLZctEuZRMllntcGcD+uhQriNI2vk468lC796fBbk1HR
 9/l7r3pauXli9DPsfjHN/PNVjN20mudwDtkfSXqyjrcxrmFUtxTbocDEZxqKIYDe/A
 xFTswy/jZ73NQ==
Date: Fri, 1 May 2026 13:24:42 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH] qcom_defconfig: Switch Qualcomm fastboot flash from MMC
 to block
Message-ID: <afRcQlOItA9ZYzu_@sumit-xelite>
References: <20260216-fb_block-v1-1-4e2d286bae76@oss.qualcomm.com>
 <aZgk1rZKhCW_7A2F@sumit-xelite>
 <d62fa57d-d85e-4d25-9d3a-1d656c60491c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d62fa57d-d85e-4d25-9d3a-1d656c60491c@oss.qualcomm.com>
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

On Mon, Apr 27, 2026 at 10:29:39PM +0530, Balaji Selvanathan wrote:
> 
> On 2/20/2026 2:39 PM, Sumit Garg wrote:
> > Hi Balaji,
> > 
> > On Mon, Feb 16, 2026 at 09:45:49PM +0530, Balaji Selvanathan wrote:
> > > Replace MMC-specific fastboot flash configuration with generic
> > > block device support for Qualcomm platforms. This change switches
> > > from MMC device 0 to SCSI interface with device ID 4, enabling
> > > fastboot operations on UFS storage instead of eMMC.
> > I don't think if it's right for qcom generic defconfig to hardcode
> > fastboot flash device. Can you try to see rather if the fastboot flash
> > device can be determined at runtime? As otherwise it might end up in
> > target specific defconfig which we should avoid if we can.
> 
> Hi Sumit,
> 
> Implemented the runtime determination of fastboot device in : https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
> 
> However, I think we need to assign CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, so
> that if user doesnt provide device number in the fastboot commands, then we
> can use the device mentioned in CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID as
> default.

Please capture any patch-set dependencies in the comments section. I
think for this patch it would rather makes sense if you bundle it along
that fastboot patch-set.

-Sumit
