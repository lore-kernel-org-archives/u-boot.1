Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2A7C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 19:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636D3882C4;
	Fri, 19 Apr 2024 21:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713553975;
	bh=oKiSeRmx9j4wgOBpxrDbApUXJjyFG67BraQao+QhYIU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xNQ5pwR3pUJVCzPz5m9iEkA7Tou9m+CadfQ2+kxscGuYfclGti+2VU6F9IKSCT9wj
	 8i9iZbSh+hdpz1BCD8ofmbqlTK6xvrh+d2fuoYiTf3KzHEf2tvbGg+sBqW9zxh0nrT
	 4CIx5gi7YY6wwey6lfvMlwMaaaCFjs2tI2NU8DMDgEKVfgD41JSX7TF4mDVYa476nk
	 hir+/WOJFt0vLDut82Q63Vh+W4hgKzh3MBB3nRisZMnNeFkwnHibJKHpyPJBDk67dw
	 q8fsxFOehyhZs7tuAQb2AS7Y6riedNHSj8cHvnzYrEkN2I6n9nbpX02bJWnFZA5pnK
	 TydwgqVRXREkg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DC5F288208;
 Fri, 19 Apr 2024 21:12:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713553974;
 bh=oKiSeRmx9j4wgOBpxrDbApUXJjyFG67BraQao+QhYIU=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=w//r6bAkI+XSDFqOBoRMsj+7OzZmO8lSiQ1YVqXIklwEA1pgO4eIoYRG7qhJEqe3E
 T2EDNHMWFbiI4PTewTeLo3K+bOBHczOQWV+vZgQXypEoYl0VK7gIkrXlOyocgAwKup
 prOsH9Hll9B4oRg4HEYKlgSBY/zQgHBfqYotzWZHEOe4exBZiRTHSBkGEUET371+/r
 CqVYv6uBqn0AHWb1Mn83oJR2UlhW1f4cVCTWBq7gstAwO9vnEqR9nulEEWrseJodG0
 No9cx17Eof1rWj6gxpuvbgHtL/WZUQa2v2+ZvYCmKDuPotEx+nXurc6zPaxpX9j8rO
 zSq9pmOWIRf4g==
Message-ID: <a7aabd79-ebf6-4919-a00a-14f0019391da@denx.de>
Date: Fri, 19 Apr 2024 20:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] clk: imx8mm: Add support for PCIe clocks
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Fabio Estevam <festevam@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240419152902.4156600-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240419152902.4156600-1-tharvey@gateworks.com>
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

On 4/19/24 5:29 PM, Tim Harvey wrote:
> Add support for PCIe clocks required to enable PCIe support on
> iMX8MM SoC.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Marek Vasut <marex@denx.de>
