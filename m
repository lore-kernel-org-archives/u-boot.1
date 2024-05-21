Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91AD4C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 15:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FD0788013;
	Tue, 21 May 2024 17:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nDf/WkeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E012588293; Tue, 21 May 2024 17:29:47 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7430987FA1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LFTYIi038790;
 Tue, 21 May 2024 10:29:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716305374;
 bh=3TPA8bULB88hnRGJgIcfEu0nlp2sLYtUE8+FUTyH73s=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=nDf/WkeAHApARb3WQhLSTdXQarN8We1oBFeRfhOU4pZZKH1bs0S6GDVvebGHqwHWS
 6kaIW7OJy6jVs4pVny/eHhrh0s4szP1jniAcpLkeEmrFCGd97fSY6JkqEdXOkN7OSA
 Tbecdb49NvceQGBGG02pbsNIXy4jkpmvu4xpKGFc=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LFTYeC002549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 21 May 2024 10:29:34 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 10:29:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 10:29:33 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LFTIam089995;
 Tue, 21 May 2024 10:29:21 -0500
Message-ID: <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
Date: Tue, 21 May 2024 20:59:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <joe.hershberger@ni.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <emanuele.ghidoli@toradex.com>,
 <matthias.schiffer@ew.tq-group.com>, <a-bhatia1@ti.com>,
 <vitor.soares@toradex.com>, <danishanwar@ti.com>, <bmeng.cn@gmail.com>,
 <mkorpershoek@baylibre.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <joao.goncalves@toradex.com>, <hnagalla@ti.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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


On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:
>> Some use case needs rproc firmware to be loaded at u-boot stage,
>> using following commands at u-boot shell, firmware could be loaded
>>
>> => setenv dorprocboot 1
>> => run boot_rprocs
>>
>> For Secure devices, secure version of rproc firmware should be loaded,
>> which is appended by sec keyword[0].
>> but currently non-secure firmware is loaded even for secure devices.
>> So adding support for loading secure firmware on Secured devices.
> Are you Cc'ing random people with this?
> Please don't do it.

I used names names popped up while running get_maintainer.pl script of 
u-boot

your email id was there for patch-3 of this series

./scripts/get_maintainer.pl 
0003-include-env-ti-Add-support-for-secure-firmwares.patch
Joe Hershberger <joe.hershberger@ni.com> (maintainer:ENVIRONMENT)
Tom Rini <trini@konsulko.com> (maintainer:THE REST)
Udit Kumar <u-kumar1@ti.com> 
(commit_signer:1/2=50%,authored:1/2=50%,commit_signer:1/7=14%,authored:1/7=14%)
Simon Glass <sjg@chromium.org> 
(commit_signer:1/2=50%,authored:1/2=50%,authored:1/7=14%)
Andy Shevchenko <andriy.shevchenko@linux.intel.com> (commit_signer:1/2=50%)
Bin Meng <bmeng.cn@gmail.com> (commit_signer:1/2=50%)
Manorit Chawdhry <m-chawdhry@ti.com> 
(commit_signer:1/2=50%,commit_signer:5/7=71%,authored:4/7=57%)
Mattijs Korpershoek <mkorpershoek@baylibre.com> (commit_signer:4/7=57%)
Nishanth Menon <nm@ti.com> (commit_signer:1/7=14%,authored:1/7=14%)
Siddharth Vadapalli <s-vadapalli@ti.com> (commit_signer:1/7=14%)
u-boot@lists.denx.de (open list)

