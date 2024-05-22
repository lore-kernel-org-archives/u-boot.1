Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28528C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 00:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866D888438;
	Wed, 22 May 2024 02:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1716338031;
	bh=eJFZFsxRlRhXHpYCp4SvfdXmdsTYWrTESVjFriiA33M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bMSD9frA+hWHpXFeGKe1uoLs/D5UgryOu2ReVEbg2E+ZGbi7UrHp/ZgaunfXDFrpa
	 RLsZQlJ/e/llqtpGgOCKo1gjLs/4Cchx9qP70FBs1JO8atoGf5QCbSEbGP4oEritJF
	 7EFSlbCRwGM3aEl/+VZEjYW7oJmOIZXUh+Jn2aJnZ3e2awLOQQrYLiBfwrjvEN7YSk
	 O/dYBOVAWHz4NqiLZbUAO3X1XSk0OpwYxtrq//K7Eh3FZG3xOTRZJplfccjySYZnYP
	 trtV1/KuQ21kqBYJqNETmmUe5pQgblWirJeNb6N/plpaYwjStvQqEM+Ew1YvNWVgIT
	 LMgNm0u+I1xYg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EA78288342;
 Wed, 22 May 2024 02:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1716338030;
 bh=eJFZFsxRlRhXHpYCp4SvfdXmdsTYWrTESVjFriiA33M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wYROeVwkQcHcu04TsRPHKXk0zqETv/CPxUHg+gUdAVW+VJVy1iCpfa85F9O6/R6n/
 NExUXF0I8QtJXcsWrAq4ffiV3TFBS03JJ9e1o4dL6LHJEwQHmdfCcbcUM5DeXvAZ+3
 knWCsC1c9dne82IKVJs2IGlQCbd721WbO9C6beT7ZjTu3PI43xIo3onEE8xfIsbj+F
 4+VhG/N0jAERimRUPeGudGe9P8LQ+eG7bc0GU/3jHQY18VyzE0/LGvdVjQ819BNmwz
 FukVG0mvVxQ1uRFyaSLkmdR9ZxyaaFSboWp00p1jEUc+3Gq5nnuiaOs70HMYeJW26W
 1N3D8kdt/YAIA==
Message-ID: <bb7170da-c4fa-4c60-a76d-643cc55703d8@denx.de>
Date: Wed, 22 May 2024 02:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: imx8mm: Enable CPLD_Dn pull down resistor on
 MX8Menlo
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: dl-uboot-imx <uboot-imx@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
References: <20240521094146.8886-1-marex@denx.de>
 <DU0PR04MB9417FE9BF37399FB344F525088EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <DU0PR04MB9417FE9BF37399FB344F525088EA2@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On 5/21/24 2:51 PM, Peng Fan wrote:
>> Subject: [PATCH] ARM: dts: imx8mm: Enable CPLD_Dn pull down resistor on
>> MX8Menlo
>>
>> Enable CPLD_Dn pull down resistor instead of pull up to avoid intefering with
>> CPLD power off functionality.

[...]

>> diff --git a/arch/arm/dts/imx8mm-mx8menlo.dts b/arch/arm/dts/imx8mm-
>> mx8menlo.dts
>> index 0b123a84018..c226285c6ea 100644
>> --- a/arch/arm/dts/imx8mm-mx8menlo.dts
>> +++ b/arch/arm/dts/imx8mm-mx8menlo.dts
>> @@ -290,6 +290,28 @@
>>   	>;
>>   };
>>
>> +&pinctrl_gpio_hog1 {
> 
> Should these be in xx-u-boot.dtsi?

Actually, this patch is not even needed, since similar change is already 
in Linux upstream and the DTs have been synchronized since. So please 
drop this patch altogether.
