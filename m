Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852E0C5516E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 074B983E1E;
	Fri, 20 Feb 2026 10:15:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NWN7953g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C0F83E62; Fri, 20 Feb 2026 10:15:09 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A1C83AC5
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AC50C6184C;
 Fri, 20 Feb 2026 09:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904FFC116C6;
 Fri, 20 Feb 2026 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771578905;
 bh=lQSuTI6NDzkLpVlnQeG5rhcxvGLMWNk3s2GOuv6JGvM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NWN7953gBj+/npzs98bhE0F8vDfIk4PiNfo6Jv28np49CYOsQerbJh0sStLj0DW/c
 F39OcDOks2vXGlhecqmlL3TcZvHvOiNB2G9DDC9kxrsH8fp66PqyqQCWo4kP3WKUVN
 bB5U7RpbGamo/ZnNNdLGLLqh4vlcZPwiu7PUpXYIBfq6BxBHsCcdlxfEdy3fsqKzFd
 GNbiNh6JjVQtofwY1OJW9Was6G4D9qU+Xzxvulshy789Rhc4Tf6mpLXAyqtbQlCki2
 4HsvlA2oYTPpojorLSeD6NJ8hJj3hD03Ccm3YQUB2/Sp3+hUrBYOAfY48lTegrpQw7
 RTbYT350PWa7w==
Date: Fri, 20 Feb 2026 14:44:57 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Day <me@samcday.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 George Chan <gchan9527@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH] mach-snapdragon: allocate memory for DT overlays
Message-ID: <aZgmEeOl0P4RmhUW@sumit-xelite>
References: <20260217-qcom-fdt-overlay-v1-1-d0fa0e70d738@smankusors.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217-qcom-fdt-overlay-v1-1-d0fa0e70d738@smankusors.com>
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

On Tue, Feb 17, 2026 at 08:51:34AM +0000, Antony Kurniawan Soemardi wrote:
> Allocate a 1 MiB LMB region for fdtoverlay_addr_r when
> CONFIG_OF_LIBFDT_OVERLAY is enabled, allowing runtime application of
> DT overlays on Snapdragon platforms.
> 
> This is useful for Android-based boot flows where the final DT passed
> to the kernel must contain modified /firmware/android/fstab entries.
> One use case is redirecting system and vendor partitions to microSD
> storage instead of internal eMMC without rebuilding the base DTB.
> 
> The allocation is conditional on CONFIG_OF_LIBFDT_OVERLAY and has no
> effect on boards that do not enable overlay support.
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 5 +++++
>  1 file changed, 5 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5a6dd23d93515029a596b5f77ebfa3..829a0109ac7807d692e127178f76d8822d5da5e2 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -555,6 +555,11 @@ int board_late_init(void)
>  	fdt_status |= !lmb_alloc(SZ_2M, &addr) ?
>  		env_set_hex("fdt_addr_r", addr) : 1;
>  
> +	if (IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY)) {
> +		status |= !lmb_alloc(SZ_1M, &addr) ?
> +			env_set_hex("fdtoverlay_addr_r", addr) : 1;
> +	}
> +
>  	if (status || fdt_status)
>  		log_warning("%s: Failed to set run time variables\n", __func__);
>  
> 
> ---
> base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
> change-id: 20260215-qcom-fdt-overlay-ec6b8d9d2a1b
> 
> Best regards,
> --
> Antony Kurniawan Soemardi <linux@smankusors.com>
> 
