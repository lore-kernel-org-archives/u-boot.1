Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB01DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 05:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4501B8056B;
	Thu, 21 May 2026 07:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YnOdqTYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E7B83E81; Thu, 21 May 2026 07:47:48 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4860080433
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 07:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6Q1P3WZNImPSvW//G2pewqEo4+9ylefncNUpb85yAhbyvhC6Pqp+LA9Ikympp53aE63ygrvPLHbwktgVCMlKk/pAo38/HymZd2DSTIoCVjU+L/HY6nEqUWIxe4aA70M/lQFueGUJZuDZmbt90FhYqrt05ht9fRKuE0AdbWJDXrNGYTeQGHNjFwsNais1H0IBQ0gJU7uigp1tjvFRh2UID1A4HscoxCtoWIskCYg2/05fXgasLqXySE8oyz1RQ+d1H98fQ+ZoT+kDyP7N2a4rM2LUxIW0SEPrlqGm7RTV8ZiZx6z0fVtr+bVpMet4+VqoHPXuz4vZkyLCD96WS2dGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEnm82Anx7JpKef5G7/dlfWxh0izgyzpNq5r0V5p8Rw=;
 b=axILP4I4yEIKRl7eAB6VcDqM45Q4r+m6qokQEaGE60/K9/XNBve3ypAYMsRnP4u/d4Xm1wZ1PCpdmsyOdx14n4Bo6FawoT0cdrYXyRx4zkE5TB7ILHObzHSCu5W1ilnkwS40ahBC81vcMvEo3HgkLGYdi0Aur2naPRlYWZiM0Rw4ydw9zVFJf0TiwfiDQuXVQa6IMUcMv8cyriQxo60laIzNyFBgaaSACN6UZ41B6k+aMYJOckYGI6hz+H2tm+ulp4m66Xggxj9zrqaNMwTvTbtYfCaz2m3MDNkyYCh+kqdBL8kHQkeoWuUDR9TcHjmAe+KpHxha+tToIHVfbWlEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEnm82Anx7JpKef5G7/dlfWxh0izgyzpNq5r0V5p8Rw=;
 b=YnOdqTYjJHtaNGQgkgnWwFSVN4+Q5fTR+LrB1sIXurOFBkEe5YOlyMxBRxni9pDFYmqCrz7EiFeolC6EatdaDanFWa3hWX3zU1s9Z7blUFXFN95c6w1vCyFthSIqwZyYaPbOedceuBp8yEfRR7JXpR6mBOw06HQc3cSvegipMTY=
Received: from MW4PR04CA0210.namprd04.prod.outlook.com (2603:10b6:303:86::35)
 by SA1PR10MB997713.namprd10.prod.outlook.com (2603:10b6:806:4c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 05:47:43 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:303:86:cafe::39) by MW4PR04CA0210.outlook.office365.com
 (2603:10b6:303:86::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 05:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Thu, 21 May 2026 05:47:42 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 00:47:15 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 00:47:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 21 May 2026 00:47:14 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64L5lB3h2948582;
 Thu, 21 May 2026 00:47:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: RE: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update
 to v0.12.0 of DDR config tool
From: Neha Malcom Francis <n-francis@ti.com>
To: "Scholz, Kevin" <k-scholz@ti.com>
CC: "Francis, Neha" <n-francis@ti.com>, Francesco Dolcini
 <francesco@dolcini.it>, Franz Schnyder <fra.schnyder@gmail.com>,
 <trini@konsulko.com>, "K, Santhosh Kumar" <s-k6@ti.com>, "Brattlof, Bryan"
 <bb@ti.com>, "Chawdhry, Manorit" <m-chawdhry@ti.com>, <u-boot@lists.denx.de>, 
 "Kumar, Udit" <u-kumar1@ti.com>, "Gujulan Elango, Hari Prasath"
 <gehariprasath@ti.com>
In-Reply-To: <8d4936cd5b16494e9447d5f64d7b8e11@ti.com>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
 <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
 <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
 <20251120081659.GA12514@francesco-nb>
 <6726eb089e2f41ad9fa4a5ff3d6ceb54@ti.com>
 <20251120144848.GA58464@francesco-nb>
 <fcba4a77-53a2-4f7f-be95-e9cefcf347a3@ti.com>
 <8d4936cd5b16494e9447d5f64d7b8e11@ti.com>
Date: Thu, 21 May 2026 11:17:10 +0530
Message-ID: <177934243083.132247.2472290729341549059.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779342431; l=2007;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=yHhbZ2LCT7HSRJtJYFspcxPPd4VZSDsjSRdH9QDJkgA=;
 b=7aItMCdQbFvxtvIU0VfiCr6eMlyO/ZLC9CJfrBM56n/CCLG7/7mKv5YpR8FpWJCAaWV0kzOIr
 FOAln0n92HCDt5z+7CXZLPCjB5laqi2bdN8Abjkxhs83s3rFJM/oNmQ
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA1PR10MB997713:EE_
X-MS-Office365-Filtering-Correlation-Id: 67250023-8118-4e96-7e1b-08deb6fc79a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|4143699003|3023799007|56012099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3J/HvYCNzufOTMESDGFObmvGt54eatk+Kzx3NteyLa/+vIrV81go+uNgWYX0gJ0JOxHDCQ5vzadfKnY/43jTwgonjMtmQ0eXjvTca0H2q6QlYZiDWtsYTXW4RVnmTTp2TwbID2c76DjdN7tjydWJnkz1HMnfEpRGaWRWcF8raVUbw7AgJ19UE7VRCsp7BTfZSvg2rnvbxZj9t9fAmMUj3DnW5R6xh7bOV0JfcHBr5JPrav8h/QBsclyNZmsXlZPMBkZlG9Eojdui4x2ij4+BNCtd7ge4e+S3b31pTPPiRurhYrTkxxsG7jmguDRNt22vDWd1UHIodGJ1xfUOKSceR431tIqTYgbrWkU70/T8x7v0RrPpIBpTqqPQROFWIJe2ICGJD3ax06zBI7uij8kTRfhQs2SQtbTsJSrmFpOQHjvQx2fpEt0alT0FssZFpwd5n8UpFw1oGvLRL4cbt6pUZp+R63VZ9a1DXCXf8zR7hIVuuCOECcmB4kBt4OU4iLoW3h0OAA3lufkZSS0RxkRpHN6P2a0L28n/SB2Ir74uNJz8RbzSKG4yTYZVahvY+TCFwyBDzLrImAy+VQNqMp+naUiamaX6v+AxNlthYhD9f/1YrydKLWNRsXweYYf5Kbrt7F2CV0Wr6XgxItldJWf2r2LXvG+LGcamu+6SAlglbuQKd1Hw8+VrnatOYZGdoFfDbK/KYQvDrfPZjeDTusJJbF2bgLbwdulSyuwUIUC2y+s=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(4143699003)(3023799007)(56012099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2417FLSKEA1fbLN5QX1Ev/1Jz0Xyhk08ay7psPbwY/w4sqdfVVpdsbsYugXoIMOdt0L4wOZy+BtLrHK8vk1E5J8fF+DwOwKpoV/Nus4nwThTTRC3baYoS0ZKQqAX2lEiBGjL0QPrkyGDoYXC1gJwi4uxf5JviZzd6xkHgEC9mlEZenLHiTMDriu8SQVT11g/gXi9lFpCDf3JbOPxFe7I5q54oMz+Rlm//9zhM85qc7YsWVjJAyaZD7sOrfec/L+huyGUCbXpEU+VT/ilIjndfx+rU1UweYZn2d1ajobmmLVBVww8MPq9echpRSNfqIdALZjVjHBGSBcZJcFbU0xusZt1XDyO+aDlqJmwJyw7Eh07vPbRMc1H8XugkIYxNPEFOVwO5RYWZM2bIcHfl6NCKurMZGRsq0u0IHtjCJQIg0rqEQIafNd2M0xNmzTVW+xs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:47:42.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67250023-8118-4e96-7e1b-08deb6fc79a7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997713
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

On 2026-05-20 21:52:09+00:00, Scholz, Kevin wrote:
> Francesco,
> 
> My understanding is that the Aquila board was previously having intermittent boot failures, hence the comparison of the TI EVM register values vs. the Aquila board register values. My understanding is that since then, two unrelated issues were identified resulting in the observed behavior, and both have been resolved.
> 
> However in general, more than one IO setting can be adequate for a given design, and it is also acceptable to have different IO settings for different board designs and/or for different DDRSS on the same board. 
> 
> Regards,
> Kevin

Francesco, hope this justification on the IO settings are satisfactory.

Tom, could we pick up this series in that case?

> 
> -----Original Message-----
> From: Francis, Neha <n-francis@ti.com> 
> Sent: Tuesday, April 21, 2026 5:11 AM
> To: Francesco Dolcini <francesco@dolcini.it>; Scholz, Kevin <k-scholz@ti.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>; trini@konsulko.com; K, Santhosh Kumar <s-k6@ti.com>; Brattlof, Bryan <bb@ti.com>; Chawdhry, Manorit <m-chawdhry@ti.com>; u-boot@lists.denx.de; Kumar, Udit <u-kumar1@ti.com>; Gujulan Elango, Hari Prasath <gehariprasath@ti.com>
> Subject: Re: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to v0.12.0 of DDR config tool
> 
> Hi Kevin
> 
> On 20/11/25 20:18, Francesco Dolcini wrote:
> 
> > Hello Kevin,
> > 
> > On Thu, Nov 20, 2025 at 02:23:02PM +0000, Scholz, Kevin wrote:
> > 
> > Thanks for explaining me the tool and the related config options and 
> > changes, however the question is why you have this difference in your 
> > specific configuration for AM69A SK board in which only dram3 has ODT 
> > enabled, and dram, dram1 and dram2 not. Is the layout/schematics of 
> > DRAM3 different from the others? Why?
> 
> Is there any specific reason for doing this as Francesco has pointed out?
> 
> > Francesco
> 
> --
> Thanking You
> Neha Malcom Francis


