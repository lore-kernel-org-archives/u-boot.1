Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA84CCF9FF
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 09:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1735E83642;
	Fri, 31 Oct 2025 10:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ZYL66rr5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 814AC838BB; Fri, 31 Oct 2025 10:35:22 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A6F8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 10:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aWMd/VrmNA2kJHGAWq2CH0g0JduhLCSNDaKyCwNpeF1MMzoOlY89S21WMCJRRSmTvU6e+PHGiBfoSZKZc9+8a6Dp7l/thLffqXprP1s4RXt87t87TaS7DmsHNmSpq7b7GCriOLuABE6dmbxThxRoEf1yKxTxrIth2lRdzoToki1mLWxGS0QEOK8OpeiZORms8pqX6Mm1paVNFuZ8TweApuEq1onrMiVuhoRwND7bN5UFMIa8SL/fTBqI+RfIgcg0GqXdKpmuOxMbj7VKj1jxVvUO9S6bd+cpyZPvbvsKKbXLYxfdG1VbYNtLB4BX7BlUd8vZgJiyKvs+fuqO8S0czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8FhrYshC/tcYW9XDNGeHGZ0BORCm+UpHuJQxifnpLA=;
 b=gr78y3G8xMjdEIv99J2qgDmt3hDcYveRzMrEg2RCiRnnvZ/E3JVd1w3aOtXCEVb8rSFlYB1l8c8tmMbjnOqms0FUzURXmA0OPBEsu6JchGwj8FavtV6wsubdHzx8oxlKCFbIbQaw+CJLLzKKLtEhD3sMvCBRsXoAyUwYrhZVEaS9VHdXBB5AebmP6ngjn6wp1lcmfLo8YArr4j2+kdHBKPnWz5eV4LKi1TuDZ/YeOTr29U3xoFB9LR2v0wF8x5bwNQTEvJj8z3CZ33UQyEMFh7pvUoTU3Uc2vO1oFb+q7VGjvzK84/SKXDEjvBKKX8EnAQkHCJa123XqEIddCRM4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8FhrYshC/tcYW9XDNGeHGZ0BORCm+UpHuJQxifnpLA=;
 b=ZYL66rr59zpEQxy0UvVOoomZ6M1bVfUTlL6RdC+2VwjYAu76Aim2IqdyZO/ENZi7oS0CtFefOTXKdTPLszZfLGvwzIfXVguDcm69WjEjRriE7rSdMe9Uw3Rf64rHGfQhI1QCh58DUmcqKJPLdVCXCJPCFp3Q2bgAyBYr828YGLQkY/SQDtHCWBe83LvlfD3VfDUBEp36znw6XPkHWn7MMc/7iH3J6CQRjDKvxXZLWTJKnFXlERVHfYJ6egnaROTFhH7faUZz7ItjTRVALy7/AmfDlcy4ZCdY4yQfSscGkkzHZikgk/xURC2QIcJSfxichi/tyzZHdMoXCQYEwkQrxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 09:35:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:35:17 +0000
Message-ID: <f7068c43-db26-434a-b039-9a70e210e395@siemens.com>
Date: Fri, 31 Oct 2025 10:35:16 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] tools: key2dtsi: Write out modulus and r-squared with the
 correct length
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, "Hans Gfirtner (Nokia)" <hans.gfirtner@nokia.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 97081d2c-0cd1-4684-1308-08de1860cd31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjA2UW1FaFJsYW1VMTY1dDhlZ1pNSURyVFZoTFZONHA1N25lVklYNjVGUXlw?=
 =?utf-8?B?LzhGcm9UNW93bjRyMTFXV1lpVlZkaXhRYWNsQW9nT3QzcHA0RWQrU25DYjFq?=
 =?utf-8?B?WXphL2hEN1ppTFBjbGJ4R2loNkRQQURqaFM2VzZGaUMwcEN5TjhBNHZSa05W?=
 =?utf-8?B?YVl6Vzl5VEhaYkRqR0Y5TU54eWNtdzk2bWJZU1VsaWkzSkhwYzZKcnkyN0FC?=
 =?utf-8?B?ZHJ2YVBNa1o5blZiaVZRcU5HRDVvTy9JeDd1NzN5QkpFSklDWm03MDNqRmYz?=
 =?utf-8?B?U0pwZWhKWk5LTnBSZHNZbStIUEtDWnl5dUFUVkdIYTJhaUsyZmVYYmZZOWxR?=
 =?utf-8?B?eDJaNVFwcXF0V1VCc0ZmT1Y1Wll4Y2RUR0pkV0dUcXhHSnpNN0hPWFM3MGw4?=
 =?utf-8?B?QnZJK2pnTENvaWFLYTZnajhYQXVTVXpMaEdKWlhFSDMyWFFiMDJwSEt5QVBN?=
 =?utf-8?B?N21jM01DQmRkb0FYWS8vcG50TEV2TExOczA0dkx2eUhpYURvSFBmUTYzOUdu?=
 =?utf-8?B?T25kWTdWUFlWMVF6QkYzSzJUdWk0OUVlZGNtNVJqRkZ5Ky9zTXFIdGtOdXkz?=
 =?utf-8?B?QkFRb3JJV2ZHd3BZenF1aisxYUxVMmZ2WWV4MmRPTGdVSTZqTm5nOTZNeXJG?=
 =?utf-8?B?c1MwRFVpKzVRY21uZis1TEM5ZWRUNi9JRjU0dHE0enQ3K1ovS0NjVFFmcklq?=
 =?utf-8?B?SjduMXZPeVc5TXFrbTBsMzRrTTNvU0R4T1J3ZWJlN2ZHd0FRZ1dNeGZWYnFD?=
 =?utf-8?B?dUErUU1zckhSN2plcnBnRU1WbzM3b1dCV1BqbG5JZ1dDMTk4bUpvRExRek9S?=
 =?utf-8?B?RW9iWTBMejFoSFZWaEI2M0pEZ3d4Q2c0cVFIV01qTjJHTVNBeFlIcU9HRkFt?=
 =?utf-8?B?ZWw2eGNvNVVvTktSREk1Vk9BQ3lBSUwvNVdDN0REaFM3ZTVaakNlUHNMUVBI?=
 =?utf-8?B?R0pVV2V5YXU0YWF4cWpxZGVjRWtXR1hyOExqU2gxcGpCd1Vuc25VaFRaREw0?=
 =?utf-8?B?dzVLdHJML3lYeTlwdGdsNWp5cnNkbE9RdVF2bkRERlk0K1dzYjNJUmhaWDFE?=
 =?utf-8?B?RklNRkNkcmtHdXYyTjF5cU9vZWt0NXBJVzJIQy92amRGMStDNlJIa3g4UllF?=
 =?utf-8?B?UXMrSXhYTDk1ZEYyNXJDM3VFNVExR29pRHI2aC9tYXZZekwrWEt3MUxMeFVU?=
 =?utf-8?B?b0hSMnI3dHBjOEg0VWZ4TUVUUFlNdEcvRWZJbVdRUHpieTViay9JUnFXZnlW?=
 =?utf-8?B?VGQ5b2c0UHhFRllhME84eDVOZG5DUDl4ODI2L2NPVm5KWng1a2thZFVZNFFm?=
 =?utf-8?B?Q2VqeGdtUTRDaFhnV29UMUpQK2FYOUlxcHlybUxYQmxNUDFiY1hQYzF3UUZL?=
 =?utf-8?B?RGRGbllHbFVFWTJCWVRrbWJGcGRZS081ejU0dmVjS29kUkkzQnphb1NtTXcv?=
 =?utf-8?B?VGs4N3haYm4xT3BvWnhEejZINUdLNW5BeHMvVWEwS2Y1YTJreGVtSEFMK3Zp?=
 =?utf-8?B?NzR1UVlyMnkzR1ZsMXI3Vm9GQUdxNUN3K1hRdmUxY1QvRnhWa3RaTHdCd3hQ?=
 =?utf-8?B?ZWNrQTdLejJpUkQzU094ZFZrZ2k0L0tLUG91cElRTkVCbXFBVDZFblB3TkhZ?=
 =?utf-8?B?WTVDK3lMM2pqUEFjVXBILzhHY1IyQlFzV29YOVRnMFJ6ejl2alI1MXV1V0xj?=
 =?utf-8?B?d3pyK0RFdzdvSStTdFpjS2dnNHpRM2ZZNlduRUhXRUprREwzeE9NNUV6ZVFM?=
 =?utf-8?B?dlRjQWw3K1dzVGxTRFRSeG45aEh5NGRoTEZxU29tU056MjZ3RzRHQXBYcy9U?=
 =?utf-8?B?ak16SzQxZGRFczU3L1JOMVZyYUQ4VEpqaURsZHEwVWRid2sybktHVzlodzIw?=
 =?utf-8?B?WTRjZlhIeTF4VUdSc3hIWVQydVpKbWRsOFNhczBBdXpzY1lSbTJDblBhcmtQ?=
 =?utf-8?Q?Rbn4q7lfH7gigg4eWfKK70ZWc8WrDYRm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllkeGVReWdNdlpzb00wTitwK29ZVVVoaUdyUXZtSFhvOTJiczRuSExkME9Q?=
 =?utf-8?B?SjY1RmhORFQyQ2dYaHRNSk01RVVpQmJzbGo3WDZnN2tjNTl6RkpleW51dmVs?=
 =?utf-8?B?Z1NLV2Y1UTBxRTI3OFdyVmVDcTZpN3lHdUZ2MWFoT3kxNFE3SjFxK1duQitX?=
 =?utf-8?B?V0pLZFczWTZIeGZUSkJNdCtpWXNGSS9pTmk3elQrZWtaQzVGQUt0R2RXNVk3?=
 =?utf-8?B?TmE0Y2s3UmpWYWJmTzJBT1hGem9oNDJFWUMwMU93QU5nL1AxZ1FadlAyYThl?=
 =?utf-8?B?N0p4dGU0SFVuSG14NDdQYWVSUFZlQ3lqMTQ1a203VGswNkkvM0U3QU5Gd1hU?=
 =?utf-8?B?NnloV1NFRGVsT1cxNEV5dWMwdHNQdlJUeTk5UzNxVnFPUjlyVS9JZDROd3Q1?=
 =?utf-8?B?VGtlbkR1ZkllQ2JHYlZsY05LWUh2bm1HSUFVU1ZVTVlQOEw2M0NSMzhCb2tF?=
 =?utf-8?B?SEJCRWpnUzBEVDlNY1BySUZuMzUxSUpZZTA2TmdwMysyM1gxTW0yZGxiYTVw?=
 =?utf-8?B?YjZCemIwSTF6OWNyK3pPdytCbEJnYkVqYmgyQnpQT2tza2YwdW95L2xlNSth?=
 =?utf-8?B?cVVTSVp1Szd4a2VJelMyMHZheWhUN2crUVZvTEYzNU1xUmlCbWhGUWhxc2dq?=
 =?utf-8?B?YjdZV00rRjMzTzQ4Mytad1FuRWZMcWxhKzh2bkdqWnFiVHRwTmZvQVdINjg2?=
 =?utf-8?B?ZURKZVI4SnhKdGkrVzFTdExMYXgxRDFBL0NtU0FMOVozODRkTnpnU1FJMFNO?=
 =?utf-8?B?ZHRKUXVLYmcvQzEvMUgzV1Y3b3lsbTdIYkRLOEd5RzJVMHVUcWlsK09BUXJV?=
 =?utf-8?B?eTU2dzdxVGJGY1NIRjBzejVtV2FOS2pPeWhnVGpXa1VzU1R2dDIxMHY2Vmx4?=
 =?utf-8?B?V0ErSERjWERmYUp5T0xaVzJWZ1JpWjVMbXFDcmxrMmFYSWlVZWtJMWdFTzh6?=
 =?utf-8?B?S3kzR2tDMFBqMkN6TUkxS1J0ZzFkVmJuT0RSaitEUzhJdHhya2g5Y2xvOTJS?=
 =?utf-8?B?Vit3bktrYm1sS3FBRkNUTTNlSnFJQkJzWkxremZkMzZQZ1cwY0FTYTdGTUlP?=
 =?utf-8?B?SzFsUGYwbGJNMmE3cGJKNHF1UHhRV1BMSjNZUldZK0MzbmZ5b29OczJrZVRT?=
 =?utf-8?B?VWIrOHgyVm9pejdQZG5kNmZBeGxyc01PZ0FuYkVxVkNVRUIxb2xxaTd0UGNS?=
 =?utf-8?B?dUdqT3I3Q2ExN2M3VW1YTHVDTmpJLzMzL0wzeU1hWVlHM08rZkhEQWl5VXFn?=
 =?utf-8?B?cGF3aEhBa2I4MFVjR1hUMkg2UHpwWXRnb0FtamJTdFo2WDhQR05hSHJkY1di?=
 =?utf-8?B?NGlKZFpFYkNFaFZuYTVSNTZHenVsTmtwQWo4YUJaNktkSzlVWE11LzV0QTNT?=
 =?utf-8?B?SllHZnZUdEtuL1hxYWNianIzUjUzcmFxTUNRM0lDVy9hbU56M2RWSTQ3YWFl?=
 =?utf-8?B?cXdwd1lYY0pyQW5BSHNYZlJCOWRJamhzcEM3dzhRdnlobC8yV2NIUE9TN25t?=
 =?utf-8?B?eFVSOUY5bTJuMU1VQ2ZQdkJ2cHJldENWL0tZTzUzdVJTanJDc1I1LzR5NTdj?=
 =?utf-8?B?K0J4OWp0cDU1dmxXb25lWFhUWlZqdjJiYTM0RG5EQTk3ODRlNDBIQkVFRmt3?=
 =?utf-8?B?aHpBTklkUDRHVmt0citZS2h4TitKMHovNjhBbXFPakp0UXEwTStNc2tNdGYy?=
 =?utf-8?B?eThnWDIrY3phYkJveUU2SFpVZ1VxUVk0dEJYMGdiWVUxUmlEOVlvTkNPTWpm?=
 =?utf-8?B?N0FYQjhQdmpZRS9aTWVtWG1RbmZUL1BrRUJmaUNjeEU0YSsxS0hmWm5IL0lL?=
 =?utf-8?B?ODdzVjJhMkl5cUVqdW9zeTJpTlFuZ2xEZnJ2c3l3dmNTRmMzSzBrRlAwOTRh?=
 =?utf-8?B?cUh4SVV6cWRXUlRxd3Fxc1VabGE2V0cyZnBkSjNaSFFHc1A4enZKVGlIbVhq?=
 =?utf-8?B?L3pnNEg3dURKNGNsa2F2bkV5TmRtZkpLa2oxdU11Rm5XMUhRWkFvQlhrL3Y4?=
 =?utf-8?B?bCs2end5c00xNERSWUVTdDc1Wityc2VFT3ZyQlR0aFJ5WGdMZ3ZrUWp0THhX?=
 =?utf-8?B?ZkRjaE82VjhyM1pzMlNacXNvV0tVT0tXUE1VajVmU3BjY3pzNkFaTFA4QlNZ?=
 =?utf-8?B?VTRheU9pQTN6SEdHSldGYnhSZ0YzTE9SRkl4TlBhQ1NsbnhiQkx0UXdtZmhW?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97081d2c-0cd1-4684-1308-08de1860cd31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:35:17.4619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URV/mI9JAi0Neq/h1obYOeYx+bsWSwudLh4UN8gGiEVyvrWINJiEPm2l9oIY4ZnL4nFiyK/FrHIBHbdt8cb/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6924
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Align the implementation to rsa_add_verify_data() by writing the modulus
and r-squared properties with the same length as the key itself. This
fixes signature verification issues when one of the parameters has
leading zeros.

Reported-by: Hans Gfirtner (Nokia) <hans.gfirtner@nokia.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Hans, please validate. I only had a dry run with your test key.

 tools/key2dtsi.py | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/key2dtsi.py b/tools/key2dtsi.py
index 1dbb2cc94bf..320ea930a97 100755
--- a/tools/key2dtsi.py
+++ b/tools/key2dtsi.py
@@ -11,10 +11,8 @@ from os.path import basename, splitext
 from Cryptodome.PublicKey import RSA
 from Cryptodome.Util.number import inverse
 
-def int_to_bytestr(n, length=None):
-    if not length:
-        length = (n.bit_length() + 7) // 8
-    byte_array = n.to_bytes(length, 'big')
+def int_to_bytestr(n, bits):
+    byte_array = n.to_bytes(bits // 8, 'big')
     return ' '.join(['{:02x}'.format(byte) for byte in byte_array])
 
 ap = ArgumentParser(description='Public key to dtsi converter')
@@ -39,7 +37,8 @@ key_name, _ = splitext(basename(args.key_file.name))
 key_data = args.key_file.read()
 key = RSA.importKey(key_data)
 
-r_squared = (2**key.size_in_bits())**2 % key.n
+key_bits = key.size_in_bits()
+r_squared = (2**key_bits)**2 % key.n
 n0_inverse = 2**32 - inverse(key.n, 2**32)
 
 out = args.dtsi_file
@@ -47,11 +46,13 @@ out.write('/ {\n')
 out.write('\tsignature {\n')
 out.write('\t\tkey-{} {{\n'.format(key_name))
 out.write('\t\t\tkey-name-hint = "{}";\n'.format(key_name))
-out.write('\t\t\talgo = "{},rsa{}";\n'.format(args.hash, key.size_in_bits()))
-out.write('\t\t\trsa,num-bits = <{}>;\n'.format(key.size_in_bits()))
-out.write('\t\t\trsa,modulus = [{}];\n'.format(int_to_bytestr(key.n)))
-out.write('\t\t\trsa,exponent = [{}];\n'.format(int_to_bytestr(key.e, 8)))
-out.write('\t\t\trsa,r-squared = [{}];\n'.format(int_to_bytestr(r_squared)))
+out.write('\t\t\talgo = "{},rsa{}";\n'.format(args.hash, key_bits))
+out.write('\t\t\trsa,num-bits = <{}>;\n'.format(key_bits))
+out.write('\t\t\trsa,modulus = [{}];\n'.format(int_to_bytestr(key.n,
+                                                              key_bits)))
+out.write('\t\t\trsa,exponent = [{}];\n'.format(int_to_bytestr(key.e, 64)))
+out.write('\t\t\trsa,r-squared = [{}];\n'.format(int_to_bytestr(r_squared,
+                                                                key_bits)))
 out.write('\t\t\trsa,n0-inverse = <0x{:x}>;\n'.format(n0_inverse))
 if args.required_conf:
     out.write('\t\t\trequired = "conf";\n')
-- 
2.51.0
