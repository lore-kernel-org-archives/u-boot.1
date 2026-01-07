Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B69CFD626
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D14A83AAC;
	Wed,  7 Jan 2026 13:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lgfjO2GK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12AAF83AB8; Wed,  7 Jan 2026 13:57:37 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F070839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 13:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQjvcVzpTx6C9Oeq224V2aXNsp6+WKP/a9YKIFRjgYx5nAu3aQpM4WgGBW6MxYtty1mM2YHq6p2H5WiEK8zbHfEe3SbWi+x4naAH4qeBDJ6Z91YKKS93m7JZBmjpeSpQqKTHUnbXH0M+UHxFV5Uc9N2RR5Jy2J5/zzCeQPsxEunowCbEZXmG/+gi/6UyYVZBIjbjzTLO+CWC/DskqPtm603toiyO2hVjsBEH2tdvfQac6GSuA5+/d78H0pO9Yhdk1hxOA27P4siX/ajfgovVQoT44IgNR87RJMjOdun5fvGORowPOirXudZl5E5yq1qcEavsyffvCV7igZ19qFZKrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D+LBjFpyVjGALIcKNZoJPTOVF91ehCpf3+eHR/Ij30=;
 b=ZynRrWZ8zmDRFn80MsIr4hn983Bq49EjtYa1zOpQfzwwuiQ8OE6OyDe99HIakN5KxDrP0i9N8+/XGd3SpfrGkIrVHy9b3c9k9q3ZeAK4dnK/ng583+b/f/kugqA6jb0oawiZ+JLDIewNEKwKVjawrUWbSreU2Gx1ktN+kjL/gkeL0fzcTqOAvYcpnWCkYovVnEJ7cXVg98Ml5GixxAYm+9KUbKX0VdqRhngXz6AO5twq2ZzGjwVtbFzjlc72lMfZ4t2U/pbdxlBgHkaQ+wk0VzqpbUGztxc7UMoxh31kQI/t9vXA3b8mIGK7u1S1A7s4aURoY8oTBdsrSdVMEVIbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D+LBjFpyVjGALIcKNZoJPTOVF91ehCpf3+eHR/Ij30=;
 b=lgfjO2GKqyohgje4Fh1vQYKpthAlhknmrqHV9Vp92o0gzyTLNw7cnhAq0qobJdAjczx/MpQ4i5PkMk8i8PlQSQ8kH4C2/WF6zieTRnivqU+MAfkMfUKuTyBSe/vpCkW2oKkFLEb8I8YEduwr0MZzLk6TZthEsSNG3Q9tAnb3aKE=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:57:31 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::d9) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 12:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 12:57:30 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 06:57:29 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 06:57:27 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 06:57:27 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 607CvR4x732847;
 Wed, 7 Jan 2026 06:57:27 -0600
Date: Wed, 7 Jan 2026 06:57:27 -0600
From: Bryan Brattlof <bb@ti.com>
To: George McCollister <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, "Hrushikesh
 Salunke" <h-salunke@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, "Joe
 Hershberger" <joe.hershberger@ni.com>, Judith Mendez <jm@ti.com>, "Neha
 Malcom Francis" <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, Sam
 Protsenko <semen.protsenko@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, "Tom Rini" <trini@konsulko.com>, Vaishnav Achath
 <vaishnav.a@ti.com>
Subject: Re: [PATCH 0/6] arm: k3: j722s: add PCIe support
Message-ID: <20260107125727.pmjub5wp2qimpunw@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251224193213.802246-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4kzuhnttlxxojxu3"
Content-Disposition: inline
In-Reply-To: <20251224193213.802246-1-george.mccollister@konsulko.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa703a5-4827-4bd8-dce2-08de4dec517d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YklRTHZDdjlZNHM4SkwxSGNYZXU1bTV6L3JWcThjOGN0SXlxYmQzbE9Vb1NZ?=
 =?utf-8?B?eEJOc0dsL0g1MldYOG5Tb0hVcnV1eDRBN294TWtSVjRLN2p4T0U2TnRRcnVI?=
 =?utf-8?B?eUtxQmhRSEk5YmZNVjFmcXk3akZDd3VESnpJdy9CVEtWRmZGeFNqNHZXbXI2?=
 =?utf-8?B?UUhhSzdCM2NxcjdIemJqdUZMaHNVeDZ5NGZLNGIrQjJTWW5nK1FIZkRvU3Vr?=
 =?utf-8?B?OFd6ajk5dHcybWZCeTU5Znl6ZU1xWnFmMnNTNFptQ284RXVPQ1E2bWQzelNY?=
 =?utf-8?B?UkFuN0xBNGtPeXYzTzRXa081VFpTM2hPN1ZBb0NxWlA4Ulg3UXkxV1NnZGtx?=
 =?utf-8?B?bDkwQkxzT0xPZit5Z1NJMFJUVG9BQit1RHp4YzM2Q2VseTN2Y2JnMzRCZ29O?=
 =?utf-8?B?Um14TG9ySHp5aHRjZVJMY0ZxaHNUeUZJY0hGeDFuUHowZVl0MGU0OGFWRXp3?=
 =?utf-8?B?SWZFbnBqSFhuOUVGWTFlNjJoM3gyOG92TG8xUHBIVWcwS2xHK1VyOUlkNWpz?=
 =?utf-8?B?SUZkVGpXMkVaK3NpbDJBbDBrUmFRTlJvWnEwaEFhb0NkWmdGcUYxeTB3WWFj?=
 =?utf-8?B?anVSTC85TlFON09vcFBBT1BRdnlIL09PUGUrdno3QWdhaHZFeTdrZ1ZlM256?=
 =?utf-8?B?L2VINDg5N1ZmZ3NuOXlJc0srK2d4N2E1Vzh4NjZLZlJWek1nTklHSFMvRDZj?=
 =?utf-8?B?QWJYbk5WaTFxcXkyampYZmY4TkVwYzBGRGtLVFlxQ1BhN3l4YmRFN29pRjlV?=
 =?utf-8?B?WTIrRERibGkwMDdaa3VDZ2dVaVQ4UGxxdTF0Rm9zZFNJS0p0QTVieGFOY3F1?=
 =?utf-8?B?RFpneVJxMTRVUnVxYzJqai9GMm5JRTNxNmFWaklXOWRkMU01WHcyajhYQWdG?=
 =?utf-8?B?UjlwMnNNVXhFVXY3M2ZjWWN6eXViNTdYRkhXZlYwRURDRXB5SUpORmZ2Zi9H?=
 =?utf-8?B?UWlZRHN6M20vNWE1Wm5qeGlXU2h4ZEVSM2YySjRQTU1RbldtTXk3Rmt5a0N2?=
 =?utf-8?B?MnhYOERpa0gycitRWnlvWUVFODI2R1h1Y2VDT0QrRmgzeFBGUlZzMDBHWXNa?=
 =?utf-8?B?clVWUlBCNVBpV2RTMDI5VkZKTys4WnJHSlZXcmdUa09KNGg3d3lGNXdkdDFE?=
 =?utf-8?B?SGJDYXY3ZHJsMURMVUY1NTFydXdMM2phNXRxQXZ5VVRmbDQvL3VSRWJ1cEFz?=
 =?utf-8?B?Z1J0NnFaTjdGTDZpM3VzdkpoSkF6UElBQVAzY0pmSEQ0ZWY4RnVLMC9PZWNh?=
 =?utf-8?B?cnZ2b2hwSkVHSDY2UXBIYzluSDU4NWNaSUFaMWZ2aVhwNzBGY1lmZjB0aUVY?=
 =?utf-8?B?TTZIUmRHUUEvMmJaS0JJM3FsaDRGTlhkNzhrTXV3cWhVZXFvdkpDMGp4R1V4?=
 =?utf-8?B?dVY5L0RSS2RFbFBJb2lkdjFGTmZJbDlwVnJmK0llTVBQOEdla0RkMVN0L3pz?=
 =?utf-8?B?MWtDYWlxWlBESWFTN0E2VnhOVHNxZnVpSG5CTFhNdmpQQWhBc0NrYS9QRDV5?=
 =?utf-8?B?b2dJZkpLOUp1TFVJUSs1VDB4UkJ1dGs2R3NtSkxCR2ZhTS9HSHQ0Vm8yWGZY?=
 =?utf-8?B?QUE3bUNWSUNUcTY3M3J4Vmg4dExXbm5ZekJGNUdnbmlFcGEraDY3bWlHSHlD?=
 =?utf-8?B?RERGcEpUeXkwb2Z1TzRQWjRSVzBkV2NZOXhNZ1QwVUpCL3d1UlEwMTRtUDE2?=
 =?utf-8?B?NHlwT25kaEZ0NTFsbHFmSTdRa1A0ZEpacEdQTkh3d0EvWEp5MEhwemVNSkc4?=
 =?utf-8?B?NkxIc0QxM0YvS3pCOXcwNEwwQk83TWg0UTZqZjMvRFdLMUppQVVTc1RocVNh?=
 =?utf-8?B?NzN0Nmg2V05wejN3MG9vRmhpUFlpZ21lZlByWnVPUjA0VFhIY081UGJpSy9E?=
 =?utf-8?B?UjhDS0Noc3EwOWpOeWJsWHQ2eUtIa05PWDl1emJkNU5MZnFhWmVYdFE0ZkFI?=
 =?utf-8?B?VmYwSTF2ZnduMXFXb3NwVHRGV2RPZHBYNUZhYmtJNG9mTC9jTm1HVXhhOUgv?=
 =?utf-8?B?NlFSWXpsT2pzZUZPdklFQmhmV1hSQkxUSGVpQURFdGp4S2ZHN1phTC9tRmh4?=
 =?utf-8?B?RWdqOXY3VERFd2tEK1M0QXUvZUxYZXRxYXVBQWxNTTFDVm8zMldmL3g1OEFN?=
 =?utf-8?Q?ALqk=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:57:30.6765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa703a5-4827-4bd8-dce2-08de4dec517d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
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

--4kzuhnttlxxojxu3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On December 24, 2025 thus sayeth George McCollister:
> This patch series brings over several changes from Linux that are=20
> required to get PCIe working on the j722s and also enables PCIe in=20
> j722s_evm_a53_defconfig. This allows Linux to be booted from an NVMe=20
> drive.
>=20
> The J722S SoC provides pcie0 (using pcie_cdns_ti) thru serdes1 (using=20
> phy-cadence-torrent) thru serdes_wiz1 (using phy-j721e-wiz). Changes=20
> to the three drivers needed to be ported from Linux to enable the=20
> REFCLK output which is used with this SoC. These changes should be=20
> tested on other platforms using these drivers by those with the=20
> hardware available to make sure no problems were introduced.
>=20
> The PCIe controller in this SoC relies on the code performing the PCI=20
> scan not scanning devices which cannot exist. In Linux this is=20
> implemented as only_one_child() in probe.c. If this mechanism is not=20
> used, PCI config reads for subsequent functions will return=20
> information for device 0 resulting in U-Boot detecting 32 devices when=20
> only 1 is present. This change should be tested on other platforms=20
> with PCI to ensure the same PCI devices are enumerated before and=20
> after the patch is applied.
>=20
> I would like to thank Opto 22 for sponsoring the initial development=20
> and anyone that is able to contribute to testing of patches.
>=20

Thanks Opto 22

>=20
> George McCollister (6):
>   pci: skip unnecessary PCIe scanning
>   phy: ti: j721e-wiz: Enable reference clock output in cmn_refclk_<p/m>
>   phy: cadence-torrent: Add support to drive refclk out
>   pci: pcie_cdns_ti: Add support to provide refclk to PCIe connector
>   pci: pcie_cdns_ti: Add PCIe support for J722S SoC
>   configs: j722s_evm_a53_defconfig: enable PCIe
>=20
>  configs/j722s_evm_a53_defconfig           |   8 ++
>  drivers/pci/pci-uclass.c                  |  32 +++++
>  drivers/pci/pcie_cdns_ti.c                |  23 +++
>  drivers/phy/cadence/phy-cadence-torrent.c | 168 ++++++++++++++++++++++
>  drivers/phy/ti/phy-j721e-wiz.c            |  46 ++++++
>  5 files changed, 277 insertions(+)
>

This is great George!

Tested-by: Bryan Brattlof <bb@ti.com>

I was not able to find a working baseline for the AM64-EVM even though=20
there is a compatible for it. I'm starting to have doubts it was ever=20
working to begin with.

I'm sure the BeagleY would want this as well. I'll have to go find one=20
of those and try it out.

~Bryan

--4kzuhnttlxxojxu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmleWDYACgkQwPir0+IT
1wzt7Af/aYdfbWA5+n21opMWlunTPR4QFqQYV4b/U5gj0yZ9AWfF9JjXK4YWH/Bl
KxnEj73hL9HcL1sMA5mRf5tqmmicy1Dr/K2NP39Pb62mWViC+foTIsP+stA7elPH
0u0bqIbgCyHAjqw3F/zDdfj/yk9ZS7Lu8hd8AAENKmQedEx7MpIEY3WKP8RPlNOn
72HYFj9CM+nGVL9T1mPWj6lqBUMS6yW4vj9KoRiUHvNFQlZelb49n6PW1hiJzaMv
1id4we+eCqRLJuafdeT3HaD3194pXCSpOAKG6JLWaTOPbFgrnP5ExjTUPRlCpjgh
sAwwn4PWzuJmZYBBJhnyNoGubedniw==
=3LcL
-----END PGP SIGNATURE-----

--4kzuhnttlxxojxu3--
