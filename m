Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B47FC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 20:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764EC80944;
	Sun,  9 Feb 2025 21:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gwU2gxZ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F70D80836; Sun,  9 Feb 2025 21:24:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B74C580836
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 21:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCkUL84t3tJoRoSK4LhXHQCEQoYwwfXiC91eyWjGcmvEYZXAHETpTTBfk2cX44bzs5jG9rv75zVe1seZjhEsPvOzzDgDUgm6FIDTDSDBbzTyuM8q0b9s2ZzBSGk1J1hwc9XYUud6dlHbrv+ALB4T5KLVhKlvI1zbR6VohTcxcPsosSK63VMOSg/YFHGphnyRdX3kV7uyf0/0JSn94SJB1rT+oPv1IjkgbQ5cvKWEFzGk7gHcT2e4RJappPj0+9cRp98mPB1B9/f3s6bFcA5+2Jp05q2mkQFZSP6HW7+wLkJTa/SZuKPHSQJfr8XjxG72kfNz716/vB813cGNevICJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZHspGjLTeUYA2s3Py7ueCkUCz9wrtwOx1wv0mhlB8k=;
 b=U/dzxtXizrmfGCeQcZfYWSmEm4cNsb4fkRjdbqBJk+o14KjiA+9x6D3UvzY0WwVrkiGC0+fS0Z40gNxiJ9riACcYsac76izQ/a1afUL+AeAa6krSg4bP6GPnpOjKnONQlxarqpjQIxvAcFIHV6GBClmNbAGSB8bpayiyTjTq3O1ztPRSH0kk6eEJIrU2FBK7tyh504u1JA7P2s70Mp6A3VnWzt+k8ovyR/g4baJ2+ki7MKmrjXpIUPV2l3rAK1vVBvN3IVycCoufGI7SQ1vMdr9RY7GKMRfCzBSWnTeY7TeItBJVg50LjihKMKc1Jy/5tCKHIb9h8lryFH1jdN+r8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZHspGjLTeUYA2s3Py7ueCkUCz9wrtwOx1wv0mhlB8k=;
 b=gwU2gxZ5dyGVPoJCSLb17gXsDfiP6J9tp1f5SEdHyEpDFA4fr+ola7OzR7no0VTWTdoC89YcNyuyRzYnmKOdF91+dnuZhWPsDLx5ipmJp3vfN5JcabjQOZYVjxy7rMPvD1P2unp+eZJxsGjaZ4uFNcQ+Wauz4r/iYBV6FKIh0IE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Sun, 9 Feb
 2025 20:24:10 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 20:24:10 +0000
From: Josua Mayer <josua@solid-run.com>
Subject: [PATCH 0/3] arm: mvebu: add solidrun cn913x based boards
Date: Sun, 09 Feb 2025 21:23:51 +0100
Message-Id: <20250209-cn9130-board-v1-0-b94ab83e141b@solid-run.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANcOqWcC/x3MTQqAIBBA4avErBNGI8yuEi38mWo2GgoRiHdPW
 n6L9yoUykwF1qFCpocLp9ghxwH8ZeNJgkM3KFQzKjTCRyMnFC7ZHAQavwSnPWptoSd3poPff7f
 trX1wANUOXgAAAA==
X-Change-ID: 20250209-cn9130-board-09c8db7c077a
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>, 
 Alex Leibovich <alexl@marvell.com>, Kostya Porotchkin <kostap@marvell.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 829631ce-278b-4da6-853a-08dd4947b61b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1JqZ25vWTdMZUNXRnhJTkVGc0tVTllqTEpwazRHR1ZyRXhkVmhLT1c2OHpn?=
 =?utf-8?B?YmpJczZ6T1h4ZkF6VUlqUmRCZGNRbWhVOU1HRDNxYU1CWkJrMTZ4djk2cjJG?=
 =?utf-8?B?cW9WRjFrRE1IZ2REenpIcmd2ZjVZdS9Lc0Z0QlBoQzJ2OXFySW8xekFtR1M0?=
 =?utf-8?B?YSt0b2MxNGpQa3FoendQL0VlbUpQaFg4eFZEMXZsUTJsbEpwTUd5SDJENy9W?=
 =?utf-8?B?QUg1VkdTMzhPNXlDWXZXUEVsRVgzdjZQUlRKMnVFTVhONTlMaXdLWWgycW9Y?=
 =?utf-8?B?Z2wzNW1EV2hYejV5YlFZL0dBb082c1cyeVR5S3dIUEVtTVA5cTdwbWE3dnFr?=
 =?utf-8?B?U3pZTHdaSUdJaU5QSUhKNFRyMlVWSWsxOEhyenh2RFBIaXJlU0daWWlnY1Nu?=
 =?utf-8?B?QS9mY0c1YTZBa2o2OWRteWY2bGxNSFBaN2NkVm9oL2QxS0U0R08wSnN0KzBl?=
 =?utf-8?B?dTY2dDEzWkpDNndJd2g0aFBjcWRCN3p0dExvRjUyakVmMVlzTjlielpadVdJ?=
 =?utf-8?B?MW1lWXV0VkZiMTU1MHR0WXM4N1hKdlFSaVhMMVMvbHhLYndiR21JRUJYcVZm?=
 =?utf-8?B?c3VwUGZIT0x2STNnZ2NjdkU2bzQwTUsrVCtvTVVzUXpRQ3IxYlpHNTlEcEd0?=
 =?utf-8?B?cDhFdWxaQUJxOFcwK1lpVFhFZGgyMTZKcjBXUjVBZ1F3TVlKTE5CcEVQN3pT?=
 =?utf-8?B?OTVOc2pWaSszUm4wQmY4SXhVeTZqVFY2bGxXT25zYVlidC8vN1IwMnVFY1Yw?=
 =?utf-8?B?MFlFUGlBNW05UVhqbklVWkRrYnZyUU9HMXBXUVpMOWxCM1A4bkFiVHdSanUy?=
 =?utf-8?B?dVlPak9WTGZRZ0pKV3ZLdGtiWFovYmJHM1Awa291dWVld1doRWRab3NJcm1L?=
 =?utf-8?B?Q2hFV3A4MHdRRXRiS3MrYlVXWjZrb0xRelA2aGxYNmJucWdDQWh1andvNGJJ?=
 =?utf-8?B?Y2ZoVklOM3h1NEhlZXlNVzZqQXZhc3BBSzg2VllsdVlTeEpnc1NGbEs1Ym9m?=
 =?utf-8?B?S3cxdXh0ZFZZZXlmL0lvNUpNWFlxOWxoY0RsQURCTHRtZUMxMER0NEtuWndL?=
 =?utf-8?B?aVQxakJpR0RxQytZSmsrOXRUSnN5S3lCWHpkb2ZEZ2RKSlY2RUFBSzlxMTM5?=
 =?utf-8?B?WHBQM0dCbHhZeUYyNFptSVhYaVZ6ZFhFZjBPY2ZvWmlXZHVUdExHVjNCTi9S?=
 =?utf-8?B?eFJiS3lSSGlHKzArYWtqMktkQzM2eGNGOUZEVFhzZmN5ZW1leElYSWFPU0p1?=
 =?utf-8?B?TXBJTmlFZzZkSDl5aU5CcVhSUVdSZlM4c1FTZEFXRTlycHRlc3FDbkIzWWp2?=
 =?utf-8?B?RHJWc0NCMFpld0wzZFdNSktxYXNTOGVIOFNNalJHNDh2ZXdza0VwL1V4S09h?=
 =?utf-8?B?MXpLakRrOXBJV1RCYWNEK2YzSitXdFpDK1RLVkZaUFRtMnlTWkh5RXhHRk9y?=
 =?utf-8?B?clI3cGVzb1c5dGJJbmVTRysxOWduSjdOMjFxS2VlU1RqNFJMUUYyakMvaFM2?=
 =?utf-8?B?N1VFVkVtd3haaHpWRHdBSE5LZWs0UlpGZjdaVTFsNkYxVEFtZFFQdlJITXk1?=
 =?utf-8?B?U3R2SnhIdDNFU0JXS2ZobnphZzdvR3JtelNEV3V5bFpIa21Fc0xaemtDdmgy?=
 =?utf-8?B?UjJ4ajBBRnBndVg5QXZBWjBERlRnRWM4WmRoSW1YdDJnRFZjU1FXVkVCa254?=
 =?utf-8?B?aER6Kzgra2RQMDY4bFo3QmNmTTB6MGd1a3FSZkRsNUlONnZTR0VaWVJoQ2Z3?=
 =?utf-8?B?OU4zRG00c3ZFSzJ4Z051N1RqV1I3eVI2NjJ3QytnYUZtaWVLb0JlSHlrWURa?=
 =?utf-8?B?ZWZFYlkxZ3QrWkNWc0NZbEhoTEtSeXBLc2RZdWpRcnAyazluZ0xsUVVKK2dW?=
 =?utf-8?B?dzQ0T2lnbkIwd0JlcEZUQzJwTzltS28ybVhiRm14blhqdExDMDI4UlhjaldK?=
 =?utf-8?Q?RBQ+MoAqy3A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJOeGlxQWJCVHdvUUdHVDByeDJhOFdLZXhmN21QZWNud0Q5SnF3dXAxWGx4?=
 =?utf-8?B?RjRwMmFPc2syUldEbDlnb3lLMWZWN0c5OWx2aXRLUy82SzhhM3JFQi9pY3dt?=
 =?utf-8?B?YmpTWXFqOGpYaVNjZlZUa0VvVTZxSHd5b3dJMGxySGFwczN2bnNjZ1c1MlpD?=
 =?utf-8?B?RWg3MXFGVnB4STk4aFBhV3VYYWdwM1hmNXNvVjNrMFhrN2MrOG9xcHc3TEVh?=
 =?utf-8?B?Rm5TSENzUzRlbTVrbG1oUEcyY0dZVzR4R2NmM0ExV2RJSnpiRElOeGNmMStQ?=
 =?utf-8?B?UHJzSnR6c01HRHhHTjZSUjZEUFVQUDhrWFhFRnZTT1RVaFY2UDRZQmdKRlZx?=
 =?utf-8?B?MmZ4R09Vd3B3TkxGYkJFVGRXaERSQnN4V1psYzJWRVFSZXFsWjlnWU1RUWVT?=
 =?utf-8?B?dHE0bDBmOVB4WWpKaVRSTDlRdTVsWHBRNVNMRDBtYWg1aTc3QVZBRW01NDlt?=
 =?utf-8?B?OGJOVHFHSUtQUks3UkttUVRTa1dHWDcrZSs0WEVzYlR2U3QvclRlbkpqbit6?=
 =?utf-8?B?cE9PbkErdTIwQUN6OVdqZDBaUVpvMHFXdDh4S1dRSWNLSlRqSVR6bkQ4RmRB?=
 =?utf-8?B?cUIxRCtrYjMwTzhwazhna0o5WDdFNEsraExma0EzSVk2STBsVGtrY3RrK1ZS?=
 =?utf-8?B?aTBKTkxOR21aR3NvaGZla1dnUzdoR2dyM1BnSjdEVzJPRUg5aWg5MUJ0Rk9s?=
 =?utf-8?B?QXlMT2xBdUlxTUZHMjk5Rkh5RFhnK0E5RVRGa2R6SmVHU3ZzWE5mY3ZVOVN2?=
 =?utf-8?B?K2UyYjdNampLcGlzRWNhU0lVeFRJRDdOTEdzcDlnZEFtK0JuQldUTjYyTzZk?=
 =?utf-8?B?NXBPTEhhbyt6SHh2NWs2ZWhCbWQ0dXh2d3JHa0E5cGRFdzRITUZpaE13S1k3?=
 =?utf-8?B?blFlcDFkQisrZWJwS2ZrTjBPSlZNbzAwZFZOQU5qQ2ZRZTZ1Uk5UbTZjNEpZ?=
 =?utf-8?B?WllYUGYxb1lad0NYRXRZTkFvYStUY056cUVmL1lBdTMvanl0bWtzUEpIeUpZ?=
 =?utf-8?B?NGROdlNYZjBIenF1VDdFeWFYSm9qM1ZqN29nWTA2ZENaRzJMT3I2bHMrTXBq?=
 =?utf-8?B?ZkpJR0g3K2trVzFwUmNsV1MrM2wxZjV5R3hEVnIwSGR4ZytKSU0yL2hOVkRD?=
 =?utf-8?B?d0RLVG90Z0dsQVdOQUhiR0g4SFQvQnRpcm1neFRZTTc1VHc4a3ZqVDdxVllU?=
 =?utf-8?B?OW85bk1GdXRhNFo1OHd6M3hDKzE0Sys0d2NNSnpGU0NaSlhUWk1xRVI2SWU5?=
 =?utf-8?B?SjQ2NmlEQUhpancxU3IwWWltRkpuMlhYTnpCZG1RRWJ4R1pUZTRhdlpjTm0w?=
 =?utf-8?B?ZGEvSkE2OXZab0xGU3drY3FaKzdTS2svaGVlRTY2SUtHZDdVVFR4YUU2UnZt?=
 =?utf-8?B?WFAvQ1RBMHFsU1EwVU0rOHR4K3FLY2svV1FyblB4bEhxT3I0ZFhHaTd0WkZo?=
 =?utf-8?B?L1UzODZDMWV4bmlMVDIxM0lFOFpQeXBIVkNFZmRkMFJXSGVhY21DWXc1VzJr?=
 =?utf-8?B?a0U2Zyt3OEdrOFpZTldDT2YwTnNTd0UwVzNQWTdXbXgybHJ2azZ6Rk83MEFR?=
 =?utf-8?B?amdETjRVdC9tRDlaUXMrcExNVmNhUmtYbHp0VEFuMGFLUFJsS1FBc0s1enRB?=
 =?utf-8?B?cGwzT01ybXdSMHM2YlFuWFFGK3c3a256bEp5WE1uYnhsTHRxTFN2VmNJdzNK?=
 =?utf-8?B?OG1jaUZFT2pGM0dJR2RtbVhITjIvcksranNUelY2MVpodmRid2hPMkZaamZY?=
 =?utf-8?B?eWNXUzlReEpGSHdteElHOXhJdzlkSlVTNVF2eEZ5VUdDM2E5QmxJUGlidklE?=
 =?utf-8?B?WFliWTI0NXlwK0ZZNkJPSGkyMmdkNTl3Mkd2RGwrZGN5ZnFrZ1NMKzZ4cWtP?=
 =?utf-8?B?eHpMTm1KYmVLa1BSL2hSOGpTSWVwbEFhUjBkUGJWTnYyaUJKR3htc0d4VzhU?=
 =?utf-8?B?YitneTJwWnNQVkQyaTdSUjVncDNuVVNiM3ZxMkNTbjBqZ0dXKzZnb2VUbksx?=
 =?utf-8?B?dHpyZVlBZFUyeGNQTVJWZjJRRGRtVFFnUmlPdGFCZFFaS0ZLeUdYN1BTeXZm?=
 =?utf-8?B?TWRmSnJaZkMyT3BOazNSYlBrbDhCV3JhUWNzQ3MrSU4wWW96LzZWczZvQjJt?=
 =?utf-8?Q?kZXuf9zc8ISa0UAgs3YhCT3qS?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 829631ce-278b-4da6-853a-08dd4947b61b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 20:24:10.4500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eH+Scwu7P0XG8qx9PJzRSGYEAU+hrjd6c0RM/ZbAHjhZ00JM5/G65xnTO6+dctwJR0NB0RZeZvvEtzPRr9Osvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865
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

Add initial support for SolidRun CN9130 based boards:
- CN9130 Clearfog Base
- CN9130 Clearfog Pro
- CN9131 SolidWAN
- CN9132 Clearfog

This initial support comes with limited functionality.

Further add the Marvell RTC driver from their fork.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Alex Leibovich (1):
      u-boot: drivers: marvell: rtc: adding rtc driver

Josua Mayer (2):
      mvebu: armada-8k: set fdtfile env from DEFAULT_FDT_FILE
      board: solidrun: add cn9130 based boards

 arch/arm/dts/cn9130-cf-base-u-boot.dtsi     |  15 ++
 arch/arm/dts/cn9130-cf-pro-u-boot.dtsi      |  24 +++
 arch/arm/dts/cn9130-cf-u-boot.dtsi          |  52 ++++++
 arch/arm/dts/cn9130-sr-som-u-boot.dtsi      | 122 +++++++++++++
 arch/arm/dts/cn9131-cf-solidwan-u-boot.dtsi |  91 ++++++++++
 arch/arm/dts/cn9132-clearfog-u-boot.dtsi    |  79 +++++++++
 arch/arm/dts/cn9132-sr-cex7-u-boot.dtsi     | 265 ++++++++++++++++++++++++++++
 arch/arm/mach-mvebu/Kconfig                 |  11 ++
 board/solidrun/octeontx2_cn913x/Kconfig     |  33 ++++
 board/solidrun/octeontx2_cn913x/Makefile    |   8 +
 board/solidrun/octeontx2_cn913x/board.c     |  40 +++++
 configs/cn9130_clearfog_defconfig           |  77 ++++++++
 drivers/rtc/Kconfig                         |   9 +
 drivers/rtc/Makefile                        |   1 +
 drivers/rtc/marvell_rtc.c                   | 185 +++++++++++++++++++
 drivers/rtc/marvell_rtc.h                   |  52 ++++++
 include/configs/mvebu_armada-8k.h           |   2 +-
 17 files changed, 1065 insertions(+), 1 deletion(-)
---
base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
change-id: 20250209-cn9130-board-09c8db7c077a

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

