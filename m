Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88FAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 13:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CD9280E35;
	Mon, 27 Jul 2026 13:26:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LtMf5pYjVELD; Mon, 27 Jul 2026 13:26:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF02180E38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785158787;
	bh=0DpSKskJi+K/MuZqANhs3YtuGvX0oGgC10yFyG8J6HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeZKkuqgWiipEnMrWrtIXnOpjqOJxsZQ7fp+H3dI0gHucIImKMOCB+PiTvk9m3BKC
	 CAAXTgbSGNuDMC6hjkfwy1RO3e5/GW8qX2R7zAuZkze0DZ9f6Sni0M1bfGHhCnlUgA
	 DJXhorZzHWU6N3Fz8hmBtWypTWUcMsDPRagd4nw9GbXwA8sUKIiu8admVXIF7pnDMC
	 MI2LSFYzdzfPQ6jf6QpskPMzca4qCEohd8xIEvH0EXaJxM3pZyMqu4LFEATLHdaYwz
	 Mkkv2AbT4/8LmkGXNtfrWLlg4tS3I/7WO8f1T1rsS6PZlHQtQciiRExmyPa7gkmD17
	 A5Glk4ZDXoIkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF02180E38;
	Mon, 27 Jul 2026 13:26:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CA9D69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:26:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 729A080E38
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:26:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwtLmRp827Vs for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 13:26:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 33B6E80E35
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 33B6E80E35
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33B6E80E35
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:26:22 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=F9g6UiKVYEDFcxjv55uA+2bebr7X5aeLXVnZnYRQmUaXS9OjhvNoi3Ho/Pj5vGhEFFJ4J1IWDyEHgjz+RnfQDX1G65/7PkvO4SjZHFMdeznkZwOuTQn6IW4tKyjZgGmJr1dOZxrfZzkoztFVjVTIQkoFBT9JMK5adMtX/G4rQGW09s45ntNHdvBCAyTqjtBcbvcmOiyctBx+7f4+1D+KRvko4Wpcsr5KgJukj6AlvRfE/RwvHLTqbB4PFEJZ4ZVcxD3S/ISexU8OZPQhFnTzjt5/9C8T3GcX69WupxPO8MjEwooTpLfcIyGGAtKD4pqkfteVDz4OT/S5hWN5UcJYbw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DpSKskJi+K/MuZqANhs3YtuGvX0oGgC10yFyG8J6HY=;
 b=yc//ldKWZzFYs/2GnyEwyy6wahAKcZyzaCddH47h8cLPCgu47fwoXdPOJcI89l6cUXgm1ZJygoAmetAs4YDGGJK5IOXpNsRW0qV95dwP6E/wd2gZ4aPMN4vQmUY1r3xk03pCmB//eHKRkiTsR9obY2qjZueBluQ1kxKpRfagtlwXkvzdjQZIQNIscvPMBNGhLG25JerHdDHlm3oF7vIKVP3Jz7mrjMYGkqvvzptmEgcyZkGByr2A2nvuuH8Me9MFqOUhGhtEId+/tO6sOYyqyQV8ueGc99eknbfEb+9sktgvh+8qGw08N68IE4K0tNhAnDVcGDAufZ0UBuQ6j55B/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
Received: from AS4P250CA0006.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::8)
 by DB9PR08MB7748.eurprd08.prod.outlook.com (2603:10a6:10:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:26:13 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:20b:5df:cafe::4b) by AS4P250CA0006.outlook.office365.com
 (2603:10a6:20b:5df::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 13:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atyqGZPEAQ+GOKWmN3yQuXSp6Ram8LaV+MMxtpjGkVjbQFy7zeC7iiV+G/rwguJHszG246+qmzo8TMA+1pMtvvP/fQf/MrFXYKEtPjlBay79s3xOridZthX565pO9S+QchzeMvNJIWeIBd/XmOdMlDgjYhsyKsM1GFa3e3HzcD2swUoXYFg+PVdXVVSKLhhsRwqHrNiyNEBZCb7raYPMH8cC19tnpOsa5a8HP8PMkn403gK7OYrqjKAayORIlM+q0bftg64BAt6bPn8jj8bdMwysvxvNsGiTmXIK+L6nbczBSSTOFhz7OBtFPAwBhzyGnDpvTaTUl/9Cy1GsSTAkcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DpSKskJi+K/MuZqANhs3YtuGvX0oGgC10yFyG8J6HY=;
 b=mUXRg4ffpQ1xo8Ybm0Osks3BgfznnTG8KvuMYDonYHBN1YaJgtXxIadiT4Jv5RumDjJ/lVucirOBeK0cl7ZEiu7+Q/7TRbHrjwmBO8hvIkVmAI2y3tV5nwutv3g+Ysslz+El4ArwcimvdABVNi5QEk//L43SzCu8mvIxK53ctFUUAcALG9yCT/r1WnF8+V2iulj1CWVVi9/507eyKnCjR+zL7AKj3hL5oo6LHMn+0jCPVZuGWy4B+tqzULlk7LWGmyyrHoUBbz7490lEeCiv/0IWKgcN5qCwky1ad+wrpkIrobDV5nfqj5YHb/u47/rj3iCBhHz9kXvJYYPUmqEG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AM0PR08MB11829.eurprd08.prod.outlook.com
 (2603:10a6:20b:744::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 13:25:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0245.009; Mon, 27 Jul 2026
 13:25:08 +0000
Message-ID: <e9119252-03fc-4312-9963-eef4beceb36e@arm.com>
Date: Mon, 27 Jul 2026 15:25:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: phy: Add MaxLinear GPY215C Ethernet PHY driver
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, "Lucien.Jheng"
 <lucienzx159@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Beiyan Yun <root@infi.wang>, Johan Jonker <jbx6244@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, nd <nd@arm.com>
References: <20260710-phy-v1-1-87f37559b2ed@nxp.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260710-phy-v1-1-87f37559b2ed@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0464.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AM0PR08MB11829:EE_|DB5PEPF00014B97:EE_|DB9PR08MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed69602-92fc-4734-7ffb-08deebe2a0c6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|6133799003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: CSibF9DkwqGjoC74H974/oWO7uaFtxJY9aKmYPiTe5gbJk7fO+9oD1CrK1y5Y4IQA/h2uLJ1az/zwr3saYaIpRO6ZKBp4W7lU/7m7USZSlBvu6K0MXBDtmJPbC6tetoYNat+H/62DlsIKEnoAvtEdCawCo7CcsDir5RQo5FB8bcus7KlSzHbR5YnQFf9IL4JU8+jz/PjhWoPzgoHEknmT/ueJeUtqEK526xX69uvGuOQjGo1+RR389xsAE0dF9yBrcGkEFcuMRuPCZnernxd9KTFyc7Qg+tQzaERXNL890xhAgD9uHowLDk4JX09MGXvalMzrYUOKcJXdKuqbyBIm6b2eWgsyri+nO0pbBu3Tou2Q3Su5HSXGJbJKt8iaN4kp6noWuw55MYxwkvRfelzxjLyF60qLYTn4+iGxVpGSc94jcxrC0HDkefICEMd7VG3iGA/lKtivNwRc0Tmn5QO7NcOv/SgRs5QPvdwRV4bIC261llkGLuu1+StRVoDZz5BKNKBHwRXsIJ7rlNQw/EGkq1XALbsU6bxKIwxc1LDsjkZ2qaRmEN6d38W5YSxBPjzcpPyWIh3IkQjL5UEE9VdH7TZC7ZqsjZOOqdOysJk3YWGzwJchXNvLBcKuJvJbLkLWvLajn1BHLbjOT4t920wMMOdWs3nTNKFNDE39EPOtFk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: JMjPRZo4Ti/6FV9sDA4aOzj/xO0nZIPlXytt/TEDRFImSNPyaZUHyZzo+1T2tbz4gIEr81f8OogJSFFMweAJ3c19IvV6o2c4PeUglRAxI+SZ7SlYuAvz5eXu5cTnmZb+RFz34qoUcRxAuEXY0yyHpNSCifI38KHbmNKWefNolbcbIHd1EiKz9fe89fz2c90DffVFuHJ+iS67FPIrRYQwoY2e3pi+iKPqOuRNbRKAkqb49U3ADfl18S/SFw4SQZclDE+v4HVYggZdmZGQcidqMVve0dcdWXmcOtvFVbOUIxEy+X/h9gfBDU9NUU2sshGq3FJbVEVQoipwv7WklVt+wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB11829
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 218cb7e4-4f93-43ef-e30e-08deebe27aa9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|23010399003|376014|7416014|36860700016|1800799024|82310400026|35042699022|10067099003|22082099003|18002099003|56012099006|11063799006|13003099007|6133799003;
X-Microsoft-Antispam-Message-Info: Za+AD6x5eo7kScFAhGjXOBx4y0fVvFwL3KUuarFscOoFmKqlK2e4an6GOl//8wAZwHyPYkbzHBpqvR2NAX0yP/ezHzM7h+MozQfp6tgQnxVSgjoSj21FGTtper3htwGEd2AJjo9+MDyLtFXgphOssWTD4xTNesHHO554D5ihA+WqEc5KnGyJCeS9l8PdNcvkKJHnliGapSpi9QpSg91usYAAmCSvygJ2rXr0F3gM9uIWol5XpKeDenIGlnmtEkxK+AdPy3UjNmWEfKXCN+Kst2gahQY2T+g9p7AjW1qJ6EanYsOFJEauMO2mzXUbPqbS7BVn8B6ACtCDURStdARzr3p1nKIlNZD3oCacm5amWRKuC20d5Xc5/l37Gw9/5HDKAQjiMzZWzFBFSuGoFac+ANS1YeTQYaSaPPHRcYJCeV+rWADOC3RNHGQFM0kEFGg6ELu8OKyRR7sbbMwp2HiFm+AKXO+ZP6zt9tr1Cvmkj12kY5/ZTYfhdBIgWT/bl3zTusY/r9El02WKg5oGCTAHKlFGgcEpgLQy/a6fSS6QD4i/t407Aupxv92iQiIWq3Zb05OLjAiElB1mwqBv5YJ6+ErUVEzoUrpHJKwVf46RPxyVibzUrcSiV543lRtHjm76YloF+kHxN+phTglj4c+c2RrN1/qZVnI4+FGnPaVgdE8J/k0IntEZ99X9q7zgGjY8wY+1cclOxsJy2HsR5tNa6w==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(23010399003)(376014)(7416014)(36860700016)(1800799024)(82310400026)(35042699022)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(13003099007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XwNI1y7AXuEQA6zQ+daM5SBqvcM7vlS3lgiokKjvM01JiH6KaoSAkI8UB11UyEqwwqEiBi4DzVaLZZjEqiOMDaffB2sqyYitoJOzjp5NbjFD1RcFzu5FRoPpN6Xd/kp94oQ/74rN/JaUD2yBQlGydIQ901gRp330jwac1kJ64adX8dC2CMNojzw/wxU1OPfjc32hZnH5AoqMU4PKzc7YrLoV6F6JR8IZbV8+IEZiKVs9DGh2K4kTddl+n/XLZw0aeADsRB4fAcMmBzvDMTpEP/II3Y9Ix6vg1KBewYaZHJkbJN/qNx5HWn7bLk9+v3zuaYcWqP06Lh+n8QVtAA9vKYDmQQ03vXedon+OAaKRGQdwb9/q0Tfu0GmHhu026aTIpydw4/vD6BQCckUSw+MHMOIwu4h7RT18+4/eM4ROzAtqhEYch8kp6T9VCM1iHe/8
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:26:12.4596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed69602-92fc-4734-7ffb-08deebe2a0c6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7748
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DpSKskJi+K/MuZqANhs3YtuGvX0oGgC10yFyG8J6HY=;
 b=HNc5GUEbbutkZq5ydFndJ3zDi8PbBiZ8eRX62mZs32tsY2q49LUnmz8w6MM6RhoT1u50mFZGoLe0BtVgiPEe3L/prMdLzFiluBkXQmoKWFtnZmBJiRVTvPkZ51+gGJrczziX8/o/ZAAemKPZ/8EI3K2ethWK4Dqsk4UXPHQZSEc=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DpSKskJi+K/MuZqANhs3YtuGvX0oGgC10yFyG8J6HY=;
 b=HNc5GUEbbutkZq5ydFndJ3zDi8PbBiZ8eRX62mZs32tsY2q49LUnmz8w6MM6RhoT1u50mFZGoLe0BtVgiPEe3L/prMdLzFiluBkXQmoKWFtnZmBJiRVTvPkZ51+gGJrczziX8/o/ZAAemKPZ/8EI3K2ethWK4Dqsk4UXPHQZSEc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HNc5GUEb; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=HNc5GUEb
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alice,

On 10/07/2026 10:12, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add a driver for the MaxLinear GPY215C Ethernet PHY.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
> CI: https://github.com/u-boot/u-boot/pull/1009/checks
> ---
>  drivers/net/phy/Kconfig   |   6 +
>  drivers/net/phy/Makefile  |   1 +
>  drivers/net/phy/mxl_gpy.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 349 insertions(+)

Is this derived from the Linux driver or re-written independently? AFAICT
the Linux driver is a bit more feature-rich and matches model IDs more
precisely. 

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3f7953d693c..f76636a897a 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -242,6 +242,12 @@ config PHY_MSCC
>  	depends on !COMPILE_TEST
>  	bool "Microsemi Corp Ethernet PHYs support"
>  
> +config PHY_MXL_GPY
> +	bool "MaxLinear GPY215C PHY support"
> +	help
> +	  This adds support for the MaxLinear GPY215C Ethernet PHY,
> +	  operating in SGMII with auto-negotiation.
> +
>  config PHY_NATSEMI
>  	bool "National Semiconductor Ethernet PHYs support"
>  
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 83520de7f1f..0e79c03df7e 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_PHY_MICREL_KSZ8XXX) += micrel_ksz8xxx.o
>  obj-$(CONFIG_PHY_MICREL_KSZ90X1) += micrel_ksz90x1.o
>  obj-$(CONFIG_PHY_MESON_GXL) += meson-gxl.o
>  obj-$(CONFIG_PHY_MOTORCOMM) += motorcomm.o
> +obj-$(CONFIG_PHY_MXL_GPY) += mxl_gpy.o
>  obj-$(CONFIG_PHY_NATSEMI) += natsemi.o
>  obj-$(CONFIG_PHY_NXP_C45_TJA11XX) += nxp-c45-tja11xx.o
>  obj-$(CONFIG_PHY_NXP_TJA11XX) += nxp-tja11xx.o
> diff --git a/drivers/net/phy/mxl_gpy.c b/drivers/net/phy/mxl_gpy.c
> new file mode 100644
> index 00000000000..7445ec5f051
> --- /dev/null
> +++ b/drivers/net/phy/mxl_gpy.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * MaxLinear GPY215 2.5G Ethernet PHY driver for U-Boot
> + *
> + * Based on Ethernet Network Connection GPY215 (GPY215B1VI, GPY215C0VI) Data
> + * Sheet Revision 1.4
> + * Reference ID 617800
> + *
> + * Copyright 2026 NXP
> + */
> +
> +#include <phy.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +
> +/* -----------------------------------------------------------------------
> + * Standard MDIO registers (Clause 22, Device 0)
> + * -----------------------------------------------------------------------
> + */
> +#define GPY215_STD_CTRL			0x00
> +#define   STD_CTRL_RST			BIT(15)	/* Self-clearing reset        */
> +#define   STD_CTRL_LB			BIT(14)	/* Loopback                   */
> +#define   STD_CTRL_SSL			BIT(13)	/* Speed select LSB           */
> +#define   STD_CTRL_ANEN			BIT(12)	/* Auto-negotiation enable    */
> +#define   STD_CTRL_PD			BIT(11)	/* Power down (SLEEP)         */
> +#define   STD_CTRL_ANRS			BIT(9)	/* Restart auto-negotiation   */
> +#define   STD_CTRL_DPLX			BIT(8)	/* Duplex (1=full)            */
> +#define   STD_CTRL_SSM			BIT(6)	/* Speed select MSB           */
> +
> +#define GPY215_STD_STAT			0x01
> +#define   STD_STAT_LS			BIT(2)	/* Link status (latching low) */
> +#define   STD_STAT_ANEG_DONE		BIT(5)	/* Auto-neg complete          */
> +
> +#define GPY215_STD_PHYID1		0x02	/* OUI bits [3:18]  = 0x67C9  */
> +#define GPY215_STD_PHYID2		0x03	/* OUI bits [19:24] + model + rev */
> +
> +/* PHY ID: OUI = 0x67C9 (bits 3:18) | 0xDC (bits 19:24)
> + * PHYID1 = 0x67C9, PHYID2 = 0xDCxx (model/rev in lower 10 bits)
> + */
> +#define GPY215_PHY_ID1			0x67C9
> +#define GPY215_PHY_ID2_MASK		0xFC00	/* OUI[19:24] only */
> +#define GPY215_PHY_ID2_VAL		0xDC00
> +
> +/* -----------------------------------------------------------------------

Coding style

/*
 * -----------------------------------------------------------------------
 * ...
 */


> + * GPY-specific registers (Clause 22, Device 0)
> + * -----------------------------------------------------------------------
> + */
> +#define GPY215_PHY_MIISTAT		0x18	/* Register 0.24              */
> +#define   MIISTAT_LS			BIT(10)	/* TPI link status            */
> +#define   MIISTAT_DPX			BIT(3)	/* Duplex (1=full)            */
> +#define   MIISTAT_SPEED_MASK		GENMASK(2, 0)
> +#define   MIISTAT_SPEED_10		0x0
> +#define   MIISTAT_SPEED_100		0x1
> +#define   MIISTAT_SPEED_1000		0x2
> +#define   MIISTAT_SPEED_ANEG		0x3
> +#define   MIISTAT_SPEED_2500		0x4
> +
> +#define GPY215_PHY_IMASK		0x19	/* Register 0.25              */
> +#define   IMASK_LSTC			BIT(0)	/* Link state change          */
> +#define   IMASK_LSPC			BIT(1)	/* Link speed change          */
> +
> +#define GPY215_PHY_ISTAT		0x1A	/* Register 0.26 (clr-on-rd) */
> +#define   ISTAT_LSTC			BIT(0)
> +#define   ISTAT_LSPC			BIT(1)
> +
> +/* -----------------------------------------------------------------------
> + * Vendor Specific 1 registers (MMD device 30)
> + * Accessed via Clause 45 or Clause 22 Extended indirect
> + * -----------------------------------------------------------------------
> + */
> +#define GPY215_MMD_VSPEC1		30	/* MMD device address         */
> +
> +#define GPY215_VSPEC1_SGMII_CTRL	0x08	/* Register 30.8              */
> +#define   SGMII_CTRL_RST		BIT(15)	/* SGMII reset (self-clear)   */
> +#define   SGMII_CTRL_LB			BIT(14)	/* SGMII loopback             */
> +#define   SGMII_CTRL_ANEN		BIT(12)	/* SGMII ANEG enable          */
> +#define   SGMII_CTRL_PD			BIT(11)	/* SGMII power down           */
> +#define   SGMII_CTRL_RXINV		BIT(10)	/* Invert RX0_M/RX0_P         */
> +#define   SGMII_CTRL_EEE_CAP		BIT(7)	/* Advertise EEE in ANEG      */
> +#define   SGMII_CTRL_FIXED2G5		BIT(5)	/* Force SGMII to 2.5G        */
> +#define   SGMII_CTRL_ANMODE_MASK	GENMASK(1, 0)
> +#define   SGMII_CTRL_ANMODE_1000BX	0x1	/* IEEE 1000Bx Clause 37      */
> +#define   SGMII_CTRL_ANMODE_CIS_PHY	0x2	/* Cisco SGMII, PHY side      */
> +#define   SGMII_CTRL_ANMODE_CIS_MAC	0x3	/* Cisco SGMII, MAC side      */
> +/* Default reset value = 0x34DA:
> + *   ANEN=1, ANMODE=AN_CIS_PHY(2), FIXED2G5=0
> + */
> +
> +#define GPY215_VSPEC1_SGMII_STAT	0x09	/* Register 30.9 (read-only)  */
> +#define   SGMII_STAT_ANOK		BIT(5)	/* ANEG completed             */
> +#define   SGMII_STAT_RF			BIT(4)	/* Remote fault (latch high)  */
> +#define   SGMII_STAT_ANAB		BIT(3)	/* ANEG ability (static)      */
> +#define   SGMII_STAT_LS			BIT(2)	/* SGMII link up (latch low)  */
> +#define   SGMII_STAT_DR_MASK		GENMASK(1, 0)
> +#define   SGMII_STAT_DR_10		0x0
> +#define   SGMII_STAT_DR_100		0x1
> +#define   SGMII_STAT_DR_1G		0x2
> +#define   SGMII_STAT_DR_2G5		0x3
> +
> +/* -----------------------------------------------------------------------
> + * Timing / retry constants
> + * -----------------------------------------------------------------------
> + */
> +#define GPY215_RESET_TIMEOUT_MS		500
> +#define GPY215_ANEG_TIMEOUT_MS		5000
> +#define GPY215_POLL_INTERVAL_MS		10
> +
> +/**

Do not use a kernel-doc comment if you're not providing the parameter and
return code description

> + * gpy215_probe - Verify PHY identity
> + */
> +static int gpy215_probe(struct phy_device *phydev)
> +{
> +	int id1, id2;
> +
> +	id1 = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_PHYID1);
> +	id2 = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_PHYID2);
> +
> +	if (id1 < 0 || id2 < 0) {
> +		printf("GPY215: MDIO read failed (id1=%d id2=%d)\n", id1, id2);
> +		return -EIO;

This loses the actual error code (for instance -ETIMEDOUT or -ENODEV).

> +	}
> +
> +	if (id1 != GPY215_PHY_ID1 ||
> +	    (id2 & GPY215_PHY_ID2_MASK) != GPY215_PHY_ID2_VAL) {
> +		printf("GPY215: unexpected PHY ID 0x%04X 0x%04X\n", id1, id2);
> +		return -ENODEV;
> +	}

I believe if you had proper model-specific .uid and .mask, this probe-time
identity check would be unnecessary altogether.
> +
> +	debug("GPY215: detected (ID1=0x%04X ID2=0x%04X)\n", id1, id2);
> +	return 0;
> +}
> +
> +/**
> + * gpy215_config - Configure PHY for SGMII operation
> + *
> + * The GPY215 SGMII interface comes up automatically after reset with:
> + *   - SGMII ANEG enabled (Cisco SGMII, PHY side)
> + *   - PHY side SGMII speed tracks TPI link speed
> + */
> +static int gpy215_config(struct phy_device *phydev)
> +{
> +	int val, timeout;
> +
> +	val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
> +	if (val < 0)
> +		return val;
> +
> +	phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL,
> +		  val | STD_CTRL_RST);

The return status should probably be checked, otherwise the
polling loop below might report success even if the reset request was
never issued.

> +
> +	/* Wait for self-clearing RST bit */
> +	timeout = GPY215_RESET_TIMEOUT_MS / GPY215_POLL_INTERVAL_MS;
> +	do {
> +		mdelay(GPY215_POLL_INTERVAL_MS);
> +		val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
> +		if (val < 0)
> +			return val;
> +	} while ((val & STD_CTRL_RST) && --timeout);
> +
> +	if (val & STD_CTRL_RST) {
> +		printf("GPY215: reset timeout\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	/* Clear stale interrupt status (read-to-clear) */
> +	phy_read(phydev, MDIO_DEVAD_NONE, GPY215_PHY_ISTAT);
> +
> +	val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
> +	if (val < 0)
> +		return val;
> +
> +	/* Enable ANEG, clear forced speed/duplex bits */
> +	val |= STD_CTRL_ANEN;
> +	val &= ~(STD_CTRL_SSL | STD_CTRL_SSM | STD_CTRL_PD);
> +	phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL, val);
> +
> +	phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL,
> +		  val | STD_CTRL_ANRS);
> +
> +	/* Configure SGMII (Cisco ANEG, PHY side, ANEG enabled) */
> +	val = phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
> +			   GPY215_VSPEC1_SGMII_CTRL);
> +	if (val < 0)
> +		return val;
> +
> +	val &= ~SGMII_CTRL_PD;
> +	val |= SGMII_CTRL_ANEN;
> +	val &= ~SGMII_CTRL_ANMODE_MASK;
> +	val |= SGMII_CTRL_ANMODE_CIS_PHY;
> +	val &= ~SGMII_CTRL_FIXED2G5;
> +	phy_write_mmd(phydev, GPY215_MMD_VSPEC1,
> +		      GPY215_VSPEC1_SGMII_CTRL, val);
> +
> +	debug("GPY215: configured for SGMII (Cisco ANEG, PHY side)\n");
> +	return 0;
> +}
> +
> +/**
> + * gpy215_startup - Wait for link and report status
> + *
> + * Polls PHY_MIISTAT (TPI link) and VSPEC1_SGMII_STAT (SGMII link).
> + * Updates phydev->speed, phydev->duplex, phydev->link.
> + */
> +static int gpy215_startup(struct phy_device *phydev)
> +{
> +	int miistat, sgmii_stat, val;
> +	int timeout = GPY215_ANEG_TIMEOUT_MS / GPY215_POLL_INTERVAL_MS;

This timeout is initialized once and is therefore shared by all phases
below. It it the intent? Or should the timeout be reset between each
phase?

Also I tend to prefer the use of get_timer() but that's essentially
cosmetic.

start = get_timer(0);
do {
    ...
    if (...)
        break;
} while (get_timer(start) < SOME_TIMEOUT);

> +	int speed_code;
> +
> +	debug("GPY215: waiting for link");
> +
> +	/* Poll TPI link status */
> +	do {
> +		mdelay(GPY215_POLL_INTERVAL_MS);
> +		miistat = phy_read(phydev, MDIO_DEVAD_NONE,
> +				   GPY215_PHY_MIISTAT);
> +		if (miistat < 0)
> +			return miistat;
> +	} while (!(miistat & MIISTAT_LS) && --timeout);
> +
> +	if (!(miistat & MIISTAT_LS)) {
> +		printf("GPY215: link down (TPI timeout)\n");
> +		phydev->link = 0;
> +		return 0;

Why return success?

> +	}
> +
> +	do {
> +		mdelay(GPY215_POLL_INTERVAL_MS);
> +		val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_STAT);
> +		if (val < 0)
> +			return val;
> +	} while (!(val & STD_STAT_ANEG_DONE) && --timeout);
> +
> +	if (!(val & STD_STAT_ANEG_DONE)) {
> +		printf("GPY215: auto-negotiation not complete\n");
> +		phydev->link = 0;
> +		return 0;

Same question here.

> +	}
> +
> +	do {
> +		mdelay(GPY215_POLL_INTERVAL_MS);
> +		phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
> +			     GPY215_VSPEC1_SGMII_STAT);
> +		sgmii_stat = phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
> +					  GPY215_VSPEC1_SGMII_STAT);
> +		if (sgmii_stat < 0)
> +			return sgmii_stat;
> +	} while (((sgmii_stat & (SGMII_STAT_LS | SGMII_STAT_ANOK)) !=
> +		  (SGMII_STAT_LS | SGMII_STAT_ANOK)) && --timeout);
> +
> +	if ((sgmii_stat & (SGMII_STAT_LS | SGMII_STAT_ANOK)) !=
> +	    (SGMII_STAT_LS | SGMII_STAT_ANOK)) {
> +		printf("GPY215: SGMII not ready (stat=0x%04X link=%d ANOK=%d RF=%d)\n",
> +		       sgmii_stat,
> +		       !!(sgmii_stat & SGMII_STAT_LS),
> +		       !!(sgmii_stat & SGMII_STAT_ANOK),
> +		       !!(sgmii_stat & SGMII_STAT_RF));
> +		phydev->link = 0;
> +		return 0;

Same here.

> +	}
> +
> +	/* Clear interrupt status */
> +	phy_read(phydev, MDIO_DEVAD_NONE, GPY215_PHY_ISTAT);
> +
> +	miistat = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_PHY_MIISTAT);
> +	if (miistat < 0)
> +		return miistat;
> +
> +	speed_code = miistat & MIISTAT_SPEED_MASK;
> +	switch (speed_code) {
> +	case MIISTAT_SPEED_10:
> +		phydev->speed = SPEED_10;
> +		break;
> +	case MIISTAT_SPEED_100:
> +		phydev->speed = SPEED_100;
> +		break;
> +	case MIISTAT_SPEED_1000:
> +		phydev->speed = SPEED_1000;
> +		break;
> +	case MIISTAT_SPEED_2500:
> +		phydev->speed = SPEED_2500;

Here the driver reports 2.5 Gbps but see [1] below.

> +		break;
> +	default:
> +		printf("GPY215: speed not resolved (miistat=0x%04X)\n",
> +		       miistat);
> +		phydev->link = 0;
> +		return 0;

Why return success?

> +	}
> +
> +	phydev->duplex = (miistat & MIISTAT_DPX) ? DUPLEX_FULL : DUPLEX_HALF;
> +	phydev->link   = 1;

Extra whitespace

> +
> +	debug("GPY215: TPI link up  %d Mbit/s %s-duplex\n",
> +	      phydev->speed,
> +	      phydev->duplex == DUPLEX_FULL ? "full" : "half");
> +
> +	debug("GPY215: SGMII status 0x%04X (link=%d ANOK=%d DR=%ld)\n",

%04X is unusual, how about %04x?

%ld is incorrect. Use %d or (better?) %x

> +	      sgmii_stat,
> +	      !!(sgmii_stat & SGMII_STAT_LS),
> +	      !!(sgmii_stat & SGMII_STAT_ANOK),
> +	      sgmii_stat & SGMII_STAT_DR_MASK);
> +
> +	return 0;
> +}
> +
> +/**
> + * gpy215_shutdown - Power down SGMII and TPI
> + */
> +static int gpy215_shutdown(struct phy_device *phydev)
> +{
> +	int val;
> +
> +	val = phy_read_mmd(phydev, GPY215_MMD_VSPEC1,
> +			   GPY215_VSPEC1_SGMII_CTRL);
> +	if (val >= 0)
> +		phy_write_mmd(phydev, GPY215_MMD_VSPEC1,
> +			      GPY215_VSPEC1_SGMII_CTRL,
> +			      val | SGMII_CTRL_PD);
> +
> +	val = phy_read(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL);
> +	if (val >= 0)
> +		phy_write(phydev, MDIO_DEVAD_NONE, GPY215_STD_CTRL,
> +			  val | STD_CTRL_PD);
> +
> +	return 0;

Not sure if always returning success is OK or not. In any case
proper error handling and reporting would not be hard.

> +}
> +
> +U_BOOT_PHY_DRIVER(mxl_gpy215c) = {
> +	.name		= "MaxLinear GPY215C",
> +	/*
> +	 * Match on OUI only. The 22-bit OUI spans PHYID1[15:0] and PHYID2[15:10].
> +	 * Combined 22-bit PHY ID = (0x67C9 << 6) | (0xDC00 >> 10) = 0x19F277
> +	 * U-Boot phy_id = (PHYID1 << 16) | PHYID2 with mask 0xFFFFFC00
> +	 */

Why is it safe for this driver to bind to any MaxLinear PHY using this OUI?

> +	.uid		= (GPY215_PHY_ID1 << 16) | GPY215_PHY_ID2_VAL,
> +	.mask		= 0xFFFFFC00,
> +	.features	= PHY_GBIT_FEATURES,

[1] here it advertises only 10/100/1000 capability. Would it be
appropriate to use 'PHY_GBIT_FEATURES | SUPPORTED_2500baseT_Full'?

> +	.probe		= &gpy215_probe,
> +	.config		= &gpy215_config,
> +	.startup	= &gpy215_startup,
> +	.shutdown	= &gpy215_shutdown,

The & are not needed.

> +};
> 
> ---
> base-commit: a18265f1ccb7a272721ed4286ed3b5a6182ff424
> change-id: 20260710-phy-a8d7427ab27d
> 
> Best regards,
> --  
> Alice Guo <alice.guo@nxp.com>
> 

