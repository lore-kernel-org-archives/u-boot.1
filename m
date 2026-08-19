Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58739C5DF8B
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A11C80B00;
	Thu, 20 Aug 2026 03:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gaQjtgUCIT-L; Thu, 20 Aug 2026 03:55:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787198147;
	bh=0IloXnB+cbO7uvhOXAL7/E3GTA27XlXNmV2x1lmnXEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c61ryTMmJtQTp8xAW7Fetc+5MoK8EfUBhuzfqjkemdCBMEzeorqU4jS43hx5i2LkP
	 5qXsVsCkAJqHsvbaGu03oo3VAgX0hmU1i3MiXk7h0ayXdJ5MZbVdvbG/DieMzgmt5m
	 5IlRnwFM4Tb045CPeCff5roXCqJ/rnKCRRgxjJDEmXS0ABPLiyD/RRHikqwtn1Qq+K
	 xfCC54vD3039ps+5Is2L5AHqgja3HlX/yzTd55aPStssSvx+mnS39oAAKaAhq9Hv+u
	 HdQ9UX2yIBZlxDi2xMclgOd5QoX8T7hV+oM1XRXgObRejgk3H4YVuUI93Cea3KtMj4
	 d9QsFMY6o3O4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7869280AC5;
	Thu, 20 Aug 2026 03:55:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B94FE2FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F9BB4024F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQhXuARp6jtI for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 03:55:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=ps6SHi/K; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=xJHiSeH/
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2C2E40064
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 03:55:44 +0000 (UTC)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hQV3233YRz8t0P;
 Thu, 20 Aug 2026 05:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IloXnB+cbO7uvhOXAL7/E3GTA27XlXNmV2x1lmnXEs=;
 b=ps6SHi/Kml3V7Cq6vcD1JLiMj6p71Mq1odPGt9HbQkpeSAD4MClNVRo3sSysqzymD72MpR
 XYwPc1wRctsidzTK0NR35T/zEe+EB4QUItY98CTK/UUMw6DTMI3bDLjpXKHiOEV2i1AP3Y
 fyGVNjd/uZRzdoknn1jVyqL6H5/4A5JTeLUMY4Zh8jrzLHJy36BBx4gz3j38g0FIqHfGBO
 cR692i289hClN74xiz7G2JViJ12Fs1TxacyS6dtYJTpLdxpNnho+siPOl/mbdpyaTL/jsj
 kQp1qpH8dfWa3rwAdA4dyxAYE4JAEe8nRO00LU7dyyIxcu/7K0hoUCtwP33lDA==
Message-ID: <ef774b7b-ac7b-40d4-9e94-66614d081fd1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787198140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IloXnB+cbO7uvhOXAL7/E3GTA27XlXNmV2x1lmnXEs=;
 b=xJHiSeH/sziNJkA8TfWm/OB885r3I0iEZBPPHIK8YnhqoH/AZhkKBLMiPZxWMC3JueUcz1
 5MChxZnTt5XtBsiEz272BaR5lRiHeWNZ6sFOzCPqYLMngWUn1fJ7IlalM9eu6BoxoaWliR
 W9+U6fNiCSpRGuyBKnvARkn5l3KLziRsSdQxdSwZQweeLioenoqBALeaxa4DQ502Icifb7
 lbHQ7YpJaRc6/GrhjS1LzyHgo33lPvyVRbjgDSl1XeIETk+jBRtkdC2NnWn1H7rFKTIwVZ
 IQqemB+o3MtLxyWgR4/nHKts0833d2NTqWVt5Ikw9tzG58thm3sFktdvBjVyEA==
Date: Wed, 19 Aug 2026 21:52:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] usb: ehci-vf: enable the vbus supply of the port
To: Mehmet Fide <mehmet.fide@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
References: <20260819143543.427396-1-mehmet.fide@gmail.com>
 <20260819143543.427396-3-mehmet.fide@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260819143543.427396-3-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6d7bk7a4rpszgoogfobonaojnmq8c3u3
X-MBO-RS-ID: fc20feec21fd2a86bb4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/19/26 4:35 PM, Mehmet Fide wrote:

[...]

> +static int ehci_usb_remove(struct udevice *dev)
> +{
> +	struct ehci_vf_priv_data *priv = dev_get_priv(dev);
> +
> +	if (CONFIG_IS_ENABLED(DM_REGULATOR) && priv->vbus_supply)
> +		regulator_set_enable_if_allowed(priv->vbus_supply, false);
The test for DM_REGULATOR being enabled is already in 
include/power/regulator.h, regulator_set_enable_if_allowed() will return 
-ENOSYS if DM_REGULATOR is disabled. Your implementation has to check 
for that, example:

drivers/adc/adc-uclass.c:       ret = 
regulator_set_enable_if_allowed(uc_pdata->vss_supply, true);
drivers/adc/adc-uclass.c-       if (ret && ret != -ENOSYS) {
drivers/adc/adc-uclass.c-               pr_err("%s: can't enable 
vss-supply!", dev->name);
drivers/adc/adc-uclass.c-               return ret;
drivers/adc/adc-uclass.c-       }
