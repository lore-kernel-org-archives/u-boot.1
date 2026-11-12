Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A3606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g/8+oiAA;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=PD0Hv00V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99CBE608F1;
	Thu, 12 Nov 2026 08:39:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CiVq7PQMkUCX; Thu, 12 Nov 2026 08:39:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C02A760771
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472739;
	b=BId/v6e4gowq//3onvjS+NFhsJC7oc0yb9gajKeZFk/3AHXqRCGtmLSuxJSjGW9/x3fJ
	 xVCG/MN0+bx8NU3d8OQEvuJjlUSM3Ojv/quwdiy0v11oQG8+Nazrl01RaykRHrXW6E5j3
	 MjKZBRWawWdpVdKFfZQ1H4hwKq944pY7afwRE2jIKjgMkCnawTjMpP7lhw7YHJhDe3aQa
	 BKuk8PpQQmjxOdwuQJoGmlGy3g9JXQUjb4XiXnrzAQzltXuq8xeEi6UtZwJHxhI6oAEQv
	 GCBAmMKS6/hYd+a/+hFQyLBke5Ati5y+ZhgFyOPlSO5ePoXGk26152lANNyBMMIDVvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472739;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=IoaoIqKD9BeriQmxSp8uayUT9QHcbUUBcdeUo/MCiBI=;
	b=l9U/wKAy53wVvkYd04RBsfcOaJL1Q6GVzqVspuFTHTUvB+jiljexmFkJm5ntVWqBMi5K
	 KpRcjDo7g9W7WrrsoDEmL+6qoOzIyPi22jzG1QQJkT8sjQMYyAjqAURS6aHQMN2+u3FXd
	 jlrhd1fSSnpd9HuyyM/6E4svPD6V6egDutRYSl1L/Lc5e5MMN8UNTAJ9g+J8rnPWGij43
	 chjrtcE/hh1RGOO1yYlTDbFFQ1560HAv/vTf2vKI5Jv+AZairt0J8EeTViaH/WyEd1f5D
	 oGNnQ2ccONChcwgko3YWJdxRDyEd2+gJm7EqUteg2VKmmhG8lyRIuZQKByAxcIGqhuw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472739;
	bh=IoaoIqKD9BeriQmxSp8uayUT9QHcbUUBcdeUo/MCiBI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/8+oiAAXbacWk3+m+aBDkO9/mzfof6TnSaNk+WNTIggY1hTBt7OpH7QQtSSDEJX1
	 6p6t/AcpgMfbVrP67RnCC2GlgVaxI23yAytxRefj6dQRQIPMXiiq5LIAaMcoUS9qIR
	 /CZSKKIPviOqXdQF9b/0Zu/XDlSL8jZqZsm2LlfySJHQiP6qW7c5KiKBbSiDJ9+bvT
	 ppSATmc7IajUSJ9pfkt/I+3X4EDxqTaiEk15itgAVlxFBA/5pI+EToGdfsMyRxEIgQ
	 g1jl9BzXPWsIkRSkYB9afWqgS9OF12CaB34D3S1SXLaRM1B11hjrHugbRBS9Wnilta
	 NAmkvJ7rVC++A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C02A760771;
	Thu, 12 Nov 2026 08:38:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DB3802FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C09E740AF4
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:38:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A1eyIJbHMU9J for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:38:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CA35340AEF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c111::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::5;
 helo=dm1pr04cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=PD0Hv00V
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA35340AEF
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoaoIqKD9BeriQmxSp8uayUT9QHcbUUBcdeUo/MCiBI=;
 b=PD0Hv00VANr+7ejFSnUgPGxJCpbJh6UIPkW2amxKrmpgldlIQCL9owfr9rX96YUtFtHntvCjn7WPAdz3yQu936SVfxd2EA/GC9v/rKR9ethSRzX24NEdPmETiL1A/lSue4ABiOcGvIv3EX2HoihCuhsphc6E0OQLXnfocJ2FG5pfiYVRHcc8YydGf/+k8QnoDZhOO3iZpJGDlRbgRhSMdbK7YFGSeo24r0rLH+A6Fk4S36hF97aqiN9TMZwPPlSposa+RsQ4psWeUGrDxTcXEloX1wURU80bM+WTnN63WSBXFRyweHL9dabxGP2H/rNqP7xsj5X55cZBiTfZx64iQg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 08:38:16 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 08:38:16 +0000
Message-ID: <8c18885f-2b90-4ee3-a048-3b1e01f2fc0c@altera.com>
Date: Thu, 12 Nov 2026 14:08:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: mmc_boot: keep hwpart and capacity in sync
 after changing PARTITION_ACCESS.
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
 <20261112-upstream_partconf_fixes-v2-3-5eba1cf22b1a@foss.st.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261112-upstream_partconf_fixes-v2-3-5eba1cf22b1a@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0090.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 46203307-c350-46a8-aa80-08df40984c0a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|22082099003|18002099003|55112099003|4143699003|11063799006|56012099006|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: EFdLOz4Fj+I0PXxUfgZ2PPJtwkO9lRIKQlgTvYqFOSGYEf4gCjgdP/dSXPjE+pu9WHemh9hKZ8PCg18Wsr7rc5ka6huktMoEzxvIsoqroFYlwE02/cR3h2vZowErzveq7UUEAEOT8qvldwH0FlQ52KBrwm3ol+N4/C140F9SzuBfJ7WIkH2PZ8xqYFTNWMcxr8U2W8D12rLVgHkucQaLbHxFMXkXa5EvpEcxZpfgGpH9s6/goNnoUb5r/G0hxKthk7aDAA354qGS6PvLZYlZKsORW/w6BFIrOcRaH24vvxyOIkN2gKQQbkbNY4whN2kgrP60uM8JhSEVCIL9zois4u5W/WX67zqZN/WKlTkUQCcqn+qPWHb421yg+qEbOe5/jj73tMqVgrXcnPK1LtVGEasitykF4VIqBDfSUjm3TJIiUPg71NilQsOcqHKk0phUvdRfjBgqRlSgAtWAnruNjJAzEHZ8A7KIET4XKrxn+IW8QP8JQxdB5k1qNHignqYJA4xbOYFAqhcWUSZIN3vioTqtRQ1FZW8QG0egZ4UsrUqr1CjlaVdeHfBydGet8O8Z2AuIjf97AOsbaNRPYQ0eXJu1+XKVAwByC08eovoGxkviSAZxNWsHotAC+QEL/hTR9PjPO+hg65qGLpTmuYO/HyfNKsuEnMiRYxb4B2R+6Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(55112099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tms3UEFqR0FDUi9OeDNSZWJXbTBObnpaeEpNU3Ric0NJYmwwcTdJZDlxc1Ny?=
 =?utf-8?B?WmFEUjlQMnEzMDZUcVA4blYxWUNieGx1QnBCeU1YSVNZSnFvcUE2V04va3ZC?=
 =?utf-8?B?R0szM1l2cHBaY0ZsdWlXczZJeFUrSUNmYnMzUWs2aWRNSVJBV2NjUlhYdTg3?=
 =?utf-8?B?b1J0aXJzMzRLckFROFFuTWNEbUZ1b0ZIUFNKOG5JSjYyS2dZSVJGSzZwVkVu?=
 =?utf-8?B?Q2x2U2hjWlVUZ3lxbHJxNXI4Zk5HV090ZVVsZW5ZbkplK1pmQVkvVkdmTzYr?=
 =?utf-8?B?cXZRd2lidmExbGxjTDdZSW5tRmNzcjRWeG9ZQWFFdjJsNEgybm82V2kyRStN?=
 =?utf-8?B?c05ZYTFvVkUrZjQvVEExTHVCUEFxbWlrWnMyc29YZEJJWGRHOHZEUEFRM1Zm?=
 =?utf-8?B?a2owK216Z0xtcmhWL0FleHRidTM5T29BQjFuUDNTTVRTMUhjZVNGclNTWFlE?=
 =?utf-8?B?OHIzS095RWZ2V0lPSm5NOXhlaS9wcHB5ZkxVdkdPeG5tRWhaaG9ZQ3hvMHZY?=
 =?utf-8?B?bUx6U1daaUZsaCszVVN2eWIyTjlqbWJGcjRCWThNSHBGNHdZTWtSeUtBVXFE?=
 =?utf-8?B?NXoranpNbkI1L0xzc1NvbHk2WWRuM0QzeE8wTFZPVjJ0bmk5S0dIeDg1bzl5?=
 =?utf-8?B?VGM0U1NQT29HUzc5aitnMCtHOVorWU5Tb2NrTjdGR0ZCZjlMWVNUbjI2UVZN?=
 =?utf-8?B?M2Z5OFI1RmI1U1dHYnlTVHVoMHdwc21YRnloVXFoMjJydnBobnhWUURqM0k3?=
 =?utf-8?B?YUZIaTV4aGFpMUtIWkxtaHNMNlVDNFZIZFl0MmM1eThYWTZtWEpkTGNUSHFB?=
 =?utf-8?B?c0tPVWFKNmgxMXpJb0kwek5SSEpRWWZadGFrUCtXUkJrRnAwTGprZVVJOENw?=
 =?utf-8?B?WnI5b1FuU1RPbWhoR2ZDWVFSVkpMYVpLU28ramNSci9CMXZzWS92WTlrZjZU?=
 =?utf-8?B?aWxhT1ovZjVRcnAvd2FuR2srNVlkSkxvZXhyQWFhVmdIcGRaN1RxTklpNzdw?=
 =?utf-8?B?SnN3R0tSR29DNnhDeit3OWhIcGIxOFFhVklVL29KM2pPYmkrVnR4dEFEQ0lt?=
 =?utf-8?B?Wkd1THg3YUE1NnAzRHZlY2hqWVBDaW5FNVZNcFpMSHNnUStrWWhtcHVydG1k?=
 =?utf-8?B?eVJyYzAxK2xQWWpzSW1yWWpNN29FRVBRcEFHR3YvTExGRFIvRUp0L1l3UUI1?=
 =?utf-8?B?SHFDc250THh5S2FoZHlpRzBIRFJyUHhwNXZIZXdKUHZuaFo0Ry93S092T1U2?=
 =?utf-8?B?TWlyZkVZN0o3ZlhoTzBPcEVjY3QzWmVudGxGc1lQOW5UU1pzYmRucVpvMTFZ?=
 =?utf-8?B?dlM4SGcwUjJpWCtobVZBdkFlN3dhalFPdVhiWXlXTVpXdU9EbzY4d1hTUTJP?=
 =?utf-8?B?eFpCRURWRS9pZVJ6eW1UZCtZR2FQSEtsVXh6QVNsZ3cxS21tRTVVTTZiRFRF?=
 =?utf-8?B?UCtnTmVQVEI2Y3E1QWFsUU5ETjUxRk41dDMzZWVMZkpQVlhSQjRWakQzZnJJ?=
 =?utf-8?B?YzUrOWhjZks3L1BCZEJCNk5KbFpSbWUvOFhjMXpJcVpyaWpHeGVPM0tYRmFa?=
 =?utf-8?B?cXpHNXVFU0ZqTkw1dlkra3ZBTHoxQnhERXJIQ3NZNW4zUSs5QjRMOWt4VFQv?=
 =?utf-8?B?cEgvc0xMZjlkWGc3STA3a05jSE1pYnZYbkc1WTlPeGR1bjlaelNlZFdYYTVt?=
 =?utf-8?B?REUzcjdJWnJ4UmRjK2tiY0k4MG04V3FrUHRaMUNYVDIxcUJQMHlYc1NUYkFn?=
 =?utf-8?B?THVYcHVVWkNmZWxLOGsrS3BrSDV3TUJPcXNIK3RJZFVKcnR1cm1TZ2RaTk4x?=
 =?utf-8?B?T2FPUmNPUDRIcmRvMS9OamFlRitvZm1MeVNNdjMyTzBOUGhDL2RrcEljWGoy?=
 =?utf-8?B?eVd1VFdGQlI3eWtsc2IvRmxrNUQzclZXTUZHenFWWStobS9uM2gvSlp2OHVN?=
 =?utf-8?B?UXNwZ2dOb1dBVE5IZE5DMnBkNzRRVzh0RnlZSkRMNlhrV1Jyd2JrSFFMQWs5?=
 =?utf-8?B?Sk1uaGJ4V2JRTVNMWWVQRHN5YUFHYTZQSkhyL0xueUZqQ1dTcEw4bXZDMXhm?=
 =?utf-8?B?Z2IybW1jVFpzTDdBZ29RSHdwSm1QUElBTXJsZHNZRVZsUGs0cXdKOTFWSFV4?=
 =?utf-8?B?dCtZNW1TYzc2QlNPQzcrc0RqSTFtQ1ZVMDU0Mm1vR3BSZWxKcTdaWUY4ZEtI?=
 =?utf-8?B?cWh6c0VSTGo2R3FEVDV6d2pvYisyZld0ZU5MaGdneGJsL1kvOHpOQTRYUWtK?=
 =?utf-8?B?QWErUFN1N0dmdXhjblVSWm1JYjRpWkpBZTZwRjZBL0hEelkrMHphWktZTHBx?=
 =?utf-8?B?dGY0Y2ZwTlVLSjdsQVJ5ZThPRkp1WW0rMnhZWmN4UjBmNENNL1FRVkw1aVRx?=
 =?utf-8?Q?Q6/Y8pQ4LUWGqmJo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46203307-c350-46a8-aa80-08df40984c0a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:38:16.7777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltKi+MOAGqIUyzl+FXf0ubfkbnPLs5nWKzRVFUy1egytflAUET5YPHGlegyjmHJ0guypY+5AqWqa0keVSEk41EVCwPsWfqDF87RPtkv2TUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6481
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 12-11-2026 13:56, Patrice Chotard wrote:
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Select the hardware partition after partconf command as it is already
> done in mmc_select_hwpart() / mmc_switch_part().
>
> Fix "mmc partconf" command issue.
> For example for the sequence on STM32MP157c-ev1 board on which we got
> mmc 0 (SDCARD) and mmc 1 (eMMC).
>
> before :
>
> STM32MP> mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 3.7 GiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> STM32MP> mmc partconf 1 1 1 1
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 3.7 GiB            <== incorrect size for EMMC_HWPART_BOOT1,
>                                   still EMMC_HWPART_DEFAULT's size
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> after :
>
> STM32MP> mmc dev 1
> switch to partitions #0, OK
> mmc1(part 0) is current device
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 3.7 GiB
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> STM32MP> mmc partconf 1 1 1 1
>
> STM32MP> mmc info
> Device: STM32 SD/MMC
> Manufacturer ID: 11
> OEM: 0
> Name: 004GA0
> Bus Speed: 52000000
> Mode: MMC High Speed (52MHz)
> Rd Block Len: 512
> MMC version 5.0
> High Capacity: Yes
> Capacity: 2 MiB              <== correct size for EMMC_HWPART_BOOT1
> Bus Width: 8-bit
> Erase Group Size: 512 KiB
> HC WP Group Size: 4 MiB
> User Capacity: 3.7 GiB WRREL
> Boot Capacity: 2 MiB ENH
> RPMB Capacity: 512 KiB ENH
> Boot area 0 is not write protected
> Boot area 1 is not write protected
>
> The previous mmc_set_part_conf() implementation set access to boot
> partition without correctly managing the internal mmc variables.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

