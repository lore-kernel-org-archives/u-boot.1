Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB232C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 18:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4092811DF;
	Mon,  3 Mar 2025 19:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Nb5p9rvn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67560811C1; Mon,  3 Mar 2025 10:48:27 +0100 (CET)
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com
 [220.197.32.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A88810EA
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 10:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chaoyi.chen@rock-chips.com
Received: from [127.0.0.1] (gy-adaptive-ssl-proxy-2-entmail-virt205.gy.ntes
 [58.22.7.114]) by smtp.qiye.163.com (Hmail) with ESMTP id cbf9d71e;
 Mon, 3 Mar 2025 17:48:14 +0800 (GMT+08:00)
Message-ID: <cbd6a15b-61b1-4466-9d84-d80d98ec8720@rock-chips.com>
Date: Mon, 3 Mar 2025 17:48:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] video: rockchip: Add VOP2 support
To: Dang Huynh <danct12@riseup.net>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>,
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 u-boot@lists.denx.de
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <20250223-vop2-pt2-v2-6-71350e482970@riseup.net>
 <97d68df3-e6e3-4912-aab3-0ffe09c218e2@rock-chips.com>
 <2377708.irdbgypaU6@melttower>
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <2377708.irdbgypaU6@melttower>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0MaTlZDQk1NQ0tMH0pISEtWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a955b67f61d03abkunmcbf9d71e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6HRw4LjIUI08qFjwrTRUZ
 EQ4aFCxVSlVKTE9LQkJOSUJMQkxLVTMWGhIXVRgTGhQCElUYEx4VOwkUGBBWGBMSCwhVGBQWRVlX
 WRILWUFZTkNVSUlVTFVKSk9ZV1kIAVlBSkpNQjcG
DKIM-Signature: a=rsa-sha256;
 b=Nb5p9rvnAdA3uOafLlSGld9dAyN3dfPAGg9NZwlJXYFAfAq6E2XqKWk1+rxRNXq9jz6uaZXqm/ArP4TnrOgwLLHXSldwE21ymswJXKU7VRWTjFJONyo5EfZSjqaLCn5cmMI4b6E9XRxphONv73ZqakFe9t7u06FCEq83iUhSFTk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=CWCdfALLXqQpQlZFSmkFBccpgjCJ0XGgLa3ThCC+6MI=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Approved-At: Mon, 03 Mar 2025 19:44:08 +0100
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

Hi Dang,

On 2025/3/2 12:09, Dang Huynh wrote:
> Hi Chaoyi Chen,
>
> On Thursday, February 27, 2025 6:29:13 AM UTC Chaoyi Chen wrote:
>> Could you use a naming prefix like "rkvop2" to explicitly indicate the
>> use of vop2, thereby distinguishing it from rk_vop.c?
>>
> Yes. This will be in v3.
Thank you!
>
>>> +	struct rk3568_vop_esmart *esmart = priv->regs +
> VOP2_ESMART_OFFSET(0);
>> You are assuming that the RK356X is always used ESMART0, which generally
>> works. But considering
>> that there are multiple Video Ports and different Video Ports may have
>> different primary win,
>> selecting the appropriate win can simplifies the processing for U-Boot
>> to Kernel transitions in the future.
>>
>> It's a good idea to implement the win selection as a configurable
>> parameter, or we can consider the
>> default win used for different Video Ports.
> ESMART0 is configured to the desired video port on U-Boot. VOP2 should be
> reconfigured by Linux.
>
That make sense.  But would this be a problem if it is to be displayed 
on multiple video ports (HDMI & MIPI DSI)

at the same time? I've only tested HDMI so far.


>
>
