Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182F3CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F7488004F;
	Tue,  4 Nov 2025 16:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VQZ6FRXs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDF783623; Tue,  4 Nov 2025 16:06:45 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B3468003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fErsoVA2gJ1GYuggZNxpkXGsbCqYU4r+yInsFI4cOawkbto2WaYiHuH0BC8AwRUuKgvY5shf1HLsv8SlEWI2Cs1ZvyfIO5KEjJAE3m6FR4GuI7z4Tq2iMTrJiMf3HENaqnMsTObR7PZRjQYcXCIvcTAiX/POxCmQ8Ut14zMy50YUNwuLWjK34t88y8beBuPSjHSm178oyjOqGG14ci/MXL45kf+oJpAL7xLTPnsZP+hJ0ct2iMZ/rCMsV3LD7/PH1xZ1xFqsfZd14iDTkrLhQs1qD0oOmQQH3z445RhDppqtIyEPInKBLL5cyMPeVrUOfMkzRVS/RUUPjnpPmLt3dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=790hGHjX4eo7kVxONgLLNGcrqNbaFNeTDmfeZWBaMow=;
 b=Gx76uMbzSrlFXBWjT1Q9lLQsmn5DW515yoLU1WuMLIej/UmZDY/Ds1NRHpszW8e45iliqltKNVtBzA6MVvJqefAdnKFqxQZwrBo7wPMCYufBlGgzOlQjBgsYMsf1PnUzLirACsEpQQknwZSfJDIv9CPmhUlTu6RuwFekmS3n9COY82on0a4B+mrC0IcTgnd4tPR6dgyVuuI9huxwuwnTA+hn+XJdplv8kCPYjM0QX77uuG73ZSoW4KZJ/UWS5HckEBDzs7Lei6R8X+FvWPMQDFwCcXPAgULOZROFbBrblizZMtwCAhdTlRSbmRCiyX8q+xU0N4drcATQHVPq7Xb/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=790hGHjX4eo7kVxONgLLNGcrqNbaFNeTDmfeZWBaMow=;
 b=VQZ6FRXsdCvYBUInuN+J6+WdWEnaPKgHqO4lV2qEup1fpchmlBGmygx/VUlGh9mSowll9/oJ/hf8uLiAqDG03PbWh8VaektTeJsgBNXgwOAKNkl2GrF0k+of3ukedE83wpCFBNPHdHLEkCbWY1VIUpYBfRl+Sv0oq0/PWi+xSDtbWJEKHAls2FjB2BstkjRPhWorg8t/dyduiebRzJut36xBvSzdL94BNfKn6zAQ1+yf2Y5NKrwbXgnYu+IXqLkh7C+kX+sNvhXC/AlvX5gEC7RRqcByKLAhvLJ8d/+6QRDXGsYtTOeNIInJlhEJVO8ROgiYFFt1aAcfUEB7pL58IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA3PR04MB11204.eurprd04.prod.outlook.com (2603:10a6:102:4aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 15:06:41 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:06:41 +0000
Message-ID: <9e50d662-c494-456c-8a5f-063ccc9a7af1@oss.nxp.com>
Date: Tue, 4 Nov 2025 23:06:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add i.MX95 15x15 EVK support
To: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, uboot-imx@nxp.com,
 alice.guo@nxp.com
References: <20251013034128.1752157-1-ye.li@nxp.com>
 <CAOMZO5Bp-s0z8oObJ333BJ5Oy0mTjoenSPqPn66YzxcK5H2OMw@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5Bp-s0z8oObJ333BJ5Oy0mTjoenSPqPn66YzxcK5H2OMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA3PR04MB11204:EE_
X-MS-Office365-Filtering-Correlation-Id: f7358246-54d5-4f08-a636-08de1bb3c23c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|42112799006|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVFGSU00TjBaL3FXTHRPWVlmY21pdjJFZ1pXdEowWGRNZ3h3R0xLZXd0WklQ?=
 =?utf-8?B?V3Q5SGxvTXAzUndUbDBrYnprdXdZV080djIvWWd1YkpnUmhUZ1o0TVhGUzdT?=
 =?utf-8?B?U21pM3RyNkJPcFNyT1NBNG1QUW00K3B5UmYvNUoyTFBxNVdCL2lFWldVK0Fv?=
 =?utf-8?B?aHh2cE9WelJMY2crazM0dVFtd3dVSnZsRHBMTkxWQU82bGhSMFdhdFlweGpZ?=
 =?utf-8?B?QmcvaHFKbmo2ZkJoM1J1anM5Y0d1amV3aEV3WGQ1ZXNwVlBkSmRVTEJtRVZx?=
 =?utf-8?B?RURNNUZHa1c1blpzRDRsYUYzM1BoZmRncTVPTFlDaWJkWW9PKzNaMEplUGl0?=
 =?utf-8?B?SHIrRkh2enB2MDlUbFZ3SHM1LzlBS3Y3QVpVK2lQWXNXTDM3M3BrSnZXNjA4?=
 =?utf-8?B?OXlIR1hGVDhrWm03dndwbVZXRlRxeUYveDlHRVF1L2pWY2hjbUErLzdkVmpG?=
 =?utf-8?B?SXA0OUQ3N2ZMaWNaODhZTmg2TUNmNklqZjVpWUV2SlVEUTJYa09lZUxZdWJ0?=
 =?utf-8?B?VTBxa3owK3dZOTVoUFEvTGJRTkpmdFI1N1RTT1NCdHc0aUxqRGQ0Wk5ZbFho?=
 =?utf-8?B?bWNNdzE2ajZwM3RZV3JxMVZjQWN4cnA0ZFFRdDZsa21wNjBNVkEyVDZhRTJx?=
 =?utf-8?B?U0w2VU9vc093YVhHdjRMempPSXVTU3NVWlBTd21mZ3ViaDRTN1didVVRdncz?=
 =?utf-8?B?eTc4NGk4REM1UUlxQ0tuRTBmWTBSZzlJdEwrWTBzQVJ3RGFJeVdpQlQyV0tR?=
 =?utf-8?B?cnJPZGdkRXNidytPYzkvT29VbDJ1ZEpvYUN6MXVkZCttNjhyQWcwR1JWOTVl?=
 =?utf-8?B?MUVnN1h0MVhVTll2K3ZrbTJmZkNOMXdEVkU1Z0t5WCtDNTBEUU5pc2F6NHhE?=
 =?utf-8?B?cXNEU3F3ZGNPd240VVkrL0ttRnNkN2F0K1gwOHFkVUczWWhialRUUWtDbUI0?=
 =?utf-8?B?ZmtMMms1SDliMXZOYmRTR3h2V0lzZG9CZFlXZ2hOSVVYTW5CaTZ3YnFRbmpq?=
 =?utf-8?B?L1Z0ZzR1Lzc3NVpSc1ljSjFrejgwa0t2QnExODJNK1ZoVXY1N2xHajFhVE5u?=
 =?utf-8?B?b01CYzNDdkRYK2EzNGdyRFVROGJ4UmhBNnhoLzY0Slg0bVp5aWNiZG12WG12?=
 =?utf-8?B?VUNvcVJLNTBXZTlQR1A5a1Voa2tmN1ZYNWl2OUFvaTdjQVltVjVJcmpNR2J3?=
 =?utf-8?B?eEthQzc0OUZwSThoNWZ4bHhnSmgxYjB1dGV5a1ZYMTN2WlhCOW5HQkRVREx2?=
 =?utf-8?B?c3JRcTY4YWZZcC9Nekp3THRONkpteGliZ0s0RDY2a0dXdW9kV0RLNTZwMFAy?=
 =?utf-8?B?UDBXZjV3MGUvRTN3STNOTHZDMlVSOVU4SngxQ290SmlieUlJZmxyTmhHczdm?=
 =?utf-8?B?alBpVjdaN1dzL242aUc2WDVIUmVIQ0tCV05nMUJET3lCZUFwd3hoSWJHRXpQ?=
 =?utf-8?B?Yk11alZWTUdNY0djMGxmZXlaSXpOa0tSNUNJbHB0SitmTmtiVG00QUpoNnBy?=
 =?utf-8?B?MU01bDdhWWExd3lMcEJLYlhuTWxva1ZYa0Q4VTJ3TktQNWdPZEVBb0ViR3FX?=
 =?utf-8?B?UUNGQW9FY3FNUHQyaVYwRUt3emphN0NhcmFhNFpnQUZCNC9mOXdZeTlOSTh4?=
 =?utf-8?B?d2lPYmdRNzVuYTFqT0IvSStrVUtyUDg1MnV5SFNNUmdVUW1YZi92UW1MZWZw?=
 =?utf-8?B?RFFtSWNtb3ZyTUVISnlYUk1NOGU1bUFGWUJISG5JajJqTjBZU1dOK21FQjNw?=
 =?utf-8?B?OUcvZDlodTFkNG9yUnlSWm92S09jblh2aDhpenNPMEc1YWhDSU1CM2h2NmNW?=
 =?utf-8?B?d3ZlK1BTd1VqMmMrZzNoWC9aamVPcUVqcFdpbmdmSC83T2V3S29MbnVtc1lG?=
 =?utf-8?B?ZmlDWVRyb002eVZFNmxlS0RYQXh6bFNlQkEzSHg2dWE4ZUNTTER1M29UR2tW?=
 =?utf-8?Q?0QGXFQ9B9vDpwMSZ4h8uX+dogqfpjkit?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(42112799006)(1800799024)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3pMRlNpR2ZTbG03Nm90SzVvZHNPV0RneEpOVzRVbHBwOTZ5NUJ5UWk2TFdj?=
 =?utf-8?B?OW4vaXlGVE9LdW1ZTnIzYnl6alBjWm1jK3k3Slplamk3RHh3QStPaDJJNzd3?=
 =?utf-8?B?Mkt6TlVKanNXUnlyZGJaYVBOMzlQaDJ3RldFcFRNZWpJWFVVYjdGcGdaMWNt?=
 =?utf-8?B?aUtqMWsxNWIrSHArRDRkWUY2RXJHRDk4a1JHL1l1WlVnTGZtei9lK0xOSFZI?=
 =?utf-8?B?ODZWRlJRNW9LektjMUpDdE1LOElOc2tkSi9NcTFYY096RmloWTArdk13L1Bk?=
 =?utf-8?B?L1I4eTdzR0Q3bmZuWkQ0alUzemdHbkZWTFZSL29pSzhBYVFnQkZ6MG5NVld6?=
 =?utf-8?B?TkFqUDhhaHZnbVZ3bmFNbE4wKytIRkNDZWxpL3NiNGUzTGE0bXVoQzhWNmdS?=
 =?utf-8?B?S0FlN3lwUXdxVk92YmFOMTh5dnFFUVFaKzRDa0pqVlVBYVlnTlFsSm5OSUFt?=
 =?utf-8?B?cHI2cmxUSllBT0dMVGJiUzlhTjlYbTFCTGtSWVBoTDNPTFJvUE1tS2M2ZUZ0?=
 =?utf-8?B?RmtEL0lPYzZTUEdDTlM2WldiT2o5elpsYjFwODNhN2NzNXlOTXR3TGp1ZGFM?=
 =?utf-8?B?c2dzM2NmNXBZdWNtaFp6QnFxd2wvbmlId2RTR05aUWtSM0oySVVNdmQzNzMw?=
 =?utf-8?B?NWtYOXNWdElWTUNhQVdxM2t4Vm9ndlRtTk50dnN0NGk3UTcxV3dSbENWanpy?=
 =?utf-8?B?SEJHQk5GVjQ5MzlKU1hoT2U5WjgyeDFPZUc1YkZyKzRkbk9LMjlqdVVxY29a?=
 =?utf-8?B?R2cyVTN0SjhkTGZ1TjFtUm1oQTE4Ykdxa2JFK1dZdnlnNHpOWlRnYXljQVgy?=
 =?utf-8?B?OVhWaUw4OFkzNHVCaWJkV1F1WkNzSVRjYWtrYURlcFZncWdIV2Z2d0F0T3do?=
 =?utf-8?B?cGZ3U00vUURIa1h3cm5iL2trTFl6SldTS0xJSDFpZjRMQVkzektMZ0VhZ0lZ?=
 =?utf-8?B?ZS9KTUl3b1VBN2xYaENyRm40WHE4WlNiYlZ6dDJPYzR1eTYwYmVHMFZnUWl1?=
 =?utf-8?B?ZEM0eEFDMzRKclpiM00wUE1COFJFUTBFaG42dmE5elR4K3FwamtOdDczNEMx?=
 =?utf-8?B?WkdkRFZrYTVDRnBQeFNjcnZzSkkvbTd5RUExTnl2dDFWdEh3NEpXV2Nxb2Q1?=
 =?utf-8?B?azh4THJJOXpVYUh5bTdIamRGeTZISnlDZXBLS1UxcHpoa3dBK1FaVWUwRHl5?=
 =?utf-8?B?eG0wKy95TStwNmRROURvSWlMWUdwVm1JUjYzemRPK3AzR09RNUxTVTBoVXRF?=
 =?utf-8?B?NXVRUzRaZm4zdlVkeW1mazgzYnZMcmNhTjNmN1RTNTZYeGtHQm0zVFM3Z1Rm?=
 =?utf-8?B?YUQrRS9XOURsUTNYeTZpeng1cWMveHFjSUNyWjc3d3YvL2NkNWNTeGFoTXVo?=
 =?utf-8?B?VHhQSzYwWHVuc0NLaGZrMnNWNVhKM3pIelBtYjdvaE5Qcm52RUhrS1NzVTF4?=
 =?utf-8?B?YnlmVU5JekEzOXloRjhmS0VUYXIyTkI1SCt6ak9JdFQ1ZFc4R3lpd3ZsWDJa?=
 =?utf-8?B?emdSdHpMbFNCVldjWmJGb0tPa1JOMCtESUU5ZG9EbzN6YVcxeS9MWVBjNFND?=
 =?utf-8?B?R21oMDd6SGtZUzBSTVlhNnZzRUFXL1dtaSt4Mng1dCtLNVZBaGtxdkdyTlFa?=
 =?utf-8?B?eDJwNFM1dmtBUDFOMzRhdUo0UWlMeFNHcHBDUWpSbHdmVnRDNldCYjhTZmNW?=
 =?utf-8?B?TlFxVVEyK2p0b29MaG1oYkdMMVFaWGFYUFJaWml5aENrTW9MMDRNSjkrSWQ2?=
 =?utf-8?B?L2tDSE56TzFaakdxTDQ2bS9nZUxEYlFRRU9jc2ZqajNHS3g1Zi92VWkxZklV?=
 =?utf-8?B?d21KcEV4MzA0UGxuWFhMYmU3S21BMVdWNTNoeDlxQktWOEJ4azQ4L1JESGov?=
 =?utf-8?B?SWJnODExY3N4Zmo0eHp0a01ZYUx4NVdib0tGNWJZZUlLOU1Td3F2ejd1N1dP?=
 =?utf-8?B?YSs0UjZLOHJKem5EYVF4VjVRRHEyZktxZFo2TUFSakU0QlBES2xEZGgyZ1BD?=
 =?utf-8?B?TDhzS3NQamF6NmFmeWR2OVNGUUxSaHhNZnNVTVdqZjlMcDlaeGlnYlNqdkhQ?=
 =?utf-8?B?WVBCRE5nV1J3Q1JPV0pqUm02Zklxcmo4Rzd0NVFyTG5aWGVoQ29Ed1dvdmhQ?=
 =?utf-8?Q?yAyWpW8oJy075iyRKs07yFCQ3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7358246-54d5-4f08-a636-08de1bb3c23c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:06:40.9882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFY/1wLisYUfUU/qvn+jr52UADsVcGT1PkQJ8yQJLqAk5PeuIKFHMUDmwH5VJr7c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204
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



On 10/19/2025 4:31 AM, Fabio Estevam wrote:
> On Mon, Oct 13, 2025 at 12:41 AM Ye Li <ye.li@nxp.com> wrote:
> 
>> Ye Li (3):
>>    imx95_evk: Share the env file for both 19x19 EVK and 15x15 EVK
>>    arm: dts: imx95-15x15-evk: Add -u-boot.dtsi for SPL and binman
>>    imx95_evk: Add basic support for iMX95 15x15 EVK
> 
> This fails in CI due to the lack of a MAINTAINERS file:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1268701
> 
> WARNING: no maintainers for 'imx95_15x15_evk'
> 
> NXP folks, please ensure that you always run your series via CI.
> 
> Otherwise, it is a waste of everyone's time.

I apologize for it.
Just send v2, CI is passed.

Best regards,
Ye Li

