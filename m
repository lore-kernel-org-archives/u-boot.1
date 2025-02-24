Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466B0C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 21:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE2C80EC0;
	Mon, 24 Feb 2025 22:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="K/dDG1UR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE0280FD6; Mon, 24 Feb 2025 22:21:16 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D87F80F53
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 22:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y09NSN7sNhb6V3Vukk2cCiiEBiwfAa74Ojsqvmcnwvw29FB1VRB+wHGJRIyEnxM0fyax/SGsvOYc1SaF7rrV6HnZxoEA4eP9BZ/DaLNSMr4V8QLeDgk0DldwwkJil5KE84WU2rev3b2KOV6Jg/e5/AEgMD9gwx/pPZYRLjkS1+vSh52wP82UDvXCIbxYXaLaovhNRD7i5ZgRj0Vs6zc3gDFB9bb/VR4EaVK2RIwBwk86qEmyOScPuQay1ec6Bl4ABspx/b/VeeXAo9E5G2rDYVjdOWH5CTWGw4RofmAUxV0LzVe75Rtr1VnBiQbDgyRBwIEsQhRSyBTpbW+XbBRGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aChP0gOubdt3woYUIVcBkx6hWgX7+EKmf6e7cpUzcBo=;
 b=YlVaSLQ4NpKcVKa3VxeM1zLNTFwMJdF9oJUVtLisLKrIEp+YzQj//5JMDr8+nrFaDRTNQNFVV5OSP7Q5hGYaP1SNunVxSxQzIccqTRuofpQD6dS+TNOLgZPZC3Jbjk7duGy1L5oVl0uTV2ANG4UnmF76VS/IZkKHo7z2HvYGMbvnG+1kW9ucYemnQOHPmcV9zu7Hd8bHV0jStXxUnLduQjPicPk49Zqac74RyTQQNG+72OgNSeN6jE5yJWHcGzor1lQ6nejhZeVckJ5NyyViAXIwJJ5+S4NOATpthcTqNyHQ3vF/osAEqBjWGBHd2/mRvFvJMtCyBzAuXtVUXETNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChP0gOubdt3woYUIVcBkx6hWgX7+EKmf6e7cpUzcBo=;
 b=K/dDG1URm38URpaT/SNy2+WyDnBJAoA5W4w2XkkS54mnLF0Kw/YX8UONkUFliiWV6AI9W9SAlJ2hbQiHEV8rUsFANK8e9pJhbKk72mU7fbuSrL1zuiWvo+amWMYoBXBSMkYuqwb7EUozERV807siV+2kd/01bhxC0bKRpiB9WEk8xrMAaN/FWSraeYdWmDbRclhHkTaX6OeU6Mzufqip9haikh9Wyb3Pho1NfTbCtaSEWyps3aaekNAVKOmXLqcikgjCeumQVffbjkzZqEGBS7lR2CW6s8+KTxDJDy3Xg4svttMk9fpaAZVBNdNSITESkFgq4zLUMfL5Wlg7n/jBqg==
Received: from AS4P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5d6::12)
 by PR0P264MB1978.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Mon, 24 Feb
 2025 21:21:11 +0000
Received: from PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6:cafe::50) by AS4P195CA0026.outlook.office365.com
 (2603:10a6:20b:5d6::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Mon,
 24 Feb 2025 21:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019232.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.16
 via Frontend Transport; Mon, 24 Feb 2025 21:21:11 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 6133520183;
 Mon, 24 Feb 2025 22:21:10 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, paul.henrysd+nodisclaimer@gmail.com,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH v2 5/6] configs: Enable the pre-load signature in
 tools-only_defconfig
Date: Mon, 24 Feb 2025 22:20:54 +0100
Message-ID: <20250224212055.2992852-5-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
References: <20250224212055.2992852-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019232:EE_|PR0P264MB1978:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8749f285-02ee-4b6f-f16c-08dd5519296a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M7OEEHv6UcLVn1Aip808sGPmM/Woef88xIuiAC19wcRLlwqkEBD0Wtx7JmdU?=
 =?us-ascii?Q?HvpYp9iUNl0HSwdoKKh8RqGxzp9+itBqMUFAJWuXU8CsTELOO7zePFr5W3rG?=
 =?us-ascii?Q?icvkzY1g8GUpxihs6bbQPzdQp7CdCNoHxAU39sEC/lsoFskhcx+yO2PTuJW3?=
 =?us-ascii?Q?kvDHdRTDGcjIhKH4qVlxX8D9n2GH5+Mvk17LgUjatdbUJskGrkvqL7iCxk86?=
 =?us-ascii?Q?M2uPpNyrM3exdehf+71EKxuwSBqTkAft0IDQ86u9GnJwUYHeN8Bte1LaITxn?=
 =?us-ascii?Q?9cg2N9UfGT/Qi8iO85bsVVd0NWMuVFSdKxEjif++9cJKF6cE5C2kQ5QRZInU?=
 =?us-ascii?Q?67BL63wsHGxFN9lvV8tMhR0KulGwOGh7ZztJiBw69cny0O03J7njbvNnyUg+?=
 =?us-ascii?Q?ynClS4WJ4IzQPU7BtVG6yoBQzuVJ7mIDh9/20H9mhdYO/ec2BA1xbIDemQM5?=
 =?us-ascii?Q?I3kibNY8QnjnBmyIbkJl5Q7GANnUafIDzky3UyL7tJF33TIf3IR8vBAmwG+r?=
 =?us-ascii?Q?bNJQZNBwCG9mRDQ7dXWwynAaufNSONK/f0JIEj/lCptRgKTNnbWUpA8i1uv9?=
 =?us-ascii?Q?k+H4abXDs9kpUTt/lVrQyINKyjTeMwT2vMq5F8Yfn27Y85CxqAPZvXOZ9q+E?=
 =?us-ascii?Q?93LudzPuBIzjnf2+QhxoSUQnjx4i5Gx/WLwfg6vVSBOUCtL4psmSsy/pghAI?=
 =?us-ascii?Q?bTFc45+pjUELvPaDMFVpbcKNUs6V1bfjwFQC9tZH3GF+nMWxkCyK2RC+YcWz?=
 =?us-ascii?Q?grGCcZpcau6nxCLycWvMGTx59+/3lC8DytrYCuyErj7SNnDXmh9z7AqvIz5s?=
 =?us-ascii?Q?ml5Nw8+5bwOUF2+KupsklFvyNfDvXtRi558jw2DQnH2/q6SifU1aRBdq7o/P?=
 =?us-ascii?Q?9/kqE/IBOIJmeR3hGXMSOdF9dC9yqiOZ5dWYIbxaHu8c6T8vctsFq+yJRYpo?=
 =?us-ascii?Q?Or3PeOJgInr1T0pwCx3wqLmQmKsjLlcvLgueqhuqDnpx0VUIvnEgcEhvzoUJ?=
 =?us-ascii?Q?kGHSVXC3LawDSHzSrE3qQBVN4fNebygXR34yHAhBr0UM26L52HP2N4d/zrnJ?=
 =?us-ascii?Q?/6+Pm2O5UEMoUCZJKwDW2SdKnghIIiHhpzQdG85TvwT0lZo8ASIRDb+6NNCc?=
 =?us-ascii?Q?RAUkxUF3wP6DYwC3SSYSuLZSDIYG4GOW0LTDA6nrRVxnvQRYz8ckozH8GHOe?=
 =?us-ascii?Q?olvPNwmElmS4wHihtTgtb2XKC36bGtCOkkMB8zmLdqQJj8YmLUy2A2zC1FHf?=
 =?us-ascii?Q?izcqs/bTGHKynfcI2VGMCa+DIiIl1DF7PzP4GXe4HrJaX0Wf/FVpkl4pLuEP?=
 =?us-ascii?Q?sGeT4Ee/YR0V85IvIHOvR388x5R5Too0Yvt8n3fV9oiBlBdeNDpB1+KeX2Q3?=
 =?us-ascii?Q?nsD1iO0nJ32yeuj6HDCujNiVfK5rEyDJn5gO6LgTY+BSMDqG/HUoVNlXiSgu?=
 =?us-ascii?Q?3UiKmOPohfYQH8dEI77kwAUlK5wG9QVVVWN0fSZT7N5WtvAaBnPoDN35Cpsi?=
 =?us-ascii?Q?1SaJ0CaFDoqyaEk=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 21:21:11.3427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8749f285-02ee-4b6f-f16c-08dd5519296a
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019232.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1978
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

pre-load related config options are enabled to have support of it in host
tools.

'CONFIG_FIT_SIGNATURE=y' is being automatically removed since it is
selected by CONFIG_IMAGE_PRE_LOAD_SIG.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 configs/tools-only_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
index cecd26175d1..e64bb768440 100644
--- a/configs/tools-only_defconfig
+++ b/configs/tools-only_defconfig
@@ -9,10 +9,11 @@ CONFIG_EFI_LOADER=n
 CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_TIMESTAMP=y
 CONFIG_FIT=y
-CONFIG_FIT_SIGNATURE=y
 CONFIG_BOOTSTD_FULL=n
 CONFIG_BOOTMETH_CROS=n
 CONFIG_BOOTMETH_VBE=n
+CONFIG_IMAGE_PRE_LOAD=y
+CONFIG_IMAGE_PRE_LOAD_SIG=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run distro_bootcmd"
 CONFIG_CMD_BOOTD=n
-- 
2.43.0

