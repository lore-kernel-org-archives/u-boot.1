Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2485FC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A265E888D5;
	Tue, 13 Aug 2024 06:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522531;
	bh=QvRM3AGY7lZ8kvYHHtjp3ZZd6l1qTnDKZoq8m+CUBWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=KSj6tK9Jo9ci04KqB0neoIdCTo9L0JDGPZE8TLcV92PFmVX2xTPkQe0yjxuu6Qw3R
	 QhZD9kGTf0kkFH0852ifN61jkgtcM1ECRQnhGhYS9GuSXmTKZvkBuWbmzzJzZfMpfG
	 X1zzxMIQwkydmBsXXv0MQ4RtNisJqBqWtxoSduQGUzgguOfefhygdgcW61+lECDlfK
	 jZCBYuV/S4shrQVuWUoMTjnreu9VoYizHU99lIfzdjdHX+M5VmReDhKNC7ao3ZC8hE
	 vTLz2Za3+DhZWxW6F1ixOa3sivx20vT1YJcPpGA414+acplLcO05pMguv4AAZFsCnz
	 jusTR0InIGd4w==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0482088360;
 Tue, 13 Aug 2024 06:15:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522530;
 bh=QvRM3AGY7lZ8kvYHHtjp3ZZd6l1qTnDKZoq8m+CUBWM=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=lJozGyq9JjivYVUlvH8FFpCyzAQq8kyTBO7L2JDYGvXlEGphOFDLBu1XJXr3zTMea
 9vzMy0+VKyzucz3pqKUVkwETR1UifOl/ejSIU7yMnMKuOLeunJJieHpaWnhvervCnH
 vcZituAgMox9WObyJWjxquEut9nEvsUD6CNGxKtsvbDCwBGtgBeitt0PmhgjPHN/Cb
 3yKP8A7Sfu15hqOyXXvXnesB1tIJU1TPQgJbjyIbRqI899J9XdjgJelfOlam8sE6Sd
 v/LfLOIt18VtQZX2/RjYBFZA3yVoUAvIq7sGQXpGvo+dA0vHH5/gTqG5DU27NMo88J
 sV7/twpXwhi5w==
Message-ID: <510ce1f4-df4e-b744-8b73-4362e1c56df9@denx.de>
Date: Tue, 13 Aug 2024 06:14:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 14/18] i2c: Remove I2C_GET_BUS()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-15-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-15-sjg@chromium.org>
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

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> This is very old, predating even the legacy I2C support, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   include/i2c.h | 7 -------
>   1 file changed, 7 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
