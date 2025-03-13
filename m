Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E77C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 10:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F2B810F4;
	Thu, 13 Mar 2025 11:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XXTrJ6D2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FA5810F4; Thu, 13 Mar 2025 11:36:12 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 930EE80F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 11:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfdiyBlprPGEjp7iY8DqHz64JY1hBexpFvt3XyvkpmEZXdYC9bw4CxmWOMDvQXRavJZUCslZeGCSCKzPiIAY26PdD7h+qMbGnBWRR2JNPH2G16qDOdFNryqEBtAvlZR349g4PF1j1pj+9oFIRamICFz8ykk3rEOENwURIGwX1FW/pu6Vt8d6mwBaVKphrtdeHcbqO/agDtJxCK7K9RsMB2wjm6tHYHctfeH3hC7jLL6rmSFUetkQ6OfhLfYEEoiOwKA14Bls/5H+0HG1u5cFPc285A0IBNf1pTrRFNicnU9cZV0hAweXRK26P/ZYUUoHn8wHh5HMlstnhYDKnzkypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wv67WCzeBoXdaPnYKUz6aktvIdmB2TRsXUrcILXB+Ok=;
 b=zFwh6rieEBGcbWStczDkB/TxogPoBBwM4dAwt01rWPOglzD8zk2BNHFy9FMFFUCvkB+Efvg0BpT9Kar7CsycCCtrRbG3OdHnHlXXOtpDNaitz6QZAfTWp6BTo8/U21iTqQwpMFWryE+m+mjxesVssggyssBrF2AskjZlMOIbHGGQQd0gHldPv1iXTYFpU9f8IyWLpgH8a1/zwXBJlFLG8ITLMc6gHerwwSoqG6KnpxKwAJv3duc3Rjtmo0danfCjIKlSmvuMqUVk1/3TlaDlwB8U86CvU0Hmj7ORxv2RIIzk3qaEiS6ZM4ve4VEnf4z3kpKW3WxS4Vsb+qhH/Q0o/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wv67WCzeBoXdaPnYKUz6aktvIdmB2TRsXUrcILXB+Ok=;
 b=XXTrJ6D2j8Tq6sEjqmN09QPWD9k3u2Z26QHeQo4qY995QH85gJQLuFQLXVATz0A5Fw0GI33qSDWeMsXQ0n5b3gpInhZvQo4aanLSYk3V/LajLi6zrjenEucp2RpUNVVVJsuuS0Wdm55kjQt0m+aCQeU8CJ1QD+Mi/Y8FRr3Xev0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 10:36:02 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 10:36:02 +0000
Message-ID: <9c1f674f-8309-4170-b49b-34778afb8563@cherry.de>
Date: Thu, 13 Mar 2025 11:36:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] env: mmc: fix offsets relative to the end of the
 partition
To: Michael Walle <mwalle@kernel.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Cc: u-boot@lists.denx.de
References: <20250312074019.2281884-1-mwalle@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250312074019.2281884-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e61b65-4a04-4662-c450-08dd621ada1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlJ1RDJxV0YwajJOMmRpWDBoTWRsM3p0NTlIQWFiWmhTUzhZaXpUOVhCNjhn?=
 =?utf-8?B?QU41WjlLSlhlL0tBUHN3VDhVSm5RczhXb09IOVRucEJQdUZmdkxuWXArT3RS?=
 =?utf-8?B?c3BPRmVFSWNPRk9INmdHeUxDUVFtcmpSTHhtVDIzSzh4SkhCb20rcGJreUla?=
 =?utf-8?B?Q0dRN3gzeTlvNlQ2T2lqbzc5bE4ydWNuS1NmRkhrSkpTSHlkOW52WlMxakZ0?=
 =?utf-8?B?RWl3MXpyZlNxOXowdkdVUVBGSXlQOGZub01NdjllRG5temlNOVFma3J0STl1?=
 =?utf-8?B?Z1dZMHloekJacHVXd05DUHNuZmZqdXd6UGFROFdSVExwazhONklGMFB0VGFx?=
 =?utf-8?B?OW16UmZzRjhpNnlkY1hnNUdPQ04rNUQwbGJENzBUTXZtQXNNcHA3dDFjc2E5?=
 =?utf-8?B?K0xqR0Q1UzkxWTNtZi9uSnROMnNRemRPbUh6UEdYUVV0NkhjK3pGb3M1a0pE?=
 =?utf-8?B?N0hqVWk1NnNIcmRwQWRESVdlQ09XZWF1OFZQNlRaL0VYWG5NWjNwekRLb291?=
 =?utf-8?B?dGdjdmR1MVJ4cXFSVnpDRVkxQzZpbUlzb2luZTd2SENjMXpyWkYwWWpWbHNx?=
 =?utf-8?B?Y1VqdHI1MDlLczhMTk5nUnJNUWFFbHhzMi9zR2dsZlJEMGN5M2FaTHRRa3lI?=
 =?utf-8?B?ZTBOdGhWcDM4MFRqZENDejVqaTVCVXVuKzEyZW1VNzl6TzNjNms3bTUyUisr?=
 =?utf-8?B?S1VOc0hlSk1YbzUwYjRlbVJnTXYrM3lJdTRWNWFqZU9kNW4ySHNiRzBHTTNp?=
 =?utf-8?B?NUhQUkF5djBqYWhhTTZseDJIWDI2TnY3WWl5SE4wTG1JMlhnbzIrMXhTSjRm?=
 =?utf-8?B?ZERHTnhkZnZRb1VQbGp0RXcxdTg1QWYxUzY0V3NOOHdJdUhUZ25QVkw4aTJu?=
 =?utf-8?B?OWRvcGVNaitDTUV3YmpyczhQd0tHWUJ4MHRHakE5MWx0VVVqa2pSNUZBMHJD?=
 =?utf-8?B?SUFjUnllUEk2NmVxeDJvVmcwUGczY3RDWWZSWnVudXBDdWhNU0NFR2lyS3o2?=
 =?utf-8?B?bUM5K0RGcnBNRWVHQ3JQV084VkYvdGYyN01ZSjkzc0NDRW5maG9yZDFHa1Fz?=
 =?utf-8?B?RUtaODVwdkZxWmtYaEZ1R0JPaHZiKzZUeFVNS3AyUG9NTXRJVWE2bzMxYTFI?=
 =?utf-8?B?T3FvRWxzTC9ZRDQydnRGMGZJSU01Wm9KTks1bSs0VDdUTzVXZWN2N29zRjZJ?=
 =?utf-8?B?NjNwSEc1ZUhjTTcrQW5FTTEydEthTnA1UUl2VDUyTHdkaGx5aG41U0pNOWVS?=
 =?utf-8?B?QmRRU0RUbkZyNUQ0MzRES05ENHBWd0dCaC8xZkN4a2hQSXZyclVTU1ZHZnFN?=
 =?utf-8?B?Ump0b1RoaTN1cG91R09LYjNhYndUeHJuNldxM1R4WG9lMUNFTGUzOE9ZamMy?=
 =?utf-8?B?aHNUcm1SWnNTYU5NTUZxcExoZ3ZZYnFsbkFBejlVemhBUFhTbUttdHlRSW56?=
 =?utf-8?B?dVJTUmlmMUNhTnJIaVBCWnBFbllUMWxHWkY0NE11YTFvU0EyekNibWZTSnVx?=
 =?utf-8?B?TTJmRlRhejJMSUhpV09DUjQ2bFhQNGZEQmQrdkxoL3lISXFYbmQ2UmNqT1dS?=
 =?utf-8?B?UmRjVElRa21GZk4vNzNKb2VKV05MQzFUTVhOUnYxMmlXVVR3LytHdDRLa3px?=
 =?utf-8?B?eFlBWlFDdnpHMEt6dVlOL0dMUWR2bjRSSmJxOGVjbk1qMXUzbFZBK2o0aGYw?=
 =?utf-8?B?bzh2cXR5aW1icG9GUmpMcGYwQjFjek1uNlR3TTZqN3dOOG5DeUhkVFNRT0R1?=
 =?utf-8?B?b0tiZzhlS1RhYk5IdGVPcUx3WG9iNHBubHJBbTVGMkFMbTNJQk9KbFVaTGRR?=
 =?utf-8?B?R3J1T3BUbmUycEJPOURLNVA0NUs1elJuT0ZUSG1QanBYRUdNUGNEaEgzVHNX?=
 =?utf-8?Q?0bNECdPxTPx5V?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnFwUWJZZ2xwNkJ2bXB0UERTM1Eva2QzMmJCSDVJS0NKbm44eDNWSFRsUEVt?=
 =?utf-8?B?T2VzZlVvdTdwamhiNjVPd05OTUJadlhPdnExZjV4YlpBT3A4M3ZNclRVaVNj?=
 =?utf-8?B?bGVBSHpjd0Urc2I0L0p6Ly9yNWR6MDVpR1FXMUNudDNPelhSNzZLdDVZYUJC?=
 =?utf-8?B?Y3k5c3FQZ3NDZm1XOHdUY0M3VCtkL3dML0MyaVlNVUhXc2dDRVZPR2ZmTENR?=
 =?utf-8?B?NHFnKytHRUk2WXZMc3JVWXQ0TEN3ell2NXdzR1lTS1ZJNzRBVVZjMFBYdHNK?=
 =?utf-8?B?SkM1V3FFemszQkl6TGxtNEZ1ZGlnRXUxa012V2gyY1pJNzUrQmo1c0I0RFhZ?=
 =?utf-8?B?R0dBc3FnVUI2M3V0ejNCOW13eHRqcm5OVFBieEp3QThZVUZUYWZlSFZuZXBN?=
 =?utf-8?B?SE1zWXlNbGNqTnRoZ2tDaVRUdHNxRkY1WXRyZFlDMzZyVWVod3hSeUlDSUhL?=
 =?utf-8?B?clY2MXFyWStoNUx0Z3V3bitVTWcxdGFiczNVd3p1VVlPakc2U1VlSmF1alRB?=
 =?utf-8?B?RG9FME9BdTAxSlEzY1RrNEhhdmUweWFHWC8wc2tUL3VxQ0hDaVo3MFk1cjE3?=
 =?utf-8?B?TlJOUTY4dGU2ZWlxaHorU3drcnMyZUEwZ2dYTGVJNE9zZ1d6YStGWDFKZzBy?=
 =?utf-8?B?clk2aGY5OFhZbDVENmZseVlNZ1dYNFhlc1hobjhSQ2h2WlNZQXJMZk9vbjNy?=
 =?utf-8?B?OVV3MGhreW9VVjdSL2gzcUNTNzlEckh5N3N5THJsM29YRVZSbmJ1dnFINDhy?=
 =?utf-8?B?NmN3bEtWMFUwcHlqeW1Oc3pwSW11K3FUdmdYUzV6Y0dYYlZVU3F5WllqSDhn?=
 =?utf-8?B?WVZzcXA0SWZPOXM4OWNBWFAxaE9CQU45Z0puenBxYzhNdTIvRkFoK1NsdDdp?=
 =?utf-8?B?SjN3NFEzYVdNbDNkUmljdXJpTGZlVTNyTFBFeEJ6RlFnNm16SEFoUTFaVnAw?=
 =?utf-8?B?TXlpK1l5TjdKdkFreTF3ME5nQ0NYUmkzUHJxWDFSTnYzV01NcFpzVEF3WWo1?=
 =?utf-8?B?QzJ4ZVBnNlhrYytJV29MampEREg3Q2pNSlo2NEtrdXhKdUhscnkva3lVUXlo?=
 =?utf-8?B?Uk9qbDhGQVp5QUs2c3VYVS9pcFRTYTRnbDM3QzJXY3U3OTFpdEY3YUpwOHFC?=
 =?utf-8?B?alNCbzF1cEZTajlPNFZxQnVBYmROeElmYVdPdHY1SUV6UU9rRTFicDFJNTFB?=
 =?utf-8?B?Q3owSVl6cThHcm1raTE2SG5LaE5ycEVTNE5BdERwMlFDSCtHZGZ6VGhCZFNN?=
 =?utf-8?B?blFLMDdZeDA3VjVqTlhVdHQ4V09BK2hqQXVqbkZTdGdOTWJGYWRhMHJFamJG?=
 =?utf-8?B?ZEJMek9KSnY4NENZS0lRWmVmeWFRTDVpVEFCZWNKZjJHVTZsdXEvN3ZmT3cy?=
 =?utf-8?B?K2dsdXE5RFRFR0RFeitDQ2phM1FISTNwRStHTkRqUEFCM3c0MllJd0R1ek1w?=
 =?utf-8?B?OUlxaHE3UWFJcHJMOEk5NjhkR0cvOFFGNHdjTUhmajNVaDZYZmMwREZtbjIy?=
 =?utf-8?B?RXVZYkpvRE1ZbVdhWXFHcXgrOU9tc3BqelUydFRuK1VaSTlxMSsyVmg5cnM3?=
 =?utf-8?B?Tkw0QVNmUi8yMjZFZmdnZHdWTnRNYndvU2Q1QnA3Wnp0anVMdjZpRHZnanFW?=
 =?utf-8?B?ZXJuMytQT0hSMnovcDlmeFZoS0NUYStUZHBWYm5aaEpORFRoRWk4RXkvM1Zz?=
 =?utf-8?B?NklTbmZnSUF1cEhLUkphSUl2OHBldDBvTTYvZzZ0bVVZTk51UHFDZTFSSHNT?=
 =?utf-8?B?VmY1OUprejhtQ1dkcm1KMkR3aVdNd2JSSmtlOVlWUENEL2dSTWhxeDh2MnZt?=
 =?utf-8?B?dUpITFVnbnNFLzc5QnhFL3B0NjhLNTZSc2YrYSsramJKa0hKQ2x2cG1Bb2I3?=
 =?utf-8?B?VkVWLzhqUWd3L2JpN3FMMmZOcFNCRm5YS1RKaXlTNFJIT2pGNXdwVGNsYkxh?=
 =?utf-8?B?T2xDUjdHL013eGlFOWpacVdRd25nckVnTStYdXdTVVkvbjJDc2thQ0s5bE50?=
 =?utf-8?B?aVkrb3RGMVpBT1J5cjdzaHRqYWlmK0o4Wk5RN3pvVEFwRTlacXptbFlIVFll?=
 =?utf-8?B?UlFzWGpXY1I0ZllqZUw4eGFrMkRjaEtsNXA5QnlJRnRMU2dCd3NhNSsyVFRx?=
 =?utf-8?B?QXkvOUJaaDVmVGtrY1JOb1g3aSt4SURxUUJOZEdnMExycXlZUE01VlhMU2Vs?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e61b65-4a04-4662-c450-08dd621ada1b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:36:02.5453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npGluZ3zLFmrTEt2guyMdDH8TLRKUQLm0wAT6bPSQeJigO4RJGp1D3UJB14Tr+MQDES7lKxsU2OKockc2HuAvZBThRVerIlBaJOihZbqAVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
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

Hi Michael,

On 3/12/25 8:40 AM, Michael Walle wrote:
> According to the help text, you can set negative offsets to indicated
> that the offset is relative to the end of the parition. But kconfig
> doesn't let you specify negative hex values. I think this fell through
> the cracks when converting the symbol from a '#define' to a kconfig
> option.
> 
> Introduce a new boolean kconfig option to switch on the "relative to the
> end" behavior.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
>   env/Kconfig | 42 +++++++++++++++++++++++++-----------------
>   env/mmc.c   |  8 ++++++++
>   2 files changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/env/Kconfig b/env/Kconfig
> index 4438f0b392c..49888bf700c 100644
> --- a/env/Kconfig
> +++ b/env/Kconfig
> @@ -231,14 +231,6 @@ config ENV_IS_IN_MMC
>   	  These two #defines specify the offset and size of the environment
>   	  area within the specified MMC device.
>   
> -	  If offset is positive (the usual case), it is treated as relative to
> -	  the start of the MMC partition. If offset is negative, it is treated
> -	  as relative to the end of the MMC partition. This can be useful if
> -	  your board may be fitted with different MMC devices, which have
> -	  different sizes for the MMC partitions, and you always want the
> -	  environment placed at the very end of the partition, to leave the
> -	  maximum possible space before it, to store other data.
> -
>   	  These two values are in units of bytes, but must be aligned to an
>   	  MMC sector boundary.
>   
> @@ -249,9 +241,6 @@ config ENV_IS_IN_MMC
>   	  valid backup copy in case the other copy is corrupted, e.g. due
>   	  to a power failure during a "saveenv" operation.
>   
> -	  This value may also be positive or negative; this is handled in the
> -	  same way as CONFIG_ENV_OFFSET.
> -
>   	  In case CONFIG_SYS_MMC_ENV_PART is 1 (i.e. environment in eMMC boot
>   	  partition) then setting CONFIG_ENV_OFFSET_REDUND to the same value
>   	  as CONFIG_ENV_OFFSET makes use of the second eMMC boot partition for
> @@ -592,9 +581,18 @@ config ENV_OFFSET
>   	  Offset from the start of the device (or partition).
>   
>   	  This offset may be interpreted differently depending on the chosen
> -	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=y, this offset may
> -	  be negative to indicate an offset backwards from the end of the
> -	  partition. See the relevant help messages for more details.
> +	  ENV_IS_IN_* options. See the relevant help messages for more details.
> +
> +config ENV_OFFSET_RELATIVE_END
> +	bool "Offset is relative to the end of the partition"
> +	depends on ENV_IS_IN_MMC
> +	help
> +	  Treat the environment offset as relative to the end of the MMC
> +	  partition. This can be useful if your board may be fitted with

I guess by MMC partition you meant hardware MMC partitions, as opposed 
to GPT/MBR partitions?

It's not clear from JEDEC standard if there's a word that would apply to 
the boot partitions, User Area (I think it can be split also?), RPMB, 
etc.? But if there's one, maybe use that term?

> +	  different MMC devices, which have different sizes for the MMC
> +	  partitions, and you always want the environment placed at the very end
> +	  of the partition, to leave the maximum possible space before it, to
> +	  store other data.
>   
>   config ENV_OFFSET_REDUND
>   	hex "Redundant environment offset"
> @@ -607,9 +605,19 @@ config ENV_OFFSET_REDUND
>   	  environment location.
>   
>   	  This offset may be interpreted differently depending on the chosen
> -	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=y, this offset may
> -	  be negative to indicate an offset backwards from the end of the
> -	  partition. See the relevant help messages for more details.
> +	  ENV_IS_IN_* options. See the relevant help messages for more details.
> +
> +config ENV_OFFSET_REDUND_RELATIVE_END
> +	bool "Offset is relative to the end of the partition"
> +	depends on SYS_REDUNDAND_ENVIRONMENT
> +	depends on ENV_IS_IN_MMC
> +	help
> +	  Treat the redundnat environment offset as relative to the end of the

s/redundnat/redundant/

> +	  MMC partition. This can be useful if your board may be fitted with
> +	  different MMC devices, which have different sizes for the MMC
> +	  partitions, and you always want the environment placed at the very end
> +	  of the partition, to leave the maximum possible space before it, to
> +	  store other data.
>   

Same remark as for ENV_OFFSET_RELATIVE_END.

Looks good to me otherwise!

Cheers,
Quentin
