Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21D3CC6B2D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20E9B60844;
	Wed, 14 Oct 2026 14:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CpLf0MjnqU_F; Wed, 14 Oct 2026 14:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1873860836
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791988437;
	b=c9z3hhk9GXPLO2c4nSz8gMISJ1X2FAjU7yJC/FpQpmJaSxXzO1/qfqwKuYy4VjB3ypcq
	 XuROt8GoPs+KT5eLGEfvsgqceMVhzOx4R2FFxR47y9clDm0Qwz+jmtqlbYAM+xGMCIRWW
	 7Xv8QVtJsiKzPTK0hLypuimBTGotJEWrCi+H2THY1/t4kWrv/Akr7LuqtRD8aooK+RsGG
	 z2pK9skCOMW1L2t8/xno/i9C2+5zD6XqOfJfkveturLr1FpCgU2grGzTjnq8ET4ToA9ap
	 8g3rYbgeui9dljxG+Vj9OmW+NFGUvr47g7s4TM9x3YqrwadCz2LNOeTmlqpyUlpJXeg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791988437;
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
	bh=uJVM4YzScGM0ToIwxuXqB9Jykc2KCj+Aw99+Adc4kkA=;
	b=D3HYRXzvB/zKs50+iE1BGJIUDsw0cRADvo3njdjkcSChn7K92c0IoxiNrUJF0+Nn/h8m
	 A7b+Eh2yPc+MEvLYk9T8ECMn9PvDBHeN+YZL9GtJ+2+YWCuAL1tHGBPxNrxC+Np2VBsVV
	 HSJfRLL+irExU9lzwkggrIQyC5oUo9o7UvF4cFrhVnOhz9KaoOxCLdUJCXyJ+u7aY+fuD
	 PzsnYxMqgEw/5njLRipqAq/0zTdgapw4VX+0GrUkD5tBSRYuk/2cAe0fEhMIZKIkHTwGf
	 eHJaJeYBKJ6EelpgblUYDw0VVJxusErep3ke2nlHZis9s9uAa/GKrv+C2GyC9RF/MOg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791988437;
	bh=uJVM4YzScGM0ToIwxuXqB9Jykc2KCj+Aw99+Adc4kkA=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fo7UwF3T26LEbElB9CFKecrZGGj2HriM43tC7TxlvBZAitTz/KxBhg5zu7eUFrZs5
	 3SFEr7qkHRQiw0cm901i0zurpPaxxulxbS1lSRq1ezlOS/cE15iimOOcO28sFOYC30
	 BuMeQfvXutHkSQpU81FfT1hqTgoEmoCWNNcqh6PKcAqREZEfPHfbIxjliXzG8rCC2z
	 SGtskqWcoIiKZMLS6SRk9x1dFfoXXlm8PY249r16Ni+s4FqxNlwZTCHgVpdKBTxwu9
	 xdAx+DjPwHIVVT/ko/GCo9dOOj3SGXfMQ/6zkGI3FsUGVdQ69412682P1o/s9FvhzC
	 0tPjBcHtf5mVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1873860836;
	Wed, 14 Oct 2026 14:33:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C0FB1518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7ADAE80E47
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:33:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLS79p8ah7Vp for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:33:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0E70B80E46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791988434;
 b=aNNHlPszp6LYmAV9HESvaZJvm9Y3FdyeiLJf20/NSEGY74Mt0tUlCJ/iaS9vU/bmCTqp
 QnHi/IC1xAw0+1gD9jU/q+MFmKrL6rwVKPVd/gmzMzuDqDo22T/1+/wopOLQQK4vf1x+N
 g6wJBUgZK6mK3nkP4SLzuUj00z8P0TAZG4BNvuiCnnVzY1WthOp+g0fDEImSk3/FLzliD
 Q+5sOtcB5EKt+0MuZ5Wc0JzbirYCsE3HMb1/E6GQ9slKIRMEpKRnRCm1YnZia3mXnyKTF
 CPo1aWeul3A248Oj68GNZsZzBOgEKtA1OGUE/J8jhCxJPAg4HrvQS5U1++JtvR2CyhQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791988434;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=uJVM4YzScGM0ToIwxuXqB9Jykc2KCj+Aw99+Adc4kkA=;
 b=rLFXimQ1BUAu2XnmZmyYgbcjiwzKJ94N0kPUk/0+JPhYUkhpzzxYiBYwVk+5r3hJoxaX
 aFfwkx7/F/ANmK7wyoh0rQbOjfy7UDZoCcZEg0dZFlNOONG62+EK1G0arfa9QSrTrDSn4
 nSg6iuxyaMCMWp1kCTnFEmMlUg8EZAnl5kVs9Yi4AxL7B8w+AzPh5UrmMMEGHdUWQGvgd
 Je+cjgN31xuBUbo7Fyg9oifFzLwRNKBqJtyRAvC/h4PY/+p/Qy9EheDVQrItSoQhMIEfB
 hH29U2DhbmOhWIzerM+IsD00laf5SIToor0ekOWbbc2NbD3smGYK0yEarYt4mDysY9Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=phytec.de;
 dkim=pass header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=Eo++rEzT; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=w.egorov@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=Eo++rEzT
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E70B80E46
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT6lntZJAhSx6Z7cl+UxO3Xx/NO16b4hP0B9Ddxs34HJLKKMP82NYmQ1TMNmozfhSnmwauozuuFBtxAjuWbYFrgCAVFowlr5ngFkfFaAtAH+us+/pvjZPADsooqL4E8sapssWlXchgAIUVRc8UQ241tkQF4tfoP2lAgGdDqQk2R1YGB3tD7VlVwgM9PEYYJuv2Pojs6Gwi5+sbednaC5+y7XDarfgF41BWJyXMo3zXADL3fjniEIMQjrgLlywkxKJ+MU/MCU4+WebfoYx2xyqacVXeTOczfS/nOIZz1CPeRcAkhIHXBqwnQfYlEaMNXJ9uhyZr6f95KuANuVm66WDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJVM4YzScGM0ToIwxuXqB9Jykc2KCj+Aw99+Adc4kkA=;
 b=ufju3uNIXGZkmVwxaVmL82qrJ/6E4SC5qkNapvp0xOK36EcRotTeo51VAMQHSx39hvdLRCQXZdviAaZfQrE6CLjgJytr/tiOomQ8FrEl+5OnIxDoJwkFGLxZFuQKZTCcN3PgY/qT7P6obJPDvaZQojHIvBF7ktII6WjuuSLQwCmhmh8hwR/b5wzhtzLcTHdGOXdb3yjD5qRwT06deTuDdb8nDr8baObG+7gTeQMVGhVOr0M6RJWRn/OWCcuHQEGksLuQnqeeHYNiEHVdN9aVQvnELGm/wOPY2DNdYnELCuG/nhefQ16jDUKy1f4YiP209oJN9k3uAYn98XQDeDZ/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJVM4YzScGM0ToIwxuXqB9Jykc2KCj+Aw99+Adc4kkA=;
 b=Eo++rEzT2Ynv4qmq6ExudtQ2eLjXkrpQM7c0YbMgpYNToi1KupoVFaaqG603sXoXXfo+XfLHhLHwBl2PWwbWR+vvEuV+vHkrhvD0QxItxnetQxOvCBDWCuEqWbQ8DLlz36wbTbWFIJRh43W/TubuzhAI1JJjGBvt9stMgUhqXf04KmUog30DwMmfBGoFVy1KzBN3IlV67M/wtS9JVlVvzRT2+ggn9clRsALyHsheBgC3sPeVsLjkN5hKXPOvPxHIGAA0yranKhuSK31vP+m1dcWinpkAMxR8x3wCVgaQYDScGkpPE+LJat7UYb6avJR6tXsZmQWsFR6KWp9D8BwIGA==
Received: from DU2PR04CA0316.eurprd04.prod.outlook.com (2603:10a6:10:2b5::21)
 by AM8P195MB0865.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 14:33:47 +0000
Received: from MA3PEPF00000407.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5:cafe::46) by DU2PR04CA0316.outlook.office365.com
 (2603:10a6:10:2b5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 14:33:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 MA3PEPF00000407.mail.protection.outlook.com (10.167.241.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 14:33:46 +0000
Received: from ubuntuvm.tail7493ff.ts.net (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 14 Oct
 2026 16:33:39 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <u-boot@0leil.net>, <quentin.schulz@cherry.de>
CC: <kever.yang@rock-chips.com>, <anshuld@ti.com>,
 <aristo.chen@canonical.com>, <alchark@flipper.net>,
 <u-boot@lists.u-boot-project.org>, <upstream@lists.phytec.de>
Subject: [PATCH v2 0/3] Set /chosen/bootsource for the next boot stage and the
 OS
Date: Wed, 14 Oct 2026 17:33:25 +0300
Message-ID: <20261014143328.3135006-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000407:EE_|AM8P195MB0865:EE_
X-MS-Office365-Filtering-Correlation-Id: 9508034d-a5f0-419a-4968-08df2a0027f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|7416014|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: 9SoA8iarR32NfPGPrnvVL+vRCbQo0LsQbk3ykx7SNkWKuMNqcqQx1M9VRg8s9jDGBKbxgSddSUZ2VscfdRKt5WKcQy61gJCvUMXIqbNg91RBbRG+qd1I3KdkUAltqQJlDzOqbOCymV1PBG2G+DEK7rCQeWUGWU83cHb2Z/H2jxfOkVVsGqX6ZHV2ZweSLwpSGlNjciMXMkqufZPqtqSCSsfZd3ZszbTu2PiMdVz+B1VPuA/W0lr9SKQKeRk1CEmlChhdB2uICWTCcxsoljpQbRyLxDmzpxJsInLinWBu2bxbWVzwko/jGKYiFGEsRWpFs3e559WcQa4UyHim8zmBj6gat52PZUOYTTVo8DoidmwL7SUbUuQPzuO9FN5YBTe0ChqF6ooTO9ffF4WRwHWtpJ7ukb1WawoUC9dS0B51PpM5mulUWX/zX1xGWAd2d87YAm6vFplwkKhS+XPshATwXIeZ0Zt2P81gAOHZXHpKpwp1ah2mEDn05YPaCng8vA7v4UDdRQLJXtXwFjHl4sb7E8DHgJKtwwyf8l6Z2GUmDjS5zCKJNyb9ANMPZbZzOGEqZwK/Fy/wODfMVeOxiSMZO9M8gvnMxU6HefpJ9sillPnpXoM7iB+YVWnz/jjGbdKHUSK4OP05tb++e1cnpASat23mQSRV+78ZciTWNj6xtzA=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(7416014)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(13003099007)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GB+5V/NW9uNUIqD/PA6jIZbnfjuPhxyrbQ85e/0nCZD7TpenmCcnalEU0ieZKd9N2oOqKXr1W67kel13LscAPkxfYrD7gd05TPc4f5qtLb7jXuURLdtzJ+G5CNxO1TC5+8/O9XSu+AZuxZwJkNAUEFnJY43RA8axzjheq7DjF4bw5oHtYp9xOfbey2pDMYe8Hm8j0y+KVzC5Zl6AECOnwh2DJTVdkrBDKJR4L9uREi98GAMOTmgYQsLfQqUrUQcvZ3iewAxZbC2Ehn6Dy14NeS2LpeuQN6jlbOch06lGICb9/pc3FEJFtj9rXXiX96iUFU0aEt5lViOhAbWoyFGzMhBnNWsvwuSt9939xT1Afcydidq/SddRlTMoQSIXd4BWTh+Oerv1Nx+rjqqTNz+EcK7GT0ZnCo6Z0CqdAg59cDy9xmWSb6PZ8+oV3/e50i15
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 14:33:46.7416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9508034d-a5f0-419a-4968-08df2a0027f0
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: MA3PEPF00000407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0865
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

Record the device the BootROM booted from as /chosen/bootsource. SPL
sets it in the next stages device tree, u-booot proper passes it on to
the OS. Implemented for AM62x and switched Rockchip to the generic code.

Note: On AM62x side the default path of bootsource_get_ofpath() is never
taken because the override ends up in every stage.

@Quentin: Would be nice to get your Tested-by for the Rockchips part.
Let me know what you think.

Changes in v2:
- Drop CONFIG_FDT_FIXUP_BOOTSOURCE, always set the property
- Drop description from chosen.txt
- Rename fdt_setup_bootsource() to fdt_fixup_bootsource() and export it
- SPL now also writes /chosen/bootsource into the DT it passes to the
  next stage. A stage that does not detect the boot source itself
  simply reads the value from its own DT and passes it on.
- Switch Rockchip to use the generic fixup
- On AM62X, OSPI path now points to flash@0
- Reword some docs

v1: https://patchwork.ozlabs.org/project/uboot/patch/20260824120632.1840277-1-w.egorov@phytec.de/

Wadim Egorov (3):
  fdt_support: Add /chosen/bootsource fixup
  arm: mach-k3: Set /chosen/bootsource for the next boot stage
  rockchip: Use the generic /chosen/bootsource fixup

 arch/arm/mach-k3/am62x/boot.c           | 27 ++++++++++++++++
 arch/arm/mach-k3/common.c               |  1 +
 arch/arm/mach-rockchip/spl-boot-order.c | 11 ++++---
 boot/fdt_support.c                      | 42 +++++++++++++++++++++++++
 include/fdt_support.h                   | 26 +++++++++++++++
 5 files changed, 102 insertions(+), 5 deletions(-)

-- 
2.48.1

