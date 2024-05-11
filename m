Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1F3C04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 12:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBF488025;
	Sat, 11 May 2024 14:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=windriver.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4573883DA; Sat, 11 May 2024 10:59:01 +0200 (CEST)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1FDF882CB
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 10:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=windriver.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5861b5c029=quanyang.wang@windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44B7o2fI010215;
 Sat, 11 May 2024 08:58:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3y1yn5068c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 11 May 2024 08:58:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuRyiT+jRcmeINuJYrSV+3XE+QV4px0xqzS2inoQOk0gSgVIgdOn/TUOj2deCk6aUGtLsMmeJItIcES44muBh6An1xq9n+wn3tEliZujVnQwX7w64QNVfebnGKLnRqquc6XYlO0voeUrZMF8VWw4M8IVsQ2ckYygmVer+ndiq5I/tBh6fkv3jxTrwtT8488PyqSbi6hux0F/rV3wJcxCAoj3gQQzTtdueQM9kxLtIvjxmkQ/O0SLmi9o1wfLYDnNvud1wrTdXcVbgFe/4wrtbkLF7iHjCksf0I+3C0SUxBY4Vf9Ua6oIm+/LpqQ70ebdFQ98NQ1HPdV+Vx71mbhySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne/KVVjrCDdC9a3/P8jpMLH87p8Qv2q4yAeKc5r4aYM=;
 b=cudFxtvk2uSFWVTtqjGm0BFEGkN1p8sThwuSt/0OA1M7ZfKbuY40Z+y0aTTyj/5ZVoLtPNqqAqAJQIrRZQqBXX69ilJ9auZnaObQmCUB3zgP03D1DM9wAgEOZiO7vycil11Eu2WdNOWsvsb/Vnh3tLYwSW5zzZMuhzIZgGsrvyuWGMeZL3t/ev2H/nt99b8Ihi2gkQkcLsKbT3qIRHBkEbi6dfCi/F3MH6vCj83Vco9Y8L79qLbbHzt30vgvpgV0uSAPYUhpRescPJx55EzCmfxvfXyNXs25+p1t7iihCnwrfgWa5Bt7v4Bl2RvNd4GS2TaHnaYdZuviQjHt831wzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7402.namprd11.prod.outlook.com (2603:10b6:208:432::21)
 by BN9PR11MB5228.namprd11.prod.outlook.com (2603:10b6:408:135::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 08:58:50 +0000
Received: from IA0PR11MB7402.namprd11.prod.outlook.com
 ([fe80::38de:da3b:4bd:8833]) by IA0PR11MB7402.namprd11.prod.outlook.com
 ([fe80::38de:da3b:4bd:8833%4]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 08:58:50 +0000
Message-ID: <3d381f35-da28-4b8b-96b8-953f7cafc5e6@windriver.com>
Date: Sat, 11 May 2024 16:58:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: Fix pinctrl_gpio_get_pinctrl_and_offset()
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240510193554.884344-1-jonas@kwiboo.se>
From: Quanyang Wang <quanyang.wang@windriver.com>
In-Reply-To: <20240510193554.884344-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To IA0PR11MB7402.namprd11.prod.outlook.com
 (2603:10b6:208:432::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7402:EE_|BN9PR11MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: eab508ec-e522-40f1-e223-08dc7198933d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzFzWWxHdjR2akNNTE5XTlZvWnZKTGppbUN4ZkkxWlA4cm1uMWovNU52NlF2?=
 =?utf-8?B?RUZWSmlKckM3UmpOSWdMdG1yMGhWRWl3RGlkNkZnTzFHVFNsYUJ5Zzc4dVVw?=
 =?utf-8?B?VStBWE9ablVwd2IyZkw1b01xMWhvTHMyRkZmMi9MZEUzMEVNZUVyL1p5NDNw?=
 =?utf-8?B?c2JoRytVVFV3L0gzWSs1TStJS2FzSks4L0ZLQTZ4dnRrTGhDMmppM0hReEs1?=
 =?utf-8?B?TFdaa0RJQ0ZGNitYQUxGejJJemZPVmpjTWtUZVVnOEtSU0o4MCtYMXp5ZHlm?=
 =?utf-8?B?ZzhkOHpZTTRpak0wcjdIUlVSaldGRmZFYWRBTWJ0Tkc5QkRPczlnL0NsaS81?=
 =?utf-8?B?U3RsWlkrKzc5UVUrbDVmMzY5TnhqWTlPa29ueDRNTzE1QnF2KzFhMG9Wa2s4?=
 =?utf-8?B?UkF1YXJ0L2xtN3hIWVh0YVlOdDBVUU42RktKR1lXZU9JTTRDUHVJVkJ5ZGhJ?=
 =?utf-8?B?RHRRVnFmRUYzS0pXRFB1ZE9MNE5ZV2JGTnlWUXNmTkEwYnZKV05pNDB5TGxi?=
 =?utf-8?B?YXBPQ3VHY1p3ZVpPbW5PZnVNeGdhTEt6dWdPVjh0S1c0eEE1NzFYM1RNN1BO?=
 =?utf-8?B?enBvYzA4b2JZTUFBNTFPalppdFIxaTJaUlFxVEU4dXIvdjIzdzJTaE5rbU12?=
 =?utf-8?B?ZWE0Rkw1bTBCNm5oNGRtTmlEeEc2WjRCNlVYa3BDUWNmeTZKZWRNRCtJeFhL?=
 =?utf-8?B?ZEtwaWVxZnQ2V00yY2JtM3hkM2k1TTdTRThOMU9ncXYyNDAwa3F3Rmc3SlVJ?=
 =?utf-8?B?ZEpqKzRsdDVhaGIrYVRVZ2hwd3hxd1I1a0xwYlRZbmFrMVlldjlVYnpTakFo?=
 =?utf-8?B?b1pvYTRqUnZSeFovUms0djNwTDRjOWp0aXVUc2hyTmU3dFpHMnFaMVJUdVli?=
 =?utf-8?B?SDYxdU1zbklFaFNnQ3JzQUhOcjFsbTkxRDQzSzNLOTM3WGdNdGlMMktFWUk2?=
 =?utf-8?B?SnIxeXRNYkVlTWh5MVRNZC9xb2U2bm9ZWEQrbmtFUFgrSjVxa0JjZjQ1SU1j?=
 =?utf-8?B?ZEMvTm5xL3Ntc1dIZzU5Tk9uR1RoeFFrbGM3RXhTd3ZLQ3Q2MEZMbXJTL3ND?=
 =?utf-8?B?S3hNY0JXcE5Nc0lvaDg2eFA2NXc2SEVWWDRhaXhXWjQ5YmVYVHpEK1F5a2pp?=
 =?utf-8?B?eXcrR2tDSGJtSC9MN0JXQjN6U3RFbmxiL2I1TTNXWE1BNFRyY2NscSt2Vkox?=
 =?utf-8?B?VDh2aWQyeDJqMXZFUEdhWjJESExnamRmeWZYdzFyRHN2V1ZQWVNoZTBKcU9W?=
 =?utf-8?B?MGhuMUk3TCtuT3dlYmZjaVhoVko2RHZ5SnQ0bFhTZnpkbmNjNVdFZmRyblVO?=
 =?utf-8?B?WjNmTVBDVGFFZjFWbmR1STlhK3p3eXJyWWdHYUtHaXR1MzZJSXpvaU9oYnM3?=
 =?utf-8?B?L2srWW96NVd4ZHJVdGVhUGJrblpEM3phSEFNUlNFVC8zeDUxRnlJN01ZNUdY?=
 =?utf-8?B?M2JmRlRCNSt4N0FJcGpPQTdYbVVWR0tUZXpCUktGNTdSVW1qZXFQSUJUWTZz?=
 =?utf-8?B?L2RDOGh0dXJWOUdCT3FLOXdlNndTSjBLbTk1R0MyZVNEdXRKdy9BdW5xMTJS?=
 =?utf-8?B?S3FVV3pIWDI0bDBJdzhoVCtqL2wvZERkbEhQS1BWdTZSZEJLdTRDdWF4bnp1?=
 =?utf-8?B?WTNySVF6YmZGVzlzMUJEN1pHL0pMNkJXQWRiUTBaQSsvWEljMUJYaXVpZlhP?=
 =?utf-8?B?RnFSdEFVVXF4dmNTMVladTl4emQxZGpRNXdxWWRmSW9IV0pvL2FwaFp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7402.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitzYjZmWnBQSEZYcWZ0dkhKNGhhWkZiUVRKcTJxZXBCQjhWVHpPMmJJSWpG?=
 =?utf-8?B?ZVM1SlBuN2M0a2M0c2lmY1BCRXM2NVl3bHBOclhNTnZheEpFamRxQ05IRlow?=
 =?utf-8?B?Q0RRQzdXL1lFbE9YckdURjNWS1VSR0N5ZG1uL0JTbkszcmlUM2xjRHRjcExO?=
 =?utf-8?B?clFyRVd5RVRpTEk5RzVrUVlXVFRFNm93U1U3V1kvMUR6Tk9LcXV4clRlVHYx?=
 =?utf-8?B?TjBHbnc4QlhvaXF0SVRYcEVjaEJwbHJiT3ZRUEEwUGdJUEljdThmbzIrN29I?=
 =?utf-8?B?TXYzRHZXWFMvZmlnRXVXeVBNVFlSZ2tKNlFlcGZtalpIWU5pWkdRVTExQm5V?=
 =?utf-8?B?RlBqZGxvS0ozTytxcXNrSnZNTW5xYWdwL050TFNXS1ZVd095akgyM2ZsSmpL?=
 =?utf-8?B?V25TeTVQUVljTW9CMnR2Z2NVMExFNnlXL1lGSnM5S3NOZkc0YURyNzF6V3ds?=
 =?utf-8?B?eGZZRW1KdzQ3MmtXcWVPWnY2TGptNEk2anpEMzloRyszenF2MER0Zk1ZRXdL?=
 =?utf-8?B?aTA2TnQ1eFR0aEYwVFFkTG5ybC9oQTlvWDVKVUdZTkw5MS90TS8xNkNtYS9W?=
 =?utf-8?B?ZEt6OUpMSFhXd0FQL2tNMS92VlFycmplbDF4ZXlRZ2xNYW8yYlRGTkRpU3VE?=
 =?utf-8?B?TC8rZU5IMUo4cGliZWM5aG1OTTdoNjJEQlhWclp6VkpsRGRKZHE5SGVhdTdj?=
 =?utf-8?B?MTdoV0lnbThHNFV2WXpIT2lYTC96ZGlRbnNVN0Z6d0pmWmVvamZPeEhzdDVB?=
 =?utf-8?B?TE50ZmkyNE1jUEowSnpqTGFXMUcvdzNzYXRhU0phbW81VEJYZkhnUG55ZGhn?=
 =?utf-8?B?eUxTM2Z5ZlROVW5iNERGMWRDYWhMd0I4WWxNN2xTWTJLUG1OVE5kV2FQdXVo?=
 =?utf-8?B?ZWptUTJHdGJLSitCaFBYT2IxaEpqTkFieklIOTdEZVFiSEMxTGEwcC9zdG9n?=
 =?utf-8?B?TlF1NFJtcFpjMVVwc1F6SmtKRnFJZWVCYkZjdUhvTXMxanNjb3F1Vk92VWFy?=
 =?utf-8?B?Ynl6ZUt2RnovVmhLOWxVSU9WSTRrNUU3ZGRGaUF6OUMxUHJacUV2QjlZTnFM?=
 =?utf-8?B?RmNwUDE3RnRlK29sMk44TGQ2S2NVb2R5a3QzWm9yMXYzN3QvK2hpOGlFdXVQ?=
 =?utf-8?B?NktFaW40V3JSVnNKSVBCV0p6dXBrTWUrT2FMQnMrSjgwRFdtK3drNlIzczBJ?=
 =?utf-8?B?WWc4dU8xODRCMG9SaVVYQUtCNFRIcXB6U1VqL3EvZmo0ZDM3ckRRSXJxaFVR?=
 =?utf-8?B?S3F2bHhwQ2QxYldBUWdIN0RwL3NoZWVRUmxvUnEvTzlWTURtQng0NktaNmFM?=
 =?utf-8?B?cW1qeDZlMTZJKzA4TGx5WFhtczA1WWkrdTBqekNxN1pjenRxT0R6Q3Vnc2hm?=
 =?utf-8?B?ODNzdzZHeXVYeEJPcWt5YktvYVRaVUY3cUFLdlNLNHloekRCQnk2cWtIUTZJ?=
 =?utf-8?B?cTZpM3NPaTU3dDIzMzNaM3k0dkM5M2RiRFhaTkxmSGE4NkNOajJ6UVg1UGVW?=
 =?utf-8?B?M3IzWDQ0RFVJUlVUQXpHZWlkZWkxZ3VtQWlZOUlaY3F2K1BHUVpjUi8xT3Vh?=
 =?utf-8?B?UXhrUTVsL2V2V0J5Z1R3bjl6eG5waU04NEZocmxxRTgrTnBIbU03U0VoS0ps?=
 =?utf-8?B?Q2trRjZCUDNmdzFKUUxHNFV1d2RCaC9GYW5VeGI3RGlmR0hZWDIzRjVnN24x?=
 =?utf-8?B?OXVEY2lVU1UyS2FlVy92MTJFT2pWcStvQ3dXZ0piMUJhWmxvVkFjUFBjVUE4?=
 =?utf-8?B?d2ozMVRodW9lNHpzRmkzSFN1cjBra0ZLdjl6SU14NWVaUy8wV0xzb0NUUGd4?=
 =?utf-8?B?dG1rMUY3WnFSVnlNRll1aVl6RUFJeG1Ob3luRXBBVjlZSGl2WHo4RWJoZWJV?=
 =?utf-8?B?VHpwYUpMbWt4M3hIeVE3ZGhSOHU1cEROU1ZUNWxWSHMwOW8wbkpETFFmQVBV?=
 =?utf-8?B?eFZoeFNrQUN5TG5zMkEvV3BPOFA1T2VUbGZlOERmSUUzV1ZTUmhnQmRGbjhX?=
 =?utf-8?B?OWloQzdzekpMWEVuOGRYYnpCK0w0aWVvVTQya2RIYnl3YU0yQWJMOGNmWm90?=
 =?utf-8?B?VkVJL0VaaHRicFpqS20rUG5OTko1ZjE2aS8velhLZHUySlp5OS9iZXlkSFRL?=
 =?utf-8?B?RmpJTkZlbjFHMmhKbWhPemVWeExJZFhmbGlHZ0NZR1BXZitsamNHWnoxMzQx?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab508ec-e522-40f1-e223-08dc7198933d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7402.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 08:58:50.2351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkHlzsaU3BQNqdUj9Co5NjPPj20AxHqf1N9cHyLD+uLfrkKazP44zOFMQZWvBXmaVLJ4kQeFIXRXVJzp1QkPqeabYdlM9p+b5+w9eJ30Tlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5228
X-Proofpoint-GUID: u50vos5AutGx8SdVSJ7Zswp-K82t92Fy
X-Proofpoint-ORIG-GUID: u50vos5AutGx8SdVSJ7Zswp-K82t92Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=785 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110066
X-Mailman-Approved-At: Sat, 11 May 2024 14:46:24 +0200
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


On 5/11/24 03:35, Jonas Karlman wrote:
> Linux kernel Documentation/devicetree/bindings/gpio/gpio.txt define the
> format of the gpio-ranges prop as:
>
>    The format is: <[pin controller phandle], [GPIO controller offset],
>                    [pin controller offset], [number of pins]>;
>
>    Example:
>
>        gpio-ranges = <&foo 0 20 10>, <&bar 10 50 20>;
>
>    This means:
>    - pins 20..29 on pin controller "foo" is mapped to GPIO line 0..9 and
>    - pins 50..69 on pin controller "bar" is mapped to GPIO line 10..29
>
> For this example, a call to pinctrl_gpio_get_pinctrl_and_offset() using
> offset 10 incorrectly return pin controller "foo" instead of "bar".
>
> Fix this by using an exclusive range check.
>
> Fixes: d0bb00adccb8 ("pinctrl: fix pinctrl_gpio_get_pinctrl_and_offset for gpio-ranges array")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Thanks for your patch.

Reviewed-by: Quanyang Wang <quanyang.wang@windriver.com>

> ---
>   drivers/pinctrl/pinctrl-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-uclass.c b/drivers/pinctrl/pinctrl-uclass.c
> index 245510a96312..6f10150b2a42 100644
> --- a/drivers/pinctrl/pinctrl-uclass.c
> +++ b/drivers/pinctrl/pinctrl-uclass.c
> @@ -210,7 +210,7 @@ pinctrl_gpio_get_pinctrl_and_offset(struct udevice *dev, unsigned offset,
>   		pfc_base = args.args[1];
>   		pfc_pins = args.args[2];
>   
> -		if (offset >= gpio_offset && offset <= gpio_offset + pfc_pins)
> +		if (offset >= gpio_offset && offset < gpio_offset + pfc_pins)
>   			break;
>   	}
>   
