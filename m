Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E47BC3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 13:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C822820E1;
	Mon,  5 May 2025 15:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746451478;
	bh=E7dsTabyG93yFfmWd0yDG65+rmgHMQ6grZ0Gzxroxho=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZtOfaiT6MDWpNnws68SGT/FI0zNJEhPkF+J80kafitsbGmdQwsPwqvlTyre0rImxI
	 JkmV11WfXgCcHaL1DlbJT2Ld1MaRpLSbYhwLp6wEJaRT4TesmsiCZ+1JwvCBbzlAr6
	 IrjNj8HnFPmYaRQAZb0gOXbuG5ETnVOoUsf3EEWTALPMYgbdgZXvber78WhqCQQdy1
	 DUn5eiUkWlJGhkZ/8cEpUeMmj2c0ItFeVgCqgaqQwfxQRfnO0vGiX5wdVUwKdT65YL
	 mXNRGwcKM6GitE1RrDNnt6dibHz9dnMuCQzkr4FyNpKU8dr1B1vlr3H3VZCmaJCslx
	 xhuaDYJtzichQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE88E8291D; Mon,  5 May 2025 15:24:36 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC5982076
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 15:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="SCv8uBBS"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D03961048C2EF; 
 Mon,  5 May 2025 15:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1746451474;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=E7dsTabyG93yFfmWd0yDG65+rmgHMQ6grZ0Gzxroxho=;
 b=SCv8uBBSHKU5UVXpoe0AnQ//jpGymxeKKBfmZbWU/JAG1xkoDpo5QyxkkzqpeVD03kPyDE
 KmGT1lG3TemW+x/rQhGHMaAm4B0fyRYPnl5X3/AlCfRC64nruBXq14nsPZai5nxvTC+7hY
 IILMsXO0IbjCtS+eoK7X/RTa635IAnnMkK5CUWzKbi7B0he5TquKoESVylPHX8vK5mrLvd
 8diz2c9Ty19DmQEKVblyJ/e3ReBU5UTLllb1j6w4KfYrpr/c+MplyDwZn8k2VgxIkj/osD
 dA2OuH0QaDAKjxAXvkGbIB3krvDFkZGoBMNtamU6Sdr7Plj55YqWgAQeVi+pEA==
Message-ID: <b0835718-6a39-1ce7-0894-8f1a7cace65d@denx.de>
Date: Mon, 5 May 2025 15:25:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mtd: ubi: Put MTD device after it is not used
Content-Language: en-US
From: Heiko Schocher <hs@denx.de>
To: Alexander Vickberg <wickbergster@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250410113740.1602891-1-wickbergster@gmail.com>
 <72eb977f-280b-5016-e8ac-76df95508216@denx.de>
In-Reply-To: <72eb977f-280b-5016-e8ac-76df95508216@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexander,

On 11.04.25 06:21, Heiko Schocher wrote:
> Hello Alexander,
> 
> On 10.04.25 13:37, Alexander Vickberg wrote:
>> The MTD device reference is dropped via put_mtd_device, however its
>> field ->index is read and passed to ubi_msg. To fix this, the patch
>> moves the reference dropping after calling ubi_msg.
>>
>> Signed-off-by: Pan Bian <bianpan2016@163.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>
>> Upstream Linux commit: b95f83ab762dd6211351b9140f99f43644076ca8
>>
>> Signed-off-by: Alexander Vickberg <wickbergster@gmail.com>
>> ---
>>   drivers/mtd/ubi/build.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks!
> 
> Reviewed-by: Heiko Schocher <hs@denx.de>

Applied to u-boot-ubi master

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
