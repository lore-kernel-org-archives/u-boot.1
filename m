Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240E606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=thi3MUzU;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=QT1njI2P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4239E8112E;
	Tue, 17 Nov 2026 13:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjnrWEfj7v1g; Tue, 17 Nov 2026 13:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5ADF281126
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794923512;
	b=esCO+U/Y8+BJeTqYiniudtMYFrXJc4Uylm11pA1h93cgCY4TmnI6cXvDTApdlTuxTmVp
	 DvW80i+vuf8cR10jkiUc9Z22emUgrh/4TPwsCm3yvliJyCtUUxn0COtUINQM1C9VCr095
	 AYKenrDhrVSLP2H0CnR/+39dofxCG/7M/h32yZLmPdTaW6XTJtzLJEtJ+j64fUlWOMO4t
	 /0t65e0MgTs2horg9eZF+7u8LDXmvwWgz5azzx98OqRznTFWxr+FsEIuNuuiTIsR5ZR5h
	 EKPtk/61zf5p+VyGZ/TZjigo7o5vWvPKOzBigf5buWpFEQawTVmlNNkIoKCRlFMrrFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794923512;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=qT0i7PSbQ1e/2eDiq0zguEL9U8YJ/+OJ4kzyJUSsNU4=;
	b=Hu+I0r+eacXKH3jrof9n8Gjlb7LtDlVXdeBMPQwhh+WBdn0tz7aSJjwgQSaaqpCofZ5V
	 gEFO6WekR5Rp+E0xUFcF0fFRQzoBiCZJZrqwBoNpRPmYSiMXvLWKHDh2eSiwZGYXzXEFe
	 /7iqgGJboITHNlD9zoS2zX2SA8JGYvPAUwIMreykADSP0K2K/vka0a9pwR2/ts8zbPoLU
	 CFIq7ulGjxDfpZdmpU7hjhtBigyCndeJK4Lgb0jnEztFu2ZSksavf9KxkuJrR+nh7WxPF
	 yVCyWrCaye6bH41FNeYfZYZ+6OlhsV/D31yLkumMjhYuMRup1nFbxo4u5161GsFTwfQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794923512;
	bh=qT0i7PSbQ1e/2eDiq0zguEL9U8YJ/+OJ4kzyJUSsNU4=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=thi3MUzUWO5ReyxMaLzK3iBdTnwkt8/9Vr7cu/MwNjxl+JxgjE9YdBONnAKx1GejN
	 PL4r2BIsCInnB61C8bH5/jpcKsTBBI0u+Rx8LyKrEZE+PmR/uXuwgl6NZj6gBNgolY
	 9nVJvaEotiv+uOdokZTTD0G/6j0Vabzk/fBSt3OWPgqDAr0wMMhw7P3R5CB/u8orGr
	 ATgBFDqcCTleuykuv40+0N8h5QAVyAKFziJ7tgL4rNGwfSgS+TxUBYcaGjSFD9oggC
	 NQ0uas4sJwzqPcOO1UHEsB54LmkIckiPZRjVYMtZ/W+taCXb2ULdpeISs2jFaDozs7
	 zSZgkqnfzy+OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5ADF281126;
	Tue, 17 Nov 2026 13:51:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C173049B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:51:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B339840846
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w2GZK21mUD41 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 13:51:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 90D7E40841
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=QT1njI2P
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 90D7E40841
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 13:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT0i7PSbQ1e/2eDiq0zguEL9U8YJ/+OJ4kzyJUSsNU4=;
 b=QT1njI2P6jHcvRoMmNa8trpsgCv1BTf8cTQX3ouW12fO/JgpRd1ukIy0mxTIM0RosK89cNVDY92Z8Fl2LFcLIr15dX8cjs/bpjt1uYCjjX3Gh77Phj8ljOowy76vo7o9E152RiF3P/7qpYRSQgD+lR14H1VQjVEUJtS2CTN5Fj2mNolpHK6Vh68+PywyoLXkZ0wRZUcx6rSbvLuK9MiudlEn9GhYMm/jdrVGclVJudopRB3NH1wPRFLL9kH5IEVOyRhq1obYIbmo9tAtutclzYK8EIuBtVuehQmvQX9t77gaJ4qvjNUWnJ1k+DSxlHeCSi3cUucdBMdQm3gIp0baFA==
Received: from GVYP280CA0016.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:fa::21)
 by AM7PPF623B04A4F.EURP195.PROD.OUTLOOK.COM (2603:10a6:20f:fff1::750) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 13:51:42 +0000
Received: from WA1PEPF000099CC.eurprd04.prod.outlook.com
 (2603:10a6:150:fa:cafe::13) by GVYP280CA0016.outlook.office365.com
 (2603:10a6:150:fa::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 13:51:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 91.26.50.189) smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: Fail (protection.outlook.com: domain of phytec.de does not
 designate 91.26.50.189 as permitted sender) receiver=protection.outlook.com;
 client-ip=91.26.50.189; helo=Postix.phytec.de;
Received: from Postix.phytec.de (91.26.50.189) by
 WA1PEPF000099CC.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 13:51:41 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 17 Nov
 2026 14:51:35 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v3 0/3] Set /chosen/bootsource for the next boot stage and the
 OS
Date: Tue, 17 Nov 2026 15:51:21 +0200
Message-ID: <20261117135124.207113-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099CC:EE_|AM7PPF623B04A4F:EE_
X-MS-Office365-Filtering-Correlation-Id: 875e6f43-2f0b-492b-78b6-08df44b1e91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|261009223027099003|18002099003|13003099007|261026121527099003|261021123027099003|261021121427099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: Bmm8FSG4TAG/CiDwAl6uWaAYQvcfwyiIjCuz43zbQlkSIke3H3bkbr283QVzDPo7y4dzM1ImwW7jFb58lrkRmjtt0431n4BG9OLC5VLCJff/CE9aSbPH1QyY1LUSYZc5xR01XKF8DYwrNuYXf7wopAlcRC06xwybYXFn4zjb2y1tzxeSJM5dwxyOIZvYEQfu9kJY1g0ArhwFkyolFK4zjygfyBLMX1UNBnU62GUInH1e6Sm4Q50PUBFkL+W3aw+uMox8xQM4FQHovpJa9tRJ1vYaM2c/MmvciYTAlYG7q7ro40YxGeyMd275k1JuxuqgMUsCXOJ0PNEC28+4rDqFiDTIUZOKScnJHJ8bVQyu8eUwIyc2VOhXbegeMkGc4wlc6eSjVkdLLlrOm5bKVwYfbAdEw+uu8AT7G/TcbwF53fBdMW4pJaYB1ijxjiA0L+/hnWIceVb4YDREkq0Pt25b/m7InoVijp6Su+hoHO178O7vJUAXeoU+WGVsf9kZQ8PoRzdttgH9abSF3yB2nXN6wB77Oo7lz5NL826oONQrapDHwhShPheDT9LNi9mcOc68UMp8mnvMEgmNODs84owwwQ/rXIXSbeYfbiIIHPJtF/j32rLgLfif3x7F+qjRgJYguw/RhlU2ZSp4/8GuDhTXTEPM+fy/p3NOebO/ZdvmZA4=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(261009223027099003)(18002099003)(13003099007)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8OZ7g2cQVHR+VAd1BdJ/xEXF1TOBjvMUMvr+C8WzPnTcW7YEAQL2BJVBG5lXSL9c+mUAalz+oBpyqHVZFMwiXZF/4ksuie8PhW98gkpDlEc51qBHLpfBNirGfsr/czHIhDQog5t7HEW9AYsq5OAD72wRfxneGyBDR49aZVBZdlNyqBv6/SQ8+RHByalRQtwZ0YO8KqQ7GhpNGiQaGZtQCXYXce/Q9A0kttWcSoiM7uE35RYVvoNLmFv73uFABcnYRVtRztM0CEn2JLbPYcp5vOmnWDlCtpyQxQopbjsEeIq5DKCchTIljvBppUfTPGnKPVItAvTWDl3JQm7SeGDpAym+wJ0mgu9+UrhmEkhDQ3u0qTKaxvPypdOqm3l4PnJImMd/mPd5YZWUs3Yt9BB6KVyXVknFMx6WH7uNuqbsXOiByWPDiov1ROhthWpkWFf9
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:51:41.9618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875e6f43-2f0b-492b-78b6-08df44b1e91a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CC.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF623B04A4F
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Changes in v3:
- Drop the check that the device tree has a node at the bootsource path.
- Use log_warning() instead of printf()
- Update doc strings  to match the dropped check
- Collect tags from Quentin

v2: https://lore.kernel.org/u-boot/20261014143328.3135006-1-w.egorov@phytec.de/

Wadim Egorov (3):
  fdt_support: Add /chosen/bootsource fixup
  arm: mach-k3: Set /chosen/bootsource for the next boot stage
  rockchip: Use the generic /chosen/bootsource fixup

 arch/arm/mach-k3/am62x/boot.c           | 26 ++++++++++++++++++
 arch/arm/mach-k3/common.c               |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c | 11 ++++----
 boot/fdt_support.c                      | 35 +++++++++++++++++++++++++
 include/fdt_support.h                   | 25 ++++++++++++++++++
 5 files changed, 93 insertions(+), 5 deletions(-)

-- 
2.48.1

