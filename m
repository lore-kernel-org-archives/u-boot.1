Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9064D358E8
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5E183D77;
	Thu, 29 Jan 2026 10:10:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SiBgIohK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C6E83B03; Thu, 29 Jan 2026 10:10:39 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9851B83D7A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:10:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sizJoMe9odSxh2lqUOUwk+Hnd23jR42dOa2b7qTtENmlaK+2lLf95YmHCf845WE+e3ila8hfnMrc/28kiUGi8z7GvHTUP0K4fdjsKX+Q76Oc4NfPj17VFrjNKkKVr5k+JmkWzEWfyEnJnoO6ktq1c8+YVBcrC9Gzg8SHhs9e5pzK2zZrmw1uWHCPWmBeg261N8faxa7qxyVtrB9Kqm0fc3jeODjqasP4K5Ki4r6b34kOgb+ZOoaT3B99z7yREvVYeGbDZYOayGR8eH4lEVnoHJcI70Csl/iay+lkS23+FJJOHYJTQg2ng3gmDI5pob0UrmwEbj64eb3xwpu48FTAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgBruq0kQax61WuFkX9IUqWXi7341JPsFpbxf63ainM=;
 b=IVB1H/QVoOZrkQjJiF9S7snadU7Fh6EHfZZrRmenGqWFASadkPlJQRSRg/ak2NSuqqoh7aY5WVE370OtV7A27rpAe7ACRuDB3c+srN1W5QBIeUJ7aHT3m0xtFD++nQRJXl9jJSnn99WRGTSn32d4T3PuHOPuvJVZFMFJWL4txkpliIx+QxjilCjEsQpod2qFMmhYnT3N01cHDhUftv6KmeHaN7OjorImLWs7xu/OwEUkN2QfiFZKvsDsGsyYePdM+tC1yeW0GMpdUmXRiCxyzN+OjVIZqR2BCaBD12r7rjrgxha2P+7YUhVsFnuR6AlbXAQbijWromS8qDFZkL/pNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgBruq0kQax61WuFkX9IUqWXi7341JPsFpbxf63ainM=;
 b=SiBgIohK9J3JiSvCFaeqv9jFKW/p4AFR+c6oSoHAWjavOk612WTIiu9X6bCQjdTPOGGqrSzX3R5m7eWA6MBl602a7/MsyqkmPP16iytoSPTY7OnUOExO+LaTIx8kgAwLkUfF+71Mj4OptDWa5dcUKXSDmH2HRYwYjsAn6jMj9YzFCPbtcF+23E8xqBjN0Mi7if5nmivAg6LcqWaCFJAG2YfvMDoFqkmyBwi54PKc3NqEekKaBUhdwoE+jMIuCP83X5ypf1Crskhujja01oPiqFGrP49ITffDRaPF/x5bbwcynbIiOPuwh5lUyW59SIa+BUq2v3pJVZLqBvtIjpcuxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:10:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:10:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:25:00 +0800
Subject: [PATCH 4/4] imx9: Kconfig: Enable remoteproc for i.MX95 EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx95-rproc-v1-4-035b2dbf3e57@nxp.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
In-Reply-To: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e13b6e-3ce2-4e7d-6632-08de5f164267
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjNqa2RaZnUycitaSXd6RHF1LzdVNEdhdGZqeUdSdDByTkhvWmQ4dzRsZHov?=
 =?utf-8?B?WEUvQlZhV0RMVlpnM1lqWmdoeHZodUJtL25NS0lUQ1Z6aTdFZkpLWW9aK2wy?=
 =?utf-8?B?WkRValkvdkg4NUZtbnNuV3VWc1phRnRmQUpkVVV5ZCs2dkt0SDRqeEh5V093?=
 =?utf-8?B?V29TRnFESVpSaGV4dU9WOG92MjI4N25VcVlYc1BucXFPNTFOMzhXTXZNNTQ5?=
 =?utf-8?B?NGhmbkhkUTRpeGNaeGZCU2ZuVXJ3YjFoZm5WN0hrMHZMSVJ5N2JVUTg5Mmcw?=
 =?utf-8?B?bWNud2pJNzZIQVVCRXBlM3JtL2d1Qjh2Ny9EK2txcFZzckxKUU9mRWsyb3g5?=
 =?utf-8?B?b1AxNFhSRFJXUUdRcXBXQVIyOGJaeVVDSm5TTGs3dXZCTmpMam9EUy92RFNV?=
 =?utf-8?B?Q2NFOFh2YXAzOUc4RTd0Q1NtR0tDRnVVVjlwVmFVVC9yZG9QeXZ1aWdHY0Vl?=
 =?utf-8?B?UDd0a3RlbU5DSU1KQ2JnbDVISVRaR0E0RGZyNFBPbEhzV3hlOExDMTRnUUtu?=
 =?utf-8?B?eTQ3clZrNTdjOXJBNVo1YWtiZXpoVkR0RHp2czNXbnRqT3NXYTFKb3NQMnhi?=
 =?utf-8?B?TEJkZzlIdGcyV3gxRjZMQWg1Qm9aUENzTkNCQ0YxMHNZVXhId3FMYU9yVGF3?=
 =?utf-8?B?WlBFOUY3ZTZtcjFSNVc1dGZmYjB5Mk1UREdzK0Z0VXhQYjZrRFNwdmc3U1Z5?=
 =?utf-8?B?dmVKbndGQWk0eGUrYmxwZVlETXpNNmRkY0IyRERFNnBqRnkxTUViTTM3Z3ND?=
 =?utf-8?B?VllHVktzcmlkNGtwYVhuZDY4NWkxdmllalFMSmdDcnpmc0pwRjgxL2hic0JL?=
 =?utf-8?B?aUROUHg0L3Zia0NMcktud24vZGVzaGxDVmJVZkUzbmVrVkxpeFJ5MEozNTdZ?=
 =?utf-8?B?bUNkVGp1dWZ5R1UwZmxiNmkxdE5vMWdUR0J6b1ZjTFY2QWNSbEdqK2ZHR3k3?=
 =?utf-8?B?SVVmZ3RUUndEZ2JUSk5pZ2RVbi9nZnRHYWc1cFlxS2hpU3EraEg4SjRmT0xi?=
 =?utf-8?B?OHBUeG5xVzVJOWQxOCtpZjBpSVlTRFVYakpZdjdBTlEyWlpMWTArZVo3NVpp?=
 =?utf-8?B?K0lVY3JpcXRNcDNsMnE1OVQxalJTd04zcXlPdGxXWTBtaTJPM0lBczFYb1hG?=
 =?utf-8?B?QjIxdUMwRSsyQjF3b0gzL2p4RTVpU3IySll1S3Fmc1JHaXNzTjc0SFY2TlVS?=
 =?utf-8?B?R2pHU0pVL09oMjFJQXJiSGhwVS9XbDZRcm4vRnhYdzhjVzVOZDN0WFZNOFpt?=
 =?utf-8?B?SzZxMlEvcUgzOVA2L01MM29sOGwrQVdzUlZsa2gyY0VXMEtmem9BZmsrM3hl?=
 =?utf-8?B?SFkyQlQxRWR1TTd0MXlWaE1GWXBQTExtRGFkcGhYb281eXJrZlYwMG9NSVVn?=
 =?utf-8?B?bTlndG9lRU5ScGZSZFVOc0lJL0hRUzVaK0lOaDRJYXBTV2pIZjJoVDRvb0Q1?=
 =?utf-8?B?V0tTdFhhSWY3WmUvdkd6RXVURWhwSzNJd0VtSjgwTUVyUGc2WU8xZWliTEVZ?=
 =?utf-8?B?bDhxMC96dGlUODI1SUpOU1ZpK2lTUVZEdiswSGZsRjRYT1krYUdLVGh1cGVo?=
 =?utf-8?B?QjdoZENUVFFMaXkyMHVaNFpnK1Fla052cldwWFBvZWpwNzhPZTJmYm5RR2RQ?=
 =?utf-8?B?NkhVNG1UY1preU1FZittYXc0Z2E4ZDIxaVZBckljMGpTK2RsRmtLYzRHRnA2?=
 =?utf-8?B?NGZBTjJ3emRROG55UEtpajhWenpxd3lZdHVXcDFLeTNhRlRhNUY2K0wrZ1kv?=
 =?utf-8?B?MGZvWDVRU3NJNXVxcmgwaEJKZXg2anZaeGxCTXpuajgwdDEyRUNaTEJHK21C?=
 =?utf-8?B?aG9XcUJPM2p3MXRab0VxVGtHMExiYm9TSGdFWHNvWDg3b1NXcjVJNzJibXRF?=
 =?utf-8?B?UkdVMkE1bXNka1BubXozbGVTQXF0TG5pNVVjeE82ei9mVHpBQUNUSGhoR0tu?=
 =?utf-8?B?aXBqTFVTQnNhbmRQaXNiNm5jSXZNN0NybitlbmMvelRVSjV3cGlkYnRMall6?=
 =?utf-8?B?YXVoQ0RhcDg4Z3B0NDEySXYvWUJzNmpSVkg5cXMxdHFCOW1Dd1lmMkdOZ0RO?=
 =?utf-8?B?RnJZQUV3N3BhY3ZQaVJsOE9QS2ZOZ1Nybmk5aUszZyszMjZ0OWxjYVlDK2Js?=
 =?utf-8?B?TW5JWWdHUk1QL0V2M01FbGMyK1FMcitldWdRK1JWUE9PbjhEcnZYUjBhNlRi?=
 =?utf-8?Q?GOggN2mQ57cbRbB0g9wCWwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3RlQnoxQkNFMGhqa3FJRzIxeTZJY1ZJNi9HT2hzVzhiU0NWWFQ4Y0RRM3JD?=
 =?utf-8?B?eERVNGx4WmRmSHN6dlZ6RGhQYWswR2RYbDRZNzJ6U2JwUHg0N2hMWXZnY2Jx?=
 =?utf-8?B?NWh4Um43U3FaMnM0TFZpc0FxdExMWWxSR3VDZi9wUzhXZ3duQjVreEFTcjhG?=
 =?utf-8?B?ZWIxdWlxTGF6RWRPdmFkcE9KUmtuaTRiZjBmM1BqZXBnUTRWZ1RacEVHTWl1?=
 =?utf-8?B?V1ZwY2RwMEpyS1hxWjZSeFdUVjRTQXJEdWVmcWJHdGpTdHBydEJvT2d4Q0Mr?=
 =?utf-8?B?OGZQZHVmN1Y1ZGNEQjBCVkhMU2hqWGdHUWxOMEFzRy91TDc3bEhkMEllVi92?=
 =?utf-8?B?VGhTVUN2aXc4QjdYbThXcE1EdTNDVkhOYURSRkNRa1pDQmNsVW1NdldzQ2hP?=
 =?utf-8?B?MG9PN2hrNmRoblpocHhwWEJPUGU1RUFSd2hacFcydGhUTXZyUHBZd2wzdURx?=
 =?utf-8?B?KzRHT1ZBRUxVVDJESndoM0FmMW5JekhyelpoeHNiSVhhaW56K1VyeTFVRStZ?=
 =?utf-8?B?NTJlMm50Y3dtV2o3RlpiQ0xGRXphTkd1SjBhVm5WanZrekg5Z0JMZks2Tm0y?=
 =?utf-8?B?VUtBVTdzNzIwQURndFZNR05ITFlpZ01ldXRxbjBmSFVyK2grNXpDbnZUSk1K?=
 =?utf-8?B?TStPQ3VCQ0p4a2ZQaGZ4VytYSWowWXRReUE3ZjhrL0ZBTjZoekhSNjNZbmRt?=
 =?utf-8?B?dzRnYThrT1pPNEx5eUpldzd3a29ncFQ1WHd3V0t6U1VOcjRRcG9CK3BVSjdl?=
 =?utf-8?B?U2tCZEI0WXBHaFNRTFkzKzU4RHZLdmRiWUVMZ0hnNzFBWXZGcmVNU2Rvd3Jx?=
 =?utf-8?B?Ty9hZ3JNU2I3OThlTFR4dlpSeXY1NkFsU3ZweGU0OUQ1YkVva1BsZzhBK09G?=
 =?utf-8?B?L082KzN4TmxSZGNkdFdLRkFJSWMxb012eFpDNlhwWVBLS05xSmJaNkYwdXBy?=
 =?utf-8?B?KzZ4Rk1KNExmZm53T0gwcHd3d0h1MHVOLzQwcWpDWkR2ZExnMDdWT3dNRXQx?=
 =?utf-8?B?V2FMcVRWcSsxKzJBd2xzanduU212aGdBaS9WTEN6cDNMV2pPVGYxUXVaSkJo?=
 =?utf-8?B?Uk5RWFdHTXRaNmNrOU1teTF4SDM3bjl2T0szVWxyUGl0RDhDcXBvVFQrRFV3?=
 =?utf-8?B?Qk1mNXBxR1JWejVIQWFEQXVyaUkyOGZ5VFR0dlNFSDBNdXNhQ2lmOStGTlp5?=
 =?utf-8?B?UEJFMGJPN3VtUjV5TU5QZWRzZENGYkNWNUNPcWJSVnZHL3RrL25VRzZTQkRN?=
 =?utf-8?B?bDR5TmprZ2pYUEk3bzd2K01ZMHlDKzA5T2xTQkxXNGJzWk1sU0s2eTVpenFC?=
 =?utf-8?B?Tm04ckFpcFJwaDJoVGNlS3czRi9vVzNWa21QUFFNTG02dHdKTW53cXRNVU9n?=
 =?utf-8?B?Yk8wVGNhWnVITkRuR1ZwekNGZ2k0Qk01ZWw3MzlzVFZpcEZlUXVTT2k4QWc3?=
 =?utf-8?B?RnhiTDloQzZ6NzMwQno3TjM2dmlQMVhLeXJGWGpEK1JDb1pLVS9sTW8xV0hZ?=
 =?utf-8?B?R1NJOUVtem9YR2FWaWJTWG1vb0JIdVg5NU51eHRxQWR2VkNYL21kemZoWGxC?=
 =?utf-8?B?eE13SndNK01uME1rcjVGNHRPM0dZeGtPRjdLcEY1bm1WaTZvM1E5MGp3Z1Fm?=
 =?utf-8?B?bmQzVzc5ZjVWL0I1YThGRHh4TVl0QkVTcytyYUFaeEp6YzVQVjZKTG9pREZI?=
 =?utf-8?B?WFI1U01rVVl5T0NEeWp4c1JGYXJNQytGRTJjenN0T29TdEhwYVJjS0lkOG4z?=
 =?utf-8?B?M0hSdGZyelgvK0QybkJHeTlTRytKTmdPSHVUVG1Ga2lLUURPb2NMY0crc2Jr?=
 =?utf-8?B?Tjh5S3NUdG03OW1kYVlKaTNKYXNKTEZUVWV2WnhhWmpZeUNIVGc4ckFTVU5t?=
 =?utf-8?B?YnZWUkcwNVg0SjlaeUZvM3l4eUtuU1EzVVNZZFZJekZWS1orYzVMeGdqUHZ5?=
 =?utf-8?B?MFVSTUsvYk5sYlRwbGk2c0RYK0xLWG84di82TE9lT2lsL0R4Wk5xbGxKdzRn?=
 =?utf-8?B?amtRTWE4UnRqNDhYUVdvTGtqNGx3YVpxVkl4SUZPeHpFQ1NmaTc4V1B5clBU?=
 =?utf-8?B?ZFBITFdqdjg4U0s3WGhtWW1NR2lDRUNIM0gvellSZnlLQnV4WTEwUS9KRjNY?=
 =?utf-8?B?MlQydFRsOHl5TlNvYS9jaHVDUHZSeG11Sm5KbjFwOWpUQ01haVA5UklMbXBl?=
 =?utf-8?B?MjVFdnJhdFJReXFPV2dVbWRBQzlraS8vWVhTTHhuc1VVVTUyVStTUms1dUc0?=
 =?utf-8?B?SG9ZcHdrU0hXaS95cE80RnRmc0tIeURRYTlXR041RGE4a2lDY3dSVHZ3cXdN?=
 =?utf-8?B?dzhjTHRGbWRsL2s5VlVrS0dIV01hZ25CQzJXdTZOdEpkK0tqaHRKZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e13b6e-3ce2-4e7d-6632-08de5f164267
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:10:34.2674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM+kP4rh5DJp3WKUa72Jjz9pyVfvtFSf/TXqyOp9EoK7yMXXiPmzKRCSrHD87/xgijKxiQ0hvLi9Q175gv3N0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484
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

Select remoteproc related configs for i.MX95 EVK to support manage CM7
using 'rproc' cmd with steps as below:

load mmc 1:2 ${loadaddr} imx95-15x15-evk_m7_TCM_rpmsg_lite_str_echo_rtos.elf
rproc load 0 ${loadaddr} ${filesize}
rproc start 0

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9f97e4328c..7051e086072 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -134,6 +134,12 @@ config TARGET_IMX95_19X19_EVK
 	imply BOOTSTD_BOOTCOMMAND
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
+	select IMX_SM_LMM
+	select IMX_SM_CPU
 
 config TARGET_IMX95_15X15_EVK
 	bool "imx95_15x15_evk"
@@ -141,6 +147,12 @@ config TARGET_IMX95_15X15_EVK
 	imply BOOTSTD_BOOTCOMMAND
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
+	select IMX_SM_LMM
+	select IMX_SM_CPU
 
 config TARGET_IMX943_EVK
 	bool "imx943_evk"

-- 
2.51.0

