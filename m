Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B02DCDD562
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE66B89050;
	Thu, 19 Sep 2024 02:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ExCMtIPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FF678904E; Thu, 19 Sep 2024 02:14:49 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AB68904B
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMo8MZcD6mbr2CMKkiP9M/Riz9RCFM5KOfAYDCwTMkeDRrnPDfF+MS0X6IaVOIgUPKgWNPJFLLP87ipdDZNFmy5zMXQzhqmb86bc6kaTOD0YsPU+51vDQExzC39EAbnPpoYnTHs0GAtyWOnMC/iRubYtcgFWYYx0kV0iIkeqocH3Id335m9k0Arpg19sG8U7D++e95hrHdw44pL2K3WjHMotJQSRbJS3U/X1QYRkALKHGwjNxv//wZSVDFe7ng+MnnSTX6TznIV92hM1WVZQtFLn9au+Lsz50ZhjbuiSGMq2mVY4bfrC50wjwsJ7xkaRgHlssh7Ry409bZoQjIHkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7FWtX54fZCC6tTc51wiX8ExN/lZaOA202QS0eNNKOY=;
 b=iw0LlQ8ktHFBWgjZiLNFHLRQ/51xrvFsnA3WMjZYuMFM6d6taimC4GQynA8EKG0EzuTB8M9BCgYq4gOtscsVksA9GscxFjoX6v2Gbo+rJDNorDgEPqW9JLAIDLXbl8TqX/sbI3/t/kGr3Ca3GZyZKj+w9hOfubSXl8IZxMkY4SphAvkZYr3y8I1h7+L8cjuDxj56GPzOkVrdjuxyGgaH7Bn2cjoHWqkvQHqOWPVV4ptD+1JoqDsMAqSD5zqCBURAGfbTjgZbk83tS/EkLYh8T71sJMsO9ZLjlWQkmZ32LfMCxuXBRFt40XkVWXKkgSxr464j+Yx3nMT7LTQuDIoP4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7FWtX54fZCC6tTc51wiX8ExN/lZaOA202QS0eNNKOY=;
 b=ExCMtIPTiL4W/XdZp+OcGj41Hht/LkvKrEy/lLqR1NRHNvx2QgwjWGvw7XEFYGOGpo1lclzs+XCsjxl7EyE9jhkL9FKgfT6YaFUxBCcPVHrRzRzDVlIR6+Q3GvbEJgD3gdHF5Gw7rRqK3YcbfySecLyYBVxHwYP9PUKzdys1RRcUy52aIXd336nUQo74QqixY+/460tq/OsFWEo5o+IbeYSi4s8dqlgQOVZUFel/sN63Xqtf9SJoVdDBHxRV67U2QQJg6bWiPden6TRYj7a/79wPO2Br16DzDK0VdoU4rYZ64yPiEC6XiwhG+mU2wJ4xxCEqMCpjz8/hPP86zXN0Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:01 +0800
Subject: [PATCH v2 02/21] imx9: soc: Configure TRDC for M33 TCM access
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-2-0d798d9e08ad@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d50aa4-e66f-4e84-ce4a-08dcd8401127
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0tyVlMxRVRGdmhMaWlQYzd5TURXK1l5YWdHVFR5NE84UitSQTVYbUVZbmg3?=
 =?utf-8?B?MVJ6cS9XMHpvSVRUMmhHMlV6RGJjU2o3TkNBZ1dTdEhYVzRIV0pZOHJwbmV4?=
 =?utf-8?B?MzZWSGE4T0QvNnZBd1pUMXBnOGNTYmo5Z3haL3loanhmTDVpK2VLOHd3Slpi?=
 =?utf-8?B?c2FPQUVTbERZRVhXaGtxcTRtZlluem9UZjBSMXVjVmQvZjA3c0JqcVB5SmdI?=
 =?utf-8?B?eWVxRFA3VVBYZ3RDZFluU0tBVHpETnk0U0RDazlmaWhrcERjeGdLTkNDVGpY?=
 =?utf-8?B?elNxNW15SFZaaEROZEsxRkQxZjBJeE5DZGhLOHVSTk9yQk9MVk1FSUdWQjJs?=
 =?utf-8?B?TnlrRHVsT2N2ZEdNUjZwQzA5UHoza0Q4MDFKaHNHN1R4V0FhLzI4N1BFRXRp?=
 =?utf-8?B?WUdQMzBGWlRUNjRXdVlBV2JySU1scnFzTitrVDJDTFRwQ2hnV2d0b2w0TzRl?=
 =?utf-8?B?bXZweHNKNStURXVST3RocUV3c213OWNtNGFrUFQ4T0s2YXVOeTNYZTdYeFpS?=
 =?utf-8?B?MzlFTUxFR0orZ3VOZVJhZUZXL0FUbTFaUVJvQVl5bkNVQVFqSHdMSjl4eTk1?=
 =?utf-8?B?ZTdUWWpKNWhKbkh4U3ZRdWRnSkRyWjJsZG1rWDkzTmNKclU4RmxaRDZKYWZL?=
 =?utf-8?B?bE02SE9KSW53TDRuOE1XODl5NHhwSldvNDRSNEV4YTc0b0c4YlhCYlQySnB2?=
 =?utf-8?B?L0RLR2VyT3U2eGpxRGtFdFBtSndGV3FZZ1JsZ3kzcWFyZU5YOXNReklvOVhF?=
 =?utf-8?B?eVIyNkQrRnR3TkRlVkM4ZUIzTEpnZ1k3Z2dwL2hHaS9Kb0l2Q0x5UnE2RGhn?=
 =?utf-8?B?N1Z2Rm1mSlorQWJVNXdFd1I5ckh0cytmaEJIbkRQOHRCUlkvSXZqRXo1dENC?=
 =?utf-8?B?emt6dGFFN2w4NjE2RmFDb04wdkxtcW9ab0xXTzE1eXByL05kTVdVbC9wNnJx?=
 =?utf-8?B?NXhRQU0xSERtQVFoM2NwRVBqQUNLWE5Ddi9iL2FYdDVWZGc4SHhYZFhHZUQ5?=
 =?utf-8?B?MG8zSGZWMEJEY3hmQlFmNlhWZmdaMHVPQzVlNGtnc1ArU3phdGhTbzBLRXky?=
 =?utf-8?B?MmZwTlBzS0hyRnMzY0U4WS9GZXZQMU92WUpDaG9wN3RJbkxVL3NRbVRnQm1z?=
 =?utf-8?B?a211UDMrZm9uOXhGbXFtclpPNkZPekI0ZGtEYXlJZVRpMXpISWdRK1ZHRHYz?=
 =?utf-8?B?SHlwcnFtRDEvR2pBL1MxaUJJVUNwQ2lZaEVUajJxRWtYZGRmY2JQQTN3VE9D?=
 =?utf-8?B?SmF5REtNUlpjSjc5dzFwNHd6elRSV2RBTWgyYitmL1Vidmh0cjFnVHM5NUFW?=
 =?utf-8?B?VTFLdW5abFhlb1pyankrYnZ3bklPcUY0VXJPaEFWK1E3L2pUSjFFOXRlbDQz?=
 =?utf-8?B?WjdKL080VVBLR0ViSXdEcEs4bGtkS0Q3aHRqVjlIYnNHME1uUkFoYkdmd1Mx?=
 =?utf-8?B?UlQxNm12UVdqbnJvWlNNZFcrdDJ6Z2hpSEZKVXVoYVA2SlZHN2k0cmxMRGxR?=
 =?utf-8?B?VzkyLzN1MHdCY29YMVU3bjQyWXRkMzVvWnBIN29NMG5wQTZ6YVFiM1ZhSnRm?=
 =?utf-8?B?YkVINFAwVHdESGhKRHptZTdiTzhGdk15VExvTm1yYndnMHdMZjVNSitPenNI?=
 =?utf-8?B?YmFBQTNJUVVZTzhDWFFab1RsWDBPMmpZNDcxVm82cUZnU1VVbU1uRGZwczNa?=
 =?utf-8?B?VkRoM3NMNjdPQW9XVWdLOUQrdFIra2ptOVdvN01HeVV4ZVhXb2Z3SlYwMVBw?=
 =?utf-8?B?eGc5bWdva3BTb1dNaVZjYmdSLzZaZVo3Tk5ZNlNTa3JwKzVOTHhtZy9aSDgw?=
 =?utf-8?B?SDJnTERNeCtHeUNyOURSOG5PcW0yUnl3V2dKRXk3TVRuUHdwOXB3QmY3YUJ5?=
 =?utf-8?B?QmJqU3lEcDM4UUJSNUtoYlFMcXd6QTgxWStuelJSa2VHcGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC93enVscFJNK0xRajh1bkR4ZG9PTTczcE1taW9uMThnQzU4cmNmMlZ3aXJv?=
 =?utf-8?B?eFBvV1VZeCs2ZHNVdmd6dC9oa3h1eHhyZ01xQWVZRDQybmM5eTJKWXhZTWxZ?=
 =?utf-8?B?SWdIQjRjb0NNY1RCZmVOSTRxM2hYSDdXMnNNVUNWY3JJb2Z1dTMvZHVaeGE1?=
 =?utf-8?B?V0pMdmtrWkZMc05aYXUxaGtUUWVvMVV4bCt1Z2ptYXczaHNUVUVEK3YwWXVa?=
 =?utf-8?B?eDNZTFp5K1IyTU84bkxwSHNRN1lJU1owU01kaWIwalNYc1FpaEVxZ0diS2xl?=
 =?utf-8?B?UTY5V2RGazZCOGNtSEFNeG1QYVdxNXZaL0hNSXVkc0svSzY3VUxuTlhCcTlo?=
 =?utf-8?B?Umh4QkVkdmwvVTI4NEQybnV2UklGUTkrMnRCVFRyTEkwa1E0dHlReTdPNWVx?=
 =?utf-8?B?UHEwb0syMGpnRFBURVBHc0xPcHRpMHR2ZW9rdEVWYmpNNTdYVTQxYmhBQkJJ?=
 =?utf-8?B?anBOQWhveGY1clVJUGJWbWlLb0lPcW9LV2N2aHZkSC9ZRk1TWjIzMHVjZEFx?=
 =?utf-8?B?UFlnK1EyWnkvbjJvTE1DQlphM0xRR1dhNUdvL1BPWXlsdmRpd1B3WlVzUDBR?=
 =?utf-8?B?WGNIdWZ6QzFwSStuY3plZUxaNVBIck5FQ2JlSm5HZFVwR29Oa2t6U1B5WjBU?=
 =?utf-8?B?Qy9sbXdLV1A4VHB2M1Vkclp6KzIyK3ZHeW1ndXZGdDNYVHkyOUowYjh4SjM3?=
 =?utf-8?B?VjJyd1JJQVI0WEtOMzluYlVPMG16NkVCaHVoMktib01VdEdueHd4c2JldlJi?=
 =?utf-8?B?SGZacm5CMVJObGFRa3lXVzJJcDFoYWVmUHJFUVBwdHB3dkZXZ0JUang5and0?=
 =?utf-8?B?RUcrV2o5bU1ReklRS2RQWXhUbmRPZmJnaVhUMmdzV25NeHpCei9oMTZJR2Vm?=
 =?utf-8?B?TFYrbjhIMmhROFZPcC8ra0tJcTQwK09xN2RyV2E5MEYzcUgvYkt4L2poMVI0?=
 =?utf-8?B?NCtiYW1kaTV2RWo0SEl3Nk1rcG1WMnNjOFIwakxFZnY0c280Yk9NeU1kRGZm?=
 =?utf-8?B?dCtvaHQ5TzRNc0lKeWs0RWtpT1E2bFRCc2s2bUF6SUNIWE9sb09tc0FxVE4x?=
 =?utf-8?B?L0V2TXc0UHhyVHhHTWh2TUdNOG5pZU9oZmVHaExEWG1OUzFZU25lbVd4Qkkz?=
 =?utf-8?B?M2p6c0xpYkJRN2dOQWVUWmFWc0NaVWFOUWk0UnpONERxM2piMXI3dS92YTNU?=
 =?utf-8?B?MGY3NWtOWFdFZkVLUjIxN21mZ21OQk96SkhQZkdVYTJhb293YXFMRm9VZ3BC?=
 =?utf-8?B?ZzJMWHFyaTY3c2x2aVlFK0ZFZmJXNXRFZmR4b2I1ZExHZ083cldkZDVRWS9M?=
 =?utf-8?B?UjlEa0EvNUdza0ZtSzRSYUpDTkJjMXdTRzVBQ1o4RmZrVjNVYWZOK21rUVhU?=
 =?utf-8?B?eUFod3BqNzZoYmRnUHNtTmEreFg2eExoYUYzR1dmcEtqN3VHcHFxUzRLM21I?=
 =?utf-8?B?Y3pMTjAvaEZiN2xRV3NPa2EwQ3RZSXZRUGJjdzk5aUJQVEUrdWFValVmR1V1?=
 =?utf-8?B?dm9Wc1RaTDh3UUs3WVovWUYzQVl2WWJyWTNtS01QZlpNd2ZleUtDc0FOcmZO?=
 =?utf-8?B?NXczU0xVSDFxblo5dnA4ZUVzZktHVHYydFNtQWdmZ0liRlUrY2NQWEJtUjJl?=
 =?utf-8?B?dG4wb01JeUYzZ3FQdDFrd3d5eVFRT3RGQzJOTmZIelpGMlpBMXR0OC9hMUtE?=
 =?utf-8?B?MHRZblFHK1NTQ3NGMGtYQlRURC9FYUdLVUVSQ0oyczgyWGZla2JQbk1iMGoy?=
 =?utf-8?B?OS8xLzNaR3U0Ym42QlBHa1liN05CTUpYYkd4Z1RLYXhHN1pvZzlPQ0t1Y3JV?=
 =?utf-8?B?SXNqUkVnRXRqamY5QmhhYmRzL1JnSDhEcFQ0NFZEOUFWQzFTUHJVM1lxaUlv?=
 =?utf-8?B?T1kvaUdsbkoxR29Qck5sUEo2ZXg0bzcxUnF3ZjVhQWlvdHVoZnorK0tLbGlZ?=
 =?utf-8?B?c1BMcHJEU1N5L3I2T2ViRE5rWFBYeEQ5MzdGVFFWYVQzamx5SkZreTlzcnRG?=
 =?utf-8?B?WXB5SmdBYVpNbFVOdnV2MHUzb3B6WndUcGFVN3BVaWxXbHlodjMySHVyVDJZ?=
 =?utf-8?B?eElHczc4SXBwbDBhdCtpOFRCRTVhRGd4bHpwSWNqSW1xNHBqTG9KYzc2dFZo?=
 =?utf-8?Q?x+CV9GOvHg87hO95NW4K6mNZc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d50aa4-e66f-4e84-ce4a-08dcd8401127
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:45.8256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0gn6aBYm4OAGKYUVBy36eljB/QHm8U4FBa6gTQ2dCc2NJJWsIDB+Tz2qX7jatRsMKT0mP/ZoJUGyWH9mndvCFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

On OSCCA part, M33 TCM is used for ROM PATCH and protected by ELE ROM.
So after release TRDC, we need to configure TRDC for M33 TCM,
otherwise A55 can't access the TCM.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h |  1 +
 arch/arm/mach-imx/imx9/soc.c              | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 9953c33b73b..fb6de533d12 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -25,6 +25,7 @@
 #define ANATOP_BASE_ADDR    0x44480000UL
 
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
+#define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000
 
 #define SRC_IPS_BASE_ADDR	(0x44460000)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 9b6ba5609d2..25b9116f2a6 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -792,7 +792,7 @@ int m33_prepare(void)
 		(struct src_general_regs *)(ulong)SRC_GLOBAL_RBASE;
 	struct blk_ctrl_s_aonmix_regs *s_regs =
 			(struct blk_ctrl_s_aonmix_regs *)BLK_CTRL_S_ANOMIX_BASE_ADDR;
-	u32 val;
+	u32 val, i;
 
 	if (m33_is_rom_kicked())
 		return -EPERM;
@@ -817,6 +817,18 @@ int m33_prepare(void)
 	/* Set ELE LP handshake for M33 reset */
 	setbits_le32(&s_regs->lp_handshake[0], BIT(6));
 
+	/* OSCCA enabled, reconfigure TRDC for TCM access, otherwise ECC init will raise error */
+	val = readl(BLK_CTRL_NS_ANOMIX_BASE_ADDR + 0x28);
+	if (val & BIT(0)) {
+		trdc_mbc_set_control(0x44270000, 1, 0, 0x6600);
+
+		for (i = 0; i < 32; i++)
+			trdc_mbc_blk_config(0x44270000, 1, 3, 0, i, true, 0);
+
+		for (i = 0; i < 32; i++)
+			trdc_mbc_blk_config(0x44270000, 1, 3, 1, i, true, 0);
+	}
+
 	/* Clear M33 TCM for ECC */
 	memset((void *)(ulong)0x201e0000, 0, 0x40000);
 

-- 
2.35.3

