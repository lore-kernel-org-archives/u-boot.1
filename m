Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CB10F6FBF
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 15:35:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D394684073;
	Wed,  1 Apr 2026 17:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="M++MspFR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F56384099; Wed,  1 Apr 2026 17:35:47 +0200 (CEST)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2006180517
 for <u-boot+nodisclaimer@lists.denx.de>; Wed,  1 Apr 2026 17:35:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yan.wang@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsy+uI1eRcH4UPDc8YaLKVXbp2ws1q6Vbzper3nX/3KQp4ewfdnZzsookyu3EHtZkpzM6n17/qAExREsslXtLseR8bKq3l5zhK6dtJxu8soyJCPdiYz7JDv/VMw1/kCAAwKLyMTtTWCAhoHmeQ1JCOllsiazBOUtAqfPxR0wu23JNlZ3X4grxh/Y5Ez4tABYc6EwRnPODSk5bLFWOfnt3b6bKEiu8xrIvlfcQhlgH6dD2+O/txI9i1boDbMIjTPW7m6+8S6V00ss3WX+ttBG3IXRSBDSTimHArxJYHSr2rFPIAvR9X22RBU2xkt9UZu1vMvAzbyUN6seBlfYtwTCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLCqgTlCEHI1/EoQ5b9n4H1odYvME1M1vF6FDuzdeFQ=;
 b=qswxFtb5jwoYrifU7Z7ZvwyE3kGqommIwDY+Rd2pHsx1EGUihYrbaLmoASsZwl01QFxBl9L88ijcGaFA8GwPCcMkuIw2KAEPoxjfPi29H2ehoLrWZB2uI/F2Zg0ltbAfbO7+cMF/op2u8m+WW2GWH7sU5/2nzUe/zSd0dNfgQH29cJZ1mKVrx/IvuCMYDATQr9C49MjWYe+eKXvjvRjGvrZgRdcUeODf2eNoSzzieqhmATi3CoS+0AXhEFSCjwFzBvcT+/jinyVWIdIgubA3+QxPeGXdcdym5kZMtjGd6pAMwQfysmg8T9I52em0h4jjmRCz0T0OrduCgDcPP27NYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLCqgTlCEHI1/EoQ5b9n4H1odYvME1M1vF6FDuzdeFQ=;
 b=M++MspFR9zBzApgJjeMMxKkT5NHBYMCZISqIOhBYCN0U4/uNIagHPSXL4C4j4PHfW2UaBlX7B+os8e+f4ZhBwpQ1L1QuKjLOvt2LiK37AebNFvlX70wWr8ZRip6vzsU4ussRMbZkytuOXwVGoJrFaqBou8KK4cKlfrxfZXdQZzPfefOI+SZYAouj57xRLUFtOvHmVwnG1fOKGsQdPTlFzqFv/I1hewg+l8Zr8+YKfMQa2p4mRrN+DUuCe556SWC38SyfcOKv9RY3nq4C7IBReldoEsiKudAf5qfVz1i8j8q4Xs/nAX21CiEp6HQ3JzGPKmQULLXOy02vu97yniEc/A==
Received: from PA7P264CA0234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:372::15)
 by MR0P264MB5562.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 1 Apr
 2026 15:35:41 +0000
Received: from PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372:cafe::30) by PA7P264CA0234.outlook.office365.com
 (2603:10a6:102:372::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 15:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BB.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Wed, 1 Apr 2026 15:35:41 +0000
Received: from sah1lpt719.softathome.com (unknown [192.168.72.213])
 by proxy.softathome.com (Postfix) with ESMTPSA id 7C2F01FFE9;
 Wed,  1 Apr 2026 17:35:41 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org,
 alpernebiyasak+nodisclaimer@gmail.com
Cc: philippe.reynes+nodisclaimer@softathome.com,
 paul.henrys_ext+nodisclaimer@softathome.com,
 yan.wang+nodisclaimer@softathome.com, u-boot+nodisclaimer@lists.denx.de,
 yan wang <yan.wang@softathome.com>
Subject: [PATCH 3/3] binman: etype: collection: Set build_done on the
 referenced entries
Date: Wed,  1 Apr 2026 17:35:25 +0200
Message-Id: <20260401153525.1541415-3-yan.wang@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260401153525.1541415-1-yan.wang@softathome.com>
References: <20260401153525.1541415-1-yan.wang@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BB:EE_|MR0P264MB5562:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c27d4253-fc3b-421f-2444-08de9004552f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: xW0ic3g2dsvBvwdDBvJuAPGueUw+1iL1ryFVXJ4Zc9stOgaJP4XccqlIwEjnoqqIjZHay1GiFT+O9Y6tAaMl+nBK4UzTgWr/V7iYvmMMnQKh6hrJRaxAQo8UTJtwo/PFsdu7TDhRJkEXcHe29yLcXX+cAia0nqxyztwX9TF6G1ty1zKucF9+vSk3fYdFKEW9KiDJPVK67g6ONSFBj43qgvfX7RxCx+Wvm4qRTBh4irYXrLpqrfgQqkEE70JyRwSZHBg0L1Ae4+seTYdO4Z8by0WYDr/e0PFfAzpUfllzzITEzLrRQ0ulYnDIkG3v2biq3F11zrwzxbDbhXqPSyZdU63DtpA6anoHHt4HVuN9wXhS7AGcq9wKWk9uw0J4X7i4qAsB10CWyYlYae/Yex8RLQuUvH3V8J3wGCJ90HIs8ocEcSwusKkaDlutgm6zi0qzccGACnYz+GZyzinyUlOmvnuh7QbZsxz7so8BSvLaH2XbbsOoXnLJfTr6WZQfTtSU9R2YHtJaCCnk8bhykA1os9l4VctZkgNNaj5UACmiyAZbEuoth5T5EjiqZe6brlbqX3jdR+GKj7HwZ4lrFQLdn1aOXox+IfmBGTeu8LuGqTdP+gFVVvh7K7bpJpn3PdL9cpJMxYPIO4b9VJwiU4+krg5xPQL9yfhD0jp20gHgNmucVjmWnYOmI2B6yTsKpHzYWnWAtEgG1ekev0TY3PoLMlpt5/AfVr+YzCooIqg6f+DOn24RndACNcQTcsVFGLhtvhSIl3PGMwHdtPmZkAldpg==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xsXuPSYhB+4Mk1o3VhfDnoSRE4z2tTc7qzBpoAqnHuByFTYC6dx3TWFZQHkVSSW14hBXdCJxyT2w7aLWntPj9EeZsg91NuMwLeFKuTdyamOkCswJmvqWlgCdHXPJ/+ygZnrKKHKsJdWe0zFXQaRrDIYljDhhOlHbvHJDEY3Yh2dmQsFUXYW+IDQpP75KjNU9IGXU1alNLjIm5bStB9GhkeakvCy/u70SLu0EqTobZzEN3UPeNVJSf/updKo5KwhVQg94pTV0tmf4mvka02tOq5MGDN0AJAeElKxZL0swH6uyT7qsiJHNV5+NgrRK/zZ8MNPlztOarJuS0HbJ4UjNsEx982KCECDv5vTlrJQcRdsqpu0zQ1L1Xvjsr92SN+kFGhzR96bzm9rQ2Jm4lgQIaLEDhkVDgwJcSCAk5KCeP9pqPXoE1l7l8K4F9AYnD1yD
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:35:41.6125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27d4253-fc3b-421f-2444-08de9004552f
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5562
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The collection etype uses phandles in the 'content' property to
reference other entries. Resolve each phandle to its Entry and mark
it with build_done to avoid rebuilding the same entry data multiple
times.

This is important for certain cases where rebuilding may change
the data content, e.g. due to timestamp or random IVs.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
 tools/binman/etype/collection.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
index c532aafe3e7..20e2640026f 100644
--- a/tools/binman/etype/collection.py
+++ b/tools/binman/etype/collection.py
@@ -51,6 +51,14 @@ class Entry_collection(Entry):
                 self.Info('Contents not available yet')
                 # Data not available yet
                 return None
+
+            # Mark referenced entries as build_done to avoid rebuilding
+            node = self.section._node.GetFdt().LookupPhandle(entry_phandle)
+            if node:
+                entry = self.section.FindEntryByNode(node)
+                if entry:
+                    entry.build_done = True
+
             data += entry_data
 
         self.Info('Returning contents size %x' % len(data))
-- 
2.25.1

