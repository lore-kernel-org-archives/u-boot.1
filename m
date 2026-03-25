Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A524FEA806
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 05:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689218352B;
	Wed, 25 Mar 2026 06:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="duI1gizf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F2A838BB; Wed, 25 Mar 2026 06:14:04 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCC681E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 06:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 01D4010BB80; Wed, 25 Mar 2026 06:13:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1774415639;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=h+1uBTkVTchrcL/FDQCaByR0i35/+zI66cyCee8w1tg=;
 b=duI1gizfUkPBHRHGHINk9YP3SIu9gB/LzJLw3rl4wBaDGmCKoViVOqF74KWEiLnnoGeazs
 Pjfaf7NmrDXjXFoQn135ORJNlQDl6biFsOm7SG3eef9vyzsi6xcOS8YCHL+fBsPi8zWLXP
 PSncdrNfaHKhnJTEHXfe2cQB/T9/NwS3TnKnWIYXXFwANmpH98VhM8dTQKe/azkMwzalFO
 GPa7MBNw9OqAPub6gYa9Ga4fYZePuyCD2zBO6pUNzI7D52QZhjopdrh7YBPhE6BArQtrkJ
 i1JU4dlH/XBpIAQFKW37tLvyAJkSDwMO5MVXnDDborDtbDDat5SWMTBcy+GMZA==
Message-ID: <ea7e374e-b947-c7ed-67d2-487343d12d06@nabladev.com>
Date: Wed, 25 Mar 2026 06:13:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] cmd: dhcp: Select CMD_BOOTP
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
References: <20260325010659.279966-1-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260325010659.279966-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Marek,

On 25.03.26 02:06, Marek Vasut wrote:
> The DHCP command depends on bootp_reset() function, which is implemented
> only if CMD_BOOTP is enabled. Select CMD_BOOTP to satisfy the dependency.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   cmd/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Thanks!

bye,
Heiko

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
