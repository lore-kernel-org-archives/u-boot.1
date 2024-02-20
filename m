Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55830C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 16:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F26987FA7;
	Tue, 20 Feb 2024 17:30:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="pov+twcG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Dko/MUCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8BE87FA7; Tue, 20 Feb 2024 17:30:11 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F2487FA0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 17:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=WuXckEHgSZztxzajQJuRrJZ7lOe71c5fUEovjKSzOwj0ka8x7g7NiBW7tjRG1blBEUvCCwdzegaZWVJdPwYKjKggwaBTva8SieyK9ZbKj/FSEOsd3NAFkfDRU+CLHfMqzvmo+nO04IYG6/iXcvukbOLjscD/X9nSurG+kZnvnaaGoodFclRC27B847L37rXc1vcXunSvY5qLLrX2D0pMxG3dfHCRcZvFgBdaFuLyADYtXlWFGXIt74E4VZKY8wF3WNjcZKW1KSzTvRYkpQqZ8nZviZV2OcDVDBwJz2iBUxUOLxqPSXDRyEflS28W1ZpeoVekd5zOVDJIOiho9sbOOg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m38RVjpeCKuJdGAFVc4NNtTQ+iuOM/4r5lSrrJleiuA=;
 b=RcCA3I6FSbJTi0W8fDWU5NFRJ3YhPAcqaP7XnCdhw0YmOny+8rIgnMxrO6LWgl1veKfCiOUXhwMQToyjXDzlWoa4V1wO2LgMg3rBhrun1ThpAedNY5R9sK+gWN8vQrhz/nTlewhJ4hEBVn+J9CVU3pbHjdWUNL1T0zuYgTZ/yjg8Hi9GnAGRt3Be+e7ByZ3XAEmnLtKz3WvbJxQbzMJeX6epvF+oMk/iEyYQnOiTufwhczJA53p6O3E7YNVdNxaXtxpI41eE4XuJ9OL9fSaIFxQtFsJX7IhlAHUpcov14aOw/25xF8J0psBfp3BDxqhPIAdBgi0jOUsEJFSWvZC54w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=gmail.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m38RVjpeCKuJdGAFVc4NNtTQ+iuOM/4r5lSrrJleiuA=;
 b=pov+twcGKTxxT1Vh/bCJvd64zG0fRaQKt4k/KPblU8BqpmK6ZGkOkq1B8X03oAPYmuYJOiSybl43Jd7VrFHRTLTS8TuUUlIHa3jG8lqAASn9wy5dnDcIdI6mDBheA4XBtkHAgtrgECjY13kKgTSbpdUpQHIz7iPOUCAgSkEkj199aC9XfcJmY+r/9TwSaI5w2YZyna1/WmCp2nW4YjSiCDh9xnqpXmqhHQHWnKbA1aN9Txb9ai+1XWC6nFwSXogFIOyG9SskE59StKSwGLyB9ojT9D2fZo0ONH04Cu7xTammlG/7PCDqV/PhYtdSBN+KLeKsGU+Ntw1lR+8rRP1FOw==
Received: from DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) by GV1PR03MB10481.eurprd03.prod.outlook.com
 (2603:10a6:150:163::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 16:30:03 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:468:cafe::c8) by DUZPR01CA0035.outlook.office365.com
 (2603:10a6:10:468::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Tue, 20 Feb 2024 16:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 16:30:02 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 A9E1520080092; Tue, 20 Feb 2024 16:30:02 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.105])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 6B3142008006E; 
 Tue, 20 Feb 2024 16:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWRxfI5DCbjz7QriKXKex3EuKcjAoBaO30PmmJvmyDde3kAim5Sty2R1wxcwyQu3n7sozVDLZwoHOkenYkSn3RPE2IeEcRNTRGdTVI0vw5x8ZYMR9WG4NGBM27W8azjS3Y0aNfICSJMQ8ERikzASLWTuMA5dZk2dVqnmOyjwZimhyN4f54dCZ2LM+2B+5xtVCJJf9DI2B/q3rKFtr3aMLC/yvTzk68ba/2cdmpA2bIiT/gtXTRW6+7bSF2CSs4QvDwj0wGIOrYE2MhdN1pUv//z7FJJfNGgGRslhay5oeKtgUNNfMiWDz6u5eXjzZfPTNAUjgKhhhKnsqH0aX9ZHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcIgR5iMc85AbFFefG3fbCnZX1Snr33vJVJYR1q0Gqc=;
 b=byYJh03UoJtgvbxUcwzdtR4ZGz2eyUZCJljk/dMrbet3C5TeijZ7B8tfbCpij5L4a1tfEITTWubkmTidBnfVxrixD+wMmadVogeAq0qyfWp3NdGfzpYeSisnkF72txrIV7lsWDWu5jzcsVgoIBdcVGyghA4ULKFr3YRVKlX1gZ8em6403U++21VfGlx0G8ErC+DgU9W6pSa09QxYriWTyY6Jks+M5mhYcC3bcg2kEGwUPiNaUUttsU57e+UreytZS9/Mwo/BGZjdt2+NZU26YVQ9oABLfMpUjPMzqQOVb/H0rz/DndRJ8hdp3qZbEY0bDs+Rfu1NB2NRyQiHijD1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcIgR5iMc85AbFFefG3fbCnZX1Snr33vJVJYR1q0Gqc=;
 b=Dko/MUCJSVLezVmxXM56HrvWRDw2PQmGuF4zK0gzIJSOOzQZvAQRBdkRwapZEr0YkwjQIEq6luud9xN4vSYTM1LG6VyObB/kXdDp5Qzl7nzdizBY/TuilmhBwSw4fmlmud/QSDNlGsLPrWWpdzVtn/4Zvcd8ScwQg3SVOQTVyFGTCLB45Cyp9rPEiHyk3AdvrKQnM6PAPMyyzIAZKk40+3VNxIVVuwC9fbS7mzdVix87cwBimootLxTRdlUr56YcSqJkaM67Sw7wiwIxQPyh8AWwQkm/Ds3qKU4mkkQ8iq2Jilnk4EAHzvmZno6Bash2PXmLvEx8X1YoGfYnNlJQiw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by GVXPR03MB8401.eurprd03.prod.outlook.com (2603:10a6:150:69::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 16:29:56 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::9529:5f9c:1795:a94c%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:29:55 +0000
Message-ID: <92a814a0-aaa5-47db-ab8f-7e799ab3e82d@seco.com>
Date: Tue, 20 Feb 2024 11:29:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: HABv4 with SPL and u-boot-dtb.img on i.MX6
Content-Language: en-US
To: Benjamin Lemouzy <blemouzy.ml@gmail.com>, u-boot@lists.denx.de
References: <20240220105049.00000d3c@gmail.com>
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20240220105049.00000d3c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:208:15e::41) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|GVXPR03MB8401:EE_|DU6PEPF0000A7E4:EE_|GV1PR03MB10481:EE_
X-MS-Office365-Filtering-Correlation-Id: b592c73a-3cbf-42cf-4056-08dc323130a5
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: vby5+Q48BYDXufB+lnaZb2IbEa6EtouiJluMrZQ3PjpFF0tlCHSU561FijUkzlrR9zpYpetJ7DcRzc9GBTh6/Dfr4z/ip8pgWCmlXAnupb9fPbTgVH23/Ux9moPJUD5P/YHFsMO6/riyZCe86z+MqwLesLXTaHMZTuTk/kqxDJ7e5q/Eerv7b+W7xcfKzIdJg+URM0fSdycv7asBhKG6GyklhdOEz6ZLa6GYXBoFBhKHfAfLvvvef+sWLrWiO6qTBfW+nqPf9fNxr/ZnfQxGMQbKDkn+tZ5mOr+2dnUeN1OHhYe3cP/gL5VpWlklpmUS0pInJDlz1C/xJ3KhpDDtBE3UcMQ1F2wyxiOk5YBmGXdfOEdnOGEnoKCiapckHhH+qYUZ7BjuA1hLZ1TnFgjCvCIaCk0FmlbypZsPKXdz1kPBwdv7hvZhmgVukwUwK7s5N2fVGIdzCW7p00veFd7e5XOSa0Se71DWRb72PHJvnhcNAhVA+ghs71V2ivaDZbGmUSOHfywzDhxMKNBvUdGcYMQwCGNeQlBa09D2frTzmTlOXi1/AkgZc/GDLt+lbbwCze+Qim0MJzvuZYJETJpnTETg2qr6wS/u+68Vz7+j/2A=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230031)(230273577357003)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB8401
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 53301f5f-ae55-48cd-b47f-08dc32312c3f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4s37JmA9KgjswYTghAERPrXAxgZU6VRoGnLGr6dbUO9YkumGInYdZT/iqsqr5zAAdtzrypGRcGiwA3OIGDOxz34ZTHTA52Ids4oPRBsusp/Ty2zlSKLt568EWRSQ6OJ/xof3qrTteAFhyGZH0Ty2C0jqJKmEJFKznQaStyRJOVNvvwS86nDlrMzPuecsGqNoZcdLMZmqoeG99w4SVFNk6SjEwJ3y9R7ZBZGF8iLM/UOtdM68RFK+Bw2FVUFmX3DwQ1XQET3KYEuHBq4XPvgkhaThwFsju+NOjiRSjLdoaRFnOEmDVZ2lD2+n5zJmKFWMk7SnY2OFAYbJX1aKSI6Mjw6lps0SCtE/HFbpgCeyByfLN4maP9qsBQ3yavihNqx7n0Fd7ya1lbo9ijDVqJWf18/EOObtnP65+M7mFFEJwsVODpUzalJz1Y9ZuVhAhgIHiy/ex/mKAh7g+k8BLUwaBNU09VsrmOGlNqLsWMSxQbvmuM0BYXb7DI4dbHBNPso+BSe/34STXIMhsZXSSRi5+K1SsLTuGpLUOMp1AOWkTibgvWvxdGQP2aVOTWgficT4R5NKsfmprZLAV4II6DHd2oUp4HBd+J6KuQPq8VeW/+QkhAQ4g7tDSeaP2ge3fxoWOfMIPl8kM5/XIfxzkg5cA==
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(230273577357003)(36860700004)(46966006)(40470700004); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:30:02.9752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b592c73a-3cbf-42cf-4056-08dc323130a5
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10481
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

On 2/20/24 04:50, Benjamin Lemouzy wrote:
> Hello,
>
> I'm trying to make secure boot work on i.MX6 SABRE with SPL and u-boot-dt=
b.img files and I'm not sure how to do it.
>
> I'm using the U-Boot vanilla master branch (2024.04-rc2) with the followi=
ng configuration:
>
>     # Remove some stuff to not exceed file size limit
>     $ cat <<EOF >> configs/mx6sabresd_defconfig
>     CONFIG_BOOTMETH_EFILOADER=3Dn
>     CONFIG_CMD_NET=3Dn
>     CONFIG_NET=3Dn
>     EOF
>
>     # Enable secure boot
>     $ cat <<EOF >> configs/mx6sabresd_defconfig
>     CONFIG_IMX_HAB=3Dy
>     CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x18000000
>     EOF
>
>     $ make ARCH=3Darm O=3Dbuild mx6sabresd_defconfig
>
>     $ make ARCH=3Darm O=3Dbuild
>
> I have no issue to generate a working SPL-signed file following doc/imx/h=
abv4/guides/mx6_mx7_spl_secure_boot.txt instructions.
>
> doc/imx/habv4/guides/mx6_mx7_spl_secure_boot.txt only gives instructions =
to sign u-boot-ivt.img but this file doesn't contain device trees listed in=
 CONFIG_OF_LIST as u-boot-dtb.img does and I need them.
>
>
>
> NXP AN4581 lists 2 possible formats to sign additional images:
>
> - Image format:
>
>             ------- +-----------------------------+ <-- *load_address
>                 ^   |                             |
>                 |   |                             |
>                 |   |          Image data         |
>          Signed |   |                             |
>           Data  |   |                             |
>                 |   +-----------------------------+
>                 |   |    Padding Next Boundary    |
>                 |   +-----------------------------+ <-- *ivt
>                 v   |     Image Vector Table      |
>             ------- +-----------------------------+ <-- *csf
>                     |                             |
>                     | Command Sequence File (CSF) |
>                     |                             |
>                     +-----------------------------+
>                     |     Padding (optional)      |
>                     +-----------------------------+
>
> - FIT image format:
>
>             ------- +-----------------------------+ -------
>                 ^   |                             |    ^
>                 |   |                             |    |
>                 |   |           FDT FIT           |    |
>                 |   |                             |    |
>     Signed data |   |                             |    |
>                 |   +-----------------------------+    |
>                 |   |    Padding Next Boundary    |    |
>                 |   +-----------------------------+    |
>                 v   |     Image Vector Table      |    |
>             ------- +-----------------------------+    | FIT image
>                     |                             |    |
>                     | Command Sequence File (CSF) |    |
>                     |                             |    |
>                     +-----------------------------+    |
>                     |     Padding (optional)      |    |
>             ------- +-----------------------------+    |
>                 ^   |                             |    |
>     Signed data |   |           U-Boot            |    |
>                 v   |                             |    v
>             ------- +-----------------------------+ -------
>
> And as u-boot-dtb.img is a FIT image, I probably have to use the FIT imag=
e format, right?
>
>
>
> I manually craft the signed FIT image using doc/imx/habv4/csf_examples/mx=
8m/csf.sh as reference and everything looks fine:
>
>     U-Boot SPL 2024.04-rc2-00025-g9e00b6993f-dirty (Feb 19 2024 - 13:17:3=
1 +0100)
>     >>SPL: board_init_r()
>     spl_init
>     Trying to boot from MMC1
>     fit read offset 11400, size=3D12800, dst=3D18000000, count=3D12800
>     spl_load_simple_fit_fix_load: ivt: 18001000 offset: 1000 size: 3060
>     spl_load_simple_fit_fix_load: ivt self: 18001000
>     hab fuse not enabled
>
>     Authenticate image from DDR location 0x18000000...
>
>     ivt_offset =3D 0x1000, ivt addr =3D 0x18001000
>     ivt entry =3D 0x18000000, dcd =3D 0x00000000, csf =3D 0x18001020
>     Dumping IVT
>     .. @............
>     ........ .......
>     Dumping CSF Header
>     ..PC...........P
>     ................
>     .......<........
>     ...............8
>
>     Calling authenticate_image in ROM
>             ivt_offset =3D 0x1000
>             start =3D 0x18000000
>             bytes =3D 0x3060
>     firmware: 'firmware-1'
>     External data: dst=3D17800000, offset=3D3060, size=3D86138
>     Image OS is U-Boot
>     fdt: 'fdt-1'
>     Can't get 'load' property from FIT 0x18000000, node: offset 464, name=
 fdt-1 (FDT_ERR_NOTFOUND)
>     External data: dst=3D17886140, offset=3D89198, size=3Dac00
>     Can't get 'entry' property from FIT 0x18000000, node: offset 464, nam=
e fdt-1 (FDT_ERR_NOTFOUND)
>     loadables: 'firmware-1'
>     no string for index 1
>     Jumping to U-Boot...
>     SPL malloc() used 0x0 bytes (0 KB)
>     image entry point: 0x
>
>
>     U-Boot 2024.04-rc2-00025-g9e00b6993f-dirty (Feb 19 2024 - 13:17:31 +0=
100)
>
>     CPU:   Freescale i.MX6Q rev1.2 996 MHz (running at 792 MHz)
>     CPU:   Automotive temperature grade (-40C to 125C) at 35C
>     Reset cause: POR
>     Model: Freescale i.MX6 Quad SABRE Smart Device Board
>     DRAM:  1 GiB
>     Core:  94 devices, 23 uclasses, devicetree: separate
>     WDT:   Started watchdog@20c0000 with servicing every 1000ms (128s tim=
eout)
>     MMC:   FSL_SDHC: 4, FSL_SDHC: 1, FSL_SDHC: 3
>     Loading Environment from MMC... *** Warning - bad CRC, using default =
environment
>
>     No panel detected: default to Hannstar-XGA
>     Display: Hannstar-XGA (1024x768)
>     In:    serial
>     Out:   serial
>     Err:   serial
>     SEC0:  RNG instantiated
>     Hit any key to stop autoboot:  0
>     =3D> hab_status
>
>     Secure boot disabled
>
>     HAB Configuration: 0xf0, HAB State: 0x66
>     No HAB Events Found!
>
> But as only the FDT part of the FIT image is checked through HAB, U-Boot =
and DTB are only protected by FIT image hashes, right?
>
> Using fdtdump shows that crc32 is used as hash algorithm for FIT image wh=
ich is a super weak one.
> I tried to pass another algo (sha256) using mkimage -o option but that do=
esn't work.
>
>   ./tools/mkimage -f auto -A arm -T firmware -C none -O u-boot -a 0x17800=
000 -e 0x17800000 -p 0x0 -n "U-Boot 2024.04-rc2-00025-g9e00b6993f-dirty for=
 mx6sabresd board" -E -b arch/arm/dts/imx6q-sabresd.dtb -b arch/arm/dts/imx=
6qp-sabresd.dtb -b arch/arm/dts/imx6dl-sabresd.dtb -d u-boot-nodtb.bin -o s=
ha256 u-boot-dtb.img
>
> Is there any way to change U-Boot FIT image hash?

I believe these options are only used for signed FIT images (e.g. for
verified boot [1]). Since you are using an external signing process,
they have no effect. I suggest creating your FIT manually (e.g. -f
u-boot.its instead of -f auto). You should be able to specify the hashes
manually that way.

> I also try to use image format and force the HAB to verify the whole u-bo=
ot-dtb.img file by patching the FIT image size:
>
>     image_size=3D$(stat -tc %s u-boot-dtb.img)
>     printf "00000004: %08x" "$image_size" | xxd -r - u-boot-dtb.img
>
> SPL starts, authentication looks fine but the boot fails.
> Is there any chance to make it work or is it insane to try to use this fo=
rmat?

I have always just used verified boot for U-Boot and the kernel, and
only used vendor-specific stuff for SPL.

--Sean

[1] https://docs.u-boot.org/en/latest/usage/fit/verified-boot.html
[2] https://docs.u-boot.org/en/latest/usage/fit/source_file_format.html

[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
