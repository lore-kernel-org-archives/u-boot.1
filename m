Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03491ECE59C
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 00:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2E288B6C;
	Tue, 10 Sep 2024 02:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725929230;
	bh=jTgoNGwb/Z4Je3mQkX8mJ+KS8XJkZDuqfRgBl/tqwmk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GswmRKOaUEd2eZjOb45N88Tuk7bZ1wBzial6F3jc9VySFU/57WIzcTu/g0WOY8kk7
	 bOQtj1ZDzoxUwtAAeS8JlIaxA7x4ekKIdPHsu1E6otgaY8s08jy4z4XW9q25y027Dy
	 b5BinSY5e231Z0cVjsCL7kNqKowRn5YDGhxwcXr75+gF5kfSBO6ioQX8vrGa4aJ9rL
	 c8zKgICAE0Y68VsXjAxo6oiDGiFHs1tpcNbBCMBL0hGtTuymdaTjVp0b6+eIKk6yJh
	 fQx2Af4/yNEveabuCcR1/pbmNvlUmKO9fbBg5w/WCpMgIXUsN9bxzIvaaQgeFM3SA8
	 PSzjNK2YlqDOA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BC8C988883;
 Tue, 10 Sep 2024 02:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725929229;
 bh=jTgoNGwb/Z4Je3mQkX8mJ+KS8XJkZDuqfRgBl/tqwmk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BKxQa4oiS+quP78Rdj8fYxdtRi2h1frTwB6+rsmMYlRZrh7BfQZqXjUhvgkMC4nix
 P1UEqxd3u4JfGWGlWORL1mEBHENLNDAofnG8gTbVKbC4fmcMQxgg9qwi7o3pOhwdX9
 9Hj/94GMK2CwhgrdEU9ufsGdb2X87+Smy6ctNfHXBjt51JKmw3jzmkRZ7mlVMiY3f7
 JF+8OuolVEseP38ja3dTtPEz51WHf1fOGBn15gJRh04tjt8+2aptvm77xODfSA2piI
 QG4FOFoGk5RaWmruVRcoU7MHSdK8PQMuaBOzFVOdUstzTkQJlHc+A309SNszDOF7bo
 IOC08wn6dre3w==
Message-ID: <12d78eee-88e3-47f9-98f1-cca05fb47171@denx.de>
Date: Tue, 10 Sep 2024 02:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
To: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 "otavio@ossystems.com.br" <otavio@ossystems.com.br>
References: <20240909193003.707732-1-festevam@gmail.com>
 <PAXPR04MB84594DC78FE974701A5775C2889A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB84594DC78FE974701A5775C2889A2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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

On 9/10/24 2:43 AM, Peng Fan wrote:
>> Subject: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
>>
>> Since commit 37e50627efac ("ARM: dts: imx: Convert i.MX8M
>> flash.bin image generation to binman") the imx8mq-evk fails to boot:
>>
>> U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
>> PMIC:  PFUZE100 ID=0x10
>> SEC0:  RNG instantiated
>> Normal Boot
>> Trying to boot from MMC2
>>
>> Fix it by passing the offset property for the FIT image, just like it is done
>> on i.MX8MM.
>>
>> Fixes: 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin image
>> generation to binman")
>> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
Acked-by: Marek Vasut <marex@denx.de>

Thanks
