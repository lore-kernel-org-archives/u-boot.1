Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A95C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 22:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84DAB80F51;
	Wed, 29 Jul 2026 22:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26GCc4sDXrg6; Wed, 29 Jul 2026 22:27:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB7CF80F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785364065;
	bh=bEuTYja8u5/KhFThTzOgp/+CdkwQiAhTrqH/C/GUFwk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=00WPh15d/tHQ9ASrWRbreoNghzTQ73LFmPeq+5KAzwpPfQkMbr1O6c4gCJoNcnwvv
	 Y+XgDF9L+2PGRJ+wGey9q3hLFNdnvJ1tojbDpdzagSq7P5/4aWFXdvfA4B++xFoQ8w
	 1wJDik1ristUk+RWmP/02wBOm96yTOSk7Vie3XrViU5+REAqlj5l4o4jXs7yPeEI9h
	 bC51jqUwhSX01n+qGCJWMHxgPUj73DpLoVNEFx0DLw3F10XX9ohmRulebsPF8JjP+p
	 jtCeF7PK5opnWk/YvGGCFkWLrztZODok7YDsJUbvP79/gqJ9TABqS/ktMXKAht5eEz
	 Xnikbol8NdQcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB7CF80F48;
	Wed, 29 Jul 2026 22:27:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 60D1226C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 472C94068A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpT4kIVx1-vN for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 22:27:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4EE6140684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EE6140684
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4EE6140684
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:27:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC508498B; Thu, 30 Jul 2026 00:27:37 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B40D8493F
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 00:27:34 +0200 (CEST)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-49ff971e903so134619b6e.0
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 15:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785364053; x=1785968853;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bEuTYja8u5/KhFThTzOgp/+CdkwQiAhTrqH/C/GUFwk=;
 b=KSSAPdfyejAXY6MuUBZLozky3t60o4LHpqy99EuRvjCaPigq3k3Pb+9ToWzMIi8YpI
 o2f68WrpDEIhQO0zi0Q6oGuenxeqad9bHBO8tUNV3Y3X3V7Esf4B/zrudxvySGD4OnwP
 oeI4YiRE0l7oi9NtB9B9uBHq5vQE4sE1IOH4yJ5kYCjOXzbm8DySBCVO4yIT7lyfU3tJ
 xybPYKfQgV4oPJVHdYPACE8YJ3SBbNki+kEmi/u6IaMwghP8naI3i/0eL9G47Ghp0u2+
 97d3LNsygxQZt+QeCqImHgC7STHsynrg4hn+PLZgW55q1Z0j83IPGW7pa2aC5lLhd5p6
 rz4w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp/Mq8LCrmngUQJvMlazRrMTbJRZF/iOcvgktV3bqYHo5g1RpW2Cra+KijsYfhutVC05EOyeZQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxOP8tYDu3VbFGyWv3acbBrN8LFNXE0PldofpAYawIwb574mCNq
 lGoS3s/8shpnXaHuk4HcC3Rx9vj4tb5U+GItRrc647ushc2c3jel/BUfnGUBrEySWfU=
X-Gm-Gg: AR+sD13LO2Ad1PPtX+LeBS3TxyKpbYi9/v4ryRPuzQ6qPa9oP0CG+Jq5INo1TH7kMpD
 yxRO1IkVtibhMy7qDMLZjcqWSIFkB/MFBarOXlCC4dxrK0kM8HcObF8YCuVsu/tCHNlSI2B26Xl
 BACxmd0P1Q/LGsDU6EQgwF8fUS+N1QeHlWvbGDf7T4pO2PU2gN4/smnJpi5VISJkCIIqrndzpu8
 obzJmdFUjylqrA5b/qoSMxeR3l/lFk9/K0lco8Gmr71vGaReIiuVxi40mdKdIXedVShxlprXvz2
 /v7wPkFa68CFn9rm0pmEK/s9tsK+OHVLlgDw8TJYEeJ1olHgJdyPStSxjSusy0HNZGrSy8WgLtm
 Wy01hpuX+S0hSsTLYClr8ej2tCZhy7nBaXIOSKH9pdyFYpt6L2FdY2utXbVRlXGo6gY4onGswrr
 M4fVZkduEq4WsA/h11/GV8VtEKf9Z7sayjHYsDxMs65xWq5FLw9J3HQrc/sKv8UWCfG3ee6DpHq
 /dVmeAqwbp1sUa2GBDrpgPEM8E/5RjDIKQzRlg=
X-Received: by 2002:a05:6808:190f:b0:4a4:933:dc11 with SMTP id
 5614622812f47-4ad888ccc21mr86236b6e.20.1785364052741; 
 Wed, 29 Jul 2026 15:27:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ea38:c35b:7ec6:8152?
 ([2600:8803:e7e4:500:ea38:c35b:7ec6:8152])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ad6efc8631sm2785973b6e.14.2026.07.29.15.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 15:27:32 -0700 (PDT)
Message-ID: <e0895741-aae1-438a-a7c1-cdad0ca6402e@baylibre.com>
Date: Wed, 29 Jul 2026 17:27:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 u-boot@lists.denx.de
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
 <20260723143852.2287208-3-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260723143852.2287208-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785364053; x=1785968853; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bEuTYja8u5/KhFThTzOgp/+CdkwQiAhTrqH/C/GUFwk=;
 b=nkA7dpT0ESrkG+5DaT+mZ9FCCZLSaEq/RrwT2AhpOulJrT3/ZqWjR6HcjSRVv9KvC9
 PFQMoY7ZoFTK1DdPVzx4SsGu4kywMxLO+0b4KFKHcEjQ9O5zN8YOIluQTeX3FEyoMZdZ
 szejTwM7v8kHeyBHjv84PSFDipXSqc2qnTICOYeMqRBP1fk8oKo4dL4cDLYUPdou1vng
 ZIACKPYk6yebY2RHszfTgBCbbRcqLOR0Q2zPEJqIT449DT7X53XDJbgR5osrZNh1ktkE
 t+mmK3RqyHXQzoQrgfTKIge0EgFQLpftCesZ2CN5SLhPrnxJdudruM4Y+wLrQq4suYIN
 I2nQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nkA7dpT0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="nkA7dpT0"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/23/26 9:38 AM, Jorge Ramirez-Ortiz wrote:
> OP-TEE secure storage (CFG_RPMB_FS) requires RPMB, but on UFS-only
> platforms with no eMMC the OP-TEE RPMB supplicant has no way to reach the
> device's RPMB Well-Known LUN, which UFS exposes through SCSI SECURITY
> PROTOCOL IN/OUT commands rather than an eMMC-style RPMB partition; this
> transport provides that missing path so RPMB-backed secure storage works
> on UFS-based platforms.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/Kconfig      |  10 +++
>  drivers/ufs/Makefile     |   1 +
>  drivers/ufs/ufs-rpmb.c   | 173 +++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/ufs-uclass.c |   6 +-
>  drivers/ufs/ufs.h        |   7 ++
>  include/scsi.h           |   2 +
>  include/ufs.h            |   4 +
>  7 files changed, 200 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/ufs/ufs-rpmb.c
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..99160a0819b 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -92,4 +92,14 @@ config UFS_TI_J721E
>  	  This selects the glue layer driver for Cadence controller
>  	  present on TI's J721E devices.
>  
> +config SUPPORT_UFS_RPMB
> +	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
> +	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
> +	help
> +	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
> +	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
> +	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
> +	  The OP-TEE supplicant handles a single RPMB transport, so this is
> +	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
> +
>  endmenu
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..d60440ca119 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
>  obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
>  obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
>  obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
> +obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> new file mode 100644
> index 00000000000..fb4cd42ad75
> --- /dev/null
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <dm.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <scsi.h>
> +#include <ufs.h>
> +#include <asm/cache.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include "ufs.h"
> +
> +#define RPMB_REQ_KEY		1
> +#define RPMB_REQ_WCOUNTER	2
> +#define RPMB_REQ_WRITE_DATA	3
> +#define RPMB_REQ_READ_DATA	4
> +#define RPMB_REQ_STATUS		5
> +
> +#define RPMB_FRAME_SIZE		512
> +#define RPMB_FRAME_REQ_OFFSET	510
> +
> +#define UFS_RPMB_UA_RETRIES	3
> +
> +#define SEC_PROTOCOL_UFS		0xEC
> +#define UFS_RPMB_SEC_PROTOCOL_ID	0x01
> +
> +#define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
> +
> +static u16 rpmb_frame_request(const void *frame)
> +{
> +	const u8 *p = frame;
> +
> +	return ((u16)p[RPMB_FRAME_REQ_OFFSET] << 8) |
> +		p[RPMB_FRAME_REQ_OFFSET + 1];
> +}

I would drop the function and just use get_unaligned_be16()
directly.

> +
> +static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
> +			    u8 opcode, void *buf, unsigned int nframes,
> +			    enum dma_data_direction dir)
> +{
> +	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
> +	u32 len = nframes * RPMB_FRAME_SIZE;
> +	struct scsi_cmd pccb;
> +	void *dma_buf = buf;
> +	void *bounce = NULL;
> +	int retries;
> +	int ret = 0;
> +
> +	if (!IS_ALIGNED((uintptr_t)buf, ARCH_DMA_MINALIGN)) {
> +		bounce = memalign(ARCH_DMA_MINALIGN,
> +				  ALIGN(len, ARCH_DMA_MINALIGN));
> +		if (!bounce)
> +			return -ENOMEM;
> +		dma_buf = bounce;
> +		if (dir == DMA_TO_DEVICE)
> +			memcpy(bounce, buf, len);
> +	}
> +
> +	memset(&pccb, 0, sizeof(pccb));
> +	pccb.lun = UFS_UPIU_RPMB_WLUN;
> +	pccb.cmd[0] = opcode;
> +	pccb.cmd[1] = SEC_PROTOCOL_UFS;
> +	pccb.cmd[2] = (spsp >> 8) & 0xff;
> +	pccb.cmd[3] = spsp & 0xff;

How about using put_unaligned_be16()?

> +	pccb.cmd[4] = 0;
> +	pccb.cmd[5] = 0;
> +	pccb.cmd[6] = (len >> 24) & 0xff;
> +	pccb.cmd[7] = (len >> 16) & 0xff;
> +	pccb.cmd[8] = (len >> 8) & 0xff;
> +	pccb.cmd[9] = len & 0xff;

And put_unaligned_be32().

> +	pccb.cmd[10] = 0;
> +	pccb.cmd[11] = 0;
> +	pccb.cmdlen = 12;
> +	pccb.pdata = dma_buf;
> +	pccb.datalen = len;
> +	pccb.dma_dir = dir;
> +
> +	for (retries = UFS_RPMB_UA_RETRIES; retries > 0; retries--) {
> +		ret = scsi_exec(scsi_dev, &pccb);
> +		if (!ret)
> +			break;
> +	}
> +
> +	if (bounce) {
> +		if (!ret && dir == DMA_FROM_DEVICE)
> +			memcpy(buf, bounce, len);
> +
> +		free(bounce);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
> +			 void *frames, unsigned int nframes)
> +{
> +	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_OUT,
> +				frames, nframes, DMA_TO_DEVICE);
> +}
> +
> +static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
> +			 void *frames, unsigned int nframes)
> +{
> +	return ufs_rpmb_secprot(scsi_dev, region, SCSI_SECURITY_PROTOCOL_IN,
> +				frames, nframes, DMA_FROM_DEVICE);
> +}
> +
> +int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
> +			  void *req, unsigned long reqlen, void *rsp,
> +			  unsigned long rsplen)
> +{
> +	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
> +	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
> +	u16 request;
> +	int ret;
> +
> +	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
> +	    rsplen % RPMB_FRAME_SIZE || !n_req)
> +		return -EINVAL;
> +
> +	request = rpmb_frame_request(req);
> +
> +	switch (request) {
> +	case RPMB_REQ_KEY:
> +	case RPMB_REQ_WRITE_DATA: {
> +		u8 status_frame[RPMB_FRAME_SIZE];
> +
> +		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
> +		if (ret)
> +			return ret;
> +
> +		memset(status_frame, 0, sizeof(status_frame));
> +		status_frame[RPMB_FRAME_REQ_OFFSET] = RPMB_REQ_STATUS >> 8;
> +		status_frame[RPMB_FRAME_REQ_OFFSET + 1] = RPMB_REQ_STATUS & 0xff;

put_unaligned_be16()

> +		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
> +		if (ret)
> +			return ret;
> +
> +		if (n_rsp < 1)
> +			return -EINVAL;
> +
> +		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
> +	}
> +	case RPMB_REQ_WCOUNTER:
> +	case RPMB_REQ_READ_DATA:
> +		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
> +		if (ret)
> +			return ret;
> +
> +		if (n_rsp < 1)
> +			return -EINVAL;
> +
> +		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
> +	default:
> +		debug("ufs-rpmb: unsupported request 0x%x\n", request);
> +		return -EINVAL;
> +	}
> +}
> +

> +static int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
> +{
> +	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> +	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
> +	int ret;
> +
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_GEOMETRY, 0, 0,
> +				     desc, sizeof(desc));
> +	if (ret)
> +		return ret;
> +
> +	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
> +
> +	return 0;
> +}

This function should be defered to the next patch were it is used.
Otherwise we could get compilers complaining during git bisect about
unused static function.

