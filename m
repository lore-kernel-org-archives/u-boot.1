Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F9FE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8338035E;
	Fri, 20 Dec 2024 03:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SbwI28O1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563628021D; Fri, 20 Dec 2024 03:55:56 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66C6B803CB
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dN8kMPhcntgb5Z2WIvzaeGTTKVcsbqTi6JgAr0qsuzQFiFuejMpuZ9/fRW1k0aLT/SVGQ03AgJbqPVfZ7wSZy14ZQRJlw6pjMTFB25wQr3wLvuv0WqpqsPo4cBl4zD7NM+9yHnnbBIQzWOrvKnHiqBykFXXH7ORedt8x2PMo7x2Ons/VtW8v4wRMoThmqJ6h0Bb7DqZGhYwg22WxFIj2+AmRnaOJbEebKViPq0MYgSODMkTrZmN4eBfmiYZPB4MXvnhbQ+7jEpSCjTmeUG6eNuNEcuyyNkmR+lWIkzWOHgoqutHG7nqxlDIHhI4Ud5cQIdgcMEhqYzSBDu2T+ukmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=F7QnXidyU1m7ACP94EaJGePkzpqYaVp360MKo+ADFawW1yOl0oxh/l6Uk7sfTfF9AFJdUuliHxkY9NsGpW2mwWGQKv9WgKzSHCDFu83DBBSyZjoXmUm3Hyjg2TiBlJo8sEeJItwjqEyTEfOUtHDLHJArHCWXRfQi0qjD5+oJHc2P0RoybeSEbCEORSOge4MJsAORWIbZyIbGTnJi/CyLvu59TPXMv9iV8NFnO9mNdsST2knbZhJVEidw1gDH5E6s3Y3ZUrj4vSfIDEvZPAza+R7+BEzc+p0wkwNKuHiFEwI/Ag9BSFoqBT86SPZjRO3DJfAnAawsZK4aXMYsJjtxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsA/x3FIieWNDxQwQf+dD1mvAAoSeWt9028OYT9schU=;
 b=SbwI28O1ty+fKOz6HVwFxHR3WSRC6/LBKRAH5V06ba4SsjTDkladvTKfyj5egblXLVQruePA9/m5YkkWyR5wr7jddWWld5qnb1uDqVueLepampd7xsNZfLlhHUJx7Y47YbiDGbfHYPFmWMDCvpyKDeQuw7xri+e7/ThvNjtyYw9u4K8B6wObzVXiOftk8RyYjNDNa9t1dlTBun9XHQj/672iZ6V5yX5hM9nQGE/EnlP9W5wl5ez6CZ+F/y7eENf6pJoGw4KTTRHeYcoY0sbXvwuV/NAZtuKyQ7bsfLknCCxNXTBWmnoWx53IgzArK5/x+fVbKXZHTaCsNeLFCe5g/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 02:55:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:55:53 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:10 +0800
Subject: [PATCH v2 12/17] scmi: add the macro SCMI_MSG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-12-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=1060;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=04Fugt2pLh/tOsYnH9qSnBxxNCtFxPv3ln1VhqSdivE=;
 b=ONEdN1QIFpcN9QXhBUfI82ZobWWxHFQiHHrmzMtXnU0bIZ8C2R83dd2IGRE6ndafA9Z/7i89X
 1XTWLwO/ThbD7++EUQMkiGUqTUFDY6Zx5kSlf02EBpAsA4chtt16hZi
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10981:EE_
X-MS-Office365-Filtering-Correlation-Id: b67eda06-a3c8-4c59-2b34-08dd20a1d13d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3Q3S0ZWSk9iRm52THhOTmlGMjluTmtteDFRMVRlcFpzSVZwMDV4bGNCbXF0?=
 =?utf-8?B?UUYzS0ZYbkI1b3owU1lsakI4N1dCU0h4L3FPR2hvOEtFRTNHS2ZWcEdpeDVP?=
 =?utf-8?B?SzBueHhURUxsRlMvNWN3clpNRkppaE4vU0tnKzQ2MlFOQjdzNlRybEZlNDFk?=
 =?utf-8?B?ZHc2QnBQZlJtK3Rma01SVUhxUTlzdWV6MzF1dTRaMURDRGpZQ0tDblIvT04v?=
 =?utf-8?B?dkhDQXNEZVZBeWEwZG92amNIN3VadWVnRkJoNnhxa1FCSmEyTjZhWm1WMmM4?=
 =?utf-8?B?clRqaWVBNGNUTy9DSVUwNHQ5dUJwWlp4TWc2RzRIMElUaGhRYzgwZnBBSStx?=
 =?utf-8?B?djhBSC9SSVVzc1I3VzA5WmczeVU5aDl3RmJQNWdIWFVHQ3pENUsrMFNzdzM4?=
 =?utf-8?B?S0dJMmVieW5jVTFmT3IzaDZVUU9IQnRmQncrRWNkKzdmbGtzdmJHNkYrYU1i?=
 =?utf-8?B?M0plcnNiay9hdFZNd2o3eEYyT3dqcWV3c2hoZzduSnJZNEtwUGtYOXdBUGg2?=
 =?utf-8?B?b0hHT0cvbTM4bTlQUDA0SW4zZjVIcjlIeXpCMEZzVzU4cC80czNHTVhta0ZX?=
 =?utf-8?B?QmdjTlJ0WXBVYVlaRUtQampwRnZVYUlaS1BVN25KcysyN1RJaVlFdU9WS2dL?=
 =?utf-8?B?Z2ltQ2Iza1grbXdwUUZveEI1dExCc1h1bmdnRXBXeGtlRFZaSklGeUxITFZ6?=
 =?utf-8?B?bFROVWc4b1dQckZsdXY2RnVqSDg4c0pTWTVOU3hwMUJIQ1dGcGlmUzFDaE44?=
 =?utf-8?B?UU1NNWhVMlN4bGJRRUNpdkRjcHFmZDlHeTBSUmw5amlzbUtZSDNEdkhvVFha?=
 =?utf-8?B?NTk2RCt1QTRKTnl3bTIrNmVmd29IUzJXZ21PQkN1WnFaUzNaSkpqdjBKaGRI?=
 =?utf-8?B?R3pSMkROSDVxOWgrWHVWOEtNWUZaaExqRGd0aWlZQkRRZm5qU053RmdWcXlR?=
 =?utf-8?B?MHFkUUY2bXQ5V0gxbGI3TFIxaFd6WVAxWnBSM2s4MXN6RWZXUXQxbjRUV21U?=
 =?utf-8?B?SzhiNUkrV3RYZ2RGbDgxM0xXYUhOVXJnM0hYeTg2MjhmYUkxVXFoYTVlbmY0?=
 =?utf-8?B?anNwcjF5a2NDamNuS0k4MUJCL2g3OWZIQWswaGdZWVhBK1RVeHdRS1hLb0xY?=
 =?utf-8?B?OGROaFpuMy91NXpMUm1PQ0NNcG8xTk1tV1JScXArRklxeVJ0TVIvK0dTc3Vl?=
 =?utf-8?B?MGJrcVh2WVFpYkNRalJUQTlGT25nbDgwVGV5cHViTHkyaDQrUGRMN2JyUW90?=
 =?utf-8?B?Wjl3ZExUMisxRXV5MmxhbC90TTZmbmc4eHJHNzg1NkVZMmNma29WTTlYODBK?=
 =?utf-8?B?WTlXWUJjbXdTZU5nQTZnYzVqY2JQK3R2NWJPbzM4Rysremc4VTRDbmJnR3F3?=
 =?utf-8?B?WlBPeGFiUjVWMmF5UWdVM1NscloyY3gzSS9jSDF3eTdOVWFBN3JmTHNBMlVO?=
 =?utf-8?B?OUNtUDVGeE82d2Z3MEUwMVE4T1lMZ0w4WjIwNGpIelExc2kydXFkZjIwbFdG?=
 =?utf-8?B?bU8ySDdFL3BYMzRRMjNRQVMxdzB6aTM0NkFUYVJBUzc5Sk1zT1l0bS9PK2FQ?=
 =?utf-8?B?eDdVMmlsbnRlQzljSXZ4T2FHbms0MFBZeWdEUVFGL2lvT1ViVkJmNytjOXN2?=
 =?utf-8?B?eERTQXlvNlBUV1pFRXVyZDZnbTBkK3pYemlhTG1SYU1MdzRIenl6U3ZFYjgy?=
 =?utf-8?B?SHd3OXl5QVFNNnlwck1HVEtrbTFrQWRRcmpuc2szMnFDN1hibUtWT2FiZXY0?=
 =?utf-8?B?VHFpQ2VrcGFNcWp1ZnFFaVFkdC9IZU5KT25DVWYyNmFEQWRteEdydXJQdjJo?=
 =?utf-8?B?VHlnYVpIelI3SkhQMXZtb3A4NjdWWFE0QUVzUHRobjRrajNOaDl1Wk1VMEd2?=
 =?utf-8?B?ZllSWUNFR0RaOGtpRXpUWERBUEFDRFBNbFJxaHdBQXF2eEZBTTFjRkFjMWlj?=
 =?utf-8?Q?eQg7LJeSG1yQZAXVZR1PntnUJcLnJX9i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlMyMXYrNG5iNWdyYWJmdyt6ZHpQOGZ6a2FnZUQzTHZBMWxaWkExbDg0ZUgr?=
 =?utf-8?B?NExaRElDeXI1MHlUekxEZjhqZW1tNnZVYm9qbGt5OTJ5VE1yRURTRUorZkh1?=
 =?utf-8?B?UGJobTFYdGt5WUNmSk9xSW9iSHU4eFlObHdlYkk0QTJHVkV6K1IvQXB1NXZr?=
 =?utf-8?B?K29ocTJya0ZyUUlGYjdnUmFVdXRxTVNhOEtqbjZHQXRsM2pJeGkrZDdKOVZv?=
 =?utf-8?B?V2piNENGck42OUxHeUpFVEV5OHdQZ21WRDRyWEJEV3BBYnpwcWVxL1dqUVAy?=
 =?utf-8?B?SmxSZXkzZlRLMTd6alVwakdaWFBiSStFbVA1QjJJNVlNcllYWnBHWmlHR2tp?=
 =?utf-8?B?Mk91WkFYazRGMFg0WFZJRkZNd01yV1YwUlcwR3prQ2RyZkMxT1ZwWmVDMlZH?=
 =?utf-8?B?R3Vxa3hsT01NRllSV3laa2tMYmtuSjUwRlRXTXZUcEpMTVFnZGJmSXVYamJU?=
 =?utf-8?B?V0xEYUZDK1BGbUlvOXR3b1dvOWdEYjlWZlFPUEMybWNldXF3blNKYStrR0cv?=
 =?utf-8?B?M0VJQnY4R0UxOUtQSkp2TkUrYVBKT2NZSEJSbHk5N0ZobTVaVVZwaDBSWjdp?=
 =?utf-8?B?WUFmZFdSUlFQd2UvSWYwcHcwWG1aYzZhMFdpYytYODlxaWVmUXdYNkJZR2tO?=
 =?utf-8?B?WWRrZzRUdWpXS3JraVRrZlJiQlBrK3ZNRlNSQVNaTnVXb2RJZjVuYmJHQTVz?=
 =?utf-8?B?S2xVV0dtdnV1NmkwbDFIS0hnQzhPRGx0dnp4aXRWeWhsMnBmdVI3VGhJVE1P?=
 =?utf-8?B?TWVaYmgzcnJXNHpMOHpNRGRRZDVyVXpTbUM3MzVyWnJ4Slg3ZDBCZnV1S0c3?=
 =?utf-8?B?MzROSXRVU2R0ZVVtRUIycVptckhjcUwxdDZ0WnlVeUNVWEVIcEhOem9CYy9V?=
 =?utf-8?B?b0NCT3VtOUtORTdOTXdzZnpYWlhnU2FsakRKRnhFVXo4aGN6TmoxZFU0U2hW?=
 =?utf-8?B?NDRZMFRDc2Nhang0eFVyakNaYlFLUzNyTlROZlB6MDJ2b0JEcE0wZmNrbkRt?=
 =?utf-8?B?ZnJzWG9waUJNY2Q1bUp3L0FqUk1oSlhDbTNlcnorR1FjbUJwMldKa0FpWXZD?=
 =?utf-8?B?SGJSVklnbm8wNWs2eUpiNUdQbDNlOTF3TUJnZUtLa2N3MGtTUFdXL0xKd1lh?=
 =?utf-8?B?czhJSDRkY1QxSlZqYzY3NndKc0Q0R3BIODZ2cHZWcWxSTjEyN010Y0ZZeFY4?=
 =?utf-8?B?UG96cURodnNDeTVqaTRPL0RsUE4yL2VjL0N2UWgyZlc4SWJFSm9sQlVWWkI0?=
 =?utf-8?B?TFNsS0NOK2ZYUWNRQ0hJcE1jR3drSkh3WEZjY2M2c2xpb04rRm00OXVTS1Fn?=
 =?utf-8?B?azVKK1RCSkpxdHZNdXdDZUtyR0padi95aktucC9pekEyeHhsY3pRcHpMV2tm?=
 =?utf-8?B?M2x4TGI2b2I4ckZHcHR1Q0RIKytYelo0TkQzNy9PdHhLY3dhNzhhNjF2azNH?=
 =?utf-8?B?Vm9TcVlYQUViM3E1SHV5YXY3dHBDWjJ2K3JIbWpxVHBPY3RvaVpudzZaNGIr?=
 =?utf-8?B?L3FUZWNOVm9CSWpFODFQbm9QSjdMTEZWMXFuQ25NMEJ6SkFrZExNRnB0M2w4?=
 =?utf-8?B?REdJNzV6QU1nWkZ3eG5Rb3dQS3BTd01UWFJPWUVJOXlmemxGRDhTcDRTaHhr?=
 =?utf-8?B?REdmTUEvbUdsYk85QmZ3b3FxdU9VY1VkOS9sOGx0RW5oOGNEYm45d0JPTThB?=
 =?utf-8?B?VGp6SU5wU3BDck9wYlloc2s4cnZqYUtkbFpMd0N1bm1YbkZuUTZLOVBhRmpM?=
 =?utf-8?B?cUxIcjB4SkdmbkxnOTJvRjBuR2pKd3R3OHo2Z2FxUm9PM3RRSi93RnV2M1VR?=
 =?utf-8?B?cGxrZDV2cjNvRUc1d1F2Q2ZNR1BFWURwdUVsN1g4OGdnNnZ4ZUJaNnY5NG5B?=
 =?utf-8?B?RFRNaS9uVXYrZDVWMlEvb0piSm9OYWJSenlLTFE1NzZqR0g4VmhXdDkrNWVh?=
 =?utf-8?B?ak1VQWlQWnl1Q1BaZmc1bHdUTDBPdDJldHU3UlBzVExRVFNPMU1KMkpZSjJl?=
 =?utf-8?B?czVPdnJmWXl4NkVzbVpVSStGYkZQdi81b2ZMbGlJN2ZBeHpOeGFmVytHVTMz?=
 =?utf-8?B?UnIzaWNZNFpRbmRQVkRaWTl0eXpJMlBXdm43dUxNdS9mNlpySUZ0Nk5vZ0Q2?=
 =?utf-8?Q?uhgVoFa88ZOuHKVQ9JJRL7TN7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67eda06-a3c8-4c59-2b34-08dd20a1d13d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:55:53.0423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehHd9wwWktiDdsu2ZRuy/31nubm68LMHqaLTuEody7rA+1EGR8zstApGxBKzkIOAmF1KCWdHI6nyqPBS4Fbj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981
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

This patch adds the macro SCMI_MSG for protocols that do not need
_in_array.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_agent.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/scmi_agent.h b/include/scmi_agent.h
index 755986d6c424ccc881ac0943a88735cbcfacb001..5508a126a6dc504afa6d896c78c760b1af0d3deb 100644
--- a/include/scmi_agent.h
+++ b/include/scmi_agent.h
@@ -54,6 +54,17 @@ struct scmi_msg {
 		.out_msg_sz = sizeof(_out_array),	\
 	}
 
+/* Helper macro to match a message on output array references */
+#define SCMI_MSG(_protocol, _message, _out_array)	\
+	(struct scmi_msg){				\
+		.protocol_id = (_protocol),		\
+		.message_id = (_message),		\
+		.in_msg = (uint8_t *)NULL,		\
+		.in_msg_sz = 0,				\
+		.out_msg = (uint8_t *)&(_out_array),	\
+		.out_msg_sz = sizeof(_out_array),	\
+	}
+
 /**
  * devm_scmi_of_get_channel() - Get SCMI channel handle from SCMI agent DT node
  *

-- 
2.34.1

