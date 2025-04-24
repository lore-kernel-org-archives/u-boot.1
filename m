Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E72DC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D338269F;
	Thu, 24 Apr 2025 08:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rlVLpzF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6490682103; Thu, 24 Apr 2025 08:35:19 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6937C80944
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfk5W4Sg4CSxnBn1oXlTToQUtrn0EhyJnCObQAfVNKsOmMr65T6C65zIEYV2N3QBUtTOtfUEjqcS0T0hd1vADTNa70+ussUn/jQG8G87srgsCZd26S/RS4lO6vMjlVy60rC7jfrWEsS3NgQPJRpt7wDB0wo0+39nbr8R11rhJ0qOAMdT1nJK+WDwRbLqn7o7IWYRI7f7s5uxn0hL0VziA03OGONFuQK1mDZmHjOv310VS1TDD+BgKSRmi/lfr/miuoJCLSsKeOU8hPQ1DM5P5hH+wI07hlFppIkEPiZvOKbHmUMJsI8paVVdENlTK76cENBC9Kns2aoS1CyKxxxsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2qrdSLzSxQ9sSMsD+oe638qbf8U+u14JXSMQcSdGR8=;
 b=bod+vFkgRyHH7gS/Q+4kXWlsdXswD9P0iKexjo0GSXqyXL6HFQWY8bMX46ta2nZ+3UbzySSmeSCBMQFgR5PlXAXbuRnxLnnbNurl0qQ84jJ6GMJ+iVG3SV3c3R8tGpKUXPbD2LsRbrM1iH6dI8q7mnGG7ncI9KNn4CLkD0uiYoS/tMByh/13fN8fNS2S1zw/pEsWmmfkj3urBjwp0+yLCoOX2rJPdgYwohgGZw0Nkv1ROgpwaptrLgxJcbRK3ow+I7ME0ctPrO1QXstKtophmu3cE1vqgZKNgKqJoPKlhO0FnrHnL1mxtUDqVS4GsFO/Nz9x6eR/4urbIFJPdZY2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2qrdSLzSxQ9sSMsD+oe638qbf8U+u14JXSMQcSdGR8=;
 b=rlVLpzF/SAap1vssxNKz5mPwBKmuZv5Mr0ERARsOoMYTD452Ysa3kQ0ZiIRcbb+m1akoMmBRdEB1je8b2zsLXWEz2UiGrhahuHBFfMuq4zmqPDQrpTRz/ISl3/8fptesR2IL+eudks7PZHwC6ZF9Katcm5TIM5n+mYOjwiVxojgq6OfvYJcd0/YfOsuPRoK4UcuToB1GJDOWpVQL3GILH/mTf/6RO7uWV8cSRf1FzuxvehR/H9KzX8scGpkV+1b1z3+CW23FZ+W9GhgoqRMnHuN1w4XXnm4BCQN/ATFTiLZVOAhCQaG7DhFtfpaXF57c/qglCs7IkIN/iTtaIPV7Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:35:14 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:35:14 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:17 +0800
Subject: [PATCH v10 21/21] Makefile: add some files to CLEAN_FILES
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-21-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 2baeb817-fc14-43f8-ad2b-08dd82fa2bb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VnBsK3hzM0NuT1pBZE41T3pOdVZGVWFBUzRGOHRDa2YzQ2g3TVhDR3VJYmFL?=
 =?utf-8?B?SWRhdDByS2RtWWRpdWN4a2x5YXl6RklvdDR2ZHFOTG9iVEJjOE9YVWxmM0du?=
 =?utf-8?B?R1F6dzl3TWlUanc4ZTR4UmFiNWQydVpKR0RhSlRiM1I4eG03L0Q2bFFkRWxF?=
 =?utf-8?B?MXV0ZzY5TTZkZTV3d0FmbE14QVJKNVEwQWdieHdUczYzSURpdHZqRFNkY3Zz?=
 =?utf-8?B?L1J2UGNvTi9UUHp5TUZQdy8rR3EySXdmOFBKODRZNUJsdkxvUTFRMkN2L2h1?=
 =?utf-8?B?TGx0L1hOclpLV000Y0czREtCN3JWSVNDcjczanF3S3BKTDh6VGtoT0RCOW5s?=
 =?utf-8?B?ejFPaTUvSU0xZlRUV25nZkorN0d2Qk1UdWlneGVCOWxuTWlQRlJiV2FRWXlh?=
 =?utf-8?B?K3o3SWxpaDZxMmN3bVlYZXdlNGtqbG5LNnZzeGQ5R2x0ay9tVHQyNkpDNzFD?=
 =?utf-8?B?RVlKdlZGMHdVUWtXSGQzbG9MRnJPem5LbGQ4RTRCZXFsVTF4eDY3aDJEMWxK?=
 =?utf-8?B?UTNSdFNDY243OHYyUHh4NHdqL0lUdXFLa0Z5T0FFUU1pcFVEUmNxa3ZoZUdk?=
 =?utf-8?B?VThkL0lFRkNmcmpFOVZaWnRpdDQ5eWZscGM0YXNRV2FlR2g4d2FjVXA3VjVs?=
 =?utf-8?B?aSt2UzVGTE9TRXlvblJvaDRQanB4Q0t2R1JKY05xa3FjdFNYUGdUUWN5SU43?=
 =?utf-8?B?dTVZMFBYMzE1Ymc4UktURXhoZXVKdkFDUmNyVWMxcTFRTHQzb0VpWVBXWHZF?=
 =?utf-8?B?R1FPTG5raXRDTmdwUzJ5a1pLUlJSR29aWStHL0RPdlBwa3htdmJKVTJSU3dM?=
 =?utf-8?B?QVVpRlR2Q2F4NUtIOUpuQ09rVmhEMS85azZIYm4vaGovMnVGN3RnekowdlRh?=
 =?utf-8?B?ODJ1ZkZHUmYvMHZMVmwwUnUydFJ4QTl1RVIrWVU3cG1ZOHdpL1hIWUtzd3Yy?=
 =?utf-8?B?U3d2aDFNZG5DQWlGcGJEWkNOb1ZkVHBXeXNHK3RPSW9FanAwYS90TVd0TXRm?=
 =?utf-8?B?S0FxMjdVZnIrbFFVZkQ5dW40Z2VxM0kxWGtkZldnQnVXM0Q5UHI0NFNuOTAx?=
 =?utf-8?B?UGNqeEpSaUQ0bnVXQ0I5NmgrRG1QaTdWMVdUNmc3Q3cxRnZ2YnE0OTBpOTlC?=
 =?utf-8?B?eVNGMG5JeTAzbmNlSkd0TlFyd1lIZml3QTBnTEx3cWRxVGswNVoyR0ZXTVBk?=
 =?utf-8?B?MHh0alpsRHcvZERiK1M1YTMvRWJSZVpuOU5Oa1ZCeFhPTEJieFlKRFh3Ym0y?=
 =?utf-8?B?M01UNGdlemQ3VGhjNS9Gd0xtSnRJNmU4K0FTd09iczdpdWFOVXRKNm9pUVdB?=
 =?utf-8?B?OE8xcjg5Y2NHVzBRQlcvUnhRS0k1NzRhamlVaGxGdXdxRVB5UmFpbjZISmJq?=
 =?utf-8?B?aEtXdWJ3VXhHNUxPKzBBc3dHSmNCQkpJMFRQQzlrV2tFZE4yTmp1dm1sRTdG?=
 =?utf-8?B?ZGhrZjl1TlZuR1hCZW41M2ErejhGWlpYaE1WWER0aHZSVnZibDcrVU9aZmpI?=
 =?utf-8?B?WnFnWWhOUFdhdVczUGJxL1NURTNjWjdkdU1KaVg0SlBXU0x2c2hWTzZOQWZ1?=
 =?utf-8?B?TGxyVXpjTzNnTk11Q1RWaGN3cDQxMytIYVp4WWI5eFdTRUdVYmQ3bnFnQUYv?=
 =?utf-8?B?TE1Uc0c1d2N3Mmc5V0hnRjc1UmxIcE40MmdGLzRUUHFZMERnZDBuVVppVng0?=
 =?utf-8?B?UE9PNWtHdzBhcWh5OUZQeHlzK25aZ1ltMmJTTVVyeW9FNGp5Wnk1VmhOMWhr?=
 =?utf-8?B?Tlk3UXBsUWRuM0VzajVXeUFOK2JkQmdjcUg0WmZPNWxqSHlaeUYyU0xORVBX?=
 =?utf-8?B?YTdKN21JVkZXeFlMMEhDWlVHODF2Z3d1WmpRdzd4YjlETGczKzl1YzlxK3BN?=
 =?utf-8?B?dzlRL2FoNk96aEFiRmJPamNZU0N6MHY2SFNUbDg4ZGhUVENWbVlJOXUrUEo3?=
 =?utf-8?B?cEg3czlWYmNaRG9HbTdmQ3k5dWNBWEtnRm9hWVU5bFo0OWNEd1E0ekxIN0RM?=
 =?utf-8?B?aERQU0VRTnZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHUwTlZlMzFqZ1dhUmFGWE42a2p2NEl3UVFGenIrb0w0S2w2Mmw2V2VEVTNh?=
 =?utf-8?B?Zm80NWJoKzhBU2hSQy9ndnpCTnZ0RUZyRFB5L3ZsakhJeTF2UEtqaEtacVFJ?=
 =?utf-8?B?UXpZTHFwbVhCY2RramFmSXcxZ09CTXVtaCtjYmlFcUFVUnBlclN5YVJxaHJQ?=
 =?utf-8?B?ZWNpdVhHKzNPc01qSW5IMFhzMmEzaTMyVXFiYnl6czRiS3RmejBheWx0cHpw?=
 =?utf-8?B?M2I2UGowcWZwdjZSK3JhRmYwMW9UM1Jqc1V5ZjN0MDhRQ3gxRVBONjVtRitB?=
 =?utf-8?B?eE0xVVFpeDVYNTR4dkVudHN6UkFUcUYzS2JEM1oxRmRQQnpCZFQwK1k4NVFY?=
 =?utf-8?B?SUxIbkVuem94bG5zNVhvVS84Tm9HUW9OSHFIazNGSjc1YWRvRHJ6WnVtQ0ha?=
 =?utf-8?B?bUk3RUFnV2FxdW1RcHlERnExYXY2TWkvN1F0Zmg2b0Z6Z1JZQUZiWWtWMitG?=
 =?utf-8?B?ckdnL0hUNTJwN0hBKzV6V3c2QmxlbFNGM3R5emtjVDNGZFZXVXlyUGlrY3ND?=
 =?utf-8?B?Q1N1N2toeWFiWDVkalFySm5PU3BZZWpST0hhWEM1enZBMmxTQm9oWkM4WHll?=
 =?utf-8?B?Tmp3SnhVUG9BQi9iOG1SZUk3eCtsR0dydzc1Ykpmcm5rOXdEaU5CMmExbGw1?=
 =?utf-8?B?bEhHVjI2SWZCSWl5QkJaSDFGWmxKRWJybDhjRm1wNVViQjZIZ0tXSE8yTkZS?=
 =?utf-8?B?MWpvNlhlZ0EyQUxBdENTbjgvaDhBR0xCVXFMUVVRenREMnJ0S2twQmxFMmx5?=
 =?utf-8?B?a1BkWEpZVHY4K1c4dW1wbzdjU3ZwT2tEZHpkZGVGR2s0cW5kK1cwN0Y3ZW0y?=
 =?utf-8?B?b2hDWU85OXREMDdwOWMwc05JTVN3VnY1MVRVdVYvdUpzSXBiRnJWQ001UEN5?=
 =?utf-8?B?Zit3SDAycWxFU2RUcCtrVXJxdXpvNlVuWFpsd3hJcjhXWENyU2VJTkZaU0N1?=
 =?utf-8?B?bHZTaGkxczVHOHRhaFZCdFZLOEx2Ni90bmxEK1BKbU80ZkY1MWs4VCttRThI?=
 =?utf-8?B?ckRKRWQyNzFIbFZXbkY2OVN3bkNPRVRCVUNtbTVNSHBzSm1VTmdYSEg5RmFq?=
 =?utf-8?B?azNSUWUyaXdmOGZyOFNxQlVvMFZWZHVCS09DdHdWY1dwQnFEb3l5VVpVSFpF?=
 =?utf-8?B?UVF1RHJrVisxRzUxQmZDcHNLTDRQVFFWaVh1TjFFUWlTRDNMK1hLdVFqdHcx?=
 =?utf-8?B?V09qVDduSWFxbnoyUWk3bi83ak9CdEx6eVZXcVFibFFYR3JpcVM4a3pEWUpN?=
 =?utf-8?B?b3JBSDlqT0ZpdnY2cW5DcXVBUUhXbkNjdm5ZNWhhS20xYjAwdk1nTzIwZTdY?=
 =?utf-8?B?NEVkQnhVSlZXWVJHODBQQTdLNC9BMk1RakZyQzdocDRQM212NlpFOXRaaStI?=
 =?utf-8?B?c3FMYnNlYWlSdnRpOWZWKzEwNUZqbnE1UkhYSEZ1Q3pkNEVGVytwbWVLbnNq?=
 =?utf-8?B?YnhkMkgrZmpCQXVKQ0grWkJ2TXI3RkcxTGk4VE1CSGk1MHBLQUxQYmwvak5q?=
 =?utf-8?B?TURwNlJtZFVHV0E0eXpPNUNqTzZNSGhJdnFBcXFxNHlxb0VMdVJOa29YZUV3?=
 =?utf-8?B?TnB4TFB3cGNhSmtRbTRXUWtLZ0ZxZ3Z5ZnRtNzUyS3NoY29uSGl3TTdEVDFr?=
 =?utf-8?B?V1RXNkNjdFJXdXZ4SEV3akFNdW9DaStid1JRZGlCdTNCaTUyRFZQaG5wekYy?=
 =?utf-8?B?WjJsT2FRZDlsZXVyYkZEdzJYZVYxT2lGdVFxNFJaYWt2bUlvbFdOajBjdnNy?=
 =?utf-8?B?MjM5L0ZmUFQwQzlNa3pzdjI0WTVSOVhaZ1F3Y3VlK0tXbmxjVitNNTU2U0dM?=
 =?utf-8?B?YU12Y3BlOHovOFZsRjJZcTNvcVNENzJyem0xWjg1R2RmdktFblBYejhkZkZZ?=
 =?utf-8?B?c1hGWFhXOEtveW9pYU9uNFNjVHZ0QVJ1R2Uxb1IvWkMvZ1IxUUhNb1ViOG1w?=
 =?utf-8?B?cjN5clRUWUZBNzk1bU42WDljQURZN3gzSTdtVW9MejREZGhZM0RCU0hqY0l4?=
 =?utf-8?B?RStZSDVnbFp3MjRWUnFJMFMrQVNEU2VHN01WSUJoZkdFSks3RVlHSW9HRnNp?=
 =?utf-8?B?cHVYNUgwdTF0Tk1nUURLWGQzdmI0cWt2VUFjeEhkT2lXekZXaTBpci9IeUk4?=
 =?utf-8?Q?b+uIEAneJ08HGg8Uhxmb653e0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baeb817-fc14-43f8-ad2b-08dd82fa2bb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:35:14.6408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96Lh2t1ZJDZtcQHR9f7/wO7latGIMlibZsR3vaYV63AYIIJyB3GRWnB/NwDIY/cWzqQv8Dt6rYISMlkPDCM94Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 73939748e54..261c4706c65 100644
--- a/Makefile
+++ b/Makefile
@@ -2231,7 +2231,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \

-- 
2.43.0

