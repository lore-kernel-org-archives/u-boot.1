Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A2FCD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 11:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3813E84671;
	Fri, 29 May 2026 13:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sN91++ff";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IfheRPNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AAC846B4; Fri, 29 May 2026 13:12:43 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69ADF844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gRggX6x67z9tk3;
 Fri, 29 May 2026 13:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780053161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jdu5Ycvznc6GZWXfJDmUVQ0+TF0A/Mo1bdnPrjnPEU0=;
 b=sN91++ffIfN3KKcCiXJ6zqUsvB00kSQdv/MRcnJmOGzeWk9d9sTSvn2TjaIQYWpwAYF8Ca
 CVsLi1MWWyc4x/HvFprWwqINtLNbVk0JGS7xRUmKdoFHR8aB/17FLQOAQuiFyU3Dn2HnCK
 cZPlsi6UGqNyYUkgAYEQk+hahjFj47J8ptlhMGwNQu5GjSngYRtUzcUlhXuEHcEuMuSvDm
 AWH6OANxTvDIktv0OMYdcjF7uBSlMjvJzOheH/Cuhw5Rqj6DtT8V+rKJHrThZGAjMK7eLH
 IpU4LPYCe6dJMpJV1NQXnHU5tK+oBxemrt67ZCluJZssAm3NFOsePyKH7sUE7g==
Message-ID: <66ed0a35-105a-4919-86b2-7be6eeca1e9d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780053158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jdu5Ycvznc6GZWXfJDmUVQ0+TF0A/Mo1bdnPrjnPEU0=;
 b=IfheRPNsMSIFcak5TUfqWE9aG/iJ4S5yVJCbDcPv+x6acCmrfbbaezwoL4zXybbUT7R6N1
 TP8GUw+5/GKrb/EQI1wcHKUQafsDyzJK3v+0sXhTjUZzI21McBagQN8eYb7RgvokNtDOdS
 g/RIsjyLQlL4lAP+nRYlyamADxqBrLy1zDj6J6/VcvFrR2MX5bVz35YTmxfbD5bWDL5jNK
 VqXO/S20mnvWYn8+iEdOsMhrDJ3tg1Dic+XTxe4yEgIRUjH7EKSeHjIGvDEaDJ3/4sXzCL
 ofX8gQYMjEU1eGxcOyg48xoyghFjz2Q6Zm7eK4HLtbtp6rnCzlhhYdXxS2pGqw==
Date: Fri, 29 May 2026 13:12:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/3] Enable Arm SMC watchdog for STM32MP1
To: Yann Gautier <yann.gautier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Anshul Dalal <anshuld@ti.com>,
 Christophe KERELLO <christophe.kerello@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
References: <20260520160715.175032-1-yann.gautier@foss.st.com>
 <f48f9d8d-4b14-4745-8c96-2c315889f770@mailbox.org>
 <b74d784c-9728-4242-a9d0-e0c805048c7d@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b74d784c-9728-4242-a9d0-e0c805048c7d@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 3cgh999piq1erwcnzskzo8wwj4kfbtzc
X-MBO-RS-ID: 18a983e606e79cab85d
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

On 5/21/26 9:20 AM, Yann Gautier wrote:
> On 5/20/26 18:38, Marek Vasut wrote:
>> On 5/20/26 6:07 PM, Yann Gautier wrote:
>>> This series adds the supports for Arm SMC watchdog for STM32MP1x
>>> platforms. This enables the required config flags for both STM32MP13
>>> and STM32MP15, and updates the U-Boot overlay DT file for STM32MP15
>>> in SCMI configuration.
>>>
>>> This series also requires a patch from Patrice[1] increasing the
>>> CONFIG_SYS_MALLOC_F_LEN for STM32MP15.
>>>
>>> [1]: https://patchwork.ozlabs.org/project/uboot/patch/20260518- 
>>> master- v1-1-37fd4df56609@foss.st.com/
>>
>> I hate to nitpick at this point, but, it seems the two patches in this 
>> series do effectively the same thing.
> 
> Not really, the watchdog config was already there for STM32MP15, and we 
> now enable and use the Arm SMC watchdog.
> For STM32MP13, no watchdog was configured at all in U-Boot.
> So for me the patches titles make sense as they are.

Sorry, was busy with too many other emails.

1/3 and 2/3 does the same thing, enable CONFIG_WDT_ARM_SMC, the commit 
messages should be aligned. Do you even need CONFIG_WDT=y in 2/3 ?

>> I'd say, align the commit subjects to something like:
>>
>> configs: stm32mp15: Enable Arm SMC watchdog
>>
>> And:
>>
>> configs: stm32mp13: Enable Arm SMC watchdog
>>
>> Even the commit messages can likely be aligned ?
> 
> I'll check if I can improve that.
Please do.
