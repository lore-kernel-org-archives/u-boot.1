Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989D7C4451C
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:46:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D3F2B607F2;
	Tue, 21 Jul 2026 06:46:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kzo3CvekYVZe; Tue, 21 Jul 2026 06:46:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B7B4607E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784616375;
	bh=XiBYiJbdinLvohhnONEQQhBVNtQPkaXSYKd4qr7cqK4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=rq0WlIW1cp5ccGifrN6DKA48y/fevfzbGPY+VpqjKRHolgY6alJ3AeMXZWmUxTLKx
	 6frFweBZ72bRKoo5+eKI9h3Ex1ZftmUEkGCFo5zXCye6hS9XeFOXN4dwISN5pLM8xF
	 +G5QklOLXZkGLx78tqLFv19bjddR3B6ur9MO3M6FuXR9iYnLM1GO+UveSoNnETmhMS
	 VzHlSSTlRqwVHGg+e6Gfjm7+8UiJNW8qptYcCTnWTyJYw2IEQgnTPf7+DiLdEDTyvJ
	 a0mIYfCcXq9PVv8qmlWOlqYMpBVh7ZXCttxOj1WNMpmQestaeHXNGf2onhPRgt+C0i
	 bW4Cyr58w1U4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B7B4607E8;
	Tue, 21 Jul 2026 06:46:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 91F011099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:46:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72449607E5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:46:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dmP3sxSW5ZEQ for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:46:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3BAA1607DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BAA1607DC
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BAA1607DC
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:46:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 869C784659; Tue, 21 Jul 2026 08:46:11 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B612803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:46:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJAbXwqPHnHG55RUBi6vxV3njPvTijhmYn41KuTTueGJG/OJfiWcmkxrE28pg40LEpBFxMo1bgzereKxZiK+TkMApfWeOcwFzf4+0yZJXzTfmZcAmljUuDp+tE3uUjBu3R75ys97awfnTh4Cj3EknTqAX/ORSnZbeV8uKsSRkSEb3Af5t1eu/cBTRr3atWn5m43EVgDn3MCNSZFWQYcMmfclDq2Q1i3r4zn1fVBkpou19Sc51NdzDujiEtiUiDE4aFZ/dL8eUayJ0XKdbHe7RG6RNDdXGIx+5Lv9YPKz/nzflJipdTCyJOakZJ7/e2p+Rb5iRBopbiizAW5Pkfgyiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiBYiJbdinLvohhnONEQQhBVNtQPkaXSYKd4qr7cqK4=;
 b=N8q1d2djk9E5AMNxD2JhgzAtBvR+EMhgzLbTrpfknX04Z9PBPdummpsVA8CWLyjhDyxV19s580+Vjbu5W8r5vCrOl+kCOs0P84BT+I8DvKOeHKwJTjoNLYeW8jzUA2yz9ToHA+3NAuFs0drp9voPomCytA8tcjaUrbbm0yZ38hzNLHl+VAN1UHL3PhES7vbXPWkOSIUOovJKOigHUPnPzzuw6SFtQm2+e6wMoXURNZyvxsafUBf+5lOQls2RVE+F5XTsPES4/5SQSZSp5AlLC7eFX49GQBPLjyXFBLvN28xgC16hOBnFfa7javqmBTBDtc2JTnuEAh0ef0l2yXwsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SAWPR03MB989177.namprd03.prod.outlook.com (2603:10b6:806:4d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:46:05 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:46:05 +0000
Message-ID: <3b9761c8-c062-4509-a15c-894a219f6776@altera.com>
Date: Tue, 21 Jul 2026 14:45:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Enable MMC secure transaction in SPL.
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Ye Li <ye.li@nxp.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260311050003.20955-1-dinesh.maniyam@altera.com>
 <19dc7d12-f4d7-441b-b00f-0f2ec41945d6@altera.com>
Content-Language: en-US
In-Reply-To: <19dc7d12-f4d7-441b-b00f-0f2ec41945d6@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR18CA0012.namprd18.prod.outlook.com
 (2603:10b6:806:f3::35) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SAWPR03MB989177:EE_
X-MS-Office365-Filtering-Correlation-Id: 23b0c42b-4d1f-47e6-1e61-08dee6f3bc61
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|55112099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: nW6Jm4J5iTRaRPNVKEQhhaRGI4PvI5wWbwzPp7AjPZRq0w7k0FA1Jnp2qQ87rs8W3tR940oMSylkU2Ulxst/RnGxDNzGrI7BBgobD2TmKolsOhhPuCK+DVSIwe0+S3ktj2m9nVAldSXo6y1noNRA/1W7Owij7Ss0kdbFwl4+FFaD5yjH8XQO5t54krh1AiYxl69A2tvI6wwY0c44RhAJ28RvgMlrH00vXGWauibaB5DDTIPO/rTovXLBOoU79V1Tat8p4NjTW9sc0GV52+PpMC2t4H0PAlym/NLUDH0BylPdr0sHVtvOfxAG7TH2HO95lY3LY3iygcmQ48Fx6U9yAxybmwSXUAbmNS0FBU4ky88M48b4wqeDU4yI+reMnn3qxn6x0Igsv4ec70UA5SPCUof32jRKVHP7e/VSbVFQBd9+rk+2vpPJ2DKOk4u6EI8Ia1QuJ5dkpYrqSk5sL58AaYJBYt10k6bj1cquynZ6Gy15ovXFCIRc1ucVuoUKG+ouh8FaT2e/v518qCX+4WWsT9LCTA4Uv8qVXoCgzpffqPgvlgfLAk1hvE1IqnO56Kwe1eHD1sgTj8LhFCmeQMIkZ1moXxxdY1sLsMUKEUIcVFxrewMxHoZO+9ahOrSErauAVzOWrrP0w+fOEBYgHPg8qefZcYpONQsY219fUE6WQVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(55112099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3E5M1VzWXNyMXpEdGJJMEhmUGVnMVFqV3dZWU5DMTFFTDhJY1NtcWlHTVNE?=
 =?utf-8?B?Wlh0S1pJYXYxYzdJSE9za1k5b1FSN1hreCt4TzlWdjFsSnhja2tjdk00RU5j?=
 =?utf-8?B?OUJZM0hkdDU1dHJldXp6S1ZUSHAvb3cxaG8xY3o1cXEyQ24yWFRVMU4wRU9D?=
 =?utf-8?B?eFU1L05jbDFZTXpWbFVRWjMyUXkzUlhQaVBUdTAvZzRvVFFCMy9reEpjZFZo?=
 =?utf-8?B?RHJrTU9tQW93cXltSmVPS1Rya2hFREtmekEvWmtOSzBmWnRNbVdGRUJpcmFh?=
 =?utf-8?B?K2d5bWJ1ODhWNFBNeXVXNWU3amtFaDd2aGtrVXZDRERsaTg3cTgrWjhaZ3Az?=
 =?utf-8?B?UWlSbzNaSVhIUkI4WlZwNng2K3ZqZGZVQStwczFVNE16emNabllmeWo5UUVj?=
 =?utf-8?B?bDZZNDNUR05NZFNQMFV1TWkxNmhpbjFlcUtPSmRuaVI4NDFSeFZJVG5oVzY2?=
 =?utf-8?B?ZWxKOUtkRUUreUlOQWlBcDh4aGFzSnNva3lJUUVVVDl2c3ZydmVWSEpSRUt3?=
 =?utf-8?B?SmJBekVFd1NpN1FCOW1Gd3BuUWErc1cxWXd2K2FQUGVDd0ZVcE1POXVVbU1V?=
 =?utf-8?B?TWdDdU1PM2xnU1VqdUE1Qk5UYVJBMXdkT1YrVjlQSGl2MXlZR1lQaFdNM1NF?=
 =?utf-8?B?QVRmZVBJRUhicHg5cUxLd2JCbW5LZzJKUHYwUSttRU5GbHl0dDBLcW05OFFj?=
 =?utf-8?B?enFCQjZqZXR6Kzc5OUZ0bnhzWVMwcWQ1TWp1ZHorOUUwOXIzdTB5a0x5VU9K?=
 =?utf-8?B?YzFaQ2xzRzFsR2xCSjM1a0lHZXNQdmJWNjNjUnBWM09yMDV2bXREVFZxN0tn?=
 =?utf-8?B?VVFobkdTR0VBWGZXRy92YkhDRHNNbVkwNVh1amhIZXgrcGVvMlJOdlM2U0du?=
 =?utf-8?B?eC9IcWtmVjN6aEhyWVZKTzJneEhCMzlhQ3ZrQTZZWmp4MHArdm43UWVJWWkx?=
 =?utf-8?B?MDkzVmlOemU4b0FOdVFYU0FlOTV4ZXpoTElnTGd2WVdNVnNzbHpaM296Ni9M?=
 =?utf-8?B?L0dOUlE1aWRwaWZ6RUZxaHI4bHNFMndvcSs4T3NLMTFlbms5VFlacXFxSXdv?=
 =?utf-8?B?V3lEZWNvMFg0RU5aQlVnWTIzS3JaZDN1MGtXd0lGUnNETjVXWE5ZWHBJUE1B?=
 =?utf-8?B?N2RSOUUxR1NTVXdKL0thcFhwbHNxOWVQaDJTYjZET0RTL2JhQ3dCK3NNRW9m?=
 =?utf-8?B?YmxyWVg0Nld2NHNTOTNqdS9rbEdLZ3IyL2RFTVhUQzkyU2ZxTFloUW12Vmw0?=
 =?utf-8?B?OVowbkpoUjRsekVVWW9CL3lMYnBMMnNIejZCcTA0QjcyS0dWVUNpRU01cllm?=
 =?utf-8?B?RGdJa0VtQUFXM0RyZWNMK214bHFKRS8yS3FCYnRxNjBVdmxzS0hzbmRGUVQv?=
 =?utf-8?B?ZUt3MjhGMDEzZ0ZpbGlUeWdJbTh6d1lpK3BOcUhmNzFBMERENVB0NEpJUiti?=
 =?utf-8?B?b2pJbDZlWU9scVc0a3dWTVdWT2svNmhpRXlDbzlUdlJKMjh3ZVkrb3lyWm5n?=
 =?utf-8?B?bXo2Ukl5V0QyWUVFNlJyVFFwZjN4YWloOERCZXdVUzREVkZlT3FOak44N2Nn?=
 =?utf-8?B?THlscjkxZFJXblpENUtuRU91T1BPdDJkK0krM2FWb3FGdTF5VU91ekRqenVq?=
 =?utf-8?B?dXR3QkZZK002UUltMXBsRmczVVVYZGNlUE03bTBONndOWDdhNU45ZE9YcXgr?=
 =?utf-8?B?Wmk5dWV6VktKcTZlb3FybFdEazRVcDBsSVhXMzMvKzFRMlhSWnZ3WEwwMEli?=
 =?utf-8?B?QXBiM0FsdFZDVWFiUzN1MzFoNVpoTUZlMWQzUS9kTlkxSW1SWnJaTzdwb0Fm?=
 =?utf-8?B?bTU5WVByK0JtNFJpRUVndGhiL0pObHBqSGc2NlFaQTdYQTZobm4xTStveFpa?=
 =?utf-8?B?S2JZS0l4eWV3ckhhOVVjUW14anY5UExXdURzTDBheG1IMFVxVjErOHFybXlM?=
 =?utf-8?B?V3VOdEVqbFRBNkpveC9nTVYrclZBc3JyY0s4TDlXUFZLMU1BbldaZEVPWXVH?=
 =?utf-8?B?bDlDMTNhaVVrdEVRSG56Ym5xeEhQbXIvNmN3c3J6bzNxTThJTnV3VmdEem9Q?=
 =?utf-8?B?SEZuYlFmSFkvdkVkRmxzeU9ia2VIcExwMkV1T3hqaW9MaUtjZ3d2STA1OEVz?=
 =?utf-8?B?bzRMY2JPV0dkbWxOL0l4Y3I2dERnclRVek5iR0s4RFBoQXk4YU95RmJoZG9E?=
 =?utf-8?B?bnhxc0VIVC9oLzg3VTVyOG5yVHVzUUJLS0hKaTQyUXpVNUIwVWxMaWZLTUxk?=
 =?utf-8?B?ZmphQ1ludzlEaXplTzl3dG04NXlxdXNSVDJGeENscDFoMXZpb0xNRUhJaG1u?=
 =?utf-8?B?QzNkMEdsSysraGF0a1BoUm9QS2FWdjdXcUM5dzhjTlZheER4c0xjQjN6K3My?=
 =?utf-8?Q?WxA8B9tRz/3H0+ws=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b0c42b-4d1f-47e6-1e61-08dee6f3bc61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:46:05.1816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Shegz93WiK/UqN57nu8+8/5BPP+vhNWe7iKLuQxM3gPm61ZbAfueTFHkKn7PjJ/RNuF5jBnCB9y47VKfm/Ibk4nPpVGnJrl+BRF+mkj17mQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989177
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiBYiJbdinLvohhnONEQQhBVNtQPkaXSYKd4qr7cqK4=;
 b=aPQOl26B1GOdte4kNAKUC9pfN7Y7R6n8SCXBz/JuM6sf+cY7u853UmFcBMyBZSeWQ1qZA9yvWvC0zFjaX/l9UT0HqC4GSOJIV3fZapHNEEO+wtUqbb9ZQrjAmif1n8WDk3dfovCwTtRz2BS6lOK4csRAkpi8OIUGnvjA8dQ7uFraLsbNTjnO53MM+NsNyUtVKcaxpE6Ghj+6X4XYDrSLrh6CQxyGbdSrLGvar1o/lytOObvBOWPGhEFxJvQqja8Q5opwz31bIvbGBkW7BS1CFsW07styMMCI22IGDWZsMnpqMc/+uj+t1vUEiDGF7sjgG1C3QIHPVAmKcclk8kwsQg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=aPQOl26B
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="aPQOl26B"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tien Fong,

On 16/4/2026 11:30 am, Chee, Tien Fong wrote:
> Hi Dinesh,
> 
> 
> On 11/3/2026 1:00 pm, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> 
> The subject could say Agilex 5 explicitly (spl_agilex5) so it is obvious 
> it is not all SoCFPGA.
> 
> 
>>
>> Program SECURE_TRANS_REG when CONFIG_SPL_MMC is enabled
>> to allow ATF loaded from MMC to access the secure DDR region.
>>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   arch/arm/mach-socfpga/spl_agilex5.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
>> index 1be347360f5..d0c2af795de 100644
>> --- a/arch/arm/mach-socfpga/spl_agilex5.c
>> +++ b/arch/arm/mach-socfpga/spl_agilex5.c
>> @@ -110,6 +110,14 @@ void board_init_f(ulong dummy)
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Set secure transaction for mmc, so ATF image from mmc can be loaded
> 
> 
>   capitalize MMC, minor grammar (“so an ATF image loaded from MMC can …”).
> 
> 
>> +	 * to secure region reserved for ATF in DDR.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_SPL_MMC))
>> +		writel(SECURE_TRANS_SET, SECURE_TRANS_REG);
>> +	}
> 
> 
> That extra } would be a syntax error
> 
> 
> Best regards,
> 
> Tien Fong
> 

Thanks for the review.

I'll update the subject to arm: socfpga: spl_agilex5: ..., fix the
comment wording (MMC / grammar), and remove the extra '}' that would
cause a syntax error.

Will send v2.

Best regards,
Dinesh

