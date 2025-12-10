Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FCFD2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:43:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C342C83CE3;
	Wed, 10 Dec 2025 08:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p7tMjlhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DEC983CEA; Wed, 10 Dec 2025 08:43:27 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1737083CD2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQKSooQtYOEdhdKFhVbKcvJ+j/zChSSxJdLlArkPlQBhGI/cPKOivDGKnwlMhP7ugPNM4+bKW954PFrwbiqbfpLTnWRLPBQ6QFYb+VdiS5C8BdCRQ3gEhPKukueEQr0MSaCea9gzEcZ3IKA0zC1gBnSZgeL23mXoabqqhqnoKUt4LD7yVVjoKnd50i2/h94CliKXictWhHSUKQ+dR2q0BJ56N1Z8392ZB5hWLlFeOb1S2W6xBuqR4UuB9/HykEu+05/Pm+a/qGL8kxn43YRj45KXjTKTTTKIh0cOeeBtBV/+xCF/ysiVL4p4xQ6Cw+kS8ZqhRKx1e3Ko0A1KZcdk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0+uOUc882yMU9dffh/sCoHqKJ57QZxHxGgNWhIzl/g=;
 b=l9WdI5YtmEBgEVYB+DbzMIXfZJZP+Yj0PJilHuRiyO2hV2/gMG0wJmkHU7PdRViyeIZ3wVEVPMoBaElljEabSj9lgEEfwrzp9bFXITP8Qa+NEsFcXjC9XPI0VtRdUUX/BXwUyAA/AWN79uHqMI8PTHWCw2v2RUAHnCmH/fOBTYdxRbhYJWBNHjtAVJ0Du8FJ6ajfNi60XXQ5AOP/U/azKwPvX37+WTpek2dh8nxeXE6srUyT+vF6t+0Vy7qCwvBVn4WbnnRbfAIoCCmb9fI1xV4NLht1GFy255pd/F4RQLyHIov4LRE5CWHehYA/bobdcroMLzbseBjPkap2FozXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0+uOUc882yMU9dffh/sCoHqKJ57QZxHxGgNWhIzl/g=;
 b=p7tMjlhuIQPBKh8CvN5QGAwH/aRdQIZWrgx2QAJajYUfIOwdFingq0lExc8P///qUY6qT13ihm2yHo9GG5TH7byug1gtQH40gejBJ3RMK9KIsmluIzn+oFq/OYzjX7CwwBuVHvoma4vXNzBrc5yuUNYk40dzP3hXzjGzy1kHiAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:43:21 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:43:20 +0000
Message-ID: <7d5563de-2a41-426e-83bc-910847eafd9b@amd.com>
Date: Wed, 10 Dec 2025 08:43:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: mbv: Remove debug UART support
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <6eaad47c30990ffd230d21c7158bc7234cda1752.1764747346.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6eaad47c30990ffd230d21c7158bc7234cda1752.1764747346.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a0180b-d922-46ac-f530-08de37bfca42
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vkt6aFV6c1dXQ3diY1ZBa01VOWZ0Rlp1UFBRVVQzT012T3VEd0l6Q3pjQ1E3?=
 =?utf-8?B?YS8rc0YybWVyQ3gvem94a1A2OVR0UUFsR3d2ZU1UUHI1c0dYNU41aEpTWEVy?=
 =?utf-8?B?cEhaVnJhYW4zMDhWbVpIYmZyalY2bkV6bGowVG5teXNnbkZwTmhwU29aMHFn?=
 =?utf-8?B?T24ybTE2ZUN4V1kyNHNjN2FsNWxXQ0RGalNta0diRXZkOFdoQ2NYM1BnUXE5?=
 =?utf-8?B?V1lJaDR5b2s1QWk5ZGVFaGNReVBmNXlPWUp1NnJKYXJ2Z05KL3VzN2kxM0pv?=
 =?utf-8?B?c0tJQm5oTktpcm94UWVBNE1IVm50QmcrUExEekhWQmR5a3VJRGNwT3hwTDJW?=
 =?utf-8?B?RlRGK2VxT1JKc1djYWZLR2x1UW1zbU9zVFdKWEEvMHlodXBYTlZoVE5PcFU2?=
 =?utf-8?B?V0c4U1RPeU9SakJXVnBVSndRelNrbi9lY3c2L2NXb1NLbWlyQ1NpUElWSnRX?=
 =?utf-8?B?Sm5zbXUyREVNeXYxTDN3SE11VzRFZGRtVkkvcTQxemgwWE1HeE1halBJbHgx?=
 =?utf-8?B?Z0wwd050RFFVZGVjVU9kbDB1TXEvdGU2YkpOVlhURWtLWG9lQXp5dUxCdmd0?=
 =?utf-8?B?Mlk2ZitxV0wzZGthWUY4L2hYODlVWm95czVPRVRPZFB6Sm5CSGFyZ3YweG0y?=
 =?utf-8?B?cEFZWGM5RU91WWRZL0tsSXdtMXVDZ3Q4R2JtK2dZMHYrTVEvRkdvM3kycU02?=
 =?utf-8?B?SmZWNjBHYnlHd3RYa0NyajkzTDZucHBUMEJESVpDNWdMd05YYVV5SXY3cG5W?=
 =?utf-8?B?UGg5L2JVYmkrUnl1VWVVMldQU0pkWlZBREhkdHdRNEpiWmNTNDEvaG9Qd3Zs?=
 =?utf-8?B?QXIyRjhPZzJuUVVvUzBRdE1mZ0NnWkRoTzVmRHBnekRzOXFxMnZabVFkL2Yv?=
 =?utf-8?B?RTB1cWVqVEhmOGxkZ294UGlCMTJ1MDJJMHdiOGt2ZTJEcUkxSXNRVk9XMWZ6?=
 =?utf-8?B?TGNiYXdua3Z2d1RFZEhGSmt3d3dKTlFEYnQzY3pzZDVvdjlXaGxIRnNuUCtp?=
 =?utf-8?B?Y3VIbk9BWUFmdU8yK2JhU3NDYXJWUnRka2QxVDRQTmpnWFdXanp2M09nRnZs?=
 =?utf-8?B?bWdMeXJnZ3R4dzdaMlhvdVFTdWc4OStnNmFSYjhqK08xWndJMTkxbkgybXpp?=
 =?utf-8?B?aENIbmluU1JHRDljWE5EYyswSnZvKzVGNVJqWDB6QmZ6WjVEaGxUTFZkKzJX?=
 =?utf-8?B?NjFxUUw4eDRUWTFvclZtYUE3OEdsdjlHQS9kU0xuMnJqTG5XbGdqc00rcmp0?=
 =?utf-8?B?V0gyVHNxVTYzaHU5UTdPRGY1SmN1MkZUNzUxY3lhdi9YNlgvUnJVL1ZseVRU?=
 =?utf-8?B?d0Y2Z2RERjBIQndEUXdPbWRmdDVsQnFFOFFQKzdNRmJiYVF4Szk5ajVjN1do?=
 =?utf-8?B?MHVtSEV2U0ZEc3VMaW12S3lkdVcwYkp6NXBJSThBTlN4RGJoK252bXMwZDZ3?=
 =?utf-8?B?V2c0T0NvVDcreDNDN3ZoRnBheG1nYTVJaXVLV0QrY0hDOFA0d0pCZXJ1cnB6?=
 =?utf-8?B?d1pSTG5NQVZjUjV1MmNQZ0pKTVFNOGpRNEU0eERSSjBvK2FiSTlqM3hBQy9V?=
 =?utf-8?B?bUNGQ3NEOFlSalBjYThCZFdweStiNG1KR0FKQVBIWGNkWHYySXBWTXZjcGVt?=
 =?utf-8?B?UjBubHFMNjlPWExLSnd5Sm5aYVBYRmtRWnJhcHR5UXR3MllKeXJzWDF4dHZ5?=
 =?utf-8?B?czQxNFBBSVdGTzJkS054OFBodzIrV0FKMUErZGlmSThjcXVkaGZwaGcvdWs5?=
 =?utf-8?B?akhqeTRxbDVKQXl1STVpY2N6MHJUWXdvRmJ6YytlelhORmxmR1F6dW1pZGNI?=
 =?utf-8?B?amREQzlVN1BMUEJXdUptS1ZEUEhPSTZpNjh4UDhoaWxMOTA4UWp6QTMrYWQz?=
 =?utf-8?B?YU4rTVUxN2FjQVVodkJ4SGJjaHZOcDRseWpNakpVcERNY0FBcHNIL3J2Wjg2?=
 =?utf-8?Q?iPYIoDGz7E15S8lTihNGcdKdL/OCY4pB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmMxWFlRUXRWM3V2bmxpRlA0VFFvUmEvVTFySjI5UnBPU2k2bjhkZVYwT3ZL?=
 =?utf-8?B?U2NDdmthd2FSWVlNZVRkSzdCWDF0MXVwK3pCTXhhUTFlcXFScTl5aFVjNmEz?=
 =?utf-8?B?bTRSN1pDTHVxM0JudVh2ZTJYajlUdG1RU1VXUm9uVmlndWJDdFNxUk1hNUd5?=
 =?utf-8?B?WWZISzZERkE3Q2Z4VDlibFYreFVud0tpQ09aQSs3YnZRbFJaSlExUzJKdHFS?=
 =?utf-8?B?aFhWRVdxdHZJVXlmdUVHdDlZMGZOL2JRcHBwa0JYY1VmbHVEbzhST2ptNkRq?=
 =?utf-8?B?TmY3SXFJc3B2ekZoZm1rYzVLNVc4M2pCMzB0K2NuYjdHNENydnl6aFlOL1pK?=
 =?utf-8?B?cmN0a1pWY1oyT2RjbUIvd3dVRWQ2UFR0VGhNTXV6NGJ4Y2dFSGE5UDFaWFJK?=
 =?utf-8?B?L1FIOUNScFptZWYvcjV3emNJZm9nRnB6aWxxb0thWmxhKzJtdEk1RzcreWp1?=
 =?utf-8?B?SVVFUXVVdy9qWVl1ZzFDeXJyNEJsZnlQQTc4SUw5TDA2ZWlBL3Z0TkZYdDNm?=
 =?utf-8?B?OHFFV2ExamRjQTBGYi8zL3VleTZFZklhZmt2QW45KzBYejRPYVgzRkRRcEEy?=
 =?utf-8?B?UXdyU0VGcG9OZ1JmREJocGg3bUZocWVnM0pvRldUTEpSeDZBR1RybGdvQ1hD?=
 =?utf-8?B?eHhhcTMxMWN6UTVpbDZtV0trK1U1WURlSlhrSk1HTjI0RjhxclRTMjc5TUgv?=
 =?utf-8?B?OEMycGJZMXl6ZVdOSk9US096NmxvTlNkR2FsKzZvdU85WmlXVkd6cGhLeldR?=
 =?utf-8?B?cVpWSGh3Y2N5Q094djZoY25HOVJleWhrSkNhRVp0VnVHc2ZyVzd0SkFHTFhq?=
 =?utf-8?B?RlNLQncwSmpNMDFGMWdhL1huK2pjbWtSWHRKcHY0VnM1STlvMFNJaXc5WnB4?=
 =?utf-8?B?UC9tQytqNXR3N21PNVpVVUFmSjh5Q2xTVngzeVFzbkpFV2E3eTJmL3VhQkds?=
 =?utf-8?B?VmE1VDZWN2N6TzNmREFlYWc1QllFd2FBVTFWYzl0VnNUR3dyZk5qYUhFa0Ez?=
 =?utf-8?B?aDZZRklMcG9oNlpra00yU3Rxa1FKQllEK0FIanp4Uy9PN29oZmdjVmkyOVJH?=
 =?utf-8?B?VVJpQVNFTGhSU1dxcms2N3NZMXFEblR2VE1QdDdjejVSdkN5UDlpbjV5NWlB?=
 =?utf-8?B?WkJKRWU3VUZQK09OTHVsWi9WTHRtTlljTHV2OGZKY1JFTEFTOG91UGovZDJu?=
 =?utf-8?B?cHNrcHRUUVBVZzAzVW9YVmowUm80YVhOT3hEZjZhU1dZY0Z3cENOQUVpMms4?=
 =?utf-8?B?M2lkbjRFOWZNN0lRUWlFcHlLbytadmY5UkwwVEROWnBOM2lnb0dWc3FPUWdZ?=
 =?utf-8?B?eThieC9Yb3ZvTEVvVCtBY1VxTzVWd3hkRnRZUlZZaFA5WUJ6RnNkQ0x5aGU5?=
 =?utf-8?B?RisvK1N5WHppNklLY3ZxNzZPdlo1cWV5amc1bEhIeVZnamJ3SGF3aHNIdTF2?=
 =?utf-8?B?Mkh2ZUcvTlAyRXBJOHp6MnR3Ti90OHl6cVFTYVRYL0duSjROVTN5SDdsSGs3?=
 =?utf-8?B?bU51S3ZhMzFwWlVaYjJzRkd6akxrYkhoZnkvYmgyTWZnNG9kNkwyelJKUFBs?=
 =?utf-8?B?SkNvTzRUZXYwdkFTWnU4T0wrcmhKRkJteE4rUzBqS1VEZ0o1ckY4YXEwVmgz?=
 =?utf-8?B?ZTlqWW1MQ0IwYVZWRVV6OUNaWTB0Mkl1NEJFOWFxTTZIa2pEb2ZDNkFUU3I2?=
 =?utf-8?B?SWRBYnlHNXFWL20rT3ZpTkxWcEJnRk5pRVF1R0JEM3R3SUQ1N0dCNEtxODlP?=
 =?utf-8?B?c3dpUjFZUnFabGpTK0ZtN08wM1RNZUdZazJDWGprVGVWbzR6ZUFpRXBZM3g4?=
 =?utf-8?B?czdGZi9FTHJPNXM2SU9Sd2J5TzlIUEhERWZJVVptVVgvZXR2QjhaUDN6VDFN?=
 =?utf-8?B?MkxiT1AxdW1CR3JwV0NlY1BJOVkyTndFSTN1MTVaSW9RL1l5c29HdTZwdS83?=
 =?utf-8?B?N1YyUUlyaWV6Nk5tbjVpMXdIVnU0dGFzMnNBVUd5eDgreG5EZlpSbGlibEQ5?=
 =?utf-8?B?Sk54MzVJQmRxbzEweDY2TUNBdWI3ZlJneDNzZ3lnZVR5M1pzUWVSaUxMaHAx?=
 =?utf-8?B?dWlOREpNWllISythS1ljY2JQQldNWVMvUlpSWUhKUlpZSlJ3M2doMUdSeExo?=
 =?utf-8?Q?T4j3ykXo3X7dGRbepCb6wwqG3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a0180b-d922-46ac-f530-08de37bfca42
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:43:20.7563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBxhblLSiTJtH3tlkXodrLNYPm6PDOUIfAeTsa0iE5oeX2948X5iNPe03FKffwYJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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



On 12/3/25 08:35, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Remove debug UART support as it is intended for development and
> debugging purposes, and should not be enabled in production builds.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index d10517094c61..9e3c44352a15 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -12,11 +12,8 @@ CONFIG_SYS_BOOTM_LEN=0x800000
>   CONFIG_SYS_LOAD_ADDR=0x80200000
>   CONFIG_SPL_SIZE_LIMIT=0x40000
>   CONFIG_SPL=y
> -CONFIG_DEBUG_UART_BASE=0x40600000
> -CONFIG_DEBUG_UART_CLOCK=100000000
>   CONFIG_SYS_CLK_FREQ=100000000
>   CONFIG_BOOT_SCRIPT_OFFSET=0x0
> -CONFIG_DEBUG_UART=y
>   CONFIG_TARGET_XILINX_MBV=y
>   # CONFIG_RISCV_ISA_F is not set
>   # CONFIG_SPL_SMP is not set
> @@ -40,8 +37,6 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_DM_MTD=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_EMULATION=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_XILINX_UARTLITE=y
>   CONFIG_XILINX_TIMER=y
>   # CONFIG_BINMAN_FDT is not set

Applied.
M
