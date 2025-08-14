Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA46CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 06:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2BDF8367B;
	Thu, 14 Aug 2025 08:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Djsv/0yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC51836A4; Thu, 14 Aug 2025 08:17:05 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6E848334F
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 08:17:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbgX3Kk6kdjHwTfVjfhheY1Glwo+I6k1849WbiIlybi1B2mcSZZIwz1IiQnP9mdEVxBAGdAZ4qWP245Cedv6HTvd+wlZVDZxRksPSeX5RIRZJFBsvRsQhPEgtarG0hWbaLJpSWf9lIWfxbqC8pEZALR3GjtXYivfN4VG03Qzu6Q5aVUnNe8LGhLg0vhziRcx1K7FpMnka6kgDIAvYfK1OAF1ezzZeMpba7IIfS/76rnJqX99yaeFOGwlYTElQncKgU81Xrcgr2DJfuRR80+QU834O+TloXENm0LVLn3G4d4ojjieOk3s/ZuABtMEe39kCiKs6J00tYinQdBmbsZNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wK1JW5EtDqjVPDWGAcFLq1OcwLpmSJxEmVtAYgHpCcc=;
 b=wZCIxjNHOzH49ptdiyQ92s/0csOdLg7Z0koJFqgFIVk8LCjE+8zHjmoCrL8ZS86G/YdTD5EWyo1gsyUpWC9rtoypnZVlgRqZzVVZ8j3NUKyBGGw4oxzhdib7enz0oe6ax+lIQjDet83HahHGFA/MZZSHFVml6M49PxHYaq/3uMpfOTp9xkVgWbOaT0OoozStgYTGafaIK83cmS5LPLIDBejQVqU271VtYWx8ImoSCvogOCv4K5noslG8jWSfFEUFbDkeylImC5W3FDaXjGVLFj6P1rcmcOuX5syIT/xoPazLSwi7XDiFt8hXcsTIDmSmeGVfsG/t74ZJTSJgomhIyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wK1JW5EtDqjVPDWGAcFLq1OcwLpmSJxEmVtAYgHpCcc=;
 b=Djsv/0yj2lxUcVpWFv7lnM5ksnJu2V/1iglIO1/oaWpSamLIv1ixhUbO12rm8PBe1wFwW1iiZG8SATb6VHGODjkQ6zaGS2yZS9a6CYf/4fptMTRUX0xsv1UbjR+zaWew4vBVsMDZbTuf++lyXoLkzyACu52gHVy1mD/oEJXjFexftz1aZO6qgp5LYTeqMaJQYPmED9gb/5Bwab1ggQpQAfVB3sNrjc0WzhWM/zgHTjgUNT3+pDZqxtl9WBQVLLAy0TQgZFZSDuhBoKIrk9XlgXVL9TO30eiqZxZqc0p77IM7kvEhTlazZxhPy5rGGIhoLQrZ6N7B/2LT+uAl7rQTBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by AM6P195MB2697.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 06:17:01 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 06:17:01 +0000
Message-ID: <76ab1570-bf8b-4463-9aca-84aef37b9e79@phytec.de>
Date: Thu, 14 Aug 2025 09:16:58 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: phytec: common: k3: Making setup_mac_from_eeprom
 optional
To: John Ma <jma@phytec.com>, trini@konsulko.com, d.schultz@phytec.de,
 michal.simek@amd.com, ilias.apalodimas@linaro.org, j-humphreys@ti.com
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250813213116.3076551-1-jma@phytec.com>
From: Wadim Egorov <w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250813213116.3076551-1-jma@phytec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0208.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::29) To DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|AM6P195MB2697:EE_
X-MS-Office365-Filtering-Correlation-Id: b5384c87-e548-4585-d55e-08dddafa2e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzlHT1pZTDY3RklWck82WGlzVkU3U2J6elcyVUc2dHFBcStIN3hDMm9TeEFo?=
 =?utf-8?B?R3UyY1orcDBzeXdzV1ZCQTU5a2VhNGFUd3hUcXRGRUoxNUYxMEJidjNmeEpO?=
 =?utf-8?B?VElleE5iN09hZ05JdmVrZlovaGt4OHZhOUpzZm91VEpjMloyTEsyelFYS1l1?=
 =?utf-8?B?dDY5c0dpQ1hoWDN0SjdGNitBVTc3L1dqVE0va1k1WEVBK1Z0RzJvMnFka2Rj?=
 =?utf-8?B?cFIyeWR2WTN5NllFUEQ5NGoxMnI3WWxOUUJ3R0RXSHVNOS9HOVNDTkdSbTdI?=
 =?utf-8?B?bVZ5MmlUdmxjVTlOZWMyc25SOW1GTXhQczBHdHhSRXhNa21WQnBCS3NkN1k4?=
 =?utf-8?B?NEhMSStLUzFoVzhhMXM5bEFhWkZuT0s3bXB3eGRxa0xnV3luRnE4UnlRbWxn?=
 =?utf-8?B?UDlKWnFyR3d1NE8xTEJPYk9iZGpDWW93dlVvOEtzVFhzcVNVNFBhaVBqMlgz?=
 =?utf-8?B?MHhKdnRCNGdrUWtVcjlwZDVURWdQdFhydVQ4bnZJRm1kZUpPUFZqdEhEYjNO?=
 =?utf-8?B?TWZMTHFFOXkxaTFrVWtkTExUYS9BSEJlZFd3QjFaUlhiamNqS2o3V3FIVGdU?=
 =?utf-8?B?eWRWc2N6cUFjYk5vc3NSSk45MExUNFR1QzJZNkN1L25qSFJIdFE5MnArMjFk?=
 =?utf-8?B?MWJZZndmV0JUZGFzUGk2Wmp2YlpWMFI3bTRJeWcwMnljL2NoQmFTZVNpTkhX?=
 =?utf-8?B?eG9oVEFtREkxY1BtLzB3NU9tZHA0dmhLaEg4VW1TZ3NiS292K3NGREgzSnRo?=
 =?utf-8?B?d1V4dXF3OU4rbTZ6K0VDTm4walJYT1NTeE1HS0hNN2FVRlRub3QwOG8yYWMx?=
 =?utf-8?B?SzRXYzExejFjV3hyWTZKVVozbnJOcytXdEtWd0ZnVWlyU1F2N2NNamtJa1Np?=
 =?utf-8?B?bG5JSm5Pa1RTQ1l1OGUvU04waXV1R1Ura0M0VXJ0aWVCZ2JHeWtXd3UySURy?=
 =?utf-8?B?ZEY1VmhHVFM5NDZuR2p6UXAwK2dMWW51ODVWSUNWZmtTejVzU3dyaFltWkFH?=
 =?utf-8?B?WEQyS0xNV3N4N1c0UDE4amxlVFN3Tk9pajB4bk1mQXlsUHU4Z0RUSWxQT3BM?=
 =?utf-8?B?RElrYVd5VmI0VmJpcjdVekY4L2FvcEUzT2VraXdEeDZQOHJLZk53YzVoVUE2?=
 =?utf-8?B?dmtyQWNsODJ4YjUvTUxsckUyQ1pBMzg5a09RRFMxSzBvWnoyNjdsLzU1VFR5?=
 =?utf-8?B?SWtZWWFmc0xCN1NQaEhORUIzeEZVdy81dDNFSjFyWmhMdDNkbm1abmNtRHFl?=
 =?utf-8?B?dTBqYzlXaXVkdFA4V0RSSE1xazgvRFV0dENLOW0zZmwzVmJqMFB3elc1TGFx?=
 =?utf-8?B?b3BDeFJRSGpqS05NNyttQWVDdjNxRlJwYjg3a2J4QVdVZy9WdlJkVjA1L1Nm?=
 =?utf-8?B?UHNEa3RPZnZXS3I5UTZaSHhYTktPZEppV3NWSzNHT0Z6WWRPcVRHRmFvWUFy?=
 =?utf-8?B?UGNqWFNZZHJBWHR0T0p3OXdVN2Fqc3RNYkk2WGVFT0NxR1ZScDhGL3JESHdB?=
 =?utf-8?B?RkZoNXJWUm9RVEJ1N1ZuYlBkbkxSTURsbkxHUGJkTXhRT0pneXY3cHJjWWxt?=
 =?utf-8?B?bEVhL2pvUHRRclZSYm9jcGxIRHM2T3UxclhCcXZsc0l6QXd3MVFibndpeU8z?=
 =?utf-8?B?UGkzaE4xa21nNGYvbVFXcEQ5ZGlaYUhDWXIyb1NxOENTNTV0b2RPTmdUZkdz?=
 =?utf-8?B?VUtlbkJKYnlHWWtrMTlhWEhNTExjK2JOUzBHeld1OEczR21UVS9yb3pHTWlE?=
 =?utf-8?B?WFZvV0ZrR0ZaZklaL1RvQUNxeUpHK01mODYwWXFBODVpU1pVbjUvTVNqK0VP?=
 =?utf-8?B?elYzcmhZM0ZqcDViVS9IYVg1VVNUTkN3WDFqdlBpY1Z4L2xoZ2R3ZTZTZDBp?=
 =?utf-8?B?YXovZHR1UGt3eWRnclZoMno2M2kzZXhOMysvTTR1cmZpUGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJRTnYxN21rT0hQS0tHVFZEWk1aUVRuV2F1cHZ2R0R3MUg0TFBXOGJCbUVM?=
 =?utf-8?B?Mk5LQUg1N1c0UzdMK3VzZ0RzVDVqQ1JXUlZ3SUxBRDk5RzhORHllcXc0cmlu?=
 =?utf-8?B?dGpwOVBwaW03d3VnWXg3WmI0NWZCbGU4bEozdXlsdUpzclFLYXNVNkdzdnNa?=
 =?utf-8?B?dlFObm9ja2cwZ21OMk9BaGJ1WXVGWEI1WTBTSE5udlk1UUtWc3N6N2IrS3VG?=
 =?utf-8?B?QzBwMi9xTzFnWW9PNTliTjFvUXhkNGQvRGw4Zk91dHdIaFdWcEd2VVNDRXZk?=
 =?utf-8?B?QVNCSEsvYWhhVzF2RnBYRGprOVJscC9KVFI4K3gxMlloeEtGY0ZQNk9lNS9j?=
 =?utf-8?B?ZEtKMW5kV3F5RDJEVVc2YytJdldNcjFZaFpwVTZ1VUdPYTFyVGZhUlpsSlc4?=
 =?utf-8?B?dER6a3duSE9raTNWUC9LQnQxeEtlckF4Q2xoQ1dyRUJPUVNLa05kS1ZTNkVt?=
 =?utf-8?B?THBubENvYitEMWtKS2V0ME1qdUNWVjlTcjIrdTNLTThoQ2pYQmdjNHF3Uzcz?=
 =?utf-8?B?YlBJZE4xOHZoUzhPSUJvTUp2WDU0SU1OT2pjbTFrcVNqd1JyQWVXWHEyYW4w?=
 =?utf-8?B?UjI2TGJZbGc0cHlCQ0lXT1c0dllrbjlTQzZBUXFscndIUWV2cHNZMVUvUTA2?=
 =?utf-8?B?WjA2Z2pUUWtQUEd6d09jaFZsUUxFVndEOWtNZk1nQWNHQytnTWVRSy9wK3BF?=
 =?utf-8?B?clNZdlNmOXozREhKdEhETlpGWXFSKzN0SkxPMWNycWZvVFZmcW5OZXVaa3pi?=
 =?utf-8?B?aGt2c0dhNGNBMDRYOExxQmVHU3FxWVQvMFEvNFFMRmZ5MlJ3d2JBaVNzQVAr?=
 =?utf-8?B?OFovMVJGRS9UaXVrSlYyL1dSSTBhdWdtS1JrdzZ6K0QrTTM0RjQzZjJFdlJj?=
 =?utf-8?B?NEV6Z09Pa2JrcnJId1BZYThVdXdFeHBrYzlHY2F1VTF1L2oyTzRvblJUajdF?=
 =?utf-8?B?RVpadDVvYytXdXNycjNhb2YrVExaU0xGdDhQNDVJaFUzWDFLZWlOMlUrOFov?=
 =?utf-8?B?OWtoaStSb25JQTZnYXp1UE9vaytIQlJKc3VWbHhJS2lwZUczcERiVklXTUhY?=
 =?utf-8?B?REt5L2FtYm02Szcwa1NjdzkvSzZrLytrVUNQcVdsK0UyZ3hXL0FqK1dFWjBm?=
 =?utf-8?B?eS84WnpaWTJrZnc0WmlVeUYxVkZtSmpBc1lDNldFTlA1SVhpdUVNV2xpazZH?=
 =?utf-8?B?Y05PS093R0hOZ0JPZGRzM0E2elZSc3RWcDVraG82bFI1eWlJUjJhNHgyV3Fu?=
 =?utf-8?B?cHpqY2M2aVA4cXNWTVd4aTIwamp3WTBER3k0WTRGNzlVWnFSUXZJUGl0V1F3?=
 =?utf-8?B?OFQ1TzRCZXdrOUpzMCtwMGE2UEdWZHc5d3FueTNjYUhibUNsblg4UDhPOWRh?=
 =?utf-8?B?YjJIbFFuby95MURVOG1kL09VOVhPUFJNV0RJT3Y1emtWcHppbnNVVCtRR1d3?=
 =?utf-8?B?TFl4aFd6YTJ1NXB5Z1VhM0J0a2lFMXgxSStkVGVXWWRIQWJSSDArK3U0ZEZq?=
 =?utf-8?B?WGFKYlFlTWs2U3RDdWNrMFZUMmVHSitrai9FVzdkTEdxSEFzYm44cGNLVjc0?=
 =?utf-8?B?UWVqWGFjQ1Y4MCtJdVp1MlVYZ1N6M3M2WjVVSm5GQnc4d2ZMWmFFdksyTFNh?=
 =?utf-8?B?SXV4OTJGTlVyaTBlbDlEeVlpMytVK0xHd29NZFVDeHdyN1ZoMVFrelU2ejRt?=
 =?utf-8?B?d3RUTUxyc0pXYnFLRnluK0dlSDdEQ0s4elhxczRaUWk5d1NTQmxQaU1jWURG?=
 =?utf-8?B?YnFCYWVvNDYzc3ZqM2FpREhqRW4zK09MbGsxSUt5dXRnNTBrdFRRRENXa1ZG?=
 =?utf-8?B?TnR0WEZ0WTJPbHRyUVZOZEJSTTNPK3BmeExmZWhJeHVSbDd1d01hc1J5V1p1?=
 =?utf-8?B?Tys2OGJKOXFxbStaUGhPOW8zWHFONTFxeFVzK3hPT3p2SlZaNWUrTjlnYWJY?=
 =?utf-8?B?Q0hqZVhXd3hDWWFMaDlrcnMwcjd0SVhGc2dzVnFwWUNlaEFTOFNhR1I5WUFV?=
 =?utf-8?B?SitKZmVWMmVvRU5QZ3owTmh4V0FTdmZHelZMT3k2TkNVWUVRNFdwTnZucDlr?=
 =?utf-8?B?RUwwQzVJRWd3Z2NQREsvSk1jMTJpcWk4U0VaQ212NjJMcmxyVjQvL25jaldT?=
 =?utf-8?Q?R8vW8Suhbk+eLJUAz39GBp3Ir?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b5384c87-e548-4585-d55e-08dddafa2e51
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:17:01.2493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJtGoufr8TTTxS2PkgmQbawwtYIG3bTK+Hw9lOV6r25h+kHCy6wtfDNKnq40gr3v/4hnGily5HZOpriHRQso3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P195MB2697
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



On 8/14/25 12:31 AM, John Ma wrote:
> Making the setup_mac_from_eeprom optional for boards without
> CONFIG_PHYTEC_SOM_DETECTION_BLOCKS.
> 
> Signed-off-by: John Ma <jma@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   board/phytec/common/k3/board.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 7f34d71d530..647f93a1d7a 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -176,6 +176,7 @@ static void boot_targets_setup(void)
>   	env_set("boot_targets", boot_targets);
>   }
>   
> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)
>   static void setup_mac_from_eeprom(void)
>   {
>   	struct phytec_api3_element *block_element;
> @@ -197,13 +198,15 @@ static void setup_mac_from_eeprom(void)
>   		}
>   	}
>   }
> +#endif
>   
>   int board_late_init(void)
>   {
>   	boot_targets_setup();
>   
> -	if (IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS))
> -		setup_mac_from_eeprom();
> +#if IS_ENABLED(CONFIG_PHYTEC_SOM_DETECTION_BLOCKS)
> +	setup_mac_from_eeprom();
> +#endif
>   
>   #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
>   	configure_capsule_updates();

