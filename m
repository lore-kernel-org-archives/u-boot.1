Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D78D3C536
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 16:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1868C88F48;
	Fri, 18 Oct 2024 18:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vLXZ9q3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B0E88DFF; Fri, 18 Oct 2024 18:53:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22CBD88B0C
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 18:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9e6c=RP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1729270377;
 bh=pPlJwcEUAM2ZDm8MMeWQ+OYqCjJiv0vxDB6ZgI0eFb8=;
 b=vLXZ9q3XaNafup+AWQEN9ewzljAlmuMfeXh+PyQfSCIWfhix1D5CaSiodRq3PL6hsDaC4s0zP
 VSWcCNlTptnJD8082/Hoq5HFbzEtDFT41jmgsWXBnm5hLNxSxW6lRp/Dh3zUnOyHWHR4fMR73UB
 b/GAaHtwEwSNsOLjMuF87uGgvKcwmvCZFN7RIjAN3xujDm6tivWJOPHkDt+X36i6V5GMYR6v3BA
 zbDTiY0cz1TYhnDLy5BlCxlzL4y6zpPTX8skdGHUgIIAnS2Jj2trOp4SJHx2IinxixxGqN37xju
 HzuYfDa9O/eMkaB5q3v6lFbu9CqB1JvB1z4J5WmRTBjA==
Message-ID: <82641e12-f239-4fac-8cc6-6bca350e684d@kwiboo.se>
Date: Fri, 18 Oct 2024 18:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588: Implement checkboard() to print SoC
 variant
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20241018163423.1562287-1-jonas@kwiboo.se>
 <20241018163423.1562287-3-jonas@kwiboo.se>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20241018163423.1562287-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 67129268c2bf7088b282a4b6
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

On 2024-10-18 18:34, Jonas Karlman wrote:

[snip]

> +
> +	/* specification: SoC variant, 0x2 for RK3588S and RK3588S2 */

Will fix this comment in a future v2, 0x2 should be replaced with 0x13.

> +	ret = misc_read(dev, RK3588_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		debug("%s: could not read specification, ret=%d\n", __func__, ret);
> +		return 0;
> +	}

[snip]
