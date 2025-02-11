Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78733C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80591800B3;
	Tue, 11 Feb 2025 11:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gao/NxQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26D7580104; Tue, 11 Feb 2025 11:15:34 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0612D80079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/lWMCpor1Uj5q/wtMGkKVuzC1eJPOeB6Jm7VTfYGRmbUaRLDSV4XZ0/Fn4Amro/8XygXIJcCetsUJxUgnO3FeoLwkpJMNyCfwCybdfnbBTgpcPRZuzUrwkrGgTBObLoxplxyKvOauhNBwWrT2t/hbHenRWw9aT+pQMk8zEeE6zYfhz8bYVtHJ/Ll231RL8gUPmLzVcpOTwUTB/rRMSU1R+s2t0VcoSc1YNiQxnyXpVnw4yvlJZHBneHPzD6A9HdygxxsQxWlBxn4+kb4lDes69kGscpMbRoeOuw8kH1GpSuyuDbVKtO0FchLnG9zWeOY9ueeEzv4Rv1QbUJSlNlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEss6M932ku0+x1LPFc4yiPXT2ZX31vN4pidxn5XqCI=;
 b=YsziOtGmWmywsS3a9Un2T/a2+fKxCKVjO2PyqqCtQzAZF2DXl3C0s5lzHazKEjwAgJeS4i38zy3ySHPGH/ytNg2jeEAAbjRxOQRiNT4uRqOCoiaENOHus0cFRpGbAWy/ZtwyjlNJ+ZhqT5X7NM6u4m4LXtWCQwv1VQXqT5s0HjzUXhTQAbkQfbxdQTaVTehmKoViyGxCp0lBguFqHcTgF6RlsxlOTpzifcQGekeRb3iDe4ogz5WpUmFWxKV7Ljd7uZOCjcCuCblnkTlt0e/KYJVzH6RxQHDUcTS6hHjPK8dz6RF3M43AXn9X+hLWeU7wh4oCQSAxLfgcPdryADP9Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEss6M932ku0+x1LPFc4yiPXT2ZX31vN4pidxn5XqCI=;
 b=gao/NxQ9odJiywKQMl9KAAnRaqci2ckruKORPMN87EBZCCkYDP97ZrGxQpDnoru+aK+v3Y6MddW3+tBe/nbKrdVDFSxh3HswpK/hF9yeBy8GDciNYtkU1KBGCoc3wwT6PBHkeVlE32A7KnQ0iQLXGSjd95QEnw17FOwuOc3IhIxp5hsaJN8llZ1UVF4+CDQr8XRN7jt623Kg6I4vSxqHBsLANEv5O4Q3AXIiCTUBgapjNO7uGTxpwNVLvGHkmpylUz+8K78EfT+nF/02evTGiNxSXm3zcWgxABWHZQNo2jQDmJ0FMr9+UWfd9NF4fE0gUe87dnF6fePlYnGgwpQHSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1333.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:3ce::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 10:15:30 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 10:15:30 +0000
Message-ID: <3d62bff6-125f-4f1e-ac4e-506412a96aee@phytec.de>
Date: Tue, 11 Feb 2025 17:15:22 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arch: arm: dts: k3-am625-phycore-som-binman: Add
 custMpk to overlays
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: nm@ti.com, n-francis@ti.com, d-gole@ti.com, upstream@lists.phytec.de
References: <20250211064205.45087-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250211064205.45087-1-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1P15301CA0061.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::17) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1333:EE_
X-MS-Office365-Filtering-Correlation-Id: 535abe53-731c-4a3c-15fa-08dd4a8502c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vy9oUHg0UVVFYy91YVB4ZWZCamdEK0dYOFdKbFdQWFh0SnRzUGxsamQwazJQ?=
 =?utf-8?B?cDRQaVB2V28vRGFnaklnTUJQcE9yU256eithSjA5MnVFc1NjUVd0ZzU4YzRv?=
 =?utf-8?B?aFF6M0grd08vS1JiZmtNQU5kUUJ2MWcrQTVkS0lIL28vRmRyRDFvajBRZUlB?=
 =?utf-8?B?ZitzTDdiNm1NOTlQS2MwWGZyUXNKWGJUM2tMaHUveGpRYmVJYmtpeVRkcXcz?=
 =?utf-8?B?SWNFYVQwNzQxOGZHUU5NZk4xME5BQkZyRFdGRWxCa25wMXNRV09NSkFwcm81?=
 =?utf-8?B?elgzVWxkNXI4RTg2M1ovYzlieXd0YjVaNXlPU2c3WTgwRnZ5MmlTNXdkQ1cw?=
 =?utf-8?B?a2NJVThnbUlNbVREOWFJRmpNbWUrMmJVZDAwK3Jkc3lUN2o4NTVqYkwxZDNK?=
 =?utf-8?B?MUNDa0lkVjdjZEZCOGl0cWVDdHFpKzh6anRydFZINDVhR2J0S2VaaTJwOHVS?=
 =?utf-8?B?MzgyVDNIaDBhMXcyT0FpY013S01EWExmVTk0MFM1VXBEWmZYdXBCUkJmTDVy?=
 =?utf-8?B?UDh3dHRQc1lsdHMyUFdJM0pOREl5WW4yd0VBQmI1eUdWdVAwRXZVY2NqUnBl?=
 =?utf-8?B?bE5XS0k5UGJDaUxCRjROYTNnL2ZXV3VaNDY2Sk5aR2dZcUtQYVRzZGhVbWF0?=
 =?utf-8?B?SnJBQW5uOERUVzVyQnpvUTIxVi8xVDgvNVpBTVY0eSsydVZPaFpZSElmTUNL?=
 =?utf-8?B?R3g3WkxjQi9JNXUzREpzUCs1QktIeGNRWkxnQmpRZWdLaDlFUkNUZ0xTR3lW?=
 =?utf-8?B?WWhHY0lZT3orRDdRenFKRGxIczhMamhnY2oyNFVPUFBGbk4rQit1MjJrWXNw?=
 =?utf-8?B?THYvOVp0ZklHbG5BTGJscG4zZkZGSW9nK29iMlZJSWNxTHM2K21EbE53QUZR?=
 =?utf-8?B?U01GT2VCODVlamVTTkk0RXA4aXlKNHJhOG9MdUFFWVArbjQzYitkWUc1LzVs?=
 =?utf-8?B?alNpOGk4U0R4N25IN2VqcFRVckpnRjRyM08wYWJYZlVPL2FLbmp4bk9PUGgr?=
 =?utf-8?B?b0gzQnBQOC9OUE80eDA2N04zbTI3ME5TbkJEa3J3WElsZ1B2MzgwczRZdWxL?=
 =?utf-8?B?ckhOVnlTTXhWaWtKdC9vK0JvTVVBNWZWUUdCc0xsUlBiblVRZnJmZjVJRlA2?=
 =?utf-8?B?WlhadDZZREJUY1kwMmRCU1BrZlMyQlNMNDhZaGpRL002UUhTWllKY3N6TXFZ?=
 =?utf-8?B?MndCMENSWmpGZEdLc3d3cUpJeEpxZzdacTIreXAzMTQxM2NHNXRxTlV5Y1pn?=
 =?utf-8?B?OEN4UFhSMTdtajV1SDdQWGgvcmRiOGE2R2dRbWhyVG93UG00cFhiRFJtRUQv?=
 =?utf-8?B?NVdVZTR4bWNhN1JkU2dUMjdneDN3enF2VklUM21CcDJPVk16T2srcDBmeTlm?=
 =?utf-8?B?b0lkTEhUMldFekxMdkkwU291Z2VTUzZiRW5aengyMnZuemZyZ0NyN0JIWVpn?=
 =?utf-8?B?WXhRQ0hyQmNiQk5OZmJuMlVaS1JObUFoWmJ2TFlrZHJlUlg2QmdMaTRIUVpo?=
 =?utf-8?B?Q095aE1yN0JFNU5OeTRBNWg1bkhNZjlRcVFvZGVpNWlMbGo5ekJ3UmVkb3k5?=
 =?utf-8?B?d3pORE9QUjlpYkkxMDZ2Y0JJL05vUDFpaW82WEthVlpEVmhvNDNGc2c5aDk0?=
 =?utf-8?B?TUdxczZaUlpEQXpNUkhLRnlzZXJGcFd6RElxdGFjVlpQVmtIUDNkTk1oMVE2?=
 =?utf-8?B?Q3FBdnlnQXgzM01UT3JDR1NMZGE2cGxwc29NdGRmWktCSmpqZ0JvUkZ5Ulgv?=
 =?utf-8?B?SS9MTUVDUS9xbEE4czNaN0lUTUVLRlRVc1ZCZVN5d2Uxdm1BNEgxVmN6Q3NQ?=
 =?utf-8?B?VjBWdzlLLzBub1hYbXZZNHJOU3NvQXo4WkRDNThwSzFBaHBHVDFHRjA4R3c5?=
 =?utf-8?Q?gqyTX46zV7OZD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTBkQ2FaeWdlL2pWWHZCendGK05odFpjTHdoVDVtbGhOSUxZZVNDOS9qaFJK?=
 =?utf-8?B?RHU0VTErcjZXcWU3S0p4ejY0aFE2Tkw4VUp1d3pKTzRXYVJnUENoMDNpN0dl?=
 =?utf-8?B?YTZmODM2R0JpQWVzVlh4MHZ4bENrOXJGcXIvRVNsMXVwSTVaMmlNOHhpRU5Y?=
 =?utf-8?B?c29aQWhhVnM3Q09DMFQ1Tk94WFRPQXphZXArVzM3bTFjWXRUTThVSTBaaHY4?=
 =?utf-8?B?amJFOWJGVXdQZyt0UzU1OE80eC9rcmVleDRLLzRjM3c2RTRpWDNsRjRBVG1s?=
 =?utf-8?B?TXFwbnB4eVdISTFtZnBDN0lCUmxsOG5VeTI0eW1sNkRrcFZHTGdRUlNXdzMx?=
 =?utf-8?B?bzFqNnRlVkRYUmpIRTdLNkZaZjZYRjIxVm5rZ25rUkZ2V0lZeG0yT0kzQjdC?=
 =?utf-8?B?U2JKMnNkSWdCTWFLcTJOeXhnQmRrOVhsYytCbkRlSnpVV21zN212WlAwT25D?=
 =?utf-8?B?eUNsQ1k5R1lQdzg4TExTM1JhSzhkMm1yRTdFKyttWnBkM0JDUThwalhGaUlq?=
 =?utf-8?B?bGpYbW9wK3NBdWtYT09YY2xjbE5KY2FaaWMzSzlxZjhKYldsWHU5ZnhJVGJT?=
 =?utf-8?B?UmlmQW1kY1BpQ0EzeVhQN3hIa0tuWExvc3R0VTFDam1RRkQrVzFBSHQ2SEhs?=
 =?utf-8?B?STd0ZnpjSUF5VEVsOFQvYysvQjhsMDVNSi9YeWc3ZERUUjUvbllwYTRHQzRL?=
 =?utf-8?B?M3hWOHcxRE9CUDFRM0R0ekpEVUoyM1lnQTRrUnUrYzRQakIrVnNINWlrb3RN?=
 =?utf-8?B?Wlkxb3lrc2IwSlQ0a3hJdlVoUGNNV1JhRTBlakNNU01zc3VHNjNKaGpNSzlE?=
 =?utf-8?B?Zk1mc0hKdk9aYVNadFplTlNDcUd3ajV2MVNkYStoaG1VQTRUYjZPbkh1MnJG?=
 =?utf-8?B?cDJDdVhwVDlINnhERFFyUnJuSGxTNTBkakRVY0d4WXc1YUtqK2dqUGNwdVQ1?=
 =?utf-8?B?TjVXNkZJWjk0SWRyTW9Ib3JQazVEVUwxb3ZFY3ByVDB1RHN4a1gzd2pLMVhU?=
 =?utf-8?B?czhKeXRBV2pZS1ZXSjYwMmtWTnVZdVFRb3p3aFk1NFNPcnRPbVB2UHNVOG5i?=
 =?utf-8?B?TUVQRk5OS2tXWjhjTUxkNGE1L0RvSWZKa2poZWVWUUM1VU1DZTVDVGNMQXEx?=
 =?utf-8?B?L2dDZ0tGUTQxVXB4OEQrQTdVUjlqR2tkTmVtcEUveitIYVB1c0RvZFlUdnJW?=
 =?utf-8?B?V2xBWCt6TFNWcXBWWjlJWUpxT2pFdVRON1Zzd3pIZ2pZSUk2MU5VT0dVOWFB?=
 =?utf-8?B?S25GMEhxRElvb2xySkg1aStCeHhudG9ZOWhrZmpOcXk2OHR2YzFWazVPU2Zj?=
 =?utf-8?B?em9NeFdCcFk0YVc2RisxTkg5QjlmQkc5ZVVkTnltb1JSa3BRdmpvVnAxVmJk?=
 =?utf-8?B?QVUvaWZNMnlaNTBDYVlRM1BuK1k1V1hVWnhJckJuS3NNSmY4ZnlFRVRKZ20v?=
 =?utf-8?B?dThRNjNNUUxUMS9jQWdNLzl4M080TWV0MHl3MGM2SXhjT0djZURlQUtEVDVy?=
 =?utf-8?B?WXJtZk9ydXlWQkVLMzJwN3A2RE5YdmtpNW81eG0vWHh5aVFFbkxVb1NBNHZs?=
 =?utf-8?B?UEZDSFoyaXlKYlR4Qk5WSGV2TlJOTzRtbmFYb2FaSisxQUp2RGxnU0xZcXJ3?=
 =?utf-8?B?THJVUlNBYWNyclp4eTBJTlRMd1NOTHdmNjA0dDVsTCtQYkhOOGc5QWJsZkNl?=
 =?utf-8?B?dmZEdE5xZFFyb0FTOVFsNHAxZGJRQ293czdkS1UxRGpHYVFQSm1IYUx3azV5?=
 =?utf-8?B?SE0zN0tWSHhSN0Zldmh5RXpuSlpRaEhFb1hOZjEvbUhuYzcyN3FrL2theG5Y?=
 =?utf-8?B?S3NZd2xKS0g2NDFydXJsYzhHZnIwY052bWszZk5wMGxJVVRQZUpYV2kwZGcz?=
 =?utf-8?B?bUVzTTJEVlloMGlBTW9rbG1CcEhpQUcvclBlaUkvcTVIZE5NTFdHN20raTBW?=
 =?utf-8?B?eC9ZNHlRWUtvTFhQak9KQ1ExVHk5dHgrMjI3TDNlYTlsWjh3UHVWcTZFU2Fa?=
 =?utf-8?B?M0ZGbDdEMmtKdnpZUVRzbC9CVkcxMWhFem16L0lIaGhlUnZlUHlheHNUSkVl?=
 =?utf-8?B?bHRGNFpNVHM5QU92b1N2cEtxTVY3dHJKOElTSXFwNEFENXJKRjRaZGEwNFdC?=
 =?utf-8?Q?dpIrJXpsvwvaBj0lye/BsmNWl?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 535abe53-731c-4a3c-15fa-08dd4a8502c2
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:15:29.9962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhWxK3eWOWUSkIWNQ9VecbaRW6DHTAVhZZW5iB7gDFKjLEtiY9jzWthfyox6juSzLqOAXLVG0KZ7d0hFHm5YLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1333
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

Am 11.02.25 um 13:42 schrieb Daniel Schultz:
> There are some device-tree overlays with missing entries for the
> keyfile. Add them to sign all images in the U-Boot FIT image.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
> Changes:
>    v2: Removed keyfile definitions which are already defined in k3-binman.dtsi
> 
>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 28 +++++++++++++------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index 31456d23167..4a65427e877 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -321,8 +321,11 @@
>   					compression = "none";
>   					load = <0x8F000000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_rtc_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_rtc_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-rtc.dtbo";
>   					};
>   				};
> @@ -333,8 +336,11 @@
>   					compression = "none";
>   					load = <0x8F001000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_spi_not_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_spi_not_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-spi-nor.dtbo";
>   					};
>   				};
> @@ -345,8 +351,11 @@
>   					compression = "none";
>   					load = <0x8F002000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_eth_phy_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_eth_phy_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-disable-eth-phy.dtbo";
>   					};
>   				};
> @@ -357,8 +366,11 @@
>   					compression = "none";
>   					load = <0x8F003000>;
>   					arch = "arm";
> -
> -					blob-ext {
> +					ti-secure {
> +						content = <&am6xx_phycore_disable_qspi_nor_dtbo>;
> +						keyfile = "custMpk.pem";
> +					};
> +					am6xx_phycore_disable_qspi_nor_dtbo: blob-ext {
>   						filename = "dts/upstream/src/arm64/ti/k3-am6xx-phycore-qspi-nor.dtbo";
>   					};
>   				};

