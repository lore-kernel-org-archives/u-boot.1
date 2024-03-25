Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4AEC54E58
	for <u-boot@archiver.kernel.org>; Mon, 25 Mar 2024 14:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E6187F1E;
	Mon, 25 Mar 2024 15:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711375275;
	bh=Dsr4ea7ArTSf9MPAeN49cAxhetnVQBsWQUbpBEvMEqk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qd4Qwk6skRCaBRR3bZ9YSict+kgdAO9Yz0wSvjzUzP7QELojEykFdsMojs/eRlSaD
	 PU5uEk8Iqe79H4tBhYzDzmdnitjkvmwe2bFJe9y8wQRoNtJhSedoI8TRzAtWLIHg9P
	 Y2YaapVFK8eg22p3CsvjIQXCVYbmMb6KeeKhxcgB+RGKwR3hqzJjGF02QilAqzlaon
	 l7qMOkUXmC4rzECfsn4RHQtjQMMmACCw1lY6ldtREic8D3HFDN6ivbKnjI5OPVoXLb
	 od/dkmwZysLYUSm0KfAfHli/OHiQaSWI0OCoc1ylkZ5Vb8Vix6i1wOaFLuYrhst8O1
	 XcxykUOovoUMA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 098B487EDF;
 Mon, 25 Mar 2024 15:01:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711375274;
 bh=Dsr4ea7ArTSf9MPAeN49cAxhetnVQBsWQUbpBEvMEqk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CyPp9iDm8uNCZnMotBx1vC39PscOnej/op9vSFMfeUjE6p8LuIEHAO9pfnwgurpyw
 D6+3aP54KpD1kavno+TCVTuRjMYJYO8LWX5RMGy0blCusXFMCl669RxTQhvAzRxdkb
 qBSRGCPFXxj0jS/SWC++jvmObI9k+4IXQNq2BQ83X1Kj0aaZDyl1YIEVCgm1++bpVZ
 XYAkv4O/drnBjip6frkeYWUqHOZYK3u0vQIOu1niXDbVjpJBck/4i4MiUlevg3Fcg9
 M43FPch89/BamCUiHU1p//tT8zPrAjUWn7/IgBHOpWTLwS/A7sCcETJ+t1F841qfd5
 W4CozVGVzMwWw==
Message-ID: <8c17ed8e-b282-4eae-8059-10d9c0a7670d@denx.de>
Date: Mon, 25 Mar 2024 15:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phycore_pcl063: Drop leading zero from USB vendor number
To: Fabio Estevam <festevam@gmail.com>, martyn.welch@collabora.com
Cc: parthitce@gmail.com, u-boot@lists.denx.de, y.moog@phytec.de,
 w.egorov@phytec.de, Masahiro Yamada <masahiroy@kernel.org>
References: <20240325135230.1777213-1-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240325135230.1777213-1-festevam@gmail.com>
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

On 3/25/24 2:52 PM, Fabio Estevam wrote:
> CONFIG_USB_GADGET_VENDOR_NUM is a 16-bit number, so remove
> the leading zero.
> 
> Reported-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>   configs/phycore_pcl063_defconfig     | 2 +-
>   configs/phycore_pcl063_ull_defconfig | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/phycore_pcl063_defconfig b/configs/phycore_pcl063_defconfig
> index 6b00df1cffb3..017054a8e12b 100644
> --- a/configs/phycore_pcl063_defconfig
> +++ b/configs/phycore_pcl063_defconfig
> @@ -63,7 +63,7 @@ CONFIG_USB=y
>   CONFIG_SPL_USB_HOST=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_MANUFACTURER="Phytec"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x01b67
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4fff
>   CONFIG_CI_UDC=y
>   CONFIG_USB_GADGET_DOWNLOAD=y
> diff --git a/configs/phycore_pcl063_ull_defconfig b/configs/phycore_pcl063_ull_defconfig
> index 6195fcfb73df..b3da43a5bf1e 100644
> --- a/configs/phycore_pcl063_ull_defconfig
> +++ b/configs/phycore_pcl063_ull_defconfig
> @@ -54,7 +54,7 @@ CONFIG_USB=y
>   CONFIG_SPL_USB_HOST=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_MANUFACTURER="Phytec"
> -CONFIG_USB_GADGET_VENDOR_NUM=0x01b67
> +CONFIG_USB_GADGET_VENDOR_NUM=0x1b67

Reviewed-by: Marek Vasut <marex@denx.de>

+CC Yamada-san , can Kconfig somehow sanitize 16bit numbers like this ?
