Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7199EC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 05:17:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2C087443;
	Mon, 30 Oct 2023 06:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698643056;
	bh=e7nr5k+SBD8bSpYtORNWvxtSYoFi0TxrhVNFEVZD3YE=;
	h=Subject:From:To:Cc:References:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=W5gPGbOYwgqiDFHCVUNDR67HSRLa47q/Y02njgTTpTeklmO2rmoXBpGejFSQbbw19
	 lAlUjxcsDEzUvSzgIHgd8fG03OG/ErHWw/k2TB0OkTTL76Cff86xALC3Gd1kkJRyte
	 khOSY17FJeEPyvGDn1ZJeB4DXBiyM7vqhPlDxqeSZsO4iTQG5B4Op88qm2J1GRwfp8
	 ZuTyJ68GjciBE0ccuTJkg0qvbu6WElZTVecR+NmwUf6799YUA6rMCIk/S/797pILCw
	 YdnSk+rDuY+4PP7jDlP0Y27Xu/yQhYfyByn+wPwThkjc7VrGc9t+Xgzzp7L8yTnbOt
	 sPP5qE5cPzmhw==
Received: from [192.168.1.107] (fibhost-66-250-177.fibernet.hu [85.66.250.177])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EF3C487196;
 Mon, 30 Oct 2023 06:17:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698643054;
 bh=e7nr5k+SBD8bSpYtORNWvxtSYoFi0TxrhVNFEVZD3YE=;
 h=Subject:From:To:Cc:Reply-To:References:Date:In-Reply-To:From;
 b=bUdQHvYotmy8t8e2SsSMbSdXOn6ylEC54VuWKyN0vumaOnQ5Lp4Cq1fq7yjqdJuR0
 Vj0395BdSQX2iPoJATgh7x7LH9uN1nStyhPtUBpcNUNt5v9jZUPW4vsqG68LyVMn/u
 bp4MsECKyiwkOCvgnx7qb0eKuUBqD+bG0qAYML1KjsoTy9z1EBV/bf6tM2c3teWQce
 eFnoP7o1YyhlOTQ0XSjV8VxBj1YqOtY9/ebvdBPXNeqBb43W6oJS0s2cltqodwLab3
 TDgkFSJvTfP44Rc3VDARhmTb3J7djKWqt+XVpQgPgqfn5Vrfx/8ljYdUOQnK8+RYu3
 taPZGfBVmZ7rQ==
Subject: Re: [PATCH v2 3/3] bootcount: Add driver model I2C driver
From: Heiko Schocher <hs@denx.de>
To: Philip Richard Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com
References: <20231020090227.16634-1-pro@denx.de>
 <20231020090227.16634-4-pro@denx.de>
 <1f54d2df-f56b-f2c0-6962-c6aed0c61a31@denx.de>
Message-ID: <8fd9d28e-1463-7351-0202-4dc96234c68b@denx.de>
Date: Mon, 30 Oct 2023 06:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1f54d2df-f56b-f2c0-6962-c6aed0c61a31@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Philip,

On 26.10.23 05:44, Heiko Schocher wrote:
> Hello Philip,
> 
> On 20.10.23 11:02, Philip Richard Oberfichtner wrote:
>> This adds a generic I2C bootcounter adhering to driver model to replace
>> the previously removed legacy implementation.
>>
>> There is no change in functionality, it can be used on any I2C device.
>> The device tree configuration may look like this for example:
>>
>> 	bootcount {
>> 		compatible = "u-boot,bootcount-i2c";
>> 		i2cbcdev = <&i2c_rtc>;
>> 		offset = <0x11>;
>> 	};
>>
>> Signed-off-by: Philip Richard Oberfichtner <pro@denx.de>
>> ---
>>
>> Changes in v2:
>>     	- Adaption of Kconfig help message
>>     	- Rename chip to bcdev
>>     	- Adapt probe to use i2c_get_chip_by_phandle()
>>
>>  drivers/bootcount/Kconfig            |  10 +++
>>  drivers/bootcount/Makefile           |   1 +
>>  drivers/bootcount/bootcount_dm_i2c.c | 103 +++++++++++++++++++++++++++
>>  3 files changed, 114 insertions(+)
>>  create mode 100644 drivers/bootcount/bootcount_dm_i2c.c
> 
> Reviewed-by: Heiko Schocher <hs@denx.de>

Your patch drops an checkpatch error:
"""
ERROR: Do not add common.h to files
#164: FILE: drivers/bootcount/bootcount_dm_i2c.c:10:
+#include <common.h>
"""

Could you please check and fix?

Thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
