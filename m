Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2765EC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 06:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9302A88A87;
	Wed,  7 Aug 2024 08:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dsLYfDTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 530E688ACE; Wed,  7 Aug 2024 08:38:29 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED6288813
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 08:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GF+gQYu2Mvm3ohZGX7GOAcuKAE48HjyA5GjqAHlchLcjW98blaiadf5th8UgGQz9rofkNXe9QPcvhE1Fh+86QXYisB1ZdJKHEGKPEDVVfOURcj0g+BmlmCSiy2UyLdahUMiAfiORwe0HQNX/jcGcnmvdeYxQ9L4Rm82scm8PCY3rzsDrCJg3PMSECcyWOAxj5LEYsLVQV/fLbMokFQYv6BEtEACXkRHBQ0Aip373OLfPFHRWAEqCxtxQwTNojt0qdhN3WhN+XY/Ewk1EU8X4E6snqIZ2/TkD3KmWdKphSp0yI/o3vJZxIzndjqRZ7EkUX2XqET2+prmk+FAhhC75Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+gPOI4O35GDdVGt1f98tCMkuMrMh338TgBeUsO6qU8=;
 b=sXl0oMs8OG3aNgU4fVQDdbsNlSu58+ZOvL2kXtgPP9GWxsh4yMOZtmRFX6ijy1UH3BkAyxgtju6HM9dQj9yVd/tyLgojuUIZmtEWZoSKoxCDHSv73VT0MFWM19Ip8j0ZgB2YpaBVyK8CdWctofLqG0+gqXWASzINnEDq29itWSixQEIL4DODCcplyTtkumlo7McYdZc22QkcWVG+G5n1SqMvG7/+GX8GwzD3B+uXiNguyFiN6Nk+vpuTcw5gEe39DmIKW+SxM/GzjsOcggzn+U9s2iDnAfDjGP4RjxLF384tAxHXsGk7IwraeC/q9LyN3dXbvqAG9oGoeWGQj9s3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+gPOI4O35GDdVGt1f98tCMkuMrMh338TgBeUsO6qU8=;
 b=dsLYfDTFAaMqZNzSmYBccUrLAKLebvsOQ7+gfzY0rOJPoiOBpqQ9pIx3O0qzXx8cPOEiGFkake+gFaBzzejezdsXCTmtKKzb/ZSY2VzVdFv/tNVA7qFIiloFZvz+ggUUyEc1k597N/EpLBVnMkjrDelYmbWScHA6Elb1T5T2ISw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 06:06:26 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Wed, 7 Aug 2024
 06:06:25 +0000
Message-ID: <25df1779-d508-4f54-b48f-26ae95bf824b@amd.com>
Date: Wed, 7 Aug 2024 08:06:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] initcall: Adjust the failure message and return
 value
To: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <monstr@monstr.eu>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Alexander Graf
 <agraf@csgraf.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20230822031705.1340941-1-sjg@chromium.org>
 <20230822031705.1340941-6-sjg@chromium.org>
 <CAHTX3d+qAMKgL9T5Fo6y=rvXDiMS_mCiCEGazHt07eiVN32Fgw@mail.gmail.com>
 <d388c065-9370-498b-96c8-d22af41d2e64@amd.com>
 <CAFLszTgMTwiunEyVaPYWwDeKoDnWx8PW2JzEj6yk_nuY+bJePw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTgMTwiunEyVaPYWwDeKoDnWx8PW2JzEj6yk_nuY+bJePw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P195CA0056.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 96522481-df6c-4bdc-805e-08dcb6a711b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXptUStmVGZmc0ROcGY5L2k2ZTNSc0Y2V2dRNUsyT0Rnei9jZGhUZis2b1Yv?=
 =?utf-8?B?UldLRmhxcXVPN0FlSU0yVFZ6bTJDekN4MjZMTXozakZRc2FsRXN0by9Nb2I3?=
 =?utf-8?B?SkZ0ZUlITWpBTkVSRzk4NHdrYmJqSjZWckhGTHdvSy83NTQ3RVlCS1l0REto?=
 =?utf-8?B?L0MvUk94c0lZRy9maUV1K1gwWEdVanVra2lEM1Z0N0tDRDRvVzdEekkzMmtK?=
 =?utf-8?B?cDg4N2ZhZ3dnVXdlRHBjUEtaekVEQU1WKzUwZFJxd1o4TEYyZ21FbTczbU5U?=
 =?utf-8?B?dHF6dzB1LzFONlRhY2lmeVRWN0wxVHJ2NkVja2dYeHlLTERaYVRQYmdGRkpi?=
 =?utf-8?B?MTh0Q2dkNVl0WCtNRE1TMDQ2TjR0U1F3WTB2T0pIa3Y3Kys0dk5DU1Y0Sm9o?=
 =?utf-8?B?VGdrQVk5dGFOYUxURVBxNy9mMUlHT1VjRlFOd0hDWTRVSW9RYkxLd1N1a0RZ?=
 =?utf-8?B?azFkRXBuWDh3U1UvSHVXeDFmdnYzWW1Vd1NyclVRUUMvNUZLaHEvY1EvNmE1?=
 =?utf-8?B?eENVV0xsbGNKU1B3OEJGK3hoWXA0c3c0dUVtcjZuajRpcnhIWGx6cDlDTld0?=
 =?utf-8?B?T1NIMUlMYVpUV3RZOHNUeDdkQUt1UDNXU1JDUXMzYUNTVHE4QVpCWW1zTUJL?=
 =?utf-8?B?OG5ZRlRkbWFWSGFXSDdISWh4b3JKamtNelBoeHk3RXZzbE9uZVlvS3R3ZjBV?=
 =?utf-8?B?SUIzSzRwUm00emdXalhEdEc2eUlZc2o4LzN0d1JrbTFvU3VqWlhwN1o3U3J1?=
 =?utf-8?B?VkZDeC9rZEFDYkxJUWNpazI0YlRBdzBNdC9RR2FxTzBManF4RUdaM1BBNlNL?=
 =?utf-8?B?V0hJRkVSZmVxMnFKZGUzZDNYMTRYKzEwd3pIUDJVY3JablFnNUVhazNYd0lJ?=
 =?utf-8?B?SEdtRUM0bStiMFVCRnMrUWtrMXhMZ1JVNGQ0ZHp1dFNXTDZna2VLRFZHT2tJ?=
 =?utf-8?B?bGdRb0Y4UkE2dGV3L1czUGI0UUxjVlNlQVdOTFQyUXZXUndTdFRMMm44ZlJB?=
 =?utf-8?B?L3FPSy9nYmpMVjlIeHhWS2F4TXJKb1hmN0krTk9rdlJRQndMS3JBVVJZVlIz?=
 =?utf-8?B?UnpLd0pmR2RETUFlOFFsWnlsWGxBZ3NwRFdBRTMrdEhQQUw4TUJmNGZVTGhh?=
 =?utf-8?B?b21PYW04eGJLU3dZVWkvNFVPRnhVakhiY1pEdE9NbW1zWWx4aXJBYk9yWXQr?=
 =?utf-8?B?cHVmUlFHY2htUlh6cUdjSHFlSnV1R2l6dE5FNWdjOVNCdEtKY3dCc1NYd1ZD?=
 =?utf-8?B?N3hsVVF1bFRqZGFuVHNTY1I5V1VJWTJFUmhBcmpQN241bnpNN3JGdDlIeDQ5?=
 =?utf-8?B?TEFiMG1WUVREYlZFSkJxY29qaXN3aGlnbllTdWlvTnBQZVNsR084dnljK2tP?=
 =?utf-8?B?SmxsODRNb0FCdXFtQnlCbkVxNVVIT3FybzJyekJGaG9oU1hwQ1JMVWMrTTZL?=
 =?utf-8?B?UEZxZEVvY0Zyb2c4Vm41NDY2WTlYSytXNWdiSEtiZDNjb1d1d0FaM3RzVmtn?=
 =?utf-8?B?VW4vL1pFLy9kLzVaT0NyRVNaOG1yUUxZTUhsaWpJOFkxZkhJdkxhMHBpMm52?=
 =?utf-8?B?MWdhYnluenN0V2t0UWZpSTlQYmRURncwUFFpa05UQlUrM3Z3U2FjUjZtRHN4?=
 =?utf-8?B?T1luZDUvTGZpbmpFNVhYNVMvb0p6V3hJSmdVOUpMMG53REdnWmFFUUFiazA1?=
 =?utf-8?B?VlBqVFNPOFN3cVNlZ0Y4bmg5Z2RMSzJ4Uzg4YVVJMFpCeURSODh2cFBxRldF?=
 =?utf-8?B?elptUnhBUTZEOU1ub29MNFQxK3R0OVNDQThEZitJbW5Mbk8ydjk5SlVCUmtG?=
 =?utf-8?B?OXltM2NGWTJFUmZIRHZDZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em93TUNiZUsvejdtSHpWRFAzTkdjcUFLUmxOWllmTDNyMXNwNGpWZHlRK0Jx?=
 =?utf-8?B?SFU5V0thYkh2T3ZnYkRaTkEvaDJWOHlBbjN0TTN1Y21VenU1cnYzSjh1Z2dT?=
 =?utf-8?B?c1NwR2tFamZ6V1NoVFhDVDUxUi93RW13d1B2c1MzeVJQS3BDYndHcWVtUSt5?=
 =?utf-8?B?R2s1bGpna1lYYjI1Tk5keGFLTlRFWHQ0bFRXYlBZcGRNOHlvYjRscTJ0K3dW?=
 =?utf-8?B?Rml3THBKWjd5Q0pVVkZWNWY5WDJaQW1IK1BEMkhORWpYa2I3eGlkd0tzNmpG?=
 =?utf-8?B?WUNLa1NqUlc0RTMvM3pucnVUa1FGN3czZzRDL0ZpN011T0hzbXFRWGI0RExm?=
 =?utf-8?B?b01SV0hybm5BOWxKQXB1eEszRWdCUzlwMlJXSXhXOW1qZy9ITW84Vy85ZjFr?=
 =?utf-8?B?QSs3cFdobWc2blJpZTh4UU5KaDJ6Ylh3Zk1RZldyMHV6MWxPRTF3RThnWTlB?=
 =?utf-8?B?ekl2MlhwdDR5a2F2dTBETXBUUlJNVFR1K2pTb1BFRWpPM0xPYUhwUERveCtR?=
 =?utf-8?B?RmpJbDExQTVlQ2wzcEttTVhuMUM3TzlPTkoxZkkrYmhGOGtGQnNVc2EySjhP?=
 =?utf-8?B?QnhiNU5PeE5QaTBmOHBZVlBSRmZtTlpSQk1ab0dPeURnSVBvYzZOaVAzQTJW?=
 =?utf-8?B?bXlDdzE1aTBER3NpNWVGVVpxdWM3bDllYW9FWmhZQWN1NWxLTjlTd3lhTUFX?=
 =?utf-8?B?a3BPZFhBMkVUdVMyTHJObTlqTmhMUVhFckU2RWxFSnFyMkpYcTlBSlF0cWlk?=
 =?utf-8?B?NS9ha3Myc1BKcWNjRWRSZHRVSndDd1NlMG9CVVgzYjZGTERwZ01XVWVpQmRT?=
 =?utf-8?B?M0xOY2Ribk9TOHhoRzRtQ1Zybk5lVllaMDlaOWNpRTFBajloMm9ydWF4WHVO?=
 =?utf-8?B?YWdmMy8xS2tzUUxTay9MZGF5L3VvazRGK2hUMUN2emhRamVjQmROVFZEcmVo?=
 =?utf-8?B?ZU95NE45bVA1cUhPQ21FckNTdEk2QjZNL0wvMmJGV3VQcEkwOG1RaWwrdWNX?=
 =?utf-8?B?M0dwSVJmVWlsQWJ2SVJHTit2Vkh4WVZnYlQxelR3Y1p6VFNROXVWZ2dHc3BE?=
 =?utf-8?B?emRvdmg1TktGTHhaNFVDcHFGUDI4dWVXWG8weVEyb2U5L05jelh3QnpkcE5E?=
 =?utf-8?B?NkdNaW1ra2dySWNvSFA1QjdrbWtSaGROVUkrenMzWktJT1M0VEZ6bE9DNUNz?=
 =?utf-8?B?RGs1VWlvLytRZEJ5azVWMWlQOFIvLzJCcnJEMWI0dnovOW5sTjRPL0E2WXlO?=
 =?utf-8?B?Mk9CcUNOTlRGZzdVUkVUYVU1SUNKVmpHOHlHVFRUZ3Z0NVhpMjl4ZHFtb25M?=
 =?utf-8?B?a3oyZlVUTWZjODdoUk0zelhmdkhmMThkZzF2K1ZHa0cvMmsycWpUNkVvL21L?=
 =?utf-8?B?OXI4ZVhDMVlsYnl5YS9aSjJpVDJzZXFvWHkzY0F3Sno0c0lkTGtnOTZLL0l2?=
 =?utf-8?B?UWsrMHBPR0YzNkduQ3JJRndHQXhPK2MxZm1TZzZZY1Y1YzdzSklJYnFQbmZ0?=
 =?utf-8?B?c2s0bE5zMTJYM09UbnJRc1BHNUQvcTFJVTBwUmk1c0Y2NU9peEdUVHltMlRQ?=
 =?utf-8?B?Tk5rT3RNT3F4RWN3bFJlVUNTN2J0UU5IcXZsTGQxQVNBaEJoeWs1c0V2L1h4?=
 =?utf-8?B?a3ZQRUFVRUtQeHNHMWVVdXhJU2pFVHFSMkhsSjFHWHNwa2FKT01kOHRHNk9P?=
 =?utf-8?B?Uk44cStBMk5ycWQ2ZXlLTlVZclA4dGp4MG5lbnBZLzd1OFljOUxBU1JUTmxL?=
 =?utf-8?B?MXIxWWNWbVJ4N0NIZ0g5ZWhVclFzYnlBbUFjeWQ2NkdaMExTTVYrY1ZnbjFk?=
 =?utf-8?B?WkgzUE1HVThEMUkzSDdJN05jTksydUZFQ3QyQk5qL0tRdmVOUjJmWkY0L1ky?=
 =?utf-8?B?ZnJPWnlPbGZ6enJBaU1oMjZKY3BHTWJpU0I1bHp1ZGF0UWF6NExaQTlpNnRF?=
 =?utf-8?B?dXFPRlUzZUFiNEdZUjJ2b1lUemRSSDBoVXVucjlxcFAyNk1XdGtqbzc2eVp4?=
 =?utf-8?B?YndVc3N3V1B1UFRxcmhlOGRjbWJCdnMxKzc0VmNqN0cwbHZ2d3lwK01JTnp1?=
 =?utf-8?B?ejVBbGFMZ3ljMVc2UHl4QkgvbnpYazQyek4yYjhRMmUyNTZvTFJ6OGMrcnZT?=
 =?utf-8?Q?bmm945DyPxKCCjESjsNjReu+G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96522481-df6c-4bdc-805e-08dcb6a711b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 06:06:25.4983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnDOwsWK9MdAsFxNLfoCBZIABFbi6+9WaRSX8ZS4IBzYi+nz2X/4iq9L8WsGDZtV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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



On 8/6/24 23:50, Simon Glass wrote:
> Hi Michal,
> 
> On Fri, 2 Aug 2024 at 03:21, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Simon,
>>
>> On 3/22/24 11:22, Michal Simek wrote:
>>> Hi Simon,
>>>
>>> út 22. 8. 2023 v 5:18 odesílatel Simon Glass <sjg@chromium.org
>>> <mailto:sjg@chromium.org>> napsal:
>>>
>>>      Move the failure message outside the loop, so it is easier to follow the
>>>      code. Avoid swallowing the error code - just pass it along.
>>>
>>>      Drop the initcall-list address from the output. This is confusing since
>>>      we show two addresses. Really it is only the function address which is
>>>      useful, since it can be looked up in the map, e.g. with:
>>>
>>>          grep -A1 -B1 serial_init u-boot.map
>>>
>>>      Signed-off-by: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
>>>      ---
>>>
>>>        lib/initcall.c | 12 +++++++-----
>>>        1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>>      diff --git a/lib/initcall.c b/lib/initcall.c
>>>      index 81c5d2450735..0f74cef32f85 100644
>>>      --- a/lib/initcall.c
>>>      +++ b/lib/initcall.c
>>>      @@ -46,11 +46,13 @@ int initcall_run_list(const init_fnc_t init_sequence[])
>>>                       }
>>>
>>>                       ret = func();
>>>      -               if (ret) {
>>>      -                       printf("initcall sequence %p failed at call %p
>>>      (err=%d)\n",
>>>      -                              init_sequence, (char *)func - reloc_ofs, ret);
>>>      -                       return -1;
>>>      -               }
>>>      +       }
>>>      +
>>>      +       if (ret) {
>>>      +               printf("initcall failed at call %p (err=%dE)\n",
>>>      +                      (char *)func - reloc_ofs, ret);
>>>      +
>>>      +               return ret;
>>>               }
>>>
>>>               return 0;
>>>      --
>>>      2.42.0.rc1.204.g551eb34607-goog
>>>
>>>
>>> I am debugging one issue and I get output like this. And I dig into it and find
>>> out that failures are not reported
>>> on the function which is causing it but on the next one. It is because of
>>> pointer is moved to next function;
>>>
>>> This is what I see.
>>> initcall: 0000000008072de8, 0
>>> initcall failed at call 000000000802b14c (err=-19)
>>>
>>> And this is the problematic part.
>>> for (ptr = init_sequence; func = *ptr, !ret && func; ptr++) {
>>>
>>> Fix should be of course to get that if(ret) code back but maybe you want to see
>>> different solution.
>>
>> Any comment on this one?
> 
> Yes it was fixed by this, I believe, although no Fixes tag unfortunately:
> 7554388c1d1 initcall: break loop immediately on failure

perfect.

Thanks,
Michal


