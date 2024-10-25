Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2A4D0C602
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD978903C;
	Fri, 25 Oct 2024 13:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZEzyeE0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2778D89024; Fri, 25 Oct 2024 13:59:32 +0200 (CEST)
Received: from mail-m15596.qiye.163.com (mail-m15596.qiye.163.com
 [101.71.155.96])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0218388BB2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe584c;
 Fri, 25 Oct 2024 19:59:18 +0800 (GMT+08:00)
Message-ID: <aa51ec7a-db1e-47d6-b91b-b1bbfc23aadc@rock-chips.com>
Date: Fri, 25 Oct 2024 19:59:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] arm64: dts: rockchip: enable the tsadc on the
 Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-10-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-10-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlJHVZPSxlMQ09MTUJCSkhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38b99aa09d6kunmebe584c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6Nww6PjIvHxchE0saNi0L
 FRYaCUxVSlVKTElCQ05MTk5CTEJNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSUlPNwY+
DKIM-Signature: a=rsa-sha256;
 b=ZEzyeE0hkfjgtwmB3NloOkTy71TeVDT6PasFaiLmTgNzjwavXEHFz3AcZ2vLJPOhySCTbW5/jbGDkFIFslpjImODAmwwOK341d92uzAbHA/E2DNU8QYo9BDQ36CYIYjKOp6QXzWgbXg6wgtyc31vZ3iBeX7BSS4kLgaMtEDUavI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Q7FdMcbREodeD9nogZulRJPDYCE8Un5YR/MOIrbNUlc=;
 h=date:mime-version:subject:message-id:from;
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


On 2024/10/14 03:24, Heiko Stuebner wrote:
> Enable the tsadc node to allow for temperature measurements of the soc.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-10-heiko@sntech.de
>
> [ upstream commit: 2dfdddd9d20306fd0d04b88fcbbf36d76fb67f11 ]
>
> (cherry picked from commit d33949501abd1145ea572b605844f0ef4247478d)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index abeb00add42..34fc31ea9a3 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -246,6 +246,12 @@
>   	status = "okay";
>   };
>   
> +&tsadc {
> +	rockchip,hw-tshut-mode = <1>;
> +	rockchip,hw-tshut-polarity = <0>;
> +	status = "okay";
> +};
> +
>   /*
>    * Connected to an MCU, that provides access to more LEDs,
>    * buzzer, fan control and more.
