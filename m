Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B94C43602
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 12:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4615E84A47;
	Mon, 29 Jun 2026 14:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="l1xD8lPZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7FEF849EF; Mon, 29 Jun 2026 11:04:38 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB6184942
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 62DECC51469;
 Mon, 29 Jun 2026 09:04:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5876B5FF96;
 Mon, 29 Jun 2026 09:04:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A1B31106F01D9; 
 Mon, 29 Jun 2026 11:04:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782723874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=M7jKq4qnP5eDQFvbHoPi0vtpBTefRxKcQlTaqkdHPuU=;
 b=l1xD8lPZAzSjqbyuf5FVaePF6a2NJVpb18nxgyLRJ94s/GU5YfGTD4X6xS00xDjr4if8pH
 7et8bwUDVi6ZKmtmwEzqZ215mw8xgTqyUT0ILCSzSqegpeKY70dzP2qFKLpbas8z9F3769
 IKSuyAQ3OtEjEPdtEcFKEnyK7oCXZgqInaC7MaNqB1gj33LgH2W0Fw6pQNvRBg9RY0KTbi
 /QnKRF46hmP0ZizrTbyErIPXgM0a+7yzrYyKTS8LQtHBQQ1lVO7fMK7YpeSjN31iZLjYSV
 Ki7/O49OIBkomzbN18t55da2tHFegVawBqj2+cIepwzxzG2SCVkZ3ZpBQw3VBw==
Message-ID: <3ea7b87a-22b8-4c4e-a42a-fadd8b609939@bootlin.com>
Date: Mon, 29 Jun 2026 11:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] clk: ti: Remove AM33xx dependency
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Anshul Dalal
 <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
 <20260608-omap4-support-v3-3-8595ccd203f0@bootlin.com>
 <20260625181812.GA3892257@bill-the-cat>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260625181812.GA3892257@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 29 Jun 2026 14:47:37 +0200
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

Hi Tom,

On 6/25/26 8:18 PM, Tom Rini wrote:
> On Mon, Jun 08, 2026 at 03:11:59PM +0200, Bastien Curutchet wrote:
> 
>> The clock controller driven by this driver exists on other OMAP platforms
>> than the AM33xx. Yet, it uses functions provided by
>> arch/arm/mach-omap2/am33xx/clock.c making it unusable by other OMAPs.
>>
>> Replace am33xx-specific do_{enable/disable}_clocks() with new static
>> functions implemented locally.
>> Replace the am33xx-specific clock header with the one shared by all OMAP
>> platforms.
>>
>> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
>> ---
>>   drivers/clk/ti/clk-ctrl.c | 48 ++++++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 37 insertions(+), 11 deletions(-)
> 
> The labgrid issue we had meant that I didn't get this tested again on
> beaglebone black until now, and *this* commit leads to:
> U-Boot SPL 2026.07-rc4-00462-g7b87c16a2945 (Jun 25 2026 - 18:10:48 +0000)
> Trying to boot from MMC1
> 
> 
> U-Boot 2026.07-rc4-00462-g7b87c16a2945 (Jun 25 2026 - 18:10:48 +0000)
> 
> CPU  : AM335X-GP rev 2.1
> Model: TI AM335x BeagleBone Black
> DRAM:  512 MiB
> ### ERROR ### Please RESET the board ###
> 

I'm going to take a look at it.


Best regards,
Bastien
