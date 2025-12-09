Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889C7D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0386983A36;
	Tue,  9 Dec 2025 15:15:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C2w1i8bF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F4283A94; Tue,  9 Dec 2025 15:15:45 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EC58838A0
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icRA/oy5rx3V/Y8bLPbBpB2FlRM8k0oCVfw3K2ro5O1xz4ftj+LfgSfbbg4UGwIN7SKRMVxVXZAmlMI1+Xx2iPwSwlDvdqX4UaxfQ9ltFlO0YJnZj8lW177cQ2cg7eoki0U1m4GYx4dr8UvUlySc2ZiX+KcoDlcxWJGIv1TMsB+gEVH5eEU0yRbtJ97mGnMsaRn6VdjtZr7xxhlf9UdnsdpU9I3/sRfrMKfCqwaLxk4mbfmP5V232HZq/ev5NfBtVdrD0DTs9ZHD7em4aLsRJrZZuR/LlBBgMbarrnwy2WHqTP5zRSt/xOa4Q8PuLvWAuhy+RCkOF1KOi9RXtgXmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGvLPidEkV0mNyofblul8YNIW2x/S8YzIADWyIvxkqk=;
 b=xY9maX1yZFOjf/u2Y9aQxgUqJ7ub7hvYqbocHtF5p8sV8f7J53AEv+Z4M0zyPcn+CqA0GPZoU1mcPTgMQ02HxARGIKqFgwP3UMGVaOK0bNLVx1HUz/aC+N4SlHUQEM0xQxTlbR/PD70fejeO04/oQtVKZDt0oEEDBVwMhKKnVnd5lBq69VeiXAlMMVxAY7noCsn7xNYYDbp+vr74phypKZJo8cDkT66mdXaknT9kB3Wrw6UlO+zgn0t1TWSQLuEkoMiWbKfhj01uy2u6UBzFN2Tksb+h5AzU56zvZ2Xbf5PyGj9t1OUk77On5KsZTBQH5EBHqDllpPvcezKWbkPC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGvLPidEkV0mNyofblul8YNIW2x/S8YzIADWyIvxkqk=;
 b=C2w1i8bFbHAABtOwUnXSyYnKcSMRLpIdl/jdetrfq+bmpQbAjCTz7HxHIfoRH6+VBZeIDd27WEwBmU8+pn0+nMqvWm4ZyQcjE2ti0Vba46lYQqCpOwlU6azzgo/QQwV4VXqAMOoXMOn+OGs9Bl1HJ/KDoFT5Ms4QUxu3+B9xjg4=
Received: from SA1P222CA0070.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::26)
 by MW6PR10MB7592.namprd10.prod.outlook.com (2603:10b6:303:242::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 14:15:25 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::b) by SA1P222CA0070.outlook.office365.com
 (2603:10b6:806:2c1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Tue, 9
 Dec 2025 14:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 14:15:24 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 08:15:20 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 08:15:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 08:15:20 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B9EFKBQ1322200;
 Tue, 9 Dec 2025 08:15:20 -0600
Date: Tue, 9 Dec 2025 08:15:20 -0600
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/4] spl: Kconfig: k3: Set common default for
 SPL_LOAD_FIT(_ADDRESS)
Message-ID: <20251209141520.reboy7fsjaxy4623@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20251208190635.2044082-1-afd@ti.com>
 <20251208190635.2044082-4-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u5znzz5tlj6vfxsi"
Content-Disposition: inline
In-Reply-To: <20251208190635.2044082-4-afd@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MW6PR10MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 1378f8f1-8241-4005-e86e-08de372d64ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWpXcS84V0wzTGJmd2krd2lwV0MxVm94SXQwVGRmbFg0ZVBHYWZYWVIyUTY4?=
 =?utf-8?B?YmYvSEFESCtQVW1QWC9VUlBoNjRoVGFYOXlxZ016REduN1lON0N0cjlNMXNh?=
 =?utf-8?B?SGRRYi9maVlCcVkvbHNXUE9ZYnFKTUU2L1BmdzI4NXlyK1VHMkc1S25LNTlE?=
 =?utf-8?B?Z0RqUWRlUmNNK3h3NTdCVS9oT3JiNkJOYnJpamRrSldWTFk5M0NhdXBxVHlI?=
 =?utf-8?B?N0E3eEsvRFJmT1F0OGc2ekhpVmh4T2c2bCtYU213V2o0eUNwSFM0ZHZrQ3pw?=
 =?utf-8?B?UjlrQ2hXT2U4MGJ1U25tNHNueTlkMXova2ZyTWRqeWNEL25zM2xPdER1SHht?=
 =?utf-8?B?RTZYbHRycE5hV1hYNjJvb28wRWJ1SmlNdE0vaG9Id3FpUjFmVXlENU5seENJ?=
 =?utf-8?B?VWcvTnBhVzRoRE8xMnNpdUwyVU9SYUZ0M1hPR25POUhTdWd5SGRtdk1JMnY3?=
 =?utf-8?B?eng3d1BJM05TL2JCdW04N2lPMWhMQlg3UXk2NGhWeXViZzYwRVdkUlp3dTVL?=
 =?utf-8?B?bkpDZzcxTjZ1K3ZFeXk3QjViV2F1RnhhOW0waWtzZW9yOTlyc012dk5MV0hm?=
 =?utf-8?B?eTBoU0M2TnhPcTRwZFRaMGFzcERBQTJlN0l3bjlrbTFXTGUwem5GdDBKQmZr?=
 =?utf-8?B?cUdHQ1RjdDRML1RkTGxOTmNhN2JiYTFSS2U1NEtaRmt6N2pRUm91R0I2OGVG?=
 =?utf-8?B?YlRGRVYwR29pdzM5SHlma0gzYjA3KytWYm9wbng4dVRDQVB6em5ueWdaMFJh?=
 =?utf-8?B?WFp6ZWpxeS9mNkpmSmVOY1B3VktkTzhoS3pKc1VVZENBbERqdU1Bd1BQUlFp?=
 =?utf-8?B?UmtZWGRDbGg2ZU9OTGpqVitXZEIzSnJFOTFyY1lSZnZLUnhvaTV5bU5mbmN1?=
 =?utf-8?B?SGxqUm9pdlRCUzZ5QjlJUWZndEZ6NkNKZ2htbjlmbTlGYVJEbmlaRFlpdFhr?=
 =?utf-8?B?M05SM2l1ZUw2TmZ3TkdEWHYrb3JwMTFxOXgzWWNaRHB1dEM3UWt5WVpYR3Zr?=
 =?utf-8?B?NHVYUm4vVFM4N1lvQW85N1RFWXMxNk54V0JqdVc0S24zS3hBOXgxNmZvaW81?=
 =?utf-8?B?SS9sU211Vm5sWjVua2ExakNWaW54SDRMbFQ0WE9uVlExcy9jOWMwRStQMEFE?=
 =?utf-8?B?aUFVSDNicVVYWitPS1JZMGtwN0NxcStUUW9FdktCU1k4aUpZRm1PVTAyYlJY?=
 =?utf-8?B?SmgvTDRieEtvTnA0MHJtTjBXVHVTZDN0WTNydzF0VnMvajFuMVM5dHVMOEhX?=
 =?utf-8?B?Q0JvQXBTWUZLY2RrbXF5c1RzZGhpeXVPcEoxWnA4STVtN3NudTRDTkV4ck9x?=
 =?utf-8?B?UCtTeVVDTVZZVzc4OFZkSmlFLzZ2T2llU3E2TnlMbzQzN25UNitNVWJJcUZr?=
 =?utf-8?B?QnpmbnV4VXdsVm5XTHhhYlQzR2VvRWVCWCtHNHhmUGQyYXVEM09HZmFPd3NN?=
 =?utf-8?B?cUEwdDFsOXN6RzhTSGF1bTlYeHlGYnRpQWJpQm01R2dqcFlwY0Z0anJyMGx1?=
 =?utf-8?B?V083WTFicHVFeThYcmsxSHg0WEk0VGh0Ri9YcGl5eVZ4TGU2dWo0NXJZM3FY?=
 =?utf-8?B?N3FTSmg0NVB6SWdkY1RTZ09DVzRpNHhWRXRkTWU3NElqVHh3TE1xNU5KNHl5?=
 =?utf-8?B?WFFMcFRQSW8vMlphWE9sUEVuWEcyVmp2L3ZGNGVpZ2QwcTE5em96UFRZMUpO?=
 =?utf-8?B?NjJHUGo0dUFhUVJHUDFldncrSmZ3a2YyZEdRbUoyTmNTYnlkbjFuUlcvMHAw?=
 =?utf-8?B?MHYzeW9pWDBKcndVQzYwZWhFd3JPdXpaU0puV0VkRHI5dHRaSWpKQUlaTkpk?=
 =?utf-8?B?UVhqbFhNVlh2NkZvaWFzRjJqSGQrZm1ZVVpnc2x2L2dvZzZSei9raXE4bkN5?=
 =?utf-8?B?ZlNsQ0txWFQxeVU0dEkrU3JBZzFwZ2tCb2FnRHZDQmhJOUh0UEZTSjlKV1lS?=
 =?utf-8?B?RE1EeVlCc2ZZYVZqV2V6bklraWtHb0x4YS9Qc05ycTZvOHRhblBhRHlnS0U5?=
 =?utf-8?B?aXZ4S0J2ZS9mbmVjbjQ2RkV2OVAwU3NxTzNiQ1Y5SkMzcW9tUXIxWUt1dVNh?=
 =?utf-8?B?RkRoR2RsYmlBV0p6ZlJBVEo2VTluTUdQTTRYeHNhUTJzSitxK2lJNzNBWGJm?=
 =?utf-8?Q?HyMY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:15:24.0456 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1378f8f1-8241-4005-e86e-08de372d64ff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7592
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

--u5znzz5tlj6vfxsi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On December  8, 2025 thus sayeth Andrew Davis:
> These are common for all K3 based boards. Add the common values as
> defaults and remove from each board defconfig
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/Kconfig                           | 1 +
>  boot/Kconfig                               | 2 ++
>  configs/am62ax_evm_a53_defconfig           | 2 --
>  configs/am62ax_evm_r5_defconfig            | 2 --
>  configs/am62px_evm_a53_defconfig           | 2 --
>  configs/am62px_evm_r5_defconfig            | 2 --
>  configs/am62x_beagleplay_a53_defconfig     | 2 --
>  configs/am62x_beagleplay_r5_defconfig      | 2 --
>  configs/am62x_evm_a53_defconfig            | 2 --
>  configs/am62x_evm_r5_defconfig             | 2 --
>  configs/am64x_evm_a53_defconfig            | 2 --
>  configs/am64x_evm_r5_defconfig             | 2 --
>  configs/am65x_evm_a53_defconfig            | 2 --
>  configs/am65x_evm_r5_defconfig             | 1 -
>  configs/am65x_evm_r5_usbdfu_defconfig      | 1 -
>  configs/am65x_evm_r5_usbmsc_defconfig      | 1 -
>  configs/am67a_beagley_ai_a53_defconfig     | 2 --
>  configs/am67a_beagley_ai_r5_defconfig      | 2 --
>  configs/j7200_evm_a72_defconfig            | 2 --
>  configs/j7200_evm_r5_defconfig             | 2 --
>  configs/j721e_beagleboneai64_a72_defconfig | 2 --
>  configs/j721e_beagleboneai64_r5_defconfig  | 2 --
>  configs/j721e_evm_a72_defconfig            | 2 --
>  configs/j721e_evm_r5_defconfig             | 2 --
>  configs/j721s2_evm_a72_defconfig           | 2 --
>  configs/j721s2_evm_r5_defconfig            | 2 --
>  configs/j722s_evm_a53_defconfig            | 2 --
>  configs/j722s_evm_r5_defconfig             | 2 --
>  configs/j784s4_evm_a72_defconfig           | 2 --
>  configs/j784s4_evm_r5_defconfig            | 2 --
>  configs/phycore_am62ax_a53_defconfig       | 2 --
>  configs/phycore_am62x_a53_defconfig        | 2 --
>  configs/phycore_am64x_a53_defconfig        | 2 --
>  configs/verdin-am62_a53_defconfig          | 2 --
>  configs/verdin-am62p_a53_defconfig         | 2 --
>  35 files changed, 3 insertions(+), 63 deletions(-)
>=20

I should probably add it to my TODO list to look at these. There seems=20
to be a lot of stuff we should clean up

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan

--u5znzz5tlj6vfxsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEE/Oiw75B1nI0/tSm+wPir0+IT1wwFAmk4LvcACgkQwPir0+IT
1wy4fAgAkwVx+fwgieef+b24826YVdi60sab/uOZ9uZvNVD3Kf/wl564HEuWthFU
Iwhz3ijYJmnnk/BxYnSDwD8LlxTjVU4Y+ISMupTJVKD/PozymeOd7cVY+MNWJeec
5PZbLasJ1tsQ5MQ7+8fZV83cTOjtymNGKkdIfkDBdZn3N00FjGtDALZoWbiDV9va
IvX5602oCgv/MbA59cusXsK10/73YUQ6VOlnVIkUoPCyq6kGmnPMKeREmV1cS6w+
UzdCbzUxcnp2a9EVvSrHZm2CCID23dWtyO8Gb3EeVf/6S9xYbsXXjFTLyTluxH6X
22+nP1GdVHz2TYP5bETzQIgHuWdBnA==
=yPbt
-----END PGP SIGNATURE-----

--u5znzz5tlj6vfxsi--
