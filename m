Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA0FEE57DB
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 21:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6908788BDB;
	Wed, 11 Sep 2024 23:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="vvTOIlyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B6F88C19; Wed, 11 Sep 2024 23:58:00 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC90888BD6
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ddrokosov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 7325012000D;
 Thu, 12 Sep 2024 00:57:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7325012000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1726091877;
 bh=mkYq9w8YNKQRCbYJR0SZ0A78RDFbkK/bkMt08fj2MLc=;
 h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
 b=vvTOIlyWr4f/+D4CpEWxJtMG0GWJCufWtqiwhPEOjwyUhO5MsFzjXRra6UihoxThH
 1ckWGfq5Ulr61/anPkPT+oLy+St3AoczlbyCEtjOdzesFBr/bep+vz2cLMky8Y3vQS
 sRazRvIT9NV2yijTUTlYqlVpqHG6/8Z/d7cZhLzesccKUcqCSwW+V8AIUJJAPuA+jC
 rcOhBnk41yzFCalEyWKyQFqc1tCxGY1RbN9CWnUGxQhKDPMsEiPN6sHTgDV/pYl7dj
 ptiLm+fP5nAdMvWDAe70Yx2VaJpwFzm1lUfnOXjOUoaqPtTjfp0MTrlt8cOihZOivK
 H9IHZBjj47dcw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 12 Sep 2024 00:57:57 +0300 (MSK)
Date: Thu, 12 Sep 2024 00:57:56 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <mkorpershoek@baylibre.com>, <sjg@chromium.org>
CC: <igor.opaniuk@gmail.com>, <semen.protsenko@linaro.org>,
 <trini@konsulko.com>, <colin.mcallister@garmin.com>, <4.shket@gmail.com>,
 <avromanov@salutedevices.com>, <u-boot@lists.denx.de>,
 <kernel@salutedevices.com>, <rockosov@gmail.com>
Subject: Re: [PATCH v2 5/6] common: android_ab: fix slot suffix for abc block
Message-ID: <20240911215756.5a7ulmaaza2oxvvx@CAB-WSD-L081021>
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-6-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240911214945.15873-6-ddrokosov@salutedevices.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.28.192.196]
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187695 [Sep 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 android-review.googlesource.com:5.0.1,7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 source.android.com:5.0.1,7.1.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/11 19:53:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/11 21:01:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/09/11 19:25:00 #26555689
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hello Simon and Mattijs!

In the v1 patch series, you suggested creating a test case for the
changes in this patchset. However, the bcb ab_dump test in the current
patch series already covers all code paths involving slot_suffix
generation. Therefore, an additional test case for that is not
necessary.

On Thu, Sep 12, 2024 at 12:49:13AM +0300, Dmitry Rokosov wrote:
> To align with the official Android BCB (Bootloader Control Block)
> specifications, it's important to note that the slot_suffix should start
> with an underscore symbol.
> 
> For a comprehensive understanding of the expected slot_suffix format in
> userspace, please refer to the provided reference [1].
> 
> Links:
> [1] - https://source.android.com/docs/core/architecture/bootloader/updating#slots
> 
> Based-on: https://android-review.googlesource.com/c/platform/external/u-boot/+/1446439
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/android_ab.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/boot/android_ab.c b/boot/android_ab.c
> index c93e51541019..a287eac04fe8 100644
> --- a/boot/android_ab.c
> +++ b/boot/android_ab.c
> @@ -52,7 +52,7 @@ static int ab_control_default(struct bootloader_control *abc)
>  	if (!abc)
>  		return -EFAULT;
>  
> -	memcpy(abc->slot_suffix, "a\0\0\0", 4);
> +	memcpy(abc->slot_suffix, "_a\0\0", 4);
>  	abc->magic = BOOT_CTRL_MAGIC;
>  	abc->version = BOOT_CTRL_VERSION;
>  	abc->nb_slot = NUM_SLOTS;
> @@ -328,7 +328,8 @@ int ab_select_slot(struct blk_desc *dev_desc, struct disk_partition *part_info,
>  		 * or the device tree.
>  		 */
>  		memset(slot_suffix, 0, sizeof(slot_suffix));
> -		slot_suffix[0] = BOOT_SLOT_NAME(slot);
> +		slot_suffix[0] = '_';
> +		slot_suffix[1] = BOOT_SLOT_NAME(slot);
>  		if (memcmp(abc->slot_suffix, slot_suffix,
>  			   sizeof(slot_suffix))) {
>  			memcpy(abc->slot_suffix, slot_suffix,
> -- 
> 2.43.0
> 

-- 
Thank you,
Dmitry
