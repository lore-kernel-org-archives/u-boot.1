Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58983C531D1
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 15:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C517660A62;
	Thu, 23 Jul 2026 15:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJtb0jqsrspJ; Thu, 23 Jul 2026 15:18:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 973AB606F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784819899;
	bh=bpSngF9pEQEbCYnaZ3fj8J+o82EONQXxv87hdJA3Puc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iy1FnjDbq0HVfQH/WnbbVTURFm1xlnwJ7obCaZS9pbO9nabAIWaJLCKIarUmJCrfs
	 vMDkGhOTPmMGWSULITB73Jh0S+Dyv+OWcmmf5caKslzPTbdtRpxeATCMRaiefyWbk7
	 d0ctGKX1Tjjr9/msDbox5npzNoeG2ZIAMhFQs65MvSl7teViLZgSgys0zfxamn8Vx4
	 9wuGVSn8nkI05lFq/6EXjEZ84VVo3BS2EmcNLyMoAv3Prm0LPcFNr5gT1LXtzZu8FC
	 ZUoPS3MIcsu4OGj03kOET/KMAh2fJn75xp+i05/WPCsI+ob2a/gJzwS1lMHIyyk0XB
	 k+CJhxLWi/BaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 973AB606F2;
	Thu, 23 Jul 2026 15:18:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AD83707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2037A81083
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O6jEkin9j7U3 for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 15:18:17 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0BC1F8104F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BC1F8104F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BC1F8104F
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 15:18:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE99880287; Thu, 23 Jul 2026 17:18:14 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6D3780087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 17:18:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tpo3xqFAL6E5++9jU+rhiI3D52nlwSQS0bfYyQCwN4kK1bgimCjdipZCCTHYYd6f9ShPrvLNE0mT2HK8ZNjRJiA1z+28DOaYmPXeC2RI4wCeqKVOwuQgrBi7qwAV1guI84RRD7NmWyJMj12mOgSHNW8sZceM9jyjhjyrOpwQuwQ9LkwFiW096hGNNGoLfPV9o1Cq6fik5H481/v5OvmkQnkgz6Ob9WlBFAd/A1zWFjFnZNaI4fwXxJh3yoG03NnPsKwhWkVgiNypvetCvjyfa4J1ZnqEetis64HSqvXkaoXtkNyfehhA1PDQlYgrMJCzmQnaDr1Y6ztWB99qYKgSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpSngF9pEQEbCYnaZ3fj8J+o82EONQXxv87hdJA3Puc=;
 b=lZV0mPigpJa1CQsYKhE9PF+gKo7uzN7S91zrBtxmCnywd4o20tdXzXgGQ80Bn/KuaJmvnB//XWEsFLRlsD/VWF6DecZMMhRXV/AYZxWYrbkKZkBExFhqv6JyTHTe4X92AcliiODOFXPhQrgk4RWuu7QFX6nnpqRx43+5JVbWu0NviwZnz6BTaBiE+qVqSE72de6uRz6sFJeqEzp5y6SAb+2+dPvILolvH8IvrFDQ/ua3Nxi52P0PHJFCa+wQwtuTSo/PV5fUsQp0xqgCv8nRmxqId/kG7Gr0cyzCgcn61c0MiIMlK2dTWMos5WvdOfEJJ4O0ya4pQFdy19coFNbWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DB8PR04MB7132.eurprd04.prod.outlook.com (2603:10a6:10:12e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 15:18:10 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 15:18:10 +0000
Message-ID: <5dc5b76f-8ab6-4a8a-8d79-bf02bafcc66e@cherry.de>
Date: Thu, 23 Jul 2026 17:18:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fs/squashfs: fix two out-of-bounds reads on crafted
 images
To: Richard GENOUD <richard.genoud@bootlin.com>,
 Piyush Paliwal <piyushthepal@gmail.com>, u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, trini@konsulko.com, eric.kilmer@trailofbits.com
References: <20260612075424.83462-1-piyushthepal@gmail.com>
 <cef44406-c4cf-4795-931f-e0b110d36282@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cef44406-c4cf-4795-931f-e0b110d36282@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0063.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::17) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DB8PR04MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 404f769a-1abf-4aa4-095b-08dee8cd9b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dMtSy3S6p51M8w4TbAxC2h+B0nmpuTSq9RllGnnXgBqux/kqGbihP6VsNdUbA1GwXyE2P43QFNLzs43HTVp4/nPJnX5l9YYCuKDChznsWa/1O9lSzvffq6F9q2JoCUh7TmXD1dmu6FIUgGlLDH8ucYO+a26mes1dqUaU4eFi9MIkx9dHT+TT06nLyfBvSHo3eteRJ/VMnJQ1RIHlrN3CECkDl5C9CnVrL8jx1MxqnkVXuCf2gDsqX+9zJqkmsW9XRMQ99hIXMJ8w8uQnMMWZWHXHdHxmTATHTDgxWfOEGa8kv+NnU3N5xkb6QydFfpDJIvZ1jLWiOobvvBUvCHxl9eZpK8Ae4MHyCwPq1xEd6fDveEvoFMkp35ztXSTMV1mHnMrhYBRwviaPNZLCFblDONlF3w3oKbxrbQ0lRZxMy7uX94b1tf93AhTaN5lmYDb2Y+aaXHldH/fL1psDYP+iO0fWWKNJr6etJVWPWC3OVRnAR6UmgxzLhVr+X9lXUGHRmL5T7Ty2csGZmv/zfK1aEzPNIkbjJgK9Ls8rTXC7ULkFwIlvm7XqYzJocRrMA90nK9+k3DRyTmj9hnUczWWmiAxqLIJhVj7LpCog+16xPKWCoBHvetVIqPRta0QF6qZntI0i9yvECqwBkQwo3Hvve5v/aGoaVAX0JLqkqfS2+JQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVdJUGhkdW41eGs1WUlvaUE0dXVNL1FaaWQrWW5kUC9WbWhUYVNlSGpNVE5x?=
 =?utf-8?B?d3B5ZlNRN09HMGEwNWQ5clNrdWRpYk1LT0lLRzVUMVlyS1g5cG9zZW5nZnR5?=
 =?utf-8?B?ZUdDd0JBUlA4Ym8waXdZak1mdmxNL0o5Y0NLZ3p1cWxPOU9jV2FTZmlocFNC?=
 =?utf-8?B?RFJhSUFWOFdVYnF4UjFobWhYTnI1MXFWbmpQdklJZU9NN09QQ1ZFK1d1VkJZ?=
 =?utf-8?B?aTZZUzFIWHcxQS92UHNwY1lDc2V5OXkxTkRKK1FmQnZTb25EMGEvRlRhS2V3?=
 =?utf-8?B?aEd3U3EwTVlqUWI1aU5OUEh3bmw0WXJUQVB3USsxRXVPbkREeWFra0ZhbUVR?=
 =?utf-8?B?N3JKa3o0QUs4dmc2Vi9Kbkk5YWNHb1lSZSthNHM2ZFhyZ2FjZG9tL0VCcTFB?=
 =?utf-8?B?clJkTzdtMU1hQ00yTEFpUmx4U0dEQnRrQVBsQjdKQmt1SXFFdkZSYmlYZi9z?=
 =?utf-8?B?UTJJOFlUcDdDOHFHdnMwSEJPN1A4VHc1MDNTTGtBL0NORStDWmZYVC8zWVc1?=
 =?utf-8?B?NlZJalJFZWN6K0phQmY4RmFRdER6WElhSUI4UVZUelJLNytaQnRyd0p2WUVl?=
 =?utf-8?B?cVRzQ0dZYjNnOE1md2VrcXh5ZFNQUmR0cXUvb0hobWIyWkg1cXc3ZGJ0cU83?=
 =?utf-8?B?c1JtTGlhMkpsRkIwOWtTS20zajgwckdrc0dkOFU4dUc0UklVQW85VGhOR1Vj?=
 =?utf-8?B?VjAvYnpUbjVmU2FjSmxIR0lWNGRFbmlVUE9EL3JCajg3bllMUExnZjBoc1U3?=
 =?utf-8?B?eXVVaWwzQ0ZURjVieFNOZ3lKVUVZOTFXSjZGWjByYXJLSDlDWko2aGtjK1o2?=
 =?utf-8?B?QnlpaTJQM3lIWnh6N3BmcEc1U0FsTWpwRGl4RlhxWHl5dnZaRG1rQXd4RFZ5?=
 =?utf-8?B?bU1CYXE1dC9IVHl5MkpndlBsbXBGU2ZtdDdBQ2dQdVg5K0xWNHowbnlrbUk2?=
 =?utf-8?B?WkZ6VGZZT295U20yZEtxaGwwRVcwZkg1U0t1VVliTG16akdNMS80azZzTGVH?=
 =?utf-8?B?cjhIay9mWWtkV2ZFZ29TWnZML2tUSHN5b3FUT3N0YVp2ajJCZnpSSUg4N2RS?=
 =?utf-8?B?SFhhQzZ3eFhBL3JTQ2ZJMm54RktadGZpQ1p1eVlPM1A1MmRkTFlLYkZkdDBw?=
 =?utf-8?B?eTg4aVhUQ1dTdDV0alRMNWFVbTgvSjEyNUh5N2IrT1RVSHVZTG5JTURiMS9B?=
 =?utf-8?B?MG92OWdvYVdFdXYwR0ZQc3plaW90UE9uV3FlaHZuRWdQYUFKei81U1NlS1VR?=
 =?utf-8?B?U3E4cC95ZjZ6N0VKaGhrc3lKNVo5b2xUMFZnSVh1Tk5sblYybDdJYUJJY3I0?=
 =?utf-8?B?TCtXaGxubDZrWjIrZVA0eXdmS2txenYzcFNKM013ZUk0Wm9FRDJIMmt3OEVx?=
 =?utf-8?B?ejQvREhFS0pWZDJFc2RiSGxOS3dMNEM2SHVBNXFYenpiNWZjZmo2M2t5U3hR?=
 =?utf-8?B?TGdueGdVQUxpQ0RXa0J3T2pTa0xtYzduQU5RcTRmdGpORXZhdnFHQTNKNXVz?=
 =?utf-8?B?VVp2ek1MWmsrYWxUeFp6NXlxa3NtbDF0VGIzREQyUUVoK2pOdktlY3RiZ1NF?=
 =?utf-8?B?Rk1UdXNWM0Z2cTdHZ0Nrb0JpR2V2bHJHSmpFdlVoa3c0c1puNmtJYzkxb05G?=
 =?utf-8?B?Nm9UYWVydi9zamduMklQc1RGZ1JMZGU5dlQvMkpJb3JCY1BNb2FTSzZ0VUxC?=
 =?utf-8?B?eHRMUjNLRkFUandPbXhaRXBsYzJrVHpnNy8ySk1pQ1gzY2RFa25pekRlMDdy?=
 =?utf-8?B?NEQycDNzT1FGWGU4eEEvYVFXaHRtei9Bam15RFFNcUNiUjhzTi9zTXMxdVpE?=
 =?utf-8?B?Qit4cW5IUCtJbGFTUFgwaE9lcTNhT1FNTFQ2YnZVbWZMdVc3T1h0aGIzWXow?=
 =?utf-8?B?VkllTCs5VWpyZ0JwT05sMnpQYXlFbEloRWdleURDaTNmR2Z1VzA1eHBiVmd2?=
 =?utf-8?B?aTdWbVZkMWFOQkFVZGtHMzdIQWJPMVhlRlA2cHBubGVML1pxLzQ3VXF4bjdC?=
 =?utf-8?B?cmlSZ2FSb2tDcmp3NmVXbzgwdUQwK08zb0dTTExwd0VFMWdISjV4QmNxTU81?=
 =?utf-8?B?aks1S3crNVQrbDQ3cVNPT2ZPYnNkYTFTUHZSQmNSQmNDcEtTWDhySEJoM2hH?=
 =?utf-8?B?cXZ2RjJ6ZElKRUtFU3pMYjE3aDczM1UzSHdYaW81TS9CZWI0OXRadGNxalpx?=
 =?utf-8?B?aS9UVkgxcHpsWVp4Z0xkYTF1bXFzYUhHU0FVK0pPUEw3WWFHbmxIeE5jV2Iy?=
 =?utf-8?B?NS96TFA3Yll6RkNTQVNVdHRFM0Q3aC81aW9yaVZQa3hxaVBiL0E0Rnl0Qkhl?=
 =?utf-8?B?amIwOFhReU9rbjFYbnRnem5MSWVIdHBwbUIzdzZBZExNSHNSYytDUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 404f769a-1abf-4aa4-095b-08dee8cd9b13
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:18:10.2391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDW8qXuG8PzEBCjVNmT5lP9w7iE9AFf1Rf3BB/6i409wyad9EpdwAuGVMn32rJgT1ZlKWObaWdxFheOB4QEpTfJ5CGQZckLbi1XnXg454D8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7132
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpSngF9pEQEbCYnaZ3fj8J+o82EONQXxv87hdJA3Puc=;
 b=BfvYEoiSQvXhGtxjZcsjHjDqsrQILd22Zy9BeFuX8RAm2mfdNCtMDt/UCqYPJgPqoxMpn1oUBTrFnTPmbI0IqeKtEoMRVC53N45/+cm8UF2eBRfXgPHtW6pafyVT7JxB2FGv9OcW8S5+izITItzgwX+zgRmJlG9zIlehoSbPFlM=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=BfvYEoiS
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="BfvYEoiS"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi all,

On 6/25/26 10:08 AM, Richard GENOUD wrote:
> Hi Piyush,
> 
> Le 12/06/2026 à 09:54, Piyush Paliwal a écrit :
>> Two independent out-of-bounds reads in the SquashFS driver, both 
>> reachable
>> by pointing U-Boot at an attacker-supplied image (e.g. ls/load on a 
>> crafted
>> USB/SD/netboot rootfs). Either one crashes the bootloader (DoS); patch 
>> 2 can
>> also copy adjacent heap memory into the loaded file (information 
>> disclosure).
>>
>>    1/2 sqfs_find_inode()/sqfs_inode_size() walk the decompressed inode 
>> table
>>        using on-disk sizes with no check that the cursor stays inside the
>>        buffer -> wild read / SEGV, e.g. from a simple "ls".
>>    2/2 sqfs_read_nest() uses the on-disk fragment offset as an unbounded
>>        source index into the fragment block -> out-of-bounds heap read 
>> when
>>        loading a fragment-backed file.
>>
>> Both were found by fuzzing the sandbox build (CONFIG_ASAN) of sqfsls/ 
>> sqfsload
>> with mutated images. With the fixes, the crashing inputs are rejected
>> cleanly, 2000 fuzz iterations produce no further crashes, and the 
>> valid-image
>> path is unchanged.
>>
>> These are distinct from the 2024 SquashFS CVE cluster 
>> (CVE-2024-57254..57259,
>> fixed in 2025.01-rc1) and from the sqfs_frag_lookup() fix 
>> (e365a269df5): the
>> earlier work added NULL checks at the callers and fixed the symlink- 
>> size and
>> fragment-table paths, but left these inode-table-walk and fragment-data
>> paths unbounded.
>>
>> The two patches are independent and can be applied in either order.
>>
>> Piyush Paliwal (2):
>>    fs/squashfs: bound the inode table walk in sqfs_find_inode()
>>    fs/squashfs: bound fragment offset/size in sqfs_read_nest()
>>
>>   fs/squashfs/sqfs.c            |  50 ++++++++++++----
>>   fs/squashfs/sqfs_filesystem.h |   6 +-
>>   fs/squashfs/sqfs_inode.c      | 106 +++++++++++++++++++++++++++++-----
>>   3 files changed, 134 insertions(+), 28 deletions(-)
>>
> Those patches look good.
> 
> NB: a patch correcting the same issue as patch 1 was sent 12 hours 
> earlier by Hem Parekh, but it fixes less problems than this one.
> 
> Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>
> 

Going through my inbox and stumbled upon this here. I see Richard is one 
of the custodians but I don't see a custodian tree specific to squashfs 
in MAINTAINERS. In patchwork, this series is delegated to Tom. I have 
not reviewed any of it so this isn't a push for "hitting the merge 
button", just trying to make sure it doesn't get forgotten :)

@Piyush, please refrain from adding Cc: stable@vger.kernel.org to your 
commit logs. 1) This is U-Boot and not the Linux kernel so it's adding 
noise they don't need. 2) We don't do stable releases in U-Boot.

Cheers,
Quentin
