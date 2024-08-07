Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10AAC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 10:50:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2372D88A66;
	Wed,  7 Aug 2024 12:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723027839;
	bh=Lb/igytMaDwegImYx9ne+1VO7UCWN3Alxwrfzd91zjE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=gWjFbNLMS+500SCHw1SVrP9dE5zekObaTX6L1eg5OJSnzv3qgN3zshjlivGqKUggd
	 vVCwwtCqfESNnSKBQYHfy2kfSa5whL2Z6z++gSdf8RoTfZrLucne6LjQ9tXrX4SNDt
	 7BO9h7jwOCCadaz0WsWX4GIQKs48QlH1KWmME3CRiw/xsAeqlkrCqg1GDtgbxNWKw+
	 3NxwC5p9hN0Q/hEjji6jJV3gR3XfICSitHfIrb30SHWVQw5RHOg5whCyb3tkH33acL
	 1EiP9upNmCmdK5CZdzLFjUODzDMZCxJ6Y/+qyjv+aI8fGzUeBezS5Wmimfm7qG/s0z
	 sNTksUrzfyqbA==
Received: from [192.168.1.107] (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D80588872E;
 Wed,  7 Aug 2024 12:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723027838;
 bh=Lb/igytMaDwegImYx9ne+1VO7UCWN3Alxwrfzd91zjE=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=BeeDsDjNGYTSUAKIJhS8hixjjN9T6ZRy9t+pUcJSE3BkSznugc91t31vDYMu0NMe/
 Dke5dGdYNS/kcUjypxdJUPyngiSE3mdvdU+KtPfKdptGLjve3FzbpTRsl2i+59hNZY
 PX88fi2U/tYElCkgvgrxDvHuZMf3P1Vw2kXQ469tlASMz1I0sWGIBZFLpvBNzWMSqc
 57fpHAHW12r0plKK9JhpXupIkp9sIe+VFWRKjrbVScxA+mKka69YyaoNKh8xlPq6RY
 ERLHDXqUCmFq9yifcKBOhlc4onkt0nvYHLKp6gF9cVGftKGw7Nv6Lz0MSWZgmhqWHO
 uNMO+siQkNoYg==
Message-ID: <ae537f45-a55f-fe39-bb3f-3d0fbf4603b1@denx.de>
Date: Wed, 7 Aug 2024 12:49:56 +0200
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

Patch breaks world build, see for example

https://dev.azure.com/hs0298/hs/_build/results?buildId=114&view=logs&j=9261107f-b16b-528d-034d-a5b366785bfc&t=aa057498-3634-5fad-2ef8-82ed58702aca&l=1197

Find the whole pipeline (with other patches too...)

https://dev.azure.com/hs0298/hs/_build/results?buildId=114&view=results

Could you take a look please?

Thanks!

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
