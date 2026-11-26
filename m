Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A2606A33D
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oP3bn7Eu;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=fElnrSzU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A119760A6F;
	Thu, 26 Nov 2026 13:21:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T0Ss5YMJlQ-g; Thu, 26 Nov 2026 13:21:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE2186068A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795699270;
	b=QL0g6CQeu4W4Bh3Qx3IY8EMVgEh5nKDINBGNihOMRMQNUQ6ciUFDcK+Lb2zMvRpWnuhm
	 sUi2izVTjT/06fPDompAmGHARE9N03fYrtNDZpJHdsu/cxMU+0ZEv53vrzvsdLyrK1pmp
	 L/izH074shub0Ti5PI/TEjdZefCLH1aSwuyy84NKDzN0S5qCOQtoaOBKqNnecaFFInExG
	 KdoV7Cyx0qswbMpisxPKmJSiaBPrlV7Nx45HUZd/qjyuLJr5hEcINPK2SciqVg9VzT2OB
	 a/85UnE4/nnV5FOWMaqL9AL7x6TSWfh7FrgiqcvEsaRq1AeqbQvCxw204tWcP6V//WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795699270;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=Pl7+np50TO76kMQ8YM9ymXCrJFwwYuUUl8R+QTe2Onw=;
	b=UWvy0y+VJ6vq13Kh/KI1zJB0exkoJNZDYqaJZDgxzxDZsJJM1PdCs92sswFKYk8S+XHn
	 S4daUNSu/ja8hIl3uu0C1tesvz4jGWT8Nc216lw5A240PrXPoVRfugYpbCE3etJ3r3IO2
	 9rVNZI1oI6qWr8/bf66SHakps3FRZtQEUE3fApTbaLP9mV++C8cjfGHLB9Rub2qxILK7u
	 mG06sGKaJJ3Itz1FJvCEvzEdRlkRiitg8MtCVFUU2KHZ32Y6cDifVLKt+AsV8fO1REyU0
	 lKZEiBHpcDoP3Uvpnu8+AS1fTQmG0loVJZAyrWex7lkCgUDSpRoyFqsHkEbSK+V0R4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795699270;
	bh=Pl7+np50TO76kMQ8YM9ymXCrJFwwYuUUl8R+QTe2Onw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oP3bn7EuMDSlc/hTHga0VS/+/JHvl8+7MMoeIdd9C+weqGgDu0eIiqxEHHIeS4Nkw
	 Utf05ujf4DJzYOY6EX0+ElOV12NQhsB4E/pAQnmzarwC7SnylZjo/h7ph4LsgGoPTS
	 Nx/U+MtQBcZeFjd20y3icJS4aRCRTYAOtAd65rwPjMLGe5+lAn+bj1dsMPEhfsFMlP
	 62bxPqn8Cg1AhbvIEnD/dDkRm31vI+qSEsb/93bYI3lCwP53WZ3bfsASdRAHF9N/oR
	 +/SLhoMDBcxf546WqQRioVCFSjOC6DGZhJ6JMijpQ8/4NJrWxdTYvh/eAjuyacLS2m
	 z6V30x538uhLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE2186068A;
	Thu, 26 Nov 2026 13:21:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E99C12DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFE0B810F9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:21:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LR3CtESJVXhl for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:21:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8BEA6810F7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fElnrSzU
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BEA6810F7
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pl7+np50TO76kMQ8YM9ymXCrJFwwYuUUl8R+QTe2Onw=;
 b=fElnrSzUevd32nHGcaozwMBr4rMKrGLjxx2/KaK09Tk9d958zbitJv5VN/eysZ0euOIDKmPRFRQtH5sZOFFd6sTzS76oT/NMlbuJ2Sf5x6N8/y9aVLcCFEvl4ZJNffO84MWm9UJwEnyRnphlIw36uf8dPKArcZ7imn5yetENz+17DlZbUUt1A5X4zwL8UZJ8/TRIBCP7+miEes+99E+h1pRqJlQ++zLXrqRJMvTMnTlNx8q1tm1ya/d1OcfOG0KJDkFZTrw1TvqWIQ0pPKlzOShoGVD5p7tioC7va/wZy0w71dw9RqHchJRugj4Df5zpC9TkW6+qc3vNGLg75w7t9A==
Received: from FR2P281CA0065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:93::11)
 by MIWPR10MB747362.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 13:20:55 +0000
Received: from MI3PEPF0000847D.eurprd02.prod.outlook.com
 (2603:10a6:d10:93:cafe::a2) by FR2P281CA0065.outlook.office365.com
 (2603:10a6:d10:93::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5 via Frontend Transport; Thu, 26
 Nov 2026 13:20:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000847D.mail.protection.outlook.com (10.167.240.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 13:20:54 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 14:22:00 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 14:20:53 +0100
Message-ID: <5d4e4539-fbd1-4c16-b9d3-88dd9ba4355d@foss.st.com>
Date: Thu, 26 Nov 2026 14:20:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32mp: Fix qspi nodes for
 stm32mp157c-ev1-scmi-u-boot
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, Marek Vasut
 <marex@nabladev.com>
References: <20261113-ostub-1905-v1-1-7a8b799e260f@foss.st.com>
 <29750bb3-18a8-45bb-958b-ecd6873b2977@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <29750bb3-18a8-45bb-958b-ecd6873b2977@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847D:EE_|MIWPR10MB747362:EE_
X-MS-Office365-Filtering-Correlation-Id: f45c3f04-a91d-4b61-0081-08df4bc019c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|261021123027099003|261021121427099003|4143699003|56012099006|261022105027099003|261009223027099003|261026140227099003|261022115727099003|261102123227099003|261028144727099003|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3rSh+VGI11K//k84dEmwH0gBtgJ3D0CaolvLums3g06G8Mg4jZbgh284MzkOIA7oElvK+nu5l13+gUQNb6iB8by1G6asm7NtbGTYxRFeDKjcWaslg2cDC2UuNZuSxcoGBV69cBNw/6s0BOPhtCAa+41qQYmRILc26hAMD1QXp8PVgVCOH+N1quVdS7NFFy27XyiH5/n0BmihS9roWpyKg7PpidbuSHKxe45en/0nGk4RfXDpyvUCuimGbzjvz5ZXPyuU0Lpa4Jyc7I+1/uDBNAbEyZlP7Ll9DuVMaVLiXMM3zHxnE9+OSyB0BNip8pGwcAFQ2trMxpydp4yNctx2Kw9LhGzJcgBVHRt844t6yO1s1sfchwMHsV/CrsjNGou70vn4mzZRhZV+okYcim5c28uQ2DpxLPWBWFe2LYO4s95QrlIvypXvR6IwPXFp0Za0SxWilbZ0Un1ArChZ/W+7kHk29WU28TfV4vAxlB5wJqGK8Q4a/UKpPGWsWYZ8bBdEe7UW22Qtj8TsKuMA3z3hQfDznV6yEhB/4GLOQC7N3WQ3m0t94p066PaFqZlg26owhbgxAxDUuP4DS+UwNp4a84jem3/FLMjAPavC4OMkpRfJzzmkJE94fOWc66lds7Uoz0S18miWvu+4bEIqwWz7wfDcBUFu2tcMA1bOsjzdA2DRyxMFRR47/6yYlFOH6weoujTXzsZPfzPgmXOSDK4ZwA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(261021123027099003)(261021121427099003)(4143699003)(56012099006)(261022105027099003)(261009223027099003)(261026140227099003)(261022115727099003)(261102123227099003)(261028144727099003)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rt79t7A7gXfZRF+NWEm+rqguxtKfHD/LWSbQQtP23vwzVzF2w3YfMaZN3X3xMOu3RCE+LOzCzXMJW0tt2Jr1GB2W5b5Qm1IKflul5HNPpU+JVM8ffATJGdlXfNTF+ccxI1tTKIu5FhVqPFvhgwj5JI1XSM5Fk6dHwfndVGwz2chUKOum1txllvJE5n2pbQdPWTmfIa4OtXRaaE1zUIOFyX13E9KFoo4Ewn+AM38lQ7ac2sbUAyIf25G72QGutItUiznspKp6KqEZXL5Zu/JDr4t4TTjTzAeZgS8AbIS+7m97CIPWM2gEux3AM86Nj2EmSqq2Vxv1gTFxvo2d4dxz0S5SfWQvK7j5ArsPi1FOvlIKEst9N1kY1CFpjHIQX9fsmoOIGBoR/UEwV1eT9+rBbNm3ys0pBeymz9gv1pj13B9byxU74pAtzwmZLuNRODVf
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:20:54.7575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45c3f04-a91d-4b61-0081-08df4bc019c3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF0000847D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR10MB747362
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/26/26 14:09, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/13/26 14:54, Patrice Chotard wrote:
>> Fix NOR boot for stm32mp157c-ev1-scmi board due to qspi pinctrl
>> mismatch after kernel v6.3 device tree alignment.
>> Patch similar to commit 5846ef86f89b ("ARM: dts: stm32mp: Repair
>> damage from alignment with v6.3").
>>
>> Fixes: 08002ffd083d ("ARM: dts: stm32mp: alignment with v6.3")
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   arch/arm/dts/stm32mp157c-ev1-scmi-u-boot.dtsi | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
> [...]
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com> Thanks Patrick
Applied to u-boot-stm32/main

Thanks
Patrice
