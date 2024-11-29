Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3CAD6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C110C893EC;
	Fri, 29 Nov 2024 13:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="gxbOQjrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 554DC893FB; Fri, 29 Nov 2024 13:33:24 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0358891FD
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 13:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXctFoWChlgyY/4/PJDbqh+6FfqLrsaVcPGVLVWqlS1An7JqC3B4HN2Gwid4HZXfta4LG3Z3LUGDewsMjjKFdXnILVOmtTvh0SHNMUeavTNwX+4CsHDfCK5K/cIcRaGvfWvkZq0a7B2lPW6HtRHk8H7MQTT4HLDbLtICCNp91KbJzdb0qwSUERluldQguQ2axlsz+peULl2/l7nT7O5bQfqCNNhakd2bu4PAZPM7z9jeg/Bp4pu1N6vfINv/qfDL6FPlj74F/7p8lsmbLBNW+Hcz3rAakKjO0kfVmQXVjuZPNqOvaZBk5wZeoCc9WuuTNTt9RHxH97bVwvNIovQlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmxSzQq8Qki1/msRISatjkleC8+5Bl7pT9XqxMaF81k=;
 b=ImUCNuReBpLQ6XNDSRohtayfTWoRiKkFZ+m7sqihMrnk8yMthbSjCYKzcDyMU63P8WPvswmtd18rVeS6v8g119iXpFvk0YYnSpnFyMbTM0Vd1a3lNDRJpU2V1aJB5svCwIEueJXhHj87lafRIn571LkBqZeVb3hEShtYWaA6EmphoRXn4dfOnX2e/jIzuoOXRRJtxnYIFhZfhHQwiAnA3gdGBUgQR9qcgv2cDKq9F1+9mhqrZhFXSDOXh+XABvhf1aZR4QRZjgl4rFbyLENxvD/yZA2yEQjuQxZXnjgTU8LN+5x4dRLhGHmeAweUG+6NfZG+DUIlmLRBoZYiQHHF4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmxSzQq8Qki1/msRISatjkleC8+5Bl7pT9XqxMaF81k=;
 b=gxbOQjrCBKPvKsjaqYkK+U2vxWAVu0KjSPJR2kR+2Oq+2poTuwcPz0PFdCQMv4FgQScloAapYW6HqsLMi/y5aeoBIRzdlc2FA3zqAGcslTOLTNZK43QwWe98OGc+NkspT6Nwr7aL1q9N/F1gxKbw8ZNReP5DLwdWOVIR76jFbHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GVXPR10MB8178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:116::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.5; Fri, 29 Nov
 2024 12:33:17 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 12:33:17 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,  u-boot@lists.denx.de,
 Alicja Michalska <alicja.michalska@9elements.com>
Subject: Re: [PATCH] Environment: Change reporting "nowhere" as "magic hat"
 to user
In-Reply-To: <CAOMZO5AsTCxvO+QuB7CGPu9nLeNmywo6N4XkNukTWtd7KtDZ6g@mail.gmail.com>
 (Fabio Estevam's message of "Fri, 29 Nov 2024 08:23:57 -0300")
References: <20241128151233.1962926-1-alicja.michalska@9elements.com>
 <85619442-4c18-4cec-8176-d7239e023474@linaro.org>
 <CAOMZO5AsTCxvO+QuB7CGPu9nLeNmywo6N4XkNukTWtd7KtDZ6g@mail.gmail.com>
Date: Fri, 29 Nov 2024 13:33:15 +0100
Message-ID: <87cyiei5is.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0094.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::35) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GVXPR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: ab43b399-0160-418b-f46b-08dd10720018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N01YblBIc1U5VldpNGhsNkhtYUZCcFRxbzhIL0RqRFRKL25FWmRxQ2cvMzlr?=
 =?utf-8?B?OTBOUGxPQUNEajg0akk5QUZsZW9BMFdPbjlEblhGOEpWZ1hWaGdORHBtTW51?=
 =?utf-8?B?dHRqTFhpUmZESFNiRThqQWVrNHFvVXJ6SnVMVHY0Y2lWdmFoZUF5SjV5ZTdV?=
 =?utf-8?B?NjlrTHZJQlN6eW1qMDVLck1QYm1HZms0U2RDTjh2V3k5YVRGU3Z1a3FSZ0ND?=
 =?utf-8?B?YXpYaU1aQ1F4UUtpZ2NQRzVGU2JUYWxZQm9wUEtxNU9KZXUzWitxMFVDSEs4?=
 =?utf-8?B?NjBBUEkzSXdyVXhhYjBqUDdVbWVVQTRWTWRDTU1SYmFIOEVtZW5wU1dOTDkv?=
 =?utf-8?B?Rng0RW5jam9Hc05Da3lPN21JYnkrVEpIUUhxeEdoWjZjOWUvcjhwRUVBR0Ru?=
 =?utf-8?B?cFBXUUNGcXdwTTFJS2tJK3Vhb2I1T2RYV0l0TTlSOHh0NC96Rk9lUUN3RGVS?=
 =?utf-8?B?QkF0cTVhc0FBeEx2ZHpSdDNGcWpLQXVoalk2S3FsQ3R2d2tyRi9wMjkrWHpr?=
 =?utf-8?B?U254cG44dDAvRnJtS054dmxWb05MMFIwRHVTeEZQRHQzR2ZDNlVIaWxsSHRF?=
 =?utf-8?B?N1hlS2VLTUlURWNhSzdGd2FCWEZRMm03NERNUXVRU1pUbW5LMCtlV2R3MXkz?=
 =?utf-8?B?L290ODhSQlIvMFRKM0h0MnBPb3dscHdmY0xURFFYeHZwU0FMbzR2WTRaNVdz?=
 =?utf-8?B?eTY1ZjRTWFpNcUVIUFlneFR6eU5mSHlOM0xoVERXTnpybnRBVXh0Rm9jYkZL?=
 =?utf-8?B?Rm95bkpHZHR1eFlpTW9yWndPUWpJTFMrV0R5bkZzTnR6UmhNSldWK0paQWUw?=
 =?utf-8?B?M2liSlJWaGxORDZubUVnNE1FaXhVNDdDYzdlL1NoUUR5Z1hFZXNBWkQ4d2NV?=
 =?utf-8?B?MnJYa21XTCtydndhUkdaL09aVVpVVGsrUURmbFh5M3BPVkdZL0QvRWthQ3Nm?=
 =?utf-8?B?THgyYW16ZFJ3M21vM3h6ZUtwRlI0eXBXYkFLQ0MwT3BwUWZTZVA3SHl1eFhi?=
 =?utf-8?B?ZlMwYy9GaEVPMmIvZ3Q3NGZ0Wk1Cbzh0MmVJYjZmN2Q1WVlFNjlxNExVMElP?=
 =?utf-8?B?VTAvdFh0LzRlM1A2L25NQ25mZFpVT2xqSXl0MFRqcndpaWFVVXFidGdlMTZK?=
 =?utf-8?B?Tm9FdmR2ZkdFTStodFBwWWEwTThYL0toZFpoWElQL3YwQ1VBSCs5ZmlGUnlp?=
 =?utf-8?B?azV0bVlOZVZnZnA0SjZvK01Pb2xzWmZteUkvUE0zcG5NR3Mzbmc4OGJ0cUdJ?=
 =?utf-8?B?UlV0RENlNUdvSFZtQ3lkUEFkdzEwQ2ZFdEJoQmwrWTVWd25hWGtPNnY1ejJ6?=
 =?utf-8?B?YWUxVGZxWWNBemp0UVVHVVdrREFVRThQRkhiSDZXempRNGNWQWxjVjV3bnNG?=
 =?utf-8?B?VjByMEpXS3VNN2JJZDRyYnNWbjJXSFJlbGh5UDVhVVo5KzdOQ0MyYnVYc05t?=
 =?utf-8?B?Wmh5WUthbFZoZGJKVmZHMWRpQjNaeFlyalhjbzZSOGpXcWhBMEN2NEJqZ1FK?=
 =?utf-8?B?dkxhSjR3VjNoQlVsNnZRYkhLbDluMlJaRHg4cmR3U0VidFlPblovOEg4dS9q?=
 =?utf-8?B?aGdXS0xiNk9Xc1dFallRRXo3R3VRSHVSZGNLenJuZ3FyZTJPNHlJakUzd3Ba?=
 =?utf-8?B?OUZDZVhoVmVxN1F6dUd6QkRLWEJwMS9zSGlaL0dYOVFCZGNGWGJDeVRsbTB4?=
 =?utf-8?B?d2xGSmQ1TmN5WTMyOWRTWFdkTjRQUk42eDBObDRzKzBPUmxacWljRTl4bW1E?=
 =?utf-8?B?STFoSExQRlNDTkI2T1JzalpCenEvOVhQWUYwSWFwWjFGVHkrNFFOdEpmQ09E?=
 =?utf-8?Q?EUdTkqlSXZSHaHjPjkMGEDvO5Is2Q0zmE3osM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJDZnpMRXNUeDExZDViMFZqUmQ2UEJWTUtkMndyYlRYUVd6NHNSeTF2d29l?=
 =?utf-8?B?SFBWYXJsZ215WmpiSXBzMGNDZDlEZUlOY3ZFakEyY2NJc0M4Yjlremh2QmtV?=
 =?utf-8?B?eGczSTJ6eWFFZUdZdmNRMmY4dE4xQURLc0Z5REprb0pxM0xoSEZ2MmI2TlBa?=
 =?utf-8?B?blk1TGNFQ2UrbHo1TE9YT0NYQ2RMMzVDMDlwbnpNWCtsY0ZZTlJwalljMEhp?=
 =?utf-8?B?T2NneU1VUGhiOU8yVStlK1BjSVJFVmtWeStWdnJCMUhONlFrUHhBd0ltRG5L?=
 =?utf-8?B?MHE1dENlam95MkhkWHVGOFEzU2xaemdQT1dPK1I5cU41NGZFdXpPS1ZldWRr?=
 =?utf-8?B?eEJlb1M2cXI1ZFMwSml6N2xYK1BKTys0bzNxSWxtNWZpaWxpVGl6V2NiL2dT?=
 =?utf-8?B?eDRtRFN1VU16RXlkMVE3dGh4blBDekNKRS9IUUZvVXkzalhXeUgxL2F1S3p3?=
 =?utf-8?B?V095MUVwNFUwQW1JUUs1OFlCNUpTRE9BY09zWnNOelNlVWx6TXdsOTZ4RGZE?=
 =?utf-8?B?bkhsTEQvWm1YcDR2Q25YdytYbW1WUjZpQVBzY0pqZTJRZ2hPbjJSQVhsdTF5?=
 =?utf-8?B?MVJYREJncG80alF5STFsRnFzU3VOUWJNOE81T0dnWHRTVzVjRHVodXV4NXl0?=
 =?utf-8?B?Y2VBQXJjSHlIcnNJYzlJbHdJdFlpVUFsZkZFT3R4cmthK2hkcHkrVDVXbEta?=
 =?utf-8?B?TDdhdzFBS2xTVUg1WERjcnJkVDNINmxvZXVWdGQ3aG50aUxMWGIwTERxU3Ra?=
 =?utf-8?B?eVdsTG9zbFB2OVZBbUt1UnpjM2hQek9Cd0lVZUN2Um9xZS9CdGJXS0NRL3Bj?=
 =?utf-8?B?T3h2emtJY0VrbXpYN056TzZTd2RlcHE4alA1MlFSY3RFSzlGV293K3IvdDRi?=
 =?utf-8?B?R2V3c2JwQkRwNUFKNWRyTHVxTTBhLzJoOFpNUGVMWXZSREdaaEpMdzhKRmVQ?=
 =?utf-8?B?T3pwMndGK0ljd1BPazYwRldPWGt2TlFJcXEzSzFEY0dPRkJ6ZG5xekhPNENU?=
 =?utf-8?B?bVNVWnZCRVlWcUI2bGtuQmQ4Vk9tSnVDTnEwS2lCVDF3WUVhNythdkFDanBn?=
 =?utf-8?B?RFYxT1E0cGs5a2x1d1pyK0dhQmlZenllaWZjSHJyWmYyanNMK3pUL25tNEZx?=
 =?utf-8?B?dm8ycXkrV21Td21qQ2hRK0phU3B6UU9SMXVsSWtJVnZxcTVyTDJYVURMS0tz?=
 =?utf-8?B?S3F3Vks3dGhxdFp1WFN4ck1WbVZpd3NldU4yYUdLMXE2RE9iTFAxVWd3b2hi?=
 =?utf-8?B?MlV4WVF1ZHhXM3dvSEoreTkwclNlZTNZbmRmUTlRVTZ6OGdteDJMSEJLaC9L?=
 =?utf-8?B?ZE5kRVZvZVZjSzhwSkxHSUF6bXZFdDJuNTI5VGlHYVJPK21qNGtXcHdBOUtt?=
 =?utf-8?B?SlMwUzNrMnZSam5nelhmampuclFJMFVnTVh5emZJbW0zelBLNE1LdW0velZi?=
 =?utf-8?B?V0VDbjRaUDV3YnRiWEdHODI4SDZacnhiMERPa3dEc09SMHVQcitGTlpPZXc0?=
 =?utf-8?B?QUt3dHZBUmkxVGQ4RkZmU1JMK0dNZ0hXbXZJN2FycURkODMvOVFxNVdLamdE?=
 =?utf-8?B?dkhvSWN6SFNoWlc4SE9zdGhFYTMvRkFXRjlYOXNYUml6SVN4RGZTRmZsNHVM?=
 =?utf-8?B?M3J3OEhGMkxOMHY0REtLT1hTOWFMNnNiSWluWkZvWW13N0hCNno3QUIxdDlE?=
 =?utf-8?B?SkN3SHIzTGRYQUdYQ2V6N2x5TDBsZGFRV0VWUFppZTdoWXNMU3J2V2Q4ZEhw?=
 =?utf-8?B?U0VqcjFXK0hUaE1SclJWdDlzOEcvVWtEemRQZXd2bXZIL0hUV0NFNWNKN2gv?=
 =?utf-8?B?OWJSeCtNNmxxOHpaSkUyTGt1YjIxa0pJaXdKd1lQVkJMK1MxSGMvNVJPeGFi?=
 =?utf-8?B?ZmxXVHNxdXVMdm5XWXNuK3lObUtLU3pGQTZmcW9ta241M2Jsb2Z5ajQ0eGFF?=
 =?utf-8?B?eDBWdHBURnBJRFBHbHdJcEgwZnBDaHBjbU01Wmh3dVg4SDlHaVE2WUJkS01M?=
 =?utf-8?B?YWIxQU1FZ2EwZWRFRDBQa2M0UnEvbEp4SzB2RVgvY0poUUx2Tnk5aWw2SGc0?=
 =?utf-8?B?d3I5dkRwaHJPeWJYbld6WEtpZzFVOWlpM3FXT0hSVFdqd0xmZS9uVkRIUVQ5?=
 =?utf-8?B?S01FQkVJV3RFb2YwRyszR0xCbmxkc0tNWWdjVFY3SlFtQ1J2ZTRlZUJNenBY?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ab43b399-0160-418b-f46b-08dd10720018
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 12:33:17.1960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvCdPQ/1RSp97xdYoz+RbzVoqKPMDiwdZs0CPoo0MasU4HHj40OyNbnbBJ3HEud43k77h9ezypEmY2BW4090Xapz59OH4zWhcyBkxkl4PIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8178
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

On Fri, Nov 29 2024, Fabio Estevam <festevam@gmail.com> wrote:

> On Fri, Nov 29, 2024 at 7:35=E2=80=AFAM Andrew Goodbody
> <andrew.goodbody@linaro.org> wrote:
>>
>> On 28/11/2024 15:12, Alicja Michalska wrote:
>> > Make string more user-friendly
>>
>> I disagree. I can make a guess as to what 'Loading Environment from
>> nowhere' means. To me it suggests that it has not found anywhere
>> additional to load an environment from. It is a bit awkwardly phrased
>> but it can be understood and it at least sticks to reality.
>> As for 'Loading Environment from a magic hat' - I have no idea what that
>> is trying to convey and that lack of meaning is not, IMO, user-friendly.
>
> I have the same opinion as Andrew.

Seconded. Or rather thirded [*].

If anything, the message could be changed to say "from default", "from
built-in", "from build-time default" or something along those lines else
that conveys the message that the environment comes from something
defined at compile time.

Rasmus

[*] I was pleasantly surprised to see that that actually exists:
https://en.wiktionary.org/wiki/third#Verb
