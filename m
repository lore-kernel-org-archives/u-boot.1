Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68E9CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 03:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7D9848FD;
	Wed, 27 May 2026 05:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Z05czP0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39E384903; Wed, 27 May 2026 05:17:33 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28B68469D
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 05:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8E21C116054; Wed, 27 May 2026 05:17:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1779851850;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=4hvIBAxbUCIQNjpTuMFTRQuS45CVkiVDbBd13F8aLDo=;
 b=Z05czP0VgqNVKxF715ynCL48EQL5phwm54/2JKxdjnw/BXEQmC4ERVIbmR/y/jBgj2oD9y
 f1le11UDKnjfetp3OUPdhLz0F6PWv7gm8h17Qrpf3TfFLx2BDAM7sG98qNgw2GAHy+38Q4
 22/yny2S9DFK+REG8Nz4tywQHND7iDOy3w92Zd2ogLH+IpILxPIeWGwX1oAauCOu1SjcCe
 UrKlHg3s/MDov7qBuKHdpzzQxaM8KFv1PDs1wUTMGfSAWtLQbrU3Tb54E5vR8Qp1SspUki
 r3GSHQeXj98e7NvvH9I2cxkpMf1inxjHLvtLctPOQypFIcaVBN+ovvh9wSfMvw==
Message-ID: <aa62997f-8732-b4ce-24e6-8c349799a4b2@nabladev.com>
Date: Wed, 27 May 2026 05:17:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] i2c: nx: Add License
Content-Language: en-US
To: peng.fan@nxp.com, stefan_b@posteo.net, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260525040303.2367825-1-peng.fan@nxp.com>
 <20260525040303.2367825-2-peng.fan@nxp.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20260525040303.2367825-2-peng.fan@nxp.com>
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

Hello Peng,

On 25.05.26 06:03, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add License information for nx_i2c driver.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/i2c/nx_i2c.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
