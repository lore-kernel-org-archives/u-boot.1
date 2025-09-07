Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320E2CA101F
	for <u-boot@archiver.kernel.org>; Sun,  7 Sep 2025 16:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 558F7802C1;
	Sun,  7 Sep 2025 18:13:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GKnMB1it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A84803CC; Sun,  7 Sep 2025 18:13:39 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBBF2800D7
 for <u-boot@lists.denx.de>; Sun,  7 Sep 2025 18:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cKZrZ6yLDz9sqs;
 Sun,  7 Sep 2025 18:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757261615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tG+fRVpEbiNlEonTMA7rRUWYhTSRydeDLUIeRBh1qI=;
 b=GKnMB1itljbTZaQCoplkZdiR78s3CNBOlxyg8C7P8juSuVE8nS+YBtyWaPXil/TvcKloOk
 d5q5foxP4A4FdKG1FqUM9ic3ATf9iTTHbMPgnvHrFNdYkS0esoK4DhrfeBIHygvDz4Rapz
 mFItneUECrRRGopiFvk1Adm22yj1GiEow4jO9/aq2U7DkqVfuRtLTVPi/nPtg9fjoTVCkx
 GXr+JTackc5iLnzISzGLs8bu54wp7Rzyvmy/eIP/M2ptRswDaIXDUQjL/hUz2HERB4SB1l
 2nq4KOpF1TXj/Yk2JKrD3aevKc/JkEOqk6oiGjcBPhfbv6kzLy8FXpiQy8gvJw==
Message-ID: <b06616ae-4472-4512-938c-ab76a189b3d0@mailbox.org>
Date: Sun, 7 Sep 2025 18:13:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] phy: Reset init count on phy exit failure
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20250906230052.582621-1-marek.vasut@mailbox.org>
 <0924d46e-9275-461b-bdad-7341f844aea4@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <0924d46e-9275-461b-bdad-7341f844aea4@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0f64b5332effb0ef4e2
X-MBO-RS-META: pczq5ri8xb4st6hpub79dho41k8hk3my
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

On 9/7/25 9:18 AM, Siddharth Vadapalli wrote:

Hi,

>> diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
>> index 714be123856..f8d4fb3b41b 100644
>> --- a/drivers/phy/phy-uclass.c
>> +++ b/drivers/phy/phy-uclass.c
>> @@ -274,7 +274,7 @@ int generic_phy_exit(struct phy *phy)
>>   {
>>   	struct phy_counts *counts;
>>   	struct phy_ops const *ops;
>> -	int ret;
>> +	int ret = 0;
>>   
>>   	if (!generic_phy_valid(phy))
>>   		return 0;
>> @@ -292,12 +292,11 @@ int generic_phy_exit(struct phy *phy)
>>   		if (ret) {
>>   			dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
>>   				phy->dev->name, ret);
>> -			return ret;
> 
> I assume that a generic_phy_reset() may be required for generic_phy_init()
> to succeed after generic_phy_exit() has failed.

Likely, that's up to the driver(s).

> While I understand that
> the current patch allows retrying, this may not be complete in allowing
> users to make use of the change being brought about by this patch.
> Nevertheless, the change being proposed in this patch looks good to me.
This only corrects the inability to retry on failure due to refcount not 
being decremented. Recovery action of the PHY is up to the 
user/driver/consumer .
