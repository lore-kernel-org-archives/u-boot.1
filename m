Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BE8C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 16:54:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F01AE88254;
	Mon, 17 Jun 2024 18:54:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CPgJpggh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A55287837; Mon, 17 Jun 2024 18:54:08 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2600::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BDF4831A2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 18:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irr5HJYXC2bMYUu6bE1VyxXvlB4PHSTX09pllXF5RNmoCa1npQsf40RYCqQ/ZgDWGPe6nM9CyDRIme7cZt/tuABsxrJjRzx1RLUhwjnqWHGT3dU5sVszZQqT110VjIHP7YFBn2DWCTYZyZFax8LIqVV4UOi4/2e9tya7o/9AWes2RyPdohkbzbFW41Bu83NHLsd7pCjm68bXWbl28xu1XMFOT5QMdh81iBy+agmJ9mHMi9dioE8iX0HX1dcC+5aSVecxU/Ya6LWDHkLvzZgVQJgyxwg89mct8pCHD/wiWX5QZZwtkM1dZ2EsSAzQbXmdG/r21Uon516SMaJ9uhlVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWJPBuQBgBXfYNWmlcWvD/YgYJzDJnh62YyKvhh7ff8=;
 b=YjhLhuCZOq6DudKamKg69MNFITVZfqAw40MBaYRKUZn8tITkw+XEBosDGeALsQJ8RKxTKwfMOtdpWPPBfTi+3cA8GlMSkiHSwgQ9iidmBEKouz7V1IvkYUdeFckU74Sg/XBSZ+jHPPz3QSfZAHDFdc/UK7X/DodmT6NboTl6erPmOOjlFzITa4O6SDiWbeQg+1zmABI8q8XzNV220nIXTBdTD4vHLK5W3R7EmlLzctEpphlCjh9Rw585SC3tp6DHCGKU/aV6aki0fNnmpACSC4fbU4CoxHEAiPsY2OVjMZbPUfmFz6pwnrAFRwNAj5UOCNWv1Y6ivoSsQVeP4zknXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWJPBuQBgBXfYNWmlcWvD/YgYJzDJnh62YyKvhh7ff8=;
 b=CPgJpgghwa4JJrbaJpFFgB8illcSwSIZ9MlqbfsfR2chmQUBfai52mN6pvHygN8X1d4uNzvGnMDHDMkDsmHMkJvXGhqW8HlGubGegXfvrHqgTnIVwoHTO5c7+nqXAI0bgqll01/UoACJ4casK7l8/aImn3O057Xq67rNyIe07YQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DB9PR04MB9379.eurprd04.prod.outlook.com (2603:10a6:10:369::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 16:54:03 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 16:54:03 +0000
Message-ID: <4c08d1d4-698e-4331-95f9-4accd91fb5e5@cherry.de>
Date: Mon, 17 Jun 2024 18:54:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v3 5/6] power: rk8xx: properly print all supported
 PMICs name
To: Dragan Simic <dsimic@manjaro.org>
Cc: Quentin Schulz <foss+uboot@0leil.net>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
 <20240606-misc-tsd-v3-5-728d721c464a@cherry.de>
 <46be03e2-c456-4842-9dc3-9a3f975d9980@cherry.de>
 <d6c3c6d65ce164e6a193f1f306c10c8b@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d6c3c6d65ce164e6a193f1f306c10c8b@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::17) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DB9PR04MB9379:EE_
X-MS-Office365-Filtering-Correlation-Id: c370de20-336a-445d-9ba3-08dc8eee17d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFFhV1J2aTlOLzVOU0xvTGltQVpiaU5MWVZVNzFZZTlvaWxqeTBSRlhmakhK?=
 =?utf-8?B?OUhGUlZMM1hSYWRyYnc5NENHVjhkdGFWQzdsRm9kNmZEeC9KeEl6YlBPRlls?=
 =?utf-8?B?S0paRGgwWFp3SFRoZW0reU1Vci9oL09zL3kwaW4xaTVuckoxZWU2NDVqRkRa?=
 =?utf-8?B?aG9GSHVJNGVkVS9FMEZMYVR1dnNwNXgwSjdvSWZuSkZRamRZYUZKN1hKUWhE?=
 =?utf-8?B?NkhrNmovemlWSlhtNkQ1L0JSTjdmVXpSdExRQ0dIRkh5TWhuUlhFclpCZ2RH?=
 =?utf-8?B?WDZORVhKU2VLU2ZmWEVGSDF6NHFuMk5MNEI2RFNBaTlvalIrZGplNVZyS2FK?=
 =?utf-8?B?QUJCc01Obk1ZN2RuWHdMK2c0MElEWWFxNXVMek95OXYxWTljYjVveG5JS0VD?=
 =?utf-8?B?cnBzMERKQ1FQRXJ0cTVjNXE0SWdoUTlHR2psVHpvSXF5OW9rREhYVEg0UzZS?=
 =?utf-8?B?YkdYZlhBeDlRb2FUS2JOc0kvbThTMTVxVllRNFVYSmZsWlpzOVJ2bkdwbERT?=
 =?utf-8?B?UmhXdVdmSnpuQkJkMktoeStqTmxLQ3UzQW1kNVU1SXM1d0FCNHBYS3lDUFpk?=
 =?utf-8?B?S1BBQmpRWCt0TU00ZllCb2s4ZHBlYXpXa1FwV0ZSRkNFbVhucDNlaW5FVERk?=
 =?utf-8?B?N0Q3cUphZU1iQ3dCWUN2WlplQWNoV2FmVmw2ZzdPMjJyRzJvK015cGNJNCts?=
 =?utf-8?B?R1Evb2ZRQUpvTERWeHB4czdLZEdsaFpLZWNiM0pWK292dG1sSStLekNrYVh2?=
 =?utf-8?B?Q1VSajFLY3VjdXgySVJyZXlHdHFPWHlyQzR4NmZQRklsUTBZZ0tETWg1QkJp?=
 =?utf-8?B?azJEVWc3dUxDenI2MXdxSEI2eGt2cVJUVERyQkFRRFc1ZkJXUXlBL2hCZXFK?=
 =?utf-8?B?NVNtZVpHUjZReXo2Y2hNa1JZMG43RGhIaUJGbGlTOFBheVVEYWFPV0dCK0gv?=
 =?utf-8?B?cUtOTXR4b2ZSd0llV2tzOXBwWGJWRkg1eUZJd3djWmhHcExrZ0FLVkFuME40?=
 =?utf-8?B?cVl5bS9mdXFvRTMveVUvMUJLS1BiWEhqbzFkci9jZlBSQjN4d2N5WTlUUnFt?=
 =?utf-8?B?VER5SSthNDhDLzZTVElDSHFZQjQxNEVpNzFlVVBQT3JQTE9FZCt1NXZtSldt?=
 =?utf-8?B?S2RGU0o3VUZuNmpmQWttcU1KYkgwTjZSMmJUaW9YYngvN0VWd3lzUnRDWUZk?=
 =?utf-8?B?Z1A0UUt5dlZBb1Bqd21XNStpN2hkM0xmd2NBRkhGbXErUmdvUGIxdFFiMk1k?=
 =?utf-8?B?K3QyYTlpNEwzVjZqemNNYU0wQjRBcTc4bTk5OEdWMzVvVVdiQWJ0bVl6NjF1?=
 =?utf-8?B?VlRGbENkTVduL2FTa1pZVENJdC9ka0xoVFk2ekZGTzRIQkVDSU5uQytRaEJV?=
 =?utf-8?B?ZkpmSE5YMm9VNzdiTnpIRjR1VE9SRU5sZStQWGNENEd0aW5xeWVDUmszeUsz?=
 =?utf-8?B?RDc4K1dsOGNYL0d4dnRxS1Q2bGhHRFAvK25BNVNWQTJqaWpIbFZkeVBkc1lE?=
 =?utf-8?B?ZmNYc1JydmhRbkdEWWlGaTVMUWtWZnpiVEtiZTI4UE9qcTNDWkg3aVFvZmsv?=
 =?utf-8?B?eXBtNHBDNjVBN0J1QWJQZWljMmNRQlROYkQyMGxjOHBuZ21BUHNCay9wc1VE?=
 =?utf-8?B?a2thOFl5L091RXA0VDkySEp3YmtobmhpRDY0blR6NE0vbi84cWgxclhtY1Rs?=
 =?utf-8?B?TVBCK09aVkFLbkJRNFpXbDRRUDY4RVpzWUpTYWJrUk55Ynl2M3N0NUw4Rzdk?=
 =?utf-8?Q?y2fDOn7aOM2DfL3I7xPq8aP5DPfTyZYZ1908t2Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmNQMlRmWWRDeFJPNHQyNXp4SWQwUUttT3V3Y096RkFxS0tLSHUvbVpzVmMw?=
 =?utf-8?B?Wkc5RjhPVzhDbzZwdmtlWTUwZzBjTjNtS2l2aC8vemdJREpMS3VVSDF6K3pE?=
 =?utf-8?B?VlI1NFZiSEYzelBoYTk1RFRjZlVtVXFwZFJtN212WXJwZGtMbUhHTXVqYVN5?=
 =?utf-8?B?YXFpMThHVkxKSWtMNVVzZUlrU3RBQzNFazBqdW9sK0NFL2ZucHFrSU5FeVlk?=
 =?utf-8?B?M2VSaTVvTW4vblZpWE13dzVyTGZHMEN6eVpaVUsrbWo3R29kZXlaQ2IzQ1Ur?=
 =?utf-8?B?SGFRNXlYQ21ZUnh0QnFyTmplZ1F1eE1POUZiMW1TWldFaklhcXhLYzB4dFp4?=
 =?utf-8?B?RlA3d2w2ZEI4VlZZc1AvZGllQzB3eVdtQmJvT2xJaFJJUi9abkplcWVRd1NL?=
 =?utf-8?B?bXBKOWhscllKb0Q5bW45N1JHU1IyY1dQSU00bGw4ZnFQaVYzR0w2eFliVUxB?=
 =?utf-8?B?MUlLdHVTdnVIQldIZldZSzAvSFBES3dhVlNlNGpLTlBNLzNIdFFmVDlzRVhm?=
 =?utf-8?B?SXpkWFhBUDY5NXI5cGZaRlE0QWhaNUFQYjRqYU5iZ1Uwb0lyWnpGRFp3UDZk?=
 =?utf-8?B?RHA2YmEvaE0rVUVTbS9kN3Nvc2pmQVRkcCtsNU55dnNCYVArZ2paenI3Tnlh?=
 =?utf-8?B?eHB5Sktqd2hpTnB4MGM1UytZSU1MQVZQdE1JM1JENzN6Z0tOVDl5ZE9hVVZM?=
 =?utf-8?B?SnJwaFlpbGFCMU4yR3hHb2xxSUtSbHRmZmwrbCtqdjlKVCs0cktQdFRoZWdO?=
 =?utf-8?B?U2U1SjZaVGVHd1BnR2dySXptT2Y4bzhQQ0gzYUZqVXNUR3FWZGpHenRLQ1ZV?=
 =?utf-8?B?R3Y3cVJqTmwrQWpNeEhZTFJZekNkTkxZbk9DRnNKZTdUTUdWVWlrWmVoeVZB?=
 =?utf-8?B?Z0RVeGZKZjkvUUdTTFY3L0JHeE9jdGhZMnMrMDNFUWhTelI1NWVVRFI3SkZw?=
 =?utf-8?B?RmFmTDIvS3FWdzlxaTJxdEhWZXRQVk1xSC8ySzZTWDFQZGczNzVLd0t2YlQ5?=
 =?utf-8?B?MFBhb0NiNXFhemFJRkV6SENOK042Y3Z0b1hub3d0OWZVcVFvSEdReHZ0aXNW?=
 =?utf-8?B?dHJZRkQ1dzJQQzFmWlZGa3ZnSTZ5cUZrZGUyOTllWEYrbDhoWnp0RFlHV3o5?=
 =?utf-8?B?eS9idkt4ZEE5Y04yMVhBU29mMGxBdnd4ZElRVG9lOXUvNDZLbVZHcCtmZ3Vv?=
 =?utf-8?B?K1FuU1JZL0ZQK0Q4cnlva2lXTVFueVhCWk9HbWhCbUwwQlY0WmNlTFhKcHIv?=
 =?utf-8?B?ME1DckFGbVN2V3dDYlNsL0NSdmh0RlNHRXlYaXg3WEJqNXRGSDRhMUd3K0FU?=
 =?utf-8?B?WVRabEtrS09DUW1SQnQvUDVkNE9PUE5YamdIeGdNM0dyUEU3eFY2M3FZOEZE?=
 =?utf-8?B?L3hmc0lkRm5qL0RvVXpySTFzRGJ5d3JCOWlxTnc0cDFobnoxTDFveUp4Nkx4?=
 =?utf-8?B?ZER6RWFjT1VjTjYxUnBpVGxPTXpqUnEzVW1WZS9DYng5Rll5S2VVT3pXMzVW?=
 =?utf-8?B?aUJKRzBNK0R5WDJXeWQ0Zldoak9zRy9WMnVhaXkzdHR4M0NITEoxYURUZWY3?=
 =?utf-8?B?cGZBSVIyd1loenZvaEFXZkEzaUlsRW1hK2xCVm9zbE05RW5Wd2lzVjNtbDJT?=
 =?utf-8?B?YnVCYjFrQjhCVGpmRkpsU2J6eHZZb1RBYlYza25DVmJieDVRZlhURUY5dnB5?=
 =?utf-8?B?c1lxbm5GREY5bDBIS1JWckE5RjhCVG8zOVNYOFV0TWVhMFFOeG8yYzU4OXBp?=
 =?utf-8?B?OVlWQVNMYVV6ejU3czA0UGtCUTFvc2dWUkROazRXdFBQcjdSR1FrWEFrRkg2?=
 =?utf-8?B?N0NCSlgrY014TUgwajgwdllUK05OcWNTaTQzYlZKQWxoaSs1cmp0dXd2V0JO?=
 =?utf-8?B?RzdnZHlwVHczMmpvVVVLTnVIWGk0UWRCRGk3QW9Qb0UvNHZWTWV1c2tlY2Qx?=
 =?utf-8?B?Z3lVVmRqakxtMk5nTm02citKVGRBQnRtZ3FIdUtkVllHaEFhSjhXTTNkT2lY?=
 =?utf-8?B?RFFEckZiQmR2VVJCTEgzK2xZcXlsdzB0ZkhxZ005SXJVUitpaTNsMm1ReDhK?=
 =?utf-8?B?ckNCYk90cjdiTXNaQkdkNmFTUFQ2OStpSmVOVWR4ZDBNQXd2aWhHZitpM2w2?=
 =?utf-8?B?YWJpL0hOMlRHZEpBTEhLNTFKQ21NOHZwMyt2cUtxQ3N4SjRhcFdaNm5aZVpl?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c370de20-336a-445d-9ba3-08dc8eee17d2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 16:54:03.6206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UO8yEUiqBvqOJfSmFOB/ScwaD/Elj3qQwYYEvOTzSIxz64MhCReTV1ME9dayH+e3UeJ768Vn9LAkdC1pgPu7ihXE/D6vKeC2BCY3uWupQog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9379
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

Hi Dragan,

On 6/17/24 4:58 PM, Dragan Simic wrote:
> Hello Quentin,
> 
> On 2024-06-17 16:10, Quentin Schulz wrote:
>> On 6/6/24 10:45 AM, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> The ID of the PMIC is stored in the 2 16b registers but the only part
>>> that matters right now is the 3 MSB, which make the 3 digits (in hex) of
>>> the part number.
>>>
>>> Right now, only RK808 was properly displayed, with this all currently
>>> supported PMICs should display the proper part number.
>>>
>>> Additionally, when the PMIC variant is not found, print that value
>>> instead of the masked unshifted value as all PMICs we support for now
>>> have their LSB ignored to represent the actual part number.
>>>
>>> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
>>> Ringneck).
>>>
>>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   drivers/power/pmic/rk8xx.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
>>> index 12ff26a0855..617bb511e4e 100644
>>> --- a/drivers/power/pmic/rk8xx.c
>>> +++ b/drivers/power/pmic/rk8xx.c
>>> @@ -6,6 +6,7 @@
>>>     #include <dm.h>
>>>   #include <dm/lists.h>
>>> +#include <bitfield.h>
>>>   #include <errno.h>
>>>   #include <log.h>
>>>   #include <linux/bitfield.h>
>>> @@ -277,10 +278,9 @@ static int rk8xx_probe(struct udevice *dev)
>>>           return ret;
>>>         priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
>>> -    show_variant = priv->variant;
>>> +    show_variant = bitfield_extract_by_mask(priv->variant, 
>>> RK8XX_ID_MSK);
>>>       switch (priv->variant) {
>>>       case RK808_ID:
>>> -        show_variant = 0x808;    /* RK808 hardware ID is 0 */
>>
>> This line removal is actually incorrect, I should have left this in as
>> we cannot use the same logic as other PMICs for RK808 as it returns 0,
>> so 0 masked/shifted is still zero.
> 
> Thanks for catching this!  Moreover, I think we should skip reading
> the msb and lsb values entirely for the RK808, because its datasheet
> lists the default ID_MSB (0x17) and ID_LSB (0x18) registers as reserved,
> and provides no information about gathering the chip variant.
> 

We've been reading those registers on RK808 in our production lines for 
probably what's half a decade now, I think it's probably safe to use :)

Cheers,
Quentin
