Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1ACDD561
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA6589046;
	Thu, 19 Sep 2024 02:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="u4id0fM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C92298904E; Thu, 19 Sep 2024 02:15:00 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EC38905A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FB8taYQMyftFdtqt+gFubc6S5hG8M8M5GIpZpYhmjF5cD1cAgXhdbfOQm26UFyfyggo9e36y2EM/UK8v06teNl+aCJI5nkbeEa11q5rzZxIwI2yLI4EqWZIfylG53OXj+UOBf3dmqVobN9x6WY9xfQXmy6AuBk1ue+apb7f04h1Zd7wybMfJYcJvf8vS3QIU86VU86iWefus37N7lYnPCoi3Z7PHyYHMJS6nOrQGE05xHMFEg5ouYHpCj2mIoYYSw2Vang2IF0n/4OYCcI/BamXllODthaNP7owQ7c2b5tIqERwd/u7XOFLn4j9WzXahpK2BtjEEBE/LH81fVfEm5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAWYs8/lFBucj+HqKf8yBv+NKBLz0G+vMm2i1lNDAAE=;
 b=BLgYYRlgTgaxjjGIlRssvKMBCqz4pns1aWPKLvHiofy0k59QqP8O9X0LV3GDgYikoDLuBFQAPSSRBYtwFPr8kybmJ9ch79D6XwVWabaYlc4CRH3866HGIvzr6yoV9scwjT3KLbmTqvd9FmpzUmQLMO79J52zGE3thWGTKpU3LigVUweUG1R9RM0QF1p7ShEvIDc1DuY0mPpUZIvNV5WDcfz9Ygo1IsNI+venTDnZqBcZe3wlGXNZlwagqs3oEOxdodgQ8OGUdFGKsqmnnrxqbfplylY8aYxJ/MKvlJugi/q2wwWeL9OoPRuCmQS1ASETpaGZMtOs0R944Gii/No+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAWYs8/lFBucj+HqKf8yBv+NKBLz0G+vMm2i1lNDAAE=;
 b=u4id0fM2HauvYzEEROfoQNggwPfVqcFgfjO8PE4kRDynTGv8dMpJHgMy26XIXYp8BALGPFu8WP5OGZdxkMc66FxFqpeYEqlzbroOs+dr40k0NRyz2H8784EVhqnx7cx4EJTYfV9o/8WtDzbaqcxAEzKCydN2Rl0dEpSOlvCu0dqMFvze+o1bR2NSKwVwqN3wzJeRAYMnmemyEOaKIYYg2aoVuEpVqmLZfGJISRpXE93sT20BXkGrKe7fXM1bv03rVTkZ090liRjDO6D5zHes6yv++HDzp0cxdz/Vo1XFW0GHse8fOh0o10O+IyRcJn0ojQCeFobzCyVUkR36YGKNeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:06 +0800
Subject: [PATCH v2 07/21] imx9: soc: Print ELE information
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-7-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e10d3f-3706-4db7-f63a-08dcd84017d6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2wwSlFROGhQNS9QWVB6ZDVEK1V1TWl2d05wRzNBaWFtSm1ra2U5c0pybFdZ?=
 =?utf-8?B?aDlXb1ZZM3BsL2xWakhuR1RHRmY1cGlFcXMzV3dSU3hjQ3FtdStVcDNocXp5?=
 =?utf-8?B?MlEvdnZiYk11c09uVVkvOTlqbmxlMXJHNW9scnBnOE5LSUFPT0N0MDZqMVVr?=
 =?utf-8?B?bFRXQzZJbkYvOXRLT1FFdzVMclJZZWZ3ejA5SlNCWjAxb0RQZEdFRC9TeGs0?=
 =?utf-8?B?WU1aRVhPNXhGTHJwbDVFaDkrU1huRi9HaFhaQXlkeWVFZTZ2UmFySHN0V0pn?=
 =?utf-8?B?WlBpV1FaU2lXaDdJSlByTDFyNzEwRVE4ZDNrbHBuaC9iTFBCc1BTTHF3MGds?=
 =?utf-8?B?Mkd2emsrbE9WRXArdzVDMlN0NFNqOHltRWN5MnhuZE5VeTcxL0Yza2Y4ZzZW?=
 =?utf-8?B?WEEwcmR5QVRzTkk5ODNzcXYvYnFkY3BId1ozcFFRaS9mQ0hjaTRMKzlVcTA0?=
 =?utf-8?B?LzdzYnNaSjZ3YlBZemk4TmZXUkhTb2JndWZNVy9TSlFwOTJpS3MyK1VUWElH?=
 =?utf-8?B?MkY5Wlh4RkwybHNlSG9jaUx6NHpNWDF3K0d3QkZRSThENW5JelAxVS9IZUps?=
 =?utf-8?B?b211VGlrOHBHczUrSWwzWXFyN2Z4eUtrM1lOV2pTQVZJTGdXci9vZGdmUm9y?=
 =?utf-8?B?TnlzTURLbDdSOTFadjhQb0MwZXhFWlZpTjlUVk9ub2I2ZkNVS2kxdHhYNnlP?=
 =?utf-8?B?VjlZYU4zMDJIUE5KQXFVTzVwcWMxL2djUFowZWYrNldDWXhXckdkWUtVbFVn?=
 =?utf-8?B?dWNIeDRncVdYdDVJa0trNTdlMjdxc2ZvcHd5ZGdSZmRrdGN3V1diUHlxZmFn?=
 =?utf-8?B?eW9JMDJEWHMvM29LZFVXU2VwY3EvYTg5Yzg1Z1lFSmtvQ2gvbHlRZTY1Q0Rr?=
 =?utf-8?B?NWRxYzhsWEpyeXplWjViSkZabkIraXRIRWpkck5TcHgyQ3VqdnRrVTVlZGdh?=
 =?utf-8?B?ZjZZa2UzSFZPcGVmNTlxeTRDVFBoWXpBM0c3WkpDNWpoTVZmQldzT1YwUDdI?=
 =?utf-8?B?WEdvYnBLR3FKa3Q2VnQweUJ0TmpHMEVMVjF1QWxpVkdsRy85d0hNUTliL0ht?=
 =?utf-8?B?SWJzcGFDYlNKc3Q2d1FUaXNkRmNvOHp6WDFIMFRZSU82cjkzVGdZT1IrVzhi?=
 =?utf-8?B?Z0tURm5yMGx6RjFaSFg1YUluWVUxb21xbENya1ZnWEFWOUpDdkZpYlVyNVpE?=
 =?utf-8?B?eC9yNXI1Q1VVY3lkL1c3MEJ3RWlBQWhiYy9hSzRUNUVQSmt0OHNTSUFhei9o?=
 =?utf-8?B?K0xTRXZ0bzMvL043V1QyN1lzR2VFWjhoaWV6R2JLU09ZN0w0bldRVjhYYmVC?=
 =?utf-8?B?UHZURzZhUkFJVE9FUkppeEhKelAzVW9pbWxkT3NNNmtnekNJSWM4R0lxSWxH?=
 =?utf-8?B?TmQ4NjlyT24xdUpNZUk1K0VreEZRb0hsNTIyUTBmcFF4VUp4L1FPOVBZcGg0?=
 =?utf-8?B?YlF5V0R1WC9oV2s3cW11YzJvSzVPVGhDOStUUW5RUEFJbG5pd1phVXpYZVli?=
 =?utf-8?B?WFJ2MVd5b3JhRFNQcXpPRklrQUsyUGNVVmt2SWVpNkFtbXdBNVRxVE9ha0Fu?=
 =?utf-8?B?dklRNEJCK09LeGI1TzJYWmFXM0daQ2IwQ3VIOGVnNFloNFR1S0Ntb0JIVXRJ?=
 =?utf-8?B?Sm00NHNNTFAzZ01xZ3o5NXpocndSWXNoMkxyeExYL3MvVktSN002amcydzln?=
 =?utf-8?B?NDc4d1dlV1VEOWtLSTZBenZKenpLdVJEVXVNM1Z0VzJoRCtMcEUydjRBVHhk?=
 =?utf-8?B?KzNsNjNoSC9ZQzNRMzB0YzNzU2I4WUFzbGtEUTJMSFFQOUtZdll1MjFPQkpo?=
 =?utf-8?B?MGFIWDlQSDJDemt4S05rMGFDOFkwbFpUUElpQTBuTUpqK2xHbUFTaXEzWjlE?=
 =?utf-8?B?VG5yVlgwb0taRThGWVhDTWJnSGlvbmZBR0ZJT3ZVNkFYd3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTNaNVZRRFdjK1BvQlFCelZMbkpmT29GZkJyVTZhQm5vT2hMNnpFZVRNR3N1?=
 =?utf-8?B?YTd2aEhLbTBjaTFxM2ZJeUx6TldHNEEwME85Yk5PV3VheW5jSC9NT2w2YXht?=
 =?utf-8?B?elFWc0QvQnhPM2RCT21YendXUHJWU2hudWpCWDNlblJjdE9jVDA1cVhDMXB2?=
 =?utf-8?B?ZS9LZUJrYUZXWG9DczhDR2pTVUxwREZ1WGppTWlRb2tMeS82TmVLSFZWbEx6?=
 =?utf-8?B?Vzg2QXpEKzlrQ2NZM0M3MmJLK291YkpxYVlRV3JuZDVCbXY3SnlOcmNmM2xW?=
 =?utf-8?B?NTNVcitvMUhsZXljMWRwL1gyRXRtSEZKdCs0bm9FLzRvaktFb3pqTE1HbzVl?=
 =?utf-8?B?NTIvL3MxMW0yTm9hYWVRREFJZ21ISEloK1M3OVB3T3RIREJOQllrQk5jRmYr?=
 =?utf-8?B?M1ZKTkhtcWs0TkVPVnlqeHRvRmxuQW1zbyt3cEV6UVlZODBLM2lGSkhGNGJ3?=
 =?utf-8?B?SnppLzZNR0l5NklNb3VmdXF2ckZEUEVpSjdKRktOd3VjcTEzK0pyN2duRkR6?=
 =?utf-8?B?Y2dKeFdQQWRMOEc1TVM4MWx3dk16TUM1NEhkS3l3eEltQnJmekZTZU5RZURE?=
 =?utf-8?B?VWp4UkhVTmhiODJ5eFAwcE5qM1dPem5sVUljR1hObzZwZmF4WkhxSW1hUWlS?=
 =?utf-8?B?SXIyRnlSeEJhQmVTR0ZhbzZiTjBpVWNsemhQbmpUVm8rWFVnV1I4cSt5MEh6?=
 =?utf-8?B?Sk5wcUZ0YTIwTWo3WWplRkdpT3VJbWpvdkdHK21GYlpNR0ZUYTF0eWJxZFp0?=
 =?utf-8?B?Q0hvMVdkakQ3aGZ5c3RwLzRsQndpUzVsVHJQWjhxTkNVbTBoWW43TGNLbURM?=
 =?utf-8?B?SkxMcGRhQ3B6Wi9yS0xrTkFJWWhUNGw2VmRET01hSDQ1L3N1S2lwZHhVaFRB?=
 =?utf-8?B?YlBHS3NkMXpPc2RyU0cxaEUxbW4yYWRnVjBBcmFKNG1yaFVyejBMUDFJd0Vp?=
 =?utf-8?B?WE9tY0dvRjZQNWVjbUZaVGRrL2hsOTg1d0xqQWF3YlFjbzFaYkZvcnNYZmNZ?=
 =?utf-8?B?RHRWSGZjL3VncS9lQUJDMVNuaGNMbXpUV3Q2NnA4NGRmWnkxQ3VtZmdVOTM0?=
 =?utf-8?B?Y1RKZVJGOVBWUnFKUHpWR1lCbWJYVFNSaDJ6dWdMTk9Da1p6SGtCN1p3eE4v?=
 =?utf-8?B?QVJvck95SHAyNFBaeHE3RWliYnVTRGhlcVh4b1M3dmpuZFdaYm1SOSs1MnFQ?=
 =?utf-8?B?b1cxL3I4VTlRMmFmWW1hYnhBSk1rN2ZzZG90TTEzSTErVTZnODNZU0wwcDNa?=
 =?utf-8?B?QXBYVWloZVREMWgzWThrTXBDc3Q4bXZMaDNJVE0zUENhVVRwUSttUEg5Qkd4?=
 =?utf-8?B?OFg1K2Jtd1ZwMmZxVEt0T2I4Yk1MQ2FrL3dpeTdZSzN1aXpocjZJeWU5RjhR?=
 =?utf-8?B?b3lVSkpjZEtkVDlBNGt0ajBaekQ0MGRhUlQrdDJXQmcwcVV6T1Z0MHJMTlg4?=
 =?utf-8?B?bE55WWhsVVhpUEU2S0pxMzBsWGlrWC9UQlltU3MvUThvUVdaRFpLck13dVB4?=
 =?utf-8?B?amU5VVUxWVFieVlJM2M0YjI4czBXbmFUQWNrUzd0TFA1Q1ZBN1ovM2xNQ0VL?=
 =?utf-8?B?RjB4eEVFT1FCN1ZCT0h4NThUWEYzOWZSTUpYdzl0ekhoM2ticUY0Wmt0aHhq?=
 =?utf-8?B?aWpZdy9WRGtwYmpiY2l1Z3FPRFplSjc0UVM3UkR6UzZhOHV0TXd1cDZMRnRr?=
 =?utf-8?B?OEF0dHEzN2xtU3BwYmNnQkFoUU5nSmQ0ZE1UcVF4SWlvdXBZblIwZE1SYzEr?=
 =?utf-8?B?YWNxNDlDYW5KalhvKzVwMXpFcTc3VXE5R21lMHJndXA0enBzdGZkNVBOUFJ3?=
 =?utf-8?B?dEFsZE1ITnpHVFc1UnZLZUdaeFdjUjE3eklPeDhpcGdmRkhpa1MvQ2RDaGlj?=
 =?utf-8?B?SzNuY2FvY0dUZlJXYml4RVZBYWdZQi90bjJCcFI3azF1dlV6VVhsRnVaWkxD?=
 =?utf-8?B?K1ZxWmtLbmFzMG5KZjdxN0xlaUdIV2c4LzExTDg0QldQUklEMVJ2UU1UQ2pT?=
 =?utf-8?B?MGdyQ1dTckJKeFNBWVJKNEVpV2tYWXJBT1IwQVpEUTk3L0J5K2dFMHhDdTFa?=
 =?utf-8?B?VnJzK1ZKQm1BV3d4YUt1UEd2R01odTg1NFFlVC9uSkp5b01BMXd5b1U2aVdB?=
 =?utf-8?Q?ths3rxKBkqgwx2jnc31PgLrfT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e10d3f-3706-4db7-f63a-08dcd84017d6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:57.0001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0+OIR5blRVSo3DTX9K8ROCOzHviVYwBhlpAs7wLRH8933oDERsEl07EAFZucMOSaTOVXFZbbl8BARN4b5V+tA==
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

From: Peng Fan <peng.fan@nxp.com>

The boot image includes Edgelock Enclave(ELE) Firmware. Print the
information out to let user know which version firmware is being used.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 7bc896b74da..0b791568170 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -582,6 +582,39 @@ static int fixup_thermal_trips(void *blob, const char *name)
 	return 0;
 }
 
+void build_info(void)
+{
+	u32 fw_version, sha1, res, status;
+	int ret;
+
+	printf("\nBuildInfo:\n");
+
+	ret = ele_get_fw_status(&status, &res);
+	if (ret) {
+		printf("  - ELE firmware status failed %d, 0x%x\n", ret, res);
+	} else if ((status & 0xff) == 1) {
+		ret = ele_get_fw_version(&fw_version, &sha1, &res);
+		if (ret) {
+			printf("  - ELE firmware version failed %d, 0x%x\n", ret, res);
+		} else {
+			printf("  - ELE firmware version %u.%u.%u-%x",
+			       (fw_version & (0x00ff0000)) >> 16,
+			       (fw_version & (0x0000fff0)) >> 4,
+			       (fw_version & (0x0000000f)), sha1);
+			((fw_version & (0x80000000)) >> 31) == 1 ? puts("-dirty\n") : puts("\n");
+		}
+	} else {
+		printf("  - ELE firmware not included\n");
+	}
+	puts("\n");
+}
+
+int arch_misc_init(void)
+{
+	build_info();
+	return 0;
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	if (fixup_thermal_trips(blob, "cpu-thermal"))

-- 
2.35.3

