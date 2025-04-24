Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E9C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BD381E72;
	Thu, 24 Apr 2025 08:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AZzKyw/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE43882045; Thu, 24 Apr 2025 08:34:27 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2081C8209C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZqXZgP/hs3ZNmUg0DpgkhmjiusKgLPNwS8KAtd99aXux8QUvWDCo5KIXihcLbDOfd/UncTE5onfBeITS8fKD2h8XzIXAR2rR2j4DaAVKs3kA8nqkUmOR/tixgV5tTEua/QAoXlK2yHNGyCsFM2VtNc/oDtI3Zbc4PiO/Cyn/m630GNn+W7DtiBd20y2OBT+tba80cVNL5B58EzXq9yMDUyPX+vBnmwpgJG6gEnEG/qlIlcCxxz+AjCADX6MtCf+G8nZ0DWVkjdDw+3f5djGqdRuwNlFNk+B2OUgRY76GUvbzx4g8LjelFbrvKTTFqagswGKsOJJVvhJRkEv/nTugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mChwcJJmHO8UxlNGhBS3lC4oKIm+rTjnLJvGTdnXyjw=;
 b=JaLHx7BXw+uY6l7qAswtiUxdUnb8b5vYDyPXy6hV4r3179N530dlUQ5IrPkWx+04PeKE3s4DkS6r9LLZkn/tk31LfhqdiX/xas3EhN9XbWZFOfhUUilppHg4r2zpEdVEgZTXHAXBzooORW927f2BQhwPahdWMN+PRckTBc5XJPOCLWV+oBvLQxqVIOEsVw89+BoJVnClmAcRFbmxI2iquTpwqAh+VbZb2OFk1zCavpUOWhE+E0kRJfVu5xtT8PJi5WyHKdJDFuKLPD4EywHSZLWVbTAmOTyM1c5q6lVi6jyHriaraljd/LQ8TnsQXoXKBu3OMHTD1IB9O2iwuRcoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mChwcJJmHO8UxlNGhBS3lC4oKIm+rTjnLJvGTdnXyjw=;
 b=AZzKyw/Hke2A1Gp6FYKjfVDK/Jmfqk57XTfbMvq9GQP8mpeLywJPAu98QY/8A6+1Cq0WXtd96NkrLnvvgaWBmTXy/J4nHHHpp3k4vFdJJ0NF2d7pvqsl9V5LI72gLCutXkMbp82d5jkKMI8MaFiwqgkA+LH8i4zkIpCVoVnzHSms97r6//3kYu9JVOeVVOsrbfsJxfkSERVgQMxRJE5Cd1RiFJHajWyRcYSUjVAjq52MSwuXVKrmJdfm0eV+FUjWWc+ypJiq9uDhgLF8Jko/bv8v3c/fhIpUOFhy5VzygHQyLHAB43JtAJ/41xCPkCYfEuRLkeRIbDDAXn5kI/U9Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:23 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:23 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:04 +0800
Subject: [PATCH v10 08/21] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-8-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e844b6-69a7-4c46-1e29-08dd82fa0d4d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnJVc0Y4bTdoWm9CeEplQ3ZBOVRRWXdhNmRxdFg0WXhCbnpoNk5rb0ZYcDBv?=
 =?utf-8?B?OEJiUlJyZWV0OXcxQXhzaDl0MGZTWmpzYW1UeG1PenhQWDVlZ1FEYU10U0wy?=
 =?utf-8?B?ZzMxY3BseGtENnJ6bGdSbFhQdHBNbVp1ZHg1RnNvUUNaSkkrSkMrRXpNNUpG?=
 =?utf-8?B?bWRhblp5bGhwdDBFb2hOTXNGdkx3UDdsQkRBNTlEaUplN08vM2xtUFE3aEYv?=
 =?utf-8?B?ZTNvNVFKZ0tsVjE4TFR6VDJPK3ROWVlsTGhpSVNweUhjdGdMd3VZeWhMTDVR?=
 =?utf-8?B?YlAyQnpLRk5Xc2I1R3NFSmdMbWo3L0U1blRkaEVwbnI2WWM1ZE1MZzhRcXpD?=
 =?utf-8?B?d3FiS1hCTkVodm9mVU11YjNRei9zWi9LbUhCVDJ6OWpETTBQaHNtemRoTzh6?=
 =?utf-8?B?N2E1UCtGNjVhKzBqU3FvYklVTSttRnVveTcxWThLK01VazYyYzBQdVZUU1RK?=
 =?utf-8?B?UFFZMmgzbjU0RUR6akdtL1h1TndkZnk5M3FzLzliR202WGdlSTkxdU9UNnhB?=
 =?utf-8?B?Z0ZMV2xXTEZkZWVGZ1Ayc0R1QXF1LzVzUHZhbys5VWIxb2ZLV1VlanVseGR2?=
 =?utf-8?B?VWpmRjU5eVE1cldtcEFIQlVFeEVOaTI0TEovMG9JK0h1T3lJb2tvVG5UdHlu?=
 =?utf-8?B?ai81TDh6Y2MzREw4Qm9hM3c1bDBFYVB6UEE0dno1YTVDMGdZN29CdWIzaU01?=
 =?utf-8?B?VDFvTW1SNFd5L3BqaXF6Mml0aWJLSFN5ZXFpVmFjaldFbEdjZnZGWnZkU0Ni?=
 =?utf-8?B?cERGYWEwYWNUeWl2V3VKWkh2d1lyaU5rSkJoYUNCWjgwdVp6TkU3WlkyZ0hW?=
 =?utf-8?B?UXM4ZWJiVzFYUm5WbFF4RTJocEdGb2RCKzJIbHpPcXlkREltL3lmcWEzZTlt?=
 =?utf-8?B?bzNONURxMnFlTGR6WGVrWEhjSzFVc050N2ROTTBIT1ZTQVIzeHJPOEZ5U3lI?=
 =?utf-8?B?V2NJcWFSU2UxdHlZV08xNjVVRUgzVEU4RGc1TDI1a2MvNjV6NDdacFMwdXcr?=
 =?utf-8?B?aFlMaXk1Z0NCZGlkeE9Od0w5dEczeFdoUHJPVTcycHkzRHgzTEFyVU4zQ005?=
 =?utf-8?B?WVdRUjloTzROdUNTam1LRk5vWXUzcGZLZklvaUR1UURSOHJFNWJXWmdMQ0Vq?=
 =?utf-8?B?dHdTMVhtV1FtYk9xV2hLS1pzQnZheWErekdjNSt1S3AvcGdaK3RvMTFPdmJV?=
 =?utf-8?B?MjBKdFdQbytyUmVrMkFneXFYVUhZUGd3d3hrYytva2dwTm5VRE10STQvU1Qy?=
 =?utf-8?B?bE9IQUFTd3I0WnJRVHpBemhjc0lQMERSTWZvWkRoRmx5SWlrdkxyb253emlQ?=
 =?utf-8?B?TEd2d01wditJYm1xRGlYR3JZeXlhUUlxWHFUNHFNNXhRbmR4WGg3a2lCRnVa?=
 =?utf-8?B?Zml0L1FPOVN3NFNlbW1USGE1ZzlZbmNLKzE4L0ozckNYT1doMnpLaERMYzE5?=
 =?utf-8?B?SU16RFlnYW94djcyMFhVVXhybW9HMXVSSmQvVVM0L3FPOStFMTRJcFR4K011?=
 =?utf-8?B?U21SZWprSEdkdEtoUzlWb3hqREZIS3FJN3E3b1N4QWlPSGdocmtJSWhDYi9C?=
 =?utf-8?B?Tm5DNlAzTzdSSkE5b3ZFU2ZtMzZLRzlERVFBUHJKSnNnTEtCdzBlNmQzQVJu?=
 =?utf-8?B?amF4UHJWd1Izcit6WXpIMm95MnRocWhXcmpmWiszQjF1bHFMODhSNlNkbThN?=
 =?utf-8?B?dGEzcTFUZUMwYUZpc2s2SnZ5cGZCQnJYVUR5Wi9JaDlSbVRDS3lnNDRVK1hw?=
 =?utf-8?B?MW4xdCt1VVYveEdzS29la20wM2p3Zk9wUTlkV3QrZGNjWndSa0ZhZzdPSmJU?=
 =?utf-8?B?STVlV3d2ZHlHRi84UU5EUlVPZlFFTnR2YWV5cEhTZ2dwbDMvVUdGSFh4UCt6?=
 =?utf-8?B?N0ZSbU1Za0VtK1hKcEtMNmI0U2IwVEFhdnBXTEJ3a3A5ZE5TZ3ZYejhoVGx3?=
 =?utf-8?B?TVhjREdnOWx2Y3k5TytOVEdiRVdtcXJNa2hwcFZiYmhiN1krcjVtRFpKVnYy?=
 =?utf-8?B?OTRPbVpqeUJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VKSlVUODlnU0NIczlYRFlKZnI3WXROa2w2OFk2VUFQbFlkcGlQamc5ZXdY?=
 =?utf-8?B?NjBDcnRuN2RkZGdFOS9XMWZ6WmJsaU83bFBFT1htMTV5RHA5aGk3bEtLdmxk?=
 =?utf-8?B?NkhyMWNpdC9MKzdzWlRSUUNDODdkb2p0TXBnQjdwQWh0SWNqYmlwQ2FvTU1T?=
 =?utf-8?B?Tk5kYW0zUmppb2trMHlrOHVpT01tclpWZUU1clZjYllkTWx0YmV5aGFzSG1O?=
 =?utf-8?B?T1hBVkx4clgrZDFtTzlmVmYrMHlBaEdjeWI0VTd2ZU5YbXlRZkpnelRGUFBz?=
 =?utf-8?B?RG8wMWkvcndBYXJWTHhQQ2JYUDBZaFlrNHU4dmh5Z2FNQjRNWmVMU3lRZlFs?=
 =?utf-8?B?YUhwc1RVZ3BqSW1hL3pKbERIUmdodEZ3OUVEeCt6Rzh2L0VhMGhLMUJmSHVt?=
 =?utf-8?B?K3l5dERtRFFVT2toWUtGMitxd2N1RVBGaEJFbk1yb1lrTUxxcW8wSDc5MUxm?=
 =?utf-8?B?bTh4d3J2dXkxYXFHaVhtdUhGUlg2eWY0cGNyR2NkNFJOQUIxTjRPbXNSOStx?=
 =?utf-8?B?aDNBb0xIa0s5cTFNNDlLK2F0dlhML0d6U3FVTGF1NG1TVDNqazhKSHJIMCt1?=
 =?utf-8?B?a1hKR1liVTlGV2s4RFQ0VXlCYmgzZ1RPN3hNQTBoOHFUdGFsdVFwRW9XL0xR?=
 =?utf-8?B?a0tGOGFrYTNpWVM1d3BlTUFEYTRBV3VuUEZKL1pCWFIwczh1ZWxlMXljZWNr?=
 =?utf-8?B?MVI2UlUrTDhVUFZxVGhZTURPL3VVWlREOURBYm12MzJtSlRydWgzN3lsNllX?=
 =?utf-8?B?aTZoVldkNlZVKzQ4NkhlWWFVWXlsWkZOcEt2K0VncDJhTFpObFQzYnVNYnNo?=
 =?utf-8?B?VXQwSG5VUnRUNCtkd2o3MDc3eXJCemJSTEhQM0N2ZzJOT2R5YWg5OWlxV055?=
 =?utf-8?B?ZE94Mjkzb1pab25kMmIzMW9ObHdGdWNwQXFpQ1hPdkFWaE9QSGRTUWpMNjZ1?=
 =?utf-8?B?eEg0dDZ3TUllYW1aUk5CMnBxT3JsTGljbzhxZUIza1NGTlRBUEdNWUNaWHNr?=
 =?utf-8?B?VDlMRGRCQnIydzB1UDhvcWduQ29pVHN2OUFvWmtyQ0pYT2IvNkpWdmN4QzNM?=
 =?utf-8?B?Q0cwK2pFTDF2Q29yMVd4ZG1FbFRkSGVNMkRBYzVESXh3cUs3MkxwZzI3THFw?=
 =?utf-8?B?S0ZUWlplZythOUIxWWRoN2tyTTdMaVNmRUtTMlphdFpDbjgzaTl2cEx1T0w0?=
 =?utf-8?B?QkpQTXBwandoY3hVR0Y1b2pCcm5Fdm9FRHRYWmRTWDB4VE9wejFlZ2Qxcjgx?=
 =?utf-8?B?MkpVV2FiWXQ5NllyN2JkZy9nZUtYQ0lyYTNZdFRHd3k5VXpKMjRMOERoNGxV?=
 =?utf-8?B?aXVHajlZdG9QdGNoM0hxM2pwbUxUVllMbHQ5cVpnSGI0ZGpGT0ttSm9DOU5h?=
 =?utf-8?B?MnBwOWRiQUZHeE92WmFmTzhScUwxUXJmcTJ1akhOSnhDUk1JUUtkTHRTVGpE?=
 =?utf-8?B?YVJCZG56R3UrUkR3RmxxVW1pWFAzem9UeUZScjdTajhCZ0NuZkVySmFuZThu?=
 =?utf-8?B?M3ovWmJqSlk3WHZhbFZSNEtMVWhoNGxXYnUxSVNKUTRpaEtoU1VEWVhKNlp6?=
 =?utf-8?B?SFl5YlFjcGI3bjM5SFY4RUlpT3VSY2Y4OW1SMXFmMzIwMW4wRWpTQi9uT05D?=
 =?utf-8?B?OVhiSUNXZ2szMGsxSGxEZEgvRVdWVVl2Z2JraGxPZXRDSGJHQUF1THRCd3Vh?=
 =?utf-8?B?cWhqOFl0S1pNTjFVSFErWGN6RzloNlZQNlU3YkJwWUNldENzblRnbGhJYVVN?=
 =?utf-8?B?WXBwRVMvMXo5TGRKTkJJaFZpOXQzWU8zL3AwQmFVTU0vbGlwejFGV0NOWk05?=
 =?utf-8?B?VzZncTU3YVFoVWxNQ1AwdzFrb3lsd2ovQWZLa0JrS1JhOWtSZEpLVTRGbXdm?=
 =?utf-8?B?U0lra2xNRUw2d29ncy9ZdjBZMTl1Rjg0cEtUNnF1QUdrY1pqUW8rZWE5d1Y5?=
 =?utf-8?B?eHhOZ2llcnQ5UW1Lc2pBSVQ3aktJUDJUaUxHM3NHWDY3VXVRMU0wZDIzM1RX?=
 =?utf-8?B?MzNqQVJ0RFdicnVGSVFScytSZ1pqVzVFS3dJbTByY09PU1VSVWJ2UGk4OEVC?=
 =?utf-8?B?a1RzYWdGRWMwWTNQVk1VZmRRMGFrYVJXeGh1U05leCtrMHBVSHJZdERpamVq?=
 =?utf-8?Q?5snTCPXlUfUoMy5blXVxlPwH/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e844b6-69a7-4c46-1e29-08dd82fa0d4d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:23.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/lk2SU453T6G0mQp3EQgcDg2QO6YZHgjkSK0E2KmmqUTLJyCakDKKzi3jTsJsCoNNoXloDoCfOnR1KsPFezgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here. CLOCK_GET_PERMISSIONS is from
ARM System Control and Management Interface Platform Design Document 3.2.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 178 +++++++++++++++++++++++++++++++++++++++++++----
 include/scmi_protocols.h |  24 +++++++
 2 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index af5e8679003..af69850cdd8 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -13,6 +13,54 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+struct scmi_clock_priv {
+	u32 version;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	if (priv->version < CLOCK_PROTOCOL_VERSION_3_0) {
+		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -33,7 +81,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -54,6 +103,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -79,12 +129,48 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 1);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 1);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 1);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
+	return 0;
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 0);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 0);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 0);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
+	return 0;
 }
 
 static ulong scmi_clk_get_rate(struct clk *clk)
@@ -109,7 +195,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -134,9 +220,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return __scmi_clk_set_rate(clk, rate);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+		return __scmi_clk_set_rate(clk, rate);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	size_t num_clocks, i;
 	int ret;
 
@@ -155,31 +265,51 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
+		return ret;
+	}
+
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -198,6 +328,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
@@ -211,6 +364,7 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.id = UCLASS_CLK,
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
+	.priv_auto = sizeof(struct scmi_clock_priv),
 };
 
 static struct scmi_proto_match match[] = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 342a65ae7f4..519b906b4ce 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,6 +731,7 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
@@ -738,6 +739,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
 	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

