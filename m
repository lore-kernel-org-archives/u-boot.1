Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC813C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A80D282845;
	Mon, 28 Apr 2025 12:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ArmKmkzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 316B1828A2; Mon, 28 Apr 2025 12:39:23 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C76C82145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfdg1lfOiaIn2Jl9d0q1+Kp6rW+ZBUPUwn/4T1lJwqQfrSM3jBERhWhhbWSPDKisgcHTC97Bk8N2CFAQZeJNxT69sbhgBKIWdL3F7TEgxQkaC7UI3nTMDJSG9GiBmgcMvDhAF3rVgWk62WnGGGmzowY8QH7HwLob1ibthELMgFXo+Og0PSLaDRu17Pk5HEw5ajHnf1xCoP56ZG6bQOMyN84Ou2x51YUwNrHH5Wjhrbs1UIaRyZfXOQ8GTjga7GPeCR2XGRvK/ACGqRZ67d9L62/F/skd/nBVjlvYyHhPazlV+qc801lMPI462I3QAcFzPeQlZ6aY2HMQiIwAAzT6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsBGKbsLaoyVEB+Fwp57pXxUlx5vA6N8AyFTPUmU1fo=;
 b=NJyepm13rjAvDbZ//9aLjjqt8/h9pvAWwvs7YbXIFiNM+6poAXY0OJvjb6yYMoyt4Yn3x/XY5eeQ7bmV63CKUmRDNbLPf2e6nSKZlW+OqztdMi8WzUxTpKkgPNQrAybdg4We5oPUHiVrQTCRBKRQ3s0JS7wstCiA4eZRB6N+omVkxSvbt2P6fN14PgV72wgQkKykV2VZwMQM/36b7IJm0+QWOpdbBvKbb8rbd/OqLsGpfyvwrA+4NdSvgzMiKFjRHDQwuc5QAijsl2IlKgVKgtVIdpEfVjdfrUxcUNbr75u75k0mrKY7VSI4hDKfrsiuvz+QQPustXlNwJd/L5jTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsBGKbsLaoyVEB+Fwp57pXxUlx5vA6N8AyFTPUmU1fo=;
 b=ArmKmkzz9P8iRuu931Q+rSTnmyenzLttA2Lv/W9OS/IKdfgwp9M3nNl9ig4ZXNUn6zjh6w6vTsJAULSY18x1jbKtgxF37ozybhpr5YLGEXllOmibrM1K/dNjcUjkzV2XRdA3dxlR8LId2svX3OzGeB/FJqRXMHoFBnIg4nl1A6lbr22YP7RkUtm+HMqbYZm9JQcJNz2vHSK6dMQQe35jIA/Y06l6sdQOB4o/SYM3hlw/wVdD5nNRuFmKHMikmGyi7/f1tBBKHJ9pwK1yaqU/Tc/cLvJsqRJHWQEohH2B4LbdXPRU7Iv4YTbhGumIAG6N4GBt+IF+Lww7gXZqpvpUdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:39:19 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:19 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:36 +0800
Subject: [PATCH v11 13/21] spl: imx: use trampoline buffer to load images
 to secure region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-13-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7eb3cc-9f47-4159-576f-08dd8640ee73
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmZMdlUvWDBnTVJXcnBUbisxYmF0aG9hVmh2MWZMbitvSDg5NUhQVVIvZlpU?=
 =?utf-8?B?Tm90VHRXWXZwWmpPelNtSUxuVkV4Mm9oZkFsY1ltaWRIc2tHNjZ4OWh5My9N?=
 =?utf-8?B?a3ltVkZQcXF6dC9CLzJNaGhNQTVvcW5jRmhaT3YxK0l1RzFEa1U1T2lsYTlT?=
 =?utf-8?B?dzZKR0hCKzV3d3VLeG5yM3BFdXh0Z2lRVFYzVUFlRGhFWXRTZGUxUEJyb24v?=
 =?utf-8?B?Tkh4Ly9Kam9YK2piMTNKUE8wYW1Ca3ZiMG53emtnL1hoL1k0T0tJTzM4MHIx?=
 =?utf-8?B?ZTVDNE1VWWp4VGYxTkZzenpvYXJpWlFoR05iQ2ZEWEJJT3lGcitzRlpxeC9K?=
 =?utf-8?B?a2U3UXJwYUFQdk91b2tqSGl3RnZSTXNEcVZJZkY2Y2RWdndxTmxzM3U2MlRJ?=
 =?utf-8?B?WHM1WHRNb0lhRmVaTnphaE9jbno2UzAwWHlyV2g4NTg3d2FwbXBBNnB4Njdu?=
 =?utf-8?B?VU9nSmJSbytWenhuRGxET1JTdWtmK1dUSStSYVJqcmhwNFFjbiswY3VpVW5G?=
 =?utf-8?B?Vlg0dElEcXVzLzI3UktkYTFTL1NlVHJvYUFLeUl1dlJCQTFmenhBZWJKeUNy?=
 =?utf-8?B?MnZHM3dzTHgxMTBTak1XRXc4bDZ5VjdaK21KdDdhQVFndWhWRnhoNlhVTDFl?=
 =?utf-8?B?elQ4RDhPR0NWSXFzeitVcmNmdFFFR1JoNmpCWTNZeEh1bXRRSWdBU2RUUWZG?=
 =?utf-8?B?WGJIWS9rUWNoODh6b3d6ZEVtcUJXKzJqVW1hdTZRL2huUlE2TlBlR3NZS3I3?=
 =?utf-8?B?TCtIZkNjV3lxazZkSU9QWHRwdE5YbkFqQ0txVlAzS0JOaXRUQ3dFRE1Xd3or?=
 =?utf-8?B?Zng0YlZkYXdTZmZuZ0JLb3hjRy9RTXJTemNSRTJ0V2h5N3hrLytrQ09LeVE2?=
 =?utf-8?B?Y1AyMnBSUzVEa05OdU1Fa053d0hQUmtqVG5KREtneUlrUTNlYVVQRlFrdXZx?=
 =?utf-8?B?QndnTmt1SGFiaFA2ZGhsWEcvallpSXkyTVRtT1ZjcFNIY0hvL1ZSK0hQNThw?=
 =?utf-8?B?dzNVdGNtV2dYblA1elVBajFrcW9aM1RuTVAvYTg4aDNIMklHcjA0SVBvZzV3?=
 =?utf-8?B?RkFSVzI1aXJjenF3T3NldExWY2ZQa3FlNTlPS1pMWm5qaE5HbHRoQzJVZDhJ?=
 =?utf-8?B?MlZDUWY0WHJwSEkrSmsvSTNUY0VnSkN1bXltMXFGRGFVaUhnQ0RVeG9kU0dV?=
 =?utf-8?B?NHN0WWVWcnpBb1cwd1NEaWFuMWRXU0RkY3FINllLc0JXUFk4RGo4YzNXazk0?=
 =?utf-8?B?dURNUDRtWGQrTnBPeE9mQ1hCcVZoRnlua3dxckJNWGpKWDl5Q0dJT293LzBP?=
 =?utf-8?B?Y1h0aThBTUpSOWV1NzhCMGh1OVhZMmdqcStwbnVkeHkvL1F1dWI3enhrQ0xU?=
 =?utf-8?B?bWV6Ri83aWlBK3o5dTVmcy9NdzdvY1A1ZTNLeTd0VTA3bG94Wjcra3FqL0RU?=
 =?utf-8?B?clFZdnZoSm8rTlJpQWsxaDY5aVZSdFNtMEg4UkZHWTdDa0VWUCtha3J5U2RH?=
 =?utf-8?B?aGJiUmgxZlQybWljdEhSbkp0RVpPL2xMWFZIZWJUQWpPK1JXemdBZnEvS3RM?=
 =?utf-8?B?VUdKQ0hNWFVwNlVuYURFRVNMSFR4TzdOWDBjWHBMVjVuUHhoZExGR0syZ3Fy?=
 =?utf-8?B?Vk5hR1duYWkyQjY4N0Frd0JybU1LYW1jNEdDeDZDa1p3NlVacjJ6ays1c0Nl?=
 =?utf-8?B?MEMwWmJjSmMrZjVsYmh1a09sTnF4YWtlNGxUalZwOWVxR1lUd1BYVURaNE0y?=
 =?utf-8?B?UFNRbDNoMEY5d2pOQ1ZleFFmY211ZEZyeU1wZ2xrQ3h4VGZIbndwYm5GRkRP?=
 =?utf-8?B?NUhrbkJKZGI3UXhIS20rSHFNZWtXKzQ4Y2dTV29lOFp4dXArdGNPMkM1SzBu?=
 =?utf-8?B?ZjBVQzRSY2QyeUV4OTJMWUM5clRheUxWREIzWGM4WFdMUzAzejBXNGVXNjZR?=
 =?utf-8?B?NWI1Q0pxT3h0U2JSdTFkMVRtQ1RUUVp5eFBJck0xZFMyOWozMEt0SnlUbFYx?=
 =?utf-8?B?OE1xbFVCbUN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm1wR3UvYnd0NFVCd3A3ajBZZzBpaVJtY1FGbFhsdk4xejRLN1crU2srUkZy?=
 =?utf-8?B?ZlVMSVJ1Szk3RE45cnk2NGhxdFljamlqVUFpNG9QQVFLc2NBcTM5bGJuWDAy?=
 =?utf-8?B?NU1UTFNCSGZyTFBjVWxzV2JkNldpazBsZDR3YWpVQmVRLzE2TWJIaE56U3lD?=
 =?utf-8?B?MVVPeGFBNFllempnOTFQUmhsaVNpYW12cmFhMWExdjMvM2QzR0U5QkZkNUtX?=
 =?utf-8?B?Q00zYTdqNEExTEtjd2poNExudFZkNUdNaUNKQ2tCMDM1S016T1FQeVRGMUo5?=
 =?utf-8?B?WWxsVXBlR1VmUGlWU281SUNxd0tOVklpUFVkU0hIT01IRTZkQWZNdjJvU3Yz?=
 =?utf-8?B?RDVSaXhWL3pRL2l1WTd2MENKbnVUVmNPc1hPejlXSTB1UmlHUDR0dlB5cWlm?=
 =?utf-8?B?WWRrb3VLWlpYVDdKNGpibll3emlaWEp6UjdIUWhwTXhlQnJpVklrTzQ4MFNy?=
 =?utf-8?B?ZFV2aExSRU5zcHJiUko1NFJzMmVUN3ExOGxCbDBSNE1YOUlsMW0yK1Z3VjR6?=
 =?utf-8?B?dmwrNEwxSDJsaHB5ampISFdtZW55bmV0WGV1SGRSak1RLyswdlZDZVpkZVRn?=
 =?utf-8?B?Y2xlN25hMGFFTzQ0U3p2Qk1uV1IySDd0MWlsL2VPM1JYek5rOHh1ZE16eUda?=
 =?utf-8?B?d3dERG44WnJrLzFIUG1NRFhkNngrNWFrZGtHeXRCYmtHLzgwemF0ZVJNSTF1?=
 =?utf-8?B?cnVKbzhvMHNFVW90eGo3RWNJNUV5ZUtoZGhON1dXdzRIamM3Q2E1Z2FnWWY0?=
 =?utf-8?B?TTgrdk5icHEwUjkrSzFMd2lGV1RQKzFTemxmUTY5V2g3QVBhNE50dWZVSnVm?=
 =?utf-8?B?SmZPeXZQbVlhWUlrNVpzdVJTNkRacE1OQlBsNm1UQzdlTVpVNW50VXR5WVRj?=
 =?utf-8?B?SjhOcDUxUWFWYlhZazVvRTkyWis4b3lhRVlvZHpRRmoxME1UeVJjd0xoY3JP?=
 =?utf-8?B?QVg1VzFzKzBhM0dXS3BaU0xTblVsZ1RHSDhwellubjF5a2Q2bkttejllOEdr?=
 =?utf-8?B?SlBycnpUVXRlRFdNSHRCNHNsbEMrSFZYaDcwZ2tWdDI3RWxwbUphWjVtd3BP?=
 =?utf-8?B?MnEzaFVBeUNYQ21YeVJiRm8vZzJIYzNDdUhwWDJ1YzA1OXU3NWI2YVo2eWsr?=
 =?utf-8?B?WkFWMzhGbnlxMjJObU40VFZNVktPN0lPdGZCOThzWk1jVU02QU1IQlNTckZv?=
 =?utf-8?B?Y0NVSGdra09PcVdmTEdDLzNHa2RUc2pHOHNpZ2FhWG00MTd0OXVnanpRN3Iv?=
 =?utf-8?B?dUpXcWZXelJVTFVFWjZrbExDeXBJb1g0TnU3TURidlllZGs2K3J3QVJ4bldP?=
 =?utf-8?B?RmZESUZhWGw0dEM1alRVeGtQdGFjYjVmUzdzSmVkSVZhc1B2aWVXNVY5azYy?=
 =?utf-8?B?L21zMGxnY05uZk0wUlQ3Y2gxWm1sckJQSTJYNXgrNXdaWnpLd3lRWVR3SjZj?=
 =?utf-8?B?dnRHR294ejlEU3dzTHEvR2t3bUNCRkluMk5TcE5lZTdVbHJRdWFTdEJFKzMw?=
 =?utf-8?B?MjdpSDVXNXFsM2Rja0UzMjBXc0F4SXNRTUZ1QXdpNzh0RTBRRTFWdHA4b1ho?=
 =?utf-8?B?NlQzajNPUE80SkhFSTk1bXRYbkk2a0RFa0VHZ3pYaHdoS1p3eGRsOFdjbHMy?=
 =?utf-8?B?UmpZUFpCSjc4K1V6STlpdlZMaXJaUVNxZFYvbXJHSEMwejBnVWhTT2tCR3pO?=
 =?utf-8?B?L1d2MmIzVFk5ZGhBcncwcCtadE9BUExGQm9MeWltU2pQTTFGL2NUSXBDQTIy?=
 =?utf-8?B?Wm1UZEFlWmdaZUVuY3M0OXlPMUJZR216OVZzQjl5RkJMdmVNMUdHRjFmRWVm?=
 =?utf-8?B?bmRHZXl6dVNrUlBtYVFHcFlEaXlKZmhRMk1UdDdmOVBhNGNiZmFScFRUQ3lS?=
 =?utf-8?B?OXBXZWxMZ0I5akwyWXN4UlZwL0RQWmdNZG00NHVKc04xc2hzQTlFb1I1TGhl?=
 =?utf-8?B?M1BHcnp3VW16Wmo1czBkemVHSmdKWmc1MDdzZHhNa1BrRWNlOXdSOW9XN0d2?=
 =?utf-8?B?REN2cU1HTHprMkc3di9WWno0S0h5Lzk3TEFxd3NVaHhZTDZsRy9CUjQ5RVkw?=
 =?utf-8?B?YUVmTWhyanZjTk5LdTA3MEo5dmpMZ0pYMW1JK0ZUUUlZL2lLZ2k4bXhvVmRq?=
 =?utf-8?Q?uG+aSf6u/fbINCRap+5/C0CTh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7eb3cc-9f47-4159-576f-08dd8640ee73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:19.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TknDrgWXmiZL9mSbVapribYzQIop/FuLOFPWG+ZQ+l0iJsl65Akltt/bRHUgG/FiunuU7cIGIJ7nk1O0rwP1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

From: Ye Li <ye.li@nxp.com>

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 ++++++++++++++++++
 common/spl/Kconfig                |  6 ++++++
 common/spl/spl_imx_container.c    | 38 ++++++++++++++++++++++++++++++++------
 3 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 3a5bdddd785..d2b0455bff9 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -729,3 +729,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index b076f49ac00..0bc96d0a781 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -363,6 +363,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd3..b3565efb225 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,27 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s: failed to load image to a trampoline buffer\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size, buf) < images[image_index].size) {
+				printf("%s: failed to load image to a non-secure region\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT

-- 
2.43.0

