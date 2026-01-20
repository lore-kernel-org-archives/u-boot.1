Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B515D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D106E83AB8;
	Tue, 20 Jan 2026 15:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="p2GNi736";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02C8F83AC5; Tue, 20 Jan 2026 14:53:11 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A0283A9F
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3YWvi9CZ9wUdlZirHqVrtv3V9u1QYsdWABVkylT+n5WpAtSM3SsDAPtywpwRSw0LudyzwGx63OKXG86xqvgy+aUm0QfOS4NTNbAmaiuULTLQAjFr0p35M1OUXJjydBt73AVhqWZmhC1yhq55XZ3GarrG5aGEmWtAe6jWWxwgbEex57k5aiE1gOAJ0tJgHsYd6JEFJQQaltKyVPjvI9qUL5mTlBEynO+LDdfq0obAbX4szKuWyRiGbKmUpUe/hZWOdw18hNz1FJjvriqT90SKueMLW9+u80rIQxdQPFHrPqBMjvV/5Rxy8wQSTW66YPylrEevaLdDHW9FvzF5O+uLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVEha07JbOMicuwzVrjQR+U/7V9qCm41oCJyBvh7Snc=;
 b=tzyAD2MJmTaybeyrh480H8l415l5Wdtwq3mXQlNbu6KRwMfgagCH89/2MJC9U/Z94CUqbCsf2C0OpI02KHOcmZ5+9O4BBqyf0a6BoIez9ZoVRDx43m6reVH0YRCc4xwS9i3WvH9yqiMdFgJEg0PjJbu7kjEr2BVoEUf4nOCDEKssftyAlj0vDcyACLEp8DLUlyPCelQbpE0XZevvMwda6jIwWsU6s9Z/mZNX3iEO5fvnGhatMXe+JKub0hl8ds8C69rpC7ctRRu6CfF+ultUS9iBEVkhSrDk6My6SWeLYTdczQUud1FJ5LSGLGGmxqE8cMqQ6gct7pBECi01NYMERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVEha07JbOMicuwzVrjQR+U/7V9qCm41oCJyBvh7Snc=;
 b=p2GNi736xV1Ks2hXZ1+kN/2S5L8BXUtksOHdtIRbBavrkX7vWhmVJ2m6cKUnKfo8KTJ9k5tHIdZ0bG8EFjs8+wwe/RIXwBLO/+CBXHuDy/6JaThGrlLj3xKlChNQf+NpeUU6lEI/gtJdietqxzZ4U7viXl29CALWUZRd8ij6cGYVbo5FgRtzUpx619fT6dqpmSi9D98bOsBet/y63FugptPc/RGYkPhv/IRKNU/BYM/lG+Lcv1GpYH7f8daVgpe+CqhKBnmcKM4D5vH42BAp9iJtVQXd8NnmeoJ68EEbcndsO62t7gkLSk9WYT1Uq363XExugAI0Cl9zxlc2D93URg==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 DS7PR11MB6127.namprd11.prod.outlook.com (2603:10b6:8:9d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 13:53:04 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 13:53:04 +0000
From: <Jamie.Gibbons@microchip.com>
To: <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Topic: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Index: AQHchwFkjqXL5NuND0+6jEwP8Ex5sLVU+B6AgAAFeICABMM6AIAAKjaAgAD8CgCAAAJ4AIAAMgMA
Date: Tue, 20 Jan 2026 13:53:04 +0000
Message-ID: <856f8b6cdbc2311ac535d9b03c6e2d21a859c526.camel@microchip.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
 <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
 <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
 <baa48570-2114-4313-9bac-280aab0960fb@mailbox.org>
 <58101ca60af16df66be8e2707fef2597f855a8e1.camel@microchip.com>
 <712cfdc9-b3c3-4fca-8f14-763efdf5e0ae@mailbox.org>
In-Reply-To: <712cfdc9-b3c3-4fca-8f14-763efdf5e0ae@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|DS7PR11MB6127:EE_
x-ms-office365-filtering-correlation-id: 10ba92f7-7dd7-4857-f85f-08de582b3bb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cDMrbzg5Z3Z1U0c5cmVGcUJOUVpWcENxQmpnZWZHcFd6ZnNwcnU5MFVPZFBa?=
 =?utf-8?B?cnlUOVdvK3BzNVU0UWdub0w4VVpEQTMzMlVCUnpSZkQ4dmNJdFhrZVQ0Ry9a?=
 =?utf-8?B?clI5UHNHZCtKbVYxR1FSOUpVdEt1VThvUUZXTDBENXJJNFJoek51cnlhTW54?=
 =?utf-8?B?TXhyTGN4RlAwbzZTWjJOVEhvUjdMemhheGpsSHI4K1l6M0hSNWRsTFlEQ2Ir?=
 =?utf-8?B?UWhsM0RJek8xcjJucEwvSzh0MzhVYXNZU01LYytqYXZBV0dDZjhEYXoxQWtW?=
 =?utf-8?B?eWNydWhRVlJpd1hwa0pSNzdUWUNsVk8xaENmbnB6Sk9tQ2h2SHZ6MmlRMVU1?=
 =?utf-8?B?Z3FRaVdmNXBrSnVQeGMzVU1weGI3L2lkOXFpNGhDZWJFUGpXZTFFMnd0cGdW?=
 =?utf-8?B?RklNRkh6VFptNGo1MktvZU9XUFdHSzVBZVRobWVUb3hvM1ZjUWlZZEY1Q1JF?=
 =?utf-8?B?UUNjU0RwcXZ5NG1XdFNGWW16elVoUWFpZ0JGRVZzdmovSERFVnlYSXByMklp?=
 =?utf-8?B?TU96d0VkVnp4Q3ByVTkvUnZWVERzb3JGeExwdGt4cmJUaURpRDJCL0FYZUJH?=
 =?utf-8?B?TkNnTCtpaXNzUTJFbWZ5MnRWdzRuM3FzRzNJOUtJR1dOUU9HQ2VRb0U4blRO?=
 =?utf-8?B?b3Y2WURNM2NDbmZVemlINVZHM0g5amxMclZLL3hpYUVnNEMxSlZKcHJhOGIy?=
 =?utf-8?B?WXc3YzI1TkhBQ1pYZW5DTTM2TkRQcU9DL3laVE1mdElEbm41Q3NISk43RGJJ?=
 =?utf-8?B?VkZGNmt2eW02SjNGT2Q5WjFibDRzUFAzeVRYOERtVEpxblR2cEtDYmtmTTRz?=
 =?utf-8?B?c1c4MS9CR2R6TjFPbEtBeVpqKytmU3BVdWFWS3A1WVNpN2d5T2FsbXVkWEhv?=
 =?utf-8?B?ekdKL0t2Z2dnTENuWURwbmtsek1PMkNldUl5RHFNUGhyMkJhdmtBMEFsVVcr?=
 =?utf-8?B?aU94VnVDNzZoQXlKS1c4ZGtpd3B6YVhyUkJGWHZ0QmJ0WTV2RzU2bFdsakhD?=
 =?utf-8?B?WTdHVTMwYkk1ekp3N2J2dnJlbjBUVG5RcG1WSERTMW8wZ3doV242WGM3RmFN?=
 =?utf-8?B?Zks0bDVRYWgxQmJTNFE2aTZLZ3Y2OUlBSitEakdLWjZNMUs5T1VLVmtYNzIw?=
 =?utf-8?B?UDJRMlpIOVpkeEErSWNYeXFKYmdUQnBhYlN3V29TdlYwYmYvQ1Z2d2s4dVh3?=
 =?utf-8?B?VFd3cEU5YlMzUXNzN3VnSnIyWkhBY0RMSjZjanZCMFZCVTRlaERGbTMyK201?=
 =?utf-8?B?SHNQU3A2RVVabkJxczhsQ09KaG1xYUlSdUQzWnpqODFaUG1pMkh1Q1UweGE5?=
 =?utf-8?B?dDJ5bm56ZmIxSUNJTThaSWo5VTJmellzRmZ2UU1CMGMxOTJ4UzBCeFg0N3hw?=
 =?utf-8?B?czY4SU1MWFpzem44RjgzRk0wcW9maGN1bFJndnhUZlJ1WkUxcjFWVk9qWXZ4?=
 =?utf-8?B?S0tsVm5oWDNXVlhDbysrNGFSRURyYmtCUjA2QllqQ3hjOTc5aWJ2dDlVMVJM?=
 =?utf-8?B?THMwcXJMb0NYQndxSEE4YUNQNUFxNW1ZUDZMakw3RXYxNk5Iek9vZUpLY01q?=
 =?utf-8?B?bmZuSXR1YVFMeHdORmU4RXhqT2VnRWVnamRGS2t1dko2VEg3bzlqU1JSM0Zn?=
 =?utf-8?B?SzRUQWdpTmRNSmpKdVpmTlZLaGVITDBJd01UU1ExWjVseGpYN0FJU3NETVZY?=
 =?utf-8?B?d3ZnVUdycXE3WGV5Y1U0Y2I3WlFZWXU5aHFrQVkzTnZxeU9INnB1QUdMeFpv?=
 =?utf-8?B?T0RtYTVNK1BIQ0NyUytSTUNYRDBwRm5VRGRLU3ZpWXNNMU02ZExreWVWdis5?=
 =?utf-8?B?cTNPME9DU1dxbldMbWUwSjB6LzRZMGhBMUpLb3QrR0tmdDRmWVNWTVBvdlhn?=
 =?utf-8?B?SDZROWlWbEVjNS9CRFFCTWJEZmNyK0tSN0E1WVRpL0J2eGo0NkFrT3ZZUUxy?=
 =?utf-8?B?VC96cnNHSk84a1RreTB4cUorQ2lwMWRjbzdoZEM0VWM3VUwyR0thYXEydXRi?=
 =?utf-8?B?R3VSN0tDQkc3VWU0K3lpQTcvdkVxam9SNXk3QmVDL0oybjBkUzRQcEs2R2pX?=
 =?utf-8?B?Q3BnRWd2cFcrUHA4VHpIcURmZUoycDdiSS9zazBOVmRKTEt1WVVaVW8ycjJ4?=
 =?utf-8?B?NjlINElHTjdKMy8vZEZQbmdlei9uVTVwTlpYaFVSNnFzZjg2b1JhVmJMM3Y5?=
 =?utf-8?Q?utjKXuNsfls+N1AXzNwVsAE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlpUNEVwcEZ2SERHSjZ0ejlBNVRtMVFrWVVXcjFvQmlwNlp3M2w1a3ZDWFZw?=
 =?utf-8?B?WDJzK3VFZ3NreDB0MnZibmRCejJzREpUK2xvNGpKSkVCZ1R0VXN0ZjVGdzVB?=
 =?utf-8?B?L2tTalJ6RXdoSUcvOFJaMG56QVRaQm1vQmYxOWdCVjYrYUpDUHU2WWx0N2Jj?=
 =?utf-8?B?SmhaTDE1NkhDS1FkYXgyaXMrMHBBcUtpeHpmYW9qU0JCamRxQmhreSttTEhP?=
 =?utf-8?B?UmFoTHFRT1NxZVo0WnU5ZHE3RVZxNzQ0aXdCWTB1ZndvQ0F1MXJ2K21oU01u?=
 =?utf-8?B?UDgzeXl6OUlKM3lWelFzTVFqbnFJUFN0RDBpckptNTJMSmpOY3BJMzFJeTRi?=
 =?utf-8?B?VFRPREUvL251aWg1RllWajFOYUh0Wkl0K2ZwNkM1NGtyZXpOOHVKMFJVekdp?=
 =?utf-8?B?bTgyd09LQ1lJRFY1bFl5em0zRmptKzZhVTgvUEJHQ3pKYlB0OElDaldHVG1q?=
 =?utf-8?B?WmNUVHE1cnFZcHloVnpLWTlOWmlJS1d5RXV2ZDFZTHM0ZkZDd0VrRHdlS3Yx?=
 =?utf-8?B?blYrQkpRQ29Fd3liMzhHdWZSNTk3TTY3djErT3NnRUM5akVXMmhralBLQ3A0?=
 =?utf-8?B?cHZaS1BLOU5ZSllMZEx4bkxrcmd1TXk4RjN5ditiYkhZeFJvME9lOWEzSzlX?=
 =?utf-8?B?YTJzNXZRWGliYmR0MndOQ0d4VUUxbXdtRUxGV0swb0E5dTA0SCsrVnd3TjZE?=
 =?utf-8?B?b29udDVQaDBkaUtLRUpLQ2NCcXI5RWhpVXJiVjFpbDM4UWpVaTlMOGduMXEy?=
 =?utf-8?B?NXpzK3pmYklVeDV4QlMvRC9tUFlzQ0NOVXVxODJmZVhoc0hGUFVBVlBpRWR2?=
 =?utf-8?B?KzJUL1ZPbTQ4Z0xNeExrWWFhZ2NuM0lYOHpxT3U3VnE3c0xaMmpHcGJtZGwy?=
 =?utf-8?B?bHNwQzJES0hyUkJDUi9wSmVUZnZ3SFpPMkJoZ3N5bW51cTV3c09TM0ZzVlNu?=
 =?utf-8?B?MHU0VUZGdWxtNHR0RlZzdzFwV0RneDJQajlkSWUzME11Sm9rR2ExWHdDWGtz?=
 =?utf-8?B?NmErelRaQjFkSVNCRW52ZFQvV09wV1lSR0E2eWcrdnYwK1dEMU5UeGxST3pL?=
 =?utf-8?B?dXZmK1R5ajljbDVVejMrK1NaUFJXOGdTaDZMZ2s0b3NEY09XWVZkTlJzbExU?=
 =?utf-8?B?U0JSZ2RxV0FGQWJCNWxDN29KL20vUG5UZnRzRlRkd0E0MHdEUVN5aTU5UEZ6?=
 =?utf-8?B?bUJ1cGIzNmY4SXp2cmVVbmZ3S0tCdnBaOTMxdlJyMmMyU295RU10TitTY2Vm?=
 =?utf-8?B?N0dPTm5oTUNZb0l1K1d0NDlLUXBwNERNVzdXMXFGVG1haytmWGczZlRWRWIx?=
 =?utf-8?B?Q09vYy8xYy8rUkduM203WHVmSDJJZkVwVnNVY0wrenM1Rm5Ia1ZuMENINkJt?=
 =?utf-8?B?Uzd6TTBNVmV6YWtqaDNVTHRwRFREc0tJTHVoMXVJejIxb3l3RTFFN0labUl2?=
 =?utf-8?B?M3JGQVo2OFJNUzRDeFNaQ2pzMTRkZXVjcHJqMFM3cU5hWUFDMU1JWmRzckZW?=
 =?utf-8?B?cW1UMS80TWVpM0ViWTZIcklvbDNxalBLTTdqdXpiam5INUpxelZmaXZEWUI5?=
 =?utf-8?B?V2ZjS3UwWU1MUDdRQW5RWXIvNUw4dnFaQXM3eDZ3cjlFeDA2U0xxSXRsZVNm?=
 =?utf-8?B?SEowRmFQd08wOHNtS0tGYlZ5Y2R3NUkrNUJBc3ZzZDhlcWRjejF2Q0k2RWk5?=
 =?utf-8?B?dDhlQ1hVeFBpUC90cDIwejFXQTdsNjBuSWNjNEM1THE0VzQvcms1Y1VVNkJB?=
 =?utf-8?B?S3RNeDd5NGY4ZVNOYU0yWjZ2OXpYS005OGU4QU5hZWU2a21heURZN2VPaTFn?=
 =?utf-8?B?N3AxUS9VWlg5bjB1WmJaWVp2alZ5ZVo1WnpUbW1oRENTbU9uR2xiWlFvZDVp?=
 =?utf-8?B?czNUZU80cnRLMm9BYkd4WEZXTE1LNUQ2NWpOZXNBTHVoeFBTUUU0NU1hekpR?=
 =?utf-8?B?ajVyNDFHT3FrVWZFZGRYSm1KY0dkUnJLYXFVeDE5a0VpUmF6SDVLUUtJY3dj?=
 =?utf-8?B?ZjUrQzh2TWRENWJvVi9CWUk4ZS82bmo1MXh3SUJOekIwWThBNzNSR0IyRHNF?=
 =?utf-8?B?ZVAxUC9sSFRxVlg4SStUdUZCbk9acG5Kd0VhcmxsZXFVOGFXcGl4VUhrbWQy?=
 =?utf-8?B?Z3pzZ0hlV29TSTRvOFNrc2Y3QzdMQ0kxRXpaMy9PMXNBZTRFcEVrenNuRHRC?=
 =?utf-8?B?c1RCY3paOE9NNDdDUm43S2lINXg4aWN4SnN4c3g1SVJJMlhlUjA0VEgyd0No?=
 =?utf-8?B?WXM2TFN2a2RWTVI3YzNaZ3o0cSt1TG02Y3hsc1BYT2g0dXZwZ3JudURqdkVQ?=
 =?utf-8?B?NnNHSGlDOGtaUzR0MFo1ZHMwaVdYSFl3NURRRnZNVHgwSUhxL1RTZmtadDhH?=
 =?utf-8?Q?a0ajtjzy3LuyLU4c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00152CC9F5F67141BA92CC0EB6B01E50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ba92f7-7dd7-4857-f85f-08de582b3bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 13:53:04.1581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttHt7O1oU+pIgIAF7ql33DfqcIVu5Fi1u2XTicKA/P7rEwJF8jbSYSASwu2eBy9z/E0CSSzYFXLhDQjTVUrZKsMh2NuY8/unrE3hY+EdKy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6127
X-Mailman-Approved-At: Tue, 20 Jan 2026 15:06:23 +0100
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

SGkgTWFyZWssCgpPbiBUdWUsIDIwMjYtMDEtMjAgYXQgMTE6NTggKzAxMDAsIE1hcmVrIFZhc3V0
IHdyb3RlOgo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91Cj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlCj4gCj4gT24gMS8y
MC8yNiAxMTo0NSBBTSwgSmFtaWUuR2liYm9uc0BtaWNyb2NoaXAuY29twqB3cm90ZToKPiAKPiBI
ZWxsbyBKYW1pZSwKPiAKPiA+ID4gMjQ4OcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGRlYnVnKCIlcyBsb2FkZWQgYXQgMHglMDhseCBsZW49MHglMDhseFxuIiwKPiA+ID4gMjQ5MMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdW5hbWUsIG92bG9hZCwgb3ZsZW4pOwo+ID4gPiAyNDkxwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb3YgPSBtYXBfc3lzbWVtKG92bG9hZCwgb3ZsZW4pOwo+ID4gPiAyNDky
Cj4gPiA+IDI0OTPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdmNvcHlsZW4gPSBB
TElHTihmZHRfdG90YWxzaXplKG92KSwgU1pfNEspOwo+ID4gPiAyNDk0wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgb3Zjb3B5ID0gbWVtYWxpZ24oOCwgb3Zjb3B5bGVuKTsKPiA+ID4g
MjQ5NcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmICghb3Zjb3B5KSB7Cj4gPiA+
IDI0OTbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJp
bnRmKCJmYWlsZWQgdG8gZHVwbGljYXRlIERUTwo+ID4gPiBiZWZvcmUKPiA+ID4gYXBwbGljYXRp
b25cbiIpOwo+ID4gPiAyNDk3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZkdF9ub2Zmc2V0ID0gLUVOT01FTTsKPiA+ID4gMjQ5OMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPiA+ID4gMjQ5OcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+ID4gMjUwMAo+ID4gPiAyNTAxwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gZmR0X29wZW5faW50byhvdiwgb3Zj
b3B5LCBvdmNvcHlsZW4pOwo+ID4gPiAyNTAywqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGVyciA8IDApIHsKPiA+ID4gMjUwM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBwcmludGYoImZhaWxlZCBvbiBmZHRfb3Blbl9pbnRvIGZvcgo+
ID4gPiBEVE9cbiIpOwo+ID4gPiAKPiA+ID4gVGhpcyBpcyB3aGVyZSBpdCBmYWlscy4gSXMgJG92
IG9yICRvdmNvcHkgNC1ieXRlIGFsaWduZWQgPyBFbmFibGUKPiA+ID4gdGhlCj4gPiA+IGRlYnVn
KCkgcHJpbnQgYXQgdGhlIGJlZ2lubmluZyAob3IgI2RlZmluZSBERUJVRyBhdCB0aGUgYmVnaW5u
aW5nCj4gPiA+IG9mCj4gPiA+IHRoaXMgZmlsZSkgdG8gZmluZCBvdXQuCj4gPiA+IAo+ID4gPiBJ
ZiAkb3YgaXMgNC1ieXRlIGFsaWduZWQsIHRyeSB0byBnZW5lcmF0ZSB5b3VyIGZpdEltYWdlIHdp
dGgKPiA+ID4gIm1raW1hZ2UKPiA+ID4gLi4uIC1FIC1CIDggLi4uIiAsIGRvZXMgdGhhdCBtYWtl
IGFueSBkaWZmZXJlbmNlID8KPiA+IAo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb25z
Lgo+ID4gCj4gPiBJIGZvbGxvd2VkIHlvdXIgYWR2aWNlIGFuZCBpbnZlc3RpZ2F0ZWQgdGhlIGFs
aWdubWVudCBvZiB0aGUKPiA+IG92ZXJsYXkKPiA+IGJ1ZmZlci4gVGhlIGVycm9yIGNvZGUgcmV0
dXJuZWQgYnkgZmR0X29wZW5faW50byB3YXMKPiA+IEZEVF9FUlJfQUxJR05NRU5UCj4gPiAoLTE5
KSwgY29uZmlybWluZyB0aGF0IHRoZSBvdmVybGF5IHdhcyBub3Qgc3VmZmljaWVudGx5IGFsaWdu
ZWQgZm9yCj4gPiB0aGUKPiA+IHVwZGF0ZWQgbGliZmR0Lgo+ID4gCj4gPiBJIG1vZGlmaWVkIG91
ciBCdWlsZHJvb3QgcG9zdC1pbWFnZS5zaCBzY3JpcHQgdG8gZ2VuZXJhdGUgdGhlIEZJVAo+ID4g
aW1hZ2UKPiA+IHVzaW5nIHRoZSBzdWdnZXN0ZWQgYXJndW1lbnRzLiBXaXRoIHRoZSAtQiA4IG9w
dGlvbiwgYWxsIGJsb2JzIGluCj4gPiB0aGUKPiA+IEZJVCBpbWFnZSBhcmUgbm93IDgtYnl0ZSBh
bGlnbmVkLiBUaGlzIHJlc29sdmVkIHRoZSBhbGlnbm1lbnQKPiA+IGVycm9yLAo+ID4gYW5kIGRl
dmljZSB0cmVlIG92ZXJsYXlzIGFyZSBub3cgYXBwbGllZCBzdWNjZXNzZnVsbHkgaW4gVS1Cb290
Lgo+IAo+IEJ1dCB0aGlzIGlzIG5vdCB0aGUgZml4LiBXaGljaCBwYXJhbWV0ZXIgb2YgZmR0X29w
ZW5faW50bygpIGlzCj4gdW5hbGlnbmVkLCB0aGUgb3Ygb3Igb3Zjb3B5ID8KCm92IGlzIHVuYWxp
Z25lZAoKVGhhbmtzLApKYW1pZQo=
