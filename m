Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A028CF9C5B
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 14:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF2388B58;
	Sat, 21 Sep 2024 16:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726927522;
	bh=z4BuUrwpNBCyNHfkPlCQ8lxpo50e3qqHLYo6e7hCsPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYdAxSjBocgUhlontu5rHBwNnQEC2ruE3PT3SNOrIuhfoDtGkYWArrBZrCCXcKJ/d
	 yU8OqWY86Xb5gUQYvIfj9OWAvrHjwUqS/FteS0XGnEBUSUo1PE7nMcJyhp48ecfxRy
	 R8ykZ8JJwZbWHH27yfUL87Xoa6wc8B6BlPoxQHB9DvbfLjAsOicttR5oOsrfAbJJrC
	 iHnfv4+FF4v880tbi0rIO0tdBFKBzrQJKPBT3ngIU7dHXhRDGXZgwbxrePinQMMNDx
	 /iUTiOYiU2ac+PaGWxPFoRHJXQJGDqW5yf0QmzrBJMlYAXTTh769e8sq+o1mNbn2jV
	 IPC/uHHjvYcnA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4313488AA7;
 Sat, 21 Sep 2024 16:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726927520;
 bh=z4BuUrwpNBCyNHfkPlCQ8lxpo50e3qqHLYo6e7hCsPQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CqlSPgzyQSINlViIBfyv/HmviXMtXcb0Var8MSs3frBaTSUP5FYijQWSorV4ZMvwg
 fret4DoLKMaO8UkKeLYXESYz4nHXGjDMQwoFYEyIZMkULk4SVyvTyMt6SeABCpc0Vr
 H9vneriYqN8GNbZ9JOKh6gvE+4J9xe9GShj7+qqVlOe3yjG9FV6ntQOETeXMY1sPR7
 yfex9eUm7tZVKDPjhFwLyCaOKAyv6Z85SkDjV3XI5kYtfgQjtOJ9Nc7/2g+abkHfyO
 DHCmsTHBlZ+I4saomhgXsT6mJa9tl3f9S6stVrjrh+HTJ6PqpDKf6mHJeSeGWRf/sY
 k4wfMLn4/FpGA==
Message-ID: <92fa9c17-bbf4-49b5-8d7c-4b7d06f60736@denx.de>
Date: Sat, 21 Sep 2024 15:50:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/20] arm: dts: agilex5: Enable XGMAC
To: tien.fong.chee@intel.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Meng Tingting <tingting.meng@intel.com>,
 Yuslaimi Alif Zakuan <alif.zakuan.yuslaimi@intel.com>,
 Hea Kok Kiang <kok.kiang.hea@intel.com>
References: <20240920070242.20884-1-tien.fong.chee@intel.com>
 <20240920070242.20884-9-tien.fong.chee@intel.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240920070242.20884-9-tien.fong.chee@intel.com>
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

On 9/20/24 9:02 AM, tien.fong.chee@intel.com wrote:
> From: Tien Fong Chee <tien.fong.chee@intel.com>
> 
> Enable XGMAC for SoCFPGA Agilex5 devkit.
> 
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>   .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> index 9eb21d65428..75ab05031bc 100644
> --- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> +++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
> @@ -122,3 +122,36 @@
>   	bootph-all;
>   };
>   
> +&gmac0 {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +	phy-handle = <&emac0_phy0>;
Shouldn't this be part of Linux DT already ?
