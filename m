Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79F606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mpoFYrIq;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DytlcS3x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03F96606D0;
	Tue,  3 Nov 2026 06:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a31-hj5kziYC; Tue,  3 Nov 2026 06:57:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5982B606E9
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689061;
	b=dq/Hnz9RL5ydSxWKbdGGOb/KHXiXI3TNsTXk2NhRQyokiHLBMU8Yza16YaCMwQVs5Pb9
	 M6EPtSjML+4fc+ZQXVweJQy/7fgdcwnFgLfFDWyzipd6gwUoL8w54TYdX9WWXYKGOiP6p
	 Yb+BZe3/Zb3lNRkV96wpIF0m6r8UhI6Mn5Uff/AqnbbtwiQz/+XA29QYO6GW+aENyxlWL
	 Tu1kwl4Z2EA9adhUBqn1aeQ3FjbgceQh39SUZkKZ61TUo+kjtN6exIvHgG6V6fBXKRNG0
	 jrjrVe4Xp/UKlltnci41JVP5YJPLLg8FZ7OkipHES4a5ZNoK9Jq3q2OgfQDA5rw1CzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689061;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=And/xqiXKHmvMX2qZoKKv08P+H3TYLbsXucrQP53gXc=;
	b=GEZr4Ka/rBdU750PyPhnF3WmG2VxVzQDkzb/iHe6L+fVraWg+QAloetDGtyCAz2iCtHr
	 pfaXat7IRNT+InNSAmoxOvWOW0IQiLrVTd8vSSt781Y2OCZOkI03QNinZCpXRZmJSQvgw
	 86L7VySl6PW2ajdFo4z7786Wdwz25Tj3xMtUVCma0GR/jukLeLQyAmXzbZH3SVqinWpG+
	 YZc1c5bl+8e2RUOrvvdkINhx5m6raqH+Pu8TAGPKWCsJeoUlRSEwfaVkR8FSqdJWYOlRA
	 DRpz+krp14Fy/GhNM7T3WEerkELiIl0t+dK6b9Zp+yla16+d3d+90T6FG0IhI5/Sx0g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689061;
	bh=And/xqiXKHmvMX2qZoKKv08P+H3TYLbsXucrQP53gXc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mpoFYrIqURXUZouPncBQ2tNCoi1DzSTwUbv0Kpj/eyHnu2n8UGs3tjzqQuAemenpK
	 UfhWZgUXC10gecAQBKDdlHHUD2YjnJMMVOGcNJQOxcZUAGmPXf9Ck/1Ma+QVM62rXI
	 571emm3Iz64A9wyzO2j9keNOMKZfd/yCpA9nd40yy++UbSsOm5RGBuM/zQQRVe/NZx
	 e5l9UiIfejETjbqT1GCNWT4ivDOWjvkdtFEf1zgY0De7jWuxoMt9Dkbub3i7QJ9Hm8
	 yJKVihSePZf7yUcUUx84Tjz1bnQVj2N14/zteFShv1iYvdkFKvn8yC7k9BeHlbHd0A
	 MgWxIbUP8QZPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5982B606E9;
	Tue,  3 Nov 2026 06:57:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1813D2AC
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0723980DBD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:57:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t6-jyo9bFJlE for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 06:57:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F37D680D84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c100::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689059;
 b=L1DlrYSdefht1yF89CjKvosVjjqYU6ZPyqHlgBcvg762YESauaVFcWgA8w8crZA5AXEZ
 p08R3iv/Xs3dMS2o4bSBNfz3VTmhBMmkXNM+rGbqtU8e1NKL6Zhn1CNBleEJgm2uulCgX
 8pBj7LiFctQgqoGcC/bU5G8BarBpwa9VzhgceLk6+jyietxOpv1I3GdwpNcz+QDggB7N7
 nrXMcBZUbj+97WUAz6gNZkUV4gpaHnvcKEDkAc8dZq79HxD8fUmdNIRPvi5oSgNnPwEza
 PCROJ9oqZDV7dp7HiI4d2dJdoXPwpTNiee40EYUVFV46cRmxWuDifT7Z9HW0kOGlMcQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689059;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=And/xqiXKHmvMX2qZoKKv08P+H3TYLbsXucrQP53gXc=;
 b=qixZtuu35jM9MlQaP9QBcu3gKymkUWOTYl/sCL9bhClrxCvRpnnY27D0SR5bXRsGoPXO
 v7rEo33Z3S/I9/O1lthxJAruR1RInqmf8CVITd97Hfam2fDePPhh04y5AB8hGHDt8FDw+
 Wh40BH8jOfFMm2B7lA+mOHJ8wBJHrMvrRqMRTF+l+RCK37zi1Phs4cKPede0th336/5+z
 wxyeOF+AE5IZZFbpDltCtw3ybUWs4SFBTwt1kjoSmIu72au4RkUfdMt7qkQ6z87kL8q+O
 GgZoiWUzRJ04DlDPWVA9nAfo9HaYcoz6AwxnqV8qSAEukwTCx3RpT7o7kqjhr/Up7kQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=DytlcS3x; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c100::f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=DytlcS3x
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F37D680D84
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 06:57:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kYAFa2LWbCflmZIxL2eT3JtJ/HyzPdtgRebJgEOgw4OLqqzjSJSDHor0G2445iZKBXLWFQ3hIrOV8wQSFJflPn/n2WOnu92nMhdOp3+V7unusM3pYLnbcbEmm6HsbKaksu/FRYfQOKqEMLfmbv9xhKmCRG/+cHcYvJzvaEGADZQTvHu3vE0aAMLT/vOX4mumc8rJe8qUbJOKHNK24eU7RlwKCYlXkUyqbcmOSUkoZTVPwTQFBhxOwItlOLR0gJXuaMmL4qDVXLuyFx7WY6ukcK6nV63ATc2aE332pcwok3vB4roYjXxoIuqOwLrkITLaYyK5GhOOp+oCoNLLEdRr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=And/xqiXKHmvMX2qZoKKv08P+H3TYLbsXucrQP53gXc=;
 b=Nx3bAoR3nGjMP8D6uiJhUjF4xUZiyafqAeNulyAhzcxTr79yDViBRwzNwOpENpdNtNeIg7YQDmeWdNfWVdOuOXt6fP4SZD5oEjIaBSE5zHdyn/atf8fsm8+ZsvrUPqHF/Cxx6OB5lQZtEMlQuiZ/ZkL1YP/Qc4/jKgxhzgNDsndgJ2i0T6QuLnLzfUH2keYif8PDGBpteqKEPHFWw0v+S+RRxs8omJcck1+tyKoBeckIABGb1Qt8pqkx0lWnPZpV3B6otLPWmsxq1mrlvPNxJigLOjOdyr+PLXjBw9m4pm0guq4S9IMVQPcgtQSOWXu3LFavqjIlafH4nvheUP5VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=And/xqiXKHmvMX2qZoKKv08P+H3TYLbsXucrQP53gXc=;
 b=DytlcS3xQXYNpy413wy6tTyAiW9X1uRATnP9H6L4Wh/taMpw5w0hxzDc3oC9uHumFCN4mHmqULosxAccgWaO6Zup6RpQ1SR+qx5flnFDKzrLaZ6ux0KJ2NSIC4Yf7FYw9LIe35QNQkcICS1LqfeVy0qrgO3VvjArGxIPlgM950A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 06:57:33 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:57:33 +0000
Message-ID: <cde2f8e2-dfab-4202-b92f-83f51e387b21@amd.com>
Date: Tue, 3 Nov 2026 07:57:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fpga: zynqpl: fix bitstream header scan length checks
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>
References: <cover.1792504143.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1792504143.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:a03:333::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec7be76-8d49-414d-6492-08df3977bc66
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261021123027099003|56012099006|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: t2xF3tUEU/2XBzRDF8QF8d5KLE+Q1r89Z0emsiR8eGdYh5n9rqyphpoDQfrOmx3NueCdnhnurH0GIyuqUZWul0LipbHtwbGzXCTtd0EYxySajLQZj7vlIGM8nqDuGkBXLZGhd89NrXx0VUswtvTeJxo3ua8Jyz19JL1dpbabJV8fzH6eKYu2Pcpt8PdvhqIfZhiYfBUtz1Cix05BJ/1i/9qLgioDGnVI5agdUtmkXXnA18LqAe7KHck46dSkFq07u1XPoDZTqlMYoKx3fZNDNksCE/5Y5q961D0jdPGr1fSzzZpv5k8kTaVF3DPvU+yGqd1Hgdk+VFrUaJ8e/CIwADAaCMjC+3esEmo5RCk0vff29wnBqMzzdGsCH1GITPFpXyURM9o2OSP8HVIqYvQVn0i5J1dHPshFli+vF+LOD6IXNKItUWQ3APhevTPlYO7l+pfxk/EJ+XLVGG/hutRyHy+OT2sL4WNo+k7TL3e3C+Oz5NOJvpcjl4d0Etqm9IwhDfxFJWjh+rJcZz+TqC9pzjWohXTg76LzI6QaAk6FxKfx8DZP2VJ5KIC3g2bjXP55Lcn9it6tb9lgM4Inxn3Uui4mwwC2W36FDdUwzkqoL5Kp3W2j6SrOkb42Yh35H9BZkgGag0oru/YTIV1QHQxApjTGgI0Mo2oFykB34YS8cw0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261021123027099003)(56012099006)(261021121427099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUFIQ1B5RXJaOFNXalRLUTRvSHg4OW1XUkJqd3dPMDhBY25YTi91WEFKT1pq?=
 =?utf-8?B?MDdjcmVZL3JBRVJMNFZoVnhOaVUwSDV6T3BGTnFUaEFPQmVaTHRhSXVFZTlW?=
 =?utf-8?B?LzNkKzBhVExCTmwxdnp4cjA4eWdzTlk4My9VU1FIa0QwRHZoYlJsNEJlRW1E?=
 =?utf-8?B?d1hmSStvNkZLSHUwU3NHZGZFakFPRmp0cy9iVXNSTlNiWG9RcXhabnNBZ2FT?=
 =?utf-8?B?eVlSS2hFWmF1RkZOTG1NdjEwRkgySkFqLzhKUS90UEFSb3hWRXMrM1p4NGxj?=
 =?utf-8?B?WXc5RFBKSitkRE9UVW50bWZ5c3hBV29FUmcxT0toVWMvV0FKbVFoMHpuZjBS?=
 =?utf-8?B?ditvSndNcmx0eFVSSEFVbmZqRmJHMk5TWjRvMXNEcjFGNTdSM2VpM1FHb1c0?=
 =?utf-8?B?L2lkYlRqb1FOSW5yL0IxOTY5MWRsbnN1czhvMmVMN2tDaHRkUUdacGFSM1BQ?=
 =?utf-8?B?TzBpMkxvcjFKN2ZjNExSVkk0YnJkRTRkR2M3N1FudFIzTHE2aVN1OVZManZl?=
 =?utf-8?B?N1kyMkJwRXU3WGFYTG9BWW9mS1ROUFZNZ0d5bDFmVHYrRFZTRkVGU2EvZGF5?=
 =?utf-8?B?UmIzQ2NwWVNJY0FocFJmaUcwNE9pWUMxM2FYRjYxdENqbVRmMFZFZCtzWnlX?=
 =?utf-8?B?RlNweE84b1pId3ZPWnVNa21hcmx5MTBpMm9LV3Ntb3NCZGN4bm5xRnFFRGpv?=
 =?utf-8?B?OWtRR2xqQ1gxVUdPSXdIOTF4OEc4YWlnL0hHdlF1WHExemliYjFWZzJrbm45?=
 =?utf-8?B?MTB4cGgrTTlFWVQzWm95cE1uaHVFMHFNb1poTCs1bkpjTXBRekdkeFlhY2NG?=
 =?utf-8?B?UkVMTkIxY2Yrb01ZaDMyYVpoVnJQVDNuYUQ1eXhRd0x5bURIUjZoK2RpMGtU?=
 =?utf-8?B?dlkxUzhhbTNLRXlQbE5teXFPbEJVRlB0M1RqUTdMZ0o1eUZ5TnhhQktJVGtp?=
 =?utf-8?B?bjZhUnhtSC90d0lBQy9rdkh6eXdaQ2huQi9ieGhTRXhxTTdPT1VRVUYxd1hm?=
 =?utf-8?B?MmN1NE15Q29ZR21OWlNTRmIzMGpUSXNTNVNUSzJoZ0F2VU82WmVHdHczTDdt?=
 =?utf-8?B?VVhFTFM2Zkk4Z0pyblVHSEJvYUlNajNCWDR1Z0R3aEs2Y0hVa1QvZjBWQzNy?=
 =?utf-8?B?Y210UzdZN2NCMXR5QTIxM2VBSUlzYk43ZTFlUWVwckxYTG9xYnVIWGUyTUNi?=
 =?utf-8?B?NE8xWDRQSFZEYUFHLzF1dXFscmppV01RRm1kcmxaYmJSZndqQ3BVK1FuRktB?=
 =?utf-8?B?dlY0TWlKaGhOMVFkNUYrQmQxNHhKSTQzZGorZE0xRzlpNU9WbGZ2WnlpY1Nj?=
 =?utf-8?B?aG9qdTlibjRpS0JoR3R2TkgvUmcxVmRndFQxcFRVelcvT0VKZURhZUhWRy9m?=
 =?utf-8?B?NU14V2YxamY0aFdDRCtSQkh6T2h5eGg5VDAwVzFDQXZQUTdRQ0Eyb3JLcmJk?=
 =?utf-8?B?dVl5QnNKNCttb2VFQldqbTAyRFRoZHlpdVJsRDlhM2dRYjVYdTAwL0cyRi9U?=
 =?utf-8?B?ZWtpVnI5VTFJWFZ1SkpNaFpBSWp0NHFpOTFhSFlzempOTkpsUXBSdnFBbUxq?=
 =?utf-8?B?djZWNnZXdCs5UTJlNlp4eFd0WWw0Z2c2Ty9IeDBzeVNFbWZUbFhCWUc5dTlB?=
 =?utf-8?B?bzVLT0ExNkdXOGJ3WFpySlIxYVVnaVJqM0xhSzZ1VC9sYlcyeFNiWEU1WkZP?=
 =?utf-8?B?eW1aZ0NCeUV6b1MrYjYzT1EyNWdpdVlacThIaEJCajhkSmVER24ySmViZE9t?=
 =?utf-8?B?STN1SmRRYWwxTVdtWTBEYUk3ank3Tkg2OExuSkxuVEhNZDgweEoyL0cxV0pr?=
 =?utf-8?B?UzFObXkvN01yb1g1TndTbUl5Zkphb3VvUFQxUi9KeTlQRmJNcENyVi90ek9j?=
 =?utf-8?B?R05UM2dCN2pYQkZoYUxEbjlVOUVRbVFyTTRWdVRrb2xHM3FNdjlvMFVHenpV?=
 =?utf-8?B?RjFhQ2NRT25qbVlYaDFXVS9DUlNQS0E4TEJnb0pGWWZ0NTZpNFQ1THF3U1I5?=
 =?utf-8?B?MGYvajc2VlVXd3ROQWhvdC9PTUFLbU4zaG9PdU1ycy9PblRpVFIvUWZFTlhD?=
 =?utf-8?B?b1h3VXBOaHJWekxiYUx0ZVJzSm9GaDUzajVZMWxJUWQwQ0xHMnJPSzEwdWJR?=
 =?utf-8?B?dHVaeWhDczdla1pqdjBBV3dlV0dMTG5tY3NpRkU4K2F0T20vVU56d1pBYVFi?=
 =?utf-8?B?ekhkVi8wQW9YQzdtUExXNGZnbVJKaTRsWDcyWFBWV2puOUhMK3A5ZEZNRWpt?=
 =?utf-8?B?cHFNK3Y2UmU5eDAwU0d6OWl4Q2RpUnlLRXdZVU9zaTVtdXlXY0V2TW92dE1P?=
 =?utf-8?B?bmE5U1FUNUVMeTdQRDZ3aTgxU0pZNkhOUGphd2xJSTFZb1MwQ2Vqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec7be76-8d49-414d-6492-08df3977bc66
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:57:33.5290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQd6ktxLhw7zGCvHrueOmhaU+js1xGB4COrZPapS92K2lHrAkNOICwZQPEvlE04M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 15:49, Michal Simek wrote:
> Hi,
> 
> This series fixes bitstream header scan length checks in
> check_data(), reachable from fpga load and fpga loadfs.
> 
> Patch 1 stops the bitstream header scan once there's no longer
> enough room left for a full header. The old scan kept checking
> positions near the end of the buffer that could never hold a
> complete header, and a match there caused an unbounded header
> read to go past the buffer end.
> 
> Patch 2 fixes zynq_loadfs() passing blocksize into
> zynq_validate_bitstream() after fs_read(), even when actread
> was smaller. Pass actread so the scan length matches the bytes
> actually written into the buffer.
> 
> Thanks,
> Michal
> 
> 
> Suraj Kakade (2):
>    fpga: zynqpl: use actread for bitstream scan in zynq_loadfs
>    fpga: zynqpl: stop header scan once a full header can't fit
> 
>   drivers/fpga/zynqpl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> ---
> 

Applied.
M
