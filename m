Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDF4CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 08:59:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D844B84897;
	Wed,  6 May 2026 10:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Rmi+EZEr";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Rmi+EZEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A83A08488B; Wed,  6 May 2026 10:59:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C16F98484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 10:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ubXW83Zm/r4ouwjg+gX7x3iqEs3fyZYkkEd8nBlytowovfWfIQDZiB7iifuaQYhUPsc/PPNI9HmpdSO+3cWkzpkP0CW4IUHYmWVAg9AQIidnFzGxyX6OLZKUeCKNMn0PpMLqRtEeYYhd2HwWSje/7JigL9iXMNurv2kTAHEJf2PA7F7TDOTw4J03e5dyi65ogsbHouW4Baz15+d710Rn/UA2jXTLUyu3f4qovVpyWW+zqYSq+SE2nma+MZAZp0ZJOGgIWeLwKpontZ2b96GqKPaSOrW5xLFnCTOadT8FvtGbYkg6bbDHuXdC8gYrycLWoeApmBYW76SeKBnYBM6oPw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhWdIjCBQwkdzIaMcxQHrpYJDUgqGzMLABNRtNQPAec=;
 b=MOSQaGE2WA8VBUDVyaRd9mqzsN5ypM3N8VZfx8QQZoL0n77UjeBmACQkMGMPaJ+mp+BV+ghsf24aVpQu9VTcdfE6ZDniRP3r46rF7HF0mx2GNykvyZ+Rdaqe8nGSWRNk/0ZSdu4VzUl4ICXP8v92m6E8q2zYLoNp1AfrCnYlO5MfHU2CxgtE6vSLSlNgzvSJy/r2obbcJD2OBtrdt4kOs4TKOQML/5arB9Lgvb1jVVAIF96o3EMnxGkGVjhgKofUygkfee0cd+w2vCvXNRaDMba3PHJfOLrjAi7W6ZUqaZYmqx4gG5FZtEhTcc8Jvsby4rzIRSS+nWddVcPkWdalww==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=prevas.dk smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhWdIjCBQwkdzIaMcxQHrpYJDUgqGzMLABNRtNQPAec=;
 b=Rmi+EZEryEJ98VMcMZEo03LNRLw+d1su/+esAyVXHDUtlu1IBtMEVTEgEgtVGI5qVkIZsyetGDQfT53zKtMe7yObGPm2D8+58fwMYbXi08jAMJ7ikgv/AnzcYDgqVG3z3Mi3XdDGBoWQ89VAcL4luW4evh2WpnlYNRF8FpnRI30=
Received: from AS4P195CA0024.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::11)
 by GVXPR08MB10728.eurprd08.prod.outlook.com (2603:10a6:150:15b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 08:59:50 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d6:cafe::ce) by AS4P195CA0024.outlook.office365.com
 (2603:10a6:20b:5d6::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 08:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.9
 via Frontend Transport; Wed, 6 May 2026 08:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb7X7klCV4MxrZa6fdSRtB2eRIU5I7rbCep27bPwCfAKsqficO9rg4L+TGN2/rh3F2bcCJCs6MOcYbYughPnKafI34qnlkPu3mVXaCCaR7FEy8WesFcLbuZl9eOD35Q8N4BgVIUDFYJw/8DjBRT9D040hZq64XWHsczeS04IOjobXw2T2HppNZVLOJyWxx1Zy7V5QyF5JHQ5kbUDv6E8yfyg/s4ZnOUqRMaCUWyfMlPcJAFVkwJ9rBc4T0hoBVfYPFSUE6yZhVcJwdRBMTiOl9mFGcHsIosSBiI3Bv+arzlEYlPsy1E6+/oAHHIqrVxk3U14p8PhqMAtZjOJJlCNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhWdIjCBQwkdzIaMcxQHrpYJDUgqGzMLABNRtNQPAec=;
 b=TuvTffUzVI1yfSlwtxwUs4w++Q8EUG11RaU1VcKS+LlE4Af6h1UBLiyCsb6E5Q7uSn9VaZGNwmLdxDKiKt33X549s6UwCdpJnDX8drULuthOeYlDZd8VTens7b5oDzhEqPhfAStZp9BA/Hs8hgm8OTxZo0pX4sVUxBVPVDCYgfswAfiLFS6jQTIcJRdDQ7opzELEXtdE4wkH3fGQU4GohWb80HDSn5FQV/YnvrVb4P5JqHluB4p+Jx9vuRFwiNYpKOAwny78H9/efc9t8cfL36wsKE0g3lQMZ1Kg2An69FQ1cy+XqK+Kr0sA/Rxx9w1lwEAGMU22q71S+VLFmzz2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhWdIjCBQwkdzIaMcxQHrpYJDUgqGzMLABNRtNQPAec=;
 b=Rmi+EZEryEJ98VMcMZEo03LNRLw+d1su/+esAyVXHDUtlu1IBtMEVTEgEgtVGI5qVkIZsyetGDQfT53zKtMe7yObGPm2D8+58fwMYbXi08jAMJ7ikgv/AnzcYDgqVG3z3Mi3XdDGBoWQ89VAcL4luW4evh2WpnlYNRF8FpnRI30=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB5PR08MB10048.eurprd08.prod.outlook.com
 (2603:10a6:10:48e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 08:58:41 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 08:58:41 +0000
Message-ID: <e9a77281-ef30-4406-9ff9-5e59193b0afd@arm.com>
Date: Wed, 6 May 2026 10:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: adin: add support for the ADIN1200 phy
To: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260428111532.1311239-1-ravi@prevas.dk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260428111532.1311239-1-ravi@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0135.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36e::6) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB5PR08MB10048:EE_|AM2PEPF0001C717:EE_|GVXPR08MB10728:EE_
X-MS-Office365-Filtering-Correlation-Id: 409259bf-35ec-4b1e-679d-08deab4dd4ef
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: nJ2o1xQcFtkLb1BMXkc5sElnweioQ/0C9RlPrfMRtPnkUokc3MMFwVZQysi1sB9OmZV18vPqJLfPDYOCFopAxeaLfSrSVSTaH4wLjXUMV0OUh3FkKd52eob1QGA/hrAxRPBwGvEYBKGVSUw0MEQHYWkReJcrK+zMD+VN7bHwRidvWww9OSfJrLa2gANIHDGLbpMEZujoF3q1TSpnKSz0eOL/pMp7/8L4IEIOFWNRvbemA31ngTFGPFmgPsNThJh59TN0ov62558diOAe/vfMQKtwAF3Xv7DGyHMvO1UJ7ckHKhcFeGlJ12W9PgXCkmrBWR+ALJC2dpzo5Tm3+RtBQvWHo5/gPzPObQ7zBb6TrPYqlmqDeMNreGIZ3f1Bxg3wAk8c6BeuHEDJIsYKsSt4EIyK3Urtzkqg9ITpKb/J5KhFH2fI3TiY4KIY2VSmAwwEiJte6DLXOaDtr36IUGLx1D+iyj8HL7v+Dy0QVP2l18tYOzDmgD/B85VzzejF4URWa4mb2OGfVm7h7cWMcKY5L6Krwc52ebgGeRqK7VgH8DLtZYzydvQix3Vem9SitqtVvCXzQPa2pAD3KF2ayHsI+4BiHgth+eZMJyRWWNOuIzDgrqG7VY6+PQrAbRGvkIMdEr8i2X2mIHKw/1+FU6iJgOcEodA4Q7H3zy3A8iKhdHW7ftj3Mq2NzurvsMnOEAWl
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: O95GXjXAEAqoVR9gLkoumE4qByfQb+p1JDLTjpicuF8GG4zqr6mE5LLlTB00ercp8kV0d7oe7Z8BLw6YGtYp3MirN7xgXzyRWpTOtnBozSSIqlaH4eqWq0kPnmng2oo6jJZ1m86jQoZTGncVoOP1VU5koZpwO8hh0uzN0/kLbe1Z/rR1KHMtoNxnry2vxfwSbyYUbwXjNjgMlz/X0LLMhJCDdMHk7VB2BGi9VsOi0+9IHoiEh7MJUbmC44Y9yfyxqO5Fno71yGNP1H/OqshTM6O8m650LCUVad++1IxAE7gmc3ZUV6JjYUZu4jC4qEGpCOF6PILqPr3yJg3oqNLiMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10048
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9f364f04-f8ef-4378-f44d-08deab4dabd0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|36860700016|1800799024|35042699022|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vvuUTWrjTsMmtk8sxGAKUr+7vEBvFeWbhtoRXpidmnO9X8jdvGL/H+F7iY13QeHKV8kmmOssauZeuGuAzcBmL8nBZpvBMFuKvmeC/Lngmzbxf6wwzvFLI/Fa6djHWlE0APhasEJmur+jD7WE7vpJrjzuCu7vpG2/Tt9EdMH+l4V7FdDmivPJlyXYKFIz49As0XGUpfE0lXOYloDzSgFrZt4bVdInDvTnnbZKhZwKb3hwaCUznCY2YHhrgcXynpfJ8TORFs98ln5qiOsSDap+Fo6faFhRRZ5KgxWzgR/RSATtR+Lgs1iHuXVDcn202LaITGlhqLWImsaeXuYDVYuBQ0RmC647LDglLrepayzAfV3zqu8P07AI9mzWHvW8f3+F2oufsjiF4Gu63LaLzV0nGKY4xPrTMqXQGTH13xpuwS58sBAiZQEMvV5cX+1rtyWM9oK5O9SzE/4Ab2/r4zn+BwMEqW0ceMiJdJH3380tYJDRCI1SDTMAC1j2/fr8MxWei9jbzgGClhb/z40qcm3yaQ+OTQwfgv9Qe+9ZBK0QK/G/iCZVEf8sJaLeCu+EUrfU+VqwFzSlmNBAHtBG+YwrVJNMorAqbrBz4lNLMR/X6Wh+2B4JSe9/OtK5bO2kCALvEZpSUa7gkog3oYsNRjpgF2svI8ds2xZU4ZzHMkrYiKufd9QOFtNpnoqp9tcEVT000bfS6qttZAfbyFhq6GagH+8IBx+FiMtyJqR2cIx4QGE=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(36860700016)(1800799024)(35042699022)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HDJ+XEdw0YyMMW5uPeDlvaUh2H0B57y1PsdiFmemzGze1xt1hyUbS1MvrzCkHZ72q5rJZoUgyVqmvzBT57Qmrwhx4b+lwnqREU5a25MVUr2Pu9E3raUCd54HOHcWyhCPBr++mJ5FUcPH9r4imGuFxZKlUoSMQMM6FkEpFsbxIquJ5/3+NQpoaBQ/QT1ZJkb/j/aFPoYEOVM9E5SKUreN8iY/FePZBeAjYHzwcaU7tn84Fw6sos3sPjA9UvO0ghCWeDlda0O/XqEGqrEhG/H/QsJ/hY8uhWeGhaNo/pLqMkoR3WA2tRmo0fvrjwqsMUKBcgeD60nDQW0FT/xDmyNs3YTNZeEhQb2buA8BQPuOgQPVA04W2F73gi+J9dRleVTd4dkeXiRmtNkyMRqhb+rDYNtyod4QM4/XHjEJQGFou2TktA/f4QkGWbmNoBmFWJJH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 08:59:50.5568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409259bf-35ec-4b1e-679d-08deab4dd4ef
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10728
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



On 28/04/2026 13:15, Rasmus Villemoes wrote:
> The ADIN1200 chip is register compatible with the ADIN1300, but only
> supports 10/100 Mbit.
> 
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/net/phy/adin.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index ce448810ff6..4d42e56dada 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -10,6 +10,7 @@
>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
>  
> +#define PHY_ID_ADIN1200				0x0283bc20
>  #define PHY_ID_ADIN1300				0x0283bc30
>  #define ADIN1300_EXT_REG_PTR			0x10
>  #define ADIN1300_EXT_REG_DATA			0x11
> @@ -263,6 +264,18 @@ static int adin1300_config(struct phy_device *phydev)
>  	return genphy_config(phydev);
>  }
>  
> +U_BOOT_PHY_DRIVER(ADIN1200) = {
> +	.name = "ADIN1200",
> +	.uid = PHY_ID_ADIN1200,
> +	.mask = 0xffffffff,
> +	.features = PHY_BASIC_FEATURES,
> +	.config = adin1300_config,
> +	.startup = genphy_startup,
> +	.shutdown = genphy_shutdown,
> +	.readext = adin_extread,
> +	.writeext = adin_extwrite,
> +};
> +
>  U_BOOT_PHY_DRIVER(ADIN1300) = {
>  	.name = "ADIN1300",
>  	.uid = PHY_ID_ADIN1300,

Added to the net queue, thanks!

-- 
Jerome
