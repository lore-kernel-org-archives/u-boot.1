Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9270FC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 12:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3A5832FE;
	Wed,  6 Aug 2025 14:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="l+HbLMnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC068338D; Wed,  6 Aug 2025 14:40:44 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB66A832AD
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 14:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oei8nuyI1LeLM96WrNiBKJWRg40JhyUKcBrwRyFOzswx6zdJH9era7nStDR8xw3BXyh/kqyrmWp7vNOLp1y87BtXQ8jpivdzeXflfh5cfvHnCgJiWCp5iY5rHK0wf6pqW/NRbpHD0cVKHm6Kx3xEqrvInDm+klhe2SuxPXYJCcWNTyUvoF3sESbyxdnydMFhIRXA1YJoM0rnSqkRyt3Vte9crrPvs0zrXkjxl1MwfKW4eqxd4YMgZOTOSXpXVDj8ZVuzgRlLH+/mj5ihrR6rBIF4YYq4iTfsa50liZ78blstGVXORgwy2ZQD2KWVwNLIZPOa5BdzyQfpYy9obVE2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVmBmG8WaY9m+Rl+WB8h7NhI+pWhRDN5jvDuw+nJqMY=;
 b=NfEs5i47040b7LFHj5K4ZPRjVp+s5cF2Mr718veaMlXspuHhiso21GEJpO9CI3JkN28eE2+FdImaveu9HTM1Bko0Z/P5MngCM3oKw7+/M5nUZFOjITqAW95OfzWB+c+5DTZyZpiQC6FvLoYjhRUvO5TiZIEf8XzatjWhtQdODD5ibkGzfbZylghAjfIaTe8xPMVadLDRnpuDXxvM54OodrIjr5QA9vg5sKm8gGHk2LMHM+MWXSYuadn0EilyJOHiIsZX9Ju/aXjfwrM8FwSznsOzUlESrvVJYlksMP5M/RYvvCLvzoqmj8ULzzRwB9iG4I0OLiyqNoqbJ5UqJuy9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVmBmG8WaY9m+Rl+WB8h7NhI+pWhRDN5jvDuw+nJqMY=;
 b=l+HbLMnTBiWRR5EWStQEYPKq3iLDlbLe+Jdl89MeEKZcVtUgkPaE60hMwP2W2B3QI3xSpXuRusYRbQeeo6Vpnim/a1joV3zMt66YxvjCcM8vN1jhkd1W27Fv+SEgBj3FHsyt/1FuCqQszz0KYrFSuzCFt+ni677H1eZIkAb81eoDhnrBFGyIBTc2wcfri9sqmqiEoINbftTCz1p3pkl/ByCZAP7yDqIBORSfD7vGQbRPGp6SC/ksM2z3Wi+8f1In9mGmsP4afX6+OcF3Yx+Ot1FWMAyYZv1v/MxkYiXfwWM+fVM+Hl5N232fkir+k76I3v3zF8T3TPTHUSBemMMUtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by OSKPR04MB11391.eurprd04.prod.outlook.com (2603:10a6:e10:99::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:40:39 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 12:40:39 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v2 0/2] Restore support for i.MX95 A0 silicon
Date: Mon, 28 Jul 2025 07:34:59 +0800
Message-Id: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKO3hmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3czcCkvTJANdM0Njy0RziyQji0QLJaDqgqLUtMwKsEnRSmVGSrG
 1tQB0q+KYXQAAAA==
To: Marek Vasut <marek.vasut@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|OSKPR04MB11391:EE_
X-MS-Office365-Filtering-Correlation-Id: 01cca73d-23de-452c-216a-08ddd4e67296
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXlndGIxU0JydXRsbjdZZC93NnhBc0pZQWE0MVJ6dzRuS3J1SWx1ZExwOG80?=
 =?utf-8?B?NXFsVGJoMzdmRGJnaFRTSFhqZUZQeVh6MDVpQXErT2graDZ6YmxrTG5FN2RF?=
 =?utf-8?B?M1ZCNmNLTjEyYnVoYWZVczV1cEVTRU96cEFkZkJRaE1NbEd5anJoK0RqeTBJ?=
 =?utf-8?B?TlhlbTVyLzRWc2UrMHMwMHVJQk5oTVozc0dqSXdJVk4vR29JbHA5eE9EcnE0?=
 =?utf-8?B?ZEYxL0xYUHBUSmJFVXFaWXBUNmJxR3lOUVVOSzVaRHF4MzRXdVc0L0x6SFh5?=
 =?utf-8?B?OTFBc1FwNkF4dkIyQjRGNklwWWJMMnZvUWUyY3hCN2JSb3BXRWdiemoycS96?=
 =?utf-8?B?S3FuV0JEZG8zS2NuMnBmcjg1K1MwMVpybGZiUXFqMitaaWc0eFBhNEpQZ2R1?=
 =?utf-8?B?WS9NMTRjRGpOQnZoeHh1VFZaNHRlTnJqZTI2L2huWFRTWEZBSE5wbU1FTWRK?=
 =?utf-8?B?ck0ycm13U1c2ejVEcmQ3T0poUWloQk4zejJaVTV1RXMyK0FUdlhEQXFKZUtP?=
 =?utf-8?B?YkNmc1dpcU53VDVpcDZvblJYNG5hMXlCSVhYL3RYZ1h0dGo5dGozZlEvdk5h?=
 =?utf-8?B?bzZzaVQ0WFhTYnZXcDI3b0cwQ1BSZVhNVlc3UGF6eHQ4Ni9oYVJ0UmZvbkpt?=
 =?utf-8?B?MVdtRTYvNXgzRXEwVWtqSDdsMG5KZlRLenhrVTQ3R3dqQ0R1V0FWWnNOa0JC?=
 =?utf-8?B?b20zaDNGSTBqYzEyMWt6aG5ZRE1iellIRlBHT2hVcEZWdEw0dXVCczZvSlJl?=
 =?utf-8?B?bnFzdjlRczgzRnFoNkNDVDVNMjY2T1RtNFhMZUVHRzR0OEhhck42TDVkWkpI?=
 =?utf-8?B?eU1IMHBtbHQ2QndHQ0IrR0s4L3oxd3pMUDd1dEc4VjJINDlBajhnWlVCaEpo?=
 =?utf-8?B?WlFzWDR6WFRqS09teEc3ajZ5UlFPSlVhVHdrQXNxOThXQm5SVFJKOE01emd0?=
 =?utf-8?B?WVU1QkY4Rkc0Sm9lODV2YWJIZm90TkdUU0tJQlVDNW9FSVg1ckk2OWpuQUsz?=
 =?utf-8?B?c3EyaVU0Ry9MMUpBQnAzMXdpZE1jZVV6anM1NnVOWkNTK3RqbzE3UWsxa2ov?=
 =?utf-8?B?VnAra3BpVk82Wmc5SzczanROcHZpMG1vdnNWSkhYeUNGV0dJbTZteHlLT1JN?=
 =?utf-8?B?eXB6b3NhUUFwbXZ5TnpWZnFRZngrL2V5U0NnTUJwYnFRelZTeDJCbnpzK3pL?=
 =?utf-8?B?MXBFNUJXNXNIcTFBOWx4aUZKS0Z0bmM1bzJyQXBEQlVpdy9Fc2lUdWFQREJR?=
 =?utf-8?B?eWxicG1FQlJPTWU2MFRQUTIrbkNlOFhhc3RqakFibW1WUXlCRnVMbHNlNTdq?=
 =?utf-8?B?bVE5TXpxRG1EenBNRTNjOXp0YkpycTRSNkl0WEs5ZTQ3cVAyT3ptM0YyTVlJ?=
 =?utf-8?B?elJkaG1mZ1ZQazZvSEREek1NS0xrNThWVEhzKzlrdlhld0ltRUFSZWl5ejhF?=
 =?utf-8?B?NWc2QTBjSHFsQWMxRFJUZHRZYXNwV2htYUJqVzRPbXh5Visxck9GaFhZbWZk?=
 =?utf-8?B?VS80WFJTTDVlOVpydkdrQ1NMZjBCdnNxWGVuV29QOHRMdzNVWkt2bndtQmgx?=
 =?utf-8?B?M3E1dVMrOUMwa1oyMi9pZFNFRHpOUEwweHdLMmdtZUxQVGN1S0JqZTFuVGJn?=
 =?utf-8?B?SDNhN3dRY0ZySVd4ZzhpdzY2dllkYXVkQ3drVjYvamxyQnBaRHBrVm5raWNE?=
 =?utf-8?B?aUFHbDJPaUYwdEJGbTRZZWk4K0s3UmdsaFpZeFhZanE0ZGcwaDlrVEpDQXp4?=
 =?utf-8?B?UEh3elkrTksweUllVkNtemxXWWdFY215SkpYVzZaTFFQc2tmY3pCdVFURlhT?=
 =?utf-8?B?eGtlYWh0THpHUEdJVlNEcWplb2JnVzNEM1N4UCtYY2RaZHRibElRcmNHQlZL?=
 =?utf-8?B?WDhkeFRtMUEveUZRZktpYU5HaE1sb1B3M29IdmF2dkxkWEswQy9NMWwzZGZi?=
 =?utf-8?B?SGlWaEcxTUcraXV1MU56RGc3MTFjSGorRTVIMHhsK0Vpb2s1V2JFZHdRRWsz?=
 =?utf-8?B?NGdsNWRWRTF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1hSeVppNUdWRDdUQmtYeU1mOXhHdEZPRE5lS3poOWwrMnp4Tmo3SitvRXZs?=
 =?utf-8?B?RHpxZ0UwRlV2UFhIZUREZlc3QUVIamJqNVpTNHMrZ1pqSXNON3c2ZlVKa0t4?=
 =?utf-8?B?K1haeXF6ZVFOekc2K3dNYnlFOUd0ZUJEZWZDSko0ODV4YzFGVUtoWEhsVHdL?=
 =?utf-8?B?aUxZdlNCcjFSVnNPZjBtZGhZOU5sQVlma1RaQjdEL2s3b2c0SDdlMXdPeWNu?=
 =?utf-8?B?Uk5qOC9BcjJJZ2Y0RmNmQmhITXhOQnRUdndqTHc5R2FBbmNIVUJJa1pwdExt?=
 =?utf-8?B?Q3dNeW1kbUdYUXZDZnFYQkU2bFBnOEtqTmsxNFJHdlhUVXlVaGptbGNOVFVL?=
 =?utf-8?B?Q25oVVNNSTVZTUpXVElTV2l5ckpyeFRJcEJFUlcvclNtRmxrZFNzaWxVRkZi?=
 =?utf-8?B?Y1I5YlZHdHJSWU8rUTZ5S1FtaXZIYTErbVE4ZGlIVGkrOU1kc2w1K0RidHF2?=
 =?utf-8?B?RHBHcVp6c3ZkckNVSDBFM3ZNUmFoWHFSUnFwM2FzeFZsOXVSV3dicnhxNTl5?=
 =?utf-8?B?UmlDN3NwNnhVRUtES28yV09GRXBlSldPZG5HcEVpTVR3ZVdYb0hhZ25sRHgx?=
 =?utf-8?B?TFpPcVhaUnNtQmxxSGpqQnBNQUJqNGlLdWNuN1NreFBaOTU1S0R4ZDl1VHEx?=
 =?utf-8?B?Y1MwaVB6KzVMU1owejNTUFpYbHVTQndIVW5XWVdubmd4dTdlQTFMWXdhazg3?=
 =?utf-8?B?VERqajlMRzdLS1hDWVVOem9Ga25oM3lIbEdoVXVoMmd0QnkwZExGbmFVa0xk?=
 =?utf-8?B?WFlFd1psNE9zV2EwL08wRE1XMUhaTU9JOXZNaXlmYUI1bW9HdVdSQnlhU2dq?=
 =?utf-8?B?ZXlETmtxUTBNMldkdzh1L1VzaUM4WURrd2F4Wmc0TEJ2bFUwbVdtYXYyUHFM?=
 =?utf-8?B?UEc5a2NNa0FzVEdVUHU3K2Zody9tN01UdmtEb25jaHR1QU1MazdvNmlCbk5h?=
 =?utf-8?B?NCs2di9NNVJNdDZRUWNscmU1Nm1nWjVSS3lPbzJYTzZwdHBhWDRwVmNXSmVk?=
 =?utf-8?B?YTJ6T1pVUXJTVC85OERTR3FRL2lBRGhPbHl2REZqWTkvd3J6VUpGUTA3U3dK?=
 =?utf-8?B?T01IaHNpMkZHK0wxSmQvSkYvWW9Ud2duN25JVnhHcUlHdmZlNlN3d0t5UDVB?=
 =?utf-8?B?RS9nY2RacHNTY1VjN0dXQzV2d2JrU1NQTm1qQWtlT1ZhbnBvbC9ZN2ZOMjV1?=
 =?utf-8?B?d3hSdXN1TTF0QktFS2lOM0ZNdXJ4YmFIUTlnZXpubTVWMkpqSDNGRzhWL21q?=
 =?utf-8?B?SjFzNUNNRDF1MUFPSTJySW0wdUdvdFZXOWdaNVRmQVVkVFRnbHZXYVZweDZk?=
 =?utf-8?B?czVnWElQUmZNeGxuY0Zrd2s5aS9SWE1xOWRGMmM0YXFrWUJOWFErMVIzZWtH?=
 =?utf-8?B?QmdUQ1QrYzlQVzJzYjJQc2NWQk80Mk1mMUc4bEFCSll2N1lSVkd2dlN1ZWZC?=
 =?utf-8?B?bmJnK0RsemcwTzFaa1M2amVqVVVpaXJqbUt6bmFsNFN1WGozWVB2SThqRy92?=
 =?utf-8?B?d3JUWUdQMllYSldMV0JKaXFpY2VEUmFEWnBqdnFkdWMwTzJIVzdtbWpDRXkr?=
 =?utf-8?B?dXp5TFplamU2WnFBazZyVVp2MUNDTVA5TkQrZERseDR1NUFLK2ZGME9HUUtj?=
 =?utf-8?B?a2tQYWw5dXAxcmRoUGY4TVlzVkdGNkRzV0hDSi9OQVNzZ0hlNUdldE5kaTRi?=
 =?utf-8?B?TXFFOFpnZXZGQ1pmN3JGUVFrK2hwQlkydkk2WVNwNGRIYUJoNENUZUFCemZB?=
 =?utf-8?B?aFkvTkRsR05QT000emEvQzFLWERQQWVQYWQ3WkhhZ2dIeHlQYjlobkxsZy80?=
 =?utf-8?B?VG9rMENKNzZiZWdEV2NQMGFUS3FGTGZxbXN3cEZwYWpQQS9IVkJjWXRYVXJw?=
 =?utf-8?B?YmkzM3UyNWg2NzJQS3VObGphR2E1YVc3am1aRkRHSTVGWW1wZWZ3NmNjMU9I?=
 =?utf-8?B?SVNVNllRbWhKRXZ2Nlk3a1JJbmpqaU9IWFBpOXJEVUpsejFodlMzNWkwTHRu?=
 =?utf-8?B?MmtIYzJ2dmUzS0FWSXU4N2VPSWEvQWtmMVJvVnhqYzYwRTl6U29MTWhRY0xS?=
 =?utf-8?B?ckVmOGpGWEJPL083QWJzUGpQbXlIY0xPWHliSzhBRWJSWmF3bTUrNnY1Q21S?=
 =?utf-8?Q?qXsrpquD2t5yWhpPKpQH7aLgo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cca73d-23de-452c-216a-08ddd4e67296
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:40:38.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKdhVKS5K0Jmn8v8hHZz/sIXe4TFcftLH5kEjYqdvF/o8Lm9PV62Ry8uPlWOuAJBoZit8j8b+rBdjNI+sc2Lrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11391
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      binman: add a new entry type for generating a data file which is passed to mkimage with -n
      imx95_evk: Restore support for i.MX95 A0 silicon

 arch/arm/dts/imx95-u-boot.dtsi             |  48 +++++++++
 arch/arm/mach-imx/Makefile                 |   5 +
 arch/arm/mach-imx/imx9/Kconfig             |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg  |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg   |  16 ---
 configs/imx95.config                       | 150 ++++++++++++++++++++++++++++
 configs/imx95_19x19_evk_defconfig          | 153 +----------------------------
 configs/imx95_a0_19x19_evk_defconfig       |   2 +
 doc/board/nxp/imx95_evk.rst                |  41 +++++++-
 tools/binman/entries.rst                   |  11 +++
 tools/binman/etype/nxp_config.py           |  21 ++++
 tools/binman/ftest.py                      |   4 +
 tools/binman/test/350_nxp_config_imx95.dts |  37 +++++++
 13 files changed, 320 insertions(+), 184 deletions(-)
---
base-commit: 007610da2cca405ea7739fc120d90085be4b6ac2
change-id: 20250728-imx95b0-6139a78b28a8

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

