Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CADC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 14:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B33287AE9;
	Wed, 25 Oct 2023 16:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXEZPMdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231D78749C; Wed, 25 Oct 2023 15:44:54 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0872987AC5
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4bjgRxY7TylTo+msdPdrEZL683IilZbTE822q4G1FLdRLlKftNoeKYCTBOcOU9UCDV5Hd6PR46Udv6BKr/0k8g9xheJgoACG+q5DY+cOJucj/CuhM9cVUIkLX4meFL1yoMeoS7JrQxXXJ4rO0mCnpqrM7hSa8KvBNI35byi9A5uln848nGIx9V/rO7BzJM77eDqI7Qhjatfjl2XLQv1s5Ju/wnzTp+nYjpDZFFj4N/6MAQcQI0a09J5Mz9QkiUz+zFwTX1xN2V5g0rClLMRFYKAxXR4kf0mt6W/RZ8ZfvYoqLwRpR0wm7SfIl98R2a2czMtZtSgLg1G4CGbPr+WyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKRsIfWrOXGI7tcfrJULOo0afi0htblWqiT4eBmmM4A=;
 b=mHj3Lj1vsY4KcK/P0GIE7JSsk5bsdcfP5NjrOBSUqROgSEefb8zo5lcND3Pb+KqRVJOA9Z75V9IIz00zgyikqFhzxV0i8BGeqPy0J/N1IFYoEvfNr/aIFDfBuBl2fptxsUoalD5kwI4w7hf4VtUCRWP+Pb0jHBsMRTPVMyL3iua4IK6LCnE+yqNPuYjIrLPRwkMAZefWEtNCxe0d6jbfWbYEERtxuRlaFnxzivTFFfdeCaHd+kefzZG6kKds+eY9eHzm2JyGd1Qi1pfgXCXUPJDx2/N+lLVLuBHJUIw+r8CiNYbi0AgGghUYC8xDRk41YBFWpFvhCG50OWCk7bzaEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKRsIfWrOXGI7tcfrJULOo0afi0htblWqiT4eBmmM4A=;
 b=eXEZPMdtGsb/1jWyppBijJxdqKg6Gj3KaOgtx6JoZNjzlXcgrnFPruwBnhonnM5rJ6IBS/OHLYmA0I68UvknjiajmmEGabMnkbAkdHmO4Yi/YOOE7nGvcVpMoHaWxO4uwhIwOFTgZrm0ML/SybxQrJ2+aPdc+pUbqJ4ZiM8jLfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 13:44:44 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::8d67:59bd:9a19:5323%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 13:44:43 +0000
Message-ID: <80c55729-649c-422a-a52d-c0e2397442dc@amd.com>
Date: Wed, 25 Oct 2023 15:44:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: Remove all default n/no options
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, takahiro.akashi@linaro.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Romanov <avromanov@sberdevices.ru>,
 Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Huan Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Leo <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Michael Trimarchi
 <michael@amarulasolutions.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Qu Wenruo <wqu@suse.com>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Roger Knecht <rknecht@pm.me>, Roger Quadros <rogerq@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Sean Edmond
 <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Tom Warren <twarren@nvidia.com>,
 Vignesh R <vigneshr@ti.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
References: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
 <20231025134002.GM496310@bill-the-cat>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231025134002.GM496310@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0070.eurprd02.prod.outlook.com
 (2603:10a6:802:14::41) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bd705b-d4cb-4dba-7a63-08dbd5608b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lIHyLRPLQ7RqZ7W2RV0ceRZ+SYAldTSD0T36h6/cTowxj9anzi8KUGFD5sSWDzAvyQ0Y+J38Cwox8GjQQMUSC4lv4RyfcL58dMqMw2nhu2dM3q/0HdlC2ivvYFulFj8OLHhZjhzV9IuFmiEgWYPBQpzUiQsSDDDaqBDHVjUJJwTpvrA5jC/sRJPj/3kbnHje+vScaWYEr3oEv2RqA9sYFZv8iSONatB0/tBYKywOid5uXes+YkHxmRRz9cmb+5MHGXJ7mpZpkLmpTSYqBJt7zeDuL66l+Zh5QTrvqpebyJKpU3g4yNAGZeqQ9HI7lflqaeh1ggCf33pfSdp3XJML6Gc5xHkRitvAE75Iw1hx84sNsSTg2BekwhNV3mrXuPHNhnmEOPaNfQGM+cTig1AAy/AfqWcmVFABkdgft1wPvkmjtSjc8VI9AGWAux0orIB4tGJRVxY77jqrW2TjKP6QAGzWZoyxyC1nDdoqbMrRA3GD/yqJR34yzHD7LhloAVDy+XsyxI7KZA9G7w42Hh6VuRO+K7hA6+3N6cWSecksDOOXwJJXlwUokHosXw2l71G5wssio5kTWbXi3bk+FpjnmizB+Vbuqc906USV7kzmdMVzIVNJ3x+ICtnt4V7PrUT/unKSGOj7mA5FOAS1j9zrXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(31686004)(7416002)(4326008)(4744005)(26005)(2906002)(44832011)(8936002)(53546011)(8676002)(36756003)(2616005)(38100700002)(6666004)(6506007)(478600001)(6916009)(31696002)(316002)(5660300002)(6486002)(6512007)(7406005)(66476007)(41300700001)(86362001)(54906003)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVzb21GaGhwK1lPOWFyMnYxeHJCL3ZEbVk4VnR1SGxVNUMxNWNoOWgzNFBw?=
 =?utf-8?B?WHdrZmZ3SlhiY1ZzZzlmWjNGTWFYZ3RTeGlYL0dxazF6a2dvd204aGRzMEV2?=
 =?utf-8?B?algrUWxFV0ZzWXZLUzI5RDNwY1NTTkc4SThqamdNZGgzQlp5RkJoYlFIUk04?=
 =?utf-8?B?bVhtWTE4Mlh1dTlZVHc0WUhsbTR5WGwwNmIzdjRYUHdINmFXOG9zaFJrWm1h?=
 =?utf-8?B?OE5ta2NjTE1RTlREMlduR1d3T056UFg0aFcxRHRPSUZMUGZtZVZ0MEtKajN0?=
 =?utf-8?B?VHZYcHphRFg0bWgrUHNQUFVxdFJNYksyOTh3SElqWlFKOCs0ODdDZGZ0OHV6?=
 =?utf-8?B?OW03YXNYaHNxZVNhRGNSQlhUM1hUbFI4Zm92UXlIZUllNHkxWlpkdmFMbXdt?=
 =?utf-8?B?enlmZ0FSL2p0OTJoUlFPNEJwVG5PMFl2emRzMEdybExXc21JaVFEclpaanh5?=
 =?utf-8?B?MTdyWEdvMGJJOFZ5eHJsTkdUNnRtU09UaHRjUVFKQ1krd0FoVWFEaFRoUmJK?=
 =?utf-8?B?dDdGa01KQnQrWnBrRXN0NEpUbGFnck5RM0NPZUsvVmFwdGkreUREQjFxbGhG?=
 =?utf-8?B?OHJrbGRYbGo0TG5kTW9lQUE1RlVzVUFBZGo1eUVibmxJQ2J5c1RHMjFUWWVF?=
 =?utf-8?B?L3R5UXZXVzRLNlNLTnlzY0NmWmRUdldMUjNCU1VTVFlvMTNKWFYrUWVxUFdI?=
 =?utf-8?B?L3ZlZEdURXg3eU5FZ2VaVXBwdm1LL3YxMzlXSjhnTXcvWkFxVU1kNTM0bHhI?=
 =?utf-8?B?SkMzMUhqb1VzWDc4VjZUU0k3SWVQbHpUWWNXWU53dzlWZ2RQck5CU3NwNlNw?=
 =?utf-8?B?dUEvYWcwdmpObkYwN2xRV01RZnNtUTA0VHNqS3dhaktmeFcrdWpreUIwYmc0?=
 =?utf-8?B?SjlvQXljQVY5UVoyczZ5Mk1yYThtdnN2bHRwVER5NUxyWWdpeXRHSzdiUDlz?=
 =?utf-8?B?VDl1OEV1V1RINWZsaXpxbjYyT0xrRFRGOThqNG1qb2RvcXZ5L2M3U3pkS0Uy?=
 =?utf-8?B?ZkRrY0ZERVkzRTdXaElUTlRRRmdkQURvQVVVd016ck9OWjZNWFRhNmNkdmsr?=
 =?utf-8?B?Y045d1pNSVpmempTWm1aRTFBeFdvMDRjNXpRYTJKemo3QWE1eEdzWVRzajJy?=
 =?utf-8?B?QnNFdXpkc21hYWowZDZwS1liUS9FWDhiRzYwcnY5cXFTSEVsY3QwZHZKN3VV?=
 =?utf-8?B?S0FMblR2QWJ4QlBiSmJTQVF6MnFYTmdiaW01ckdBV2VJN2VDampUQlU4cXBj?=
 =?utf-8?B?Yld5cnpFTUQrNzhGWHpqcWlpNlF0YzdPd2w1YzFBSk1acHNpL1pPalo3T1hM?=
 =?utf-8?B?Zi9GS0pFWVIybUxDVGZnMFl0VVAvZDZPK3FmOVI1YTdGMGY1SXVxcHY0QUYx?=
 =?utf-8?B?SnZNcEtKNlB6MVo0RkFKMTE4VlZUbGFVanJ3RVJaVGpwV0ZtbHlCU0Ztc09G?=
 =?utf-8?B?RERKUERJbTFYTkEwMXhQaG4vQ2RXcjFBUnVtVmhUcWp2R0NsaklBVFRVUHlo?=
 =?utf-8?B?NXZuZnlyWW9DM1hUeExCSFBpdFhuTWJPL1pJMDFuNitzL05mb0J1emJnNkc4?=
 =?utf-8?B?MkNrbVRKSDVRdjhyTUwwOUczdHQ5ZUk1SUY5Sm9GSFZEL3kxeE81QzdWRWJq?=
 =?utf-8?B?akJDWUZwUDFIT00yZ0Q1OEM4WWxkWnZPVGFQWHhZRHI2cVBiV0d5eDMxUEhF?=
 =?utf-8?B?QkNIamlLaE1HNm8zU2xVZ3NidHIvQ09NS1ljalo4SnRhOWhhU3lPM0FKWTEw?=
 =?utf-8?B?RWRXK1QwLzlyanA5TGRCNm1sMkNQWWVGaDg2cmlvdDBJYmh4WVRxT0pGQWtB?=
 =?utf-8?B?U3A0UkczL25RS0Rka28wR3hYbnNIeUlPR0dPaUVwb0JQM1U4cERCaXR3UWdV?=
 =?utf-8?B?QzdQV0NPQVg2VGgyMU5kV3N0N04vdkxHc00rbjZoL1pxKy9kSWdKc3hSNnVv?=
 =?utf-8?B?WitkZm1BRmNiQ1BDeTl2OUpxMGowQmxFZXNXblBCTnZ1NHZweHNMRUJyajBV?=
 =?utf-8?B?aXNaZnpqREF3ajNleDBjTmdCVzQ4aE50Z0dHNXBpTjBvOVozM0RVd2R0WTI1?=
 =?utf-8?B?VWlBMEN2OGo1dE1HZFlIbklBVzYxRGRHZE1kMW50S1VPZkZrZ1l2em9tTGZ2?=
 =?utf-8?Q?yHbiO3/kLfFvB38GBRDFHwQoq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bd705b-d4cb-4dba-7a63-08dbd5608b1d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 13:44:43.7178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BtuARZJnVyaLcTh1FNVDNByylzUWYnZgYiKr4ph0nCLMhSElSCTYegZ6eykEO5E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
X-Mailman-Approved-At: Wed, 25 Oct 2023 16:20:31 +0200
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



On 10/25/23 15:40, Tom Rini wrote:
> :n Wed, Oct 25, 2023 at 09:25:37AM +0200, Michal Simek wrote:
>> Similar change was done by commit b4c2c151b14b ("Kconfig: Remove all
> 
>> default n/no options") and again sync is required.
>>
>> default n/no doesn't need to be specified. It is default option anyway.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> Thanks.  It would be good to add something to checkpatch.pl for this,
> and it would be appropriate to do it outside of the u-boot specific
> checks I think.  A similar patch could be done for the kernel as I see
> 519 instances there currently.

yes that would be good.

> 
> Reviewed-by: Tom Rini <trini@konsulko.com>

Tom: Are you using qconfig.py for defconfig syncup?

Thanks,
Michal






