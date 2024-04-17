Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3501BC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0F388467;
	Wed, 17 Apr 2024 13:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="mS6SFdvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5862988467; Wed, 17 Apr 2024 13:23:46 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EEE88468
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240417112334epoutp031d55dd0fdf8f213d76530854513b2a7a~HDX0pjd8M2500925009epoutp03S
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:23:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240417112334epoutp031d55dd0fdf8f213d76530854513b2a7a~HDX0pjd8M2500925009epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1713353014;
 bh=NEg5FX2ofhLZ6CZM7mo491XljBYMkzDl3G2h8XEUp9E=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=mS6SFdvcAfa61M23aG9TYNbE3DvDmk6AF9WlcUnE27jH3a9xJ/pm+McXKAgqOb9vl
 9lKNQ5tZ8XTItxwapB+/iocw0loH3As/Unw5s4cxccb5+uwBh7aBKdmHGmRLJRlgbd
 /bsPkTLXOvGTGW4pZvSZeNvlLIwNoQiCHxO0WP+M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20240417112334epcas1p417d8f93f211110ad4b61a9fe1b8f6824~HDX0VQKca2670826708epcas1p4g;
 Wed, 17 Apr 2024 11:23:34 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.133]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4VKJSN6HPjz4x9Pv; Wed, 17 Apr
 2024 11:23:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 C6.0E.09662.431BF166; Wed, 17 Apr 2024 20:23:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240417112332epcas1p1b9fa4971a57e73dfdc8939952a4c4c47~HDXyiSZ2n0334503345epcas1p1l;
 Wed, 17 Apr 2024 11:23:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240417112332epsmtrp1b9e76763c02e42f6cd0c43615a55862f~HDXyhuvs01170411704epsmtrp15;
 Wed, 17 Apr 2024 11:23:32 +0000 (GMT)
X-AuditID: b6c32a35-053ff700000025be-a3-661fb134bd96
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.96.19234.431BF166; Wed, 17 Apr 2024 20:23:32 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20240417112331epsmtip1df8344c787c126f65b72a9d35239ac78~HDXyW9oGS1562515625epsmtip1s;
 Wed, 17 Apr 2024 11:23:31 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Judith Mendez'" <jm@ti.com>, "'Peng Fan'" <peng.fan@nxp.com>, "'Tom
 Rini'" <trini@konsulko.com>
Cc: "'Nitin Yadav'" <n-yadav@ti.com>, "'Simon Glass'" <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20240415212747.2678974-2-jm@ti.com>
Subject: RE: [PATCH 1/5] mmc: am654_sdhci: Add tuning algorithm for delay chain
Date: Wed, 17 Apr 2024 20:23:31 +0900
Message-ID: <01e201da90b9$adcbe020$0963a060$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG5/NRqE0+DtqCkK0jpqvLeJwVynAKizPr5AnepbiGxhKSNUA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmga7JRvk0g98/DCw+fci0+Nx0hNni
 x6ovrBbftmxjtJg6aTO7xdu9newObB6zGy6yeLw6sIrd4+ydHYweG9/tYPI4fmM7UwBrVLZN
 RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtAFSgpliTml
 QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjN/f
 jQp6DCs2fjrK1MD4VK2LkZNDQsBE4vTUDYxdjFwcQgI7GCXWbe9hgnA+MUpsWtnJCOe8X/GK
 BaZl3pNWNojETkaJKYtfsIEkhAReMko0PdMFsdkE9CT+L1rIDGKLCKRLtG97BWYzCyRJvLqw
 lwnE5hQwlOh+eBIozsEhLBAo8W+NOkiYRUBV4svmpWDlvAKWEt0nZ7NA2IISJ2c+YYEYIy+x
 /e0cZoh7FCR+Pl3GCrHKSeJB6z02iBoRidmdbcwgd0oIdHJIfD3WzgbR4CIx5eI6JghbWOLV
 8S3sELaUxMv+NnaIhmZGiaVLDrJCOD2MEv8arkN1G0vsXzqZCeRqZgFNifW79CG28Um8+9rD
 ChKWEOCV6GgTgqhWkbj0+iUTzPy7T/6zQtgeEjuO72SdwKg4C8lvs5D8NgvJD7MQli1gZFnF
 KJZaUJybnlpsWGAIj+zk/NxNjODEqWW6g3Hi2w96hxiZOBgPMUpwMCuJ8LYIy6YJ8aYkVlal
 FuXHF5XmpBYfYjQFhvZEZinR5Hxg6s4riTc0sTQwMTMyNrEwNDNUEuc9c6UsVUggPbEkNTs1
 tSC1CKaPiYNTqoHpYgtbyQp5rcmXPvWo9XnFVi1Zs/73t3vqmdsOvYmvXeld4jit39jh5dvf
 qXt72g/ut/KZqnpO79sCxe/bWVyZFkxokrNOCjjAzCyhXVh/+dKBH5t4U603Zfe+Sln16K+Z
 rg9TS2BcFkfkRieHE/mJh0O/zNVcXJlz9tf8J68urSrT4dX8f+7uxBIBp36lZxuWnShvVPHd
 wu0rmOLyXHDv6dqjuga3OpvezXa7ZXv+P3ObC/fGl55sF+7mRJdebOFQnVljr5klOrOM//Sm
 +POrgi2zlV9l/2jatEx39/ufDX81dpqmzu3oXKNzZ3WI0I33zaWLb6yIiX9h2Mz33Vo5Ridk
 982p6Sl5uzPfnudUYinOSDTUYi4qTgQAA+1PpCUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK7JRvk0gyOr2S0+fci0+Nx0hNni
 x6ovrBbftmxjtJg6aTO7xdu9newObB6zGy6yeLw6sIrd4+ydHYweG9/tYPI4fmM7UwBrFJdN
 SmpOZllqkb5dAlfG7+9GBT2GFRs/HWVqYHyq1sXIySEhYCIx70krWxcjF4eQwHZGiclPTrNC
 JKQkPj+dCpTgALKFJQ4fLoaoec4o8WPjSTaQGjYBPYn/ixYyg9SICGRKdM6LBQkzC6RIfP0z
 lRWifjmjRN/0bhaQBKeAoUT3w5PMILawgL/EuralTCA2i4CqxJfNS8HivAKWEt0nZ7NA2IIS
 J2c+YYEYqi3x9OZTKFteYvvbOcwQdypI/Hy6DOxmEQEniQet99ggakQkZne2MU9gFJ6FZNQs
 JKNmIRk1C0nLAkaWVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBkaMVtINx2fq/eocYmTgY
 DzFKcDArifC2CMumCfGmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgtgsky
 cXBKNTCtEdw2rzBpGYNvdt4vlfu3pXeWtd1ivab1P6jxlrX0wb/3zMzP+AXXSqt81/8586C0
 /6l9E/Jnz/6edOvu9v4Fz9/EXTaYw610/2WRPpvuX9Z1xgEz/CPS/+t92Bt97lH33BQX43M2
 DyIyiqvL2nQ6CtY+WhL0dubjW8Lf7zLcj9kjpNh/xXqLZqDA92/J579PPvmfnyH8tubtHV9D
 Yh4kz1nfuGxKTfrvxVObmcs4dW45rOd+vOW04tukr3yRUfeKQzoKT6nYTrjWcMqI+Ynymmf9
 AuxlF0IyJhyefEnn+GSHqb+u/d7Y2XJ9y3U2S8uXOy93vszLqv78z3z6hPOionHruIxvP9st
 vnmrteKXbCWW4oxEQy3mouJEAOWDdTkLAwAA
X-CMS-MailID: 20240417112332epcas1p1b9fa4971a57e73dfdc8939952a4c4c47
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240415212757epcas1p1a6d792672e1e125e1d1bfb6feec15f0f
References: <20240415212747.2678974-1-jm@ti.com>
 <CGME20240415212757epcas1p1a6d792672e1e125e1d1bfb6feec15f0f@epcas1p1.samsung.com>
 <20240415212747.2678974-2-jm@ti.com>
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



> -----Original Message-----
> From: Judith Mendez <jm@ti.com>
> Sent: Tuesday, April 16, 2024 6:28 AM
> To: Peng Fan <peng.fan@nxp.com>; Jaehoon Chung <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
> Cc: Nitin Yadav <n-yadav@ti.com>; Simon Glass <sjg@chromium.org>; u-boot@lists.denx.de
> Subject: [PATCH 1/5] mmc: am654_sdhci: Add tuning algorithm for delay chain
> 
> Currently the sdhci_am654 driver only supports one tuning
> algorithm which should be used only when DLL is enabled. The
> ITAPDLY is selected from the largest passing window and the
> buffer is viewed as a circular buffer.
> 
> The new tuning algorithm should be used when the delay chain
> is enabled; the ITAPDLY is selected from the largest passing
> window and the buffer is not viewed as a circular buffer.
> 
> This implementation is based off of the following paper: [1].
> 
> Also add support for multiple failing windows.
> 
> [1] https://www.ti.com/lit/an/spract9/spract9.pdf
> 
> Fixes: a759abf569d4 ("mmc: am654_sdhci: Add support for software tuning")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  drivers/mmc/am654_sdhci.c | 107 +++++++++++++++++++++++++++++++-------
>  1 file changed, 89 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
> index 05595bdac39..e5ad00e2531 100644
> --- a/drivers/mmc/am654_sdhci.c
> +++ b/drivers/mmc/am654_sdhci.c
> @@ -97,6 +97,7 @@ struct am654_sdhci_plat {
>  	u32 strb_sel;
>  	u32 clkbuf_sel;
>  	u32 flags;
> +	bool dll_enable;
>  #define DLL_PRESENT	BIT(0)
>  #define IOMUX_PRESENT	BIT(1)
>  #define FREQSEL_2_BIT	BIT(2)
> @@ -110,6 +111,12 @@ struct timing_data {
>  	u32 capability;
>  };
> 
> +struct window {
> +	u8 start;
> +	u8 end;
> +	u8 length;
> +};
> +
>  static const struct timing_data td[] = {
>  	[MMC_LEGACY]	= {"ti,otap-del-sel-legacy",
>  			   "ti,itap-del-sel-legacy",
> @@ -280,8 +287,11 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
>  		ret = am654_sdhci_setup_dll(plat, speed);
>  		if (ret)
>  			return ret;
> +
> +		plat->dll_enable = true;
>  	} else {
>  		am654_sdhci_setup_delay_chain(plat, mode);
> +		plat->dll_enable = false;
>  	}
> 
>  	regmap_update_bits(plat->base, PHY_CTRL5, CLKBUFSEL_MASK,
> @@ -375,38 +385,99 @@ static void am654_sdhci_write_b(struct sdhci_host *host, u8 val, int reg)
>  	writeb(val, host->ioaddr + reg);
>  }
>  #ifdef MMC_SUPPORTS_TUNING
> -#define ITAP_MAX	32
> +#define ITAPDLY_LENGTH 32
> +#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
> +
> +static u32 am654_sdhci_calculate_itap(struct udevice *dev, struct window
> +			  *fail_window, u8 num_fails, bool circular_buffer)
> +{
> +	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
> +	u8 first_fail_start = 0, last_fail_end = 0;
> +	struct window pass_window = {0, 0, 0};
> +	int prev_fail_end = -1;
> +	u8 i;
> +
> +	if (!num_fails)
> +		return ITAPDLY_LAST_INDEX >> 1;
> +
> +	if (fail_window->length == ITAPDLY_LENGTH) {
> +		dev_err(dev, "No passing ITAPDLY, return 0\n");
> +		return 0;
> +	}
> +
> +	first_fail_start = fail_window->start;
> +	last_fail_end = fail_window[num_fails - 1].end;
> +
> +	for (i = 0; i < num_fails; i++) {
> +		start_fail = fail_window[i].start;
> +		end_fail = fail_window[i].end;
> +		pass_length = start_fail - (prev_fail_end + 1);
> +
> +		if (pass_length > pass_window.length) {
> +			pass_window.start = prev_fail_end + 1;
> +			pass_window.length = pass_length;
> +		}
> +		prev_fail_end = end_fail;
> +	}
> +
> +	if (!circular_buffer)
> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
> +	else
> +		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
> +
> +	if (pass_length > pass_window.length) {
> +		pass_window.start = last_fail_end + 1;
> +		pass_window.length = pass_length;
> +	}
> +
> +	if (!circular_buffer)
> +		itap = pass_window.start + (pass_window.length >> 1);
> +	else
> +		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
> +
> +	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
> +}
> +
>  static int am654_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
>  {
>  	struct udevice *dev = mmc->dev;
>  	struct am654_sdhci_plat *plat = dev_get_plat(dev);
> -	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
> -	u32 itap;
> +	struct window fail_window[ITAPDLY_LENGTH];
> +	u8 curr_pass, itap;
> +	u8 fail_index = 0;
> +	u8 prev_pass = 1;
> +
> +	memset(fail_window, 0, sizeof(fail_window));
> 
>  	/* Enable ITAPDLY */
>  	regmap_update_bits(plat->base, PHY_CTRL4, ITAPDLYENA_MASK,
>  			   1 << ITAPDLYENA_SHIFT);
> 
> -	for (itap = 0; itap < ITAP_MAX; itap++) {
> +	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
>  		am654_sdhci_write_itapdly(plat, itap);
> 
> -		cur_val = !mmc_send_tuning(mmc, opcode, NULL);
> -		if (cur_val && !prev_val)
> -			pass_window = itap;
> +		curr_pass = !mmc_send_tuning(mmc, opcode, NULL);

It's changed to !mmc_send_tuing(mmc, opcode). Could you change this based on latest u-boot?

Sorry for bothering you.

commit a3b2786651c7 "mmc: Drop unused mmc_send_tuning() cmd_error parameter"

Best Regards,
Jaehoon Chung

> 
> -		if (!cur_val)
> -			fail_len++;
> +		if (!curr_pass && prev_pass)
> +			fail_window[fail_index].start = itap;
> 
> -		prev_val = cur_val;
> +		if (!curr_pass) {
> +			fail_window[fail_index].end = itap;
> +			fail_window[fail_index].length++;
> +		}
> +
> +		if (curr_pass && !prev_pass)
> +			fail_index++;
> +
> +		prev_pass = curr_pass;
>  	}
> -	/*
> -	 * Having determined the length of the failing window and start of
> -	 * the passing window calculate the length of the passing window and
> -	 * set the final value halfway through it considering the range as a
> -	 * circular buffer
> -	 */
> -	pass_len = ITAP_MAX - fail_len;
> -	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
> +
> +	if (fail_window[fail_index].length != 0)
> +		fail_index++;
> +
> +	itap = am654_sdhci_calculate_itap(dev, fail_window, fail_index,
> +					  plat->dll_enable);
> +
>  	am654_sdhci_write_itapdly(plat, itap);
> 
>  	return 0;
> --
> 2.43.2


