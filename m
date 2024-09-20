Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E904C7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114BC89313;
	Fri, 20 Sep 2024 15:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zB0N+5aN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47B289313; Fri, 20 Sep 2024 15:29:19 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E1789194
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 15:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYNmISgmlCpe9HJGqwU7MCr5GqaAhV+UQCpqdNCWPQw8itFQxGaZb5t46I8lkhKXEZTxB6+DKfCnC+5WZ45BUjxRy3TuWje30/87FcpcMw70oF/ZFLzwIAOojwKeFLhMxOnJlJOt9RfP/yAAMGm2Vvjylq0hiWutGKwcOJvxBB6U2+3E9BIJrPuxtajM1BWuYD/E60Ymk4NycyIXcko9CFqIZMQR4DNkJOmLHEOu44oU6uRUBmEBOWwbay3R4uCsOOJo1b7xD8FI81iQaeDMRQpOgXzg+9HvgqWF1EMZt3n11s22nxwnjltHQrKTPLLk7q5GepeMvu18Dvq89VK1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwABCgc6t1T75RM2n5orHgmRbeWYgkQOX+rhm+Jegf4=;
 b=HHzBs+cKhgSojlR/hZGyxEqqpX64XcM2lBBjTFiN9OgzfB3gbQW/uD6P9rQOU0a/IQPznDVJxuHFRvvywPKPSNncLvmsk17W6RHED6tsC/FFlTrFJW4oXj7TLxII0T020OhfOSPf5ljYdAl3JHJUm8mg3cAg24+843Z2CQswFY68a+o8mr9ixqnnNh1lZEnXvut5qKQ5kkLJjaLd8rQmp8rNaiuyX/M+eJua9zSzobFhUkgxgidGVxQl/G4Aw8UksCol5gKmIXfHEabKJasmdPiy0kiSNzizezD3RjyDPrAX585GAXxgoxMbX2c5SWC14nHzHn0Lybm8Yg0qpPQeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwABCgc6t1T75RM2n5orHgmRbeWYgkQOX+rhm+Jegf4=;
 b=zB0N+5aNk8qIJrRVv/uhKtXKjblnxzSBUNSeNlkx2Z/rVUuezBWTJNtsS2KMBOpD+h8q9uNzPiVwK9z3k6Q53XnkzJ0Fg4ZDq4V4Ed0ywMmIH1SxRECDmaz2BP1EBYQ2IAJPsEJ5FY0e1KS9EVjAXt7obCfVWcYyglMtP1e/E1c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.23; Fri, 20 Sep
 2024 13:28:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 13:28:08 +0000
Message-ID: <75549865-8707-4970-9ff0-1e64593e6568@amd.com>
Date: Fri, 20 Sep 2024 15:27:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: gem: Remove undocumented is-internal-pcspma dt flag
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman
 <jonas@kwiboo.se>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vishal Sagar <vishal.sagar@amd.com>
References: <2ecdbcc4ce692e2f8b3e7054a2abab35f6c03a69.1726213052.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2ecdbcc4ce692e2f8b3e7054a2abab35f6c03a69.1726213052.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0020.eurprd05.prod.outlook.com
 (2603:10a6:803:1::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa7f682-f16f-4312-d706-08dcd97810ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0R5UlJsL1lLdGJYQU9jQUN0eWlxOWltUmdFNE1LODlueGtMMUJNY1JkZ0xv?=
 =?utf-8?B?YmxTK3JtdlhabUcyMENNSll0dDhxNUppaCs5SExJaEJkclJRODBwVTE4VnRs?=
 =?utf-8?B?NXorUnBvaGNReDJjUHkwK0xUcmtnNmJBV3czMTRBZGhsQmROOXdxN0Q5VmpC?=
 =?utf-8?B?RnJVSTh3WFhmb1cxQkpCYUxLdFJPRlRKWnJPajdCYjIrMzhZMjNpYlRxOERY?=
 =?utf-8?B?N0VjYUkzNFAyOEZNalEwVDhDUm14VDVFNk0rZ1VqZ08vOWJZSVVrd0NzRy9Q?=
 =?utf-8?B?ejN5N29mbVdTaWZrMkpQTUxXNXE3UkZUTjFYVDhZS0JJeVlEekNBTXFTTW15?=
 =?utf-8?B?Z3h2NlVPSnUvZ0dJNGM5aENjN3Axams4OXNNY0xadFdJUmduZ2xBc0tGWGhY?=
 =?utf-8?B?d1lweTZZQ1YyNjgyZE5NL0JKMFpPM0czeWloREZUajdIMzJEVWFUMVh0ZGRt?=
 =?utf-8?B?emhwYzRWWGhsZ0U0SEZUTkN1S3h3VFBqcnQwSE5IeEhyREhhRWowbWhaQUhT?=
 =?utf-8?B?SDJscHhqbjBadTlubjlURUQweDRmam9LT29nQ2pVK21zOFJROXFoRXc4cEhs?=
 =?utf-8?B?UXdYOEZRRy9vWkIzeW9hNlZXbit4OXJDVXFoeXlCZmkyakRmOUhESWRDY05l?=
 =?utf-8?B?QzE2S2g4QUNxVWE3KzJDait0UUlTN3A3MmFITVBzNGRSUm1EWktCYzVKOXRY?=
 =?utf-8?B?QTZLWEdGa3BsRkFVL3IrQUJ3YmNEUVZ4QmQ5Tmw5SkxtMlpBVy9qblVHcEdk?=
 =?utf-8?B?MHUrUEFBbU9hZ25zUjFNTFNJaFh5K3NTU3NlYmJsR0t3cGdIUmZYbXd3NXlL?=
 =?utf-8?B?Z3VTVnNNTy9ZdG4xQ2lkelUwbDZVbzFyYmxQMHhhNkZPMXpZN2RvK2FOVjdX?=
 =?utf-8?B?Q2J4NkdwQnNqU2l6UXVxWmNDQVQ2QUpGWmVTWFloWjFLd2pLbEhTa0xKYmsx?=
 =?utf-8?B?SGZGdXd1MERURGp3Smd3eGJkclFpbzZZRkEvWktwNXQ3WDNxOGl0OVBNaHRG?=
 =?utf-8?B?aXhpdjl1NGg4bjY0b1laS3N1bXoraHBtczhIVTNzbGgvOEk4SWREendMZmJ1?=
 =?utf-8?B?YjgwZm5ES2ZiRW45R0ZGZnZxNk8wMmw5T25YSDhsTnVOc0RzWUcvWWROQ0o5?=
 =?utf-8?B?TzBIODJaZWNsSGEyeGY2QitzRUl5dHNzdnNlcTNPTzFuTExVTFp6VFVGRktT?=
 =?utf-8?B?Ky9hVHFGYTY5eHp0VnRQbU1VUWcwbUxGdWRadXhTbVpKWTBBNjVxTXp4UVNC?=
 =?utf-8?B?ZDlFakM0RTVjM3hlNXdSb01RRUI5dFkrelNybWpvTDhoa2U3TXZNS1BuOXhL?=
 =?utf-8?B?V3N2bkhSTWNtcENqejZkMDdVdVpkS2hycmpBU2NVMWlyb2JSN1BxZ25FbWJP?=
 =?utf-8?B?V2d2MlJhUTdXV29VZWhIbjdCdXpzb1NHNFVMNitaOXpDL1JYSmZWR2FiakJl?=
 =?utf-8?B?WkNMTm5xWFFNR1czaVViNzU3dUorV2hxTmQ2UG1SM1dHbS92cGdLcXZ4RUNK?=
 =?utf-8?B?TE1GL0Rab2tXL2QxbDNyZnN0N054d2QvYllDZEJjdFFLVElJc2JoKzdLc2Qx?=
 =?utf-8?B?Z1ZENUpaRzdFZ0gxQU9XbWFIYXpzeGpaeEV3aWZETUswYk9xM1l4bnlQVytG?=
 =?utf-8?B?RTE5a0hVT2dkYUxjWFFSTUdZREpLcHBELy80Um51bE9tUDVUVUxnZEZnT0hQ?=
 =?utf-8?B?OWhkamh4YU1vMTdySXNsRnJPQ3VtejdSU2U3a1lXTWhWaVRsNW1sS29RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFExMnJCTWVMMi9DeEp5blN4bzBUWUFKbStlVUREeSt1WCs0SWV4QUVGamo5?=
 =?utf-8?B?dFY2cnMrbGRsUG9LdHN5ZSt1N2pveU5hOFJtMDRQNldVOXpwNkRpZGRGS1Az?=
 =?utf-8?B?OXZGUFZ5dmJYWG1hS0tzOUh5Y2thRmlSM2pwQXNRNTNNMnhvRDcwbjBjVzM2?=
 =?utf-8?B?c2RuNzk5dGpvcFJTbEVnSzczNWpQbDFNK2tpMkFhREgvQTZpaUxyVm1mYml4?=
 =?utf-8?B?enViM1kxeVRDNWh0YU9TbnlBckJibUlmNmdNRzdKUVdFamVDT0NSWlFvUEJt?=
 =?utf-8?B?MGpQMUt1Slk0Sm82M3pUd2RwaTNJQ0ZrdmxPQ2tKRnRiall1Qll4WWZIaUI5?=
 =?utf-8?B?bmtSY2hJVndVdElKRGt4TlZRNTUrTjc2VFZKeXdJMkJ5d2J6Z3BtUWxiKzNi?=
 =?utf-8?B?MWlkYU9VTnIxN1gyRWJKeGFVSnN0cXkyaVZWUUdYRG14ZG41MFhLWStTTytL?=
 =?utf-8?B?c1RBU0ZwVzRxMlhDQm53NCtZbGh6NFI0K1MvcXZrMGxmM21ENldnNEx6WGIv?=
 =?utf-8?B?MGNuNnlzYnpXSHJZTHdoY3ZIVEZ5Z3dyenNnbjc0U1JtVGVHNU5IM1hiaVpK?=
 =?utf-8?B?OWt3MXcwSjhMNCt1VXlhR0NibUlnOEU4NkwzUEZvWmtGU3BTck44QzQ3K3Rj?=
 =?utf-8?B?VGxNckZ6ZlA2OHNKNDRwUTFaUWZZeU8wMHNvL014dmp3MXQ1SFZLSm9WSk9K?=
 =?utf-8?B?LzBOeDFkZGM5QmJSeEpnVTc2TzdTSlp5TlNveXdlMlJDOFdoazI4dlJpOUkz?=
 =?utf-8?B?TTlGd29iY05vZlloUlkwVjhQMmxnMTZ4MkJERk1tQjN5WDRReDEySmtDZ29E?=
 =?utf-8?B?TWJSM2w0YXZiaTA0eWdxa1BuVWMwdGVuV3UzakhGNDY1YnV5YjBUeW5jdTVh?=
 =?utf-8?B?Z1p3K0dEeDNFRm02SWprTkJ0N2RKKzNqUTI0L000NnUrVmdpckdzL09QMHk2?=
 =?utf-8?B?ZWMvZHpNVW5UQXg5bmF0d3E5NHFKZmloOHY1K3R3cmtmWlU2Ky8yb3lXeERt?=
 =?utf-8?B?LzBOUmZnOTcwTldrUkY3RUtIalFyVnNEekFWR2YvS3pZaDBsbGhQaWZzZ3pK?=
 =?utf-8?B?RWswdi9qUEtxWWc3cjNBeEc5V2RWelhjbmIxcytTaXBkQnhQa2QyUVp4QXhR?=
 =?utf-8?B?M3IrVTNBSXpRS3NON1NBajVIQTAyTmMxU1Bkc1F4SzlZT3JNRit6cUFnNVc2?=
 =?utf-8?B?eG9CL2psajdDU2FTYzRrb2V1VERtYy9uYVd2UElXdXhIK3pYWS8vZmdnSEth?=
 =?utf-8?B?emlVa1ZlL2wzYTNHbkxwOHUvUmJWVTlHelpXcEIyMXdCWTNnd2RIWmNzTVpk?=
 =?utf-8?B?dng2NVhSN2JJS2MxZmpmR2V2akFnVFl3MFlHNy8yZmhkSXFXVjFzcXhMVHk3?=
 =?utf-8?B?WWdrZXhkdk9GU08rNUlEOURhQmh2SE9rd3Y5dFB0Vmp3Q25nT2FOY2c3UjZJ?=
 =?utf-8?B?bXBpd2ZjYy9YbWNMS3U3ZU14SlhaVUtFYkVzejBRRXJTRTNvSVR2U0ZNNVg1?=
 =?utf-8?B?UWFRUkVFWHRWRFBkVjJvV1EwMTJ6ajZtTGlmZWREZDY4eFdaYkdKeURXMk15?=
 =?utf-8?B?Q051MDVSNXZIL2xzUEtNZ2cweER4WGhFTnZSS2NkWjlRUnFiOGV3SWY3OFZM?=
 =?utf-8?B?ZjNVSEZZVnJiTG5TVVREZUNCSWk0RFNZbGQ2Q3V1aTh2REZrcndZVmxZZCtP?=
 =?utf-8?B?d1Y0aEo3bHI5aEVEYXNXTnQwZ1NuTGVVNGMvMzFvNXVCODdyK3VjMVFvMGNN?=
 =?utf-8?B?L20yamFhc2pTVCswYmZ1WGhwcUN1ZkRuTGJtbldPZUJ0TDJ2aXVhWkxwVlFu?=
 =?utf-8?B?dFF4L3BEalN1YlNNTnRxWHJHS2lObUY2Q0R0R1J4Vi9mc2U5OTAyZGJad1pB?=
 =?utf-8?B?b3NYV1UrUzNFcC9mZVpGOElTbXMvcStBOUswT2ZtTDdKc3N6Q1hjQUVLWUky?=
 =?utf-8?B?ODNYdnpMNXFaUjFIRG1nMjBTbWlwdDYxN0JNWVRKa2F0SWgxbDhTQVE2aFZP?=
 =?utf-8?B?OHE0aTVjU2xEMDM3YmcrUUsxSmpuTWoxbFpSMHExQXlmeFlBZGVHc1JOWXRC?=
 =?utf-8?B?ckx1U3RoUXZ4RHhTcExPZ09LZlBRQ2I3ZE5oZUd4dDJHSWhiNFk0UzFPT1Zz?=
 =?utf-8?Q?iUUCu27nDVdZvtUGIfzp19ybK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa7f682-f16f-4312-d706-08dcd97810ac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 13:28:08.3303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHi2GIsyg9FLRHooJti7tfVxxRfDAGlVDpR0BMkWPbfwJgGuGqw6v+Xqo9KZ6+hK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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



On 9/13/24 09:37, Michal Simek wrote:
> Generic understanding/consideration is that phy-mode as sgmi means that the
> internal PCS(Physical Coding Sublayer) should be enabled by default.
> Xilinx GEM implementation allows configuration GEM (gmii mode) + PL PCS PMA
> (sgmii mode, Physical Medum Attachment) but in this case phy-mode should be
> setup as gmii.
> The reason for this assumption is that phy-mode should be described based
> on GEM configuration not based on mode coming out of PHY.
> 
> Also Linux kernel automatically setting up PCSSEL bit when phy mode is
> sgmii without a need to specified additional DT propety.
> All our DTSes with sgmii phy mode have this flag enabled that's why there
> is no need/reason to just duplicate information.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-dlc21-revA.dts         | 1 -
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts    | 1 -
>   arch/arm/dts/zynqmp-g-a2197-00-revA.dts    | 1 -
>   arch/arm/dts/zynqmp-p-a2197-00-revA.dts    | 1 -
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso     | 1 -
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso     | 1 -
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts | 1 -
>   arch/arm/dts/zynqmp-vpk120-revA.dts        | 1 -
>   drivers/net/zynq_gem.c                     | 9 ++-------
>   9 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-dlc21-revA.dts b/arch/arm/dts/zynqmp-dlc21-revA.dts
> index 59cf22d0eb98..293d8e97b63a 100644
> --- a/arch/arm/dts/zynqmp-dlc21-revA.dts
> +++ b/arch/arm/dts/zynqmp-dlc21-revA.dts
> @@ -87,7 +87,6 @@
>   	status = "okay";
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
> -	is-internal-pcspma;
>   	mdio: mdio {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> index 0b97fa3f28ac..4e0587fd441a 100644
> --- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> @@ -155,7 +155,6 @@
>   	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii";
> -	is-internal-pcspma;
>   	mdio: mdio {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
> index e3228fc98f0c..c439f778ca46 100644
> --- a/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-g-a2197-00-revA.dts
> @@ -80,7 +80,6 @@
>   	status = "okay";
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii";
> -	is-internal-pcspma;
>   	mdio: mdio {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> index d3070b0062e9..ae52e8e996a5 100644
> --- a/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-p-a2197-00-revA.dts
> @@ -90,7 +90,6 @@
>   	status = "okay";
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii"; /* DTG generates this properly  1512 */
> -	is-internal-pcspma;
>   	mdio: mdio {
>   		#address-cells = <1>;
>   		#size-cells = <0>;
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index ce7c5eb6d346..6349a0e10877 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -195,7 +195,6 @@
>   	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii";
> -	is-internal-pcspma;
>   	assigned-clock-rates = <250000000>;
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 0a0cbd2b69ae..b0d737d3caf0 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -216,7 +216,6 @@
>   	phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>;
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii";
> -	is-internal-pcspma;
>   	assigned-clock-rates = <250000000>;
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> index b626d1aacf58..7849f8c540bf 100644
> --- a/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts
> @@ -117,7 +117,6 @@
>   	status = "okay";
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
> -	is-internal-pcspma;
>   	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
>   	mdio: mdio {
>   		#address-cells = <1>;
> diff --git a/arch/arm/dts/zynqmp-vpk120-revA.dts b/arch/arm/dts/zynqmp-vpk120-revA.dts
> index e0632883e4ec..4768fac71d02 100644
> --- a/arch/arm/dts/zynqmp-vpk120-revA.dts
> +++ b/arch/arm/dts/zynqmp-vpk120-revA.dts
> @@ -118,7 +118,6 @@
>   	status = "okay";
>   	phy-handle = <&phy0>;
>   	phy-mode = "sgmii"; /* DTG generates this properly 1512 */
> -	is-internal-pcspma;
>   	/* phys = <&psgtr 0 PHY_TYPE_SGMII 0 0>; */
>   	mdio: mdio {
>   		#address-cells = <1>;
> diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
> index fe7d10844507..461805ae53ff 100644
> --- a/drivers/net/zynq_gem.c
> +++ b/drivers/net/zynq_gem.c
> @@ -228,7 +228,6 @@ struct zynq_gem_priv {
>   	struct clk tx_clk;
>   	struct clk pclk;
>   	u32 max_speed;
> -	bool int_pcs;
>   	bool dma_64bit;
>   	u32 clk_en_info;
>   	struct reset_ctl_bulk resets;
> @@ -504,8 +503,7 @@ static int zynq_gem_init(struct udevice *dev)
>   	 * Set SGMII enable PCS selection only if internal PCS/PMA
>   	 * core is used and interface is SGMII.
>   	 */
> -	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
> -	    priv->int_pcs) {
> +	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
>   		nwconfig |= ZYNQ_GEM_NWCFG_SGMII_ENBL |
>   			    ZYNQ_GEM_NWCFG_PCS_SEL;
>   	}
> @@ -529,8 +527,7 @@ static int zynq_gem_init(struct udevice *dev)
>   		writel(nwcfg, &regs->nwcfg);
>   
>   #ifdef CONFIG_ARM64
> -	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
> -	    priv->int_pcs) {
> +	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
>   		/*
>   		 * Disable AN for fixed link configuration, enable otherwise.
>   		 * Must be written after PCS_SEL is set in nwconfig,
> @@ -992,8 +989,6 @@ static int zynq_gem_of_to_plat(struct udevice *dev)
>   		return -EINVAL;
>   	priv->interface = pdata->phy_interface;
>   
> -	priv->int_pcs = dev_read_bool(dev, "is-internal-pcspma");
> -
>   	priv->clk_en_info = dev_get_driver_data(dev);
>   
>   	return 0;

Applied.
M
