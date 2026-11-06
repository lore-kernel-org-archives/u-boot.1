Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2A606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dq0wHTu0;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=DLJQiiye
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06E61408EE;
	Fri,  6 Nov 2026 10:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Em5th3aptm4X; Fri,  6 Nov 2026 10:57:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EF124094B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793962668;
	b=k6g2aIY9ZtjXV/gjyiKMkaXVGCe8mQ25F4mHif6piYSp4Nq4CFlkL4WO8EwAGaHpACc/
	 ee0xG8nOsyZXzNKz+NyXiIRNe73MkiXSawH5iwD8h9a7jB/W5j+/wDLhS0XdAZjHOUT4h
	 C3KLxPC7YXZuW3usenoMKbCSXH54ImJeRR079lCKoDfwsuNp0EjazwCqas+QvKNzxfnHj
	 l7GcqrZXV+Quv0KvCNtq06J9SdnfbyHYBYFmWww8jduJzT0XI3Ympqxo6BlKSeE9pXnc3
	 hrWQJa/39UP86S0z9NXP9EG8sugCXk2PCBjV27hD+Y9Vl+3LPKWiQyZJOhCbY1e2m1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793962668;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=5UvfLcEdcoDQn/nzgegr3UopElt1FFSPKZNYefC5Olw=;
	b=gFZNqJ4JQU4e2RkFbn6GETowjV8rVRdbQe4lyDWrpYAZloECO3gQcZS5Wb2NhSWqBs0u
	 A+gkW8tJZnq7kFXwtNIPyRAFTagZfgArd7dxaEqTksF8e/4yJgEzI7X0WNNGyfZfrW/i7
	 mgF2V/f7SnSilxnhyKWS81swSnNx7FseaYw9Do7ObPpye8jut64bIggcLPGcVKZNBl8nQ
	 tdbm3k3oxXNQgX7HHDhbg/0yVrouc7i6YyOz1p2MH8Mnsn2PN7zLdSnttF3YYJuTVbMxR
	 B91ZjRS8C89kAdAHyxdJ8MenOnCdVFI/4G3VbO8ugRcuc0ND32gIyAUA+ERrgmCgezA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793962668;
	bh=5UvfLcEdcoDQn/nzgegr3UopElt1FFSPKZNYefC5Olw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dq0wHTu0KcaLhV+XywREjavIj9NAyHM4+cwol+MXjkt8VNYXfl4IHsQT3aj18xxft
	 NYysH1DTgHAmBxdrbmn7fnN6JoL9QHu4fOf6tCY4qZPrIqYmyBFwacevFDWKyJ3eb+
	 Z5cFwvvtGTv3VYQmuEdj88b0LFjSp9vLX2P464PAiqmkP3QWPGypQx4JRaGuqpiCGr
	 aqhZ72l8eQJPWRJVf5hkjCZApXMifU9XTVb734cXBF8+ST18CLKcdLhEDB5zZF5/Ur
	 S67qK15VrV7Bt2mDAmmJaK0JDpOFNnFUu6Yz8zxaYlnD9I0+WKznNKsfKS7QpX0/pj
	 KM7c7XHia49Sw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EF124094B;
	Fri,  6 Nov 2026 10:57:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56B091E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D456403A9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FeksehSqb3bZ for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 10:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 69B9C400FF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=DLJQiiye
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69B9C400FF
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 10:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UvfLcEdcoDQn/nzgegr3UopElt1FFSPKZNYefC5Olw=;
 b=DLJQiiyeFfG8yPgmBscNCNBdgJpZ0wllqLtW1u2mwlqw8/MvHYjb3BwJ93rMrhhve1LdLAT2wd5gCGloGL4ahVP6lveqPNyylKHxeYIyQ5TzJXjkpFt28zKKdmohXRlWNAFwSiY9NSu6q0Ui98j4YH+xSPCBJ3SqomNQGfRn0mw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB11098.eurprd04.prod.outlook.com (2603:10a6:800:293::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 10:57:35 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 10:57:35 +0000
Message-ID: <548adaa3-9d2f-4fa2-8fdf-7c537c4d153b@cherry.de>
Date: Fri, 6 Nov 2026 11:57:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/30] usb: dwc3: part 2, make the resynced code work
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: u-boot@lists.u-boot-project.org, marek.vasut@mailbox.org,
 trini@konsulko.com, ilias.apalodimas@linaro.org, michal.simek@amd.com,
 lukma@nabladev.com, alchark@flipper.net, jerome.forissier@arm.com,
 dlechner@baylibre.com, anshuld@ti.com, sjg@chromium.org,
 Thinh.Nguyen@synopsys.com, mkorpershoek@kernel.org, love.kumar@amd.com,
 s-vadapalli@ti.com
References: <20261028141554.3073545-1-anders.roxell@linaro.org>
 <b464c545-c1f4-461f-8f17-48854bd70825@cherry.de> <aunlk5FaVe_jcpSr@monster>
 <ca7b3725-cabd-4064-95dd-46c3eaa325f0@cherry.de>
Content-Language: en-US
In-Reply-To: <ca7b3725-cabd-4064-95dd-46c3eaa325f0@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIYP296CA0009.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::8) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB11098:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5899bd-6ebc-4528-fae1-08df3bf4c3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|22082099003|18002099003|10067099003|4143699003|11063799006|261026121527099003|261028144727099003|261026140227099003|261022075727099003|56012099006|261022105027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: G1HI8RV19HTASzvLtlrOyDQK7xKicwd1ShbwOrAoYEfYS73xtpTfBOziCfnnVfwsrqq2ShaDMLgtJCCRJQLpaYPSOGzegohO/jKJCcF2mwX1cFq8cPDn5Rmmes5QlAAYs9ZtHVAbqeAuJIePhw9P39rQMsuZ6JUV8gQ14hcaiVnDJSEA8vBFu0ioqmc0GJZbk7cZNrZKVTNknlc0BkO7t5RTNxdKKiRQqFUWpzaB8RUlXsK/CLyQLNlehUsxMuUR3eHcYLgyg0GldW3a0c5EEaGpIv7vYKVJ8kCeX0hEqO782k+wuV9FK+HkY1ZzQQ58DNlXkwfUaP4bUNtvK77NAweYuUZRjtuOcqPm0YpXnGe7GUYF9irye22jbTwFay9/0x4+CdI4n6namhIBxwB0vFxesJTIm0azWIguzFCOsW1g9qICVQqWhahWDwkwq4f99OSIr4stJHNbkuV8hcm34gUGeYU+5x4GISgBZPst61U2NnEBnYEps0sch0eMc4Tm+LhaXMDi45Qge+NLIkQFeTByuVRAWfKugd92OiEJ5s8x/TQK2/xnx1GMAUKfvoFt1IlNRZDbICj1E/9ZoreTF5WUgGGoj8HRqhNVW0Z9kUCt2Kcsdreti+YDesSS2GlTj3qCN4gCRRZvPONql8rffyAC1+yfW1XxFeDVsO441xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(261026121527099003)(261028144727099003)(261026140227099003)(261022075727099003)(56012099006)(261022105027099003)(261021135927099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDBoaUJ4MFFCTStBSFdYUHQ5bVNsY1FzRm5HT01YaUZGbDFzNUJsZ2hyU1BM?=
 =?utf-8?B?ajh2bmpjK0dPSUxpZEdkc3Fqb2JmL2xzSXYxcE9pWlU3eFdrWUJvODZxMS9z?=
 =?utf-8?B?QVJUb2VSR0xhTjF2cVFyT2YxMy9MSEpsUkIxL2g0SWNKa1NFTTRVNEdaWGNn?=
 =?utf-8?B?Wms1OG5pTFhHSDIyUExQeHo1ckNxNDJMdndQbWtOME1qeUNLK2NScEk1U0Vq?=
 =?utf-8?B?R2k0ZHVNM1JOdW9MQitFYlE3YWZQQlZ6VWNvNzAwN1RsZTRNZnY5VDh4TVF5?=
 =?utf-8?B?blBoZnJPUVFCeUd0UVk5NUtFdUNYbnowbmliY21FdjBkZUIwT3drcW9KeEFI?=
 =?utf-8?B?R3dwRjd4VCszYmo0NEM3RTVHd29JWmM1ekY5ejhqWTR3RlRRMWE0UTNBMTg4?=
 =?utf-8?B?Vk9xZFVyOGhHN3lWQ2tWSFVmd0dFeWFIV1RyMlpsc1F4SVpHQmFLSERxeWY3?=
 =?utf-8?B?QVltamxBdjVtb0VydXJla3E0RE1taEV4OEJWSlRmTmtmOHl6bkI3czhEM1pm?=
 =?utf-8?B?ME03eEZvMCsxZmNjck45SFRSUGt4WkZ5VHhEZFJSVjN4ay9BQmNNQkZOcDJT?=
 =?utf-8?B?UzhZNzJlNmQybnlYVWxWZE5KTWlqcCsrVFlkR3orNDUzQkcvQnc0MVl4Q3di?=
 =?utf-8?B?YnlQNDA2dGlRUThiZzZ3b3JWM1o4RllJRXNqcGt4dkF1a0lIV25QNmlETXo1?=
 =?utf-8?B?REhyV3c0MGFNYU5qUGdDTTBURUJMY3R2K2dyTFh0c3hseWxVdE1YZTFLSm4r?=
 =?utf-8?B?UEJUeUFBUUd4WGgxMGpMMm5mU204UUJIYmZEZDlvNVBBc0tvdUdhZ1gwUm51?=
 =?utf-8?B?aElaSDlRTmpLMXEyMWx2dkJaendQZ1UyeVB6ZUxCdUgwa3BKOUQzR3luTkMz?=
 =?utf-8?B?VjR2QlNSZUV4YTh5Qy90UDA1NUNrM0tKQmNQT1FOVTJHWWZUVmlXcmJ1TG1a?=
 =?utf-8?B?WVJ2ZzlaVnlJMGdmVzJHUUtHejNIN2EwakY4TVFXdklESWEybEZSVERvbEZ6?=
 =?utf-8?B?ZXVLKzM0ZlUxZlJkWUJkS0ZBNXV1ZmpsanJJVUdLbUw3djNlbExkaG1BSE0w?=
 =?utf-8?B?M043Z3lkMzBqekRtWWE3Q3BFRGtod0UyVEdaYmFPRHUyRmI1YStHSExxUG5r?=
 =?utf-8?B?Z09uT25VeXRIbEJlN3pWSXdSSk1XTWFLMmhyTWFiZS9vaW1LSXJDa0lqYWh1?=
 =?utf-8?B?N3lQMysxY0ZHS1F4Y1ZCWFgwZEg3dzlmQzZoUEZvckppUkRlUTl0a2JXdTFL?=
 =?utf-8?B?Y0xvam1BV1JkYUw1Y3VoclhVQURqZngyRFUxR3M5SVNHQXVOTkptMGRGNmhT?=
 =?utf-8?B?RXIvVmpjSWJGL1d2U1RkcGdIVjdLbW9qQXI5dG9sUkFoak9LekxPdjU2cU5k?=
 =?utf-8?B?eGxRaWx6RTRObWlJdUhrZVFMbGJxcTZIdWpqZ0duY2ZscUZvZ1hzQnFEb0Jx?=
 =?utf-8?B?NDF5Mk81My9EQVM5YmhSRTlWazNmOW9FOUxWdGZKUHZpV1pqU1l5cmJyQjB2?=
 =?utf-8?B?OEdFekVSaU9vSkttZGszM29xenhzZ2tKUXlUKzMyT3pRQ2U3R0RYVmRBM2hU?=
 =?utf-8?B?NkQ3VG11dnpsV2tjV3lnVVNYTnNlUXNKd2ZHUmNuNXRjbUhBcTBURUx6ZW13?=
 =?utf-8?B?emtYQkVramJ4MHpCc2hPQm9hMHRkN0pEV09QMncrczBwdzRRb2puWlMvSjRj?=
 =?utf-8?B?RXJLN0Nicm9JVThQazh3OFNQV1pLbFVjVmtGVU9yV0NEZjNnbi9sSG9xcTdM?=
 =?utf-8?B?WVRYT2JRSGpQbVYzZGhsUCtTT3RLMU94RVI2Z1hlS3BCLzFpM0Q2ZWM5OWdF?=
 =?utf-8?B?V0ova3N5MWlVeW1TV3VXbllWb0lCVUJ4NkdxcWVSOVZZR3d6MWlUZmpjNGhn?=
 =?utf-8?B?QTFza1lzeVNqQjlmNFZFdHZjaGRTZmluRHkxOFMxcW96WVJZQnJjM0RlTjRl?=
 =?utf-8?B?YzhMdVhRRWJDakN5UHJFN2xhQkc0SGNUWVJaZW9VQ1MySGdmY1I2MXp5YkNU?=
 =?utf-8?B?MW54ME8yWk55cGdTdDN3dFNtMWFaWm1oTGFzMXA0Y1A5QVdua0xxZnhrU1dl?=
 =?utf-8?B?Z2d0ZTdVQUFBOXEyZXpQZ01TMXlBSFdNcVhDNDRMeDZRWTBjZExJUjAvRzVS?=
 =?utf-8?B?eE1WWFUvVW9XanBCUm9UeVdxeFcyUlA5cDk4Q0R3TU9Fa1lSK05xMmJMb1Na?=
 =?utf-8?B?UGN4Q1hFT1plYnFrY2tUWjNkSzAwSG5zYnFwOHFqbkw3Qm50T0NrN1pVd1Bs?=
 =?utf-8?B?NHhoZGF4V08vaXBaMFVnNkJmUW0vT2E3d20wSmNQNXczK1lsTXZSZGFsb2Qz?=
 =?utf-8?B?VEFtNFlkMng4UXV2Yml2YVdqRnBnY05ENkM1S2RtNklha1FwN1dWdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5899bd-6ebc-4528-fae1-08df3bf4c3bd
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 10:57:35.3700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNJVws2S+engewDyBa2qDN6tV1an568XPfGXFEnNzdXYXBf87ydUA6RQtVu3D/wX6Wym9vzXKoVRJGAbP0nZ7DbPpwDactfMoMpleRMbDrc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11098
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

Hi Anders,

On 11/4/26 6:51 PM, Quentin Schulz wrote:
> Hi Anders,
> 
> On 11/3/26 2:45 PM, Anders Roxell wrote:
>> On 2026-10-30 15:28, Quentin Schulz wrote:
>>> Hi Andrew,
>>>
>>> On 10/28/26 3:15 PM, Anders Roxell wrote:
>>>> Hi,
>>>>
>>
>> [ ... ]
>>
>>> - Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
>>> - Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,
>>>
>>> RK3399 Puma behaves the same in main and with your series applied.
>>> RK3588 Tiger has some regressions.
>>>
>>> Q7 USB P2 (upper) doesn't detect the Sandisk Ultra Flair USB stick 
>>> anymore.
>>> It does on main branch, but on the USB2 controller only.
>>>
>>> Q7 USB P0 (lower) has issues handling the Kingston USB stick. 1st try:
>>
>> Hi Quentin,
>>
>> Thanks for testing both boards.
>>
>> About the OTG port: no need to spend more time on it.
>>
>> v10 had two bugs in the dwc3 core. It never read the core version, so
>> every version check was false. It also cleared the GSBUSCFG0 REQINFO
>> bits on every controller, and main does not touch them. v11 fixes both.
>> My best guess for the Kingston write on P0 is REQINFO, but I have no
>> Tiger to test it on.
>>
>> Did the other sticks pass with v10? That is the Ultra Flair and the
>> Extreme Pro on P0, and the Kingston and the Extreme Pro on P2. I want
>> to know if it is only one stick on each port.
>>
> 
> - Q7 USB P0 (lower) with Sandisk Ultra Flair USB stick,
> - Q7 USB P2 (upper) with Sandisk Ultra Flair USB stick,
> - Q7 USB P0 (lower) with Kingston USB stick,
> - Q7 USB P2 (upper) with Kingston USB stick,
> - Q7 USB P0 (lower) with Sandisk Extreme Pro USB stick,
> - Q7 USB P2 (upper) with Sandisk Extreme Pro USB stick,
> 
> was what I tested, on both v10 and main, on both RK3588 Tiger and RK3399 
> Puma. I only reported the ones that didn't work, so yes to your question 
> above.
> 
>> Can you run the same tests with v11? It is on [1], on top of main
>> ab4dc5aacf95.
>>
> 
> With v11 checked out, I only tested the scenarios with regressions I 
> reported in the previous mail, that is only, on RK3588 Tiger only, with 
> Kingston USB stick on P0 and Ultra Flair on P2.
> 
> 2/2 tries were successful (regression gone) for the Kingston stick on P0.
> 
> 5/5 tries for Ultra Flair on P2 (detected on the USB2 controller same as 
> on main) were successful (regression gone). I got one try for Ultra 
> Flair on P2 that reported the stick on the USB3 controller, funnily 
> enough, the only try when I got a "cannot reset port 1!?". All other 
> times, the USB stick was attached to the USB2 controller (like on main).
> 
> I would like to run all test scenarios again and see if v11 introduces 
> other regressions compared to v10, but this takes me about 2h 
> uninterrupted and I'm not sure I will have time tomorrow or Friday as 
> there are other fires to put out (still have to review the OpenSSL 
> provider thing again, and I'm now finally impacted by it myself as I 
> updated to Fedora 45 with OpenSSL 4 this morning).
> 

For the v11 (commit 6030c4d33099 ("usb: dwc3: enable SUSPHY again after 
xhci is registered")):

Tested-by: Quentin Schulz <quentin.schulz@cherry.de> RK3399 Puma 
usbdrd_dwc3_1
Tested-by: Quentin Schulz <quentin.schulz@cherry.de> RK3588 Tiger 
usb_host1_xhci + usb_host2_xhci

I've just remembered I've now got a Pine64 Quartz64 (RK3566) with two 
DWC3, will try it next Monday.

I should have access to a Pine64 Rock64 (RK3328) starting 2027 where I 
could test the DWC3 controller in there, if I don't forget (90% I will) 
I can then report regressions, if any.

Not having access to any RK3528 device with a DWC3 (MangoPi 28k, NanoPi 
R28S, NanoPi Zero 2, Radxa E20C, Radxa Rock 2A/2F), or to any RK3576 
device with a DWC3 (Anbernic RG Vita Pro, ArmSom Sige5, Khadas Edge 2L, 
NanoPi M5/R76S, Radxa Rock 4D), I cannot test those. I'm assuming Alexey 
may be able to help for the RK3576 with the FlipperOne device (or others 
since he has quite the collection of RK3576 boards IIRC). For RK3528, 
maybe Jonas can help.

I would like to give the v11 a try on RK3566 next Monday before giving a 
definitive go for Rockchip platforms, but this looks good to me.

Cheers,
Quentin
