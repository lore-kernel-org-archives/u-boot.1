Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B6CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 03:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE9684683;
	Tue,  5 May 2026 05:33:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="AALigvjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663278468B; Tue,  5 May 2026 05:33:57 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7564F839A8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 05:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 642AA1155E6; Tue,  5 May 2026 05:33:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777952034;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+RjAwTHGYmjvkJ6tAV9oDV/gQL9M9+mLwqIgqCRrtjA=;
 b=AALigvjxbBhNJNB0qKcoVrRws3WFuzCNMuhYD00QicLoAGrZ5CuWNhIgaymrHGYQKBKlQd
 bJid8TmO2jDWCd1fPstAW/PMKRhR0gfoDTTcJ56i0efC6NHMjyULgJyWAv5ecc9Icg7b33
 bUVjuhX6YnMkPF3o4HXjxQuMID3DtWFxiKvyxq/Mut3fwbmBvUlRTpI8PwuOOJLW0e1j0R
 iO9zGBvgEQ/fvUJw5N8wHsah9X8nVx0/e7Xm6eV4i1CwgbZJCEabbQhqdsR4ADBQsNvoK6
 7h3Ypkm6Rn+B+c2SU7zK6o72mGhr24WBh+jt0zns4z+EjT7LHHoFJyzkX/jvhw==
Message-ID: <a9e75ef1-a4b4-4d5c-bca5-3a3d233417a1@nabladev.com>
Date: Mon, 4 May 2026 21:12:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@nabladev.com>
Subject: Re: [PATCH] env: mmc: Use correct eMMC HW partition size when
 calculating end of HW partition
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Jasper Orschulko <jasper@fancydomain.eu>,
 Joe Hershberger <joe.hershberger@ni.com>, Michael Heimpold
 <mhei@heimpold.de>, Michael Walle <mwalle@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
References: <20260429121324.391457-1-marex@nabladev.com>
 <CAFLszTh8=H20tPnhym5CHsVSVg1LFcxeHLovd0VMVRYsiArmrQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTh8=H20tPnhym5CHsVSVg1LFcxeHLovd0VMVRYsiArmrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 5/4/26 2:22 PM, Simon Glass wrote:

Hello Simon,

>> diff --git a/env/mmc.c b/env/mmc.c
>> @@ -239,8 +239,12 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
>>                return -ENOENT;
>>        }
>>
>> -     if (offset < 0)
>> -             offset += mmc->capacity;
>> +     if (offset < 0) {
>> +             if (CONFIG_ENV_MMC_EMMC_HW_PARTITION)
>> +                     offset += mmc->capacity_boot;
>> +             else
>> +                     offset += mmc->capacity;
>> +     }
> 
> Just to clarify the motivation: every caller of mmc_get_env_addr()
> goes through init_mmc_for_env(), which calls mmc_set_env_part_init()
> -> blk_select_hwpart_devnum() -> mmc_switch_part() ->
> mmc_set_capacity(). After that switch mmc->capacity should already
> equal mmc->capacity_boot when CONFIG_ENV_MMC_EMMC_HW_PARTITION is 1 or
> 2. Can you describe the path where mmc->capacity is still
> capacity_user here? Perhaps the fix belongs instead in the
> partition-switch path?

The mmc_get_env_addr() is a public function, you can not predict the 
caller, so it should return the correct offset no matter which eMMC HW 
partition is selected.

>> diff --git a/env/mmc.c b/env/mmc.c
>> @@ -239,8 +239,12 @@ __weak int mmc_get_env_addr(struct mmc *mmc, int copy, u32 *env_addr)
>> +             if (CONFIG_ENV_MMC_EMMC_HW_PARTITION)
>> +                     offset += mmc->capacity_boot;
>> +             else
>> +                     offset += mmc->capacity;
> 
> This seems to do the wrong thing for
> CONFIG_ENV_MMC_EMMC_HW_PARTITION=3 (RPMB)

I don't think we support env in eMMC RPMB . Also, 
CONFIG_ENV_MMC_EMMC_HW_PARTITION=3 would be GP0 , not RPMB, which we 
also do not support.

> - it picks capacity_boot
> when capacity_rpmb is meant. The Kconfig is a plain int with no upper
> bound, so this is reachable. If you want to keep the explicit
> dispatch, you could key it off mmc_get_blk_desc(mmc)->hwpart so all
> partition kinds (user/boot/rpmb) fall out correctly. What do you
> think?

I could special-case it this way:

"
         if (offset < 0) {
-               if (CONFIG_ENV_MMC_EMMC_HW_PARTITION)
+               if (CONFIG_ENV_MMC_EMMC_HW_PARTITION == 1 ||
+                   CONFIG_ENV_MMC_EMMC_HW_PARTITION == 2) {
                         offset += mmc->capacity_boot;
-               else
+               } else if (CONFIG_ENV_MMC_EMMC_HW_PARTITION >= 3 ||
+                          CONFIG_ENV_MMC_EMMC_HW_PARTITION <= 6) {
+                       offset += 
mmc->capacity_gp[CONFIG_ENV_MMC_EMMC_HW_PARTITION - 3];
+               } else {
                         offset += mmc->capacity;
+               }
         }
"
[...]
