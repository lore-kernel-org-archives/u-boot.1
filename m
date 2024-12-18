Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A838E77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 23:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A211680295;
	Thu, 19 Dec 2024 00:26:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="JiwpjrRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8919080295; Thu, 19 Dec 2024 00:26:31 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D738021D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 00:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20241218232618epoutp03656fb97fff05b6e23ce7ea2577a97513~SaRzEepqz2648826488epoutp032
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 23:26:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20241218232618epoutp03656fb97fff05b6e23ce7ea2577a97513~SaRzEepqz2648826488epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1734564378;
 bh=wDHhPZZEGRvymw17A6hMIrT+lpV5yD09l61xwFr/oo0=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=JiwpjrRwUsXBDMeddjHpU/OM5CFrHESy9ZyMtYcKgv9YVrK0Rsp48WOho6W9pbdo5
 /UzJnrwJ+r6ANaSYpx3/Qvkg+T2v79YtNjutrmi1vK1yuvAxcIK8xMK2nsXAeGJ55n
 WAKAhr+AEBuwh934J32xXCvbN6sCki9wkKYZvVAQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20241218232618epcas1p36cb7fd7325d911556f3d1be306734bcb~SaRy1UJgT2301123011epcas1p3z;
 Wed, 18 Dec 2024 23:26:18 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4YD8vF3zvgz4x9Q4; Wed, 18 Dec
 2024 23:26:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 26.81.23425.91A53676; Thu, 19 Dec 2024 08:26:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20241218232617epcas1p446f580bee6bcec5d149383f140f16721~SaRxtLpUG2715327153epcas1p4z;
 Wed, 18 Dec 2024 23:26:17 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20241218232617epsmtrp11dac6ae27cfe6ad08386a0f723ee1db3~SaRxsepzd2851128511epsmtrp1a;
 Wed, 18 Dec 2024 23:26:17 +0000 (GMT)
X-AuditID: b6c32a39-564a824000005b81-23-67635a191e19
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 30.0A.33707.91A53676; Thu, 19 Dec 2024 08:26:17 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20241218232617epsmtip2a8237d1d35ab0eba2de019eeb285d551~SaRxh2ldw1475014750epsmtip2O;
 Wed, 18 Dec 2024 23:26:17 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Shree Ramamoorthy'" <s-ramamoorthy@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
Cc: <m-leonard@ti.com>, <praneeth@ti.com>
In-Reply-To: <0ec29812-b2e7-40de-a55e-c381c62795c2@ti.com>
Subject: RE: [PATCH v1 2/2] power: replace magic numbers with macros
Date: Thu, 19 Dec 2024 08:26:16 +0900
Message-ID: <01e601db51a4$3c8f43f0$b5adcbd0$@samsung.com>
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQDJjZr8Ya4lM0w/UNXlTz8OpdnKCAFA/cSAAi20pJYCf7MVSwKE0otwtMySunA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmnq5kVHK6wbd98hYPt89jsfjz6CWb
 xa9D65ktpk7azG7xdm8nuwOrx6sDq9g9zt7Zwehx/MZ2pgDmqGybjNTElNQihdS85PyUzLx0
 WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKCdSgpliTmlQKGAxOJiJX07m6L80pJU
 hYz84hJbpdSClJwC0wK94sTc4tK8dL281BIrQwMDI1OgwoTsjC37PrMUfFetWHLjEWsD41PZ
 LkYODgkBE4lNbSZdjJwcQgI7GCW27Q/uYuQCsj8xStxsn8QM5xz4dJYFpAqk4ey3R4wQiZ2M
 Euuvv2KBcF4ySuyf/40JpIpNQE/i/6KFzCC2iECCxJ9Nt8HizAKaEnu2b2QBWc0pYCWxdYMF
 iCks4CLxaFMASAWLgKrEhD/XGUFsXgFLieOLX7BB7FWQ+Pl0GSvEFBGJ2Z1tUNP9JGbcPwV2
 j4TAMXaJ6Xd6oQ51kfh1exEjhC0s8er4FnYIW0riZX8bO0RDM6PE0iUHWSGcHkaJfw3XodYZ
 S+xfOpkJ5DqQo9fv0ofYzCfx7msPKyToeCU62oQgqlUkLr1+yQQz/+6T/6wQtofE2c7V0PBZ
 yCTxYdkm1gmM8rOQPDELYcMCRqZVjGKpBcW56anFhgWm8IhMzs/dxAhOalqWOxinv/2gd4iR
 iYPxEKMEB7OSCK+bZmK6EG9KYmVValF+fFFpTmrxIUZTYFBOZJYSTc4HptW8knhDE0sDEzMj
 YxMLQzNDJXHeM1fKUoUE0hNLUrNTUwtSi2D6mDg4pRqYNr7pSE1h63zKw8HvyH0z0ufkVK3p
 wtIZDgZz3LZu/JmU0JF44UWq5KI/K24oxGvcX8U1d/bF7dJ/5KbXME6+fiXy+vyHngIXDi3i
 W1+3qSlzCdfVYtcdIrfOtDlJvzkxVeluMNtJmZQQSxaFTvn5/605pp49EFpw6P/hTx/La5+x
 mTsoJDpKBlRM6V6ZNl13SsGu2bIl137kTs0Lnhtx9JyBwcemn5btAfPmOXEtW8dnso97wqPZ
 fML3/N7KHqvibhDuSp/Eys3e8uK0/a3pp8Mf3JSsCzRfeePhj7NCZXc2iJubzYl2fX7whUbG
 3GCd1ZPOWVss+//3hZKgGH/PetbHJ2LX+Vf/uxorOLvbXYmlOCPRUIu5qDgRACcxAIvzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWy7bCSvK5kVHK6wYztvBYPt89jsfjz6CWb
 xa9D65ktpk7azG7xdm8nuwOrx6sDq9g9zt7Zwehx/MZ2pgDmKC6blNSczLLUIn27BK6MLfs+
 sxR8V61YcuMRawPjU9kuRk4OCQETibPfHjF2MXJxCAlsZ5SYvek2C0RCSuLz06lsXYwcQLaw
 xOHDxRA1zxkl/u+awQ5SwyagJ/F/0UJmkBoRgSSJE5trQcLMAtoS3Ys6oGbOZJKY3b+HFaSG
 U8BKYusGCxBTWMBF4tGmAJByFgFViQl/rjOC2LwClhLHF79gg7hAQeLn02WsECNFJGZ3tjGD
 2CICfhIz7p9inMAoMAtJagEj4ypG0dSC4tz03OQCQ73ixNzi0rx0veT83E2M4FDUCtrBuGz9
 X71DjEwcjIcYJTiYlUR43TQT04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzKud0pggJpCeWpGan
 phakFsFkmTg4pRqYmEOefyu622vpvdwvVEY2/ZKA3o6Tt2fsm7L7oO8eCf9te+/33va8EHRY
 Lvtkz9Ev246khfMsLr7yyDxZI75bz0embEOFYVEab+qKbSfKueXC11pcTDd7cXzS54p8jdm2
 C+f03btherHiafefzwskrz1znbY57KzMTrfPx8yWX5YPmCTwfMHrWdIf9/UnPzxvPfPgbK8/
 vAHcyjoBCZETM2N7D3OZcZpO5MrY/oX12gzVZxuuTVi0Jf1h8lX9Nuc509iXH961yNZfVObs
 tp0J/savpRfvm9J8PFKh5tmJBvGymQ+fsKhKVinwxbfHTVm+srIj9DJ7u0Loloq+f2vFvX4x
 m185Ms/Z45X+0tVNV5VYijMSDbWYi4oTAdm/3i+0AgAA
X-CMS-MailID: 20241218232617epcas1p446f580bee6bcec5d149383f140f16721
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
> Sent: Thursday, December 19, 2024 7:55 AM
>
> Hi.
>
>
> On 12/18/24 4:44 PM, Jaehoon Chung wrote:
> > Hi,
> >
> >> -----Original Message-----
> >> From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> >> Sent: Thursday, December 19, 2024 2:13 AM
> >>
> >> Replace magic numbers in buckval2votl() & buckvolt2val() with macros to
> >> help with clarity and correlate what the numbers correspond to in the
> >> TPS65219 datasheet.
> >>
> >> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> >> ---
> >>   drivers/power/regulator/tps65219_regulator.c | 26 ++++++++++----------
> >>   include/power/tps65219.h                     | 14 +++++++++--
> >>   2 files changed, 25 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/power/regulator/tps65219_regulator.c
> >> b/drivers/power/regulator/tps65219_regulator.c
> >> index 4b0fb205909a..88abc896b3a2 100644
> >> --- a/drivers/power/regulator/tps65219_regulator.c
> >> +++ b/drivers/power/regulator/tps65219_regulator.c
> >> @@ -72,12 +72,12 @@ static int tps65219_buck_enable(struct udevice *dev, int op, bool *enable)
> >>
> >>   static int tps65219_buck_volt2val(int uV)
> >>   {
> >> -	if (uV > TPS65219_BUCK_VOLT_MAX)
> >> +	if (uV > TPS65219_BUCK_3V4)
> >>   		return -EINVAL;
> >> -	else if (uV >= 1400000)
> >> -		return (uV - 1400000) / 100000 + 0x20;
> >> -	else if (uV >= 600000)
> >> -		return (uV - 600000) / 25000 + 0x00;
> >> +	else if (uV >= TPS65219_BUCK_1V4)
> >> +		return (uV - TPS65219_BUCK_1V4) / TPS65219_VOLT_STEP_100MV + TPS65219_BUCK_REG_1V4;
> > Even though Not relevant to this subject. If uV is 340000, the return value is correct?
> >
> > Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> >
> > Best Regards,
> > Jaehoon Chung
>
> Thank you for reviewing!
> The allowed max uV is 3.4V inclusive.
> If 340000 uV is detected, the first 'else if' statement should be taken.

Ah, I missed wrong read. Thanks for checking. If you can do, other tpsXXX can also be changed to readable macro.

Best Regards,
Jaehoon Chung

>
> Best,
> Shree
>
> >> +	else if (uV >= TPS65219_BUCK_0V6)
> >> +		return (uV - TPS65219_BUCK_0V6) / TPS65219_VOLT_STEP_25MV + TPS65219_BUCK_REG_0V6;
> >>   	else
> >>   		return -EINVAL;
> >>   }
> >> @@ -86,12 +86,12 @@ static int tps65219_buck_val2volt(int val)
> >>   {
> >>   	if (val > TPS65219_VOLT_MASK)
> >>   		return -EINVAL;
> >> -	else if (val > 0x34)
> >> -		return TPS65219_BUCK_VOLT_MAX;
> >> -	else if (val > 0x20)
> >> -		return 1400000 + (val - 0x20) * 100000;
> >> -	else if (val >= 0)
> >> -		return 600000 + val * 25000;
> >> +	else if (val > TPS65219_BUCK_REG_3V4)
> >> +		return TPS65219_BUCK_3V4;
> >> +	else if (val > TPS65219_BUCK_REG_1V4)
> >> +		return TPS65219_BUCK_1V4 + (val - TPS65219_BUCK_REG_1V4) * TPS65219_VOLT_STEP_100MV;
> >> +	else if (val >= TPS65219_BUCK_REG_0V6)
> >> +		return TPS65219_BUCK_0V6 + val * TPS65219_VOLT_STEP_25MV;
> >>   	else
> >>   		return -EINVAL;
> >>   }
> >> @@ -161,7 +161,7 @@ static int tps65219_ldo_volt2val(int idx, int uV)
> >>   	if (uV > max)
> >>   		return -EINVAL;
> >>   	else if (uV >= base)
> >> -		return (uV - TPS65219_LDO12_VOLT_MIN) / 50000;
> >> +		return (uV - TPS65219_LDO12_VOLT_MIN) / TPS65219_VOLT_STEP_50MV;
> >>   	else
> >>   		return -EINVAL;
> >>   }
> >> @@ -187,7 +187,7 @@ static int tps65219_ldo_val2volt(int idx, int val)
> >>   	else if (val <= reg_base)
> >>   		return base;
> >>   	else if (val >= 0)
> >> -		return TPS65219_LDO12_VOLT_MIN + (50000 * val);
> >> +		return TPS65219_LDO12_VOLT_MIN + (TPS65219_VOLT_STEP_50MV * val);
> >>   	else
> >>   		return -EINVAL;
> >>   }
> >> diff --git a/include/power/tps65219.h b/include/power/tps65219.h
> >> index aa81b92266fd..e8780af2d811 100644
> >> --- a/include/power/tps65219.h
> >> +++ b/include/power/tps65219.h
> >> @@ -17,10 +17,20 @@
> >>   #define TPS65219_BUCK_DRIVER		"tps65219_buck"
> >>
> >>   #define TPS65219_VOLT_MASK		0x3F
> >> -#define TPS65219_BUCK_VOLT_MAX		3400000
> >> -
> >>   #define TPS65219_ENABLE_CTRL_REG	0x2
> >>
> >> +#define TPS65219_VOLT_STEP_25MV		25000
> >> +#define TPS65219_VOLT_STEP_50MV		50000
> >> +#define TPS65219_VOLT_STEP_100MV	100000
> >> +
> >> +#define TPS65219_BUCK_0V6		600000
> >> +#define TPS65219_BUCK_1V4		1400000
> >> +#define TPS65219_BUCK_3V4		3400000
> >> +
> >> +#define TPS65219_BUCK_REG_0V6		0x00
> >> +#define TPS65219_BUCK_REG_1V4		0x20
> >> +#define TPS65219_BUCK_REG_3V4		0x34
> >> +
> >>   #define TPS65219_BUCK1_VOUT_REG		0xa
> >>   #define TPS65219_BUCK2_VOUT_REG		0x9
> >>   #define TPS65219_BUCK3_VOUT_REG		0x8
> >> --
> >> 2.34.1
> >
> >
>
> --
> Best,
> Shree Ramamoorthy
> PMIC Software Engineer



