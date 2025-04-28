Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EA7C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4884382999;
	Mon, 28 Apr 2025 12:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s4JjXwJ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0191829C7; Mon, 28 Apr 2025 12:39:47 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEA67829CD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWiWcywWq7ohCoaQiGjr5KReNaezZkqhJA3zsmn7doCE1wCX/2ujQQrCISyuZD35t4qzM1jPR+i+Mpssoel+Yvx+AYt512TvwRQkiu9d8JCm7TwQR35FHcCK8oE28KIPis3z4TEMnYo2hVG6Bp8rD6BAkYlf8lrQ5F+nYWCRZ1uhAArAzcNBMiPu5KxXIXzpLE1DrLPLcJJHTVzRiVEhji2QVBgUP1SimJVd30iLZAPVXwND2H5M6GeDprwE/ynVaCqv04RDlNiwJPOc/yog4iJsYpfo1k3HCSo3AbZE2q5Zf7DJAqE1EsQSypkleJP9xyNKml7NVOb0rj8l8Ezuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4xJB2bKHRzugnT9lrCxPxT7n67lChTPQ9RaxMOBUyk=;
 b=bOCx74yIr2e7dBYYcoMYF33VToigwpxRvwHeAONCeiosKqb3oX0okY5nEjGQzrFBd1nLY557eFFTzyVAznTvN7UbLTL/Zt31V9HG1t7OkbldBOVqUBUFqWMm2uAnFjnRHO7D8dAeni66+t6jTFWY9skk3BUu1rswDnGrLqJ3FkUfdpKx6hg8nT5yXSfR1WiWhr/snXsMqeTbxzWWsukOkF0qe+cFhtXFZHWR4bFY2+QAZySRxK+EqfEf/R1SCVRjVgHFF4u53y9eNXHVj725393hNcDv+rkV5AxfdrWoOzyrCKJLwqickKqyzvXXkjC1RRxCgz7lW96BWMSzeqVzUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4xJB2bKHRzugnT9lrCxPxT7n67lChTPQ9RaxMOBUyk=;
 b=s4JjXwJ9W7O7l4riZjWC7KW1a70s2kh7FefMqNd9XaYmLJNueF0QSkiYttFQrZL5SwCxmbFgpfLLeyud3anlNUPQ6IVmYMGd9XnaCshKt9aN1xDkaVvuK5aocru+y28JRAOvFwtLWFevsoiMU1V2NLVrKfnfJgxNAYPpDli1dLlGcPCOlPXQXaO2EZmCuVWj0h3OoWJD1Zzw3CED+RtXdXCxVr2e0+nB1tW4XzERIEFSZcrCnKd7r7y5FlGtpcwV15xJU1hSfSipgCdLS2e2ekjZxfIIgqYgsBYbSuwQCo5u8+6EgwE75jefY+/RMXobKSvC0FzupU+OK78v1Ts9dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:39:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:41 +0800
Subject: [PATCH v11 18/21] imx: container: add V2X container support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-18-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fe71306-f775-4c7c-b60b-08dd8640fbd1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eC9JUmI3cVEyMzFWSUY3WXRUQTlSZmtJbm9BamNHeUdyeS9oelRoYUw1RkJN?=
 =?utf-8?B?aFY4L0dHRWY0K3BCM2p5SmdnNkRwZVI4RUZtMWpQM3BhYlVMVGNvMnJlTmdD?=
 =?utf-8?B?dHpieFROQ3hEaU1EUWhkU2JhdXlaVUUwNjkxaTVXdUNnU1Z4SjRmODlPZ3Nq?=
 =?utf-8?B?WFcvREJiWURWMnJ2MXhGQUxucldjMXVwaGxDT1lGN0hpcFJYdEJ2Z0xyZ3Er?=
 =?utf-8?B?WHlvNWthYnNQWkllMmdLTStxbHJ1eVZSTHhNRnJpSG4wbms3NjBTbmIyK0Ra?=
 =?utf-8?B?NTVlVlNhQ1FxYnEvM0dXckx1TnBhM0x5aFFFQlRPc1gzYnhYMVQvd2hrWGhX?=
 =?utf-8?B?d21Pb0xSMDBkaXNWV1ozK2s5T0k3UDlHTFN1eDcwKysrK0QzdG9DaW1iMUJP?=
 =?utf-8?B?RlJDTlorYldJUHZJcUFWOEM0dXluR1RQQU9jMllPQXltMUljWGQzU3FxczFE?=
 =?utf-8?B?ZjBqU2w1em5GNDgyOHErK25wanl6VVlubFRURkFmeFU4R3U5TUM2dXNqd01N?=
 =?utf-8?B?M0hlRFR4M25Hd0VBa1l0R2szRVM5SzI2cEtzS2RQSEhoQ0VZV1RZR2c0WVEy?=
 =?utf-8?B?Q0tyTDRKNGZWcWtqS3dEZzZqQko5OGVkKzNVV3hJVUpLV3p6MG8zNlppcjBN?=
 =?utf-8?B?bXJUWGtlUG56T3B2akhvb1c4NWpQeWQwcE02YjVIMjBMdlJQcmovZmNRbnlx?=
 =?utf-8?B?TzdoOFlZNmFvNjJSUjNxcXlKd0FGZG1kMUpKVEhDRFdSZEN2YXVxOWVHYlJw?=
 =?utf-8?B?OGtwcWM0UnJLYkVrMkhMZFBOQXhNV2JEVjErZHdoZkVQeWt1TVVtRnJPdVMw?=
 =?utf-8?B?MFVBN1hCbDZjNy9xTW1VK1I1Z2lRL0lVTCtCb1pOenFxMERvdGxxeGsyeThR?=
 =?utf-8?B?NHV1ZU1Kc1RIT2NhRjhHSXpWRlk5Y0pxRE9ZQXhTZ2NWeTc4c0NlSE1hWnBF?=
 =?utf-8?B?UVhxaG84Z3VNdHRQLzM1bHByVVBNZXVjT3A3YXBHNjlpSVJxRDZYakI1NlRP?=
 =?utf-8?B?N2F4YkdOWjlGelRsNlo4azVIdU4rM01vSjV4RlNDLzkrQU5GMVg1alIvbWpl?=
 =?utf-8?B?aDE2R2lkZTRGMXRwRks0blNZb3VXa2I0NCt0UTJEbUw1U1ZlR3EvUDlUN2Mx?=
 =?utf-8?B?MDFUaTFXaUVQTnEyYm9Rb21EZUtjWHROZGdYcGtjY2g1L3JLSHloOUZxRlNR?=
 =?utf-8?B?WmpnMmZhanpQUktpYmNJZElFSVZzeHNGRUtlMFViWm9Jc3JHY1FXcmhacW84?=
 =?utf-8?B?YkU2bGZGRzBFcFVLYy9xWFNpc212cVg3ekhYTHFEUmR0M21mNGdPYkdvS3Y1?=
 =?utf-8?B?RVV4bkhFUCtZWW1qQXA5eGNCK0N3NW5JSy9pUmtYZU5BSGRxRUFDZU9aUyt6?=
 =?utf-8?B?K1NtT2hKSnhGVWNoMU1PSEYyNWhPTHdkeHdQMlVPRHkzRjV1MTlNNDFoR0Fm?=
 =?utf-8?B?Mmtha1NyazhYUUhadXVRTWdMbDI5VFAwT1p1R2xtQlFPb3Y0U05kbDgxTG5S?=
 =?utf-8?B?eDRQS0oxTnhVWlJES2dweTlGandvM1MxdEJIb3kvOVR1ZHAyZ3Z6NmthZFRw?=
 =?utf-8?B?T3pNYTR1OVk1OVYxN3JrVklHSFI4cWJ3MFFuZXlWNk9WNmpkTlJ5R2JlZENz?=
 =?utf-8?B?MEZwc0crTGxBYzE2TjVrVW1KbS9kODVWd2FmaFA3UytQK0dWT3puNm1UWDN3?=
 =?utf-8?B?bWNoamF2MEw1UnplREJqKytOZmV5dXlmMzR0ZkZEVmxUdk94MS9LdGY0RmVk?=
 =?utf-8?B?TW1KM1dtY09DelVpR1FnZ2t4cEhwNU8xaEhtY0xVanczYXFlbW41a2hZQ1NJ?=
 =?utf-8?B?dWZpL2hKZCtzc05TSmVDZEN0bU1hVWFuc1ZiRjBST3NHZDBhek1lUTBudHJK?=
 =?utf-8?B?K2x5OEd2WmZxL0ZmTHhRdHJoQnBjUlhzSVA1cnQ2RW5UYWd2dm5nam53RWVn?=
 =?utf-8?B?M2FLSmhxQ3Y3ek9ySENUVEsrVEpDblU2bGpSOHgzQzVxamZKYk1JcFZRQTdI?=
 =?utf-8?B?R2EzTEt4b01nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3Y4SmV4dFFzUW1BdEhYSUhNK2lCaEczRUVxbHBrMzMwMnhkVFlZNnE0b1Rz?=
 =?utf-8?B?UHFwdkpFM3JUeVQvaE1RbExxd3JjWS8rR3pLRDNiQUlRM0hjOWtRZzVCbkgz?=
 =?utf-8?B?bVVNNjJHMFhBS01DQ2VhcGpybDJ2Y1krdk5ud2s2ZVF0c05BWU9RNlFXUEIv?=
 =?utf-8?B?NE8wRjVCR1FDNWJDT2tWQm51VVZGazcrUXB0Y09sSUJFRUpicGpLaDhlRlZh?=
 =?utf-8?B?OFB5QVBEL2V4TGxrSE9Qc3FiRHpOTk1kVnZsQ2FJWHd1cDYwNVRuMEljUGVl?=
 =?utf-8?B?Q09YMGJ4OE5vMkxyblRRMmg1MGwwcVFDRFlSeFVNSmFVZHR2TEEwRW11VzNX?=
 =?utf-8?B?TXgzdTBWQXZ3cHZwcm5FWUFUVTlmWXA4UFkrd3c4VWFEZjF4TU5JZkN3Q05Q?=
 =?utf-8?B?RGJ0NGtTM3A2MHdRSU5sTGZZNkJCZkFtSDEvYWkyeUlDdWdBMlhVb2U0Q0g5?=
 =?utf-8?B?MnUwbk5TbDhaZFdwTGc4YlFWNEVXM2x0MnAzUzVsNmdBNlduS2NUazdieFh5?=
 =?utf-8?B?MkpiOXlNcnhpdlZBR3RWUFFSd2JCdEY5cjRMY0NaY0FtcXNoVVNIeVFDdHo4?=
 =?utf-8?B?eE1pZ1crcW13d3p2U0VzTWdsSjVkc0dQa2YzRUUzTXZGSGdwbTFrdEgyRHNT?=
 =?utf-8?B?cWlXZzhNOE90MXh3QlRic05rZlhkMkFTazBZUE1jb2VEcjJjNHNBWGlvVUxp?=
 =?utf-8?B?Z3l5cHNHdm1JNVdZV1dWam9lQnJCY052dGtyWWJHam1McFMvbXN3R3pUUlM4?=
 =?utf-8?B?dC9yNW5zVWgzNUkwU3duZzhFMFdFbVFaUVBaRW1ieVN1WG0yYTlnTEF1OVBN?=
 =?utf-8?B?R1FHNFc1Tmo3QndGNTJnKzdaUTMweHEwTUpEV1dZdkN6eFBrcFhUcnd6dUFr?=
 =?utf-8?B?Q25LWENmZlhsM00yUm5SNjRyWTZGVXUrOUJ3Y0V5b3BoRE82dytrNDlEdFA4?=
 =?utf-8?B?V3NWNkxJRzdKKy84WE5HZXplWmp3Z2lmUzJaVHVPd0tvWFpTU1dHTURZREU5?=
 =?utf-8?B?VGQ2VHJvTDcycE13aVZkMnYrNXZvc3hKSFZxNS85S0dxZU0rR1V1dm9rZWkx?=
 =?utf-8?B?bm9USXE2SW1IWDEyWnBCMWM0ZkxJdnkwaGV0cWdQY1BoRFNIYTQ5djdidDNv?=
 =?utf-8?B?R0Roam5UNjArTkZHTy9ob2FwOTd4NlR3NnhaSU5XUHhJN2krTW8zODlQNnVW?=
 =?utf-8?B?RU8rNXorY21wZC9hOElxUTlnMThtYUVRckNxNXM2VkFld085clBWSERMUy8r?=
 =?utf-8?B?alFaRFhJc0J1YUJGbllHTzhkc1VrTlhUa1lZRC94T2JMeTlTYzlqUVRmcnk5?=
 =?utf-8?B?eGdwL0JoK1hoSmZMbjl1aW00bmRQRW9sNHdGMUhFdFFpUmZJSkR5TUVWRE8v?=
 =?utf-8?B?RmNKRkpxNVM5NGN1cGpoZjFERGRPcjBCWmZiTjdMV0h6d3VVRmgxd0I3ZTBV?=
 =?utf-8?B?bnBOdjhJRFpLWXU4L3dLc2IxdzA5c3NTUmJCZEFQZmp4SHZ6MUVWNWRNSUNt?=
 =?utf-8?B?ZUp4c2lWZUdVRTM4a0JPZ0lGaDZNYkxZcWlwY2ZKZGVHck5kM28rYmx0Zkdn?=
 =?utf-8?B?ZFE1ZjFuR1J0ak5DaUN0NjJXNWo0eVRyeFI5Vk9wSXJOMVdVQ3d5bDd5d0dv?=
 =?utf-8?B?L3R1VmtydGFaajU2V3RYeEg3MktpejZSS2RvV3BJNWdZU1c0UG1CbWgxQXpH?=
 =?utf-8?B?R2dpa1ZKL1hJNVZQSTlmeXhNOGl1U3BmV1UrT0p2UUhaZWIxU0JxU1RtNkY2?=
 =?utf-8?B?T2xTd01SOG9QOWNYSmFlcVNsdzNmcTdHbXdpTGpVWmZrVWpOU25sK09GMzkx?=
 =?utf-8?B?TlF2NSs2NTU0Z2V4K1c2b1AvQmhaWFpHQ0dERHcvWmhZVUROWDdyVDFnaHJY?=
 =?utf-8?B?OXhmMFgxRVNBZWtYNlhmSk5PSTBYcEFZajlBNlRGLzZpRE9xbUVSbW1SZGpD?=
 =?utf-8?B?RHRHRlZXeC9zRmdKVWtSZmp0dG5nQy9ad2g3eU9LNnhCUzRTUy92YWpaN0xo?=
 =?utf-8?B?ZUdXNDJuZUhRdEVxWUp6RHlxNkRyZVBDSzdNSnplNEU1UDRNYmVpK29pYnBw?=
 =?utf-8?B?ZlNnTVpya0tqUkREVlZiTWtxTDRCZzhzTmx4eSs1eW80K1NwRGdJQVBsMWc5?=
 =?utf-8?Q?zPpnLkqUgJIlm88W8V/TD0QdZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe71306-f775-4c7c-b60b-08dd8640fbd1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:41.8811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xex2/LFA0o7mD7DqzVbvD3Mdlb61bTr71id/LQFLihEOzJG4KKVEnbKuhcj9aS0lZ87rLQus1o/gq8brjDehvg==
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

From: Ye Li <ye.li@nxp.com>

This patch adds V2X container support for i.MX95. Since V2X container
may not be included in ahab-container.img of i.MX95, check if V2X
container exists in order to get the correct image end.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 119 ++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a06..f84e23f4b2a 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -41,6 +41,52 @@
 #define FUSE_IMG_SET_OFF_WORD 720
 #endif
 
+#define MAX_V2X_CTNR_IMG_NUM   (4)
+#define MIN_V2X_CTNR_IMG_NUM   (2)
+
+#define IMG_FLAGS_IMG_TYPE_SHIFT  (0u)
+#define IMG_FLAGS_IMG_TYPE_MASK   (0xfU)
+#define IMG_FLAGS_IMG_TYPE(x)     (((x) & IMG_FLAGS_IMG_TYPE_MASK) >> \
+								   IMG_FLAGS_IMG_TYPE_SHIFT)
+
+#define IMG_FLAGS_CORE_ID_SHIFT   (4u)
+#define IMG_FLAGS_CORE_ID_MASK    (0xf0U)
+#define IMG_FLAGS_CORE_ID(x)      (((x) & IMG_FLAGS_CORE_ID_MASK) >> \
+								   IMG_FLAGS_CORE_ID_SHIFT)
+
+#define IMG_TYPE_V2X_PRI_FW     (0x0Bu)   /* Primary V2X FW */
+#define IMG_TYPE_V2X_SND_FW     (0x0Cu)   /* Secondary V2X FW */
+
+#define CORE_V2X_PRI 9
+#define CORE_V2X_SND 10
+
+static bool is_v2x_fw_container(ulong addr)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+
+	phdr = (struct container_hdr *)addr;
+	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+		debug("Wrong container header\n");
+		return false;
+	}
+
+	if (phdr->num_images >= MIN_V2X_CTNR_IMG_NUM && phdr->num_images <= MAX_V2X_CTNR_IMG_NUM) {
+		img_entry = (struct boot_img_t *)(addr + sizeof(struct container_hdr));
+
+		if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_PRI_FW &&
+		    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_PRI) {
+			img_entry++;
+
+			if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_SND_FW &&
+			    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_SND)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 int get_container_size(ulong addr, u16 *header_length)
 {
 	struct container_hdr *phdr;
@@ -83,7 +129,7 @@ int get_container_size(ulong addr, u16 *header_length)
 	return max_offset;
 }
 
-static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length)
+static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length, bool *v2x_cntr)
 {
 	u8 *buf = malloc(CONTAINER_HDR_ALIGNMENT);
 	int ret = 0;
@@ -150,6 +196,9 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 	ret = get_container_size((ulong)buf, header_length);
 
+	if (v2x_cntr)
+		*v2x_cntr = is_v2x_fw_container((ulong)buf);
+
 	free(buf);
 
 	return ret;
@@ -231,45 +280,67 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
+	bool v2x_fw = false;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length, NULL);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		if (v2x_fw) {
+			debug("v2x container size 0x%x\n", value_container[1]);
+			offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+		} else {
+			printf("no v2x container included\n");
+			offset[2] = offset[1];
+		}
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+	}
+
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	debug("scu container size 0x%x\n", value_container[2]);
 
-	return value_container[1] + offset2;
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +350,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +383,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +397,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +410,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.43.0

