Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3F3CED618
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 07:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 466258912C;
	Wed,  9 Oct 2024 09:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dbZgIDWG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A998912C; Wed,  9 Oct 2024 09:27:20 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C03D88EE0
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 09:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVvcl1uxk341HcILlEedQV6T5Wdr+Xp4m9MkSksUyUsY8CeZexVNm5bGdYcydbFcOF9LQy2pq9dBcE7FD/TnpmoXU5VYapVfh/xLV8k3zxeKVtXlXgL4C2pn1RBNOG80Lu7pPu/nL8TXBmRz0OiXdIdXyI2iTc4PTIGLF1m8v/EIWyfjgkuBdNF9YnPSP/uKc7jObfv7YZ7eva18N8vNOG/FOi9K3kneWOw2hT3llW58avdXp4bZhCQNkVrf/v9oSKVH1UyqCnTXuFNFgLd0expcSuZcYL6pk0LNTLxhGc3TODhO4q/Pg2RI42/uZJDtiq3JixrxoeYOJnBMRZXRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TInoatSrabQZ0IlaE57qIsouMzmjEe0/rS7htivgeJE=;
 b=ETssbghur8krRKzf/jBLL0KuMKGFo56qKK4aB/eAffVyDqfv01xOcdUqEPRs/kWw7wj9YJgjggyR8i9tB2A2WDHH43VOVbxG76my1QKFsFy/jnSvI9Fh1kueSRIyzvBjfQ9Y0RVI3qPT9YZ9W6XUQ2WhfeEKH5CVGIGpWSvtInkqTZ3e8ioq3ZzdWcASzhVL2BmBIz6exDrLTxss4oF2z6lkouSSc4QpxKMQVXzb53SS32rOqVlFXFcf8OGeRwD39VsvHCvE2E8YhkLufgzu8hxZhXpaom1CCcLBcebxTNROToZ4he8BJU0fGkIJEyLUYXFYMXO2NVBXprvUfegfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TInoatSrabQZ0IlaE57qIsouMzmjEe0/rS7htivgeJE=;
 b=dbZgIDWGxmDIeAcrzcqyVTy4tw+XXfCRU9RjVRoiKu73nQMmNu1ijlG0waJOBVi9wj71ZQHmoYSQ6xvlN8U6DvTDYxzvhRxYXRcY7paJwRGhVBpMQdsIwtdCip8Z+4iAEwtrTEsniMoR0JsrXpSHGPLK8G+OnpPbPPVFTd9MHIJhG4q4T0l9YyThbf002c7uT/LRA1Pj/JPQCj3XahH8g6+0Wicyt6Ro0t6sb/qbT1Ofma26xCteAzAvhvkGbM1Oc9s7lGyAqNTCyb98IAWPE6E0QBvV5lNvSpnmOOJ0UOfSSDWvInMXGtsMVF+6knHRLTltKwprAibWu7yXsRRCjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8438.eurprd04.prod.outlook.com (2603:10a6:20b:411::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 07:27:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 07:27:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 09 Oct 2024 16:31:02 +0800
Subject: [PATCH 1/2] imx9: clock: Add 800MHz fracpll entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-imx93qsb-v1-1-50a4ac53ccc4@nxp.com>
References: <20241009-imx93qsb-v1-0-50a4ac53ccc4@nxp.com>
In-Reply-To: <20241009-imx93qsb-v1-0-50a4ac53ccc4@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b69e0f-01dc-44e7-b1b2-08dce833cd45
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1hkZkF1dE5jNzg1V3l0bXgvREN4eUFqTkdYaHI3Y2JqaGFmdkpudU5MM0k0?=
 =?utf-8?B?MzRRajZtRHcrS01TQUpHNXB4Tld5eVcvZ2l3YUZueVFTUE9KaGd5NzJsNi9B?=
 =?utf-8?B?eWpQQjZERUNNTzBPRHZMOUlBblFISkxsdC91UGFIMXgrazFQVkUvdW0yRVhi?=
 =?utf-8?B?TU5NN3Y4dmtsQ2thQzRwM2FzcFFaU2dEMVk2bFlKQWN5RGdLU0ozdmYvRmx3?=
 =?utf-8?B?dmhGdzJCUW9aRGlPS3BSendyUkxDQ3hhZ2dFM01DK1UwUzZlK0lkOSs5ZVdO?=
 =?utf-8?B?WkZDRnFLTlNZVUh2QWFHT2ZtNTRLSlVQczNRR2x6RGtxVmFkSUx0UzdtaHdQ?=
 =?utf-8?B?VWxXUWI4Q0xQenNjWE00OW95bkZVS3pHZmVoSUVtV2lueGVzaVk4OFN6VG1E?=
 =?utf-8?B?S0YxMXpiTzA1OHk2SDdjSjExcmJUSTUwRmtvaHlSdUh6V3lHcTZ5RXAyYmEr?=
 =?utf-8?B?Y2NZZTN4UVNZYnJXWXBTQjlBeW8rU05QZm1QS3Q2NU92eUtJcWJ0bG5CMUUr?=
 =?utf-8?B?a3pXcHlOZFlGd3BWdDlGL0Yva082cWtWY0M4K0hrWUs0eUZKUWFidDJrT3Js?=
 =?utf-8?B?NENvYnZESlNyVmhxQ0JBZWo2MVQxTERhcER6OG5TMjBNTkpua3VuMk1uNUlp?=
 =?utf-8?B?Z3lJc2RsWXJSbG1MWkZnZlN2VCs1QkZwdlhWSFQ1WExLL3pqM0pPNFQxczlV?=
 =?utf-8?B?OG9HOWVxbWRTSnlOdERCOGZLWUdYV2twVUR4VDBQNmxhbThNYm8rcDBWK0pM?=
 =?utf-8?B?RE95Z2pHOC9kaFJZWU5jejZWQ25wd1o0SjZrcVBUakVWTDNXNUtHZGhPVVA1?=
 =?utf-8?B?R0lSaWVLYnlwbmErMHgrTFdETUpBeHBQeVR1L3VDVWU3b0hOZ0EwcDhFVzNl?=
 =?utf-8?B?MlpOUTc3bXBEaEJvcHJQVStTWjNNakk5cDdGNmJPMndFdHRPaTZ3czU4UHpJ?=
 =?utf-8?B?ekFvdEZ6ck4rb0FKbWV1ZEpLeWJNVVd1OFU0RDhqR1hZUlpiSXdXbkVBUE9v?=
 =?utf-8?B?UnVHcldCcHI5eHkrRU1tQVUrSU0vN1hTY1FMMis0d1ZkTW1IVHNuYWNEUzdL?=
 =?utf-8?B?VHV6WWRpaGNEd2FQb0tRamdteVQrdVoxTGRyd09sVUFqY244QmJWKzRzNFBh?=
 =?utf-8?B?d3ZmaDk0VEZkbEsrcXdGN0w5RkJVeFBicmdXNkNBS3M3aC9rRWQxRHI3V0o4?=
 =?utf-8?B?TkNMR0hKOStnUEJKL1pzWWtNeXFmc3pONzFqM2JCajFWS2MrQ1RIMUZlamQ0?=
 =?utf-8?B?emY1OUJxZlVPMnRGUVE5d2pSUzdSbXgyZy9DOFdxemlqdks2amtIVnY0ZTlz?=
 =?utf-8?B?VWlkbnpIOXlpejJjUmlCNkl6akd5NExtdXd6ejNnVEhsdmZtZjVOVGVBUFEy?=
 =?utf-8?B?Ujk1SGJ5c2tMS1ZSdHpqVUNvWG5sQnVCQmdyNndqSjMxWHJYU3V6L1ppMklv?=
 =?utf-8?B?SVlDNUlzOGQ2OGZiTWhKbzFrV0tIcFlROWJ6c2FTTG9OWktINHhtdm9Xck1i?=
 =?utf-8?B?TWtUV1ZCWG5sUm95NWpQWVBDR01DMFBQWE5uNnZRZDBUTmlUWWVwSllTYi9t?=
 =?utf-8?B?RGZTaGNwd0l1a3paVzZVQVhPVEJ5VFpUU2hIdU9LcHI5OUswdGdOMVZzK2xW?=
 =?utf-8?B?cFJaTy9RUktSbVF3ZG02N2hFSlFabkRUekVjY3c2TEdlVSt0d0FxVFdmNjZk?=
 =?utf-8?B?dEpDeGFoMlhvVDBXUVY3SXVZQnlrTlBxT1FVSkJPSndnbjZ4WjVKUFgwbU5E?=
 =?utf-8?B?RVZGdDZ5MVZDK0Z4YVhWNzRoZUtQQkMrWWdPZkN5YklNSTIvOEtkd1owNzZt?=
 =?utf-8?B?RFZ4bHlXeUFCRkY4UXB6Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlYvNStFZHNya3dTNE9HK2VFM0c2WFRTRmhtbkQwUDgxWTNhQVdNRUkvaGRa?=
 =?utf-8?B?S2Zha0FEclUwM0MvRjBiOEtOeExmdGhvbkRhSXFiRkl4eG9OaU5vbjBNY2FU?=
 =?utf-8?B?U0YyN2NLdzlyelBDWGZGby9WZkJ2eW0wbkpaTExVczM2NjYvaS82a29qMVhp?=
 =?utf-8?B?QnRKM2hGRFFUc09RSDNSR1FDQmlJa0hWQUpVODdXVVZnaHdxTyttLzI0RE80?=
 =?utf-8?B?bWlibTltcGxYZUFqZjUvQjI3MlZhR1FJcmxGWElaeHBycjhDYmlVakpJWldT?=
 =?utf-8?B?cGV2NVZyU0F1ZSsrRTRHWFk5V1lNejZoMXhpVVVEU2dkeFJOcTdqWlh6UEtt?=
 =?utf-8?B?Unp2ZnNUa2NWVXhNRCtsMEd1aXRYRXNKZklLNS8vRU5MMEdQSFdCaHBWZENC?=
 =?utf-8?B?K0ZFdnhGVlBTcWo1TndieFJxbEtIRDNIMy9ZWVU2eHA0TmZPR29OOXljZnhJ?=
 =?utf-8?B?Vjl5RDhsY0Uzd1dVem5IMHRrY2swM1ZyMzFiUitHM1RITzZhNnB0cmMxalBU?=
 =?utf-8?B?VElaMUh2UTd4M3lrSEgyckUvNWt0dHVLVnZmRE5BWXhtWXdmR0RkUFFCUjFX?=
 =?utf-8?B?dmlaaWozSzZ2cWgyc3REYllCVy9aVzJVM1VXQkpEdS9CN1lBRWE0ZnFJOGUy?=
 =?utf-8?B?bHI5WTNId2pmeUNpWERsZWYxQVVqY1pha0svWVpzeHdPVW9YZHdHOGN6YVUz?=
 =?utf-8?B?bUJVVUdCRUViT1JZYUdmN0xLNk5WRFZSZnpockdCZUIwdmIwTWJiTUVwQ0Fu?=
 =?utf-8?B?eFBKYW5KM3Y5bzE5M2IxQUxRK2V3ZkNXMzI0MzFaeUJiZ2JOYThOVmdOK2F5?=
 =?utf-8?B?MUlGZ3k1ckYzY0lKNmx6dndUYmxOLzRaZFNFL1lRU2UvK2plSGE0VWRzREZu?=
 =?utf-8?B?cjRLZWpqUEtMdE85WHlieDlmV3JUR2J0TFAwbDlUdjkvNnNqWmJrVk5JTUVB?=
 =?utf-8?B?L3JTdmJSNWdOQisvL1BBTUJGS3FaTUVpbkZZVlczdVdCeURvUnE1SXh0NHky?=
 =?utf-8?B?dWdIbjZwYTBadFVyZDdmZWRnRy9ZMDNoeDNCN3IxbG84c2Z6Z0gxTzNxaUI4?=
 =?utf-8?B?YU9kYmxKUEFqcXdWR05PYU1xaHFDc3RKc1M1UXl0ckJBdStwZUFlWVpqUHk1?=
 =?utf-8?B?bmhPbEptbWFXV2lIUUVJdVg3MFpySEs1MFJ2ZWxIRE1HSWRCSVJ5NVhLYWxu?=
 =?utf-8?B?VDl2WmlkWHhhYS9oc0o3eHpSNlVJQVBMU2h4M1ZnRkpsanM0S25IN1o1b0Z6?=
 =?utf-8?B?SkhVcmRiN3hyYm1GUFpVZ25xaWRld2J0b2xZMTlxZzFMZDcwSVdkTHJvdnFR?=
 =?utf-8?B?RjVITmRmMy9ORGRxWEZ1dE4xZHZkQVY2WTNIV1lsMS8yWVdWVDV0cTl5YXRr?=
 =?utf-8?B?UVVqYWhIZHoyOWlwM0NhWDRVOG5aZ05yNm5ZNGI4SDduNXpQR0p4WW1DUUxO?=
 =?utf-8?B?NStSc3dSUFlTVkhML3F5WVZ5Y0liMmhYc09wRnd1TUNUVjlWMkpmU0xVWlJR?=
 =?utf-8?B?RUVmK3ZnbUsyQXFKYnRjbXgrelpsdXV1YnRUSHc2bSs2QUQ5UlVtemF0RjB4?=
 =?utf-8?B?Nk5mTzBGblFWZWVya3FnZW5IVzBsNk9IaFovZWJGOFhsWHpVY2RZeFNQWDMz?=
 =?utf-8?B?dG94NXFzR092OTRIRU42Y1RPT3IyNmlQSGJQRGI3NVp5MWgrUFRWMGMxZEgw?=
 =?utf-8?B?UDVueTdubmkzV2N5cGgzMURjckh5YTVPQTQvbWExeDhTc2JnbmZKUDVZNStM?=
 =?utf-8?B?VDdZcGhocXNZS1NSYVpJKzV0blhyREtET3J1azNjVzNMRXNyREQrUkJ3LzhX?=
 =?utf-8?B?Smpja1NxNXlRb0lZQ3Vnc3ZIbnNjWmdxSDE2a2J6aFJleVpna01DZjdzWWZx?=
 =?utf-8?B?d2tCZ21wQUdvQXk0WmxSTC9oUmFWdkNtbEdUNTIyQlh0WWZRNU0zcUtwOVBl?=
 =?utf-8?B?NmkrZFg1WHU5TzdRYjIzZk40TWl1amdBaFdMaDIvYmhFMkhaOVlXVTlVZUhO?=
 =?utf-8?B?VjhXVWhBQU1iVVRtQlFwdXNOQkw2YUxlV3MvLzBqbkJqWXZZTjdXYnpVNk80?=
 =?utf-8?B?bHBMclBaMGdHSTd2cVBlMWpvTmRkaWZnaTN0SE1LVm16SHVrUzhoRnUvQVpN?=
 =?utf-8?Q?Pa/D3YkZoBqm07FnGDevBGxv6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b69e0f-01dc-44e7-b1b2-08dce833cd45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 07:27:16.6160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TucykKMsFKxfD+nCkymhAxEDpUKdKfe6Q1kpz5lM8+C3BLv3q1+nFXe+Yy/kzCsq2KQjd3v28VeV7sthnbZx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8438
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

Add 800MHz fracpll entry to support DDR 3200MTS.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 12685f970de..e42ad263d63 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -35,6 +35,7 @@ static struct imx_intpll_rate_table imx9_intpll_tbl[] = {
 static struct imx_fracpll_rate_table imx9_fracpll_tbl[] = {
 	FRAC_PLL_RATE(1000000000U, 1, 166, 4, 2, 3), /* 1000Mhz */
 	FRAC_PLL_RATE(933000000U, 1, 155, 4, 1, 2), /* 933Mhz */
+	FRAC_PLL_RATE(800000000U, 1, 200, 6, 0, 1), /* 800Mhz */
 	FRAC_PLL_RATE(700000000U, 1, 145, 5, 5, 6), /* 700Mhz */
 	FRAC_PLL_RATE(484000000U, 1, 121, 6, 0, 1),
 	FRAC_PLL_RATE(445333333U, 1, 167, 9, 0, 1),

-- 
2.35.3

