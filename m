Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D1AC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C4F806E6;
	Tue, 14 Jan 2025 18:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736876511;
	bh=R5bZvVzn6AW3vmwP/QyAD/DbzUeUXDAIQvOZWelbtMg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvAbdDeVp24c5SNlBszFmUt3rWbizVtd5/PV0KZ7qsFC0twsJ1X4UYJxtEJeodznQ
	 nmzkqAsPcM7qU7K6rzkv9tvk5ewH1lY0lhTKILm8dNdIWPQacL7/Zxsj9N2rC4+TRD
	 hN1RL38QMVmCP9Y0xTsmnkHQsQEKlivGv8M7DoFNWOhSpIB36ZGJ4ePRM+/JPihl3T
	 gfnOSZhtULFjvjs03RPM2DMnlpVMo5iaXy0V9K+uys/55K9lpnZCbW4+Rq0i9rFI9T
	 5BevXKYoiRsTeWo/cZtdklyLbjdGEPhca4nIUB3JnRDLErOWsLTkq2nVoEWOCa/Tj0
	 xv2ht1VNqo2BA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51BE0806D4; Tue, 14 Jan 2025 18:41:50 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62C1580657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 18:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="CJaLID7M"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A72B4101C6440; Tue, 14 Jan 2025 18:41:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736876507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5bZvVzn6AW3vmwP/QyAD/DbzUeUXDAIQvOZWelbtMg=;
 b=CJaLID7Mf9ftz07AeAbqNkrPvRVjhWqU/idg7sn1XMoQBboxZ2u935oEBKMfO/GCKU+cg1
 eHJ0q9MImyRCqlOKlGdywyCSBmdGTX9RqKSahME+YT3Iz9Bz2rqjXh2WPtRfFoV9BtTu9B
 f9EuWRwBlExGvOzFpULDgNI12ZrTtKgnT3gQVzGdVuERI8MjXfuDySbwhxnBKZq/h2FFeX
 DTq3n66VPqovveWM0HbgZGUXMREfOn8+rN02LefL8oPg/G5dK5ylrh4zepWBrG8g/IIEVS
 Mt9gPW93nCGB4MlktWPSUdVzwj+otHnW5utpieTMhx3bk0ww8z2kx9JOhmqlYg==
Message-ID: <366cef60-e32f-4557-9830-b1b642f0683f@denx.de>
Date: Tue, 14 Jan 2025 15:53:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] usb: dwc3-generic: Add STih407 support
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
 <20250114144528.1612168-5-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250114144528.1612168-5-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/14/25 3:45 PM, Patrice Chotard wrote:

> +	/* glue init */
> +	reg = readl(glue_base + CLKRST_CTRL);
> +
> +	reg |= AUX_CLK_EN | EXT_CFG_RESET_N | XHCI_REVISION;
> +	reg &= ~SW_PIPEW_RESET_N;
> +
> +	writel(reg, glue_base + CLKRST_CTRL);
> +
> +	/* configure mux for vbus, powerpresent and bvalid signals */
> +	reg = readl(glue_base + USB2_VBUS_MNGMNT_SEL1);
> +
> +	reg |= SEL_OVERRIDE_VBUSVALID(USB2_VBUS_UTMIOTG) |
> +	       SEL_OVERRIDE_POWERPRESENT(USB2_VBUS_UTMIOTG) |
> +	       SEL_OVERRIDE_BVALID(USB2_VBUS_UTMIOTG);
> +
> +	writel(reg, glue_base + USB2_VBUS_MNGMNT_SEL1);
setbits_le32() , please fix globally.

Also, I am wondering if we're not overstuffing the dwc3-generic.c with 
too many disparate glue code shreds, and whether it isn't just about 
time to split the glue code parts out of it, into separate .c files. 
Thoughts ?
