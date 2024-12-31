Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0CBE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2FF8021A;
	Tue, 31 Dec 2024 19:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668804;
	bh=TCreublYCQecGspKxFJqK75uv+wq7L23vimd0HULjCs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfV9i0eIotXZwQgHNrmCL/UZ5zLSFAMJIwi9WCHrQqDPSjvS0sAiI6ifvmQP4v0Ck
	 tkt1vfgWOJkHSBJSGklGt0WqkdOwkZ9sqY8ORXis84pylRbroAAhFUk1JqIZy4uRPv
	 tPZ2fxp5/2MSB4HH7VwuCwUCAzSSY90icH+ZzgRo6h/D9+bX/8OwTT0OzUT3KOIXT2
	 xo3rnje3FHyGb7DFgfVqazXxqQL6/SayKCqMiySrh8BICNnH8QgzzQry9Nyff7QVOL
	 O2uyKWGoyFlK7l2kvqgm47lv5XIGN98a+xtoBcsp44IT7j7jmsCr2ZqsyVwYJi9L4Z
	 wrVAw3ukXwlCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C778039B; Tue, 31 Dec 2024 19:13:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2D768039B
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="GPfL7zgH"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 81F4E10486D95; Tue, 31 Dec 2024 19:13:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCreublYCQecGspKxFJqK75uv+wq7L23vimd0HULjCs=;
 b=GPfL7zgHrnnC9uXD2YiolV9Hi4uzQBmmY1MNPQbBCd+WNYYWcG091mcPvByoVdUObVw1PG
 P2JH7J054kq7u8DBkUldjOSVpLBq9iBvuTmiwkZxqw/yMXHNFWWXDcnWOZmxc89jiN5mZ1
 iA0neDab7xke3jIpIXMwzeuBU69Pbu2M33un26rsIwdUmmhfnviKf+ECjMaEJSpIO80iJU
 k6Zj71OuO2bvlycxweIq9sEYfnUkH/+jgumqC+xKzMV+ggMdebqAaxOr7UrbF8OzeprAVX
 IlixerwMeUJWbCfAgCKZF1hE0hrtJwVgWkQstIMrgdWwIwBxztYyF225sE1knw==
Message-ID: <a861de9c-231b-42dc-8296-7919b038da02@denx.de>
Date: Tue, 31 Dec 2024 19:10:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] USB: dwc2: Fix HBstLen setting for external DMA
 mode
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-3-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-3-12cd9b8a2358@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> The loop used to calculate HBstLen for extern DMA mode does not produce
> the correct result according to the datasheet [1]. Replacing that loop
> with a direct calculation using LOG2 to correctly assign the burst length
> in the GAHBCFG register for external DMA mode.
> 
> [1] https://rockchip.fr/RK312X%20TRM/chapter-26-usb-otg-2-0.pdf#page=24
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
Reviewed-by: Marek Vasut <marex@denx.de>
