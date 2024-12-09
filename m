Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5008FE77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 10:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD808962B;
	Mon,  9 Dec 2024 11:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="AXmCabRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 417A38962B; Mon,  9 Dec 2024 11:11:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021848961C
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 11:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8c16=TC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1733739069;
 bh=OHcIx/SEWmktceX09fvhsfs9rr5ayZdzh/zrbq4vqPA=;
 b=AXmCabRHclQC1P3ZrqrvE0pArr2CUUOdoVshobjMRgXcSj+7W8TYuxLufnPPlgZv5onclaZbY
 gJ3kABW7yVb1dlRjMUgLlZXBttX0ICG+CI8JS3wwzgxsiIEbonVC6bzoJT69RHm2dwr6FUz1oN1
 n/2XSo0TOs3SKLAvhVdnM7xnjknK4c4Mkqa3yd3A+RQj4Phv9CIC/GI+4lSsaP57KDkpJATHOiQ
 Tjjb8wKYG5KOv/sUKSerA5QUBEmHqb6W9bwF+ClbHcIpTzA+4SIt11gOUcAKtp6QSVZbHggwhUv
 elySeQ2nUru05OPdcncrtbqem9KMvHZwL7elkteYOujA==
Message-ID: <2c6deec8-8145-482f-bbf0-e2efab3dcf74@kwiboo.se>
Date: Mon, 9 Dec 2024 11:11:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] gpio: fix request of PMIC GPIO child
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Billy Tsai <billy_tsai@aspeedtech.com>,
 Michal Simek <michal.simek@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Ye Li <ye.li@nxp.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Jim Liu <jim.t90615@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241209064413.6282-1-clamor95@gmail.com>
 <20241209064413.6282-3-clamor95@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241209064413.6282-3-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 6756c23c15f9ba9c57c46cdd
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

Hi Svyatoslav,

On 2024-12-09 07:44, Svyatoslav Ryhel wrote:
> If correct PMIC child was found it should be requested as well.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpio/gpio-uclass.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
> index e776906fe73..e6c00c48722 100644
> --- a/drivers/gpio/gpio-uclass.c
> +++ b/drivers/gpio/gpio-uclass.c
> @@ -1160,6 +1160,14 @@ static int gpio_request_tail(int ret, const char *nodename,
>  			/* if loop exits without GPIO device return error */
>  			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
>  				goto err;
> +
> +			ret = uclass_get_device_by_name(UCLASS_GPIO, desc->dev->name,
> +							&desc->dev);
> +			if (ret) {
> +				log_debug("%s: getting GPIO device failed %d\n",
> +					  __func__, ret);
> +				goto err;
> +			}
>  #else
>  			debug("%s: uclass_get_device_by_ofnode failed\n",
>  			      __func__);

Instead of extending this PMIC/GPIO workaround maybe it is better to fix
the issue at bind time? Look like the max77663 pmic driver use
device_bind_driver() instead of device_bind_driver_to_node().

Also palmas gpio driver should not need to be bind, the DTs I can find
in tree all have a gpio node with compatible = ti,palmas-gpio. Do not
really understand why the palmas driver should need this workaround
the gpios props seem to bind to &palmas_gpio node in the DTs I checked.

Maybe something like following diff could work for your boards? I.e.
revert c03cd98d1a16 ("drivers: gpio-uclass: support PMIC GPIO children")
and bind gpio dirver to the pmic node.

Binding to pmic node should probably only happen if the pmic node has
the gpio-controller prop.

Regards,
Jonas

diff --git a/drivers/gpio/gpio-uclass.c b/drivers/gpio/gpio-uclass.c
index 0213271e3a69..67fc776cada2 100644
--- a/drivers/gpio/gpio-uclass.c
+++ b/drivers/gpio/gpio-uclass.c
@@ -1142,29 +1142,9 @@ static int gpio_request_tail(int ret, const char *nodename,
 		ret = uclass_get_device_by_ofnode(UCLASS_GPIO, args->node,
 						  &desc->dev);
 		if (ret) {
-#if CONFIG_IS_ENABLED(MAX77663_GPIO) || CONFIG_IS_ENABLED(PALMAS_GPIO)
-			struct udevice *pmic;
-			ret = uclass_get_device_by_ofnode(UCLASS_PMIC, args->node,
-							  &pmic);
-			if (ret) {
-				log_debug("%s: PMIC device get failed, err %d\n",
-					  __func__, ret);
-				goto err;
-			}
-
-			device_foreach_child(desc->dev, pmic) {
-				if (device_get_uclass_id(desc->dev) == UCLASS_GPIO)
-					break;
-			}
-
-			/* if loop exits without GPIO device return error */
-			if (device_get_uclass_id(desc->dev) != UCLASS_GPIO)
-				goto err;
-#else
 			debug("%s: uclass_get_device_by_ofnode failed\n",
 			      __func__);
 			goto err;
-#endif
 		}
 	}
 	ret = gpio_find_and_xlate(desc, args);
diff --git a/drivers/power/pmic/max77663.c b/drivers/power/pmic/max77663.c
index cf08b6a7e1df..838eae50740d 100644
--- a/drivers/power/pmic/max77663.c
+++ b/drivers/power/pmic/max77663.c
@@ -56,8 +56,8 @@ static int max77663_bind(struct udevice *dev)
 	}
 
 	if (IS_ENABLED(CONFIG_MAX77663_GPIO)) {
-		ret = device_bind_driver(dev, MAX77663_GPIO_DRIVER,
-					 "gpio", NULL);
+		ret = device_bind_driver_to_node(dev, MAX77663_GPIO_DRIVER,
+						 "gpio", dev_ofnode(dev), NULL);
 		if (ret) {
 			log_err("cannot bind GPIOs (ret = %d)\n", ret);
 			return ret;
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index f676bf641694..faa876f4e73d 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -45,7 +45,6 @@ static int palmas_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 static int palmas_bind(struct udevice *dev)
 {
 	ofnode pmic_node = ofnode_null(), regulators_node;
-	ofnode subnode, gpio_node;
 	int children, ret;
 
 	if (IS_ENABLED(CONFIG_SYSRESET_PALMAS)) {
@@ -57,14 +56,6 @@ static int palmas_bind(struct udevice *dev)
 		}
 	}
 
-	gpio_node = ofnode_find_subnode(dev_ofnode(dev), "gpio");
-	if (ofnode_valid(gpio_node)) {
-		ret = device_bind_driver_to_node(dev, PALMAS_GPIO_DRIVER,
-						 "gpio", gpio_node, NULL);
-		if (ret)
-			log_err("cannot bind GPIOs (ret = %d)\n", ret);
-	}
-
 	dev_for_each_subnode(subnode, dev) {
 		const char *name;
 		char *temp;


