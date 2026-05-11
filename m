Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89D7CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CD6847B0;
	Mon, 11 May 2026 12:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ky40vvF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50DCF8486A; Mon, 11 May 2026 12:51:12 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46AC6846AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW1AbeGMYUdFzys31k6193v3Jh0v6dfVLsdJ+S0oaiViye15CPG+ex9Yks0wu1iNDoH6lGlnPNrY4Bx/cHCVr0Jzxn0lhm+jzVnG/hb5l2oXsGbjI7XxvvjueD3qk1jhRETnsuZn6nOEorapqS+ACvoQe4VAb5DkrN6C3ByqHG7ocx87S5JCflMhExmeiWUETbWzcV/lacW2J4fei9yZQ5ElEico6uobXZwz3CmmXmTTj4Ps/AzgIiUvo3bD+UhCvg8DuNLeQ2g8a9ReLrpx+UBLGYvnMrIulcM5cniwydbfhOLCp8bmmzqhQtg7Vf5z6Fqua6tjDhLoBEAbVvsqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7Q+avAIspkomvsPOYfjzFYTNP/WZwDC0C3dK3Um4mA=;
 b=YVkVh8nrnIVnY04AKV20LU8MXQdyJ9Hi8J+K7rnYqqbqgOT2DcHoCTZ0YPkUAKuYum6AFVreZBXuvwzwnHDA6LpNYuf/IG7CkWhPKWlx8iQbTeXvSfo8AxM0A5eHyu952DAgzEfz6+qr8j5UItOSza+nuEhbVxpG8CKmqs4aB44ldrnqIEnE88JVQbhoavlsVXwYAo2ZVPZIcuuy+l768TbpHCyC+fKqPQP7wo41PpAuS3NTp2LU488LTs/CDlV9k3v2nOe5YRhySeO00LpfEJd6UFCI3yjHVufRDu7Dv8Jf9lrTQP8TiQKtyLtahTBw+WvxZ83d88gMMBDrg/EQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Q+avAIspkomvsPOYfjzFYTNP/WZwDC0C3dK3Um4mA=;
 b=Ky40vvF5orRt3L98Sd3WqSNWGqEEOH8ejlyyKXMtfVsfHpdnPV+AIMxmjq0z4SYKgkorj2xhl+F0u0XTbIqAIZjX1dybWsTPQccdIst2/2PmLYhXjaf2yiQ8IDUZwzFnDd91is+sMgkLAJ5faN09hQw32aZjAybfXR/EYqRPX8U=
Received: from SA9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::28)
 by DM4PR10MB7426.namprd10.prod.outlook.com (2603:10b6:8:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 10:51:06 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::86) by SA9P223CA0023.outlook.office365.com
 (2603:10b6:806:26::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:51:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:51:05 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:51:05 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:51:01 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:51:01 -0500
Received: from [172.24.26.211] (lt5cg60819vj.dhcp.ti.com [172.24.26.211])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BAou5E3211268;
 Mon, 11 May 2026 05:50:57 -0500
Message-ID: <061ce261-ac0a-4389-bca1-d69604c06059@ti.com>
Date: Mon, 11 May 2026 16:20:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] firmware: ti_sci: add low power mode operations
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-11-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260430084414.1354490-11-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DM4PR10MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 8990691f-80c8-4917-4e63-08deaf4b3376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|18002099003|22082099003|921020|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 32bTMXkBNAmex5IddkgUZAghegIB8MuUnWhETJde+llMiq/CywOd5Vk0loWigz/t9n/zOz64TVUEpoXvUAKA2bjqk9U+wSd2YDjhm+RPNUXe876RVFfFmBhPbh8QUj+ST5wu5PhPZMwJL6lORW+ExXEY4uzhZx3fH+sFwZ6wXNWzaqCDJyBuEVt6xguHEut+MPhumaJoJwqr9YftAodmFAtaX6GeGdL2T4Al7iZE+KPYijOOK8L8lNeZxFl1fsa4UMJUuIiiKekDja5ikZ0mEjIHY/HC8nMCsB1LttGKvqY7vjWg5DxN99bp3MTUzgeoSS5LbcfhFrHCCzCKKxHYlf/C79YP+q+UTTx0bfIkogjpUwo/MamzDI30MDVdXcwYbdchZmcJg5lT5o07OXn3aaM4xlqPop/OdAFYSHB2dIRnMf5As/sIGlw5lelT2I3Cr+z8dVeIYwTyESvZI1UfHntJB7XOCPNawkmyxSbwOKu8Arc9LziIvU3r+/Mp0kFkoOYRSyaKKHdrJiPubaQ7CBlhCMbFFjfyaarRpVceWybrD7Db17DW3nm7gWRiyPHTDCWH06DcFBhn/tlGwPHr5uvZ4/8yfi6FSYsQnkVmpiRv/R7Y6tCCOwaChGjgdI8vePqBknTksWfjymrOrF4ddvv9wNKnyzRJ3QVkriwW1FAY5lrWjS1GfAN3tXKvLQ1+cN2+3+mLLNdv1TlZ7tIOEVjaPMaEhpEkmJEkV3XeJ4kvfcJzG1RftOtVglqmCjTsUAXCK4Yalry/gCo88SdW7w==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(921020)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULTx/qOzzIMmjRTFieE8XXFuGfwTUW1eO66UE4tuW/Gr1a6VC/TfxC6MVz8hzDiMZYYpmjosqHYlNmfUyN4NjCPUYhdjeBS0xOWHWHoQNZmxVWtSTP7x6w9BybZqc3Ue2J5HUfInn910zNQFWYR3yCSr6xXZFbsPbSpwyeRRXAHT6h2PZOqzpM+s1TPnL+K3dGkusse1iQM7e6PXlhgyKH21f67gVu5B1hiVaZ44IAOP/W0Gyv3NdbXqRQZMVouR1cNqLnzvHueqcikt7a3XWP+cG0mVeuhZxByKOdjiJJyd2uwEY28ikpuVXxf7YzbNSNBXcsob2mEkc+fO1w5BiR4rc8XBB3GoMZUlYsWOD0I+C/IwvZg+gEdDcC8cjyb70DF+yyC0Q6+XssRfWiTalZXPerAFn3wHg5gcKXmk/Gv/hmI6xx8vn8Zpu0osBMLd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:51:05.3545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8990691f-80c8-4917-4e63-08deaf4b3376
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7426
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



On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
> From: Prasanth Babu Mantena <p-mantena@ti.com>
> 
> From: Prasanth Babu Mantena <p-mantena@ti.com>

Drop duplication above

> 
> On TI-k3 platform, at resume, uboot SPL needs to do several tasks:
> - restore TIFS minimal context from DDR
> - send DDR save address to TIFS
> - load TFA and its context in MSMC
> - set TFA resume vector to its warm_entrypoint
> - authenticate certificates and apply firewalls
> 
> All those operations are now done by TIFS with those messages:
> ti_sci_cmd_min_context_restore
> ti_sci_cmd_decrypt_tfa
> ti_sci_cmd_core_resume
> ti_sci_cmd_lpm_save_addr
> ti_sci_cmd_proc_auth_apply_fwls
> 
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
> https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/PROC_BOOT.html
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/include/mach/security.h |   1 +
>  arch/arm/mach-k3/security.c              |  64 ++++++++
>  drivers/firmware/ti_sci.c                | 179 +++++++++++++++++++++++
>  drivers/firmware/ti_sci.h                |  92 ++++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h   |   8 +
>  5 files changed, 344 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/include/mach/security.h b/arch/arm/mach-k3/include/mach/security.h
> index 8502b57bd80a..d9f31e1500a1 100644
> --- a/arch/arm/mach-k3/include/mach/security.h
> +++ b/arch/arm/mach-k3/include/mach/security.h
> @@ -9,3 +9,4 @@
>  #include <linux/types.h>
>  
>  void ti_secure_image_post_process(void **p_image, size_t *p_size);
> +void ti_secure_image_auth_apply_fwls(void **p_image, size_t *p_size);
> diff --git a/arch/arm/mach-k3/security.c b/arch/arm/mach-k3/security.c
> index c7017bba99ab..752912c6930a 100644
> --- a/arch/arm/mach-k3/security.c
> +++ b/arch/arm/mach-k3/security.c
> @@ -133,3 +133,67 @@ void ti_secure_image_post_process(void **p_image, size_t *p_size)
>  	      spl_boot_device() == BOOT_DEVICE_UART))
>  		printf("Authentication passed\n");
>  }
> +
> +void ti_secure_image_auth_apply_fwls(void **p_image, size_t *p_size)
> +{
> +	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
> +	struct ti_sci_proc_ops *proc_ops = &ti_sci->ops.proc_ops;
> +	u64 image_addr;
> +	u32 image_size, backup_size;
> +	int ret;
> +
> +	image_size = *p_size;
> +	backup_size = image_size;
> +	if (!image_size) {
> +		debug("%s: Image size is %d\n", __func__, image_size);
> +		return;
> +	}
> +
> +	if (get_device_type() == K3_DEVICE_TYPE_GP)
> +		return;
> +
> +	if (get_device_type() != K3_DEVICE_TYPE_HS_SE &&
> +	    !ti_secure_cert_detected(*p_image)) {
> +		printf("Warning: Did not detect image signing certificate. "
> +		       "Skipping authentication to prevent boot failure. "
> +		       "This will fail on Security Enforcing(HS-SE) devices\n");
> +		return;
> +	}
> +
> +	/* Clean out image so it can be seen by system firmware */
> +	image_addr = dma_map_single(*p_image, *p_size, DMA_BIDIRECTIONAL);
> +
> +	debug("Authenticating image at address 0x%016llx\n", image_addr);
> +	debug("Authenticating image of size %d bytes\n", image_size);
> +
> +	/* Authenticate image */
> +	ret = proc_ops->proc_auth_apply_fwls(ti_sci, &image_addr, &image_size);
> +	if (ret) {
> +		printf("Authentication failed..but assume pass!\n");
> +		hang();
> +	}
> +
> +	/* Invalidate any stale lines over data written by system firmware */
> +	if (backup_size)
> +		dma_unmap_single(image_addr, backup_size, DMA_BIDIRECTIONAL);
> +
> +	/*
> +	 * The image_size returned may be 0 when the authentication process has
> +	 * moved the image. When this happens no further processing on the
> +	 * image is needed or often even possible as it may have also been
> +	 * placed behind a firewall when moved.
> +	 */
> +	*p_size = backup_size;
> +
> +	/*
> +	 * Output notification of successful authentication to re-assure the
> +	 * user that the secure code is being processed as expected. However
> +	 * suppress any such log output in case of building for SPL and booting
> +	 * via YMODEM. This is done to avoid disturbing the YMODEM serial
> +	 * protocol transactions.
> +	 */
> +	if (!(IS_ENABLED(CONFIG_XPL_BUILD) &&
> +	      IS_ENABLED(CONFIG_SPL_YMODEM_SUPPORT) &&
> +	      spl_boot_device() == BOOT_DEVICE_UART))
> +		printf("Certificate replay passed\n");
> +}
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index c015bd3cc245..a40f2918d75f 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2014,6 +2014,62 @@ static int ti_sci_cmd_set_proc_boot_ctrl(const struct ti_sci_handle *handle,
>  	return ret;
>  }
>  
> +/**
> + * ti_sci_cmd_proc_auth_apply_fwls() - Command to authenticate certificate and
> + *				       apply the firewalls present in it.
> + * @handle:	Pointer to TI SCI handle
> + * @image_addr:	Memory address at which payload image and certificate is
> + *		located in memory, this is updated if the image data is
> + *		moved during authentication.
> + * @image_size: This is updated with the final size of the image after
> + *		authentication.
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_proc_auth_apply_fwls(const struct ti_sci_handle *handle,
> +					   u64 *image_addr, u32 *image_size)
> +{
> +	struct ti_sci_msg_req_proc_auth_boot_image req;
> +	struct ti_sci_msg_resp_proc_auth_boot_image *resp;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_PROC_AUTH_APPLY_FWLS,
> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&req, sizeof(req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		printf("%s Error making the tisci command\n", __func__);
> +		return ret;
> +	}
> +	req.cert_addr_low = *image_addr & TISCI_ADDR_LOW_MASK;
> +	req.cert_addr_high = (*image_addr & TISCI_ADDR_HIGH_MASK) >>
> +				TISCI_ADDR_HIGH_SHIFT;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +	if (ret) {
> +		printf("%s Error sending the tisci command\n", __func__);
> +		return ret;
> +	}
> +
> +	resp = (struct ti_sci_msg_resp_proc_auth_boot_image *)xfer->tx_message.buf;
> +
> +	*image_addr = (resp->image_addr_low & TISCI_ADDR_LOW_MASK) |
> +			(((u64)resp->image_addr_high <<
> +			  TISCI_ADDR_HIGH_SHIFT) & TISCI_ADDR_HIGH_MASK);
> +	*image_size = resp->image_size;
> +
> +	return ret;
> +}
> +
>  /**
>   * ti_sci_cmd_proc_auth_boot_image() - Command to authenticate and load the
>   *			image and then set the processor configuration flags.
> @@ -2745,6 +2801,125 @@ static int ti_sci_cmd_min_context_restore(const struct ti_sci_handle *handle, u6
>  	return ret;
>  }
>  
> +/**
> + * ti_sci_cmd_decrypt_tfa() - Request for decrypting TFA to specific address.
> + * @handle:    pointer to TI SCI handle
> + * @unencrypted_address: Address where the unencrypted TFA will be restored to.
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_decrypt_tfa(const struct ti_sci_handle *handle,
> +				  u64 unencrypted_address)
> +{
> +	struct ti_sci_msg_decrypt_tfa_req req;
> +	struct ti_sci_msg_decrypt_tfa_resp *resp;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_LPM_DECRYPT,
> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&req, sizeof(req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		return ret;
> +	}
> +
> +	req.unencrypted_address = unencrypted_address;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +
> +	return ret;
> +}
> +
> +/**
> + * ti_sci_cmd_core_resume() - Request for resuming TFA.
> + *
> + * The TIFS will launch the TFA from the entrypoint saved via the ENTER_SLEEP
> + * message.
> + *
> + * @handle:    pointer to TI SCI handle
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_core_resume(const struct ti_sci_handle *handle)
> +{
> +	struct ti_sci_msg_core_resume_req req;
> +	struct ti_sci_msg_core_resume_resp *resp;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_CORE_RESUME,
> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&req, sizeof(req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		return ret;
> +	}
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +
> +	return ret;
> +}
> +
> +/**
> + * ti_sci_cmd_lpm_save_addr() - Message to inform TIFS about the context save address.
> + *
> + * By restoring its context, TIFS will restore its firewall.
> + *
> + * @handle:    pointer to TI SCI handle
> + * @ctx_addr:  address where the context will be store to and restored from
> + * @size:	   Size of the context save region
> + *
> + * Return: 0 if all went well, else returns appropriate error value.
> + */
> +static int ti_sci_cmd_lpm_save_addr(const struct ti_sci_handle *handle,
> +				    u64 context_addr, u32 size)
> +{
> +	struct tisci_msg_lpm_save_ctx_addr_req req;
> +	struct tisci_msg_lpm_save_ctx_addr_resp *resp;
> +	struct ti_sci_info *info;
> +	struct ti_sci_xfer *xfer;
> +	int ret = 0;
> +
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	info = handle_to_ti_sci_info(handle);
> +
> +	xfer = ti_sci_setup_one_xfer(info, TISCI_MSG_LPM_SAVE_ADDR,
> +				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
> +				     (u32 *)&req, sizeof(req), sizeof(*resp));
> +	if (IS_ERR(xfer)) {
> +		ret = PTR_ERR(xfer);
> +		return ret;
> +	}
> +
> +	req.ctx_addr = context_addr;
> +	req.size = size;
> +
> +	ret = ti_sci_do_xfer(info, xfer);
> +
> +	return ret;
> +}
> +
>  /*
>   * ti_sci_setup_ops() - Setup the operations structures
>   * @info:	pointer to TISCI pointer
> @@ -2813,6 +2988,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	pops->set_proc_boot_cfg = ti_sci_cmd_set_proc_boot_cfg;
>  	pops->set_proc_boot_ctrl = ti_sci_cmd_set_proc_boot_ctrl;
>  	pops->proc_auth_boot_image = ti_sci_cmd_proc_auth_boot_image;
> +	pops->proc_auth_apply_fwls = ti_sci_cmd_proc_auth_apply_fwls;
>  	pops->get_proc_boot_status = ti_sci_cmd_get_proc_boot_status;
>  	pops->proc_shutdown_no_wait = ti_sci_cmd_proc_shutdown_no_wait;
>  
> @@ -2833,6 +3009,9 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
>  
>  	lpm_ops->min_context_restore = ti_sci_cmd_min_context_restore;
> +	lpm_ops->decrypt_tfa = ti_sci_cmd_decrypt_tfa;
> +	lpm_ops->core_resume = ti_sci_cmd_core_resume;
> +	lpm_ops->lpm_save_addr = ti_sci_cmd_lpm_save_addr;
>  }
>  
>  /**
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index 68908c6c8c46..8fb519b62dbd 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -57,6 +57,7 @@
>  #define TISCI_MSG_PROC_AUTH_BOOT_IMAGE	0xc120
>  #define TISCI_MSG_GET_PROC_BOOT_STATUS	0xc400
>  #define TISCI_MSG_WAIT_PROC_BOOT_STATUS	0xc401
> +#define TISCI_MSG_PROC_AUTH_APPLY_FWLS	0xc402
>  
>  /* Resource Management Requests */
>  #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
> @@ -85,6 +86,24 @@
>  #define TISCI_MSG_FWL_GET		0x9001
>  #define TISCI_MSG_FWL_CHANGE_OWNER	0x9002
>  
> +/* LPM requests */
> +#define TISCI_MSG_SYNC_RESUME			(0x0302U)
> +#define TISCI_MSG_CONTINUE_RESUME		(0x0303U)
> +#define TISCI_MSG_CORE_RESUME			(0x0304U)
> +#define TISCI_MSG_ABORT_ENTER_SLEEP		(0x0305U)
> +#define TISCI_MSG_LPM_WAKE_REASON		(0x0306U)
> +#define TISCI_MSG_SET_IO_ISOLATION		(0x0307U)
> +#define TISCI_MSG_MIN_CONTEXT_RESTORE		(0x0308U)
> +#define TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT	(0x0309U)
> +#define TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT	(0x030AU)
> +#define TISCI_MSG_LPM_GET_DEVICE_CONSTRAINT	(0x030BU)
> +#define TISCI_MSG_LPM_GET_LATENCY_CONSTRAINT	(0x030CU)
> +#define TISCI_MSG_LPM_GET_NEXT_SYS_MODE		(0x030DU)
> +#define TISCI_MSG_LPM_GET_NEXT_HOST_STATE	(0x030EU)
> +#define TISCI_MSG_LPM_ENCRYPT			(0x030FU)
> +#define TISCI_MSG_LPM_DECRYPT			(0x0310U)
> +#define TISCI_MSG_LPM_SAVE_ADDR			(0x0313U)
> +
>  /**
>   * struct ti_sci_msg_hdr - Generic Message Header for All messages and responses
>   * @type:	Type of messages: One of TI_SCI_MSG* values
> @@ -1588,4 +1607,77 @@ struct ti_sci_msg_min_restore_context_req {
>  	u32			ctx_hi;
>  } __packed;
>  
> +/*
> + * struct ti_sci_msg_core_resume_req - Request for TISCI_MSG_CORE_RESUME.
> + *
> + * @hdr:			Generic Header
> + *
> + * This message is to be sent to start the TFA on the main core.
> + * The TIFS will launch the TFA from the entrypoint saved via the ENTER_SLEEP
> + * message.
> + */
> +struct ti_sci_msg_core_resume_req {
> +	struct ti_sci_msg_hdr	hdr;
> +} __packed;
> +
> +/**
> + * struct ti_sci_msg_core_resume_resp - Response for TISCI_MSG_CORE_RESUME.
> + *
> + * @hdr:			Generic Header
> + */
> +struct ti_sci_msg_core_resume_resp {
> +	struct ti_sci_msg_hdr	hdr;
> +} __packed;
> +
> +/**
> + * struct ti_sci_msg_decrypt_tfa_req - Request for TISCI_MSG_LPM_DECRYPT.
> + *
> + * @hdr:			Generic Header
> + * @unencrypted_address:	Address where the TFA should be decrypted
> + * @encrypted_address:		Address where the TFA lies encrypted
> + *
> + * This message is to be sent when the system is resuming from suspend, in order
> + * to restore the TFA.
> + * The TIFS will decrypt the TFA at specified location and restore it in SRAM.
> + */
> +struct ti_sci_msg_decrypt_tfa_req {
> +	struct ti_sci_msg_hdr	hdr;
> +	u64			unencrypted_address;
> +} __packed;
> +
> +/**
> + * struct ti_sci_msg_decrypt_tfa_resp - Response for TISCI_MSG_LPM_DECRYPT.
> + *
> + * @hdr:			Generic Header
> + */
> +struct ti_sci_msg_decrypt_tfa_resp {
> +	struct ti_sci_msg_hdr	hdr;
> +} __packed;
> +
> +/**
> + * struct tisci_msg_lpm_save_ctx_addr_req - Request for TISCI_MSG_LPM_SAVE_ADDR.
> + *
> + * @hdr:			Generic Header
> + * @ctx_addr:	Address where the LPM data is to be saved
> + * @size:		Size of the context save memory region
> + *
> + * This message is sent to TIFS to inform it about the addresse where it
> + * will save the context to in case of system suspend and where to get the
> + * context back from when resuming the system
> + */
> +struct tisci_msg_lpm_save_ctx_addr_req {
> +	struct ti_sci_msg_hdr	hdr;
> +	u64			ctx_addr;
> +	u32			size;
> +} __packed;
> +
> +/**
> + * struct tisci_msg_lpm_save_ctx_addr_resp - Response for TISCI_MSG_SAVE_ADDR.
> + *
> + * @hdr:			Generic Header
> + */
> +struct tisci_msg_lpm_save_ctx_addr_resp {
> +	struct ti_sci_msg_hdr	hdr;
> +} __packed;
> +
>  #endif /* __TI_SCI_H */
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index 6b1dd801f5f8..1d0a6340e1ee 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -336,6 +336,8 @@ struct ti_sci_proc_ops {
>  				    u32 *sts_flags);
>  	int (*proc_shutdown_no_wait)(const struct ti_sci_handle *handle,
>  				     u8 pid);
> +	int (*proc_auth_apply_fwls)(const struct ti_sci_handle *handle,
> +				    u64 *image_addr, u32 *image_size);
>  };
>  
>  #define TI_SCI_RING_MODE_RING			(0)
> @@ -635,9 +637,15 @@ struct ti_sci_fwl_ops {
>  /**
>   * struct ti_sci_lpm_ops - Low Power Mode operations
>   * @min_context_restore: Request restoring context from DDR.
> + * @decrypt_tfa: Request for decrypting TFA at specific address.
> + * @core_resume: Request for resuming TFA once decrypted.
> + * @lpm_save_addr: Send DDR Save address to TIFS
>   */
>  struct ti_sci_lpm_ops {
>  	int (*min_context_restore)(const struct ti_sci_handle *handle, u64 ctx_addr);
> +	int (*decrypt_tfa)(const struct ti_sci_handle *handle,	u64 unencrypted_address);
> +	int (*core_resume)(const struct ti_sci_handle *handle);
> +	int (*lpm_save_addr)(const struct ti_sci_handle *handle, u64 context_addr, u32 size);
>  };
>  
>  /**

