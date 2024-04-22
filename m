Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AC6C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 08:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C79A883A1;
	Mon, 22 Apr 2024 10:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="VeY2icRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF4F88398; Mon, 22 Apr 2024 10:11:25 +0200 (CEST)
Received: from mail-m25487.xmail.ntesmail.com (mail-m25487.xmail.ntesmail.com
 [103.129.254.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C26A1883A5
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 10:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=VeY2icRfJjRTumAMFBTH2yNDWJCvpvkZ8SGIrYqQRgIjhCzpk0czZhhUbcl39AWy8ux+/fAxpx0I6evTBbPC87WrWb7MkY0v/1ViUExb8oEszwT1U39Ba66Lz6+ZI22I2kg1iBVtlq1YdVOJgv39uthcJSXHOA6ZhdCdrJpwKfk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=fJ+YAx8d7XEAaD4NubEuXmYABfVF/ERx6Ac5xNUNp00=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.33.226] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id D4A899002F7;
 Mon, 22 Apr 2024 16:11:15 +0800 (CST)
Message-ID: <bd1edf89-7b0e-4b60-af03-b56429b05944@rock-chips.com>
Date: Mon, 22 Apr 2024 16:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/28] rockchip: rk3588-generic: Use M0 iomux for UART2
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240422062936.681359-1-jonas@kwiboo.se>
 <20240422062936.681359-27-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240422062936.681359-27-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkgYS1YdTU5NHUJOS05JTkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f04dbfa5f03a9kunmd4a899002f7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6KDo5LTNNUToWGB8oDT83
 Py0KChFVSlVKTEpITExIT0xNQklLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSENMNwY+
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


On 2024/4/22 14:29, Jonas Karlman wrote:
> The default pinctrl for UART2 is using M1 iomux, however, all other
> supported RK3588 boards in U-Boot use M0 iomux for UART2.
>
> Change to use the M0 pinctrl for UART2 to match other supported boards.
>
> Fixes: b54c3d0dd69b ("rockchip: board: Add minimal generic RK3588S/RK3588 board")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3: New patch split from rk3588 bootph patch
> ---
>   arch/arm/dts/rk3588-generic.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
> index e4721d97a87d..baafe7463f1b 100644
> --- a/arch/arm/dts/rk3588-generic.dts
> +++ b/arch/arm/dts/rk3588-generic.dts
> @@ -40,5 +40,6 @@
>   };
>   
>   &uart2 {
> +	pinctrl-0 = <&uart2m0_xfer>;
>   	status = "okay";
>   };
