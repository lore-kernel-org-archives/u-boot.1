Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3966EC021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 14:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B8180EC0;
	Fri, 21 Feb 2025 15:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RHGF0EqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA90F80F56; Fri, 21 Feb 2025 15:19:44 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D81806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 15:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9db3=VN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1740147581;
 bh=hA+ICsvBPMoBpD7j+4GGhfxC/bj1x2giNHjWSrR+6uo=;
 b=RHGF0EqNQ+ICthVcLr5zy5eM5sySnh1ig22pwL4QWw3uhujW0y02efanYR04bGbDUkof4YthJ
 fUuWeBOcEG6eZeJetOTBYMOgNCLgr045mciw9mUgXuHtGNyTSojRcb875FPn5U9Kc9jPkq3OIfr
 9C7PDPTB2YV1vkSfb9k38mc+tBQQNk6BP8BimslaDfN/EUAptpg9ZJop0kYILnnVf87bsZ3yvw1
 wG5UmklIewVcBVIj8pHGW/yuyz1JzfUtW/zA5+jNUUCblW8cE61qPCm+bllmU0LTq9mYOhcnoaB
 3ZJ9vp0Qrd/OeZpNCbmWKbcJfxkcdYfmHOseY6NMVWFw==
X-Forward-Email-ID: 67b88b7938976bdac8636a80
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5c85ed27-384b-4e8e-ac19-b5641ad2b522@kwiboo.se>
Date: Fri, 21 Feb 2025 15:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] power: regulator: Avoid probing of regulators at
 pre-ram stage
To: Udit Kumar <u-kumar1@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com, jh80.chung@samsung.com,
 marex@denx.de, nm@ti.com, patrice.chotard@foss.st.com, n-francis@ti.com,
 sjg@chromium.org, m-chawdhry@ti.com
References: <20250221124505.1972915-1-u-kumar1@ti.com>
 <60f6f69d-7bdc-4ddd-b4f6-05b8d34ca382@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <60f6f69d-7bdc-4ddd-b4f6-05b8d34ca382@cherry.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Udit and Quentin,

On 2025-02-21 14:54, Quentin Schulz wrote:
> Hi Udit,
> 
> On 2/21/25 1:45 PM, Udit Kumar wrote:
>> commit 51c4679d2f84 ("power: regulator: Trigger probe of regulators which are always-on or boot-on")
>> allow always on and boot on regulators to be early probed.
>> Due to this probing boot time increases.
>> Since in hardware regulators are always on, so probing of such
> 
> According to the DT binding:
> 
> - regulator-always-on only means it should never be disabled, not that 
> it's automatically enabled.
> 
> - regulator-boot-on means "It's expected that this regulator was left on 
> by the bootloader." We're the bootloader so it's our duty to turn the 
> regulator on.
> 
> So I'm not sure the justification is valid here.
> 
> I vaguely remember this patch was discussed a lot between Marek, Simon 
> and possibly Caleb so let's see if they have something to say.

Correct, this cannot be reverted or it will break platforms that used to
call regulators_enable_boot_on(), see commit 6f52feee2867 ("power:
regulator: Drop regulators_enable_boot_on/off()").

If you want to skip probe, please ensure that appropriate bootph- props
is used so that the regulator is excluded from your platform pre-ram
phase.

Regards,
Jonas

> 
> Cheers,
> Quentin

