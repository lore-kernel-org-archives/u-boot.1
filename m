Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E3D606A31B
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bILneI9l;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=eHD9d2Js
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B593607D5;
	Thu,  5 Nov 2026 16:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPADeNV0T6xN; Thu,  5 Nov 2026 16:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5DCA560634
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793895251;
	b=KiTgvZry0Zpw76tI0DWPtB1CLO/0i/eHlDEylAxdDqMrtQGIO/kNy/DHNkVI9/q8f/AQ
	 mpF+njh0yTo1NzSQJnoqvSGrW8w+H8dmKL/kSUatecphkmUzgcIh7hrwOKQzhpXiqxt7i
	 gE8zOgaOftWQb2KRq0NftqfOOia9ac9VeN/2W0L4UoHdDSzqHx20MPtCSZpqXlcKAtdw6
	 g9f/p14sCf83w6bCp43EZxHxlc9ianOAfG9cNrt4YgBndbpYY6YwedbHlwA5eRckWyJ9b
	 3UICA4mnKVuOHiphxAQNaj2nM4GLDwjaod2SU/wV4VlitEfJjC3T2TuwlRCtAUNIVfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793895251;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vWUC5PTLMN3gaovJHQNKK6u4u5u99xmaogRAbK+m38Y=;
	b=Yr6618xlzynzdhR29O967i+r84OMBZTfqkQ9jyE8464GVPs4nonivQG7gq6VQ1t2TXcn
	 60cY+sD9qsRdK1eGrlRzRFC78bXmZGiNeRyGWgA1N62+GkYI4LLORdN3WV6iLNIQzAWQP
	 unLzCCbs3xd7ic2TL0G1A9HWTJ7DQNQ6xewIi+lMPDMvRQMO16yeHBLVtH7j2X7wmAoqw
	 huOSoXaH/3evzZM5xRoj1cnBcyMTkUZh3w5OCJII7NMjjw22FpzJC5rFoDdCQ1LWyQtH8
	 Yi0fbIwTXxBI/Pk0ED8dIcHsAxnxWGyAwcMJk/nlg5OiyJS2kVVAXNp2I2O43nHiwxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	spf=fail smtp.mailfrom=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=eHD9d2Js;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793895251;
	bh=vWUC5PTLMN3gaovJHQNKK6u4u5u99xmaogRAbK+m38Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bILneI9l3jleX0Bj+R1iydCSGT5c+gdL49h2/dviqsy94x16JWVNhWR7Y+cFSouKT
	 d4F8LmekNijQXNJtdnx/pnG0vtyqyMb6jdZIZOL4TUMpaRFHmRzZGFdv2LtShRIxD8
	 mfqvgiaThyk22nzCQCMVmvIKTe2GAuTlN3f21VbSMl6hovaCNWhVdDbuBcud4+IklP
	 JNrR/0EV/JXExf5K5k3gIhzEGKSxWnksN7aWrVipJEW11rY1CnIBXdIVFfTlX38wDP
	 YAXaQA4Ia2cilgrLPejDGgIbJCD/GOqfQdx8h7aoFw7kzFD5Ujv9E4h9oo250/64h8
	 FqavFRc/939Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DCA560634;
	Thu,  5 Nov 2026 16:14:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DAFE0280
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D85CE60634
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jyuCwY0Q95T6 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F092A6061E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=eHD9d2Js
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F092A6061E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:14:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B18548482A; Thu,  5 Nov 2026 17:14:00 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B1484820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 17:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vWUC5PTLMN3gaovJHQNKK6u4u5u99xmaogRAbK+m38Y=;
 b=eHD9d2Js19FnL7pUZ3HXfwmtHYwdi1lR1OkuO/kEGK1HGK1GCF2hk2Ntk3DjUscFpccZ8L+mrmAla0dRIqAPAzrcjaQPOZq7FqWeFHKo0tKkgEsH7LwsESrUwzIUxOGouaaLk9hLXLf1tv9d2VPuZb7t93wLyKWCVT3+pMtoK0o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:13:50 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 16:13:49 +0000
Message-ID: <cb2be9fa-19b9-4d02-9696-bb89c1e713fe@cherry.de>
Date: Thu, 5 Nov 2026 17:13:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: pmic: rk8xx: Don't set RK817_POWER_EN_SAVE bits
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: clamor95@gmail.com, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, chenjh@rock-chips.com, zhangqing@rock-chips.com,
 kever.yang@rock-chips.com, Chris Morgan <macromorgan@hotmail.com>
References: <20261105151057.477529-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261105151057.477529-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS4PR04MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fa1d1c-69cf-47f4-596a-08df3b57c68a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|18002099003|22082099003|261026121527099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261021135927099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: Jq28169VODWgeDJVFrzWuAVx4SgbCysGnqGRGhCBcbrTx1uwghoOjAWK56m0tRHT9VFZkeIa7ryNFS+uf5cd8RSfexpRJ0y26gFUJR7p9QmIfS036AxDf36D7nRU11Ay4QhBtEqfM11qfOvhLPLx+7M+1VzWGHrlbqH8U+9DefVpHw+aUeReD5fXpywNe7NrCG2yknNUajPmjtIt8nASTKMoIJ0HxuvUwyrKL+S2aP1ofP+SaCz0kWKRqVjecEjAXRKLfPFBTKLfcUSVmkHr7+hF2kxULkmbGyWzOIsPqwr7uBSvI3YwA3/cBJj4+3f6Bq4Yg+oR8D2dZ/sReBsXVPWclsp7SBMzdZVoP4bO2+bQWSjA0FIjChz2JPd7Lf0kU7a1nEV2VMqYbni2OQ8Lf+1bYUbP5ozNfvOhtvT3dilLBSEAiopl6J8/GswdWKe61zpJFwaxumUTZYgPSyFEZ1jhDhlRK3PCTFJei+ZnvH9OhZ7TECV91HeZqiS0gDPgWIZdnQFoHS8BLGxg8jQAmfTkE/k62LHMmR7Tm416qia9srfvXJtA7oCqEsaWcGCNB+EoMFt9j6oQdn6xAfvdnrX08A8TJ3Hf7aI6FdmmLEzqLhh4piOTajzhElo1y5BvUS+8vpthQ5Z5XOJezLJtXruC5LQZ/im6XHdUhWNkgQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(261026121527099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261021135927099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlBra1V4R2ZiNSsyeXN3dm8vVnl3SDdiTm9xL3MzMFEvS1hNM0tJU2pRTFpE?=
 =?utf-8?B?dEgwdmZ3ZVpDbzdlbWNUeU9NdHRPcjFmUGt2L3dKVzdQb3hUOHByZVpzaUw4?=
 =?utf-8?B?VDJkSDdnZTA5Z2poZHJYd1ZXRFFZUjczOEJDbWJhUnVNenhtc1R6VWNlTFF5?=
 =?utf-8?B?OTk5WWZxMHlVMUoyU3BjWUZyRW1ld1BLZmhFb0JlTngzUHVOVUFnL2dSYkEw?=
 =?utf-8?B?V2NveW8vVGdEajM3cGhuRVFSY29jSXpSNktkeEdqcjR5SjJhYjFZWEtuMURo?=
 =?utf-8?B?TW1Xb0F3V0pyS3FyOWxndkg3a2ZLc0poWStJc0dkMzZpb3VkUkl3YitzaXhM?=
 =?utf-8?B?UDBrTGE1b2x1OXRsc1pMcTJGaWRWakJLdy8zbjczM3ZId1JMQXZ1Z3VVL01J?=
 =?utf-8?B?YjREald3R3pDT1JFRytMR3VUcWp3NGVVWUVWM1p5VjhmNGFsR1FKWXpUSTl5?=
 =?utf-8?B?NFB2N3V5M0FER25GcFMyOVhCcWRXNHVBNHFJQTc5aGI5RFpmV3ovYXBhbVVy?=
 =?utf-8?B?blUwUEdZSzZaN3hva0grMWJ6NkxxbzBKQ0IzVXQvOVpoNytIbG0xYnhNSHRS?=
 =?utf-8?B?RkkzWWZZQUxvWlJqTm5PTSt1WXRZU2hWZFpWVjJDdGRLd3hBT0xKUGgrTFVS?=
 =?utf-8?B?cUVIQWs4UEdsQzZCUys1OHFUWkdkc1FaQ1EyWlVrOU04ZXp4VkFkaEwrd1p1?=
 =?utf-8?B?TVhaSEpSUXpzaHhwMTB4V1VzRlpPb29GL1M5ZEJHVExtQUozMG56cjd2T0pz?=
 =?utf-8?B?WkpMS0U3SWR2MDNuWTJVcTB2THVncThoRXFlMVRwVmRqWjM5aDNHbVNFR0FK?=
 =?utf-8?B?MHpnM3l4aFdpN2NEeXRtOWt6azRjQzZ4NEExdW9oOXJMbkhUK3VWTWUzblNH?=
 =?utf-8?B?U09zQlhESHAzVXpubktXazhxRkRFVUluK1pvc2tielJWYjJZUGJrcWVzVlZL?=
 =?utf-8?B?Y0YwSHRtNVRDNUtobUJseEt1MkNQU1pabE5SWm1RRFdlU1QwcWFySEdiQmRP?=
 =?utf-8?B?bW15TStBdi83R0FzcVN3Q3dzWnZDVXVrSHJLQUJzWERQSGtHeXNoT1JBV3o0?=
 =?utf-8?B?MXhMYlg1aE5IMmpoeTZqY2xCekV6NWVxZlBRUzRPTlVidkVVOU9EL3JCSkg4?=
 =?utf-8?B?cjJ2Y3oxWDMvc3E2aXd6WjFYaHNNZ1BubFVQU2pyMjhxNGpEMlhtM1JFSVFZ?=
 =?utf-8?B?VWYyYi9hSE5QR2poY25iRXZ3dFkzZGhFRFM4dFhMRUhmb2M5clhhNzJkSnR0?=
 =?utf-8?B?SUZlb3BWK205dG9Id0tDZ0Z0RlRHSWc4T0srNFZ1UEdWUnBMMVhobzU2Q2Nr?=
 =?utf-8?B?dWlBY0kzQ3BpY25jZTNoclJqdG95bHR5UEM4ZHIvZW1RVm5qckd5aUZsa1dX?=
 =?utf-8?B?YUwzNE5QUWVucVFhRnpxUTVhNXRyaVJ5MjlNQlczalZiNEw3aWQrbndXYjNy?=
 =?utf-8?B?bjd3aC84YUlia2tiekNsWUJ3am1TQWJUUlJEWjJZbDZGazJ0aVovc0RZYzNV?=
 =?utf-8?B?bHJMUmxFRDRYT1RVYVY4dlhuU0FraSs3UjBLc1pCVkc0TW5QZXV2bXU2SmdW?=
 =?utf-8?B?bThNaTRWYm1qZ05QcDA4d2RET092SnhUb0Z5UDhOUlJWa2Z0ZWF3V2h4Tnov?=
 =?utf-8?B?WmYyL2Qrc1d3aXJhbjF6K3dUcUR0WS9Cd090TnVZRks1bFBRaVBZY1pycG9w?=
 =?utf-8?B?SWR1UnNOeDZDSW1nVkw1NDJHeGNNQUhGSFA0TWRXYm5kV1BFeW9mYjJDNERG?=
 =?utf-8?B?cTVrMENNSzdiWGlxMHJXUm01ZW15YkhZenhpb2thVXFBUktrRUpnbGR6MUsx?=
 =?utf-8?B?aUZMOEpyU0tCZmo0dXh4bG9rdWVxTWFIMnhlL2dXWHVZQkdjcG94VzZqVm1q?=
 =?utf-8?B?RTg4TDFRMStDS1dzSEpUZUpmVzdUbVkxRkN0MUJ2NHA4RUNXU3RaeERPNitG?=
 =?utf-8?B?OGdEaThaRDFGY0swbE9BaXRSdEx1Sm4rclpsMmh4SDlBOERpcEQ3SVdWT0NW?=
 =?utf-8?B?L2hFeWwxeGwvWmJHS3IrWFE2dVFNU0tIaEdkbnVkUFZQQ3h6MWdraU5WZEVa?=
 =?utf-8?B?OWpzQk1RNGczSVpDZVFWSUtmNzlBcnJtSFJrS1RObFN2a0tFUTdYZTBYeVVL?=
 =?utf-8?B?M010cXVoRHp6SEZNQTRURXZGTVdRS2xiNnRRWlB0T1d0UXJZTmx0bHpnbXpp?=
 =?utf-8?B?SlVFaHl5dE9lbk1kQ1g3RHAxK3B1SzZIUDJvb3ZtMXlVQkxLbXhicU0rM1A4?=
 =?utf-8?B?VEZUOWxxV2U2aTF3ZzJYaDlCR1JnS251aFgwdFUxNzBHWitYWHVsVjIrYlpj?=
 =?utf-8?B?cElaeFJFR3YvcURnSGxCejU5dDkydVdUVStTNnZqTkFOdnR6U0NSdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fa1d1c-69cf-47f4-596a-08df3b57c68a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:13:49.0459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evTRdN6qb436+P0jh3805Ytuu84uXkV42aEHSFBQbh5i49x/QSr1GTqo+2VSsbR9i5m2WKg89QR03uN6dSgPJKNczuROo6Qm4ZSY5YWkoLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_FAIL,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chris,

On 11/5/26 4:10 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Don't set the RK817_POWER_EN_SAVE0 or RK817_POWER_EN_SAVE1 bits. These
> bits are not used by mainline Linux and actively setting them in U-boot
> interferes with their function for BSP kernels, causing systems to
> hang when regulators are enabled or disabled incorrectly. [1]
> 

More information in the commit log would be welcome, in the event the 
gist ever disappears.

In essence, those two registers are used to store the current state of 
the regulators (why? don't know and not explained in the gist, do you 
have some info maybe Chris? Anbernic seems to be ignoring it anyway but 
we don't know if there are actual users of it). They aren't meant for 
that at all, but that's what they are used for. Downstream kernels then 
read those registers and configure the regulators at boot based on the 
saved values. In upstream U-Boot, these registers are set at PMIC driver 
probe time, which doesn't make a lot of sense since no regulators would 
have been configured by then (although, they may have if the PMIC driver 
was probed and used in xPL and U-Boot proper then save the state as 
configured by xPL).

I'm a bit worried other downstream kernels may actually be expecting 
these registers to be set. But considering we probably are 
misconfiguring the save registers anyway (by saving too early), I guess 
that's fine?

Please expand the commit log to contain summarized information from the 
gist, and that would be an:

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Considering this has been the case forever, I'm tempted to get this into 
2027.04 rather than 2027.01 as it's not a new regression. That would 
leave enough time for people to complain about it (though I'm not sure 
may people are actually testing upstream -rc on Rockchip?). At the same 
time, we're still relatively early in the 2027.01 rcs so maybe that's 
acceptable too.

Thanks!
Quentin

> [1] https://gist.github.com/fr0z3n-cs/047b24a6fd430e816fe02a877ad7ab8c
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   drivers/power/pmic/rk8xx.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
> index 95b71d2fe49..16b3dc7cb1c 100644
> --- a/drivers/power/pmic/rk8xx.c
> +++ b/drivers/power/pmic/rk8xx.c
> @@ -251,8 +251,6 @@ static int rk8xx_probe(struct udevice *dev)
>   	int ret = 0, i, show_variant;
>   	u8 msb, lsb, id_msb, id_lsb;
>   	u8 on_source = 0, off_source = 0;
> -	u8 power_en0, power_en1, power_en2, power_en3;
> -	u8 value;
>   
>   	/* read Chip variant */
>   	if (device_is_compatible(dev, "rockchip,rk817") ||
> @@ -293,15 +291,6 @@ static int rk8xx_probe(struct udevice *dev)
>   		off_source = RK817_OFF_SOURCE;
>   		init_data = rk817_init_reg;
>   		init_data_num = ARRAY_SIZE(rk817_init_reg);
> -		power_en0 = pmic_reg_read(dev, RK817_POWER_EN0);
> -		power_en1 = pmic_reg_read(dev, RK817_POWER_EN1);
> -		power_en2 = pmic_reg_read(dev, RK817_POWER_EN2);
> -		power_en3 = pmic_reg_read(dev, RK817_POWER_EN3);
> -
> -		value = (power_en0 & 0x0f) | ((power_en1 & 0x0f) << 4);
> -		pmic_reg_write(dev, RK817_POWER_EN_SAVE0, value);
> -		value = (power_en2 & 0x0f) | ((power_en3 & 0x0f) << 4);
> -		pmic_reg_write(dev, RK817_POWER_EN_SAVE1, value);
>   		break;
>   	case RK806_ID: {
>   		u32 rst_fun = 2;

