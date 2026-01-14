Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3786D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2F78063E;
	Wed, 14 Jan 2026 16:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="LngU8MZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB4F808AF; Wed, 14 Jan 2026 16:05:35 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF07C80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb6v6fxSzCNLLxJepNQunUsk9H921uKAnzHjwK0deinBia+5qCME4JuMQ0Flt4fCY8IGzkdVoXjMbTamQYlCEPabwzUrQsNpBQG8ohFzcLUO9XwXTDYwmQwrH5/7TDFiED0diLMcDXIkmym1xMJCWg7QOh8PyCAoQRSSdbrUYa+OeZH9Vt0LaUMV1Xc8pm1eVFbWZ/G4EY81OmshRXLy2uWtFJkDz2onKQXjnU+XLc/TDcctXPGbtwDiXS0tB0j2Pxrm9f/Ba0f1t6JKop6OfCY6k71OtuWvfUzrCCe+MeiQiw5j2WbHROunF2EhVZkWGHucS47mKmcP0KZ7eqJV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z9xs/+aKiJ3qnQtUKeR96ObTbPCPUxDIjl9ncZG5KM=;
 b=DH6ojs9QKCbxDOj3B4EgW7Zmn4FNONUGAHL6LzILMMr659i0J6pDIcqORRO+wuE2OggKMKDauUNaDTJmUt6V1ZMI1zOeYr82MUSdLJPXFdHU5yailIV4oTvj/ohyyWTBqIwGip9D9j5LrlQ0E8PvN3NdNulfsxZ7EUAAz3Tf7pIoGWoOe8x1XhGFMNGPig4PhYIezEgFsxMsGLUii5hN1RfHgbBNW32JnTiz3VRKl3AbjTEqYeqyAvzmvl+cWq+J5cApBBwbfaczhf616L/R7OdyWgC2xmwO0IFZZ1FMzcMgjAx/J2GshmNws1Uf6d7ByPeQ4Z2/uL3MZTrunejabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z9xs/+aKiJ3qnQtUKeR96ObTbPCPUxDIjl9ncZG5KM=;
 b=LngU8MZjZp9ziNmt5dk4ZO30JLlvY3CtIH65n+BpSDL+CP2QK4B6HiV1jWXuNPda2jS1go9TnAImCQp1v57B560mjeUb8J5IlZLZM3lFCsqSKP4QPtFd1GDSgirMGvMQs2mcDos99MbVWjaWjAYYyGFpaf+thulsnFetTv6v2go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:05:32 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 15:05:31 +0000
Message-ID: <91c5e702-d57a-4e1f-b634-252848f2b95b@cherry.de>
Date: Wed, 14 Jan 2026 16:05:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd/Kconfig: fix type in CMD_PINMUX description
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
References: <20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260106-fix-typo-in-cmd-pinmux-desc-v1-1-1798f6690589@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::10) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|AS8PR04MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab5f865-ca3c-4e3a-3381-08de537e5ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTlPVTE5ZXVtMjNzaW5tQVFZanZQQTgvTlNRcTZTc3VXSmM0MUdHYnVaNUUw?=
 =?utf-8?B?aGphQVFPcHlPWlBFWVlrUVIrcThRK283VllTc3lTa0lQTUl6VGNpYXZNQjFt?=
 =?utf-8?B?REVFeUZyUnNoZDlEUHJ6TEZNQXlNOE5wQm0xMjJCdytXS09ib1pYc2NwMHI4?=
 =?utf-8?B?eXZUdFo1aExwRkpaNVdJMXYzS3dnSWtNZDNBMDM2ak13NlNWZldTd2FNSExV?=
 =?utf-8?B?NDlzV2tuZnl3Y2x4czJaZHlLWlFBTHdxVDdWeVVCSFNEbEZES2loUlRDZEcr?=
 =?utf-8?B?ZHhzVlhEZWc4V2h5enEvUUc0N1Q4dUZMOHZCVTZka3VxSTRNVkozbDRZdzJP?=
 =?utf-8?B?QUhVTEZMTkQ5T3RxV0d0ckpQNVdSNE9ZR0hKK1RuNWJxZ1MrcHVIQjh6R1Ix?=
 =?utf-8?B?aVBaSmJXanFGRUhFQk8wc3NmWVdDbkZPT0FCZEdqKzVFdnh4V3ptSFEzYXl4?=
 =?utf-8?B?UHZyZGF3T2kva3VPNjVzZHRhSU40dmtSUXRGbklqWU1vUVptRFlLMG9iV0RY?=
 =?utf-8?B?emthZlQ4QzJuRDhSbXZ5cWRjcFR3ZTgrdHhacDhacU4zaE85bEJuWitaMFFt?=
 =?utf-8?B?N0dWVXgyaU91azJycTk4UVNML2sxR1kyZnUvR2VBb2tzZmhScERUQUc0R3Bx?=
 =?utf-8?B?akM2UjBmcHc2OEFPNklhY1Z1Q3dMb01VSnAyMFdEYzBwYS9EVnNTS3pJUkIv?=
 =?utf-8?B?WWxWYnUxcVlpZUV2cFRuenRiNGx2RndsRVJsOEVGSVRiZ2U3U3RJQ1pkRHNR?=
 =?utf-8?B?SXRKaWRhSndYc1VjNDUvZXk4K1BVTjBZVlh0YkNtSE8yTUVIbFJuZG1uNnhy?=
 =?utf-8?B?YUk5bTFmcVhQa1pSR29BMEhyaGhSaDFMYzh1QU16WXdLdytKd2ZJVlNKckFm?=
 =?utf-8?B?Zmh3cDc1czdrbzBNMi94T01KTXNmMUdFR0RZYnNha051NmRuelpOWVQxWTJE?=
 =?utf-8?B?WXRhaVM4ODNvZHA3TVBQenExSmNrVmJmeFFWUGNJSjltQWtURE1ob0RpSlY0?=
 =?utf-8?B?dWdXUEJRYTN1ejhHZWR0RmNIQ2FOV1lnWmVNYnBUVnB1QWcxa2FwWmpaQjAv?=
 =?utf-8?B?UzhjN3FOcUhyejJrZm95cFdSdzZ5WEFJaXc0eHliTHg3QkdXcVp6YVE5TEE1?=
 =?utf-8?B?T3BDanFtN1RpekdrcXVudUxsQ2w2QWRkeVk1VXUrcVhIQmN1OU9aTExmcnA5?=
 =?utf-8?B?VStwRTl3cFZ4N3czb2ZSTk52WTBaamRFVE5ZK0pDQ2NSUmxsREh4WkllMjZR?=
 =?utf-8?B?UC9rTUVTVVhNU2tHMlFrZzBqMVlOQXBFbG5UalpVMVVyamVHZmhmMXYzdUQ1?=
 =?utf-8?B?ODBZOWFUTENiNklOcUtsazZYMTF4bTZ6Q2pDNHBhcHdDQ3puWTRJTTBLRVA5?=
 =?utf-8?B?UlNqaXl0YlpNZzk2ZTV1R3Q0eHZUWjRQTGttQUFIQ3ZtTkkrSHN1UFpmcG1V?=
 =?utf-8?B?ODVRTG1hTFljeE92L3ZkWWZBdTY1aStXQSszSWxJdHBQU0phSzkyL21rSWIw?=
 =?utf-8?B?Q1d1c1NaVVI5TWlpckh6b0Z6NU4xVGZWNmJ6ajZ4MUs3MUdMSTdqZ00zcXhV?=
 =?utf-8?B?QVlTbU9XZjR5eFUvNlNSREVQcGxvVzZqRFFtNG9KMXVxd2M5QzNFZEQrYmg1?=
 =?utf-8?B?UEpjRloyeXQwTGovZlpFWnk5RFFXSko2ZWZGcnhxTlYwb05tdFVhN3d1RTF2?=
 =?utf-8?B?WkYyTm9PTjM4aWdVQThWL2FJZzY1WFEvYXpQYU5OM1ZBMVJibFh1NWpKSURB?=
 =?utf-8?B?TVNCckQyV2E3aUZnZ21xNXA0MUQ1VjkxQ3hzNmdIbVdiM3Yrb3N5MW5iOW9a?=
 =?utf-8?B?aG9ZdDI2eWE2NlRjM3N0ZElpZUZlK2VKWE90ZXlZT29nb1NRMzYvZmJwM0tP?=
 =?utf-8?B?UUxra1VlWHdDQ0M3Tzg3aTF1K1MwRXB1bDJyRFhhSC9kbC84TDM0ajlGYUhD?=
 =?utf-8?B?a3dwTDhWdXZOdmhNRFdOSkhtMi96c3l4VjJqR1hKS1RMald2QlIzV0xHTHJS?=
 =?utf-8?B?ZEV1aVlSV0xiMi9ZTk1vL1htM1l3Skt1ME5LV25HczlaWXJGQno1cDhmaEF3?=
 =?utf-8?B?eXlabXJvaXN3d25sT3VIeXd5L2ludHlNZ0F6SGZrUzJZMEkvSzQ3UDEzMm9n?=
 =?utf-8?Q?PESY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3N4NWVJS0o3eG9BOWczekdjMWUzV25XWmVWSXNZUEhIbUtQOUdNT0tPQnUv?=
 =?utf-8?B?eHJyd3ZqUzZLTmRWb00xN0xvMThkREdkQ0tqYW1VTVorbGxGNFd4OE1Zb2Q5?=
 =?utf-8?B?bHFoOGFnNTdGbDRldFpkamhsQlZYZUhuLzB1NzRoM2xYWUNUUGVWSmhMVkh6?=
 =?utf-8?B?RUxEajU5SisrbERRWVN1cnlYaWwrUHhDWjUyK09zamR5WlM1d3pBazdyZkhv?=
 =?utf-8?B?Tk1BK3hMRzFUQWRoZkUrSUdsUDdmVmNERjQ0SmNVMWx5UTVpc1hyUFlUaHVQ?=
 =?utf-8?B?Nm1BenJiMTBjdGlqc3JwNzdxbmZUaFhNRGUyMGhSLzIxSE1FMm1OY1RGbnJJ?=
 =?utf-8?B?b1o3T0dMa09FVkt5Q1UrV0dTL2ZkakVDeURDRW5wZmY4TEVJWVpVWVhtNTh2?=
 =?utf-8?B?cnlGbkRmdnJ1VTQ2S29wV3YyRUx1ZzJ6NktjM0xnNHZEUkh6N1NTT1g5TmN0?=
 =?utf-8?B?NkZ2OERyWC9DdkF1cUQrT1JHRmkzMDdSaGlqWnJWNnBVZjVXR3VpdnVLNDg2?=
 =?utf-8?B?dTl0elB3Qk5rUG11dVQzc2RhSVd5dEZyc1RyZXczQlpxd2tDQVdFS0cycE5m?=
 =?utf-8?B?cEtianpvQVp0UXZyQ2VjTURVY1hiZnFna3RhTGo1ZTd3WjZzajUxcmo2NStp?=
 =?utf-8?B?R0lQRkE5ZUJJYjVrZXE2dFZzRXhRRlNTalVFWWVBNDNoMDI2K0tCV3FadzFJ?=
 =?utf-8?B?MElYbVRQRXNUejNnNzhUQnl3eDBDUmpmV2RjYmZ3S2pQaVF2MFc3NlBkWmRx?=
 =?utf-8?B?dGJHcGd6eEcxVnNnZXJ3UXRTbFpNcnROUUhEbWFyT25nVEVtZ1JaYlVRUldW?=
 =?utf-8?B?QnFqa0hDbC9TcE1KazVIZ1c3ZTRTbW9iRi95am8vRVdmVW1xcUpWLy83UE9W?=
 =?utf-8?B?TDdjcldXdTBiYWZYK2hxU29pZHA0TnVSaTBaYmZ6UVJxMW91QzNtdzZLeDJX?=
 =?utf-8?B?Zy82TnExRHJyMnpvMWRhYWVVZFU2Y1Bmb3ZlNFp0QVpDRXRPOWFSbno1RC84?=
 =?utf-8?B?Ums5T29tdW8xZnhTdEJnRUU3L1UybEtBTUdGMlY0dmsrOUZoSjkxVGtvK1JF?=
 =?utf-8?B?MFBac25adFdFS1J4cGJiaUZLM0ZiL0JNWExsKzR0UnZ4RTFVaEEvOFh2VFNu?=
 =?utf-8?B?OElSdS9UbzZQMEhtY2VxekVIeXdDbjM2TTFYMDdpd3hIcnA5MkxZYUpMbWhF?=
 =?utf-8?B?NGxVOHk0bWhKZGY2QU1iSU9BU0lGY3MrUEU2YjBsOTlxZXk2R2l1RUtFN1dR?=
 =?utf-8?B?OVdUQUExUm1oOTFVcXVrektHOVBUdEs3dllZYmRCS2lSOWp1VnBDS3ZJUFN2?=
 =?utf-8?B?OG9WdU0zYzdUT1pZbmlmRG45RkZCYU9kQXoxSWlHM2dZRExvQ3ZVb1NLVlB1?=
 =?utf-8?B?SmFnc2xSQnh2VjRkTXNhVURmZG4reUw1TmpFNEZ6R0lGMmZSWEthaUlXOC9o?=
 =?utf-8?B?NDJhak82TzRCbTkrQnJKY1Q0WjJ4VitHM2tYQ3Y2SzdQMitYcEpBaWRNTEVl?=
 =?utf-8?B?bm1tUnI0SzZFbXdSa1MybXJrbTZGWENUOG9xYUlyOEowZEd5bXgwb3I1QzZQ?=
 =?utf-8?B?RlgyRUl5Ti9RMnRIUnRieXRxaDdCajNXSGRwMnFNK1R1eEc2dENoejBoY0U1?=
 =?utf-8?B?U2J0bnkwQnVzMGh3Y010aGpja2plVUFJYklTbjNYM2NJRXI2QVpnZStNOVRP?=
 =?utf-8?B?VEQ3L1FSK25tZ3hZL1BTNXRIaVBjRWFORFZ0Q0ZQUGhyVnowNWlBU3dDckpM?=
 =?utf-8?B?Mm1VMlJHTmtKb3MrZFplMkhvSmcvbkNJaXVMelJWU2UxdzhNVnVDTkJHOFM5?=
 =?utf-8?B?MXc4Wk1Ua1BiZTVlUHRUenZ0b1NieHJBVnNIZE1jeEQ4U1J3ZDFabGtMN0Zj?=
 =?utf-8?B?aXpDRUdGeFBMVXZNOW5vU0ZLeld6QVJlcy9QVEM4T3ZRV3Uxbk16MDZ0S3Mz?=
 =?utf-8?B?RzZpdjhibG9haXYvMklYKytqWkU5ZFA2dXJ1VWpXYmNheFd3RFM3cTBUSnY3?=
 =?utf-8?B?ZlBNV0k5eXZ1aDY5eHJEd2ZsWmRjaHFrdG9lOVBZeTB1dCsweUI4VVYvcDRa?=
 =?utf-8?B?aDNqblkzaDJrazloWUVwQmZCc01mMjdoVjg0eXZlZWM2VHlVTHY2Ymd3TnN2?=
 =?utf-8?B?TXcveFUvS1FOWlVxZkFmd1JCSzErdkpmaWNDbDZqY3Z2b2tPNXhDUTBnd0tw?=
 =?utf-8?B?d0JGSTRFL3VaV1hxdG00SU5hTWkzOXNPa003R1owNG53UHRqTTRuaW8xYlA5?=
 =?utf-8?B?eUNhbTBncDFaWkgxVWQ1bzdYU0cwWWMvOG43RjdoZHNuVDljaGhJbmZFMVRC?=
 =?utf-8?B?cWY4elFqMWk1Qml1VE5XWG1Yc2p6Y2hHbS9QOVdtL0QzTUt0c2kxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab5f865-ca3c-4e3a-3381-08de537e5ca5
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:05:31.9265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJLGn2KP/I31EQSJKNVZThbaHGF5QWeAwp7cTWsr5K4yJR//cDioVG6CaRZyzX+BXizlreh2ELWCdsFJ+MftNu1ut5iMGaasFDhm7eLbDlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846
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

Hi David,

On 1/6/26 11:10 PM, David Lechner wrote:
> Fix typo with correct spelling of "purposes".
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   cmd/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index b71ac554c0b..94f3e75ca6a 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1679,7 +1679,7 @@ config CMD_PINMUX
>   	default y if PINCTRL
>   	help
>   	  Parse all available pin-controllers and show pins muxing. This
> -	  is useful for debug purpoer to check the pin muxing and to know if
> +	  is useful for debug purposes to check the pin muxing and to know if

Not a native speaker, but shouldn't we be saying "debugging purposes"?

Anyway, this fixes an obvious typo, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
