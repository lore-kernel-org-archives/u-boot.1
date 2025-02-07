Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D01C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 06:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78C56801DE;
	Fri,  7 Feb 2025 07:51:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="lbCTArja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 346EA80207; Fri,  7 Feb 2025 07:51:50 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B22F801BE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 07:51:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPinjz3Cs9uHmj636+DdFVvk1skItuDoA5+lCURvR6l363wcoUC0z+2+Pp0KsgO80FWsoXh+CnQV/8Zn/KbrzstvUIG9JyStue4P58FDRJ9Wx/i2IYsrTTl2nsSwuzwz5UgA2ALzY92bo/L/fIw3JxDQYUsasfhIakptmCQVGjygY5gll85VK2CrkQwug+ULFbnIT+48Zegt2k/kN6OqRnwdB0IaAmgdrw1xEOiIW2QDJkfZGdv4i9IOAOT3fSDPcCKpllvuSpmDeYWzh4Oc1RxJSAIjh+tj1oKmAWdnki51te9Z1gVOHF+bpZYTx3pyX0tdgnt+b429Lxrabu1E8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThW0BLGzhliC6Hu58ZBXhzDv+tr/RaOtvhFWPb7tqsg=;
 b=udjG4La8fv9IRmyoorSxTCeO6qVnqRO+FXm2VFpccEyxuCVXPg7gcK2zx3EtSxs0Yh6s6reqUaLFRrE53rR3ghYUPJ/WzadXJHsaHEgRIo/hJII14+QEVOSOnv2Co9ez2i3KhMEU53MpZspztLCjTb7s0RhAmGl+u5mUR388rnCPgLsQdaHN6yiMJY81X3wt/nKix9Nv6lRc5P7WU6YVmERQHLBAz/zGe6rCiqLXxk7lHi7K9mm6ICBEPlIA7jZYx9ntqWxLz8fTHCcQCeIWkEnoxniHijdF+61It60DFy1IXdMPjN0wv1xDOoJYOqS7rnC04mXaKX0skhFYBzDuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThW0BLGzhliC6Hu58ZBXhzDv+tr/RaOtvhFWPb7tqsg=;
 b=lbCTArjausNv7BvF93kgVq8KvE42vJvKbnOx569BkXWl0Rx3CQ/X50JbqatXgzfqhMglGB4Df+Fh1DK2nxGUqiJ/hKIMB3sSMN2VCj/KQucOj5zUGQ2LpEAUv1bAe5xpWoiJ7c6pNuBTHlW3FNz/87cVA3WovVuIqtxyXx9xWDK8XWQWA0EJh5N6gDvS21Xphq1Xy6MFgod2zkrOXn+PzZryGWvHUErF7lUqj+zO1hWvY4GYU1NwQ1prqDdiQZQNJsMz1/JyKXO6XkmA/o+tlh7VKvE313JR5n36C+wiATIehVlkxyxIsH6OvFhX3QRCUjTylR5lu+TmznthyPcrhg==
Received: from PA7P264CA0388.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:399::25)
 by AS4P195MB1813.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:51c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 7 Feb
 2025 06:51:45 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:102:399:cafe::1b) by PA7P264CA0388.outlook.office365.com
 (2603:10a6:102:399::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 06:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 06:51:45 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:44 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 7 Feb
 2025 07:51:42 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, <d-gole@ti.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 0/4] phyCORE-AM62x/AM64x: Sign Images with External Keys
Date: Thu, 6 Feb 2025 22:51:18 -0800
Message-ID: <20250207065122.2495923-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AS4P195MB1813:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b27a4c5-c47d-4018-5df1-08dd4743e2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Jpk1J9VooeInrM5xU2oJLFYxS6jUvFUKq/J0zj0tmPVSJrAuJ1MsLr6vTO/?=
 =?us-ascii?Q?ituwiTRkTIZM7r/XPZuDca/rwn9qngHsHQuOXMEVyF3crVVMLbhUYDLhFHXe?=
 =?us-ascii?Q?eMeuTpVSOqaSHPI83CTpEFGCYeHdKqgoQV7QpTbsAZpDAdd1QvKlkI4jqTyd?=
 =?us-ascii?Q?wyYFXvtc9+qUcmhExlm1g8qX/GELMMe3IFgnC6I7nNJmTgmMci9EaLNfeaXb?=
 =?us-ascii?Q?Azp8gR3fzDwP73fM8EhqduNjS2yAkhHU681BPcZ26xJIpCES5idkA3PGQFN2?=
 =?us-ascii?Q?2AH7uSHSVubqkxUP6YQmh3Ez1jiOgY1IIOoNKU1qq/S3W9DfutxWhQqZP2zd?=
 =?us-ascii?Q?ul6bGTmHICumMXJmB2OKC7DLwtblrUun/lCwLVzyb/+i+dd4O8nDEOEAkv8Q?=
 =?us-ascii?Q?Cgg0ucVqG5sBBiRhEKn5xgqCxVogvm9P56cqC3zajdyBkjTZlt/rLqe95Ea/?=
 =?us-ascii?Q?ynode5yjIMxcAx8Hq+VMzT8WVcIQaG/6bGCYXXiTqawQ64wgI+kUOhvh6usu?=
 =?us-ascii?Q?hnNvhib+3e+A1spj1waqfYiz+RvgV6T//hdodA3WD5GdjW0nNRLMUHrPPojy?=
 =?us-ascii?Q?rhjxFhhdp7Zve2r+jgK8olm4eY6fqBPZNBc95LMi3AKlXqx/ffUo+9WVYr2I?=
 =?us-ascii?Q?Xapl4Me4ngitfgUvRK+I16tDndMBQjSGzVfyt+BXDCnXT9D3BPUiCx4fTyDW?=
 =?us-ascii?Q?fTH2wg7AYRsm2pZJKVnvmU6+SSxdPlMzPyExkYkBz0rH5gpkhbtZJ8r8l5LK?=
 =?us-ascii?Q?maFom82raZYmXvrkOmOhMbtlh5TluMAkLS5CXWiQ72qicDqqkgXSnBsPsHIv?=
 =?us-ascii?Q?k1qRjMMsKiBzK94dV5c5AdYiybxcRMt3IYM+Wgx3R5jgXlieLFieQNOoW0p7?=
 =?us-ascii?Q?iA3ZMNCy1GUqfe2vSfT4T4iO7gM1a+gYIQDRPGA+KRG1Ljnxz1Z0UwxHXjvf?=
 =?us-ascii?Q?LAwd5nxoFPWZNgUhAGXHsWxjq3IdHafAq4JQH5VGrAW4zNmr6WHt1k/4iNaT?=
 =?us-ascii?Q?DSbYmPuILSI9Q+NCIn2CX59ZUQ7px3r7FH17CpS3nbjtaI94UTH+SjdKJ1vk?=
 =?us-ascii?Q?xXu6J0/s466Znfdumd40bIte4kLnR2xCntHxwqGiWzhGX3HwGGu6WmoKJBA8?=
 =?us-ascii?Q?HSsULoAOzzUle+IQRO2AZMJzRAk1x/Q3zRyBNo79cjsmuXb0ch1k/y5TZ+QU?=
 =?us-ascii?Q?ke3uMEQ5yz1yNgquAYkwtJ2A7fvaqxpWcjbZweILUKw+TOqmLtEXpRH+T4gp?=
 =?us-ascii?Q?jHwCKNUq+LrWou56mwUKYi9UlgqdhKN1aiB29TqJ2F6GPisznz/m4P18Wr1G?=
 =?us-ascii?Q?VwF/LE02UzF2WAEmlDeYgkRKL8XAeLwu2pcT5eyo+ua4yiL54dNFNIaZbV9M?=
 =?us-ascii?Q?nbtDZHP0QGJXnNL4WCGd8SM5rZGBgzLQxt0otIe2l1C1MdCcHgAi66YDBQl7?=
 =?us-ascii?Q?XKi+I0MJjizVBHqTOK6JcW++46CC+i1DrD1Lf4v/ekbYOPnugIa1U+jPDJns?=
 =?us-ascii?Q?GhOF00gToGmCgyw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 06:51:45.2015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b27a4c5-c47d-4018-5df1-08dd4743e2f1
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1813
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

This patch series adds three new Kconfigs for PHYTEC's K3 boards to
pass private keys from an external location. These keys are
required to sign all bootloader images and device-trees to boot on
High-Secure Secure-Enforced (HS-SE) hardware.


Daniel Schultz (2):
  board: phytec: common: k3: Introduce Configs to Sign Images
  board: Phytec: phycore_am6*: Add k3 Kconfig to A53

Nathan Morrisson (2):
  arch: arm: dts: k3-am625-phycore-som-binman: Add custMpk and
    ti-degenerate keys with CONFIG entries
  arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk and
    ti-degenerate keys with CONFIG entries

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 72 ++++++++++++++-----
 arch/arm/dts/k3-am642-phycore-som-binman.dtsi | 70 ++++++++++++++----
 board/phytec/common/k3/Kconfig                | 34 +++++++++
 board/phytec/phycore_am62ax/Kconfig           |  1 +
 board/phytec/phycore_am62x/Kconfig            |  1 +
 board/phytec/phycore_am64x/Kconfig            |  2 +
 6 files changed, 149 insertions(+), 31 deletions(-)

-- 
2.25.1

