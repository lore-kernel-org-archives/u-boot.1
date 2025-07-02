Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF11C83013
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 07:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46A7F82103;
	Wed,  2 Jul 2025 09:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751440958;
	bh=48HQO8V00be4/MnndR5GGfeHao4TtBgIkBm8iT3Zb/g=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S8ipki8hcgXtUDiA+b8aufvZrcUb1sfYr4yaZ0YWMUV/Qo2x7c9/IsokqSWPmp27Y
	 l+ANGhE7uGISH9vN3PKv790zSlG0+Z6h/8zApQtXLWK59VCtQnFKgz0qqaezeoPgQg
	 6EDn6btVXhfdngfGENE58QDvkV9I5T4K6n8dRFIzSIFMrOj0AOUQjB5IKTyBLHuwpG
	 ZcTpd4E02lALsd2E/IGtE/rE83tzTBu/adN1UHZl7Ceuw6oUAKDdqQi5b17pJBmqu7
	 l9fMr5Rv4uqllmgJBsjRPk2L7BxhvRzw8ajEXzxKhkIRpgZwzeP6bAs2AOpN0nY4Ww
	 a6B4wJDwyR5jA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96FF82ADA; Wed,  2 Jul 2025 09:22:37 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD13A81FEE
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 09:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4bXBDn3888z9tKJ;
 Wed,  2 Jul 2025 09:22:33 +0200 (CEST)
Message-ID: <80c125ce-7f0c-410a-b12d-0403fbe77a4f@denx.de>
Date: Wed, 2 Jul 2025 09:22:31 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] watchdog: qcom-wdt: Drop read check on write-only
 WDT_EN register
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, hello@paulsajna.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250701065738.1644669-1-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250701065738.1644669-1-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 01.07.25 08:57, Balaji Selvanathan wrote:
> On some Qualcomm platforms, such as Dragonwing boards, the WDT_EN
> register is write-only. Reading it back after enabling the watchdog
> can return invalid data or cause unexpected behavior.
> 
> In particular, the check:
>    if (readl(wdt_addr(wdt, WDT_EN)) != 1)
> may fail even though the watchdog is correctly enabled and running.
> This leads to misleading error messages and unnecessary failures.
> 
> Removing the read check ensures compatibility and avoids false
> negatives on platforms where WDT_EN is not readable.
> 
> This work builds upon this previous submission:
> https://lore.kernel.org/u-boot/20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com/
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/qcom-wdt.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index af97b27e311..e4ebb1f31d4 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -82,10 +82,7 @@ int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   	writel(bark_timeout_s, wdt_addr(wdt, WDT_BARK_TIME));
>   	writel(bite_timeout_s, wdt_addr(wdt, WDT_BITE_TIME));
>   	writel(BIT(0), wdt_addr(wdt, WDT_EN));
> -	if (readl(wdt_addr(wdt, WDT_EN)) != 1) {
> -		dev_err(dev, "Failed to enable Qualcomm watchdog!\n");
> -		return -EIO;
> -	}
> +
>   	return 0;
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

