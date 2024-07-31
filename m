Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E44FC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 03:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D1D88453;
	Wed, 31 Jul 2024 05:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722397525;
	bh=/2TTXDLR1Rg82TjP49IkF3KC/w0/m2s7XFJ/hV73KSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fHVS+Tobvj0CgYpzzut1daHY3p4q2XVvfaAJkjS3evF1aS0iLFM96bD3WMiT8UY0o
	 iqoYTA/eb755cdnB3PDi3LK+tZz+33rgcqmbEdbd3eVzWYjqJWTLz/iDqQxFbP19Fh
	 8tQM+2TEuC9YlxMChi0Ldawif6/ccX42UbLJ1sxNQrzQ9A0+4wRVcWTk3Zet117fxW
	 ojImZn4/h2JQvhvzJNhNGYEjM20i3en0Q6IT/tU4AZe7GZB9DgnXfFA+udf/3rF4Hy
	 ivY/cRIrfQxbzkOVqiN08dCjbsIb1oD/geK7VpmjaKPjGRxNgZVFKQrQbLuoKzzy6m
	 ChgqmeaGoJgBQ==
Received: from [192.168.1.107] (87-97-105-110.pool.digikabel.hu
 [87.97.105.110])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A6541883FE;
 Wed, 31 Jul 2024 05:45:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722397524;
 bh=/2TTXDLR1Rg82TjP49IkF3KC/w0/m2s7XFJ/hV73KSI=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=wjO12edkf51TUoYyganTWNHJPK0fVkoiq8MfcnpxvocbEEo2rAcAV2kZqBsjoqZ3n
 SumOW4yClzI4lK+8nlL6tRLX/GBee7NaOTGpCMZKBS+oTXMhLHUFB8IW6B8Sxqco6t
 O8GYfCp/WM4ltjUuL42hKDcIQrnq34XzdSnGWCHMBcX6LcnpzTGPgBqs14oSkvK1xY
 8oflD9wdO+6vYF1gtNsigAldKn6ZtnKp+DeWDzPck0T55h/k4MlRKu01Afi9989+IC
 Aes9/6JXhPMhxiiOtL6WxvJIqNC+EwQ45OwUAKpD6TDSjvltz58ONYZ/ChhQ0G+fZH
 ZEK5uhcF7metQ==
Message-ID: <01e8c052-edd1-d9f9-7b8d-852b46c935b6@denx.de>
Date: Wed, 31 Jul 2024 05:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCHv2 3/3] i2c: imx_lpi2c: Support read transfers longer than
 256 bytes
Content-Language: en-US
To: fedorross@gmail.com, u-boot@lists.denx.de
Cc: Fedor Ross <fedor.ross@ifm.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
References: <20240730152529.143651-1-fedor.ross@ifm.com>
 <20240730152529.143651-3-fedor.ross@ifm.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240730152529.143651-3-fedor.ross@ifm.com>
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

Hello Fedor,

On 30.07.24 17:25, fedorross@gmail.com wrote:
> From: Fedor Ross <fedor.ross@ifm.com>
> 
> The TXFIFO register of LPI2C only has one byte length, and if the length
> of the data that needs to be read exceeds 256 bytes, it needs to be
> written to TXFIFO multiple times.
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> ---
> Cc: Heiko Schocher <hs@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
> 
> Changes in v2:
> - Add additional '---' below SoB line to separate Cc list. This way it
>    does not get included in the commit message when the patch is applied.
> - Prefix 'CHUNK_DATA' macro with 'LPI2C_' to namespace it.
> - Do bit manipulation in writel() function directly and drop the
>    'val = assignment' .
> 
>   drivers/i2c/imx_lpi2c.c | 71 ++++++++++++++++++++++++++---------------
>   1 file changed, 46 insertions(+), 25 deletions(-)

Reviewed-by: Heiko Schocher <hs@denx.de>

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
