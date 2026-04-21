Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CEFF8924C
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 10:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D5383C51;
	Tue, 21 Apr 2026 12:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T/qD/wX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 496F7843D0; Tue, 21 Apr 2026 12:22:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8E28439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W2C5ZWf3yyD5rmELRayJg5iNmsCwmw0vrX3qtFVn422bWJTbO5Vw7ZMq7y9Rt/KACXBLMALVCCx+FdY2qD5al6HO3nJprpQbO/anMCjyxGgmn9+CIaZSSCwMeo3b2KmhDgHVPzSw7ADd+VJspNZ98YUDsMtmfoqYC91ubjRGB6VAiCLursJ3uzaWQn+Cx9mdxOg1FhsPa6RHxukvBQK28GP0ApGh7+RVDwGiGWNBFby3cIuOGvWXhs1B9WT28/yXnfGvKFbopjd1VBz8I7JB8lQTTPPO5mh287T/c6D4ptPmsdXkMXnuHt7ULv41P0/Az3PSA2D/oq35QJtiQm8PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgZ12/LLzIrAe+qkRDiVpp+ZmcuyEjQGinRkjBnWmIs=;
 b=Q9kFGKSp3iEenxVGtn77/WUzMGssSvTYI/qkbQtQvEVQnpjgomXfU/eqKQv8a6othCkk0uYVR5lbKJi8VCoG6AokMuCthVsGAJ0aB4ZAGSpye6QEMJwbQjbL4zkoydDf8YZRCTjtFokyEqJBcpG+TjlXV2W3CpeHM6it/q2INZn8oPcg/MoeSMtuMlwb41Tt+HFWFho6xqeseFna9LYyMaivv41L6ISXJUTZe+9QlB4+eKKcxbGA8nHiLP5vN+jUFCrfERL3BZAdyOF19A2/UBGgI1Qp4Mz8kZCjs3KYu+j3bo1h7Z+/Q/1q96Y4AZ20bDzcZPEiwDX0HqUsXa1afg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgZ12/LLzIrAe+qkRDiVpp+ZmcuyEjQGinRkjBnWmIs=;
 b=T/qD/wX4XG4MpRxGKuiHCOSrMeZlwckcdyN70f0ZwBWMZsIITB6GtS0Oub3z2oYvBoLlaYJamzNgqkN21JQyCPDDYm18X+zi/ZcncdouS4L/wEp7hbrI5kvbHEFEJT+K9z9NTk9nckc24ICNZ5+aLSGaL6lTys5qgojVN4d4oBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by FRWPR04MB11222.eurprd04.prod.outlook.com (2603:10a6:d10:171::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 10:22:04 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 10:22:03 +0000
Message-ID: <e84195de-bbf6-4c3b-843b-87d83f4950fe@cherry.de>
Date: Tue, 21 Apr 2026 12:22:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [OE-core] [PATCH] tools: mkeficapsule: Add disable pkcs11 menu
 option
To: francesco@dolcini.it, Paul Barker <paul@pbarker.dev>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 openembedded-core@lists.openembedded.org,
 Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de
References: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
 <7xe72m3tkzultqh3hw4cubfognfryjk5ababajoe6w6zt7jx4c@aaxa2kehv635>
 <aeXgdkBin5uz0-OH@mt.com> <20260420085001.GA47182@francesco-nb>
 <e87d67ec12516ae9c62b1d7b19797ff0ec131b36.camel@pbarker.dev>
 <20260421101655.GD23508@francesco-nb>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260421101655.GD23508@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:803:64::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|FRWPR04MB11222:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ff69c8-77c7-4f5e-c0ce-08de9f8fd516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2aBnlZ327pFFrnlszKC584yRHoLT1wX/mRz7wGt/yNlwrFUSIoJrMtnTsSVwrpGzjeO422F5kpfEx6ptIw2OOVuRt6YwjNQMz2VfOzcGHDdrXSdVfbM1fr1GhayHfoXHQei06vcfNocrEuMeZXX3qWMOdYJUx5e8UEg00hrXmUTOgCgc9WL1z2GSEs7N1YxXT2b5WuHL6hsUC7iNHO8B5qWkBS0lh7CnL3uoHE3YxaZxtnG1BfAGFcDNZzeGyICcSEf0L5k7BMx1KbYLggcNgQwvvJ3bt/zuc5BUY3Iec0ATRqVyld11St+N3B3/4yh9amhV2JMr9KId/vcjMNVm0MTcZONz7i2Zhm/o0aqymfEe3w8ELBkAV/SkinBiLV36nP1DSC7370jateRy5VCi5EnaZSIvB49V9FbYNNVKTVdckj+LeKaZaQbTbDU7FpJEedFGofeFRbfAnC2TLYUr0DikFAkJUqi96XYm/fTcEtOAO297HnX2mofE1gwHyRnRG1bMibh2hzIpckMnr7W/pptftySvz5DaSQShzM6aWynl0cQeSL89RtIbIHOTxoeWphk+1CjkzLFmz/1uP+j2m3LxDXvB/IpTOcZQvzromGH6ivXLj/wYXRGQRDG/Z7n+DhEZBUipHVFoTr01zbqyuRiZ8RQEvRoy9YfVhIY6Kb4+rO/4bjgx9He/djBsugtgXapmqmyv6Pi5xQ1p3G+srzmnMqYXN3SjB+OfJ8cpJbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFU2YnFKQ0ZrR0M1UFhNaEdHMzk1dkt2WU5sMHJ3VEFxTE0zZDVib3g1YVg1?=
 =?utf-8?B?YTRNb2ZkWEVjWmlmaW1jMEVlRmZYMk95cmtOaXpsMnlFSmtqbjFwd005YUdu?=
 =?utf-8?B?R29mSnB0RVNaMm1nRWxVVFZZZm41K0hxZW85L1NNWnRHSVR6UUdrTUY1c2dP?=
 =?utf-8?B?L2RQVUdLSXFnRVdjVXRlNXNMR0tpWXZMTE5UZHNLWTRhQWJ1bFdlemxSV2Nj?=
 =?utf-8?B?VG16NWQ3QUZDTGgyeVRYZTVtVDJMU0w0UjVNMVdqdmphazlmZFRDc3ZhUkxP?=
 =?utf-8?B?SUNJMmUzcXp3di9QdmhCVVlzbDE3aXBEOVpiYTJ0Q3hVT3p2TDc1bnVrZWRG?=
 =?utf-8?B?cmIwZnFseDEyNlBFd201YU01Y1F0bmYraStHNDIvVHR3T3VIVTlKV3QyTmRh?=
 =?utf-8?B?Yk15MzBzRnR6RTJXd2NEUGZLd0phZ3N6eWcyWFRDdElydTVLWXQzRmNhS0cy?=
 =?utf-8?B?ekpVRnFoRkVQQUNVRGhHZElWNUY5WmVITFhqTW5ZQWpFYkkwU0JmL0JhSXBL?=
 =?utf-8?B?Y3JOTHBYUC9sNkFkb1BiZVZXYk5Qcm93K24xeFQ5aEd1Q3BxSFhRTTkySEov?=
 =?utf-8?B?NmY3WDA0SWlsazZTVUlzaU9Od2Q3NE5DdVBUbFhkMUFqeWNuL2wxVWIyK0V3?=
 =?utf-8?B?TCtYUGJXR1NsNGRPNlNSaUpMNGVTTlJJY3FOVHRLYk1CcE1zWWQ4ZHByWGhj?=
 =?utf-8?B?NXFwZmVjOG5XNkVPdHVlM3hwS1VKcFlBVStMN1Z1WUVOOWJ1QlBqYnFoUGhY?=
 =?utf-8?B?NEd5NGtHd2w5MTloeUZnWDlkN1lYZEtHTWNRYnh3ejJZeHBHVEVrOUFnNXVn?=
 =?utf-8?B?SEk2Znl0bjBGQW80K3g1S21WYUlVQ0Q5bVpXcGZ6dTZUWng0RjVoQkRjdGVQ?=
 =?utf-8?B?MWZkRXpITGFBTWVhQlo4K2grbGVkNmhkODZzNkNHUHIrTXZVMzEwdjM0Z1Nn?=
 =?utf-8?B?RitzMDlrR2xtYWRxQ0RLS3ppSDR0aGd5YjdwV0QzUFVEYkZUMEFYSnR0d1N4?=
 =?utf-8?B?WkVQdzRrcTBzM3JJSGFmUEhMVDk0TFlPSk51bFYvUDBHd09iUXcyTEZsUTAz?=
 =?utf-8?B?VDBWcmR6S0pwQUJlS25RUHR5TE1COUVnR3pnS1pndW1OSEpyRzNhOTBiYWtR?=
 =?utf-8?B?anhDbHdRYVE5NUV2ZHFKdm5qbTRuN0ZvS2pUOEhYQUVrTlhiakFmWGdueFU2?=
 =?utf-8?B?c2JzQlBLSmVHMk9JK3B0bFhMZndBK1VqSFFuUWNDSmExVDVRdm1CbGVUUjBQ?=
 =?utf-8?B?eHA5TzRYMEtLR0dKQ1pTRFFUYlNDbUhHaU1hQWF6SUlzMXk0UjhORmhxVEtC?=
 =?utf-8?B?RG43dlQyUXkyeDRZL21KMVlUTm5vWmZaSi9sZXNuTlA4U1lGTHhXZUNVMHhh?=
 =?utf-8?B?V3g4elFyQ0RHRHlUUVVvQjNOVk1zeEhFTkJDcUcrejZPZHFId2VnTDZ4cEpm?=
 =?utf-8?B?SGlsTzB4VjdGYUxpMTkzOGp2ZDVRMmk4QnMzNTlJcUVxK3ZOVjZTRnpWSExJ?=
 =?utf-8?B?OWRYbUJOMVVHaXJMUkI2QTZTZ3RGVFgxZ3FSdExnd1pEZnhJcFVEbzZ5cHNZ?=
 =?utf-8?B?M0hxaG1YMXd0ZmNpeVd3NGJJbEpFQnRYR2NzZTJzMWxzMzFITFluMDdlZzBO?=
 =?utf-8?B?WXpSMlNJSENIK2VVbklUTVVJcC9IalQwTmV0QlA5SWphL241U0Z0QW40L2pw?=
 =?utf-8?B?dDNEVk0rckphQmRZMGJCZWxtaE1YS1lNS2o3UGtmYVJCNGpYUjRYMWUzNEc4?=
 =?utf-8?B?VlM5a0ZETk8xQitXVjA1a1Z1d1dWTExGSy9NMTRwY1RBcE5xR2dLNFVVUnc3?=
 =?utf-8?B?UE1PNllmQUs1WjdhcjFmVUl3MVNCd2FzaEVhRk5McjQ4U0oxME9GTjJjQjdC?=
 =?utf-8?B?bzc5RXloeUNlSU5Sd1FpVmw5N2ZQTVQ3Z09MOERCaU1jVy9OWXViY0xFNkhP?=
 =?utf-8?B?RkJuamROR0NkT2JtRDNpNVg3Y1l4VGJjTHpKUjg4c2w5eDZEZHlmYnIzT1FM?=
 =?utf-8?B?bU4rWm9UNWZuT0FKZ2ttZ3MyNm1TUExDZmlUeUN6UUlxUGk1MkJnT0tsNHBn?=
 =?utf-8?B?UEtWQ2ZPYlo1SEZMcEJsRThxak9UdTBtWWduSVdIMFZEZFJwcExWejdOK0k5?=
 =?utf-8?B?bThUeVV2c1pEZTRMNUtMTE94Uy9COU9jTVNBekhtRzdxOTFnUEo0S1JCdEpv?=
 =?utf-8?B?a3FiWEZHVys2Tkp2Y1dLdTdqNkl3UVZZenZLMXN1dHpGWENJNk9ldTk5ZTVT?=
 =?utf-8?B?Q2FKRXRFQThGMEw1MDdRTVJjaFZ2K0R0aFh0eHFKSXYwczJOSjFGNFdTa1N1?=
 =?utf-8?B?SGh2UCtsbUZ0UmJLNmVaZ3N0RzNQRkQrNnI0UUNqUGVsd1VocEpldVl6aGZD?=
 =?utf-8?Q?F9aefmG/5zOFrgHurcHpiwahaMsikC7HJLfuG?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ff69c8-77c7-4f5e-c0ce-08de9f8fd516
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:22:03.8841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bUpVU9tLsLiIt9l2fIy/lhTbNXDB2csqbUcRWpmFrrdfHPXEslJh/UIUNIb7+2PacIBlf/vnQa4AiXk0F3bB60BdOm/+XF6IwwpmLk/pZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11222
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



On 4/21/26 12:16 PM, Francesco Dolcini via lists.openembedded.org wrote:
> [You don't often get email from francesco=dolcini.it@lists.openembedded.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, Apr 21, 2026 at 11:07:21AM +0100, Paul Barker wrote:
>> On Mon, 2026-04-20 at 10:50 +0200, Francesco Dolcini wrote:
>>> + Paul Barker
>>>
>>> Hello all,
>>>
>>> On Mon, Apr 20, 2026 at 10:14:46AM +0200, Wojciech Dubowik wrote:
>>>> On Thu, Apr 16, 2026 at 05:51:13PM +0200, Franz Schnyder wrote:
>>>>> On Thu, Apr 09, 2026 at 09:47:07AM +0200, Wojciech Dubowik wrote:
>>>>>> Some distros are using gnutls library without pkcs11 support
>>>>>> and linking of mkeficapsule will fail. Add disable pkcs11
>>>>>> option with default set to no so distros can control this
>>>>>> feature with config option.
>>>>> Shouldn't it be the other way around? Use of pkcs11 should be disabled
>>>>> by default and enabled if required. As it is now, it would still depend
>>>>> on the the gnutls library having pkcs11 support and therefore still
>>>>> would break our OE builds with mainline u-boot if we don't change our
>>>>> modules defconfig.
>>>>
>>>> As far as I understand, gnutls is built by default with pkcs11 support. So for
>>>> most of the distribution it should be ok. Security by default.
>>>> I don't have yn strong opinion for this but default enabled has been suggested
>>>> by the maintainer.
>>>
>>> We are in the very unfortunate situation in which we are not able to run
>>> any test at the moment in our CI and automated test infrastructure (not
>>> in U-Boot, not in OE), and the reason is that we have pcks11 enabled in
>>> U-Boot, and OE core is not picking up the patch to enable it [1].
>>>
>>> Any advise to have a way forward?
>>>
>>> Francesco
>>>
>>> [1] https://lore.kernel.org/all/20260408130553.819420-1-fra.schnyder@gmail.com/
>>
>> Which versions of U-Boot and openembedded-core are you trying to build?
> 
> U-Boot master + openembedded-core master.
> 

I'm assuming something along the lines of:

your-layer/recipes-support/gnutls/gnutls_3.8.12.bbappend

PACKAGECONFIG:append:class-native = " p11-kit"

until the patch gets picked up in OE-Core. Even if we fix this in 
U-Boot, enabling pkcs11 support in U-Boot (a target recipe) would 
require enabling pkcs11 support in gnutls-native according to the patch 
sent by Franz to the OE ML. This kind of dependency is pretty bad as you 
generally do not want to have to modify a native recipe for a specific 
target machine or configuration. So, I think OE should take that patch.

Cheers,
Quentin
