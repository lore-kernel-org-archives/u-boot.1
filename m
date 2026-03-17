Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E58FD7091
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 20:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C9C83FAF;
	Tue, 17 Mar 2026 21:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gZzH9Iv7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521B58410C; Tue, 17 Mar 2026 21:24:07 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CAB83FA3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 21:24:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-41708f6c3feso4014575fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773779043; x=1774383843;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8QOP3gF5BVdKJrBD1Dk84QRbMr++i1MMLQ+Tm0hCGEU=;
 b=gZzH9Iv7oz6m15XWYPTcdIEwbLgk5Czhe680n4YTPaj8459eA//n5ojDZNduA/2c/h
 rxeJ4XpR6iDSq/ERcvNF3W7lfqt/A9ElWhntjpGvbjpT3Pyj1SmJ/ZiQqv3Ip54Izy+H
 8J+j3zInXJM/XdLrscdpx0OMQPJzBn52nROodf8Kx+vuz9dM/D86UlASK+QXy+MEnlm/
 n9j9p88cAXIPGg8R4oJLZwqxwsli9nZN044gheT9R5Jf9IJW/cH0tMUA9BXLCqp1tA/L
 Pzb1RtbBCDIMYGu4ZwsFQkoIGsrXS8Dj7oPeTYyV4beaZzrlqso1vD+4cG8xXiLpwcKq
 W/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773779043; x=1774383843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8QOP3gF5BVdKJrBD1Dk84QRbMr++i1MMLQ+Tm0hCGEU=;
 b=PcjtSfLFaQuqYXI2/jDzwDcWs/vtkUU8Jjr3BdXb4q8+qI67fvHLJCCf9gN1dIoH17
 QuQr7hk/OFPZVnnLai8DrotfhpgmDNcg5RrtdWPZHp/Po18/a1/VEJkse56Rs5ItS+5c
 YdWs5C1EW+MUaO6qYsk8pNHQ3HiZFaRV8YlqFWxtkT51i+x+2pbh1Mw8/lt2wGpoCdhl
 QZrbVPNvZIHAMIVr9QByeUielYeONqhwtUUnYF1iR7PY8fSmZzGXuXmlUNYFW3KOjf9I
 VJSWT5kbtAziUM0jwU8L6QUqB7Tvmz7TrnWHZwXULSWwdwg8b8dTkho2GCp6O592Jk9D
 bpSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZReG5FF36Whai4MRb3obqzUEZv1zd47jTuOWGDiQGiA0qPgrYXrbFhYLqP8moAi792KA/FfM=@lists.denx.de
X-Gm-Message-State: AOJu0YwBn1Ig4OhIw/uOCKBEuDMw1SfdO904ZHCnogAyqqLFiw9RqRZO
 0RC4V0gp+HGmM8RWUhFOeiDAyBGMjvRKzkahzF2yMymha8Ru2AsKCj+xqzhKK2Q+Rnk=
X-Gm-Gg: ATEYQzysJs7+f6LKXz9bjG/qR1ZpDu8cYqnPTOJ10iL+HjaKSW/wW/LBLpYFrkmqUmS
 1VqzBK4hR3VpeWz+i0DjNWxB2X91PScdShngahtftmC6SiKHMZ6IHoawzPzUc5EY0c15RtpPftr
 +cyX/zqLEuVs8C4RENlLs93ywtf3DfCKnQGOToVuxicbo6FnBJWbMsm/GyoNYvGhVsOsn7Gmicv
 nNU4/bWq/qTiSiM1ope0bWwSU/Bp81Iqhuho8U5QjGT2Fs9viuC7ndkWkfTfsnyzTi+dO2RHZWU
 qR31pBydAy6k2k+7Sv2PvNbgEE8Dzun9OrjzsDFZjCPOJkFervUpZNRuBPz0H4D5GoGOoVEJRFZ
 X+v/UwIjYf+NKvi+biS67CrGYSWcST9ga++MG+0DsbNfjkq3nTpHRotBFEdVpEXr+qkaK0kzANy
 xfE1CCYnDSyUkdS/J7x5A4UrMWmkm1rrZ95VTXVY8vfJ1L5wCS46qWLuj9O+H17Ougp7N3asEvB
 5ngIeWgkQ==
X-Received: by 2002:a05:6871:3516:b0:417:1fce:805f with SMTP id
 586e51a60fabf-41bd3f442fbmr595403fac.22.1773779043209; 
 Tue, 17 Mar 2026 13:24:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6995:28aa:eeda:102?
 ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd2c2d51esm704177fac.11.2026.03.17.13.24.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 13:24:02 -0700 (PDT)
Message-ID: <d1e9afe8-4dc5-4994-b278-dca8384d8bb0@baylibre.com>
Date: Tue, 17 Mar 2026 15:24:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] power: pmic: mtk-pwrap: add MT8195 support
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317-mt8195-add-ufs-support-v1-1-7d731ec438ae@baylibre.com>
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

On 3/17/26 9:24 AM, Julien Stephan wrote:
> Add mt8195 support.
> Support comes directly from commit e88edc977b00 ("soc: mediatek: pwrap:
> add pwrap driver for MT8195 SoC") from the Linux Kernel
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/power/pmic/mtk-pwrap.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwrap.c
> index 3e3a691d9e8..8ff6458a5f2 100644
> --- a/drivers/power/pmic/mtk-pwrap.c
> +++ b/drivers/power/pmic/mtk-pwrap.c
> @@ -276,6 +276,23 @@ static int mt8189_regs[] = {
>  	[PWRAP_WACS2_RDATA] =		0x8A8,
>  };
>  
> +static int mt8195_regs[] = {
> +	[PWRAP_INIT_DONE2] =		0x0,
> +	[PWRAP_STAUPD_CTRL] =		0x4C,
> +	[PWRAP_TIMER_EN] =		0x3E4,
> +	[PWRAP_INT_EN] =		0x420,
> +	[PWRAP_INT_FLG] =		0x428,
> +	[PWRAP_INT_CLR] =		0x42C,
> +	[PWRAP_INT1_EN] =		0x450,
> +	[PWRAP_INT1_FLG] =		0x458,
> +	[PWRAP_INT1_CLR] =		0x45C,
> +	[PWRAP_WACS2_CMD] =		0x880,
> +	[PWRAP_SWINF_2_WDATA_31_0] =	0x884,
> +	[PWRAP_SWINF_2_RDATA_31_0] =	0x894,
> +	[PWRAP_WACS2_VLDCLR] =		0x8A4,
> +	[PWRAP_WACS2_RDATA] =		0x8A8,
> +};

I think we need to take a harder look at the driver here. There are many
registers that are accessed unconditionally in the code that aren't defined
here. (It looks like the Linux driver has similar issues as well. And we
have the same problem with mt8188 and mt8189 here in U-Boot.)

So either the code is broken and should have more conditionals or the
register tables are incomplete.

Most of this is in pwrap_init() which is conditional on an earlier bootloader
doing the initialization. If that is the case, we could avoid the issue
by adding a capability flag PWRAP_CAP_INIT and use that to avoid calling
pwrap_init() when we don't have the registers defined and raise an error
instead.


	/*
	 * The PMIC could already be initialized by the bootloader.
	 * Skip initialization here in this case.
	 */
	if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
+		if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_INIT)) {
+			dev_err(dev, "PMIC is not initialized\n");
+			return -EINVAL;
+		}
+
		ret = pwrap_init(wrp);
		if (ret) {
			dev_err(dev, "init failed with %d\n", ret);
			return ret;
		}
	}


Then that leaves PWRAP_WDT_SRC_EN that is unconditionally set in the probe()
function.


> +
>  static int mt8365_regs[] = {
>  	[PWRAP_MUX_SEL] =		0x0,
>  	[PWRAP_WRAP_EN] =		0x4,
> @@ -341,6 +358,7 @@ static int mt8365_regs[] = {
>  enum pwrap_type {
>  	PWRAP_MT8188,
>  	PWRAP_MT8189,
> +	PWRAP_MT8195,
>  	PWRAP_MT8365,
>  };
>  
> @@ -796,6 +814,7 @@ static int mtk_pwrap_bind(struct udevice *dev)
>  		break;
>  	case PWRAP_MT8188:
>  	case PWRAP_MT8189:
> +	case PWRAP_MT8195:
>  		pmic_children_info = mt6359_pmic_children_info;

It would be nice to eventually drop this switch statement and the
enum pwrap_type. We can move the children_info to the
struct pmic_wrapper_type and get it from there instead.

We can save that for later though.

>  		break;
>  	default:
> @@ -867,6 +886,17 @@ static struct pmic_wrapper_type pwrap_mt8189 = {
>  	.caps = PWRAP_CAP_ARB,
>  };
>  
> +static const struct pmic_wrapper_type pwrap_mt8195 = {
> +	.regs = mt8195_regs,
> +	.type = PWRAP_MT8195,
> +	.arb_en_all = 0x777f, /* NEED CONFIRM */
> +	.int_en_all = 0x180000, /* NEED CONFIRM */

Maybe we can find a way to confirm these?

> +	.int1_en_all = 0,
> +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
> +};
> +
>  static const struct pmic_wrapper_type pwrap_mt8365 = {
>  	.regs = mt8365_regs,
>  	.type = PWRAP_MT8365,
> @@ -881,6 +911,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 = {
>  static const struct udevice_id mtk_pwrap_ids[] = {
>  	{ .compatible = "mediatek,mt8188-pwrap", .data = (ulong)&pwrap_mt8188 },
>  	{ .compatible = "mediatek,mt8189-pwrap", .data = (ulong)&pwrap_mt8189 },
> +	{ .compatible = "mediatek,mt8195-pwrap", .data = (ulong)&pwrap_mt8195 },
>  	{ .compatible = "mediatek,mt8365-pwrap", .data = (ulong)&pwrap_mt8365 },
>  	{ }
>  };
> 

