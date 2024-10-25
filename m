Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA24D0C601
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 11:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9972F88BB2;
	Fri, 25 Oct 2024 13:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KYbJs4t6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3A0B88FAC; Fri, 25 Oct 2024 13:58:40 +0200 (CEST)
Received: from mail-m19731105.qiye.163.com (mail-m19731105.qiye.163.com
 [220.197.31.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C26888EB
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 13:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id ebe5817;
 Fri, 25 Oct 2024 19:58:23 +0800 (GMT+08:00)
Message-ID: <eb9585ad-f05b-49b6-be20-2bfb77385628@rock-chips.com>
Date: Fri, 25 Oct 2024 19:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/18] arm64: dts: rockchip: enable uart0 on Qnap-TS433
To: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: ukleinek@debian.org
References: <20241013192424.84280-1-heiko@sntech.de>
 <20241013192424.84280-4-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241013192424.84280-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU1LTlZKGB5ITR5LSE8eGEhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a92c38ac25d09d6kunmebe5817
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pj46FRw*KTIaCxcNKQ4ZKENK
 FA0KFDBVSlVKTElCQ05MTktPTU9DVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSEpINwY+
DKIM-Signature: a=rsa-sha256;
 b=KYbJs4t6n1ncpCEIpUoC4CIK+VcboxoLAH2dFLm0MZtR+zw8Xjg234+8oUCFxJUVR+iT+UZDMmjktMCNINQEtf7ceusPh8iE2dRJ30K/lH3AX8raH5tbJyzu0YX9RELMqLLWNK6AuJorjXnCcTyrtz/ShkaGHp+WEWxY0/110R4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=3k/KdIB9tAXJpy/Owljfzt0j8oAupUKGZPVPlkuzRDM=;
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
> Uart0 is connected to an MCU on the board that handles system control
> like the fan-speed. So far no driver for it is available though.
>
> Tested-by: Uwe Kleine-König <ukleinek@debian.org>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Link: https://lore.kernel.org/r/20240723195538.1133436-4-heiko@sntech.de
>
> [ upstream commit: 07ef8be476bebd77cba3ca4804be03cc0dba414f ]
>
> (cherry picked from commit aaa5b1c4bd8f0e4327078d513f0eef05cb829bcf)
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> index 9bf9c3b65ca..bc26f2e98c1 100644
> --- a/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> +++ b/dts/upstream/src/arm64/rockchip/rk3568-qnap-ts433.dts
> @@ -104,6 +104,14 @@
>   	status = "okay";
>   };
>   
> +/*
> + * Connected to an MCU, that provides access to more LEDs,
> + * buzzer, fan control and more.
> + */
> +&uart0 {
> +	status = "okay";
> +};
> +
>   /*
>    * Pins available on CN3 connector at TTL voltage level (3V3).
>    * ,_  _.
