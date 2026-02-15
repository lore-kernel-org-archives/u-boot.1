Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FBDEF584C
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 12:38:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74DB080B98;
	Sun, 15 Feb 2026 13:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EXVYMODh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6583D83AB7; Sun, 15 Feb 2026 13:38:29 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08EE680325
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 13:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCnboc7PYHxZ+8l8VGYIl13ybQie3mFn6GugxIrb6kjcTVGU1jrCvypQgYGHFglcJpDaes4Za17l7g+IVT3Zvf82CxCsuEpjCT2l1wC0hQehop/k1D9vXHMy4j8x01BlY+dVJ0wnxp1MJd8V0pWIpe+zH+hOMe9KodwHx1uztcm9g/jfPxTu6IdD2Yv7hAYdLrNw4cSdvs7ZAa62wguxFELA36nWY3n08BWyAJyhIpreoJZjXVDT0EH8KZjIk6E8SYl7/rarzBnysv90morerXheNZoRECdiQvIdH5/5vSxVkP5QUcMqDPZj8HG49F7q1Au3+oDeYQK5eQ43y1ZVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZahPK9jxHCDbHPMqxrqKclj7Y/0MXOZcSN9NIdaNkVQ=;
 b=bWyupPs+F/sHAMsPMYVijO8TKj2zBMr/rg1Mg3RnXNLVVt5lKtdyxEe98U/4rq6fpmtnA0ZfoN4bhM7ZjktomJNsr9x2ktXtct95A8mnR61AkMrz1ZJg+2iL6Bq7GFT7XUNFDtkMbdCukqpe0tom/SOcxapJaZT3HXFsRQu7Q55ewWJ3cskpkoyl9QoLuC7J5pBd8qY2VCYzRIpTTOEK5doIwHYy/laN2RjBw2IJZtmAsukq3GNN0HoAEZeiy/iVi/HANX0ShYc6fy1/FJoaJJte6OmR3VqWAIWRFlwH0QPIeX8PL4SDJGXghTYsEAbFSHMDgQBAe9nBW3LNVkYY4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZahPK9jxHCDbHPMqxrqKclj7Y/0MXOZcSN9NIdaNkVQ=;
 b=EXVYMODh375cfcEi2BJ5Y5afjJSUw3e1ifiPZlvMnKIkyp1tBEBFhH+lDHgL8zLyONew+yIS8Oa1RGUCysdaDhhVbep4CjMuI9ppZibZfz988t23KVh3ptY5+q9Wg4B3eFi0Ff5j6ZmoePLGBNdKEytkJEdJ5HvmwKMwtdtoc/w=
Received: from SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::16)
 by BN0PR10MB5080.namprd10.prod.outlook.com (2603:10b6:408:114::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 12:38:24 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::b2) by SA1P222CA0079.outlook.office365.com
 (2603:10b6:806:35e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Sun,
 15 Feb 2026 12:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 12:38:24 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 06:38:23 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 06:38:23 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 06:38:23 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61FCcKtk3920127;
 Sun, 15 Feb 2026 06:38:21 -0600
Message-ID: <5ca6e8fc72703eed92c12b90bc43fed0c4f8f077.camel@ti.com>
Subject: Re: [PATCH v2] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: <marex@denx.de>, <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Sun, 15 Feb 2026 18:09:48 +0530
In-Reply-To: <3b12260f-e0c6-41dc-9c56-596515f871ca@mailbox.org>
References: <20260213051556.1247716-1-s-vadapalli@ti.com>
 <595b83ef-f83f-4ee6-8026-853a7eb89f62@mailbox.org>
 <fd664cb27379c34463c6e0ac43bbd30c00483949.camel@ti.com>
 <3b12260f-e0c6-41dc-9c56-596515f871ca@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BN0PR10MB5080:EE_
X-MS-Office365-Filtering-Correlation-Id: f00bc20d-f54e-464b-449d-08de6c8f1c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UktmTnhudm5qNEpUS1NRaW5lT3RhSVJHekNWeEFhQ3Ywc2ZNTnFCWkVEWXJ3?=
 =?utf-8?B?ZlI3TE1QZ3UvUDlUaENRbFRLSEplaHpYb0tXMjdFZjQ1K1BDSkcxNjdPMmdL?=
 =?utf-8?B?aUxZZ2lCc2FSVWJyWjRzQTNOSUR4dUJjWUZmY0lkS1FRUWIzaFZrc0lqQWNF?=
 =?utf-8?B?QTkxVDJicHNNTWNZdDVEeWNCSWZDTjF1dURWamJKR2pjQ0xHUUlBK0pVYzZ6?=
 =?utf-8?B?dkNndmVNT3Z4eGFMMW5WU2pYWmQzaDMrUmhwbkRobDM3L0c1dW1zTXc4U3px?=
 =?utf-8?B?SVFJdmN1Z0hGZGE0SUJDWWxsL0lQSEFhWTlZWnFsUDVhMFBGL3RCK1NHYjNU?=
 =?utf-8?B?MWdhYUdRSzN6SmNJS0pOQWlpMy90WVExdFlHaHcvT0ZxOS9nZFNFSDIrMHhT?=
 =?utf-8?B?Mm1pMkhjTXgrRGJvNjNCZHBLdDU3U2k3TW1XdnREUDIwTGJhYU5GUDNhdmZQ?=
 =?utf-8?B?RHA3Ri9ScE41Q1BOYXdiTkxOTDJuRkdOWkhiNFdpd0lvL3JmV0Z0RnI3YkdT?=
 =?utf-8?B?UThzaElMbXlwZnRiVVp6WCtjbmVoM0JWYXlrUnZDVFBDR0ZvU1IweTZCdXhO?=
 =?utf-8?B?ZDhPaEVpcVFPc1RwWUkvdVU1TCtIWmY3VVNLN0RQZlJNcWZiODB4YW91OWsx?=
 =?utf-8?B?bmhvb2ZuTE5Yd21QR2ducGRlQWF1OVc5UEh2cjdEYUNUaGgzNlJkSTdyY2JB?=
 =?utf-8?B?SGM4U3RBUlh2WDlpV25mdVRJdXBYOWhWVUdQMCt5am9JM3NhSWVwMTFjK2FD?=
 =?utf-8?B?UENaa0ZtOFlQN0xUc3dTQzF1YjFYQWg3TlRWTWNFa3hhcTZnbWcwczBLb0Q0?=
 =?utf-8?B?RVdqNkFqYzc4TVp5OFowbmRJem43djFqM2lFaHFqc0lIVGswWTNPRW1ybjZM?=
 =?utf-8?B?ajVyVHp0bTFWUG9kRWNFKzd2MWZhT3duaWgzNGE3bWlzc01nODY5OUxMQjl3?=
 =?utf-8?B?MmxVQjR0cjdjaW1qbzBKUjdMTmorWG5OZGJiVHFpdm9lSDkyQmp5U09ucFdP?=
 =?utf-8?B?RGZZbFRlbHZGckxXWTVWaWhtNzh4Q3BCd1gzY04zclBmcklUcURuU1lVdkdO?=
 =?utf-8?B?RVBtL21zZ3EzWjUrdmZJT0pPZ3pHWWRxSFpxbjc2N1k4YW1nM3BadVhubzVx?=
 =?utf-8?B?SXFNakdDamF3S1lWUC9zZndQU3dBa1NnU01JT3lkaUJBUlZwaFk2YklGS05B?=
 =?utf-8?B?TGovcWk0ZGRlMmNEL2dJeGJ1Nm9ZWDFVNHdIN0s1dEoxRXRPWFZkLzFLbVVR?=
 =?utf-8?B?eFBEWk5UVmJxYTRGK0g3OGJnV2RicmhjZC9oNExkOFk4UEpHNCtUYlBaUU1r?=
 =?utf-8?B?WEZPZ2dpV2haaUV1cFk0WllWdVhIeTRxRUR5WUJ4SGFqeUU0VlFRN1doVTZv?=
 =?utf-8?B?QVhraE9DZHNvNGFaOHVHQ29mSWU4b3IraTN4aTJZTFF4OTlYMU9sZnFzaXk2?=
 =?utf-8?B?UWRPTjV3Q24yYU9aVmNNMlN5Z3pSNzk5bU1saG9XY05GcTgrNzZsK0JLY0tF?=
 =?utf-8?B?QWI3QUdpZndMZFFzT21uV0VrdkhCYnNJTUIwVlpDRGR6NFdOV21XZ1VlT2ZM?=
 =?utf-8?B?V3NtTUJTZUIxNm9sbFNOZm1CNlV1cU1xR0xSdnZ4czZoVEJFa29LZ2dpdWhF?=
 =?utf-8?B?elRYMlo4dVoyMmRvZnFCZXYvUGE1dzdNdlZpU1pqQ2I3MTRramdhTnZwZG41?=
 =?utf-8?B?N053Um0rdW1TcnhNMVlQWWs2elpYTzA0MjlldjlGcTBGYnpXTXlVMWg5ZUxK?=
 =?utf-8?B?WGhsNUx4Tzk0UHlkVjlBRFJiaDBNZngyd3pYTzZiUmlaWDR4ako4Wjc5Y3JO?=
 =?utf-8?B?QlNyTHJhWlA5ZzBvRFRLWWhZd1Z5aVRRcWE5ZGIyUHRpWWd3VWNVOGhRYkFk?=
 =?utf-8?B?UEpQbEloUEt1WlpwYkhJNFN2YkhmdW1iK3FlZWZ6VG4zS2NhYUFCamx4MG42?=
 =?utf-8?B?REh2TzZtTitMYlRXZTcxazRZb0dlWDhmSVV6NUY2RXV5ak9RTGxRNXRhWERm?=
 =?utf-8?B?RUVlZmdMSDhTZlk5L1ZJZUM0eXlpZnhjV2RyYWFvVWRwUVdvMnlLR0VOQ3p2?=
 =?utf-8?B?WkoxUlRTSEJHeGJCUVZ2OEp6QW9PV1dqcjI1VVBUZnBUdllvQy9rWnF5N3BF?=
 =?utf-8?B?bDBpZjJNMytSMEpBWTB2VXdIYkU4UWVOQlF5THlNY2VWMnNaalZWaldwbDhY?=
 =?utf-8?B?Nm9CM0V3ZFgzVmVJQ2NSRUtJR1VadEE1MExyRGF5MVgyd0dDeXpYNUw2MjBh?=
 =?utf-8?B?T2h1RElHbFlKZmxnbkREWUs0Q1l3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DCwJ/HPWuwns/UyMkOlGFMp7fHf11uzIwHIQPtwNLxzs/Edm3oNiPcDO9VQ6CGVaAdklWyyJEsbGv5TL5wKHZUQKFPEK1jwMXvPZrVKpbZ8p4aGIKFfq8bB8SMulYSlxao5dnHbhRTBXkGavcqApmuebjPxuo9cSMjWrydO4QtGL7o4fwSLVuOyQvnIVvx2j7kOpdI/7S5HvCIgWNMd7K0ePFWVyU4zh8zZRZRR612/egdl1trb1WcDPam4RmxPq1D5iin6YjSATUzP+LgRBoW2kgev+PlQL6kkAbxtlIJ7zsKzPwhFAKDI49+1t9ictXiCYQNTBM9vYvmsfEi942yUn/pEsXvo3rDyzHAfodHQa9yKfDls6jFGIrVpBPlrh1dPMm/dREptdk77HwQvR2sNHDlISWRYBW6dTONKDDTu6LUuUiAYExCNiVx2Y/2So
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 12:38:24.1960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f00bc20d-f54e-464b-449d-08de6c8f1c38
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5080
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

On Sun, 2026-02-15 at 01:04 +0100, Marek Vasut wrote:
> On 2/14/26 5:36 AM, Siddharth Vadapalli wrote:
> > Hello Marek,
> >=20
> > On Fri, 2026-02-13 at 16:04 +0100, Marek Vasut wrote:
> > > On 2/13/26 6:15 AM, Siddharth Vadapalli wrote:
> > >=20
> > > [...]
> > >=20
> > > > +++ b/drivers/usb/cdns3/core.c
> > > > @@ -392,6 +392,63 @@ static const struct udevice_id cdns3_ids[] =3D=
 {
> > > >    	{ },
> > > >    };
> > > >   =20
> > > > +/*
> > > > + * The VBUS Valid Bit in the OTG Status register can be used to de=
termine
> > > > + * the role. When VBUS Valid is set, it indicates that a USB Host =
is supplying
> > > > + * power, so the Controller should assume the PERIPHERAL role. If =
it isn't set,
> > > > + * it indicates the absence of a USB Host, so the Controller shoul=
d assume the
> > > > + * HOST role. If the OTG Status register is inaccessible, return a=
n error.
> > > > + */
> > > > +static int cdns3_get_otg_mode(ofnode node
> > >=20
> > > Pass struct udevice *parent instead of node here ...
> > >=20
> > > > , enum usb_dr_mode *mode)
> > > > +{
> > > > +	struct cdns3 cdns, *cdnsp;
> > > > +	void __iomem *otg_regs;
> > > > +	fdt_addr_t otg_addr;
> > > > +	int otg_reg_index;
> > > > +	int vbus;
> > > > +
> > > > +	otg_reg_index =3D ofnode_stringlist_search(node, "reg-names", "ot=
g");
> > > > +	if (otg_reg_index < 0) {
> > > > +		printf("%s: dr_mode is otg but otg register name is missing\n", =
__func__);
> > > > +		return -ENOENT;
> > > > +	}
> > > > +
> > > > +	otg_addr =3D ofnode_get_addr_index(node, otg_reg_index);
> > > > +	if (otg_addr =3D=3D FDT_ADDR_T_NONE) {
> > > > +		printf("%s: address of otg registers is unspecified\n", __func__=
);
> > > > +		return -ENOENT;
> > > > +	}
> > > > +
> > > > +	otg_regs =3D map_physmem(otg_addr, 0, MAP_NOCACHE);
> > > > +	if (!otg_regs) {
> > > > +		printf("%s: failed to map otg registers\n", __func__);
> > > > +		return -EINVAL;
> > > > +	}
> > >=20
> > > ... and replace all that ^ with devfdt_remap_addr_name(parent, "otg")=
 .
> > > That should work.
> >=20
> > It doesn't work because the 'parent' node doesn't have the 'otg' regist=
ers.
> > It is the child node which has it. The device-tree nodes for parent and
> > child are:
> >=20
> > 	usbss0: usb@4104000 {
> > 							=3D> PARENT
> > 		bootph-all;
> > 		compatible =3D "ti,j721e-usb";
> > 		reg =3D <0x00 0x4104000 0x00 0x100>;
> > 		dma-coherent;
> >=20
> > 		[TRIMMED]
> >=20
> > 		usb0: usb@6000000
> > {							=3D> CHILD
> > 			bootph-all;
> > 			compatible =3D "cdns,usb3";
> > 			reg =3D <0x00 0x6000000 0x00 0x10000>,
> > 			      <0x00 0x6010000 0x00 0x10000>,
> > 			      <0x00 0x6020000 0x00 0x10000>;
> > 			reg-names =3D "otg", "xhci",
> > "dev";			=3D> OTG Register is defined here
> >=20
> > 			[TRIMMED]
> > 	};
> >=20
> > The 'udevice' for the child node is created in the cdns3_bind() functio=
n
> > __after__ the function in this patch is invoked. Therefore, we don't ye=
t
> > have the child device which is created by:
> >=20
> > 		device_bind_driver_to_node(parent, driver, name, node,
> > &dev);
> >=20
> > I did consider the possibility of using the standard APIs
> > (devfdt_remap_addr_name), but since the child device doesn't exist yet,
> > they cannot be used. Hence, I had to implement custom logic.
> Maybe it would be possible to create a temporary udevice on stack and=20
> pass it to devfdt_remap_addr_name() ? I think this should be complete=20
> enough, although I might have missed something:
>=20
> "
> struct udevice cdev =3D { .parent =3D parent; };
> dev_set_ofnode(cdev, node);

This works, except that I had to use the subnode rather than the parent's
node:
	dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));

> "
>=20
> devfdt_remap_addr_name() internally calls dev_of_offset(dev) on the=20
> cdev, tests is device_get_uclass_id(dev->parent) =3D=3D UCLASS_SIMPLE_BUS=
=20
> (it is not) and that is it.

I have posted the v3 patch incorporating your feedback at:
https://lore.kernel.org/r/20260215123514.2288422-1-s-vadapalli@ti.com/
Thank you.

Regards,
Siddharth.
