Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C859AD3C523
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 02:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4802183B48;
	Wed, 10 Dec 2025 03:46:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mX1bafIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37FB83BFE; Wed, 10 Dec 2025 03:32:19 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CCB683AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 03:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmOmk9GMZ8l47HBaETBntofA7dijuRLUBiQ1BMajA2HPWS2yXgwfJdtlEYNpr8o5GZN1konKp16soMs7INL9wKgoOX4xTLP0Xi0Asuibsewi+hVpAg6GcYPNQUq717QcxMfOmGpoPW/LPvu7CYz+ufrBvAJsYM+CX5Ki0tNvHa55U3NSi3LFrWtXKHsd5g3g8PqxL6aWSZI38Q6YsBx+HGkvzZARdFy7ytdvFRzPfGYI//hsWtMSIR7jtnt0Ei4hCkapEsOFsJlvbTaCW1MpNIfaSZLAhtTV7DWg2rETv+3rjvM7eycO0aHTxP7oSWiw9QHITZxSSbb4aUs8aKEA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Of+isOApQQoy7+ydyT9lq47N2/hIuNrrJ3mO291ZFA=;
 b=jxHebi1ZZb7PMc1ir7w9kj4GkToAoDIRd20QR8KOjKWYW9AfN7IHfQ/Rxb7wsavyGzOBcqM3YBrNKNnDa05AGoYVjI3jvudJ8SMuolcSEFwj5CclOXpDrEhDN/fzaV54Hl6wsS4ynl2VFQjfyn2OGT4wwdvqzoHPvdl8+FQIUrKpx8WIyjB5rlJiXwMhYrGynKGyF4lYU6kdzkkEIku0fReLT0go8gvyUALfcZepFyiqGXo0FU0FPiJBsw30VW5fr96TLIDZ2c552KxSP4sklHL6ORLcHRGhH+9bQfrS6YHG7QDSSgjJmuzPdHYlUwYpHB5Pak953bUjiH8SZnE6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Of+isOApQQoy7+ydyT9lq47N2/hIuNrrJ3mO291ZFA=;
 b=mX1bafIgMr0AM/tqripR+mgjIc/Q2j1fzfvn+FwwLvJMtU34U5ccrQfyr0nHkQRpc7S3JVpzdDJRFRqDurMeS5hO5ok2GqKHo+rG4hdjImp6PgJGNxIgRSej9oSOWsxTxtNQ0uV4dvtBX8Np9en76rmVW0UhKKWM1NBLuEggo7w2+GdDok+aw5PxrLGrvLNiXse8m5UPJnWYSydM94A1jG/QxtMI7hauVq8zNw96TKFZ1ZuieTtt0tdd2BNx3D27iew5ngwZDp1CCVUCyXY4LlCyykrqQWflBLmaciseTpy4bdvEanszPm33Wlqboqz81etCMOhC3+IWi0YkRDIGWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10241.eurprd04.prod.outlook.com (2603:10a6:150:1a4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 02:32:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Wed, 10 Dec 2025
 02:32:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 10 Dec 2025 11:45:28 +0800
Subject: [PATCH] imx9: scmi: clock: Correct imx_clk_scmi_enable
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-imx-v1-1-c3cfa8d318a9@nxp.com>
X-B4-Tracking: v=1; b=H4sIANfsOGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIwNL3czcCl3TVCMTYwNjA6M040QloMqCotS0zAqwKdGxtbUAyPCEZVU
 AAAA=
X-Change-ID: 20251209-imx-5e2430302f3a
To: Alice Guo <alice.guo@nxp.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR04CA0014.apcprd04.prod.outlook.com
 (2603:1096:4:197::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5effea-881e-4d5b-d377-08de37944ba6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1R5N3F1QmVQOHh3cXUzRDNRUGZTSjNvM21pZTQ2cGl2d0thb2NGZFB6NmRU?=
 =?utf-8?B?bVR4bFdIMG96Yk0vTXVaVjlpbjV2NDZ1aUlnRldVQ0F0UzdmenRJdmw1R0ZS?=
 =?utf-8?B?YUIwU2psT3VyVUlDTWN6b2phZk9GbGVvN2RsZHdlNG1Id08zZUJHZ0NnRXpQ?=
 =?utf-8?B?OFRYei9jLzIvbGI5K2MwVDZoUVovU1FSZFlxRjYyKytkUmRJUmdWWWZGQzFn?=
 =?utf-8?B?cU5YdkxNQVdDZmtVWVZGcXozcjZtSVc5NlpMckpDZWY4M05ueTdGeXF3YUlD?=
 =?utf-8?B?QzUxZGN5VmxWeFZvSUFnKzNnbmlFRGtNM1A1V0d3K3FUWWN1U1VnVisrUDE5?=
 =?utf-8?B?MWU2NG9JWjczUjY5MUN3QU03ZFh1czlTbDhCTnZsNXY0S0FGY3hDZ0VTOUtY?=
 =?utf-8?B?YWpHdGsxSDlXc200SVpiMHpSUzZJWlBaeHpRZ0RzUk1kakVyT2ZlUTFjaTEv?=
 =?utf-8?B?aG9ZQmFhUVZnSmdGSHV2ZE1aWXdUNkdFSHZPRFpEUndCUjY0Ulo2bDR0NGdU?=
 =?utf-8?B?M1JQQjE3b1VMZUV3cGpVaTZsUmgxbnZ2OGZ2ZmMraDdyN2lFVHRZZGU2RDF6?=
 =?utf-8?B?U043bTlIa1ZBckQzY1NGTDcvUDFCTEtDK3h2cDVFNnNMc3JRZjVQV0xSaC9I?=
 =?utf-8?B?TlNtZ3lsTG5URkcyQXhVRVNBLzNuMkc1V1hkT1FlbW1rVkVPN2ZnMVBENFRG?=
 =?utf-8?B?RzBvRk93SGhCOEJpMWQ0NzBjOGd4cmtUODQyTGZvUXBhUjJKSTZBb1BFZVB0?=
 =?utf-8?B?ZHpZRHlqRXdNc0xzaW9QejF1MElKK09kMGtPdCtEYnRKM2RCUGJRM0tnbUcy?=
 =?utf-8?B?bXVNTDdPMkV0ZXRET3ZMeERaN0dUMFJ3bWVZMzNWSnlsSUdOMnhWTWIxeGcv?=
 =?utf-8?B?OXV2RXpKUlh4TVZnQlZmL3VWWFJPVGNoWlRYcnRjTVd1cjBreHp1R3lFOEtN?=
 =?utf-8?B?TTV4UmVSNFA5K0oxSFVBbjBJd2tZS2dicVN0SzVuYk40azU4VTdRZUh6U09F?=
 =?utf-8?B?MWRtbFBJcW5qRitkSy9KcTRwTS9KQjRqdldsZU5pRWR4dVdhRVl4K0FYL0Ez?=
 =?utf-8?B?WWczcSt5UjZNZk1EbHVGWVp5cFNkSk4xT3dHL1g4RnFsWWQwRXBKWHorVWpl?=
 =?utf-8?B?QnZEU3FzTnBodVE3cG1NOVVWamptSy90WWw1WVJRWHVJa3liSy83OW8vL3VL?=
 =?utf-8?B?Qk1SN0FYVUdXVmJJVHBWaVl1SE9pVlRSNlM1K25zd0h2V0xnQTFiVmJmQWcr?=
 =?utf-8?B?cmZLMlZSTDQvUDAvSW4wQzRyNmUweWp5cCtuQWxZS2NWcFBleHVDVEIwb2NV?=
 =?utf-8?B?SXV2K0xxTnhxbTRpRXMvNkg1TkJTRGt5RjI3c2xkWndPbnJ3Rld5NlNBSDUr?=
 =?utf-8?B?Nm5WYzF3NjYvVWhacGdCQkxKQ3h2a05uOGtmUXMwZjBmbkkzSVAxMGtva25B?=
 =?utf-8?B?STdhS3o3YU1uQmt4L1NNMHNzMWtxTTljMzRFZzZaYXduZ3k3UUlSQ3hYWFpY?=
 =?utf-8?B?a0lmWmEwNlVjTmY0ZUR1UWJrRXhpaWZvcTBrVnhMWndGQ2tYVXc1aGV2L2xq?=
 =?utf-8?B?MHBJeWEySHl2NFRkckxPY3VIVzJSVUV5UExzdlBMSXhSbW5yWjY1VFczL2xR?=
 =?utf-8?B?dFdJWnY1YUJKSDIySGZPSkNZTzBISlJSa1R1bXpsUGptcDJqQ1VFVDZVRGVz?=
 =?utf-8?B?M3lRb1NQaWVuVzNJMjZSQ090eTFHZktJYTlDTFV3alR5eVZyRHY1WU1XOFFF?=
 =?utf-8?B?SWdYQ2FJemVaRG5ITVN4aFowZW5jSjErVVBYS0xEUFZ3dHg1T09CTlZlOW05?=
 =?utf-8?B?TnVLc2FrT3Z2Z1ZqR25JUUVBMVZVM0owcFFWdlhVamhKQ2ROemNjdnFsL2ND?=
 =?utf-8?B?RXBPYk9EZXBPalo3REt4bkYrOXlXczhFa1BsWVhrTjJjaHp2aTZjV2RXTXBp?=
 =?utf-8?B?SXBJWGJja2xncUhMS3NsTVlab0FjVWFWNklxUU9EYlhRdVc3U3owU0F4dlFq?=
 =?utf-8?B?RTRXQ1h5MFdJK1RKV3NnbnBwVy8yOXNaZVExR0szZG5uZ0UxaXZMUUlxQ0J2?=
 =?utf-8?Q?IF36Fp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Q2QWcwbTg2cUoxZWtQSmtCQzl4bmdHR2pWWXBtRjlsYkRPY1p3TkpZRkZI?=
 =?utf-8?B?MlhiN1dKUHpiQ0RVd2pUWWFralMxRVFCaGg0RXdUUFdYWjRsNEdmNHFXRStR?=
 =?utf-8?B?YUltTnZYUVQ4ajNZb0l1TTJ0UUpXcUowOGIxN1IxM0djTHlBc2g0NjA4M01P?=
 =?utf-8?B?WGMrbklwemdEUFVCSjZhUEg5aGpZSTN2Zm9Ya20xeDRGSGdyRXl1emdMYzB0?=
 =?utf-8?B?ZmlSb3U5U2J4dzEySTNzOEZSeU8zRU1PZnIrSGRueUwvRSs4SFpybThKVWk3?=
 =?utf-8?B?TjgwMTByN3NVd0ZSZ2p3azVMUWNhaktPSGFJSURMQTNZUHVWWmg1NE1KcEda?=
 =?utf-8?B?WUZadzMxN1ltR2lOZk52dGFZY2ZDaE9HRVpBK3d4TXRpUjVqYWFrR1gxcUNM?=
 =?utf-8?B?b21oYWU1YzRQVlhtMkxQRlZvQzBvZWJMZzJKRUVFU1ZhZjBiMVNtejhhbjEy?=
 =?utf-8?B?b3ppVStPWmV4Nmk0WUxNWUFncGRaQktnR3d5Y2llZXZxcjJZVFlodFZDdkIw?=
 =?utf-8?B?M2NCSWFhY2ZUdjdZbEpla1pNcU9PRWNjNFBXTTFyL2NsdWZLTWdaeUJmdWps?=
 =?utf-8?B?alNQcnZNQWVBazlDU3ZUeUhiRHdrRHhYZ3JOMmpRVlAwUXBFUVQ2OXRKdENq?=
 =?utf-8?B?VGlTYzN2UEMrbzhvYWljN2pweklDdFFnYW14Yk5UMWwzL2tzNEhOVnhvQ3h6?=
 =?utf-8?B?MFhXNTFOVGYyMVBTdEQrREdJOVVISHB2QnVhQ1o3ZXpUZHpSd3plbjJ3dENZ?=
 =?utf-8?B?Zkp3dithNWZpcC9WUkZGbGQzUVJ3N2FsTVpPZVBmZSt3N2dIVzhTTlltWVZT?=
 =?utf-8?B?YnpKaDB6ZS9Tc3hwQ0ZjQ2JOV1QyeUMxY0dkajRjM3JTdTVtdHlBVDQxVXF5?=
 =?utf-8?B?L2RTYnhyYzNmZ2pGaERUUFVmckR5K3BsVGNGY3VYc3Q1WjVrU2grNUtXd202?=
 =?utf-8?B?QytHMmRrUGtNb2hiMm5WZ1RVL1ZtS0dYakZONFpLNkRNRGZ2MmdEM2VIL0Jq?=
 =?utf-8?B?eitlaFFVMHdxTXpiM0JEbmJNU09sNnVSWi9sd1FXWUpqa2lpVHhZdy91WXJk?=
 =?utf-8?B?OXZqeXVTd0FnellQenlKeEdKbVZQQnRxanorcHJoZUxmUHlLZFFjWWJOcEgz?=
 =?utf-8?B?Uklsd2JuMFBsVDNMcHVxUmxxcUV2YmYzZnE1czNHZnRWTVR2eHJEMkNGZXJu?=
 =?utf-8?B?cE4zTnpyaGVEYmo1L1JucDcwRFplamk2RzdPSHp4RE9HVnplUkpaZjhvNEo1?=
 =?utf-8?B?dCtYT1pDQzBXN0U0SFROVW5tczhWTUdUMnFhTU4vZmxpemlldlRUZTJ6TWxo?=
 =?utf-8?B?YnhMMVloVTZ1T1krcktTRHczQTNSWkhpNzlzajJ3ZHdMM3NEUEx6SWJGNHFq?=
 =?utf-8?B?WEdPZy9OVmJiZy8yNzVTV0t3VDRxU1lTQ01ReWxkZ3hhb0QwSXZmS3ZzY0c0?=
 =?utf-8?B?ZWVWb29rUEZ5WE9lais4WG1aa3IyeElnRHlOMWNzSlpoNEQ4QUc4dWl0SXBa?=
 =?utf-8?B?RWhJZEpROWVlNVV3N0hoSVFDK1dLUUxVaDBmb2dETDE3OW1MUWpDcnVMT1B6?=
 =?utf-8?B?SnovVFF2dk1pMmRLSEgwL1g4eVVtM2hRZGxQMGljeWx0UVh3Qi9KU091K0xk?=
 =?utf-8?B?UitGYUcrN29HVW1uNS9tdVVLSU5NK3NibkljeHlIK2ZSWW85UGJZaWFXYkFv?=
 =?utf-8?B?a3FHL1hXMnJwbEdHYWxRVkRSSWtNNzQ2NVZVOWlnLzhOZUlocFJLclBsOXRX?=
 =?utf-8?B?L3ZtYm9Ob09JTXl3bkpHcjgzK0w2Z0ZleUZFdzlFKzV3ZldTVGdaa0NGSm1u?=
 =?utf-8?B?ZDY0cmNmMklHRWxLcFNUbjZNOC9INThnZ2lYMXQ3aFRINVh6RHF5aTNzSjZk?=
 =?utf-8?B?RnFaanp2eWJLMnN2eGxPa1BWdmVzMUVjdy84Y2NJa3VkZUZWN0FIRjk4VDdY?=
 =?utf-8?B?bHRkb3FoTEJMTnArNEtLTk1xN0p6dEtGbkZnYlNmd3krdzNKRmxycGZSMUN0?=
 =?utf-8?B?bUJXUGpHQWZzWEhmZDdIdzZheU9zZS9EWnVQMVJobDhJSUFvTk1uWkpLMlJn?=
 =?utf-8?B?Q2VYUHBOc3c0azJrblpNZGJwN0RYSHd3NUVjbEFscVQ3TlRYc0ROQnRPWXNm?=
 =?utf-8?Q?C07EDbTYXsQ7+0Z/f68F9Tiua?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5effea-881e-4d5b-d377-08de37944ba6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 02:32:00.0211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yA95hTqoFZFB/vF21/EVl2j1DUZshHE/DpQvVYqTPyh7JDFVQzJKFqIdT31vDYmwIX3ThaZIs5z2dfRPvN0rcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10241
X-Mailman-Approved-At: Wed, 10 Dec 2025 03:46:47 +0100
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

i.MX9 SCMI Supports CLK SCMI version 3.0, so need to use
"scmi_clk_state_in_v2".

Per Spec about extended_config_val: "This field is used to set extended
configuration of the clock device. It can be ignored if extended config
type specified by Bits[23:16] of the attributes field is set to 0."

So no need initialize extended_config_val.

Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
index 9030dbf600d..a502f19bca5 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -10,7 +10,7 @@
 
 int imx_clk_scmi_enable(u32 clock_id, bool enable)
 {
-	struct scmi_clk_state_in_v1 in = {
+	struct scmi_clk_state_in_v2 in = {
 		.clock_id = clock_id,
 		.attributes = !!enable,
 	};

---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20251209-imx-5e2430302f3a

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

