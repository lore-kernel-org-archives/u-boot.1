Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACC0E7719A
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C738069D;
	Thu,  9 Jan 2025 03:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lG0bcHLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0780E8061B; Thu,  9 Jan 2025 03:23:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5794800D0
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MekYQPMy5LYEOCBkTRnrlzaRQcybFQOslLotEosrbvMvTjkhI+6lKVRJ1cz5GjEp0LQ4RYGdNC3d/ec5CYIGocvc/iOaWT6YcuvS6Pb5cxfJ7MqebMqWeVBwrc7TR5uxE9Py1kbOw7cduqoUwTazEElKcDzdqPrYg5ifxEYXXuyQCPa2uP/ytojzqbrQzIGtcj2Y2o+n2R3tT8tH/Y24efmkemwhAXZvhPF2aXjVgNKn4nNmwj+CQqsLZBALsCKQ9+7DC8SVCNRMb3RCr8rSoD7p5HHitFE4mcmYI9MeCqCc1WphhUdOHfZ+6A3eYH7bfogXzEvYvW9U5+1gXfGUNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yhC/dNX+0FmZ3LNXyiOBPVeIQm1JcxVfHq/g1pNmV4=;
 b=HV6t4OjHakpnPq+F/PZLhmaVaFnJaow+i7ajsXTY6aYlm480x8x2TGxzJlzlI4U1FwP6hdBEYF09jnSMm6zWLtLrvcHk5n2kwAhMMQ5/aRhQnk+TvcE23jd8ZtqVmIXvMUYdKsECj/iBIFquwFnUB6Tn21xoHSXfyrH/B06vh2a1T9rm1XO5srF3avsQxiEKCb5BGsvv88DBUYVcXUTfoJKbCpYN0oqrKOvKxyPvXTJAesyMkzCnFU5c0+aHEvFyF/5qJPv8y84gbTVj9hBOsjvNMth5XH4mLBATC5i55tciwdIVvb3Fva6TmdQ2ZFvWKVVddK2/k3eDl2WYyQwBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yhC/dNX+0FmZ3LNXyiOBPVeIQm1JcxVfHq/g1pNmV4=;
 b=lG0bcHLEyZPFuS2YMYHzqZTA4buK2dCP70YcoLCLOeO0jm0ewBHAA4aPkBk1zznhT48ACT56Mmi3lHosojeGjT13129UYVmy8DUjeDWDK2wOcQoeCuiEWL8BHEyhmtuNpJ+VaYKPp2eqD8hlzb8lXObHuHReoXTfb8tcMtJrIL0HQTXBi04xHmU4ToRJYRmsF9aEMalwG/9NlQqQCt3Hw5FnACyvbtA/3xrNXLjqJZrXyaIkv5hVcSGIKayGfj3s8uPliKRQa2u4ls+YHFuUQ4mwTpFtNY8NrhFiGnGH7YBM5GeRwQe4C0bkmPg+H40xNNE+inQn/q9Vq0L3lUkd8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:19 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:05 +0800
Subject: [PATCH v3 04/17] imx: imx8mp_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-4-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a248c1-de73-4177-0c6a-08dd3054952d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1c3MStpdmZnOE1rdWxwSk9uT0NTOTMrWUZscGdOY1RSTC9ENWF6cFVwdWd2?=
 =?utf-8?B?RUQwMTFEL2NwSXlqSjRZWXVhNS9xcUVQYjltTGx4NGUyeC9ybm1PM2RybzV0?=
 =?utf-8?B?ZnZpdUhwOE9SMSs2WDY4RkNkZXdIbk1zbEFuSFZudkV5S2pPc2dEVEk4WFZY?=
 =?utf-8?B?U25YT3VYcXFNV3VsK2VUcFE5SE9VNW5zMi9XTW1vWktpbnM0R1RIK0tpSWxr?=
 =?utf-8?B?QTZGcFNjWlJMMTdHYThmcWMxUUJwSEpLUEZyN1hWQWphS1pwWUdKb1hsV0g2?=
 =?utf-8?B?M1N0WXlpS2hSU3UyOXF1TllzSE1CYXU4WXhQVjZ3bGdVTWI1c2ltUE01MThF?=
 =?utf-8?B?QVplNFRXd1VEaHk4clRVQzVvcFkxbmNONThDZ1NNaGRMU1ppUVhZcG55S2Nz?=
 =?utf-8?B?T3ZLb05SclROZFhMdUtEcFdwbll1UHNBclhGYzBaY3ZrSkNEQTcza3R1UHRM?=
 =?utf-8?B?ZiticEVLbkVDQUpncmJQL1B3Qm1EbThhd0M3amRzVXhlYTZCcGpFRzNxOXpX?=
 =?utf-8?B?bitKTHd6WlhZV1IweC94d3J1VENKdXQxdFEzZjZ3Zk1oM3I3WjFTVFVDUHJy?=
 =?utf-8?B?b2Naak9pbFdqZ2U1Yit6UkoxK1RWYjNjaU9uUjlQK2I0QmM1aGw5bm9pd0pE?=
 =?utf-8?B?Y1JPakZyVm5ndGI2TmtndEE1QzBmMUdjVWxEeXJyc3FHbHNhV3l5NXpGdlJQ?=
 =?utf-8?B?eU9OeXR0L29VNkpHZ0h2TG1BYnF6V01QWFhyQWc0YXZnSkxpQlpWT3E3bERz?=
 =?utf-8?B?emQ0dE9RVW9LeDMra21TUWFLSDRyYkdNNG5NN3ZtcmwvZVBaL0pJOTZhMVZX?=
 =?utf-8?B?WWNsYXptYVVmYkRQVDBjdWZ3NkE3Sk5LdEF1NnFXaFZPOGdhZ1dLVHkvYTV0?=
 =?utf-8?B?WXdCL3h0VTE4OEVLczhGY2FRVlRsQzdRYjJGS2lnSnBUZWxFNFg4RHcxdVF0?=
 =?utf-8?B?OFhISXpLbEU4OE5sdmVWVnJaSFdPNm1DazkwWnRKMThMNEpXMEppV1kvL1VR?=
 =?utf-8?B?QU9rdzBqY01KZ1pZN2ZQcll2cHNPZGZwWnN3UkMzd2ZoSjUwZGFwZzBkTUw0?=
 =?utf-8?B?N09WbFlpbDl0Z1hnMnFLbVRReDEzUVlmMTkwdkJJQ3VUcEd5c0ZUbUpuU211?=
 =?utf-8?B?enZTeGR4em45YUlkNVU1ZVpPU1pnYU4wSk9SR2NjUzBVc2RVc3JKRWpmTjdZ?=
 =?utf-8?B?WDMrZmZtY3dHMXI5YXc5M283aEFYYkFtNVZNVGVvaGc3cE56T1lUL2pPbzZ4?=
 =?utf-8?B?dmFTUmN2a2pZTytJNi9xanhYOC9jWEJ3dmRvdXlOUWxFclpCMEVIN24ybmly?=
 =?utf-8?B?ZUloSUs4YUV2VzRrdVkrbmVCeHIyaGVmMlcyUUV3bFJsTGI4aWxIZUg3QU1F?=
 =?utf-8?B?KzJ3YTViaU55M1lXcTV5ZXBscDlLcGlINVVVekFVL2NWOTZVZ1d4VXJkbEhW?=
 =?utf-8?B?SjBPZ2xkWW5GbUZaQWVXcnJlQXpDRHZ5MXJ2Y2RsTmJNbVFIcjc4L0xYUW9x?=
 =?utf-8?B?ZWJlMmxpNkFkSUVjTXYrUzdNc1VlT3AyeTFWSWdYbXlybDd5VTI5MUZtRUNs?=
 =?utf-8?B?ME5Oekw3aTB5bFNGbEljczRneFJTekhMOHF3VldKaGYrWjY5eWx2YnRIeEhs?=
 =?utf-8?B?dlpQblNrTHRVNG9HazVGOHorMGxzeDlpU3g4dFh3UzlnQkxMbkprZlZHVTh4?=
 =?utf-8?B?UjNnMUxvSFVuMTN3QnBoNjYraitpWmoxWGNuT1Rpd0ZMaXBiZGY4U09KbHdQ?=
 =?utf-8?B?MzRZb2IySHdLZXlHanRtUnN5ZkFxV2U4bUVsaFM4a1dmOUl2QUhNVzJiMmti?=
 =?utf-8?B?ZEVnb1pwR2E3MzJyVGwxaUsycTh4aFN2RTdRajlKMEx5S2dTNWVBSzR4ay95?=
 =?utf-8?B?THA2WHliMHk1TnM2SE5lMTVLWFRqYVFzeE02eXFoZEZYOTJzcjUwV1Jnbm5T?=
 =?utf-8?Q?LLdz7ugWL36eiOczD48gwJnDl5gyGH39?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFV0QmdBb3ptb0d6eVByZjUydWNyYWQ2bWI4ZlZIM3Njb09JOTlvOU9qN2dn?=
 =?utf-8?B?b052Mmc2enkva2V3WnB4Ujg3L2wyWG1NaGxRN2ozS2M0OFN4VEgzSXR4U0xo?=
 =?utf-8?B?RU1KMHZYMHZSbFNHYTBLVlRyNjRWV09WaWUyeVdDbjB3UXlPb0UxeURDVUw3?=
 =?utf-8?B?L1lhNXc3Z2tsZnJlN00yOHJYOWZlMnVGU3JqMU1XNzY1UTJvTW9UZEUwNldG?=
 =?utf-8?B?UVVnRlQvZUVJbG9mMUhLY0FQVEV1b1RDM0lhUlY1VVZrUHY5VkpBSitzdjB4?=
 =?utf-8?B?YXlSb2tISXBhcXBPTHc1a2dQcGZvRGRlMXNEM3ZudkgyQjlhNG1vYkM1Qlhx?=
 =?utf-8?B?Z2Z3Tlh5WWg4TEZ0NEU0bnpEay9Hd1NsNzZFckpqZFlaYXYreVU1SWM2ZWlr?=
 =?utf-8?B?WjZDR0FDa2owcEd2N1BGYldXZWdQOWloQncvUWxRMkRyTG5TeDA4MThhR0N0?=
 =?utf-8?B?ejhVQlZkRmh0VU5ha1VxR0dmVzZWR2orYXN4QW93R3NNb1pXdC9VY212RFNh?=
 =?utf-8?B?a1IzbFBRWURmV2JyU1RSd1BMdGhjTTZlUkFhMVprb3c0WDlaVGxBZ2FiL2Fr?=
 =?utf-8?B?aFkzekVmWm9EZmVMOEFPellDZUtRRFZ1cmRUOXFyVDNVU05UUXlqME1ic2V4?=
 =?utf-8?B?emVsZ1pmODN4b25HNU1yeG1CMTd6TUxBWDNseEVjdGgzY0ZpdDJON1JleVVQ?=
 =?utf-8?B?eGZabVEvbGxCT2dRSXo3VEJxYXphdURVdGZBeGRWaDVMSS90ZWhpYm16NG1w?=
 =?utf-8?B?a0hRRVdST3Bvclc2aHZJYWhCUFBNY1c1Rmw1RkJMeml3RENMTlg4bytEcUZB?=
 =?utf-8?B?WE53L2xnNzdzL2dlMG40SS9GaS80REFHR1orSXFZOW1ma1g1SHNkRXlFTlNt?=
 =?utf-8?B?dEdDZHB4RWVsMW5hbnhDU21hUWpvTkpYc0lhYWN3YzFOc3lJRHVmSS9KL3BN?=
 =?utf-8?B?ZEt1MEJxSGpSTEpMK0lRUUhCbUFqNUp0UUlkdWdkYlBHcWtGRENWeGZrMzg2?=
 =?utf-8?B?Ukd2Q3dYU1dPeXV1UGJ6VjhxME5LNENoTEpEZ1kyZmxzZkw2VENUVzQ1T1U0?=
 =?utf-8?B?dWxjZGVqVExMSnlVemJIVnFGUjBkUHlQcHR0c2ZSa1QzVmNTYkJhR3JhKzlG?=
 =?utf-8?B?ZUx5THFTaUhuMVp3Um1aQ2w1OFFwV1BpRzlCZmRjK2VHWUVoYTdibk81cWNu?=
 =?utf-8?B?eVc1Mmh1THRDN1V1d1dZOUpzazl2c3FNWS9UU0kvWTY1Q0xJUkh1M05VTVZz?=
 =?utf-8?B?TDcwL1NiQldZbzFDbFFNdXBqQTkweWhTNHFKRWZ0S09LdG5nZ01zaXVDNVR6?=
 =?utf-8?B?U2RVKys4cEw3aVZTdjV1WnFQRk82RnNiL2xIYlp0RXdjSVRXa3c3ZTVtaHN1?=
 =?utf-8?B?dUVJbGlVTmRrQjh4a05JcHVrOUtJajVWLzk3ZURwZmVMekl4a1AybGJhQXM0?=
 =?utf-8?B?YUxwTHhTTHQrZ1QzbjdibTd1UXhQd2RoVHhTVmhPNXo2bVVWVXJwRmo3T2JG?=
 =?utf-8?B?Zkx0RW9UNU1SZWQ2U3ZNZUhlUStXSldNT0sxd0ZlM3lONlNLNnNNYTFraGoy?=
 =?utf-8?B?UE40YStxYnQ4L3phc29zQ3RZTThXeVl0MkppZWdIbHhhak1rZEpMYms0L2lJ?=
 =?utf-8?B?T1FFcGVKZ1NWVlg5a1J6VUZBVnRGVTVhWmR6d3UzNEppYTViMWREUThDZUFE?=
 =?utf-8?B?czFIdFdWTTJoSTBlZnJXQ0JuOFpPbnhadnFGUnRacldxb3hQOEg5SldHOGcz?=
 =?utf-8?B?VC9yQTRxUXJQd3UzeVp1aGxMbWNseG9wMkl2bE90dnJyRWJyNDJZbnlSOUxw?=
 =?utf-8?B?QjdIeE0zeTFVdHFXRDA0ODBUWlJHcnRFdFVvMGJkdnhxVzU2RHF2dFpnWVAv?=
 =?utf-8?B?M0lFWUlLT0JWRy92dFBOK05ZYjUvWlovblJlS0VxWElMTzJHdnl1TG5ieE0z?=
 =?utf-8?B?R0MrR2tyZXo1ZFFzR1ptNWdUUEE3RnpvdGhyK1ozc1hxcEVkOVphREZmaDIr?=
 =?utf-8?B?NkV4c3I0UEYweWdrclVFbkZRd1plY2NFc3NKbmNmSCtmMU1hTFZzeWFWbjB5?=
 =?utf-8?B?RzRadHVqSmFwWGxJNHRkQ1JQNWdQOE9IR0JGb1E5Y2hXMnZOL2RCZG5FaHpo?=
 =?utf-8?Q?sjRaLIagd/xPrIb3fPRQrYrxl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a248c1-de73-4177-0c6a-08dd3054952d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:19.5727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zscQO37hvlMs1I/nguHiMKrkjTTFadLmnLpGb/9BBEYdC/QnWU8LazTWdzy1bVBHwMTRowUsw408MaxJmaZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

Enable dynamic settings to mmcdev and mmcroot for i.MX8MP-EVK

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/common/Makefile         | 2 +-
 board/freescale/imx8mp_evk/imx8mp_evk.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index c2c86c0dd08252e8feef5d2f2f5176af408020ac..468a06725c1e470d0d36f79e8a25e31799562e9b 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_POWER_PFUZE100)	+= pfuze.o
 endif
 obj-$(CONFIG_DM_PMIC_PFUZE100)	+= pfuze.o
 obj-$(CONFIG_POWER_MC34VR500)	+= mc34vr500.o
-ifneq (,$(filter $(SOC), imx8ulp imx9))
+ifneq (,$(filter $(SOC), imx8m imx8ulp imx9))
 obj-y				+= mmc.o
 endif
 
diff --git a/board/freescale/imx8mp_evk/imx8mp_evk.c b/board/freescale/imx8mp_evk/imx8mp_evk.c
index 024b46ef8bc28bd8f6085cc9cc290b719b37fd66..2ff067bc6752135f323398e620e37ef11d1b91bb 100644
--- a/board/freescale/imx8mp_evk/imx8mp_evk.c
+++ b/board/freescale/imx8mp_evk/imx8mp_evk.c
@@ -3,6 +3,7 @@
  * Copyright 2019 NXP
  */
 
+#include <asm/arch/sys_proto.h>
 #include <env.h>
 
 int board_init(void)
@@ -12,6 +13,10 @@ int board_init(void)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "EVK");
 	env_set("board_rev", "iMX8MP");

-- 
2.35.3

