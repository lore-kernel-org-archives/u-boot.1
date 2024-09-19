Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C3ACDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E078909E;
	Thu, 19 Sep 2024 02:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hfSHInIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3283789058; Thu, 19 Sep 2024 02:15:19 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF9189063
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vM1IXEU+sHKd4lTlHrjmHjF3BSMXjVwDDLvvWor6XakPnc0hl2sv//FKrEcbQtE6smoYN03fK65heJJ+zPxKEcSjVOSfFMKFIzwnVaApT9aGGpKI4qbvNJ9WZyUYgQRYqyQntSnb2pV/DVi4vmzC3+23GgSu8blZTGap1UF3ZO1psENGAMQjNIxmloFHdBrPB3U/24eY9nPyc5N/0AjyA/55/Ztf3mwQNbj06QmEq+4VXvXIUaX6Eis1HXm1cxsVxuFPrHCLUdUWDPM1VQQQKMNCncBlEsdhAlnj+QPoOvSQEsqEnq5KfP8PIXQl+EZf0qaxzmbS7MJxz1NjU6gr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WB0HSTzZc1cRbaJyblvquAo/ToyGJKv8Iva58dQ1AE=;
 b=r/xsFkY0RM9oinVw977x2Ws4ERl7jTDRe6lY3KEafxDIUWjOEcuAPz/0eXOpHhXw1CKp6P6Q/S3h2V1SVxaMzocIH3Yjv6JcGATyZZK3/maQ0kLm/VFhkrH4Let9fYySHCmvCQiTkgcWIGJsxliShM0hHLSepYygmqwl5Y/WtPwmwClkJo9WnIec3mgdJxfUgRVlW4zEtTr6USh3X+2RWzUPfUJ03q0m8gz/WGaH/JsA76/QUuCLTUVGvimuKwBPwbsqOtJevmE9kRkBTBkk3iqhPOJBzpSYqnAfdr9Np20pLKyDVMqWEBWeRNhT0He7nkQQQmn63dX1l37czvN9+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WB0HSTzZc1cRbaJyblvquAo/ToyGJKv8Iva58dQ1AE=;
 b=hfSHInItLsbnuc0raI9Sjf+V/OCUU5taqBD294uO6gCnvwVfiW9b/+x+4X+5augctO/kxn9MLUAQAj8FLxxFEoFb21EVptmwY7P6m6k2SgAd338JkrrEd0LWZ9Wm4KLGQJ/nRqVC1pLCmcDJwxmOWlIukjufD2aEHObgJEIvfaMIXj8aK9tjniuCW4BKeq+eFwWK/sxB2+DvcT9vkqohMGiOPd9lrF6lpYFBZUatynHp+pgqsUbH/otVKquoLofmmFqYZVzn2hDzvPs9eIdwjy0rop4F8itFN5J2yNhsOqvOI1cgtV44e3dPNoD1QLXa+Nyhb/FP9M+ex+I7ui2ydg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7872.eurprd04.prod.outlook.com (2603:10a6:102:ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:15:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:15:14 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:14 +0800
Subject: [PATCH v2 15/21] imx93: Add Low performance parts 9302/9301
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-15-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c177e28-4d96-4ad5-130b-08dcd840225c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG1vN1g4ZnlsN2E1TUxDMkR0YWhGSWVaRnlaWVZWUlNETUd5RnEwNmxHZEhQ?=
 =?utf-8?B?RmpER2N2Z2hMQ2E5SytQNERyMllCM1hzYWNsVE5rd3YvaGkyQU9ocTRtMThv?=
 =?utf-8?B?cStpN3dBYW96S013d0R1bFJXRzFBaUl0VDU3NFkyWGswZkpwS1FqQ3Jsc0lh?=
 =?utf-8?B?RWVoNk9RK0EvaDloL1hYUXhjNm5OYWNGSWNycXltWGZVQit2cVJxclhoMGVQ?=
 =?utf-8?B?QnlrMmM0QkJhOXpMTlIzbU83UG0xVGc5ck1JYitLcGtkRnA0VW1TL2hVbXBE?=
 =?utf-8?B?YTAxdzFERiszKzgydzVzOCtlUjFFSmdGSlRqUmhuVnVOV2Y1S0dQWnFCeE4y?=
 =?utf-8?B?bzNnVWJPbitBbHFxQyt3RmUyMHlzbmdQbXRNcC9vVUxUTlIveVRTczlKZ1Zh?=
 =?utf-8?B?akgvTFlSYzF2UE83SVR1TGZOYy9BY0dkS2JvcW1LQVhpbzVXZWYxakxRbEdh?=
 =?utf-8?B?clU5MjlsUFFELzRMYVZzdjJZZmt5RGJSa0lBUk1TV0thdWhuWHlDdGxoMktn?=
 =?utf-8?B?V3ZSeTNCcWs1Q2llQnZlZW5CZ2ZaYjk1YUNZUXRVZzlVenVMT0NtTXRvRFNV?=
 =?utf-8?B?ZUpaanQ0UGV3NnVVQmZRNEdYcVJhbHMyOUgrZDdpdWt0anoyaEFQVHMwRzhK?=
 =?utf-8?B?QUVRblBya3V5NGJlcUxMdzNJZ003ckVzSC9sRWxJQ0Rad3psWUwxWnFwS2VC?=
 =?utf-8?B?NzExbGl2c1FiaXNHVFRBa2NoeW1oS29mR3RiU25RL2s5V3hweFYwN2xxUVBx?=
 =?utf-8?B?dCtKTFE4eFlQNVJkV0ZCQjhYZExkN2wxRDVGdnh3UkQ4RStaT1kwRWhBT081?=
 =?utf-8?B?dXdVbjUyRytkMlErQVEvMjlUamtnbklPWHhDTlpCVFpjRldiMkRtMXFZN1Nr?=
 =?utf-8?B?TnlDNHhDSHNoelNJdjU2MjR4eUZEUnhhejN3QlU2ZjgxS2R2d1Z6aXZZYjQw?=
 =?utf-8?B?YnNFVnV2aFd6bWZ1NmNxZ0plbzV4TkJXaVI1aW12Ni9WZFhnV2xFYnJESXBJ?=
 =?utf-8?B?RVEvY2lHeExXdFplcDZFK2ZzWXVGdnJNU1grNW1YVnpNay9mTWliMVcvTjA4?=
 =?utf-8?B?bzZIZHFaNTFIOVhtYTlKUExLRy9TTng3c05YbmRrN2hlYlV2ZDVhMU01OUla?=
 =?utf-8?B?aW9Lc1FWTFVOd3dIZ3M0a3ZEM1lsWUhzVFFGb0JMekJsclY1YWtVT1FaMS81?=
 =?utf-8?B?T2JUbjdRQ2RMcFVKK01BT0I4Q1Q4aEdSZ2lRcnVrRG9odTJWVnhpS1dtc1A1?=
 =?utf-8?B?ZHZDQzM2MFduVTV3OVBUcXRHeEJxU21zaE01dElPN3F5SjU4UnVTRVM1UFdn?=
 =?utf-8?B?bW9yRHVkZUJSMUYzSEJqUk90dnphY2U4U2ZZUW8wdnZrU0VaYWtLOG5nVHY0?=
 =?utf-8?B?YWgya0RVS1pISWt4S2xHNUJYNGE0Mnk3M0tJSk9DcnNwRmlUZjBMMjhOWEx2?=
 =?utf-8?B?V3hESUhIUHhLWFlqWFRxTzdLSElmSW5nMHhxNGdpbTJ3S01SY2RkeFZuZXVL?=
 =?utf-8?B?U1FPVm9kQTl3MU5FQWd5L0VBdW50NXkycWJ4aEgwSzFacndjdjdSYWpLUHJH?=
 =?utf-8?B?RnpiYkRnVG9vT2U2eVp4UE11aElOWWpoSDRuZHJTOUFBeVlmRXlnQWpSWjhh?=
 =?utf-8?B?OU1ZQmt0UXhrOXBBQ1VVaFZQWXp4Sjlxb1hhTGo2SGRKRzYvcW03c2JUdk9Z?=
 =?utf-8?B?RGh5Z2ovdFlsWmtIeHordHFMcGNHOThGTVBxL00wWElYUTM1M2lITGp1d2d2?=
 =?utf-8?B?MVh4L1h2SURMVHYvYnZZTG9lS3hNQU9FQStrSTBuNWNpVTMxUzIzdzVaS1lW?=
 =?utf-8?B?c05yRVFHNWlBdVpNRmwrMXdJMFZESk1YZzJCVDFCa3JNa055TW1ZbDVVMjlm?=
 =?utf-8?B?SWQ3WENqcFA5SmZ1WmxhZElqWm4xR2Vyb1BrTTN5YmZ2dHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUFadWJlVGhEb2NrL3RIQUZvMTdRb2FvbExmR1RCclhHN3B5aU1lV2JCeUJH?=
 =?utf-8?B?UWcvK2kremFDQU1ROEFFNGxCZ3pGNHRVSDFOejNIMUpNOWE2WWp3SEFRSVE2?=
 =?utf-8?B?Z0xMN0NqYUIyRWoxSzY0bTk4REZVZWZIRTBGcmNpRmFENFdQcVZTN1BnYmJi?=
 =?utf-8?B?bWFmMmxTMFlZNCs2WEltWXpDOURlTiszdS9SYXQ5bXlUc1RqOG5tSlcrSm5E?=
 =?utf-8?B?WG9KcFFTYngwcEsyWW1HMUR1YktTMDdHRkFLOFNLRDNmSGs2OVowNmxVbUNO?=
 =?utf-8?B?U0NjUzl2QW9IZVlnYjltZTdKeU92dVBiV2s2VW94RGdoVlIxUFNob0JydmVi?=
 =?utf-8?B?cFBrYWVtMUZXUjB3Z3d5NE95QTNpVjB0QWgxWHQrelk3K3BZWEYwaUpXdEN2?=
 =?utf-8?B?NVJtUG1ENVo0V3dudUZibjlzalAyTEpGMmg0b1VpVFBodDgrL3l1ZEt3YnBM?=
 =?utf-8?B?NXZQZ0ZzR2tLSGdDa2x2SkkzMmQ3WjJkQStyMTVPTjZjU2JsZ0VOOG8vSmlr?=
 =?utf-8?B?UDEvSi9LeEQ5VW90Q3F1Z3UzMU5HOGJjRlJGVTduMXdERWIzY0RKN3U1M1dK?=
 =?utf-8?B?MkNWd0lkTmdNTzlQd3k1TFAreXZMSm9DdVh3dGpvQjFrOThqR1dCb1Uwblhz?=
 =?utf-8?B?MHlydHhNSnh6OFFtR1ZIMUhjQjhRUUhsUW1XOThKVE5XT0l3TVdocmpCREMy?=
 =?utf-8?B?Y1lqaVlhc1R6a2Vwcll6VWNBQnVMT3J4QXdnQnRST3FnNkxxTWR6Y20waW9U?=
 =?utf-8?B?TWtJZHYrSjZWM01xTWEwNDlBai9vSnZVTHROb2R4cUNINzZaZ2hUbktLeVQ1?=
 =?utf-8?B?WDhXYVgrLzU5bE9xc0hYRUFmTHgvSXdKOXRwL2ZtR0NCWVpydkNlYTZvVkFQ?=
 =?utf-8?B?cDZIMXlFQmk1QzNONXU5djZoNnhPZFYxZ1k5SWdhMU0xdm91ZFZlaUxoVlZZ?=
 =?utf-8?B?ZHp6VDVYYkxtNWxNWFFNZTY1RmVvWnN2M0lVbTlvWDdORW5ZRzhKQWNVTEow?=
 =?utf-8?B?aGhObnE2dlo1TEN0b2dHWnpBdGNJSGc2aitDSlU5aG5WOUdTbEh0cVloejBk?=
 =?utf-8?B?RVNSeGpqRXFkR0pXQ29sVkYvZmszR3hISU5FSHBRSjFpbG4xUjR3aUc1eU9N?=
 =?utf-8?B?dFN3d0tZaEhQbDQwbUhRSURzT3lSZEpUWEhrblV5SS9DL1VZcUJUQWlsZGhj?=
 =?utf-8?B?U1hJYnczRS81UTdLWGJmVG5tRnE1clhmTmZsNnZPdXRYY01oUkJZcnE0aDFi?=
 =?utf-8?B?MXlpVmxybWlRRGJGeUJRM1RiQWx1UmkrNWE2eXJYNFdFdGVEcGwvVXJrbEpp?=
 =?utf-8?B?YUR3eCtSMWF4dkVhamV1VGw5YzVlaUZ1N0l2b1oxM2Q5cjVhQW9pd0xkc1px?=
 =?utf-8?B?Q2lDaWxzaWxOcWxxUGh0bTRQK2pvaXRwcGdpakhWVGdSWFI0WFRlUXdJNEZo?=
 =?utf-8?B?WGFkVS9LT1lCUWJudGUwcmZDNjN2Qk03a2dUMCtVN1M4cEI2Vk5WL0UxbktC?=
 =?utf-8?B?MW10WWVjNnVNTEVPVCtiaUtBWEFGYmdIbHR0aUZ1cys4OGJmZFVORWtJaVBW?=
 =?utf-8?B?dGRTVDlOdmxPSk81UEVHbFM3LzhaV20yaGpCemJRMmwvVVVNWk04dW1BRlpy?=
 =?utf-8?B?TUZqZEtvQUZ0Z21qWm84MGg5eU1UQ2hJaGhGcThpcW9XRE9SN0FaaGY1N2Ji?=
 =?utf-8?B?aXZPUkRqM1FTazNCOVNIa0FWazNuajNIVDVEUWRRbmx1TXNWUHpvNFI5WVZo?=
 =?utf-8?B?cmdtdnYxUS81ZGh3SVhrVHFOaE9Wekhib0dzWWg2OVNibDJvV2tBTTNqeE1E?=
 =?utf-8?B?QzRWbkhhOXR2QzVPS0ZxYkx0bFlxVGRVenIyY1lNTnJXTWtZZkRjQURGNExp?=
 =?utf-8?B?NVRXejZZTW1BOUpNSmRUVTYxVmcrZkdhRlZEQW5VTURlbFhENTMwMCtWNDNE?=
 =?utf-8?B?cmJ6NWlWZ3VjUXNrb2ZTbDN6cHdQZkRGZFpLMGs1R1JQSm8yb1IzdG1reHpH?=
 =?utf-8?B?Ykg5ZlFyZGd4Y1hibTczWitKWndrUmp5Rkx4cWtQNDNGVEZJWjFkSmRjS1h4?=
 =?utf-8?B?Z0JCNk9SZEtIWk44R1p3aThCd2VhWjU4RjdrcUVudVNtaHNwaG9SNUVEWklu?=
 =?utf-8?Q?6ucVNAhoxX7183Jx86BWSIhh5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c177e28-4d96-4ad5-130b-08dcd840225c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:15:14.7034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7uKL4Dr6zyewtoMnsVqShCk/F0629SFhRYwgbGSa+Ai0Pq5YNbRHz9GgWOYkwlDkVzyqlec3Lcmji/jYwHdCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7872
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

Add support for iMX93 low performance parts 9302 and 9301 which
restrict to low drive voltage only.
The parts run A55 max speed at 900Mhz and M33 at 133Mhz, have NPU
and A55 core1 (9301) disabled.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx/cpu.h       | 2 ++
 arch/arm/include/asm/mach-imx/sys_proto.h | 5 ++++-
 arch/arm/mach-imx/imx9/Kconfig            | 1 +
 arch/arm/mach-imx/imx9/soc.c              | 6 +++++-
 drivers/cpu/imx8_cpu.c                    | 4 ++++
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx/cpu.h b/arch/arm/include/asm/arch-imx/cpu.h
index cbd2717f97c..b0468a1a136 100644
--- a/arch/arm/include/asm/arch-imx/cpu.h
+++ b/arch/arm/include/asm/arch-imx/cpu.h
@@ -68,6 +68,8 @@
 #define MXC_CPU_IMX9321		0xC6 /* dummy ID */
 #define MXC_CPU_IMX9312		0xC7 /* dummy ID */
 #define MXC_CPU_IMX9311		0xC8 /* dummy ID */
+#define MXC_CPU_IMX9302		0xC9 /* dummy ID */
+#define MXC_CPU_IMX9301		0xCA /* dummy ID */
 
 #define MXC_SOC_MX6		0x60
 #define MXC_SOC_MX7		0x70
diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index d93e095e191..c146a223b71 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -85,7 +85,8 @@ struct bd_info;
 #define is_imx93() (is_cpu_type(MXC_CPU_IMX93) || is_cpu_type(MXC_CPU_IMX9331) || \
 	is_cpu_type(MXC_CPU_IMX9332) || is_cpu_type(MXC_CPU_IMX9351) || \
 	is_cpu_type(MXC_CPU_IMX9322) || is_cpu_type(MXC_CPU_IMX9321) || \
-	is_cpu_type(MXC_CPU_IMX9312) || is_cpu_type(MXC_CPU_IMX9311))
+	is_cpu_type(MXC_CPU_IMX9312) || is_cpu_type(MXC_CPU_IMX9311) || \
+	is_cpu_type(MXC_CPU_IMX9302) || is_cpu_type(MXC_CPU_IMX9301))
 #define is_imx9351() (is_cpu_type(MXC_CPU_IMX9351))
 #define is_imx9332() (is_cpu_type(MXC_CPU_IMX9332))
 #define is_imx9331() (is_cpu_type(MXC_CPU_IMX9331))
@@ -93,6 +94,8 @@ struct bd_info;
 #define is_imx9321() (is_cpu_type(MXC_CPU_IMX9321))
 #define is_imx9312() (is_cpu_type(MXC_CPU_IMX9312))
 #define is_imx9311() (is_cpu_type(MXC_CPU_IMX9311))
+#define is_imx9302() (is_cpu_type(MXC_CPU_IMX9302))
+#define is_imx9301() (is_cpu_type(MXC_CPU_IMX9301))
 
 #define is_imxrt1020() (is_cpu_type(MXC_CPU_IMXRT1020))
 #define is_imxrt1050() (is_cpu_type(MXC_CPU_IMXRT1050))
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index e892da80fe8..63e75b6806e 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -30,6 +30,7 @@ choice
 
 config TARGET_IMX93_11X11_EVK
 	bool "imx93_11x11_evk"
+	select OF_BOARD_FIXUP
 	select IMX93
 	imply OF_UPSTREAM
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 4ee40c2da32..23e81caa8ec 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -191,6 +191,10 @@ static u32 get_cpu_variant_type(u32 type)
 	bool core1_disable = !!(val & BIT(15));
 	u32 pack_9x9_fused = BIT(4) | BIT(17) | BIT(19) | BIT(24);
 
+	/* Low performance 93 part */
+	if (((val >> 6) & 0x3F) == 0xE && npu_disable)
+		return core1_disable ? MXC_CPU_IMX9301 : MXC_CPU_IMX9302;
+
 	if ((val2 & pack_9x9_fused) == pack_9x9_fused)
 		type = MXC_CPU_IMX9322;
 
@@ -704,7 +708,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
-	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311())
+	if (is_imx9351() || is_imx9331() || is_imx9321() || is_imx9311() || is_imx9301())
 		disable_cpu_nodes(blob, nodes_path, 1, 2);
 
 	if (is_voltage_mode(VOLT_LOW_DRIVE))
diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 60deca963a6..6c0a8c0cbe4 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -60,6 +60,10 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "93(12)";/* iMX93 9x9 Dual core without NPU */
 	case MXC_CPU_IMX9311:
 		return "93(11)";/* iMX93 9x9 Single core without NPU */
+	case MXC_CPU_IMX9302:
+		return "93(02)";/* iMX93 900Mhz Low performance Dual core without NPU */
+	case MXC_CPU_IMX9301:
+		return "93(01)";/* iMX93 900Mhz Low performance Single core without NPU */
 	default:
 		return "??";
 	}

-- 
2.35.3

