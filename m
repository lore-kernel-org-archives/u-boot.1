Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F109D58E78
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 07:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97B2783BC7;
	Mon,  2 Mar 2026 08:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OoWAOoFw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871DA83E63; Mon,  2 Mar 2026 08:43:49 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D434B8063E
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 08:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQV/DUYhqSknkRnKAlJKqi0HtKipG5HE8Qq5PMwJqpEVUVK1nMvqDocFmJp3kFgSn+jO1YWZnBcg4NEKLixBXBKrVqBsCRa0CLFXFK50XMD5FMxlYj4RZMuCQCnmlFUECXQYwiV5hqaPZ3ibbadqKLHGvFyJSMqSwMGdxyaNImfM1tD7akzUXlzaCWkyZhcouvQSGPhBK7hYffl64JXyNJ6G1UCl/SQ00bXY8NGfxGcH5kObKMJgSUzZYaW+HgKx9ZvObfiWy3D/kOn4sy1aeiK6Ia/Em4+UlaP920E9uiJsRmo9knstOaKsjXuMlk4Fex5J0sA6qJ+aY+ni1CEiSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJJP1ZlSffJX8XtiixVrsx88V4YH180smK/Ryt+IKWY=;
 b=Ks/4TDxuj0GUVZYs6VmJOQ+TX1YFZZdVTdu6c90w1NYwtv+km43vyJY5djBVXgUtGRJRbgRDVOtcaVvMXzyYMRHf/woZpBQGDyNo/jTUKJ3uuRkb4LI+qa4RFYoyLm/8ltIgpqoFRbo7ZfQcawV9u0kuHuB/02y3iYU3YA2D9ZRhm4IRBtdzerjam90Al1lIJGRnQM7cwFLDq5wxdQdTgimx9TjvirLEjsd8kBqneS0X/ZFGnG25a5KLw0Cjt6NxFWpbd1GOMz9pfdISp4Sfd5AmCWxAkQfM0GEAPiS0j6SUWYdIkcKm7yOYg7FZ/ZYXhj0i5i3USD73Tabx49FI/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJJP1ZlSffJX8XtiixVrsx88V4YH180smK/Ryt+IKWY=;
 b=OoWAOoFw3ZB9cSIsBxsC5wd98aGf19ipJzArz6y3zm/qCYZvNj5Z0ved8jVO6oFeoPemf1CmTFMg3j/E8eTnE1skNTRks0YPKecEZhabQK5Ro18KNr8IdDGsa1/JW8Lh3DG5W+NuujcNU5Fljm/1JVSapSDKbv43P73OhJXOhzg=
Received: from SA9PR13CA0134.namprd13.prod.outlook.com (2603:10b6:806:27::19)
 by CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:43:43 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::ad) by SA9PR13CA0134.outlook.office365.com
 (2603:10b6:806:27::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16 via Frontend Transport; Mon,
 2 Mar 2026 07:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 07:43:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 01:43:42 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 01:43:41 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 01:43:40 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Harini Katakam <harini.katakam@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Martin Kaistra <martin.kaistra@linutronix.de>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 0/3] net: zynq_gem: driver enhancement
Date: Mon, 2 Mar 2026 08:43:31 +0100
Message-ID: <cover.1772437409.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=3fsfPmiOvixR2yR19mGbALiTHIAvO4oJw1Lb4mBdoUs=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQutV/CFVDD4jwr2kb5lV2BpcOXzPakb8kHg9JT0t+eF
 GD23ZPdUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABPpMGT4pxhuKTJBQ6+KffX2
 3T+tPkT+EVvA35lj4/f7iYwU65kr9xj+yh0uKvj3++kfK4Gs7fN1+0qsuP2uXmY66PGX2/Bs0aP
 3zAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 67790d76-5e9b-4dba-eda3-08de782f6d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: XQZi6IJi3Af2sxlaem1iAJwPwdQ4MJ3IJmOQ6ZlJzQi8iOFwsRzK3bdvp+R7w+HuG2nX1UYcC793cnWiTaJEZ38C8UnjL+bcX6MmxJFeDZzgfIDa2AxYtHWG72mRuHlsSdSNTggLArWCw+x42yLjXbFarTptXKCBWasfTPvWHNaR7e/aI14rLVdMGlnEzmbGCJ0FuPUlYhafvkNEuv8D8b0UGHMzVFvEblpBJSYwmNA5pzLFGLksrzLkqTx/2HFOX6tZPZ2CBrJM2/AqJZ83PhTVcZBPjMqfS61q2+rmptZH174J2RAredIqwDyvI6oaaheSFcyccAH+Hlm+Dp8BlKHZ58qhdlPSscGrSIEiGzpCex8ZrYIEo06tNzYcOk+cbdggvowbFAOu+q8/luNelxLOj9iiNcgShPEw8WtLXs2+HBTFJUqHr5a9FpbjydqF4Zyadmji8NXtpahZLBtxa1JAvWQCcFzEvYFYYECErxeHBmfJPm8CqSa+xt48maBgAFeBn5hKGsgPiglsMpcrpkVgvWPkbBV6NAFfwh5qRmADtTE/Gi1I8dSPQz7FLOSYyHCS+pZ9Bpa7nqFQxH5Ux4VeEffulASCk957wRyvWGZZ556a6OKRlW2Ww1dPZRB1SrJyCg+wKBcLKcMJMDiyQANxD70z9fLP+p/IJ7IZiFY4LU1ZLYh1ul9Wu+X4iQomf0iCTLrcDM5Lz7pLxWoALpe79u1S7mzh9KXPC/xRsz17wmBCDli1978YsmteDTefZ4vi4eozHBKlZWXkpWnaWT6DDcwYxmGA60cgtQbagdSEfKJ/U/OkFLS5rEWns+GNhCkcEHYOyxk4OwP5PrV6lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u5thOj/ghVDkFtDhLrnP5fV6lM/2EuqV338TWLXFz4nN9PtVbrwun/97IEB0MwR1fkRl52oKcLLV7ydg0R3thuQZo04Z0szaZfUyNeZ0JUFN+gA9ONRDjIRCu7jRnImyIieigFi8nPttDLnyWYmVWfgjGS9aJntAyKlyPLTK59WGFpKGy/XGmmd/jQg2WNRdnsg0ntZ0pezX2Cg8gprT+dfizNSrsOOw1gI3beKBXja8BxoI8gebg3GXXP/e6CYbFMnEnMRtznCke/dsUREwKcHS0/u3GJPFscprSpGjXEiBavxXnTszIOmA37FzzYOP6UTlWtyz/Mfp7BeYKcVeeIYCeLdSMIXlcUAll9ri85JmBWK35fdJTnOwB/LPDDvnkwDVBwKopauHbR3vrdRnvL1ByuNbGjFOt34l0D+batMRk9gK2GP5wQ6SF814q6gD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:43:42.4382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67790d76-5e9b-4dba-eda3-08de782f6d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544
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

Hi,

on cache coherent system some operations are not working properly
hence these 3 patches.
Boardcast one is just optimization to ignore packets which are not for us.
TXSR is actual fix for coherent system.
dma-coherent flag handling is nice to have but don't expect any performance
improvement.

Thanks,
Michal


Michal Simek (2):
  net: zynq_gem: Disable broadcast packets
  net: zynq_gem: Add support for dma-coherent flag

Padmarao Begari (1):
  net: zynq_gem: clear TXSR transfer complete

 drivers/net/zynq_gem.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

-- 
2.43.0

base-commit: 1f3f1426a8ad7123de58103913eea84c84ce08bf
branch: debian-sent3
