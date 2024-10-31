Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB48D74959
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 13:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C080689288;
	Thu, 31 Oct 2024 14:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qqVb4mKF";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HHP6mb/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECEA89293; Thu, 31 Oct 2024 14:41:15 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C5988E43
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 14:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XfQBK0PyDz9spH;
 Thu, 31 Oct 2024 14:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730382073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQP/2d4DbxegMQsNXvhyDTBHO2qBpqq8A+TI/3bq6lw=;
 b=qqVb4mKFm+wQqBAuE+MsfjY0tsL4j2uuVcjm0gh+4qOMdfaQMipQiP+zjNu2glOTYlz76l
 Yjpc0XHbvRRWUVB8OOmvEqKMSyV91iQKWggh7qtIS10FcSuCpcT6PaALJUzPbyXANEFlO0
 MMBVILd+MXfLE1HK/ouV4DIZKjCuPqGB7NBLiR4tl7pdosT8+aBYKm0r0OPcH3J4wUBJQQ
 acgS/7wabd/JxxUmfp4u/tZvQWOtkvs+T3f5bx9FfuA23uit0WWtFM32h7eerwEewJ0sKz
 j7sIM2h4pzwD1jWErQ+84/nFQzY/x0kG4ah0hruyT1ygM3pBQWU7ke2aejm4/w==
Message-ID: <44b1aa55-eaac-40fc-8924-b157314f39a1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730382070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQP/2d4DbxegMQsNXvhyDTBHO2qBpqq8A+TI/3bq6lw=;
 b=HHP6mb/xUWFeJ52Ni3d9o2kOT4gR8G/EZ2Cepdz40fnn/79QPxbBrRWMjjCAwYkMcJNeOn
 Lqt7KWWbS0p8pa9DA7lu0ef6nnruNkLZuMt/Sa3AvRkrmHsIgApg/8hCInrsGS5JtyLxcz
 rPDaxcnN3wZUOOEXMYld9j92A8BgvsJzwO5YPc4OJmwHDwI0AhaKb3skGwu2Bzcf2+YByP
 Yrq6U29jJ1PkS/h1HOKy6c2g5yu26fZr2OVjW5vK163v8jIwZp9x6UjkJU9sNbRLlYBEZ+
 aXlWPgply8LnDm3fvjbKR64N7lspFW/MUgCjnEiQOypGHz7Ont3ceyslvaHWYg==
Date: Thu, 31 Oct 2024 14:41:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] mtd: spi-nor: Remove recently added nor->addr_width
 == 3 test
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Pratyush Yadav <p.yadav@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241026201741.171073-1-marek.vasut+renesas@mailbox.org>
 <CAMty3ZB3ngMezv9S2XrNjXL69q+z9x-=qnQGga51FgTfA4fanQ@mail.gmail.com>
 <19fc4486-f8fe-4286-8941-76ff2a81b7d9@linaro.org>
 <CAMty3ZAJrKvUAxWg9CfKtyrjw+WnHOgwkfAJb+N-7d3NyXUrxA@mail.gmail.com>
 <f797cb27-84ca-41c3-83a5-b9044f2d5e5c@linaro.org>
 <3835b139-ae37-423e-8a24-a958ece69c0d@amd.com>
 <f5e21529-00ce-4eb1-b606-e300cd4d6e74@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f5e21529-00ce-4eb1-b606-e300cd4d6e74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: af0d677400956e5f00e
X-MBO-RS-META: nu55drjxm1tm16x5nyxefg31au9f55pt
X-Rspamd-Queue-Id: 4XfQBK0PyDz9spH
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

On 10/31/24 7:56 AM, Tudor Ambarus wrote:
> Hi, Michal,

Hi,

> On 10/30/24 3:20 PM, Michal Simek wrote:
>> Jagan is aware that we are using this configuration for quite a long
>> time and we are still here and not leaving.
> 
> Okay, great. Would be good if you/your team can allocate time and
> review/test patches that are improving/fixing the stacked/parallel bits.
> Help in reviewing other SPI NOR bits is appreciated as well.
It seems that over the years , there are no other users of this 
"stacked/parallel" functionality but Xilinx ?

Also, how does that work if one SPI NOR suffers a command failure while 
the other SPI NOR succeeds to execute the command ? Is that somehow 
handled, or is there an assumption that both SPI NORs behave the same 
way and can never fail independently (which seems like a dangerous 
assumption to make) ?
