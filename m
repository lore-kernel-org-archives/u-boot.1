Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B4FCF45C0
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 18:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC2338382A;
	Mon, 12 Jan 2026 19:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FJtcWvyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EC183885; Mon, 12 Jan 2026 19:02:39 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D667383759
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 19:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUxv1e5nsGbBI0gQT9kdE5GYHgfLj+TbXKDa29RnRweofW5+J34nbvuX75oMugNXpUx56HwmpJIAtphfLHoSRbcDK+hoZnAMVC67uvZImcfuw28f6NQWYdWY5PdYq9cABmQ+IWT5n3PRtWzT3dqp9526p+K51D9unlHwIzigFsbkA7pjHAd8KV6iBhdTDJuXxVcZ5qiGLPvAV23ikeh+lsBZ46rQRfcc4+wuH1h2GVY5GwjKACmU8kAP2VoFB6m+CigRpd99F74/jpINjl5El4ih/CLlxLN3pGjlnzxDdYAqEgghcq2QqOo69cds9c/3NHfN7s554+q8SL55VIP2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIj5WHrYZPXsQtWFX0ZmyR5A7LFujWC/yWQ7YOTOixk=;
 b=IKGqBhEXrl3FWrBZIpI1iZPkE+miakvbh4eoEIhGSCVZSSehkqZGDrEdSxXBq7MW61ecEv4DAMAxVBvGgAMpp1Y4i67OahwnptHKrTOGSnzXB9Xvcm0x+K2aWqzZcw5q2HhWmNJyJvGNrkxjLRO3Q1ayNRxDa02SmPkVQqgZWqLB2gSCJun9evGNFHXPqiNNJ0xh8DU6ge+GRDC0CU47zn6wcxxeMnyNNHKZ/RYdB0AJsFlGqGl3h6u0aZ1Y20w3RTTSHWjT955RZCqiv+QYEkV1c6R/7qqV9NVXA9qVka7VgRL5MFZYKKi2XlK5jPqbJRQSwRj/0JPU76gY+O30DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIj5WHrYZPXsQtWFX0ZmyR5A7LFujWC/yWQ7YOTOixk=;
 b=FJtcWvyoZRGTZmuKYz5gtob6syEAlKCHkT8eEnqLFzKEHFS1HljNRm3hepN5SKx+dOKXtOPeN8nKEnshvIhSCcq8p7ni09/gw2lm4KpewsWPgxt5yleMxtyraOK3pLA/+xUKv8iX6ox2YsHYhLl1I9FrkVj59D1338XSfYzSD84=
Received: from PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::15)
 by DS4PR10MB997598.namprd10.prod.outlook.com (2603:10b6:8:318::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:02:33 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::60) by PH7P221CA0019.outlook.office365.com
 (2603:10b6:510:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 18:02:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 18:02:31 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:02:14 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 12:02:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 12:02:13 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60CI2DYa790939;
 Mon, 12 Jan 2026 12:02:13 -0600
Date: Mon, 12 Jan 2026 12:02:13 -0600
From: Bryan Brattlof <bb@ti.com>
To: Vishal Mahaveer <vishalm@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/4] board: ti: Add 32k crystal initialization
Message-ID: <20260112180213.2s6oedurypkhyqml@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260108143713.1130054-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="m47ojr6ibbrvvuqg"
Content-Disposition: inline
In-Reply-To: <20260108143713.1130054-1-vishalm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS4PR10MB997598:EE_
X-MS-Office365-Filtering-Correlation-Id: 177576c0-304e-4c8e-92ce-08de5204c1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|34020700016|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDJMYm5KT0loRkZyRlBlc3gwdzRQeUtIdmJ3UWFNT04wTU5aV0dEVjVhdG1t?=
 =?utf-8?B?K2c2dzdQZCs5NlBDbk92ODgySXRUWHg5NGpBMVJMMnZnL1V4UlhnSm53MjNh?=
 =?utf-8?B?c2lWT2JQVk9rU3dBVXllYitUQjIzKzR5aS9mRXBndW1RNzlGanc1Z25HTWhL?=
 =?utf-8?B?WDVHbFNHUUZqN0NRT05nRGtGdkRzU2FvN2drVTZ1WUxZblRjNTFScWNqVjdv?=
 =?utf-8?B?azJ6bEtiQmxnSTAzWjFta0hUbWVhYkZtWC94OWJmSlk4WnZiOENBajdabU11?=
 =?utf-8?B?ZzBJTW9wME5qOEVMMGZta1BiclR0UHNwK2FadmxkeGx2cTNtVzdkc0thcUtX?=
 =?utf-8?B?dVhUeUJYR0xLREN6WVJjZ2FHd2h2L2trKzFNdkJsckErUU1tSXc0Q3dtQzRm?=
 =?utf-8?B?WElmVHQ5MHE4OFNXbHBpcVhVN05SWUR0S3Q3Z3FrdkRYK2RiOWdCRDgzVVhI?=
 =?utf-8?B?dEtHSHlQZnFMbUFGYmFxTkdQT3g1QkV6UG82MHlieGNaTFJUeGd3Q0pudFNt?=
 =?utf-8?B?Q2t4MjladTRtQW9jb1Y4eGdJME5rMm1ERmhIMWVrNnNsL2xGUGtwN2NwMkI1?=
 =?utf-8?B?VjJjd0w4RWZudkQ0c2VaU2RnRTZzUFFhUFU2ZFB1QmZEaGRoY1dtVVE5TFJV?=
 =?utf-8?B?U1h0YXp5YW5uVSt2ZzhxK1RWS2FUWTd2T2MwN2xlald4bXJXWXJzQUlOY3Mw?=
 =?utf-8?B?eis3WWFHR1pzQzhubHpyS1BBaUFNU3hZcnFvbU5lSlM1WFRmd0RsWTRwUEZP?=
 =?utf-8?B?d0dwMVo3YTVDTWZ6eHVCVitsbE9NdFZsOWVLSnpqTEpCMWJuSGJUY1JnSmRD?=
 =?utf-8?B?bldab2tvQ1NuM094bTR0TVU5VDJRaXhYU3A4MmZ1TTg5b25Vc3A3cnZJMXdT?=
 =?utf-8?B?VlVibDk4NEdEODZVTHRzWmtuWnd4aDR4d2FRNFRmQVM2a1pwWG01anozcUt1?=
 =?utf-8?B?Tlo2YWZ2SGxSZm1aTE9Pb1Y5K3NXY1hzaGtZRWZhc0lRV1JIWkoxVnh0eitR?=
 =?utf-8?B?TUpPaEpDeGZTL3hod3BJdWVGdnc4T3BiWkhHTDFMWmNnRjdmSkcxWElPd0Uw?=
 =?utf-8?B?YXQ2NHJ1M0NIMWlPMHdDZzBwZXJQamlGY1NRMVNXUjNtemUvTkFDZG1GbUtu?=
 =?utf-8?B?OEVLbTkrYWR2UXRZeUk2S1MxeVkydjltTC9yaFpvQU9FTnpHVXhPcEdkY2o1?=
 =?utf-8?B?YXVVNVdnNkV0UVZXcld0VlJBeDdGMHlzM0M4ZzVlRnhpcEpYZHZNbnMwTHF1?=
 =?utf-8?B?cUtiL0xjQjEyWXc1MjZIME8vS3FwMHhISVBuWHo4WWR5d05vNWVJQ055MS9B?=
 =?utf-8?B?bUdBWUMvbnowYys1U255RElWam9NV1dRTGRuN3VjcGZPSE5QeTVtZUFVMDBB?=
 =?utf-8?B?b09UeExWelk0VGdDV0dNeGMzUTZzVWRVeG41aTNsUCtPanFaNFU0dmJESitj?=
 =?utf-8?B?NEFETjAyMy9KMG5UTGZkVWVvbGpwS0c4OE84MVVzTDhMWi9zYmhsa005RmNP?=
 =?utf-8?B?ZHcxUUd5cmZKaThiUFJTUDhJdGNOMDlDdzJjU3crWDAzNmFiNWd4M1FXejhX?=
 =?utf-8?B?MEk4bEtiKzVqRnBJVUU2TUh5NWdhRGo5TkFkN3VpWjlzQ3dlRTM4b1ZEMkhQ?=
 =?utf-8?B?UGE0UlZOanF0U29ZVG16L3RUa1UraDlSVng3UTlTZWFMbkIrUVYrancvc3RB?=
 =?utf-8?B?c09uaTBHS2pIdnFpZ29TMUh6Q0lGRmI3aFJGdk5nZ0ROVVhFbWdSVWhINTBz?=
 =?utf-8?B?OXBsZ04zU0p6OVpCSS9NRituUS9DS0F1enBLU3Q2S0VqT0JIRnV3ZWlNK3dU?=
 =?utf-8?B?ek82WmpyNytiZHNvTE1lMmpJUkVuWjFGQXdtS1pXVHA1V242T1Ztejl0dTVk?=
 =?utf-8?B?ZGxCMWNyeG9paDRaajRKMGQweDZVNjVKMUR0elpUNEc5UG9hbTlWbFRTdDBZ?=
 =?utf-8?B?RHozMGk5WFNnblJjQkx3ZTJ6aUhXUjJlYk5yZVNWUWxMNjdCNzFoMVZFcU5q?=
 =?utf-8?B?V094ais4ZmptZFZoelRtZXcxWUpFNkx2dmdPL0srY1R2aXZFcVJ4ajJGQ3FJ?=
 =?utf-8?B?d29NSnFCMlJKcTN5SGxyV1NPMStWeFlnbUtwd1o2ajNDRzM2TjNYK2htYVZQ?=
 =?utf-8?Q?dC78=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(34020700016)(36860700013)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:02:31.9483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 177576c0-304e-4c8e-92ce-08de5204c1f2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997598
X-Mailman-Approved-At: Mon, 12 Jan 2026 19:03:53 +0100
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

--m47ojr6ibbrvvuqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On January  8, 2026 thus sayeth Vishal Mahaveer:
> Add 32k crystal initialization support for am62x, am62ax and am62px TI bo=
ards.
>=20
> Changes for v2:
> - Created a common API which can be called from individual board files
> - Squashed defconfig and board file changes into single commits
>=20
> Vishal Mahaveer (4):
>   board: ti: common: Add function for initialization of 32k crystal
>   board: ti: am62x: Enable 32k crystal on the board
>   board: ti: am62ax: Enable 32k crystal on the board
>   board: ti: am62px: Enable 32k crystal on the board


Thanks Vishal!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

--m47ojr6ibbrvvuqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmllNyUACgkQwPir0+IT
1wzcJAf7B2Bak+2tCSI9+VYcMrKaKuZ7l+qyoOpDIzjVY6gNyqEJDnO7u7V+2ukj
lM8fJftXXdGkeDUyNzn7piGAKH+HPQI3g9nBZ0c0x3VZmrR3tV/Z1hBSDBgwch4D
D/q8K2WGfJl1C9jw4xbgp4Pxn1QgUBXfrXRSfCMJnUtahdTaWQVHYWRQWkH93wbJ
OyJAZwcsN+I/DCB71x85UKvHZET8+BbENgKWr11wL0FDIa1LlHQmBVef2Mx5zI2A
+qFoEq/WHfDQtb84LraXxvsaoNeCC4kHGkef0EVizGyAKw6lLEvKCUdy0mLOr7sx
Fc5L6Pxb33Cch7Tf7QaNIwxJnkC+xw==
=hvcd
-----END PGP SIGNATURE-----

--m47ojr6ibbrvvuqg--
