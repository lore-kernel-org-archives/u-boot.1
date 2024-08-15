Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129D8C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 11:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C34889A1;
	Thu, 15 Aug 2024 13:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723720683;
	bh=ka7FMtLagiqx41Z18578iZFKJDv7r5mRwRhiDs/SrPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=w8JpaCfIEcr/QOGdFWz/d35ELLE/2jl93fYhVnUgwguWvROExB8K7RoylQ5EwdtM2
	 Z9/rMiOgmWc/U7zw6MLpL0mdC1D2vRrZaa9sd5IptIfhRORYSe1DcDVlQS4kQBHm0e
	 vNNbPjFE55ulU/8eDVLY+3PehT2IDTbOujh4CjuiemotH0YIpDyKmv8dFQeg9xKgQc
	 ObBbK+xG+PDeNtq2XcUf6Y6BX8wr33sNJvSPOQKLJ6lkDPWADi1Q0Tk5Ugbe73JQmk
	 hsa5frx8aozJ5FzNU7E76De/0MLkZXV1aVCHclVuOJgJ9evZFsJikgcp+dGhp8a8up
	 OLA3wFVLa4LgA==
Received: from [192.168.1.107] (87-97-108-209.pool.digikabel.hu
 [87.97.108.209])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CB87288872;
 Thu, 15 Aug 2024 13:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723720682;
 bh=ka7FMtLagiqx41Z18578iZFKJDv7r5mRwRhiDs/SrPo=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=Nw2hIO7tAF6ldBqSY1DKN0TGmzDHRkn3CttBYPW2TlTDlzx6Xu4dMP6vr3iJ2/zoe
 FJj2rkRiEW/uAl1Pj5AMDSSxJ11M4/4MCH6vf6xSfK3ko/tBRB9KLme8uaVHieMV56
 sTOXL1p067tGv/mZG2OTr+d6OYZBzncMtiagaFwM7ReXWxyKyYOTPpTRL6amJhECLX
 E5KgxTX5qST+eXQrhI797TYrVWp34FTLJ7LdsBxQcDE2JRuNti8x+g+RAc4iVEyK4V
 LjX43xFNT9cut+BhIu6Lc+V+5EPc7qAK1QgQCJvX9jtpyTfDuYkvOTPF5DBQ6YDY/A
 ILxuJO2auT11w==
Message-ID: <d1dbe0e1-ecf5-2ee4-5a64-3e50183d1583@denx.de>
Date: Thu, 15 Aug 2024 13:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] driver: pwm: pwm-imx: fix probing on imx6
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
 Fabio Estevam <festevam@denx.de>
References: <20240814121027.3477977-1-hs@denx.de>
 <20240814141736.GN1626301@bill-the-cat>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240814141736.GN1626301@bill-the-cat>
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

Hello Tom,

On 14.08.24 16:17, Tom Rini wrote:
> On Wed, Aug 14, 2024 at 02:10:27PM +0200, Heiko Schocher wrote:
> 
>> U-Boot 2024.07 drops on aristainetos2 board the following
>> warning:
>>
>> 	Failed to enable per_clk
>>
>> and bootlogo is not seen on LVDS display.
>>
>> This patch uses old behaviour for systems without clock framework
>> if CONFIG_CLK is not enabled.
>>
>> Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock using dm")
>> Fixes: 4eea76574062 ("pwm: imx: Remove unused references to CONFIG_IMX6_PWM_PER_CLK")
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> I really do not like this and would like to see the clock migration also
> enabled / completed on these platforms. Then we can also go and rip out
> the non-DM_PWM code here.

Yes, valid argument, I also thought about this. Anyone working on
this part?

Until this work is not done, this patch is in my eyes a bugfix...

Just enabled CONFIG_CLK and CONFIG_CLK_IMX6Q on the aristainetos2
board and get [1] (as I also have there CONFIG_VIDEO_IPUV3=y)

Uff... yes, there are such functions in drivers/video/imx/ipu_common.c

:-(

and even worser "struct clk" is defined in

drivers/video/imx/ipu.h#L22
and
include/clk.h#L63

completly different ... so this is not a fast job... I fear...

bye,
Heiko

[1]
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_enable':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:93: multiple definition 
of `clk_enable'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/drivers/clk/clk-uclass.c:611: 
first defined here
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_disable':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:102: multiple 
definition of `clk_disable'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/drivers/clk/clk-uclass.c:672: 
first defined here
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_get_rate':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:120: multiple 
definition of `clk_get_rate'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/include/clk.h:645: first 
defined here
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_get_parent':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:128: multiple 
definition of `clk_get_parent'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/drivers/clk/clk-uclass.c:478: 
first defined here
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_set_rate':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:135: multiple 
definition of `clk_set_rate'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/drivers/clk/clk-uclass.c:565: 
first defined here
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_round_rate':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:147: multiple 
definition of `clk_round_rate'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/include/clk.h:645: first 
defined here
| arm-poky-linux-gnueabi-ld.bfd: drivers/video/imx/ipu_common.o: in function `clk_set_parent':
| /usr/src/debug/u-boot/aristainetos2_2024.07/drivers/video/imx/ipu_common.c:156: multiple 
definition of `clk_set_parent'; 
drivers/clk/clk-uclass.o:/usr/src/debug/u-boot/aristainetos2_2024.07/drivers/clk/clk-uclass.c:586: 
first defined here

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
