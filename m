Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022D6CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 416CC86EF4;
	Sun, 15 Oct 2023 08:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QdvTiwqf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E10EC867EF; Sun, 15 Oct 2023 07:59:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B816A869D1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eb25=F5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1697349395;
 bh=3i/Rrxs2i7qgoMRvubA/mexjP61e7NLeQmrB5tUscRc=;
 b=QdvTiwqfcwm38ZxKC2E6VjjGyT7WsaaMpAfQpkuYmAlrH9tI1iMmPdrxZTNj+A+ijDuB6wfdy
 xG+OKyRkBptmWuWr9/9hQKPKGOvsA5Nd5oJgyxa5qN0o5IOvd4A/eotOE32mGWz3V3yI6/YUFt3
 0iP8fvFkwZFuSEUoSQEbNC/ZKKL7mGZUKDGJ0PLXrWfsfQ/AJIjLOPc4H84ejVKDBvbelBIhsuE
 p8RbW84J5f/6iHzk0OMEmmhADPRRbhCp7zsswOaGzpD8zf/awvrhZhmkT48wsTZ50aichlFL0Bv
 +lf5xCJz9YSCRW8peo0XIzRlNq0aISXgHFky11EzesFw==
Message-ID: <c4fd9d1b-d938-e00c-30f7-331713bf85f8@kwiboo.se>
Date: Sat, 14 Oct 2023 21:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] rockchip: rk3588-rock-5b: Sync USB3 nodes from
 mainline linux patches
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp
 Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Marek Vasut <marex@denx.de>
References: <20231010222344.3436526-1-jonas@kwiboo.se>
 <20231010222344.3436526-4-jonas@kwiboo.se>
 <5f8632de8eb8d1f3a31656e1c65ea30c70beb01a.camel@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5f8632de8eb8d1f3a31656e1c65ea30c70beb01a.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 652ae821048a763a5fcc82ad
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

On 2023-10-11 18:52, Christopher Obbard wrote:
> Hi Jonas,
> 
> On Tue, 2023-10-10 at 22:23 +0000, Jonas Karlman wrote:
>> The device tree for rk3588 and rock-5b contain usb3 nodes that have
>> deviated too much from current state of submitted mainline linux usb3
>> patches, see [1].
>>
>> Sync usb3 related nodes from latest patches and collaboras rk3588 tree
>> so that dwc3-generic driver can be updated to include support for the
>> rockchip,rk3588-dwc3 compatible.
>>
>> [1] https://lore.kernel.org/lkml/20231009172129.43568-1-sebastian.reichel@collabora.com/
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> These will be upstream shortly. Maybe we can wait until they appear in Heiko's tree?

My understanding was that the binding and only one usb3 node have been
submitted so far. So may take some time until all usb3 nodes fully reach
Heiko's tree.

I think we have two options for usb3 nodes, 1. remove them completely
until they are fully merged in linux, or 2. sync them to current pending
state and later sync to final state once they are fully merged in linux.

With this patch I went with option 2, can instead include a patch that
remove current usb3 nodes if that is preferred?

Regards,
Jonas

> 
>> ---
>> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
>> ---
>>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 148 +++++++-----------------
>>  arch/arm/dts/rk3588-u-boot.dtsi         |  39 +++----
>>  arch/arm/dts/rk3588s-u-boot.dtsi        |  68 ++++++-----
>>  configs/rock5b-rk3588_defconfig         |   1 -
>>  4 files changed, 99 insertions(+), 157 deletions(-)
>>

[...]
