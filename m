Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A96EDA687
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:28:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C4B839DF;
	Tue,  3 Mar 2026 16:28:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VuCdGr7m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F7D83F4C; Tue,  3 Mar 2026 16:28:25 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C3A838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRYjWIY5ObRMJXNGg8EM8f8DcnGDMmJGUJ6ON+VUpyZBU3l6vVrMblkomBKn2byoz8VB/fhX3lO8cgajSMm2hHk3yUYCq8DEbjZBbCf60NWSr27uOfB2EAJSJ+BXC21NQTqKbsdop07z4BpIDJy7AEpqz2GiPCiF65pkzjaLYEiTfnp4gVMPSzEDY2CLDGRueTP4PWY+bEa7cDDBj0yNZ5bwYofjoysUawQ0t9lf8K+1isS+K50Kkhpdi/MR6cb2aCSQ12GH7rrr8odvgG9qJ3m3gtZs3yO5YNUL1s0pbBR62DaSvOneNSnKfv/0rTOjCvwIEZ56CoPuNQd3COoP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On9g4ciMIGIXuAqwIAlxTH6QCYNHfipbwxhMDTpHXao=;
 b=gMfos4DWaaaq2bTgii4SNntY/i5aHM/ScPA2cHO3pvQHFTScoHSkbUde0PVJxTdnqRCSaraZ9ZBWd8JyzMfwg7eqFGGaQMYmpmB1lqkowWOxle1ca3DUckKjh+48SoRqvxKF1Gx6cCzniRdBlu0rQzggATW5yr29gcBwzDnwOiwW7oC3Op34i2yK8wdZcf5LRLAmAtClRJnyRfUx1eidkimIdtlCg+4x9fQrrBNZxJazqJRDED4rdvxMvuQNydtJRuOfbJwTNKoNWUBdZMiRjdvH+1DCH/0UDsHiwVvYTsp4gkYdoNmVTEev8hvU624JcsPJmGS/08VJUCh0mQMctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On9g4ciMIGIXuAqwIAlxTH6QCYNHfipbwxhMDTpHXao=;
 b=VuCdGr7mMDOQ6xTa0sX+mSRv5Rs7VawZY166qSTdSbhcPmJhs16EUsVWyoaoQh/6fUuVOsMzrevmmsTFYI1jb7SvSYcuO8wI4NiBqW3zIUmaq+AVWoXS17gmoNGs/TgVNAbdXq9QNwjuZGZTf3QWme0ngb8/5LGwM7jjvOfwJ2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB10556.eurprd04.prod.outlook.com (2603:10a6:102:48e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 15:28:12 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 15:28:12 +0000
Message-ID: <ac4ab14a-ecec-4488-a476-c0d1361264c5@cherry.de>
Date: Tue, 3 Mar 2026 16:28:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/16] binman: test: Move symbol test files to
 test/symbols/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-15-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-15-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0180.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::37) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB10556:EE_
X-MS-Office365-Filtering-Correlation-Id: a5dd7136-4a1a-4cb6-7856-08de79397b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: GU8y+m1hdZbQfVkaPqoYqAjADD7UesRTMahKJ2+wGlHiI8on8trSTDDHXZu1slnaJuW9OM0u3Qq8PMnMU9EsbJkPPox4wl6QtjWSAoGQOpIeK/Z8n4e2rLn53Y9JAhLrYekTAO8/Yc1vDX99ulIrajAOylUA7XsHg5lavaan5pLaKYihHbOOiAeClN/nFzLC4Zv3wr+jb/zj+2BB+qeuRS7AucgY8Co3eL6i+9xQ+I6Ef7sztTNG7dI5PhW/fSVtH3fBX6WQLPBFjLTxSUwQZYnIR/ev8ixY7VayPiOluk7SK9W4qLCoRTd84OTZXomG+MLnBF/UzNRBvxFa41Sm/79U/P0IcmrdKFbSyjr25DBnJviBTq+dpCpSZKZi20EEqF5i6LsVKe1wksuujxLiupYYrR+84RNxCzdjgkguEmyGDV1HfEbSaaizFUiqH2IgL/g5PTQ3wEDDOeuj/oQt6nP7U2/0NM6NQme5tiMgsaa3Nmu1QL9BakosaYIpsPxYsUF7+UbV1APpOM77ZXQ6HpfaIVeE/oA2kz6cEUFoBhj1MugmzmSfAQiK2zNZ8r5hB86u3/vTsKuyB79kvtXz67PV7p+V3dGX7NV49M7fIGIbHmIL3rMX3MzIkWAn41q508v9L0LlB+ZjpEXyYKTsYI5TNnFoOm/DkRCp39BEA3CuXAfUfxObBcH5EEG1CpjaZpalf7Augq+nPzppR2salT36WxidreZnaOXNZ56BI6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlNVEdOb1BHQzhaMk1xMDl0NnVodTNIbjJqc2FRblFmYW1DaWxvOXFiVTVm?=
 =?utf-8?B?OWdmZFQ2b1ozSmVXTkE4WGg5Y1JCbmt6OGZLOGdweDFQS0dGdnVvWWVraHU2?=
 =?utf-8?B?c1dXcy9zdGNwNVlqQk5iUUVlUjE3MjkwSzlqYy9JL21UVnVxQTVySW9SVFZT?=
 =?utf-8?B?aEh4OHA2aDBiZlBLU01id0FOUGdJdU92R0hEQkkweGplTHUvaUs4TWh2WHRm?=
 =?utf-8?B?dHFKcUN6R1hYa3REcGtJOUFhVDlmTTVvMVJtMlZCWDZXaFV0KzIyMk9CQzdt?=
 =?utf-8?B?dDkzekUweWdmSUV5SDBIdWV0TTZWdHFFNjdEeVhqRXF2bCt4TUx0cnVDU0lZ?=
 =?utf-8?B?TUIvbUNqcHhEVDhQQTdXYUd2b1lDUU9EaXd0MTNYTHNmUzBxemU0YUI0amFr?=
 =?utf-8?B?WGhGb0FEdmtvL2lqSnd1OEdBM1U4Y1E3R1N6MXozRHQrc3RoTFNEaWVIVkFC?=
 =?utf-8?B?TWd3S3NsVGlHU3M1R3Y2REEvb08rcE9SVmpaR3NYaHN6SFFZdlN0c0pIeWRO?=
 =?utf-8?B?YnRUZ3RSaXZaYlZma09GZHFrdWNqMzBRdUdmMW5yNng4cnVFckRpQWcxTTB3?=
 =?utf-8?B?MWgreVQybXZrUHNidWdZZk0rck50QjlUd1NTb1luay9Zd1FnazFlY3RPblBN?=
 =?utf-8?B?dVlpMVhFVC90ZTRrOU11TG4xSUg2d1lBN2ZxQkxoVEs5UWJmRWorVHVnQ0Fy?=
 =?utf-8?B?azhScUw5VEJzWVNqelJUSmprS2R3VmZSd3FvVXFlNE5RMEE2SnljQVB0VFN1?=
 =?utf-8?B?TzFORWNiQ2M4anlDaGJyUnY3bmg1Y1F5eEt1c3RGOUdWZ1BVUFpTbk10Tkg3?=
 =?utf-8?B?dVBGUVk4MXJRank4eCtubE9SdjZuSFV2dm8vZkpiTExNeWlvSkJ1aG9CcGpD?=
 =?utf-8?B?Y0tOTVF0Z0J5WlppZEpTWUhNTWJSeWdXcUgrbzl2bDJVUlJjNngzN01VSHhG?=
 =?utf-8?B?SDYvYWc2eHAzYWRrcGZJVmpuS0lZa3dKYkgvN3B3ZGFtL2syMW5JVktYUGJS?=
 =?utf-8?B?aFdoUHpaakt5MExMSWJ0K0tUaDBXQmNacU0wNVdzRnpJT3o0RzJqdWZ1M2p6?=
 =?utf-8?B?eG9ndGNJTXlPU1R1N0FBZDh5YmQ3RmtRcUI0Ui9Ia0dnSVQveGdPWWlNeFdn?=
 =?utf-8?B?cHQ5d0xwYmhFVnI5eWpoakkzVWVEaDFON3VnQlE2ajI4TzBuLzdmeWowaUMr?=
 =?utf-8?B?c2tKM2Zxb0trODhjSG9mYTFabGQxN1JGR0grSzdRTENoelVqTm5UWGEyL0tz?=
 =?utf-8?B?cWE2YlFNYmc1bEsrc3ZxS1g1d1dwVHFLVTE5b3NEV2xsSmVmSjBCQUsrbStl?=
 =?utf-8?B?eW5PNnRRbEErdVNXNHFld2VNWWg2TzZnVkdwN3RMbzRhaUhGR21TUjlzK1pL?=
 =?utf-8?B?WnF3RGNpbWlnTWsxbUxpSkRJREt0SExQcnh1K2VCYytRVTZrZUFlUyt5eGt4?=
 =?utf-8?B?WG9BRkNKQXFDTXFPVFZ5eEVYb2ZxaDBLWkd6SmpKQjZURVprSjQrcjRrZytX?=
 =?utf-8?B?d2FTSW4wbiswMkFDekgvUFRvU2g1bGRHckdpMzVHWElOT2l3N1lvT2U5T1Jn?=
 =?utf-8?B?ZHBISnMvNk9ndHJsS3dLamd5K0U0endnU3BlaHAvRmRtSFd1UjhQYmJnTnpG?=
 =?utf-8?B?U1dlNTluckN3N1J4ZFNKckhIdzJGRlc2YURVMGd6QUY4WnVROFJxUnVVNThQ?=
 =?utf-8?B?V0F0RFcvWnExN0RmZG15YWRreHF5RFNPejEyMWV2OW1neUpxQU9RVktxcUtv?=
 =?utf-8?B?cmZQNVVBemV1dUN4KzUvZCtvTGJFWm5oRDAxVnZyQk96QUpSb0czNU1MUmxW?=
 =?utf-8?B?NHJDSm5PWHRJSkp5aVlTSFF4TXZGQ0RRdEc4MlF1b3dqYmFBOERoY0NzeVVV?=
 =?utf-8?B?SVFZVXRxL2JBWVZFejNudm0xNlpJbW9JcjlNUisreWdJbytKZk1EQ08xVmVH?=
 =?utf-8?B?UU9tK1owL2liSWhmVUpoV1NMd2N6NmQ2RTRkL2FKYU9BclhOTndVRU1zRURJ?=
 =?utf-8?B?RkJjMmVDRFBGU01PT1oyOHpzVVhtSEl4Q1pGd2VySGswb2Q3RlgzdDVtdmQx?=
 =?utf-8?B?RHYyaThaY3FrSjByVmZYTy9aYjFTdUVrNTY3N0FHUEhPTVN5NHRUV3RHVFBQ?=
 =?utf-8?B?OGFKT2pzdWlrbUt5Wmcxd3I0eHM3RzlJaGxzb1dnUTNQNmRZK3JmQk1sUVZz?=
 =?utf-8?B?YTRIdlBzdiszUWJud3NjMTBqdHF4R3Q1Y3NaemZKUENqODF0NXdSVDZHb0lQ?=
 =?utf-8?B?WXU1dm1XakJQR3N1ZFpYTkY5ckN1UU9ycmViaGl3cmY5NzhtZmdnU3RSRVdB?=
 =?utf-8?B?d1pnTVZ2UTdCVHhuWFZROHRWWktCak9sencweGtHdDJUQ2UzR0I1Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a5dd7136-4a1a-4cb6-7856-08de79397b2b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:28:12.1392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geS4mmyeaPj6lz52K9Iyf4YE4jqFlTYCSCWZpXdYk1V+dZRtcWZYCv5IsrfWJ7oqhhaZua6ZF5GIUZm3hzhbd/Ao0MqpQrD2j0UF6DM3tF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10556
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about 10 test files for binman symbol patching into a symbols/
> subdirectory. Drop the numeric prefixes and the redundant symbols_
> filename prefix, and update all references.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
