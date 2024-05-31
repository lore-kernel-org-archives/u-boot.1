Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B11C27C44
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 07:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 340CD88270;
	Fri, 31 May 2024 09:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="pi6GPuqi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 461AB883BD; Fri, 31 May 2024 09:35:53 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on071f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::71f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2416C8819D
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 09:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcewVPQcmE6CFDDqPUe0Kb4Fx8z/wW3xl1hJnekrrOcKd6FqEQvkUh8STKQDyBUgvRKHYx73kHsNWPM1snRzS3Ymzk69GH5+5Fmdsar9cc0TK3NQahq2JSbJc0xn5u7nC/InYb20IQtRLlVEbcIukbUcSHK+ZqC28fq29YE/vCJhiE8jhmwufxlAEoNaOHihPk0ccDDxFXLM7pD0XEaEjgiia7QPzolzkdBJE4Vi17WgJrocPkhwaNjfzeCx2CEe3BUpMIj99VKDIH3/7qk32R+eCM6ytYfrWouOXZRzNnNWXkSdXgH7rElDFdON6cQBplm99RkZO1z5HcQkx+KnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8MTKFOCERsYn8srwfee9zzHmkt9Qh6tA/vFE7ZYPEQ=;
 b=FtkPj/1vBunhN4b5T1GFZfpd1MjEKw9DZ5KwDzd0xPqz2cNDVMQcOTwK49LOrLuvxnkDbUrnfgMo7eI0baDZBbQQHL64awZPjXXhqJQZlmMImIScrh3vQ7Olt/EyHbekrBwo7k1UHeGKkXV5ZEodV1pPlKDh9s0pswCK8gmXsVjXc1AGRN9AjNt7SLy5fwLKjLalJFiqR4mtibQIWL/zPablI6M2xs/VxTDq14+otrXIAizQ92rYjTBM7qjiL0fHXaCIW33Lo0T8kHKI9WBlkZTEZc3cCGvvG6eoBq+Y3znRwA4nqevxRpLMNNcBzJI/H81bNRL8pOpN+rQjvFffug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8MTKFOCERsYn8srwfee9zzHmkt9Qh6tA/vFE7ZYPEQ=;
 b=pi6GPuqipEeFkMh8727P6knswJe4H+MzvfV/vX1+NuOlQmOBYFL4RWqtgQZk09tjfjjVyMiih4HF9nXco3FRUDXvD+2iH0Po/Cs7MwhQEH5uPZIAVutnL7FW2nq/ATsasDhelgMBcyOOaTUGFJwgp/Iu5P7j7MoQwUJItEdVNQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by PA6PR08MB10393.eurprd08.prod.outlook.com (2603:10a6:102:3cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 07:35:49 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 07:35:49 +0000
Message-ID: <253f484b-e018-428a-b02e-24ece486d29a@weidmueller.com>
Date: Fri, 31 May 2024 09:35:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] mmc: zynq_sdhci: Only evaluate card-stable
 signal if card was detected
To: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Stefan Herbrechtsmeier <Stefan.Herbrechtsmeier@weidmueller.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240424082343.212554-1-lukas.funke-oss@weidmueller.com>
 <20240424082343.212554-2-lukas.funke-oss@weidmueller.com>
 <82f63d08-3dce-4166-bd82-246cade9ab87@amd.com>
 <CYYPR12MB8703F5C687226352CCBBCD3898F32@CYYPR12MB8703.namprd12.prod.outlook.com>
From: Lukas Funke <lukas.funke-oss@weidmueller.com>
In-Reply-To: <CYYPR12MB8703F5C687226352CCBBCD3898F32@CYYPR12MB8703.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::10) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|PA6PR08MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: 4463a137-fe44-493a-a301-08dc81444ab0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjFlZWhyZHZVOUJjQWthY0FuSFVKaDVoZjFlUlpOSkNwd2QxZmU2cUUyelha?=
 =?utf-8?B?eEwxenRpK1lVTlBwWUo3dVBxV1pFa1crOUpta2pOeWZzRXpNSGVlZXY1cUQ4?=
 =?utf-8?B?QUlHMjg2WXpRVEdmSE1rbjFoZlJxRkowbGtkTWRHUGNhaVlPblZObmNjWkdP?=
 =?utf-8?B?bGF0c2ZBT0lxbldqRCs2dzdGdUV3RDdLQk05UkxlWk8yTnFkU0owLzZVWStS?=
 =?utf-8?B?OGdUYWhUbkNicGJjNGx2N3d6MloyT3dtNzJuMU9NQVk4TkJ5TE1rNDA4MVVT?=
 =?utf-8?B?dW5KbUlEbEVwRjZtbDVsV24vaXBBWG94b2JhVmt5alMwU0ZEVFZ2Q0dmcVVl?=
 =?utf-8?B?ZENKQUl5cmlhWkttTThvQ0YwMWdiMHlLQWRTYlhWVkZPd0Jpa1dqRzhnYVVa?=
 =?utf-8?B?Mks4SFMrS09ydFhMNDlkaTN2SjE1Uk1EWlgrWVBSYWpJaDBEMTEyTU1WdzR0?=
 =?utf-8?B?Q0VyVGIzSzR0TkdlbnNZRWw2UTNSVHdHMVBLYWhYT0Y1MFRtcUtiQkhKa3RS?=
 =?utf-8?B?ZTFaV3JGYWxkV05aem41WnpDcTVqTFFPWU1vZmZvRnQyMzQwNUNKaWdqbXFp?=
 =?utf-8?B?NXVtNzJYbjR1bG9URmdXUUxUdFNxWGxZRHVKQzkxbC8vdndqWmFPYVI5b2dY?=
 =?utf-8?B?Wk5kNjhZcCtLK3NUcmFWdldYYk1IdVBEcWNjemhIOWw2UkRKa05NOFJkcjhj?=
 =?utf-8?B?VnhKcnJxOTJEa0l0YVRqcXhreTM3MFR3ZUtNWE90MU5aYzhIdlZpdUJlOVp6?=
 =?utf-8?B?UFRaUm96a0IwTjhOY3pneE5SeDFWanhZeTdUQ2g1R05BYkUxd0ZQVnRGenIy?=
 =?utf-8?B?U3BBWW5FZmxWTjVtbnNtU0JSYkZWQThjejkrcmU3cjRFSUVaTW5YdEo5MzlJ?=
 =?utf-8?B?cGdiWDBBZTVEZ3MwRDU0UFZSeEh6OHhUY0RDU2pNd1IxK2VxVHRzQUw4TnMz?=
 =?utf-8?B?OUkzWTFOK3ZKbTRrTWNscUIwNWh5MEp3V3B5YzA3QUZ6L200UUxYSmpYWDk5?=
 =?utf-8?B?dmxtU0RTdUpFSUdDQVZqckRlWWFta25mR043aHhmV2NpQll5MjU2YWVRcUJV?=
 =?utf-8?B?YWxsM3JxR0dIV21xTHMvakdYKy9CTVlsNEhVR2xyTDNpOEp2WVU1b2V3VExy?=
 =?utf-8?B?Z0QrM1VyNTNXbFArNXd0VU8xd2dUMVFaOGdDWld2ZUVhbGRJU1FKTVdGdUtH?=
 =?utf-8?B?T2pOa3VZbXQ0WnRSeWVyVmJXMDR4K3UzZ1RMSkd3c3VlVkQyYWZja3J5eldU?=
 =?utf-8?B?WGMxZ0JFbythYkEwU1E0cndDUTlZRG8zRFllTCtsakI3eXhYMDBZRHR0TzdI?=
 =?utf-8?B?M0l5cHZRdzdvYjZ5YlJYNWVOTjNhWE1qMHpDSG1RR2hEUnFHaGVDUXk5YVRo?=
 =?utf-8?B?QVAxQVd2b2ZhNUFwNHIzVkozd1dJeFA2cWRKTENuSVErMGowa1dIdlc5Vmtz?=
 =?utf-8?B?bmU4VGMwZDRMaGF5VmxJNm9SSUJ0Y3F0d0t5amY3SHg5UTJhSU9HQ0dQQkYw?=
 =?utf-8?B?L3dmZTFoeCswYUtRT01QYmt3TnppQjVOVmlXWkFHVnpLVk1vNHFKa3k1UGc3?=
 =?utf-8?B?SGhpK2pPd2tTWTk1NG1FQ1lzOXlSYjIxVStTMFBqS2xzcURZeklHa0NUN3FX?=
 =?utf-8?B?dFJWZi9ZWDJweHliUGRLbEw2K0xYd1ptTTA5SXFMU2oxY2NQVTlHMWtnLy93?=
 =?utf-8?B?M0ZjZzI1ZC9LNTUzU0o0cHdLelFTT3FJdlA1dnhCL1lTdDJXaE5FK0R3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWIyS1EvTEhWSWdyK08yRkFoalllTWlyTXZWaXVxRTg0cVZ3blpqYzhUN252?=
 =?utf-8?B?SUI1c0tKWjFYOFUwbCtPZHZ5Uys4OWFpcmZrSGRIZS9MSGJxZWJKR3F0OXhh?=
 =?utf-8?B?R1J3MmUwWk5TTzVuMm9sMWtyTkhsaHcyREZsRnNVTlJhNE9VRG1Mcml0QnhO?=
 =?utf-8?B?c2RZTXV1ZEF2WmRLTUNrZk92OEM3MlVuR0Z5RXh3WHBnMVIxb1VCMHhRR2Zr?=
 =?utf-8?B?U09IUHRVZnRVd1FYb1BHelVQajNjM25HUGs0K2hWWmdJUjRXQk1sWHMwSzdx?=
 =?utf-8?B?NnJyamlpekkzK1REODhRN3dOZjU4RXd5S0UyYjU2MSs1WEZBbUkrdXdGSXEw?=
 =?utf-8?B?V0M4cm43NE8zMEZXdXJuWGRGaE54QjVGWWc1Yys3a2pSSXgxS3p2QXltWEJx?=
 =?utf-8?B?aWxmcWN0aWNXYjg1cWVxMXZ3S282b0kxWGV5d05GeEMxc0FZc3VqbzVIUnIx?=
 =?utf-8?B?RzRUNUEyUVVCaWpWWDE1UGNldXZmM2h4WHY2TzNiVEdYeERPRFZvTjFHZWxL?=
 =?utf-8?B?TTY4U0pZTktHM1dneFZVRVcvL0FoL0ZEWGh3NGZtSTFmY0M5Q2x6ZDhBWVFo?=
 =?utf-8?B?cEgvcTBTakRlemwzN3JIZDZ6NjNkU3dBdmdwVkRnUGZwb1MrcmRmeGJrYWhy?=
 =?utf-8?B?c1RiZFg0d2hVTXJDMno4NXNyTVVrR0lmdUJjWEhUMmRFbUxTQmUzdFNGVWll?=
 =?utf-8?B?cG82dnRTYUI3dTFLai9HRGUydndLdE0zQURGWXJZTjNGSXM1cGNPcXZzS2tG?=
 =?utf-8?B?MVNqUExuUnlHOVZ1Z1NDdmtBSzE5YkNKZkVUenZOcFFteVFsNSt1YitUbkJ3?=
 =?utf-8?B?ODdsZEpEelVFR2RyQk95Kyt4UGx2Ri9XNnZhYmxZY2FUOFMyaTZONzdTR1VI?=
 =?utf-8?B?YmpBMmJJTlZFYkN3aUVPbFl6L2JnYTRoUzNOVVZBMWxubGk5TTFzZEJHaWdW?=
 =?utf-8?B?ZjBic3hMWDdvSi9rWlNneG9hZVplUCtFb0tVcEdqZDBDNnJUMjYwd255ZkxS?=
 =?utf-8?B?N25VTlZjbE5lV3dFUmZFOEN1cEJ1ZTcrQkRJTnRNZHREU3hNRXM2ZVBwbzZk?=
 =?utf-8?B?NDRQZ0ZtOFQvM2lLNm9oS1VIbHlqZjY5cFQ1b1JIeFlDRzQ5QlFzb1pPNU9I?=
 =?utf-8?B?QmlUNlJDazJDY0xNc0RjQnJoUXorYzZIUmtVTDVocjJPcUFxM1NZSHI2L1pK?=
 =?utf-8?B?QnpsVzNVdVRnSlM3dGthVDZoMEtjWnpwQ0NjQ2FRbm5DL1dNcVVwcHJFNWdK?=
 =?utf-8?B?ZFFnNGdMQllqR2dJWCtuSnlQK3RTUGZNNXMxUTVvcGFhK29CellzeGxtRVpy?=
 =?utf-8?B?NmJ6c2o0dW9PcElaM1NzL0tWakpMNEcvdTJicDQ1Z0NnMnpqSWlvenBDSXB1?=
 =?utf-8?B?MVZzV043NFZzZzMvakhnajBWQXQ2KzhQVzhjVndiS2ZIMHc3b3RmNG9JMDRi?=
 =?utf-8?B?N3JEeExBZTV6SjJINzVKcERrMjRnRUc0dEJGdTkvWnVKeXBQNG0weThMa24v?=
 =?utf-8?B?QW8zK1NFd0Z1U2poNk83NGFFdklndGs2L2ZCQWY0ZkJJbUhld2lvMXRvcHNB?=
 =?utf-8?B?MGswNFBtOTF2WVN0TFNrZXVRcVZLdzJKMnQxdWJ6TWtoc1kzMXc5enRleG0x?=
 =?utf-8?B?dFJVYnRRYzY1QTFXRGRlcnpxaDM1TExZRTRqUlJoeDFlOGxMKzNkaGR4azZ4?=
 =?utf-8?B?OVEvdS9oTnF0TDBkQkpTUVdmcnovVnpvNXVlNnBtV1BnbGhORlk4eDNFRnVD?=
 =?utf-8?B?MlYzTHkvUFEwZmlhVjBmakwxMzdBRyswcitpVFd0Ni9yQmVueTVCaUdEbnFj?=
 =?utf-8?B?WkRndlFidGh2eHIxRUhsOUhBOFhFenFraVMyMWtYT2VCNTZGRXA4SmRxRXR4?=
 =?utf-8?B?TmV2TDFlVjhQMmZ5NGthdHpOOUIyRmV0U3AyL3d0WHRoa0hpZXNHcUwzMWV6?=
 =?utf-8?B?UXNtOWE4dE85MGFHVmp1Q2ErcnE0V1IzbVlTSnlTSVRsSHVNYjNoVVZTWjZr?=
 =?utf-8?B?bFIwWFVMcXBoajd6R3BxNERkTzlUWmZwRGZKWG9yam5MSFZZL0ZGc29KaE40?=
 =?utf-8?B?ekNBZGFqa2ZscEpZTURZU2p0cE1vbDE0UFh1T3RmdnN6QVp4SHE4cUgxaGw2?=
 =?utf-8?Q?ifDjijtkxA7GRPLl2ITJrlvtb?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4463a137-fe44-493a-a301-08dc81444ab0
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 07:35:49.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpV09dPpQodxyV/JTm26bz+aRHUPh0rkhjmdAZSAvDD4Jo/qjj9QKvZcJgFDEz9xpdHl4iGCCdjTIwPnKWh8Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10393
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

Hi Venkatesh,

On 30.05.2024 07:39, Abbarapu, Venkatesh wrote:
> Hi Lukas,
> The polling of card-stable bit alone is enough, as if card-detect bit is not set anyways the card-stable bit won't be set which leads to timeout.
> I don’t think it is specific to zynqmp platform.
> 
> Could you please let me know if you observe this issue on any of the zynqmp board?

We can observe this behaviour on zu2cg and zu3eg. I haven't tried it on 
an eval-board but this would be the next step.

The main problem is that the stable-bit is not set if there is no 
sd-card plugged in from the beginning, but only if the cd-signal changes.

Is there any documentation how this bit should behave then?

Best regards
- Lukas

> 
> Thanks
> Venkatesh
>> -----Original Message-----
>> From: Simek, Michal <michal.simek@amd.com>
>> Sent: Wednesday, May 29, 2024 8:33 PM
>> To: lukas.funke-oss@weidmueller.com; u-boot@lists.denx.de; Abbarapu,
>> Venkatesh <venkatesh.abbarapu@amd.com>
>> Cc: Stefan Herbrechtsmeier <Stefan.Herbrechtsmeier@weidmueller.com>;
>> Ashok Reddy Soma <ashok.reddy.soma@amd.com>; Lukas Funke
>> <lukas.funke@weidmueller.com>; Jaehoon Chung
>> <jh80.chung@samsung.com>; Johan Jonker <jbx6244@gmail.com>; Peng Fan
>> <peng.fan@nxp.com>; Simon Glass <sjg@chromium.org>; Tom Rini
>> <trini@konsulko.com>
>> Subject: Re: [RFC PATCH v1 1/1] mmc: zynq_sdhci: Only evaluate card-stable
>> signal if card was detected
>>
>>
>>
>> On 4/24/24 10:23, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>> On ZynqMp there seems to be a dependency between the card-stable bit
>>> and the card-detect bit. The card-stable bit is set *if and only if*
>>> the card-detect bit was set before, indicating that the signal was
>>> stable and reliable during card insertion.
>>>
>>> If the card-detect bit is *not* evaluated the corresponding check
>>> leads to a timeout indicating that the card-detect was not stable.
>>>
>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>> ---
>>>
>>>    drivers/mmc/zynq_sdhci.c | 7 +++++--
>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c index
>>> 935540d171..d0bccd41cc 100644
>>> --- a/drivers/mmc/zynq_sdhci.c
>>> +++ b/drivers/mmc/zynq_sdhci.c
>>> @@ -1168,11 +1168,14 @@ static int arasan_sdhci_probe(struct udevice
>> *dev)
>>>    	 */
>>>    	if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) ||
>> IS_ENABLED(CONFIG_ARCH_VERSAL)) {
>>>    		u32 timeout = 1000000;
>>> +		u32 value;
>>>
>>> -		while (((sdhci_readl(host, SDHCI_PRESENT_STATE) &
>>> -			 SDHCI_CARD_STATE_STABLE) == 0) && timeout) {
>>> +		value = sdhci_readl(host, SDHCI_PRESENT_STATE);
>>> +		while ((value & SDHCI_CARD_PRESENT) &&
>>> +		       ((value & SDHCI_CARD_STATE_STABLE) == 0) && timeout)
>> {
>>>    			udelay(1);
>>>    			timeout--;
>>> +			value = sdhci_readl(host, SDHCI_PRESENT_STATE);
>>>    		}
>>>    		if (!timeout) {
>>>    			dev_err(dev, "Sdhci card detect state not stable\n");
>>
>> Venkatesh: Can you please take a look at this?
>>
>> Thanks,
>> Michal

