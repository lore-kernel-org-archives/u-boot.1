Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FA0C61CE2
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8122B60622;
	Mon, 24 Aug 2026 08:44:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7YfhGQLgiM9o; Mon, 24 Aug 2026 08:44:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561077;
	bh=cB+GW9eylViFS3DU8QK1qyyy9ick8Ish/z7vBOvUNiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b0WGE0ArbKcW6X9jbC2jczKweoqdwkidjJ3wtVnD8Z4rXH6Oti/efytR3fmkTmwyq
	 Sp3AteEyMxga4Jg/6u+nfU1TLYzFEePzK+1rXBur790L2Xu4HjnyBdT7QyeSSIWn1P
	 yt4Veyyp+tmTEtYDDtQEcu/SBp5Px5+zu69mJMsUmiy6Cai4Q+s8+96cr7dtzBsc5y
	 C56I/gKNCs5KMxNT9DotwT4XzwBXKXqF+wRI8Ohw/NcxhADnWc5AoUxjPxkDnuj1JA
	 T/muLLWtF3eUaYzow3O8owsA2jCddTMwEycV+Ex5337utIPRWeQXWiZRtlT0JodEzU
	 laIBUInzfcVXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF3966063A;
	Mon, 24 Aug 2026 08:44:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 594CF336
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A30960737
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ONGWJfkKn8Wy for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:44:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=L18rAt4G
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C75D60622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDYYoAAPNgud2mAnEWo9uIDZUDo/RmBSXBqgcYyJopxHHt9sXIaJY/bRYN0LTTCn3gO5R49fPKyT9ZqRpWYyAyM/3QjAMIMxIfrlhYbLP/dkJPRHvxvD2pTDGe0ET4Os79kGyvCBvUm44m1LWC/JROFKKafZVmVvO8Pg4lwYSl9k3x46niiAQ8faeDTsohqqcPe2JXv7K37p3fv92bomL0QlM8dC0gUmQQ76OTIRqJlWMzfIps0PzeQuFxHCT0uMKe2Oi0UP3FbJ0a5uZncK1TIerBxd2InOPG2oJHaj+6FKaOMobAn1la1AG8FWHuvCU0qg6DYcDJIvvF44i8krSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB+GW9eylViFS3DU8QK1qyyy9ick8Ish/z7vBOvUNiQ=;
 b=s8qz1yEb9rzPdTQ9boct9LFH+OENRy+cCPGq6b8L+PWKgcJOHbkpGuHXDVCT9QLIE/oOx/7jWQUymrchXpE044B9yjVdZyJ4SZyE7B8l2fmHIY5bfZp4om2J+W8EMETGtEaN1GMiO8rql427ImGMGcou/Qu4qHiSOFV8nzEAMdS4LZOV0dufWaJafpx4ys8d1fvyWQ6UsDYmPvKQE/dimDeFi5+FWMvnWxWNMXliLq8vCY1SJp7SnJKbDyRZFkL4EGKVAxLIYEqy6JNR3a/JUKBWiF+SEN3zI2xc96inVnfaCdpB+GI+GkU7hPM/H2bPSBE+ffHrnSC48v6PXrWXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB+GW9eylViFS3DU8QK1qyyy9ick8Ish/z7vBOvUNiQ=;
 b=L18rAt4GCd0Z7dCcRYs5uMZ0VIKftBq164qVx7KTmyRmZ8kvlJ5iCeXlXLtyX8x1RXHwj57RwnUO81vDxcJW/krAGMvv9uGOfFnprWySu1j6XjeuPv4T3MzFCxoaKdjwKt67zKadNDDQpbtydc0eVTp2PEUPi4cp5OVm/rP9B1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM8PR04MB7825.eurprd04.prod.outlook.com (2603:10a6:20b:24f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:44:29 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:44:28 +0000
Message-ID: <506600b2-06ad-4a43-b5f6-54a61f7a3879@cherry.de>
Date: Mon, 24 Aug 2026 10:44:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MAINTAINERS: Use proper Orphan status marking
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.u-boot-project.org,
 git@amd.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <08f68cd8c514140071090a846839632f8cae071c.1787560364.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:803:14::48) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM8PR04MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: c303b037-79a1-43c2-ffc5-08df01bbe8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|56012099006|10067099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: e27+CZglxb8LEFPu5egaHfPr7JMMJNaIot1fSflShFjIvBRwSd9yPb3c0MvmAOEOt7WRK/UeGtleP6RUVnLgp3QA0uGKYqBKW7AVt8O8oL5RRk0JjQrASypLPFA3Q8oBcYaUQVT0l5/6kYiwGUx35inM9et5UbGZ00C3OPAt4CvHG60hw/GVfwaKsOf1jgpEZbXN/dqp3qbFpK1hP+E635kBOwkeLDzrd9zNZLVmG8Re1KBTGOR2I6ZhSjCv+nIiz/gsrVTnyrY6LDVO+TFUnpE836G0ri868qNPkjbKwpVxNDAF8AjxCa9eYo3K1y5Ik9hLeIQXZSVBuZzP2phb+pjQoHrQwlru3EoV4tz3Wa7iZWVt0NhzKu6glEE0+NWlw98NTxTLuYh61cfXqvLmSDwHHfIbUXq1tgaGNPSyNeZriKhk7UnCHUj1mv1BOQKsHiNkLJ5NenAII+l4VdyjXqwq7W3SzCWv55IkcbPBn4L88JCgDV+UMxL0M5h/yOnE6cxoBe7L6jm01kTJqkJYqGEjjmtanE+vxdlrcc51eHT1P1PkQMJ8RzgMQUO2LlwEgi0z8ESZil7KZinkSyl+O+1ffS7zB4oliDJ8g4xsBQ1eP5kcc9r68UuXcFx6GfcE71twEHVml2drHLNLIy0KcFKYrLxGZaI4+tI6VZrEP/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJ3dzhFazJBYThYZjFIdmlMeG1RSi9RanhnV25BU3R1Ulc4Sk41emFMN0sv?=
 =?utf-8?B?OEpEZi9vYUhTUjh5RjVXOEVjMldHaTJPYXlvTGNqSHM5dXZBcTdXZUZuTGdZ?=
 =?utf-8?B?VitJcXBLTGx4VCtXMEx3cmorK1NEb00rZFJXdWkxYTQwRkZTMmNyQytOaThp?=
 =?utf-8?B?N29yWlB4WWN4Y0VwamNsTlllcVVhSEw4eExTSEtmc0hlUEpMNW45L3pBSFpU?=
 =?utf-8?B?T09oNEVKMHUxRk80MWc5SEpQZW0xZ0JWc3lNN3dNTGVJK0twUU5CYndsbU1F?=
 =?utf-8?B?bTZTemFsaSt0RDFzcWczV3QzZ05UbEVuR05zbVozRkpvS3dTb3cySUVOM0xS?=
 =?utf-8?B?VmxXZWdRUk1UYzhpdEhSU2J2Y1BJaWhNalBqZk1GWmN6TWpmYy9qcU81d2gr?=
 =?utf-8?B?QWRZVUVqcGdKeFZocmxQZEdnNUZqU3B0V1NpcUV4d2d1U2Q1andhamlydVZ2?=
 =?utf-8?B?NzFuZjBacGN5MmIwbC9WYjNRS0hmMEtCbHNhYlExQXVyMVJ1RFJISG92TWtv?=
 =?utf-8?B?TlJPMUZrYUVMMDgxVzJZa0JZSUVTOEM3VjNoRFpHYXBlTjFxL3hZY3M3T3VI?=
 =?utf-8?B?NGw4RlB4N0tJNTlqVjJtWWpYNXIyN1daV3JJcVZhS2JGMjgzWFlMbmlNUFdD?=
 =?utf-8?B?UnYvQ0xtRWlzM2tKVE9RM1ptb2srVm1UVEVTVWpoU215NVd3akhsNlNscUhi?=
 =?utf-8?B?c1Q4Q1JWTGsvaWRXYVF3dlRjQVBQYytGL25rMVV4K2JrS2ZMWnYwMWpKKzZM?=
 =?utf-8?B?MWUxTFlKaFZqNm9ROUJwQWtXcTlQUEZMa3RadTh5cjBLWGRneEExeXRGMTFv?=
 =?utf-8?B?UXZkdjNtb1JQMHlCYWJHZnFIZ3Z1QXdJRzZ6OW1KaGhPSzMvUXowNGl5aGsr?=
 =?utf-8?B?d3hyVU9DckRVOGR5eVlnNXoyZnZZWFlpUDFJQkdoMTVkUk9QRFdMOFlSM2Zp?=
 =?utf-8?B?UjVJcWlFSXN6NVA0WmhIcW9icXVKdEJXcUZuSU92RnhGU0crQ0hoWk11bzRl?=
 =?utf-8?B?aFNxbjlRZXJFeU1hbVVCZVR6bFVaUmlFUFdBZmNhQkJVRll0RTRrUmVROEt0?=
 =?utf-8?B?TDJTTlkyeHlIL252ZHE0TktFazRqZmd4UGdtR2FtOUdGRFZib3lwTUNuRUpO?=
 =?utf-8?B?VXNqSXo2ak5aTmVab1FURlQzZkUvSTJRa0pVTy9CNWZxUFZDMU03ZjJkZzlQ?=
 =?utf-8?B?U0lzekRWMWJ4V2o3L0Z6SmhudWdSU0g5ak5mRjVvMEhIdEZSalVzdWtFWUR5?=
 =?utf-8?B?WTRvL0k3WFZpWFZiL3NVMmdTc1VUU2RBQ1c0c0o0N2pablI0TzZLNmdUc3VJ?=
 =?utf-8?B?cTRWbGYvQ2krcGk5RFExUlQwZktVQnA2WjFaM3V0WDRuYldweGNoT0pCM3dG?=
 =?utf-8?B?aEdRTzZ5TEd2SVE2b2pzMUpxdVpHdTM0TCs5bjNXNWErWXY1RlhueE5aK1Bi?=
 =?utf-8?B?RDlrQm9CR2JCZzVqNFEzTW5UdmQveFFoV2hXZktrOU1vQmlISnh0TEViM2NZ?=
 =?utf-8?B?QU15WC95eWh1elh6dmoyUkhRaVNBekFZcThsbFk5T05tZzhyVjUrTEorNmZy?=
 =?utf-8?B?OTlhWXZYeUlJeFZLV01BOWRxTko3T21kRHhkcUxDcm9sNDFqSU9PS09lUkg0?=
 =?utf-8?B?MDRoeGlmLzBocC8xNGdrdTNkaUNIbmVJOEY4VHh2SVpMTGwzNW9HQVFPUVR4?=
 =?utf-8?B?UEJBenljSnVvRWsydmhtZVNhK0c5TGkyMEhSQ3czL1NTckFZeEo2dVM3b253?=
 =?utf-8?B?YzZxRURzM2lWS0ZmeDBsKzR2TGduL0pPU1FqWHRTQ0FMdzZWSkNKRDUwRUdE?=
 =?utf-8?B?VlNSQ0o3RU91eEpoZzc1NXlsR0xrNElvL21LajZ1dXJTK2VOVnhVUTdoYUVZ?=
 =?utf-8?B?VklaMEMxY2RXYVV0S0tUR2VBR1IwYzYyMEl6TU9SbDE4QVkyMGFJZVRJQTMv?=
 =?utf-8?B?MWtWT3BUTEliaHYvOGN4bGU3UE5mbUZqTmRvcGdINnpVcTd0Rm9nbjVXWWJC?=
 =?utf-8?B?a1YyOFJkbzlTMFRrbGRMSXVtSW1jemNBY3FBSVlBSEppWHIzZitKOVJnczQr?=
 =?utf-8?B?TjBSWTFuT1dlcVZQYlJSaDYvZ2Y5Yk1iSEs5YTBzcUxQd2Y3Z1NRVUJpdUVM?=
 =?utf-8?B?QmRVZjZPejFQRitleVVWcCt4SG1QZzNtVDlHT2tPd3VmMFBYdUxQSFM3bDM5?=
 =?utf-8?B?aXhLOExMUzZ0bHBNbFhUVkpGS0pET1pPbWJFN3JFdEVrcWlZU0RPRjJLV0JO?=
 =?utf-8?B?NHcxdEtOcjZabGdGdEQ5VjhYa2lyOWhWb1ZnSStlUVVGYzhSN3gwRFdhcGI5?=
 =?utf-8?B?V3UybHlVSjNxUG1SNXZ2a2R3dktkRlZsdDhxZHRqWTladnV5RlBHRkFYMEtN?=
 =?utf-8?Q?/XyJ9bOsLXr1nTePf/q/7mCvq22tbTFjT/dQe8K2eMmPb?=
X-MS-Exchange-AntiSpam-MessageData-1: Y3rN0kzs6b0OB1uO7aYVJYgbo38rgf36Qz4=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c303b037-79a1-43c2-ffc5-08df01bbe8a0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:44:28.4475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YY+uMXZ6aF8AtJ+XFBjoJ2m6ODqBgW+Z9pLf03CEF/isWuetoq/S6Wc5/LXEDUnRf1wSRrU1M9rvNleFEfAlZO2Mj0KkxIzK+8gfl8U6Es8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7825
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

Hi Michal,

On 8/24/26 10:32 AM, Michal Simek wrote:
> Orphaned is not correct status based on description.
> s/Orphaned/Orphan/g
> 

This has bothered me for a while but I never took the time to put 
something together, so thanks for fixing this!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
