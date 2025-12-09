Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210ADD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4003835FD;
	Tue,  9 Dec 2025 15:13:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b6IQpO4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8542F81D6A; Tue,  9 Dec 2025 15:13:13 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447DC835FD
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCZC7yVG0N+J2AY0l9VsBQPI1dr8Qr6D6RbW6Y/gz2TwksYFZ1vpAt07iBYDOakCNljMlHm1S7BRqgOPTYYtM8g6Yqsxu1SEICeHm4h83tSFligqqdgMOxhYA9IQcM3gcYSn4S1OK/lxlHcOcvc9urFBPykF8iNesYVa/42JO0zdNqUZHyFQY0bLO1L6StXGBmpblMD1xzeGW2mjQPn8Mqd+OztmziY0FcVRc7jDAVLR/7ZMhhxCCEygL+sDW5yS2IVODfxvPYNfgv4nxiNkZVy9ONzykZo+fScjgxvsRspJHIr46iJuCl/x9B8ltbTEBDe90nDkLjz6ePRcl4/0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wHe+gf0Qi6WbPI4xugAiUVgRX9v+7llg7i3FC+nTuo=;
 b=mIqogLLxDrLPf3x3kXEvrjgo+Cwf975pPqn3zk9jjsmGMxSDviziuz3luoszA6JbKwcrdVXNDIxFOKlQH+q9056g3awxuiKrToCx46dlIY5cw5Ojnyog/54ZwcHQmUKGrysIr/dCwu/DdHwx5uDnWL4KMNoK6Kj8SouSF1Hog2BUaHr4GiCyyxU0C4smbxIujQuB3Qk+NeF9S+ubpHIo8x6C3jTNXCDMhhAPcs8gGcYK4+eXXvo1dlI5k/2R8llhl9MVXzcY3izd5g5nS3jJoVlIsDrXL8j+6D00oDk4V3GUEfmf5JpfYp9cyi5nbDnfJ8BBpNJWHFZBHHm+BB1RKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wHe+gf0Qi6WbPI4xugAiUVgRX9v+7llg7i3FC+nTuo=;
 b=b6IQpO4Inrzc1FKHIfgEBSqmq2SRWpYT4Z3wan9RF2VYjZFaaXEpP0H+Z11SIZXllz4KWi/5OaOl8o5a7Q32MGZhAzTC3zMIs89ZB4XqH14D/f9GrHjwQIlevnuGaK418o83iYKVFGGhUcwA9n4BqnG1UVoeeajge1uCyYs1zFo=
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 14:12:46 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::a1) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 14:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 14:12:44 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 08:12:38 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 08:12:38 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 08:12:38 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B9ECc1t1298542;
 Tue, 9 Dec 2025 08:12:38 -0600
Date: Tue, 9 Dec 2025 08:12:38 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/4] spl: Kconfig: k3: Set common default for
 CUSTOM_SYS_MALLOC items
Message-ID: <20251209141238.vfkuj6ojob5vkruh@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251208190635.2044082-1-afd@ti.com>
 <20251208190635.2044082-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ysc3uqogoqk3ymfl"
Content-Disposition: inline
In-Reply-To: <20251208190635.2044082-3-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH8PR10MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: abc776fd-e401-49e4-48e9-08de372d05aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0VzWmtncm40R3ZDQUM0RFU2bVFUaGdPSFdrQnRYd3RaOVdKLzdVNmI0VG5K?=
 =?utf-8?B?eEdCV001aFZyMUIvdmlZUzNEczVLckZYd1F3elBFV0hJNHNyOVR6VUtsVS9r?=
 =?utf-8?B?ZzdjdHlJNklZVVQ0cXV3TjVkNU9LTSt3NmpyMkJNMlEvdDBLTlVMUGs2bG0y?=
 =?utf-8?B?Z2liQWZrTUtmMWx1b3VieHA3QVExNHE2dHJ4UWFwbmhYWUc2ekxXSERycEdK?=
 =?utf-8?B?c1A5NkxySDJIcGFBV2hHWmdndXhMbU1EdTdRK3hMYzVSSG13Q08vZm9DeUNN?=
 =?utf-8?B?eE1wTG5jajJPelZvVyswTDRxQXlKcTZNdmdDLzZqd3hjYWowakJNa2U3RzJO?=
 =?utf-8?B?WG9KV2Z3S1lWWGNGOUxtUnM3bmNDWG1haVlQVkxySnkyU2lRUWtxeFhPRVdT?=
 =?utf-8?B?bWpRWTlwNDh6NXlSN1p4RU1waGVKVUNLUktVcGdrWTJMY1drSzNyVWs1OEtG?=
 =?utf-8?B?TExYRXJWUFZQQnJXWVNncGJsdnFaZVFreDAvSXVXdDk2TXg5TzE5bzZmbFM5?=
 =?utf-8?B?eUVLVHFySkNDMUtLd0VLR25aWHZLTFQxdUl1WDVHMUNFNm5UNEVRSEtSWTE1?=
 =?utf-8?B?bEJXdVlOVWNkL0lCcjJkTkdWODcySE1Ca0hqaitxUVJhV1BqWTBNWFREdVFm?=
 =?utf-8?B?Y3FaZWVLN0NHS0NsUlEySFhjdytsaFJDa3RTcUF4Z2dpUml5ZHA0aDliUnpR?=
 =?utf-8?B?WENZUVk4ajVNWmN5amZJKzErMzBiUEE4MkZvblRvSmhMRzFDNFdXczBlTm9o?=
 =?utf-8?B?SGpqQTdrMTZOVmtkclVVeEwvb0dLdWFnOVBSR3ZMQTBIcWdBcHhrcFl5NzFZ?=
 =?utf-8?B?V01yNHlLWHVsSjE1bCt4eE9XbHhtOGc2RE52ak1ReVFXVk41cHZhZm83NGdE?=
 =?utf-8?B?bm5xS0pBb1V4MTNJVWdyKzFyMVBxNjBXOUh0SHltNTF2TnpEd3o3Lzg2K2Er?=
 =?utf-8?B?V0M3ZjMzUVByRitFanhoaHVMUTdSZUUyOXMxUnlIem5nRGpJcTZxclcxbXBL?=
 =?utf-8?B?eXhmcHRseXp4VjB3Z055TFYwU0pmUGNiSktrWkxOZnMzd0tXTEpvbmQ3RGJq?=
 =?utf-8?B?N0JsVXl0WEl3WUh0MUNoQVdQT0pVblFuVnRjQnVQTVR3SVFZOFlOYkVnSHR6?=
 =?utf-8?B?dmFrQm1tT3NhRkI4UHNybUh1ZERxSVNhY0Z0SVF4VEkzZEovK1lUSXdENzR5?=
 =?utf-8?B?RzZ2R000Vi9NL2lvcUxMcTFobHQ0ZFp5cDlCdjZpMkwwOC8yUE1qN2NtQmVJ?=
 =?utf-8?B?K2I5UGhNSjByMDNzMGM1T25MRlpkNU5VVi9BWEg3T0F3RHFPR3R5ZEZKdjgx?=
 =?utf-8?B?V09wOTM4QWlsTjQybllKWVBXeDI1ZUprZzZROTd0dkxNdEYrblpMcmF4VklN?=
 =?utf-8?B?NEprSG1EemhORWdFZCt3UlVkL25SMkFSMzVSYWdDWnJnUzRpbjhoa1ovR29r?=
 =?utf-8?B?TnNzV0c1UE41RFpmQWVTdng1Yms1OS9mUVRjenpXU2M5elliQ2JBVG9PTjdM?=
 =?utf-8?B?MlEzcVF2WXhmT3hRMUU2WEtkVU5aZkVnWEEzL2JlNnhVSEdqTUowVTdZd2cx?=
 =?utf-8?B?OWxyYTFNdTVWclpXVTV6S1VSRUdLTjAvWXJENnJWZ2RGM1V1RVpkUlF3U2pM?=
 =?utf-8?B?d1k2VWg3QVVMMWx2R2lZNXhCU0s3blFpV0Y2ZTgwQUdFc2NVYlJmZDBGMDc4?=
 =?utf-8?B?ZG1YamhlcXZ4K09WcERTY0FRdEgyMDlNUEN6cXo3aU44dTNLQnhrUUNaYlM1?=
 =?utf-8?B?cjl6cGt1TlFiUXZEcm5RY1B3M0JlaHprVGUxNVBIOG91ODhGYU9rUTBUSEp2?=
 =?utf-8?B?WHN6UXM4TWkzME0vaVpJbXo1Vmh4Ni9aaFdMNUlrV2V6Qmp3RVJlQVNJcFcy?=
 =?utf-8?B?Q3NNNU9pL1NPNjJJZlprS0orUEtGWXVmRTJwbk1UcDBmWE1tUUV5OEdvZndv?=
 =?utf-8?B?bjdjMlpoSmRvajJmOGlkeS9SS1d5WVRSQVZidVBjRnBqbXQ4MWphL3JVVkhi?=
 =?utf-8?B?Z1F6UGZMRUFoR3ZlRGlzOFZOY1JoanRwUk43ZDlBbWI0REMzNVkwQ1hiZG9w?=
 =?utf-8?B?KzU0MFJaTkZQNWRaV3FJaTN3a1ZwaExvT3FxZkp4L3NlZ1MzTmxUbTFPMkpW?=
 =?utf-8?Q?BoTQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:12:44.0869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc776fd-e401-49e4-48e9-08de372d05aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
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

--ysc3uqogoqk3ymfl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On December  8, 2025 thus sayeth Andrew Davis:
> These are common for all K3 based boards. Add the common values as
> defaults and remove from each board defconfig.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  common/spl/Kconfig                        | 3 +++
>  configs/am62ax_evm_r5_defconfig           | 2 --
>  configs/am62x_beagleplay_r5_defconfig     | 3 ---
>  configs/am62x_evm_r5_defconfig            | 3 ---
>  configs/am64x_evm_r5_defconfig            | 3 ---
>  configs/am65x_evm_r5_defconfig            | 3 ---
>  configs/am65x_evm_r5_usbmsc_defconfig     | 3 ---
>  configs/am69_sk_r5_ethboot_defconfig      | 2 --
>  configs/j7200_evm_r5_defconfig            | 3 ---
>  configs/j721e_beagleboneai64_r5_defconfig | 3 ---
>  configs/j721e_evm_r5_defconfig            | 3 ---
>  configs/j721s2_evm_r5_defconfig           | 3 ---
>  configs/phycore_am62ax_r5_defconfig       | 2 --
>  configs/phycore_am62x_r5_defconfig        | 3 ---
>  configs/phycore_am64x_r5_defconfig        | 3 ---
>  configs/verdin-am62_r5_defconfig          | 3 ---
>  configs/verdin-am62p_r5_defconfig         | 3 ---
>  17 files changed, 3 insertions(+), 45 deletions(-)
>=20

Makes sense and works for the TI reference and the beagle boards I have.
Thanks Andrew

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

--ysc3uqogoqk3ymfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmk4LlUACgkQwPir0+IT
1wy/mgf9FQoyX7HIl7OVfV5aw1UcRp6vb/IavObsdGkDC2O5a/VOtwJ/+KjlH+2A
62zCWzhiL1Ngtx4M50P7vzLan0sfTg/cEX/b56oylvOUskLbi+tZ9wGwTKA/5zk8
+KNvwVpb/bAIhhwurRKXO5X5ayFTsNMUJGjmUYR9WjjcQjCBu9zSxYHCr5vde6+8
J7HTR0vyurldjxO5VJAzdyfEbArX3aLtfsrK8IDQUE5FXBe/DWep9V6QQhnTeI4l
RYe3PvPZyJZF9qjMNgrUrPeeErDHdybGhaGHComWhqYxv353nXtuBOm9ON/DTu6A
bYjMTtcQuNgsgDxg2D05+myrxJ2jzA==
=b7ld
-----END PGP SIGNATURE-----

--ysc3uqogoqk3ymfl--
