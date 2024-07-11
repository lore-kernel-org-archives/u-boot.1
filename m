Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B886C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C38388701;
	Thu, 11 Jul 2024 13:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tiDBDSBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6255886D7; Thu, 11 Jul 2024 13:32:13 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8642D88701
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXkECyVSnlveSKlpvaXw3aoYhYpjrUY1GMBBF+A4QdGwAHD4G9QWONQqV+H25baWAziq34Zd6nL9qtLZsS6k8v3sY5vCm+xIuBrXJNFTnG5D1Y7YCd0iOU+xRuAOypyPiXx0evjYWjk4fzCbo2Y9ZqL4qqtoW3NKG4jq8Pitbvhz27SwFWnWjdHwo2d7biu3Da3OaG1pmSlOqFPtW/FaBSwzqUzxrgOtM2XNFFyRmP2S/lxYyc2TxtN+2UZncJZF+M72DnzfO7WDasyMXBuJuCxzTt+o3Xjkf6Yfd0iWfITrZbylSRCQmTAPYIhEX/H8KOS+rxTJw1vL9m/+8MYrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keMQt5Q04QHKFX2GVPv6rb2VNEbAKxRBeJf2Cl5sipk=;
 b=G+re+AuSPmGO/G+vQs5lZ7avN1SjYyQpwZkkkPu+CJ40+xv+uiLpY9oItsWuiODMHHW6eb8KXhboETq6s9x+hrYzzO9zHMHiDJJGYan76gdeeQxbzTaG6kaJAhEE5LrRd9Ch2TTd1AEgnY9Ekeq/n1+AI3mRZM4yPSNG8vSwcnczcfYeF/uypdN1TpZWG566XvWHlFY4WOfU9CneRCfzjTnoooS4PyF1YztnR4ys49i7edwNf1g2/v8W4PilBQldxZaD7pZDOfrh6dECsnZhw972mz9KlnhK8KmuuNyKgfx+jauRpvj9Yxhk6SSYRNieqUZG5bFFkUGNAM/pOb/aFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keMQt5Q04QHKFX2GVPv6rb2VNEbAKxRBeJf2Cl5sipk=;
 b=tiDBDSBxcBRNJbhucSonlGf5aXqnvnqKRCDJ+uXJCL71TNcFCSXhARtirg9zYbzeSdQac/HsZL+muUERLKzn1EKxnThz/2SsDzV6PvfDWwrMFuRMwQv1oBzH5HFu2kh26gY8sg3qDTJPyMjtEOl2CzHpIPRlEu+yt+Jek5N5NV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6277.namprd12.prod.outlook.com (2603:10b6:8:a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 11:32:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:32:07 +0000
Message-ID: <6cd92bc5-e170-455b-b618-ae7608357423@amd.com>
Date: Thu, 11 Jul 2024 13:31:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynqmp: Add set_rate support for display clocks
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com, git@amd.com
References: <20240711082939.29260-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240711082939.29260-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0047.eurprd04.prod.outlook.com
 (2603:10a6:802:2::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 306b7a0a-40c6-4edf-8b4d-08dca19d1894
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFUwT3JYUFJxN0lwdXVuMlNTbWtxTTJsajRQOVNFZ2FDcmhDckswNStTclE2?=
 =?utf-8?B?Mlo1K2ZnSkMxclRRekVEQkJsRExkelEzYm1UQzB5QU1rWkMrYk13SFEvS2hT?=
 =?utf-8?B?ODlzek5wWU1Pc1VuU25qWEFCSW9CMm9pdHBBY1BoL1FTWWlobEgzRTJ5cTBR?=
 =?utf-8?B?R2dqaUYwc1ZVbE04U3JGRVZzTW4wTWZCTDVqZitCYXFtQ3VDeXI3a0JKb0Zn?=
 =?utf-8?B?Sjh6SWduOVNwcCsrQ0huSCtXanJiSy9USXVnVmxsSlVPb3kydkZvVjB1Mzda?=
 =?utf-8?B?TlVhVkFPOUtramNDY1YyYkpzQlZaZ1hxd3o2ZXBTeVJxcVNPT05HZXA5Z0l0?=
 =?utf-8?B?b2JMaWlBMndpeXV1QmhWeGlqcWlEMXFMVHZ0WEd0L1NHOUVDMy9pVi9TbHlI?=
 =?utf-8?B?MzhXU2hpQjFqTnFzbFp1b2YvYXVTdUFKcjd6UEdlRXZnZE9FSUR1eCs4bGVw?=
 =?utf-8?B?MDdqU0VEV2JDcS9LV1N6Z3pBdy82ZmRla1ZHVHhYbXk5ZjhpUUhpeW9uU3B4?=
 =?utf-8?B?eFhUU1hEOVV0aURyeFViMS84QktjOUlHUFQrcC84VjJiK2hMWGhHenFUWGpp?=
 =?utf-8?B?V1JHcm52dlY1N25qcU8vVjBEN1kyZ3o0RnNkNmtRQlNPb3dPOXVMQW1oYTFk?=
 =?utf-8?B?VjhGaExsM00zRVphYjFvTHdSOC9MNnpweXljR1ZIYXNHNVVuUFZ5MUdvVkZL?=
 =?utf-8?B?RkE4QUwvZVljNlJqeThqNWdTelpLektMVzJiSWxzSHY0L1hDNXBnblBmMzhR?=
 =?utf-8?B?Rm1ZdW1NUXpPZFlaVTM4d3grTXMxWk80UFMvYlN5RmJLTUdESlcvSFhSOHFu?=
 =?utf-8?B?a25tOEtzZzZqanVCdEJOUlp1d0ZCandacGRETFU1UWxBVDBMRFM5Vk1xR2Zz?=
 =?utf-8?B?K1ZSTDV0ckh5cWszc0VrTkt0VXBMWnkzVDVGS2pBbDhBY0ova2M2S3lUQVRn?=
 =?utf-8?B?TWNRd0x0alc2SkNZRy9GTVBmTW5Zd2VqcmFMb2NpdVM0WURJcURUK0N6UGx6?=
 =?utf-8?B?cGVQQzVrbHdTRjhxTGIzYjhyNEZNNkJQeDlLbisyYURCNGVCU29xdkFTTzdo?=
 =?utf-8?B?azJFN0JKbGY5cHppdjhOdDhkYVhKVzNsc0dvV044aHo4a3J6U2VrTVNFbEFh?=
 =?utf-8?B?WWFqTFR0VHMySnEwTkQ5d0NHSHVxcFE3UFNJaDNkNTdDOUdOWkdLa1p3NURW?=
 =?utf-8?B?Y2VwVFpQWTUvRXZnbE8zTmR0ZWRnQXRjT3J2QmN3aXhXQ3JMRUdmVUlKTkhQ?=
 =?utf-8?B?akR4U0F5bFYwRnpxY1BIQWNpbEF6a2xac3ZEZ3Z2MTN1R0pwQW5rSnNWV1V2?=
 =?utf-8?B?aStiKzI2L1hnWXNjdXZHTzIxdDJVWVBjKzNLQVI0djcrV29JVjhsVHpmQmJD?=
 =?utf-8?B?NXI4ODB1V3NEY01ZSUZKeU42WkV1YTN5UDMwV0RvUHJZRExLaTdNS0l2R2Fo?=
 =?utf-8?B?enNNVmJzSFVXb1I2YWV5ZXdqMm81VWxKSkI5Z3doNW5kTkY1SnlJdWV3Mnh2?=
 =?utf-8?B?K0tyWDN1aGRKQlYzbG5xZ0VLZzN4TTJRczJ5TytQTG52MzdzWmcyVi9rTk5C?=
 =?utf-8?B?V0RmMmx2d3p6RnQ1bzlTS2VrNXVycFJWTWpFaUpjWmZnViszdWIyenJ1UFB6?=
 =?utf-8?B?S1V1S0gvY0VZVnU3UnNmUDJWSXo0WlgyTGtZRzY2S0hYcUVqd29PaGl5SEZI?=
 =?utf-8?B?cTkwazZIbStIc1BnenNodjlGclc4RVRsYThKY256eXZ3aEJBamxhWkVjNGZp?=
 =?utf-8?B?R2Y0YWpUMFhiTXRrUFUvQllkRWdobnZtcDkzM3c1Y1Q3c1U4K0JiY3JETGkz?=
 =?utf-8?B?aE15dSs4MHhZNk54UHBodz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZ3czY0Y2lmbUdtMTVsUDc4dVRlN0IrZkR3SWsxeHdXNFM2T3dhWWhQbmtV?=
 =?utf-8?B?VFJCQWJxcVNLdURkaXZNcTNrWjIvWlRiNW94WGcvSkszbXRlVjVXS0F1a1Fn?=
 =?utf-8?B?azhXU08xZ1pSZkkvUXRnMmJvMGl0YkRQVFg2Uno1TDNHODFGczlZWmtCSzk3?=
 =?utf-8?B?ZkJBS2pEM3d6eHBZSGFRS0RDWjFSMlY5ZldCNnFuL2Izb0lOU3hwSzZYUjZk?=
 =?utf-8?B?MUMrUGJ4K3VxdFQzYVJ1NVhxUUo4STdnQzhySy9xRlgyRFRMWFJHQUJNM0NP?=
 =?utf-8?B?eFdOcG5IZ3VYdDR3V1FkelZUdWt3VTBVUUwxUjBzOHVUeGJlYS9mMHpoZlhh?=
 =?utf-8?B?RG5XQkQxUmw5WnlUWjhFdTJCemFldjVITUV3cGFTakU4VTdHbHovS2hPaFJK?=
 =?utf-8?B?bFhUSWZEOXFKYUNybU4wRElTZlZnNEMvbjZvKzNNMDUyR2N2UW5XNzVrSEcw?=
 =?utf-8?B?OEd5cUlPNlVBUW5wU3ZQVDk4MWk2Tkx1QWI5S29KbzZBZXZ5Q1VIWUE4eG1w?=
 =?utf-8?B?eFg3dkVLOGc1V3VqMlNzWE9PNnlZUmxKZGo1VE4zVUw3OGNIN3FVaXo1UUp2?=
 =?utf-8?B?Vm5Tb05JWDlEVGliUk4vVlVuMllRdDNVR1dhMDRwakl2NXJiNjVOb2JZdVhO?=
 =?utf-8?B?NEhKYXdzRlpDZ05tbyszeXdSTVE1Tjh0SGhJdDNBb0RIUUdOOXRTakxzbjJK?=
 =?utf-8?B?VHp3and6bEF1ZC9SWTM2cEpVUlQvZm9IOGtnYXBVWS83L0k1N0l2ejN0LzZF?=
 =?utf-8?B?dDkvUGc2ZGFwYmNvZTAzYVAzcU1qckQ0MndRbEE4WFl5NGVMV0FXcit4QW1I?=
 =?utf-8?B?eGVHZkNIZDZiNVpTOWNDR1VYNVZKbW4ySjBzVWxld1pvQjg4aDhOeHJsNjlZ?=
 =?utf-8?B?djA5QmZ4N2dHWVBPTERJK0M2OXZFNXNLZE9OWG05SmxzcEVMU1hqWFE4c2du?=
 =?utf-8?B?bXJQZXMxRDd5MWF4M0FzY0dZQ0dUU3QyczlsdmdpeTdaanBmaHp2LzFSRUJS?=
 =?utf-8?B?d0ppd0Jsck1hdzViTlpUU3Q5bHdnbWdMNXN2cXUwYjZJWGZ1aGx3ZVErRk1Y?=
 =?utf-8?B?N0hjUTZxcE1BRXhwendYWlRYa05JOWJJUkQ1TW5BNmh5cy8wc1g0blQ3dWFR?=
 =?utf-8?B?eXBmVmJrZnBnOXJZekxVQ0p4dWkxaTJxNTA5TEZvemo3Y2YrQmlrZkJIZXpJ?=
 =?utf-8?B?eXJvLzNORUxkekRmOURlZ0ZERE4yWXNyVTVuR2VJZDhwa1BwRnFXSHU1VjRZ?=
 =?utf-8?B?dUFmVHY0QkpYOGxkSW1qQjFrSk0vaVhuVk5DaWZwQnhwRGlzWHQwSjhOVVJ1?=
 =?utf-8?B?ZkljbEY3MUp3WXBnK042VTR2ZjNFZmVGc0NEeHdZdktZQnpZK1pJdXdWeVA4?=
 =?utf-8?B?RlBPY0U1SDRiUWo0K2ZrNitQTGZKQ3dtSStCd0ZzNUo5UURIZTNoZng2TlNU?=
 =?utf-8?B?bGVoMzdVUnJNSXYwK0RFTjJuWEI4OVlzQmF1YmlGRU1vbm5KRTN3cTRzK2I2?=
 =?utf-8?B?dnFvb0VXS0V3c05EQXBGQnFNbUhNUFhMQ0RkSGZMb2x5cC9pOTdlUTZBYVZi?=
 =?utf-8?B?Wklhb0hRZmRZeE1EaS9ydXNzdGVlRjBiZTFMbnlOdXZac1R3VU40Z1ZsVkdl?=
 =?utf-8?B?QWlvN1dRZmpxVkpJUW1CKzNGa1QyYzRKbnprU3V1RCtpMzI2L3FMWEZJWTdZ?=
 =?utf-8?B?bTRqS21nKzZCYUE0TkNPQmkrYUtqaGVNN0tEZjdyalJPOWk1STBVQ0pGNis2?=
 =?utf-8?B?NDJtNHh2bFdGSURpUkJxTTFRa1ZycG12KzhCR3dJRW8xazNrMW12LzZFRnFM?=
 =?utf-8?B?T2tuYXhORFlwZDRJVHBScTErRnp0NUpvZDlHYnNTS3BTVTF2aXF2MHdENllJ?=
 =?utf-8?B?eUxXK0Y3VGhxM3gxL2NWbzNhTFhZSDdFVUtiWlZKNFg1aExOdHYwNEhNeUxp?=
 =?utf-8?B?WUxVeEVtd3grTy9TeHJ6Ym53OUxFaktRa1psN2JBT2UyZGZYdG03N1VucEow?=
 =?utf-8?B?UDdGSW1aRFYvR21acUQ2SUtoVTNYS0E3NXZ3STkwOGVsaWRVYkd1MFNGSDZX?=
 =?utf-8?B?NHU5dUlENWVjNkJnSGliL0hsNGF3cDJQT0pjK0NKSWU4V2FWS2V2c1Y2UGhI?=
 =?utf-8?Q?Dizhk4jUIGoHdFsnLokhnyfCa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306b7a0a-40c6-4edf-8b4d-08dca19d1894
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 11:32:07.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d2W5lRb9sdo2S8s2mMWd8MDTwev8wWoV7YM1NAKjlUfg8GclY/A0c8h9JEAqQlD5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6277
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



On 7/11/24 10:29, Venkatesh Yadav Abbarapu wrote:
> If "assigned-clock-rates" property is included in the
> device tree, display driver probe is getting failed, as dp_video_ref
> till dp_stc_ref clocks are missing from set rate function, adding
> them to fix the probe failure.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/clk/clk_zynqmp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
> index 5999926614..5635451821 100644
> --- a/drivers/clk/clk_zynqmp.c
> +++ b/drivers/clk/clk_zynqmp.c
> @@ -727,6 +727,7 @@ static ulong zynqmp_clk_set_rate(struct clk *clk, ulong rate)
>   	case gem_tsu:
>   	case qspi_ref ... can1_ref:
>   	case usb0_bus_ref ... usb3_dual_ref:
> +	case dp_video_ref ... dp_stc_ref:
>   		return zynqmp_clk_set_peripheral_rate(priv, id,
>   						      rate, two_divs);
>   	default:

Applied.
M
