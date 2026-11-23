Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5720606A32A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Dx6mo/Uq;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LJQjMd4B;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=LJQjMd4B
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C931405DF;
	Mon, 23 Nov 2026 09:38:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g9Di3G7DQCzL; Mon, 23 Nov 2026 09:38:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2E42E405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795426738;
	b=FDdi5h7+s+Iy7ePsUPOMhzryeD0R75JCNszcQsaipt2uOE8ZN7D9SBl/Ij6siCTAPKUV
	 KoyOtFa8sxUeUMhD9HiwILtp27fCW94qXs3LoIted1/OPmt2HJfTsBdD1ZnbH+5IJh0gb
	 zLNVDx8i78x9eBWRcM2bgBsrUDViGCE5l1QIKz/3CRTj7si0l2Ifhv5kj7LyqbPcMZPcj
	 hqKb5mCtDESCSv8e6HmKFg3k8Nro4mao75iwZQN42TEXAxowosvO/4piTMvI1QL7+vuao
	 An3lGULTG1I11e5kPaoQKsG5YqtJNxqwic9V8RGb5XwBNojcJXBrElsMsiahTFS3Otg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795426738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=oR0TPSxDioe2xK2C3j4+b2DdFerHh13Tv6WUU2qo5g8=;
	b=o+He8GlGDhQcZft//ke239gy5ga3LNRtXQkrYnNVk863hFK6qmYKKBS28G5rGMVci2O7
	 ZZyQns9Lms1pCnq5RX1nXa18ii9TtRjJUOpXgF1ddOcnZewMs9A9slnI9/RmViYMyGPml
	 qy6p/BfPkB1iqtoxUGbIU0cev2zfOu8lT6JE1mYDjGGpJV8lSDTH3v7i+R0i7CdD54pwz
	 P0X5v5JYE/3UUJwufRVpG7SkcLqDokbInFZkY8pmbSZx09jPQOHD5qtV9Pp6/+viIOvg2
	 /5nLlDwUAPjttFlg+OCz3Q4jQm9svcuZXXik3L2sYHl00jH75v5l1j1S8GHzjdJgnig==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795426738;
	bh=oR0TPSxDioe2xK2C3j4+b2DdFerHh13Tv6WUU2qo5g8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dx6mo/UqHkxvFycDaqYsWiiqh+KOEwoiXxeySFQPnka+OBZTx0Db5bfnuaMRYAC1w
	 s/HvR24TxaAadND2HtVKfbLuoPRMXRldghKD/AF8NP4t2im/hhBoCtnVtp30zzBNFG
	 Cgl7xkQrWwayhX++OLTbpFO7Mcnnlv79TCRRQ8ju3tYrbmbH7R7JoPsC9PUK1MDjRl
	 esF/6/VlToEadPiWeW79qlDL6viz6w/1jEuut6yzmJGYku91bTiFsRGR+4cMuZXi76
	 ihactAgQp91AlLfEZizS3Ea0qPjaRGbNg2i8i3jQbdNytMjwgtQgVh3BPwiXno32Bd
	 jO0AmFto4tyIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E42E405AE;
	Mon, 23 Nov 2026 09:38:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C67BB499
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C3EE880982
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fNkws1n--01 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 09:38:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3C72D8097B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jerome.forissier@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=LJQjMd4B; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=LJQjMd4B
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3C72D8097B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 09:38:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4041846F7; Mon, 23 Nov 2026 10:38:51 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E02E0841F2
 for <u-boot@lists.denx.de>; Mon, 23 Nov 2026 10:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR0TPSxDioe2xK2C3j4+b2DdFerHh13Tv6WUU2qo5g8=;
 b=LJQjMd4BKNIwFfYHtFg2pPMJ+2VvVXXyZ/rz/io4UI8C8KySUNDaCRbAjDnze7RPiFBL5binU2hrMrZ0hQmlUuvPpoir3nogfflUhyAt/z51kmaKJfVqVY8tVGjAdAnvoR1rlcxFtogO2Iyw6AqZRvWeEMsZwy+vxS8epgWj4mw=
Received: from PAZP264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:236::23)
 by AS2PR08MB8784.eurprd08.prod.outlook.com (2603:10a6:20b:5f5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 09:38:31 +0000
Received: from MI3PEPF00008498.eurprd03.prod.outlook.com
 (2603:10a6:102:236:cafe::63) by PAZP264CA0176.outlook.office365.com
 (2603:10a6:102:236::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:38:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008498.mail.protection.outlook.com (10.167.240.183) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Mon, 23 Nov 2026 09:38:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR0TPSxDioe2xK2C3j4+b2DdFerHh13Tv6WUU2qo5g8=;
 b=LJQjMd4BKNIwFfYHtFg2pPMJ+2VvVXXyZ/rz/io4UI8C8KySUNDaCRbAjDnze7RPiFBL5binU2hrMrZ0hQmlUuvPpoir3nogfflUhyAt/z51kmaKJfVqVY8tVGjAdAnvoR1rlcxFtogO2Iyw6AqZRvWeEMsZwy+vxS8epgWj4mw=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM9PR08MB6131.eurprd08.prod.outlook.com
 (2603:10a6:20b:2de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:37:58 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:37:58 +0000
Message-ID: <784e2e28-b53d-407b-bb65-caba8b5a9a18@arm.com>
Date: Mon, 23 Nov 2026 10:37:57 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 0/2] net: tcp: fix CVE-2026-29007 and CVE-2026-29008
To: Prasanth R <ragaprasanth@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, nd@arm.com
References: <20261117085645.3142669-1-ragaprasanth@gmail.com>
Content-Language: en-US
In-Reply-To: <20261117085645.3142669-1-ragaprasanth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CW1P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:29e::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM9PR08MB6131:EE_|MI3PEPF00008498:EE_|AS2PR08MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6c7196-651c-4ea5-127e-08df49458929
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|5023799004|11063799006|56012099006|261021121427099003|261021135927099003|261021130227099003|261021133027099003|261021123027099003|261026121527099003|261022105027099003|261022075727099003|261026140227099003|261026130827099003|261022113327099003|261022115727099003|261009223027099003|261026135527099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original: JhMVTsU+zAMKRmrnxJe5TRNsCwL9BHDHUNE7RGCCHjsJeWRO5dlOQYfdFrk/avb0ogfQrUVHX1lpcIfnO/ghndqG1GVbxgm9WiCSyEcaMCsWYJhNJ703Nj931BAqKCmj8RF9IWhcUcG+1N2zOjm71OduslvuaS1QjJStLF7+YF8hXXSCVz6kBueM74NgOSLqg44ZQMOSMtjZDldvQ9f63bfBNzR5UNIoxwv8aDCeGqJo4vwJVFc0UWQur8dEhEzzfHndQbBINtFYhet/yyH5KQ61h+4ORLQPPVNjxhbyfr4LHYdimKYwMyQUE5Jv73toar4WdQk/oH545gS/S0Dtd82JAWYQ9JgjF3aGo5mSoH9DXphf6RrVF2VHbpjnMLWfWRnDUANkPqAej8m7uOqGuopGoeG9OdreH/U+ftYjYIZZ5zpk/M8C91HNZqfZwKYuTiefBFQlT4e/jpVqjgPs0gCaaH7e+r6UZhSM+J/7NQJFJ+WxfCY7Zwq5bShQEBsrp3THeenLKnEJRGVrEjV1IbehAMgNwsiNw0Arr3+/KwYGTWoKwFbzvZBW5/UTbHPip2VWn0R9QoyVWy7kd69f8N43KuOrPyEinKUIPOOEAPQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021135927099003)(261021130227099003)(261021133027099003)(261021123027099003)(261026121527099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026130827099003)(261022113327099003)(261022115727099003)(261009223027099003)(261026135527099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: T7cYOhIWveXFUUXUl6DzZqIeRMluMrfg2FGOpmiiNg8TraPLc+1VwHMKpTn4YQ0eo3k9KGA5y76TSLL7qO8WdgsH49IQyB4g+s5HFkG6FQHMciQbxxfI2qyZqH2Su473hgqG4k1kQzRsEuoLfqZI6PWXiBZQwPVXun7noYDXSaFxp8eIf7Z4dQK0e3IRS5phq2aEtQ0lYRF/6t5K/zeybqI6yfZRZFCH9sp+tycyw9/tLTNiVbrKEAKyHYjuqOMFaV8O3F60sR4HDNeFQ8sCJR4EJBY6hrfG+YySNviHw9gHof9Yda3ckJSXcL2mVYJ4XJW9xvL4YTNsxNF83dh13w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6131
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008498.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 980c2ee5-7c7c-4c44-3fc7-08df49457584
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|14060799003|35042699022|376014|36860700016|82310400026|1800799024|10067099003|261026130827099003|11063799006|5023799004|56012099006|261022075727099003|261021133027099003|261021130227099003|261009223027099003|261021135927099003|261102123227099003|261021123027099003|261021121427099003|261022113327099003|261026135527099003|261022105027099003|261026140227099003|261028144727099003|261022115727099003|261026121527099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: xzXZxtJE7VnjW8bAviMI9100bZlR8hNLCza3jbOMofAG4K2EPsR1CgMZJOKp0ZkdSXiz2VfAZBqdcE/3ScD2p6bd8W9I1xrWpt4sFacT+LfXSDDLGjN3JMwjSqkUiczEqkuiSlfO6nhOmF+O8u2CDAUb2l+DBvejua7Uj5u9G4WJDF4zFKlEbfhV1ysuVrg7tmWJhUXA823iRplQlL6xCegLklyO7L5XEQs9F4aFwoWEPTZUHQIOm5ht9fhOegKlL9fzjeS8z3JGtp6Zc6RYjEl6/FEIaRDy+Nn590BKrZcLb6tHclCtLGoMJbfOz9WdxURfdaFtXQSHMYEyNGqxXpEFK708iW4DfwmEt8fDfU0jxPJkDYg+Z0ACZa/ujPfKzFDdv8CODRwgWYham325mw8L5zxaf5w6yJbIw3lwIe4tx9O4BLaQ0qgnuut5NJ4+ZCwfRHiBp5B3tuH8TWidFoCT59c8XsCfoKQR69zsW2uwjwNoFJ6r7qjdni8izfVWFBI3Jup0EIKTjAPQsrvKgOvfUswScIBD4o0aMOtY0bl7SYliXhssT/nZjS3rWY9wFOD6wZXa5IpDmGCiRRWpJZdsksEY/98ROxwuOXH5IrYV05xeeM1MZ/HOxSYoq/bfM3xplVmCoJ3lD/ijmdX5zQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(14060799003)(35042699022)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(261026130827099003)(11063799006)(5023799004)(56012099006)(261022075727099003)(261021133027099003)(261021130227099003)(261009223027099003)(261021135927099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261026135527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022115727099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PdVDfzMi0QTQumgZpvRx93UZ6hunfnzbK+KD9yQ1cJNTPgg0mTvg4jRTPgb+gndYNNNzeAGJhzdklaI2gu43UnkhyXPz/G1eixms234T0/ohiBw/k4LAWxPLXHiTCKRBbrj4mhvMNbk1CdCqIAfTFPQOizaGUT5AIYrxH8Z581cGXb5n+sjLHTFtsYPS/a214IkyY3Eknnj9cJrQ+kk9FOYYQRvt2aUeQ67upy1j0wfiOiywunVhMA+nr+nmaGMMpK/5VTig0L1ebjoCdA8lhDKqVWrqaTckBCZ+7RdupYZnLgK3ejZfVrgQbwZyNSOlmpYYfRBc85yv8Iwb2gF8rwi+mKVKOlZkfOx307ZrXzDrNT4g0bt2pNmEijIf2lQoOApIj6HKyqTLTKbBiZOvvEIR7cJoy+mzmpD8yUtkU7umOvgDUrAriDNzCM2K7e+S
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:38:31.0956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c7196-651c-4ea5-127e-08df49458929
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008498.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8784
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The legacy TCP stack trusts the data offset and the option lengths of
> received segments. A segment whose data offset points past its end
> makes tcp_parse_options() read beyond the packet (CVE-2026-29007) and
> makes payload_len negative, which reaches memcpy() as a huge size in
> TCP_SYN_SENT (CVE-2026-29008). Both were disclosed on this list by
> VulnCheck in May; as far as I can see they are not fixed yet.
>
> Patch 1 drops segments whose data offset does not fit. Patch 2 makes
> tcp_parse_options() check each option against the option area, which
> also fixes a read past the end when the last option byte is
> TCP_O_END, and limits the window scale to 14.
>
> Testing: ran tcp_parse_options() and the length handling from main
> and from this series under AddressSanitizer with the malformed
> segments. Main reads past the packet in all cases; with the series
> the segments are dropped or the options ignored.
> Also built sandbox on current main and ran ut cmd net_test_wget: no
> failures.
>
> I used an AI assistant (Claude) to help write and test these patches;
> I reviewed the changes and the results.
>
> Prasanth R (2):
>   net: tcp: drop segments with an invalid data offset
>   net: tcp: check option lengths in tcp_parse_options()
>
>  net/tcp.c | 56 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 20 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/2] net: tcp: drop segments with an invalid data offset
      commit: a0e2935a4bdeb982e48a8f13fa257bbfc6d8e657

[2/2] net: tcp: check option lengths in tcp_parse_options()
      commit: cf248526dbd1da6622b58483c307cb837fb76165

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
