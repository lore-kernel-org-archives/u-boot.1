Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294DAC5DF8C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 04:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E35DD60639;
	Mon, 24 Aug 2026 04:35:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUyQk0_8NrE7; Mon, 24 Aug 2026 04:35:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787546148;
	bh=0gKxganuu3tYyMKFurLhsHs3RhiCAIPUyCzuCxQNQuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qjLTOCpJFXelTQDs7im7lIRq+4KF6Bwu2Q9ZW8MX3zy2QXF8Ua15/HRGwyFEGfuLv
	 7fyoobgOm3MDkWy3fEqTQE7fwSviAEHYNfjhC/Q8uNVB6qtNbEJifu/l08QdP/MD1U
	 sGegPlTPCGlpm2ic2KYyMrE2WKnPWu1jCdhsyM559jEOJPPTr25rUsK09p9bVh3DKO
	 +SlKGmcBo996z8AowU94GyChU1oCI9s9jFiSZU9bQ+UshHHwsz4TzLNT8jgMD+Hvjn
	 6/K35zQcgPmywLDRi9Tb4Dbxy3A9pDtJxEVBhR0qkxqT+GlcMSreuHrO3ceG+AFgVA
	 Cku0XkJYhZz4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80E0560619;
	Mon, 24 Aug 2026 04:35:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 07BB941A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE2E04062D
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1W2SKU10Ycv for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 04:35:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=juuso.rinta@nokia.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nokia.com header.i=@nokia.com header.a=rsa-sha256
 header.s=selector1 header.b=jZYbKEsZ
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07FC840624
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 04:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLvBgq7kiMefbvmS+EhClsWEFY/5rc/YTnX2lGUff83TYFBoaQmZrQa2+eBDOHKdw4VJFJrCWGX3dzUwfa3bHlPpmjXpFPwl7EfkP5+IOwZ0wrPndiEyDMEbqOnXOcD1XwDTVMNpcNbRy3aP6vOb14QagGXZk5cP3pMV49dUYl7nVBn2Xv9tzZMCKY6lrc+13vPrFQfZzxhAfhkoCMP0FaquRRZmevypDzh8esGl2cwPiJZpwqexy3JOMRt9aiQAMpNYeOprzG1PMlE/v7TdGNVTTrcgDB9gZ4prTt24x0EQbPNuuFNkFaVjrCdiCtUBXITw6CHzHfkgjfy+CoNbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gKxganuu3tYyMKFurLhsHs3RhiCAIPUyCzuCxQNQuA=;
 b=NFwyIueXq1fqAfY3YnquX5KEr85JxBVG18/h2k+0K/juC8xbmPCts6N8+3p0k/5Ev4G6LWfQGulCFqUBjkohd/VkrvIyYt3yP+H2Gwl1mi5u1CoX1Y0HWxQ65DqCQ0M5fuVsMHMHaErS2lyEEt1BRx0o2Ru/+5LPGB6UcfD1W8BVuhyAFuesovJ+TsJa9H5Wx4Ly+pB/5hPtxlk1g+MWFpNFEhAREtg3NTFS4gT05kCdO+7ZUOcTDHDHfLMaAlgtT/k4kbcfs827U3UEJ4E5upoPuJpupl8vC2PouUQAr7l0br+EgYawKtmqKNeFy2SvHNE0zFOhoSjN9mWbE72rPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=cherry.de smtp.mailfrom=nokia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nokia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gKxganuu3tYyMKFurLhsHs3RhiCAIPUyCzuCxQNQuA=;
 b=jZYbKEsZD4ReV5GXYffT4mmyfv9AcCpPDqF3I+S0WSq8eQoDs53ejvXNuH7x8aGS0QiYiQhANZ1hr/bu10yWbTS599gGDJlH2a6y49ZuWLysLF5/BIhpGvzBdiCRXo9hlcc7ShwHcAwuEltdFzzsvWNoOg5pmBlz/grwOR31QpWP1kndLg+Eml2zA8FriP24RUMzjHDnAFU821nZ9RFaJel5BHAVC9eSkDK5vSFsNDH4qcwF0zaws4JPaH/mk2ojpoAFd63qH4N8/0yEJIVLg/p5BxQRmkWQJwMZKv3BliW3hKXRigJDs5+FeaQc4KJrfHi3vxW/406EV16uJAqtHw==
Received: from PA7P264CA0337.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39a::9)
 by VI1PR0701MB6846.eurprd07.prod.outlook.com (2603:10a6:800:17e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 04:35:38 +0000
Received: from MI3PEPF00008483.eurprd02.prod.outlook.com
 (2603:10a6:102:39a:cafe::3) by PA7P264CA0337.outlook.office365.com
 (2603:10a6:102:39a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 04:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 MI3PEPF00008483.mail.protection.outlook.com (10.167.240.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 04:35:37 +0000
Received: from updev-hifix-1-5g.devops-fwk.dynamic.nsn-net.net
 (10-175-3-186.he-pi-os-dhn-100.nesc.nokia.net [10.175.3.186])
 by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 64FAA202E1;
 Mon, 24 Aug 2026 07:35:37 +0300 (EEST)
From: juuso.rinta@nokia.com
To: stefan.roese@mailbox.org
Cc: aaro.koskinen@nokia.com, antonio.borneo@foss.st.com, juuso.rinta@nokia.com,
 me@ziyao.cc, patrice.chotard@foss.st.com, peng.fan@nxp.com,
 quentin.schulz@cherry.de, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 0/6] watchdog: report effective timeout
Date: Mon, 24 Aug 2026 07:35:36 +0300
Message-Id: <20260824043536.2004812-1-juuso.rinta@nokia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260823071511.687900-1-stefan.roese@mailbox.org>
References: <20260823071511.687900-1-stefan.roese@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008483:EE_|VI1PR0701MB6846:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e731b95-8fde-4934-ab06-08df0199257b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B1Afuka43qaJFMzLAK/WhFgraGw6naInDmUKPjN6SCOFFLIsb37t7apPjGnVDpCBJKdq3PhWCWpcoLAIUAOc88ENn3o4SgiPr2K/srxqgnh5dpf9GXyoS+rMFxOYuQWnTpuwo0BjVJ4l1fFZAeKvdIXCZAJZmDN95O6TlfEeNbQb6thesJwAtG6EnBaz7ToAnW5uXpu2UFLGRa08AstkogbEwUaxUjDHiucE7aybmNgO/0n/NG1DU87HE4QR+bRxjafeulR6l115dctV4snhT554Ma40+1LdXdGPbFaLyDuvvrkjy5z4buLQAcIXwED8gu0jl74fJVhZY17c+qlpqJ8PQib5Y1kYO+PDa9FFS/wGXqdKqJamydUnfWLKzp1d6zmjN5J+7GbUPgDnVFAH9/Cbs1Jq9cGJMhsJB3pR/9UqFpCjVhrh1FV7wf8xPjRhtrIDIuzxp0/AbG4zDq/A0o/GJ3Z/e9tLcvSJTr82CxJOTeAHSKmfxxGpfkuQmd3QhyxpHx7MSm5z0mHTg21uU1c7jRw1wHN6l9nfQbVQCscHOJVfyuc63f0qvgOHa2Gp4So0EFt8/MTCanHwdViE7WHar12dH0cUccwF/vz/CStHtTJ8yY8n11fzWhaMPT8hs70hoTqbRTBWmerSxQCIngooxzV/y3dCK7/4NpuN8SMqWTgA1nbEashzTBlGLMOH
X-Forefront-Antispam-Report: CIP:131.228.2.241; CTRY:FI; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:fihe3nok0734.emea.nsn-net.net; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0sqtwrEFCTmBOnaFrzj8OrhLRn4ArM+C2qBfPuCRmDSPtm/RZClLxcf2HI4xwbOjtUC5xepawyh9wIi2Z5Z6e6sLA5t4Ue78XH+ASBhfraMrGijLuXEZndmgxsw3eVyUFeSmaZwQ4mBzrmS1hScxznW2owkHRl3GsRw62kEFDHyNdiUeHCJDaEtZPbeicSKC/dDmvDu82DxlA0CD+SLhoLcAtVvOcR70OY+ACS0BiZ/lTEync11cNlt+pmwNN7EAoAiCqXQR0d/lHjfNsTYiU45TmbybgCkBjk7WFRSGgph9REhlog09OgWaBWhic1GxB8xOQy14Ebh9weKySdFPAL79OrhVWiNeR+P2jZTz/eMZQ8NLJ+y+bUgSu3D37ZfTQdNpsF0nVc1gJwC1S9dWR5CjVsyZmnISg9YCZ4HVK9SyJV0dHyVuUwNNI5C/+DpI
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 04:35:37.9249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e731b95-8fde-4934-ab06-08df0199257b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0; Ip=[131.228.2.241];
 Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6846
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

Hi Stefan and Quentin,

Thank you for the comments.

> Juuso, I would like to take v3 as it stands. It fixes a real bug,
> drivers that don't set max_timeout_ms are unaffected, and the
> effective-value work sits on top of it rather than replacing it.
Sounds good. To clarify on the next steps: the follow-up will be a
separate series on top of v3. It adds a get_timeout() operation
that is called after ops->start(), and uses that value in the print
when the driver implements it. Otherwise, keep the v3 behaviour.
With the real timeout available, wdt-uclass can also warn when the
effective timeout is shorter than the service interval.

> No need to resend just for that. I can add them while applying if you
> confirm that is what you meant.
Yes, that's what was intended. Thank you, I must have missed the 'b4 trailers -u' step.

Best,
Juuso
