Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22622C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 13:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C3082B0E;
	Mon, 19 May 2025 15:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PcJBSJQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4157382B26; Mon, 19 May 2025 15:15:09 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1621F81FEE
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 15:15:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwz8ZdazfA5me2ip35hCjl+Xnc0zPZI9DpUTbiyJ7IQNK3CXPmfKMkqZ6BVSvtdt+C1nH9nZuYMYLG/2xV+Mu+mPatLHNmLPO2+WcpOeNUHxvIYICjAwQOycrObxYdcF+bXQqVax4BV3GqpjO8vujwQo+j1LfFLWBBWVd5D2dgdSa61ou3Glj2GglzlUCIp5gAqKEYrj595RDZQMvsagt7Trz7tG8sEO1WGxxvIyZoyHK15wtnIiNOOcYcY8fCJLlY0Klj6rJlslDVbmRBGIL4Nl3cZ10h7oLtOuhZzs1QC7a9hgcEFhNf/4bqjdPVuRNT+u82YhQ5dZJFLGUB3tOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00nCFkZd0ClSF4/058Fv1cnC5ZYmhXg2qUxMD39BgGU=;
 b=bxXVebBS3UGNs1CBWe8l/A3G5ynfw/09YZaczlnJhJEL6I0Kw+BDJ+PBBrVJoGj2XPoFCaf8+n/L7CacNpW0TuDFNJwEctogPthM3U5XEyBpJQrO/6Sjaj8y8NE+i2YwRlK7ctQAQWC5sTnlq5qa6usOHhfhLxlw4ut93kBH3Drls16+3e857O6obrQP3FTImZbOekHzKZu/D8DCyG4w9dS192m1mVlVY5vfLARo/Sk62tLikrH+WLnJH+0SmxS9B7ZWah1sYLIqTlwPF3MGnmec0zprHrFp2lMvgM5b4DHCfYym2WSYB19nCh8cxOuxe9OydwRsgiveYGWjBs6TUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00nCFkZd0ClSF4/058Fv1cnC5ZYmhXg2qUxMD39BgGU=;
 b=PcJBSJQXwT8c5m+bHMdzhVMFPw0sBrLhczzWmMUOZyUtUl+9FKvlpZVW0Uf27ebBOXVd4H3xDv6AzQ4N99f4jG/VmLF9Q9VAonUuQPNgKZRKjRx+HEd/6Yf62vclUe6H4UeELrXN8D3sLJ21nMqSjFx+SffpDeZTrsccXwz6ZG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Mon, 19 May
 2025 13:15:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 13:15:05 +0000
Message-ID: <3d255a1e-5a3f-4cfe-ae0a-6736dbc49340@cherry.de>
Date: Mon, 19 May 2025 15:15:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] usb: onboard-hub: Use the ofnode to check if the
 peer-hub was probed
To: Anand Moon <linux.amoon@gmail.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-1-3cc5a06087cf@thaumatec.com>
 <CANAwSgSMJGy6hXP8++pfnqkuzH66zhn=UROK4MTs5mrdnyyhFA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CANAwSgSMJGy6hXP8++pfnqkuzH66zhn=UROK4MTs5mrdnyyhFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 286cdaa3-6afc-40df-c5ff-08dd96d72ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTZsQ0FGSFNLclFhY2JZWW9JQW1vZERnbU1CbmZ4cTNDU1JBeU8wS3BlZnc1?=
 =?utf-8?B?cjBEVHY3dDJydHBTZVppMU92dUZFWmpLeHhicnIrcll6UnpWUHJxZFZ2NnRW?=
 =?utf-8?B?NFFOK3ZNMDZ4SmlJWDJTTnpuRGRLT0NkOEg3L3M4MkJldnlGRXRwR24zZTVP?=
 =?utf-8?B?N2dZQzVmU01QN0RNeVlJL05pOFBFUmxPUzZRTGhXMVA4eVhVazBtdHhuNllC?=
 =?utf-8?B?aWdNNGk5RFNEem1MNzR6eE9QWEVlMmtBSzBpMWxHRE9XK0g3b2o4RnkrbUVy?=
 =?utf-8?B?MmV3L2xtelNqd1lpT3BOK21NRGJUVEJPRHJRRGptS1NnNVlhRVZwL1ZobFBn?=
 =?utf-8?B?SVJhRlFtdFNYeDEvenhiNHRuaEtWcXE3aWkwaVdJUGQvdWpQVGdkNWtFRjFh?=
 =?utf-8?B?YlJEdlBJWnVnZkNvVHA2YnRmUm54U3ZtN3dBRGFWemdURlNGZFNGTDRicmVH?=
 =?utf-8?B?c1JpelJ4eWxzdDJ3eCt3UDIxMUtaMm93WmcyelhXSWk4K0FjWUoxcFE0MHRs?=
 =?utf-8?B?eDR2K2F6ZjVxSGVSNWpodGlpclhUZ1BVNGE1SGF3aFBGNnZZRVRPMFlxTnh6?=
 =?utf-8?B?d3VIcXBUcTIyN0VYazJJTlVnUlZwSVJCMjdJKzBDdVR2Zjg3cWNBTG56eUpO?=
 =?utf-8?B?TVI1NHdqSko4VWtraXc5d2cwZEdqMk9idXRVcndMTXIwS1UvSlM1ZmorVU1S?=
 =?utf-8?B?d0Fnek5wV29ONndzR2g1eTlVRGRjZHhQZDRKTklPalo2ejZ5cWNmUlp4MGFK?=
 =?utf-8?B?TWpnekxYeWFlOVd2TW5DRDdJWFNUYVBISHdzUFg3K0Z1MmhzaTRUVGVhV2tu?=
 =?utf-8?B?ZUhUM0JGclRVNUVGN2ltNUw0RFRpS1BETHczYmRrS2xwU1FnRFNqSDUwVXJJ?=
 =?utf-8?B?Qmg1SVlkZ3R5ZXBIOXdUWDRuaFcwTlhtUmYycnFzZ3lVNytRMnc3T2t5bll0?=
 =?utf-8?B?RGVkWC9sQ2VtQXBPSDBkQko0NjNyU2ppZUcxemhQaGdjYVpSMDRPVStNRitN?=
 =?utf-8?B?M0QvaXNDVEo2eXF0RHdTZnJyQjEyV2NNUWg0YW9sUXFCYTA1Zk0wUVkwa2Jm?=
 =?utf-8?B?cXpSRlhTNDBvQ1NyeW5adWdoc2hHUG9QcERMYnczYWszazhpai9mM2R4MThQ?=
 =?utf-8?B?OGdjSkpGTzExNFJxUVl6NFJZVy9SMVlJZlh1UG1zMDR6cDRuMndYWTQrc0hQ?=
 =?utf-8?B?YVh6NHVaMlladVNyUFBZN20vTk9pWXBHZmY2ZjRSUENhQ095MjZhbitQVmVV?=
 =?utf-8?B?V1dpTFMxUmhKd01LQWNZZlBETDBKU3oxNU5rbnREMTdlTGtCdjlkTEg0OWp1?=
 =?utf-8?B?WWRRTmt5dFlaZmRBLytCb1FsOGtSQ1FlQXFDN1JiVGlUcmo4VWtkL0E4UVFV?=
 =?utf-8?B?NFBPMTZDeEN2Q3ZZb05UU1lFcUNCamxQeGdRSUJRK3dPOU00MHNaejB4Y1dh?=
 =?utf-8?B?UmJCbmZnOTdORDdBa0RCeGNGcmFGWkxiSEd6NmQwdVo3K0RkOHdZZFlpaGlB?=
 =?utf-8?B?NHppY0JkVER2Rms3S2RDeWJXdVNCT3VBdHNnVnRDOVQ5QUFld2F1aVdmaEp2?=
 =?utf-8?B?RlZITnA5WkhoSE1vVVk3dDNvcU1aZWJrN2FBdExpQ0hNMktFYVc2Z200c1ZT?=
 =?utf-8?B?NDBHYVIzZmFveUpwdTZ5NU53NlNSOENEblc3bGF6anZQSGxsMi81RzRtZVgx?=
 =?utf-8?B?TkxmN25zTlBJREIxb1ZGRkZEZFBQT1BXLzVGcHI1Q1NPbnJDM0RaUnRwRmJO?=
 =?utf-8?B?V3E1eXRaZDJLTW5NV2ZXT0V4UG1SeC9jRG9yZU1vTHpjVDV0blZuU29UcmJN?=
 =?utf-8?B?VDFvT2YxRmdTVGVGWDFjQ3EyQkdwM0pRdFArQ2owaVQzTzRwaUNxZWJJYWFK?=
 =?utf-8?B?cEpyWmc3NzY1K0pYWHZ0dVVHSDU4SEkwWlNQTFB5Y3ZZQWIwbE50TEVBMW1s?=
 =?utf-8?Q?sSYFoIjdjrU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1nWGdqVk9Rc3Vucy9wdG1qT2J0U0s5bDFNTHBqN0ltb09BNnpjUXoyamJq?=
 =?utf-8?B?NDMxZnVRZzVWTkVRRVMzWU1NcVBhanJKS3lDdVM4d1lFcDNaRVVZNkJRTS9Z?=
 =?utf-8?B?UjlhcnlCbHhVM0hQWmNUVG1ET1p2WWxENFZFWUMyOW5VYWJnWUhOWHFFVytN?=
 =?utf-8?B?d2RFWkpQelZHamZBdTFOcTZtdFlYdGdGMzQyRnVQMGl4Z1ZsczFRb2R2VVdJ?=
 =?utf-8?B?R2VnMWkyem9QWEhLWjdZakU5Z3BqT3lvQWVTUFBVd1E5YWQ3V2x4SmY3Q2s5?=
 =?utf-8?B?L0l1ZHlBTmoycmVaSVh2TFgzaHFmeEtLUzh1TnkyWmp4STJuekJwVWhJbDZY?=
 =?utf-8?B?dFIrZmpyUGZvOFpRRnpjVnRmMERUb1o3eTJZcmZlZDlPRmtIdm5hL21ZaWFa?=
 =?utf-8?B?eHA3TEN1Q2Nhb0FCVC84NWVTckRGSGVXUUhqWEdtV0x4Z3lUSit4NFUzbXRJ?=
 =?utf-8?B?V2ZKVUFDdWJzQ0dwQU83WHhEdCtIYWtCOUFEenEyaExGK25zak5GWHFzZEQ0?=
 =?utf-8?B?MHdzT2svc2hXdFl1eU5tRzBYR2ErWG5nSFMwSDR0T1lIai9aQUt5RXdSL1RX?=
 =?utf-8?B?enNIaUFJNS9RNzZMZ2FFN3ViS1drSmJCOU1iTSthc2ZkMHVjc3RpWlkrT0E0?=
 =?utf-8?B?Vnk0VE5yKytpSlVsZVcwVWF6V0xTNHVYL3A1Rlh4bFlyYmpKTFVQbjJrR2l5?=
 =?utf-8?B?SWs3V2IvMk0xVDNPeDI4R3BJVEtTTnkxY0piUE11Um1EbTgvTVFjUThUeTFM?=
 =?utf-8?B?Y0dsUTV6TlBXRlJ5OTcxUzRMdG95aTZRZmVuSHY4dnpUSHEyMDBxcmZiR3hW?=
 =?utf-8?B?cUFCT2lZeE03RGlXNW56QzN0Uk9RVlYzejZpSVVXdGJ2SGFiV2huYktCMGRv?=
 =?utf-8?B?ZmN2cVRJSDJrcTRUanphb2Y1bkNoczgwR05VV0RqM2w3TmxTbjRDZElUb1ZH?=
 =?utf-8?B?bEd2YWptM081UzM4a2F6ejdTN25WcGJmU0h2VEJtcGwrdEF1S3FZWGZ6NWox?=
 =?utf-8?B?RnMrSnp2R0xpeTNUclUrdkVseEpoNjhjT0ptNnB2TUtDMTBXZzg3YWhiYlkz?=
 =?utf-8?B?NWF3WXJLbWM2NDhsQ1FoOVh0WUovSFRXZUVwOFpJWm1oR3Z4QjVpbUVpSVhG?=
 =?utf-8?B?aDIyZkxwdDlza1E1VFo4cjRwdi9LaW1lUk81TGdNSmFmYkp0dXpwY01tZVJt?=
 =?utf-8?B?ajdldW9WRm5rVm9jMXMyTlEzekpiVkFoVGxDREcwSUM2TEF4NG1sYlRnZmo3?=
 =?utf-8?B?dlZjVUIyWVBTdGVTaG5xcVlhdnBKVll4WEx4d2hPWFlKdjh6VEk0djdCNWIy?=
 =?utf-8?B?bGN3c3cwaUVpYU1tSCtBeFJuNHI3QjJHbFhSQk94bHJZMmVrcUk0SW5RT0ZS?=
 =?utf-8?B?ZXFPeithbUZSMHdIRXAweTVWN0U0Y1BXekp5b2N0R2NrQ3VPNUw5SFBMRnVR?=
 =?utf-8?B?NkIyVXlmT3ExVEJBN0YwS3N5bGYzaVR6L09PdGxtYzJBOExzY1ptNlRocDBQ?=
 =?utf-8?B?ODdNZVRlVittaC82Yjdjcy9FaUlXWVNmUkxJT0IzSGZvdzluZytCSzRFNTg0?=
 =?utf-8?B?ZG9BczRjdHJVaUhBT1duMEphVERjVjkyekVEUXJZdytQTk9vRkMxVVZvcDQ4?=
 =?utf-8?B?T1hoR1pYT1RKNzBScytlVHFaM1g5d0NxeEIyUkI4b0huWExtalhzWmRYczNj?=
 =?utf-8?B?eGQrNjRYcnpwMmdEbEk3NnltVFlTOEpCY2JUTVFNdjBuNVFRK1M3SE9MdmlE?=
 =?utf-8?B?V0VKTG81QUtpYUFiYjVTaThmeEFiM2hpTVUrTnA2MmhvUlkvdnFHc0N4OGlx?=
 =?utf-8?B?b0dnWlpXZUhJc0tGc3Y4VXRZUXp1UEJjdkZqbWxVYXVVd2xhQUN5OW5veTds?=
 =?utf-8?B?U21yTFZpNFllMmwrMFdzRzNmTGw5UDNxTkordDFGSWdSWUxoRGlpdG9FVGZL?=
 =?utf-8?B?N0ZobFZsWFRNcWpIendiakFXdys4YmJUdTlGcEdpdUp3d2JuTklaL05KOXRQ?=
 =?utf-8?B?OVBYM3haKytibVJwYUROTUk3U2tBOWk5Zm84WnJMWUQxQ0NoTGhndVNoZGVk?=
 =?utf-8?B?ZEVlQlZCUjMya0d3OHlaM3U4a0tWWVVVSW5DcFBYbGd3aW5KRmpRSlBNbDE1?=
 =?utf-8?B?RlBBL2RkMjVNVTZ6ZVRkWmdhUk1hSy8wd3BhZWdRV0svL0xwajI1UEtWSTJv?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 286cdaa3-6afc-40df-c5ff-08dd96d72ba1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:15:05.2602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyNuwRIqfcF5yZh796lMJmFmE740oHGW/G5ie2yKBwpBEOBszSP3oEPLAd8Il/LP234GZg6o53aU1e92lTkzRKIJymeL8kB8YxE/lYPd7ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

Hi Anand,

On 5/19/25 2:42 PM, Anand Moon wrote:
> Hi Lukasz,
> 
> On Fri, 25 Apr 2025 at 16:32, Lukasz Czechowski
> <lukasz.czechowski@thaumatec.com> wrote:
>>
>> Currently the check in usb_onboard_hub_bind is relying on specific
>> compatible string for the Michrochip USB5744. Replace this with
>> more generic approach that will allow to add new types of devices
>> to the of_match table. Because the driver only needs to bind one
>> "half" of the hub, the peer-hub node is used to find out if it
>> was already done. In case peer-hub was bound, -ENODEV is returned.
>>
>> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>> ---
>>   common/usb_onboard_hub.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>> index 7fe62b043e6a..9f8c1a304cdf 100644
>> --- a/common/usb_onboard_hub.c
>> +++ b/common/usb_onboard_hub.c
>> @@ -9,6 +9,7 @@
>>
>>   #include <asm/gpio.h>
>>   #include <dm.h>
>> +#include <dm/device.h>
>>   #include <dm/device_compat.h>
>>   #include <i2c.h>
>>   #include <linux/delay.h>
>> @@ -179,8 +180,8 @@ err:
>>   static int usb_onboard_hub_bind(struct udevice *dev)
>>   {
>>          struct ofnode_phandle_args phandle;
>> -       const void *fdt = gd->fdt_blob;
>> -       int ret, off;
>> +       struct udevice *peerdev;
>> +       int ret;
>>
>>          ret = dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle);
>>          if (ret == -ENOENT) {
>> @@ -193,10 +194,14 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>>                  return ret;
>>          }
>>
>> -       off = ofnode_to_offset(phandle.node);
>> -       ret = fdt_node_check_compatible(fdt, off, "usb424,5744");
>> -       if (!ret)
>> +       ret = device_find_global_by_ofnode(phandle.node, &peerdev);
>> +       if (ret) {
>> +               dev_dbg(dev, "binding before peer-hub %s\n",
>> +                       ofnode_get_name(phandle.node));
>>                  return 0;
>> +       }
>> +
>> +       dev_dbg(dev, "peer-hub %s has been bound\n", peerdev->name);
>>
>>          return -ENODEV;
>>   }
>>
> 
> Thanks for your work
> 
> I'm currently trying to reorder my changes for the
> Odroid Amlogic platform on top of your patch series.
> However, I'm facing an issue where the probe is not getting called
> and it isn't working on the Odroid N2+ board. I'm struggling to identify the
> missing piece that's causing this failure. Could you share some pointers?
> 

Is the probe function never called or is the device not successfully 
probed? not the same thing :)

Looking at the device tree for the Odroid N2, it seems the onboard USB 
hub is improperly defined.
Except the compatible and peer-hub properties, **everything** else in 
both nodes need to be absolutely identical because only the first one to 
bind will be probed, and that isn't necessarily stable across reboots or 
rebuilds. So the vdd-supply need to be the same, the reset-gpios need to 
be present and the same as well.

Also, I assume phy-supply for the USB PHY would be enough for toggling 
the enable pin of the USB hub but I'm not sure if it's proper or not, 
maybe we should rather have an enable-gpios in the onboard driver too?

Finally, please also read the cover letter where we explain that the 
second patch fixes some issues when doing a `usb reset`, but that 
there's still a corner case that doesn't work: if the HW default isn't 
holding the reset line then the device may not appear when enumerating, 
because the hub will be found before the device is probed and goes 
through a reset, then the core will detect the device is removed (due to 
reset) and not probe it, so that could also be an issue here.

Cheers,
Quentin
