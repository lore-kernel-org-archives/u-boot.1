Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A12E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C98880107;
	Fri,  3 Jan 2025 07:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="YD/P8Tkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE28E803F0; Fri,  3 Jan 2025 07:44:13 +0100 (CET)
Received: from mail-m127173.xmail.ntesmail.com
 (mail-m127173.xmail.ntesmail.com [115.236.127.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC846803CE
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 7978ae50;
 Fri, 3 Jan 2025 14:44:05 +0800 (GMT+08:00)
Message-ID: <9d89f5d4-e91b-435d-9cca-34f8b3358f12@rock-chips.com>
Date: Fri, 3 Jan 2025 14:44:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] rockchip: rk3399-gru: Fix include of TPL in
 u-boot.rom image
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241212235735.164272-1-jonas@kwiboo.se>
 <20241212235735.164272-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241212235735.164272-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0aHlZKGENJGkMYT08YSBpWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942ae829da03afkunm7978ae50
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQw6Nhw*CzIRKSw0KgkzOQMO
 FA8KFEhVSlVKTEhOQ0NNTU9NTktIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0tNNwY+
DKIM-Signature: a=rsa-sha256;
 b=YD/P8TkqXpYMp5GNF16aM63B1NNbw7MZFstwGW07pURlxpicNfYg33IuKK0He5AMZ3sYuKVKWTvfO/cTaauG42fJ5j3dsSN+W30Y+sCd33QZocGzB3GfZL10oaAtLc2soTI4sryUZv0Iy+a23zBeGDoLaK7S6zXqIrHTqnSXX2w=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=vkaQC7kLFI909RRFRFUMIVyw77BoKPtoEenGD2nBk+4=;
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


On 2024/12/13 07:57, Jonas Karlman wrote:
> The chromebook specific u-boot.rom image does not include TPL when
> building with TPL=y or ROCKCHIP_EXTERNAL_TPL=y.
>
> Fix this by adding rockchip-tpl and u-boot-tpl nodes to the mkimage node
> for the u-boot.rom binman image.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3399-u-boot.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index 81a3c6fc972b..bd7527dde223 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -39,6 +39,14 @@
>   
>   		mkimage {
>   			args = "-n rk3399 -T rkspi";
> +			multiple-data-files;
> +#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
> +			rockchip-tpl {
> +			};
> +#elif defined(CONFIG_TPL)
> +			u-boot-tpl {
> +			};
> +#endif
>   			u-boot-spl {
>   			};
>   		};
