Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DBECCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 17:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097C2839D6;
	Mon, 10 Nov 2025 18:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="og/Wwxul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2060283A5E; Mon, 10 Nov 2025 18:37:53 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC6DD83957
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 18:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n36EYAE/fhQPpBvyXoVz6wiLH+AwuUXaB3PEp1WSB7y3K1yCYLCN19HuBsejXDxAMTiZi1K70Ke1icrCZAlmM6mRTCIJpbgPa5hctb1r3ZvjTtyHLC620vC+K1Q9FFOkJu2rj6yRZuUv9Dd+KDImgsu+5S5bEHYCDVe9Ct1liLlJqyrUuS70SAY5O/9XTcjuTGS6cYp90tFRQRbPPTZl9rYGCZOxZ0qnYxga70H9rNuuLuOP5YzroZTO5fu8fPd3I+xDXEhVgZ7YD5cAwi6l1i9r9PZ6dr54JwVBvDjoyeCToWq2k5+MLlDNRQADWslQF7MqNc7klwCGIUa/mtdLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNA3gbXC2F3eR/i/Txxg66gdl554Y1FqLnicf2igDIA=;
 b=AVxocmhmsTsbZ2uUBnmezZcOfKjNytRbFFON1mbfVSbLVykFEsdVfHb2MlH8MpGtsZTsq+jxl4c443sPc4NsmiyBV3uhDUk7chx6ED9k13DcbQMFb3uOKo1IkGwoaD7hHpTYGhTbv4MMcziVTfoWqVBLp1T+TpUVJ6kzxZTnA8r4Y6Q5z/6JYBSFPYfmy2HICJEtYYYKHzle8K1wwBjNNAB3+pZALvvFdcEQ9/ZZA29hbU4JuBnbmfj5cH+1cDfUqjsJN80lOBImrgWFR/d1tStT3Q27uj+nu2LPwHLVZC0yYQ4zMOCdBhYY3tx+o6WDjvoi6l7FPHMdFvJXweDDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNA3gbXC2F3eR/i/Txxg66gdl554Y1FqLnicf2igDIA=;
 b=og/WwxulRfzTXCj9ElYA6WVa0XCMkdWr9JA68I8J727Lraex2SRfsqGyZ5J4p8uUBMf6v5sD6LNmeYyc2esHxyI/5V8qHMgXfsXFtos7mXELcJi0jgbZmLBlCMnoLf2jt6Ew8QHC6DnQBEDksVFO3kaYl5tQJig6Y/PfhIQ4iv4ZzmY9nnl1LHsS0IZa9/aQDbdCmy4Fw6XzxRUZ9vOpdDrJ1Uwlc/Yl97/gY9fBoL6GR3YJ2oQcfIaqBb9OSqmIjXzgsxi8F2ie6kjV3SxbNb4No5OnZia7ETQtxwKYG5O0OCyVwHWTLv08p36wTwY/7hSzv8BTGoUjC1pt1/Zzxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY1PR03MB7802.namprd03.prod.outlook.com (2603:10b6:a03:5b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 17:37:46 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 17:37:46 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com,
 balsundar.ponnusamy@altera.com
Subject: [PATCH 0/8] mmc: sdhci-cadence: Improvements and fixes for Cadence
 SDHCI driver 
Date: Mon, 10 Nov 2025 09:37:29 -0800
Message-Id: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY1PR03MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 09173c4f-51bd-4928-bad5-08de207fdc29
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWhkeVZPWkJkQkdKWnBHWWs0VTBPYjN6SHNJdW1lVVgvemIra1RkOVRoSWdS?=
 =?utf-8?B?aUpzZ2Y2RVJlQldoK25iUmdBTE85UDJybjZFZnFaTjdJeWlHdktNaExvV3Fi?=
 =?utf-8?B?cjd4VmpmL2Fmekl6M0sxYncrLzNISTNETGJOWjd4dXpud1VLUnBhb1pJOVNj?=
 =?utf-8?B?VmwveW1xZGIvZWpOQWdiZHhNRDdDdFQ3QkdDbjJxRE1IT0dlUDlYT2V6TExP?=
 =?utf-8?B?TFNUM3RXUC9qaHF2eXlrZmlPb1pKZFpEZVlrblZ2ZVFVTGhlOHJBWjhta0s0?=
 =?utf-8?B?TSttcktMV2g1aUhiMU8wODFrMnF5VkNuQjJmVVJaTjV2OXZkZkR3M2g3VGF5?=
 =?utf-8?B?NUIrVEFsUVl6TmxsSkF3MkVJVHIwZVQ5dTd0K2gwa3UvaXdwdEExcmFYemxu?=
 =?utf-8?B?K0F0YjcvQ3F2RFlsZnZpUDdpQjZ1NDkvQ1lmWkdKWTM4RGdLQk5nMG4zU000?=
 =?utf-8?B?QkFpemt4eUVqT2RnOGZ5OEhsZXl5Z3I2TE90cGM3bE1vcWtmSlkzYVljRU5O?=
 =?utf-8?B?My9zL1lTdzF6VzhHSU5DU0QwMnlDVnlocVpONFA4cFQ2NnNxekRYb3VPTUsv?=
 =?utf-8?B?bE1VQk00ZlkrT2tuNTVEZWhVWmZURW9NdmpKcVpqWm1PRVdDWlg4cGRzUjVY?=
 =?utf-8?B?VGFlUWZKVnRkM25uajN6bVRFS2cxenRKZ1FuaU9rRW9NTjhwcERaOUJlY2d2?=
 =?utf-8?B?dmhnOTNVZ1hScldpTXNadm50TVFneTRGZ203UGdjSnM2S2NCMnE5UDZWMnRn?=
 =?utf-8?B?ZlMrMDhOQVNzN29CQ3cyd0JPcjdTRytWOHo0VlpMc25jZkpnMUNOWXozRVow?=
 =?utf-8?B?ZUdZbVZYb1luQ1NIdmdGdUJCdXZKVjR6NW1oWjVDT1AvVEFEdHJGcXdsMnJ0?=
 =?utf-8?B?MTJnNVJJdnlnODY3ZlBPQ1p6aXZ3SE9zeHpvcXZOMWF0Q3F0Z3kyZm1UV0pi?=
 =?utf-8?B?OThUazI5dm5XK3hwYzFUZTA5Njl2SlVhbEtiYkMwRVNjMkxEQ09IQUtVcDQy?=
 =?utf-8?B?K0ptZkE4MDlUL0N0bWR5dmhmUDc0Wjd1MWFPMUs1MlAraks0bzZqTWZRaEN0?=
 =?utf-8?B?UnhGUnVSbXpBNzZ5WE9aMDFJTi94Lzd0VGsrOE51OGZ6bmJHMnZ0Nnl4RzVX?=
 =?utf-8?B?ZUtlQzA1SG02OExmQzU5ckQwMk1mY1BNYUdQY1BBRThlcTBLeFJSZEhJTW9i?=
 =?utf-8?B?dXVEbXcxWGsrWnZkSk82cTUzZnZmOFp2OCtpYkZRcEx1dFhMMTVXNHFOcFhu?=
 =?utf-8?B?d2FSNWZPd0JzdzBqaUlKQWFieURjYTJ1RHRILzZxU1Rya3VmWERocXNNWFBP?=
 =?utf-8?B?TE9zU3lGeTRGWWIxYmN3VGwrajFsRURISGc5cE13bDZGVVRTSFNKZGlGYThn?=
 =?utf-8?B?dll2UThWdVdXaVZJUHBIaUZXRTVOMFBXMkIzb2xTK3ZibTRFVjNaZ3pGSGRO?=
 =?utf-8?B?UVVPQXlEeXN2UDdDVXc1S1RaUm1sbVZJczdveTJUdVNYMTlQQU9yQlNBa1V2?=
 =?utf-8?B?bmRlQVlzT2dRdGJmK3lxTEZMM2V3NSswWk1aWmRNMm9ENm5WN1pOUTI5WmFh?=
 =?utf-8?B?VDEvMmVydHBDK1F4U3BxdUxvaUJkTzZsT0N6RGNVOWc5RjF3cVh1dmJycHFT?=
 =?utf-8?B?L3hEVHAxV3ZJNkJ1bU5kYTI5dkV2Mmp1THRwWTFzaDVLaTJ2dlkvallBQVhp?=
 =?utf-8?B?dU1tZTZhOTJTYTBCcWdqRjZhQ29yWVdiUWVWT2E2a1pVV1AzUS83anhvVzBD?=
 =?utf-8?B?cno1KzBmcjZQY2lGNHVIK2JLaUJMdHhLU0R5RzBaNGZYZmx5dXdRem9iVDB6?=
 =?utf-8?B?VmNreUhONXRSRzlDMThCaS82UnkyVWkxM0hzZ3Q4VWtSOHZSSjB0R213N3gx?=
 =?utf-8?B?c0dVV0xpWUF3eHZBOHA0azVnMlQ4TVp3QWxmdExObUpacURranZ4TmVCRzRS?=
 =?utf-8?Q?I9vjdP190HRNG1dbhR91ADWxbnwVbTG1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2llSHcvdUNkUGl3UWF5dzYzRXhPRkd1VENaYUoybm4zd0QwcCtPbW1tZzVS?=
 =?utf-8?B?cGwvaldMaWZ3WmQ3OUR4TFI5cjJNeWhldlhhbzQzNmRrM3VCbWM3UGp4RFJu?=
 =?utf-8?B?V2YzcnVUQVpWTVM5cVNtVGQ3d0lZd21oZUk3RFQxZ2VCYnAycVZPeEF2ZWlp?=
 =?utf-8?B?d3QzQWNPQ09jYkhxeUpiSDByTVdVcmZDOTNXMThndHgrY0JPM1N1dmdSeENR?=
 =?utf-8?B?VGIwc2VydjYwRmlwVmtQNWF4NDV1K09PMkI5VU54RWhLVjlBUEp4b2oyL0N1?=
 =?utf-8?B?akVkS2FrMUUrd2NmdHZFYUdiN2NHMndGd0MvUmkyY0JtMU1BL0Nxd1J0SWhp?=
 =?utf-8?B?RWdMZUVldVRCYlI1RU5XczZ4YjJ4b3ZRTnFPY3JodnplL0ljREdqMGhVbzhE?=
 =?utf-8?B?aFREMzhUeGsxT3luUnN6RE9VK2FuMHMrZXN4Qy9KUFJmKys4R0s3S3NwdnRj?=
 =?utf-8?B?dlNMVEU1WTlyVWVZcXRzb0Nqejgyc1ZsVUVQYVNFRHJEUVNqbWFRWDNZeS9O?=
 =?utf-8?B?TitFUFZnM2FaODlyTjlWY0F4R3FTQlZVbWQ5a0gvTi9rMUNXSlZzc2xNM2xz?=
 =?utf-8?B?NytRQ1dnMHVMbTZ1Zm1wckJuNDlMeDVwdVpaN0VSTVdzQlhiUzBPQ3phQmNJ?=
 =?utf-8?B?cndaNlEveUVtZEpicW9rRmZScEZrWDBhVXJCV1V3bXRmaUJvb2sxeFd1RWNq?=
 =?utf-8?B?dFI2ZUhscGREbmphL0dta1pRbGlkNjdOZjZmK29YRlIwcjVyWmJDNFlNMmtC?=
 =?utf-8?B?bkRXN0ZlRU40Z3NjejdqZlpwb3JxMkk1UXlOb1hrcUljTTA2VFJJT2ZQZEtC?=
 =?utf-8?B?bkZxU1M2WU5EV2xRdzAxWEIyR0xQRHhjb1R2T2JQNjYzai9Rd0JXNnI3aDhP?=
 =?utf-8?B?Ui9ISEdpSjdNUmRrY1MzL0NuN2NzOVNtR3FPc2NPMmFqQVlJUG9qQWRZY0hZ?=
 =?utf-8?B?SStKR3NyL05OMmJuc3lSYjNuNHZzUHZ0dUZuZ2l4N01LWXZrTVFzZkZINjQ2?=
 =?utf-8?B?aFQrZEN6anRxaUYrMHp3YmczTHQxSVduNHpHRkQvZHBrODc1aFhPbXlSYTdU?=
 =?utf-8?B?T1loRHNDeHhOYXcvYVEwRmRlckVvb0tQL3E4eFhBTGhtNkxhdzNWOTR2Z082?=
 =?utf-8?B?SGtrOUViY3BTN21FZjd6RmpGMnFDaU9lbFB5T1NXMTZnMWpmdGRBWnhTV0s4?=
 =?utf-8?B?eEo1MkluN25Ick1FMG1Dbm11ZXF2aTZIVCsvdU44dmFpNzlYOGMwYkhLRzBl?=
 =?utf-8?B?MC92Y3QremtBMTNUMDdvd2FPUTJnUDVHcGR6ajRqSnMxVlRINUFabmRXSnpX?=
 =?utf-8?B?Z3hvWGpjNlpqN0hxZnEvNFdPNEhIaTB4MEFyZFhDaWk3eC9uSkJiMlI3b0s4?=
 =?utf-8?B?ZWxKZzNhRW1YeDZBV1hEVU1udGUrdFFkajVOLzJJOXh5ekxWQkFxdGtnNm1K?=
 =?utf-8?B?QU93UTdDM3lKZ2xoRURwT2pFUTByblNLQkthOWw0MXgxN2RZMTVHTEJwdFU0?=
 =?utf-8?B?TW5NcUdKZ1VsbWE2dWJHaHpxeXhOcStXYlp4QUtlYVpGYVh5U1BhL0xJYmRK?=
 =?utf-8?B?U2JkT1U5bXgxQ1pZb3lQV2dXOW9BbHJZd3BXQlRoRWc4azZkWFEveUdtSm8v?=
 =?utf-8?B?YVRlV3Z1emlhTThtUjh3cGNPanRId2s1MmV2blJjZ2k0SThqa05jbDA3UnNX?=
 =?utf-8?B?QXBsOEhvSGsycDltMDJNTEJPVHA1OERrSGFXKzV0QXRicDNJQ2MwSWo3RGVL?=
 =?utf-8?B?NENVNGVJWHRqdGdHRVRaTUR5eFgwR1JHeEdrb1QyWlR3bTZzWEtoVHlvTkZm?=
 =?utf-8?B?RUVZSG94aUZEckx5TkpVRHdKUVIzRWZseEU0dGpGV0ZjY2Q1WUdXOVhRb1dn?=
 =?utf-8?B?V2RHUEZSNkFKVkNoemhBZnMxMUNzc1RkSXVqeVJON3pUVHNRcXVqcXN4UllC?=
 =?utf-8?B?SEZ4eEg5WTQrbHZTR0hNQW9NUXFBckxHaU5ZTlJiL0VnMHZSM1ZBUEFFcGdp?=
 =?utf-8?B?OTltOThnMlNSSGoxQUNXMEpob1ZCMUJRaG5oZlJWRTVDTHNQRVQ4Ri93RG9Y?=
 =?utf-8?B?eml6ckRhemF3eXdLc29ia2d5RDBhOUptd2ttSGIrZXh4elJmcWlxQ2VZSFNC?=
 =?utf-8?B?TjRubExGQjAwSjFJMk5ucFAxZFhtKy9HYitKdzlwYXdqb2RkWDlOMnZVQ2ZT?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09173c4f-51bd-4928-bad5-08de207fdc29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 17:37:46.3687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf9fKWLwjfZcJxyiyleocFrBqCC5MAIiybAcLdP5tXtMJLbEqKAAzeKQYyjzH34RZhg/JfHb5RMqdUSSAn5y4VnuOvKfhTEggkMN87+k9kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR03MB7802
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

This patch series introduces improvements and fixes to the Cadence SDHCI
driver, correct timing mode handling, device tree integration, SD/eMMC
tuning, and compliance with SDHCI specification updates.

Summary of changes:

- Add reset control support
  Ensures proper controller reset during probe for reliable initialization.

- Respect max-frequency from device tree
  Uses the max-frequency property for configuration instead of default
  hardware values.

- Correct timing mode and PHY/control configuration
  Refactors timing mode selection for SD and eMMC cards, implements new
  mode mapping, and updates PHY/control settings for UHS and legacy modes.

- Add SDHCI_SPEC_400, _410, _420 defines
  Introduces new specification macros for SDHCI v4.0+ compatibility.

- Use hardware version field for controller detection
  Switches from compatible string checks to hardware version detection for
  controller capabilities.

- Enable software tuning for SD and eMMC
  Extends tuning logic to support both SD and eMMC devices, improving
  reliability.

- Fix device tree property naming conventions
  Updates DT property names for compliance and corrects minor typos.

- Add DLL master control and improve tuning reliability
  Adds support for PHY DLL master control and enhances tuning robustness.

Please review the series and provide your feedback.

Regards,
Tanmay Kathpalia
tanmay.kathpalia@altera.com

Tanmay Kathpalia (8):
  mmc: sdhci-cadence: Add reset control support
  mmc: sdhci-cadence: Use max-frequency property from device tree
  mmc: sdhci-cadence: Set controller and PHY speed modes for SD and eMMC
    cards
  mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version defines
  mmc: sdhci-cadence: Use hardware version field for Cadence SDHCI
    controller
  mmc: sdhci-cadence: Enable software tuning for both SD and eMMC
    interfaces
  mmc: sdhci-cadence6: socfpga: Fix DT property naming convention
  mmc: sdhci-cadence6: Add DLL master control and improve tuning
    reliability

 drivers/mmc/sdhci-cadence.c  | 100 ++++++++++++++++++++++++-----------
 drivers/mmc/sdhci-cadence6.c |  82 +++++++++++++++++++++-------
 include/sdhci.h              |   3 ++
 3 files changed, 137 insertions(+), 48 deletions(-)

-- 
2.19.0

