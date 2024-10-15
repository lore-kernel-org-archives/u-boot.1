Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E221D1F9CB
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 20:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77C878897F;
	Tue, 15 Oct 2024 22:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CSKmVTYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9527488770; Tue, 15 Oct 2024 22:48:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8420F8862E
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 22:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c9a1=RM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729025300;
 bh=l8eyeAWt0DqkBdQyWBOGH9DNgV9DhnoOXMrxOokI/Cg=;
 b=CSKmVTYCj5xfWBtbW06XtzGNAGmHtNpbbruLAjQHyhPL4npscW7gujAgE2hIkISNf3g9Sg9IQ
 qHPrVfzGi5HrujhQsREFy0hzFhn4UIKNCe2a8dMYJ6+8b6+UuRheWBFUOqfmOZK34nx/5Rj0geD
 dw4nLkk5+KNxi9j1kY4HhfXT+f58Iw7SENiB6AEKR4Tz2P/Uy+fHGYYRsH6gkGW7KOt+aOfV5lE
 B+MWuWUY8zkq8LtsL2+pz1UnFqJOgjKKqNh/ybwhbW1U70vH1jsK/JLtSzFTNh4RP1FFQzA89tR
 NpMg3ogwsP6d3ya/PiW0cte7JFmswsLYTEyY1xsEoh3A==
Message-ID: <8cfc2a0f-dfef-4528-95fa-298bfc701ac7@kwiboo.se>
Date: Tue, 15 Oct 2024 22:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Makefile: Drop SPL_FIT_SOURCE support
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20241004230756.371153-1-marex@denx.de>
 <172902143755.5381.3133865412226742988.b4-ty@konsulko.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <172902143755.5381.3133865412226742988.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 670ed5137922294f1eb351c6
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

On 2024-10-15 21:43, Tom Rini wrote:
> On Sat, 05 Oct 2024 01:07:13 +0200, Marek Vasut wrote:
> 
>> The SPL_FIT_SOURCE is long superseded by SPL_FIT_GENERATOR which
>> is long superseded by binman, drop SPL_FIT_SOURCE support as there
>> are no more users.
>>
>>
> 
> Applied to u-boot/master, thanks!
> 

Look like 5b9261fb0b1e ("Makefile: Drop SPL_FIT_GENERATOR support") may
have broken ARCH_ZYNQMP, it still seem to use a mkimage_fit_atf.sh and
CI pipeline now fails:

https://source.denx.de/u-boot/u-boot/-/pipelines/22715

Regards,
Jonas
