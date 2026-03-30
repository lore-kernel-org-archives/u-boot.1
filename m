Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2343C1061B0F
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3975183DBF;
	Mon, 30 Mar 2026 17:33:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="rrcx20BZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778F383F5B; Mon, 30 Mar 2026 16:19:06 +0200 (CEST)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B9383D17
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 30 Mar 2026 16:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rED9eaMyN9pJc4JEY2Js94kN5WPYrIyZXDZiWAFarBKzBj774sR9Q3nU+EXOP9nMgHBrlsDhJOJMxsUT2imDWZV9P2HToLyBJaT+7vsQmSev7jWrjez3xW5TV5gB93FM/qTLz0y6DNMzrwBjo9ayBfBOf7B0+AHxBoje4JwiacI3Yg0oIqnPvMFP9Gjki7fWb+39x66ulRWXYSNE4zmR2/DnUnTmrNJAx8r4XHnQzyRlsK1EQRnsSpI6mQS0jYyfqsZlI+GL4+9G7HHoa0ZOy/xjAQVhq8Q0pq4XQg7Z3t+6ma+foBPRKp/CrI8K5XsjPuHoDUTGGi4/7VOkZK3ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSOGyYgEs1nNRZcwTAwLr50Tk7Te2DezYeXotUqtXvk=;
 b=IVcTi5PwMswOxzqS1riOmpFd4sV/E8s1biHfLsxP3veq28s+egQyfTcnHYz9hqoeWszA1vSKpB1uh+E5ec653JvBKlbVytam3VkV+cuqwWvTT1HmShKAoN1QuEcs/KzU/m020Kie2ojVuI95oPunn4ZmNiWljgGDxgvOg7eKbpvyzDC9NB1PfVyH6kUYSfLhavuMzlBV0iKkblC1eB3GlzKddUX0W0BSxWtmGn7ZYdLFhX1laKtwtPYhTKarTmKfpMAyGWcc39UVyYCFe6GXFSFZnlV2QowpeKxCFxqZcrZqrNjw18vuSdwSRppkHDIKvmvDT69ACc+x0rI6ogO4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSOGyYgEs1nNRZcwTAwLr50Tk7Te2DezYeXotUqtXvk=;
 b=rrcx20BZEI1BtROSAXgy1NWcdixJUNh5wKE7larcFrnnUhHzTi890sTFK8u3f4bUJ9h+af5fNiFohfnq0Q7X++h9jVnefTKeZvCvEsQYnppxWgqNSmpUCj8me0v/t40NvpFexO5bELM58IIKut1YRKV/TJgcpgkmpoft+gVygy+9/x6s70d8vFibeo5v9QAdCA15G4uobmXgpdwx43dywKPZUfY5HVEJ9opVwDnA9z4q/X418ed4mJ+b92vmgzl9bJuLJ8M6SG9HBVTKLQp+W09arTkKjmCtO+HQYxtbVOOo0nAtMDITIk2esVhxO5Ep+95S55dv+WQaoYdFxr3d7A==
Received: from MR1P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:54::7) by
 PARP264MB5484.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Mon, 30 Mar 2026 14:18:59 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54:cafe::90) by MR1P264CA0146.outlook.office365.com
 (2603:10a6:501:54::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Mon, 30 Mar 2026 14:18:58 +0000
Received: from sah2lpt245.. (unknown [192.168.72.191])
 by proxy.softathome.com (Postfix) with ESMTPSA id 5F846200C2;
 Mon, 30 Mar 2026 16:18:58 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/1] tools: u_boot_pylib: disable standalone module detection
Date: Mon, 30 Mar 2026 16:18:52 +0200
Message-ID: <20260330141852.984717-2-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330141852.984717-1-paul.henrys_ext@softathome.com>
References: <20260330141852.984717-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PARP264MB5484:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e5e09d18-a77d-4a54-43e1-08de8e6748e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 6KLTZc+q7qU9NdGu4iVEVHogoMUMGHuS7kbzY0tWv37hfvIRJP3x7Z7WDCpAufU1nV19iczKEsVg92OyxIO0JELunsGEvGWpjtRAimbjFWl+NQADYywcN7ZkRqQGFwAfafvLeVPDCfk+2+KhTtVO5DJ0DlbpjlYMY+Hld7E1vaTBSMrQYvCEKl8gvMIcYK9hyEScVKCwkIK/ouN946NIr+4/Hqady+NElrlM7YhPCP5PKcupEooJxg1flXVeMXAzRul0+SPs8Tdseka7442IXbLmSM8eNciGKuGmea4GzWuJma5GuGjvO5Y8HCUHY9JTAMHqtb9fE8Qn6RnRDMgs83ZUhvm+jaqbC4o15SUmJseASiNGrDr08nuHyDlD/6HzsGD0/K7UOVkk7ONCusXJG8LFx5+l9i/iLuUM6gpHFR4BfpZVxWgf5v8pDDk473ImSghmYuONd3lzGH5YgNUoGkKpicnBQimyS3cB331U8yWD04x2sRy0msIr9o8bB7u7E7vuao4lRYzDelbpplnip6geuZHXFYv+ie/nahyoeh1TM6+uXVucKKyRT4x9jZH/oBrOuoefP9zfj3yJwuc1/d63MFfMpGT2BBCqXOPzVJaBonf8wP036v5RNX5NRO1B2aRTkq6qP4i1P18sUNMQD+6BazjwOfUTqnIn2IQNLy8rFuQbK6SGvdkTtm3ov1ybR1RfsP4IOCx2+Zmn+mUQ4Q==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SW2lyXbM8RJOkKacxSzgvmnVy3GeUdPUytmfaR7BAK+xBETPHg4vHjfnQarP/6bztlfr01yfFCuckvg0rafdN2gW1ac2Q/Eq7NYkM0qUiFQmW6sEBGbG77qrPm8xvu10OANRWzDfaza4l/xtXX4W9k0k1+q4KoxVbYR6GUDZXLP2+XPVxaDD3iZJjvcofbh+yEg92v/xPe1/wnDv1il8DzolS+WSe7n2hQBDcOTQd+Lg5xkQgWfN3eUmxfZGOO7HqXvxIX/84LvsynQUA9OP7kSvSCbcdy+Lp88G8WatBG18yDLqGp1D6/gTMB+hDM2xyg7MMnHjLSddL+0tSZ1rtl09Aay65Ez1sPkSMHxgzpCMnpRechaawjDXX+otzC5gocTMaLmNGYf2znkgW10e4LafNVoMWt5japFy9yoDHBoj4HLully2m2Fl8ka/V3nl
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:18:58.8016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e09d18-a77d-4a54-43e1-08de8e6748e1
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5484
X-Mailman-Approved-At: Mon, 30 Mar 2026 17:33:14 +0200
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

Do not try to detect standalone python modules at the top level, so setuptools
stops searching for: command, terminal, ... as independent modules and instead
relies on package discovery.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/u_boot_pylib/pyproject.toml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/u_boot_pylib/pyproject.toml b/tools/u_boot_pylib/pyproject.toml
index a860d134551..22b364583a0 100644
--- a/tools/u_boot_pylib/pyproject.toml
+++ b/tools/u_boot_pylib/pyproject.toml
@@ -21,5 +21,8 @@ classifiers = [
 "Homepage" = "https://docs.u-boot.org"
 "Bug Tracker" = "https://source.denx.de/groups/u-boot/-/issues"
 
+[tool.setuptools]
+py-modules = []
+
 [tool.setuptools.package-data]
 u_boot_pylib = ["*.rst"]
-- 
2.43.0

