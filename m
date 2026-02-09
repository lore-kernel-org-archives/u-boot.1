Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95065EF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D926683AA7;
	Mon,  9 Feb 2026 02:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tp7krsf+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1047183CD3; Mon,  9 Feb 2026 02:29:13 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D84FF83C30
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDJnjQa7WgIXUGuMkaWLCv9JNIT9Xd1U/DgHri8aOIoasrB0HhZ5ujRNZlMtfo4B+lrF+TOH1Z0t3A2xTV9PY+G6KIbqPxLHX1ibFurGfj8N0EcpiA/4b9pn4Gam/ENwGO/tKXH/y/A2qLsizkES070zKdjjvQ2IruUD3nfz+IaFezbpOMhwffl5g7KqHCgv1Dx59/f2n969L6OLrk1srtD4zxBnrdLbkNmdsnleSXKbrtrIoTbJ2rodhY4EX/mEUhTw1SscXa0mg8R2oVL5C1sz3NT2LVE/2A0yp5DbqAvoLb9Km7dESaP4SDloPZTgjlUdtBc64jzpk2Mytsh/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlZ7txCufvgBDrNMB2IW01K9N8kpcuL+X1j2xht0yaA=;
 b=tdq9wNey+sAPPx5kFTJ2isJvj3REG85Dl/qQdi5Z8gnzhXtJNA0kJxZogbiMh5tKQ97+0sxbZz8ecrvipUsShBxLiuEohcUiwVvEqF1upEhoaTTp7c4aYDI1lSY6GYRRPqr+c0dy2ps+T5QBGhhdyr5KvNu/CND6TbHPdVLzhoPDESepKiMkgmpsbO9j88Jv8yekUvE3ehu9wNerT3BvSU20I6CRHFSXXXixqoWPJTKqK4+6zcNNtN1bJx/Fs8sixFhQ/SVgqM7a0R7M1liwwSbjq2CUQF3HTQCMmhyHA1OrdCXIA9+Jnz6Qlpsj25tnDMwD+P9T2KdqLg/LdQn6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlZ7txCufvgBDrNMB2IW01K9N8kpcuL+X1j2xht0yaA=;
 b=tp7krsf+qoyGZHqgm0nCzbXbT77Ij0qpgxkPF3acfrZxBviSkFNovKz+4V/oPahJ8Bkgk9CA7OPFjo+DG8YO8LAYxp7pRIbWZpgV/1ZB3JIpIFbiJclCD4s4joyjrT/gJBG1Zt2wvu6dq0Df7o3wYcR5JG6wjEYAUt+GXtjbiu/7gHylX0V+KXJ7oCfdzmtTl+lNgYZRqF9fNAcB2e2cx1gDzdwqQ0oC/Nj2mM90Ts3vpGIrCrVOt1j2TAuqtBHSWWPhetnLZmFk6IJNkHBXdYbDAlZczSBChfIxZ31rclpMOArBDxthaOlMgp9IZ8BTpY5OoMI5rh6iA6S2y29NJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:29:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:13 +0800
Subject: [PATCH v2 09/14] rockchip: evk_rk3308: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-9-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 1911668f-ddee-49fd-2a48-08de677a9f4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nko5WWlNODh4K2Y0ejBCL0xOcFR6VncyVzBoc3hjYVNnUk5nYUxmNWJZdGx1?=
 =?utf-8?B?QlhhUTF1M2hvOUpib2JsV3J2T0p3RW51dC9kY3lOa2plSjNxaXp4QngrbVhV?=
 =?utf-8?B?WXNBTnQ5SDFBb2k5ZEdIYW5GZGtJM0ZzQitCRFcxOUM2OEJZaWhhRDRpcEJy?=
 =?utf-8?B?MGRxK1pnNlp0RUdiQkFxRlZ4WHlJamEreXZQZm8rSm5MWHJTOWhISUllN293?=
 =?utf-8?B?c3hHYjRWYzlJemlYTm42dExQZVc1NU84WDJneCtSVnpZb1o5YWtrVTl6Wjl5?=
 =?utf-8?B?QUs1Q01FNS9lQWtjN3ZDUUg1c084OVlGeWFpbUJjV1A5VXFNR3BicHFKWVFY?=
 =?utf-8?B?bjM0YnNpNHZhRHR1NTQ3WHpDWG5VcHFUNENzcXJEV2lSV1hZaTlTdVFpYnBF?=
 =?utf-8?B?ZUp0UGZNZ0wxZklGQjlPaThyUjErZG9veHplMGo3VkRXdTRzVnBVSXdHbktQ?=
 =?utf-8?B?UHJ1TmV4K3k3YW9xR3N1V2FNd1lyZGI3SUJOR001MHp0K3JBK2NHRVlLaDFG?=
 =?utf-8?B?VkQ2VWN1VWZTTU1lem8zVUYwQVVMR1ZJUmxNbXdPb3hMelZGV0pvYTJ5OGJS?=
 =?utf-8?B?TlpoY2FodUpMTFNaUG5sTlZvSy85V2xydktUaFpLbFlHSEtsdFBKa0MyWnJ1?=
 =?utf-8?B?RTg0YmtMQ0VBZERGZUVJYjNGSFRpclZuTUpGck1yM1dwWWFGOExsR09ld0ZQ?=
 =?utf-8?B?QlE3cGUyV3psUXNNWkg1Z29aSWZJRGxOOFZvYXkzT2Y2ekc0RTJpQXNub1Rx?=
 =?utf-8?B?citvbmgyTmc3WEYwR21xV3cxMzdNaFkyRzhxTHlpNi9MVERvU01lVDc0NGlp?=
 =?utf-8?B?S1lRVVlkL2NSMjBuczRLb1FjTjVFdkI1WWhFamRvUVFMRG16YUh3SHl2eFNC?=
 =?utf-8?B?bmVYZzB2MlkxTFF4R0c4OGdRc3RlcXBwNzR5SFZ4a252dVMvK3MwVzdEbDV6?=
 =?utf-8?B?QWZ2c1l2U01KZ0daUkdpS2FFQklYTTQ0YjdsbXpEYXBaNTBOQnVWTjNtZ3lZ?=
 =?utf-8?B?aTJGMDJqZXE3Yzd5QzVlYzlmMVhZellWVHFQMHZBTHowL1A3Z2Q1ZkFncklG?=
 =?utf-8?B?U1d0WTJBbEwrWmprbjNrTUhGeXRjRVJ0cnBLc1JEcFh6Mmo4U0lJU1BDeDhk?=
 =?utf-8?B?VzRncmRCU0U5bHp1WGJDTSs1UlorV0FiY0RkTThOcUNQaG0xZVBDVnRGMG0z?=
 =?utf-8?B?VFhKTXFpbUdxaUxCSnY3bUZqaEtrS0I0VDllUHZlaldUSG53YUpERlJRTWJy?=
 =?utf-8?B?SHNjUGpUQUJIUnNlQ2tBNmZNTDV5TENUQWhUU0ZjWFU1UERRemEvc2t2RWRR?=
 =?utf-8?B?NHFZWXdoMDNHTDJJQTBxZ3ZGc1RaRnl5eWxxWjBXb0RTSC9ObHIxRUNPMkxx?=
 =?utf-8?B?VTRaY1lTdk81VHFmY294ekh5dVNNK0xtTThuR3NSaDVuRkMzaTVFNCtBOVRu?=
 =?utf-8?B?MXhOMmFXOWdrZEV2WVJGeE8xbmQxL0tySjNTYlVnL0UrOSszSG0wWlJrb3FW?=
 =?utf-8?B?OWt1OGoyQlk0QUgwdms4QVB3b2FmbnU2c1gxYWRoQnE0R3BQVWM5YnBHa3Ez?=
 =?utf-8?B?MFNROWw2QzNIK2YveEN1VzNsUFE0dE1OOEVLdldWdjA2OGwwdmM1eWIvNHJ3?=
 =?utf-8?B?S25NZG8yT3d2ejJvblJYMHZCV2dWQitURXVUY1hYNVFVZ1NQSVdzVDJEa3A3?=
 =?utf-8?B?ME1rRzVOUy9TSWoyaDdDcHAxMTZad1dPRDI0aUJQN3dxelhLcUVaWkkxRkpS?=
 =?utf-8?B?OG8weXBiMzFTTVZFWE8xeVJiZXhPOERZdlpCVVcwSDZiUXFaUVhwSjZVMk9T?=
 =?utf-8?B?WmE1U2lLMzdSUFZDNDkycTBydm53bEUrYU50MnNzckx0SEJpd0dVRVJuMU5N?=
 =?utf-8?B?aEp2b2l6WXJlNXd3TDBBRW5Ya2NjZXU5S3krYUIzREpNODZRd2lhQ2Mwb0s0?=
 =?utf-8?B?dHJteWdUNDhiSHpGWTNRenhZeVB6NHlKZE9DckQycUpZK0tCTVJzSmppcnVx?=
 =?utf-8?B?NVFBdHBZRU51NVl1akVxRCtRZHNjQ1FpN24ydkpNWTNiNXlEOHBib1JHVVd5?=
 =?utf-8?B?NE5wR1ZzRXZiWWhkOVFLOGdaYWdKQ2V1b3JQNk91Z0ttazZxSGdMY2IydDZ1?=
 =?utf-8?B?MXNtdmFxZnBvbDJnRHl2T3ozYmxJOXlkc2V5aEc2N1o0QzNlTUQ1d2s5aG9i?=
 =?utf-8?Q?bY0dKF4lkgphqWUcNHfDW3w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXlOQ0hYOGdHNUNTa2NiNE9YN3l0VHZJWjlFQUpFMW9OaUlmQUlSNU04UkxP?=
 =?utf-8?B?RVpheXBOZUw5Zm05bVBTbUVzajVmQ3loWXNlYkNQRUZYVTVqMFA2TGMrayt4?=
 =?utf-8?B?cWhxOFBRVlNRTjdJNzVwUmUxNXdsdmZHZklmOVZlZ0hNY1hUaUNjUGhUOS9Z?=
 =?utf-8?B?SmZ6aHJwc3p6aXdoVVcyNWtiRDdRVit3YmRjTDVlUm1EKzViV1NyVWw3ZzJ0?=
 =?utf-8?B?aFRYUk5jcHM3RHBub0xkdW5FdEs2UC9MelRCd1I3aml6UVQyMVFPdVJ3c3Zx?=
 =?utf-8?B?VEtQZDMzbWhhU3FuVUVFaHZia3N2VFZjN2ZZVXhEQXpWK3pOU0FwaFdwYzlx?=
 =?utf-8?B?cWhQR0dxNHpwdVFBNHBjdm5MZFdCYUR3REI0MnlMZHc4bXdZODBBVk9sejNj?=
 =?utf-8?B?QUxRa1p4Z2V3Z09yMFRuTng4TEQxbUovRUdZMVBJMTVVc3l4cE1nU0Y1eURp?=
 =?utf-8?B?S3AyUlZMcUtEemJTL1prUHYxNTY5YzNIYW10WHJCMVl2TWI4eXRobVRjTnJ0?=
 =?utf-8?B?RHUyNEJkZU9IR05ab256QTBsdDVycXMrdnRpajlBclZDTUROR0RpaVFheEt2?=
 =?utf-8?B?WXNDZlNnYS8wQVRBTnNzQUlaVkdHUDkrNFQ5Ujl5N2NNenNVOGQzc0RrbTlM?=
 =?utf-8?B?ZllQNDBRYlVmZkpubGhUN0paYXZqMm9RejVsSnFORDJPZ0hBN3ZHbWRhdk1E?=
 =?utf-8?B?TjZPQyt1Z0NBT3NoeGZ6d2pSVDljSGRlM0Nkc1J2elg3c1B1SVhCWExJWDdh?=
 =?utf-8?B?eGpqSENvdXRBM0tST3AveEtKSUM4OUd2aTg0YmcwWDNUc0tzclovb1V5WURO?=
 =?utf-8?B?ck9rUWR1dzZOckQvL0h2MnJuMmQweDNCMFJUODFFM3BZMGRVYkJGemZZWDN6?=
 =?utf-8?B?OVU5MDE4c1FtV0dyYWhkRVBSRE11V09GL2FSSmp4Qk0veHcwck5ZdEtiTitQ?=
 =?utf-8?B?WUNIMXJKb0cwNnZYays1UmRrbDk5VGFoaExqWjQ1azFaZiswTHJqLzAxNjBF?=
 =?utf-8?B?UkhwYThuZ0thTVU3b2RUSzN4M3dhaVpHUmwyckJJazdpS0NTZ3ZCQXNmbmFY?=
 =?utf-8?B?ekF4ci9HaFJ0S1R2S01pb1hkM0RLSlVmTXFNOTQ0MURUelpKSzdBT1I4MlJr?=
 =?utf-8?B?WTFjM0hIWTVXMVJIMGl2YWlVT2o0Qnk2UWNzK3k4NmVPcXYvYzczR1I2RVhW?=
 =?utf-8?B?c2Z4dHNZb0VHemN0MmdtNWlYa0ZUdUVNTkNUV3N3RWkwUzZ3UnNhNlVvYzAx?=
 =?utf-8?B?aU5CUVkxSmw3WUFrZnIzUHFhWUZ5cVBDMXBrbkczRnUrSWJYTndEQ1prRkdS?=
 =?utf-8?B?OG04RVBLNmswKzRibXBJVGttN1p0VHRPT3Fud3ZVcXZDUUJHNVlkeDg1QUtC?=
 =?utf-8?B?N3REOThUUHR1UHJBOGRmWEJCOFdXT3I2V2U1UE1NVUEwNUt1c0FySnc4VTBt?=
 =?utf-8?B?ZDhHcTZLV0p3L2doY3VGU3dUMkZNVGJpN3JjZzdZSWlQNldGaUJVTE1yc0VK?=
 =?utf-8?B?bGZCT0ROKzVDbGpiZWE1a0s5SUszdzdaa0RucVliVWRkSG5aK244ZjBxVjI5?=
 =?utf-8?B?U1ZSWWcyVy8wNENvcXVuWVl5eG9RbFcyMUVLR2FCQ3ppNzFzUG1hcDV1Mjdr?=
 =?utf-8?B?Z1NPcTI3U3FzQ014c1dzdHI2QUpuWW5DL3B2RlJnZHArV1lQV1JIeThqQ29J?=
 =?utf-8?B?NXh2c0k3K2VvMUpPNDQ0dDc1d3FSNEJOMzcxdTBNeEZZTEJENjhPdk5WTnZY?=
 =?utf-8?B?Q3VvRm0rNFA1cXdDK2E4L1g0RmFudUIydG40SU1sckZTNzBOQk1XRDFnSmhD?=
 =?utf-8?B?R1Y4ZmxabGVvOGtaaFFCSVAyMXpIVGxCaFhJK3FkNENmTW1KempUaEprWGxh?=
 =?utf-8?B?YmhMNUJPSEZYbmk2UmpxY3lYZ21FcWZCNmdGdkJ4ZW9SSlFxUkljdjNPaDN4?=
 =?utf-8?B?YjgzZUc4WDJ1VVhaeG1VTUYyYTBlUDBKT2ZjRTdwNlZYdGNtQVRwVDc5MXZy?=
 =?utf-8?B?N01MeVg1VXIvUTVFbHNQczc0K0VYbXRRbDFpNDlqSksrWVljQjZnTUFUellN?=
 =?utf-8?B?ekx5TStobllFeC9JNXUxT3JOdFQ1NStaSDJqOXpEV29MM255WjhyTkRlbVpo?=
 =?utf-8?B?MmlHYmQ2cXFyblIydjRQOE5KVjVheG5sb3IxLzRoRFI5ajVtdVU4OGNvbzNz?=
 =?utf-8?B?QzE3bjhSclBhSDd3NXJBQlFRckVMRlFSUHM4ak54ZlJReTBFMXF1TXZ2RHdJ?=
 =?utf-8?B?cGlDc1hrTFBMNUhRWTU0M0wxL000czFiL1pGYVZpL3JIeWk5QzB5TFB5Zlpy?=
 =?utf-8?B?TEFDeGg4ZUlsL0JTQnVCY2FFb25IK0lVT1B6VFVvcXlWUzZ0S2p3dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1911668f-ddee-49fd-2a48-08de677a9f4c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:09.0556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMbwrEUGRoJWjKJ1yZEjn5wAXIgm7Luv7l3vd0Q+bQz4TSIkXEFBQzXW4dZFg4KBBWBufeJiLUytAHfVuFKQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

There is no user of 'gd', so drop the usage of DECLARE_GLOBAL_DATA_PTR
and the including of 'asm/global_data.h'. Also include correct headers
to avoid build error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/rockchip/evb_rk3308/evb_rk3308.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/rockchip/evb_rk3308/evb_rk3308.c b/board/rockchip/evb_rk3308/evb_rk3308.c
index c895da934a998b4f8a4a8b32fbc7336bd4c41604..75536fe117db3fe26abf5a60d2d68e72ee99dfde 100644
--- a/board/rockchip/evb_rk3308/evb_rk3308.c
+++ b/board/rockchip/evb_rk3308/evb_rk3308.c
@@ -4,9 +4,8 @@
  */
 
 #include <adc.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;
+#include <stdio.h>
+#include <linux/kernel.h>
 
 #define KEY_DOWN_MIN_VAL        0
 #define KEY_DOWN_MAX_VAL        30

-- 
2.37.1

