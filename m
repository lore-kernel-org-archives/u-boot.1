Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE9105A591
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B85D8420D;
	Thu, 12 Mar 2026 13:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hCB4LHe1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F7AD8418C; Thu, 12 Mar 2026 12:23:19 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 362F584181
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 12:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im4BehKA2YSrqaBb14foG6LhMwybOvS54EcPEiAIR0/QfHdH/dFEzZ4AdKmzEajUhHnL/TleqWAnpBqjUB3iVJDO+kPt7WcbfDZdzMLDaJoo8OYAevpIQ4SePGqz6vfYxxjjcKpM1uQJsJSJsHTMCGsBz6mnMLXi4g/X3/RtzIvJPfGvuh+mrRSXTrnc8dcObehUc7rAO7dxKxZht/7TjM13YEdQORyDrVhrblNspJSsAy34ne8IIDlZFDXHccEzZfn9JxIifEWm2z7cjiiKqPMFmWEkZjdwZs6y7HstdlHVPDuvgyBu7ttiNJMrypk/LBZuBWNnBVjEjDnfZPjrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMr2MYQgeR8olM1x/p4JBwToPzbzxRkmo/UwInWkeMk=;
 b=ZH/YbppLElc+NHmV5/WGEJSWh+/kHzzCoHr6VtpI//BdGix6zHUI1KulzMIWzEKZvBU3VQ4/TSl6mWPan19kftqYimD/wt5ZYPLtMlDTJEaYR9S7bXJIUVM7jZ+Jxavcl08kkT0pYvtWveSR6wtpZhuhBi2SLY+UWAXBUotrunS9QywVWDSkzv9P3pTGFhScyktDEkV/WbtXXdKg7zC8UbRKaB/LyUcSd5Z7CHzo4V2aFzq8/7ORxzqRZ/Z65s1Szqo1QsmvgXL0fnC+wvxdmV573M6hl9BFMrBDnm9xELyPAMwa0kNQFUhpqeazeyJuzGSDNL9l+2lg4nrKncrYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMr2MYQgeR8olM1x/p4JBwToPzbzxRkmo/UwInWkeMk=;
 b=hCB4LHe11kkOcpInb7HjgGCJYPrzO1CmbNMENK+HgPO+j5gB2tbgTcDkZ8V+inkCF5YiRO2sIhuy3WbHRb3SQ1fRKezPUfgLvFVRgzUxyKX46t9po60GTaPtUW3mLGRMgHGGXTygF3CmBcutoSYek0j7k22kz++L7xGn0awMO6DSwC+VJ685gelY2OPMp00lDb2gEn2udbBBJD76I+YvuoaJy2mZ9a4AnowqEXJS8e0B1AW5gMByauLauUpMkooAzlKSxx6ZInWzXfQoBrgnT6Y+kAYGbAxU8dX+MGvLaA37ledORtiz9vTNKoH31YVS53iNLHhljLmKqUWepZGn3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS0PR03MB7225.namprd03.prod.outlook.com (2603:10b6:8:123::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 11:23:13 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9678.023; Thu, 12 Mar 2026
 11:23:13 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Nikunj Kela <nikunj.kela@sima.ai>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v1 2/2] phy: micrel: ksz90x1: Issue PHY soft reset during
 configuration
Date: Thu, 12 Mar 2026 19:22:47 +0800
Message-ID: <20260312112247.30570-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260312112247.30570-1-boon.khai.ng@altera.com>
References: <20260312112247.30570-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::6) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS0PR03MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: b0754933-57b4-4ab0-2538-08de8029bfb8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4ahsFUQXQXWvEPyG7eaPchWf2Xz0XeA8Hd5Nqsf0fO6hE+JstuaP0QJGRL4rP89r62X1mciaTPeqQKThpp3Rb1gObk57SsOSA4ofXFwkZRjiMWTrUpv/XV58i4U0QE9ydsyDFbXvqW+O6DHv0A653fTvF8uUXo+yBJHu8FRhbenC/2O53bnm0Po6Y7xJaznaJTYNOjLpRYuDuFjAF0m0igU3WdFpaDR3V6QZ9KuvTF8Nn4rDWJ6dUAxGoXAxew0Nk4VTfuuhS6JskV6E4yqleoyGvwBVasHO8W6yvsmTSPsLFRsET2BOfU0pcwJJh//VqKloNGeTi6iztB8ua+PmYULbyF1FMHq0MmUb7YidUUjp5hiPGlwfFnujOblBg2oAKJrpXabSdQd4lF5LMvYNr7VYkjZu3fxSQU7pger+mDJp1voccboq9AXK09EbtaNYJnn8+GQqUqVYLnp/4olVFXDXbH1rVYZf9iJtHS+f8Y5URGECKn5yzFUyqQld2K12R7yqGNjgZA783FLWTRFBTjk5nVmbQAUCoVQv+DR2FeCmRZ33EytuHcDxoYaTzUfpCxfSvQAkSAz54rGpW19s7d6+E/g+TfUweq87qCs6ZjOuO2nr3VpmLrgnjAyPj2K3qWK4kHsD4J2/NIf7g1uBtG4avbCrDq2d9/BQGSlI0YpGrBRzQrM5vqcVuCPbSb6uBSI8vVtRNZR3tiDNUpfPu8Nz2sVXLfo9xdATNo5vTRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdOSrzbRrijJ4f5gZWLkIEpsD2Cfm8exKwaRloGTV0bJvZBgMnI+UaQwfJC3?=
 =?us-ascii?Q?s9he6KDoIGWoXdxEhOO9fC2rrAOM1s1aQMQin+eDeWtPACAxqV7GlA4fcM6q?=
 =?us-ascii?Q?9nN7PcwLR0dQEAU2M+kHlT2EEijR/r3YKQkB5NCB44kM69dMsV6P/ss1b4sX?=
 =?us-ascii?Q?Oh4RDKz/RoxlzpgepiMwvkML1wr+6/8D+1Yceh0l5nxT6SmR8UmRvcmWrZOV?=
 =?us-ascii?Q?kBqGJmEg+rCc7Ov6hGaZYRRnijycMeI63WoD355oShU85kcU/gbX7XPdlCCN?=
 =?us-ascii?Q?+GvYcT4Stv0vHlZ0dOfX4As7+mgzO8C5ycRhau5ntp0l/rVPRzwgHWvMNiyp?=
 =?us-ascii?Q?WebfFFiELKYqDgUkHwn2F+kkazLqe/xPjp23NP3PCXQnG6Zunx9NSDqEwT42?=
 =?us-ascii?Q?XKmPAh+KbvqoA/HSqhRUKi4bQdQAdDZGzxHWdp6WzOveWLjEfIif7liMKrce?=
 =?us-ascii?Q?aKhK2xUEca2/1zUv4LtXLbBqA+O02lWqnzJI7J7mXkvQpGqXyGss2fvrNEe6?=
 =?us-ascii?Q?+VpThSrBUIuXPzP/QtCrZGJObawzS9ui5nMYqWweUNJnBB/bL+49A7+A0yYm?=
 =?us-ascii?Q?f8nZ1lJxLIgu0xpS/ghH3TmejNUJpo9spMuAC/ls6Kqr32+zrFn2PjfNoApM?=
 =?us-ascii?Q?UfGtP787GL716GspxygVSVI12Hm6wV13YG40GJpMaYj1XQNlaOGR2c6/Q2Or?=
 =?us-ascii?Q?ZmKAB5w+0/u5XxoYnC3Kb1Foemo+ZJR12soC1yI4BlM+T7vgDAMuLw4O9QEI?=
 =?us-ascii?Q?B+E/odkDH5Shn0cmbyQIGN6zS48i5NHp4y36RvpN/xwW6CViDbvTsEs62lgy?=
 =?us-ascii?Q?wrNc9Vj6/bIFPDud2CE5RHbEX5xV2nMUJPoLBxlna1wJ+9GRqYUvWhvY4NpV?=
 =?us-ascii?Q?3YwuyAIF68BGSVjbvSbJiQbpfn6VvDQxCM/Qpl2TcRNA96ecXdSVJcdWO2i1?=
 =?us-ascii?Q?Q4L/VLz79XOTJKll2g4JW2v3kbStfljVZrpAd2T+afbIUS1Ga4ms2TlYPbM+?=
 =?us-ascii?Q?Yn+DjgN0jO/VPtCtSWImhymAmO2/E/NMsGH8NDqJWKRK0+DN6Dir3HEdIsR2?=
 =?us-ascii?Q?2vLB22NLwwbxTXyX3f7FTlteq5RvIEpwX7LP4WqOa/hTdGTcyUan4K7azYD8?=
 =?us-ascii?Q?gNtFV0mVCcfOl3S3dk3Kk3er8WLtujt95gfOopXROI/qu2JueruXpEpRH4WY?=
 =?us-ascii?Q?3mcgacCzKu1zx5GNDBlaGXklzXrhVkupPpYJqSiJ17FvRzNKG8jFWi4whCfQ?=
 =?us-ascii?Q?vz3GWKd5ZgMl15Kfa0EC4Ne9QnOe05fsbClyh0bDZ5ls+i+6o6VK+4carIrB?=
 =?us-ascii?Q?+Vxnw2XLcg4UzS+FJ0Y1PmTyTgSawaQQAofg6wIGmcIdoSR+LX8hZUIr0KOL?=
 =?us-ascii?Q?2EV9t3f/DObVwpGYySkQ03RMhAgfvk06IMOjMgjzxksISCj1GF1dN1+yraWp?=
 =?us-ascii?Q?Vw7fyX72n5YITj4AcM0J3yikBZQ2BJgpRE4umtju8nzs7DLx568S0aojeUlM?=
 =?us-ascii?Q?ZnZUwKqj3QfO0PqSUfKDwfbJicoXBnvrcSvVwzxboTVZ4P/IgnfwrBdcCEhX?=
 =?us-ascii?Q?pi6UlVJl8YCdQQSHkO1KHondp7Y06b9blL9dGxVb+cLijHd85eLe4uLmM6Rq?=
 =?us-ascii?Q?7Maban7LUqDbOG08CGqtLhCAdPP/VKnPW1pTyLB/uZrspOgPOGQQyN/Q4O1H?=
 =?us-ascii?Q?lnkugNAwZOt1N8Xi4wAA7OdnuOijytxvfYQlGcvvG95fWv9ZoyAhWJkDBPnl?=
 =?us-ascii?Q?5sje5b8rpQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0754933-57b4-4ab0-2538-08de8029bfb8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:23:13.4930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Coq7xHOJfGjwKPBubN+mnOfCoWLKS3OvY9xJzT+HV0SfHxF7vtZOFox8/S6p/K7uV8uVHDGt4k4q3L7x20Z0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7225
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:21 +0100
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

- Add a call to phy_reset() in ksz9031_config() to ensure the PHY is
  properly reset during initialization.
- This clears the power-down bit and ensures the PHY recovers correctly
  after Linux reboot.

Tested on Agilex5 hardware with KSZ90X1 PHY.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/net/phy/micrel_ksz90x1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/micrel_ksz90x1.c b/drivers/net/phy/micrel_ksz90x1.c
index f357e0f1c77..1a7116f4ddd 100644
--- a/drivers/net/phy/micrel_ksz90x1.c
+++ b/drivers/net/phy/micrel_ksz90x1.c
@@ -407,6 +407,9 @@ static int ksz9031_config(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	/* soft reset */
+	phy_reset(phydev);
+
 	ksz90x1_workaround_asymmetric_pause(phydev);
 
 	/* add an option to disable the gigabit feature of this PHY */
-- 
2.43.7

