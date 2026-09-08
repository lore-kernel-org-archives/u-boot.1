Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 428D1C79FAF
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 20:12:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 616DA80CE9;
	Tue,  8 Sep 2026 20:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rrkm0HxeOau5; Tue,  8 Sep 2026 20:12:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 659BF80C04
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788898349;
	b=Xa1b1wReYxHE/hCSH65ShVVQSrdgka+LZY37DAiQDeA5klwoT+soWeBMLOumfaAPBCYf
	 hB/Wbh6Wa4pWskEL1ieZp+FKcmq57BhIpYFF5jXbVPvDQN/paBG6mhYN85Reo5SqL3rxd
	 2bmJbEHEa0NOeZt7dziEN13qvaJ1dcEvkDFyJ/mWnUy08wB16oRMnYdmCVS1EKqCW0WvZ
	 zMlAM2ALJuJcAHI0M9Gb4him6NnwKw8jAYU5sLULKfFLIXo1+ePv6MULcX0t4cc9y88yn
	 voJgMOQKorRX8nIMgp7YM/BUys3fUk2uuj7Xu/ZySEFLn+uaOiIWhHtQcmkPXeG17uQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788898349;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RGlXuZJU6/oEpzUD6wL8prjcH4ymidZuFi1VmZ856Lc=;
	b=aCrBULZovhJmPdvMGkVD5wt+dLLsLtSaY9it2nOAiGxBDff8Pnm6DnGbPys6JENCx25O
	 5bW5/G8A1gS3FsVB10PKJ9RAwrK07pwaXOt655odtnGss3Pr9xf0sPVqd9+fI0xSjmUbV
	 uf9mpg3nbvh1Y/XIjDHG9mx+/aijW59fgH+HVL83IJ3plzk89wDnjfhTWZsk3HmLwaIw4
	 h5igyYSsOa5EcqqjYS3BiCwA0Koxxxay3BaUAca4K2AJeHzm/bJwFR6xxNeV8foChA7xO
	 xlwtYuKKix+O0BS6pNY7qDnyMWOL2xTsHEjjDz2hsq1rH1C1bso1g2If2Me38Gf1NVQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788898349;
	bh=RGlXuZJU6/oEpzUD6wL8prjcH4ymidZuFi1VmZ856Lc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqDMbzR//3qv3SJN7raWf1scntQXRPY/65jlGgG4wKRDgon87m2CYhV8WumsHmjVz
	 IUdKy0cr6Biu0GvPaVzArLfwdycBjULNSdZhP0QIaE/doES7YuaBKHvKQ7JLsDkSrS
	 6Rb1sWgHVIsX5r3RVnuIdeQ6YocluNjU2nBuJOtWZ+OXeHvFTqP6LtjcyfAjMTgTrW
	 o0o8qxHXFeND7LOaj/WPuLFWKHIC7aZh+8yroHPqofiORsouTmPLSySk1QDKHNL50+
	 thzwQY90cifbU1Uy1IclsimuBcXf5GHxk2sKqHjM3ZPtdVcMz3x27aVPSFEqG7V933
	 mhmylJSbNn8/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 659BF80C04;
	Tue,  8 Sep 2026 20:12:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 05135268
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DEEE24061E
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5CuaqWPhQSKY for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 20:12:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 50EA8405F4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788898347;
 b=sL4ps+KRvZBfVHlb8+Z6AHAub0SzfvSdpwI8D1LiaBMEZZepeW9khZRyzPZMk4BOyPNT
 hXy4L0Pca+AYHy4tI15PCpZUl5F34cLlJ4YCnz/Ac2RkAiJRwpgdcNTNYTQSzJ3lmEGqt
 WeNNRoSFwUp4dnSylNcsU1vZBv9ofcwle+BRq+1h1X69lyKfInCrsaliOeJ9b80LkXBmo
 HGAtTXxssex9JFnaSEJL60o/9A5hqdhjaNfOA2p1AAbP4nXyXRlBTuQfhfUTmECsOnTtj
 /AKOfDBMJdrL5bh0tefnxXsmC4mrAerl36UuUv88/X7zTzykn7fo3adp8Iwu3fJJ8tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788898347;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=RGlXuZJU6/oEpzUD6wL8prjcH4ymidZuFi1VmZ856Lc=;
 b=iLz8hhNg3kASNw5Ztg+hQnvxjBblqZ8YujOGZcOPMAUkzrifHafZ8qC4/ybMrFJaYAmj
 7PuNyilYKMTYIoci73N2kxeVEcoBl2s50vfa3JcSrdlM29lhS20328c4PhqikitmzLUKJ
 rOowgX9sKzsam345ChoBqlCrtJETmhhOqTiYMw7+18CwVGfs881evknasetN8z43uLIsQ
 qMLGC+na7y/4m4r39dljfhGZ4ABDc9EdTP6EjbJqewUx5Xjk5PekVuBXwAGMhu6w+0MYS
 CnP0Z7ze69T9dpo9Zx5JGFjvAO5q6IYGC9U8lCgX0FxdTig+lvofxY4uIxRaCvN/C1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=k7HLEMOt; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="p8pwB/Il"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=jm@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=k7HLEMOt; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=p8pwB/Il
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50EA8405F4
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 20:12:24 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688HQXSG2576574; Tue, 8 Sep 2026 15:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=RGlXuZJU6/oEpzUD6wL8prjcH4ymidZuFi1VmZ856
 Lc=; b=k7HLEMOttWZ2CF1cwZuc47XxK/XPrHn737m6Rdx40EFYEzl549IEHKQLV
 veH8i5xnnNuAhwGk+lURMzBDpowZbGamqZrn5D5f1KplxaPBMuqI1n3noeJ7bOM4
 HZQvzj7ctnMC0IG1mOM5wRvYMBWE1vpN7la/eX0q7dJUwZFrQ1gpRE3MzBmAFC3X
 BuFyIRezxlqfTysPpI55a7SYEt1JzHtMnUuzcKBuCStToPiBLiuGVfDN1GmcX5WD
 dTM9tFkeMuZP9GVRQRBKXujCh6rSaHltS+ZrFzqGHBGI5IiCzzzuJY8Ck67bdnfm
 uH9Jbf/xcFQnsHOBt77Q3OvaeFmug==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gjn9v1j36-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 15:12:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TywtolQIryd9d6Nf1BZb4wxwyEAunc3UYjz20zOtjPB3wcWuKpHEFJwnYPtT5Z20jLhu20sLN+xI4megnCMOqWCJDpyV6c6dlXsACRj7qJGMDnhpeVn2bQBLx23Wu2Xco4sfOdgg3d61zM/0jZKnr7Lzuvb0Q2TxGm2TW0N7VKAKZ9WhFDbyOWvMwZan1zH6y+RjTK10f4tifwdiFIHU2F+lYN2sEvdP3ZVK9VqdNrtXEOwP0oNrKC9Os8UF2tFKB38FZ2tBDrVs7FSI6/hauSc420Miz3XdzDt6rPIFvVikrIDHPyKsHepHOZV29R0KFNED+JJSOGBcLb2f+0wzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGlXuZJU6/oEpzUD6wL8prjcH4ymidZuFi1VmZ856Lc=;
 b=f1QGxL3KgX7TnSBBNkuAJNQDuqMSnYPDYZjdevmU0hRQd0GF9sq+z8kj4XKxM1jc+MCrOruBmdXu60dB5uNTPz+XqRpMIhVzaMCT05U2+zTt/gyvQtHp5Z9uhwQwfcCxLu/q8PaHUuvinhT3HquN5BqQhTrjgNqnE/Oj8Y1VGAe9r+k3t9YdzAZRQVltEYCRHpQubFYDLWZ6jLz9WPIbqX1PurWAHmcaD04eoQHPgudCxagJHjN+X7A5rXjo9iIHrgODtpbEy/0AL6NADl8MIzst+XWPD7sMNufhvwRLX3vjGkr4M1o8OQfhg+oXV7wn7Fec7VFVWpjCGjfc4F7pbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGlXuZJU6/oEpzUD6wL8prjcH4ymidZuFi1VmZ856Lc=;
 b=p8pwB/IlO0tUY70lqiXD44H/R1V6A+KrAhY4/6lQGCAB7TmjjBKBjZO85d1psyZQtAHC9qgA5QgLG9PSobKxsBhy3wVY4vkgD8rtaRJFhtxefGX+Jjy/NJgCBpXy6wRbVFFvGkV6C8MijatmMO3jyU+JRXIbhAEKNhDoYxl8f+0=
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by PH0PR10MB4533.namprd10.prod.outlook.com (2603:10b6:510:39::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:12:07 +0000
Received: from MWH0EPF000C6195.namprd02.prod.outlook.com
 (2603:10b6:303:82:cafe::5b) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MWH0EPF000C6195.mail.protection.outlook.com (10.167.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:12:05 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 15:11:46 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 15:11:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 15:11:46 -0500
Received: from hpz2.dhcp.ti.com (hpz2.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 688KBkfD3101205;
 Tue, 8 Sep 2026 15:11:46 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v2 1/1] mmc: core: Add power-off-delay-us support for slow RC
 discharge
Date: Tue, 8 Sep 2026 15:11:46 -0500
Message-ID: <20260908201146.532645-2-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908201146.532645-1-jm@ti.com>
References: <20260908201146.532645-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6195:EE_|PH0PR10MB4533:EE_
X-MS-Office365-Filtering-Correlation-Id: a121e6c1-bc80-41fe-25a4-08df0de57413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: pzQEEzrgv/iTxWZkHxDrTliJVUiAPM4XD8UdifdZzYRagvwDrXWJeFva+JW4ADspptT6lzua7oNfO1RKXDFCrjHbQt4RT4VV4BT147YNyM6d1Xc76bX082FuEa2hb6Lz2iU7KKj634+Y31nE7pC3OutfurKtxCSMIKOrImhnGaa0Z9tcpWC5sMoOh0sWzSIU0iroRAHw9Z1OP99Zih7lUjmk+EMU2Pgh7hHFHtv4A3RoIorcY8BRNnhfWYBxbzTwuAbzX6kfMZlHHM+nrMKfjLS5SHi88Y5jRUvF9K+NuIngHnVkgcZmZgHlp27eHvWD1fUbpNAuJbzVK6vqWxQvg3zgmYm5e1zPERdZQYTXtV+9eaoFPmYb+ZyzbsTYCKbPL1NfHFLE23lXbHtDgt5iV2oOyz3ddc0wafiPfMZEMx0OJUtz+vOw8BW0w6JeOysBWXmjQ1R0pS3R8HjesBAx+I5MOAUZTFSRevBhOosl9JPx63T5pXnwj/oAfSdkF5H+07nX+mfhfCTVLXXbLPy3AQd5kmvY4ZGss5cQMVFBxR9xFZ+EFVzw04/IZ2/qx0Y21RtJjp3V4ldWYVfK5263RHDT0WrDqEL3++4kValZfEwUtR7kxZVDxMc98KMz91TiMYu6LrhqD0CjGZHeiubnJlSp/TtSOS47jOqK4VF4ymbPyY/3diAoou/qWTPgNVd4uh2IlJeE9nCEjPhdh3Dt4g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QrGNBzeAlLgjy3NQ2rTiFgOpBVaN5BuVtPTrxmvhaFc9TQM8/akSeBz6bE95SdFxBjiTmr+u6sFjFI7qHz1p8RHWxzB/1LWi6z22oliWt8os0Qy/WJaJ9zpxKtj2ImDgploOMPYm4P+Ta0JfftArIFJ2WnjqE213HNlYbuM9B2pkFzefSmtGeYxJGlrrXDLBjGGebeV+SCnq4jhIhaSz7sfRtfCB2UKxtEfA2jbcIp6WVEsGP7uIfmL/zbL5oyA/FX6b79vKn+pBD8wN68XXiv4lKpHKMhFv0HeviMr3PP4+0wFUM++g8jcmY0Z7CkcK1tmbu4zcrXR4ILWoClOt0BGu8OaRVnYV5l1QhaHRxEV62wztNLLEx6Yh0UzykMG3fy0mrVFxEa3sCU9SYRcm0Abn/CdhF0OEnYrwD8lWqJoOWkvtz1/1QHZpC0uyYMIN
X-Exchange-RoutingPolicyChecked: 2o4O5mJTHVdKhjI1wxYc42Sqh5Gj14XijCTMWAxC/wQmBKQZ053o8e9KWQLa+bSbeemUDr5j1EsMZXRJHDPEk0PsQoe842C0zGppFw/81m1O28tNtmrTPM9To3VeHiKPp8rvII6xbrQzKUuGzCBXtxlWc47r8LiX1A6oJ6sFq4A9r/iAmgLMJz2Yma5pQu3mBF98IPsSvL3EKwg7e1GlMd/F97hlvoIrQdpgGyDfqjQLTffq545OI6WCG1gtX6sYSUQgKz68haMxl9p6onlSGTIBzrCCsG6B2rBfa5sXHoeAeynGrd5OM376NmuL31S/zuHzeeTAqpKLzLBsKlUNXQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:12:05.4628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a121e6c1-bc80-41fe-25a4-08df0de57413
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6195.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4533
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIyMCBTYWx0ZWRfXz4SWUVHGC1gY
 SJAMNm69xyY5/3fTPCGd4/ncrDlH173bXeYVrOhmESQ0kLvBHaapLj4p9I08IutGcu9QrZdZ8f9
 UldenK1WoE238zJ33urq+2pztPpFowY=
X-Proofpoint-ORIG-GUID: G7arGwp_mMJvPkP4zpTRNqd-u5Q_w05U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIyMCBTYWx0ZWRfX4iUqkoJVv/oS
 YSXxXsQtbOg9X3Aa6OZ4ObRqaja5KEgaoSKltgkGaiH/rD1NcBAeSdi9slxXRaObOeLCl614Ssx
 9aKmf0zdeZWyNGQh8ksvB8d8hHgmQGG9dNjl6j36tkQ/sXwcVuE1tYM1kBDuREgbQzPXnH8YDSg
 u/5huF6NgaUk2deHH3FMzsSPfN63B/L0Zy4B4W5Hzs2xK8c61XCt69mbbaJ8MgIynHqJjGq7Ca0
 hMIaxDgoa85BmYhS00xwm7fa/LxNDnCyS4U9yaeGZMFLGpTUEhachWf/pNS7Gs911hGSAIPx8gW
 FABoZHrQjWip+eWpRr4srsKorXMcQqnnmVJ40Q7gN+ML5IsyOAQcy/2p0QnXIW/urT8WcZIkGQU
 PdXo79rGA2ncvW1SUETNFwy44ajs0KlDPD7wbN+AZmWtc03HTAw8md9Q0aEDudUgXD+/idOkigh
 jlgbrKQh+fQzDMA4MQw==
X-Proofpoint-GUID: G7arGwp_mMJvPkP4zpTRNqd-u5Q_w05U
X-Authority-Analysis: v=2.4 cv=fvjsol4f c=1 sm=1 tr=0 ts=6aa06c25 cx=c_pps
 a=ReLZl+GdXdFt35wSL8r9Ug==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=GWDwzzfK0Y2hdcwNGMgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080220
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

Add support for power-off-delay-us property to allow additional delay
after mmc_power_off(). Boards with slow RC discharge on MMC VDD rails
can use this to fully discharge the card before power-on.

Default delay is 0 (no additional delay). Boards requiring longer
discharge can override via DT property power-off-delay-us in microseconds.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..4adcf424195 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2909,6 +2909,8 @@ static int mmc_power_on(struct mmc *mmc)
 
 static int mmc_power_off(struct mmc *mmc)
 {
+	u32 delay_us = 0;
+
 	mmc_set_clock(mmc, 0, MMC_CLK_DISABLE);
 #if CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(DM_REGULATOR)
 	if (mmc->vmmc_supply) {
@@ -2930,6 +2932,12 @@ static int mmc_power_off(struct mmc *mmc)
 			return ret;
 		}
 	}
+
+	if (mmc->dev)
+		dev_read_u32(mmc->dev, "power-off-delay-us", &delay_us);
+
+	if (delay_us)
+		udelay(delay_us);
 #endif
 	return 0;
 }
-- 
2.34.1

