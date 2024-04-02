Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA32FCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 15:40:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38E1A87F19;
	Tue,  2 Apr 2024 17:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="O2i8hrOA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="NICnx5pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA61A87E78; Tue,  2 Apr 2024 17:39:59 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6DFB87F19
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 17:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=oQfAel82xqcaJ20aAiozGvU00uXqdgyXO24ZCfm+a2YYaoddYUih8oEQg8sTjJWLu9FKhmtHy/lNeD2YI+8qZwklUVleBJzSAddFP+X63hCqCum9MJ9YbLKkvC8krfL/BkLzU9F884/eFAX9DsgnhwqNCmzzdCRPdN3gjNiyy7/kkQ4IVyrXkRfTlWgQYkk7e+u7u9XQwKDfap2+Kzez/MjvHF5Jb6eR9RbXzvfaua2nLxWiuX89kCuD+exP5cGfVHG/tu2zJq6+fZi6V812XjXeLFMEY275F/EbtrfNOtPPqZsUiW46IU8RKIbcwg6IfWRKAKcK/abvjk++o4HGGg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2dgAycG+8ysCPXa+A4Evqftd8uPbiz25ZKluFG1An8=;
 b=V6JJJRXYXevXsvfatckXdt+xHjT+dKXI/UzeeaULhE9jjgENkied9oDML7V85bsVEuVaFwFgNA8mINaRk5bng2BU+Dr4F4hUmFoRqijQEj2/4s8ap7LobefmFnNG5+3tOCAZvBSL4/biz8NwmixMyBT6SePhycv00MSE3lkJQRNEm9V8WpNzljehQBeCN0QX4BkPjGCJcFYPZsrZt3IFYyo0ZOzARgSZ6KNl8goFDtp2Vaqr5kzLH5iEAWRXt+RbJM4EOmJf9MGpeYLtlCViczn8nmNFSim4jOpqTjWsDkMW0HuTrYNThSekytH9i5NMsn9uW2RvVKgW2HFD2Q2CHA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2dgAycG+8ysCPXa+A4Evqftd8uPbiz25ZKluFG1An8=;
 b=O2i8hrOASSmsC/merevJYWISdOjSsDmL3ZEcBArAuOBRJyM9Rm5lTORHkyYJKTr+TtOXJdZq4K+sxUHL3qPsqkGhwg2Sd/e331aBeRyn6vYtY1rHEfmlcL5OciTFu0LKaWUUcB74+UsjLF1Wd6D8j7Ct7uK4OHzWg7lfVa5AFijhFWkgW4pyvaCLV/2PDJ9z6yLwBH7ihVfdaE60JMJ8Hcm4MIFIGU8FVANPSsoj6kppVqtv92FjULMnwJ+J15lQBg0GzyPMrywVSOAHPSDAaJ9juOSGlk94PYJ+azb8A7JF1TU2FYpKYyAXaLja4In+h11JSMB+0loHxEHNaT9bKg==
Received: from DUZPR01CA0271.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::27) by DB8PR03MB6252.eurprd03.prod.outlook.com
 (2603:10a6:10:131::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:39:55 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::af) by DUZPR01CA0271.outlook.office365.com
 (2603:10a6:10:4b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22 via
 Frontend Transport; Tue, 2 Apr 2024 15:39:54 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 61F5920080F8D; Tue,  2 Apr 2024 15:39:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.17.168])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 6AC7A2008006E; 
 Tue,  2 Apr 2024 15:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNmX1kz19ZM7qMZJFL6kgCyfKCQVGkbOjyB5tP0VHz5hvdnw4/lpIB4fd3rjNGuP949R4afxRaHjljnEEB8FRUK6vrF3rFOzE77L2lNKVr2uICPK6T02IE1FXW8+Yc6fJMqKHo57X2DBlyjMaDK+4jDmFt3IQUnPPx2NAYQrgVnMQ4Y8sBwFJiknLcx4lN5LRdLM3SMsIJl2HbKPb2ulfL2rpFrHDvi4VwMOE1guRoeSohfHOMRbcyX6Ff7IhZLHeuQFfj32jYrc+nn7uTg14Syi9qapippWR8wxcLrUTCD+4aFDGDy6E3LDrI/59VhFUyYOY1MwBd/2LUTOc+GVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEOF4biLNSUYfChuRm5UlUDiWj+kSH+ZKpSj1vDrzt8=;
 b=Y4KXP2e1urZeg9rs3huZYiMUmpsEN3noBXsLmImV61zO0do20qxeCRh0QR+BK3ylNeom6BdNeXKS++3rs8LzmL1jZjpKpwYB+Pmao4OCjM3I2Fo7GjUdY8T7ao3VJ/0sr4isk90fv7pFXv1zJsn7gCEWFgT6rryASZbB7bUR4RdwDrpBhPPSvjtjH+E/R8AJ9VNXFxLS+QFMgNouk7G35SOHzObcEQ6/0bRnnWp4Af4yTqeqVRhTtrAyo/AJ9baA78NlVxeZlluXKV5LgKoPPZVZxZuq0u/MBAMb5fhrsnycL0vALknuumOrOxx1iCScwQOzD9scenCX29IYFF/s4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEOF4biLNSUYfChuRm5UlUDiWj+kSH+ZKpSj1vDrzt8=;
 b=NICnx5pm7jHYgOCJTSFcplOeuRW1BiATcQlwoJ2mcskNiPG19g6ZkH2TlQW51vPGfng10JHz6/St5M28vpnjhrj85Yq0t3YmAq2HFmRhQcbgfPh6eXlTmPeqJeFb7jkduM6ysjNQYsxqpgfneeb2jKIp084noMUIHDguJHbiV+ZRY++JwYW//aPtV2iPYZRXgyeYdacjggn5bfYNvJWjQo854zvxip6SR8AzujwScYdIdVH9IsAfZHV9JXjHNJDm9vu45gGSRuE0DkQhBKWPViyvg1NClPV5WfzGjy9KeXS/SyubP8VHuHTloQI5h7KCYNKVGYPPrYq0dkFr9/Wq9A==
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9840.eurprd03.prod.outlook.com (2603:10a6:20b:607::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:39:51 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::84d0:c817:1e20:5554%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:39:50 +0000
Message-ID: <04c61877-29ef-4a09-b003-eb36733ccca4@seco.com>
Date: Tue, 2 Apr 2024 11:39:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] mmc: snps_sdhci: Add sdhci driver support for
 TH1520 SoC
Content-Language: en-US
To: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Geis <pgwipeout@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Stefan Roese
 <sr@denx.de>, u-boot@lists.denx.de
References: <20240330175948.80931-1-bigunclemax@gmail.com>
 <20240330175948.80931-2-bigunclemax@gmail.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240330175948.80931-2-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL0PR01CA0029.prod.exchangelabs.com (2603:10b6:208:71::42)
 To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS2PR03MB9840:EE_|DU6PEPF0000A7E3:EE_|DB8PR03MB6252:EE_
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: toeg6bZsU2DS4GimyqXRYmwJIuhPFcnX5dU44oqX782aKhAolrvpG0Fwl7LPBk0sCsPrUHJh0lCBaBL5RxJK0ME1KLxurlMeAFWYp7dtJ3VAZ32KlahVXZWTYNYMt/fCHNRD0tkNH6LdSewU1TFRNuZH6a1O+0n6c0o8oHF/3J7HNJroR9TnEI4XWpJR9rDp0V/jSWB8f6ulV6rgrr6uZW4hT8lQm+/yY0N4CoyJQf/Onjv9/+h6FdZJXqZTxeyNHKmTJUh1UMHmZoD0aVMBhmM4eIwVr5k8nvgMmhMg7cf2rcxCHNl1MKo60PxakHaDzt/Nt5DWy7DByesnbx4+WikBu8IuGqE+FeqeZxCA3CxSHMNdOUGe7RFyC5Qo5g97NfkdYcqTJXmtNWsKTA4cG5VU6X2XBZWuaksi6LcAwsseM2mauNqwQmiaEYhMFwctwb+/u3kSuKJ4k7zHWO7JfsInJ/Jwe9Auo4FXP6kKXGv1yjTqLJeMi2OiBNmfUafYGCrWnf3B/86sTqwbA7wRDj+NHfsbSQ5edORVyHr03ytGs9HBeCQ3WzUBt4qEUkofF5Otjmf2wQaD+4I9HpW5Zr9i/Kwmrrc5UZxroZn4YoXoTXDz3kxsmUrKoBkXkNJYsyxWgM5wi9j10FB9w/AnVesl7ZbO2yBdo8lu1MJ5g26ICDbeBDCHDbddAOVxIsK+Exu+k2a0qYGMAf4ORE4z3IYgjrRJmErZkkdVFRL/rB0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(366007)(52116005)(1800799015)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9840
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca78e629-0bb9-4bc8-b897-08dc532b24f1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJrqMuyJcYDQizcqEHRUQ5OuX5M0GArslfgn2NuhvjX95J5fNQVeqvKtJdIFcIz4R+uhA6n0zScBkFzUQ0nqGVAm5fiImtjDJ3gP0JpdyuF/Y4K4JTLwSPHzWWsxyczp5CH5f5nPHV/2+8BE1vX89qupZ/Z1DSYVDcKZBwx3n6nHi2FxhjNRNoQ57jtEuYAnwMF66E40en5vO8Vnzk3NoB6xbp7vju2JkE22j2ThrSdAYUPaUo8Km+osUhdhK1dgvKpvj91pIuSqdYZ5ZFNanlKAhS3UAu+/Xyj8GrBglWxsriNIQMsLsQmwEyoxG4cIbExlLVg+jhirw8ywNbYvAum+31ZY7c+o4LrNGuNoghTuSOWLhdSoKdE8QI8MBtGXdeRvA9ya2dZxZGDabdsEbfsbuYkPYP7Ta0deFD9a9E20xqoOoDyDAEcdA1uQdaeja5V6AWOMnQ0M76cnU9adgOmhlNBFaZ/tWwtF3wmsFxI4CTKIJw8bIxuCTKGhMP7YAJylYW39OO6CX6UCgmk6mLEJco4/OdH+RsvG6S0WfTlEpIuCoZBvdk37dCxo5QZ/kiEiAYrOqUczMghy3gq8/oWkEIUqZELUcgCvEBlUmcv7k9QDXVjAoIAutE1aSyfMX2HKAeuITWWH1L/wmL2cTuqVaYzO/fUa534adlwIbq+2cj1ipW2EjToPY1tToRy187eg7bnJn+wZo7IZ/Hesyvr3rcR+d1s1JB4/FLq/jFaHuNt51j9Fze24r9mBGjeW
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:39:54.7506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca78e629-0bb9-4bc8-b897-08dc532b24f1
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6252
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

On 3/30/24 13:59, Maksim Kiselev wrote:
> Add support for DesignWare SDHCI host controller on Alibaba TH1520 SoC
>
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  drivers/mmc/Kconfig      |  12 +
>  drivers/mmc/Makefile     |   1 +
>  drivers/mmc/snps_sdhci.c | 464 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 477 insertions(+)
>  create mode 100644 drivers/mmc/snps_sdhci.c
>
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index cef05790dd..6936fa0928 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -671,6 +671,18 @@ config MMC_SDHCI_S5P
>
>         If unsure, say N.
>
> +config MMC_SDHCI_SNPS
> +     bool "Synopsys DesignWare SDHCI controller"
> +     depends on MMC_SDHCI
> +     depends on DM_MMC
> +     help
> +       Support for DesignWare SDHCI host controller on Alibaba TH1520 So=
C.
> +       This is a highly configurable and programmable, high performance
> +       Mobile Storage Host Controller (MSHC) with AXI as the bus interfa=
ce
> +       for data transfer.
> +
> +       If unsure, say N.
> +

Why not use MMC_DW?

--Sean


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
