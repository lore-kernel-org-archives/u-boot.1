Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F9EE63F2A
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 04:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C9280FA1;
	Mon, 16 Feb 2026 05:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ttMFlKJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D8B83AB7; Mon, 16 Feb 2026 05:36:00 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C630D8063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 05:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9Q9eopYS3CenMHTixthahO9Mmcu2QKzDZMqsMpjIkWV/RxEysjZmzaVu/XGFIuj0XwhacJTaAOecPWhWDzGmS3xLLH+sd8wGM3nV6R0+oNDpng8tKQWIdNf6Vk/kd7GG+XZCqQoX8VmjAatvpZU3tVG7GOeVHHSeUyOay3ZTQTZ09RkqwqwYtt7i7DFnWDjSbH+asip5zIoChDCe+6dNbtbM0C1P5MY6J9GWfUgTtexAl6wFceWLMiAboYSeXfEc4+oClhEMSWA4R8SOjP4pWO8YPTvdbgXaJ2oFGgfYq4ksopTN7sAcKGI6YQ3g90S9NYRJAPJSdheOatalH3ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qI1ttKK75CvuBgZYHNgLsFT2W7YkKvUmqIac0VkrBRg=;
 b=mRrHJGRz41J9KPQrrz9h5Y7gDsF6a+HFKCSDhBLlYpQAV707OVI1fubagQF0/kvxY2Giq7bGluZdF3qtNThDpLRL7a4pFnNrx889AjUp+sRHDdkP8GBtZ4/JB9SEoijgiJnKjGFn1Zo/zoCSlP431UYu7i2DtGKAN13CGDkNRd51AvxfSXffK+Q5YHG2fSJ5pZuZWuAtvjK3/Iecgqr4bHWH17YAmnAwjEZGpOhgpL5eMo0vRGmoZQVKTY1m0DFwQaZvxT6Sns1sGH2K+VtnJCXXd9n5iIEdJL17IYbwSjj83sIXoi6KfvnKc3hTJ6lHVSwc7IhvVWil227ceVxlBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qI1ttKK75CvuBgZYHNgLsFT2W7YkKvUmqIac0VkrBRg=;
 b=ttMFlKJx+ebWDFQ2mybkUyyqcU/AJUnrU7zpBHbu43yR9yY4uEvvpugLLXdvRPHT5KuTc5wr8OWmnsvh9kl4ayFmTz7RZdReU0KIqxNQDuUrSuRal9xa0ebJhLkI7BdHB4i04HtgfW1gGDcB4CYdV8xxbrgT67T84m144uLimh0=
Received: from PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::15)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 04:35:55 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::2e) by PH7P221CA0019.outlook.office365.com
 (2603:10b6:510:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 04:35:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 04:35:54 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 22:35:54 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 22:35:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 22:35:54 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61G4ZpYN1176075;
 Sun, 15 Feb 2026 22:35:52 -0600
Message-ID: <301f3523dc9c6e27c79f44c213a9370f48c06cb7.camel@ti.com>
Subject: Re: [PATCH v3] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Mon, 16 Feb 2026 10:07:19 +0530
In-Reply-To: <d1791dbd-8d1f-4ecf-8b69-62b4f1fc85c2@mailbox.org>
References: <20260215123514.2288422-1-s-vadapalli@ti.com>
 <d1791dbd-8d1f-4ecf-8b69-62b4f1fc85c2@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7a244b-fa3b-45e3-56b5-08de6d14df52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VU05bjF3ZTQweE1pZ2VHcDQwREpGeWN0SDVxTWErTW9Sd1hWaXRiTGlxK2FC?=
 =?utf-8?B?OVc0c0JhWDZhZnhMdEZ1aTdsd0g5VW54bjlITGo3a3Azc0pYUTZsZjlQaWRL?=
 =?utf-8?B?VE1pRFBlUmRMR2szVXJsRlFMaS9HeEN0U3N3R2tmNm55aW1ibkdwcldIUm9C?=
 =?utf-8?B?K0lyb2xHRHN6SkpsR2o3NzE1QU1Sc2tMZVpZbFpnTVg2QWhHYWlaeWxkSldX?=
 =?utf-8?B?a1ZkdXcxL2xCQnJobHJNQUpTbHg0cHBPY0NwYWJqWHVXckR0NnFtMEFzMFFw?=
 =?utf-8?B?RUdXNHdhZDFnMUhuZkxHa1Y4MTA0d0VTMS9tejJWUVpYY21WeFJIRVdyVG91?=
 =?utf-8?B?cnBVU1pMeTg5WkFGUEVseGxSOHZham0vTHRqNnhLc1kvaFlZZW4xR1F2UHNF?=
 =?utf-8?B?bGdPSk05bkdQK2RkVzlVR1d0L0V6ZnNPV2xmZW5PYi9vQldlTFlGS3ZjZVBu?=
 =?utf-8?B?dlUrWUx6YVZ4ZEtiRDVvQldqaXp3eVlZZ25lcEZ3Ry8xQXpDSWtsc28wTUxh?=
 =?utf-8?B?SjNFTU5xVzRjQkZtLzQ1VStHRjYvWGpkbVVyYzh2RGsxZmFBY0ZmbVJhUGN6?=
 =?utf-8?B?OUl0TzhoUHBLZmR1MVdtN1MwdndSSTNCa012WlJ0NkNUSmRNZXY4MHZQYlFF?=
 =?utf-8?B?THRsUnZCRzRncGtKektHb055dUowZ0Rra2w0bWlHWFEzMG9Vb2dIa1VxQ05Z?=
 =?utf-8?B?b2tRa0pDY2VQekYyVUhra3RFaHN4S1FLQVVzd3RxUzIwTEZBd2hXdGFIQldz?=
 =?utf-8?B?QTIwd0tmd0tMVVZoOU1jbStVVDc4VHI5YWpjRy9BYlBqRGZFQ2szUEtrTW9x?=
 =?utf-8?B?SXJ4TEZ6Y2F3VVR2MXErT2ZUeEJVdVFocUw0WEtBU24yeDBnNVE4OVBDeXdH?=
 =?utf-8?B?MWRQR28zK1BLS3lzazZUV0FlQmUvdERSZm1TdzkwYmVNUWpvdGNsQlBsRmZP?=
 =?utf-8?B?cDJFYlRxbzlZR2s5UHFVeHVsVTA0aHJzNlBOV3B0aVJkeUJEZWtBS0QxUTJp?=
 =?utf-8?B?STVKU2tQZk53YkZkVmdVVjF4Zjc2b2gzUmc5SlNTRWtLOVY5KytxazZTUVpZ?=
 =?utf-8?B?dmpBTkZlZ2ZxMGJNdG9qZzVGQ3BsVXJ5SUI5ZkpObVFTQXQ0djdGQzhTQlJ1?=
 =?utf-8?B?VkRWQy9ld0lsQmM3VkprNm44Z0pnUmo1aFlkcWo2T01PQnNYSXR3SGFUT2x1?=
 =?utf-8?B?Q2R2OW9CbVk1RVZBZmVBdTRQTHdybUI4ME54MWtKbU1OcmJQZkFBaXl0Sy9J?=
 =?utf-8?B?UTNFeHJXdXhoTG9kUW04ZFhISVZQTUY5VmhURlNFYVNVcllpRVZYM0RNR25i?=
 =?utf-8?B?TkdUaW5Icmc1OHZSRmF3d0xkUUJBM2xGV1RKUFhCOXRvNW1INjQzNENqUEcy?=
 =?utf-8?B?OHUwUzBkdzJmdUxlUkFXdEdKUTVrQ2R6M0hNNTBGQUxWOVFxQVhSdVhSakNU?=
 =?utf-8?B?d1cyYVpVaXViK04xNkxZMThVOE9wOHJmaDRPclpMdzdhbWJJdm9NN05jSDV0?=
 =?utf-8?B?Y2NNeTF2WC85TjJaMTRiR1J0NXZVNWd6Ym1xRDBqdlVXeGk3ak13Ti9CaFBq?=
 =?utf-8?B?M2tyaEdJYkJIYkVsUnR1ZDUrV0dVTHdZcFV6ZjJLWDQyVWpkREpVeC94eFB1?=
 =?utf-8?B?QktKeTczS1dQVGVsWDZUUDM3dnhNSE1EbzQyblVZOHlhdTRxRytqVFVxaG9V?=
 =?utf-8?B?RTNJNEdGV2FDK0lwblNDYStlM3FWTXFvYklUYWRnL1pKYVNLMXFESmhCU1FB?=
 =?utf-8?B?djlXQi8rZkRheGVxMFVuTnNkVFE1UzVldGZkdzFZRnNKc3NteWJGclhEVU1u?=
 =?utf-8?B?ODZVN2dYeWJ5TUExeEVWWWJuczhXd2dvaWFsZnBkUVNEZmtGVFhINFRJSDh2?=
 =?utf-8?B?Y2hVa2xDdVhUS0tReFYvVDNHSHZLcCtObzJiOGRZYXh4bjg4emNsUjRXbVRM?=
 =?utf-8?B?dW04NkE2MFNBVGRHQkNqeXRSZHh3WFFoeGI1U0psU01reHRLUVdBRkpKQThU?=
 =?utf-8?B?Q2JIWjQwTmJURHJ5ZUJIbVZmVnpEL2tjQjM3MWZlVEZBR3QvMmtzUHdXalpD?=
 =?utf-8?B?Mkx6UWp4VW5veGFtcmp2amppQVIwcmdaRytkS3BvZ1dhRnlNMkRTU1o0dGM0?=
 =?utf-8?B?Uk10NmNmL3VSQWVUeUhYRi9JSDJDbktNQklHak14OTBVWERma3JVMVpSck5l?=
 =?utf-8?B?MmRYZTFPVVo4YWw1UmEzRDZPS01ocmU2ZDR1OUJodno1NExWcVVEUFJmVllO?=
 =?utf-8?B?WFdRbGV1ckZJR0F6T3o4eGwvMU93PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KHELnJpHsQwst2NT4bLLjAhVSohPSxpehxWmAXtXgYp+XA6bVfKb14nNSI+9ucicwypkMeac67xbsgUFwe6dHylCVNAVOFzUb6rGderjmjVAPGqhKwuWfQR1aUk6qjG8M31yePjAE6tNlYtYp9k2pHguBUEA9i/+s+lme+bxux0URan8vgKdOCdHjBnp3Q76isy6RMoAznDZ1r/SgfS6GN/wy1lFA5uV51k20ijrljDyU+JhRfHKw5MQKmsb0TpDDh1q4B3LWhkC7K7KWizCVnaUlspe8H14lbAQHhSuWfVevUDnEctssCna5RbFhC6HzXZSkoqkB/36mLKk98YuckcnVercRqlTHUp3V7c5HhaCyswNIb7LMeF+ektTbbEMdmP3DUbf/PQiXFGZq+gMmOeDAQfufC2Pfxqwnu86h/zh3xFBYCxVm9VpuXNkCHLT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 04:35:54.5893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7a244b-fa3b-45e3-56b5-08de6d14df52
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
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

On Sun, 2026-02-15 at 16:58 +0100, Marek Vasut wrote:
> On 2/15/26 1:35 PM, Siddharth Vadapalli wrote:
>=20
> [...]
>=20
> > +static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode=
 *mode)
> > +{
> > +	/* Create a temporary child device for using devfdt_remap_addr_name()=
 */
> > +	struct udevice child =3D {
> > +		.parent =3D parent,
> > +	};
> > +	struct cdns3 cdns, *cdnsp;
> > +	void __iomem *otg_regs;
> > +	int vbus;
>=20
> [...]
>=20
> > +	/* Use VBUS Valid to determine role */
> > +	vbus =3D !!(readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID);
> > +	if (vbus)
> The double-negation is not needed here, simply use:
>=20
> if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID) {
> ...

I have implemented the above and have posted the v4 patch at:
https://lore.kernel.org/r/20260216043459.2467850-1-s-vadapalli@ti.com
Thank you for the feedback.

Regards,
Siddharth.
