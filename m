Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D47ECA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:08:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1237140663;
	Mon, 12 Oct 2026 16:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DdWhXqpcYmh; Mon, 12 Oct 2026 16:08:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 61E9840576
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791821301;
	b=ovHYGbGbLlD2X1FwkkyMv2DR7LDsAZieLLTbZPCDHjH+UAA843ugVtlObDbhrcGKUCQo
	 vaSxrQIlIFdo6V+0Fz80eUkkxLE8PQxXr0q0ay4ggMRC5FS3R7GOmsa22PZJRgv/QO9gS
	 OY9jkW7dJtloDAEk4soj5pw6JIHq/zsMFiEHqGkmsIUy/NjELSrV+fOVfutCtvfWFSqg2
	 q5vz5hDfyckWH3JAs3tDP9Qd123QObFdEkOmHqH1WHD3zXLgux3I4XulxtAHEaZE24Zhw
	 88GC1wG4k/B0qUjF8LQs6dBJVKDxiJHRDN/8rSYr7o2ERQcCoAA/YkitvtBynYkOi0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FswbV22jtvlUYlC8aBfPQChCf6OWSDbGdEDgjOGKK1s=;
	b=ZIWsy+75lPgUP/qQLCAW3OLczZHtO9APK5mmqbWUCdj+tlzdQhfF7kFvW/HVbxytZezP
	 HXtzk4c4LQIGIq7zEYPWsz5ky0d/n5MousmZNUDqZZYZKk9xE/TqPaefd0jvbiS94GbGe
	 zzxY9A6jCYsWygmFwfNZnNKUug8gpNseRdjUVmFV1NWyH6ugKhEPh+W9aayXrrKW5MQlX
	 y0Uw+3v3YOACbLpv9+JhdcxzOOU2JnLf10C0BapocRbq5b7XyOqOnsfjw1UhCoIm2Zd2i
	 0uGfxZAgcugPyHhCqAIrQjXxIHnNiewWrhnIwbylNachypi5twnjqG27Vl/FNJ3qL0g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821301;
	bh=FswbV22jtvlUYlC8aBfPQChCf6OWSDbGdEDgjOGKK1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NRCmK0Si3D31f8g9o6JsXdLpIxa45QscNLoNlct5coTcMGIZGK8cJVsSlijdp8v+v
	 K9DhssaxEl0EKkZQ5TX924tdbgS3h39yhCQpKiC32Zfue5BttEEi8oxgbyC7Vj20Kw
	 Ab2b70icc/y7ygwVDcudyVMaURaH4+QjG4OpBRGitSt/b4dnOV4ixjacXj7OPLnIBq
	 OEBIKyLE/fPWsIvJLGdnFYHNIjU1pZ6gam5hSK23LjmQ2e5A3DSzuSSXZDX6oQmigF
	 YRZMtCngL5dWXlBzHDhWjwb+cizLTMaIuYINdxk1uG+FmTPhkVzBchvzidYQ3eUABM
	 oDiTRf4d0I49A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61E9840576;
	Mon, 12 Oct 2026 16:08:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C982380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D0AE40201
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id plISpxYb5cmu for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:08:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5602940200
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821299;
 b=FbvyS8sVDTL0ov/kMnPv5MHFxzntr/fCUzvd37HVSuxbbEy38sV6gCE+x/iDkrINPFvs
 ZKAHnYsEkYH8/X7Fk78BrQ4uyFuH14lCKeZ1fIKJVcGslbvnI0vnh56KQ1Q+jHOkrGYXY
 W7CHT+07VV0PeZjOhjSOC84MmVfBeqaTXXggi5todgmldclym6OgRqufS5llHZ+1Lp6qp
 0o5KhyEkG4SrrSxCAryr5S8ORizMKwhc96f8XaN51B8Vdut5yKd+vRP7a9Y9iBLwsM3vb
 BGdawASwKkkBocL42t+tWY77C+9TtuylQnATs/gKuo9W0gWSYYuhQ/oVQ70RtMWCAag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821299;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=FswbV22jtvlUYlC8aBfPQChCf6OWSDbGdEDgjOGKK1s=;
 b=KnKmLjmtdsa2ySfbvwuxA7v749S8IX3AHmojbH65v9eU01fmBKeF1CCQhiZeHPmBeW41
 eZt5Pl54YQ2r3m6ddd+b3LInB0OTglPLUffbtCXaDfJdLT6fJ9trwCl8vkGhVyc9S7g1K
 debNzpwg5d/tnIBKJUn1j6/c0jRA41nEJxVy3WcG9EB/Z1WK/VnjULQH/coycT9uTMnrY
 WhWVTFlEgSKp4M572BfJcfcaVPAOMUVZRD+ATx9pQTdAHDbYp36WjkFZ7xAChlppe/s0G
 AA44KeLRzxHaDy9h5v/2Y2Af+D487TiYdeq8Yjd50n/yiwBoC1T+6EYf47ErwES8aPw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bbT96Hoh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=bbT96Hoh
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5602940200
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F03DhLWKnZpTUAlwmrNRMGQap3Czr2PZHM0FUkWJJVCF5+hxU/fjUwiWb6ZAbF2Tqi3cM7lVDy8QJCEv0KTFjqu9nUC0bt5AjM5QgGGA2DV4sJG675tRS6G1FMo/BXZ7OGV2a7VJFOgwerK8kKUxXP67tuLPw83+QFZ4qKKRS4rT0lE3mn2GF2wOjIaarYp8a92Hh08dCDoCM63JzzxF3hH/OuThA4gHz1Cu+rkS2lq33Lk7gk7z38pnBhGvSMI9PE376A4ZQPg868iEMFDLI+SyWXt7I1zrpgVc5d1Zca9hvM0ZPD4akzAchWRAHEa/GyFa9KVheli/ZjMILCQPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FswbV22jtvlUYlC8aBfPQChCf6OWSDbGdEDgjOGKK1s=;
 b=Cj54qw3Aol7xV/NroCw0vbzo6LTHvqdlAsVM7m2oFgeUq/GkhDyFBu4oFpih3W2uxY0P/dRtGDA39ES49wc3/hNTcyiPJQcj0rIkOCa//uqy+m6oz2LIGuzTb+O6lR2NfacSOFGAjIF5ftIInFHFqZeHpMgKXIQeM8nJnd8rK76H9TzaGPIm9PcqQeWzYCJye6FGFpSgnYwkFRPfHJYhgqooMhyy4+afBq3On+e2vtXjHL4BCfnGZSHlAehVyhzmbUzHpshmLZGzH70c2dA0Kr+4qFayRh7CoiHQH4Nxnn1nHjuAkXKwWFORbHfn7PfVd1Jsw9YmaSERWlsg0DWNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FswbV22jtvlUYlC8aBfPQChCf6OWSDbGdEDgjOGKK1s=;
 b=bbT96Hoh0zJaQ17Xf/dYzYK7JZXN/TKR0Snz+912a3f+dlhy3YHOa0JT4JmoVSzG8eyJ88V4OntCzjmNvqmH9gDLFzzaj3is17f0pMhmOkwtduiZnS6r4Z4ijChUBbjU0nj1MDDMezx9QI0Vn29m2cEg99Uv8LglQRSuPEdJQ8k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB7581.eurprd04.prod.outlook.com (2603:10a6:102:f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 16:08:15 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 16:08:15 +0000
Message-ID: <3b3b951a-5b51-477d-9e86-12a173a409be@cherry.de>
Date: Mon, 12 Oct 2026 18:08:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] clk: rockchip: rk3528: Always initialize clocks in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <20261012111552.1173161-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261012111552.1173161-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0096.eurprd09.prod.outlook.com
 (2603:10a6:803:78::19) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 594f0ca9-d230-4e3a-a147-08df287b05d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|366016|10067099003|11063799006|4143699003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: gGI+haM9V3JFajLm/svs53bygldM8a7q49U+i0aCr97jyHDpexNUpS71NV+qJezt3LXAl4Baz5WpKYcBtnVsvN8vL/f/B5Nige5Zf7DKTs9RDU+kBLl4ArEtt5ru1l0sDpYaf57EFzJVsicGwb3dhr3AJgvqcEY+bTZeXd4nBVojfNC5QbAkADLnWMSPWTjdDzjjMzZCA4w+SIiAmCNyq038Evt/RSbVmZZmEt/imWFa/yc+PmnTk6i4ORxWcZnoqmJE2WX28exq+HaGVSYj8wvr8eFY5IM5wY4in/xxiWnrfsN4/PziKIVxXXnLtLjfmAAYQJgU2talmNjm5m5pnfCD7X37sqEPeK/EYlW/EuDaoNJzUbgKGfOvVE6I+CFY7vtGNE2us0jM6eqCrEo2dORaQ94ITxoz0bux6JkngFtCxFJENQa+FXPVgrdKlAdnukiRMRIO4KJXT2T/NG11RrFNBJHoJ4r+yagUIMaFFSOwtdn+PnH1DH29yLX+MAQ8SoH5pbQcde/0vf06eauYph2InfKAHn5/2hP+cicCoC0hZrPTDovj4e+myIDsa7QGNaEIAK0o3dUf5efnDuF63Rmm4zQoiSwoW6fvGaExakpc6g9H5so0dMJnyjETPTcJCgfRPkIIvOtf2XM5vbrqEN3VA3gmyGyFEIzfEJS0H5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGQvTHFjd0hDYldBNnZZRE40dVR1dDVIK05uK20wRDZHSmdwZVo1eTUyWE93?=
 =?utf-8?B?cTBDbm9Ja3hSMXZUdEtvL2N1VHU0aUJiNG1oVWtZbWZmNkczWU9pKzVLQjVx?=
 =?utf-8?B?Y01iSjFwbXJSczdNU3BLZHAvZnZjdUtEazlsSzVEaUdRcWVlRVZDNVdaakth?=
 =?utf-8?B?MW5teHIvNUN1R3M4VkxTVHRzVURxRlpSaiszbVVYbldGODdDczVqR3VyUlBu?=
 =?utf-8?B?VVhVTFUvOExBN1FnaUl0U3lXcmhLMFVsd3lldm9zNWhVNlBia0UwdmRBRUgx?=
 =?utf-8?B?WDhJM1ZIWmloL3pPeFRrMTJEQVlkZWZBVjBVMzM3Y2VPSkExVzV1S0FQZjVU?=
 =?utf-8?B?Q3NtT2Z3Nko2WFlGODJkVmpEaGVxZGRCTWNialRyeW82Tm12V202bEF0Z21v?=
 =?utf-8?B?eE9NMzNEM1VOZ29ZcUVYS09vWjFQWmtrc251b09oTllObDkvMHQyTXBPcUdv?=
 =?utf-8?B?c1UxWXlUK0xhL1BONHZJeVh5SkM5RzVmTGd0QkFsVjZ6TjhCVk9KUGhsclNy?=
 =?utf-8?B?a0Zqd01ZOFRubXNsd0RGQmNDTEZSU2ZmcXJxanZHSzV0RjJOTCs3aFNmN2Ro?=
 =?utf-8?B?alZhM0dBN0c4SVR1MW1SVlQwY1k4U1dMY2VmUjBYSktxT0FQa2RqUFROWURq?=
 =?utf-8?B?NU80NVV1bXdnU1dOd295WjVOKytwVTBXd0ZXejR2MWxsczJCQ3ArSGNaYVo0?=
 =?utf-8?B?dWw2aGZocklUWnpCaXBVc0w3cGlmblhOYmJDenVQMGJkOVkzbHkxZTNzSkJp?=
 =?utf-8?B?R2dIeERHc0xKOGVBSlY3bXhxR08yRytqblRUWDFjRy9KaFR0aXNBQkFOYWo5?=
 =?utf-8?B?Um9JZ01DekQ0QTdkVUFmMTNscG5MWDRMRCtjWHlFeEY4NXpUWFBUTGN5STBL?=
 =?utf-8?B?ak1GV2tSdUdScnlZcVBoZUlwTGtYL0JMS3FDTyttcHE4VkpUR2Z2bWdRZnJE?=
 =?utf-8?B?SUY5Tmc1cVRmaFdBYnNsODhTa2hxR0h1aFBJVi9BQlNRRUh5TVFScDIvZHZ5?=
 =?utf-8?B?bHo3ZjNXRG5GTmtZK3U5YlpZNDQ4c1B4MURzR1dYWnpyUHJVV0Y1UzJuOWxI?=
 =?utf-8?B?T2Q2enhPMVlNS1dhRVJFT2wvY3pqQ0UvSGc4b25jMFRiSlBRMVcvOFdwbW9W?=
 =?utf-8?B?d0h5SlBTVnFsZmd3ZHNXU25vYVlkMTZ2bkVzV2xZeG1ZZXNCTUUycGcyRTlJ?=
 =?utf-8?B?U0JaM1dCZVNpNkI0MTlWWjNvVCtwUFV6WHdsRjlGWVNTalhMNHNrZVFpSlhU?=
 =?utf-8?B?WGNHb29NdmNmd1JDbnlUbGFsaXNHMkdsUktKRUd1SHVXK3d6VnpQT040MmE4?=
 =?utf-8?B?REloZkE2WjVYVmtPSTBTRnRQQ2NSZHVzQzdoZERneFB3dmQ3WEJEdGZwOTk1?=
 =?utf-8?B?TGRHZytGOGM4cjZzZ3JXbXBNc3o0UWgwOFprckN6Y25jbDFPRkhSQ3kyS3Z4?=
 =?utf-8?B?dDZjSUVUVEtjU1VuOEtkQlMxb0pOb08rNkxZdGNvVEx2Qk0wTERpM2l3Mnho?=
 =?utf-8?B?V2Y0bjM3Sjl2TTRxbjA0NCtSaUJRdjBFUm5pT0hHSHNnN0dpcExlSm84MjRt?=
 =?utf-8?B?SGxNdVZuM0VXVkRuYXo3djR6OC9VME1YS2hwZE5sR2crZGF1ZWhlQ2c2UXhY?=
 =?utf-8?B?SWtLZEtrQWVZeWJldkNUUlA0N2lvMTNOcFVmUmxxOUhPRFB1cFR0RmhiaW1J?=
 =?utf-8?B?QVhWcXN4cjdTbHJHb3h5WXF5SG43NDkrUjFud0tTMkRuaXlKRHpxT3gxWDFX?=
 =?utf-8?B?U2FUMW1QZjhKZEJjRGp6UFMwaCtpTXdGaE9TQm9wWkl0Z2tHdnk0K1hHNWtZ?=
 =?utf-8?B?U3pCOXhIeHp3VVRBVElRMHlZcUUzeDBkdTdnelVoUnlxY3dVVlk1a09sSkpt?=
 =?utf-8?B?bW9MVHgwOTdDeVNwVS84TThZNk1RMG1RQ21XUk52elEwajJVOFN0UFl2dHYz?=
 =?utf-8?B?L1B3d1h3VmlLSURnZDEycGZXWGhORzRIcU9lOW9iemg4aTRaMzRFUjJBek0w?=
 =?utf-8?B?MTREWHZUbkdxdEdxV1k5czRKbmhYUXNnb0F6UUowRzh2WjVoN1FCTUlZOGd4?=
 =?utf-8?B?R3dodmxkTEJyeDQ4QXZ5SnJTS2NQcUczR29BSHZHSklWQ1IvakhpVnJCTGlp?=
 =?utf-8?B?SzRDOUhzbFNFbzhOMTFPeWJZNm44YUh4bkczM2pGTG93NzZ6c1VlR21iMTUw?=
 =?utf-8?B?Qkd0bTVIMnJlajNJU3VLQ1NuRVQ1aVo0T3BBZi9RSHluUzJUMGVqd3FuNitm?=
 =?utf-8?B?YjRZbEtDdGluVThvcm0vRmZodWdSSzNtaHV1Um1qMWdoSk5PaitGLzJLQXRW?=
 =?utf-8?B?OUs1c2xXT3dRZkorV3YxZDZhMXAzbk8zcGQyNGYzZCsyUVg5bjNiVERxc1NN?=
 =?utf-8?Q?Z4DsDmNp7Tzcf4bRDHFxufjUkxfQ+fYGbLP033Gqj3C3x?=
X-MS-Exchange-AntiSpam-MessageData-1: Ood/7gpiWU9WCA==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 594f0ca9-d230-4e3a-a147-08df287b05d0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:08:15.5160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgvUudjQ//c9skCMfseDLvbsWCSujxnvGW86Tuo6Z6PqQncnW5ky9QCCLbJ1sfxPk4VOEQbuhtRLJdh4qRb0nc9eRRc7lJO7teC6jhl8fMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7581
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

Hi Jonas,

On 10/12/26 1:15 PM, Jonas Karlman wrote:
> The RK3528 clock driver configures the CPU PLLs, clock matrix rates
> and default PWM rates when probed in SPL. However, the driver is only
> probed on demand, so this configuration is skipped when no SPL consumer
> requests a clock, e.g. when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the
> boot_from_devices() call.
> 
> Flag the clock driver to be probed after bind in SPL to help ensure a
> deterministic probe and clock configuration behavior prior to booting
> from devices.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
