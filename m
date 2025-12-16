Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8E7D609B1
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F38C1837F2;
	Tue, 16 Dec 2025 16:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pG74aWPt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F0083923; Tue, 16 Dec 2025 16:40:27 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61365837F2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dW1N70Gszz9tQ8;
 Tue, 16 Dec 2025 16:40:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpHI7thVqoho0X9wu4JR997dBWsYynDJwUeUPsETL2s=;
 b=pG74aWPthyWyY+S15v5+MbEyT8Gr7F2BoW3tChkRRXwS7h+mA6ESdEDuTVSJ9QbhecyQbk
 b0o7X5kSFV76lKP2be7K8MC7L+LnIB1sHON76L24HIIWoOMDyZZvSUyNtyWAs3ln46kf5g
 AV3VeV6iwHu29MN4VGtwe1sb0l2AsGgtx3x0uWeE/ED++vvWtkPwEP9XD1ZqTYwTsGi2in
 hF6zpFvH5ayYxqDIJ7Cq/ble+m5rPQ0a+l2cPvNVpReQKoI5Wu+AirXCC2GtU3XhTF9q5B
 DbC/Ilk5YVhKBi4kcAvWtlDbX7y4zUMET9jxc5M6jmJ5+gYPkfy2umggZjnFSA==
Message-ID: <89608e43-92ab-41e1-b5c3-79ca01f0360f@mailbox.org>
Date: Tue, 16 Dec 2025 12:13:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] usb: dwc3-generic: add support for exynos7870
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-2-fe46e2ed1908@disroot.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251017-usb-dwc3-exynos7870-v1-2-fe46e2ed1908@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4jz4su6c48uz6o5iwn5chqqmjxh1qkc6
X-MBO-RS-ID: e2841186d7e4e7da943
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

On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
> Exynos7870's DWC3 glue layer is quite simple, consisting of a few
> clocks, which is handled by this driver. Add the compatible string in
> here.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 1967594f48ab40963463e6f17ed58ec45ce5867c..622847a9daf8e3c5cba4e4a9414b50e8a050df55 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -710,6 +710,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>   	{ .compatible = "fsl,imx8mq-dwc3" },
>   	{ .compatible = "intel,tangier-dwc3" },
> +	{ .compatible = "samsung,exynos7870-dwusb3" },
>   	{ .compatible = "samsung,exynos850-dwusb3" },
Please keep the list sorted.
