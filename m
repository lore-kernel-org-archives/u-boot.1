Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67812CAC586
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 13:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBFB582C84;
	Mon,  8 Sep 2025 15:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nTg/xvyb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE23F83071; Mon,  8 Sep 2025 15:09:57 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A98882AE9
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 15:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cL6k82Bgkz9sqd;
 Mon,  8 Sep 2025 15:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757336992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qGEkiRX3i9c/iP+DKVfdhmP3mwcQt19Xr+ZrXGnPTo=;
 b=nTg/xvyb3jdt+F7qMfm2n5JzFj14LdO46DrdgTNzuVPIfZqPtTpprzg9Mx21S92DvrB3al
 1Nz4O+RnMcdJPM+HTEv3PYTyLGQu5CVhEI0XCOEaEuKAtJ8GBQSY25nPZNH9L+vdzGAiqQ
 A21y5vQ8dKzn/kmydmaDcK1gC50AzZipjrvdWBIIwOBDmLBaw1Ua3nqdGmAopUAqBRBSG6
 VQCgxKMHZspYR8vGdE0GdKVSYH2YaurMXEm79HGHhydxXaXDoZTfurwFDYhO7jQ9Mb/dtl
 Mhu6LY7w5UfbKTaoZnTj/ncNbJzNzKkHINijp7j3ZwJ5Epo8fx//dh+844EImA==
Message-ID: <fa70be78-e92e-4da0-9a06-d576eaee8572@mailbox.org>
Date: Mon, 8 Sep 2025 15:09:47 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] thermal: Convert .get_temp() return value to millicelsius
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford
 <aford173@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Mathieu Othacehe <othacehe@gnu.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
References: <20250906000609.284902-1-marek.vasut+renesas@mailbox.org>
 <55c0e687-c08e-480b-affe-81f566283228@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <55c0e687-c08e-480b-affe-81f566283228@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: e7cpnxy8drktgihq4r4nuyrbpdnopr8o
X-MBO-RS-ID: 673127bcae91d4e6987
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

On 9/8/25 11:38 AM, Quentin Schulz wrote:

Hello Quentin,

> On 9/6/25 2:05 AM, Marek Vasut wrote:
>> Linux kernel .get_temp() callback reports values in millicelsius,
>> U-Boot currently reports them in celsius. Align the two and report
>> in millicelsius. Update drivers accordingly. Update callsites that
>> use thermal_get_temp() as well.
>>
>> The 'temperature' command now reports temperature in millicelsius
>> as well, with additional accuracy. This changes command line ABI
>> slightly.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Adam Ford <aford173@gmail.com>
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Cc: David Zang <davidzangcs@gmail.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Mathieu Othacehe <othacehe@gnu.org>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Stefano Babic <sbabic@nabladev.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Ye Li <ye.li@nxp.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   arch/arm/mach-imx/cpu.c             | 1 +
>>   arch/arm/mach-imx/imx8ulp/soc.c     | 2 +-
>>   cmd/temperature.c                   | 2 +-
>>   drivers/cpu/imx8_cpu.c              | 2 +-
>>   drivers/mmc/omap_hsmmc.c            | 1 +
>>   drivers/thermal/imx_scu_thermal.c   | 2 +-
>>   drivers/thermal/imx_thermal.c       | 2 +-
>>   drivers/thermal/imx_tmu.c           | 2 +-
>>   drivers/thermal/rcar_gen3_thermal.c | 6 +++---
> 
> I don't see this file in master or next branches, did I miss something?

I sent this as a separate driver, which I suspect will land before this 
one, see

[PATCH 1/2] thermal: rcar_gen3: Add Renesas R-Car Gen3/Gen4 and RZ/G2 
thermal driver

> Otherwise looks ok to me, so:
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> I'm wondering if we shouldn't keep the output of the cmd in °C instead 
> of °mC?
I am wondering about that too, let's wait for input from others. I would 
suggest waiting a bit longer before landing this patch, to really 
collect input.

It does indeed introduce command line API change, and may break tests. 
At least scripts cannot depend on this value, so that part is fine.
