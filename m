Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A44C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87412826AA;
	Mon, 28 Apr 2025 12:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="m+KZKxXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B55B780EFB; Mon, 28 Apr 2025 12:38:34 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979CA825A6
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCQvF1pDyHAX05YP/V7iXkG4+AEgewD3XjUizHB8t62ar4UbDpYH1JZEwMrhMWhX2zt8oCTpyOgKuV5qbGPHACIjKyuZR3A17jmu75GjQAVaoy9s25XI6vI/l0t9zaOVZokajf9hGz+S/xxK2fhBIPjI6/Oc0sHKf418jvBiEogvIxyoKPLvo7SZQ0Vwg0RhYOsEc0d6kUzx4TECyLCAF5s5LblOISM0VdQHcMoXj9xiK5P/GaeEF5IZ1l8wNe5HALLgww962B/cMzI2J/lQYLa2ZcvXnqrIf6OMg/V6taHIZHeBv5s6MJj+qs22ckXK0v0jPKddnWNstVnPCfVrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9bgJdxApWO0OK5m2ceaNl0WHVX+MUokdfxvbc9cgBg=;
 b=MhzI5ntZhoz/rruJBfNqt8oekH0unEZfryEaBQpn1PUKp3hTFrUB2LXiCBwlBDuZPn1KOs8uCwUSO3Y3IxJO3Mt8K8wdoViIfw+ExvgN9LDb12bhIyb1j54VNV8gaM/gai7SwHkDkhS47MW4j+FP0CV7J5Td659Tya8GpqbpsV5TOJ9H3fAShTuGuDqG/yX+4Vbj9mPh26cgae1r6QFq/a4/75nQ7VNxKKrichatHIESlY6ZOSGDtdY9OzcHJxnhHhTvc/I76ZA8Y0CeFAmZiSBtiCp0SuKLn+qjoqzhYWMf+gt/vE4nN/uy6K5AWPeNTF592gdplh9rvLH2itz05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9bgJdxApWO0OK5m2ceaNl0WHVX+MUokdfxvbc9cgBg=;
 b=m+KZKxXGv4fIQA05SLSwItYxlSDhwpaz1uGdz5NYX8NG6fPdOFD7x2n6NNDnYFCUgqQ6AfwuCeDJODNsue7t4LPIPx0Ao65XMTnRcK5XDZOPf86m3wdoCbL4XSCeUwLj4wzBW+GQB12gjcMgL+JNZWKZZzKx7aqfeJxZexW8n530mi6UgDLezVjLQuiuKxPpFTxgHM1KOucXeCqYsasaI0ldv2Op/xqL8x3DoZ3ZpOyhW3DEeadQatxbp1/wFfoZshrW/al8mNSUM5jr1ihMvVBxFz4vntHEGOnE5RcYs4xAbkOlBthiSGO3JPuWfk26qGztHI6Jg6IN0B0PJD4MwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:38:30 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:30 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:25 +0800
Subject: [PATCH v11 02/21] firmware: scmi: use scmi_proto_driver_get()
 function to get SCMI protocol driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-2-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: 72af0846-a070-4152-0803-08dd8640d12a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFRnLzhzTDNjZXVRUnFiZUNGaVZoWFh2Q2ptTndOSjk5TzVqZWdiaDR5bWNN?=
 =?utf-8?B?RGVYanpSWWMzWkx1RlpMN05QbHUyVnc2cUhwRHVhZENIMkVzUVZLNGtlNDVm?=
 =?utf-8?B?TzlyNUhlVVhFNHk4b3JlVmJVb2Y4d2R3NWJwblpXR3RxNmNTbjhxd0F6Qlhq?=
 =?utf-8?B?aURsYTNKbVphQmJQQkZreElBMEc5MGlQRk9teWQyaU1qK21JRmU2YnZQT0Q3?=
 =?utf-8?B?b1UyUmdDdkx0LzIvK3d2THhTckJRU3ExSHMvVlJhbVhWOGVYTTVMd3laZGEv?=
 =?utf-8?B?dldLSXdQdHpmOGZMcUVOSkFPR0YzbUNaU2V1bHpCSUNTZ2kxdS9Uamt0b2Fu?=
 =?utf-8?B?cEFjM2xWTWR1NFBGaG4zM0grOXNkTm9aRlRDNTlwSUJ0Q285SUd3ZWhTMVVZ?=
 =?utf-8?B?dzI2WndoU0VibkgyNGFVdjJSMExvaVowb0pMbDlSY0hNTnZIeGpJSEhGTERM?=
 =?utf-8?B?SFQxdERWM3B3R3dOL2ordkg5czM2NFhlc01xbGs2b0lHS09yL1ZlL2ljUmwz?=
 =?utf-8?B?cWQzZTI2bjkway9BL1F4UlFFUzE0L2ZmN1J4REpPdmFTOG9zcFBPZVRLSG9l?=
 =?utf-8?B?RTZ2b1k2TlpVYnFpSUR3MDFjQ2I2Zlo0NkZZWVB1Ylk5a1M4Z240U1VreFdH?=
 =?utf-8?B?TkYwZXBrd3llNFpXZ0dqSTBDRmdLbklnOXEycXcrVkp0elZxdEtZY2pwbWhC?=
 =?utf-8?B?bUtoTTNFdmovWERIS2hlN1ZqT3oranEvMWswTmJyZUFMM2FZWEVaMmMrMDZy?=
 =?utf-8?B?RFA0L2huK0NmZy84c2JLcjJVeFhWS2U4a1orY21WUkdaNWgwekNjNWdCajZq?=
 =?utf-8?B?a29rWHEvTmVvVTVRcWR3c0RhWUhDeWxNd1I1K3BtMDcyUCtLejd5TjVmejVS?=
 =?utf-8?B?YTNJS0hRRmJRSzBZTEN0TGd1SWRCK0JHT29BcU4vOGVhV0FBMnNHN0VKMzhw?=
 =?utf-8?B?M3FBTlZBN09MazhBbnUvNkhQeHNPdWFMaFdYcjZ2Y3J5YUE1TWdZV3ZZUUl3?=
 =?utf-8?B?UDV4YmR6ejlsbmV2bEdZSmpPbHRpbUkzTlJTbkNabkhrd0FJZFVzd3pQWHBT?=
 =?utf-8?B?cURhM29aaElwWW5wVmZ1WVR5anZtMUxoTnBQd1BXYkRpNnNkS00zYlBnSHJp?=
 =?utf-8?B?ajVQZHplWXJJS1g0dVd3c1BVbnZvZGxjdUJxeVZldmpHUnRpZW9od1owMTZE?=
 =?utf-8?B?QkNlNCtPOG5hNTNyZlhWOWFBbEFxdVBHMC9VYUpFeEpCVmN4WFFvNS9MWnhu?=
 =?utf-8?B?bGV2NWtocFc3ejUvTmJhOHRxeDZmN3VrcWhZcFJlNXUva2F0cmxkSXNsVkhX?=
 =?utf-8?B?NzNqOGdnN1E3K1ZQZ0tzdDJ4N2xXNGVpWjl2MTJKNFRsZk5HVTA3YlQwaUUw?=
 =?utf-8?B?VEFnRFdwNnArZEgwMUdablZrYnZjVjhaZ01GU0N5a25tdENZZ1RlOFlzUC9a?=
 =?utf-8?B?WFZtMjVKUGYvL2VjRDg0Ujl5aTIxZVhud0FDZE45U3lqeS9DUWxyRDl4VTc3?=
 =?utf-8?B?cHdqcE5qc0NkbVU5cVFiOWpONUFCaDJibGtaazNRZjVQK1BXY1A5bFJ0N2Yv?=
 =?utf-8?B?Rm0wTVpkN2gyYlZYb1dndXRFRUVJcmxkSGd0SXpXUmovYjdoL0lOWm91c1lB?=
 =?utf-8?B?cHJFeUhWRm11dUxIWGkySVlEaW5UNWRmdFBsTVZIdzhjeTAza3BiY1hsMzBD?=
 =?utf-8?B?bHMxd0QvQzd6S2tjdm5Ecm1iZEdxNG02U1ZVYXNYZWxGYnBPYjdJZjJjdUtr?=
 =?utf-8?B?U0puU09FSTZwVDF3elhLVVdxNmxkbytRa1luZU1YQ2V6TW9BSWNJS0lBY0hJ?=
 =?utf-8?B?a1RiS1hQQU5NazdLTGxkUEdpaitkVWZpd3FuTFVpc2RTdFF3TnplYnozOCts?=
 =?utf-8?B?MXFvSU5sTk1CdU5pcWdaNmZGTUVKMGd5UTBNcWdYMXAwdW93aVczSWc0d2pK?=
 =?utf-8?B?WGRqRmRDOFRMSmhONUdMR3YzWFRLV2VSU1NIUWtiSUR1RlJnWUltVGNOK0VM?=
 =?utf-8?B?cW1WZURtTVZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdYODllNmcrTUhib3JlM1JNR3c2Q1lZVUFnbDFydHlqNkhWd0s2eGlUMFhQ?=
 =?utf-8?B?V0tHTmlRU0tneHM3WkMzQ0p3c2RPbUlpQWJYVEs3NjI2NW5TNVF6MDZrOTRN?=
 =?utf-8?B?Ny9VNHY0bFIrdzZRL3AxQUUzVXNkanI5R3JjeHpZZVUwMnFENE5Jb1N6N25U?=
 =?utf-8?B?TUZQdFU3RUhQajd5eWdBbElGd2hwZHk3M3VVcm5QTktNQ3ArbzIraTVUQnov?=
 =?utf-8?B?bFFjQnRacEo2K2VUMktrbFRDN1BEL01kVW9CMWxHeDRkcG9ORVFJYkVBODFG?=
 =?utf-8?B?anJ6YlQ4OVFoWFFTaVVNVzFEMXgrRG1VTTB4WlE1UmNlbWJBVW55dTlxTW1p?=
 =?utf-8?B?dmowcDJvaW5qaXRwL21RZnhuSE9wWXdxR2xubXRpSWRSWHF4bEZkKzJ3bkZ0?=
 =?utf-8?B?MEpGenMwS0Q0VDBSK2hiZjVRMGtaS2VTZndKOHM5OFU0cnIrU2Q3OWFPSUtQ?=
 =?utf-8?B?aTZLM1FtbTFWcE9MTTBoazE3elBvcytabngvZHZXNmFLYUJxaTV5OXpmL0sx?=
 =?utf-8?B?ck16MnBZV29lYXFIMW15ZGtaSnE1VjJOSEY0NEkybnJ1UkNLd2NkZEZYWml5?=
 =?utf-8?B?eTM1QXJKc2hXeXdCbi9NN0FxaUI3cDJXY2ptNThwa25tc3UvQUVDYUFiUUVi?=
 =?utf-8?B?VE5INHNhc3pZdDdkaWZoSDNqaG5IQUl4Nm1ydjhhNkZCQ2lvemN2QkRsTHZm?=
 =?utf-8?B?RFllUmVMS3JFcHVQUGNiVmxEaVNGRVF1M1gzWU9URTNhQmtXLzVIbmZCNFBw?=
 =?utf-8?B?MVRLZUNWQWkrRmFLSHRaNStPNkV2UWlCdFdJVFQ2V0JYYk5OMmtCSGNrcFFN?=
 =?utf-8?B?b01xVXkxc1lxSzhtc1JjL1cwT0JYa0t5bDk2dkpQcHVjMy9MQUNqM0hSdnBY?=
 =?utf-8?B?WWpETTU3cjJyRjdCOUNpY1dKMnpRZzFEWi8rUTRhaW4xS2o5czdUdUdFRzdz?=
 =?utf-8?B?TllScXJsejdFUDRxOXdpQ3NCOWVIRHhjSHkyZDNuaU5aRnk1U0d4LzFsVjZB?=
 =?utf-8?B?VEFkektuNGJ1TC9kRSt6ejIwNENDNWpNZ1BRY0drMzJvWm13S2M4TWUvRVZH?=
 =?utf-8?B?VTNXVDZKYTJ3NnMxSDZZalNHRjk3NGphakZJT2YzN0p6TS9QRGtUc01NMito?=
 =?utf-8?B?a0JhbGdOZWxscVBPRzEwOW00Nmx3ZzNkMU5uZHpRcHlyTXJqbExLcWV5NDRh?=
 =?utf-8?B?QUxZejRjWC9SS0tySllOYkFTNitxZkdBZmRTSTBZTW42aDdaU1NONXYreFJx?=
 =?utf-8?B?bFhrK2Z4d2tIVTlhMlByTC9WZ1JJd004NTNnbjJoSk9DN3RJbFpmc3pmQ3E3?=
 =?utf-8?B?OTJVTHBCYVRTR0p6elg5b011b254L1BWZk9taWlMWkVhbCtocWlQenRlRXF4?=
 =?utf-8?B?N0t3NEhsVnpTVzlKeFVrY0Zvc2ZlS3BEd2J5ck55cUNZK09YNDFRblYzamQ0?=
 =?utf-8?B?UjlqU3hVUUU4WWdYUm5ISHdaa2JYQTVDZ1pxV0R6U1pscFJzOVdETVpNVWIx?=
 =?utf-8?B?ckdGY3dOOHo2VGRENzdlTGFxSlFBUWhndnlQNUI0RDRhNGRyUlBUeGovYXB2?=
 =?utf-8?B?U2ptaWZvRk0wRDk2UEtoUkFVM0k2WmQxVGwybDFLaWV0cnNnWmpmMytFVU54?=
 =?utf-8?B?eVliNnF1L1dIeGRxUW9LWU42bDdLWGRScUZNZWJQRG5nRExJbHd4N0hZRmJJ?=
 =?utf-8?B?RkhBRjFXeXdSQk9PN2hRTXFYN2JFWjdXOGpmR0wyN29CMVdxUzUxTVNCb1BM?=
 =?utf-8?B?UGVVZG1uMm41N1ozcFkzdHZJUEdSWjl6Zkp5Rmw4TFdPTWRueWw4VmU0Sm5W?=
 =?utf-8?B?NHFqVkxJMmE1WHRzODcrbis0QU9DOUExMDZXSm5qM3hGa2dkMWE0eXpMN2ZJ?=
 =?utf-8?B?ODZESlNjZDJvcE5mSVBkNWZmdUt0L0lTK0lwalFEWWRDQkdrOEtxWmtkUWdu?=
 =?utf-8?B?a3RNczdlM3ZPNVdSY1BtZXRVQTRHc1doUEtrT2NtU1ZLUHp3UEpaYTBSTHFr?=
 =?utf-8?B?ejBGeEZ0b0JEKzNDTFFGK0E0R2E0VzdQYVQ0U3BQdGVLTjNMT3l6THFkYWht?=
 =?utf-8?B?NlNMbHBVRElnV0I5eVpqdldYTUpQV2pTclhWQlBLclRsVEM4WG41ZFpwMFJE?=
 =?utf-8?Q?Lscxc4JtlTa3SCVgSETHzsRC4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72af0846-a070-4152-0803-08dd8640d12a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:30.3806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Yt0+OmeAq2pbV3sniNo3aAQjWKrsxPV6IbNSb5Ob/lHOfOD8soEN9gQPI9XGCZOh/78zMoshPIHMq1Pv821kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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

From: Alice Guo <alice.guo@nxp.com>

If there is a SoC specific SCMI protocol driver, using
scmi_proto_driver_get() function can avoid to add SoC specific code to
scmi_agent-uclass.c.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/clk/clk_scmi.c                    |  8 ++++++++
 drivers/firmware/scmi/scmi_agent-uclass.c | 28 ++++------------------------
 drivers/power/domain/scmi-power-domain.c  |  8 ++++++++
 drivers/power/regulator/scmi_regulator.c  |  8 ++++++++
 drivers/reset/reset-scmi.c                |  8 ++++++++
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index e42d2032d45..b8d40cc9653 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -8,6 +8,7 @@
 #include <clk-uclass.h>
 #include <dm.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <linux/clk-provider.h>
@@ -191,3 +192,10 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_CLOCK },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_clock, match);
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index ea79cfa0cf2..cc3f31d881e 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -425,31 +425,11 @@ static int scmi_bind_protocols(struct udevice *dev)
 
 		drv = NULL;
 		name = ofnode_get_name(node);
-		switch (protocol_id) {
-		case SCMI_PROTOCOL_ID_POWER_DOMAIN:
-			if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_power_domain);
-			break;
-		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_clock);
-			break;
-		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_reset_domain);
-			break;
-		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			break;
-		default:
-			break;
-		}
 
+		if (!scmi_protocol_is_supported(dev, protocol_id))
+			continue;
+
+		drv = scmi_proto_driver_get(protocol_id);
 		if (!drv) {
 			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
 				protocol_id);
diff --git a/drivers/power/domain/scmi-power-domain.c b/drivers/power/domain/scmi-power-domain.c
index 3cd0f075d95..e8c0ba8878e 100644
--- a/drivers/power/domain/scmi-power-domain.c
+++ b/drivers/power/domain/scmi-power-domain.c
@@ -11,6 +11,7 @@
 #include <power-domain.h>
 #include <power-domain-uclass.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <dm/device_compat.h>
 
@@ -190,3 +191,10 @@ U_BOOT_DRIVER(scmi_power_domain) = {
 	.probe = scmi_power_domain_probe,
 	.priv_auto = sizeof(struct scmi_power_domain_priv),
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_POWER_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_power_domain, match);
diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 79db1a6a8aa..7d2db1e2bee 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -8,6 +8,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 #include <dm/device.h>
@@ -202,3 +203,10 @@ U_BOOT_DRIVER(scmi_voltage_domain) = {
 	.id = UCLASS_NOP,
 	.bind = scmi_regulator_bind,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_voltage_domain, match);
diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index 6dc1fcb3365..f92a9e35579 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -9,6 +9,7 @@
 #include <errno.h>
 #include <reset-uclass.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 #include <asm/types.h>
 
@@ -81,3 +82,10 @@ U_BOOT_DRIVER(scmi_reset_domain) = {
 	.ops = &scmi_reset_domain_ops,
 	.probe = scmi_reset_probe,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_RESET_DOMAIN },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_reset_domain, match);

-- 
2.43.0

