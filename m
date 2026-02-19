Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010A9E9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 04:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01DF883AA9;
	Thu, 19 Feb 2026 05:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qXm1QZ07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65DA083AC5; Thu, 19 Feb 2026 05:53:07 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B6883936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 05:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfList98L+7l8MqLGCSZJ3DzVM/HMqD290FVo1nRwJKL5Ik+WkIGx7PyBbsUTs2FcfW8CV9D6YP0rjMeN9+4i6BqPaO1/ecMW1CKrT08Vu07M0ldvk9wGH0raIHYzUCcuOS8+K9BN83mqGKiVDEnJvJy66w0aNQqF3QFMvJDAmQkO7zmteXwr5ob+EhSJXPBrH07GuIKsyK0SqT8pbTlqG9g99bPpJztphRv//YEavW+3KiH4WnmsqfLN+fdnRblsHnJAKE4SQE8560jzw9A7Ud+lphORDOKKAZJT4il69wvg5ivx/GZ5y+xP7T7SGLsbkBuikgqsK5UAkgejK8i9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B54HerIY0E6om4xL2mXRX4mIaKB7uaEAkmA+OgG0uxQ=;
 b=Gr/hoWKhjEqqMqjX9eKzVi4oYxN/Yu3hKarfFgIdannqiZGNAU8uKdmoQR9g8LCz10qUQDizmFAoHPzkDMLGKHA60Kwa0yMp/dNODeO72uwwgSQDZ5cQrRONKAWet+YgzzJqFHcJugyPbBT8ynFnNUMQ+yOzjv0nZORcehdYiQrPlq0bwFgGAxhn74klvqHACQZ/1PEkrn8sU4pPAmiQVZHzCaC/yU4NEbOSRqtVgUE+aw7jas+j52LgfIjzSY2EENzdebDjGcInVTEThyD0LCDy9lKT7yTDjeZ3eiaO2eaIkTqoepaimvA1wdyLLTjgcQAYt4wHaoEWpXAOsSFCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B54HerIY0E6om4xL2mXRX4mIaKB7uaEAkmA+OgG0uxQ=;
 b=qXm1QZ07sjRirSoEGUbO0Pe7GKHKBwnNbMEmbB79Jtt1cXP6erbeJzzN3aZjacMIOohV6nqYk9PUX1L53nLMrYDHiGSEaBN31ieBFJc8mwbQ224CBkwnx1aZdJT6Yy86ytcdZ75Zyeh3SVDO8QMozPkfETcDR6DAW57P2mZfgGc=
Received: from CH5PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:1ed::26)
 by BY5PR10MB4321.namprd10.prod.outlook.com (2603:10b6:a03:202::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 04:52:58 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::50) by CH5PR02CA0021.outlook.office365.com
 (2603:10b6:610:1ed::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 04:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 04:52:57 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 22:52:51 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 22:52:51 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 22:52:51 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61J4qkZI1540040;
 Wed, 18 Feb 2026 22:52:47 -0600
Message-ID: <d6f733d4095a6d4619eb896d7e5ac00e55a56da8.camel@ti.com>
Subject: Re: [PATCH v5 10/10] docs: board: ti: j784s4_evm: Add PCIe boot
 documentation
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <ahalaney@redhat.com>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Date: Thu, 19 Feb 2026 10:24:15 +0530
In-Reply-To: <8f91ccb6-dccc-4f09-ab78-6e92d407f3d8@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-11-s-vadapalli@ti.com>
 <8f91ccb6-dccc-4f09-ab78-6e92d407f3d8@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BY5PR10MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: da2ed999-afcd-4aad-e436-08de6f72c006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlZhbzRUMU84eVVJTUc3SzhINjFMSloya0owQmIvbC8wWEZ5YXZ4SEJxN2lu?=
 =?utf-8?B?TitJeC9mNVprSVhwdUtCbW54djBtRU9RNjJPY0x2bFFoNGVsVjhiNkZWVW5F?=
 =?utf-8?B?SThZN2NVcm5VRWlNaTBvR1c2MlhaVklWNm5kS1JIeEs4S0xRdUNPU3k5N1Yv?=
 =?utf-8?B?b1dabThmTURIT1ZFV2ExSG5HeElYWVdaa00yUk5uamZlYlRCamdUbjVhVW1M?=
 =?utf-8?B?OWhwTlFDN25zWHFxNTRCTkRoNEdCRGpodWwxU0FxRnVKQlhEVzVkV2xuNGYy?=
 =?utf-8?B?R1RpN3BCaW1oMnRvZkUrNzQvMUdNbUlld29XUGRGQjk3U012K1h2Rjk2MlhU?=
 =?utf-8?B?T1VtTGpJMFpuZ05QSkowY1BOSzNQbTRxckZ2ZXY2YUxJbDhsNlRaTWNyNXUv?=
 =?utf-8?B?QVJheVlxang1SURXelMwTjNhTExtOTN5dFlDTUdJdEJWaVNJcm9jd3NjbkQ5?=
 =?utf-8?B?K1MvNWZpb2dKdGRyQ1d6NlR5UlI5NlNGRS84UjFCK2VJNWFsL1YveEJnTDFi?=
 =?utf-8?B?SnpURmkzOHJzVXNiaVBvRTl1VkNYc1NCS2F6UnRNdFJBZ1p4d3FnOXNxZDlG?=
 =?utf-8?B?VE9pL3FTcmRJdk1HMnV6TGt3ZlZYRTBvN1hTdWFHQ2FKK1lpeUN2QTdhQ1ZE?=
 =?utf-8?B?UWUwczNRYUFsWTVGZ2pEZFFBQjNoU1QyV01OTlRBSmZ1bzRpOGpwNWh0QWhu?=
 =?utf-8?B?d0NKTm5CYmpOQWl0a1R5R041K0g1aXVuUm1HVW56b05KNThqN1RFU3JwSVNE?=
 =?utf-8?B?L1FsbjF3SmYvUmI4bUNMQ2hEMEY5dGxBeEFDL0twTFNxV1JIMG1NYmc0OTFl?=
 =?utf-8?B?Y2I5R0k4RVU1SENpeXpkUHhBVnFLaVpVU3RsMXhEQWNPOTRsR1pBaWljMk05?=
 =?utf-8?B?dW82aDZXdFU5ZGh0NXk1QkxrSG9oZW1xVzN4RXFOQXR2bkh3UzFJWUJMcXBK?=
 =?utf-8?B?VS9zKytJY2x3NGRuNjVrZjMyVEZFK0lHa2NPWXdiWkRocnZZTjN6MTFUbGxi?=
 =?utf-8?B?L3VoRTltcmJYd2dtTWl6RFRVaVgyaG9FUkEyQ1g1TUlWdkcrZk8zRnk3YWJJ?=
 =?utf-8?B?RmZhOXpvMGNZQ2tGR2tSbTRUYkJoK3JNQlNSVHA0TEtOQlBtcjBsTVZSSkFX?=
 =?utf-8?B?ZkhwZXptaXNCRlc4cEFBZEp4c0ZpdU4zbDdFbWhuL1lmeEl2N01kVDNTSFA1?=
 =?utf-8?B?NlJBaFRnM1JsemVZdnpXVTNtVWNBdk5ZN2JzRnVSNU1vc2o3VzhhS2hjMmFG?=
 =?utf-8?B?OWJtNmIvelJqUGpwNjRGTDVZL2dycXhoOHQxYm5lWEZUN3A0QU9EcHJ0Vmxv?=
 =?utf-8?B?ZE1xZ2oxNmllVDI0UGc0TVA3bGtnZFBKeDJvSGN2c1VUb05WTUNwTUJyUitL?=
 =?utf-8?B?ZjQyWnBSQmo5VVFaMVYvSmJjeUthS1pUM0hZWW50UE9zR3JZazgzOWdHNjJ5?=
 =?utf-8?B?ZWo3Vm1PRjU3K3ZwenlHelMzb2IzVjlPbDZDZzEwMDBHNmtGdGpkR2YxM2Fh?=
 =?utf-8?B?Q3BiYk1DWUhtOEZha3hDZmluSEF3aFp2em55M085SFF0Vk5admt0OXdReVZI?=
 =?utf-8?B?R0FMeDQzeE1CWHVhdEFMZG5uL3d3c3lxNUFmaUVrZHoydS96RmlaRlArMDY1?=
 =?utf-8?B?a3d0TkM1aXNWUWtWQk4zbHNsam8zeGJvaVdsY0pTV1ZuQlVIc0VhVzNOTGZF?=
 =?utf-8?B?dzZZOUg1NkxISVJrYnljNUhJRVMvaGFZdnl6VVhCQndNb0I5MlpJSFZ4RTB0?=
 =?utf-8?B?ZUlnWDNnREtSbkQxWVBnMVVKRUhDS3hrWG5tL1ViSEtVdUlSTzZKZ3FTZ3kz?=
 =?utf-8?B?UGhjYUJVYjhOL3R2R0pLMEZadWJoeWFKRU9XWUxheWtnaFhiRksxSjUwU2lt?=
 =?utf-8?B?U3h2bTYxbTRpaW5UZ3YwUG9STXVvTzk2aFg2UXl1d1dkMlY1ZHhTNjFaZVd0?=
 =?utf-8?B?R2MrWmVmQmdNbEsxZVhyWithNElPNVcxMmpPRWwwVTVsQWoxUkNabERBY1ZG?=
 =?utf-8?B?bXBndnc2MS9qbllvQmxlWG1CQU9OVVp2UEx1TEY5bUorUmQyenhGajFySlVo?=
 =?utf-8?B?K3h0TlV4UnMvMVlvMkJ2N0p2ZDQ2V0ExTlF3TVpGdlcyaXQwdjAxQ081MnpB?=
 =?utf-8?B?c3drdGMzZ2xmbTVWVzhaVURwMTRDSjNHRE16b2pZTjFkOTBrNFAwMDBEbzd4?=
 =?utf-8?B?RlB0b1cyNFN5bWh4Y09TbUpINE8xSUl6dHhtOHVnVHpBMjVjc05iTlM3MDFz?=
 =?utf-8?Q?dgi1nRhxJCGPSXeuKjBAh5SPQWDIK+dKTjKAGYt3FE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5GaRu+gdXXmgMXIVmoFV1DU8GeEPhhlxnOUHeR4x7VoJAvJ20YOAH9bY4pYmrWXJrLYw8iNX7zn9Xw16/QuVvJlDE8CFBpIVJXiSrIbOMgfkwn51iqYLcrKxceN4qfn9mNR/8HiiKyVBAj5zDECRe70MTapAlV1YzdIbwG20CkMrVTVxrBKkLaF7HSGQ9Mr6kJ06mLMZMfQ6V43TRoPTC4ynomKiMetnFmuJqAU396e7W5PH6TvAe+sbGWTQ2wx9XHzxOBZ9LOrrScksczgCAVPU3BTe3FOl3YYbL7FDxfvOZN3gkYVlatDDdQMKi2TvLl+b9t9kpVlIFsHt/DmQlsm0LU+rCXQDWdT44/uX6mmGsW+1JvolnhDvAEJL8B2wC7fducBNSyeQnr+kh4S+p5mGqDBUL7Q+eFDDUOOVAadccvhttlCylY0sUf5JRUHv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 04:52:57.0853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da2ed999-afcd-4aad-e436-08de6f72c006
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4321
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

On Wed, 2026-02-18 at 18:57 +0530, Kumar, Udit wrote:
> On 2/16/2026 3:58 PM, Siddharth Vadapalli wrote:
> > From: Hrushikesh Salunke <h-salunke@ti.com>
> >=20
> > Add PCIe boot documentation for J784S4-EVM including boot mode switch
> > settings, hardware setup requirements, endpoint configuration details
> > and step-by-step boot procedure.
> >=20
> > Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> > [s-vadapalli@ti.com: simplified and documented the pcie_boot_util progr=
am]
> > Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >   doc/board/ti/j784s4_evm.rst | 305 +++++++++++++++++++++++++++++++++++=
+
> >   1 file changed, 305 insertions(+)
> >=20
> > diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> > index d858dc7cdbb..fb767bedbf6 100644
> > --- a/doc/board/ti/j784s4_evm.rst
> > +++ b/doc/board/ti/j784s4_evm.rst
> > @@ -299,6 +299,10 @@ http://www.ti.com/lit/zip/spruj52 under the `Boot =
Mode Pins` section.
> >        - 00000000
> >        - 01110000
> >  =20
> > +   * - PCIe
> > +     - 10001000
> > +     - 01010000
> > +
> >   For SW7 and SW11, the switch state in the "ON" position =3D 1.
> >  =20
> >   Boot Mode Pins for AM69-SK
> > @@ -330,6 +334,307 @@ section.
> >  =20
> >   For SW2, the switch state in the "ON" position =3D 1.
> >  =20
> > [..]
> > +
> > +PCIe Boot Procedure
> > +^^^^^^^^^^^^^^^^^^^
> > +
>=20
> overall series looks ok.
>=20
> One suggestion, if you can move generic document into some common file=
=20
> and include here.
>=20
> then you may not need to update repeat text for each platform.

Thank you for the suggestion. I will do so in a future patch independent of
this series.

Regards,
Siddharth.
