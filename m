Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE7606A322
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0CoDeX1A;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=FletjMZ3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B96540648;
	Mon,  9 Nov 2026 08:57:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hFN3OQJrdwkC; Mon,  9 Nov 2026 08:57:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2DBFA40636
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794214624;
	b=n055m55GdCm/qEHGzDxe3P66bVa0zjCSlpvZUB/+9PczTOOZWsb3tLYT4BhX0sJOgYtG
	 0pbA/gWt39ncFCJCZoNuQjboXVm9sXmshaEAlPywfV7ANP+47s/QoRp5Y522MN2YXQ5Dn
	 ZVYEoWB0+GQJdR7vJXKxGOYsNT7OM1xuMhhBAOxr3RaF+A9rRYjV9VgW5QApnkyMbUL3a
	 EkovS3tDBzUhg/0do8ruBf7D9ZU1Y1GEemuqXfsLxoy2TxTtOVF3bKHLpWLScCp/IdFCq
	 urtaTpNvKE/hZNpVxPdcODD1VLrTUk0O9UykcvMy5YzrZJYazdpBm8aO7buZPFpHjdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794214624;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=XR1lUwV+UCBBDZbwMXGgyfcsNv7ePVHIxU3RrXIPzRw=;
	b=pmjIG2MJPtkq5Poi2xsOSWNmEV2AglGVdioAF4PecWCIdqR1v/sARN+RvYtlM5iRaiIk
	 AmBqP6nydvf95p5sd3RjaOxnqeQSrn23iqvrKHVStjz5KeYrlA/fXHtqznNuB7d+Q1Wq5
	 hYv4CeCFHB1ZfRGyAG78qM13Rps8pqe8WvB8fzQEYq7OLfPj6u13Lwyrm4fZqGvvj4r3E
	 EVB3RZghN1pOjfABAAUHjijwopg1JE8C2oRhktsNMkRnZWE0z/LGMsb+vPZR9tjsnp4YJ
	 Bdh5fUUxHpHYnzH2RauE1qe3XiPgNFXR5aCI6O0X1rONd/nytYJ8m6N3AGWyaOUZ+rg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794214624;
	bh=XR1lUwV+UCBBDZbwMXGgyfcsNv7ePVHIxU3RrXIPzRw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0CoDeX1AREe6EN3+XV4E2i+RJ5Ul4NVUHeSPJgpEC6q2Uwo3WWmOU0lKH+md5Ki2X
	 KbtnEcozelzn/ZNnrhlx62XTL95JFUGPHWVrZlHoGiokRPBvRh/1ReBsLf8WB1z3+7
	 SVOHBV3REKHsgmh/NEBGlDCXmrdJc7R6vExg0p9kWYZtvWGbl+b9gLmo3bjG5Vv9uK
	 gyJUkOAjbyA9YnzJCerYLYe4WPlFT8ISyazNjQeiW/Jbe9ISYwdm2SNmRDscCUqXmq
	 +d63CypWjBBW6B2C3BWtyZbvNpOvMnHxplp/zi69d+oZVFNMycxJP2wR1jDZxiY3DV
	 nVqGLJYcD9hng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2DBFA40636;
	Mon,  9 Nov 2026 08:57:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F599235
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 05230401DB
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:57:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2c-VJVbL9zKP for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 08:57:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BF811400BE
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=FletjMZ3
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF811400BE
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR1lUwV+UCBBDZbwMXGgyfcsNv7ePVHIxU3RrXIPzRw=;
 b=FletjMZ3iTuU3o2pDai2gDacOL2aKoFQXQ05cmI6x/ulv2gcjUR8IhYB+Js5XFTHdsmy05kWaxx8DEEanml7ONTnfnNGJoXLvlR/tMteTd70eIsRaLBdYbuvZAzRfT5TxNieDpR8qGOysR0uJcghHQbRxfucmlylGfcpXp/EvbcBaens3Fzmkohj+guODnjg+uQZKPuZTbpugbqfXVzyDitDYXVFKx2k7HgBbsTBOZwzIDK1wTYFIeFFmV+hBRGhyOng+YX4plcMGCbRwWNUbbkFOUyWxsT6Bqw3m9+Fv7qoXUPjTdSuPu4IuD8tWmXaWx1F0/kx2QOC3Fydo7tc0w==
Received: from VI1P190CA0045.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1bb::18)
 by AS8PR10MB7400.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:613::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Mon, 9 Nov 2026
 08:56:55 +0000
Received: from ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
 (2603:10a6:800:1bb:cafe::a4) by VI1P190CA0045.outlook.office365.com
 (2603:10a6:800:1bb::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 08:56:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6B6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 08:56:54 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 09:57:34 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 09:56:54 +0100
Message-ID: <4150daef-4e68-43da-8249-4c9899eab90b@foss.st.com>
Date: Mon, 9 Nov 2026 09:56:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: fwumdata: fix redundant metadata buffer overlap
To: Kory Maincent <kory.maincent@bootlin.com>,
 <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>
References: <20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com>
 <052c5303-be7d-424f-bdd9-ec4198250a4b@bootlin.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <052c5303-be7d-424f-bdd9-ec4198250a4b@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B6:EE_|AS8PR10MB7400:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b25921f-68c7-4caf-def1-08df3e3f677b
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: oSKCfetnqHNb49W5O6gw5+wn/bua5o/xY1vxocaRfdSdNOemxiyjuSvUWJ0mZaVX21nbCK6DZwkHeHFQ8mIMsBRUME8ariVeB98oOtw8ltHV19MgMzXMEKE0Ufl7DwR2fpR2bVA3kb2zHKR9ZHKSSI9vWMHKvVzlZLOA0WrZnkbd5MR3cZKfTFIxgS1rjC2coHKp+DDYLZqSiqhfB58Kjk4C8mIAawQwcsk/w1g+pXRpcHHP5NfUdcEpOKDfgQhLLU0zk5IJoJfsXu8k6M9RLHUfcDfGL29dAp3+uKzsBjw5ej457jox4aS2a0Hjv3YZULMxXC0e92pnDMqs4HuuFgSO8EixVbAJ79BCLX8X/XEvzrtnmnCp5Uf9TgOI/8krJmweLQMCeFpgtf5dHiVI/Rfj/MMjX34hczNHT2lWcEZbQ0EXUusDCSBi7Pqz/fdZtaz1wt4dY75VnezjI9pgz+J30SQwy/gwtrfHePZUOUyvMZI1HjNb8v4degR58WN9RNHnpsYEt/wXHRQwZ7bjqTLzA98/jfnts+1mE+HUCT93AcLkALJw5osdF/FV1Z/stUn/YjhrLNyArlESuapl7/7Moc70vK6b3QelBZ/LGxmP7NPpa1n2VgeiC7Z6cQFpbQ7vS2pRRTwi6m5+iRCCCjDtp5Krda7MQ0osv+qoQQIw+/i6ViOOgZ5WkObNtDskORcgaY42xTbTCcoB6LdKnw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MhXCFi1nZaxxT/3wSa/mAy3l2BtHZ0cqZ/CGKOZPVypqFniXl01Fqzpv3FRONiOR/xG7KvuGD0kC1hUlWbBcqf4HlPpj+emsj70/QN95w2L+eUFrb/4gtayXekMqrYOkxWq10m+TOLCH390g6EtDAt6wMSUwIeTneQ+c/014I/rNYWcSXJLYYA9Xiuk1K+H9njeWXWQfUuyDRR5/DShKTxu1dTFXDoPpnNJO/2Nb+d8is0RwrVbnHtA2qCn8TaZbiuQeNPycKam8IDnFlJNYNvfBhJjl/AeKyKaanuUWSMFmX16cXSQqeCIl7cLquoUOkbAnPs4CAfV8iX1gmyfWiYXo6IVHaQrMGBsmGSr606vHPXdOei+OBLtmfyKxIkKwTsQSGhpc8OHJEKupfv1WEMtA9RpW8NVLHUxt191Gr+UhdqTI4dPvn/BhheOLD0ET
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 08:56:54.9628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b25921f-68c7-4caf-def1-08df3e3f677b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B6.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7400
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 8/18/26 15:30, Kory Maincent wrote:
> 
> 
> On 8/18/26 15:07, Patrice Chotard wrote:
>> read_metadata() allocates a single buffer holding both metadata copies
>> (calloc(2, mdata_size)) but accesses each copy through &mdata[id], where
>> mdata is a "struct fwu_mdata *". That stride is sizeof(struct fwu_mdata),
>> i.e. the 16-byte common header only, not mdata_size, so reading the
>> second copy overwrites the body of the first and the two copies overlap.
>>
>> When both copies are identical the overlap is harmless, but as soon as
>> they differ (e.g. after an interrupted update, the exact case the tool is
>> meant to recover) the primary is corrupted: for V2 the metadata_size
>> check then reads garbage and the tool aborts with a bogus size mismatch,
>> for V1 it silently operates on a mixed view and can write it back to both
>> copies.
>>
>> Index the copies by byte offset (mdata_size) through a small mdata_copy()
>> helper instead of struct-typed pointer arithmetic. Both copies are
>> guaranteed to share the same size (checked in parse_config()).
> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Thank you!


Hi Kory, Sughosh

It seems this patch has been forgotten ? it hasn't been merged.

Thanks
Patrice
