Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1678CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 04:36:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6D93800D7;
	Mon, 29 Sep 2025 06:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="MBqS/HQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C130800D7; Mon, 29 Sep 2025 06:36:46 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E86800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 06:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC257104A47; Mon, 29 Sep 2025 06:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759120602;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=TB0Bpf48b1jLGRBt9p5a40FQN4cwIrWnXa2O8wgkhoI=;
 b=MBqS/HQwBFTOYwrdxe1BoDKqKqILTFJAwGv3uavSGIP7vP3yENqflCcs0MgMEhbV/q+Cvn
 /H9j1GD5eTjbH/VBx5XLG60fb7/Z64EyPF+waqwO2VgQxoqRKN/iXySpj5mgO9P6u9r/bV
 hZ0Qx9YIhuXtRKWxccmYGplORZJIfF+CMoieQbk2vrtCkbpXIq8eHOKapq+uM6/5WZb7HX
 nSyFpic6NsSkuKnm78zC0h6+To/kuhd4DqlabA9jZNnnYigWmVGGI3hWnOuP4m1AEi6ZfM
 6/uoe0KhrxuLhkFSLzhQ9WmG+/9iG5Q/Kxrys4lYkhv7hVe4WJupCfovy3FgFw==
Message-ID: <0a7a3a13-1184-2cc1-10ea-8657a6bd4620@nabladev.com>
Date: Mon, 29 Sep 2025 06:36:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1] i2c: designware_i2c: Don't warn if reset DT property
 is not present
Content-Language: en-US
To: bigunclemax@gmail.com, Tom Rini <trini@konsulko.com>
Cc: Wojciech Szamocki <wojciech.szamocki@nokia.com>,
 Dinh Nguyen <dinguyen@kernel.org>, u-boot@lists.denx.de
References: <20250926100530.732938-1-bigunclemax@gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20250926100530.732938-1-bigunclemax@gmail.com>
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

Hello Maxim,

On 26.09.25 12:05, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
> 
> If reset property is missing in DT, then we get this warning:
> 	designware_i2c@0: Can't get reset: -2
> 
> Avoid this by checking if reset DT property is present, first.
> 
> Fixes: 622597dee4f ("i2c: designware: add reset ctrl to driver")
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>   drivers/i2c/designware_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

@Tom: I think, this is a late bugfix, so feel free to pick it up.
   If too late for 2025.10, I pick it up and send a PR when 2025.10
   is out.

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
