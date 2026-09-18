Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B193C982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 16:51:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4098F40BF2;
	Fri, 18 Sep 2026 16:51:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XtgFYUn7iwXf; Fri, 18 Sep 2026 16:51:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 500EB40BCB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789750265;
	b=Tjn7DFTeMf/ONdZMrE3N44lyDKHygLlG9sNhE9a4b6SGsNiTkc/pdaxRoo2xPULdoVSr
	 TAEnE0WHUPWxy5hL9V8jfxeoOiHkXuHkUXmXyh6EAkKBe8pGkBHa2M7BoPqw/hrp/16YQ
	 4vDyId5mFuFOF1PTI7TAG2kMuRG7UbzWx02TLtu7T0CksUYL9w40DPco+z9HkVfrrEhVl
	 KDTlKzweabAvcsU7fcnwcCU3hYahj06teG0DmtYJIVxBLKeU4r85W8Zwl1H2jlE2lqYek
	 po4KCFe9dbaxh9Nif5GrrY3hNV0SUWanJB3bqrZUwiyiK8XTHFEkFRVohb/hAEOY9xQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789750265;
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
	bh=H0s+tKnAr0yq3ar7rY/XKtqwqbYJJPKuB8SLHXY/TMM=;
	b=I2hTkeyxJIOYEXNp07SFtb+P8XE3etsjOFBOYAu4cgS/+ILnbr7pfIQKXXFPIUD8zIug
	 flVUeNVpWkkQMfj1d2B92tsAnqiXkn4iHlKzB/QtLPkmqW7eOkFwFSG5nsiSY9Py1ltYn
	 w5e1rvVs6SsPCJQqcRCGBp0q07J+Ru4ylSn+7eO2b/ng5yst2IPcs83V/v2t2c/VUJ9B6
	 ESl801VIFzFXtoWsbChnLSZHe06V1wiDLAGeJWnL5vGBBGyQJc6UdE7qlZiiVnWtBg0TR
	 +fkRMzJLe6VYL41bQQHv0lwjOgnXSrgxhGK4lW/C7tNmuevuml2aIFw2pgjPCKM38qQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789750265;
	bh=H0s+tKnAr0yq3ar7rY/XKtqwqbYJJPKuB8SLHXY/TMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vBZskDF9Q71ubBbIxvI4+mU+gZQCX4nsefvTxupywoll8fBXlis/3Il2Zn+AfTj94
	 POm559rjznGWhyQHjW0K2isqF/qLkHUvsEGxw1bbbBlCUzW4NDA+G6RtXs8Sqi8Zfh
	 FSUIH970OFEkLQeJueMu36wY25pet4hD4I5S031u3aWVNRzHa2GTnQuZpCY6PY6D+2
	 i7sJzflx2cE6XI3heN9gZUjw0PJmr+uDIivwFojD02BqIb/jfojRMHeS6HO9ojctWG
	 2gwjB+91BmFu8RucP9DTs4XjspNEwdRThr9KWoekVXytQ5P68pp16f1cY+ANEGy+Rv
	 KYVDywzp+nRvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 500EB40BCB;
	Fri, 18 Sep 2026 16:51:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B53625B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D7EA40549
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UXWU6MGOhmeP for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 16:51:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DD1CD40545
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789750263;
 b=MpG0X28+PyyYxGtE/wAkVos+oNwniaHA7gmy3MgT0SeClQ+B/kvIrHIlSXRYRjGbvRUJ
 LO9yDsZHTd7ZyzOA6SH/sTHFUeSPCJG0hvDPNlM24PqAIcg2KD9bG3mMRES2geSTSqsHo
 JtGKBybwSU+R1ewh18CRVxvFVOusYP3exlUnESYNpQkkzRI1bhfciAy0VQlfuyKDw+bhW
 U111ddNX22YvuMDyqupacQOlEt7I4ZTu3Dlnw9eVrL+vmNJ+SyovWJ/+hV6n7IPZe1AHa
 COvhLuPOYJwvffgG/8dWo0aAMxyrhmeqBZogMJkr8B8vlY6fSUek08Ga8kd9GBnjcKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789750263;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=H0s+tKnAr0yq3ar7rY/XKtqwqbYJJPKuB8SLHXY/TMM=;
 b=nd3x6Rs0ySXnv5XXuPWjaBeRzMO11gIA2bs8uXAp6VOBBHXYinkpeBDrDiVgL25/rN1d
 t5m7z8juc6PAROZXAhHEfZGfCY0vRSU2FBhhvo3tXBGq7avWpuiFhDEbSdPu4vwDs+m2z
 FffpTjrJsY1bhlIznIuETG02/KZwjTbb8W6RNpKxc4GeMOo2MmtnrqFgclcsZQ8BvV+V3
 KUjoMEe3MIQmgs3H6NqTR5Z3CAF1GxRP62BTPktyZnC2loeWsUwINVs3pnbPCWIDDegRK
 Ml37267GEvwFs64tLi1rBFRXrJY3DwBHzY7YKaeGX2Nii4OTC+bFq9o6M7/aEGK967g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QgnczAeY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=QgnczAeY
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD1CD40545
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 16:51:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7CtQXJZRXrzRGF9Obj3q+ojNlR4UIHbKDawUXC/0mpZHj43tx4udZz6Ni9uQ9IRTacTeYHEu8HgvkEy2mKA0scSaTQ4giyVlv7VU4g54Qh8+HI1SvVOyTl3XBkvwmUz76BC+cFrCxJz1xkYHfDieveitncHIzvOdHlCEY6sN6acG7cHEWrJRGEV9skTe0Yj00zK8g3G9M56OaicEd0ANfj6+3xw+4B7AeFGD4xZKEXixBJSUIMkvG2vRz8A6PAyAhIbm1QCA7lRmoc1mCbOD28LmrItEnn+rD1D2BjYIuCfteSmReThInQtIWcHj58V1hB2+tErDaZTiaJEHF7WZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0s+tKnAr0yq3ar7rY/XKtqwqbYJJPKuB8SLHXY/TMM=;
 b=hbCkWvMVuVcB+xC7L5xjVPcVgXTVlzCdb2Ao2zWIUoYPlMrYom28EOXO/hIDNfh2hNFLVaxxeXuT2/ftzjNOWsmI/WOzqH2Bf953zuY8oxWQPAIjUaccVUzmauu/gUJnHbGjF/YryqilCxhDnXkSdIyuUhqu7IcGNJbZD6XVbokMz6u56r2j3NCqlnzctZKpWO/5VnB3L+gr+I5eoSng2yc7HEvJz4jJjK+lArh9TiQERiIx7CIdf1xmOLK6SIXUmmPk5+mBElq/+jV78HZ5S+lH5P2aSydNpG9vz1M3pOtViYvgN5UKpMTLrgEsvt8zDefziVYHnasZBh4W7+iYpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0s+tKnAr0yq3ar7rY/XKtqwqbYJJPKuB8SLHXY/TMM=;
 b=QgnczAeYdUnm/X/p4vHToVDNUcrZgGI6Qom657GQ0MelHX/jeMheTJP92gvrJ4pNAKCRRBRkP+oZRN9i6dONIg+CM8bshhvRJhs4nhNKRAgJBl0dKUCdy/FS8KvgLeZpSBoOUOy42ONA6dPH8c13mGcxdaoyHbQVeRNZ98xt1dI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI0PR04MB259148.eurprd04.prod.outlook.com (2603:10a6:800:366::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 18 Sep
 2026 16:50:52 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 16:50:52 +0000
Message-ID: <1ced1b39-2c59-4cd3-b88d-4ff9c5a2e106@cherry.de>
Date: Fri, 18 Sep 2026 18:50:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add HINLINK H28K
To: Chukun Pan <amadeus@jmu.edu.cn>, Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Heiko Stuebner <heiko@sntech.de>
References: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI0PR04MB259148:EE_
X-MS-Office365-Filtering-Correlation-Id: 68838150-a124-4336-0256-08df15a4ffce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kyo1VRrFvqLCrzwNeaFBM/K9azP8Cbj/tJ7M9pgFRe58hmeMtteU+MasGQlSZlvSUPgzVeJDNZ2o1QiMUEGf7dQHQO7eH2aQwjZMM6dfRccM54CzYzN95J/TiLCdRFeInPwbaap/LHolNS8pTOen55Vv/42jR26jnEyWixT8XNDQeqNH9m9gCjukJ8ex7/nKkL1Jpl5qiDjEP7oLGgQ0F8mLcUT3kd17dUe6Os7bSmWgzVB5UPc4bQRFn7916It619WXgv2hbBWFSSJ6YgI41MqHHs/hQ9YewjUVDd9n3+P+s8D+SG3nfwVBkrlRCZu5bd8H50o6PW2SNHKLJ3tA5dnVHA6jy3W1pal9EMbuJvv9X831FrgselG9HovYZN2Ompe+U+6yAKcUN5hIeIf0cBFb68+fqLVed0Bp8GfE98c0f+OJS3LxnffQytos5Sb2DBX31TaIT5gmiRHg637pygHn5749sUfCVmyhSru7qIzD7OSYi7dFSZreAgZMVx8kx4NATusYrJ24xQ558Rl7I4DstuhMTjp2s85c+apnt9LPMvJnvGvafPCkm8cSAttItt5+HSLh/ByShH3tcPpOgCxnPARd+ul5MwAbvRpQIdKn3mc2Mvy7ovns01TdZ7mD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUYxd0tyMWZhR3BCME52bFVDdFREQXE0RytGK1NlK3BjcHd1a3ZtV0Y5Y2dy?=
 =?utf-8?B?azJydk80N09nd1NjUEoxRWUzQUo4b0ZkMjR6ZEhGOEkybUVyWXNOeFRXcmN4?=
 =?utf-8?B?TUM5MUVYZ0ZtWFVmQUNqSWViVkhOMGZlQ3k4RzZzTkRJblVSRkFaWGtqK1N2?=
 =?utf-8?B?S2RkVlpWR1hmMDJseWlzRVptWFc3b0srdStEZzdQN04zVzBjTUR2MTYwV1pn?=
 =?utf-8?B?SDhvcHp2U0RLV3lNeWFrWm5TSDVWT2I1UHM5MjhINVQ3cmVTVkhJaUE4Q1JH?=
 =?utf-8?B?YWFJc1JBY1pBbklRNml2K2krWGxhRUxLRkNGbHZvSi9vS3hicXFqSXVzVnlG?=
 =?utf-8?B?aG4vK3A5K2czbWVHYlE0Nm5ybGU1dk93VDYvS2JGQkxHR1A1QTdMMVJRTTcz?=
 =?utf-8?B?SGx2VjFoT0ZnblZPZi8zbi9KWHhiMmJrYjZRdkMvRVRYOVphOElqd24yVkpt?=
 =?utf-8?B?bGZnRnRsOGQ5UWdmR3dxTncxa3ZKNnpidHlrWnkzUDFPMG50NEJoNCtaZTMw?=
 =?utf-8?B?NXkvdGRDb2tGLzRDRC91WERCWVdkYWdRZko4N0dWK2I3TzRIODl6SlpJY3Ex?=
 =?utf-8?B?Tkg5Wk1GVW5ibUErb0Zjb2ZldGlBZVh0M0p2Ullub0IyL0dHWm5oS24rQ3l5?=
 =?utf-8?B?VTd3TFhXNE8zMmdrZHQ4TnB5TTZDTHF3M0h3SmlwUUhENmxOZFA4QjdRbUEy?=
 =?utf-8?B?bXdkSFhheEswOG9ieldFemFMUTBuZVNBWEVrYUNwYkRQaEZKZ1Q2VklvRk1y?=
 =?utf-8?B?OGM1UVVMUEFYbHN0V0NVNXJMQUErZVA1WnZQdFlMMlZXODViMUF2T1lkMjZ2?=
 =?utf-8?B?TjB5VjUvd2dyMDArRkNHNk9ORTVkdVYvdTJTeEc5R0N0cXpMdTRzVHRJcXc5?=
 =?utf-8?B?aXZaSUhya0hQUlhLRWFXa0ZJYkt1Z3U1elROaWhxRk1GUXRTZjZWeVp5SFZy?=
 =?utf-8?B?R3BNSnRTVkZCcTJTSDJYb3FtaEJqWjNNOE9Celh0QVdqR2NFUjQweW9UZUFZ?=
 =?utf-8?B?a3NJZVJwZGM3L3R2M3pkcG9jbm9QRTRIOGRjb2Q3ZCtRQ1hyclR4c0dPUWxY?=
 =?utf-8?B?TW5zYi8yV3FGWC9yWDdLMjNCUUVJbGIrM3VOczg5UDd1QjVyMjJqbFBRdjRY?=
 =?utf-8?B?Y1MxbTJwVkpDU01sTUQ2cXdrcnVvRjFtWmJHYWxxU3BheHJnZW53Um1hejYz?=
 =?utf-8?B?T3doVkh6dk9Tb3JvbGV5clBqdlp4TUVPZW03S2JjQisrYm8xTk9KbXFCU0RG?=
 =?utf-8?B?c1B3TDdCNk5BMUUzVkRkZ2Z0RVZSejBMUVFxVFhQSFdiM2oreGJGK0Y4djUy?=
 =?utf-8?B?ckJueVNNVDEvVGpvTi96WDFiUXVkaHRsbUF4MGhaK2lOcHMxRXhrczg2dTNS?=
 =?utf-8?B?Y0JjUXE3bWk1U1RVaUt6SVJqcUFsYUU2bHVPNmZQSTZDY25KenJCaXNWUWg5?=
 =?utf-8?B?Njc2NThkSjV2OGp6NEhiUE9hbTYxMEpwTVZ3bi91YlhXTVZKVnl4b0d2WkNB?=
 =?utf-8?B?V2xNTVE1ZDZuS2RMeldJRlA4RUxmaUZDcFNsL0R4ZUhUK1FIYThFbGovWmVa?=
 =?utf-8?B?NnFnTDNVN2lWUkY3ZGNRTWMyNzMwS3UzYmpUWmtaZUJyZjcrc2xZdzJMak1R?=
 =?utf-8?B?RmhEU0NKa1NwNHFhZWRGRGhIUEcxWHFhMXlWdmhOb3UxRzVTNG1la0orL0Np?=
 =?utf-8?B?anc1Z3dpcWJjNEFLdkV3TzUxNnF6ZUhTU3NSNHc2RTFCa3BIZFh3UTVuRnBw?=
 =?utf-8?B?dEdiaTdRSjBXa2sxWHRXN0JoaGh5MVF4ek13Z291VDkyQjZhNEQxUWJiSWN1?=
 =?utf-8?B?THUyL2RYUlFyUUFBOXE0ellIbGthN0ExL1U4RXIvVHZ1N2R4aU5rS1dBZVkr?=
 =?utf-8?B?UGhrQUJ1R05CbmZCT2UxSllxL1ZVRHRTYzNQK2Vab3FpelVxeDd2MXBYaTQw?=
 =?utf-8?B?VG00bmZkM1Y3dGlubmZ3emUreHJSQzd2RmVGYkJOdEVEYjMwaURudFAzakkx?=
 =?utf-8?B?ODk3QmRQZjdLOEpHcmx2YlkvWmVIVlVpUW5GR3ppMnBXV2g0SFhvdzI3YjJZ?=
 =?utf-8?B?S0htOXFiQy9uYkw1TUFMMFRFeEYrVGkrSCtERkhTeVNzcXlwOWFVQjE5YWRF?=
 =?utf-8?B?RWQ5aWF2UDJMc3FkZ21DMCtvdGhSTWVsVWlDWkRTZmIwV2hrNlNHWWI1MWZN?=
 =?utf-8?B?cnhPK3ZYOVpySks4S2NGNFp2S2dKTjRZQWp4K0xEUlBmdlFuZHh1RXdCVTBn?=
 =?utf-8?B?cldickgzR3cvV21pcUZzQnBuanBhRGJUcjFvdjdrcU5Bc2IySis2TmRYWEIy?=
 =?utf-8?B?Nzg3MzVaMVMxQ0NmcXYyOXluSzhSTERSbzVMOTN6VUR1Y0daZkRsQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 68838150-a124-4336-0256-08df15a4ffce
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 16:50:52.2284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w+wGgAzO42/8lC7/B0DYvOxYxyAh6FAr30RJSSzmvsBQeI/kZgxca1ogvUA1wTQJAguiU3BoDF92Cn90+IgygeGqdlZCrfNr5EjY4kZGKuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB259148
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

Hi Chukun Pan,

On 9/18/26 2:00 PM, Chukun Pan wrote:
> The HINLINK H28K (LinkStar H28K) is a SBC with the
> Rockchip RK3528 SoC. It has the following features:
> 
> - 1x USB 2.0
> - 8/32GB eMMC
> - 1/2/4GB LPDDR4
> - MicroSD card slot
> - 1x 1GbE RTL8111H Ethernet
> - 1x 1GbE RTL8211F Ethernet
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> Link: https://patch.msgid.link/20260610100006.366963-3-amadeus@jmu.edu.cn
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> [ upstream commit: 5fd91b4f3ef20ecdc6db7a9e5c831209c7042c08 ]
> 
> (cherry picked from commit 056a3d3a36a2f0bbcfc9019b57dbbbf9ee33929e)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
