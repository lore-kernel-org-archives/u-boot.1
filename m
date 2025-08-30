Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34433CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4301D8380E;
	Sat, 30 Aug 2025 16:31:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Fo7i5Icy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1244E83043; Sat, 30 Aug 2025 16:31:07 +0200 (CEST)
Received: from mail-m32110.qiye.163.com (mail-m32110.qiye.163.com
 [220.197.32.110])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 968508380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [121.204.19.91])
 by smtp.qiye.163.com (Hmail) with ESMTP id 21239851f;
 Sat, 30 Aug 2025 22:31:00 +0800 (GMT+08:00)
Message-ID: <67090e94-9b59-4fa9-b451-e1ac8003ea10@rock-chips.com>
Date: Sat, 30 Aug 2025 22:31:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: roc-3328-cc: use 1600 ddr4
 timing
To: Christian Hewitt <christianshewitt@gmail.com>,
 Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Da Xue <da@libre.computer>, u-boot@lists.denx.de
References: <20250610190820.1462097-1-christianshewitt@gmail.com>
 <20250610190820.1462097-3-christianshewitt@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250610190820.1462097-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a98fb63884503afkunm6f52c931405cc1
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0oeVkpIHhkeGB1DSkJNTVYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSUpVSUtPVUpCVUJKWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=Fo7i5Icyl3DQxPJzhYGTLV/dLWXE7zDCCD1P1lCtx89XkSCqjGNZZUWrfRYajWu0BeqkuVUQUJFt5KjfaCUcfnwePvgDVjk7SxmSS07z57wGj3edWdiIZ+9JQh74+4KoZNLYZkgmFf9VXA3frmAgF/hUZwh0Uk/12meMI0W+n/E=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=bg899g2XK5enSlTDlURpNKmUewVgx5yeczy3nLiszJY=;
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


On 2025/6/11 03:08, Christian Hewitt wrote:
> From: Da Xue <da@libre.computer>
>
> Swap the ROC-3328-CC from DDR4 666 to 1600 timing to boost performance.
>
> Signed-off-by: Da Xue <da@libre.computer>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3328-roc-cc-u-boot.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> index 582d6ba49b4..c47d29c59de 100644
> --- a/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-roc-cc-u-boot.dtsi
> @@ -4,7 +4,7 @@
>    */
>   
>   #include "rk3328-u-boot.dtsi"
> -#include "rk3328-sdram-ddr4-666.dtsi"
> +#include "rk3328-sdram-ddr4-1600.dtsi"
>   
>   / {
>   	smbios {

