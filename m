Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA30606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kQbddX7+;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=N3FAqB79;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=N3FAqB79
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64E3740947;
	Fri,  6 Nov 2026 18:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id boKX4HclBPqk; Fri,  6 Nov 2026 18:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 619814091C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793988497;
	b=G4dRUAYP3S5Ogryr3hNS5c6FsClnCXf+QdGmWBPqG8Kk9VSqODWf/iiiC8slc1xx1hkm
	 FPmUanmrEWVZrKYOx3tnl1BazJJqF09zLynpRVO7xxqx5n2kKQ1Do3JmK/HpoSBABgdj8
	 Sd1XswEVxHAr3T27I3fVhurExctwffAYWAX/Wfx8vv3OF6bCqCBFfEQLYcisQc04pnRAN
	 OzXvSfHJeDkzBjRJid3IblEAslbNgn+VpyNCHWdha/vVMfZ/VgdcA4zJ9Ve5BiO/rfWoi
	 t16EUM9F1Ep9v6/MgAEwCqCB/601TLkO/sAgV5ySm6hLOc6GwBUGBQ9lXLSEhlo+Z4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793988497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vyFwAEoYVjPEgQLEXN6+vdcEY5xq85FJ21FERQtuBAA=;
	b=KbJu+f+XJDjOZ3OKRdQlrwD17RQ+JSPyExc1dHPijkbZEkssHAfu2OlG16zOZKYHWHL+
	 5VTOn+R3AzzdG9+wmjInYuEj13ctCMWstRZQm1JKBL7DrvAjBStExJyGkjxcRPOoimbEm
	 u7SzyPghipU/a0xqNG8H3mgnW4qKh7MmBlB56UDq8l7r0AHB5JgSzeRuHaWwYSxtAuTyz
	 6VPUbPPwbLUunZddSOzhUv6Hc/rCpZ+zBpwTAnktpdMYIoNyKogxMWicnlci2zgr5Bwj4
	 6ZNsLeJpDGgKmMfShYjT+qJmLFMkb8xpeSrLVbDyFiWxMASd+xeUsiZ3vAE5Jd/ZDSg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=N3FAqB79;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=N3FAqB79;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793988497;
	bh=vyFwAEoYVjPEgQLEXN6+vdcEY5xq85FJ21FERQtuBAA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kQbddX7+/3QhivgcZdHRGMJYiHBnX3BiBimVoroIl7koDulg/+MLx2ruI19d0mjHn
	 2b3b71tFRtsDqSh5NXn36duPbT/fkpcz6M4oeXglecib4riK1TIUorOA+iTM8zDBAk
	 WT4OFLAzD83zh7W6kADUp+05cH60KF4P+lOFLU4Hbzoihz2ojIz0j3JXRy5R79eFSd
	 hp6J3zNJ5oJ4vKee6sRryJYLA5O+MmJmrt95rRHdZRW9U8SL6YWLiU6J+0clHeQglK
	 y/r1+1dPvll3P9Be7vITBwyjbr9IvNjK20f7f/u7hcjhX9ZvJEEQ46zQkns/EMJWxd
	 TdGXD9GO3u5DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 619814091C;
	Fri,  6 Nov 2026 18:08:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 364F52AC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BF4F4091C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j93EcCD29gsE for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 18:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EDF5C408EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=N3FAqB79; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=N3FAqB79
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EDF5C408EE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 18:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyFwAEoYVjPEgQLEXN6+vdcEY5xq85FJ21FERQtuBAA=;
 b=N3FAqB795dy77uBsb8tByQv2i4Vb+fpYblycIgEmOf9gbu59ZsOOKNYKjxz4qbXfc2PH/Hby+9qMXYQiuJt4qO76PSrsdT1ipaVQ+xFVfIFjfNmVb/5Y1FYaeAmrUFpb6axnp70+HsBYUp3JfNkWbnGuvP1AsZbhYbm0a7dW3Xc=
Received: from DU2PR04CA0322.eurprd04.prod.outlook.com (2603:10a6:10:2b5::27)
 by DBAPR08MB5621.eurprd08.prod.outlook.com (2603:10a6:10:1a3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:08:08 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:2b5:cafe::4f) by DU2PR04CA0322.outlook.office365.com
 (2603:10a6:10:2b5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 18:08:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 6 Nov 2026 18:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyFwAEoYVjPEgQLEXN6+vdcEY5xq85FJ21FERQtuBAA=;
 b=N3FAqB795dy77uBsb8tByQv2i4Vb+fpYblycIgEmOf9gbu59ZsOOKNYKjxz4qbXfc2PH/Hby+9qMXYQiuJt4qO76PSrsdT1ipaVQ+xFVfIFjfNmVb/5Y1FYaeAmrUFpb6axnp70+HsBYUp3JfNkWbnGuvP1AsZbhYbm0a7dW3Xc=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by MA9PR08MB241936.eurprd08.prod.outlook.com
 (2603:10a6:250:104::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:06:53 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 18:06:53 +0000
Message-ID: <a514914f-c0d8-4a44-9bc4-86b2d9cb870c@arm.com>
Date: Fri, 6 Nov 2026 19:06:53 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: designware: Don't cache the MAC priv in the MDIO bus
 device
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <sanderson@brivo.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, Yao Zi <me@ziyao.cc>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 u-boot@lists.u-boot-project.org, nd@arm.com
References: <20261103180348.1026425-1-oss.patchbox@gmail.com>
Content-Language: en-US
In-Reply-To: <20261103180348.1026425-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|MA9PR08MB241936:EE_|DB1PEPF000509F8:EE_|DBAPR08MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b52d41b-29c5-401b-9445-08df3c30e948
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: lYGew+47IBpXiA9X0AHasAcYzpDWCflnLGanjYOnr1R8LUGYx1D0tEhdbRMl6mT4mwLx57ds90j9ACJwUK0ECXt/nIImromCoxYt9UDT0H3ER1EtKpQIAbJzNeTBnwHEYYFng2E4fCbwHJR6ONqdAw7dSquUsHwIW41NMFUrkUiA0eEieM1VkXv6K+0bBkBdoqiwdQq34u8znugDJLl9vB7PPCC7dAxImiDfzWCFJIseEv+G2UC82m3dHR0XaGuDz/xhT4noA/lcrJiaN1VdbtDLaWjIhwOwSrKv7OhjGdLk1OER+qbb+9Iq3vF+Tp2Ao0XjYYdwquG1Kqd9teNcyQWJ9//QuYFdyEEePNMjb0mpPl5OVdlFQliIaDFaMuEGOVwHbGjyafrpKrLWryWUoxPxXTJgTjZU7dO6ccyAjiWOx5pt18Mc7DWOmfjgvt8G94XDXDf1Wf76q0nUmUqYADfZObN9FgYByclXGo/2E7Wv+flYr559v0OIJGzOb6S/RdbI0iWsVeT67mafc6HWsZWNbVIA/z7ApLpGUmJwAZvD+9jyOSxUXHErwTLC3THG/q4QtmN8g7Doa1oNI3wm7b4Ur7QsAheYY+TeNcu+wtZ4IqUohFWNlcrc4pLh5b3Y
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: MfnHxjrCiaCkEmFnMk4TPLFOmL7sql5WtjF0oXRH0Ym05Bw2Uf+ef81zM1zZ/ZJYeHFP3AUEG+6pTbJ7TuryldNoyoTU4SwpAKdYWPew/1c0kjWWnoM6wYov7dcCk4L9SYXJoxc27PXIgdjLGpsYmvHUT+hxiDJ27WbIeTlAA4TANMTb0kqQep9Nb2bXr7/tAq9daEfdNixrQa0obz/4yLXB3WGNfq0iveD8s+yeXjkdr68H8igGWZzSg1Cm+Oo5lzWU6Yd/Aw156An6L0RMmbuTRvxZvpPF9LZDxJRvVpSOt4jY+NTbGS7rqZM+WL8Fk1e1lvV/otnZ7qooDRHdxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA9PR08MB241936
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 387c483c-c46a-4e6b-08f8-08df3c30bce0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|35042699022|23010399003|82310400026|36860700016|14060799003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: RNCeB2l+aVH50QyqKdzWyqs6OcG01hJqE0C5X4gEqYemYEL38nMc77OvPj/CkuskT3XXsVv+uEjEMqLD/SZBZDeK6GeMehEjJpnVC01X1sycTF2bqZvA6LgK2Rjau93zMgwcTNlzi3JVxKhMiu6eUAFtsmv0Z/RypcgVvfsqqpuWrpNp50Kq9Fg/hA9rkt5JFZP5xySK/GuVUmDySHgmM92Y3bzZyEPTpxHNHexTv2ynlqinj5WhVK0NGfGx52D4dg3to0GkFBFuNBKXwDaszIi4+VsZmzRL11UHoYmtXS4juAqHhHVwokIU/KYUEM+VLBHBmUlJCPwyJMsBWIHc0/3QUHZ2ame+JWs9FV2YH6Qhz4brBKFNdXC30/3lUne7szArOV6Nq0B17c081iNixc2lewz5ZMOUMic6iqKN/r5ayKq8lHg7QTs6c8EpNzDBDhYR4r6i7VhCkimXdNr8O2kLKBQ9H+b5wk2F4K64hMa3NGN7lwJNH3QzmNwRa3WoX/GAgAa0h4GR+NMmMHR4JTCeMHkMW7PBs0H5br3FLcPDG92UuJ1DH4Q7/05C/xOsmSHCWtxnUoqCl//y4LfYDXPPdTUQ4EORZ4npXQIVmoG18A+A+V+8bRRc0EksJbWetPY/HDx8WJ+NLpcIFQ9U8NV94YEvSS1MH1vWZWykkq0=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(35042699022)(23010399003)(82310400026)(36860700016)(14060799003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M4hrX/qKLudqILzPBB78RycG+bnxB39dWRYnobXmwi6JpFrpZFhRiCcpsHr/Ox6uzRIV3uP8kWU1dcKNu3Xu3Ed0xjZSJAB5xy1LXG2e7FeI2HKXTe2mpbTmWCrCWnV0L9l8bHHDiAa+VlRhImnji86TPnpl1W+zhTOrYuAS1naz8fGOazmhuPFpCf4kglU6LNdA8/E0uxcupZtsH7Qc/SrhoAUDJOXVIF9WVO9ENCbntWSOCBUQY5B2GYV3N27qNK9CDOFrqYqS6hM8U8c/K0kGN8pVXkrm01ubElgVqzBpMp+218vxFXhgDNq11qgWHhNMLcqgBLjnUFr6dZtSgvgulB3H1wWlKBGlYZ3jzuVzky8O1Dc9iF3qRnYjtIflgGCAnrmRdydqWSoh9S3EhDO7M/RNvOYoVivN1DuAP1zpcwPzJ/sVWaQdRQmNFkC0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:08:07.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b52d41b-29c5-401b-9445-08df3c30e948
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5621
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> With DM_MDIO, the MDIO bus of the MAC is a child device. Its probe
> method sets its own priv to the priv of the MAC, so that dw_mdio_read()
> and dw_mdio_write() can reach the MAC registers through the device in
> mii_dev->priv. dw_phy_init() probes this child through
> dm_eth_phy_connect() when the PHY is on the MAC's own bus.
>
> If designware_eth_probe() then fails, e.g. because no PHY answers at
> the address given in the device tree, device_probe() frees the priv of
> the MAC (with DM_DEVICE_REMOVE, the default). The MDIO child stays
> probed, its mii_dev stays registered, and its priv still points at the
> freed memory. Accesses to the bus then use that memory: the "mdio" and
> "mii" commands, and another MAC whose PHY is on this bus, as on the
> LicheePi 4A. If the MAC is probed again, dm_eth_phy_connect() finds the
> MDIO device already active and does not probe it again, so the copy is
> not updated to the new priv either.
>
> Look up the priv of the MAC in the MDIO operations on each access
> instead of copying it, and return -ENODEV while the MAC has none. Drop
> the probe method that made the copy. The legacy, non-DM_MDIO bus keeps
> looking up the priv of the MAC device in mii_dev->priv as before.
>
> Fixes: 5160b4567c71 ("net: designware: add DM_MDIO support")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Build-tested only, on th1520_lpi4a and nanopi-r2s-rk3328 (DM_MDIO=y),
> socfpga_arria10 (DM_MDIO=n) and arbel_evb (DM_MDIO=n, BITBANGMII=y),
> with no new warnings in designware.c at W=1. Not tested at runtime:
> there is no designware MAC in sandbox and I have no affected board.
>
>  drivers/net/designware.c | 52 ++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 21 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: designware: Don't cache the MAC priv in the MDIO bus device
      commit: 0985149f0d3f35e1f3dd3212ca4decee6b127df5

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
