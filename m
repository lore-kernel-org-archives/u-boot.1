Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 616E0EA4E07
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 14:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4639283F4D;
	Mon,  2 Mar 2026 15:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="PQ5Odmkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EEF83F53; Mon,  2 Mar 2026 15:29:56 +0100 (CET)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5AAA83F30
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 15:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmGA3NSOi2L1z9vQ9iTMPQtcH8IMEjGht5Gielw5WqyuoH+SdfFqPZTcajEE/HmvaYFK4vuPempaf8FM+UWZZcks353ofuc0B1N2Blau8Tz0nhXabWjABn8/ZsMvl0gKIyNOOgc4NdOw2B9QMHQHd3YVSZgbo6TP+K0tIQv7qbk66lHy8RAQvac2dG1mHDk9lh0VP3uOIeUVR/oKfhYvgUFN4xlZBoi1IewFYV2WxtaC7JFTsxUdIYQmXPfG5hVVEmpETqYKFHtTc1bzSLhnd6BvLrW8aSYdRt1/+2yTEuu/NYLsJr5HxlupwbR+yqCWA1tjx7R88ECwRWD2rUttkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eEU4lxm/82zNUiE2ze3yDVcda1phqD5MIq0UeN2dQNI=;
 b=AH1AhlS/4LyF7ujhuRpLKkwtzbizCzq9HAPwY9G5HSYFtmeZlhdUWMgaYsnXHz/mlIu08WClpuUurxg7Fj1+5ehQv2Up8DYkKzSb/3LOEzLbOvb1332mRevip+ggXPdkxVNdtiEZZl2a64colMy7Zej4JKOQiHq58C1VQXq0asOMGo6MOXx4wBloRCc2ragolu8A02MVr7QJzgBezpSSj0dT2YVTYPA8w22TFSov3snVDppRQS918LMgd21Jue8lhNZxY/IHY/WX+0JTLZGf83Hy1KfKnex602azkfuw6W2BGzGH32C8uxQAGqu6IgjmO9w4x4ZcFiDZKxsMDVmaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEU4lxm/82zNUiE2ze3yDVcda1phqD5MIq0UeN2dQNI=;
 b=PQ5OdmkkSiLAW7dkCy9ChN0mzR6lKHUuyVgiSxZV0vVVMI9ajtez9sg2w1pNs8Fnmm000KU9+Vvnjf/CrSBgKVFxEfl4UZ9Rrtq1lJBoZasi8tZc+fuDsbqbqW6MFItpkinEGv7CRHBmr4DPKMxjiTPTyUXIObFcNS/DdTjN47zvNl6VU9H7LkKJxxt+n5nt0gl+VIBls3xTRC/9tUxaxn9kAOf8cAW/2DTp/yk6l9JRn91OMLzuaRYcPtRI24LYHEI+5AV3VwjBKk+CpWCE5a0e8sZnYq6bjOMSNsEl0BeobKQRdcrmkCMDwlSB4JmIxZVe1KJh5Wg4LU8+abCtcQ==
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com (2603:1096:101:52::6)
 by TYZPR02MB9052.apcprd02.prod.outlook.com (2603:1096:405:39c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 14:29:49 +0000
Received: from SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::4718:ae53:48d1:20ee]) by SEYPR02MB5557.apcprd02.prod.outlook.com
 ([fe80::4718:ae53:48d1:20ee%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:29:49 +0000
Message-ID: <SEYPR02MB5557D6DDDE0CF13F325F067E967EA@SEYPR02MB5557.apcprd02.prod.outlook.com>
Date: Mon, 2 Mar 2026 22:29:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
To: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, nd@arm.com
References: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
 <45e3b935-6e0a-471f-b87f-6c03edd4f237@arm.com>
 <20260227144909.GR1593142@bill-the-cat>
 <99c81520-9f2f-43b9-81d6-c60fab345533@arm.com>
 <20260302142525.GB1388590@bill-the-cat>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20260302142525.GB1388590@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To SEYPR02MB5557.apcprd02.prod.outlook.com
 (2603:1096:101:52::6)
X-Microsoft-Original-Message-ID: <184d15ea-17d8-4dad-9d84-06ff6b0a9ec6@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB5557:EE_|TYZPR02MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 4540936f-4b5b-474a-2e7f-08de786828da
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TXC3SDMOKasxb1Truxn0Xe/HeUFtDLjIWVyLFJ93P6GiZMbpi6qAjQKtEMYZI3/5Lkhq1w4zuu0Ws0kukjhvqkDRZ8+CVEzQHcrIvoNVkEHj8ACWBCX5vbVy0/1i6gWxN4z+I9vTVNlvSYer6QLS/5DpdadaD1BVLb3fH3JKdVF/SMKyyHSNGybyCkjzdhX+HPlPIc5jDQk4hlQgsAUGxP9VqWabco31S8fWZh0YcYHJFz/xtsCk05l7dswE1nHCXjo0R2NXpPAYv3AYL1UXZR2aW4bl/4iMkQsqn3S8Mpvx0dowdC1L1TB2JWurRZ67r6R9v8cb6Dmq/8E/NVpI054lmeGoM+c8mwRoWUFNwLT9S6tG7pwrXXnMor2j3O5aBhnNOg8OLmndUoRctLbqJiO3KnNiQxVN+RvsVf0Ik5bS0sHIFYhvON4UHdaFx/leeP3azzUEkWALMO4fBmXNBpN0hGdmyNJzOkRTc/4/sIHBMTwbB9u0CyWjf0FkF6H7WtCO4wEZMozSYt+wCfU8oSR+twYHfMO0ReGPJdGP+7OXLSj9UXzKmLEtr0FGv02W9pIPInK2SzpwNIucHSI1viirmUg7l9fyyypmY8ivsFhXldPwBMa0AemKGmpKPmreV7Z9HSejewNtdNU7+QJ8qDdOSZ89os60WDuovvhmDTDyGJT+0cQ+bg1I3zLnbRvdokkT/EyzByTVMcfKrH0Ahp2N5ShYeAGdktldYmsYAd9OltAkXN8vmquFeLHxtoq9E/JUbb1dv0RIQtwkNv9gcKutEDWWPE8mTE=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|461199028|15080799012|8060799015|23021999003|19110799012|6090799003|53005399003|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1FjVlZNcU5TL01UTFd0TFRIaTExbzR6QmlkdmZWdGl2M3dWV1pzbDEzaGc3?=
 =?utf-8?B?dDBJbndGVXdXT083a3hkUVVLbnZYUFNvdkpSMHNpTUo3NjV3OE9sdVdPTTBr?=
 =?utf-8?B?bUJoclBUR0JPbGNqWE9SK21PYllCZGxpbTN0YXNxZm1lakxWOUZrZ1dEVWZD?=
 =?utf-8?B?ZlZtU09ZSXpGYU1Uc20wZE4xNTJoYnRXS2o0UEh6aE55SzBteHpsSnkvYVhp?=
 =?utf-8?B?UDhRV1VMdGV0NzArbk53VmR6QVcrelpTVFBFZjNQclBkRlpYZk1vaGpNOGNu?=
 =?utf-8?B?RXB4YUduazh1U2Ezb1dnMTBEeVoxOXJXVStLZTlpQ1ZuV2ZZdzFOeTdIanZW?=
 =?utf-8?B?STVTa1NYU3VnYTMwVzZVRWl3bUNSNXN1YkN0TmVSUXZKTFpDWkljMEtScVVn?=
 =?utf-8?B?bXpVRlFnVTBobDBqUlcvQm13eTFSQURKV05rR043dnhMZnRaeTNZREtNd25s?=
 =?utf-8?B?OWFWUkllK1EzWU9VSHdubDJxZzVBVkhSdkRMQlpjdmo2Rko3bG9vZ2JHejFl?=
 =?utf-8?B?VUx0ckhPdVRlSENwL3BRemxGTFROcGNKblhDcFR2WHVqWGFVVnZKYUROS3Rm?=
 =?utf-8?B?cmtyRVFtSzVEcDRjMzg4bjFBdTcvamtLVmZJcStlMFNNUkJiSTZnbEVmZ0d3?=
 =?utf-8?B?dmtJOHB4aUYwbzd5ckx2a3g3cjUyZ1dva25TTGNDbzJBQWtjR3BOeFBxNVVq?=
 =?utf-8?B?Zk4zTEdsaGtVMWZlVFM2Z0FzSnloOGVSSHF4KytFOHYrdlYzcmNoRXFvdm5o?=
 =?utf-8?B?b0hjZDlFRCtEZUFVeXJXem9XZW1qTWsyaUMzMTJ0UUlNRkpsWHVwcEthVUFK?=
 =?utf-8?B?S2xnUEZyU0NQNHVMYmp6WkRSMTU5TGtydlFVWkdXSWpmdjhwZFpGdTFVZXVE?=
 =?utf-8?B?UUV3K1lNUm5Tc2VacjFtUG1zTXZ4OTYxV21NdGQyRXVWVWN3Rzgrb3VnYUdN?=
 =?utf-8?B?dC9SY0NYSVdiK2F4czRJdFV4VmhDYmFYZ0dDdm9yd0hoRHgxMFpFNEJFTDZl?=
 =?utf-8?B?R20rUm5wUXMxdkhsUmg4QlBVaG5qYmRBaFZsREdDZUxRcmpOOUEvQ3djT0N4?=
 =?utf-8?B?S3pidnJzaEFXQ1lmZjEyUUtCUGRnc2VlQWh5MzZTb3VKM0hmSkFQYXV3SUtH?=
 =?utf-8?B?b051SWswZnZrTFpEWWxRcm5qSklZUGVGZHN2d1BSU0RaKytXTVhQOVRWYW9O?=
 =?utf-8?B?TmI4elNTbGMxL3owQmV4NGhUcUFXdVArTFlwZFNoaW5JMEtuckNQR0IrUUZY?=
 =?utf-8?B?WEljdm1ONXVpMEZUc2NvRkVKSnV1bXU5OVZrVHlJQ1pRVlloZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWthcEZFRTgwT01VTExGa2tHaHVPSy9VYURzQXY3YkkzbVBDQjdkY1hYZUJ6?=
 =?utf-8?B?QktTL0sxRFJ0R3REbGx4SFZoRG5DZFRoaDhtYmpiSXI1S1VBNERJR3E5Tnlw?=
 =?utf-8?B?THYwN3phWm53QjczWmtxekhOM090ZytYT083eHpvL1U3MjVTSzdGOHpNK2E2?=
 =?utf-8?B?eDRLYklXckl5dlFxaS9TRWpabzFhdTMzUjVHVElnektGRExEcTRmNTN6ck9u?=
 =?utf-8?B?TEFuSjNXYTdGUm5SR3hMTHN3dzhrZDExdFg1Q1JsOUY0R1pIUXBzYTFmcUMw?=
 =?utf-8?B?cFNrbTNseTNOb1BJWE41ejBlMnVSekhZUjVnSVh0RHhnNXgrWVZVZkV4L0Z4?=
 =?utf-8?B?WUY5eEJ4K3hpYXlkeTdLcXVDS3dsVHFhYW5LUmZHbm5lUjBISE5oSlNKSE0w?=
 =?utf-8?B?TnA4UDE2cmljeWNlZTFmUVVWSms1d0N6NFpNSlRhZUQ2Q2d4NUpOV2hkTTFR?=
 =?utf-8?B?N1JMZFNQQk5pNDZZNUc3M0JMbFhtVWxHeHZmSTFPNmJ5YkVNZGlwRVJKNlhC?=
 =?utf-8?B?MjU1S01zbXBEMWRDRlZqNjFBOFNQRUNUejVML3k2b3VSZk0vdXNDeHQ1YUw2?=
 =?utf-8?B?Z0UrMTlEWG0wUFV3SW04THYzTWVxdDU3YzFMWWNxa1FQT3RtU0F0eFV5K0Mv?=
 =?utf-8?B?S0VXUDJZVGt1Q0hjYkpLdTVsN0FCTS9CRGNYMWZUKzFlSGtHUFJtaWVaTGYw?=
 =?utf-8?B?QjBHaC9ucDB0NTJmTE9QWTN3ZVptamF1aEQzempQbzJMMVg5NVgwc0RWdEdw?=
 =?utf-8?B?Rkc4UmoyTWl4djdXdWF1a09kZFkwaDZNVzdBTzNNVUxkSThHdEhBQXBQcnU4?=
 =?utf-8?B?aFdYNTBWd2o1dWxTMjF6OWREbXR4MkZ5eENPNGRFTUhCU1ZZMEc2YktaZmFF?=
 =?utf-8?B?eWx5QUxEaEkyWWhsL1pJYXFCMGh1czBKbHhEbFAxY2xtdUd4N21scGJkMDVG?=
 =?utf-8?B?NmN0Z1dGNWx0NDh1RDhkZnRSWnc5L2Z4YUJZcG5EK05VZS9USDJlM1JHOGFt?=
 =?utf-8?B?U0VtcE1kakVMRkFadDJlcWtHdGtmK3VHdjNjaG9UUy9aQjc2KzFzdnNmZGFu?=
 =?utf-8?B?ek0wYkhUeUdWekFhNjQwNUZwZVp0eXg4eTB6eS96NGR0eE82aWhtY0ZCclk5?=
 =?utf-8?B?M1NkajdwUVlVbG9mTUdYV3Vmb20venBXTWNRVVprTlJSNEYvWUIvdDg1MnRQ?=
 =?utf-8?B?T0hIWHEyRVVWZGxnd29ySjNWSmRKc2hSRU5UR3c5UnM5QkxBT2thVDBMZVJZ?=
 =?utf-8?B?M2prcmpvbGlwU0FoOHJmNk0xS2hBZlRhaGYvdENtbUlFMUIzRjZGRmd6QmVj?=
 =?utf-8?B?MVhaZGh2bFNscUc0NnFaTXVTYlFzKy9GRkZTR0wza1pYd0VOUC9ueVo4UHVq?=
 =?utf-8?B?ZDI2YUhKTHNHeklzbWZPVTg5MTY1bWNjNFhpeTJEeXRPMDIrYklGQks5aElG?=
 =?utf-8?B?M1FYaUZOTHo4N2tZMzg1aWdaclBrUFFnRjJxdnAwOWlZNzhYR3djUFNCYndK?=
 =?utf-8?B?UmQ1dU5wcUNDZEF2TnFLTnJpaXFoMHFaT3dxU1dhUkducFNyc2tqV0p2OWc1?=
 =?utf-8?B?UXV6cWhscndydmpuMzNKSVZFUXdHdDZpZXF0QWVWem8vWlpSMmpmRWhiQ1Vr?=
 =?utf-8?B?RW1FQWwvRkZ0aDE5RW9ZV2dmem5BMTYxemJrOXhGZEV4VEx3OTZhUitrRnNO?=
 =?utf-8?B?ODk0VDhRY0FpYnoxQituTGYxYWFaK1hkaVd5SWJYNzNnamZyRnVaUzgxMkxH?=
 =?utf-8?B?OXNtNkEyRTc5d1hjY3VHL2d0SzM0L3ZqbTE4S2JlZG9NYmlrMnhmOGZ2UkZR?=
 =?utf-8?B?eFhzWmZnNWFtdjVramw0WkhSVEs4TTNsamVIaVc5VWZwOGE2cUV5Um1ZbWVm?=
 =?utf-8?B?OStmNktjbGVYRzYrNFVrbWZBSzByb2s5QW9TOEpTUDhVOWJycG1ycm1TckRq?=
 =?utf-8?B?VndYckxrOGhPZXVZaC9kS2FwRUt3cnZOTlRkY3IwSlhsL0FaL1JQelZHZ0dh?=
 =?utf-8?B?V1NITkxvSzNnPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4540936f-4b5b-474a-2e7f-08de786828da
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB5557.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:29:49.3839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB9052
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

On 3/2/2026 10:25 PM, Tom Rini wrote:
> On Mon, Mar 02, 2026 at 03:17:39PM +0100, Jerome Forissier wrote:
>>
>> On 27/02/2026 15:49, Tom Rini wrote:
>>> On Fri, Feb 27, 2026 at 11:03:32AM +0100, Jerome Forissier wrote:
>>>> Hi Heinrich,
>>>>
>>>> On 25/02/2026 07:14, Heinrich Schuchardt wrote:
>>>>> For enabling the clock driver we use symbol CONFIG_CLK.
>>>>> Select this symbol for the HiSilicon Fast Ethernet Controller driver.
>>>>>
>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>>> ---
>>>>> @Jerome
>>>>>
>>>>> I could not find any usage of the drivers.
>>>>> Should they be removed?
>>>> You mean no defconfig enables them? It could be that some project
>>>> downstream depends on them though. But do we care if we don't build them
>>>> upstream? Tom, what do you think?
>>> In this case, there never was a "DM_CLK" symbol, even for driver model
>>> using CLK, it should just have been CLK to start with.
>>
>> I think the question is more bout HIFEMAC_ETH and HIFEMAC_MDIO which don't
>> seem to be used anywhere:
>>
>> jerome@builder:~/work/u-boot (master)$ git grep HIFEMAC_ETH
>> drivers/net/Kconfig:config HIFEMAC_ETH
>> drivers/net/Makefile:obj-$(CONFIG_HIFEMAC_ETH) += hifemac.o
>> jerome@builder:~/work/u-boot (master)$ git grep HIFEMAC_MDIO
>> drivers/net/Kconfig:config HIFEMAC_MDIO
>> drivers/net/Makefile:obj-$(CONFIG_HIFEMAC_MDIO) += hifemac_mdio.o
>> jerome@builder:~/work/u-boot (master)$
> Ah, OK, sorry. Yang Xiwen, is there a platform that will be submitted
> upstream that enables this driver? Thanks!


Not yet. I was going to upstream a HiSilicon SoC Hi3798MV200 that will 
use this driver. But the progress is interrupted. I don't have free time 
to finish upstreaming it now.


Maybe i will resume working on the platform in the future. But it may 
take years i think.


Feel free to drop this driver if you think it's not useful.



-- 
Regards,
Yang Xiwen

