Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE18C28B28
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 03:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02DBD8144F;
	Mon, 10 Mar 2025 04:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741576064;
	bh=5hgP8yPdolALPgi1KA4SAOuoSEjDvQNqueTmvJ2GRgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZQzJnSODEItx332wY6zXx1oymxZUDsqXPGwf6eOMudkMAbXnLfIMDlrPxoQfk5ZAv
	 4oOxp1okQbkkRjAopK9D7JBrN8b/fHJHDv437ivjM6/p4XAtaxW9XOSgGWKivDJ5H2
	 2ITTxv/cUOA2HW5Td8VZHI23yNcGevHBqQG5vF9Y152dLQ1UQKeylHy0kzrK74SXR1
	 Ok/cDCf6YSg/L6NClrmSyV5K9gV+nRu7f58G6iIgCPSl9t4WfStxDEeD4kpJDkne0t
	 lqURpzxmEIlOi+GlUxz+r7zzyPF9xUWkb2cX9t6qqNFsRONX6IR4M6XbB8zisojohk
	 BF+FXYSfZhcVA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B896809A4; Mon, 10 Mar 2025 04:07:41 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F948809A4
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 04:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="d42RrK6I"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4FE4E10382F1D; Mon, 10 Mar 2025 04:07:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741576058; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=5hgP8yPdolALPgi1KA4SAOuoSEjDvQNqueTmvJ2GRgo=;
 b=d42RrK6Ivaby6fCjIBgG7CZilZKfJMlsZrTAPUMAMxOHDD+Jea1fBikXzkapjfinn68AKd
 /hfm9JsXelqVh+aWdEoi0yihCyFgkslp8XZtActye19FF0WNnBu1Imw8el44fBVAVYSlaX
 hmxLhuzL8bd2vAu+/bfo71SwAW3I4wUq/jY5EkVZM1BrDm5UNNpB1gcogVgBLV3ryja4+t
 KvoyvLAdL8DqZrMy/gmXa548llAdvrwIxcgm/XwleUabbC/rAQ+1sU3nei8Tj/2zTDtnuf
 QqeuiIMOOTVFZauXYhvjhh2B4VxC4rElU/hgX7pEcx6obK8ioEsWZsMC8thrNA==
Message-ID: <a78cac46-5f9a-47ad-a4aa-b7b0df995992@denx.de>
Date: Mon, 10 Mar 2025 01:13:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbUEFUQ0ggdjFdIG1haWxib3g6IGFk?=
 =?UTF-8?Q?d_i=2EMX_Messaging_Unit_=28MU=29_driver?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "sbabic@denx.de"
 <sbabic@denx.de>, "festevam@gmail.com" <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "lukma@denx.de" <lukma@denx.de>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
 <3f5b9ee6-0def-43c6-a312-6248db8c588b@denx.de>
 <PAXPR04MB96445643235AE5C18C2D8824E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1081d31c-fd2d-4529-a651-5f5152d2b9ff@denx.de>
 <PAXPR04MB964472BBDAD65C0BE2271EC5E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB964472BBDAD65C0BE2271EC5E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 3/4/25 7:00 AM, Alice Guo (OSS) wrote:

Hi,

>>> The driver of i.MX95 ELE MU is in drivers/misc/imx_ele/ele_mu.c.
>>
>> Why does Linux use MU driver for the ELE , while U-Boot has some separate
>> driver ?
> 
> In drivers/firmware/scmi/mailbox_agent.c, some APIs provided by common mailbox framework are used. So, the driver of i.MX 95 MU for SCMI exchanges needs to use common mailbox framework.
> 
> In drivers/misc/imx_ele/ele_api.c, APIs provided by drivers/misc/misc-uclass.c are used. So, the driver of i.MX MU for ELE needs to use UCLASS_MISC.

Can we unify on single mailbox driver for iMX95 please ?

>>> No need to add the driver for i.MX95 MU V2X in U-Boot.
>>
>> How so ?
> 
> Because we do not use i.MX95 MU V2X in U-Boot.

OK
