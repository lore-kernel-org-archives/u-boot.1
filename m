Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BE5C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 19:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1417A8812B;
	Thu, 21 Mar 2024 20:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711048634;
	bh=ll7KYVmutf2awJ6BJn+7n0A5rwGqXczgvuCudMZTmZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFLZWLwuNCSoMaSEQk9rBOwjTOfZg/8QBicGGmToCfWZSuu4MZqW/3uFULZtDlxsJ
	 n978dZEB6qw5jz5149ZEAq3oxKhER1YsPjAlhkKuB4c/sCSL6oBcmM+Lfu97Vout4s
	 jdKHVRaSpJI5fpt5L1mqZaRflAyZ4vVP7Ej8AkKQ9terDyc7yE1FWDszX7990D84NS
	 yD33KqSHKyk+dvWJy7ei46XQmKVKVKxjlZTnytfN3GHy2CawJFnfIIGN+Ev4iL8Xvb
	 FVa8G2oMphzTC5Sprbt0he7OhI8gVGzoOyGs3Yl6fPrY8Yhk2McaSykZI9k5ZLo4AX
	 QP0N9L5cH8KEA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B44AE88120;
 Thu, 21 Mar 2024 20:17:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711048633;
 bh=ll7KYVmutf2awJ6BJn+7n0A5rwGqXczgvuCudMZTmZU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pBdf/ETIthc+kBJyIlqqAINlKHTprGONise4gjpzk1t8+hyeyZccKyW3xKs3XxQeE
 RU1VFiy2LtpzwkOWGnZSJ3alocpRMtoIGu9G0/r9bW7DL6c4aZSkggnsXa9iV3dph3
 7EmvcfQx27/Aeo/Ze8JFuUJWJXPGejl+Z8n6f1zzc9ZXJOGQpNDfUxu7iJgEZh/8Ka
 unwCCX3G5qVVurVlkLvxC7vqnZJ9WwX+72uPbunrQSRrquCLhA6ZYL7y+jNugwFjoY
 qdfQUGF4M8c4Ovi5I0OELSxmd7oHvvNJmTuvCq513jIc+ZcIwWu9DYZy6TajIt0jt3
 42w9CZMh4PG/g==
Message-ID: <3c07647d-3baa-4205-bb86-f1dda4b8dc18@denx.de>
Date: Thu, 21 Mar 2024 17:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/11] pcie_imx: Update header to describe it as a
 legacy driver
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com
References: <20240321145507.619448-1-sumit.garg@linaro.org>
 <20240321145507.619448-9-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240321145507.619448-9-sumit.garg@linaro.org>
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

On 3/21/24 3:55 PM, Sumit Garg wrote:
> Since now we have the modern pcie_dw_imx.c driver for iMX SoCs,
> encourage people to switch to that for any further new iMX SoC support
> or even for the older iMX6 SoCs too.
> 
> Suggested-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
