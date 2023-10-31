Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86716C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0A3087ABF;
	Tue, 31 Oct 2023 07:09:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="h/a5Uz0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D2F587AD7; Tue, 31 Oct 2023 07:09:49 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6AFD87A6E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031060944epoutp02a9c5ebbc719133729f011a5370a75b3d~THEkKfJYi2141921419epoutp02Z
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:09:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031060944epoutp02a9c5ebbc719133729f011a5370a75b3d~THEkKfJYi2141921419epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698732584;
 bh=n6XUE6/tPVq9ZmGzexlm3z5b2H5Sn0R5o04eZZo7VwE=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=h/a5Uz0N8deHRFEuELT9FgNhiaeLJDDNCEZbr9DsDdEsPmWHMObxKEH7qn4cuEM2r
 OnF8tix/+zZ1gf7P+wuwsJbbERmf1bnZQFLPcQAnwaLDYNNR9g/dsOctutUEhUKhMh
 omCuKa/jYwNFK7Sq1dsMf2fasCLrjFOIjTPLMdjQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231031060944epcas1p45c0399a1b40c7fd821348ef92ecab731~THEjxtOrL1693516935epcas1p4j;
 Tue, 31 Oct 2023 06:09:44 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.135]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SKKVH05lpz4x9Pv; Tue, 31 Oct
 2023 06:09:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 53.A7.19104.62A90456; Tue, 31 Oct 2023 15:09:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20231031060942epcas1p1876a7ef8fff3e53885d0d244f5277d7d~THEiPThWA2928529285epcas1p1k;
 Tue, 31 Oct 2023 06:09:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031060942epsmtrp1c9c803a21641de2f948562281e2f4a61~THEiOi7WF2952029520epsmtrp15;
 Tue, 31 Oct 2023 06:09:42 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-3c-65409a269743
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 44.6F.07368.62A90456; Tue, 31 Oct 2023 15:09:42 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231031060941epsmtip2c6984de5ab52cf6bb2f369f9b714b4cb~THEh026Fc1834918349epsmtip27;
 Tue, 31 Oct 2023 06:09:41 +0000 (GMT)
Message-ID: <7c7c903a-df99-4b93-a14f-f1b03d90fcb3@samsung.com>
Date: Tue, 31 Oct 2023 15:09:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: regulator: add AXP313 support
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>, Jagan Teki
 <jagan@amarulasolutions.com>
Cc: Samuel Holland <samuel@sholland.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, SASANO Takayoshi <uaa@mx5.nisiq.net>, Mikhail
 Kalashnikov <iuncuim@gmail.com>, Piotr Oniszczuk
 <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231018155014.383566-4-andre.przywara@arm.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SYUxTVxjNbV/bV7eSt1rjXf9YGyfBrKVPWvZ0whhzWyc4G50LIXPdC30p
 pe1r0xYFZhZAJpNUrKmL0khLMiWojAamQxCYFCJ2iwk2bt1Q1myUCXWAMosTpq7tk41/5/vu
 Ofec734XZQu7uGLUQDsoG02apNxVyLdDGXLZRk8epQh5VESb9zEgRuvdCPGwy8Ul7vo6AHFi
 oJdLnF4aZRN3fz/CJWb6j/CIjhMxXh5f/fWDCEfd7m0H6h7POE99485loJ76pgmoW2+L1LF4
 M9Dwio3bSilSR9kkFF1i0RlofY60YI/2La0qW4HL8C3Ea1IJTZqpHOn2Qo3sHYMpEU0q2U+a
 yhMtDWm3SzNzt9ks5Q5KUmqxO3KklFVnsqqscjtptpfTejlNObbiCsVmVYL4ibH0++EJYHWL
 K24+DCLVIC5qAHwUYkrY0DcIGsAqVIj1AfjH33e4TDEP4Px0DYcpFgBsOXSStSz57WqYxRz0
 A1j3uQthijkAw+1fIUmWAMuF8X++BEmMYK/AyPANDtN/CQaboinOGmwdjIyd4iXxaiwHLvxY
 k8JsbC0ci/oSDigqwj6E0ZAteT8ba2DBn729qRRc7FXYvTCSwvyEtino5zDadbB75jQ7KYDY
 ORTGLsR4TOztcGR2ksvg1TA2cvF5Xwynjx3mMYJDAJ49M8hhCieAT6vDzxVZ8Luz7lQkNpYB
 /b2ZTHs97FlqBoxzGpyNOzlJCsQE8IvDQoayAYbuTbOWvcajzzgMVsPFIT/PBdZ7VryLZ8X8
 nhXzeP43bgHIeSCmrHaznirBrbiMpg78t/MSi7kLpD7vpsLL4JH/iTwAWCgIAIiypSLBkCqP
 Egp0ZGUVZbNobeUmyh4AqsSGjrPFa0osid9PO7S4cotCmb05S0ng2bh0reCj+XqdENOTDspI
 UVbKtqxjoXxxNav+jWyebyp3h8Ww834ktB8RYZ9NlWnzzlBI5Xhr1d5rde89/ljO3xo6OdcT
 1Do7DvZPjN12PSu89T6t+cs566eRXdHrL7x+1F2kOi47eLFotPESZuLUamtRe7qkRnagyB3o
 DFdK6hq5tcCwa6d2okJ5b/xC/t6fWu4vvLg0UFz8Q9g1WTeQZva1jexefNuYFc71dlS0aU0Z
 lXyI/VqIvmv8pXXxZifXfS1DsCOU352vT+8DeLO3xq0Zmhl+UHCJzalytp16NO2//vSY21c/
 FzeXTQTpc/7Y+cmjaV37iq6apnxPCrDAy+mRN6+4N5QhjbcGP933Ad5p2lh1JfNPKWIvJfFN
 bJud/Bexyk7cRQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJXldtlkOqwedlAhYr5v1ktLjQPpnF
 4sumCWwWz+evY7SYsm8Xm8Wc3xeYLZ4/6mSzeLu3k91i3ZRX7A6cHms/3mf1WDNvDaPHzll3
 2T3O3tnB6PFi80xGj2W3RTxefZ3LGMAexWWTkpqTWZZapG+XwJVx6shjxoLJUhUXv5xkaWD8
 KtLFyMkhIWAi8fDAdaYuRi4OIYHdjBLLjvxjgUhISXx+OpWti5EDyBaWOHy4GKLmLaPEwl03
 2UBqeAXsJL7+mcoIYrMIqErcP3KWFSIuKHFy5hOwOaIC8hL3b81gB7GFBWwlvl1tBLOZBcQl
 bj2ZzwRiiwiESUyeNIkFIt7FJHFxrR6ILSSQL/Hyz22wGjYBHYnt346D2ZxAc2aeXM8Kchuz
 gLrE+nlCEK3yEtvfzmGewCg0C8kVs5Bsm4XQMQtJxwJGllWMkqkFxbnpucmGBYZ5qeV6xYm5
 xaV56XrJ+bmbGMGRpaWxg/He/H96hxiZOBgPMUpwMCuJ8B42dUgV4k1JrKxKLcqPLyrNSS0+
 xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJg1OqgWnuH+amkmddjUbJmxTrbjY4FWguEjn0
 5p46y4Enn53iBesFX8crcx6Qc9JiUHfdYHL+w4oP4ebrP/x3UFXXLdKbfKhc/ZhY5zmhaNF3
 79dVeQdoL7TkPPaqlyG7sOfbdJ05t3sFPLg2MYXynzv1KlbBkLFHvf0Qw2q2ymuMT5XrBMW9
 FT4FWMsdlUu6w3etdeKxp8qGSvusFafuOlhzkH2vbA7HpFCL8868y2/3Kd0x8X3r+N7E02ha
 ySzNeB6/X0s1tNZMW/Z0SWNz61vei1vXd2kzZppv/f5c6Xtz4Lp9vV0/NziV2ITWu/5eu0NW
 /dtJ3lVHrcxj/nCt9n85c9ZuCeH6h4XneXLqzxW2KrEUZyQaajEXFScCAJreXBkbAwAA
X-CMS-MailID: 20231031060942epcas1p1876a7ef8fff3e53885d0d244f5277d7d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031060942epcas1p1876a7ef8fff3e53885d0d244f5277d7d
References: <20231018155014.383566-1-andre.przywara@arm.com>
 <20231018155014.383566-4-andre.przywara@arm.com>
 <CGME20231031060942epcas1p1876a7ef8fff3e53885d0d244f5277d7d@epcas1p1.samsung.com>
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

On 10/19/23 00:50, Andre Przywara wrote:
> The X-Powers AXP313a is a small PMIC with just three buck converters and
> three LDOs, one of which is actually fixed (so not modelled here).
> 
> Add the compatible string and the respective regulator ranges to allow
> drivers to adjust voltages.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/power/pmic/axp.c                |  1 +
>  drivers/power/regulator/axp_regulator.c | 17 +++++++++++++++++
>  include/axp_pmic.h                      |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/power/pmic/axp.c b/drivers/power/pmic/axp.c
> index 025dac24f28..0e1e45fba74 100644
> --- a/drivers/power/pmic/axp.c
> +++ b/drivers/power/pmic/axp.c
> @@ -87,6 +87,7 @@ static const struct udevice_id axp_pmic_ids[] = {
>  	{ .compatible = "x-powers,axp209", .data = AXP209_ID },
>  	{ .compatible = "x-powers,axp221", .data = AXP221_ID },
>  	{ .compatible = "x-powers,axp223", .data = AXP223_ID },
> +	{ .compatible = "x-powers,axp313a", .data = AXP313_ID },
>  	{ .compatible = "x-powers,axp803", .data = AXP803_ID },
>  	{ .compatible = "x-powers,axp806", .data = AXP806_ID },
>  	{ .compatible = "x-powers,axp809", .data = AXP809_ID },
> diff --git a/drivers/power/regulator/axp_regulator.c b/drivers/power/regulator/axp_regulator.c
> index 02f320eac1e..d27e09538e0 100644
> --- a/drivers/power/regulator/axp_regulator.c
> +++ b/drivers/power/regulator/axp_regulator.c
> @@ -173,6 +173,22 @@ static const struct axp_regulator_plat axp22x_regulators[] = {
>  	{ }
>  };
>  
> +/*
> + * The "dcdc1" regulator has another range, beyond 1.54V up to 3.4V, in
> + * steps of 100mV. We cannot model this easily, but also don't need that,
> + * since it's typically only used for ~1.1V anyway, so just ignore it.
> + * Also the DCDC3 regulator is described wrongly in the (available) manual,
> + * experiments show that the split point is at 1200mV, as for DCDC1/2.
> + */
> +static const struct axp_regulator_plat axp313_regulators[] = {
> +	{ "dcdc1", 0x10, BIT(0), 0x13, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc2", 0x10, BIT(1), 0x14, 0x7f,  500, 1540,  10, 70 },
> +	{ "dcdc3", 0x10, BIT(2), 0x15, 0x7f,  500, 1840,  10, 70 },
> +	{ "aldo1", 0x10, BIT(3), 0x16, 0x1f,  500, 3500, 100, NA },
> +	{ "dldo1", 0x10, BIT(4), 0x17, 0x1f,  500, 3500, 100, NA },
> +	{ }
> +};
> +
>  static const struct axp_regulator_plat axp803_regulators[] = {
>  	{ "dcdc1", 0x10, BIT(0), 0x20, 0x1f, 1600, 3400, 100, NA },
>  	{ "dcdc2", 0x10, BIT(1), 0x21, 0x7f,  500, 1300,  10, 70 },
> @@ -274,6 +290,7 @@ static const struct axp_regulator_plat *const axp_regulators[] = {
>  	[AXP209_ID]	= axp20x_regulators,
>  	[AXP221_ID]	= axp22x_regulators,
>  	[AXP223_ID]	= axp22x_regulators,
> +	[AXP313_ID]	= axp313_regulators,
>  	[AXP803_ID]	= axp803_regulators,
>  	[AXP806_ID]	= axp806_regulators,
>  	[AXP809_ID]	= axp809_regulators,
> diff --git a/include/axp_pmic.h b/include/axp_pmic.h
> index 4ac64865831..aabafc8501b 100644
> --- a/include/axp_pmic.h
> +++ b/include/axp_pmic.h
> @@ -32,6 +32,7 @@ enum {
>  	AXP209_ID,
>  	AXP221_ID,
>  	AXP223_ID,
> +	AXP313_ID,
>  	AXP803_ID,
>  	AXP806_ID,
>  	AXP809_ID,

