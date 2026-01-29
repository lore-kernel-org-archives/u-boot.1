Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D4FD358EC
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 181B083E96;
	Thu, 29 Jan 2026 10:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k81Dke1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0155083EF9; Thu, 29 Jan 2026 10:39:51 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DAD683E52
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:39:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZKj+ov8aa8LsYjIuixQD9hHz6ud73NMQDXPfaqJ+UdHm1+isqE0Mqwqb+zaeqUQtaawlrwVvNZ5A6rCkUKHtyR28IdZanjhIjZFiWarweTSQ5o5WRoIEIInBuxpDvY0ObnHUgjkog4aAP2UXEgaWWluEgjw8gWGuQybA7+FGRimgj2ZO24sux/1QuEPCTHsQCj6UJUIq/KJPZFih3CkGG4UXbpy2ocZ79iJZz4GfhCSVy4nr3k9zW6TTzJWuQpDdSUESnFa8woLJHg/SnAVtyy7zx925G1xg08/Io7xUIOKjpm4DThIJcAVmU6i5Dqd3wYWQU/SGzT/0kHFdWyNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgqoo2jSDj7eEQvH32V0rblVlrRKyHhzEzPNe1H2sPs=;
 b=P7zniH7E/2IifGltLIb4o+512811IycJREWM7Pr4WDOtvirmruIlafQlFOFXAyzbDDaIfgfJ7bwipwuAiRN/AU4alCjRxEX0AgWhPjlVsexuQwzgq4wB68O19GXkR+Yv/oSaxusXbHvRzp57OXNfKdI/GYmlG4BKNNCmYZVkfa0rQumQRygbP3Rqp8nGNQq7GbEr/EafPfGSZe7bDZNP0VLhJ0HHUkhzcCYHE6e31LYrELZ6T1R8X1h73jhRX+TrhHYsH+gLpAxIbMouJrOFhpc6wbYJPSIu9R70i/IkjBzCCuOqfpH2tEwD9YDPxCx3jMJjnPXhoyryNg7/h2D/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgqoo2jSDj7eEQvH32V0rblVlrRKyHhzEzPNe1H2sPs=;
 b=k81Dke1tZUAIUxnylcuOo8X9AheQoBNifQb7fe6MmG8veSYf4WSCphB2d/u3GC0GlvpOLpdbJOSe1lMylhKwZk24DyOgYH+d9SH6yp7vDGpKB760hPKH2L+TiaTv+Ycw/AcmWdW+tb33XiIuRsnpprNkrZyhPuAHLR5y2qC2s/4i2XBHIeDLgcVcwBgwxJRXd6YdUBmsphvRhVZRfqyIJS5l3S3fXn3FMTPYyD0Us9eSxlJpyUppzfE70P1Jru/bU9tM4Pj43eroABFjgshqXeoVaeZ2uCbc90VoIgxSAhyzwsS2CxtpEIOKtgcTVZwY4602xn6lcbe3RggW640ujg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10384.eurprd04.prod.outlook.com (2603:10a6:150:1dc::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 09:39:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:39:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:54:10 +0800
Subject: [PATCH v2 08/12] imx8ulp_evk: Drop board_phy_config
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx-clean-v2-v2-8-1245ad2c3a01@nxp.com>
References: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
In-Reply-To: <20260129-imx-clean-v2-v2-0-1245ad2c3a01@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10384:EE_
X-MS-Office365-Filtering-Correlation-Id: a31c3cef-df4e-403e-3905-08de5f1a571d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME02c29CL0dTR1VRZVpMTVdkVTZLNGF2UlJPcFVoY1dZMjBUTzNDZHBVSVNa?=
 =?utf-8?B?cFduMnFtb1VQNmsxUWkzWHU2TklpQUE5T1JpR1d0UVhVWnhlNzl4VFpXNUtK?=
 =?utf-8?B?eEVCYW1LWUwvcnIzTVRNL2wvRkdxbUpaS21uSGpsd0VEWDBWTWxMSVlyK1ZJ?=
 =?utf-8?B?RG43Z1V1QWpkZXZDV3VEQmk5RzY5N1F6M3pCUGhxMWhXbzJYVjE5elMrM0pN?=
 =?utf-8?B?UUIzUXZDWjZmc2VYY0Yxc1ZNRTM2K3Bvd1ZhNWhpM1lmZDBJYzRhcUpZM3Yx?=
 =?utf-8?B?Tk1paGU5SWE3d1Y5MUpiY0N6czNFWU94NnBqMHdUVVI1cWxPTlJycm1FRHlm?=
 =?utf-8?B?NldqQXdWVW1QU2t5LzN0UmtJUUcxc3JsWENRN3d2UWJjWm9Tam9zb0J2T1hs?=
 =?utf-8?B?M1F5WGRnZzVGaktCaWhsY1RhYmtMSlZEaUNWeUthemE3eHhCTzN3Q0NQemg4?=
 =?utf-8?B?RVkzUkt3WnM0UzJhVUFkTGhBTVI4c0l3TStMb0hvUjFSL25pdVJDWEFzK3NF?=
 =?utf-8?B?TDgrMExiL3RBaGh6bkZFWXNleG4vZkZ6eWhrZjd3M05BTDJYdjdCR3JiNDgw?=
 =?utf-8?B?U3Yza3QwOEIydDZJWG5ic3hPcTJtNFloUERlMmw2ZzFmNlVDaWd1SVNIbVZ6?=
 =?utf-8?B?c3FoTWF1Y3NNVHVwbDM3Nm01UlN2Q2NFZEh1amV3WW9LbC9YTE15ZHJpVmlV?=
 =?utf-8?B?cGNsdG1EbUJGTVR5ZnNnNjA4V09SV0QzN0M4SUlIM3dpWHIzTjRiK0VxZWtK?=
 =?utf-8?B?UlRTY1BqaU8yWlRSbW5ieEtONDRiZjJKb0UxMnRoNXFabkFPMHAxWjM4d3du?=
 =?utf-8?B?Q2pCTnpRb29jSDNYYUdQOXhGd3RBRzY0K1JYZXV4UmIwa0p0NzNDaHZUTlJJ?=
 =?utf-8?B?cmM5VS9yMkVjcjF3Q2xsNm5OanVUOFRPMFB4WmI5VUxDSWI1M3dTQVBWMjJQ?=
 =?utf-8?B?N3VnbzUvSEVwY0ZhR2ZjbU5UdHB3U00xMDduM0RDS2xKdzRzWWlpbjhENXVJ?=
 =?utf-8?B?MU1mSWtqR1dEczVKY3NWb1lSYTBMRXhTL3hSZXNRa3ZERjZzb3JwUGFHMjVJ?=
 =?utf-8?B?aUJ6UStxQWVNNXM2M3Zaalhkd2ZRWnA1bXFUL0NqakhTVHlCVDFjMEVWWmE4?=
 =?utf-8?B?NkJ0UFhhSHA5RngycktDSndNSmhOQVlKNEFOL093aUU2VlRxMXpDYUFLV0RN?=
 =?utf-8?B?TDkyZldxWndxVG94dXBXd2d2QXZoYzhVMzA0enRid0kvR2Z6dUYxZk1PTWJq?=
 =?utf-8?B?cS84UnRTWGxJekZLeXhDamZCMkR4MDIxdWNPMm9LdkFiK3M3aTQ5MHJ3UnVL?=
 =?utf-8?B?cFJmT2NNQjVGbzh6S2tQWmt2SEdoR1VRYzR1RDdaSUo1eGlwSUtYSVhQUitZ?=
 =?utf-8?B?NDJZUytNL1Fxa0pURmF1dXRyOHpDY0pmOHhpY2lPdkRLTmd1cGxCZmd4RVdy?=
 =?utf-8?B?WnBnRFE2dGx5SGtBNXhXam5vUDJOWmp1OGtUUUlxanRvWjZSZUlwVW5XT0F1?=
 =?utf-8?B?cFBlb3k2WDhpaGJWeGdDNDNkaG8zNHF4YTljZ3ZLc3hEVzJXN0pCRnFabSs0?=
 =?utf-8?B?ZkU3ZWN2b2RHcE10TTZZVzc5cFFaZnZiV0tjV015SkdwanhNM2tVR0EwRlFU?=
 =?utf-8?B?K3VxcDZiRDNQaGkzWW0wSTlzTzVvcXpQSUFJcCs0MDR6UkVBU3I1cEVQVm9S?=
 =?utf-8?B?QWVMSDl0SjhQbFhTb3hjbkx5dVN0cHBVeHNEODdxU2toM25aZGdac1B0OHdK?=
 =?utf-8?B?RHp0R3JxM2R6Z1lkU0lFME5FVWpEcGY1Umk0TlBkOUlCQ291WmVuZjZ0R2xW?=
 =?utf-8?B?eUlnZzBXSHhiOFdZbTNYbFY0NUg1TGJtMUptVWJud0FjMFlUZkNhZ045dElk?=
 =?utf-8?B?VEpKYXhFaExzV25TRSs5U3NVTzNuSDF5UGVlc2ViYmFMNHRmUHZsZzdLbTM2?=
 =?utf-8?B?TlNGalhWNWN5V1dMeDBqYS81YjN5LzRoNllqMVpkR3lxcm95NW9IbUk2VE1C?=
 =?utf-8?B?TkNBQzQzT0ZTZWFHNU1PTHV1YjRkN1MwajNYQnRyU0liNWhRSCtUK1FFZkh5?=
 =?utf-8?B?SUlyUS9EMnlBMHUrcFZMc0FBZTNlYTI2WVc5OS9XbEZ1Y2tyZG9BQ2JXcUVQ?=
 =?utf-8?B?cXVJazBId05YcEl3UGJoTmJ1cnVFT0JZM3h3MmJxL3UyVzhESGZjSXNKallW?=
 =?utf-8?Q?0iGfUIg9jy5PfewBfSfKVEE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FCb2IxdnpNRXgvSWplL3daNm9taDB6QlFkZ2RkRnpjWmhydUtqTVh1MWM5?=
 =?utf-8?B?Q0ViL1Z2K3ZIVHIrWnBmT2hFL1Y3OXgrVXplc1ltMHAzUEsvc1J0cXRRUWR6?=
 =?utf-8?B?cnB6V1U0VEt2THVRem92WXVUeW9QUXh2TWh3dTVSQ1Y5OW9GMDFnalVZNjBB?=
 =?utf-8?B?RE5ybGpuSG5xbUVIWG5ka3VoVnNLMjJ4YVNVWnplUGRLWWdQUlVkbGxZNFJa?=
 =?utf-8?B?RkVFai9RcEtuVnZUeDUrVld4MElxUzFtbDJzcUtGOWFwU1RLb3JzL012Zk55?=
 =?utf-8?B?anNEMC9UT3VMUXpndWRSSTlaMkdWaTJIQ295RGRMeThWM1ZIOUh3eFBYNlU5?=
 =?utf-8?B?TEZIMi9hVXZRTjRvc3JqVTROMS9rdWpBZGtKRXVyaE55aHJEdUFkWVBsdVR3?=
 =?utf-8?B?NlZlTE5TdDNPK2NKNnFBM2Jmb1lNbytSSFpJSDB6R2M4cm9pR1Y0Rzk4NDkr?=
 =?utf-8?B?dHBJSWh4d28wMkUzQ2hXa1g5Q1Q2bnl1ZHBIUllpUkxjS1J4cGN0UDcxdnE3?=
 =?utf-8?B?aW4wZVB4b1ZSRVNmeWJ6TkF3RGx2bFpDbEx1MzBmaGZKMUNkMUw5L1NJakNE?=
 =?utf-8?B?THNYaGZ2c3VUWFhVbkhRSFdtemliRzljdHpQNkgySWhHb1FaNS9sY3NmTjVr?=
 =?utf-8?B?dlRvaTk1SlREVEh2cXorV1FGV2IxUlBQYzUxYlhkUUF0OW9zMFZnT2dJN0FG?=
 =?utf-8?B?WkdjdUx4WWxZU0pBaE1yeVcwcEhyWFpML1VHKy9FVmlsK2hyOSt0M1JHUU1M?=
 =?utf-8?B?eGxLU0NXV0l1WElUTzVKeDhWMWZrcEt2WURYb0VJZmhmakQrTUtaZ2o3VXA5?=
 =?utf-8?B?cDZWM2NGOUhXR0JLdGVibCswYXNPNlJwUHdZdC82T2NmdzFweThtOU85eitk?=
 =?utf-8?B?cWlYUFRIcGFrWVppL25SamZCZmtFQkdOK0picWNpcjZPcytVQ0dXdGg5TlFl?=
 =?utf-8?B?VGJvcjloaUJaU1BoMzBvQzFLWUJGeFIva3FFUXVFSEJBNTNFb1JIV2xQM1hl?=
 =?utf-8?B?S2dlQWNmWXBUaEN2bi9rWVMveENGcEUxV3g5azA4UUU2VlNkSm54eXlWeGE3?=
 =?utf-8?B?WDJ4S2VvcW9GclFpbWVUNXQ3RFhnRHhmazlNWkt4ZE5NYXhYY3pxOTJFRzg1?=
 =?utf-8?B?Vjg4MC83Njd3MDlMaU1jL0NDcVJmeGFxcGJPRHh4YThMc1FrNnc2MExFWFdZ?=
 =?utf-8?B?endWdkNEYjRnSU1icVlraUYwRnhETW5TbWtyazgweGlpcHRuZkUwS1licHZI?=
 =?utf-8?B?YXpFNDlFaHJPNVdrekNXUTFmWTA3b0szRE9OL2o2cXFuUXN5OTM2Qmlydkw5?=
 =?utf-8?B?WTRneXZUdFRZZUxtZms3aUVmMEluN2gzR3g2WHZ5NkoyTnVBVUZ5clJoL1lO?=
 =?utf-8?B?RVRGNnhEc0tKejVZbnpIVlVzWHVFRE1aOWlKMDgvTjR2YklwTkhwb2F2WHBu?=
 =?utf-8?B?ZlJBNHFiOW1sdlh6RktqdmxVdk0vbmNLMExIYWVxdnkvRTZ5Smhlb0RqTnht?=
 =?utf-8?B?Slg1VU5sR0dwRlYrOU5UYlVoUlRsNTdWbG92Tytha2t5NE92d2JwY0lpbkdF?=
 =?utf-8?B?ZlFnSnVUZnRGYmhBajBFWGlKSUVQQURmTEQyemhTclpuVDdSQnNKYVlhZVlz?=
 =?utf-8?B?MVBCSmFzRktUOVhZUjMwb1JGRU5Oc2NKZnZoNEtEbHRZNzFnRXBIcW9MSm92?=
 =?utf-8?B?U0k0dlNVdEdCRlh0dGk0MGpwU2V4RmhwWmIxMjNrc042ZC8rVHlvZmZMVkdn?=
 =?utf-8?B?b0lSakJTK2UreHdlWG4wUnJQZEs0RmNSRnpXenFXdUMxYzByVmNLSURRZFNP?=
 =?utf-8?B?cmkzanRORENwQk83bnhTKzlzbDB3ZzRmcDFjZml4eXlQRnNlZ2NVbG9pUHhs?=
 =?utf-8?B?Q2FseDJmL0VtdGE4bTZwZEVXaVpmczJiajllbnB1N2hPek1XaFBBSWJQTC8w?=
 =?utf-8?B?cVp0Y0pjN2ZmQkpsaWljQlVndnI3OTZNTWNMUGJhTThyRDJua1h4T2swK2xx?=
 =?utf-8?B?bkUxSHJDWmI3ZGVQWERzcmRobzRxY1VkK0c0amJzemVhSHEzYm5yWWkwdWRO?=
 =?utf-8?B?UjJqcTVOYS9uTHdsSHpoT2U1cWE1akE4alptaEJNR1ZlQVFMaG5oVk13NURr?=
 =?utf-8?B?ZmROZnE0UC9kTmFmcWV0b3VpRkxUUDZ0bDFPdlRwbmhQRmF6M0dtQ2tTOElU?=
 =?utf-8?B?bnpUSzhmMWdjSHhjcHlTb21tNndtMkFKck5rTGlSZVU3RFVEbm9WeVdLL0VH?=
 =?utf-8?B?NXI5dis3emxqZVVURU9NWHhvdGVZZjJUbXc0Z0U3TXloRmRzeXVXeVFNU1ZF?=
 =?utf-8?B?UitwT3g4ZXVYVDRxSDdML2hHWkRUTGVyTFdQY2p2WEFJd3ZOdW1nQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31c3cef-df4e-403e-3905-08de5f1a571d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:39:47.0519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xXY9gwwdZLlidTE5ubHI2A7GDyHSDr+oAqxUa1h0ptjIGfAtLuijKaj4P8JTcoRczRL6ryJ8JZDD1pa3ak/5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10384
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

From: Peng Fan <peng.fan@nxp.com>

There is already a weak function in drivers/net/phy/phy.c, which
does the same thing. So drop it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8ulp_evk/imx8ulp_evk.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/board/nxp/imx8ulp_evk/imx8ulp_evk.c b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
index cd17f6960c7..dc4054b92be 100644
--- a/board/nxp/imx8ulp_evk/imx8ulp_evk.c
+++ b/board/nxp/imx8ulp_evk/imx8ulp_evk.c
@@ -4,14 +4,10 @@
  */
 
 #include <env.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/arch/imx8ulp-pins.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/pcc.h>
 #include <asm/arch/sys_proto.h>
-#include <miiphy.h>
-#include <netdev.h>
 #include <asm/gpio.h>
 
 #if IS_ENABLED(CONFIG_FEC_MXC)
@@ -38,13 +34,6 @@ static int setup_fec(void)
 
 	return 0;
 }
-
-int board_phy_config(struct phy_device *phydev)
-{
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-	return 0;
-}
 #endif
 
 #define I2C_PAD_CTRL	(PAD_CTL_ODE)

-- 
2.51.0

