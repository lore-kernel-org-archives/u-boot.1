Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BFBC04FF8
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9B22881B6;
	Mon, 15 Apr 2024 14:49:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qBrhtcBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7616988207; Mon, 15 Apr 2024 14:49:28 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602D688089
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHnPvLZ2oQjwmBeO6nepdhmsas0TgiLFYO/USa1ftr8ZfOldGljxUN6S5KzRodswDkIfnYjCAfcf6uVnvALp2bYLLZIJ8TBjkqvyk4vHQPoGQmSz1jh01kvumXE9qHYMV5LzOhjC2yc9MBi3LTOML470nyf/vjYF3E43q/DsFupYf1NeigLU0wo0GSzQ+SY2bip25aScv65AXYEnfB7+nvthNg54ZaMRcgvWe6LHSoClikNlEpx8tjM2WnY3iHlp7Ugss1yAX3UwsBrUkKSGcMYIIPi7JNy9DOVHov8cTvo0qY6OgFXVNBEP2ucRS4UcdtAjLwq/mNPftLIrXclJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMIaaWG6jSM6YCnOLkWvH3jJ02sYtxslkl88hSwQYWQ=;
 b=YNZckCCUVLbZoIZgWLdoERe1yFuDFfsGUq76NHAeAJhk94RGOQt1e5bbM6PUgMsamJDWO5qAORXMxAJhLAYt1Kxroq7YHWusus32PGJCQEI/aleeiSlHVIj16GeZ5rs/GC98e1MIv2l5xoSD5m6nFFUv/FVA0fZi7LFdqu3L7ErjJNDsJDL2vSTNwpvTQsSiWVUG0Sc7xLQ0L3N4Ox9Zx26eI1WZSsSfcbNJQ8x2JkBxAgV+1lohksVgpsD9wUewgDafNEv3x6jfUaUQetjwONSaf8MyqXEqbBf4Ewi2ocIF38tBTUv0Z9/+1jBDycfr6+NFS+Wu+Kd0QcGI+1IlAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMIaaWG6jSM6YCnOLkWvH3jJ02sYtxslkl88hSwQYWQ=;
 b=qBrhtcBaLoBuRqZy21gS8KneTRjC1os2Ei4SrhwelZ3p3gtJCBkCqkGvOYZ/s7n80km4qAHVWOfwKUCiF8jg5+wHx3mxP9fXRYrCsWeapLX+De5W8cxu96yR4Mf6bFM9ovFh6MdbfWH1Z5KeCOTbrOliPTR0Pk7WGrxx9O+VUlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:49:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Mon, 15 Apr 2024
 12:49:22 +0000
Message-ID: <3df9f51d-d37b-41da-94a1-f05936ebd0d6@amd.com>
Date: Mon, 15 Apr 2024 14:49:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] Kconfig: Make all Kconfig encoding ascii
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Elon Zhang <zhangzj@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jagan Teki <jagan@amarulasolutions.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joshua Riek <jjriek@verizon.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tim Lunn <tim@feathertop.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de, git@xilinx.com
References: <cover.1713180904.git.michal.simek@amd.com>
 <55ab78c9f2781b31278395f9e0066041f97b00f6.1713180904.git.michal.simek@amd.com>
 <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6b45c003-f6a0-4ee4-a01f-e5acc81d68a9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0096.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3d6915-4f0f-4782-5372-08dc5d4a7981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fsy0uiWTPNTI9gyP/yXI6lKuJB7JWoRMyICgfiurrZhalHWrobplRT9GYfdow+zlvB6p7HG/uiIpBRNYQ3OsFk/bfe09KftmY1zI0473RXAU1FFxrxVXeJ8gIBrj2V1k+QXm1c27fcx3HXNXO6Q3j9+IpQsQaXHGldD9SGgPFr/PjQKGJOtXPqSSFpZzv5CqtY6DUC/TyuAlj2n4Bochb1eMnzEyiM3wr89eU/UUSq4iLUx227X8f9ccEC/47tCIhDSY53UV74GGPdiJN6S78R4/kmHLQIqCabsEVcfuVRCTsZr/y3ecXcCYfjAm8nn5JTdGKkD54UCq1czpGUAvN+0Yy7YVTvsImjo2KGMNNAu0qge+GBKgOVP8zxMnh25KzszgHtgb6BronvR9HHigMZAgVwmMlvrYnmNdXyIi+P+Aq6Mm4Mc3TIHLRmI9TqpiO/PY3W4xyHiWWwbsnq+ZdpEfnuE+VjG6cDcY2Zw1bvm0zSh7fqMX1sW6PLnbAOvWVga3o6luuZOGriIrROgkSy7M6XgkZtRIzBUDNOiewj17SBPsBSpkzljwGocYbmqSKNbm/ppMXzxxIOClkizbCqKw+XS9/hbKnd6VWRdJOiCZyKCReMsOWQ60AgU491ZPi78S23RJCrXR0p7uMHeifMXQwsWIq7/AJwC9WeV6P2s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVlRemZmR2F3NU5Td3h5SGhGRVpIT04rOW8wQlFWeGQ2aU1qU1dPMkdyY2NG?=
 =?utf-8?B?TEcwYXJZbEZuNTRkcDVUUkhFZUllKytZNEkrQ0FnNVBLVCtHdUNPNmR6NUNq?=
 =?utf-8?B?UVFERUpEcStET2FtcHRXeFpkUU03TnpoaUVJdGtPcENldTV3R0tmaWtQVFJj?=
 =?utf-8?B?TmVxSjZ3RXozODUxNktWd0pBODlKTmRJMHNWdmxwUHBUZ2NXSmxhMkpLbkZP?=
 =?utf-8?B?US96SGdFMHkxaWlYRUphZGxIeXUzOWRBaDk0N1g1Vmd3MWhBWjlFVTdRdVh5?=
 =?utf-8?B?NEFpZ1ZjZ21GR1J1SzJ3TGplMEZ1QUE1azFsZFQ4Zkxzb0xMbU9WNVdUYzhx?=
 =?utf-8?B?UUo1bGtWbThCUjRYMjdGdXVYUEs3Q3RqU1FuQ25xeDZwU2ZrQVkvTTdLVUw3?=
 =?utf-8?B?b3pNQ3FLWjltd3E4VVZzY1RQci8zVmNlU0wxODRFeFA0SFR6eXVxUllkSWZt?=
 =?utf-8?B?NzhsUVZGZ2RFQmtQajVsZ1dmcXAwekhTUko3d3Z2TWF1dnJlNmV3MGk2czZR?=
 =?utf-8?B?WjJnSG1WYm83Mk92OVhNS05VU3FJbmRsUnBqOE5HRHpBZTB6dDhJRjFoSTJE?=
 =?utf-8?B?SVlYZTNqM2Z3ZWNXSjJEMm1XbnJUS2NFMVBFVWRkV0RFYm1PSkZ0WlExTnhk?=
 =?utf-8?B?c1krTi91MDVlRlNJWkVNUXZuejZIRXFobXJIalIwcGhrY0l3bkVnM084THcv?=
 =?utf-8?B?MVgxeVpUR1RHR2FtcVpvbi9xSlNZOFByZ2NqMDFSSi90QzJhVFZoQXhzUGhp?=
 =?utf-8?B?WE5iZXdJeFhlL09nZnkxOXo2Vi93ZkJFaHpLdmlWWE9Ub1FJeEE3cmw3YlRG?=
 =?utf-8?B?WDFDZjk2cGdLTGphMFZoK0toNHppVTAwQ3VvTlQ0RlhVVkpsengvYXFybXZ3?=
 =?utf-8?B?WGFZNENaTDJFZWtSYUYzUmREczcvdkxhR3dVeVVYaXIrWC8rRWpuUTVxUmEv?=
 =?utf-8?B?U1BkcWwwU2JQcTNKampraFBWcDJ1QzBzejRXclZJUWVBTCtlMENRYTc2Vm5x?=
 =?utf-8?B?WDRwUlVtZGtySjNUYndRNWNva0MxNVBhekFENzNFbVBVZmRBL1ZiMkplZmc5?=
 =?utf-8?B?ejkwL0o4ZGdvOGRPbVNiaUhXTC9UczNBRk9WSnFQeTltakQ3TzJxYUxTc1BN?=
 =?utf-8?B?dXVyREZOSWdtMzg5S0xjZlduU1BhWTFOVjdZakdrMnFHemdDM1VuYXdDcG95?=
 =?utf-8?B?aWxidElIRk9pbFR1elJDOXdlTzg1YTFOSjJBN0dncUMvODB5c0MrSUxpc2Fx?=
 =?utf-8?B?OVFQOEI3WmxjbjlCU3k4eUpXdEVRVU1vSDVJRmc5WkRlSElsVDBhWGFZSHJ4?=
 =?utf-8?B?aFVYdDJYWW5jM1R4bHhhWmJBc3dxNDNyM0I5aU9KOEFOdTZBR1JBVVVWZm5V?=
 =?utf-8?B?KzdiRmhNbXhXRnIrM2swMDlJVXBCL3AyYmp2Vk5YM0lIdzlhMTNoRHNwZDVN?=
 =?utf-8?B?RTJrMDFsN0ozTUpCcGxPTm9IQWxMN2IvK1JFazVwOUtMMVlqRjJ1TXhmQ2FE?=
 =?utf-8?B?R0pERVFVZXZQWmI0U0tZNXlKL1ZpZWMvV0hnQU8ySW91ZzZEOFJrbGJnM3dk?=
 =?utf-8?B?YWpIa1U0QVZFYkRXUWNyV0xNOURNajlkK3pjOU1BZTZlQ0F5Y0o1dkxNNTkx?=
 =?utf-8?B?ei8ra2NuTDM2ckg3WXhWcktaNCt1SXc3UzAxNlppRjlRaURWNEplOUdmWGxW?=
 =?utf-8?B?Y2d6L3lOZ3hTV2ZIc0lCYmRjazY2U2pvVVNHT0ZBdmR2cEJPenBIVTNZNkVs?=
 =?utf-8?B?cTEwcHJHS1h6Q1hvQytta3VndG5Qb3FkMVBkbjVXcE5ySVRkWTFISVlqL0tC?=
 =?utf-8?B?M3V3SEFoR1FISEhnTzRsMnA3czB4Ykd6OGZibmUwNmgrRm00YklKUVNMeG9B?=
 =?utf-8?B?bS9wa3FsbVRiYktHdVpkd2UwdTMxWkJ2OXphaHBLSklwaWY1UC9QTjhJSWVk?=
 =?utf-8?B?c0NoMCtCQWhxSmxDVHpaWi8zano5b1p0OXVmb2JLSFRHL1UwVWV6UExzVDlv?=
 =?utf-8?B?eklHOVFhTHBPQ3pTRHBvdm95REptSm4waEppQnRKdVN0WXpRL29PTTdDUmxU?=
 =?utf-8?B?MFp2ZWs3aDN4M1Vlb2R0Z29hYXA1RVBOUXBodlNFbDhyYkNEdjZsK1BLM1o0?=
 =?utf-8?Q?bcmKMwycAtDMT4xM3bMR9pWPw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3d6915-4f0f-4782-5372-08dc5d4a7981
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 12:49:22.8339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k186NXHFF/UgYkvIh+r4R+yy5IVGoio+pWCdAV+P+WNRVzMo8GH+J2WU3sC01Mkm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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



On 4/15/24 14:22, Heinrich Schuchardt wrote:
> On 15.04.24 13:35, Michal Simek wrote:
>> Some of Kconfigs are using utf-8 encoding because of used chars. Convert
>> all of them to ascii enconging.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>> There are other files which are using utf-8 enconding and pretty much I
>> think we should convert all of them because there is no reason to use utf-8
>> encoding.
> 
> Hello Michal,
> 
> The commit message does not explain why we should refrain from using UTF-8.

that's a good point. I was thinking about the reason for it and pretty much 
wanted to get feedback from Tom about it.

In doc/develop/sending_patches.rst is said that patches should be sent as plain 
text but encoding is not specified. Traditionally this was ASCII and I pretty 
much don't see the reason to use UTF encoding (even my name has special czech 
char which I am not using, the same is for Marek Vasut).

Thanks,
Michal
