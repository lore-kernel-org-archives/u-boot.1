Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2414C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 12:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED645822D7;
	Thu,  8 May 2025 14:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G4uI82G1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03F28283E; Thu,  8 May 2025 14:10:48 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC0282153
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 14:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 548CAe4L1083490
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 07:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746706240;
 bh=Np/epCeL3huNT5hvrR9ldKYLNUkhNPznVpNkquag+T4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=G4uI82G1LQo3tvUNOFEMGI+H/XibNa+Z8skHnVajZzaCjLdATsg0SvsF1MlFYeokU
 djVLYsfCg8DGtuhGrbRHKL0hs1uXVALNKr5gO0N8W98EZuaZHjrKJFwgNqnTDmuS2Z
 pR1ygiNa7kfYDzXJLpeXKELVDjraWuXCZ9Aju/sA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 548CAeAJ077541
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 8 May 2025 07:10:40 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 May 2025 07:10:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 May 2025 07:10:40 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 548CAdNt002803;
 Thu, 8 May 2025 07:10:40 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 8 May 2025 17:40:18 +0530
Message-ID: <D9QROEXZH6QD.3FBXQDNA35TUI@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>, <trini@konsulko.com>, <afd@ti.com>
CC: <sjg@chromium.org>, <xypron.glpk@gmx.de>, <cfsworks@gmail.com>,
 <nm@ti.com>, <hnagalla@ti.com>, <n-francis@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <kamlesh@ti.com>, <bb@ti.com>,
 <j-humphreys@ti.com>, <s-k6@ti.com>, <j-choudhary@ti.com>,
 <d-gole@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 7/7] arm: mach-k3: r5: common: Add support to boot
 HSM M4 core
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250506104202.16741-1-b-padhi@ti.com>
 <20250506104202.16741-8-b-padhi@ti.com>
In-Reply-To: <20250506104202.16741-8-b-padhi@ti.com>
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

On Tue May 6, 2025 at 4:12 PM IST, Beleswar Padhi wrote:
> The tispl.bin fit image is packed with the HSM firmware image. Populate
> the "os" info of the image so that it can be detected and used to load
> the HSM core. Further, invoke the load and boot of HSM core at R5 SPL
> stage. Boot flow for HSM M4 core is as below:
>
> 1. Request control of HSM M4F remote processor.
> 2. Assert Reset on the HSM M4F remote processor.
> 3. For HS devices, Request Secure Entity to Authenticate and Load HSM
>    firmware into core's internal SRAM memory region. For GP devices,
>    load the unsigned firmware manually.
> 4. Deassert Reset on the HSM M4F remote processor.
> 5. Release control of HSM M4F remote processor.
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v2: Changelog:
> 1. Hang system boot if HSM firmware failed to boot.
> 2. __maybe_unused to decrease preprocessor usage.
> 3. Better error messages with return code.
> 4. Added Error case in if-elseif-else ladder.
>
> Note:
> #define PROC_ID_HSM_M4F seems to have extra tab in the diff/patch.
> But when patch gets applied in file, all of them have consistent
> tabs.
>
> Link to v1:
> https://lore.kernel.org/all/18e01808-499d-4690-995a-45ac5fd727d9@ti.com
>
>  arch/arm/mach-k3/r5/common.c | 84 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
> index 81fc67a0023..1aa3869cec2 100644
> --- a/arch/arm/mach-k3/r5/common.c
> +++ b/arch/arm/mach-k3/r5/common.c
> @@ -15,9 +15,14 @@
>  #include <spl.h>
>  #include <remoteproc.h>
>  #include <elf.h>
> +#include <cpu_func.h>
> =20
>  #include "../common.h"
> =20
> +#define PROC_BOOT_CTRL_RESET_FLAG_HSM_M4	0x00000001
> +#define HSM_SRAM0_0_ADDR			0x43C00000
> +#define PROC_ID_HSM_M4F				0x00000080
> +
>  #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>  enum {
>  	IMAGE_ID_ATF,
> @@ -27,6 +32,7 @@ enum {
>  	IMAGE_ID_TIFSSTUB_HS,
>  	IMAGE_ID_TIFSSTUB_FS,
>  	IMAGE_ID_T,
> +	IMAGE_ID_HSM,
>  	IMAGE_AMT,
>  };
> =20
> @@ -39,6 +45,7 @@ static const char *image_os_match[IMAGE_AMT] =3D {
>  	"tifsstub-hs",
>  	"tifsstub-fs",
>  	"tifsstub-gp",
> +	"hsm",
>  };
>  #endif
> =20
> @@ -136,6 +143,73 @@ void release_resources_for_core_shutdown(void)
>  	}
>  }
> =20
> +static int __maybe_unused boot_hsm_core(void)
> +{
> +	struct ti_sci_handle *ti_sci =3D get_ti_sci_handle();
> +	struct ti_sci_proc_ops *proc_ops =3D &ti_sci->ops.proc_ops;
> +	u64 hsm_image_addr;
> +	u32 hsm_image_size;
> +	int device_type, ret;
> +
> +	hsm_image_addr =3D (u64)fit_image_info[IMAGE_ID_HSM].load;
> +	hsm_image_size =3D (u32)fit_image_info[IMAGE_ID_HSM].image_len;
> +
> +	/* Request Control of Remote Processor */
> +	ret =3D proc_ops->proc_request(ti_sci, PROC_ID_HSM_M4F);
> +	if (ret) {
> +		printf("Unable to request HSM processor control: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Put the remote processor into reset */
> +	ret =3D proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_HSM_M4F,
> +					   PROC_BOOT_CTRL_RESET_FLAG_HSM_M4, 0);
> +	if (ret) {
> +		printf("Unable to Halt HSM core: %d\n", ret);
> +		goto release_proc_ctrl;
> +	}
> +
> +	/*
> +	 * Load the HSM firmware into core's internal memory.
> +	 *
> +	 * In case of HS device types, request secure entity to authenticate an=
d
> +	 * load the HSM firmware into the core memory.
> +	 * In case of GP device types, copy the HSM firmware into the core
> +	 * memory manually.
> +	 */
> +	device_type =3D get_device_type();
> +	if (device_type =3D=3D K3_DEVICE_TYPE_HS_SE ||
> +	    device_type =3D=3D K3_DEVICE_TYPE_HS_FS) {
> +		ret =3D proc_ops->proc_auth_boot_image(ti_sci, &hsm_image_addr,
> +						     &hsm_image_size);
> +		if (ret) {
> +			printf("Unable to Authenticate and Boot HSM image; ret =3D %d\n",
> +			       ret);
> +			goto release_proc_ctrl;
> +		}
> +	} else if (device_type =3D=3D K3_DEVICE_TYPE_GP) {
> +		debug("Loading HSM GP binary into SRAM0_0\n");
> +		memcpy((void *)HSM_SRAM0_0_ADDR, (void *)(u32)hsm_image_addr,
> +		       hsm_image_size);
> +		flush_dcache_range(HSM_SRAM0_0_ADDR,
> +				   HSM_SRAM0_0_ADDR + hsm_image_size);
> +	} else {
> +		printf("Invalid Device Type\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Release the reset from the remote processor*/
> +	ret =3D proc_ops->set_proc_boot_ctrl(ti_sci, PROC_ID_HSM_M4F, 0,
> +					   PROC_BOOT_CTRL_RESET_FLAG_HSM_M4);
> +	if (ret)
> +		printf("Unable to Run HSM core: %d\n", ret);
> +
> +release_proc_ctrl:
> +	/* Release Control of Remote Processor */
> +	proc_ops->proc_release(ti_sci, PROC_ID_HSM_M4F);
> +	return ret;
> +}
> +
>  void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>  {
>  	typedef void __noreturn (*image_entry_noargs_t)(void);
> @@ -157,6 +231,14 @@ void __noreturn jump_to_image_no_args(struct spl_ima=
ge_info *spl_image)
>  				     &loadaddr);
>  	}
> =20
> +#if IS_ENABLED(CONFIG_K3_HSM_FW)
> +	ret =3D boot_hsm_core();
> +	if (ret)
> +		panic("HSM core failed to boot, %d\n", ret);
> +	else
> +		printf("Successfully booted HSM core\n");
> +#endif
> +
>  	/*
>  	 * It is assumed that remoteproc device 1 is the corresponding
>  	 * Cortex-A core which runs ATF. Make sure DT reflects the same.
> @@ -388,7 +470,7 @@ void board_fit_image_post_process(const void *fit, in=
t node, void **p_image,
>  	 * Only DM and the DTBs are being authenticated here,
>  	 * rest will be authenticated when A72 cluster is up
>  	 */
> -	if ((i !=3D IMAGE_ID_ATF) && (i !=3D IMAGE_ID_OPTEE)) {
> +	if (i !=3D IMAGE_ID_ATF && i !=3D IMAGE_ID_OPTEE && i !=3D IMAGE_ID_HSM=
) {
>  		ti_secure_image_check_binary(p_image, p_size);
>  		ti_secure_image_post_process(p_image, p_size);
>  	} else {

A minor nit but this and the following else block can be refactored as:

ti_secure_image_check_binary(p_image, p_size);
if (i !=3D IMAGE_ID_ATF && i !=3D IMAGE_ID_OPTEE && i !=3D IMAGE_ID_HSM) {
	ti_secure_image_post_process(p_image, p_size);
}

Regards,
Anshul



