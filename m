Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D60E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 01:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE5AC80087;
	Sun, 15 Dec 2024 02:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S1TKTkGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57AAA8008A; Sun, 15 Dec 2024 02:05:57 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1031B8006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 02:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8XPI0A8lUUEQli0td1t7lJTUlbOZ9GRxrNmd14WIBLPJca+/ooBcrVv6pzl6H+mJd925GA+E9nIe8mC0dR9LioV1eP3JdCaXk7Mmg2fxwwh7SWIBPQ7mVbkv/zU1mveHvsUoTtbrUhbQGwgPYku8GwHzXl6MG9tKUZAuxjyaukG5rUHH5sL+WNktG/S42s1WhIF+eOr4wUfUmfWSpeeaHNZJh2npNNNfjs6chN16/1OhtCb6M8Jbs0nDm5hRv/5TxXEfX7kYhiRjyuPaTTi6g7r0DTRxi9GuUVcd2IIVcyWLK3uzg+YbTjNoZztptI/sz8Z4KD/Fpbf/YFq+j5L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhNinng9TNX3YUd5sip3xyIrIJU30biV7x62R6C15MA=;
 b=uMxbuYHC8yI2r4ACtVi717b7S03mh/lw18yWDlbGHHSK0gcehplPUsmykxZ9/74Ma7U1CGYF/8Q9nN/Q4hyYR2tn0p+NdL74cIfeGrm1AGlzkmjEsSZnso+XsdZy8bm5DTgUUGfckwtuR5yRVUkBHxEOSSaN4eYuzN4V2BxSezMWnumvWyF/Q1AfIZfeLthZD3q3l0rAKnaHSx6t5gUoEjiJK1yQXRv/g10GaWdKpU4PQlkVpHEvOpTl7aDQLnTD7CDLGRUKJi8K23vgx0SMo8L+6YgnvI/vMTZfJNwF1iErUDmhLoy5yKq3W6okPLp+cG3MPENwxnI3UFCV95s1Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhNinng9TNX3YUd5sip3xyIrIJU30biV7x62R6C15MA=;
 b=S1TKTkGDG2IpbEmUP7rR33mV+2lBkIr+5pIMwsa/6PCmy9NZd9+uX8NR5fEbnurddH9ntO1KLJYhKMMtyuxFUhqr0IbwLPhTzbh+lZaMULQjb+Yxs9F7U3PAwNYcvDlm+KwtuV69rTu7FRL01BCjIt7v7J3zy/frJc9LluGPMcnq9IvoXN8UHe+FsnUdCzwTqpHthnI7LzYNK7fRmxmIc79CYKwQPSIOwKR88QRd0shyTjoatQVMx5wSwTnEYl9puGc+1bWNPgdiXr3WtYqz9Hmd0TO2lKjIYYH7C3/uox0gq+8pFnOeH6iLGakNdrxnSXWuX5XE3VOLKPriS+LHYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7485.eurprd04.prod.outlook.com (2603:10a6:800:1a6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 01:05:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 01:05:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Francois Berder <fberder@outlook.fr>
Cc: Peng Fan <peng.fan@nxp.com>,
	Shengzhou.Liu@nxp.com,
	trini@konsulko.com
Subject: Re: [PATCH] board: freescale: Replace invalid usage of sprintf by
 strcat
Date: Sun, 15 Dec 2024 10:11:03 +0800
Message-Id: <173422862036.21608.3355430674870831196.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <PAWP194MB2055C82705BDFCD5C0C4DF8EDAA42@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
References: <PAWP194MB2055C82705BDFCD5C0C4DF8EDAA42@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e95fa63-d568-48f5-4928-08dd1ca49e96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUdnV0o0c2lBTVp0Vmx3Q1RkTkROR1FjcUhMT3FMUFdzMUhRNHhUTHVPbzRR?=
 =?utf-8?B?am1MZ1VxbjZ5UEpNdFpYUGM4Q0RZQ3JDZ3ZIMUxSdnpabU0veXJjd3ZBcEZz?=
 =?utf-8?B?OVhKeFNzemZ3Q25JSURvT0REVzZwYnk3dXd1NkpNTm9tK3BzSTl3eHlpWHVL?=
 =?utf-8?B?Ym00ZUN3bkNsRExGeEJUdWlHY2pMcjdIRTI5UWE4ZW9SN1BDTS9KaDJlckU1?=
 =?utf-8?B?OWNBMWxUMVhzVnJIM25jUmhhMmVRV1VXZXV5Nkc3bXhLNFVjQVlRSzA5dVA3?=
 =?utf-8?B?VHZpdUdxcHZpZkk0OTFlU3RvaHZ1T2NYUGQzTjkzaUFDbFFoV0MwT0gwQko4?=
 =?utf-8?B?cE5aUzdKYlZQMTZMNWdQUk9Lc1RnSU93cXVCQWtOOXZ2OFZzclF0WHhIbExD?=
 =?utf-8?B?R3V1K0JNZWUrZVlMVGxCYnJySnFOalBxS1VvbXprSWFtTE85NWlobUw0ZmJ1?=
 =?utf-8?B?VVZDQUZZRlVhWVRpaGc4WDVUTWxGUmVMaTZrT2dkcFpyb0szZmZ4anU5VzFh?=
 =?utf-8?B?RjhGdmhLcUtQU0wyTkJuQ0hYbjZTQ25RUUljUmQ0cGQ3cm45TndMZU11Tk50?=
 =?utf-8?B?MldrZk1OVUxMakQ1OE9OMkVTYWJ3R3BBTDZNeERIVmprVGxqZEdYc3VZMERz?=
 =?utf-8?B?bWs5Tk1MOVd2MzFGRFlzU0w0dVZsWVBGL1dEbi8wZmFxL3VXenY1WmhVZ2Zi?=
 =?utf-8?B?ayt6U0VYZFdRa25lbFpjZStpMEVjbms0dWVtUGVEUTBVWGtaTkZTc1ByZzFm?=
 =?utf-8?B?TVB1RWRIRDZ4L2QvQVcyMGxRTVVEZExJYWJsTGFaVzVPWDRRVm4vNmxrWmRV?=
 =?utf-8?B?VmF2OGRTaFZnN3FWTVgySVVKa05GMEFBS0JBWFM0bHBxNkRCTWRzYlBCYnR4?=
 =?utf-8?B?eTFodGY3eXhEcm9hbXBJRHlFeGdNa1NKaTVGV0ZVb1VURDVEUEQrY2hNK0N0?=
 =?utf-8?B?RUZCcElOeDdFci9TZlhZelNwdjlFa0JLNmJEN2psZVRsNURwT0lLRk1TOEc0?=
 =?utf-8?B?Z2gvR3pDY0NlWWRTRWpLOWovZkF0bitQT0pSOGN0RkU5N283Um5TdnhvY2NQ?=
 =?utf-8?B?bW5KVmZ0NkFIbHZUcC9GSXpPSVN4MkwzdjlzQXhkeXFxeFdobHovOVhsVUEz?=
 =?utf-8?B?dUE3ODZvOTFIOGtzYU5KSEZwcW94dFFSaU80SEo5eWtOL3l4T0ZOb2IxUUU5?=
 =?utf-8?B?UndoNFJmVVZjZHNEQWh5MVpuWGcxZ0tGa1NpSWlvWVorNWI4aTFMc3RTMVdP?=
 =?utf-8?B?VnFpdnJQMWp5WVdVZWNtaG5sUlhuaFN0TjhabkdzalBubzA0SDZzamFxTUdE?=
 =?utf-8?B?SEdrRElGV0FUT0gwTnBnNTJieGRXb1FNN1pYOC9wajJZTmM0VmlhU3JjR2h2?=
 =?utf-8?B?YWZHajRaTGIxOHNmM2tTSVZLU2dTdkt4VzFpMHhFNFhxemh5dy9HcHdWaSti?=
 =?utf-8?B?ajhqdy8zRG1taW9XdzhqY2EvRDZ4dDdXVFMzdDlJOGI0elVsWlJpRUhXQzds?=
 =?utf-8?B?SlFLaU1hb0l5TjRSVFFBUnVWNWpUTGtFU3paT25xUWZwd1kveE0wQ0lXSHB6?=
 =?utf-8?B?WU5EUDhrQlZLNDBRb0t2ZG1INjJURTJSMzEyTUVRdjhDNzV1aU5JN3Jvd3VM?=
 =?utf-8?B?RU1NNDE0NktrbEloNk9BcU5hR2pRRUFNMnZLaDdTM3hlSmxuYjJTM3dvOUtj?=
 =?utf-8?B?Y3pTK3pvd1ZzNWxBRElGTU9GSk5iY1Vzb2VWRldLNHE0Tnh1U1B5a1pFRnBK?=
 =?utf-8?B?WEEyaWpTTFdBN3JxWkpTckRrdVFVSUg1TStpdmVvZHljbGFZeUtjVXp0T0hC?=
 =?utf-8?B?UWpRTldIdVhkM04zVU1nYlBrWlFhZURBWklZbUNxTWNlQ2I3V082SDh3OU9G?=
 =?utf-8?B?Ly9pd1pwWW1ucks4MzNnYUNnWDQ2cEcxczhNS3R6a0ZXbGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDFBYzlqYzBFbi9xY2ZEV0kvd2pES1VxblVrL1kyaGU1OUtHdmQ0RjN6T1R5?=
 =?utf-8?B?NHpVTkZxRnNRSmJMbUhqZmNWS29xTlBpZzBZZGFBcllOZUcvTFREbldyMkFG?=
 =?utf-8?B?dHhzSGZqT3dwZHRHeVhnU21PejlJQWRidUFBci8yTFJNK0VMbEU2dTBmRnE0?=
 =?utf-8?B?aU4wQUFNNkJyOWtZWVoydTViV00yYlZFa0xWUjdhb1Zob0M0SEI0K21Belpz?=
 =?utf-8?B?dzY4N1hzSklsUTduSE1mNGQ5YWxMKzYvRmgzNVQxVWxaZFpqZm9FQWtnZ0J1?=
 =?utf-8?B?Q09KbU1iVVFWSEVBb3YweTEwV2JxbDZ3U3djTTcyaUtOKzh1aFlkUXBZTVRo?=
 =?utf-8?B?T3UreWsxTmJYMkRwbVZjRmZzRmhGbHp2NXErTmNYV2IvQWJEQWczOHFrR2t0?=
 =?utf-8?B?NWxqeWlUaTUrSGpyWm50QU1uSFZKa0RybWhFanFDRWhlT0R1TEpPZDFxZmQz?=
 =?utf-8?B?Q2tSSVoxbjdUdUZIMFFqWS9FYytadTViZFZSbUhsblBoZFhoMmVUQWMyZXlN?=
 =?utf-8?B?dGo4K3J4My94cW4rSWdlQ2l5TnJ0UE9EVGFiaU4yYXBnSmlSa2J1NWIrSDJt?=
 =?utf-8?B?M3l0YzhEcXk3Y2tDS1ZVekRQdjk1SS85a3laQ2xFcXdpdWpEbHFNWmh2WTEv?=
 =?utf-8?B?MWVFSWZZSU1sTm9GSHJEWVUzSXdZWE9tc1IzL2haeE5TL2x6Q2JRQjJ0L0Q0?=
 =?utf-8?B?bEl6SFdmUjdwY2RMRXVTRXlZeGF3QVdVSzdLOWVLQy9UblcwNFA5d2h0WkVh?=
 =?utf-8?B?VDRPVWNtZ09KWHFpd3E1cUVFa3BVeDlVb0hBb0xzQy9lU1A2OE9mU1FWV2NX?=
 =?utf-8?B?bmQ5aElEMmxlcmREVzdXTlQ0L25xVStvRmdDcnhTSjM4cFl6bEV2bSs3VFlu?=
 =?utf-8?B?TndRTG80TldNY3ZCT0FPYm1JTG0wSHRWSDhjN1RpVUZXc2hyNVoybGkrWGxO?=
 =?utf-8?B?UThzQlMyZjg1U044K1pPNlVYTW13QUpHaFB3dGNZM01nMmlZZThjcHZCa2dE?=
 =?utf-8?B?SmNGRGtZRDJ0TG5QMEVtN3dhOGd4dlFCZEdOZHRCbE8yVGdKdDVaczByem54?=
 =?utf-8?B?b0REbUJDTnZ5TDF2eEQyU1dYZklFS1BlNVI1RElOS1h3eFJEV2VXRGRjZGp2?=
 =?utf-8?B?bVhIaEpPSnBXZXViTnZpMGRqc1Z2SWJHUWhsZnFKOXZJeTRyODgrNlc2ZHJJ?=
 =?utf-8?B?ZlpMY0Z4bmhURDhOWXB6SlIrcWpEZERCejh0Zms2RjkzdmMvd01BNCs4eERO?=
 =?utf-8?B?OFZiVm1CcjlybnJCVHJUTW1UQ1h2bFpub2djM0dNYnMrT2RyOExqWTlWcW0w?=
 =?utf-8?B?N0N5Nm9lRlBWMnA1QndXZnd5cVRBZUFQMVgxNW5FOU5oYTVtMExJN1V5ZmxV?=
 =?utf-8?B?UG5TTUhLYkVqQzJmNnF0L2FPTGo2bTBndm5VSWY1VlQ5OUxOVzdtMCtQam8y?=
 =?utf-8?B?RU9XSzZNeEhyUDZXOUV0QTgzbnNtekcvSVIvNUNuRGpXQlpXTTh0Yk1mLzJi?=
 =?utf-8?B?bDZIVHdHeVlEajVoSTk3eWxnN2wvMWVZMDROMjFNYzJBVFBUOFBrbmwxaTlm?=
 =?utf-8?B?K2kxQW5XSFc4aGk3ekZrSHpvc2dPREhadGczTGh6MDZxQ0M4ODhSN3N1UDdX?=
 =?utf-8?B?SUdWV1dlRzMvaE1PcmNjL2tiTDJKY2NMYWdUQzZWUmtOVGdxcUtpRDdSQnF3?=
 =?utf-8?B?SjVyV0lrWjdmMHNDWFd5VkFZaisrTnh5Ym9qSVcxNUZsOEgvYXZleVBmR3pF?=
 =?utf-8?B?eWhBY1VvZ2lvMWl5Y0dvb2RlbGhqZ0lDckw0L1gxMjFsTmJudjVGT2ZBZExp?=
 =?utf-8?B?RUpGcGFZcElGZ0hRQnMyUHNzYzZkcDdWZUhRWTdaNDlwSWY2c1JML21PaFlK?=
 =?utf-8?B?MG5qQW1uK1ZvRUQ3QlJyM1RIYjZ6d3hGdDYxcjBLMVZCeW1QZ2tIbFdDNEwx?=
 =?utf-8?B?ZC85NDlpY3ZDMmdPSmhDRGN6S29BdTlrbDZRRmV3dDZGbUhMOUxDNmd1aUdG?=
 =?utf-8?B?UWJLcXB0b0hEMlYzNGlRdXdjTVFnK05VbXpPTVd0WnFia29DUUlMS0VXcDYr?=
 =?utf-8?B?TU9DLzZmRVY0cEJVdTc0TU1mZ2cyTEt5NE5ZUFRRVmJ4cS9wSWFBZnZyNmNE?=
 =?utf-8?Q?qpBUF8GvY9twlGyBwkdFJaM85?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e95fa63-d568-48f5-4928-08dd1ca49e96
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 01:05:52.0876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1jDfQLJYTjVHwzJ+bCAbti0k7gbmIec8SGHPTdKIkCBsDwcce/qULRhrWnfY6Fr821df8WM88Hifqjakfz9MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7485
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


On Wed, 10 Jul 2024 23:37:35 +0200, Francois Berder wrote:
> buf was used as destination and as parameter to sprintf
> which triggers an undefined behaviour.
> This commit removes this usage of sprintf and uses strcat
> to append strings to buf variable.
> 
> 

Applied, thanks!

[1/1] board: freescale: Replace invalid usage of sprintf by strcat
      commit: c71aaaf6a896589c97e6ebb45c85f577d435c1e5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
