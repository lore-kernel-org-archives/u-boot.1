Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73450D41C27
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 11:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D91839DE;
	Thu, 11 Dec 2025 12:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HpIsEPrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 166B283A26; Thu, 11 Dec 2025 12:42:46 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 771E88334F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 12:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eek3iUSlkq3fFkOQGriRUMgJqbYT9dtE5KitYH/+dOlQHbbXpAQDk6pODfYDiLO07U5vnZdkV+dk8NtToafsVZdQt/WL/ZY9sXD6JRK+BpJIWLgGTSaOV1ShphlD/YUZaRgSOBtSsraqNhmCLgaOd135nuMgtbc5UHzIvCGTcnQX3JEWSgyyXSdd5hCYv3pxJS9aFwGBZoRzte1uBLg+t65Ro2/JusKbCxYOf5843WF7/DUJ2h/+kA9Morijs04UrVKFlvTJPgJwbeRUt0rlXPSG5V3BM6S0cw2tNq+O/qYRm2w/+IdZijPGqizp50nRhvcPpq8bP4Xg5EtU+uU6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrvPe9r/MIyxxmX/mSnsHoE5+1cKUx6f49LxWzXd8Ho=;
 b=BBIT55u83FU6bnSr2OggKmam1kzC8Kkt6MmP5BJtnXD96Z9egFAA9fYWWwcz2Uhk03egFzyp8A4SnbmjSXIT5vw0qsTZ7CT6lBalt6SYD3tiYw5w7m30pIJVAzyGYX0Zg87DutR5w8p67UC/fAZFDRNOSpAptC6Wn3F9mHI/3q6i7pp55tM7G02tSJouqjEO5AWcebNAa4ny/Ik3eJCa52Bs6bo78uuvgyWo7lUv/oGpfBF2tusTvEspcoGrHhTU/8pfC2XoPvD4AQrdTL+I66eMnK5+NFznFjw/4nuf9B2w4DQkPE3VI9WWsUw0c6xTfAw3MgcjYStA14YguzbV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrvPe9r/MIyxxmX/mSnsHoE5+1cKUx6f49LxWzXd8Ho=;
 b=HpIsEPrQbHdLAbuJu44zGqQKqYgukyEjuw7s8O0k7Q5kwutCcOy0QZq0z2O9nAv/He0FYbB2S+4i1bGqggd8GXfKty4/IVNNglcv5bnZiMoI4NwpR4Vdk6KnNpNYzlMHAoI7VYqt12U2A91KToXgbOg2FmQM3xRiy9ElDd5HmXE=
Received: from BN9PR03CA0848.namprd03.prod.outlook.com (2603:10b6:408:13d::13)
 by BY5PR10MB4241.namprd10.prod.outlook.com (2603:10b6:a03:208::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 11:42:34 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::c2) by BN9PR03CA0848.outlook.office365.com
 (2603:10b6:408:13d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Thu,
 11 Dec 2025 11:42:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Thu, 11 Dec 2025 11:42:31 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 05:42:27 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 05:42:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Dec 2025 05:42:26 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BBBgQuA431105;
 Thu, 11 Dec 2025 05:42:26 -0600
Date: Thu, 11 Dec 2025 05:42:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Sean
 Anderson" <seanga2@gmail.com>, <u-boot@lists.denx.de>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Christian Marangi
 <ansuelsmth@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Marek
 Vasut" <marex@denx.de>, Simon Glass <sjg@chromium.org>, Jonas Karlman
 <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251211114226.jbggbrqlcfq7dbur@exterior>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
 <20251208153852.GP303283@bill-the-cat>
 <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
 <20251208163527.oq7vddgodao3legu@unguided>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251208163527.oq7vddgodao3legu@unguided>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|BY5PR10MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f093bc2-3964-487b-aa1f-08de38aa5ecf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MBGcVEBpklKaWwKgXs2RcvF2AhMVHm9nVKgYFvs+1sMMB3eug7choq7SJLCC?=
 =?us-ascii?Q?2RdNviMdBVL29tTGpi9zRPwtNdjihKIQTzJz2x2ZRHCrsm5AHnBXhO7PQXkt?=
 =?us-ascii?Q?ZyKoLRE40Vws8khnQI/mKkY7ZvhE4AcKpKXhhz/ZFoc8GwvTflcp+dxW6wxp?=
 =?us-ascii?Q?bc8MK+8Nobyo4Kbe0OFniomQSL5aNh8YLhORVEfyyogUiluOsBKiLd9XRJqG?=
 =?us-ascii?Q?gkinRBI6GmR/H4Gxn3xceo/iSunNhDKHNMVQHatU53pz3NKsKlAWuCFUH87j?=
 =?us-ascii?Q?wL+SiNNg6bALnnF21mReDlzGrLv+L9PdifTsqgQctC2fjShDR5dLNew8p+ve?=
 =?us-ascii?Q?zbLQqGRc9VWoVJ1o4rKXIDjLwaGR1b/LcyulZmeMS0C0dkYaNwNE56yojpqA?=
 =?us-ascii?Q?YHM6MQyaANN/Z/x8vp9mBSmW3wWIiQLgja4eCObDzTY8lvtoSOD9VJWw6v+c?=
 =?us-ascii?Q?otMgDBk2n33G6/VmwGHWweT+qDuXTbpj3WypbxrGhbnO8CaeaITdvMdbJh/9?=
 =?us-ascii?Q?sbp858guGhFXPHcHfC2JGxRgcIMPaZrQff95U/m9HoBCv/YbsZ0OC2RIC5/H?=
 =?us-ascii?Q?4vJshrY16TnNhmpxEdf67AB7a47YXd5/VL6MEiTq2hqHxBj4hCas6hTg/p/E?=
 =?us-ascii?Q?48pttrlqgapDow/OCd1tt5t/vU2l21HLC6eMk28hEkowStj/ilshnkQ5JJnZ?=
 =?us-ascii?Q?r2QSWG268xP1aviKuZ3U/APZiHRR7O7TlCvAYNgymu6rVCfdz3e5PuVWl5ll?=
 =?us-ascii?Q?Ie3Rg4Swi/V+fX4yC4/8EOlIrVTjqaVEoFDosJOXmlqG8f5kZWK8EazxWGWS?=
 =?us-ascii?Q?kbomGFaongpmZDKtnZNYa+2qaDJbwFsAr24D+SAbYO2qMDrTLU0Q0bv7cwqH?=
 =?us-ascii?Q?HwKhv5W+xRkI+40A/r7wavfR4o3+4vHSbFfQ1iV9YhDsWKADR541zBim0S4j?=
 =?us-ascii?Q?q86zzEL294OS46UMp7DZ6IIJpZf2OLIGCnaj78l8bbwOFGAXhr9adAw2vxgA?=
 =?us-ascii?Q?OrpMjQ02cXN3QNXvFn8ueIFYywBGIlxmp5QC1fYIAChQa58KQz0ITX3W5az+?=
 =?us-ascii?Q?QproQE/Xlg4UCtLeBNK0uGSpA6cFBHNJ4RzeMK8KksghwFta7eS/iwXaYXPc?=
 =?us-ascii?Q?VZNqsi5TPhrtSIwV/uhB9PIPnOeTZ0EVF8/kaR+BYSel6HUx/Vvou0cBs/dM?=
 =?us-ascii?Q?sDL3RQ/QLH/YJ2DBcFrH4hIzOAaSWQRUuaK4wmj9bqZSf4DE5jfBMzLLU/yd?=
 =?us-ascii?Q?iF1isD7lXfcU1DRCf10xjznpMa87r6abV+r2W4Jobdd8PYTZ8Dfm2SOnK8gm?=
 =?us-ascii?Q?jU7X/ZNO0xiMicj/867Q45n+szDV4qvbJZ9yLh5q6uSReYpNnyOxQCd+IzcJ?=
 =?us-ascii?Q?z6jIQt5VU/J/heljl5abopBe8A+uFi6mDuz7uNbGtrm9jNNJG/ZvC8TVhleP?=
 =?us-ascii?Q?hwU1ySLbEgV1XVCHTwJw5sR55ROfN+xZvacOLRZwr5VeyaXohqEtpyJBDAwG?=
 =?us-ascii?Q?kduFKcYu+1egJwRjEe7/0lUfcKa1rWYhTYh9T5P6NLaK2JJnQ4vcWlfi4mDW?=
 =?us-ascii?Q?FZQquxy0zyqf5fsBHmw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:42:31.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f093bc2-3964-487b-aa1f-08de38aa5ecf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4241
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

On 10:35-20251208, Nishanth Menon wrote:
> On 15:52-20251208, Andrew Goodbody wrote:

[..]
> > > > Confirmed by reverting the commit. Looks like
> > > > 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?
> > > 
> > > Interesting, OK. What Andrew did in commit
> > > fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than before and
> > > there's two stanzas there. Our lab is current being re-worked again
> > > right now so I can't test on the K3 platforms I have, but can you please
> > > see which of the two changes in clk-uclass.c is the one that breaks
> > > these platforms? Thanks!
> > What is the breakage please? I did put this series through CI and the only
> > issues were due to lack of disk space, so not related to the patches.
> > 
> > Andrew
> > 
> Looks like A72 would'nt get started.. adding a bit of print to get an
> idea:
> 
> https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb
> 


Any suggestions to proceed?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
