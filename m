Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D9EC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B261C88901;
	Tue, 13 Aug 2024 06:12:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522341;
	bh=50JLIOlAW/Dd2IEVPB7Daf0TWEfA0Q+HmA8bqRWG/bw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xBstF+m46N534uMAZ2t3IkdKdaiV0JgIKg1nghVfOrTUfZQuLbXdBw1fqUfG1XBKE
	 itVUS152ErEh3BDzeV7C4+fqpld+Nkn5KJVa6S1t0VWGR5BC+EtmgixHv9apld4aDi
	 d1BP+k1vHEHgvxXIn8/hUyj7bTbWfDUpbBZn0O/hjQeU0NY0xLxH1ToKUlr8ap+TXq
	 eUTCOMEid36+qnl0uosbR3kS5PVzNRHF//Z1C7wMNuDkGl/0PtoX+Qll28iouTvIo9
	 Q36XKTB9U0qQVF1coM3sJP7OQRXG5bsLSeHzNw0AA/bLCEnPgfo7udgqenOJ5DwDGS
	 31nL+kemkY5rw==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BDD2088360;
 Tue, 13 Aug 2024 06:12:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522340;
 bh=50JLIOlAW/Dd2IEVPB7Daf0TWEfA0Q+HmA8bqRWG/bw=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=eFGQyEpLTjbQc0gj1zSkVXNAlraC3mE/JPalaKDHOtyfs2VlfvM/gIW7P5mcVjT/G
 4uEYcuQa9ge+8VqpCYgsdBTdjjoEigDCNghd3M1nZfZse10uqn1+s7mD5MSe2IXDxt
 w8NU4kWn7xUO1egLVWa/7MgzStifj2W4IqzT0oq3iD2H88dPLt1vZQ+3hvWJ1+FoNw
 ALHw8BavjXzVzjYTYgzzdEqj8zvhHueXEg4BB4B2fqf04+6UDoExb26r9uq73kJjd5
 3V8B/r8AdLxX4U6FaaenJyU/QoNUpVvOdn3NIJysr2mrUPRz1jdaiMArYb+jXAoXHk
 7IQKHt4mI0yDQ==
Message-ID: <a69a30e3-d8db-717f-6f67-0a5837ef22b1@denx.de>
Date: Tue, 13 Aug 2024 06:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 10/18] fsl: mxc: Drop legacy I2c
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-11-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-11-sjg@chromium.org>
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
> Drop some old code from the mxc_i2c and ddr/fsl drivers. This will allow
> removal of very old common I2C code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v2:
> - Leave pg_wcom alone as its boards were converted
> 
>   drivers/ddr/fsl/main.c | 3 +--
>   drivers/i2c/mxc_i2c.c  | 1 +
>   2 files changed, 2 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
