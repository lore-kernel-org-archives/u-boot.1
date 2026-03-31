Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDB9FF60D9
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 08:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E1184020;
	Tue, 31 Mar 2026 10:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="vGCfbgvp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470288408D; Tue, 31 Mar 2026 10:06:55 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC1184020
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 31 Mar 2026 10:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgJKeg8IkE5B1K+7KghWy52LYXiBYGmmJcfoUsLFTyhSzJXfcPUZgmxtsavbNt11sABwkeYo3YRYFNxe4n0fyB3uMD7BbRkBLOVc6wmdkVzahkWDNVpN5J4pWLOP0i6kDvph2GT3B7h7XImb7UoE2G6IHtS5nndIZdmYnsOR49RXdWNHndKFgoj5OiR6JxIzny43yxtJPlKckUQG0B6UZhhmYTehNyGZ8calaUvZuABnkbW0ZIJHn4EY6YeF8vJwE1bMaGveGJnNXEOyzr2ATSnUbkFsBgr9ZD0uOY3qH80bgLQNBddg+OGClIQvXJVtc6jOpS9mQYERQnxb0Fw/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbSg09GIgTsGWF+cMXt7lEUpxp/ifoNm07w6RJKI/f4=;
 b=NZjoorE9Z/6DRAq8hOAwPXrIVUj0sAgkzSlmTmeV08ii0Y5tz0YpIKAjJVCKryA3zGwI+YB3r/QRD0w+CkD6WsqYb8mzTc0QCCnyhibp08LK4gvt4ZUbhSbiB2um6iMmhTIaU5Y5a8oewyK9qRbd4Kdt4G0ahg8BpBC72eYLWdYYQJ/1TvUdK7WAJEPlXS0GnfEs3Cf3X8+2zu0JXiLQVXUmhGUebGbOuiKr8qVYapLhPnuk9WQNltrSHfXhqjMI3J0kpNXCcM5NXuAKRMTnUn+ghZlWe+ez29fea7fCrLUbM3F5qCEF2VNFVixmDukliGqkeUqRnf1bu3uNJFAMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbSg09GIgTsGWF+cMXt7lEUpxp/ifoNm07w6RJKI/f4=;
 b=vGCfbgvpjauyrE8b44MTlAuMh/neI4O1IyGCwbQQ+K1iNAliL4f7lQgHS/Wg63DiqhFUG/h0xt7+U2lLzzzcw+zxTYdNmdVTRZIfWwRu73sp7t3pljR4ScFxyUFtWvPd242FpZmX+NAGiQld2SMmdX6HUMPYI4G8FJwdLJl5fTzkQfvWqCRyiR8SZbA93zil2E/BzB6MX7vN0hPrFysNC4Fb8NR8Ajzsr8v0D6lFSZGPh2xO3eD3blFW6DGt176b3xb40QEWhdXB7VRmNEGylxxCe0hPUC9W+K2aZYxnAVy+s6eSNP5JD7brb0h+YgCzPfm4ekYa0ESB4pXwD2mXbw==
Received: from PR1P264CA0113.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cd::14)
 by PARP264MB4633.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:42e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:06:47 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd:cafe::24) by PR1P264CA0113.outlook.office365.com
 (2603:10a6:102:2cd::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 08:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.21
 via Frontend Transport; Tue, 31 Mar 2026 08:06:47 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 250E0201BB;
 Tue, 31 Mar 2026 10:06:47 +0200 (CEST)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot+nodisclaimer@lists.denx.de
Cc: sjg+nodisclaimer@chromium.org, Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 0/1] tools: u_boot_pylib: ensure all Python modules are
 installed
Date: Tue, 31 Mar 2026 10:06:35 +0200
Message-ID: <20260331080636.380507-1-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|PARP264MB4633:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45790cbf-363a-4421-5efb-08de8efc74c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ta180o2O7til/Aci68/MzYkdeICU+LFaQu6X2vgAh8YZ0GRLygAJ4w0rsqgrsAIgSFSAqdxoQE4hz/8C/XE5nGcMf0tK8KcQLfdluK8bf3QM5nZC1YmwPx+uhzcNWE71nINLTCiWpWjnRE+7QbIhiKBvnZXmuojDe5GNa4Or7QrL32RjXURrZxqSS42Va7RSQWtjT37yCoIuj/A9A4uEy5ZqW6r28yrddo9TD2HA7RyPglUILTix0x/Udnac1qo6gk2rJCoUM6M7sbl+0yYuofW5CvXBIWsAFGxxmxOxg0WeuQqjnL20np3sOyjeRiNeIyg8a2BZ5Y2qs4trLd0am1XllY5FMGyn0VpIyTM3UnTClNlb/ff7nLRqeMb2X/typ2fXWEZ6UktYGi3fCJ2XWHTltG6vuP4JVNarD3nzirVdClbK/5ZQXkaCeKFVNy0yKsNCYcQ+Lyc4D1y6XHxyzqehrM4GLWoFYjbYJZ9a1Zd9EBc37+E/uPaHHNSI8s+odrEeKtsCb3AJh2FCCSMXcsYJ+zvI85B9rHeMI5k/t/zuq4BzBTNERcPk9hxq0o3AnBSSPXYullgG04HuPd0ZriDNKgv95d/yQd3F0LSRsme8uN2lEED7IgUR9WxEYQw3+7IeizMhr1KMVfI3XE11x7TicvKSWwlRnNpg1wu5DPSsrfaF6IqpwlbGDq0Ia2EYigO+2GbomursyuSpYGqmX+wqXgKk6frr1LXLQH8O/W0=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4t8ykmgfIYClXIgi0v18rz9F/SSseLDReYpkHNg2d9J/skSbK8SNNh2fcVlnJx/Lbfb/HuB2qB2ZYLJWGoSDrdUapEvC/9WxGzLhqOdpinTohORSBMPx1iMRx3dGgBrV4rI9KMllkkCkSGhNkHGab/MSnRaJlA5n7frtsJh8jcO/8VW3fsyIoYGs47oKT7hjKYSTH1GSsHkSLqop5HNFcj33zCJ8fR4ExcSHSSwERfyvEjzTJJwVLU8kY3meLuhYXcUGNFAIS/mnpTjEcXUVKvpXyITmxCkjrno/APcGXpGGagn9872gb2yxG6nJ6GUD+MBBqRlC56ok2i8q3TdrKNPLnY51Uhks2H5oPkhf3qpN+e11gdtIFS1UJ6/u1viP4njIrjuvNFwuM/iysBbOREcIMfvGnUISJ5oDdpSSEDkwSaozLFaz67C0mf7mHKhV
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:06:47.4469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45790cbf-363a-4421-5efb-08de8efc74c2
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB4633
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

Add setuptools package configuration to pyproject.toml so that
u_boot_pylib is installed as a proper Python package without changing
the existing flat directory structure and making sure all modules are
installed.

Step to reproduce the issue without the patch:
git clone https://source.denx.de/u-boot/u-boot.git
cd u-boot
python3 -m venv myenv
source myenv/bin/activate
pip3 install tools/u_boot_pylib/
...
error: Multiple top-level modules discovered in a flat-layout: ['command', 'terminal', 'test_util', 'tout', 'cros_subprocess', 'tools', 'gitutil'].

Paul HENRYS:
  tools: u_boot_pylib: ensure all Python modules are installed

 tools/u_boot_pylib/pyproject.toml | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.43.0

