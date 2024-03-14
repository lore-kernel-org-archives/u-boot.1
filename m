Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E018AC5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 04:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3B4B87EA8;
	Thu, 14 Mar 2024 05:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1710389748;
	bh=fRb4QhzkZfmPV0VEE+bN2rSGtEemjXW4quOTEoG4G0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBHj8Ramx9NJk5+6h+plR9OrwG3ypyzeftGtBGN035I7c7KSmVKk+NHrz9kTxoFLN
	 a0JkHXQ/OkGtv1q72xxkmF6Wn5sXBFYlNf/Icn6aHeM5YU1LCrsZzh8JqyOlHO5XQv
	 FCYB1j9eZnET22jBbqeUdSf1weEPtlyiChOVMjKXMDc/87eQ+D6nG/qZtYhzO2wSqU
	 ZPbto4wyHA0XCPXThTvcPUXv0TStWl5i/sUqkjoukcohuBlbq5Tjz60YQlAn3FdtCv
	 LDTWJlF+mUgy0HvTHL6pDWuuScjlSlpZNVGGWsM49lWMmiZojsLWtnk33qbK2+QW9J
	 IHdacV5EGTa3A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E05A987E75;
 Thu, 14 Mar 2024 05:15:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1710389746;
 bh=fRb4QhzkZfmPV0VEE+bN2rSGtEemjXW4quOTEoG4G0E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KCdxKJH1n+r024WOZSZv6XU+6wu6lwaNY65m2ULFXAamtb80rf+q7cku1U+6e77KJ
 pSNJEhJdnMkTQOTK+ciaGunAzEYpntN/GZoawdQGv5IjFd2pH+ggcuz+kotEtUiEYn
 X+3MeYxDrl/uzX+y0dWZVq63w7mY4nN80vugZey3tlNE+/myYCDyBCCbQBvSnM7iXh
 UqTfK+ep+qlcqOj5NA1hG0jNlVOwY6rDmgrlXyzDb/2Adj8HStugaXWIPiWk0zdEIE
 Q6rROSbf0le6qoflA3o06cHKcV2pzH/qtS0SMhpGTc56iQeqek7pChXV70zSHDhsJf
 I4oJsyOVv3tZg==
Message-ID: <e2bd6285-f26a-41ba-8f8e-94668245e0d3@denx.de>
Date: Thu, 14 Mar 2024 04:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] clk: imx8mp: Add support for PCIe clocks
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
 <20240312070338.86127-2-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240312070338.86127-2-sumit.garg@linaro.org>
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
> Add support for PCIe clocks required to enable PCIe support on
> iMX8MP SoC.
> 
> Tested-by: Tim Harvey <tharvey@gateworks.com> #imx8mp-venice*
> Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon-kit
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
