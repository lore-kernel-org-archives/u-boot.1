Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84596D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C23C183849;
	Tue,  9 Dec 2025 15:11:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u+qUooHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D71983885; Tue,  9 Dec 2025 15:11:31 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50066835FD
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I683yv4wUsxTB1CVQk+gqM6UxdSpVZZeS4DNkUiA0GcYmhn8gt8ynwC3kphZShUsu+3HC+p84FfuawbaGsUUHkPA5DtKXp1Uo5zt4yaY5hO1EN3tBLlBMTW/S0LhcPoZ0FffAH3y83HAJFPbT4zPYhKjhyYiKgl2yA3pF0mtafliEuaD0WOF/YxYLA8LL3HucMBWy+AHede/SrSp/77a/aVsUJSfHjqJkyzXfC02czU2GnvDVMdUB4EjRABeoWJ2JqsXAE8mT9amDhxekoPG9JQemvsyqFl/7IwQt4QRdGO7v7BTBUWCO8FfRuAHSO+htqK9s1dqdUbJjWtLzLQ90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHK1sqAL3+sjvDquZRZ1zILAWKcwNtxfQSFSIPZjXpg=;
 b=FfdNMeL3lyMKrb4E2goDvlomS7n+h0vGNkhasHKSrw1CtKOhh5vMGzq6b0K9t6SS6734zi39/c+GhEZLLgeJqqJW/XJE7hGjWVl/WmSD/o0QRdh8QCSBhUPzpqLml0mzlwxDfJheoESTlcw58U+6DSups4MJ5BsAGOUwbIP45UrC/bh2fdTGjG75m7+l+YEeEKzzC+S5Mr77VUcOCNsXDRgxMHvId4s2EzgjhMbhM9GTTmDomDOGO+QTufka89roV0TAy5vls8Ay5abJP7KILUiJEsWBT9+tx6dKL/6CgnbBWNXqNaLXuWL4X/l3KnR093euRA20acSmqruPB7iObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHK1sqAL3+sjvDquZRZ1zILAWKcwNtxfQSFSIPZjXpg=;
 b=u+qUooHNoJcdmWyoFsuwvWoOGIFBaceJqJ4XnGpfO4a2sQwjhN1VkUE5T6/yC/Buw0eRRfYnY5yrRWbGqeaFeRPidBDnPeZgQl66wOl4MWYFh2/W3UdJYExt99FNxL2SGNaA5KETlo3ToB+YGcpqRL05g4tA6UaUAcJpVVDlUjQ=
Received: from BYAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:74::15)
 by DS4PR10MB997597.namprd10.prod.outlook.com (2603:10b6:8:31e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 14:11:16 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::4f) by BYAPR05CA0038.outlook.office365.com
 (2603:10b6:a03:74::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 14:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Tue, 9 Dec 2025 14:11:16 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 08:11:15 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 08:11:15 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 08:11:15 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B9EBFeO1317752;
 Tue, 9 Dec 2025 08:11:15 -0600
Date: Tue, 9 Dec 2025 08:11:15 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/4] spl: Kconfig: k3: Increase malloc size after
 relocation for R5
Message-ID: <20251209141115.b3xul7zewyzezxtj@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251208190635.2044082-1-afd@ti.com>
 <20251208190635.2044082-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bcbll746y6y47plc"
Content-Disposition: inline
In-Reply-To: <20251208190635.2044082-2-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|DS4PR10MB997597:EE_
X-MS-Office365-Filtering-Correlation-Id: 910acf93-4a71-4725-3b7b-08de372cd12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODRFajA0UEQwN3RJeEFncEI5aG5RWEJOa0o5LzJlZDlrMlE4RE8vOTFQdUly?=
 =?utf-8?B?N3N0c3NyaUxocUJHbmxpVkZ5bnpBYnIvWDIrY3dGSVE5cjFRNnZCRUh4TVBP?=
 =?utf-8?B?NWpsQzRJekNBaHpLWHV3bzNQYStOTEZHYy9tVDRuMHFPdStkOEZhOWtOL1oy?=
 =?utf-8?B?RWtrc0VNRVpTODVPWGtTQWgwK3NNclF3T0VNdEx6VzVpQ2xpbFRWQkxzZ3Js?=
 =?utf-8?B?a3QzSXVBMytlazdqM1JSVy9TTnJIQTB1MTJTSDVmWjJSWkpqb2drbm9TQy8z?=
 =?utf-8?B?a0l4a3lYajNuZWhEU2s0VDNPRHZtd21ZNXhPcFpaUVN3ZFhCbzBZTkRPOVRT?=
 =?utf-8?B?ZVZqdXpiVGlTN3NTMmF6R3gzeEhyTXBRSUxOKys4Z3hiL1lXYlNGbUJvbkNH?=
 =?utf-8?B?Z25ZNHBRc0JCSnpwTVl0OFR3MVEyZEZOUGpNWGdFbHdPcWwyMG5CSkFNdU5m?=
 =?utf-8?B?OVVxd2VhNEdrQlNIOThRSzUvMWQ4TTg1c3VTdHNkbTVraGxJOHFKbkpSK0VI?=
 =?utf-8?B?VHVrTFIzNDdtZ090alhXUFovZ09QT2NVblo4aGVHMEVwWnFJcW9uNHM4Umd1?=
 =?utf-8?B?TklLRVJGNk81c1F5MGszamNIWWNpdWFhVmFsTDN5dVdHWjJzSWVrWEtITmFx?=
 =?utf-8?B?T0ZTM1ZIbzRUYlVsQnFWVGNCV0oxYjdIaElmNytkdDhibnRnQkhWREhCengy?=
 =?utf-8?B?MUdWVnVGNlNFQ09uSlFLcUgraHFKNkJEalkwc0MxWnlwc2FJcDBqVm9OWkNq?=
 =?utf-8?B?eVYzV3huN21nRHhkd0lCMFFuVHFxZ3J2V05WNjdQVDdlU3R0YkdUaXBERk5Z?=
 =?utf-8?B?QVNGcllXMlY2M0dmck1md3pnZ0RNclpHZWtnUml3cVpWejJWRDVCa05jTEo5?=
 =?utf-8?B?RHZDUjFyYmR4K1dEbmUyYThHZVVmaTloK1Q5YmVQd1k3OEZ6bXZGbDZsV0tI?=
 =?utf-8?B?YWZiOExqUVROSDYwZlc4S0Z3Qktucmxtb2tQQ0t4YzhCY2tIbUZWNEdvM1Jr?=
 =?utf-8?B?MGhLZmo3YUNtTkh2TkVTcjZ5bGxINXVxNjVXUERmRlFoemVCeXNFdWFVTXJ5?=
 =?utf-8?B?b0l6ZWpYRUQzRkYxMHUrQ1RBczdZVTdhT05zZGRlTUNJZ295M09jbjBGVHdR?=
 =?utf-8?B?ZHV1YTR6RDFDV3hWTlhRbWgvWkZjL2hZaktiQWJBK1BaV3ZSaWd5R2JDNUlt?=
 =?utf-8?B?dUp6bHZNQjFyNVpXYUMzT0k5dFJ2cEVxSVlhUmppQnhoa3U4eVQrVkkrWmZF?=
 =?utf-8?B?UDNNQ2ZaYnM1TnJlciswUHBkdkNiaStDdk9adXV1UFI1MTlQOW9pME52ME1U?=
 =?utf-8?B?dWJPd0FxeGNyYnVyNHpOM2kxdnVac0xGQW4wd2RrMjFLSmU5c2tXZXoramxr?=
 =?utf-8?B?S2ZoWWY4dmVGZElZYzI2ZWp1aFhlRW5FbkFnUE9IZVRBbklNWTlXMkRrOHRW?=
 =?utf-8?B?N2VhVXZrdlBsdWN3cnBtbzRYTk5hSlVKVllUMVR4Q2tHOFZ1NWJTOU81dDB0?=
 =?utf-8?B?S0EwUG1USktOamw5TC9pUFBsSmRma0ljYW5RRzdKamc1RDdLcHEvS080ck85?=
 =?utf-8?B?S0NFc2VxbjBzT0dZSTRlTkh6Q0paWDVzNTFIUTk0dEdjUUVqa0NoYUF4cUdx?=
 =?utf-8?B?T1NTaFBPR0JnbUdpOWtlaFZPcTUzRjM3eWlReEZQc3h3SG83UVNPWUwyeVV3?=
 =?utf-8?B?WDR5c21oZlZvZnZ4KzA3OFcrVVpQSlR0Rld3ZmdhUTZROWtPMVJWYU8rZU5S?=
 =?utf-8?B?V0laQ1E3eStrWUxMR2NaSEtUdzJmU2lMZis0dTVDOWwwcEdseWpQeXdFM3A3?=
 =?utf-8?B?ZnBpM2xBVlZQeDlmc2diUUlnb21zNXBIODUwcWRCVmJRZERqREc5eWlHOFF0?=
 =?utf-8?B?SFAyc3pCNFh3bzY1TWNXOUErcXBjTXI5V0tieWIxR053RHBkem1qNGNVTnRW?=
 =?utf-8?B?ZkREdFF5V3hteTIvT1hoVG41cVpEaDU3K3BOWHY3aHJpQ1FVNS9qMDJNdytk?=
 =?utf-8?B?cmluV1pGcGNvc09YTk5lR2d6WGxZVXUrRkNySUF6TW13alRST0F4b0xralgy?=
 =?utf-8?B?ajNOa0dLS1Npbm0xc1daZGloTzJWSTJ5eUtDdDZMUjdONGVIZFlldS9aNzJq?=
 =?utf-8?Q?EXVE=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:11:16.0106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910acf93-4a71-4725-3b7b-08de372cd12f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997597
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

--bcbll746y6y47plc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On December  8, 2025 thus sayeth Andrew Davis:
> Seems the "generous 2MB space" is no longer enough for SPL on some K3 R5
> platforms so let's increase this to 4MB. That matches what we give to
> ARM64 SPL, so combine these.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  common/spl/Kconfig             | 3 +--
>  configs/am64x_evm_r5_defconfig | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

--bcbll746y6y47plc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmk4LgIACgkQwPir0+IT
1wz9EQf/Y/0R7kZB38vLLMrdv40ludR7xfvEqV12yjzCJMvsZhzINF7nNGTzh2UR
9dn+nwHiZtb7ykJUK8JiQUlRM4KUXPTh63GictMjdBR98NT4frb6PUxEf3mujNAq
OyXVpf8QVKYo+vH7NpRzlMa+tPxkOGf8RhSvsDRl0Ysd0WKo4WNfNobWbDY7Ar1Z
Z3zZyNsfYFwQpiZpRVXRIjXdWSp+Yr9W6TmSlrZsDM00eUBL4rk8sbspI0sB8yEq
ZYUf9wz2JY+qKkcLxIl62eT0lthYWyz6H3gs0N4iYRpM9xd2y+bJXVKiRsGwnbW+
drnfYbDkSRt8Orhrv9zfCTNxLGm+gQ==
=TBPK
-----END PGP SIGNATURE-----

--bcbll746y6y47plc--
