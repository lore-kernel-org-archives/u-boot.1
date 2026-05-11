Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2284CD484A
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 14:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F03183E36;
	Mon, 11 May 2026 16:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="N/7h+fvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA23C8394E; Mon, 11 May 2026 15:38:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCF7080F0E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yl6zXAF9AZZhi8Xuz2d/2wQ8iN6d4Amn+NulN4u3pe/SHXqNuLYdhIj+V6cMGvz2NonNRoDI5Ni3T1NZB2cR7kmGPFki1T8MMdnHQhKsLG48gMq4V+y+4Opvz04RAy0QeRaK3NixjJieCkxx+G0eIeaqeWI5kzIoJcFhrAjsMRibwWz8JIjzdili4MWrOSBdyiut4izto1mFZXpWb09vTVvoTW0oFvnvMyT4NmjRX3EltJd33zFYghiRZ0N67EJ3xe7mR8KNidejDvmg6vge9CP4im7ZJkh6ueaTsamuEKp2i4yX76f15jrN/Cam2nqMzZqfSWHgK4JAkn9Vz0Yt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+Ic5+5TpsWFWxT6guX0AbABkwT/rPvGtgC+IMzwOuE=;
 b=PKeYXZWjSVOApIOdxg/SSAlXqr7Yrxqn1uyN9CQ1C8FJJ7tVYRlPKmSL3gISVHntD/T/9veRHZfT+8E5cgpGwtpPKXYfa8o5pqTg/2Gcfx+LY9N/2YciFuYUE1iUirL85wDNo578Yia9wc+/y2PCj6/NScne6IYA8oVSXYr3SJHyqwgm6Z7PlyEQhxs+EOyIUsjLQJV83LdLl/kcxh5dXPf+ROdMQlvXLW+ymx/WOn54nX1E6Do2Fqz96KQqIVaXCxZ1S0l7YcUFZj99ldpRfLnMLT7SiHSOYBjcP0+f4HM5DaYUW1UN7+i2qxxA5xW3vqdwiQzfgmPujAySo76VQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Ic5+5TpsWFWxT6guX0AbABkwT/rPvGtgC+IMzwOuE=;
 b=N/7h+fvDfxpcgk4RSZnU/+cQGy+cMcmRaCtURK6SzvYeJsWRNXkKVNJV3W7hOMHwaiEg8s+cwQOEuATZ24uhQBb9YU2tPBjattKHBvC2eZpVnCM/lxWjd7eYpjKTzb0BS9upaNYncYhEF1SUJg0mvyW1QgZMzXW4NryOaIbFV4pt8mDGw+FtXWHmCQBTYKj12f2yi6cXZd4XhwtJwD4O+Ue4KFg6bxQlu8hYJvlbYnnkiJjB8zCHkOkzfm/qh9LklrO1kYO97XHyNX642vhm2bt//ZcexT8+HrU1BvJ5owM4sWYQJqAyLpQISLQCCd6aCXNMPTU2RH0qlpOPmtPWTQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 VI0P194MB2908.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:315::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.22; Mon, 11 May 2026 13:38:01 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:38:01 +0000
Message-ID: <BESP194MB280543D9B308D6ECEB5C6A53DA382@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 11 May 2026 15:37:58 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] net: sntp: Check packet length in sntp_handler
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::19) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <78721328-0317-49eb-9b57-6c1dfdad30b0@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|VI0P194MB2908:EE_
X-MS-Office365-Filtering-Correlation-Id: c0248447-63d7-489a-a451-08deaf628550
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5062599005|55001999006|6090799003|51005399006|37011999003|24021099003|23021999003|15080799012|41001999006|8060799015|19110799012|5072599009|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGtZZWZYbE5zWUd4NUhaOHRwQ0EwV1V6Z1hWZmRITDhrOW9NQkpjTm5JbzlR?=
 =?utf-8?B?bnJlNVQ1TWV6RDlkdHkvMzJHZnFRYzlEc250ZEsyVEpvTzBWME1BNm5FTHZE?=
 =?utf-8?B?bVpPenlEYUluSGI4cGRvUkh4d3pnc0M1SW4rMHlYb2J5VWk1YXN0QWdNdU52?=
 =?utf-8?B?T2dvYitucGpiSzA4c0llUE5MUWMxWFUwRVNLSWl5NXJvenpEd0JMQUJvWFBU?=
 =?utf-8?B?d0Y5dksxQlJMbGFDN2phc0VxdGVGbkJrZU9ZQmFYQWRpTDdDLzJIZ0d2V1U1?=
 =?utf-8?B?NnYxZzVacmI0ZzlSYkJMQzFXVk52a0c0eFdmRmUvQlJxVHcrOUxCKzR4bisz?=
 =?utf-8?B?YkNXbUcwM0lYT0p3eXc5MGpwREVNSk9ocWxXcExDejI5M3JjTHc3emd1U3hm?=
 =?utf-8?B?dG9GUzlSTW5jT0NWZWxDZ2dwYUtzNVhaUWk2SU4xT2hoOHdKRldveXdjbzVE?=
 =?utf-8?B?cFNsYWpPVnBTcnB0YnFnVS8vUVBhUGtLYjFRVlNINkQvaG9NMDBOOG5TMk1i?=
 =?utf-8?B?YURvbXhEY2wxZzhtMkhlMXQ2elcxcSsyWER3cXlNQ0cweGhQYi9WN1B1ckxL?=
 =?utf-8?B?TkhNaXg3QTc0YjNycDZDOTlubkVKek01NFhra3dNOW5nUUo4Mk1KK3V4OFJj?=
 =?utf-8?B?ZnJlcVFPb2w3QU45WUQ2M2NTNGFxbVFpYitYdlZYZUg0MklBMGk2SFFmaVBy?=
 =?utf-8?B?RlRpb1BvN2J2YzdKVUN3Z3p3UjZ5NUtHMzFMdlBRQzFHSFEwNXY3NFNZZG9Q?=
 =?utf-8?B?NVJlSWN4SlR5QmdUNGZ6b2dtYjREOEtta1ViM3JtVm5oWVN3QSs2WjA5T0dp?=
 =?utf-8?B?OUFZSFNlR1JJdHRlV2R0NmQyVHVLekV0aHVWZjZzMEZDdXBKWXdEQ1FhUUg2?=
 =?utf-8?B?T0JhSXF2WDVkQjlaWk9PZVlPMUxIN2tWdUExYXcxMzA4ZEFOd3I4RG9oSy9j?=
 =?utf-8?B?RjFtNkVWK0U5d0V4ckMrOXBCR2ZMWXhndXQ1aVZPZHExTDNXNUluNnlqRUVk?=
 =?utf-8?B?Y1lVU0ZvNU5MVURhb3k3U3FIRXlVQ0Z1MzlGUnpkMml6clprd0cwUDZ3OVRh?=
 =?utf-8?B?U0ZRbzVLeWw1SE16QlRYQWFuenZXMkVyeElXWDcxWWpDVExzVzRuRWxqUE81?=
 =?utf-8?B?SzV0TjdVRDZIZzMxUXRsVDJlU21sU0JvQ2xGZ0tnQnFQNGo2dFVIcFdaQ1BU?=
 =?utf-8?B?cCtUQWdCN3BoS1BkUnAyd0Q5OWlQckVQeWRkYW9BYk1SUS9uNUJleEc4WjRj?=
 =?utf-8?B?MnR6THY5R1NDNnVHRjFSODRvS1RpQ28ybmlGM2QxS3Fxc1FaZm1VcnpTeWV6?=
 =?utf-8?B?TzMxTGdISFl4aDhQVmdxcXZURnAyK0JzNzl2R1B6eHFkOG5nVkxhSXBMaU9I?=
 =?utf-8?B?SmUvdWFvNXYwVjRyVFNuNGpMVE5pMThLeTZmZDd6R0FqSFhyaWFHKzdLWVI1?=
 =?utf-8?B?ZVhCbzZFbkZ5WEM0S2NrM2FJcEVlRVFSY25yTmtBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk1zZ0FmMzFpYktRN3lKTDQ1RjBTWlJndWFHYllyTU5yVUFnaXlVVDF3Z0lG?=
 =?utf-8?B?WmxIc0MyYWdKd3E1VnE0QndkL0JreUVDK01yZ1FvNDdVclg0K0xDckNhYXNn?=
 =?utf-8?B?NmR4R1k3NnUzZ1MzMTd2dDFWb3lwbVo4aXM1bzRiemNSVk9qTmtpYnBNWHdp?=
 =?utf-8?B?VWVLTndUM2RMWlpZOCtUbzgreko2RnhFdENub1NZQ0dFZTg0RXA5LzFQSWZH?=
 =?utf-8?B?bkx3Q04wSmJnRTFHdHI1QWlqUFAwU3FVS1NnNE5YN1JPLy8veUo0Rm4rSW9X?=
 =?utf-8?B?QkVkUTRsRVN0NHZRSDN5OElQYk93TG56V1JUMjhjNzhQTVRUS0FWQnZVbS9D?=
 =?utf-8?B?WENxaGcxOVRySEVub0xtMldkMTVCcWs5N0h5OUNnQis3N21YUmllcTJJdktU?=
 =?utf-8?B?c01UOW1Cd1l1WFA3VFVkWVFOYTc3ay9mYnAzUWdJeUJXUHZCeUJjZEpVRjZB?=
 =?utf-8?B?d1dkcWVTbG5FYTREM2ttTytkMzlFRjNtaFZhd3djK3FYc1JaTGdNa0pvQWFx?=
 =?utf-8?B?Q3BlZGkwazFGSTZoUTFzNkx5SENFblNVNFovdjF3VXpQN0VMb0pmZis2UzRZ?=
 =?utf-8?B?QkRERFE3NzdpVVJoY09XK0ZDbXpDRmY2UWgrSkw5Zm9lSmoxVXkxK0xxbHRn?=
 =?utf-8?B?WnY0NzAweWsvVGxTdjVvZWlmeDFZbVUwb1JaaVpsNnJxRmh3TGNNcXU4RCtY?=
 =?utf-8?B?bWhhSmF3d3YxaDVtVWJYdFRURWNKdWw4amJxYU1mN3BJa21YcElrcUNFdEJy?=
 =?utf-8?B?ZVhya1FpTXFnejZJeFV0MENIdm4vbU10cHNPcTROYnVJOFVEWFJ1UG5BYUNs?=
 =?utf-8?B?Umo5U09xaFdCL3BFNlJBZnRiQTNmQnhvWmlDZEJQOTRkVUV1elpXQXprNWR6?=
 =?utf-8?B?OU92R21qNWRyU0pvM1h4MndLNW04bVFZU3NCMkpYbGhrd3BwdXg4dzN6dXNz?=
 =?utf-8?B?N0Niczkzc3l5eHNvNTdVQVMvSDNpV0pLRkJyNHN1ZkNNZnFGeEhzZkZkNTRt?=
 =?utf-8?B?L2RaWlpMWWhHOHMwZEltbTc3WUs1MkZWY0pRcEpiUGJHKy9nUytwYnQyN1RP?=
 =?utf-8?B?cC9XTG1CdVdUS3BURERjL3IzRTdkUy82R2VzTVhIUFJ1MStwZ1FmWk9zYTI5?=
 =?utf-8?B?SmROMFlXQ1JlUmN3U01HMW1QbC92VzJ6Yk0wQXpXUnd3U2FkOVFUQUFBaHJn?=
 =?utf-8?B?aDN2VEQybGRoTXV0Z3A5Ry83dmN1U1ZTNng2bTdVTjBZOGNPTGUySi9CUkQr?=
 =?utf-8?B?QWtNUWNRRXhqb05mN2Z0Q2R6UW50RVhjOUdJdnhFMXVsVXlFS3hLNklrUGJ0?=
 =?utf-8?B?RjlNN2VEWSsxalkvdCt3aDVqUDJBT3Z1NCtvZHNPcWpZRTVwZndUL0lMV25E?=
 =?utf-8?B?N3FQM0VsNUVyR3UwRXh1OFprYVo5K2ZweWp5cjE5QlhGZGQzYjFhU00zOWhE?=
 =?utf-8?B?cDhqRE43M0NubHluTFBaT04yTG16cEVndEY0UitpSlltWExwVFlNYkw1d2Na?=
 =?utf-8?B?UWNha2Y1ZGZxakZ6b0E0Qy9XbEZMRjV5TjJLSm1aRThOd2ZzTnpvSkVlbGhX?=
 =?utf-8?B?L1dhRXFqUmY4T2RDZGJZcWVQZU9BVHNueVJUakd4My82RUdkNEdycGgrL3Ny?=
 =?utf-8?B?WGlXd0Z6SUpoSnByQzh1OUJBUngvb2ovRXF1bkhBaUNtVlR5QUxYaFZUZ3ht?=
 =?utf-8?B?QWRMTmpGNFBoZFV6TndudCtXOVhVaUoyTUhYeERVZjlqM0RhZW9nOFNRVUFX?=
 =?utf-8?B?ZmJQdGJmbUQ3ZnBDb2JmbkowVk9GUnhUdFhSdmI0RnJiS3lrU0RhVjRsaHBr?=
 =?utf-8?B?L2pWMFdoRXZ1ei9lV0hweUE4MmtzblBOd2xsQlM0MEFzck5WYnBUNi9sd0dt?=
 =?utf-8?Q?VD5vueBca3jyR?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c0248447-63d7-489a-a451-08deaf628550
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 13:38:01.4102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P194MB2908
X-Mailman-Approved-At: Mon, 11 May 2026 16:21:38 +0200
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

Currently, the sntp_handler uses data in the UDP packet
regardless of the actual packet size. A OOB read can occur
if the packet is too small.
Fix it by checking the packet length before extracting
seconds from a SNTP packet.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 net/sntp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sntp.c b/net/sntp.c
index 77cee0046bd..4b3dc675bab 100644
--- a/net/sntp.c
+++ b/net/sntp.c
@@ -64,6 +64,9 @@ static void sntp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 	if (dest != sntp_our_port)
 		return;
 
+	if (len < SNTP_PACKET_LEN)
+		return;
+
 	/*
 	 * As the RTC's used in U-Boot support second resolution only
 	 * we simply ignore the sub-second field.
-- 
2.43.0
