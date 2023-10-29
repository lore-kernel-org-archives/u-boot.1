Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA85C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 05:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29E9874DB;
	Sun, 29 Oct 2023 06:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ZeDDhARg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A850A874DC; Sun, 29 Oct 2023 06:39:44 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A67874D8
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 06:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231029053936epoutp0131051de23692c7740e82bb3bdcbc207e~SfXrmuEJK1012710127epoutp01G
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 05:39:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231029053936epoutp0131051de23692c7740e82bb3bdcbc207e~SfXrmuEJK1012710127epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698557976;
 bh=ZvvZQrx2zmc0RVh+b4b0iZ6WBQMpXery9LPyBnMLGaY=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ZeDDhARgwylT8tFAEwZpF+HohmjcxWIAaghusSHQDatQUgd1pqIxofXoRoCXJAmYN
 uFviY7tuzxUqvLLkXDmhQQP5NUK22zkVkNQYH+7FPEK78pMD3npqRpc+sSLVwh1Ln8
 N+BzjYjBKMNsBtS3WMI8D+xDpRcGYTFss/XNcdxQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231029053936epcas2p4971801e0799cadd74424529d9163d133~SfXrYcySJ2193221932epcas2p4L;
 Sun, 29 Oct 2023 05:39:36 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SJ4wR3Yyjz4x9Pt; Sun, 29 Oct
 2023 05:39:35 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 BF.CC.09607.710FD356; Sun, 29 Oct 2023 14:39:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231029053935epcas2p31e68dff026cc1d3885ade88306ec33cc~SfXqi3N761273412734epcas2p3h;
 Sun, 29 Oct 2023 05:39:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231029053935epsmtrp24ef580d19e134008b80e120c939b0f9d~SfXqiSVzo2708027080epsmtrp2K;
 Sun, 29 Oct 2023 05:39:35 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-e1-653df0177fc1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 23.B3.08817.710FD356; Sun, 29 Oct 2023 14:39:35 +0900 (KST)
Received: from KORCO082417 (unknown [75.12.40.192]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231029053934epsmtip23015793bbda08bc538b7c8ecd60713db~SfXqYFwi50701007010epsmtip2C;
 Sun, 29 Oct 2023 05:39:34 +0000 (GMT)
From: "Chanho Park" <chanho61.park@samsung.com>
To: "'Heinrich Schuchardt'" <heinrich.schuchardt@canonical.com>, "'Rick
 Chen'" <rick@andestech.com>, "'Leo'" <ycliang@andestech.com>
Cc: "'Sughosh Ganu'" <sughosh.ganu@linaro.org>, <u-boot@lists.denx.de>
In-Reply-To: <20231028232612.109832-1-heinrich.schuchardt@canonical.com>
Subject: RE: [RFC 1/1] rng: Provide a RNG based on the RISC-V Zkr ISA extension
Date: Sun, 29 Oct 2023 14:39:34 +0900
Message-ID: <05e001da0a2a$4c9135a0$e5b3a0e0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQF/9HxSBlVeCM0jiHlogvUUv84v3AGwzHiKsQbjf5A=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTXFf8g22qwdJNkhYXGm+yW7x9cZbR
 4t41OYu3ezvZLR4fes3kwOqx5/QsZo9ZDb1sHneu7WHzOHtnB2MAS1S2TUZqYkpqkUJqXnJ+
 SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
 fmlJqkJGfnGJrVJqQUpOgXmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsaBs/eZCw5oVDxZcIu1
 gfG0fBcjJ4eEgInErVU7WLoYuTiEBHYwSuyZeZ4JwvnEKPG+4xAzhPONUWLl5/csMC2r1l2G
 SuxllJhwYjqU8wKo6vt5sCo2AX2Jlx3bWEESIgJtjBJnJ29nB0kwC7hJnHx2gw3E5hTwkJjw
 fykziC0sECjRfPQ1WA2LgKrExGNvwAbxClhKnGyZyAxhC0qcnPmEBWKOvMT2t3OYIU5SkPj5
 dBkrRFxc4uXRI2BzRASsJNpOLAO7TkJgIofE3+M9UA0uEvuubmOFsIUlXh3fwg5hS0l8frcX
 6DgOILtcYseyJIjeFkaJ5rY9UL32Ej9uTmEFqWEW0JRYv0sfolxZ4sgtqNP4JDoO/2WHCPNK
 dLQJQTSqSxzYPh0aiLIS3XM+s05gVJqF5LFZSB6bheSZWQi7FjCyrGIUSy0ozk1PLTYqMIHH
 dnJ+7iZGcJrU8tjBOPvtB71DjEwcjIcYJTiYlUR4mR1tUoV4UxIrq1KL8uOLSnNSiw8xmgKD
 eiKzlGhyPjBR55XEG5pYGpiYmRmaG5kamCuJ895rnZsiJJCeWJKanZpakFoE08fEwSnVwNS4
 kcXy8sm1a/NSBdx91vO/uTFbRj6rQen7Lwa2Ex4v6q6Fv7CWsr81eeO5iUv8ko2Zvl0yEVqX
 areUf+LSlMrtBvu/5pz6tFjFgenJzT+zHx05pnvvgcdX8/MRHIq7V/56+/MR+4TcteJOv8N6
 Tn/QZ4x++j7MYInlXbMLu7dOsP99y/j/6RtxD0OnLrRi3ReaFrT0x4Gkn8zZp1Kq/twq2X0o
 olQuu3th5F9LTXb3L3lS66pSLQ4FPOZTmnQxTH/X2U2Tb7yUl/x4TPuSR/6yJkH9Pc1bpe37
 W2M2CNz/kzrnwL/dKr8e7y84KTDr4WOBM+vri77PeurRqHRJP/rfV9HOU15PrBgK36ryli78
 psRSnJFoqMVcVJwIAFhD8nUcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42LZdlhJXlf8g22qwdkLLBYXGm+yW7x9cZbR
 4t41OYu3ezvZLR4fes3kwOqx5/QsZo9ZDb1sHneu7WHzOHtnB2MASxSXTUpqTmZZapG+XQJX
 xoGz95kLDmhUPFlwi7WB8bR8FyMnh4SAicSqdZeZQWwhgd2MEh8nxEHEZSWevdvBDmELS9xv
 OcLaxcgFVPOMUWLK790sIAk2AX2Jlx3bwBIiAh2MEns7nzF2MXJwMAt4SPw7KQnRMJNRYvbO
 2WANnEDxCf+Xgm0TFvCXWP70M5jNIqAqMfHYG7AaXgFLiZMtE5khbEGJkzOfsEDM1JNo28gI
 EmYWkJfY/nYOM8RxChI/ny5jhTn6z9G5bBA14hIvjx4Be0BEwEqi7cQyZphnXh3fwj6BUXQW
 kg2zEDbMQrJhFpJJCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBEeXltYOxj2r
 PugdYmTiYDzEKMHBrCTCy+xokyrEm5JYWZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs
 1NSC1CKYLBMHp1QDU+VNwxk/p7ju2r7eYkb3nc3m1w9xqTkyJ8Zxa7uuaFZxdJ+kLmClOsN3
 +fGdNR6Py+zt1a9+O3ymuYFr3RKFhbn7YmIYIhJfWZv7WzlY/fsgOLf274ZC1rYuvtCMh+1T
 3KN97N/MWhPl9jpcSz+y57he1/sy1metOofKjwZEOpbxeMZveuQeNiu3l2VXhMQeyePGBrMM
 rnxxfqd3oHzPujmu7oavHCSXfU8Vu66452hvaMrjrxOF1hx78OXQm+Rj6mYbpu9Y2byOt3VT
 yrQe2xUWK9vnVU7N4vQ/FJHitKDuyJfFrqwe3t/e/98r/pnPKPFb+TybiZWzXS69cW10dy71
 XZPY/eWQy5dTBX1NSizFGYmGWsxFxYkAVtSpmB0DAAA=
X-CMS-MailID: 20231029053935epcas2p31e68dff026cc1d3885ade88306ec33cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231028232641epcas2p48ab2b6db1932c3035028f44f16c831d8
References: <CGME20231028232641epcas2p48ab2b6db1932c3035028f44f16c831d8@epcas2p4.samsung.com>
 <20231028232612.109832-1-heinrich.schuchardt@canonical.com>
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

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Heinrich
> Schuchardt
> Sent: Sunday, October 29, 2023 8:26 AM
> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>; u-boot@lists.denx.de; Heinrich
> Schuchardt <heinrich.schuchardt@canonical.com>
> Subject: [RFC 1/1] rng: Provide a RNG based on the RISC-V Zkr ISA
> extension
> 
> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> provides an interface to a physical entropy source.
> 
> A RNG driver based on the seed CSR is provided. It depends on
> mseccfg.sseed being set in the SBI firmware.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

This works fine on my qemu risv with your opensbi patch and KASLR has been
tested as well.
Feel free to add my reviewed/tested-by tag.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Tested-by: Chanho Park <chanho61.park@samsung.com>

Best Regards,
Chanho Park

> ---
>  drivers/rng/Kconfig         |  11 ++++
>  drivers/rng/Makefile        |   1 +
>  drivers/rng/riscv_zkr_rng.c | 102 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 drivers/rng/riscv_zkr_rng.c
> 
> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 994cc35b27..f8f1d91ed2 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -48,6 +48,17 @@ config RNG_OPTEE
>  	  accessible to normal world but reserved and used by the OP-TEE
>  	  to avoid the weakness of a software PRNG.
> 
> +config RNG_RISCV_ZKR
> +	bool "RISC-V Zkr random number generator"
> +	depends on RISCV_SMODE
> +	help
> +	  This driver provides a Random Number Generator based on the
> +	  Zkr RISC-V ISA extension which provides an interface to an
> +	  NIST SP 800-90B or BSI AIS-31 compliant physical entropy source.
> +
> +	  Using this driver will lead to an exception if the M-mode
> firmware
> +	  has not set mseccfg.sseed=1.
> +
>  config RNG_STM32
>  	bool "Enable random number generator for STM32"
>  	depends on ARCH_STM32 || ARCH_STM32MP
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 47b323e61e..a5d3ca4130 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_RNG_MSM) += msm_rng.o
>  obj-$(CONFIG_RNG_NPCM) += npcm_rng.o
>  obj-$(CONFIG_RNG_OPTEE) += optee_rng.o
>  obj-$(CONFIG_RNG_STM32) += stm32_rng.o
> +obj-$(CONFIG_RNG_RISCV_ZKR) += riscv_zkr_rng.o
>  obj-$(CONFIG_RNG_ROCKCHIP) += rockchip_rng.o
>  obj-$(CONFIG_RNG_IPROC200) += iproc_rng200.o
>  obj-$(CONFIG_RNG_SMCCC_TRNG) += smccc_trng.o
> diff --git a/drivers/rng/riscv_zkr_rng.c b/drivers/rng/riscv_zkr_rng.c
> new file mode 100644
> index 0000000000..f48ae35410
> --- /dev/null
> +++ b/drivers/rng/riscv_zkr_rng.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * The RISC-V Zkr extension provides CSR seed which provides access to a
> + * random number generator.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RNG
> +
> +#include <common.h>
> +#include <dm.h>
> +#include <rng.h>
> +
> +#define DRIVER_NAME "riscv_zkr"
> +
> +enum opst {
> +	/** @BIST: built in self test running */
> +	BIST = 0b00,
> +	/** @WAIT: sufficient amount of entropy is not yet available */
> +	WAIT = 0b01,
> +	/** @ES16: 16bits of entropy available */
> +	ES16 = 0b10,
> +	/** @DEAD: unrecoverable self-test error */
> +	DEAD = 0b11,
> +};
> +
> +static unsigned long read_seed(void)
> +{
> +	unsigned long ret;
> +
> +	__asm__ __volatile__("csrrw %0, seed, x0" : "=r" (ret) : :
> "memory");
> +
> +	return ret;
> +}
> +
> +static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
> +{
> +	u8 *ptr = data;
> +
> +	while (len) {
> +		u32 val;
> +
> +		val = read_seed();
> +
> +		switch (val >> 30) {
> +		case BIST:
> +			continue;
> +		case WAIT:
> +			continue;
> +		case ES16:
> +			*ptr++ = val & 0xff;
> +			if (--len) {
> +				*ptr++ = val >> 8;
> +				--len;
> +			}
> +			break;
> +		case DEAD:
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * riscv_zkr_probe() - check if the seed register is available
> + *
> + * If the SBI software has not set mseccfg.sseed=1 or the Zkr
> + * extension is not available this probe function will result
> + * in an exception. Currently we cannot recover from this.
> + *
> + * @dev:	RNG device
> + * Return:	0 if successfully probed
> + */
> +static int riscv_zkr_probe(struct udevice *dev)
> +{
> +	u32 val;
> +
> +	do {
> +		val = read_seed();
> +		val >>= 30;
> +	} while (val == BIST || val == WAIT);
> +
> +	if (val == DEAD)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> +static const struct dm_rng_ops riscv_zkr_ops = {
> +	.read = riscv_zkr_read,
> +};
> +
> +U_BOOT_DRIVER(riscv_zkr) = {
> +	.name = DRIVER_NAME,
> +	.id = UCLASS_RNG,
> +	.ops = &riscv_zkr_ops,
> +	.probe = riscv_zkr_probe,
> +};
> +
> +U_BOOT_DRVINFO(cpu_riscv_zkr) = {
> +	.name = DRIVER_NAME,
> +};
> --
> 2.40.1


