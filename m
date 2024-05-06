Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0C5C10F16
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 10:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E530888511;
	Mon,  6 May 2024 12:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Dr6wTiuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B45FC88134; Mon,  6 May 2024 12:36:49 +0200 (CEST)
Received: from mail-m254123.xmail.ntesmail.com
 (mail-m254123.xmail.ntesmail.com [103.129.254.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBEAE8801F
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 12:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Dr6wTiuIkodSov6Qz6xFlsCnRcTp0d7PN9UIDlDKjrE0cH14Qx0vFfhK29kz8UTFNWd8YY51DZ36qiNzL27IwvTYmyZJOLEyyAnIP01RTgJS7zY9dD6eoUz2CKZMBUu6rEPU3bOdQhVXIKiL/IizKfYvAwNJWoJlf9W26yvfpvA=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=RFNkcgnwi1/4qmtrJOWhISYs+TIFoeqrwgP8dl7NSbc=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id B8D1F90032E;
 Mon,  6 May 2024 18:36:39 +0800 (CST)
Message-ID: <e0001b78-d964-4cc1-92c8-f279b4be67ac@rock-chips.com>
Date: Mon, 6 May 2024 18:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] rockchip: rk3399: Fix bootph prop for vop nodes
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240430153053.308788-1-jonas@kwiboo.se>
 <20240430153053.308788-15-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240430153053.308788-15-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRoeHlZDSRpPGkgZHh4YTkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8f4d7a1f9403a9kunmb8d1f90032e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NlE6LAw*HzNRNhY#CzkWQksd
 CA0KCx1VSlVKTEpPQkJKQ0tLT0NKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSE1PNwY+
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


On 2024/4/30 23:30, Jonas Karlman wrote:
> The vop nodes should not be included in TPL/SPL control FDT, it should
> only be included at U-Boot proper pre-reloc phase.
>
> Change to use bootph-some-ram prop to fix this.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v2: New patch split from "Fix loading FIT from SD-card" patch
> ---
>   arch/arm/dts/rk3399-u-boot.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
> index b9b8d3ee1d92..496f25d9fbf6 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -143,9 +143,9 @@
>   };
>   
>   &vopb {
> -	bootph-all;
> +	bootph-some-ram;
>   };
>   
>   &vopl {
> -	bootph-all;
> +	bootph-some-ram;
>   };
