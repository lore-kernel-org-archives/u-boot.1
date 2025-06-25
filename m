Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E901C7EE30
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 906C282CFA;
	Wed, 25 Jun 2025 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750863036;
	bh=UWHnzkBzM7hya+keJ/iLS/3IASF1kr4IYJvtFnuJDeY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kJUAkcZlz5BrmuXT4FgKNB5amjnaKRciNKc+D43p6g+dTQxSy9k3iuIwH62p7aCil
	 vbibQ5aYJDg9emh4SSXx8hxcld2gQckU0NXGWIJTkgTyF/QbSL2nAa8CGj6d5Za8Z7
	 wpge4KGKdHWxFCzvg0+9bur6tInKoqbsthSoHoNmTLrpdI+hd0y4zQT5SkuUpw8t8O
	 MoKgn7gerM8BJr+M5VrqnUqLZ8urBUGYyZHoX6MVPwUTBr6vNIgxOFmEezZkxXWeJD
	 NY2gUhVJrRp32kGA+rm0RvpLroLyigi8lfcZoEVPDRBzpFDMYzyYWhBM8F+pSfjQ+6
	 g3Z9kDYvgiDPg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE5282D21; Wed, 25 Jun 2025 16:50:36 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB89682C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4bS4Vr1w20z9tPb;
 Wed, 25 Jun 2025 16:50:28 +0200 (CEST)
Message-ID: <36bc306e-5fb2-41dc-a3f4-378b3372a3d1@denx.de>
Date: Wed, 25 Jun 2025 16:50:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] watchdog: qcom: Add max timeout check to prevent
 overflow
To: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, hello@paulsajna.com,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4bS4Vr1w20z9tPb
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

On 25.06.25 11:46, Gopinath Sekar wrote:
> Added a check to ensure the requested timeout does not exceed the
> hardware's maximum supported value. This prevents register overflow
> and ensures watchdog reliability.
> 
> So, added a check in qcom_wdt_start() to ensure the requested timeout
> does not exceed the hardware-supported maximum value. If the requested
> value exceeds the maximum value, then the timeout is clamped
> at maximum value.
> 
> The timeout is first converted to watchdog ticks and then compared
> against QCOM_WDT_MAX_TIMEOUT. This helps prevent misconfiguration
> and potential watchdog misbehavior due to overflow.
> 
> QCOM_WDT_MAX_TIMEOUT is set to 0xFFFFF, as Qualcomm SoCs typically
> use 20 bits to store bark/bite timeout values.
> 
> This work builds upon the previous submission:
> https://lore.kernel.org/u-boot/20250527124926.128413-1-balaji.selvanathan@oss.qualcomm.com/
> 
> Signed-off-by: Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
> ---
> Changes in v2:
> - Made changes to clamp the timeout value at SOC supported max value
>    if the requested timeout value is greater than max value.
> - Link to v1: https://lore.kernel.org/u-boot/20250624061907.3893511-1-gopinath.sekar@oss.qualcomm.com/

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/qcom-wdt.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index adbb5aacdc3..af97b27e311 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -17,6 +17,9 @@
>   
>   #include <asm/io.h>
>   
> +/* Maximum allowed timeout value in Qcom SoCs*/
> +#define QCOM_WDT_MAX_TIMEOUT	0xfffff
> +
>   enum wdt_reg {
>   	WDT_RST,
>   	WDT_EN,
> @@ -55,8 +58,24 @@ static void __iomem *wdt_addr(struct qcom_wdt *wdt, enum wdt_reg reg)
>   int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   {
>   	struct qcom_wdt *wdt = dev_get_priv(dev);
> -	ulong bark_timeout_s = ((timeout_ms - 1)  * wdt->clk_rate) / 1000;
> -	ulong bite_timeout_s = (timeout_ms * wdt->clk_rate) / 1000;
> +	u64 tmp_timeout;
> +	u32 bark_timeout_s, bite_timeout_s;
> +
> +	/* Compute timeout in watchdog ticks */
> +	tmp_timeout = (timeout_ms * (u64)wdt->clk_rate) / 1000;
> +	if (tmp_timeout > QCOM_WDT_MAX_TIMEOUT) {
> +		dev_warn(dev,
> +			 "Requested timeout (%llu ms) exceeds maximum allowed value (%llu ms). "
> +			 "Using max timeout instead.\n",
> +			 timeout_ms,
> +			 ((u64)QCOM_WDT_MAX_TIMEOUT * 1000) / wdt->clk_rate);
> +		tmp_timeout = (u32)QCOM_WDT_MAX_TIMEOUT;
> +		timeout_ms = (tmp_timeout * 1000) / wdt->clk_rate;
> +	}
> +
> +	bite_timeout_s = (u32)tmp_timeout;
> +	tmp_timeout = ((timeout_ms - 1) * (u64)wdt->clk_rate) / 1000;
> +	bark_timeout_s = (u32)tmp_timeout;
>   
>   	writel(0, wdt_addr(wdt, WDT_EN));
>   	writel(BIT(0), wdt_addr(wdt, WDT_RST));

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

