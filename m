Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300FDC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 04:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5BA87A0E;
	Thu, 18 Jan 2024 05:58:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PVtFvZcM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DF5687A14; Thu, 18 Jan 2024 05:58:01 +0100 (CET)
Received: from mail-m606.netease.com (mail-m606.netease.com [210.79.60.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C9C4879C4
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 05:57:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=PVtFvZcMAHsbdBWD3ITdbdPaOps4iDk0Qu2I+ljF3UV+2TbKxLilqLwkenmDqf/ryNyGbxPPH+v1q9VFqCIOYPR70Bmv2QvikpKEPG4clOBTxsEsfZUcte7fZV14A2QOYNaFXgPcJddNAmt4zAFUQhLFrtpT/WiSY4tkd+yeOQ4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=OrqB+5LZ6Sg/RYsGaVcowOy+uJmpEormyu91O4nJsFo=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 02709900328;
 Thu, 18 Jan 2024 12:57:52 +0800 (CST)
Message-ID: <a7ce4a4f-4c66-4e4f-86db-d98b5bc57ec7@rock-chips.com>
Date: Thu, 18 Jan 2024 12:57:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dts: rockpro64: Disable usb regulators-always-on
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>, marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20231222144236.509978-1-i@shantur.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231222144236.509978-1-i@shantur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlMQ1ZOHkMdTU8eGk4dHxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d1aeec9262eafkusn02709900328
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6Aww*TTwdTRAUHCs8Qgw6
 DkoKCipVSlVKTEtOTk5IQ0xITUpIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJQ0hCNwY+
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

Hi Shantur,

     Since you are working on the dts change in mainline kernel, you can 
sync the dts after kernel apply.

This patch will be dropped.


Thanks,

- Kever

On 2023/12/22 22:42, Shantur Rathore wrote:
> USB port regulators should be controlled by PHYs
> so we remove always-on property and let phy manage the
> regulator.
>
> phy-supply isn't configured for TypeC port in upstream and
> now that we are removing always-on, we need to add the
> phy-supply until its fixed upstream.
>
> Signed-off-by: Shantur Rathore <i@shantur.com>
>
> ---
>
> Changes in v4:
> - otg port must be configured with phy-supply instead of host port node
>
> Changes in v3:
> - Split up patches as seperate series
>
> Changes in v2:
> - As requested, added fix for regulator-always-on in RockPro64
>
>   arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> index 732727d9b0..0ac9fa9a03 100644
> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> @@ -22,6 +22,18 @@
>   	};
>   };
>   
> +&u2phy0_otg {
> +	phy-supply = <&vcc5v0_typec>;
> +};
> +
> +&vcc5v0_host {
> +	/delete-property/ regulator-always-on;
> +};
> +
> +&vcc5v0_typec {
> +	/delete-property/ regulator-always-on;
> +};
> +
>   &vdd_center {
>   	regulator-min-microvolt = <950000>;
>   	regulator-max-microvolt = <950000>;
