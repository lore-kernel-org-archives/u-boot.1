Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CC8C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 12:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B9D826AA;
	Mon,  9 Jun 2025 14:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m3kEOnEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C98D82998; Mon,  9 Jun 2025 14:02:50 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C2D811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 14:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559C2jBh762060;
 Mon, 9 Jun 2025 07:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749470565;
 bh=9EuJ/7tLkriM4jWgZGEHyA2LWcfyQkAgmvIWqoaV/OY=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=m3kEOnEdJwEOTeTKxlYtpB+SXIhdIWhO05otSna/ZLPCWDTOsy7OL//x3mEP2y1DR
 SBL/kEcfH/UKqwJ8sXwQc9FTmooMnL5TlVkn+J62bom3pSn0mo9fj3uF2cOhpMPM/F
 8fj1NuTyEB7kW5srWR6JMXDfQdxxRRIN6mjGtCb8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559C2jLv063845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 07:02:45 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 07:02:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 07:02:45 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559C2iWO1369809;
 Mon, 9 Jun 2025 07:02:45 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 9 Jun 2025 17:32:10 +0530
Message-ID: <DAHZJMLNMEZ2.230MX338MEONB@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>,
 <bb@ti.com>
Subject: Re: [PATCH v7 08/10] mach-k3: common: enable falcon mode for 62
 platform
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-9-anshuld@ti.com>
 <20250606191502.GB1382132@bill-the-cat>
In-Reply-To: <20250606191502.GB1382132@bill-the-cat>
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

On Sat Jun 7, 2025 at 12:45 AM IST, Tom Rini wrote:
> On Tue, Jun 03, 2025 at 07:54:48PM +0530, Anshul Dalal wrote:
>> We use the spl_board_prepare_for_boot hook to call k3_falcon_prep which
>> is ran after tispl is loaded but before jump_to_image.
>>=20
>> In here, we find the boot media and load the image just as std falcon
>> flow (since spl_start_uboot returns 0 now). Once the kernel and args are
>> loaded, we perform fdt fixups on the fdt accompanying the kernel (if
>> loaded as FIT) or the loaded up args and return.
>>=20
>> Now when the flow goes to jump_to_image, we do the regular pre-jump
>> procedure and jump to ATF which jumps to the kernel directly since we
>> have already loaded the kernel and dtb at their respective addresses
>> (PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE).
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/common.c | 107 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index fc230f180d0..70317fec19c 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -259,8 +259,115 @@ static __maybe_unused void k3_dma_remove(void)
>>  		pr_warn("DMA Device not found (err=3D%d)\n", rc);
>>  }
>> =20
>> +#if IS_ENABLED(CONFIG_SPL_OS_BOOT) && !IS_ENABLED(CONFIG_ARM64)
>> +static bool tispl_loaded;
>> +
>> +int spl_start_uboot(void)
>> +{
>> +	if (!tispl_loaded)
>> +		return 1;
>> +	return 0;
>> +}
>> +
>> +static int k3_falcon_fdt_fixup(void *fdt)
>> +{
>> +	struct disk_partition info;
>> +	struct blk_desc *dev_desc;
>> +	char bootmedia[32];
>> +	char bootpart[32];
>> +	char str[256];
>> +	int ret;
>> +
>> +	strcpy(bootmedia, env_get("boot"));
>> +	strcpy(bootpart, env_get("bootpart"));
>
> Since we're talking secure parts, strncpy is even more important, and
> being aware of:
>  * Note that unlike userspace strncpy, this does not %NUL-pad the buffer.
>  * However, the result is not %NUL-terminated if the source exceeds
>  * @count bytes.
> from lib/string.c
>

Got it, I'll update the call to strncpy(bootmedia, env_get("boot"), 32)
in the next revision.

>> +	ret =3D blk_get_device_part_str(bootmedia, bootpart, &dev_desc, &info,=
 0);
>> +	if (ret < 0)
>> +		printf("Failed to get part details for %s %s [%d]\n", bootmedia,
>> +		       bootpart, ret);
>
> ... and bail out?
>

That makes sense, in secure world we should not be proceeding in such a
case regardless. I'll propogate the error to the top and hang at
spl_prepare_for_boot if anything fails.

> I feel like all the changes here need a read with "and on failure in secu=
re
> mode what can someone abuse this to do" in mind.

