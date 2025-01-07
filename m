Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0B8E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 11:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0DB3803DC;
	Tue,  7 Jan 2025 12:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736249104;
	bh=2Q50Z12La7togQsVFVXHWdLKZepEpuSJDClGFG/Yk8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1i9moVo3VKO07JPG9LIfJYcvwiAJv8sMbxnnBfgJuvv1nOQKWOlhDFO+fGkwXdnn
	 FTSo9hB5Dyka2ZG/MZmoKAvRWN/bFBSZL2SXXxf41noLrZMIlHTywMeRa+sqgqYZD6
	 WBFKP4rI3PiMGK1SPtS86E+S5zcFjeYqXQl/c6LmTLB3BIMNXvSpabUDS+u2ESvNZs
	 +zAL9KVRga4sH5uKskf/L9MTjrZYIQ2nDBY4FAfkG3tZTmTj9ioefW6d8BIOjg1q/4
	 vhnO+35fBd0Z9iEMKnPj1537+56UU8GQdvTUEa9hmkBYzF6KjWu/U5h4bl9ApKlqZJ
	 0K3JUvgrdi5fw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F48F80601; Tue,  7 Jan 2025 12:25:04 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8891C801FD
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 12:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OBfdu0qd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CFEC1104811F3; Tue,  7 Jan 2025 12:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736249098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Q50Z12La7togQsVFVXHWdLKZepEpuSJDClGFG/Yk8k=;
 b=OBfdu0qdnGTd8RM4cvvMfvG45IxptloudsqORkeGxTH6leQwlP+RIOoi7Qh3NOxAQ6iUWt
 j5YojXeZntpF95ow+PinWXpZcfMR5Dadnpst6xI4SK0hT/T4/Lz4utBfEVOI2iVQtAAmmq
 iAIjl1Y5g9RO0tnkhbkZ7503sMQm7wEUO8mYvloGHLBtmWdwW9jy5QIwnQed/dzwMU00+S
 LDQlKJ7ECgx8yGtb92CvcR7Bfd8ZfNCUggn29Zd1O5Nl3UGwICPD/i7ESooAnIms+zNSb4
 yl4Fir8RK+zrmOeq90EvK+DNh52DP8yWxpR31HXAW7tLT83p/V7/uNSX2Ae/+Q==
Message-ID: <764324cc-f845-4314-b336-8033e5df7444@denx.de>
Date: Tue, 7 Jan 2025 12:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW0VYVF0gUmU6IFtQQVRDSCB2MyAwNy8xN10gY2xr?=
 =?UTF-8?Q?=3A_scmi=3A_check_the_clock_state/parent/rate_control_permissions?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
 <20250103-imx95-v1-7-6744df5dc020@oss.nxp.com>
 <0898a19f-e6f1-4fa0-ae0b-6f696ffbc837@denx.de>
 <PAXPR04MB96440B011EEC2F444897AF44E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB96440B011EEC2F444897AF44E2112@PAXPR04MB9644.eurprd04.prod.outlook.com>
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

On 1/7/25 9:00 AM, Alice Guo (OSS) wrote:
>>> SCMI clock management protocol driver in Linux checks clock state,
>>> parent and rate control permissions. To be consistent with the kernel
>>> driver, add this check here.
>>>
>>> When using common clock framework (CCF), use the clock signal ID to
>>> get the clock registered by clk_register() in scmi_clk_probe(), and
>>> then obatin the struct clk_scmi variable with container_of().
>>>
>>> Signed-off-by: Alice Guo <alice.guo@nxp.com>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> Reviewed-by: Peng Fan <peng.fan@nxp.com>
>>> ---
>>>    arch/sandbox/include/asm/scmi_test.h       |   2 +
>>>    drivers/clk/clk_scmi.c                     | 173
>> +++++++++++++++++++++++++++--
>>>    drivers/firmware/scmi/sandbox-scmi_agent.c |  56 +++++++++-
>>>    include/scmi_protocols.h                   |  26 ++++-
>> Please split common/imx/sandbox changes into separate patches .
> 
> Spliting common/imx/sandbox changes into separate patches will cause bisect issue.

How so ?
