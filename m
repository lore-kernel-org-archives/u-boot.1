Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EB7CC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5D0F80F61;
	Wed, 14 Oct 2026 20:35:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tXRKYnLFTgHq; Wed, 14 Oct 2026 20:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 137FA81007
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792010118;
	b=I+Me+JP3TIInoSkWsdf02+iHyei2MGidpwDWDzJBcakt/e10DIY5BOz2Nv6o8Y9F15uh
	 OaZwqr/Qvvxa26M2RtWusCFpTG2yNly5YZhLs7SYqdwOiFDWlf+I3mHdgeyt6OY8FkAur
	 1e1NUiev2gou31wWpeW9/0Iq0sW1eTW9/jh+ia1lVOpBLEfumqLARqMJUeo2R/zaML0CT
	 ETMF8cJLqiuLixev4g95jPEbIicA6vStVk21s79HLIYC5O1YiphteC9NkLVcFR/JsU8dR
	 hZJFQVmQw7wcB8JA2Fn5MaqeV9RoO8Ybx75/4i6jNBzuZSifHLPOrOx+XxVnD8pp8dA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792010118;
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
	bh=jE/cp4fiMykghTOc33GaK8GX8WLB/KqbpYMepmqnUko=;
	b=M6oeDpqLxxMY5E8XKEhvfHcR2D5juJY1vyJ8k1SDQIoNfzyvLrkXIliYleT3ivXo1m8G
	 aQQF1m89PZb3ofqwSMhkjIjhQSP1bnx4mJKalxoh3GYlkGqwZRAJkWwOdXK1eC8UQu5V9
	 hO0LfJDUne3m9Br24EAgDHXVzqTR2ULBPsugo4RpfD5m6FOMooJbqFNt+KNwBhlQfqBFd
	 TVWjoSbTU78s79YH1GK9HMCUWZff75v8C7R6nutXTYdr3PeWzRHFoY6WV5tqD/t92auxa
	 y686M2d5jOqBy/wECKh1G/QmcQY3anBZaIy7L30GLZCD7g29lyK+ZJcqSgCda44litg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792010118;
	bh=jE/cp4fiMykghTOc33GaK8GX8WLB/KqbpYMepmqnUko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=INglusUdymB44S9W4tX8VBinCeafVbePRr/sqPyd9S/IYYPh9JFR8k0htIN4mNbPq
	 qwnGaUY9pLnxFrMdCYUb6NnWiFstg+qdU02qHNm6R7m08yAVoDKmc+6iZmqnqxjhu3
	 Sb5CZ8ObCTFy/lbjvtxIECzSbXNd9FT8X1UiMA9fPEvhnfLJZt5N4/BAwX/Kfe/FzK
	 xV9OB0ShQn85dZ4fi/bzwsxJDdcHP/ME/KR88DJeGclsOn5wwXUGnP5rmpnNX7dc5Z
	 IeISI6s9G+r4YVyDFVS1fECFC8pyRMAH0fTilFcE0ZjwOLUq8o9epnMjlIeMRxVFgX
	 vaDt2upQXONzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 137FA81007;
	Wed, 14 Oct 2026 20:35:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A352A2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89E10401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XrRKBHS9zDUK for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 20:35:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B77774019A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792010115;
 b=A+ikztafv2iwV4PPkJ1JN8HOaLdQl6xg/dF0dTWN1El2t7iHS+hRsX242cmyEJOIdnzU
 75bO2qr+A8yOAAemAX/Fypg6S0o6bFmrsddiX6HTECLKI1hG7D+H6FERrvK373Xyc4ZLk
 xXqsSbxDzXmskJfk3j02qh+4IIfpxe8ZFA6Srl5inVSITYsn2q51VAlvPfqtFuK3f6fC1
 hdoqy4mAWRyJy5DDoWjMJFkXrfQAhjtMcVEt5X6OheqNkUthyN6VgkuJRytPe3MfB+KOX
 39UZoT/8hHuLLg6XuUhmEB4BxFeKth5+243n/JhCjPssT1ANuf1BNrrDAtP7V5P7OpA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792010115;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=jE/cp4fiMykghTOc33GaK8GX8WLB/KqbpYMepmqnUko=;
 b=DuI3vXssGTGpTeScbbfP4D+tW4+JmQdBK6LNcstTibG9KdtDsYyp6e1plo3oB1fh7r+l
 EFCKWIvgtrqOdFtm/TdhvEROc930pv9j/2e175+Msa+gJCHppbM+x0NbPhTIS5Kh9gz30
 RNi6NCVC+ivKATPN+z42nAklameYmRpb5a6/G7y+VmyYJiG+3Iik6JhDvJV9aqIIE6sWn
 3pOBH5hud2VZs4Q+d0oSvIm7NQCBcu5BkTgAICs/X3fsjzhpVJdQn82Xq1YZXKke2DGK6
 bvj4cXlvkoW8Vxrs5D0X0IHKdJRKiEj0l15I05g6uRdQo5gpmJPiQCLX/1zG6QX5G7Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ZW8DLm6P; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ZW8DLm6P
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B77774019A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 20:35:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5MMxqvH747sUNPkCMjq0R+jJCNuZsGBeHxdCwxsaweWYNKht6C88f3WmjLVJJ6RA4Tu6zL2xaJOun9JYGVhZliVtMyl2yhRAYjE1UQrfG7LUiztHsPDXJhSLVQJSWzIG4wKGCo5vszEL8A6puKTx18t/kQDQ/U81PVUjtKEpbjsx1Zoz4a7FEdahX2K3vySsjeYdsrZJ6BYJLo0Jr9JjGnBeodPqs8myFypwpcKPUKhDXFIZpcwIFxi/F0cvo0lrKYMlRSiH+A4xOl56CXl7ywnEVudTh3MBUtda/m8MtZeF1ebXwu/GfIcbx8wbAUPvFuvhg9oHKqpzcibmRFDvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE/cp4fiMykghTOc33GaK8GX8WLB/KqbpYMepmqnUko=;
 b=QcFbWbDEZqdAUBJaExOWIrfFmHKvRfkm7O719bio2b9WXf9XM/Kza338EgQBsHNn/7y23BLlKYhu9G4jXvcfTD+ovM8E863Jm5gsj/Pf2Fe5eyowwUn/ylOQHAhkrWNh7fJ6jnZpHDomF9x4zhPFLLcPVCWaOYpdSydoy9KPI3A0uRG3+QpOfbwLFAcVA+3/42/k986hXu16q40VdBV+sArNXM7fmK25lZhVPUz1WGwZndisTvpPkvmoNKyIoADNbCciLDoqE0sA7qUzVoOLfVId3em7hmqTfHZ+ye+WU2L6m/mi1WRnyAG/4h7tn9NeSqDcEge3uq0xgAFk38UAsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE/cp4fiMykghTOc33GaK8GX8WLB/KqbpYMepmqnUko=;
 b=ZW8DLm6P83oaHMQHGRdilcYeYV2du9GZGXnbYexascdl0NjRnpVZe56dO0KB033APEkWMn1InK4wV7QNU1X1OCAP72x/dYf9vTm6mu2XbfwQA7E0g7MP/JSkBXBz5Un+JWGYnczpn/wUWTA/5PDzSNgDyg37ncmmkyumdM5e2YnQHD6HykshemJw55ha/5OmvpJa7H9/0GHg/WAaq0zl6Db6DFmssdO+1vxWVGrHNTwUWrkbF9EFghFmoZGQxYmasdKtQmkin18bTuN/7BjP2QZxr6YzYSefCFe3ExKH3rF9Q2xpb6ackn6lzla8af/EoADRpJ80s0jmpXflVBRWhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BY5PR03MB5235.namprd03.prod.outlook.com (2603:10b6:a03:21b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 20:35:07 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 20:35:07 +0000
Message-ID: <5cf65034-e7b9-4d0b-9a72-5d771e1d0e80@altera.com>
Date: Thu, 15 Oct 2026 02:04:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io,
 Anand Moon <linux.amoon@gmail.com>, Hung-Chun Tseng
 <alan.tseng.cs@gmail.com>, Tanmay Kathpalia <tanmay.kathpalia@gmail.com>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <b34530c2-2a90-4cca-94ae-207e503188ee@altera.com>
 <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261014T154006-0400.uboot-k1-mmc-v2-handoff.DaveWK225@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::7) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BY5PR03MB5235:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b10b0d-c912-4459-69c9-08df2a32a298
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|55112099003|18002099003|22082099003|10067099003|261009223027099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: tqPcebCKzmsfxH7O0EYR7s2JnAXzuu/CotZyBNm4Gs135pWwGtSX20xK4tSaYu0eS29uH0OXr7Tu5Q60sqMDfENE0ZKwknWYSlDvr3w0hVJxpw6Kzjm6RED83TpT1txV8Mc46q+zZJlHXu0Rv9uvpXrSehLt9yvDCQOu5LfpDXN1UjVLb7BpjO9//29SE8b2VPO1Q0MywPLemWx0BhCpGblr942O+EnxIdqW0Wcv9nyu/gQ9ahQ7+xidKuufNp4QvE9qdU1lBtVrmJ3//ulsuccbGFpRfnCKFtgKdSMIIrWiIeJS5XKxFnrFMjgEiy3PMDoT8G2PMKyl9eg3B2IMaSIun06anBOrIo7hs8d0qjlnw57yll+b/rqPbkt0674LgLhfjfmrCO1NpG+IEwT5I8qrcolTeRsXQIF3+0r8vwvptV02ap0TLr4yB8EkdhXj4F5KiRCaHQRS2e69jEGS7TZlCe1bjVj/ezbBIwCmFBtt4/P/0KshW3Bg3CWbXyLNCegQvKFQ2Ap/R+u9Iuf+x03Ul6e3g2HbjybCUTBu0ZZHZhvRFzX/zDrUbihesimhbRgKJujZZU5CjJli9t9p0zHUALF2AruL13tklqxYO0Q/jdHm/LOvTR5H+gYWqiQKwIIM6nRlukWI3Wm6LaRezFr4eCE1NZav81riDpdPWqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(55112099003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTd1eHpWOUdKSDNreEJzdUJ5eGcwc1RBR25saUhhRm5kNVJVTUQzcUMwU05U?=
 =?utf-8?B?ckdiMlN6UlIrT1o0K25pWVp0WmhzOWw1L2N6dm5aUlhiODhJbm13c3pFdExy?=
 =?utf-8?B?MEpkQ0NTWGJzL0ZpKzRLSzQ4cWZKUzJ1K05lOGwxaXZnQjRJMEYvNUZaUTQy?=
 =?utf-8?B?L1FWMkFWZWRyNTNockZ5Z0ZHTzVGQXFaM1h2MVUzQldOMW5VVlV6SzZiMnN0?=
 =?utf-8?B?V1RLUDg2anhlNjg0Z2dPVExSalNtcGdXVCsvR2EwR1gyeEJJT05GZFc1Q1Rq?=
 =?utf-8?B?NGU4RWtGSmpiRyt3VFlFOW1aK3pjejF0S2pTVit6bGczZ0IwdXFGaVMrSW96?=
 =?utf-8?B?aGVZWHArWmVrZG1UeTdONDFSbyt2QWtndGVPMk8yR2hWdCtwcG85VnExeHg1?=
 =?utf-8?B?Nnc4ZEFnMzJzTzh4R3UzcTBDUW9SL3Rob2RLMWcwTmRuVmw1c25aNGgwcENm?=
 =?utf-8?B?Tm03d0FxNlBhejQ4N3BXWS9oQmlrN1ZrZFJBdmRrcWs3SXVJczVPNHNBWHhH?=
 =?utf-8?B?UE5xMnNmSDhiYXRjWW5PcHBHY21FdG1WQ0FDVkpoQVZHWWpaNnYvYW5ZQTRo?=
 =?utf-8?B?Qnl2M3RYZjBEb05aV2xNSGt4WXZlLzluU3JwUGtTK3p5MUtIM2Y1YU9zZTk3?=
 =?utf-8?B?RzJBa3BEdVBwQW1scmZ3Uld5SU91SkhLSkptbmFycmV0RUdSRTFjVy9oYk1n?=
 =?utf-8?B?U2ZZcVhhVWpTcndIai9iQVFYbzVJK1RwN1FIRHJYcHcwU1oyazB5NU4zaC9Y?=
 =?utf-8?B?Z2ZUb3RLeFQyczRNRjkxK1h3NUM1UWExY1RqTDBMK0F3Z0RDdDFxOTVpT2c0?=
 =?utf-8?B?ckdpN1ZVQXZEa3p1SkxSYlNZcFZFYXFYeWxhby9pbWFvT1BPZE9mWGRFcWlW?=
 =?utf-8?B?ejFrTEg1QlU2czNaQ1gyQmNmaGo5T1dXKzQzcXdxbGYyTC9sVm42SEY5SDNi?=
 =?utf-8?B?SmJBWWhFWmhJYkUrdUgyQ0VVeGN0OFRZa3dqTzB6Vk1QckQ5ZzdpRTdVREhk?=
 =?utf-8?B?NjRZRHJUdWJwQ1JxMmlMN3BzektOOEZhNE5ES3VEUHNPNlRkV1RWWUxYdlBE?=
 =?utf-8?B?OENvNUlUQ0xwTk01azZ3eFp2S29HcUEwYWJXQmdOVmFLMXR0cWQydnpjb2Y3?=
 =?utf-8?B?TnEyMGhCZ0Jkek1iMDVwYWRtYTBKOWhqdkJNd21lS3A0VTRSQThsbmRZRnJX?=
 =?utf-8?B?Yk1mNHFKV1p6VUVSTitJRXpSdmR1Y0drT0JydUZqTlNGbFNaMmwyNmNMdnlN?=
 =?utf-8?B?bGpzNGgzTFY3bmRqYlhucUc2VjM3d2JBd0xKNUd0T1hkRHFRWTcrS2pyMHFq?=
 =?utf-8?B?ZTg1RzRNNnI0VFpaRkNSUlNKYnE2RkhUaHc4Wkg1OThRdzRNeWlhK0JlZ3Nq?=
 =?utf-8?B?VWFwSmdXanFQZjI4SFlieGJ1N3NPN1F0M0dpZXJxR2d6dXRZU280YU9GSWNq?=
 =?utf-8?B?K1poSks0NW90LzJFSWVVQ3FMMGpKY0cyN3JQVytsTUM2S1J3TmQrMUxlVnRU?=
 =?utf-8?B?SHZzZUhwK2FMbXE1TkRoeGFYRXpsWTNxN1RKdGdrMllUNDNPSlF3bmljcEsy?=
 =?utf-8?B?RWpqMXVTRnYxenZIQ2dWUkRHeVZJRWJSWG9jQWQ3L0QwQzVFbm0xaG85Yys1?=
 =?utf-8?B?bXpQUXIrcW92TzIxUksxd0JFeitSK3laQU1tZkJxUW5FdXRYNm1jZ1RucC9G?=
 =?utf-8?B?U043cmlTcUZ1aktHVWt5ZDlzcXRVa3Q5bFNxV0YzZk5JR2tXeTUzL09ObUho?=
 =?utf-8?B?TG5CWEJOOGZlbzJvT28weUc2WGR6Y2J5SzZqWVVJSjZuQlpXKzlZL0Y2ZXI0?=
 =?utf-8?B?b0MvY1I1Q0t2Y0dkWUdxeEtTd2xTQWR6MGFLMWN6N3hwdmRTeDhYZW9WS1Jw?=
 =?utf-8?B?U2UwVGl4TWtmQ2lSTVBZTzd3RjErUnZaSUJadDlWU2EyUEttdkZBR1IwWERV?=
 =?utf-8?B?eDN0anRMeVBYV2krSkpycGdlVUh0QjF0T2FsbzVKNkdrY2hVdm95RURPeld0?=
 =?utf-8?B?cmVoeDRDNFFoaFJWakN1RTJhUlFOdTZER0swamhuMVdYbFowOTFnblo0amtq?=
 =?utf-8?B?dDdNOXIwUE95dVpseTRJQXR5TCtiU1dwdGRSRWV6MTFLWmxid2JWaXo4RjBZ?=
 =?utf-8?B?ZlRybjlIREhML2tBZTRkaUJwNW5BWGtLVXRCdyt1K25XbFJsZGlqOVhFeWNM?=
 =?utf-8?B?b2tPdkNRRTRiaUZlL1N1aFNhOU56d2VDTWp1REtIVVdwbk1oZDIvMmdTRDBJ?=
 =?utf-8?B?QmF0VjZKMUp4QnlEVDJ2alZyNUlTc2lqemd6U1NTSnhpSDNPaWpxbnBJQnRP?=
 =?utf-8?B?SlpYM2h0aG5wSWFpYktWR1RvamNPSmwwbzdNV1ArQjJFSjdQZ1FqRHJ6N0FP?=
 =?utf-8?Q?AAubshmbrxQCfnq0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b10b0d-c912-4459-69c9-08df2a32a298
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 20:35:07.6124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UO/2pjKCkthQgnYIEovdLhiRZqWmosJF1PD4K1QltOYaDNuKFgII4YrS8bm9K2igdSYznJ4tqp3vI3Cn+1eRQcRMn75xxLGAZjOzyPMeKlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5235
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


On 15-10-2026 01:29, Dave Klotz wrote:
> On 12-10-2026 19:30, Kathpalia, Tanmay wrote:
>> Dave, I hope you are aligned with the changes discussed and tested.
>> Could you please post a new version incorporating them?
> Hi Tanmay,
>
> Sorry for the slow reply. I'm moving my K1 boards to a different boot
> chain, oreboot plus EDK2, so I won't be respinning this series. Thanks
> to you, Zixian, Yixun and Anand for the testing and the careful review.
>
> Where things stand, for whoever picks it up:
>
> - 1/3: Yixun suggested a sane default max-frequency when the DT has
>    none, rather than trusting what an earlier stage left behind, and
>    asked for a clearer explanation than "happens to return 0".
>    Hung-Chun's RFC, "[RFC PATCH 0/2] mmc: k1: do not require
>    max-frequency in the device tree", covers the same ground.
>
> - 2/3: the BPI-F3 failure Zixian reported comes from set_vdd_mmc()
>    putting the SD I/O rail at 1.8 V in SPL. With the rail at 3.3 V,
>    Zixian and Yixun both see multi-block reads working in SPL. The
>    agreed fix is to drop set_vdd_mmc() and enable
>    CONFIG_SPL_MMC_IO_VOLTAGE and CONFIG_SPL_PINCTRL, so the driver
>    sets the rail and pads itself. Anand's dtsi change adding
>    vmmc-supply/vqmmc-supply for SPL would go with it. Both need to
>    land before or with this patch.
>
> - 3/3: Yixun pointed out that clk-uclass counts enables, so the clock
>    half doesn't hold. Only the reset half, where release() asserts the
>    shared reset, may still be needed, and that needs a test or a
>    reset-only version.
>
> Tanmay, Zixian, Hung-Chun: if any of you wants to take this over,
> please do. Keep or drop my authorship and Signed-off-by, whichever
> fits what you end up posting.
>

Hi Dave,

No problem; that is understandable, as we all have other priorities.

I am open to taking over and respinning the series. Since I do not
have a Banana Pi F3, I would appreciate Zixian's help with testing
the new version before it is merged.

As the author, I would prefer to retain your Signed-off-by tag, while
adding my own Signed-off-by for the changes I make.

I am also happy to contribute as a co-developer if Zixian, Hung-Chun,
or someone else would prefer to own and post the next version.

Thanks for the work and for summarizing the remaining items.

Regards,
Tanmay
