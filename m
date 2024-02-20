Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703F0C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 15:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BD6487FEF;
	Tue, 20 Feb 2024 16:32:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708443164;
	bh=PM/xIImiClhXPn7jZ4s9UkqTPxWgUepivK7EPqhFtcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KMY+OaOlaRfQa6dHnoijFGmk2wBU59DdPlJrqg1vkO9E8PuY1UATa91mZmKHFapkE
	 5EmX5y9CwOqgx7iS54OKKb50g2M5FA5IT3XPX9SwJ7rKpcVq9Wg2W2hBIrfIvF+5Yw
	 B6HvYBb3+cC40luPUFd0+iht7MzurUSp2lUEeSLyjuXz2kcJO1LEFHPKtnbNvzouBE
	 Qoi38B2qZ8Ne1td12rNu2wnY3B+yV14vbt9cu94/Z0FlJdVSveHceTALOhX6nty7H5
	 ByCGmtKPrvFp36EUjp1Fj3okefy2lMWOxmfoZ6U5RUi+d7ZPKmg1huYxLjVXviFZae
	 tDqaTDIQt2T+w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id DFE7B87FE1;
 Tue, 20 Feb 2024 16:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708443161;
 bh=PM/xIImiClhXPn7jZ4s9UkqTPxWgUepivK7EPqhFtcg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=j3zYsDer/L1uny9nlN4cHSHDJpjEU7I8Cz7JQH5c2vfOVzPAggl8ltNRaDOW+KOYt
 tJe53BI76T2qEISDwwXdWQUPPonTf2s1xSw/5+N17B+YtiBfuvHjfhEoGrN7kSXOd3
 xE8bMniFvllbUXeZLrtoyS6Xodc1OWJdgyWYTavZg9e+Pe0PYjtsu4RDivZ3/WAk7b
 Zc+e/i1n8/ppKQvbWJz/0kWB9uQl3bhqkrU6xlH64JadYaVZGHLbTZcqwr9EWJPYkS
 5G1O8GVJ1r0cd4HL7QKIntsXSl3WbLWc1zb2LUaMurBnfgUT56nszBG9awnFqIX0mb
 MLowcX5NrSZig==
Message-ID: <55e11f56-0080-41a7-b4b9-43c3abe61264@denx.de>
Date: Tue, 20 Feb 2024 16:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] phy: phy-imx8m-pcie: Add support for i.MX8M{M/P} PCIe
 PHY
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-6-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240220131056.2962331-6-sumit.garg@linaro.org>
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

On 2/20/24 14:10, Sumit Garg wrote:
> Add initial support for i.MX8M{M/P} PCIe PHY. On i.MX8M{M/P} SoCs PCIe
> PHY initialization moved to this standalone PHY driver.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Is this based on Linux ? If so, include Linux commit ID from which the 
code was imported.
