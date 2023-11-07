Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95161C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 04:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E33086FB4;
	Tue,  7 Nov 2023 05:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JXMfsWbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF548870B4; Tue,  7 Nov 2023 05:05:21 +0100 (CET)
Received: from mail-m17222.xmail.ntesmail.com (mail-m17222.xmail.ntesmail.com
 [45.195.17.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B9086DD2
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 05:05:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JXMfsWbGdmevRXlvfxOdgWrLqAkQC7bPOiN6v96DSKtx+nC/VQTVqs1j7D4oAG0ACujiwKdSkHebwk0YgtCqe77b9DsebkMf77KUbimwm+6g6Cr2GSB4TXaCkkJv+xMjLb6amZD+jovVxb0rRHnQxZoQwqG2sR/Z19hd4rIN8Zw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=dcT7EYURSAqmH+7svBLx4DvOokBjmSxe8hBO2stynjg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 92FC44000FB;
 Tue,  7 Nov 2023 12:05:07 +0800 (CST)
Message-ID: <f28daf6d-8a2d-4f1a-b353-0a6879a4f9ff@rock-chips.com>
Date: Tue, 7 Nov 2023 12:05:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: dts: fix bootph tags for rv1126
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
References: <20231030131241.501472-1-tim@feathertop.org>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20231030131241.501472-1-tim@feathertop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5PHVZKTE8fSklLQk0ZTkJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8ba7f49c162eb3kusn92fc44000fb
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTI6NCo6HjwxNRU4ESFDVh8r
 PCxPChpVSlVKTUJCSElCQktDSUlKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSk1PNwY+
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


On 2023/10/30 21:12, Tim Lunn wrote:
> RV1126 fails to boot on 2024.01-rc1.
>
> Commit 9e64428 changed the behaviour of bootph-pre-ram, to limit
> nodes to spl phase. This caused rv1126 boards to fail to boot
> with the current dts.
>
> This patch updates the pmu/grf nodes to bootph-all tags as they are
> needed in all phases. This fixes the boot issue on rv1126 boards.
>
> Signed-off-by: Tim Lunn <tim@feathertop.org>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rv1126-u-boot.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rv1126-u-boot.dtsi b/arch/arm/dts/rv1126-u-boot.dtsi
> index 5e348278f2..918c307743 100644
> --- a/arch/arm/dts/rv1126-u-boot.dtsi
> +++ b/arch/arm/dts/rv1126-u-boot.dtsi
> @@ -26,15 +26,15 @@
>   };
>   
>   &grf {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &pmu {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &pmugrf {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &xin24m {
