Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE47DC27C40
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90CF87698;
	Thu, 23 Nov 2023 00:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700697312;
	bh=k8f/4PH8t86TVr1aQfApS6/XZFrOmcV+BKqYj9G/WbA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XCKJFJ8JopngrITbbNaSgY5lwthh9Vo2iwcM4C/YXMfBV60hEdfVE1DqSmKCYJ0ld
	 AYo1yyKyjjAdVznjuHaySXuBdhkp5N/sjUad0qd2UIqMXvLzWE5xpBFxkvKM6zOcTI
	 8kNJz3JV8FxK1NfzgK3Iw5KFeMvw2JP5WWHMcvcY6BhXsml6Fjf5SCCmlyCmVf9429
	 64BUPBA+TzMxT9wsflalZLThSQEdcM+tEICD9+4NAJAjv36Ea9sSFivZUC4lk9CtPR
	 JtCCIKNBl5/KoCrmTptXyDgui1h4PQg8KurjiId1JK0R5b7T+lUSfJjR3ao4OmYyRk
	 mmQN9ez2XbGIQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E237B87675;
 Thu, 23 Nov 2023 00:55:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700697311;
 bh=k8f/4PH8t86TVr1aQfApS6/XZFrOmcV+BKqYj9G/WbA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jNsVCJ1eRAnwOmNvhxQXu7woNns/ADhmqAgIOyhnFP9l8wB8z+sVL1eBqQS5VZrW4
 ad5PDSiTHOjuCn2UJhd0of+XVgfrb5EMnt9EUBsBxwCLXzgsfo7CQnwvek0dWgqlxH
 e+efnMc3AwCCUf+2v4fBHEy+JCIkAIvjfMxdguT19jdrz/d2GIabnTAmPqGpJOGLUq
 r72YICpvRhGc5WN+H4q8fjJbSNvXk1v7BNvTLpSkPkP8HyNtRw4tmKm5bEEgtrLiOz
 BKKhXAdiiE7kOthXCJsph/K2C9MpmyAQRl7naKcBNv99tfXX2lKNUR6gBkH5F+t/Ua
 wOYDrfET+zVXg==
Message-ID: <37b4f93b-1fc7-4fcb-9ccf-507ffeed7afb@denx.de>
Date: Thu, 23 Nov 2023 00:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3-generic: Use combined glue and ctrl node for
 RK3588
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20231112152527.1306793-1-jonas@kwiboo.se>
 <141ed34c-93e7-4ded-8697-3fa5501d4ee7@denx.de>
 <242c3d30-81ab-4132-b002-045df675ed2a@kwiboo.se>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <242c3d30-81ab-4132-b002-045df675ed2a@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 11/18/23 00:30, Jonas Karlman wrote:
> Hi Marek,

Hi,

> On 2023-11-13 04:11, Marek Vasut wrote:
>> On 11/12/23 16:25, Jonas Karlman wrote:
>>> Like Rockchip RK3328 and RK3568, the RK3588 also have a single node to
>>> represent the glue and ctrl for USB 3.0.
>>>
>>> Use rk_ops as driver data to select correct ctrl node for RK3588 DWC3.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>>
>> Reviewed-by: Marek Vasut <marex@denx.de>
>>
>> Do you still want this in 2024.01 ? The MW closed just a few days ago,
>> but this seems OKish to put in still .
> 
> It should not matter if this goes to master or next. Next linux DT sync
> when this may be needed will probably not be until around v6.8-rc1.

Applied to usb/master, thanks
