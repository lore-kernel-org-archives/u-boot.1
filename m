Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4872CDD548
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 16:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F053288F49;
	Wed, 18 Sep 2024 18:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SJyUOMHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38E5088F4D; Wed, 18 Sep 2024 18:59:44 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D53988F64
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 18:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfS10aSCw3NgqPfQoSkIx5KCbxRDewXpSwIzHfsYj0k3qR4SKoQrAaIosaqU/w4lRPX3sfVhIYVfC4fXm0RUPpHVrUEUhixfPSdomYdttjRQAahJrY71YPHGAkgB+KvvER0hZn5oHxWZZ0jUyjOMeqr1InijcznxnA4VW/faJcAC9UfaaJeLcvElXzpJ2+nq0FCkhiVyAXaRDxbkm0UEZl+XLcLT0Aw9w5sEjWwbDuvwRObniYv9PDWxLtr0p/59SOSa1qrF1lbrvMfRB8E+XQ2c+vu68v8A/Y0vEm1G4rvbp/lTnXBrd1wSVjpo+L5w4QIcGG3I8cWzZiaqAVHrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZtcuyef24f6FBt1tGpbrpwjatvQqYTWfGxTMPZVFWw=;
 b=VROsoViXErpH8QttEfn/co9FlI0NRmWH9WTDDmahJQlvhvOshF6hYmUc8Jdz6cDpTk6fR2QN26eeqE1yE23ycAvSslAHzVwlGvmp6eeIvZBEgdON7dVDKyPdcCtYpLnADe5ryqQhIj9JcHvau7qZdZGH8dIXQcGdzTvkDU035LMa6lx0StaAw9Qn4btTp62sWVtLgfFJHucbjnZIq3ytnnFr6HCRS7K0krDhHFFRVD05OneshRYwiLeca46OEgcCJ7sCX06xbZyeDopqxF3tS4dN/ShBcBMkWrJQbamsq7qjT9/vSQB4k2K70KF0zQ7mK8ZdvndwWEyRfAoiOdbJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZtcuyef24f6FBt1tGpbrpwjatvQqYTWfGxTMPZVFWw=;
 b=SJyUOMHuK2Xlc550i/kHEAOL9ZHePSqE8rK5Vw2WGBv2gyMmaQGEc+dHjfAwkNucQNFVnVCPPW2NlVgKvOxa5H/fbLvcNy4mklfPtcJtVQIluqJiVQ1jOb3+HSdWhxp9OI9fRbtZX/iQ7WEZt6H2NT1C/WXVAME1Mm970WinO/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10209.eurprd04.prod.outlook.com (2603:10a6:800:244::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 16:59:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Wed, 18 Sep 2024
 16:59:40 +0000
Message-ID: <376f36e2-1fa4-4fea-9af9-2c2e491cedbd@cherry.de>
Date: Wed, 18 Sep 2024 18:59:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] env: mmc: refactor mmc_offset_try_partition()
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Marek Vasut
 <marex@denx.de>, Emil Kronborg <emil.kronborg@protonmail.com>
References: <20240912134141.4143855-1-rasmus.villemoes@prevas.dk>
 <20240912134141.4143855-2-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240912134141.4143855-2-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10209:EE_
X-MS-Office365-Filtering-Correlation-Id: e02cde1e-f304-4dae-de6e-08dcd803495e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2ZOZHZoWEdjdkJnd00yK2IyV09HcjZEWE96VlBJUUl3TXpaODdjelM0cXJD?=
 =?utf-8?B?WGg5emN0WU1PWVNGT09BQkJlNDUwcDJubmpKazJTNG5RMURJam8wdTFvYlNj?=
 =?utf-8?B?emVHNUtXN1hFT1NTaTRPakd0bXJIUjEyMFpjeEsvcW44S281QldIWmNIS3JS?=
 =?utf-8?B?M3J2VVk4bnZRTzJoUVh0WkUvQ3VjODNDSWZLU1hDUmM1UGJUUVAvMVVvNVh0?=
 =?utf-8?B?N0xuMlg4TkJxMGZtaGNqcFh6cEN3UkVEdHluUERCaFk0OXRQMnlPNjNtMzY4?=
 =?utf-8?B?NVJoRXVjR1lOZkQ1a0pmbk16cVJxTmtlZXJMQVAxSFlUTTcwS2RBWTFpTEFE?=
 =?utf-8?B?SzdvbHBQTVpPeDRKY1hRdE5EUlNiVHMrYWcxYTdDSXNSZ3M3cFhLVVA4QnI5?=
 =?utf-8?B?N3ZZUlpiUzJUcXY3SHNPWjR6SThWdGFsenVyeFBBMEZmTzYzWVA3TEZQRGFp?=
 =?utf-8?B?ZzB6SEhtcUFEdkRLS0NQVG9QcFhkcEJXeUVoUGJ1d3c3N2V3TWpPMjdZNVlt?=
 =?utf-8?B?WDMwQXh3YUtucTFDU1h5L1dCMEt2azQvL245TjZ4WmFub1hRK3hUaTVlQlha?=
 =?utf-8?B?d3J3aytTOEZCeG9LT2pZbzB0K0NKSDhnMGN0SDBiSGRVR3dmN0RqK2g4WHlY?=
 =?utf-8?B?cHVva0NCamc4VkFzUW9oU1EvQkNScVhEQjQ0MlJRdnh3SXVwVmJtODRMZk5a?=
 =?utf-8?B?a2dpUkp0ZFRuaWdxUUVScUQvQkJXTU93THB6Sm84NGRkU2NwZkdDTUtzV0lz?=
 =?utf-8?B?a0tvS2dQYjd5eHVMa1VDSTJLc1RnQWR2Q0d5Z1hNUmU1VFNhVVc2WktZcFky?=
 =?utf-8?B?R3Nka0J6VThPc0cyTmx3ejBQZlo2QjlsTVMrVFY2eUZOSUZGSG1TRGNQY2E5?=
 =?utf-8?B?bGdsVTF1a0M5Q2VDSHpZTVc0NmdWY0ZFWmx2ZVBocUwraWxTY2ZoMit2VUVR?=
 =?utf-8?B?N0IvK0RFRjc1dWU0U1JSRTVYMFQxM3lFbmR6a0t3QkNYd0wvOGVnbU4vdkNr?=
 =?utf-8?B?R3MwNFhxNHNCUGduaWVPRk1ZVnN5dmREQnRyM3JHMjFyZmV3VTZ1TGtCLzVz?=
 =?utf-8?B?TkVrUUJkRkVnejdJZHo0ZkRXclpUMWU2dG9yYkVtc29nMWF6cEcvR0lNRlVD?=
 =?utf-8?B?N3lEc29PYmhGcW5ObjZaT2czUXluNUJFSkNOTWlGSWt2eVlPZjZRcUUrdndx?=
 =?utf-8?B?b3A3dmxwaHorRUV2aFVZZDc4YnhVbCs3SU90NzN2MGZFZXJCTkxGNEI1bnU2?=
 =?utf-8?B?bEtFMDY0KzdIMUdLd3M4VEViTjFYWUF4aHk4aXh5UnVVYllQaU45aVYxV2I4?=
 =?utf-8?B?bThLQzJwZEllcDhwY25JYzIrU0U2cm4xWGVDVUpXNVZvenUySmtzMGtyWng5?=
 =?utf-8?B?OGs3Q1RFbnArbmdZZUNGSURFTGFaWlplcmFSemE0V2h2RnJ5cGRhRDBHaFVa?=
 =?utf-8?B?VEdEcXJSWVBvT1JlL2dtVTlNa2JSNjlKdENCUXFCUTR6ZnVpVkFNNEtOc2wv?=
 =?utf-8?B?WTV5aEM5ZDZseC92OGpBaWlGTFZxbWR4M1lma0puak9RRGJ3bi8xY1NOSmdm?=
 =?utf-8?B?Z2hDN01HcUN1aEdjVGhaS1RXUzcrcllBL2ZMS25NZUk2Q01kUXliaFVzYzk5?=
 =?utf-8?B?N0FXKytjOXd4U1VHbURjVC9Xdno5aFYyMVNxSldtQ2t6azRJeGthNDU1eERq?=
 =?utf-8?B?K3BIajErN3hrUG52NDlIOHJKbFVyY295QzVhNEt2ZkJSd0VBUXk5MWNKSUNw?=
 =?utf-8?B?bnpmWi9HNVJOVjZGaEVQc0ZBWlQ4bFJ3WFFoNm5VaWk4cWZTdWZQMnFVaGpK?=
 =?utf-8?B?TlBTMmN5UVAvazloQlVOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGhHQjZBYXVITExPY2hiV0xJNytrYU1paHphaFpsY1k5SnY2aE9zTUIvYUwr?=
 =?utf-8?B?QlpJL1ljdE94WDM5SDZxQkpSSERSVTQwblFnelBFZGFob0UzTngySmNHZFBO?=
 =?utf-8?B?WnpuU0Q4ZlRTR0hhQmwzazNZWUYvdnJDMEZhWkpZK0FTeEZiMnFFU3M0MGNh?=
 =?utf-8?B?aFVZSWV5UExkanhDRy9xbkxTRjJpa2ZRbG1zRnI2QTkwT3pFaGg2UXl0eEtT?=
 =?utf-8?B?Qmc0OGxpM2ZZUzJWamtkVWc1UXo1blJDQ1gyVzk4QXRlWk1mMW1kUnd5aU5O?=
 =?utf-8?B?TjVsWmcwdUU5aG9lV29aOE8xNEJkbVBaRDNQOGo0YlNxdDVySzdGVHFkNWJZ?=
 =?utf-8?B?K09VcStOblYzTXNQU0N3UXpJRElnR01PV0hZZkVpWmZPcmZPeER2ODV1Vk9J?=
 =?utf-8?B?a0tPblM1VzRWY0N2emRwSXlzVGh2Qk8xY3VsVWhuNzM3Q2hkVVB6TlBmVTcy?=
 =?utf-8?B?YXhqT01VSlM0NnpLRWo0dzRWa1VJampTYXFPS3JtMDVFMUtTdlBGTENlbnUw?=
 =?utf-8?B?SkxtdUYxN05BcmtVV1ZWd0ZvSW9oYnFVTnJzZGZLVEhTZTdaYjhGbGdhVDZK?=
 =?utf-8?B?NlZRUDlTK1hoWDYycks4Sis3NzFpMlduWDZCb0pWck40aWdEdk8xaE9YK3c2?=
 =?utf-8?B?dEJMRCtHZEJOWkNhemVuZ2drVkU0bEpFVzlEMDdoM2xJU3RUZjVGbG9KWE96?=
 =?utf-8?B?akt0VVNicUFuSnl4dDVHQkJvTjVHRjJ3L2hNc3FDWXNvV21lVHVxZ3RCbDBw?=
 =?utf-8?B?ejJuMXBSakMrcHFHOHhRVnkzaER6bUxVRkpaSVFzcW1aUjVWcUNPVlZ1SEky?=
 =?utf-8?B?elVaSkNhSENzWHYvWUxJTGhGWVEwaGd1UnlqTnRqSk94ZHNONVdTMmp6VWxv?=
 =?utf-8?B?UkVRbCtRc0dQU0FSMHJDWnNLWjNKcWZWbWtscXN3R1ViVWJVS0kxYkVjSmxS?=
 =?utf-8?B?eDFFRkU3S0xReEFVOEFEK2tLdkhWUDJkWHRBWVZ0VTBxOG5RS01rNFF3UmR0?=
 =?utf-8?B?b1JxTUkrcldHVHlUaDBtQWV4UnNHVlluYW1Nb2FaMmpFdjBvQVFURW1FMVZz?=
 =?utf-8?B?Y1Q1SWZsRzJoRXh0U1FPb2NYVVZNVHZMdEJxSFJJNUlKQlUxVUhMNnY4RnR5?=
 =?utf-8?B?R1hscHFRaGw2NXM2bjFjc3U0WTNSNTJrKzY0RktRdTZyNkhmcjYzQzIramtF?=
 =?utf-8?B?OVlWRkJwOE41d0N3SmhhWUFZTEhZUjAzNjdpRWNwd0lqZVBjaElYTTlpZ0lW?=
 =?utf-8?B?ZjFSblpYMTNPV3BIcGtyUUo5U3dPc0Y5UHdiYkVYVjQ1dDFUNDJLMkZZK0pq?=
 =?utf-8?B?NWVLYjdZRTRQQVM4Zk1WNEQ3SzVleHBhZkdXNHNkZzRpTldrWjVLYjNqOVZt?=
 =?utf-8?B?a2VJTnh0d3gzSHU3ZUx4UGpJTzlCRkdsUUUyYmVOREJURkl6UHZYZVBRc2lP?=
 =?utf-8?B?SDl0b0JqQ1ZyL0pYQWV0NElpWVVGYUxzOWxUR2dYcWNoVjBVRmlsaWJrMlVR?=
 =?utf-8?B?aDhoTStIWDBkYkdDUmlLbXU2UFVtbFRBQ1kzRzJUakRYSlpWSTg3YSt2My91?=
 =?utf-8?B?N0tRL1lJNndyRCsycFZJZ1NIT0cxeGRlTEpuN2ZxVVJxT3p3cVVhYmh5bkhW?=
 =?utf-8?B?OWc0Tzc4MEQvelBiaDBYWTVmMnZhREdVMFlqVTNTTlAxdENDcVp1Zkp2S05F?=
 =?utf-8?B?SHNCTkJEaUlaMzVOaXdaWWhGVnllc2ZIQUJ4UUg4blVtUDBXdU5lV2pGVkNz?=
 =?utf-8?B?MGxiQTVYZThXMlo2QWFlenVjajlETk41a2toWXJjT1FmRDZKQWJIWnVITXoz?=
 =?utf-8?B?MGtqMWVBWFVnWi9TUVo0cVJyQ2g2N1gzSUQxL3pPZzdVOVJWWlVhSnA4Wkhj?=
 =?utf-8?B?Tk5TaUJKNmQyaE1ISCt5T3FJOGE2Y2phOG03ZmpNb0dhelN4T01OTUNla0NW?=
 =?utf-8?B?S1lNRlVVTy9wQWZ5c05hTmRMbVZVTWxBdEUxNnRIdlEvZmRNajhydDZTTm1E?=
 =?utf-8?B?akl4Z2VoaUQ5bUFDL2hmbXNsckxRY3Z4SmhWaHNQL00rYVFHM3lUY3VDS1NP?=
 =?utf-8?B?TG9ZVkFmTkU5bVpzZXN2VzRJT2M0WnF0a2QwWVBobjBCdnoxZ1hjY3VmM2Ix?=
 =?utf-8?B?MUQvSTlMRVZtbXpiS1pXTWNTUXhubEFGSXM3elZhSkdETjdwOXd3RHdjMm1z?=
 =?utf-8?Q?3Qg25Xm7PKG3IBV3us2HBuQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e02cde1e-f304-4dae-de6e-08dcd803495e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:59:40.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUg/1Srho9A1MbLMBNca8wAc9VAPkVeBZh9rxS4vULifZUjxaUpkl63ZGRddOedtCW1ZAWXuv4lIQUU1mCDqBS73p8+7kj9DbkempNy6ytY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10209
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

Hi Rasmus,

On 9/12/24 3:41 PM, Rasmus Villemoes wrote:
> In preparation for fixing the handling of a the case of redundant
> environment defined in two separate partitions with the U-Boot env
> GUID, refactor the
> 
>    for ()
>      if (str)
>        ...
>    #ifdef CONFIG_FOO
>      if (!str)
>        ..
>    #endif
> 
> to
> 
>    if (str)
>      for ()
>    else if (CONFIG_FOO && !str)
>      for ()
> 
> and put those for loops in separate functions.
> 
> No functional change intended, but I did change the direct access of
> info.type_guid into using the disk_partition_type_guid() helper, so
> that I could avoid the #ifdef and use IS_ENABLED() in the if() statement.
> 
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>   env/mmc.c | 59 ++++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 0338aa6c56a..db2d35e9bd4 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -53,11 +53,45 @@ DECLARE_GLOBAL_DATA_PTR;
>   #endif
>   
>   #if CONFIG_IS_ENABLED(OF_CONTROL)
> +
> +static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
> +				     struct disk_partition *info)
> +{
> +	int i, ret;
> +
> +	for (i = 1;; i++) {
> +		ret = part_get_info(desc, i, info);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!strncmp((const char *)info->name, str, sizeof(info->name)))
> +			return 0;
> +	}
> +}
> +
> +static int mmc_env_partition_by_guid(struct blk_desc *desc, struct disk_partition *info)
> +{
> +	const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
> +	efi_guid_t type_guid;
> +	int i, ret;
> +
> +	for (i = 1;; i++) {
> +		ret = part_get_info(desc, i, info);
> +		if (ret < 0)
> +			return ret;
> +
> +		uuid_str_to_bin(disk_partition_type_guid(info), type_guid.b, UUID_STR_FORMAT_GUID);
> +		if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
> +			return 0;
> +	}
> +}
> +
> +
>   static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
>   {
>   	struct disk_partition info;
>   	struct blk_desc *desc;
> -	int len, i, ret;
> +	int len, ret;
>   	char dev_str[4];
>   
>   	snprintf(dev_str, sizeof(dev_str), "%d", mmc_get_env_dev());
> @@ -65,24 +99,13 @@ static inline int mmc_offset_try_partition(const char *str, int copy, s64 *val)
>   	if (ret < 0)
>   		return (ret);
>   
> -	for (i = 1;;i++) {
> -		ret = part_get_info(desc, i, &info);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (str && !strncmp((const char *)info.name, str, sizeof(info.name)))
> -			break;
> -#ifdef CONFIG_PARTITION_TYPE_GUID
> -		if (!str) {
> -			const efi_guid_t env_guid = PARTITION_U_BOOT_ENVIRONMENT;
> -			efi_guid_t type_guid;
> -
> -			uuid_str_to_bin(info.type_guid, type_guid.b, UUID_STR_FORMAT_GUID);
> -			if (!memcmp(&env_guid, &type_guid, sizeof(efi_guid_t)))
> -				break;
> -		}
> -#endif
> +	if (str) {
> +		ret = mmc_env_partition_by_name(desc, str, &info);
> +	} else if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) && !str) {

nitpick: it's guaranteed that !str if reaching the else if based on the 
condition of the above if condition.

Cheers,
Quentin
