Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265ECC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 14:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB82888064;
	Wed, 27 Mar 2024 15:15:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LWsS4dDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F9DF88064; Wed, 27 Mar 2024 15:15:05 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891E288019
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 15:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOINPyuzqk4ApPy2SOSfEF1qgJEicWxb7A+r9XVCQ775NIzk8S5VmRoob/d+/QLDHLc3v+4BsnwPXhMC/6/MX2fdOiD2aMFtPixzjL+p7V9rnoE1K/3yIsUQ2jZ5/yYMKJm26eDqP1b5ihP4I2u2l3gbWGkana5yzGonKJwacI5+pxgaYH4OiQ46TOi3rph5R7CDw/lg9W1SIk1tB3Hqc7D9qvV3nBCCfkl3plyY8lV5ji1Q2HnDUWP5w2phqoTrMQ9SlzwzLBB+ewMqbSLAH9kEBvY6UTs7DgIGfirSydga6WamRGyhBJtx15zhy+/0yF6P6MmGVIO7lmxWl/OoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ldHmxId7SdpJzWWbgj6VjSBg/GRTzHjvychV7hJvbI=;
 b=ga/wJRhGRx9qN8jx8PNPysPxufRBhcKc7oTFlf/NU/dpAbOi16iDeqyEdAIe0K5myentFLTA9Ql32TJlAug794CRj4jyFgOsXWTNRw3il/UduIZvr3VCS/o9gpmiZPqD69Ln5A7ohijueEcKt0iqwbImkQSX7UsTHOPD6WvP5rhFGiN08NimLGvJ5i9tJmqxsC+Z4HBVzkjtlE0O1nDzUjQk07TBKoTigommAml/FYXG0bAoTCj5BooWbIbe3fFxMzUzBm1dMvQD+9WfRrYDSOCh4rsVl2/WFSmpvkMhdkp6c8dEdy9gwURFRP0MWse8amYvGCSP0t0xTNSzuIVxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ldHmxId7SdpJzWWbgj6VjSBg/GRTzHjvychV7hJvbI=;
 b=LWsS4dDG7vkKl2LO4inLbBHtWBL7c8fxSrGu+BoEuz+TmgWeYbCoyP6Ey9rfFrS+dRTDKSUUpQy3EfwJiSK8JRj2CNKozS3TqSy13wHUTnElNU6OIw16JjKw0bjDe1sj3noHJxejuNOAhS/BUZwNSjHT5UwCVHShc0SA9lXQRsY=
Received: from MN2PR17CA0025.namprd17.prod.outlook.com (2603:10b6:208:15e::38)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 14:14:58 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:15e:cafe::9d) by MN2PR17CA0025.outlook.office365.com
 (2603:10b6:208:15e::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 14:14:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 14:14:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 09:14:56 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/4] zlib: Address CVE-2016-9841
Date: Wed, 27 Mar 2024 15:14:49 +0100
Message-ID: <cover.1711548887.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1086; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OvCVTMjpZkKFFL3FPdu8KwJLnSIEnAXZg5DLRKwlJSE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjQWzVs/F+7557hS4Fu6TuGDQBa1k2YcJY6Xq5UMzd8EB
 7DY1Lh1xLIwCDIxyIopskjbXDmzt3LGFOGLh+Vg5rAygQxh4OIUgInMrGWYZy/f9ERFf77zgTvH
 n5qZbg2ts4grZphf/GBdwaS1zO35Oqv6VKPvJv7Om10DAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aecddf5-683b-479f-551d-08dc4e6848ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFTnz5a6F90lbHEZFpdfYXQ5k9IW7LTkT+Nx+flWKEzsiCfsJBNnLh6Ad+1Ijxx1UPlkDHJpsdsQJ3o1mE6vEdckvIFutAWvWnms9UWfdfx/07477tKDf2+rFaCnsZomHfGWPLoxSGugRrHNUQF49g6q36jVW15kLdbdWR1ZSb25yKQHfXRYMQC38tD/9sam4JpP2YaUCJ06kCfuYwKadH12DqYiJn7Dh55YCDvscAbXQ/1Hc5WTwnFC49iMz2qpNLL3jx/Jh6JYV8Ujr4s4Zh8+GI14Sf3x6v2turmfIz44FDV7XM7kZgq/6hibxEvTvYFLP9AQbZB9spNjuX02//YMPM1nmAlwCMSe8qOKDzJwiSQFans7SyLIqD2LO367dwMCax/2MOG7hc8RfEQiV8yokWzn9hzdMBXjjJc6xA/jZ7H20m5PAPUP2iGJ4TgnYrgw4cMxR8nRwAR8jBLrz5Ejoe9YOMbeeecHPU3cu+v36iB+orNsBwXpiIh8Payqwq0yeSaacEmBi1h61wpfWMeiA430zcqgLWtTvDsSQsb2ZSPLHfgWhso2NY1OitcsxGjFrA+SPDh+/G1zgo+8ZfeCEumAB4nHnOA5UksFm1QfXXpNaNjQFaVaroNObKrvqMjlQ/9z18uYhX3mPpKyofpQ3UtoDwu4Ssx00tU1RfmF1mvgSG9BnagA8O5PKHs70prhCnBp2xbNEMOD1xPWqJiu0QlrTERdE2/gn25tabeD95OfiG1lOCgs+hVTSar+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 14:14:58.2117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aecddf5-683b-479f-551d-08dc4e6848ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

it looks like that only CVE-2016-9841 is not fixed and this series is
trying to address it. The first two patches are just preparation based on
changes which happened in past. The third one is actual fix and the last
one is following what has been done in Linux kernel long time ago and don't
use incorrect zlib version string.

I tested it with and I can't see any issue.
./test/py/test.py --bd sandbox --build -s

And gitlab CI is also not showing any issue.

Thanks,
Michal


Michal Simek (4):
  zlib: Rename this variable to here (current decoding table entry)
  zlib: Rename write variable to wnext (window write index)
  zlib: Port fix for CVE-2016-9841 to U-Boot
  zlib: Remove incorrect ZLIB_VERSION

 include/u-boot/zlib.h |  16 ++--
 lib/gzip.c            |   2 +-
 lib/zlib/deflate.c    |  13 +---
 lib/zlib/inffast.c    | 176 ++++++++++++++++--------------------------
 lib/zlib/inflate.c    |  31 ++++----
 lib/zlib/inflate.h    |   2 +-
 lib/zlib/zutil.c      |   1 -
 7 files changed, 90 insertions(+), 151 deletions(-)

-- 
2.44.0

