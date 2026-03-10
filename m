Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C4FFCC9D1
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 07:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE0C883981;
	Tue, 10 Mar 2026 08:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isKwJSDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94AA839DF; Tue, 10 Mar 2026 08:36:59 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FDB583952
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 08:36:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+aebpEghH2bdKV75u6VuGVGJ9sElnH8uj1XGwxMLMiroE7FN4TRUQ52j50y6AalTzGHQIj7IMU835Y23s4PCKJ5EYLgRN9hNEW49SG6WlRnuwwPsP5HHGDlQmiXCSoEdmjdjhZlW4RdKl+WMtM/R2LGQ84V1mw05ipjlZSNAQBFuo8nVwJFTT+1k5xN4KTeeyAe0WBuOFL/I73Vdik+VPv0hsD1GdJ1bsjHWthohbiTqjAw8aDT0Hw8bQl6yM/m8p0F2CLLfimOszxCgkXcnybk1LK5mAXStcmcoOjH4sdSlNNIY7cTYgbn+VJgycSbWRPErDg+JbL08nVePJCEuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfTA7siioXSgzhl6A5MObex7lZEuLFLvkJoVS3tj6gQ=;
 b=euvySJBUdNaLcA8TNlEs5Zb8ynbOfdXg4EZGWmaZU22ZjAr1joyc0MTD4yO7Oc6PGUhysL9/45gkGwg+Mg4fMYMNl+RJcJ5fVHNd+7oWArwbCM16CxxsRvkHVmDmrAe3UmvNC+2pEq3H1dzgQqS+1sOxDxriiYcW71WCaEnbBeXO3ePUh0m5mGsxkcEp6sWHX+4q81HtFKTQiG2Dzcb8s7cR0KMeDyn3lyACJpWZa+7KC05bwpgWrUALJCrpIW5H6sMaU4KvDC2ray3YRWsGtpSG9cpDlaiXwg+PbOI8Mkzx8VORT9LkeqYtgrssS924UwNbJ19P7NfbPQfhnukvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfTA7siioXSgzhl6A5MObex7lZEuLFLvkJoVS3tj6gQ=;
 b=isKwJSDAAp5WjnMe0dKsFdIxY48937cIQ4RE8WSdYL8uBRttOkQtr4iQYfGiV6I0ZYKg8T5T/Rkc9nxfnUF1E/+O49+xajykRgCQjI62HCNR5ZBql8NXOC2YPQVD9Zm3+9KERzD9gBcex63pGLruM0thC+6f9E78Zr+TDmosvmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:36:48 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:36:48 +0000
Message-ID: <1091ab87-1d8f-42be-8ca8-235870728f26@amd.com>
Date: Tue, 10 Mar 2026 08:36:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] net: zynq_gem: driver enhancement
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Harini Katakam <harini.katakam@amd.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Martin Kaistra <martin.kaistra@linutronix.de>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1772437409.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1772437409.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::24) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: cc574148-ba6d-4c9e-16d2-08de7e77c9c3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: jxtSPeonrnI/rxNpjiCmBW2A5sZtevk3kaeQBs1OEu4gwfTHmEtjhp6ABGvTVvjFukayABEcN+4QGcREf5TmMvvp1tUNu+4Y8R4RTSYsyBEE56dc5z3QVgMT2Z63aVc/r+EQldM0zT5/u6y7N20XYNgq8JvI2AsFNDNuc9QKsD4CK32MM6MzznDnQzo1npFJG45nUair3BTy6WvaSAuV5Sdkzs70RP5ebh8ejxRGxDYJzXdHmD85l7T6I/x1bAqjujSL8raiQCJoTHMJVJoguRQRkQPo6O6WjURNXJA5Wf0JtLkNn68EBUwnVHWWJnUYzLvQqSCelwuO021ZUOvvl8J0KT9LU3RqVajcWCamQeCin91raibiANcI5EtCQ5eP29PEO0+p0AEC0osJDAZRu+aYVDwokRvcbp+GU5w8IZvxQ52/RlFlzsiE3YapiwEm5zbKx6IiJeXoPtziQIFuwEFC4jTbgRJvAdFBPrG+MdrYKWIEaVHVb4OWHPetn5/r0z9fhEdqSc+V9wi6LtHpyPTZPXj2g3LjdonM6z5Tdr1ig2jroYvYl4HuCrpZUbBxiEvADUFmUmVZrJN5Oz0Wbf/N3V2vi94hI8ilj91DcS8prvVufW4gguxLEsSRNScUUBlijKd2Th4YykcIuVisCENe6yuTxuvghYCnFKeY5ukifGia3tBVnXfJaADWlB9/Oasmib4O3NQxqEdukl9R5bOxlokYxuhzaxVFyTKkuSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGt2bEtjRzd2cXVHaHFxRDlSR2ZNUngvK1ZNM01RaUF6RlRrSERqTi80Z0ho?=
 =?utf-8?B?OEN6ZzZuVlRSejN6Y3JNNlF1T3dXcys5bnVUZk1pZUFFVXdoenhWVlJuYmlO?=
 =?utf-8?B?Z1k5OHo4SEdLYUpra21YbVJDS3B2blRTSTRSUkU4eFVLUkJJSEo0aHZwTVQ1?=
 =?utf-8?B?V2oxSGVPSkh2K3F2TGY2NmJJL25iMHpubUEwT0FxSE9wRTgwK3p0VWpwWHpX?=
 =?utf-8?B?Si9jV0thY1J3eHdNTDJHMXY2S3Q3NWJBWXV2OTBBVkdUd24zNnpSSmRIQzYr?=
 =?utf-8?B?UktQMFRibmVnWlozeGdCWDE2SVR4UHlrQXRjSDlZc29ZQWwzeWk2ak9uUm9W?=
 =?utf-8?B?ZmZHNWkvOHdIRWdORnUvUXN5cWF3MGpjc052Wkg3d0thSXExL1lNSVBGUUNa?=
 =?utf-8?B?cnNxOXUvanhiaHZSUWREejVvajhvbEtEQ282SlFiak45QTYydkVNZjdQdTda?=
 =?utf-8?B?TXE0UDlZY1loV0NWR0w4TnJmVW5BTnkwdVdsVWZxZzZyMkQ0MnRJSlRKaUFk?=
 =?utf-8?B?N2ZzeUVoL0dLY0hpdllqSjhaMGlaK2E4TE1KWTVSMjZTT3NkREtLWThjWS80?=
 =?utf-8?B?Z3VRRE42UG1xdm9Sb1U5SmhiVUZwb0hGNkF3ZHZuY1U3ZjNvbEFEQXVmSHFj?=
 =?utf-8?B?RGVoajFhbXRROW9nQnFtUDlJSHhKcmozMGFyUStyUXl5UzRMWmlFYlhTZmlJ?=
 =?utf-8?B?a2pIZmhEQTRqRGx4OU15Q0lmNDRsbWJxY2VaQ0VlNUdWTGk0VVUyVlNoQjVy?=
 =?utf-8?B?L3M5Kzl6Mmp3UWVIN3VCSFBRL0JlWFRyME9oNkJhK1dSb1NQZi94WDlFWWNX?=
 =?utf-8?B?VE9rdDAzNm9DY3I5ejhtMFFFaFBLektveFEvWTZpa1FYdUhKOFFaOEx3elp4?=
 =?utf-8?B?UkxrRis2YnI5YWNucDJVdTF6QUJNZFRHNmlZeno2SUJkRVZTV0h5OXo2bmRr?=
 =?utf-8?B?dTA1b2Q0OCt2N2ErRzFVWDY1eGhUMlI4eE1zWmc2SnVXaVJNMHR1VzBUb2NR?=
 =?utf-8?B?aXVRbGorVjhtcS8xT3NRVUtqSjRkbTMwT01kdWF3Ly9rdlFBSkRTR0tjVlJT?=
 =?utf-8?B?QTVrSXQ0WlA3VlhmRUZzT1NrbjExemdPSFJsdHZpZlB6Y01xMXFFenJwdVBC?=
 =?utf-8?B?czJIRW5NRE5mSkRQc1lkcTVtQWRQV2JsTHhZdnVLT0lWY1hEWlZvaVROU2NV?=
 =?utf-8?B?ekx4N25vSzFvQ0NVKzcvOUpYTlJRMEt4UTZsZlg1QWdaSlc5M1ovcnJVZFBu?=
 =?utf-8?B?Vy9kck9sUHdWNHVXdVR3NHRKTDV1eFdiWGhJRndMWmY5ejM5SFcxYzcwV1RL?=
 =?utf-8?B?aktTVEp1d0cxcTUrUXY3eDloTUloa2ppNW4yYTdYK2UzWThuUVFZZHRFQ21t?=
 =?utf-8?B?QnZUVHVEejRyZ0U4dUN2ZEFMY2ZtNXRsbmFPVmluZnNUbHR0QnFpelpCa21X?=
 =?utf-8?B?azhVUXpJOHVxbktuektoWS9zMkJmT3ZVYlBVekdkWFB1UFNDekFIU01pUm90?=
 =?utf-8?B?aG5wUU5mUTZuNnJLTTlsNWtWMDVvQmpSU1o1VjN4VkRqUklrQ1N4Ui8vb2p0?=
 =?utf-8?B?MTcwVk5OVW5aOUdEMXJqck5sM2hEd3BBWWFHL0dRWHA1dGF4LzE3dGZpK21j?=
 =?utf-8?B?Nm9ONUh2S0gvakh1SXV1MytkT1hxdDBqNy9RZFZEbUsvZmMzMXVzZkRwR0x6?=
 =?utf-8?B?dUlkbkc5ZFhJUlBVMEtlQTRJU1hLK251eis1N2hybVI1cmxtWGtJSWk5bkJq?=
 =?utf-8?B?dEpJYytBNlBPUnloaWdhUk9DdEF4ZjhOZEtaM0tiY2YzdHUvWVhGUWJ4WHRj?=
 =?utf-8?B?T0hxcklDU05uSXh4dDBOSjJVbENBQVNzKzBDVXhmZG45ZjJUL0RJekU2cVhS?=
 =?utf-8?B?M1BJV0hHZ1hpK3ZIUmFPUC9CL0J1TldLd25wcU9VeEZTbWpwZ0pVUEJaQUtI?=
 =?utf-8?B?SUtZQkoxZXVhYmZkSjI1dXBTeWxtQUpzYTNtakpnQ25XMFcvYkE1VFczV3FK?=
 =?utf-8?B?RFdVTE1UN0ovQTdTcnVLSHhhTTFCcWJkcmsrc3ZQbk5UL0ZFZXMwTFdrOU8r?=
 =?utf-8?B?dDcrT1MxQXp5OXlZWHcvRFl1Vk9BWVhNV1FpTnBuZjZjWFlQTjdiZnFXVEV2?=
 =?utf-8?B?R0F2MkRDNFM4MmQxTDRsd1I0bUZwM0hVUXhBZWRxcnQ0dC9WTkQ5Uy9oSDhx?=
 =?utf-8?B?bjdkY1gzSW5FOCtvMjhlbXUwcVJwWDdYVUtzbjhqRlJaNng1YTBvNzRScUZZ?=
 =?utf-8?B?ZXhTT2p4UmdETXF1ajlJNjNESkt4RVo1N1QwY0ZSK1BreTd6L3Q1cWJsUE5j?=
 =?utf-8?B?SGNLMEdlY2NPR0tlbDBiMndUd2xOaFllSkY4RVFjOUkreEQxZTVCQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc574148-ba6d-4c9e-16d2-08de7e77c9c3
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:36:48.5701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TOyzIKkKMssUYJma88Rp7aYUv0PquXhAFe+8Q9wBGzWnQarwDbOeY355G8lwT5gT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333
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



On 3/2/26 08:43, Michal Simek wrote:
> Hi,
> 
> on cache coherent system some operations are not working properly
> hence these 3 patches.
> Boardcast one is just optimization to ignore packets which are not for us.
> TXSR is actual fix for coherent system.
> dma-coherent flag handling is nice to have but don't expect any performance
> improvement.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (2):
>    net: zynq_gem: Disable broadcast packets
>    net: zynq_gem: Add support for dma-coherent flag
> 
> Padmarao Begari (1):
>    net: zynq_gem: clear TXSR transfer complete
> 
>   drivers/net/zynq_gem.c | 34 +++++++++++++++++++++++++---------
>   1 file changed, 25 insertions(+), 9 deletions(-)
> 

Applied.
M
