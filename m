Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCD606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vqLQ8Iam;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ig1TIZuM;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ft3TW3BT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 393BC40573;
	Mon, 16 Nov 2026 23:29:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B02UA11ELatg; Mon, 16 Nov 2026 23:29:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2FF9A40486
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794871778;
	b=dkoDpiouz7ISFvX1ZQnr5qJKeAH1bxe33SjC3mUFk/IstUbGWWSjiupb74eTX29YXFez
	 x+0EsywxXUSuIXJXIqhwqg6AaHNsrpqs5uJSK5PD6YODwWLa1BHUeH/hpK4IvCvODLhI0
	 EDL5NXtde8bJKf1WGisrD1196sQC2Nfa7yoBLh5YEDZf7/8tqRfn7xJXktssEEwPEfWo0
	 8xNPkY75epUNg+q2+Vr4jNpbpMWlVYOjsPnXhRdfR4mh6gbWaeXtiEiviKoJg/wIY4tgf
	 oHprZqkKZbWHKof3/xvv2mLtRSVuKedgzBK/Sq+SjmQR91IdMFVWr0CkJEpkdD+5A8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794871778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DRiTMzUIQlml+hL8/kmUxHSdl2lR8Sq3HMyg1itynoI=;
	b=YVVqjsKn3JxrYL+ZLsKpdoJYZ4HT1X/h7lnkmVUqEDvOVBoTSsUvy+vpYvZZeri9u+oR
	 +R0qg5WnWndwzKL0whM5Ldt9IEy5BVtlsHvJatw1CLg2WahYoD9h44mNEI05/SrwyZMQB
	 b1TJaRo54DgHTHKEZnbHLw5s/D3RjTg+qC5fsH4HiVZsAHhaZXrR0Omf1gVZ7XRXaLscZ
	 iqC8tZfTwfeV4jc82sfa8fGgyewN9Ssqq8Gi0GGJgJtL6HAoEpuaoU1nWKK+bC58QLjnL
	 qJvX9uUnit3zdbJTKBB4/J8feriMFNUN19YaWi1AXNLeWQvIPa3EM5ww2aBz6gAZICg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794871778;
	bh=DRiTMzUIQlml+hL8/kmUxHSdl2lR8Sq3HMyg1itynoI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vqLQ8IamCFAnl4UhqOYTEDhDvooIrx94xCuoRYyry1CA54wT8Ru8LDfOAaT4KyWQx
	 NU4hQqtr/XtmGPV1b1A9C3xlrZbuVteBTZgY9yX4ZfWhX1JZDsVbZLS36UnBp9yMKR
	 GCPU5uXWlHPoB/cxKNBajk57mgifwFIgCZDJ9H/rSG7SVwY4rfl4aPeqzxVjxAIfcV
	 S+NstdHAb/MWrNWzWEs3d6e6ZymvGheF7X57lGG2nTwmjJe+Myfnx7ll7WdzPCe3/U
	 b3NwKHn+JoOboCIgtspI+RisE15IyYludP1t5jgZCJEONXmDNu5jFmyijT/qE72kjR
	 TxRDaz7ufxDYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FF9A40486;
	Mon, 16 Nov 2026 23:29:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9794328C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89699400D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s4330hd3okz9 for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 23:29:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BED54400AF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=jm@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ig1TIZuM; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=ft3TW3BT
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BED54400AF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 23:29:32 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AGNPM1d2530879;
 Mon, 16 Nov 2026 17:29:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=DRiTMzUIQlml+hL8/kmUxHSdl2lR8Sq3HMyg1ityn
 oI=; b=Ig1TIZuMDxyAahssw69/W8/q+w/3Xt6HvUYm1AhGPg9cTjLGdSsgNIYRD
 AGjzzR+GPzBjCLsS+F1/OgsuwJ13NAEySFM7MUpEGxiVPhr32klhjLcF9/Kt9PPu
 9ZNbTOfp3Mln+nGdBO0qY0WLCtTVB0bstHEIIsGWf1VajZ+LeArowJOUEo/R9Yz1
 mtz3mgTQnvz7yiTlqGthB0rvnjSvWtvaC6XGwFI3sX3w3LK3CpDdKhbQoSljlCDR
 v5R3m0+IFSqVFvQcKYheGkn2IIBZYmbZ5RG8VDm9GFOy6cCMpSDX7zWlvGAvDrgb
 wLCqruM6uCgvI1dIEgcrH2mFznHcg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
 by m0380145.ppops.net (PPS) with ESMTPS id 4j09f6rm9v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Nov 2026 17:29:22 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRiTMzUIQlml+hL8/kmUxHSdl2lR8Sq3HMyg1itynoI=;
 b=ft3TW3BTfvQTx1j2x0kLCBidR9GdWtjFe1wI1oM9XQ5hMxN3c5ZXwEgZK+rMxBlTUh/QRP/FdFuHQMLnMblkMFl0z4BSvuWw9+ojDgxMoNPKJv1vOrVQqrHFGyNZg3PUn3gw+ssHenr2rWE5fxT92XZKSD8QwKKnUBr9oibMe4c=
Received: from MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 23:29:19 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::32) by MN2PR05CA0058.outlook.office365.com
 (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.7 via Frontend Transport; Mon, 16
 Nov 2026 23:29:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 23:29:17 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 17:28:26 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 16 Nov
 2026 17:28:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 16 Nov 2026 17:28:26 -0600
Received: from [128.247.81.105] (hpz2.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AGNSQ921694086;
 Mon, 16 Nov 2026 17:28:26 -0600
Message-ID: <1921fbd4-94f4-45d0-b708-d327fe6631f0@ti.com>
Date: Mon, 16 Nov 2026 17:28:26 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] arm: dts: am43xx: Switch to OF_UPSTREAM
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 <u-boot@lists.u-boot-project.org>, Julien Panis <jpanis@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 "Andrew F. Davis" <afd@ti.com>,
 Nikita Kiryanov <nikita@compulab.co.il>, "Peng Fan" <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 "Francis, Sebin" <sebin.francis@ti.com>
References: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20261104-v2026-10-next-topic-am45-ofupstream-am4-of-upstream-v2-0-6091edbb51fa@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: dfb4e18b-5466-4d1c-afa6-08df44396f23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|23010399003|18002099003|22082099003|6133799003|261009223027099003|13003099007|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: lTJ5kurf6GBL4np22ja/szdK6qrRIeb4bxL/QsijASX6SeAfqat4rvOzFRFDhu7Wq4m86ZEdyh7tqxgZYEkgqmDBwmmqGB5RNNNRY+uJoMj4/wiutw4cc6b3uVco589Zbyes43/erKxS/s5W41TmsEoFgPs7gmwG6M3Wm3IalcHCutzYckNqR2Z6/hC8I1IVkEHhaQTL1tvYrcPfbS1xbUCiqCKoNaBk7NYfWMQf/Lhc3Y59RmsXQmwez9ECvMnMn8d/cn7c0eoY55ix3uXde2jaHcsHZcSCx69Xp8+e2Vt6KoH2JCUikBtVMh8pLGaHrzrJiukcHTCt1TKmLI3LbhCo3iypRBxztqf7SaqFqY+OactWDc/HMmgj7N2HPO7uabO5QX0biJNhf8xmzxXfp2k/pLt55mauUNwrVk+BLLbDHtDrJTsrzfiae2L7cOAHaNkRVntaUrOThULw8RJqjyllxJG1K/TYPqenEMkhCI8GrXtK6Q/7v6yHKFpSYrdDfBbfGQLGCqVM50xmWICzXMis+gX3oz5dUc8UfOb9VgjRMJU3vuA1DnqBtZoabhJqOhdXsUIc9KOaukJMDJPYCHbEUOrywMiuL0ytvn0qjdR3hdL+ge+hR+Urb/EvmXWfgi9BHSbPBoBsDL70AfvVWDK/9XFzFx0atsIj5gMkIEc=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(13003099007)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261022075727099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NMI0tGGTvc5liaLp8ki94NLiX0VP+4KPD+2KtUjttQtZP9Bfz0or2sz+Vmyt9ZBHKgoJWcpldMxAMi+/CngDh3MzIcqBRRWRWgd1wHvxzaitBszFL4Xdtqm8uLAcKCsJhBZwyBri/7W21w3dRrXmGCQnKfPm5dNpZiC357pAglLMwRPXXgWQf85n+d0thxVqs/phNq9CyuiTl6EvfSQXy1Akc+mnwBRWuWJeugXUj1qe6TE3rTSPF2IN/euDBZHsX+EmhsJQGi21u8ZqmzB6a10G+4DbsAg/OVaV4GPs+bPJ5p9ekHshdfBvxIXNrdwwwbI6XvKUAa31vAkbjAwOYEAYvlkE2sw6UYd7VHwKm7fp6m9rYkkUaBWoFEPqXzF8pCOIkwBH2PH94OYbofFZDEcoT7w2mxds2Yt6FHPNLklkQH3miT7cE7/w2DChVVVB
X-Exchange-RoutingPolicyChecked: g9YneNDGxgz2aJFgErdSemJxbVhvjUPf8g1s8qmreEzwn6QpoO6rcnVbbLYCvk5pjDK/tLGq2Lwsh40UoOB6tQbe+ewQBRO6mbOiT6VyvG1YaWwWHTIdWXCCHooZ6dluPwuE6Ay68s9Y+l98qVYGc5BUkNulyahSujY4jXaYioPJ7MNn61jqK8FWWR9whvi4Ynhe5SM4hEpd89cvM5N6RKFzlCH5l8cWRkojyqqWkuQkat41qfp35XNTTlb41HG65kIoUHz+5k3UiU8hE5RLp/h4SJuQGuQN4Zrc/wnuwlcNrgv7fUouLfG9HIJEdPop+y3c15fFrNG5JwtxjZVDSg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 23:29:17.7149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb4e18b-5466-4d1c-afa6-08df44396f23
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX1+Ne1tWxAwg2
 jOPZ7xo/1rZhAdhI1JlGjJKvTolFUaujnYshp8/pWrA72DOHW+C04+PxUgIuiqRispOFT1Qhuqu
 wvvFm29btEreJE6tNrw4vIPgBaogiSI=
X-Authority-Analysis: v=2.4 cv=WLjqzXsR c=1 sm=1 tr=0 ts=6afb91d2 cx=c_pps
 a=OViojaO3c1oaidwcGWKC2A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8 a=TkTV6T0WQADC0w2EjwkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: q7WSobjZO-uJkSVLXc4LWCg7sF2UbzJI
X-Proofpoint-GUID: q7WSobjZO-uJkSVLXc4LWCg7sF2UbzJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA5MyBTYWx0ZWRfX1GzVm2HHd7qZ
 PC58jEeCdeTVnBIHqC4QstR5AbiSMqVPhBRYNSTTlIqXcc3wJDESMjBxbdW/8F+XNsnpbQuBEuR
 v+CSusdy0yY9ftXNFkSWaTgQJhUHMm5d+minacvmbQaPkIDtMwGp9nGkLpt4Z5NKYBCbcaj2zC/
 qCVzFss9Q34lNM3zrFsDWXlevXc9sreNg19KGba+7qDqIQMr74O6x64bcBT7JmDSGDLZjgUdrBy
 4b59D+GvFHF/f1dvCmQtciJriqm/vrj5ee/ACmXKsY4LRY1R4n5L6EAfHKC3rPwsRrriE68ygxN
 8KiabdgagS+adIX5kfN1zVvX5cyvX1LIpAA3Qq4cWhsLobeJXh5paBGsa3Jym8RWLcT9qkdIp7f
 rpAyTW+dpo7A/vsouX0Zre3rWVEkaK4P46Dta8Dc7MvMwv6Jlw8gM4GBvwSNMCbjL5ezdKVuFnx
 9DQ0R6Z4K6Y4Y5nCEKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160093
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Markus, Julien,

On 11/4/26 3:47 AM, Markus Schneider-Pargmann (TI) wrote:
> Hi,
> 
> this series does the final changes to switch on OF_UPSTREAM on am43xx.
> Mainly it adds some -u-boot.dtsi files to define tick-timer and other
> necessary pieces. It changes the defconfigs and removes the old
> devicetrees.
> 
> This series does not have any dependencies that are not merged.
> 
> It was tested on am437x industrial EVM with mmc. Help testing is
> appreciated.


I was able to test SD boot on am437 EVM and AM437 SK boards and I see
the following:


EVM: https://gist.github.com/jmenti/9c494e63186ad0ddc87aacc974f47336
SK: https://gist.github.com/jmenti/a5d5ca0804f6c0f94e640d5fe0b76030

With signature:

Retrieving file: /extlinux/../am437x-gp-evm.dtb
Card did not respond to voltage select! : -110
Cannot persist EFI variables without system partition
Booting <NULL>

and it pauses boot here for a while.

Is this expected or are we missing some configuration for SD card boot?

Figured id ask before testing uart +  nfs and am437 IDK board.

~ Judith
