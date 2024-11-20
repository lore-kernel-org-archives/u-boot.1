Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4DAD63920
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A540F89647;
	Wed, 20 Nov 2024 11:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="kanT8MF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A69C78964F; Wed, 20 Nov 2024 11:40:39 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B21CD895F2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXLsQCdRYNkOPBWB0uDgp2F7F/AQMPYNsbOCFc8NgkxRq6b+1AlqjPdZwG8iLptlPFvWqSBKVnkZHSxBX9Rdn0JhowWXU5fzXiN5YNGcYZulma8T55/6nKq6lYHRvVzq9fZCOAUfsbIzZhWA7dxjstPtRNmFGXidaki+uja3ZwMruNsKKNkN3DfXzssMwCzIvQ2vQm/89tXfxxOPcQg8mnYPQf3LpIcd4Ugy/HUu3B0NxEEyg4TrkkzHXksb6LSO/0Xqvf6JSPP5w5yenAAgHjm43X1EB5zAMDDVyXfEfZnwjXo/Ys3VCZPDY0itnTCD2GTXmUOP2cfOKQkVEj0hvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGd/DK6/BT0jN/EVo5R0IssPEfvkXDUn+y+aljdRiLA=;
 b=TUu/thDpcBaVtlL5bv5XQxbd0cbg9geR8WpghxMgPpcqi9OqxiSAU+lb/1Dof745F6CYdscIDXIvOi5he2sHjP1psN8gSV0qlRSupr5a+h6ECsnvwBxWjUMNpY3YBM9FG4FXxo+4tS5exb4rtOWXlhPu5tTuaaOcX3pz17IlkCvpE29VBjr+R3mvgqN/T0I7ZguofEtZmuSMAPj02UdSdZyyDjm0gDEOQIq7uL6ywYweZHcNHHJnys2MOSCl5+RcTCQtxgjZGJLFwpZnKBgktv4Q3dv7OunH2gZl/oSgcV6sQAyV/DACBkQy2cA3hTfdg/wSZU5cmt//OCEBjK6pBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGd/DK6/BT0jN/EVo5R0IssPEfvkXDUn+y+aljdRiLA=;
 b=kanT8MF3xfR72ehkmUd6qs0wu9B2Wk/d2Yp6sTMg/PQapoTnCliubYxOgNsd+qEDmT9WAPO7bEufjwaJdZM2X5D+V+PsAoc//KgYAuoSyuyqN/60RoIVKVT1f2gXh3sQfOsicwfbdQVDrG4mO04hqa+u2Vu9xrdBXB+6f0MW3PnZ/qBaAhgZHT7/MSg0Bc8dbMwaj1OlFeHL7WoOXwQmUIwtSslIvNY+K+NhIwbAbbL399cMunVZWR3Zqhjoal3yaufsrma3Qv44IoZqzQzuDbF63BPn08KlVxT1heQVX/CjSVwf53c19Jj8rqbZ35ZZTqjqAwiZKk/RaFCbOZShQQ==
Received: from MR2P264CA0048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::36) by
 PASP264MB5774.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:49a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Wed, 20 Nov 2024 10:40:36 +0000
Received: from MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:0:cafe::87) by MR2P264CA0048.outlook.office365.com
 (2603:10a6:500::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 10:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D57.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16
 via Frontend Transport; Wed, 20 Nov 2024 10:40:35 +0000
Received: from sah2lpt245.. (unknown [192.168.72.220])
 by proxy.softathome.com (Postfix) with ESMTPSA id 563672012E;
 Wed, 20 Nov 2024 11:40:35 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, paul.henrysd@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 1/1] tools: binman: etype: Allow to replace 'NAME' in node
 names
Date: Wed, 20 Nov 2024 11:40:29 +0100
Message-ID: <20241120104029.886860-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D57:EE_|PASP264MB5774:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4da590a5-96b2-4f5e-936e-08dd094fc468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r7iVHmN2ckbnAh3KCz2pTl6NP5rYZDdwynn6NXdqxe+fY1kT8gWbsXznRGoA?=
 =?us-ascii?Q?ycc/g2+HgHZNGQzdWA91w5pP5H50KSqZtRhr5wz9OVH/WhD5Cp26xTVvLuUW?=
 =?us-ascii?Q?eFs8e9HmQXItntn2uvSVwYsROUQhIY/pz90rebTpQJwiWlS6t6uU4wI23NYK?=
 =?us-ascii?Q?BxcVex2J3gNTScCy3EHX4vrDzyhaNt7qfqwsLavfiFOS79UsoUp3Eam5k9YE?=
 =?us-ascii?Q?m6y9MYGx3Vek/4SNL0dBSAlPwgUJgWPRS2kfHQR1nOjaSS61QdPntq69stZT?=
 =?us-ascii?Q?joM0qbz+YTs0mEAVl3dQFAtM0NfbI/4CWD299VpwA5HxfpDTtH2myJYULu8D?=
 =?us-ascii?Q?O66xj9r43ihdfTCXn9CNDHKCEmRccD3xlAjgmPT784vJ69v+GYH2oTRuJPm3?=
 =?us-ascii?Q?03iI7agIaPUm8pNi43BYlz6ntwBbnN7rhP4VBozJngiA5GT9V20qBYFh/Lxx?=
 =?us-ascii?Q?e0cqOtvQ8Sfh0mQtbAYmEf/6/lOznxm1eNBOtbotofJM1NVlnjGo8CqonyLV?=
 =?us-ascii?Q?dV5DO4XDyVo0F1+Qj3kcEWdZGGgsqKkjZqKaF4ZuejZGLGU2pvxp0JMtllcc?=
 =?us-ascii?Q?rDUkl5rRW+IwbrQnHELFCmH1tZI4YJoifnbk9vJhz7RxPPsvOZh7HJLLNH5C?=
 =?us-ascii?Q?zXaEnFJ/SU7uDocI9tsnwN24+6HDd3SxhsSvYXtfWONU08u5XjFVFk4gzbyF?=
 =?us-ascii?Q?74R1G40Pa4dHake2I+cWfpLCpS/DEcSNH0c6owiwKtrU0UVizPa3EE8b63dO?=
 =?us-ascii?Q?FkyKSKlITNtqmZm9e97Ut+BUe8olkd4oTIScZh+MZwJpb+72bz7VUJfG2T09?=
 =?us-ascii?Q?SN98ZIdbtjcaGq73xihfNV5F9gj1kWpnniFLk0MmtyZOutknPsUhqao0q/GV?=
 =?us-ascii?Q?IYSMecfBcUUP31Mnel6BddPIfVwCvSZmwYVrDc07wDtFqnKP9sxj9LAZw/dC?=
 =?us-ascii?Q?zYqoEsh3xQEppq/CVzIz2XkprrcYwQtbUwHNXJ/bt1SXJdjZenxWuICigRz1?=
 =?us-ascii?Q?V2H+qAZKv2WCcf4+9zica+B4R/wWm025j4yzTTo1hPeiMzqf1oi5z3fazbAB?=
 =?us-ascii?Q?Kq7FL9IGdZm0vIBPbqrzLyxO3mg/y62CV1QE3MvIyZtP1TGqQxUqEdF5qPoJ?=
 =?us-ascii?Q?I1oAH+sYbm6hA9AJZHGGkQ63G296vE+8Dn+HP2HTF45zeiCkFUA9ilgcOYWq?=
 =?us-ascii?Q?44+v58vqYQkq87vXpU1IbMP6EHy+J/7+El1GK0v7691rE8b5pmWkFVocy3w+?=
 =?us-ascii?Q?7l/lqnLUgaKEAT6HH3/Vv30ICnQt7jLFFgIxNQxniLlTTbA7DS2eX/s/fCWK?=
 =?us-ascii?Q?9PQ78maGGVQzvjSrOW1eq12omzGlbCq/Fy3fh6jdE4+lmMl0Do0x+AT5u+Ke?=
 =?us-ascii?Q?2HK6pXc/RzarODyqOx/YSOc528loq+tuztnUwhsWgmUC46fYCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:40:35.8107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da590a5-96b2-4f5e-936e-08dd094fc468
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D57.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5774
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

This change allows to replace both 'SEQ' and 'NAME' keywords by respectively a
sequence number and the name of the FDT to provide more flexibility in the node
name for the device trees included in the FIT.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/etype/fit.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index e0c1ac08d8..b9ebc3afd0 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -732,6 +732,7 @@ class Entry_fit(Entry_section):
                 # Generate nodes for each FDT
                 for seq, fdt_fname in enumerate(self._fdts):
                     node_name = node.name[1:].replace('SEQ', str(seq + 1))
+                    node_name = node_name.replace('NAME', fdt_fname)
                     if self._fdt_dir:
                         fname = os.path.join(self._fdt_dir, fdt_fname + '.dtb')
                     else:
-- 
2.43.0

