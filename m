Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F95C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 04:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A0083E70;
	Fri, 11 Apr 2025 06:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744345279;
	bh=jfsSDUutk71+l19/vvdtsDHyupiKxQ1Et1aAwu6Vts8=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=SaN7ri1HWkPhRvgg8fliOglcY/S1RGTjvMvqE8E3bZgR5XUvr2YKE+kv1karN1Vb8
	 2uwxzQ3kXXOJYUU1V0wZYJQxqTDIJw9Vm00DqVLFe+rWiINM/iGOg/WttRFto79vig
	 jYF/pU6Hb6ja9GUk5Or2hqDuNwm1gJJqxpGl8KA5sjCW3eWoD8OFLwTAKosm6Y+RCj
	 hM4lKPC0QGq0cHy5b67LYuL/RhFKphTX899b4lpiqgwW+g1ztiyTjbACSMJrxtnCQo
	 TuklZ9i6QEz7bhF6UOFGE0fRRFkSpVPYImPI83pJmPCm/tHfFX3eC586eVybm41C5e
	 r0KiWdIwH+KIg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A833A83E73; Fri, 11 Apr 2025 06:21:18 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BDF836E7
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 06:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Lv8Py/Bo"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E436A103B92D7; 
 Fri, 11 Apr 2025 06:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744345275;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=jfsSDUutk71+l19/vvdtsDHyupiKxQ1Et1aAwu6Vts8=;
 b=Lv8Py/BoNWe4nhA+U4IPAPEbaE+n43vySXybg/sT4jA+J/L9Sg3hit+w8DqTU2Bhjw8DH/
 eNjjmDNtkkqgCtOzQUKxouaW41xMhem7T0jewIB35ezEs2muyg4H2DVpBHPIvtb9AWndsD
 tfp6zMClZaipuBVEgsdnI8TFVPEgIfs0vB00sbXZKcwKJscfDKl+AkCBu8DS+0tpX9J5xU
 2P0deyBxLhgwthOFjJmG1vTqUaNdOqUk0XMpBJMSyL74A2iqYveZ5Wc1ckfb2PWxx4ZkAd
 TEGWWWpMvgLrG5pf5eLeW1hmeRvUcKhmdSKV3C6igZMKUZudN5w/MCnGskoHcg==
Message-ID: <72eb977f-280b-5016-e8ac-76df95508216@denx.de>
Date: Fri, 11 Apr 2025 06:21:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mtd: ubi: Put MTD device after it is not used
Content-Language: en-US
To: Alexander Vickberg <wickbergster@gmail.com>
References: <20250410113740.1602891-1-wickbergster@gmail.com>
Cc: u-boot@lists.denx.de
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250410113740.1602891-1-wickbergster@gmail.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexander,

On 10.04.25 13:37, Alexander Vickberg wrote:
> The MTD device reference is dropped via put_mtd_device, however its
> field ->index is read and passed to ubi_msg. To fix this, the patch
> moves the reference dropping after calling ubi_msg.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Upstream Linux commit: b95f83ab762dd6211351b9140f99f43644076ca8
> 
> Signed-off-by: Alexander Vickberg <wickbergster@gmail.com>
> ---
>   drivers/mtd/ubi/build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
