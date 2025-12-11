Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE36D41C37
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFA3839DE;
	Thu, 11 Dec 2025 14:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O8oIKwpu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D5C83A26; Thu, 11 Dec 2025 14:51:29 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BC0583045
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 14:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RknFUvkPxnLy2m2oVHW8eccl9Bkyzi5BaTFak69mlJPi2vPzNw74yIwkFR9Fz7TSIUt/1uBszzDBzdZAIG/RdCiq9wuASfYLcqrLcoQiYYQ6ETtp7HhB9vK20T8dhapN5oZQmg0zvNRzmekxPAAe17+kNTQtLyNiuic84Rp8vIh+Chz+ewTUegcGF+zonWYuiiik9O2yf4HsMAWC1N4fv/hbxgeoI0pCd7+o/7hjE35Tko/vfIMYUz/fizPT+j1Eqy4jhvZr36NRxAGln2n/h9VlzyNOgS/kgbK4ylrTsxsIsSaZ/1YlSaXFM0muSvQMafCt1buGx/MUK06mgICzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbpse/iI5f8bLlfj1T7uP8Dto4hI2YGdMtoAwpniWHI=;
 b=lKPowYbUpb9d5AraFNkfqoDibmktE9WbCICPwEQJ/iDqeY4alQB58UoLVqoqdQKoCgKF1JazXwd3medIqwIxIAGivx9SoiYb4jrDCINFEFqS0XCRZC3lyIHRfJpB05A39G7yn8wWUAa4T8x8WlF/tEKB7OXz5POIr2zCCDtOC9YDgbxJzzL5+ODdl+NfR8XP92Pumtl6ipjybVXvOUNFqd8cnP5NuilDgvxmGNNP4Yp2R6owL2nsQmvYgW5yPCup+xGn/KcdgmNZ42+sehOg/qgq/3AQaDMpaDPQesLMILQUoIuUvFcyuuNIUND5rHjZ29UltIGSr0b+GN+6Goxxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbpse/iI5f8bLlfj1T7uP8Dto4hI2YGdMtoAwpniWHI=;
 b=O8oIKwpua+2QePTgN/Cls1/1AklB73MsMlztegRdLGImmD35j86lyt3WibamCn+yq38I1TDvsUBHCpY687z6KpAoMxnGJBv4W6GWxLDfWT70H9hMiwzHxkhIeThSjJRJW03XRyCSfL1ricoXXWOdZaTafPEhswoSQpMOAoIcukQ=
Received: from SJ0PR05CA0200.namprd05.prod.outlook.com (2603:10b6:a03:330::25)
 by SJ2PR10MB7618.namprd10.prod.outlook.com (2603:10b6:a03:548::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 13:51:17 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::5d) by SJ0PR05CA0200.outlook.office365.com
 (2603:10b6:a03:330::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Thu,
 11 Dec 2025 13:51:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 11 Dec 2025 13:51:16 +0000
Received: from DFLE109.ent.ti.com (10.64.6.30) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Thu, 11 Dec
 2025 07:51:10 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Dec 2025 07:51:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Dec 2025 07:51:09 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BBDp9bE577920;
 Thu, 11 Dec 2025 07:51:09 -0600
Date: Thu, 11 Dec 2025 07:51:09 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, <u-boot@lists.denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Christian Marangi
 <ansuelsmth@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Marek
 Vasut" <marex@denx.de>, Simon Glass <sjg@chromium.org>, Jonas Karlman
 <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251211135109.akox2mxasbitmaeq@outskirts>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
 <20251208153852.GP303283@bill-the-cat>
 <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
 <20251208163527.oq7vddgodao3legu@unguided>
 <20251211114226.jbggbrqlcfq7dbur@exterior>
 <20251211134716.GM303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251211134716.GM303283@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ2PR10MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf26a3f-1156-4fb0-d191-08de38bc5ae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mp6CvdPNi4bV1cKGN+LGJbHdrbzEZsk88d0nNocOSwGx6JlNXpf0xaftdl5b?=
 =?us-ascii?Q?w0Z8AwyhpsdkWe7bb1dQKzQkMhvGV2ArUJwXpYLr95OWqKsy7201qNMKkfAK?=
 =?us-ascii?Q?c7xpXg0EiezfFj3ukdWaROokb/WhIQj1LDZ9GL6O92tyEs3A2Oj39q6xW5DW?=
 =?us-ascii?Q?xIYKuM9qmNwnSQFpERR3Qb6HxflYne8lX9eU+79KcV9xtZ5yOwI/fVZ2yCUN?=
 =?us-ascii?Q?K90+O60JVMvxRBvudA0vzT/J44FocWdGjYdtYxvrd1HZ9dTq5HhRiSXK2ZgG?=
 =?us-ascii?Q?UR+v41alPCqljg45N0ebbZLoYx8M7COJecIJdJsLSiMrQrI6pCQWkz2jG0Mq?=
 =?us-ascii?Q?OhpzudtLJYDlkPnVG7rnF4F4KgnpVVufXE9e3Q5VdlJNLIhADbJg9zjwmpAx?=
 =?us-ascii?Q?Zkqk3IfZ9EoySSth4TTCN3zJJJqj3HjrSrMuFtFZFiMGtCWf27USRGPZanvB?=
 =?us-ascii?Q?ueZI6hO8SHVsKJjgU9BqV9sLV8M7kYF2cdus0geRJfTOHN8PwepyiHlDjBir?=
 =?us-ascii?Q?pG+VZcadwTxvRo1WosfmGSj+SYxG3PCQ8DLfckE7xmfEj/hJ0nS70YCu6XLM?=
 =?us-ascii?Q?JuUTQcvqoDAFJH7nEOCnngN0I9rWJR4u/faa65lz+W5FwANH6LoWXzzk4LhL?=
 =?us-ascii?Q?auHPb1O1dHhN/SxctJ0B6f1o2LSkG9HMhrwgenqiptf54zTGiSGLxXJZ56De?=
 =?us-ascii?Q?awc6Ce0SdKLeUsmiabELqKzhWplbjW6v4XbxLPrFJQrDJsIQo8bygsBkt25z?=
 =?us-ascii?Q?LEHTvJCLrFRjCKfmq/a4ZpU5qEQ1WnsbGu2XA597laYtjoRq4h3c+4kPkRrP?=
 =?us-ascii?Q?lpF9YhA+VcuS4B/nkPGw5KhCH06PXdXg1HxmxCtPwl+q+Bt7D+UHmprQM9Cy?=
 =?us-ascii?Q?oNqX93vr6bwDdAa1l8hLMgMuJXAucrG+tvhKlj8iZ1ICwL1sOVW84uUJ5dSJ?=
 =?us-ascii?Q?rYq7R3WtBhQHtY3nN0dkIaC+kzmmCMjeQ1K2xLRg7DzqnkGIaRkOah3aXy9B?=
 =?us-ascii?Q?usKGm1oKntpYfHUQ4iucVknIjXOvVkf/P+VFCmCXcvgLfxbxdgnaR09WnYXS?=
 =?us-ascii?Q?o3uRbDMUYlEO2H24XAWo7Y6nN2NWDm61lAzKdVKgULq2Z9SEiIS2mZN04yhB?=
 =?us-ascii?Q?+osSIukQQfohk3AJZiZ0ACHFGmDiZUY6xq9IOvaRCdpCwjE5m7d1IsaVw7jT?=
 =?us-ascii?Q?cVCKnDYAFAFyIyR3C9/OD+DzKDmJgpcT/OBN2FUW3Q4Pqbi/4A1XnEnsQE8B?=
 =?us-ascii?Q?uxwZgBWoOteHPOTtXWLqmsrL+23ws2HJetlid5ID1/1dVzifD0yW1mWImxLe?=
 =?us-ascii?Q?ebZkz8T8s7aLqwr9ID+BSgsJ9FVj+lkH3sN+a5Q4QFixpA+OQD0a4/LJ0FnG?=
 =?us-ascii?Q?nmSzYn96iipboT0521QoxnBz6Kxjj6NLApauCXU9rVPoLA6SsCRZPzqVC3Rx?=
 =?us-ascii?Q?5SDrAxeWEAXQoOCK37D8IEawx3gBOjsHnjThewVeBOVnlVK3VhCUhS9ycMWE?=
 =?us-ascii?Q?l9ruuvk99/uTnUlIXAEkdI9qIA0zgAfkoEtB?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 13:51:16.2340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf26a3f-1156-4fb0-d191-08de38bc5ae3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7618
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

On 07:47-20251211, Tom Rini wrote:
> On Thu, Dec 11, 2025 at 05:42:26AM -0600, Nishanth Menon wrote:
> > On 10:35-20251208, Nishanth Menon wrote:
> > > On 15:52-20251208, Andrew Goodbody wrote:
> > 
> > [..]
> > > > > > Confirmed by reverting the commit. Looks like
> > > > > > 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?
> > > > > 
> > > > > Interesting, OK. What Andrew did in commit
> > > > > fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than before and
> > > > > there's two stanzas there. Our lab is current being re-worked again
> > > > > right now so I can't test on the K3 platforms I have, but can you please
> > > > > see which of the two changes in clk-uclass.c is the one that breaks
> > > > > these platforms? Thanks!
> > > > What is the breakage please? I did put this series through CI and the only
> > > > issues were due to lack of disk space, so not related to the patches.
> > > > 
> > > > Andrew
> > > > 
> > > Looks like A72 would'nt get started.. adding a bit of print to get an
> > > idea:
> > > 
> > > https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb
> > > 
> > 
> > 
> > Any suggestions to proceed?
> 
> Can you please see which of the two changes to clk-uclass.c is the one
> at fault, or if it's both? Thanks!


The logs show the details
https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb#file-log-patch-L12
(return ERR_PTR) triggers the flow in https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb#file-log-patch-L19
and fails

This looks like the clock for A72 that needs to be set from R5 SPL to
start up A72 - with the fail, A72 does'nt start up.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
