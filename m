Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE49DCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:43:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49296832AD;
	Sun, 26 Oct 2025 16:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="eunUHtZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502CC836B2; Sun, 26 Oct 2025 16:43:16 +0100 (CET)
Received: from mail-m15598.qiye.163.com (mail-m15598.qiye.163.com
 [101.71.155.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1FE82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f8d;
 Sun, 26 Oct 2025 23:43:10 +0800 (GMT+08:00)
Message-ID: <23df6d1f-113e-4adf-8dc1-5767b440bb59@rock-chips.com>
Date: Sun, 26 Oct 2025 23:43:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3528-radxa-e20c: Drop eMMC HS200 prop from
 board u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251019111357.723242-1-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019111357.723242-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a2130162d03afkunm80a68f254d2a37
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGUsaVk1PSk5OH08aS08fT1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=eunUHtZd9DxeOtnBGxV7e9jPqmDn5QQiUpciwfG41Ul55sZapmvRtNVA1SHeCJkT0qHiWcDfZpNlE7bN63th1OrzKo6NpgSqkRK994kLT/eXhIdJCC26ItBKNAH2h5KDLRENXwHTlkcQTQIZCKw2T58oslLJcTW10o9uYuCD0Rc=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=Hkbtz94gjTXDDghwnKRGY+Wa2W2wL5TuhA1uamrOY0g=;
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


On 2025/10/19 19:13, Jonas Karlman wrote:
> The commit f8cb3fde935e ("arm: dts: rockchip: Fix eMMC write on RK3528")
> added a missing mmc-hs200-1_8v prop to boart u-boot.dtsi.
>
> Remove this boart u-boot.dtsi mmc-hs200-1_8v prop now that the board dt
> from dts/upstream after the v6.17-dts sync includes this prop.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> index 16c47e6b9a9e..3e2fbd81da17 100644
> --- a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> +++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
> @@ -2,10 +2,6 @@
>   
>   #include "rk3528-u-boot.dtsi"
>   
> -&sdhci {
> -	mmc-hs200-1_8v;
> -};
> -
>   &vdd_arm {
>   	regulator-init-microvolt = <953000>;
>   };

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

