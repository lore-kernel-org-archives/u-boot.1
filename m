Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD905C3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 06:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8162881C1;
	Mon, 16 Sep 2024 08:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VBpE6Mdh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62AB871C7; Mon, 16 Sep 2024 08:17:04 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D32788E5F
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 08:17:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vaishnav.a@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48G6Gx0k062445;
 Mon, 16 Sep 2024 01:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726467419;
 bh=CT1isYMFRbLJ1ItLOT0FLFxeAU1NeS/BS0H7UkpzarQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VBpE6Mdh+e/XU6/aDz+EgK8xzIbQZEv1aHbistQH4PlF+BdbamQQRDt6fwic1426i
 bTT7vFXNtvqucPKMVIV2yb2KIwbVq6ygvwe0Zig6/C+rtylFCBj/D/6fwudQH3a9jm
 Brs8wrjlTOqbsMWIi6H6GXZB0apDMn6VMT8SXtUg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48G6Gxvf017015;
 Mon, 16 Sep 2024 01:16:59 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Sep 2024 01:16:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Sep 2024 01:16:58 -0500
Received: from [10.24.69.142] ([10.24.69.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48G6GsxD105458;
 Mon, 16 Sep 2024 01:16:55 -0500
Message-ID: <c9e22782-8645-420c-9017-18f3aafcbb12@ti.com>
Date: Mon, 16 Sep 2024 11:46:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: sf: prevent overwriting the reserved memory
To: Prasad Kummari <prasad.kummari@amd.com>, <u-boot@lists.denx.de>,
 <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, "Kumar, Udit" <u-kumar1@ti.com>
References: <20240913073251.2286529-2-prasad.kummari@amd.com>
Content-Language: en-US
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20240913073251.2286529-2-prasad.kummari@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Prasad,

On 13/09/24 13:02, Prasad Kummari wrote:
> Added LMB API to prevent SF command from overwriting reserved
> memory areas. The current SPI code does not use LMB APIs for
> loading data into memory addresses. To resolve this, LMB APIs
> were added to check the load address of an SF command and ensure it
> does not overwrite reserved memory addresses. Similar checks are
> used in TFTP, serial load, and boot code to prevent overwriting
> reserved memory.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
> Changes in V4:
> - Removed do_spi_read_lmb_check().
> - Added the lmb_read_check() function in lmb.c, making it reusable for
>    NAND, MMC, etc.
> - Addressed review comments.
> 
> Changes in V3:
> - Removed lmb_init_and_reserve() as part of latest LMB series.
> - Error message moved to one place.
> - lmb_alloc_addr() is not required because the given memory address is
>    being checked to ensure it is free or not.
> 
> Changes in V2:
> - Rebased the code changes on top of the next branch.
> 
> UT:
> Tested on Versal NET board.
> 
> relocaddr   = 0x000000007febc000
> 
> Versal NET> sf read 0x000000007febc000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> Versal NET> sf write 0x000000007febc000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> 
> Versal NET> fdt print /reserved-memory
> reserved-memory {
> 	ranges;
> 	#size-cells = <0x00000002>;
> 	#address-cells = <0x00000002>;
> 	tf-a {
> 		reg = <0x00000000 0x70000000 0x00000000 0x00050000>;
> 		no-map;
> 	};
> };
> Versal NET> sf read 0x70000000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> Versal NET> sf write 0x70000000 0x0 0x40
> device 0 offset 0x0, size 0x40
> ERROR: trying to overwrite reserved memory...
> Versal NET> sf erase 0x0 0x1000000;mw.b 0x8000 aabbccdd 0x1000000;sf
> write 0x8000 0x0 0x1000000;mw.b 0x8008000 0x0 0x1000000;sf read
> 0x8008000 0x0 0x1000000;cmp.b 0x8000 0x8008000 0x01000000
> SF: 16777216 bytes @ 0x0 Erased: OK
> device 0 offset 0x0, size 0x1000000
> SF: 16777216 bytes @ 0x0 Written: OK
> device 0 offset 0x0, size 0x1000000
> SF: 16777216 bytes @ 0x0 Read: OK
> Total of 16777216 byte(s) were the same
> 
>   cmd/sf.c      | 8 ++++++++
>   include/lmb.h | 5 +++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/cmd/sf.c b/cmd/sf.c
> index f43a2e08b3..08e364e191 100644
> --- a/cmd/sf.c
> +++ b/cmd/sf.c
> @@ -10,6 +10,7 @@
>   #include <div64.h>
>   #include <dm.h>
>   #include <log.h>
> +#include <lmb.h>
>   #include <malloc.h>
>   #include <mapmem.h>
>   #include <spi.h>
> @@ -317,6 +318,13 @@ static int do_spi_flash_read_write(int argc, char *const argv[])
>   			strncmp(argv[0], "write", 5) == 0) {
>   		int read;
>   
> +		if (CONFIG_IS_ENABLED(LMB)) {
> +			if (lmb_read_check(addr, len)) {

Even though the function is named lmb_read_check(), it performs an alloc 
which is never freed, thus it makes it difficult for other callers to 
use the same region for other purposes (some callers use 
lmb_get_free_size() ), as mentioned in the commit message the check is 
only to prevent sf from overwriting reserved region, but it looks like 
this patch makes the load region also as reserved, is this necessary?


> +				printf("ERROR: trying to overwrite reserved memory...\n");
> +				return CMD_RET_FAILURE;
> +			}
> +		}
> +
>   		read = strncmp(argv[0], "read", 4) == 0;
>   		if (read)
>   			ret = spi_flash_read(flash, offset, len, buf);
> diff --git a/include/lmb.h b/include/lmb.h
> index fc2daaa7bf..aee2f9fcda 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -111,6 +111,11 @@ struct lmb *lmb_get(void);
>   int lmb_push(struct lmb *store);
>   void lmb_pop(struct lmb *store);
>   
> +static inline int lmb_read_check(phys_addr_t addr, phys_size_t len)
> +{
> +	return lmb_alloc_addr(addr, len) == addr ? 0 : -1;

who frees this? can we free this right after checking?

Thanks and Regards,
Vaishnav

> +}
> +
>   #endif /* __KERNEL__ */
>   
>   #endif /* _LINUX_LMB_H */
