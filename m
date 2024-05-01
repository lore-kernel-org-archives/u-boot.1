Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC24AC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 05:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4347988AD9;
	Wed,  1 May 2024 07:06:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714539970;
	bh=2B52E5JmkUAvawA5z12XHRKmeFgUcohq88W7AfPKkRI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cW4WgFXfBlXNfukxmmJyG8xKkQsRUYVtvS86ulB/XUe4BXoXNtAW7Xr8itnYsddtZ
	 y4+YBL0z3AHleLg4lDXJgkILuOSHKM2xko9O8tfg7QbeOEz+5CsnIYkE+Rgdmu+AYq
	 ulv2E53UQtKv48XbjoytwYN3LplZR6CJdHTMhx11uGJvBMYbJ78t8edKOcGFL+SoLx
	 PRiFc9zw6qZUXExgJ+FjlcF4ldUaY2Cv7DSESnz3oj5mZ2PvPgwLZMkPaUaVzEIYt+
	 xaKijNvIlNJRDFBxIyPRff1HPnJzbF29+oJL2oTjFISCIE8evC7kEPiEsElaqWiMUi
	 XFdv7gBZvI+QQ==
Received: from [192.168.1.107] (89-186-112-218.pool.digikabel.hu
 [89.186.112.218])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 31F0D88ACA;
 Wed,  1 May 2024 07:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714539969;
 bh=2B52E5JmkUAvawA5z12XHRKmeFgUcohq88W7AfPKkRI=;
 h=Date:Subject:To:References:Reply-To:From:In-Reply-To:From;
 b=luZi3cxfD4fvtPXjKZ1SgPoLCT4P0sK6DrxDO8xeAmVjRBWVu0KEHKLAh9sp2mkel
 8ggdjjod4D1pXoPsq4qtvNPrbBTdNpWEwESpt2Qw7V+yZxsQd3LFySR5my2ssNIyc4
 e0Hsslj3cRDujBcyvNJnzrxm+gtmZducNZXVaq/Fs84rN5hb338XfnkF7BYZIwFduJ
 HGEI5Aay5OlJ3RR7gp3B51CM2ac2N5COtB8WglMlW0LN/9ueFXrM36IROFNzxiNTnO
 nLwl+JmZyHu2i4nWsS976chR5zAIdziv20HnImhuyLCKsVmghWc8PMQ8DJ6y71sYxz
 vbnoAXIfb9olg==
Message-ID: <572abfcc-ac9c-d373-321d-7ceb50e7d00d@denx.de>
Date: Wed, 1 May 2024 07:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 017/149] board: aristainetos: Remove <common.h> and add
 needed includes
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-17-trini@konsulko.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240501024316.1767971-17-trini@konsulko.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Tom,

On 01.05.24 04:41, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> ---
>   board/aristainetos/aristainetos.c | 1 -
>   1 file changed, 1 deletion(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
