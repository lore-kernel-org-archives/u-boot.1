Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D53FE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 14:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E3AB88CEA;
	Mon,  9 Dec 2024 15:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="T9r8zl7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE81189407; Mon,  9 Dec 2024 15:01:29 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 258DE88C85
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 15:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=483b=TD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1733752880;
 bh=Pe5saov5bkR4EainfoM+cxfoGeYxXM+2ptIFuHd+PcY=;
 b=T9r8zl7MUcIlJdxj6DrJ+7nWkMQKWyXDgC2ezbUsZe3sBb4bLQCr/pLdBh2xcXTEGmrMHuhsC
 2S/H2nBbOZx09B6IqU11m6tIb70ZMUNoV2zkFXA/BvfbpHnRCNG5ECeiU5rVMxXnouz835bx7V+
 GT+klIw6j9r3Y3iU70ZfPyPsZrx+pxze68xN41VXDRWclhvtAN2iXU0nLmr0L24H8z5GsqO8A8M
 0pL296vDfW5Uu0XPwfijw3MPBQLolgiIS6W80PypZCj9SE6OFvhoNNNKj8iO3gZPmz5dqpUqFET
 1gRwPn5BYnFFA+WW3UaqGwTH+Vo7jNBtpCGU6V6MIlCg==
Message-ID: <e2264034-0c14-445e-a565-4b456ac4de0f@kwiboo.se>
Date: Mon, 9 Dec 2024 15:01:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: use OF_UPSTREAM for rk3288
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 u-boot@lists.denx.de
References: <9419288c-ee9a-4b5f-a02e-1d7a58199550@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9419288c-ee9a-4b5f-a02e-1d7a58199550@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6756f82fc1cee88047b936cc
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

Hi Johan,

On 2024-12-09 13:30, Johan Jonker wrote:
> The device tree for rk3288 combined is now
> available in the /dts/upstream directory.
> Use imply OF_UPSTREAM to migrate all rk3288 boards.
> Clean up MAINTAINERS.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

[snip]

Please rebase this on top of the following series:

rockchip: rk3288: Include files from dts/upstream
https://patchwork.ozlabs.org/project/uboot/cover/20241109210427.884888-1-jonas@kwiboo.se/

rockchip: rk3288-tinker: Migrate to OF_UPSTREAM
https://patchwork.ozlabs.org/project/uboot/cover/20241105160054.1373319-1-jonas@kwiboo.se/

rockchip: rk3288-miqi: Migrate to OF_UPSTREAM
https://patchwork.ozlabs.org/project/uboot/cover/20241105215202.1491441-1-jonas@kwiboo.se/

Similar cleanup/fixes should/could be made to other rk3328 targets.
Already have one for rk3288-firefly incoming.

Regards,
Jonas
