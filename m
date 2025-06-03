Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EB9C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED28820EB;
	Tue,  3 Jun 2025 10:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v2bgvfPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EA54820EB; Tue,  3 Jun 2025 10:39:24 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2029B82103
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5538dJ3N470568;
 Tue, 3 Jun 2025 03:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748939959;
 bh=cRrYyusGrYShWauCYoN/dBEOKqrDsN8/rWr1rnN74S4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=v2bgvfPnzEvBURFLv8h20Khsk0B4naJ748z0GrymRzMZ5TShJLdbFUe8U6Y/MEqnW
 NQbwVzHoOGnsFgeyH+DicrgPDKju7oLEWSHgQf/P/wYz5eLRj3RLFO2BkMH3Q+9XPc
 GZ7OXEKcK4EwayRL7wC4N7dZAoLp13gY2DmA4fjo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5538dJsG3483842
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 03:39:19 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 03:39:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 03:39:19 -0500
Received: from [10.24.69.37]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5538dG4x082315;
 Tue, 3 Jun 2025 03:39:17 -0500
Message-ID: <f6f648a9-8c60-4423-a0c1-6a01ed7e0549@ti.com>
Date: Tue, 3 Jun 2025 14:09:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] arm: mach-k3: Add a function for printing DM version
To: Moteen Shah <m-shah@ti.com>, <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <d-gole@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-6-m-shah@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250528080519.677750-6-m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 28/05/25 13:35, Moteen Shah wrote:
> Add a function to print version of the DM firmware in use.
> The function queries the firmware capabilities first and if
> DM split mode bit is set, sends a request to TISCI for
> retrieving the version information.
> 
> The DM split mode bit indicates that DM is a separate binary
> altogether and hence it will have its own versioning.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 29 +++++++++++++++++++++++++++++
>  arch/arm/mach-k3/common.h |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index fa8cd93d664..524bb1da1a0 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -68,6 +68,35 @@ void k3_sysfw_print_ver(void)
>  	       ti_sci->version.firmware_revision, fw_desc);
>  }
>  
> +void __maybe_unused k3_dm_print_ver(void)
> +{
> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> +	struct ti_sci_firmware_ops *fw_ops = &ti_sci->ops.fw_ops;
> +	struct ti_sci_dm_version_info dm_info = {0};
> +	u64 fw_caps;
> +	int ret;
> +
> +	ret = fw_ops->query_dm_cap(ti_sci, &fw_caps);
> +	if (ret) {
> +		printf("Failed to query DM firmware capability %d\n", ret);
> +		return;
> +	}
> +
> +	if (!(fw_caps & TI_SCI_MSG_FLAG_FW_CAP_DM))
> +		return;
> +
> +	ret = fw_ops->get_dm_version(ti_sci, &dm_info);
> +	if (ret) {
> +		printf("Failed to fetch DM firmware version %d\n", ret);
> +		return;
> +	}
> +
> +	printf("DM ABI: %d.%d (firmware ver 0x%04x '%s--%s' "
> +	       "patch_ver: %d)\n", dm_info.abi_major, dm_info.abi_minor,
> +	       dm_info.dm_ver, dm_info.sci_server_version,
> +	       dm_info.rm_pm_hal_version, dm_info.patch_ver);
> +}
> +
>  void mmr_unlock(uintptr_t base, u32 partition)
>  {
>  	/* Translate the base address */
> diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
> index 7bd72da1de8..487291697d9 100644
> --- a/arch/arm/mach-k3/common.h
> +++ b/arch/arm/mach-k3/common.h
> @@ -38,6 +38,7 @@ void disable_linefill_optimization(void);
>  void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
>  int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
>  void k3_sysfw_print_ver(void);
> +void k3_dm_print_ver(void);
>  void spl_enable_cache(void);
>  void mmr_unlock(uintptr_t base, u32 partition);
>  bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
