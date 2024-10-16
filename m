Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA3D2A549
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 19:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D216F88DD1;
	Wed, 16 Oct 2024 21:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="YKrpVcJe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2440B88DDE; Wed, 16 Oct 2024 21:35:28 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe37.freemail.hu [46.107.16.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 592A888E18
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 21:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XTLlw1GryzX66;
 Wed, 16 Oct 2024 21:35:24 +0200 (CEST)
Message-ID: <6e52a56d-ad56-4314-babb-4a290db1c8df@freemail.hu>
Date: Wed, 16 Oct 2024 21:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pico-imx7d: increase ODT resistor value from 60 to 120
 ohm to improve DRAM stability
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, sbabic@denx.de, otavio@ossystems.com.br,
 Ray Chang <ray.chang@technexion.com>
References: <20241015002505.1243-1-egyszeregy@freemail.hu>
 <CAOMZO5B+EpaaP1YXNxWsk+6m4qU347cYBC-cMFYjiZTaB1s-kw@mail.gmail.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <CAOMZO5B+EpaaP1YXNxWsk+6m4qU347cYBC-cMFYjiZTaB1s-kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1729107324; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=805; bh=7OsfBWWrK+K17RLfa4JdSipK3j7aesX2KpfGNoRTcHU=;
 b=YKrpVcJeBbfmzn/AUak47qEjPvp2vCQK+gO00MNjA2sfBdCWEgj7Rrv6z+mnRPwA
 i7n1Z7pSpy5YGdOdguYXEl4o/S9Zex6w1ARz4eIfu6JUcMCalY28S73BOuATWDg63Em
 OTucfS4uFA2o/QyKRKmtNtLBGM+LdDlzvBlH4nwRp84P7nWNQ6IelGqZftJoGglm2Fw
 rzjjyWnC6N3sBz/lMFVmDtKsDPyeXDgXv+ufG8Q7Qsm/3a1Og83osisC52RKllFj4Zs
 J7DtEOezB3hACymRDguwIJSRW9mBllHU9P9xl/VmGP8PCci2ajjSpUhZZ0ofK6x+be1
 YObCHhYfjg==
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

2024. 10. 16. 20:32 keltezéssel, Fabio Estevam írta:
> The subject is too long. Make it succinct:
> 
> pico-imx7d: Increase ODT resistor value
> 
> On Mon, Oct 14, 2024 at 9:26 PM <egyszeregy@freemail.hu> wrote:
>>
>> From: Ray Chang <ray.chang@technexion.com>
> 
> Place here the explanation for this change:
> 
> Increase ODT resistor value from 60 to 120 ohm to improve DRAM stability.
> 
>> Signed-off-by: Ray Chang <ray.chang@technexion.com>
> 
> You missed your Signed-off-by tag.

I am not the author of this patch why i need to Signed-off it? It is a DDR calib 
optimisation from u-boot-tn-imx repo for pico-imx7d by Technexion maintainers. I 
can not share any more info why it is needed.

https://github.com/TechNexion/u-boot-tn-imx/commit/8a00e57b697c6f7d3d3abcfc552550ac7d8cc96d
