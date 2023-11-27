Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFE6C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 06:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0077487507;
	Mon, 27 Nov 2023 07:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701065571;
	bh=KNUej+PvD+hJLn8rKCkuxG78abzcbjHK+TORNIILP4s=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=o7mxxZ6xMNodlKBhVYe4u9tTkjvLmSbn+ac8tn9eaQXztDlyrVqFpI1Q9aDU9Bxii
	 9iKeVgWgzHnRcOZ6hWXU30ZJvP7UaifklgRXmD8xSKnT1xUpfJIKmD8Tav+Jwhsi6A
	 OUxOqejAyC9M4gcGB2q/+KaEBPB9/Ec4vCMUoiPkMZmrr4MLZmINMWly1FJsrMyb38
	 GnfCcv8IW655BaBGy44PmjRgswZqK5DC6WOfZzcr0IlsUH2enL+4LP+pDB7R1dI9d0
	 4wTBICdORgy+PdZPb1fcOS16VUChm6HU6ZdvZbzmjcsCO2ZfHTW3kLoEAUZ7AZdMqn
	 yBjrRMklXRAng==
Received: from [192.168.1.107] (89-186-112-232.pool.digikabel.hu
 [89.186.112.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E1354874FB;
 Mon, 27 Nov 2023 07:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701065570;
 bh=KNUej+PvD+hJLn8rKCkuxG78abzcbjHK+TORNIILP4s=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=XEakMK5LIS/F4EMM9ExC0gKzAUNmduwYVTgJ2zUnUYBM/W8gxkIBksUdOPUTa1JaU
 oCAkUEZLgYPX7ds9X84Uo11MyyA1goZFTEin+Aib0nzZywbmO1SBMM5Newxlh4LY85
 hxTOAfMHdqQLEuqlvFA8Sk1IWpWpNHzLqBZphj8Bc+YWa+CIqcLIvXshbR7s+nDiWE
 WnElsLcZPrlb/xlVK/2FV99AR4cWQWFDDsjrQh/5W7lg50m6vdwqxBfJHlhLA8AV9y
 ZPTLnk5STY4icPt0GRPrcE44cdmIj5fDW+Uk2WxTjIkKgVcKuJNHwsoKl1ileeeChB
 Bft0EqqHFZ0AA==
Subject: Re: [PATCH 1/1] i2c: Bugfix in i2c_get_chip_by_phandle()
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231124140400.32027-1-pro@denx.de>
From: Heiko Schocher <hs@denx.de>
Message-ID: <27d8c4e1-3a5c-360a-a59f-31a38e2e34b8@denx.de>
Date: Mon, 27 Nov 2023 07:12:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20231124140400.32027-1-pro@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

Hello Philip,

On 24.11.23 15:04, Philip Oberfichtner wrote:
> The "i2cbcdev" sneaked in when implementing this function for the
> bootcounter use case. Obviously the intention was to use prop_name
> instead.
> 
> Fixes: b483552773 (i2c: Implement i2c_get_chip_by_phandle())
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>  drivers/i2c/i2c-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Indeed!

Acked-by: Heiko Schocher <hs@denx.de>

@Tom: Do you want a pull request from me, or can you pick up this?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
