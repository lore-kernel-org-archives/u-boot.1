Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A521FC2FC0E
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 08:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B6D86A7D;
	Thu, 17 Aug 2023 10:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CE3C86A80; Thu, 17 Aug 2023 10:28:13 +0200 (CEST)
Received: from mail-m127102.qiye.163.com (mail-m127102.qiye.163.com
 [115.236.127.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EAB586A75
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 10:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m127102.qiye.163.com (Hmail) with ESMTPA id CD0A06C0208;
 Thu, 17 Aug 2023 16:27:52 +0800 (CST)
Message-ID: <db7df492-7d03-e32e-2aa5-eb651a91fb77@rock-chips.com>
Date: Thu, 17 Aug 2023 16:27:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] power: pmic: rk8xx: Use sysreset implementation of
 the poweroff command
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20230817054457.472342-1-jonas@kwiboo.se>
 <20230817054457.472342-2-jonas@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20230817054457.472342-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0sYGlZIGEkYHk4fH04aTh9VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8a029bb2fdb280kuuucd0a06c0208
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mi46Ezo4Sj0MNAMfCQ4UNh0*
 LkMwCjVVSlVKTUJJSU1LQ0xISE5IVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJT01JNwY+
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


On 2023/8/17 13:45, Jonas Karlman wrote:
> Select SYSRESET_CMD_POWEROFF to use the sysreset implementation of the
> poweroff command when PMIC_RK8XX is enabled.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2:
> - Split patch
> - Collect r-b tag
>
>   drivers/power/pmic/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
> index 176fb07c651a..4a6f0ce093ad 100644
> --- a/drivers/power/pmic/Kconfig
> +++ b/drivers/power/pmic/Kconfig
> @@ -233,6 +233,7 @@ config PMIC_QCOM
>   
>   config PMIC_RK8XX
>   	bool "Enable support for Rockchip PMIC RK8XX"
> +	select SYSRESET_CMD_POWEROFF if SYSRESET && CMD_POWEROFF
>   	---help---
>   	The Rockchip RK808 PMIC provides four buck DC-DC convertors, 8 LDOs,
>   	an RTC and two low Rds (resistance (drain to source)) switches. It is
