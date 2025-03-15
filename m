Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2814C28B28
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 13:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F61B809A4;
	Sat, 15 Mar 2025 14:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=oracle.com header.i=@oracle.com header.b="ok/4eDt5";
	dkim=pass (1024-bit key; unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pLgwXEq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7E8580756; Sat, 15 Mar 2025 11:22:16 +0100 (CET)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687C6806FC
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 11:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.zaludek@oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52F9ovRV021578
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 10:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=s1z27oBqWWiGpZgR
 Q8e75rN13mpb9a2J38J05Qr3M/U=; b=ok/4eDt5pcwYpLPFlS+eHyswYIRswoPh
 LU7OaEHrNQFREoixc77LV5glPNByNdAK81dMJWcspHxzEXuwUqPsnpcouXaVO2mA
 SIObZzMzveN9mzi9hWiXyPM+mdRulXmMyYfeAqiR8xjxtUf6lXxhwHZvXJWiUWSH
 cfWPEfcpWjqJ56ZcWpk8vZEYwckrfYjfsDRXp3IbA2vWzZfgrTwu0DQz5Ea6i9mC
 qMNV2i9zhYANZQQXGaEaxs6Gi9JAbsM/v/W7/1oscjt1hh4cMas8iFMbsEXA4scZ
 hh49vG19OZVr9InnF/clnXB05oCwH4k1uLulD1VhuLC/tWTTAtbyag==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1hfr76n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 10:22:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52F7FL3S012869
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 10:22:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45d00byu27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 10:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJUKEe8D0j/CjVt5OPxTUvyW2ckXOYj93fEfwHKf+PVWoyXvadfXD76BZTxGbdUG2U1lOKc3aXK+70B9FmHjo9rlmKdwa1igJetM71NpEN1s/GumslIJBnqvXM3VJuhgU5zWPPqzbrtdus57RLKsYeZh01MnEURFSXGtPC9IZdD5Sgi/cC0l1usA8cCgWm9ukijs2ch3v2OoMgpYBs2O2+KE75fVzaWhSJIXSkDr+Y+vSWSH9ZmeoGc5XT6nNzPJgYufhLI80FqvwM9/7CMlMazANOWwUl0CDorWLdWWaNRbgEUz3eV7CVL307k41DoFvZtjeL5aDbtPqBt0nwxtiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1z27oBqWWiGpZgRQ8e75rN13mpb9a2J38J05Qr3M/U=;
 b=KpjPcj5SfSxOeu/ZwQ5f6F8H7RwRoavFDuxbqLF/o4HBjSsS5dVaMyVQ+hLfF9kJV/WBrDHCKG7Dq8l+aAEot/rPC2hBD/ib9lGD3EotYBF8m2pnZyH4Tak64rytwZLirKGWnUISVF+ScXOsAeAUnLzikz93F+Bd4RdyXt1FkstKTmClAd/Me2GyCHsGeMV7rN4GDA6yNcwa33EL04HOS1CwF9LsSRnALHQCqm8UNcgIwpL4+MXIXRUidehkqMRxEMvs5KEY8I2YnxwTCuhHn9WZU67zAzrzrTVoO6Y7H1r8qejqhoE1GDW7I7Dj252rfpQ48R6FvNYrtXhHQlf0IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1z27oBqWWiGpZgRQ8e75rN13mpb9a2J38J05Qr3M/U=;
 b=pLgwXEq0HEzDjcJJNjdd34x/zdl2nQOQzejqmy4SUG3gsdGyI5AHTJM0YFRm4buWqkp9eKPcvsnWmM3ZCc+9bLUYPuDU5Rwr92QPt01olKntboxke9eaauvL2W87hxIypM2rg0r0trntEGVPOslaGCCUBUlZiOYnJ1SKKcsOF+k=
Received: from MW4PR10MB6322.namprd10.prod.outlook.com (2603:10b6:303:1e3::19)
 by IA4PR10MB8565.namprd10.prod.outlook.com (2603:10b6:208:56d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Sat, 15 Mar
 2025 10:22:08 +0000
Received: from MW4PR10MB6322.namprd10.prod.outlook.com
 ([fe80::d2cc:1005:5775:9f21]) by MW4PR10MB6322.namprd10.prod.outlook.com
 ([fe80::d2cc:1005:5775:9f21%4]) with mapi id 15.20.8534.027; Sat, 15 Mar 2025
 10:22:07 +0000
Message-ID: <be127241-1bee-4955-8af9-d85a6862761c@oracle.com>
Date: Sat, 15 Mar 2025 11:22:03 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
From: =?UTF-8?Q?Filip_=C5=BDaludek?= <filip.zaludek@oracle.com>
Subject: efidebug: defaults prints incorrect hardcoded path to executable
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:10:232::17) To MW4PR10MB6322.namprd10.prod.outlook.com
 (2603:10b6:303:1e3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6322:EE_|IA4PR10MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b4ff58-3d32-4a79-dc6e-08dd63ab3d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3Bod2srMDJEWFU5MDNVeC8zaW8zd3YxbHh5d2tkZEhWaXM3WXI4Mi9ZOTR5?=
 =?utf-8?B?TFUxd05pemZzVjhsYTBYYm5UOEMrSitqSm9SMGZRR1VlMUFwY0p0MHFlRWt2?=
 =?utf-8?B?REhKMWU5ZnFWT25iOS9QWm0xVm4xWlRRZTU2NTFnMWxCcnV0a09ZNXRhdDZj?=
 =?utf-8?B?TTZ4TG1DVnNUbmJ0Y2thbThuZDZUOFR2Q21BcjV0cFRwK09yc3d2WlRQdlhZ?=
 =?utf-8?B?ZG5aeGp3SnV5N1lodFBnVUZub1FWZnJjZm55OWNXWUJIL3RhSC8yUkxRTVVw?=
 =?utf-8?B?N0xsVVRodzV6WTcyZVJIL0ZmazN5R3pybVNia0FBaW81SloyanoxZ0dqN0lu?=
 =?utf-8?B?ZE1FTmR0Nko3OXMwV1RUQStuYTVFY3drTS9hZFdnTHhIN3hQaGluYkEyVTBN?=
 =?utf-8?B?VmowTUNWVWZRNFNJc1J1bnJuUUtNd2o3VWRwVS9ieHN0aFJyb3N1aWdaZTVB?=
 =?utf-8?B?OHAweTZWWTZXb2plMklWN2lDV0dIK1FkLzdIMnZTMWhiTCtNaU9NWFlJVnl3?=
 =?utf-8?B?czkrUFNEVzlNc0t2R2duUkpRZGx3cmNLT0NlWEZjVU4wbFlwSUVvM2g3anNM?=
 =?utf-8?B?cGgvZklYZ0hQak1YWjVnc3ZMeVBkcTdNb0I1N3BYeWpzcThOM05kOTZKeEda?=
 =?utf-8?B?STZrdW1kdWpVZmppdGZEZWZBT3RhZVlEcWlnYjZrdTRBR0FYLzZmMXlQYnlH?=
 =?utf-8?B?Ym56V2Zac3JteHFmV2pndTEwRkxLWnVhTUpxRE5kam5jeGtNd0ZhSDFkZGor?=
 =?utf-8?B?bmIzZ1FLMmN6cVZ1eU95YXE4L3Z3UlYzcDdSbit4RXBGVXNXQzV4Y2ZMOXJx?=
 =?utf-8?B?ZTVEYVpBVlhKeVJhQlpXclVWN1ppRjlScTFpRUFLUzU1MnlzbzZCUGZtTXRz?=
 =?utf-8?B?Q1oxSzR3QWVZT0ZYSHByRHYyV3lkWHpVNzFOV1U0T1NCQXIzVWk5bnE2MGNk?=
 =?utf-8?B?emlsK3BUbzVoYkdNZm4wWkFwNFVWODRWQkJoNmpoR3lRc1g0WVoxUDV2WnVa?=
 =?utf-8?B?TDlzWHlZUGZuMjEzZUNZa2RFeWhSZHBZaWV5SERWbHgwMW95eUhYdzI0R0ov?=
 =?utf-8?B?cyt3Uk9ZbXlTQmNlVHcvUGR3SDZHUnJ1ejZHd2xEVC9TREZZZ2hwM2xjUWZR?=
 =?utf-8?B?Z2R3V2FwVFlHMngxNHpJTTV6ZVpvTmZnWUMvV2NwdGJiZVJVRExqQU0zcjJw?=
 =?utf-8?B?TTdoZEJ0d3dETENCRTBiQk0vc3pnNFJjK0w4bHo1MER1QUNoMVVhTGNHd0lR?=
 =?utf-8?B?eEtwbDVMVDZnRzgzem02dmJwMUdRY2NrRUUvZXkzaVdwamZEdFFzbDNLVEpY?=
 =?utf-8?B?Uis4Vi9DTVdJRmhzSnFjMEk2QzRaT2tXc1pya3lOa2NLQ3NLTWU1ZkUwREoz?=
 =?utf-8?B?Y0dyMjU3VEN2L2I5YjA1NzF6cld4U3ROL2l1c1hQZ0ZXVGNmeUZZSWE0NlRz?=
 =?utf-8?B?M3l5L2FwazJGM29HbFI0eVFoUWo3UjFBTk1vbUZ3bFhYQXJlaStra3ZPZElp?=
 =?utf-8?B?OFNUZDV3MFlSTTl5T002YlpYb3lMVDdXVE1rN0VlWWJqUFlQN3VEWGZSZkg1?=
 =?utf-8?B?NEg3WFFhYjEySUdxaFZGSzd2cXplenhTclIwUXU1WFZPd05qUWE2akkySTlR?=
 =?utf-8?B?NTh0S2lMWi9ocFBKV1EycXloMm92RCtpcU1JcVZpcFFsSmxEalYySTg4VC81?=
 =?utf-8?B?NUhGZU1adUtCSFhxVDJDczJpdkZ4Qkx3UjlzNmU0YTdZRXFiaDJGVzlNd2NF?=
 =?utf-8?B?dVkxaGFkZnBNNE9SVk93MEppUkk1Rnd5T1V4eDdCRWxjL1gzM1dqbWp5emNE?=
 =?utf-8?B?MGtzbnJhajJpd0JxMDZLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6322.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajk1WnNDdWVUc0syZUc5RjNxMWZVUk1ZOFg5cEgvRXpWd2IwcDlqMWxIWTlG?=
 =?utf-8?B?aHJKZmFxUnVXeWhGQ0ZwSTVkYjNJaVBxRThQaUZWZHdKMlJmZE9sSlVWRjhL?=
 =?utf-8?B?aGN0eTNkc2ZyNGhEblh5TElObFFMUllIVzl2V09OWUhvczNvZUtodEVTYnJK?=
 =?utf-8?B?U05pTmVGOU9OL3IzTkpSZlNEVStVdU5oZkJvNjVmMzJCa3ErdWY4OE81c2FY?=
 =?utf-8?B?Nm93RzAyYnNlNUpFbTNqd2lxVXRqU2hWT3EyWitPM21yN3hDVEhMaWZzQzRn?=
 =?utf-8?B?L3A3M0Rtc2FpQ1JDeU9wbldINUVQakp3OG1GNER5OFFlUlhMTEZPMGdUR3hF?=
 =?utf-8?B?REJWQ2JmTGc1QzNMY2ZHWStORU9QNGZiZzY2di83MTdraERIc1RmcVZvSEpL?=
 =?utf-8?B?cXprQkN1M3dXU29VWU8vMUphbEE2QUZWUlBUUDBiSSt5YjFPQllSSFFqYTI0?=
 =?utf-8?B?Q0xoQXRXSHhGRlFXOS9FT2h3RVdIWVpOTStYVlVFMnBTVC81WWNDQ0VHMi9G?=
 =?utf-8?B?cWdURm1nTEhjeEFobFo2MU13Mmxkb0pyeDBueWtMcUMxUGl4dStQeUpGTkt4?=
 =?utf-8?B?cEdscEJwUkdBRFBkYUpueXBaOW9rdTBWbFpuckdHWUxHS2hhdExnbEFVREk3?=
 =?utf-8?B?WHJEZHB6a2xudC9zMi9IOC9PSzdXaWV2VCtad3VKRUFrUGxHd2JYSWZxc3Rm?=
 =?utf-8?B?ZU9Eb05XKzdlenQ1eGJBcWZxanNkR0RGUmtib3owNGY5QmNWUUVNekFqUWNE?=
 =?utf-8?B?c1ZDTEQzSERub1BNaU41TUZhRVpQZEtrRVBkKzhZaGdPdDFUWE00N1YydGh6?=
 =?utf-8?B?K0U5Q1ZiTlZCWXNvUkFsMTZwU0t6MWNxTldKNGZzd1pkNnNlNzlXWFByU28z?=
 =?utf-8?B?eW9UeVVhWFR3YmRDMzM5c3BVeGdLdDNPTXMzcEQ3N0FnQnpvOEJrZ1VhY0d6?=
 =?utf-8?B?S0IyZ01jRThDRzFaeVVXT2w5YUcwWGhnZzNNbGhEUmZFZGhTcFZkYk9FcEtE?=
 =?utf-8?B?SXBtdHB4Y3JUTlVBRlorZ1BhL1JtdTBsbit0OHkvM2JXUisxTnBMRlJvS1da?=
 =?utf-8?B?eDBqL2hPV0hJRlRQYVYxcFZsL3phTUM1eEhyNlM1UXAzNCtzYUN6cFh3VEZS?=
 =?utf-8?B?MDVZMllHallEU25GQS82Z2VjSHhtY3FlQzhQZ3VWYStTUzZwNWYwSk1SMUNP?=
 =?utf-8?B?WENoQkh3ZzN4RW0wa1ZKVTB3WW1KVzZFRFVlTXNGTWk4MVR4K0dWYmU0emdU?=
 =?utf-8?B?YzRvYklWYnluamVURmRXMTFXSzk1MW50VW8vRjVXVUNjVDFWWGV0aUpzeU8y?=
 =?utf-8?B?cHdvU2dzOE1ZYlJLR21Na1F3WFNsOWpXd3ZKeDRXNkRFNlBhd3B0blFTZkZ1?=
 =?utf-8?B?a2dUSFNMS1hsY2srSHR2WUJ3cW9xSjkxSmtiWHNWZjdacGhyUjNQejZSMzQ0?=
 =?utf-8?B?SFVTajhabVRKSXVjcHNYLzNsdk56WXdiaFZsUDNzOU8zOVNKMnJ0clpDOGhz?=
 =?utf-8?B?Y1RRdWpHbm83b3Q0SWptRG5zbzJYYjFuNmVKbHFKTGZJOVR2MjMxOWZYaUpU?=
 =?utf-8?B?ZmJzeXhoNFMxL0JWelFyOGNiMWo1cjhMRDRpMFRsRzIxUFgxUDlqdjh5Nktl?=
 =?utf-8?B?eWZxcW5tdERYMzEzOWl4SEFUcWsvbjRTdXhCWTVxT3V4OUgyTkxjL0w4UmJ0?=
 =?utf-8?B?NEtqUmNIQ2dhNVVpemZ4M3MyUGNvT2Z2UjRZWFJGbC8yY0Z6ZjMzK2dqa2Z2?=
 =?utf-8?B?SzRldzZKSHN4L25EV1pQVjluaVJrdjlHa09lNFluOURjcWFzODV4eHFDRW1S?=
 =?utf-8?B?dHJhNE8rd0xUTTVmNjVNNXM2enBLZGFLNksreTlWY2VtSzVOQ25NZ3I3Mi9l?=
 =?utf-8?B?ZC9RSDh4OEhVZG0vWkVHRlFxMG5oV01TeDdFVzd4V24yUnlxYzhkK2dEZFlE?=
 =?utf-8?B?eHozQmlBRnhwTDhiejcxdVkvMEtwMjNQY3FqSFJxcFZnQmEremhybFhOOGIv?=
 =?utf-8?B?WGg3a1JwS2p2RUd1am45T2N5ZXlEMzFPRDlTQzBPTlF2UHlUQUQ3NURRY3Bu?=
 =?utf-8?B?YUd4OTJJQWUxU3RvWEl2QlF4eDRGTm5NaTZrQUNzZVA2VGJ2WDNxSUlLR2l6?=
 =?utf-8?B?NC93KzlDNjhYRkhMSDE5Um0wZUhGNmFJSThHMkkyaFJKcWtidWIxOTFtanln?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UdGLdOi24JYAwtk05IrdrK9+pMbYI2l7d6RnGtZIQpXVXUTz2JKg5zW3K6pdeaMwH+YZAuR4DDPR0uKkRlwhSz4W9i8SxnfY1lcoVWDCDoNH5XgBksLg5lVwLyvauYwLja2USk2eVldHQpiAhZTHwPJ2E2pdHT2B5sOOe4u3/ydLdiDakI/io+YRm3mR/xIciBhk6a72LtcZfiXqxnVgs5zIRdb2biReqoT+fSP78aQLDkYrh6etJrprjZ1K3rbZ7tMIhwsrbV1LWZ9bTCqEFDCMDY+qHoVwbJGHLKczxwciGJj9ZncuMoA8/0/L1kwz2KYuMe6FW+D+aoxvN5mz9qpLShUdFdy9l3OqwssJqCEqCONZHFFJd226nu7klB/A4FjYknnmOuaX3D0Mm2CQEp703/5ggaxV5XB9gndU/lIEos8+yU7I/2c085Jwe4MGadMYPaEIwOA9lwNOaYk5yw6NgCSEasLHndGnafgfqDs8LMckyEZpUA6MDgUgz1ej0IZIerk31lDIpbLwXicrKvAmxMyJtvdvohuGdOWrcbfkQo+g+h93UiqwKILIYgnSBqC5SBkFbjf0vym9oMVRU9xX85vOG6mFYlZ1wWAuanU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b4ff58-3d32-4a79-dc6e-08dd63ab3d01
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6322.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2025 10:22:07.3551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKHuIpb1RS53KusOgaEJGPk8mWuY2kK/Uzpq2KS6hM3wTN0qRlafAU6gEbMiuL65J93WLmA/Xo65HcrO7HCtoWliRsLpWb/c8z7LLuvcTuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_03,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503150070
X-Proofpoint-GUID: Ctqt3pKUT_P1U4zXG46cQyhTRxjl004x
X-Proofpoint-ORIG-GUID: Ctqt3pKUT_P1U4zXG46cQyhTRxjl004x
X-Mailman-Approved-At: Sat, 15 Mar 2025 14:20:02 +0100
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


Hello,

path to efi executable can be re-defined in..
https://github.com/u-boot/u-boot/blob/master/boot/bootmeth_efi.c#L26

but then 'efidebug defaults' prints incorrect hardcoded path..
https://github.com/u-boot/u-boot/blob/master/cmd/efidebug.c#L529


I am not advocating any circumvention of uefi std boot flows, but anticipating EFI_DIRNAME definition as close as 
possible to BOOTEFI_NAME.
Perhaps in header file?

Not touching any code. Regards!
Filip


