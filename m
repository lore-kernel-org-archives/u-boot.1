Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DA5EF99FF
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20A883AAB;
	Sat, 14 Feb 2026 05:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RVZVii8t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25A1F83642; Sat, 14 Feb 2026 05:35:12 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0CA83642
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxVhhCX7fUkWYGUQtu+Tct+BrYp9Y6lYO/WV7ffO5FOEJhm5jUQNsCygEewPqu9Otu2giRwGMyadDL61/tR5JOe4PeO9O7pUeZc5gc14zUSEGQB/I/gOSMHOM5dYqW4GQCyvTMdI2qN97AA5CfsGQMG9YqIdRt0wTsjqnFO4a1Knx7+7qKxP4C8uETQk7PghcLRjWUfJuFFsxE8XpQyhBA3zNNXbmxTwLqWNQkfcTbH0HZpqzhveaq/YZ/lZBftfkdf0RfCyL5K3Ae428/AGkXJmet4Xd1toNjErAMjgm/tauDV6twgH06qaSReiHqeJj+E1+aab1ta+Y/NtoAKR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c4xu8PvNnXpzIyrXz1na9PQ0b27kvavtxoD0Ozbyvg=;
 b=r7+NqvEA06l26uLb6i22nNNw7JE4QSvO7xD5qwgzXyDz4v41EmVtFhKh2mpVkn7qESo660wjfpPavQ4gjcKA/5o6RdoNbpAPIJPy4xc6Gd8lXvhDZ17F8WD9hrV2CutS/tHbJHDpNqtiHrBeJEVBQgIPmvoDieVSVMTq1TVg+6G3Jj5J9Qrwz5GgloxZTXQZl6Mvg0jlgtgup3wBna2+K3ptpEDfGDORLuW4tgLUHaTb+0OlN8KRBmWUaenGfLHQy0cqGOKhiBHHMGgtV/v8XF9qJFE0RQaonmhwucfba1j0atkw6IeozlrafTbb/ATWy30epYI6PomiFp0cG9mNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c4xu8PvNnXpzIyrXz1na9PQ0b27kvavtxoD0Ozbyvg=;
 b=RVZVii8tMyjZFlfcTh5mOh2c+P8ZCqwBQZyeg5AV9DGzk9O/xlsTZjLc272Wuj1pvioUvsMNUjC+owkxTjt4cqADdKzNd8HYZ7CD0uOmGHiIyo28CtQrFEE2rHWjC5+9dAzTqpPiONQkVosbTLlkaW8cJlqZbMqCA3Gh0FJvHUA=
Received: from DSZP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::6) by
 IA0PR10MB6793.namprd10.prod.outlook.com (2603:10b6:208:43b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sat, 14 Feb
 2026 04:35:02 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::15) by DSZP220CA0002.outlook.office365.com
 (2603:10b6:5:280::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.15 via Frontend Transport; Sat,
 14 Feb 2026 04:35:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Sat, 14 Feb 2026 04:35:01 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 22:35:01 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 22:35:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Feb 2026 22:35:01 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61E4Ywpv1911410;
 Fri, 13 Feb 2026 22:34:59 -0600
Message-ID: <fd664cb27379c34463c6e0ac43bbd30c00483949.camel@ti.com>
Subject: Re: [PATCH v2] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Sat, 14 Feb 2026 10:06:26 +0530
In-Reply-To: <595b83ef-f83f-4ee6-8026-853a7eb89f62@mailbox.org>
References: <20260213051556.1247716-1-s-vadapalli@ti.com>
 <595b83ef-f83f-4ee6-8026-853a7eb89f62@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|IA0PR10MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5a2021-bd8c-4198-13bd-08de6b826b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TCtCZDl6RmRoTGllN3F3VHF4T2gxZTRCdVdIZm9IL09FLzJZMXp2VWNzeWht?=
 =?utf-8?B?WjJkVDQwZ0tEd0YzaE84ZGpkNlhkY3FyR2dadTh4K3ZpaExPY2l1NTd1dFZM?=
 =?utf-8?B?ZTc0aXgrRndFUTNSSFY5UEdIU0lXZ2VVbHovLzBxNnd4akhWbkVkWWgyVklU?=
 =?utf-8?B?WXBMVjVVeUV5cHp4a3BhSU5DUnFQSk9qOWcwcEpnb045ZGtvcnptWXNOWG9m?=
 =?utf-8?B?SkdJNUh1eEtrS1FPTFljSDhuZjU5ckpqWnBKMDNSRHpBSmg1WEpuZ1RoNGt6?=
 =?utf-8?B?MmN2WHlHU0JyTzFBWDJ0UUxRbkpNcHdlZ1J6QVhQR3pnczlJYkJiazd5bjRl?=
 =?utf-8?B?NCt6M1piNE0yMFRjbTZhekpLWnczTkp0OVhvbi9hbm5oMTc4QjZ2dVpncWtv?=
 =?utf-8?B?bFE5UUk1Z1NSWlRQTHgxVVBkdzVWdXNvYkZEZEg4SG4wd0o4OEV0VUcvWTZN?=
 =?utf-8?B?U04zSmliQ2V0VFFJNXFXMlVYOXRLbjgwRmR1RVkzdmRNbjhmcFU2bGN3WDZu?=
 =?utf-8?B?cmdlWnZnOWtvc1JRWlZqQzlTLzdabEliSWdFN1R0R1pHMEJuTUJVTXlINzVR?=
 =?utf-8?B?QU9zTk1uc0pveDNIb3F5T210dldTZnBQaUR3QmFRSUpHREVGTkxEUDRUS05Y?=
 =?utf-8?B?ano5Qk1LY0hQb0lLNkhrRjV0ckhmVDVVM0hIYW9CQmhyYjlQVHFSZmZscWt3?=
 =?utf-8?B?VEhjSFRSdDdSMGluWTlGTzNpeG42dGZ1NGlRbktnRHFXbE11R1ZWeXp4YndE?=
 =?utf-8?B?cEYvVUoxaS83aEo5bkV1cnpFaytuaTB1SVNqRytWWVpjR1htZUR4dS9TbnJs?=
 =?utf-8?B?TnE3bFRYTEJ6VENnSXhnUUppbzFsRmdUWXNEdzh4cEdzcXFndGE4UFdVbS9Q?=
 =?utf-8?B?aGVKd3NSek04Q3NkRUVicjJUek1vQ1p2ZkxpcHQvT0VPUStWQkVJb1NRSFJT?=
 =?utf-8?B?dTBldlRMTEM1NlovYld6NHRJUXhPTGo5cXBla1VDMUU0NU15dVg4ZUJuR3Mr?=
 =?utf-8?B?UVhrbitXWXNXZlRLRWsySnVHZjRHVjZmZWIxQUdPM0FHbFNNVm1Jd2c0dXBp?=
 =?utf-8?B?cTdwZ2k4K0RXQmVLZXpRdGZjWWt6SWtndEFZTGs2dEo4WWtKNEVBMzhPU0gy?=
 =?utf-8?B?NG9RekpQdDFmT0JlaU1odHFCYnFrc1NMYlZLbXF5ZEY5QnIra3hOVjdBWkp5?=
 =?utf-8?B?UEhyZFRmaVExd1pRd2pMQ0hGQmtSa1hCaGV3b1RjelNJY01rRFBTK2pqbXVF?=
 =?utf-8?B?R1hYVXQ1blZZNjNGOW5xMFdyOElzWlkvUlo3VzVEb2VqZkxlOEcrUVEreDRR?=
 =?utf-8?B?ODF5SFI4WTd3U1JXaGdGZjEvaUVxcEp2dXUrTElzVUhxMHVkck8wSEhtV0Ro?=
 =?utf-8?B?L3RFYlJWYmpCSDdtUTFwZXNiUnQ3ZXVRRnZYOTFCRFRxMjRFR2hQK2tiVjcr?=
 =?utf-8?B?U09maXR2WlEvVGIxTlJySms2cGRaalBPNGFsdGJsV1hOdkdFdkxkbzJSMHk3?=
 =?utf-8?B?VjVJaUlYemtqTGVhc3UzM0tmRGxyZjFycTMxSVphbllXYzlvZ1JRRlBWaURw?=
 =?utf-8?B?R0RhU08yb0NOZUlFNXdlL1M2ckNuVm1MN2U4R3YzYU9qNCtTc3BKWER3ZVlt?=
 =?utf-8?B?UlR2b3ZBQ0RUcnl3SzFjVEJIMDE4dnNBVzh5Q2pSQ2xoODlSdXBQTXJzbnhs?=
 =?utf-8?B?ell0c1dJZFEyMzJFeUtJUGZMOWZEc3VldFpNbTFEUFNmYy9rWVd5WWZ2UVNk?=
 =?utf-8?B?RWlReVhmUC9zaktyNVU3Z0lUbXJ4R2xvY1RXWm5IZTZmRDkxckszNFMrb0pG?=
 =?utf-8?B?eWo3eENWVWp6enJyVDlkVXpOUmFyNXE5WFVHSzFPV0JuK0pNVG9ZOHNvTCtF?=
 =?utf-8?B?RktyZ2hCRlZaMnE5VjN2YnN0d3RobWJWdGs3c2U5b0tZS2ExRHF3OE5wTWZn?=
 =?utf-8?B?cEdsaTdidlllR0xjL09velhOeEVja1BKL2lSdHpFUTUvVEhTY0JiK0F5TWtH?=
 =?utf-8?B?MDJEcE43MGZWZjdleVpUcEpITUZScDVxQ2F5V3dSQXVJcGpNYTh2a1ljY2JH?=
 =?utf-8?B?SXVzVVZZaG92R0ZqZW5XT0FQenBUOTJxeENoY3F6bXFydjUyQldrZHhPekgv?=
 =?utf-8?B?czREeTJISDFkcWpFc1AwWk9LenpObkY5TE0yeHZIN3lQVUNYbVR2Q0Y5Y0Ra?=
 =?utf-8?B?NWtFcS9CbklaVmNQR1FNc2Eya2JwTU42cWJxelNvdHZ3a0w5TGFHcHRYUGtm?=
 =?utf-8?B?blNTOXY4N3BBVHJjUjViRTVYU013PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: glazz8yv+0MCy9p39ETjxuxrnSKG++kQmQ8SCr5ZJn834Iw5KI0JF2aSD2KyKgBKTDJFJ93rEUMWUQArUyJg7nYTUDB4d0RGlZVKmtLIQHlDmCHTpIdUFFewk0ziYyZ5/gp0IfqLkWHfDTn4cEvPuBTKCpXqWyvfm6RSauUkJlNWG3DnsoBcydqrOQ7VFVwdm2Ax7UB+pXlVRAgvc6Xqvbr+QW24/hC2QRvdew8AlbPFEBQ/8jrUJbwAgMZZJ5nfWGOfhljz4a9Aw3OW28ZB1v/4keeuGbhQHoolrZ7i7DX84BGJh/Vk4PiYUVAz+9hGJBKfGiPT6Pp52HSeqA3RIgXCdLM8NEYpOWACXKkOpixGlj3EjX8oR4O/GDLmT36XVL9wyoVEY7WdFLihbi8mCOxq+H/Vx/42l/QIlkysKBpn6ommxFiBRtPfS5GB254F
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 04:35:01.9755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5a2021-bd8c-4198-13bd-08de6b826b27
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6793
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

Hello Marek,

On Fri, 2026-02-13 at 16:04 +0100, Marek Vasut wrote:
> On 2/13/26 6:15 AM, Siddharth Vadapalli wrote:
>=20
> [...]
>=20
> > +++ b/drivers/usb/cdns3/core.c
> > @@ -392,6 +392,63 @@ static const struct udevice_id cdns3_ids[] =3D {
> >   	{ },
> >   };
> >  =20
> > +/*
> > + * The VBUS Valid Bit in the OTG Status register can be used to determ=
ine
> > + * the role. When VBUS Valid is set, it indicates that a USB Host is s=
upplying
> > + * power, so the Controller should assume the PERIPHERAL role. If it i=
sn't set,
> > + * it indicates the absence of a USB Host, so the Controller should as=
sume the
> > + * HOST role. If the OTG Status register is inaccessible, return an er=
ror.
> > + */
> > +static int cdns3_get_otg_mode(ofnode node
>=20
> Pass struct udevice *parent instead of node here ...
>=20
> > , enum usb_dr_mode *mode)
> > +{
> > +	struct cdns3 cdns, *cdnsp;
> > +	void __iomem *otg_regs;
> > +	fdt_addr_t otg_addr;
> > +	int otg_reg_index;
> > +	int vbus;
> > +
> > +	otg_reg_index =3D ofnode_stringlist_search(node, "reg-names", "otg");
> > +	if (otg_reg_index < 0) {
> > +		printf("%s: dr_mode is otg but otg register name is missing\n", __fu=
nc__);
> > +		return -ENOENT;
> > +	}
> > +
> > +	otg_addr =3D ofnode_get_addr_index(node, otg_reg_index);
> > +	if (otg_addr =3D=3D FDT_ADDR_T_NONE) {
> > +		printf("%s: address of otg registers is unspecified\n", __func__);
> > +		return -ENOENT;
> > +	}
> > +
> > +	otg_regs =3D map_physmem(otg_addr, 0, MAP_NOCACHE);
> > +	if (!otg_regs) {
> > +		printf("%s: failed to map otg registers\n", __func__);
> > +		return -EINVAL;
> > +	}
>=20
> ... and replace all that ^ with devfdt_remap_addr_name(parent, "otg") .=
=20
> That should work.

It doesn't work because the 'parent' node doesn't have the 'otg' registers.
It is the child node which has it. The device-tree nodes for parent and
child are:

	usbss0: usb@4104000 {
							=3D> PARENT
		bootph-all;
		compatible =3D "ti,j721e-usb";
		reg =3D <0x00 0x4104000 0x00 0x100>;
		dma-coherent;

		[TRIMMED]

		usb0: usb@6000000
{							=3D> CHILD
			bootph-all;
			compatible =3D "cdns,usb3";
			reg =3D <0x00 0x6000000 0x00 0x10000>,
			      <0x00 0x6010000 0x00 0x10000>,
			      <0x00 0x6020000 0x00 0x10000>;
			reg-names =3D "otg", "xhci",
"dev";			=3D> OTG Register is defined here

			[TRIMMED]
	};

The 'udevice' for the child node is created in the cdns3_bind() function
__after__ the function in this patch is invoked. Therefore, we don't yet
have the child device which is created by:

		device_bind_driver_to_node(parent, driver, name, node,
&dev);

I did consider the possibility of using the standard APIs
(devfdt_remap_addr_name), but since the child device doesn't exist yet,
they cannot be used. Hence, I had to implement custom logic.

Regards,
Siddharth.
