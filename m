Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58356FF6E7F
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 20:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8519E8407E;
	Tue, 17 Mar 2026 21:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sMqt6Axj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85F138409B; Tue, 17 Mar 2026 21:59:10 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237B38405E
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 21:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46704177543so66056b6e.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773781147; x=1774385947;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2cShVYUEsbh66U88/u3opim8EZIhdKMLODlV8+riNds=;
 b=sMqt6AxjUG5XjC+Wu7mcFW+MdPss6scBmYBE/BIr5nTxZexe7/dxrcMLDUny14I/cV
 BfxWWZjXjCNITkn65XO9y0IgCw/kqY3KRG+b2Q3O/qV6xjXeXNbgSGdo6YCiS8AbxO62
 ie/0WM2da9ECqmtYOrmb0pYP4HqRY2OrsWvnuJ3NpAuc4b3dsDRLRZ4x5xvyjFouuOQM
 71qLvMHlWEdddN3qcqfeuaWilYCnJxkIgxZyrBWh/ZyhrpHIyWfj6L/M0RNEPJAwEhG3
 0xVs+sN/XK2Q4wvt5AYsLsvPu6L9uUUL3vlSAbvnl+uDGc+XJuKoEHfG9/8kB6vWRdbq
 NzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773781147; x=1774385947;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2cShVYUEsbh66U88/u3opim8EZIhdKMLODlV8+riNds=;
 b=C8ioU/wWcsjgNekJcnuN8S2MlylsNOYiRe7f8lBcHC48U9hRCnT6CbcVOaJKS8O3w1
 nSm8vhyz1xDCb9oI6N+UqksUNnBNs0/cgLDUZhmzcK/yUqxaIKk8fS484gvVORcynQSE
 Uvfx3mCMtm1t0sug/iEe1We4cbjXsonbnJcxXDvRKGLMIa7uyXdtvoOllqjp0dqegevz
 c3k3Oy0zZyaNb1eTjbfadN0MMmsOCq1EH8lfIobM0wTp86+4SLTUGFkMM6tf6sL2i0q+
 G0dxhi2cYukPTIpOesO0wFJ+aYPecgWHIArnItXCRUCx7IUpNasWKDa5VCsmTlwzo6cv
 xsYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlW5vrOTIZgV0Ii38xiEgg0pqzD5JRs25x1J5jYBummT4P5nEKHl2OP+3RWwfXBvY5ljVUM6s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9SgEZwqnDp16jwI2/FdmqD4bhClrcLJFiDXH78KZQpp7nM9/A
 9Zf0hXeX107dqrlihr2mqyoKLBARmJvujScTKNIwNHyC860HHixS4MMbCxBiZTjhw/Q=
X-Gm-Gg: ATEYQzwfpGIU5Vc9eklbG15y9YFmqST6ksaoApQmV2J9L3csCNHuxcebmiBee2dAQtL
 3vOiICRNNIRT+XCnQ43/idN8LrN4GZz8+f4eqEx48bX/fvjgWevQ+wlkpZtLHkTAcZi2HpnKMK6
 Di3Q4DR1XnR9M4eSMT6/8mNPuuutv/jnLZCMMQBTAmJby5NdtCEja/hRtmFvY/9t3mmkM4sDuLv
 ql5kHZOLBbsouC11TiUCAMkNS7vhfmk47ym6t2Thc/Bmbr0BsuCAZlZd7CLJcbWevzo42fJ3vAO
 GzhKeasKzg1YtNhi0ZnpPEzgIuddlYZsIbiHfkcvG1C2cSOeAHwOzkGQwrM6anVaNmfN+FO4hBB
 EMrMNka9gqArhWXCU0MwUjoNbjyzEd2msxWZDEzNeEuHeAQJUmtcPcIyZj48uTKF/p7EfSKlAnq
 0sU5Qhd2NH3HMnFPSJq5ua6VbLMdLVy1RfmwsOVjGBw4Q1N6TtKwVvr1eOzO6XobWrw4zNFNc=
X-Received: by 2002:a05:6808:e85:b0:44f:6a19:433e with SMTP id
 5614622812f47-467ba1ea603mr575374b6e.15.1773781146692; 
 Tue, 17 Mar 2026 13:59:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6995:28aa:eeda:102?
 ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2c30b0fsm700729fac.10.2026.03.17.13.59.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 13:59:06 -0700 (PDT)
Message-ID: <3e77f9b8-9971-480a-9a0e-38ba44838fa8@baylibre.com>
Date: Tue, 17 Mar 2026 15:59:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] power: pmic: mtk-pwrap: add MT8195 support
From: David Lechner <dlechner@baylibre.com>
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-1-7d731ec438ae@baylibre.com>
 <d1e9afe8-4dc5-4994-b278-dca8384d8bb0@baylibre.com>
Content-Language: en-US
In-Reply-To: <d1e9afe8-4dc5-4994-b278-dca8384d8bb0@baylibre.com>
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

On 3/17/26 3:24 PM, David Lechner wrote:
> On 3/17/26 9:24 AM, Julien Stephan wrote:
>> Add mt8195 support.
>> Support comes directly from commit e88edc977b00 ("soc: mediatek: pwrap:
>> add pwrap driver for MT8195 SoC") from the Linux Kernel
>>
>> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>> ---
>>  drivers/power/pmic/mtk-pwrap.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
>> index 3e3a691d9e8..8ff6458a5f2 100644
>> --- a/drivers/power/pmic/mtk-pwrap.c
>> +++ b/drivers/power/pmic/mtk-pwrap.c
>> @@ -276,6 +276,23 @@ static int mt8189_regs[] = {
>>  	[PWRAP_WACS2_RDATA] =		0x8A8,
>>  };
>>  
>> +static int mt8195_regs[] = {
>> +	[PWRAP_INIT_DONE2] =		0x0,
>> +	[PWRAP_STAUPD_CTRL] =		0x4C,
>> +	[PWRAP_TIMER_EN] =		0x3E4,
>> +	[PWRAP_INT_EN] =		0x420,
>> +	[PWRAP_INT_FLG] =		0x428,
>> +	[PWRAP_INT_CLR] =		0x42C,
>> +	[PWRAP_INT1_EN] =		0x450,
>> +	[PWRAP_INT1_FLG] =		0x458,
>> +	[PWRAP_INT1_CLR] =		0x45C,
>> +	[PWRAP_WACS2_CMD] =		0x880,
>> +	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
>> +	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
>> +	[PWRAP_WACS2_VLDCLR] =		0x8A4,
>> +	[PWRAP_WACS2_RDATA] =		0x8A8,
>> +};
> 
> I think we need to take a harder look at the driver here. There are many
> registers that are accessed unconditionally in the code that aren't defined
> here. (It looks like the Linux driver has similar issues as well. And we
> have the same problem with mt8188 and mt8189 here in U-Boot.)
> 
> So either the code is broken and should have more conditionals or the
> register tables are incomplete.
> 
> Most of this is in pwrap_init() which is conditional on an earlier bootloader
> doing the initialization. If that is the case, we could avoid the issue
> by adding a capability flag PWRAP_CAP_INIT and use that to avoid calling
> pwrap_init() when we don't have the registers defined and raise an error
> instead.
> 
> 
> 	/*
> 	 * The PMIC could already be initialized by the bootloader.
> 	 * Skip initialization here in this case.
> 	 */
> 	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
> +		if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_INIT)) {
> +			dev_err(dev, "PMIC is not initialized\n");
> +			return -EINVAL;
> +		}
> +
> 		ret = pwrap_init(wrp);
> 		if (ret) {
> 			dev_err(dev, "init failed with %d\n", ret);
> 			return ret;
> 		}
> 	}
> 
FYI, I've prepared a patch and tested this on Genio 720 (mt8189 in this
context), so it seems OK to do this at least on that platform. An earlier
bootloader is initializing the PMIC already. I'll wait to send it though
until we get feedback on the other issues.
