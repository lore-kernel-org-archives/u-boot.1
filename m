Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84DBC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 16:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB4C83A3B;
	Wed, 21 Jan 2026 17:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vnZ9BuI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA307839D5; Wed, 21 Jan 2026 17:46:10 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFBFC80077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 17:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsYe6dak3Pz8MSYnPcLr71z7Z4FnvQLl29YfXtuwR/wp6Bff6oPD1hWIwhWC36n7Z+CZM6bI1oGF3WccXfuxiGvGow2G2upTSQLufJSloLca2Wrn+h21E94PS+eyplWgFG4yCq8b0kvL2V+dKLFn8iYA+1w0qg966qxT3o1STaLFxNlypLF65m8pfw+W0eMr0xRI90zWeO5Fw8AtNNCK8VNeF7SVCEqB9KfYAwQhPEMGhhAvOeIhLHwCGGDEtntRzz/M8yvadTz143JNVciM9N3U0mBLfc4MrbNI9D1Fi/Jdictgg3RTh1NH/Q9sXoBwdwWVGlHQe/LFYRP2pQKn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSru+CrWa2XavhPfQbpWLmseSBWnLo3Yr+SepozwMn8=;
 b=RMAc+O8REgB7QkDTe0QUD59xYXbIq7gSoKixVKFBX8eGL921E+kHWdGgMQ6YNQuGb/NAoXpwnHSybwr3yq1uivVoyplnS8uS95ZI3huGA4AX+GXSYi6WtZVWSBh08ryJiqDe+c6PxAHZeqH+4JXE0xsQQlMtXTO7BcWZCO8YC9aUlWGdemd8BkOlWRVndw2o3zlXNfpMGx1qSZFF9QiJ1Wp9kRJ8QUzLdM9wM0neyxZEj6TDTLCPgamIgc9dSPA9XbwLzHSzWpTqYnNDjlHXE4u/pa/NKzLW0Y3cxCdeBtJZtMnMB2fWoO5gPp0Gcek2x4a8it7d6PmnVs59R3MutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSru+CrWa2XavhPfQbpWLmseSBWnLo3Yr+SepozwMn8=;
 b=vnZ9BuI6ehVdt0U+hZRKjT1gS9KnpoKcdOXjwMWT51HuHRtM18ILQLPNO0AptDXbKm9d7hTTQVVA3vEJYIPP7KZS3znbhjrNI6CGz1UrCEZWd5A+AGKZ6XsKbAA5Cp+AzrLLDuM2DwGu7ZmWR9afoWb3R5jChEOnLIW1Ij6R06PuaiuAl6zBvLd/NXa1mVuOpJicM2dGdd54OBoYnB0UMqzSpQb1hTGOP2BcKP9fscI+uFwQVFv+wvOxpTvpCJKmzNdtWSZU7jjxnOqytXbrm3oUZMMvuxpPz+a/+ZAKi5x5NPhjLPs4Hx/jUd6N/btb1s7+x9FnR9TXUhoI+bfLfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BLAPR03MB5649.namprd03.prod.outlook.com (2603:10b6:208:291::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 16:45:58 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:45:57 +0000
Message-ID: <0d50377b-22dc-41f9-b74f-de1cb97959c0@altera.com>
Date: Thu, 22 Jan 2026 00:45:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dm: core: Support multiple drivers with same
 compatibles
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <simon.glass@canonical.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-3-ebb8d990b9df@baylibre.com>
 <87bjitesqo.fsf@kernel.org>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <87bjitesqo.fsf@kernel.org>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BLAPR03MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: d23069ed-8007-43df-0d29-08de590c8cbc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|8096899003|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmU1a3lsWXhQdUJyNWNpTWlFMW1kb2VTNlV5YTNGNEZhMEE1M3kzUEsrTFZI?=
 =?utf-8?B?NmNNRElCUlE0TnM2Q2xoaVNWb3gzcmlJNmJ5cTZEWFcvSU54RTdZRHJkUlhi?=
 =?utf-8?B?U1cyUXY2RjlRRWw4eldscXlleklsU2ZMdldwdmpGY2c0SllRUURaaUJ0RnpE?=
 =?utf-8?B?d2VoVDBXWjl4cG95S0NZd2k1SGdFNExYcS9RM1JVc0t4WVJNdXRPQytRQldT?=
 =?utf-8?B?MEliREhiTFVvSkRLQlhHTGNrQkpnN3JvT0tKaEQ0NVRobWs4Q3pvT3c3VURR?=
 =?utf-8?B?OW9qNTY4RzNkaDdtS25YSm1hQXFhbld5WDlEMkFoT2F6anRPcFhNQ3hwQ3ZX?=
 =?utf-8?B?aDBpaXd5SjZxb25qaUgxOVZzQm5uRWpOYUUvblVGUmsySjZhSGJLNnpsdWtM?=
 =?utf-8?B?d1k2M3RhcnZqdmJUa0NoSFduemdkU3dIY3RXR29sS3N5T1pUTEE1Q0dvd3VZ?=
 =?utf-8?B?U3ZYaUg3UGhRajZyWlg5M2FYdWswVlkxeWl4TGE2SDlpb3FreGhobExoendS?=
 =?utf-8?B?UFB1OGNkaTdVNUtpd0FrZ0VlUnhjRENhY2pGaDV2UlZ2RCt6M2FwVW8zbTU4?=
 =?utf-8?B?UEdYcVJKTkxzeFpCOHRqOGJSYnNLREZkNXprVmpWelRuWEY0MCt5dDVzOGs2?=
 =?utf-8?B?UWFrZzYzaCtteU1qd0U3b1Q2SXpJV3pRa1pnVlhCYjlFZ3VWRVFiQWpxMTJ0?=
 =?utf-8?B?MXRBMXZwYklJUDlJdVVWODdCaGF0ZW1wZnI3TzBsVC9SZjRzZ1lzQjFQTERH?=
 =?utf-8?B?WHJNZTluaWYxc3ZVSWYzYlpxNXBzb0tyelgzVkdaTXpHby9mbC81bGlrZ2o1?=
 =?utf-8?B?WGtQMjFjOWhpblpEcDl3d2JHUU02R1loNURqRnp6RE9sSVloa2tTMk5ieGNK?=
 =?utf-8?B?VGVTNklyK3MxZC9lclBXcUQ5ZGphVHl3TVdJMWNTdFU5VmxFNzlCOWNudC8z?=
 =?utf-8?B?aUxVZDFFVFN4MWNjV08yL2V1V2FBOVJjbnpaZ3lDOGZXd0RDY1g1d08rdzNp?=
 =?utf-8?B?WlNVVjBhUkJTb3I1S1I5Z0JXazFFVFNDMUFWakI0ak1Pck1tOXZnVUJYWmN4?=
 =?utf-8?B?czZkbWhKeSs3cGIrQ0Uvckw0NjQyQjlLRk1iQU5sVThFQU8zTGxIdXFwckdw?=
 =?utf-8?B?anNKa0NJYnllaFl5SDdzT0xuSjZTT0lTUmJJd0pRYnR0eTIwLytqUkVVWndO?=
 =?utf-8?B?aDFVOXFrR3l0aWlPMGQvYVVGcnRsS2M5U05nU0NmRGJmR25mL2xiVTZkYUF5?=
 =?utf-8?B?TFVtQlRqU0VCM09OK1hIckNuTUMxTDVHSitjcHlrMmR1cFRXNjhKSlh5MkNM?=
 =?utf-8?B?OTZQTFdMR0xPeGx5T0tKU2k3cTlGT2dkNEFMWkdyUVphdHhwM1MrNmpSWmQ4?=
 =?utf-8?B?QzVpQWM4ZWVoU3RFNTNQZjl0dGJsbnhxaUhqeGQyTmxkWWlkL2F6Z3hEaXhk?=
 =?utf-8?B?c1Jocjk5cnFSV2NmZnM4S1FjTlFZMUM4NGJvR29aN0Y1K01SS2ZLZDBhaVVN?=
 =?utf-8?B?TkR2aXg1MjBKNHNta3BmeUFsV2tLc3YyVmxpY2VQUERQTFNRV3dwTE9iRW9z?=
 =?utf-8?B?TkVxaXhYdnVaZ2ZSeEM5OHBQczBTNnNieEJHZVdLQXhHNndQQ0tpS0ovSVdN?=
 =?utf-8?B?NWFqWVpDamY1NnJFNXg3Q0FuUkhXUHFoNjdsR1NwdVdEVXB2cWh1RndoWDJ5?=
 =?utf-8?B?OWxQaHpQSm1WeXduZWlDcUxHUnpTMzZtT0pHQUlvRFdFQ2tPTGdKWFVXNlc1?=
 =?utf-8?B?UHdvYVB3MVJaZEQwRXZvRGpZbUFGU3VxK3VBSFNzYm5iL2hDQ0M5Ny9hRy9M?=
 =?utf-8?B?OEQ3MThzMHF2N21nNzJhdXBpbmhwcHBpU2w3eTN0QjdXNzhaNUpmRHp0MVhx?=
 =?utf-8?B?M1AzV0VOYXpheXZYSUR5SUdFUCtLVWNXck5QQ053OEVNTDlvZldrQ1FOMDNN?=
 =?utf-8?B?b0ZZS3BYWTc3UVpoRW83QkdFaFp2UmdsWWhzT0RzUkNNQTJ1SDFiVjVib21V?=
 =?utf-8?B?aXhaMlZnMWFOc0p0UEJyMkd6QkEyaDFjT3UyOEoxM1E3eGd5UllOVkRzc3lD?=
 =?utf-8?Q?4OC6um?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(8096899003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUFJME5DN0N5UjF3MVJUVnZTWm9uUk9DWUFXMzF6R1BLWGZBM3JVZTdmMDZt?=
 =?utf-8?B?VFljYWZSWTFKQmtPUXo1K2hXdlc1ajMrVzM3aGUwdHhNRHhsSHhNdUp5bWdM?=
 =?utf-8?B?dUdOdllxUHJYWXZyY3pCcHRQcUtVcDd6UkZsYnF2VkhsUTFWbkYzN0dTTkYz?=
 =?utf-8?B?ZlU3RG81R2kwV2ZhVFFId3JraTlNL3lOK3NaNC9QMUJYdlRENWR0clA5eFR3?=
 =?utf-8?B?TVI3cHhIMmg3aDR3RFN4OVd0ZnB5U2Fia2lnUHVWSi9QOU5pWExGQ2dzVXVy?=
 =?utf-8?B?anU0Q1ZPSlREc2ZGTmdRRlE3blZHVVhYTkwzTlVsREtKU09uN0htem5zTlNv?=
 =?utf-8?B?VFh2SHFNUUlON0R0NHNxUkRJMERndmtKZDZlSHQ0MDg4MlZSa0F6bDdmc0tE?=
 =?utf-8?B?dlpQT0pURysvSFB4VDN2TlFRZy9QY0o5dHZSVnNsb1ptUlViQlNmeEl6L0Jh?=
 =?utf-8?B?amUxbHErY3JKMkk0dkJYQXlxd0JpMFJza0NsaVFpMEVoMDJqOGxsblArV0VI?=
 =?utf-8?B?RVpKTmpDcXZ2THo1SkZNUG5NVURmS0g3c09oQ0RtbnBDNmNoQUllZjhoSGJR?=
 =?utf-8?B?UWxML1VlVFlsNWo3bUxCT0xYRDZOUkpqS3NvbzZpNXVtZ0RhZkZFSHB0WWFt?=
 =?utf-8?B?RnF0V091T3lONVhQMFowMldBL1hYUjJpU2NvdUFtTFV1VEdaRHRrcEhXMVcw?=
 =?utf-8?B?NDR1OXNIYWZEaVp2RU42UUE0d09SRll6M1lhSnZYOEdYWmdXR2ZGS2xWZE0w?=
 =?utf-8?B?d09vU0t4eC9tazIzVVAyb21yK05pbFdBaENPT3MwZTlETHRuaHo1aDNDOXZQ?=
 =?utf-8?B?amVTY0ttUENGQ3pJNERPeWJyT3BsakJtQnM3bjdkTkk3NTJWL3ROM0I3aW5W?=
 =?utf-8?B?ckwwZmhwcGxGZUp5RmxtWGlSMWswcVBCUDJFcDczNnBZaVdyd2pvZkdBWTY0?=
 =?utf-8?B?Ly9rQ0xQQVdSNDg2SUpTUWQ3ODZRUHgzOFNvVzVZdzhESzVaYjhCajB3dHM1?=
 =?utf-8?B?WUJOeUxkWnQ2WkthOUxaYlFyVTRvTi9uM2Noejd2My9UYjl0cmR2dmRqYTRi?=
 =?utf-8?B?QVFQYUpmRFFqdXNzQ2ZuNnNLOTFPUUl0WXR2Q1l0ckE3WXVUS3UwOXJOcEhp?=
 =?utf-8?B?TUJ2OGpOaVBsUzBUWHVYcUVxb3dpdzh1c2RNYmRGY2svVC8wK0syTXkrZ01p?=
 =?utf-8?B?NXpOa3BmRzhiQmFwOGJNTjVQSURNWDRUSTAyQlU5ZGNPZDMwUGpPZjFwNUhE?=
 =?utf-8?B?WFRlUlBVRUFnbWNWUEVmMWRmeHpkc0V6S01Rb1EyZFdqOTF2Mkw5UWFyK3Vj?=
 =?utf-8?B?NDZ4SUJDbFluTUpmdVFzT1RhbW4xODl5Q2VFc1hXSWpHY0dEdyt5MlR5QmxI?=
 =?utf-8?B?anB6N2JtaXBaQW9wNlhHdG9rVG55OVBVUnJZS2UvMDk4WmNYVFZ3UElBU29k?=
 =?utf-8?B?VDhsMnM4WklBQ25sbTYvbHVyZDVzellMOXN0MXBkdmV1WkZzNEJQVFVpUjRI?=
 =?utf-8?B?Q3d2bllpOSs0c0FLQmVyRXpJS1k1RGNxdjNHV3AxaWkvSUxwTSt1cC9INmQ4?=
 =?utf-8?B?TzJiK0hFd3RPcW5qVUxyYlhwSE5YK0cvYVVicVBKL2hZQi8wcy9qU0hwN0o5?=
 =?utf-8?B?UmR0R01waCtHMmpPU3QvUE9iR0N0dGNjWTgxMXdFQmgrQTZMd01xMms4U2tp?=
 =?utf-8?B?dEpsZGJaV0JJS2NTZ25vTHppZGNHRFhkT3VIa0R6MUYyaWdvbXBNSWtIVnFD?=
 =?utf-8?B?eGFPTTlSTnhQYVFzaFZnbzBFM0lzNmFndWdvSEJORzE2MENWWGxJYXdndXpL?=
 =?utf-8?B?UDA4Y0RmTmkzTWJ5VXg0K042TWtTcVo3aFpPTlMwQWw1alNidCt4RHR3UG5T?=
 =?utf-8?B?anBZVUdjNGdUbkVCODJnakJSME03aTE5cUNCVkpPeG9BQzNHa09ObDhMUVVX?=
 =?utf-8?B?czkyNTQyS3JnMnpkb2NHVnRCUlFDQVN6clFjcDZTQ1VpVHZYOHlJTks1TGVT?=
 =?utf-8?B?NVNxY3F4TWFaQXc3N2dYbEpEdHNPOXRhbGVPVjgwQXUzWmZFK04vVS9aampj?=
 =?utf-8?B?azNGbU05TTBCU2J5ZmRpbTQ3VTdtd3RZRjI1YXQ2N05VMTJIVTZPRURkOCts?=
 =?utf-8?B?SjNYNFh2T2RQSUx4Z3E3NkZqOStRSUVKbTBJM1JoTmM0cnVrdVhMWHJpUlVi?=
 =?utf-8?B?NVhGYWl6cjgxMjV2UGZNTVFuZ3hvSVo4aUhtd3NGT2prMFU0Y3o2SG5IUmQx?=
 =?utf-8?B?cnlmVFVsWG9pRzRYc01HRlY5VkYvdmJla01xYUdaRmhJeUdXcFRxZlJBOGhT?=
 =?utf-8?B?WlNGWjB2M2VZT0pzS0IrekxwK3BFU0gxWUt2Y2daVXBnVzE2Wk1wQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23069ed-8007-43df-0d29-08de590c8cbc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:45:57.6194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUT6zeInPbqS/MTalJS5g2oviJ6YeVEFop0beQ+w3Sp0+WBm1BHZprAzpKuOWNIYxvFb+7TqcxMu3trJXX3kjn7XWSSNM33JtigANtPpVDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5649
X-Mailman-Approved-At: Wed, 21 Jan 2026 17:50:24 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Markus,

Thanks for the patch.

On 16/1/2026 6:50 pm, Mattijs Korpershoek wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hi Markus,
>
> Thank you for the patch.
>
> On Wed, Jan 14, 2026 at 09:33, "Markus Schneider-Pargmann (TI.com)"<msp@baylibre.com> wrote:
>
>> Currently once a driver matched the compatible string of a device, other
>> drivers are ignored. If the first matching driver returns -ENODEV, no
>> other possibly matching drivers are iterated with that compatible of the
>> device. Instead the next compatible in the list of compatibles is
>> selected, assuming only one driver matches one compatible at a time.
>>
>> To be able to use the bind function to return -ENODEV and continue
>> matching other drivers with the same compatible, move the for loop a bit
>> to continue the for loop after -ENODEV was returned. The loop had to be
>> adjusted a bit to still support the 'drv' argument properly. Some
>> simplifications where done as well.
> Nitpick: where -> were.
>
> Please don't do any refactor/tweaks in this patch. drivers/core is
> already difficult enough to review without formatting changes (to me at
> least)
>
> I see a couple below.
>
>> The modification will only add additional loop iterations if -ENODEV is
>> returned. Otherwise the exit and continue conditions for the loop stay
>> the same and do not cause any additional iterations and should not
>> impact performance.
>>
>> This is required for ti-musb-host and ti-musb-peripheral which both
>> match on the same device but differ based on the dr_mode DT property.
>> Depending on this property, the driver is either UCLASS_USB or
>> UCLASS_USB_GADGET_GENERIc. By checking the DT property in the bind
> Nitpick: UCLASS_USB_GADGET_GENERIC (not GENERIc)
>
>> function and returning -ENODEV the other driver can probe instead.
>>
>> Reviewed-by: Simon Glass<simon.glass@canonical.com>
>> Signed-off-by: Markus Schneider-Pargmann (TI.com)<msp@baylibre.com>
>> ---
>>   drivers/core/lists.c | 65 ++++++++++++++++++++++++++--------------------------
>>   1 file changed, 33 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
>> index 9d1ca38212ee7f53b8894f964f096611c8ec20a5..3d9f9bc93954efdd624dddb1833f3a855c3c28de 100644
>> --- a/drivers/core/lists.c
>> +++ b/drivers/core/lists.c
>> @@ -235,50 +235,51 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>>                log_debug("   - attempt to match compatible string '%s'\n",
>>                          compat);
>>
>> -             id = NULL;
>>                for (entry = driver; entry != driver + n_ents; entry++) {
>> +                     /* Search for drivers with matching drv or existing of_match */
>>                        if (drv) {
>>                                if (drv != entry)
>>                                        continue;
>> -                             if (!entry->of_match)
>> -                                     break;
>> +                     } else if (!entry->of_match) {
>> +                             continue;
>>                        }
>> -                     ret = driver_check_compatible(entry->of_match, &id,
>> -                                                   compat);
>> -                     if (!ret)
>> -                             break;
>> -             }
>> -             if (entry == driver + n_ents)
>> -                     continue;
>>
>> -             if (pre_reloc_only) {
>> -                     if (!ofnode_pre_reloc(node) &&
>> -                         !(entry->flags & DM_FLAG_PRE_RELOC)) {
>> -                             log_debug("Skipping device pre-relocation\n");
>> -                             return 0;
>> +                     id = NULL;
>> +                     if (entry->of_match) {
>> +                             ret = driver_check_compatible(entry->of_match, &id,
>> +                                                           compat);
>> +                             if (ret)
>> +                                     continue;
>> +                             log_debug("   - found match at driver '%s' for '%s'\n",
>> +                                       entry->name, id->compatible);
>> +                     }
>> +
>> +                     if (pre_reloc_only) {
>> +                             if (!ofnode_pre_reloc(node) &&
>> +                                 !(entry->flags & DM_FLAG_PRE_RELOC)) {
>> +                                     log_debug("   - Skipping device pre-relocation\n");
>
> This was changed from :
>
>    log_debug("Skipping device pre-relocation\n");
>
> Please move log formatting to a separate, cosmetic patch. This way, this
> patch stays purely functional, and simpler.
>
> See:https://docs.u-boot.org/en/latest/develop/sending_patches.html#general-patch-submission-rules
>
>
>> +                                     return 0;
>> +                             }
>> +                     }
>> +
>> +                     ret = device_bind_with_driver_data(parent, entry, name,
>> +                                                        id ? id->data : 0, node,
>> +                                                        &dev);
>> +                     if (!drv && ret == -ENODEV) {
>> +                             log_debug("   - Driver '%s' refuses to bind\n", entry->name);
> Same here. We added "   -" to the log, making the diff overly
> complicated.
>
> Locally, discarded these message formatting changes and the diff was
> much simpler.
>
> Can we please re-submit by moving the formatting changes in a separate
> patch?
>
> Thanks
> Mattijs
>
> Previously, we were using glue/wrapper driver to support multiple drivers
> with same compatibility.
>
> For example:
>
> In this file,
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/usb/dwc3/dwc3-generic.c
>
> look for|dwc3_glue_bind_common, why not use the similar implementation? |Why does/core DM /need to know about USB role selection?
>
> |lists_bind_fdt()| must remain simple and predictable
>
> Thanks
> Dinesh
>
>
>
>
>
