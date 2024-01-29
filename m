Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCCBC47DB3
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 16:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 995A587C20;
	Mon, 29 Jan 2024 17:09:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="v+KTd2Vi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5204B87BB5; Mon, 29 Jan 2024 17:09:35 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98A9387C52
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TG9QXG031975;
 Mon, 29 Jan 2024 10:09:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706544566;
 bh=qQPWewftAIn0a+FeUbDmLboTO4gRdzopZSCh/viH+Uw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=v+KTd2VicDOU+CUKkIuwE8UUONTCwhy+O3JK3g7Vas25P/YYYXJqChNRjb+LYwN5q
 HyNen5WGCNkogCSG5PG5fzikf+vk3XyxUPBlzlroMwWNlH0GXleeSkEse1Sy9YDgRk
 cEtSX2msk7c6sg0d85AHdETD6b+ZpjcxDkqMwDOU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TG9Q13040512
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jan 2024 10:09:26 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 10:09:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 10:09:26 -0600
Received: from [10.249.128.48] ([10.249.128.48])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TG9LVv013308;
 Mon, 29 Jan 2024 10:09:22 -0600
Message-ID: <9e614e85-36dc-3273-b117-ccaecb732f99@ti.com>
Date: Mon, 29 Jan 2024 21:39:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] video: tidss: Use DT property names for parsing nodes
Content-Language: en-US
To: Nikhil Jain <n-jain1@ti.com>, <u-boot@lists.denx.de>, <agust@denx.de>, Tom
 Rini <trini@konsulko.com>
CC: <sjg@chromium.org>, <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <a-bhatia1@ti.com>, <j-luthra@ti.com>, <nsekhar@ti.com>
References: <20240124090711.305690-1-devarsht@ti.com>
 <4eea1235-9e88-4044-9095-dcded9ad7f74@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <4eea1235-9e88-4044-9095-dcded9ad7f74@ti.com>
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

Hi Anatolij,Tom

On 24/01/24 17:28, Nikhil Jain wrote:
> Hi Devarsh,
> 
> On 24/01/24 14:37, Devarsh Thakkar wrote:
>> Use device-tree node property names for parsing nodes instead of
>> indexing as indexing could be different between different SoCs based on
>> number of DSS entities available on that particular SoC.
>>
>> Also correct the video layer naming in driver to match to actual one
>> being used in upstream DSS device-tree node [1].
>>
>> This also fixes AM62x splash screen usage using the latest upstream DSS
>> device-tree nodes where hard-coded indexing which driver was using
>> before this patch was not matching the correct properties in the DT
>> node.
>>
>> [1]: Upstream AM62x DSS node:
>> https://github.com/torvalds/linux/blob/v6.8-rc1/arch/arm64/boot/dts/ti/k3-am62-main.dtsi#L774
>>
>> Fixes: 5f9f816bb8 ("drivers: video: tidss: TIDSS video driver support
>> for AM62x")
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Reviewed-by: Nikhil M Jain <n-jain1@ti.com>

Is it possible to pull this in for current merge window for v2024.04 ?

Regards
Devarsh
