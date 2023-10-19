Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C565CCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C08874AA;
	Thu, 19 Oct 2023 17:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697729749;
	bh=gTuCD7oriDbgIsoQXJRWqvmOtOWYvZ+75u6IZGsvw+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGNuQIu63z5MteOUgqEG3S1y6hF7agYJUKRI6lT88NYtYMr9CZcGUazP2iSJblNZu
	 L5RLyroKF3CaqU1oB1wzqqsOWeDZIL86ui1xKd07K9bPcb6U2iHt+JWenoej4IfchU
	 Dyv5NrgvztKelEkyav0RbfOoyNB1xleF5RJpjExU2lkO9gJcyjwWB70rXSu+MC+Y47
	 LxG5pms99yP7LXyGijlbKneZiUbrjEzmWMIQNLgS5tn0JH3l91VWdVN8yRxzT693et
	 nMnr0mgeOkuCa4kcKNb/gJqFm9dA9Owdl2vBwhntFldcLDKOEuMJcDaOBQFohcLKX3
	 CZMMTj1oXcW3A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6C88B8727D;
 Thu, 19 Oct 2023 17:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697729745;
 bh=gTuCD7oriDbgIsoQXJRWqvmOtOWYvZ+75u6IZGsvw+4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qvoXTXnFDgQTT116Y/EbPqoc2FSlOxNY4yu9jXE4iRHbwH8YxazfkI+2HiCapv9/G
 K/5xpjmwr80bdJGETkiW7N4shUwNcvO6C+Bm7dXRIJ1eJOwFm0lWsr3yAUUdeJI54d
 9OvtCblp128Mv1u/p04SVd62r+XToZbtq95aHH4O0yEzRV9oeDtAmSaKRiCmOYYP6M
 JPdwZaDSOLAcZhwKnS4nuPQfjMdMJLEu/NNIEsYFHVfsiQhpUYjhPArTQWdHq5xwEt
 sfc2AJmZ/FKnjXop5ABLn+T3DNobaoBDdx/YTpTZut93CQvahr+VMoBmW7cicRXzL9
 bQQbNZg71XxqA==
Message-ID: <e19b3976-0cfa-41f4-bff6-cdd8190c4e7e@denx.de>
Date: Thu, 19 Oct 2023 15:57:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] led: led_pwm: use led_bind_generic() helper
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-6-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019095837.2084458-6-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/19/23 11:58, Rasmus Villemoes wrote:

Commit message is missing.
