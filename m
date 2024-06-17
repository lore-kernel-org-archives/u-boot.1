Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACD9C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3633188254;
	Mon, 17 Jun 2024 19:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rD5NFF9d";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g/QgnrPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A85C88323; Mon, 17 Jun 2024 19:38:48 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 254268811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W2xv75ZNxz9sTr;
 Mon, 17 Jun 2024 19:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718645923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaMDudhCcNrMR5Zu5d7oZNpOk+BZVOmSYoUfsr57E9E=;
 b=rD5NFF9dTRN7aUvzsv9WMsEocd4bVqsbJmsvngHaM54mlsetkg4IW/UHZVxV6p6kqVGaUR
 dMboxlf5oifFNk4jFuCkfeujqOPCpcp4l0+6FbCGI+3CfBbGe8S8s0cYU+MAljOVXwp3iC
 HyRVEZIV9jlrkUBAONkH3tT2L6L9atpMM83V0OC5o8zWv1mTE+Azm63cGXtR236CVUvGHb
 AK+WUwSYO1q8U6enwlpGAxYX/tbNrgtiuF/TDeDx3XqFAdxdbZNWFZkCqq7RjLULjEEcoP
 pb8u78TBR6Q8Kk4otGaFQb6oAUuFFuezjOn6KDUlb5wjQyLAekV1MH7r4+f5qg==
Message-ID: <1cf95726-aff6-42bb-b725-8d7cf5f08b38@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1718645922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaMDudhCcNrMR5Zu5d7oZNpOk+BZVOmSYoUfsr57E9E=;
 b=g/QgnrPQklNsuMGqqZFySzUkIi/pnEUee55Q6s0+MS7ckTeAaUGuO5oaR7zMtlVV4UXtJf
 uZ5sbsPDnPYaK8/mPOx4xQLiBk56CKlFIPsTA40AQAUZpiMr1R/PG6TbTbIsE2b3rnPXxf
 s3rjHXisSXQ3D31PAfGNPm5okWvE+/Hmwf2mP+TVyJrTXi5g0JC+HQqnUv9Y4JXIOXPZR+
 02feh7fR/MUHIb1i0rTvejO2HIVVNW8B1s6aI2H2eHeNzTE00FMaqE6EBx87fOsd8XFZPe
 NRoZkqGVe5CR+N29VF8ndv9cpswNxgYyosO/deah3HKPCTsjymvtYOfktvkBNA==
Date: Mon, 17 Jun 2024 19:38:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] phy: Extend generic_setup_phy() with PHY mode and
 submode
To: Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Mathieu Othacehe <othacehe@gnu.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
References: <20240616150426.36338-1-marek.vasut+renesas@mailbox.org>
 <40658f45-445c-43ad-841f-afcdd3a565bc@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <40658f45-445c-43ad-841f-afcdd3a565bc@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: mckbtthy3stnx9jjyhdnxr5dauycr5c7
X-MBO-RS-ID: b5caa3255f62f44b333
X-Rspamd-Queue-Id: 4W2xv75ZNxz9sTr
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

On 6/16/24 10:49 PM, Jonas Karlman wrote:

Hi,

>> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
>> index acdcda15b5b..bbaf95112c5 100644
>> --- a/drivers/phy/phy-uclass.c
>> +++ b/drivers/phy/phy-uclass.c
>> @@ -508,7 +508,8 @@ int generic_phy_power_off_bulk(struct phy_bulk *bulk)
>>   	return ret;
>>   }
>>   
>> -int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
>> +int generic_setup_phy(struct udevice *dev, struct phy *phy, int index,
>> +		      enum phy_mode mode, int submode)
>>   {
>>   	int ret;
>>   
>> @@ -520,6 +521,10 @@ int generic_setup_phy(struct udevice *dev, struct phy *phy, int index)
>>   	if (ret)
>>   		return ret;
>>   
>> +	ret = generic_phy_set_mode(phy, mode, submode);
>> +	if (ret)
>> +		generic_phy_exit(phy);
> 
> This should probably also return ret and not continue with power_on.
> 
> If possible please also add a test case for this scenario.

Fixed both in V2, thanks .
