Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C862C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 08:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1646888047;
	Wed, 22 May 2024 10:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XRZemZfb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A6888081; Wed, 22 May 2024 10:30:25 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BEEB87E95
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 10:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716366623; x=1718958623;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z1Mn1DObJxE1uo4MTB38U14H98kqbiPPrwwdY7s1EKA=;
 b=XRZemZfbfMBw4rQKgf6mfCd93sjbIG5bToa13FGsiqgA99BH7Fcj2ZLT60F+g9+Y
 jcJ3mjJwH6XBNSwDqoTmLNL+OUaI/x2jBncxLPJtw35tJixCcVVYUny06bytWAQh
 lmsQulzwbLFkOYm1+MsinAC1yFCBdgkL6PPWhR6lwBA=;
X-AuditID: ac14000a-03251700000021bc-23-664dad1f7cc4
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CE.41.08636.F1DAD466;
 Wed, 22 May 2024 10:30:23 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 22 May
 2024 10:30:23 +0200
Message-ID: <dee06e33-5d87-491b-8570-f3bfeca81c01@phytec.de>
Date: Wed, 22 May 2024 10:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 6/6] configs: phycore_am62x_a53_defconfig:
 Enable CONFIG_ENV_OVERWRITE
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
References: <20240522061827.601699-1-d.schultz@phytec.de>
 <20240522061827.601699-7-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240522061827.601699-7-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOLMWRmVeSWpSXmKPExsWyRpKBR1d+rW+aQddpU4u3ezvZLbrfqTsw
 eZy9s4PRo7+7hTWAKYrLJiU1J7MstUjfLoEr49nZLqaCfvaK5psLmRoYG9i6GDk5JARMJJqf
 vmbsYuTiEBJYwiTR9v8MO4Rzl1Hi9tRdTCBVvAI2ErfOHGcHsVkEVCVuTe1lhYgLSpyc+YQF
 xBYVkJe4f2sGWI2wQLrEim+zmUFsEYE4iXW7XoPNERLIlJjxcAkjiM0sIC5x68l8sDibgLrE
 nQ3fwGZyClhJPDyymA2ixkJi8ZuD7BC2vMT2t3OYIebIS7y4tJwF4gN5iWnnXjND2KESW79s
 Z5rAKDQLyXmzkKybhWTsLCRjFzCyrGIUys1Mzk4tyszWK8ioLElN1ktJ3cQICmwRBq4djH1z
 PA4xMnEwHmKU4GBWEuGNXumbJsSbklhZlVqUH19UmpNafIhRmoNFSZx3dUdwqpBAemJJanZq
 akFqEUyWiYNTqoFR/uRi+XkJXJqOW2p07iyvncAsp6VXfKLk78G5LD0Wu39tOSae5Lhx2TdH
 Sf6LguJ/Pn15u++uyd/ZHtZbO4NqC26afItbydeeEqNd+1E+jb2+Zl3S4ZkMXXOq5vnuXVfE
 eG6ZjMaSH7ambFIf9ly6LDEv18182/RebevGH/dU+PwEjKee9bFTYinOSDTUYi4qTgQAWQXl
 uloCAAA=
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

Hi Daniel,

Am 22.05.24 um 08:18 schrieb Daniel Schultz:
> Enable CONFIG_ENV_OVERWRITE to overwrite ethaddr in the environment.
> This is required because our environment is not located in the
> boot partition.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   configs/phycore_am62x_a53_defconfig | 1 +
What about the change for the phycore_am64x?


>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index fd36edc29dd..286cd89c5a6 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -59,6 +59,7 @@ CONFIG_SPL_OF_CONTROL=y
>   CONFIG_MULTI_DTB_FIT=y
>   CONFIG_SPL_MULTI_DTB_FIT=y
>   CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_MMC_ENV_DEV=1
>   CONFIG_NET_RANDOM_ETHADDR=y
