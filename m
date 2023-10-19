Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB9CCDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D6787490;
	Thu, 19 Oct 2023 17:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697729747;
	bh=6hJsTkfRLNrf32RVxzvgTtUN9arxlLriQwYDXvGtlcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQQtJ9q1iYPfojsMMQ22foRXsmF+tZmn3Z1NaQQY0zh+TiRDoT8hR937kq93CU4nB
	 L+gDyl3aNjZiRH+CLoU58NChSkO6eRZJJDyiOz8L2RuKhP2pArP29D3WrIinO7Lfan
	 2DagmCUHBU8eNUeK8E2zWubo3UZrakxVAjxBkDDf4NHp/72mtgkURBenWbB71TReGY
	 e/bzm1a/QxDjWYS0MNS5O/C2c/sPv2bWUnuveJ/8WrRUCMC+fZZj6eq3ieqGxk15Wx
	 GdBlMZTpo2YXEV4kMR9hFkR06SBqyEr9sPs2ZW9nfa5WKzokHrRbpuM0xmk5pt4ZYG
	 76f7TvUDgZJpg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7D0128747C;
 Thu, 19 Oct 2023 17:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697729744;
 bh=6hJsTkfRLNrf32RVxzvgTtUN9arxlLriQwYDXvGtlcg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gSZvfKPBGkC+rcDIkjDNLrPl4NFTEjsDuG3eyW4o8+fiJbVgLMUs6oWr8Jk6fJlui
 vTbbqdsjqPIQZG/3QsX9Bij0hdqOtjUy24oQBibxw9rNcRnQQCyKuaVo1b3Nb/MP1V
 c6rvrBiJZFhdbOYtH9KRcBOfLRTYLc8OaoeZB3oTB8PVdtqqNcIX8Td0u0Z1Oy5SvL
 rdfqGb5obTtSJ1b1soh2mtxQS1s85XtQ/+ixe9NnubKPXJx/t0mbyNfV+wOG8h+Svv
 kAdoHxAHkIC6QJ267O7gWv7WNCOOme6vPvmsJKd0NmNt69j3GXj1kuSSwTJxT3ltup
 BFAqeNRQjB8uw==
Message-ID: <27774b01-7270-4033-a199-562cf1d2adea@denx.de>
Date: Thu, 19 Oct 2023 15:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] led: introduce led_bind_generic()
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>
References: <20231019095837.2084458-1-rasmus.villemoes@prevas.dk>
 <20231019095837.2084458-4-rasmus.villemoes@prevas.dk>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20231019095837.2084458-4-rasmus.villemoes@prevas.dk>
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
> All existing drivers in drivers/led/ contain a .bind method that does
> exactly the same thing, with just the actual driver name
> differing. Create a helper so all those individual methods can be
> changed to one-liners.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>

Reviewed-by: Marek Vasut <marex@denx.de>
