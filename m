Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CA1C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A1188271;
	Mon, 17 Jun 2024 15:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UU10Obb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003F9882DA; Mon, 17 Jun 2024 15:44:53 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4538687DC7
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=f7b9=NU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1718631882;
 bh=z5293sXJafD63PSSLAnzDKM7ZwimGO1qg4Z9B1QqrhU=;
 b=UU10Obb1kvljyyUTNhgbQCtxlW6zDKM7WXz/Uo+IBc23ZGLSak+AaopV4ZHh+HijuVXTtr4IM
 d2qP1T0N9/y4RLVgxcephW8jaeXZabJ6mK8+alJ3OpMM/9EB+BZspvB38AUy+1WgXQg9Ww7RSAx
 uINND3JrShKUkh1KTVxB4Z566WN2nJhQ32J4W0YiTAING56UADlXw2Z67QKNlayiqKVGagn5GU0
 EbYwRnbNE2BWQ2hZgvI3FWyRfMNAel5PX/7boN1Y49h1oV/m2U5Xt8F2VL5JIRvVzWNrFufAb+U
 TXxT3uPW1VIlpR0Jnv0B9KXxgp3B+nVtrkoOfZ3JczTA==
Message-ID: <81133178-c476-49fb-ad49-dfc00d7a4adf@kwiboo.se>
Date: Mon, 17 Jun 2024 15:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Quentin Schulz <quentin.schulz@cherry.de>, Quentin Schulz
 <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom
 Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
 <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
 <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66703dc8c9f2f712a5a194dc
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

Hi Quentin,

On 2024-06-17 15:29, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 6/17/24 3:26 PM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 2024-06-17 15:10, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
>>> when booting from eMMC"), the spi1 bootph properties were mistakenly
>>> removed meaning, so re-add them back to fix SPI-NOR flash not being
>>> found in U-Boot pre-reloc as required for RK3399 Puma.
>>
>> Good catch, for TPL/SPL the bootph props is propagated, something that
>> is not done for pre-reloc.
>>
> 
> Can you tell us a bit more about this? I know that the pinctrl nodes 
> marked for pre-reloc recursively apply the same to their parent, but 
> couldn't find anything similar for other subsystems for example. What 
> did I miss in my 5m search?

v2024.04-rc1 added support to propagate bootph props using fdtgrep for
the u-boot-tpl/spl.dtb files, however pre-reloc the main u-boot.dtb (or
possible the FDT included in FIT) that is not processed by fdtgrep.

fdtgrep: Allow propagating properties up to supernodes
https://source.denx.de/u-boot/u-boot/-/commit/7a06cc2027c0169c462da63a68fa269c0d59a950

Makefile: Use the fdtgrep -u flag
https://source.denx.de/u-boot/u-boot/-/commit/aca95282c1b72c41d8e72984b1dceb15f396b2f8

I solely relied, wrongly, on this new propagation to justify the removal
of the spi1 node, without ever thinking about that pre-reloc uses an
unprocessed version of the device tree.

Regards,
Jonas

> 
> Cheers,
> Quentin

