Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70974D116E6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 01:41:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90D5E83B72;
	Thu, 27 Nov 2025 02:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="B68u5BAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6AB883D13; Thu, 27 Nov 2025 02:40:56 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66EBC83A64
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 02:40:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20251127014043epoutp01b08b6e7221221ec56cbb4eebc229ab82~7uYEzRPHc1174511745epoutp01T
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 01:40:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20251127014043epoutp01b08b6e7221221ec56cbb4eebc229ab82~7uYEzRPHc1174511745epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1764207643;
 bh=Krk3JGPoELv/FoBHYJNrwteaxQlWq8snMDNSv9QQbow=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=B68u5BAn/13stjwO03NG53rLoD2QJdBGsIsQXnVgRJRo8CSh1j8hxMCC78G9IiZTa
 Y7PY54+bhzGvMszVVyxM7kR+GWgfMdK2fSjPbtL7Xg9krlKNzuC1JG/JdcJ+I+1UyH
 ZIj55fswN9h2//wSHl5yxTZFjObD1q5G5Nr6Wpe4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
 20251127014043epcas1p2592fd4f63a27ac14b31c4acef2e2ce6d~7uYEmBg2d1343913439epcas1p2G;
 Thu, 27 Nov 2025 01:40:43 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.115]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4dGzf26y4dz3hhTK; Thu, 27 Nov
 2025 01:40:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20251127014042epcas1p40c3e7a674c9e241416ea90255c3a1059~7uYDupvGa1302913029epcas1p4B;
 Thu, 27 Nov 2025 01:40:42 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20251127014042epsmtip2a99c10f05a44718601f6a04e7efbf4e2~7uYDsGDYx2618026180epsmtip2L;
 Thu, 27 Nov 2025 01:40:42 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: "'Stefan Bosch'" <stefan_b@posteo.net>, "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
In-Reply-To: <b56b9e23-5667-b018-0d12-58f21e913066@posteo.net>
Subject: RE: [PATCH] s5p4418_nanopi2: Stop disabling device tree relocation
Date: Thu, 27 Nov 2025 10:40:42 +0900
Message-ID: <006301dc5f3e$d7985cd0$86c91670$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIFwcqhm9stn9mEHudbIqPVI6FbdQHwuRJBAlyHjhS0j5tYUA==
Content-Language: ko
X-CMS-MailID: 20251127014042epcas1p40c3e7a674c9e241416ea90255c3a1059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251126093117epcas1p3589fe6eba854b9a1bd7ad71a9611bc22
References: <20251119145535.843388-1-trini@konsulko.com>
 <CGME20251126093117epcas1p3589fe6eba854b9a1bd7ad71a9611bc22@epcas1p3.samsung.com>
 <b56b9e23-5667-b018-0d12-58f21e913066@posteo.net>
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

Hi,

> If there is some window of memory that must be used for where the 
> device tree is relocated to, bootm_low + bootm_size (or often just 
> bootm_size) or bootm_mapsize are the correct way do this. Please see 
> doc/usage/environment.rst for more details.
> 
> Cc: Stefan Bosch <stefan_b@posteo.net>
> ---
>   include/configs/s5p4418_nanopi2.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/configs/s5p4418_nanopi2.h 
> b/include/configs/s5p4418_nanopi2.h
> index fec1bfd50eb9..8a8d54daf7b4 100644
> --- a/include/configs/s5p4418_nanopi2.h
> +++ b/include/configs/s5p4418_nanopi2.h
> @@ -139,7 +139,6 @@
>   #endif
>   
>   #define CFG_EXTRA_ENV_SETTINGS				\
> -	"fdt_high=0xffffffff\0"					\
>   	"initrd_high=0xffffffff\0"				\
>   	"rootdev=" __stringify(CONFIG_ROOT_DEV) "\0"		\
>   	"rootpart=" __stringify(CONFIG_ROOT_PART) "\0"		\

Applied to u-boot-samsung.

Thanks,
Minkyu Kang.

