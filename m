Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14A8CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 11:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6098318E;
	Wed, 10 Sep 2025 13:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tCFMt2ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7388319C; Wed, 10 Sep 2025 13:50:57 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A28830B4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 13:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAVh6gXfMDQE6sqv/OMY3cj0kn1oCZJTCghscB/EXgEb3F0dqOO3sgiMiCokwalSuMJlTMHDdu+QFyLnPMZZIFwLDU2082rozZKt+cjzCQSoApkXFOQ3r4wH/MxfufWOn+701nDyKQvVFjDZ8Nuo8TAz6zVZDX/XBjcxo5ESQE+F7viL4fvkTwI8/notXlPcE5F6FtI0p7Bsw6qNTkBKqqU7orIOSxm55zlrlozOA2aWCJOy7IzIhiiF2EvoNb3DFkd7ANK/hiSFUw/B6ndcAyXq3n/uR8JnCq2POt+XSnUJIH+EkljbCjCAdLdX5yzM8cBBcPKxA0XXhTyAoxomlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H/kfK++vsJDMWEe6FcJ9iCCVc8pk6mu1SNOfk50IZY=;
 b=ytpbgKn4xWJOh6MW++PbpSjlMvz9pBqIcLvpZ1uZ3L6LvFnGefFNiVn97PfdUFmeD38ao8t99lmHhfKtylF9pqeRLO2j9xqljPwAsl8QCmap4kTYcFhcdAkGQJ3XMXPFTUPJl+oQsE/FG/tGB8Hiud/7CIPNh+tgHfVT64z4agxsOV8/4dlMczKSN/jBauPCwCgrcgzqElfwTCSmwalM3gI9X2rgYrF7iXJ41dwipV6UpNqWTKCS6nXrvQKmqDEslzZs/rwHNTtjMAP71I25d67hSpSgU+7YywIliolCr6VaTZmdH4eIbLoLUnWHS+LRCBo0mzxE/UcA1+l1qRFdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H/kfK++vsJDMWEe6FcJ9iCCVc8pk6mu1SNOfk50IZY=;
 b=tCFMt2irqxcKs8SnFqjqVzjuU82tfyj1p/BZDYSmAvKUR1gSo3h0vnpdbi6N0tGIlOQqbjyrn7IHoEdX30VGSE3UaooKsXJRj1QLGxuXl5z563yTBG4SWlRhJ+lWK+mT6+ruMeCpN/J44TKXAiCLFDZDmC4IYvDCZ7nreXbMn6f2CWFML/BO5iBUCUgqR11fQl64a31ur2YH6BJhxbl22Sn6GgplyyPBdVI12igs1w8W8xoOVSj65sjR+g+kmz9PG/yALKjsD3e5ItobHeGxhCjHr4qeLwW13TTfMAiZYTu73NFwwmc7GsWkKg27eXINjLhiOlxyjTRxyXLMAd04Sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:248::6)
 by PAXP195MB1312.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 11:50:53 +0000
Received: from VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981]) by VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 ([fe80::24f:8371:2871:5981%4]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 11:50:53 +0000
Message-ID: <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
Date: Wed, 10 Sep 2025 13:50:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers again
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "bb@ti.com" <bb@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "kishon@ti.com"
 <kishon@ti.com>, "c-vankar@ti.com" <c-vankar@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>
Cc: "upstream@lists.phytec.de" <upstream@lists.phytec.de>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:610:b2::34) To VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:248::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P195MB2484:EE_|PAXP195MB1312:EE_
X-MS-Office365-Filtering-Correlation-Id: d8fed5c1-7ce2-4054-fb11-08ddf0604b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZVRVU5OFhCRWFMTm50a2lCWTdkWHROeGFJQ2Jpb0NDOHdENk1XSlRmWTBS?=
 =?utf-8?B?cDFpN044ZUNkQzJiSGhRaHdXOGJjV1pxaHBqTEd5RzZPOUF5MjJ0UGhrVzlN?=
 =?utf-8?B?VnNkTFpIcTQ1aFJEVGx4TEI4MGJQb0pmRThWdGRoeUwrd3MwZ2ZHNEVEdFRQ?=
 =?utf-8?B?V0NjWDFheVJnY1h4VlNIQXRURFhZTU5RVVZNdUNFWTg5OThRVDNEdUV4b3c4?=
 =?utf-8?B?eThseHpCazRtNmxiSzQrcVZ3eXpLb0R2dDhncjJYeGRWL1lodmJtRlpZL0F5?=
 =?utf-8?B?VXhhYzU1bnFLN1ZNaUZxbkU3UEh4L2cyamgvMXJpS2x1TTVjWmtSVzdiaEVw?=
 =?utf-8?B?aklndHMxY1BhTEoxbTJNYmtKdkpscFJNWDNGVWRaSEVYVXBlaE9PY2VQb0Nq?=
 =?utf-8?B?YmdiMmdzTUFCcWVsZDlCR2UrTG1pK1RKWkdubEJ1WDlTaXQwQVpZUHF0ZStl?=
 =?utf-8?B?T1kxY1gxbjB5VkY0R1pZbHRoSjNyckpmS0tCVHkrNC8wTUNXRUZtZllJVUFU?=
 =?utf-8?B?SGF5TWhudnd1WlVzQ1dZN284a3JKTjhhMEZBM2w4S2xZQVU4a21KN3BONHMw?=
 =?utf-8?B?Q2MwSFFMRVpFbUkyNDlQd3NJOVVNdGpGeWZhaXI5RTI1MElFTTV6RlN3eGcy?=
 =?utf-8?B?Yy9iU0JncER3aldTVHZIbXNuTkt5cVRrRUF1V0crZ0N0RGN6NzJZQkcrZFh6?=
 =?utf-8?B?RUEwWDU4Z3UxbkYxUnB3UC9HTGlRZUJWVnoxbUVQM1RmaEZ4anhEMEdDTXdu?=
 =?utf-8?B?VUxHRTlnT09TcERyaHM0bkd3c0hnQmlJUWRvcTRWeVVvc3hWR1JFdDBsSVNI?=
 =?utf-8?B?WFd0NFJtQ28rZHBreFdsVjNwbWFuQXlLRm0xZS9vWXFEWmpuZ1d2MEhZcHdG?=
 =?utf-8?B?RjlOVkU5b2NEbnlaNCtUWlM0SndIR3Ryb2NFRm1uRmZUVHVXaFhRVGxpWFpK?=
 =?utf-8?B?a3pHR0FYOEZ4dXpjbGgvVFlaY3lEdW9pR2wrZmIwa1paclhWZ2dRZ1NJV3lM?=
 =?utf-8?B?b0FaN1U2OVk1NnVjR2dZUHl4cTRTMEtPdCsrSFRsUHZkZ2FTQjExNG0wcms2?=
 =?utf-8?B?RWpTSkM5bHRzTUNjUjVUbktNNFdwREIwUGl1NFFhT01SU3BNNmsyWmY3V0Ro?=
 =?utf-8?B?NjFBTW11RlMvOXBHSmlBbDhESjI3dnY0QVRnckZwZUFyTnJzM3JhZlkyeDRv?=
 =?utf-8?B?ZkJFREZYbytRQkU4Q1pSRVFMQTFnZVdhNk1PMWhkdmNtV3lERmppS1pvbDhR?=
 =?utf-8?B?WW9ISjZEY3lzL2lQV1V0RVVtMFNXUmtyOE1uSWtBRjRFclhPYnVxOVk0M1Vr?=
 =?utf-8?B?RVNXQ2lzZUVCL1FhVU5COFZwbldUT0d5djJKNzhWNlFQSXVxTDRaNERRb1lN?=
 =?utf-8?B?a0R4MFRsWHViaXFxQURIVVJVOUwwZE5tbWczSmxLWXpqS1RNQ1R0a09FVDlP?=
 =?utf-8?B?UDlxK1o4d0lxY0ZKaXM2bllUSTNvLzZWYVpqSEdzaUxjd0tYNE1pWnZDZW1T?=
 =?utf-8?B?VXdQRnBzNXBkT3diaTFJVmQ3bHliL204d2pERmFCcExNU3J3dnd0REVkb3p3?=
 =?utf-8?B?VW5NcVRFaytrSXFqMWExOVJ4SkZucmw2VWFxdUxidnBxQTBQaGFYSmhCeGtG?=
 =?utf-8?B?OGxhVUpRMDBwSnFueVdZaVJCampmT1c5ZWVHMEExLzZJK2I1aDBjVUtYcis4?=
 =?utf-8?B?VXdaRmVCNTB1MXRkbm9lbFRTc0sxb01hTEpmMEU1eFgyNzdLdWRuMVllL05l?=
 =?utf-8?B?STBlSTkzT0M2NkJFbHNKcURRY3JrOFdNWU9DdDQvVEVKOTlQelRLSDVCRkVF?=
 =?utf-8?B?SjMxMm1KeURiN0xCZkxsajJ0ZW9PVHN4djZJcS8wbVFadnNiVDB2dk1uRlQ2?=
 =?utf-8?B?NnROdlhMUllQeHcvdlVwUmxaUWxOcmJyU25VZzVleUN4Y0xkWkdwMGVrZ1Nj?=
 =?utf-8?Q?vKNsxBoe3R4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0P195MB2484.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2k1Q0VyeXJ6VGNlWm1NdTlqbDJrV29GZE1xTGRYZWU4WjMvR2x6WlB6NFpx?=
 =?utf-8?B?R0FwQk5DSjI2ZnRNTXhlMFZaUUtyS2I2Wmthd05YdXNjYTZubGlxU3BORVNv?=
 =?utf-8?B?R205Tm42RDNrTzloQ3BIZ0kvRndzUi9BQXBSUUZZQ1lUZkMzQ1Fpb0UxN2M3?=
 =?utf-8?B?TEJzbkJPRmp0cDRxd1podEZMVS9DT1VicVlYMWc5T1A3REc5aVBZWGlDWURB?=
 =?utf-8?B?SFYyczBjNjlJVnZtNTJvL2pPSXZJZm5icFVueXN0OEdpT3cvaDlKUXM3emYx?=
 =?utf-8?B?Z2h3dlh2TUxHditIL1h3aS9ZK2NzTTBEN2V5VDlZSXJ4RjIzL2YvbXdzb1c5?=
 =?utf-8?B?b29lb3VxTys5YTJrOVduMkRjSkEwZE55RFl3K091RnRJMkMrbGZBTmhFMWx6?=
 =?utf-8?B?bWxUSldDYzZXa2pVck9JNlM1aE1kRjJRUHNDRTgyN04zMmNtbG9GQWx1bW5t?=
 =?utf-8?B?K21zcm1EUm5YeDhzTDJlMU1WYVhVOWRmTWZ5Tnp6Q0dBTkxRanlOWldrb244?=
 =?utf-8?B?Z1ZDOURGSW5DTUp5UXBEblRXMlhkMzlLUUFNUHlkL2tPSGRDaFJGNXdJdTZ0?=
 =?utf-8?B?RGxXUlJmRWRwMkd0UTVhcmdWRGpWRVRqZHFPdVIrc05QeFNDWmw2eTVoYktW?=
 =?utf-8?B?dEZtcEhHMzVTeC96K3NZN29XK0hGbzFPaVE4Vmt6MDVxeVdMY2lON3hLaHNV?=
 =?utf-8?B?MGhKVDFybVY2ajVWSXNhMC9vb3dnNjFwY2JaMjlhVDNubGl2eGhUTjlJZXI0?=
 =?utf-8?B?eTMyK0RzNFJOSVdvbHo1aER5VGEvb0hjMGx5UTJXWWZyMW1hbWlwNHhnekh3?=
 =?utf-8?B?YkRCRXBpc2J6QTlFOUQ0amhrSExlWFBmUGtnM1V3ZzNiV0lrYnFVZ01EOUxR?=
 =?utf-8?B?d1I4T1ZpRVNwaXRMQjhGdGFFWWZ4UmNqMmIraWZoT3JpWjN6T1J3LzEzRVZU?=
 =?utf-8?B?SjV4dUxiaTNWcFoxMUc0ZzJIRnpTSTZvZUpwRW11cWVwVW9TRGVtQmFzbUZj?=
 =?utf-8?B?T3A2YzlnOS85NFlqbUtnTmdsaVBud0w3ZklYa3l2a3NncklNZlhZd01QTnQ3?=
 =?utf-8?B?SWFad0ZpOGhadm5wek1raWZzelNoT3Bldjk0Tnk4d2JmdVFSS3ovN2FSVUxU?=
 =?utf-8?B?RGRheCtINW1reUNhNjBCVEg0Uk1lSmZQWXhhaktqQ3JLcHNTelRDMWloMGVr?=
 =?utf-8?B?ZXQ5SVJoUTROaHlEY1JnQzJ5OHlsYkRGZ2dzbTBBbjQ5a3pwMklvQ2hIektt?=
 =?utf-8?B?UUIrTSt5ZU4wakpNdHZLUFF3Vmw2N1RnOUJFeVJwOHBkcDVXdXZVWUw3c3li?=
 =?utf-8?B?NCtxUWYrR2tEWG0rZkRES0xlS3F0ZW9QRG9VS3lqUEFtNzdzM3c3cDArUTFH?=
 =?utf-8?B?OUh3clY1bmcvSUU1aTlRWVBZL2ZEdis3TUNrUWxmZ052VU5OSm8yN0JxUmVn?=
 =?utf-8?B?TGVkUGVpbk5IK2dQR0E4NUNlTTJidkk4bGFmOEtZNVRoTVZ6OGpKOUNsazQy?=
 =?utf-8?B?ajVScTJBUDZYSkxjQ1pRMlQ2eG9GbWFmWlo2Y2xSN1N4ZSs0VDRnWjBoSmVE?=
 =?utf-8?B?ZHcvNGh5NnFiZlV5Rzk1bmphT3lRWW80STRBVVkvN0NoZmoyZ3hRUUMvVUVN?=
 =?utf-8?B?WE5hSkY4ZzNtNklkZ3pEK0lKZ2N5YXkzbUNiMm9wWERNTzRIZmkrVFVERmZy?=
 =?utf-8?B?Z3FMRFhUc09vUmFKZUVjYW9SWXp4YnN1UW1DMk9wSC9Rdm1LSHY5KzIzcXJL?=
 =?utf-8?B?eXE5dHZ5VHpFdE15dmpDdi95bWNDdDUzNzhrNzJnZG82OGlheXVPRzA2ZGJV?=
 =?utf-8?B?QnRMeklVY3FxQTBtMzVzNkFBNENRbGtkMWtBalcraHVEcDlTUTc0T295RFU0?=
 =?utf-8?B?VXpPMnlRQTVteThSSHJySStpNTJCcGlCMkNyN1JHM01BSWxUZ2FRc2FvbURm?=
 =?utf-8?B?YmR1cjh5MFMvNDlhMEpDQWZ1eWJPZ0FDa2xqZjloNm1jZHdCaDVoSzlRYzFt?=
 =?utf-8?B?UkRDYlk0aG1SNmRhamhVdUthSVVXcDd1Rm03WmwvSnFrV1NXbjBOdWxvMGJl?=
 =?utf-8?B?ZjNOQWp6VnRPaFNxRWNCbHdxeTZldnZ6QmZmYWRoV20wZllTYm93VDZTRFFU?=
 =?utf-8?B?d2F6YUVhSE9OVzI3NURDbTN4RHdBTENteE5PNFBrbDlncDRuR0o3bmVFVUs2?=
 =?utf-8?Q?k0+KMcqVvyPjHi39uMJnZGxcrSDWzgoXWN1KwW8A9HD0?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fed5c1-7ce2-4054-fb11-08ddf0604b4a
X-MS-Exchange-CrossTenant-AuthSource: VI0P195MB2484.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 11:50:53.0328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lva9xG/um+EHT/4XFeZz77LLiC5VwV6HbqobEv31ipuBDr9xfh0fyV60jiNfbjyisICBbHDo49RuWgee9ZL6ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1312
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

Hi Alexander,

On 8/21/25 18:21, Sverdlin, Alexander wrote:
> Dear Daniel, TI team,
>
> On Fri, 2025-08-15 at 09:02 -0700, Daniel Schultz wrote:
>> The watchdog requires to have the MCU ESM error source enabled to
>> trigger a system reboot. When booting HS-SE (security enforced)
>> devices, the MMR registers are locked again and all write commands
>> are simply ignored.
>>
>> Unlock the MMR registers again to successfully enable the MCU ESM
>> source.
> I'm just curious, could you please elaborate a bit, where the registers
> are being locked again if they are being unlocked by ctrl_mmr_unlock()
> in board_init_f() before enable_mcu_esm_reset()?
>
> Is it TIFS firmware?
> What else could be affected?
> Do we expect to leave General Purpose Control Registers unlocked
> when we return from board_init_f()?
> Does it mean that the whole ctrl_mmr_unlock() has to be re-done
> after k3_sysfw_loader() call?

I really can't tell why those registers are locked again. I figured out 
they're only locked again after loading the TIFS firmware on HS-SE 
devices. So, I also assume the firmware itself locks those registers 
again as part of a secure/security feature.

The A53 SPL will unlock those registers again, which will be permanent. 
Only the watchdog is problematic because enable_mcu_esm_reset is 
currently only called in the R5 SPL (config only enabled in the R5 SPL 
defconfig).

BTW: We have seen the same behavior with the AM68A/J721S2.

- Daniel

>
>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
>>   arch/arm/mach-k3/am62x/am625_init.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
>> index a422919fab1..498bbe45b38 100644
>> --- a/arch/arm/mach-k3/am62x/am625_init.c
>> +++ b/arch/arm/mach-k3/am62x/am625_init.c
>> @@ -84,6 +84,9 @@ static void ctrl_mmr_unlock(void)
>>   
>>   static __maybe_unused void enable_mcu_esm_reset(void)
>>   {
>> +	/* CTRLMMR_MCU_RST registers are locked again on HS-SE devices */
>> +	mmr_unlock(MCU_CTRL_MMR0_BASE, 6);
>> +
>>   	/* Set CTRLMMR_MCU_RST_CTRL:MCU_ESM_ERROR_RST_EN_Z  to '0' (low active) */
>>   	u32 stat = readl(CTRLMMR_MCU_RST_CTRL);
>>   
