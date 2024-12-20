Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA2CE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F9B8021D;
	Fri, 20 Dec 2024 03:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="ivLKu4QN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D95A80291; Fri, 20 Dec 2024 03:05:12 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A358021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20241220020502epoutp02ac51c48e1fe3e67f319c21d5bcc9426f~SwFq6jW8T2479424794epoutp02b
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 02:05:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20241220020502epoutp02ac51c48e1fe3e67f319c21d5bcc9426f~SwFq6jW8T2479424794epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734660302;
 bh=0JqlCi6ZQXveD5LautM/2yo+OFgGx5DGMYFmW8iZWBs=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=ivLKu4QN8CAAWjlT+dCQNe4tzqeAcZ81MRFeEnO4/kB8aFRYz0LKHQxertmuIUoLu
 IGxMs24G6DGFpbT7eAfpHKm2Zzo4iwOvP7SAnlfsm+EtsfJpNFGE+AYt+NERo5Vi7W
 a8DoF6sjQ9Xt9RGpSlCq+GfzcIRxxunvkT8YFcwg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20241220020502epcas1p1f7b3de992e79fa92fd79031bc6e54952~SwFqrA-QM1391113911epcas1p1E;
 Fri, 20 Dec 2024 02:05:02 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.236]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YDrMx01XGz4x9QB; Fri, 20 Dec
 2024 02:05:01 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 A0.A3.23253.AC0D4676; Fri, 20 Dec 2024 11:04:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20241220020457epcas1p2a014fd54b835a529175a6fdd38e7224d~SwFmnzQrV2881028810epcas1p2J;
 Fri, 20 Dec 2024 02:04:57 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20241220020457epsmtrp2cbc735f30a765b05078a53559cb1da7b~SwFmnJxT90266102661epsmtrp2i;
 Fri, 20 Dec 2024 02:04:57 +0000 (GMT)
X-AuditID: b6c32a33-5b18370000005ad5-4f-6764d0ca6819
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.E0.33707.9C0D4676; Fri, 20 Dec 2024 11:04:57 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241220020457epsmtip28114e7c5d8fb22bcf26766dee595a76b~SwFmctYBL1065910659epsmtip2g;
 Fri, 20 Dec 2024 02:04:57 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Shree Ramamoorthy'" <s-ramamoorthy@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
Cc: <m-leonard@ti.com>, <praneeth@ti.com>
In-Reply-To: <6a7b88ae-da5a-4430-87a4-84f4005fe183@ti.com>
Subject: RE: [PATCH v1 2/2] power: replace magic numbers with macros
Date: Fri, 20 Dec 2024 11:04:57 +0900
Message-ID: <049f01db5283$91a33fb0$b4e9bf10$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDJjZr8Ya4lM0w/UNXlTz8OpdnKCAFA/cSAAi20pJYCf7MVSwKE0otwAiscdFoC6wWtfbSloCmA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmvu6pCynpBh9fSlk83D6PxeLPo5ds
 Fr8OrWe2mDppM7vF272d7A6sHq8OrGL3OHtnB6PH8RvbmQKYo7JtMlITU1KLFFLzkvNTMvPS
 bZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4B2KimUJeaUAoUCEouLlfTtbIryS0tS
 FTLyi0tslVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM65d62Ip6NCteH7mC1MD4xHl
 LkZODgkBE4meec/Zuhi5OIQEdjBKHP+7lRnC+cQo8evyeQTn2vS7TDAt2x7sZoFI7GSUWLTi
 NBOE8xLI2XSNBaSKTUBP4v+ihcwgtohAgsSfTbfBupkFNCX2bN8IVMPBwSlgJTHtFyeIKSzg
 IvFoUwBIBYuAqsSCrV/ZQWxeAUuJ7w8XsULsVZD4+XQZK8QUEYnZnW3MIK0iAlESr07GgFwg
 IXCIXeJH/1SwuATQyPX7RCFahSVeHd/CDmFLSXx+t5cNor6ZUWLpkoOsEE4Po8S/hutsEFXG
 EvuXTmYCGQRy8vpd+hB7+STefe1hhZjPK9HRJgRRrSJx6fVLJpj5d5/8hzrZQ+Js52poUDUy
 Szxpf8Q4gVF+FpIXZiFsWMDItIpRLLWgODc9NdmwwBAekcn5uZsYwUlNy3gH4+X5//QOMTJx
 MB5ilOBgVhLhddNMTBfiTUmsrEotyo8vKs1JLT7EaAoMyInMUqLJ+cC0mlcSb2hiaWBiZmRs
 YmFoZqgkznvmSlmqkEB6YklqdmpqQWoRTB8TB6dUA5PNKta29KMuT/le3Tk1dR+L0qMpLb8P
 ivAazzP9abb+b/KaSQHnXB9r6dbuS3ltq+LLMUHd6tbDdd1vp/cd9Yx58KH0739uw1cLnlqf
 +Xb7koaHk0BO+pxlTV/41/T9Pv1j7zSX9c9O9Phcl3y66KwE6xTPd5/E392xPKqw+d3bi0xz
 Jz3RvrjYoy9gzspXGz9y+5fmvZYw+8neG/G0xDXHRl7nwY8l09+kPtyk/D7lIudf1tZWT8Wl
 Vdpf6zcYTBP2mb5dW9fgIX8wU2FOyWrdft30JqFNO3/I/+Fb/Ecrk629elYre9XZVp8VIbr6
 N5g2RO3g6q3RZjfNXb5feNrveWxi13p/3Vy4wnU/U/RuJZbijERDLeai4kQApwMdMfMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSvO7JCynpBk82a1s83D6PxeLPo5ds
 Fr8OrWe2mDppM7vF272d7A6sHq8OrGL3OHtnB6PH8RvbmQKYo7hsUlJzMstSi/TtErgyrl3r
 Yino0K14fuYLUwPjEeUuRk4OCQETiW0PdrN0MXJxCAlsZ5TYeOYUE0RCSuLz06lsXYwcQLaw
 xOHDxRA1zxkl5h8/zApSwyagJ/F/0UJmkBoRgSSJE5trQcLMAtoS3Ys6GCHqvzJJbH7ymxWk
 hlPASmLaL04QU1jAReLRpgCQchYBVYkFW7+yg9i8ApYS3x8uYoW4QEHi59NlrBAjRSRmd7ZB
 bYqSeHUyZgKjwCwkmQWMjKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxggNRK2gH47L1f/UO
 MTJxMB5ilOBgVhLhddNMTBfiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQ
 WgSTZeLglGpg2jIp6nPj1a41XtdE5VecD5YUv9WoaiBlceTP7yveZvfFrE6m2V2c9d3R/Jj3
 MrMf9hPnMrq/7Iu6fGw3e//uWW/vu0mL3/+7PKBYIy//zJxZ3wt0rK8ZlERo9774MT112w2r
 hWuEj/6/NKPP6/zLzjcr9zKL8DaIrunqaTi09GlV2dQItcKoX7f3vr6zN884tn2f7AXDu8ZK
 AR7Mda+fmwWn/wh2e2hXo6Qb77TK5NPd+2xJTlrzZFWz2dxOK/Pc1FuqvOCmXIbZtBCHj848
 yjzXHopxHNz3bb7w9JQLaj9V39ccsD+jF5h0LJS9bi7z5o+7Kpgu7JnVY/TT3tnh/LQ3l7Q/
 mmj6cQb0yFjVKLEUZyQaajEXFScCAB+WABuzAgAA
X-CMS-MailID: 20241220020457epcas1p2a014fd54b835a529175a6fdd38e7224d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241218171243epcas1p1071f30015793a4317dfb47c70b99dacf
References: <20241218171236.1022565-1-s-ramamoorthy@ti.com>
 <CGME20241218171243epcas1p1071f30015793a4317dfb47c70b99dacf@epcas1p1.samsung.com>
 <20241218171236.1022565-3-s-ramamoorthy@ti.com>
 <01e401db519e$6d116220$47342660$@samsung.com>
 <0ec29812-b2e7-40de-a55e-c381c62795c2@ti.com>
 <01e601db51a4$3c8f43f0$b5adcbd0$@samsung.com>
 <6a7b88ae-da5a-4430-87a4-84f4005fe183@ti.com>
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



> -----Original Message-----
> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> Sent: Friday, December 20, 2024 2:47 AM
>
> Hi,
>
> On 12/18/24 5:26 PM, Jaehoon Chung wrote:
> >
> >> -----Original Message-----
> >> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> >> Sent: Thursday, December 19, 2024 7:55 AM
> >>
> >> Hi.
> >>
> >>
> >> On 12/18/24 4:44 PM, Jaehoon Chung wrote:
> >>> Hi,
> >>>
> >>>> -----Original Message-----
> >>>> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> >>>> Sent: Thursday, December 19, 2024 2:13 AM
> >>>>
> >>>> Replace magic numbers in buckval2votl() & buckvolt2val() with macros to
> >>>> help with clarity and correlate what the numbers correspond to in the
> >>>> TPS65219 datasheet.
> >>>>
> >>>> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> >>>> ---
> >>>>    drivers/power/regulator/tps65219_regulator.c | 26 ++++++++++----------
> >>>>    include/power/tps65219.h                     | 14 +++++++++--
> >>>>    2 files changed, 25 insertions(+), 15 deletions(-)
> >>>>
> >>>> diff --git a/drivers/power/regulator/tps65219_regulator.c
> >>>> b/drivers/power/regulator/tps65219_regulator.c
> >>>> index 4b0fb205909a..88abc896b3a2 100644
> >>>> --- a/drivers/power/regulator/tps65219_regulator.c
> >>>> +++ b/drivers/power/regulator/tps65219_regulator.c
> >>>> @@ -72,12 +72,12 @@ static int tps65219_buck_enable(struct udevice *dev, int op, bool *enable)
> >>>>
> >>>>    static int tps65219_buck_volt2val(int uV)
> >>>>    {
> >>>> -	if (uV > TPS65219_BUCK_VOLT_MAX)
> >>>> +	if (uV > TPS65219_BUCK_3V4)
> >>>>    		return -EINVAL;
> >>>> -	else if (uV >= 1400000)
> >>>> -		return (uV - 1400000) / 100000 + 0x20;
> >>>> -	else if (uV >= 600000)
> >>>> -		return (uV - 600000) / 25000 + 0x00;
> >>>> +	else if (uV >= TPS65219_BUCK_1V4)
> >>>> +		return (uV - TPS65219_BUCK_1V4) / TPS65219_VOLT_STEP_100MV + TPS65219_BUCK_REG_1V4;
> >>> Even though Not relevant to this subject. If uV is 340000, the return value is correct?
> >>>
> >>> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> >>>
> >>> Best Regards,
> >>> Jaehoon Chung
> >> Thank you for reviewing!
> >> The allowed max uV is 3.4V inclusive.
> >> If 340000 uV is detected, the first 'else if' statement should be taken.
> > Ah, I missed wrong read. Thanks for checking. If you can do, other tpsXXX can also be changed to
> readable macro.
> >
> > Best Regards,
> > Jaehoon Chung
>
> Absolutely, I will make a note to work on this. Besides tps6594, are there any specific tpsXXX drivers
> you had in mind?
> Or work on patches for any TI PMIC tpsXXX U-Boot drivers that include magic numbers?

I didn't check the entire tpsXXX drivers in more detail. But I don't like using magic numbers. :)
It's a difficult to know what purpose its value is.

Best Regards,
Jaehoon Chung

>
> >> Best,
> >> Shree
> >>
> >>>> +	else if (uV >= TPS65219_BUCK_0V6)
> >>>> +		return (uV - TPS65219_BUCK_0V6) / TPS65219_VOLT_STEP_25MV + TPS65219_BUCK_REG_0V6;
> >>>>    	else
> >>>>    		return -EINVAL;
> >>>>    }
> >>>> @@ -86,12 +86,12 @@ static int tps65219_buck_val2volt(int val)
> >>>>    {
> >>>>    	if (val > TPS65219_VOLT_MASK)
> >>>>    		return -EINVAL;
> >>>> -	else if (val > 0x34)
> >>>> -		return TPS65219_BUCK_VOLT_MAX;
> >>>> -	else if (val > 0x20)
> >>>> -		return 1400000 + (val - 0x20) * 100000;
> >>>> -	else if (val >= 0)
> >>>> -		return 600000 + val * 25000;
> >>>> +	else if (val > TPS65219_BUCK_REG_3V4)
> >>>> +		return TPS65219_BUCK_3V4;
> >>>> +	else if (val > TPS65219_BUCK_REG_1V4)
> >>>> +		return TPS65219_BUCK_1V4 + (val - TPS65219_BUCK_REG_1V4) * TPS65219_VOLT_STEP_100MV;
> >>>> +	else if (val >= TPS65219_BUCK_REG_0V6)
> >>>> +		return TPS65219_BUCK_0V6 + val * TPS65219_VOLT_STEP_25MV;
> >>>>    	else
> >>>>    		return -EINVAL;
> >>>>    }
> >>>> @@ -161,7 +161,7 @@ static int tps65219_ldo_volt2val(int idx, int uV)
> >>>>    	if (uV > max)
> >>>>    		return -EINVAL;
> >>>>    	else if (uV >= base)
> >>>> -		return (uV - TPS65219_LDO12_VOLT_MIN) / 50000;
> >>>> +		return (uV - TPS65219_LDO12_VOLT_MIN) / TPS65219_VOLT_STEP_50MV;
> >>>>    	else
> >>>>    		return -EINVAL;
> >>>>    }
> >>>> @@ -187,7 +187,7 @@ static int tps65219_ldo_val2volt(int idx, int val)
> >>>>    	else if (val <= reg_base)
> >>>>    		return base;
> >>>>    	else if (val >= 0)
> >>>> -		return TPS65219_LDO12_VOLT_MIN + (50000 * val);
> >>>> +		return TPS65219_LDO12_VOLT_MIN + (TPS65219_VOLT_STEP_50MV * val);
> >>>>    	else
> >>>>    		return -EINVAL;
> >>>>    }
> >>>> diff --git a/include/power/tps65219.h b/include/power/tps65219.h
> >>>> index aa81b92266fd..e8780af2d811 100644
> >>>> --- a/include/power/tps65219.h
> >>>> +++ b/include/power/tps65219.h
> >>>> @@ -17,10 +17,20 @@
> >>>>    #define TPS65219_BUCK_DRIVER		"tps65219_buck"
> >>>>
> >>>>    #define TPS65219_VOLT_MASK		0x3F
> >>>> -#define TPS65219_BUCK_VOLT_MAX		3400000
> >>>> -
> >>>>    #define TPS65219_ENABLE_CTRL_REG	0x2
> >>>>
> >>>> +#define TPS65219_VOLT_STEP_25MV		25000
> >>>> +#define TPS65219_VOLT_STEP_50MV		50000
> >>>> +#define TPS65219_VOLT_STEP_100MV	100000
> >>>> +
> >>>> +#define TPS65219_BUCK_0V6		600000
> >>>> +#define TPS65219_BUCK_1V4		1400000
> >>>> +#define TPS65219_BUCK_3V4		3400000
> >>>> +
> >>>> +#define TPS65219_BUCK_REG_0V6		0x00
> >>>> +#define TPS65219_BUCK_REG_1V4		0x20
> >>>> +#define TPS65219_BUCK_REG_3V4		0x34
> >>>> +
> >>>>    #define TPS65219_BUCK1_VOUT_REG		0xa
> >>>>    #define TPS65219_BUCK2_VOUT_REG		0x9
> >>>>    #define TPS65219_BUCK3_VOUT_REG		0x8
> >>>> --
> >>>> 2.34.1
> >>>
> >> --
> >> Best,
> >> Shree Ramamoorthy
> >> PMIC Software Engineer
> >
> >


