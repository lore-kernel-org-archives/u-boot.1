Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C63C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62BE887F01;
	Thu, 14 Mar 2024 05:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389750;
	bh=K5b9XSR6vGnkGjo+rOg7mSIEdgZAkQJWV6PsDM821Z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nh4CTRdAYSb/qRaxr4kwEPaWORLiv2HizrVG5EKZzjibbC0mffxMQoih0GgIO7aWL
	 ufWeOTyL903fOX57SV5gnULZgVlhASgZdI7l4LdJuyspXUcxXtQLfvOMkai1VX99Vl
	 bTqd3042cd9iZVzLtUv2aIc9P45xeIQSVyCRgdCp9MS2OpOrwRjGEflfAChEb6XSIB
	 VetxUJajAwaYVMf8PU24iQ5fJGJNOjw2iOzTxSJ0B9JzNhXTLi3EVbAOlaPV50ZVaP
	 um974cPiE6+rw/yArGRk/Wxot+zqXdGaFSwRmmMdGxANEKoRKaZWwXhBJMQEKjk7aZ
	 IyagOsZUtNl+w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E512887E0C;
 Thu, 14 Mar 2024 05:15:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389748;
 bh=K5b9XSR6vGnkGjo+rOg7mSIEdgZAkQJWV6PsDM821Z4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=stfXQoGndncOgF/PcnNDyzXtev8N9RS3Uddn+GSvQ1oyPJP25jweClgIKIjxVPRgf
 bmINFivWR4Ts1/GkcFniiHmAcQWgUe2Fe6vLsML3Xr2bOdRH9B4JDsRq19tUtE+8Xu
 H7YDWSHrkUwXYPJZxn6wtbMnmjUdRJ/ftKxxcTDmGkPFMqMKIzNsQniiejUFBS3u1y
 GbeAyIx4MCeD/clKN1bZ8JeER5ypHc10ANRV4Q+nm+EGguHeY8Pj8/iGQVSZspSTUw
 Iu9n/0YHNLxUaT/CtTQ8KfRixZVJPU7XOVSIYMUKj860GyPL78Uoq+YegwzozKh0ip
 SY75gESM866tQ==
Message-ID: <d477d827-5910-4c5b-9b35-116e85fb8e53@denx.de>
Date: Thu, 14 Mar 2024 04:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] reset: imx: Refactor driver to simplify function
 names
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240312070338.86127-1-sumit.garg@linaro.org>
 <20240312070338.86127-3-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-3-sumit.garg@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/12/24 8:03 AM, Sumit Garg wrote:
> imx7_reset_{deassert/assert}_imx* are a bit more confusing when compared
> with imx*_reset_{deassert/assert}. So refactor driver to use function
> names easier to understand. This shouldn't affect the functionality
> though.
> 
> Suggested-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   drivers/reset/reset-imx7.c | 24 ++++++++++++------------

You could even rename the driver itself now, but that would be separate 
patch.

>   1 file changed, 12 insertions(+), 12 deletions(-)
Reviewed-by: Marek Vasut <marex@denx.de>
