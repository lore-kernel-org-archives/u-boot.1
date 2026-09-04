Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41DDC79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF36560BEC;
	Fri,  4 Sep 2026 08:37:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VT8_H7mih5IA; Fri,  4 Sep 2026 08:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5B8BB60BD2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511057;
	b=d2e5sBzk7iJ3ozo8L7ENX3Ae0g/bA5D7SOGGgAb4+8i5UT9cxmRM/1GO07bxRhTTlCzq
	 B9P0wzbThxrpypXblzeN0mu9eceWPpNa/goX+7fttUJlFBamXWJu3cKYumdkOhVgOhoU9
	 NkuA0C2DmXi+f8CobsfMNq/2W2Ea76QLpKbiisAA3Zw+D6sKkPd4/qGBHSc1k2YsaATYC
	 AhPA6nRXbzNQlVo4PA09GXoN+V/6jbu888MkUTQiKdxukD/lqiUxmK3EgMrSLjAmtnHTV
	 MQZg1XMjP9SOpSViYt6qas/9kEdm1RVgZiuX4wAnB3JQjWTub+oUuZIg5ypUE98+fFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=e5VcqDr5pKeQlkmRcZjPpiIyH68psOKjpCO47hOTmZ0=;
	b=NT18OOtY86BnrOJbnjkonj4nMf9Sp6bujmyMSlD8V+YnZhdmsek1zSbyj3LYzS0z3EK3
	 V+1cTOuxMpewPOTSYvSHJ9ipbCSI+5h1SooaavvwsTi0TuugwmrGQL0swo1832vt4PPG4
	 /bWal248aTVJgD1k03MoMjC7gMMsB0dFhLlDUo8Q2Et0B4fEWTZZ9Z8axDREMoUf8T1qG
	 LmWXWYm/kYrUZqGa5n+1SkdcOv0QLw0oF7v6PqEmnUgjXecP+Rmkqs/isnEKj/eJ7WEUO
	 MWAokg6Qv9uoCN06w6myM55IdlNSACaXNGzMPGTo+jtSQUNkdcGmGzmQesIb0Q+i2gg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511057;
	bh=e5VcqDr5pKeQlkmRcZjPpiIyH68psOKjpCO47hOTmZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QORsZUbdYE+WOU5W30TRImLx0y8Rj7oPv1R0h8jIStgFiHxMm1GXDthY0tBQ0uRPU
	 hYCAP8XCqWTXo0G+jan8GIn2RjE+Clhw4nBA3SsnpkLhs3HLpIKeTfh0DhTHgr6M1l
	 nfEAWuBFcGaEvPhsp7pJoHO7mhRYO/mPwQkMicWoiFV3O6M9KAP1JbjpfJawsCSJaV
	 nZHebiJUERDo3RKnTwpyUNfJliTdPAIc/vxzMCfBRkuth8RYC3PZdavfFJM7rKhyvB
	 hwR7GyVWFxAnJMy/+BykL4XjxXihj9GTm9LS+x5QWbXPafJvYZ6TD9jX9KJyslG3Wr
	 IK8t4mTsAx03g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B8BB60BD2;
	Fri,  4 Sep 2026 08:37:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB73E3DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 917A540B3C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ob_34LwBck6V for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C38BD40ACB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::4"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511049;
 b=pEBOkcr/rTc/5hLldVd+/Ly/AR/hmQm4iAAvrHMuOsHkl2x6QqkMjUMCs0CKdl3xWBas
 xpwWcbNtZ1rj27wtHkqR2pAHGvLJ9BM79M/HAEPDFYWiZhWK9bTvq+lRctxehnk1ZsmFt
 27xq4hZzbT1v3MFhrckmSpbfcg+XQm9wJrnFDWqmZH7p+/PPnTRuRRoWL8M/sI5Tx/YS5
 ZQtokK2k37LriZ6KXkm38dyH0ekbm5UUU2XnVGKtxReJPBHiMS+jUI2hK6jjG4iFODI5f
 OZVHIkyZrBq0lVrGnEY4gozycFAtzV1qMKNpocRohoBPK0Ze4urIImLytGnD8MCUbjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511049;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=e5VcqDr5pKeQlkmRcZjPpiIyH68psOKjpCO47hOTmZ0=;
 b=tc+L6vr0Pf39hLo2el/jz5aFTYBhYASrzlIF+Wi8DTfQf5K4FbJhI1xrO5NgSe4k0q0Y
 /KmWIWVZfEQNDzd48WPvQy0pLmqHGUsz67B5m/vQNGQJCFt6EKBmAPspiuaDzcSkuLDpz
 1QyMyyP2kSSGSFz6KfWOsxnYdhG63ln+R3DSGGVaIC5OsWrKPbO+2UX0rj4jjq2I0ea9e
 pdcxKD9TbYAgQ/mNiJoiLwUjqTO4uakZaC3HSNUOHzrzkuElAbAj/luTIpNRZraqZ+atC
 CB9Dz5zYU3CnIR1Yx82VQ3hgMKiNbuer+ajLs398t7HEJmVkvSASmo2RsDU1ZsY9MgQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=u3U7yJxZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::4"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::4;
 helo=pr0p264cu014.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=u3U7yJxZ
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C38BD40ACB
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uE9rAOrGK25tCo1QbKvX3u/fUkZjdrIUiqenR1gp7KSaD0RZ5LdeXzoZX5jkzXN5fjOGe9RWqMr2zdnYuCCOCurZZPcj8WgwY9PcAcwNU5+RxylyURJkMAIbWu4MzyUfQex1P52kdVsRaDQexRkCUpq8J2WUFJYHhJ9gU+45Yz5nPlc7zBj2+x5lwupZtTKkMAL4yzSqbP7XrdE8uwS21olzq+cvw+HhUcsV3TTux13XpZm5kNzLdrvd09tyeKHPT3cf50O/yMoivOIUgc8tVcprjoWvL6C8zcjBipYUeD8MyU/cL8iXOtwRRJYYPEeGZhChPAnkr+u8C0VycEKAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5VcqDr5pKeQlkmRcZjPpiIyH68psOKjpCO47hOTmZ0=;
 b=RLSVFY62BBQS/luX2oH7ToxNq5rXAHCp8pjDboI2B5htemNrU4VRq7NjBycBSZ+W7yhGK7Kf1jZwa9NCWnPPqgbBCC3oPIclOfh8hXYcHJBjxMAtetxbgICmUw7+yPJQjMLXK9aabUuLRiQYkzhaaFxlMwi2T4ol8V9jGu3oSrppOC8XhnC7XozglqkdK3tFhbi2+RDFTYVQC5AXxebeU+QBwjZLUCMMwKpnexpasIHDzwdr11C49zMLNVUjyf8Ydc3PZDrpkYhI4SaAuXtgWuJi5ofWeSVV6ivnbI4uHhMChhZXyu2d5oiEkI7rGIHd3eB0EsNrrTMI6FOhDSW/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5VcqDr5pKeQlkmRcZjPpiIyH68psOKjpCO47hOTmZ0=;
 b=u3U7yJxZUAgvRI6VBT6R0pTRAItBZ4vGu9m0lDc/KFul/a3NM02dDAz62MEf3wErMSXZCfG6DJrvBSti0+w9ydxXwUerjP9lI78FbeQ5d7QSYkzycWCPmr/m0Z96yXID9CaV3yf4gJoHuhvMrWhtswiOgpxxCKUQjmBfERNMN5RSGfJzCV9/Gu17BbOuJiQZUL43yM/8+xAf0seaqgpVPjMINgpA4wmwHNs3AwZzvBYVwNTLSBeM2D7mO5EnGUBpzT1Faez84Svp8LR2b5y3sFZcqrhWYmVVjCUmyM4GZKEIP6MJ08SUy0CnzkJr16zSnF812+RSX5jU4Vo8MIx1yg==
Received: from MR1P264CA0093.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3f::21)
 by PATP264MB7194.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:58b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:23 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f:cafe::45) by MR1P264CA0093.outlook.office365.com
 (2603:10a6:501:3f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 08:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:23 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id F069A20061;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 13/15] tools: preload_check_sign: add support of ecdsa
Date: Fri,  4 Sep 2026 10:37:17 +0200
Message-ID: <20260904083719.53132-14-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PATP264MB7194:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1073d179-11f9-4c51-db01-08df0a5fbdd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lwvnUN5LwKC+cyTGefpFyCGHLZ63ijsyYVlfBYCx3lSxriL56T7Pj7qwFjLYVfjf/Q80acUPIzXHe1yJcH6jtsalvRdRGJKorbk1mUwn3aRWAt6yOJ+m6RKP/SfEq4DBrhWXRjwSa3Bq/aBZWjJMsiwkwA+YT8VKMwgiX79O46DzzbZotIouCpL1Ppz9DBHp5m+EtxEZ6i/tYh1p++EGvN7A1raxlrdelXgB+vfqxWnlCIZljLuGmcNXT2pq8BGfDQsMmqpXq8FNnLfCgkWvCVong9rHTkBGTzsOPJ4QCDZ+dq50RO1rpApgVNR8Lb4xgZp4PEP/eZJBsDzAh3fBkAgkk8AN0I1J4Rou267DWGYD9woEFHKAhs1DYDuY4qjmN/i+Fr4JEt9BxJ4Sbn0w9fxQAGFyM0R6nawr/LPZY3tY/MVbVjsMNVbPt3BZGeBlOin7rDGmeA96t60MdkeuROdj90fHBVf5A6Ky9Q8LAm1TnJvu+HLJRkIPBs3x3zOmSfcyaI2lW4KT62ZiaZlsfkGFbT+NZztAtYbLn2xEgvHNkcfHRYXIQj/AX3Y55FZ4I6jKlgm9wc+Jbptjg/wvBOLME6k/B6OjzLGwyQUne3jYheWJVX9UMmbI8ECre8CBvVt/i57dt/5xFSZMuRmJG/1uBMQBEJl8lu8fhUf16Ma0RzdoSEXENEex0sHfQez6rfanB2dlgjIUZlkCiRZvWg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QI3dAaWTsZq4w9IKaBxUZfG329YJVKSP6mLkYhl8QfG7Q1j3nWiEMBweekEQZEapGZ2CYKaXb1sJ5qXEFI6sWVHOU0XJmArPgchFSqKKQ8gk6eQd99Oue3Px7JOyMr7EUa/tnE9y+3ujZ1YXSf+0/9CUqQN7F8NwWVCZu1CdA3r5MjPBJZDBBr5d3ncCk9WfsVw0ME5V0KFroZB7ktindjTHCu4RsWbxmGazOg4RIrNZWWhczZQKos2HWyqjxAwhQFZluQTdtTcyNiwpQBMe7WF0BQOTDd3yg6vlGSNQLXa45I7bNcRwW3UwH388hi4GenKPFgxc/ih3CCTfj88GPm8/o64f4vOs8ZTvIlj+svJtAeDc7iy6xSsMSFi7MQWB7PUMKFh679aCwexuX5eZ2EbFURRt5Zu8E+hjA5/fDzOzAPUZDD8c8OQmir2Ai8/W
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:23.2117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1073d179-11f9-4c51-db01-08df0a5fbdd2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB7194
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

right now, the tool preload_check_sign may only
checks an image with a pre-load header with rsa.
We add the support of pre-load header with ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- free key to avoid mem leak
- fix error management (set ret before goto out)
v5:
- add include ec.h, evp.h, err.h and image.h
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change
v10:
- no change

 tools/preload_check_sign.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/preload_check_sign.c b/tools/preload_check_sign.c
index ebead459273..d94f0509e74 100644
--- a/tools/preload_check_sign.c
+++ b/tools/preload_check_sign.c
@@ -8,9 +8,13 @@
  * complete file. The tool preload_check_sign allows to verify and authenticate
  * a file starting with a preload header.
  */
+
+#define OPENSSL_API_COMPAT 0x10101000L
+
 #include <stdio.h>
 #include <unistd.h>
 #include <openssl/pem.h>
+#include <openssl/ec.h>
 #include <openssl/evp.h>
 #include <openssl/err.h>
 #include <image.h>
@@ -144,6 +148,32 @@ int main(int argc, char **argv)
 	info.sig_info.key      = info.key;
 	info.sig_info.keylen   = info.key_len;
 
+	/* For ecdsa key, we have to update some values */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ecdsa_key;
+		const EC_GROUP *group;
+
+		ecdsa_key = EVP_PKEY_get1_EC_KEY(pkey);
+		if (!ecdsa_key) {
+			fprintf(stderr, "Can not extract ECDSA key\n");
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		group = EC_KEY_get0_group(ecdsa_key);
+		if (!group) {
+			fprintf(stderr, "Can not extract ECDSA group\n");
+			EC_KEY_free(ecdsa_key);
+			ret = EXIT_FAILURE;
+			goto out;
+		}
+
+		info.sig_info.keyfile  = keyfile;
+		info.sig_size          = (EC_GROUP_order_bits(group) + 7) / 8 * 2;
+
+		EC_KEY_free(ecdsa_key);
+	}
+
 	/* Check the signature */
 	image_pre_load_sig_set_info(&info);
 	ret = image_pre_load_sig((ulong)buffer);
-- 
2.43.0

