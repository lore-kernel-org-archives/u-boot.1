Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54096CC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1165D80E4A;
	Wed, 14 Oct 2026 14:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E1RnzuKHu0C2; Wed, 14 Oct 2026 14:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56A9180E50
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791988456;
	b=n0LJRWEBknTrh+feCYArLDqpXHrUs5VQjlYb4WWuzt9L8sXk0U4XF1EfTJZqkovd19j3
	 Efum5bU9OqScxlVZBKycOIEPyaHiZyfjKLLDVHxOZge6o/gDiXfghF45SZYEb9Xh61VXX
	 gh8b8AxqhMjV/4Dn7um7p9OSEr42D/0gFR8F/uRrKoyvUpQWSxJ3Gx+6+rqCx0mRRSZqY
	 SsuNGNcxt0L4BvaBjwK32IMiIwRhRYLpoi48/otK7H4bPwyYaa+VbKGvcCvRrtsse7SAU
	 uw0d0eOj1qMsrSGOvHWMEkD/eLdJJuOKPCkv0Z7PpC+Q7gepxwhN5OPyiX+GLpjQSFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791988456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=Us2CCssOjrz90ExsHHio2OC5IAA644hRFaTya+emaV8=;
	b=mR21J/Ieoo0Otj4NvjnIO5gmmHJHGqGhfe3iOE95vOoYAwP5r1Tpsuc0pnM1DwYIXp3Y
	 TvHLcaadxWPF0vmTJ+AwUF5tMDHXb5Wf1Q0vZlCa/zoQEuM2U/v2bPy57boI7lan0m/qv
	 AU2JRFznsnR3OUajefnsbFRkhBMKctoIIm8efv4ADVhSmSrp3oYQuvS0HzD9lWenY4CjW
	 3fSaW5DwzebWdfXSHoBYXPNuGZaV0E1DDgnzK9s+V/gdywjkGv45d/6WqIQXAbxL0mHL/
	 GzJDLTZiD+F53uPpLtOKtGwhip88snDMkRqc7pPfj/8DfXgIW+pa8IkcQ/V3hwSYJ6Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791988456;
	bh=Us2CCssOjrz90ExsHHio2OC5IAA644hRFaTya+emaV8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sx8SdrC2KKdSFQAiFcHJygXZhzBCI5ouqcyFWOPG/942x8fo3Z3jJDxWqqia2dmcP
	 WVXSQ7tHajUr/+jer+dPsP3CHtOJPCzspbQe7S27Lqz5slY0SkAJS6Gyd5eXkx7h3y
	 OYTUIx9wYrTVdv4Nusq7oxWFiHmECV5rrZN6kmfLUwCKZ9oktkiHRt3yDHCLuWY9Ou
	 jixQ1nKxu/eUrMmKj7Qp8uLb0Ggtqv4llDvyPON4ulRZvwv4fJ9vp916oqgtder5mR
	 qKKxpz1F4u0tl5h0M6Sjxx34Ld+oqwCKDHa6Qtfnxznvi94FvZjhgWXy96eQlpn4vw
	 XzYLgVwH5LRVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56A9180E50;
	Wed, 14 Oct 2026 14:34:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED1792E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D368A40189
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jE_4CwofFF9t for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 99749400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791988454;
 b=Cr/G/jZK+/3KQKBlDU7NTLdwJNOWK5A/8vHMDTvhxYxo/8VnyE/Cgux7iU8dbKFPW97r
 V8zM2x5PDXHbKU3RuCKa5KulcTZNtT+WWt0bZKY0BQz3z7h5+WZwr9fpeI6ui5q1XFoDf
 Yyl9Y2E+DHXfXy/xP0V/Qkd7Ih8IuS8r8TW6KCVIsKoyByZGodDQTM8/ZxTA7Kxz61OVA
 g6+rh92SX3gN+S4zhgpHiOKqeJvAElu3TFYbXjlkEb/+BFwTZzNfFC5dHlCiVdLOR12E2
 9bKxoK/Z7YmtTXB9N1vHvnKlGMJ5fGSj+31BBh8LwqE+ubxNOY/yTqlhO0WHNWQys/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791988454;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=Us2CCssOjrz90ExsHHio2OC5IAA644hRFaTya+emaV8=;
 b=aSc4xFXgWvDi0ZcM5vCzjIUElkbppOTEvFMJCGCi3255zy5TzVIeJUcsqiZemN5QAWvd
 r/hiBAyc/JRH6aNxaavL2kXgWngMW5w9or3ze77yJ6FZ3xNcs4pMg6lqP7W1vOFPaoYAr
 B17LQmChE4OD53U62mzpI+iQ0TncihmX+yf1V431uZoor0qEkX0H3Ar149UjuG1LAXO0c
 2xYffXOehAEh6V5IHpoD0MeFPFz5/LY22TBPWeCpkFvmeRdXsUX2z/jyW9bBlRPHOE714
 EsmiQrr5kjVmdee2sAawbu+c2nxJcep1zJSdGTttwAFhBzJhDUsAOOuLApvikLdAhdw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=phytec.de;
 dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=Zu3Eljq3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=Zu3Eljq3
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99749400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:34:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7begBx/TXKg1XRHkulR07bhgrXwoXQ4T4E3CDDeZvb5ebPDPdMHCzkgdJzveFGMz8CYnXKOr3j6nd80VHJ7POqndTN/DX8Cr4S1IAyEuZPg8TFfKLOqnt9NI32mNx47TAJWkB+nQAbigwsVS6YAenGzqjTexcRBNvrKvvQoBEH6TQzzJAMGkwRB56gwjpLId64D84g+cIxOPOSsE8CJU4DUbvA8JImFC55ZRiK9JceevpLK6XZUSSC+wY437LSEKEYQ6zp4WQ1/B5yd6nv8UmTycTOzwH60Fjvvht+U4TyE1yKyh2CWdv4SH8Zh6uhud4JyQ37Ef6qjzSxjD3Z7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Us2CCssOjrz90ExsHHio2OC5IAA644hRFaTya+emaV8=;
 b=jMzz6Qic0YXKtNJe/INfTwpxs6aofw2DbeDTj7KKQ8CzkzwJk4JN4W4rScIuHSH5yQ2S2bmp1DFX9U7kBz9rid6IwFbhyP9G3ZwSfXbTRm1UhkfBw/ePHCtUJrtjWVTmazyJs7eWzRPLoe75vkVcQDP7WrgM8NJAzEI7GcxhDSjCNUXGo7QcsuvPnSj+9CaVPo4AD62YAlyPVqEqti026FUaloRPfv6upOmatK6ppMKjT/HNkK80JBPRGC8HvEx4q4L3S0XTMZTZIxpZiFfso9hfUdc03Togm3LK5n0zkEZAZylpJtJoi0/hs7AZBLsZYiX2nXoKtkI7h9clfAR/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Us2CCssOjrz90ExsHHio2OC5IAA644hRFaTya+emaV8=;
 b=Zu3Eljq3fg8XD4FNUIjYboWgDzbowqxs18dxbWizKeVw8fP+Gst/bI7S164EjElB3VVc1KYbfH7GPaR/WzkzE8OZeTVLJO+EInVKAykQHQHWbs8mmIk7wNwHT2LAoX+XcZvPPRDPNZb2/8WnoCQKNoA7in4cBG3XCnnOKQpisJ+a6QsJvEpiTCZC/wFgiHFfyS7rIMNbfLvgqiOaKQwIFDMdMVmzrgObGSmvPw7+0CpLGB8ypEftzJ0leXML09KgO4sScwWlxvO0yicV5ZX+sQSmZnKE4Cq8aCbHPeV5aER1z+QasVhmUZeWN6hYPlVGEyeffM6W+PtgZkxeejluzA==
Received: from DB9PR05CA0017.eurprd05.prod.outlook.com (2603:10a6:10:1da::22)
 by DB9P195MB3019.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:5fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 14:34:06 +0000
Received: from MA3PEPF00000404.eurprd04.prod.outlook.com
 (2603:10a6:10:1da:cafe::34) by DB9PR05CA0017.outlook.office365.com
 (2603:10a6:10:1da::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 14:34:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 MA3PEPF00000404.mail.protection.outlook.com (10.167.241.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 14:34:05 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 16:33:59 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 3/3] rockchip: Use the generic /chosen/bootsource fixup
Date: Wed, 14 Oct 2026 17:33:28 +0300
Message-ID: <20261014143328.3135006-4-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014143328.3135006-1-w.egorov@phytec.de>
References: <20261014143328.3135006-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000404:EE_|DB9P195MB3019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc0c40a-0eee-4e17-34cb-08df2a003348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: cyTzjF+33NaWEdX4vRLsiHt7B079/jEvC8ZW1DPLzbn/SziWz+sSVFkjMtNOTeXPuuz81x1hD7ZRbBpUnEHtcevOqZ9ou9NJQpQqGu+Lnv4yFS57WMxOGLNZ3lyAGiZDQyVBzcJI/9mBbz7V1zBuLldKC80IB6y9hZsG/A4CKvLj+OPt5ff6TFyOWFtV3eje7d9qzqRp+v+OfglK08pAR4/Vnlqlz3xHSAzNsozUT4Turu9Z57Fz0V8h9iu/V4I5LPxMLeEIf8E9xuDtdqtDfST/cv+WxmRDT58I1SZlUm2XWz8VttowHyjoWngcqB8WYUc4C9MPASj6D8vx0qx8/HDGDF+tNvEGgVe2aR9zSxbr3KpNixZtkuqXPUj4GqztX+YfKdOFUJFhz+SBFBMpYlHaW4WvGhUwfxSD0XyE4uFjNbZiyoRic7SkHjp5pvUFH3b5fL2BgTM+2gSBW65W9UhTMkeuQFETIsV6KZbhyWNPiVgGLBOj+Igf8Mfj+tN/azy1bae3o5f7Aj8A3q/JMrARsv6GzHu7+QMImc+GDXEnDzhXPFvsxn/cwVSW+4YX1Nmk/ZzYcINAxXg7pyOiWim0uuULSqpKlohZav/YG5KMRsb6c2iiJUMScq/pxndEwlu2ofUF8JrttkLuXh80pQMiHX9lHT0XxttQRR14A2oABqrGuq5yU9CurhHCuOA2
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FhoGbrYjsRCIVUTVtSxrGIsnVTBZbK1gOrbHEJhqiOJ91FIsZfVncfLno3eZliPtZ5chkBo8BPotlfgpSobnpZ5rhkVfaVg2c/zFAL8tkCuU6j0KNqyYdEHpNvajwUr6+jWNRtjVRu0EA+Zfg5YrRST818As1EAlVS4JQQRlDAHAPEPH86s/m7zOMi/2UN01S8m0UhQ3EhjlmiRwWQdFdTO0MBqHt+bxlduhQh3D7dYX5nNqqhmjkcrX5wf0zR90QkxZpzQ2XUVJlEnrS2bZpypPsQmhHbrLnOXF1Xshfj7wbbFPB3mkx2EEr5bsDEhuqYACciASdjDNJx33OK0sbyrwHiHqIDLwimfE/47czvuhiZFVrhOQYv0AX0JwS89n0ADCwjZ6EuAeJ2GosuRQc1iYP9wjrhBMbshwfMHvrwnsZpOfG48zrSOd5fUQEYR6
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:34:05.7795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc0c40a-0eee-4e17-34cb-08df2a003348
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB3019
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

Implement bootsource_get_ofpath() on top of board_spl_was_booted_from()
and use fdt_fixup_bootsource() in spl_perform_arch_fixups(). With this
U-Boot proper also passes the path on to the OS.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index d2dd5e10935..1a2fdc420d9 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -262,9 +262,13 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 #endif
 }
 
+const char *bootsource_get_ofpath(void)
+{
+	return board_spl_was_booted_from();
+}
+
 void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
-	const char *bootrom_ofpath = board_spl_was_booted_from();
 	void *blob = spl_image_fdt_addr(spl_image);
 	char boot_ofpath[512];
 	int chosen, ret;
@@ -293,9 +297,6 @@ void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 	 * Inject the ofpath of the device the BootROM loaded the very first
 	 * stage from into the FDT.
 	 */
-	if (!bootrom_ofpath)
-		pr_err("%s: could not map BootROM boot device to ofpath\n", __func__);
-	else
-		fdt_setprop_string(blob, chosen, "bootsource", bootrom_ofpath);
+	fdt_fixup_bootsource(blob);
 }
 #endif
-- 
2.48.1

