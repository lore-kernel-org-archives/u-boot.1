Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E1BCD4F59
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1541388BD2;
	Thu,  5 Sep 2024 10:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Oq1owGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11B688BFF; Thu,  5 Sep 2024 10:37:17 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A01C88B82
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O79R56jbivbrZKm0IGK/ITkQQN64rTXW8W8iotq5jYEaqbwOHHOZJ1Kaw1h8YcxJV8B81MaANbTX5rLbTlDkoYACfqu55KdFGkgEChg7Ifl8xuVkXZmKh1Ng58a+lEsm56UEm8/qY/1slEe2kVuniVMQBmxy7DutLG3XoGnmImEPZsMMI5muWG3nkhDYQvCgGO5oyZaXUeMfD51czRhU27lljTMbtKvy1wgQEHZILwELks8ep48UM4XTqtn5A3AzFSBSp6adD2tc+bV5iYV1hYBL7BA+WnvRcl7IIGQZU2HkGcpFwrTn1QQ5DruPzc+r7NDDW+AJMwsEUT2U6Ljx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za/bbAy5D87ub3aXcPlleCKlAT5p+0+SGVgK1Wa00G4=;
 b=PkZ1IID5qnuNQqPuI3qkLus8CaSSDlHqeHchB8i+Tva8kCefNplKY2x35TPQqtgUfZy0eMi43NNxi6rq3P39MmGf7ZFmcrxxr9ZWzWeUFVV4QMEq3ibq1oV9xXHqBzVtEMmT7NCTBb264qu1TG1AxIyuwMBqneyZo0cU4tIoMcOGzJUx+8U3OJx8jzBM/WYJVzCQELUBHFhG99eiMKiShgc4XG8CHHkKVkyPGvQrf1c17VLdKf3MZyHfwXkG8RGd5I15sZsoTSf3hYZOZHxmD5UCshN1PHH2j0zS+VbzLmbvJemTWg6eFCczrgDDXlaNsr5dSzTSGGJ09D5sZyPQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za/bbAy5D87ub3aXcPlleCKlAT5p+0+SGVgK1Wa00G4=;
 b=3Oq1owGlkNwtFqKeF8AXv17xQia/GuTdROQ+ER8ywqDOVnAG8fQzU0+7PRjC5+GADYPkeWRpyMt02EBh2G5TnXsDtOiXrgEmJVf73RnRh/98/gkNQLLnhaIPNuoW1QswZZiX9p38hHpzGNCrTz3khl+YVi1ZAgjNRvYeHH6I8XQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 08:37:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:37:11 +0000
Message-ID: <db7aaa38-d66b-4575-a50c-0b1bdbcda9eb@amd.com>
Date: Thu, 5 Sep 2024 10:37:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
 <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
 <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
 <41f4766b-7861-4608-905f-9717e6fdc230@amd.com>
 <CADg8p97-Nbn0AsnL4Tu=375uoONmPSgr9Yj0MnEB5u1O8P0AEg@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p97-Nbn0AsnL4Tu=375uoONmPSgr9Yj0MnEB5u1O8P0AEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bd0ce4-2769-4706-c824-08dccd85ef48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VUJJUHh3d0JvOVkxV2x4UnJpQmo0RUZuU1pTRGtacjlhdFhadjhodmJXa3Z0?=
 =?utf-8?B?UTRLSlVzUjkvVzJ4MktsbU5WZEJ2dVNaa1NPRzNxZERRM2FwdHJqSFhjQTY5?=
 =?utf-8?B?cVJNelVJSmtJd1J2cWhHZm1sRUp4eW5QZmdKakxmZ2tJUUFrRUlnRk1jbjJP?=
 =?utf-8?B?WURpWVM4QkJpZnhxRzFEcEJ3cXNOczMzdy9vdkpjbFY5SThCZWZwTDVLOVRa?=
 =?utf-8?B?Q0pNMVBIcDloMVNvdk5KdHNXMFVHWWd3ZmRCQ2tIT2NXb0hId0FKSVhVZmJG?=
 =?utf-8?B?M2VEVFQwbVYrTmd4bHczQUwrTUhaUGhaZ0YzbytadXBHeHBzSld1SUlFdDN5?=
 =?utf-8?B?Wm9yM3A1WVJRdmFrRHRROWtKRUhpVExsbFhlRDdRMU5VdEVGWVVzU2FKZ1VH?=
 =?utf-8?B?M3N3SERZajI3UThnK05GdmUwUzF6eS9LWXlibVhtb3pob2EwazBtdGlvTXBR?=
 =?utf-8?B?TktUMVdkSTVIUTRkQmFXd2hUMS8yZkR6RUFnYWJmSFB6RldOSmp3OHNwU0Ji?=
 =?utf-8?B?bGt0N2JKc1drMUJjZXhLRWJ1YnNpNjR5eENTSE1xdnVsVGM5TVlDczVubXpB?=
 =?utf-8?B?dnBlVTdjeGlmOGpjczRCNzFUVkxLSWtiMy92SWlVQ3E0SExnYng5VXdIWkQv?=
 =?utf-8?B?eVVsVTBPOG01TGtkbmk4OHJ2NW4reUZQK1haeDlGN1FGRUNHRjNaTjNhUFcw?=
 =?utf-8?B?WDl3Z0FMSFF2QW8vdk9HbmF6TUYrdWdvT3NJVU5WS2xZUkxEZ3ZGS3R5QVY0?=
 =?utf-8?B?SUpMbHN1R0NURjdERFdyK3F5ZzhOTHYvMThNTmhQQWpsQk54cWhDNG1LVlFR?=
 =?utf-8?B?eWdYLzJFc0o1V0FZSmlxZVVSQzErVGsxZ1d4U3BEVTMrZlgwWkhlajZ4ajRw?=
 =?utf-8?B?QVcwOHJGVVM2bnZMTzN6cC9ZRFNOdE55RnpZcTZSMVFWRFhKWEp0cWpaRVZ5?=
 =?utf-8?B?MXdZdVN2Sy9LSkxpejF5ek5ZUFczcTZmVjd4Y09CNVI2aFdCOW1RWUZLNjlD?=
 =?utf-8?B?R2ZXZ043VnFPWUNMbDNWNG1FZnZuekJSaWxXMEtZa3FXK1NyYTU0K0NBdjRw?=
 =?utf-8?B?QndPYzg1T0VacEhleTBFMWlsSEUxZEZLZCtMMWRRSGdmR2dBU1hxUXlldXZo?=
 =?utf-8?B?Tk1FSGhiZXQzcHQvWnlSNmZvekd0YitsTXZCR3B5NktROG8xckY2WjJoMVBI?=
 =?utf-8?B?VUlKU0gralF5UVBkcEVLdkxnTGFucSszd0w4MXpvd3d6QUZrS0lMREFlbEJt?=
 =?utf-8?B?QTdOeTRUZUhtZElEcDcxdWtQbkNLNjAwZTRrcmRlbkYrZy9PNnNJOXpsU0lS?=
 =?utf-8?B?aGRrUjRGUk5LS0ZDZDQxSEpWQ1VVdU5zTEFiK09wMEw0b3o3dlM3S0VvaHBa?=
 =?utf-8?B?cDdZb1EwZWhXMnlKZWpraEVaaEsxdllNMS9BMHA5SjArY2ZXQ1JWZTFPMU05?=
 =?utf-8?B?L1BKNGhHMUg0c29kb2xYTFY1Q1ZkNitxOW53UG56emY5ZjdNK3dRcFROSCtS?=
 =?utf-8?B?QXliY1JQZEdhcXp4Rm9mWk0wdDVvK01QSEk2Y1BSblJyMW1lUlZ4QjlOb1NW?=
 =?utf-8?B?TnhheUJvM3FOTmE4V2JEZFA5b0ZkbkMvM2t1am5ISnhuamFPcDBvSXBDc1hz?=
 =?utf-8?B?VkdXZ0szTVZyKzdGWjVjMTZhdmp4VGMxbGt1ZlJqMlM4cFhtUzVwYVRjK0pD?=
 =?utf-8?B?UHZ3MGtFRXNpTkEvRTNUYVhOK1ZLL2o5ZWMvbnZ5dEY1V2V4MjhURk9iaGZ3?=
 =?utf-8?B?VFpxbTBvN3NCMEJ1Q3RNanFBTnVOT3NTOVF2U3NYdmFqMVFLWXk1Q3FYK3Fl?=
 =?utf-8?B?R2VQWnVIVllHMnpuZmd5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUZiNXo0aWFmYm1CSnlpTHlWYzB5bU9pNDhWWWdOV1BNL1FXMnVPa1hVSktn?=
 =?utf-8?B?dFJVb3lBcFd4eHV6Y2pGMlJrOWM3b3k5V3k0MFd4WlEyNXpIUzR5Y1d2OUE1?=
 =?utf-8?B?ajgrTnJucDVlcjdGdFNTbVBvbFVBelN1N3FzcEpzNC9HUExQS2J0dHllZTJh?=
 =?utf-8?B?bjhNM2ZwNWNrN1lQNmJ5WFdZdW1CWnFrNkt5dmNnM3Nnd3NJcndteXdCTHM4?=
 =?utf-8?B?UFI0Tldod0NCd3pqendEYTROcmtxT1NWd2RmUUxCUU1TM05nWHp0MGJSamQw?=
 =?utf-8?B?RGpuRWNQNmVVQktwOVNyWnRsREZaeWROUzYrUzRURE4yU01Xb3VRd09FUTRp?=
 =?utf-8?B?blAyMFQ1cGlzZms4UWI3U05hdFNodkVKenpUdW9GYVVSODBtSVZxMEVpNkIv?=
 =?utf-8?B?dHFVTTloOUMzRnNwWFRQMzg4UWlSaFk3VmNueGVBSW9jdG5RMVRjNzdXNytB?=
 =?utf-8?B?enhWNFdFQUdkTDFSZ3kxS05HUTZwNkRQWEZtWUZuUVF2cG4xdk8xeGVCYUps?=
 =?utf-8?B?eXpaUjVBVDJGdjB0cGo1Q3hlWExPL3hoYVlzTWRMYXNoUFNuR2MrZ29sUzNs?=
 =?utf-8?B?bSt0TFBsMko4RUNQN0hDa1VLYlZCTzdoQ2NWWG5JRG1xSTljR2Rwd3d2TGU5?=
 =?utf-8?B?MnNlaCtsckx0WlpodWtTOUNWUUwzRU1EaGtJaHpKWUpuem84clpaMUtBQzNT?=
 =?utf-8?B?TmZ2YVYvSjlXSFJuNzBYaXIyc2R4ZmtLU0ZkSEhCK2t3TGtrckY2a2FKRVRS?=
 =?utf-8?B?ZjVmM3M0T2dGQXpLZmR1OU9oOXR1ZzB5QmtQVE1uemdQb3BhYWVtSmZaVzJ6?=
 =?utf-8?B?K1VGZVc5VVpDdVVnZUk3akZBbFk2QjYyUFZwdGZZNkVKa2hyVm5qT0cydEsx?=
 =?utf-8?B?MUZaWndkNTIxTWtaL0E5UC9ONmlqNXlZVXh6K3pHMGNYNDFKSFhvQU9PYjNX?=
 =?utf-8?B?SjJWZjJVb1lIb3hBVGVXMllJd3lVWE1GNWFvNTZ0MEJjNHdmSVAwTlFYK2ty?=
 =?utf-8?B?cUhLRWdYZnQ4NHNUcFlvVGNiaHV5TytKSm1RbnB4UXo1ejdqU1Z1bkZmQ2FT?=
 =?utf-8?B?MURNMVE4MWFVa3ZLZ0p2NHpMRjE3eXpjUXZBbVkrUEZET0FOUldzYWdzYUI4?=
 =?utf-8?B?ZXNKQ3pvNmlaRkJ2VXB2VkQxOGZxd29IVmsxSElmMWRnVTN0K2xnWWsvOUVn?=
 =?utf-8?B?ZnpFS0crYWNBNXM4NFpEV2lKbjRjSzQyYUFzUXJnbGNKaVZESzEwejg3NFFI?=
 =?utf-8?B?Q294dGMzK1hKZzlGcFQ0aHJTcmxxbGk3N1QrYVpaVWc1S2k5dG1UT1JiZ09O?=
 =?utf-8?B?UXNyNktYdU5ndnNXRjRIYjhZRG1RZDF1SDJOZkoxQjF3OVV5ZGVETXZLZm02?=
 =?utf-8?B?dk9vanFJdERHRUFUZGg3RTdHeWVQdENpVW5HRlNhR1o4MFhUckNJck9BTXlH?=
 =?utf-8?B?a3N2TEpON1k3L0FtRzY4Z05CQVpJMHc1WUVEdU1JTDY4OE9xaHBNUjEyd1Rp?=
 =?utf-8?B?M2ppak5kVTdBbG9aQ3piUEpDNlBINWJ3UXRJVlNiaVVYK1ZMSHVlSU44RHBr?=
 =?utf-8?B?MnlrV0tuazVwOCtJcmxUci9GMG9STjFIdmc3Z2VDWldJT3I5Wm85Rks1cWpN?=
 =?utf-8?B?MkRzSlFiVHN1SXVQdTU3U3lSL2FVRW4wb2ZwOUwwS0RHZ2d4OEdJa3BOWWdJ?=
 =?utf-8?B?T1oya0dHL3hpYVdJd2VoeE02blJVeTB4V0dEYXByMnpkbThKb3FWd25XUC94?=
 =?utf-8?B?SWVMWXhUNVhSK3JDdnYvNVNOYjZQWVNjelo4VXBxVVRocXNoeGlIVUNVWloz?=
 =?utf-8?B?T0JBZ0x4dkxNVzdsWVh5enlhRDBmd2sxL0FSRGRzQ2lzWWI1SlZCYnZteGxE?=
 =?utf-8?B?dXdXK3d4YXBjMTlpQm5selN2UlRGQStIc2lsczJ3QWt4Nzd0UURJeVBDc0ZU?=
 =?utf-8?B?dlpNUW9kdE4xMGJzWktmZUhHVFRobi9lUW5mQmxtUklFRFY3V3cydHFzUEZs?=
 =?utf-8?B?TGNTcDZSNXQxWERaM0xFV2VhbitEV1RuWVJRSlplaGlVdkVlOFFoVExLaXk4?=
 =?utf-8?B?ZGc0eDRqZWF3T3dnVlRLWDU1WklkNzQwZVFzbkpXdHA2bHdNMTZhVUNDZHM4?=
 =?utf-8?Q?ySgM8UWTpjZkRStgAMW/2nYxD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bd0ce4-2769-4706-c824-08dccd85ef48
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 08:37:10.9333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnwRMVIveQOtxHRRfFmE6AFlMz9gGSUKSt2CRBu/TX6CQv5hWecohHbu3dK40wDu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003
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



On 9/5/24 10:12, Sughosh Ganu wrote:
> On Thu, 5 Sept 2024 at 13:20, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/5/24 09:43, Sughosh Ganu wrote:
>>> On Thu, 5 Sept 2024 at 13:09, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/5/24 09:38, Sughosh Ganu wrote:
>>>>> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/5/24 08:24, Sughosh Ganu wrote:
>>>>>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>>>>>>>
>>>>>>>>> The following set of patches are miscellaneous fixes and some
>>>>>>>>> hardening of the FWU update logic.
>>>>>>>>>
>>>>>>>>> Sughosh Ganu (6):
>>>>>>>>>        fwu: v2: perform some checks before reading metadata
>>>>>>>>>        fwu: v2: try reading both copies of metadata
>>>>>>>>>        fwu: v1: do a version check for the metadata
>>>>>>>>>        fwu: check all images for transitioning out of Trial State
>>>>>>>>>        fwu: add dependency checks for selecting FWU metadata version
>>>>>>>>>        fwu: do not allow capsule processing on exceeding Trial Counter
>>>>>>>>>          threshold
>>>>>>>>>
>>>>>>>>>       include/fwu.h            | 11 ++++++
>>>>>>>>>       lib/fwu_updates/Kconfig  |  1 +
>>>>>>>>>       lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>>>>>>>       lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>>>>>>>       lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>>>>>>>>>       5 files changed, 99 insertions(+), 42 deletions(-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> I found one more thing.
>>>>>>>>
>>>>>>>> I did this change
>>>>>>>>
>>>>>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>>>>>>>> index fbc2067bc12d..dab9530e499c 100644
>>>>>>>> --- a/tools/mkfwumdata.c
>>>>>>>> +++ b/tools/mkfwumdata.c
>>>>>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>>>>>>>> fwu_mdata_object *mobj)
>>>>>>>>              struct fwu_mdata *mdata = mobj->mdata;
>>>>>>>>
>>>>>>>>              mdata->metadata_size = mobj->size;
>>>>>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>>>>>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>>>>>>>
>>>>>>>>              for (i = 0; i < MAX_BANKS_V2; i++)
>>>>>>>>                      mdata->bank_state[i] = i < mobj->banks ?
>>>>>>>>
>>>>>>>>
>>>>>>>> to break desc_offset location. I generated mdata structure and write it to
>>>>>>>> primary mdata partition.
>>>>>>>>
>>>>>>>> This has been spotted by (my debug) which is the reason why I did it.
>>>>>>>>
>>>>>>>>             if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>>>>>>>                     printf("mdata offset is not 0x20\n");
>>>>>>>>                     return false;
>>>>>>>>             }
>>>>>>>>
>>>>>>>> But I got one more message below which
>>>>>>>>
>>>>>>>> mdata offset is not 0x20
>>>>>>>> Both FWU metadata copies are valid but do not match. Restoring the secondary
>>>>>>>> partition from the primary
>>>>>>>
>>>>>>> The reason why this logic is in place is to handle the scenario
>>>>>>> whereby, during the metadata update, the primary copy gets updated
>>>>>>> correctly, but due to some reason (like a power cut), the secondary
>>>>>>> copy does not -- this is because the primary copy gets updated first.
>>>>>>> In such a scenario, the secondary copy of metadata can be then
>>>>>>> restored from the primary copy. In the scenario where the primary copy
>>>>>>> is corrupted, it will show up in the crc check, and will get restored
>>>>>>> from the secondary copy.
>>>>>>
>>>>>> But in this case - CRC of primary is correct but data inside is wrong because
>>>>>> offset is at 0x21 not at 0x20.
>>>>>
>>>>> How will this event play out ? Am I missing something ? When the
>>>>> metadata is getting updated, the offset will be written as 0x20, and
>>>>> not 0x21. And in case the metadata gets corrupted, the CRC check would
>>>>> fail and the primary partition would get restored from the secondary
>>>>> (assuming that the secondary copy is correct).
>>>>
>>>> It is not after update. It is initial state with incorrect mdata structure.
>>>
>>> Well, if the metadata partition is being written with incorrect data,
>>> not sure how we combat that (or even if we should). After all, the
>>> spec clearly states that the metadata cannot be protected against
>>> malicious writes. The logic that you pointed out earlier is to handle
>>> the scenario where the primary partition got updated, but the
>>> secondary did not.
>>
>> I don't disagree with you.
>>
>> Scenario here is that primary partition is updated with incorrect data content
>> (but still correct CRC). This is correctly detected that data is not right.
>> It means primary partition is wrong and shouldn't be used and it is not used.
>>
>> But because it has correct CRC syncup code logic is doing syncup.
>>
>> That's why I think we have two codes which have pretty much independent logic
>> what to do. If primary is wrong sync should be from secondary to primary but
>> that's not what code is doing.
> 
> The scenario of "primary is wrong" will only play out in case of
> corruption in the metadata. The scenario that you highlight, that of
> the metadata being wrong, but the CRC check succeeds will only happen
> when the metadata has been maliciously written --

yes. And I did it on purpose to check your code and all error condition you are 
checking to make sure that code traps them.

> if not, then the
> secondary partition should also be written with the wrong metadata,
> and the checks would then fail. In the case of the primary metadata
> getting corrupted, it does get restored from the secondary partition,
> assuming that the secondary partition is intact.

When primary is cleared/has incorrect CRC there is no problem and recovery 
happens but if CRC is right but data inside wrong code doesn't check it.

Thanks,
Michal

