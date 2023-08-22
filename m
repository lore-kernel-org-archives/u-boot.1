Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296B7EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 14:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E143A86485;
	Tue, 22 Aug 2023 16:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="Am4AGR66";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA31E86485; Tue, 22 Aug 2023 16:34:33 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn2080b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::80b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C357486484
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 16:34:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFzXGIwfT4pLHFSAYuJl+mfWM7/T5wnX+ZLIF6zf/MFpwDy7DcGX1bjYnvETjuPINWLiqpBlycJjroh2ARvV0YikueJmR5pf6u3g3YkDhY0I7x7DOg3EUHl5A1mSWILisgC5jImBFJeGbmUyajkVRl9RzZ5ObnzVWBka0FuUEJ7FQDnTuS6w36rBS1g0d5CeLkbpjr1DuoeKlScsBPMaySqdMNhtAWg/EYa4MgHeqz1SNWbWElEICpalgUA10UVy45csj1p7sW63UyUObIzwpdxNXrwUEPj14jc+IwZIv0KzIsPdH1MVYBu8eZRjNtYn+xSfdg+1F8/IY9auBQdGjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDlRUijImWtFsZasnZEjqX+zJPmLzk/veAYHB8EnZpI=;
 b=Whw2O0eacTFSnM8EN1l6aUAprw5KqwuD2JXEFjHavRguUGZeu/kjfq6f/ItRv8D5DomT0ZbVEoVhE/OSF6FzGDDnA4l5FZkqBwe9xmai0u6pTzIn+nQJmGEzdL6OMgRZEKcXnFzsZmiKerZqWwpTGx26blH4lWCZJiV/caJhVQAgcAUjWHje22dMdThyNSJgYXDTY/LU91OXr4ca2zkn7WiWp8oFETru+y+SCoCwrZ4LFOf5uyRdjJ4Q/k/K1smVtS9mnWwOsl084P3FCTIdlzdDCPNGDc+zJ11AwMxBitYjHIMcH1P8wx6Yj6i3T3WMN7+JpJv1QB6aQdX532TfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDlRUijImWtFsZasnZEjqX+zJPmLzk/veAYHB8EnZpI=;
 b=Am4AGR66aGD/Xmtkr5o3Zz3ZyGjO5Q5afNPzYJJa4EkjB5c+4PPwetS1aqe/6LeDLT59oYViJSzVXTVuVkONbh32Cn1OCUZtJuXDozycAxGAlwMlqFaF2MnzUIsMSDJ1WQ8rtqX1khBU22kzQjV2WuuSz6HXxIdXGVKX6EIiVyq3HUi77M+kzTJzFbUTts7EB7gaJ7TnG9wCbmYjbtsWVjE8eybFLeEMD/0mR6hPMEwkSql0CVc00fpfYEogfsh7AaLEV5LhZ2KGDochRAsKBlf/St5oVnudLDIPnnmPLY5PiqmHf52vOkh074LJtJMEE3FWTIcuemqq91W+Y4GA3A==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by OSZP286MB1847.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:166::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.14; Tue, 22 Aug
 2023 14:34:25 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%6]) with mapi id 15.20.6723.013; Tue, 22 Aug 2023
 14:34:25 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: xypron.glpk@gmx.de, chanho61.park@samsung.com, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de
Cc: mps@arvanta.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 0/2] Enable PCIE and USB by default on Visionfive 2
Date: Tue, 22 Aug 2023 22:33:55 +0800
Message-ID: <TY3P286MB2611878AE57C8A60482C661D981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [M/2g9SS7EvyDcupYs3xdffG82IL1Jwrw]
X-ClientProxiedBy: PSBPR02CA0008.apcprd02.prod.outlook.com (2603:1096:301::18)
 To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230822143357.2818-1-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OSZP286MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: 201249bf-0e6a-4ec8-d9a5-08dba31ce222
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvtspoS0ND55m/FdCMInfiCoWHam8EVyQmTSo5XNuGbUP74myCQskH/laJtjVKngA3U7Z2Pd2JkId5GSBESX1aTQ+gJHOg2PhaPcgW+iOgY5hCCfFx8ZSmcWSKiSEz09kczgoxXk1OrzutHOTohNcYvPPO0Cy/cx8r45WJcOw8nUbY8hqyUv505KB8/niOhExljT0/jqcRKFXNu+TjdGl8ysK6ADEQbownbcU+Ifv5hFl4/rZgcd5sdiL1OUG2DpQMcCPHQ5WJ/tp15Sbq1OvGd0j1QIPXAL8VyGaqHBjJIjwPKuOJsSDd9El36ySxdAMMHBsvanoZAyZ4A5wZeI4jNWcz5NjADJe52cF997/ZbsFCbXpr9KImZj0DXgGanuihtZJOuNc/QR6/0+LJRoU02BS4seDE2P2sqQybbLSRdCPATJn/a165mzq6Uh+8TTcWKSwzgrvUaSdR+Iera0xk44V8To3lHDhNiAb6WpYVsXAVy8s8xbYyQjzGaZ66QpMkZ9otTYsZPxLl3WZSoHkqbaKh5+6BsggCw8dYGkXK9ajGGkviQxxj72jVyySgXMHQxdoPuvClu8/UC068l8qJeDYlfymhFp6tJQd6uIl0FWircG2wwWH3Wtpfdl1831NoAGVt0wfTF4wOSOMbUIgbeTlVwz6kaxde/wwPUUfLTWAlzf/d/DkQOxdDpnawcgpIOvbR0k3ysVR/CbzwGNQfl9YwXvWLMKvA9D5mgf6IbjW2CbAyr5ULmLUAW4rMbXf/A=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4Na/W6t/+HMHOq3RxczW2gWLy5064MIOIfn2jQZWu3aYuj8/1567ReujauRT1Pd3NWL+XPDfkZfdaCLmlDwA9DE4yvJ6mLMgohbXUgNIh/E9lOQ/PQKVedaRwkowpiqwl5PzYfErX7o5RKJiMn0GPWYhGvO9IKg6Ks7PEMVgqQ1+2awZNnqo8yXQsz6m2Pwywq2PPQ684Kb1DGCLA0QctDTeVHg/Scsehigad9mbYqr8+wjUT1M/bOQrAAlEEsOOGdQX37in6vdvfwx9k1FHZoUp934Z7GncH+qVM/ZuTgTkkUvYQhNo3wnRn7eIYOGsrylVS/v9RVojsgr9DUDoZHigthkxh49nXrMQ+vy7KlUhE9qKGMolvzGOZuoUK5P/ljMCHzqKbQv8rEeFtpUeMGCLppj979aLCX2ls1GX4oyrEYXrtS00VPbFKv+GJFqiwecgxFWd9MAsjQYdrFyHpXpJu6xiNaa9svTRMi5EeHDlXlSvHADuc11ek7CYx8zmC+KHcpeuX6O43CMK4uXdScKgYWWE1fJEKCAAXdFKcTyBhDG9r+32Dh6SRZeG4kI1cE3tdhU7lxW1nZ4lgrYsFikGw3zNzEVtXcVoKa8I0KzE5+yB0G4mEtHiDooFEji
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ldj9jnsXmPIZfFaJuRUO+n7aHlWQ9utq4Sq5rGqRl3zdBFRTh965v1vYr0iv?=
 =?us-ascii?Q?jRm+KFAOHtb20Q2yqB9RkqCSslukPwQNjEIH/ABc8x+UJjvjggEl4mHnx2oP?=
 =?us-ascii?Q?SNSJR8Ldp+78SnnHpRl8SgzXpjTCzXif7uNytaC4dYMks1ho1BQ35fWog1Ra?=
 =?us-ascii?Q?vAjVikV0/A3VROekIhiSUzyRWvIkk0NW7ynGAxHSbushRb/AAjGU0FNOWdeO?=
 =?us-ascii?Q?vvfT7Y36T4HB610yvf5uNySH6sk0h9Rdi2cM3XqEjTdl+xW9qzAuw3iuGMG/?=
 =?us-ascii?Q?ZOHD1DKxKEioo9Jwsd9OC546onG5MkRNyYisH+P8HJfWNPEH0iuqOoMHvfCe?=
 =?us-ascii?Q?ymr59aGVJGwRTVkgsm+ycvduT7bQsI2Bxahyw9eKCgm35HaWXqAj6hNWjjpe?=
 =?us-ascii?Q?ndXRDDWcJ/i6CmCmq34jxOVFjg9YiyskPQ0k+PNsblhNxp+YYWHrzrgw5/Zr?=
 =?us-ascii?Q?R18Fs1ZzkuXgXIYxSkqNjdYVZ8/i2ua9lV/FN2gyWkTKPqvv03HgrVchKSCi?=
 =?us-ascii?Q?zYiBSJksNPpL+ZbztoPSu/xqJVt0nt7+ekKzexY7ZsetWcNQSyQlshizcs2/?=
 =?us-ascii?Q?vdwgLBDSfDizsVsd+n3LSjvRvs1AhXLVEVqw+qIt3QfCZvqyD5nKTi0H/0sX?=
 =?us-ascii?Q?DDzXbawGwwB7d+q+tzQOZShuGEICILwE4j8sUBI3umQcwx00JCiYC3EB5SBe?=
 =?us-ascii?Q?GrWU/1lFt1k73VEDCQtfyRTTHBCMEZ2xclVnOak7RTAIwcN80FhE9bfC0F/I?=
 =?us-ascii?Q?nhicsBVNTdcW8Z9GaShdHZ1VEhMd0S0bcMv4dMk7gIhTr8joDTnayQWp0/aN?=
 =?us-ascii?Q?UEBzdcPb/WpOLcTJouEfGgAsuMU02+ATqA1dujjsTCP2EJD4DdPDAkBJ5Mx4?=
 =?us-ascii?Q?kFOX3acPK5j0sd9sQgpqe4XsbSDZ/uGZiRmk8d7xU+fkl2iqOBqBDWZ18MoJ?=
 =?us-ascii?Q?xNxd0dtBTnGVyBAsbSHGPobNICBRPp6+Zj33n/ekPP/I/rHKwl50y6Bo1n4n?=
 =?us-ascii?Q?0Vm7KnfuFzG7JxEE0B/okYk+Yyyyo2IIc28nwRSaQQOqRdktLTVDUAIlW/6n?=
 =?us-ascii?Q?8qlSNx9JqhKmPIOoJsTfwF4BGi427Cct0SCtm0sUD9IyQOZnGpTTNLtlQvFc?=
 =?us-ascii?Q?+9aAdjWe5Zkzk4dRdshVqV4ACv1MAgMpiQ/ehf9jPXg2u98dsf07H1rULQG1?=
 =?us-ascii?Q?LTKRa8Lnx43u9g/a3y7VxkgSNw+2ASKXmHCe7Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201249bf-0e6a-4ec8-d9a5-08dba31ce222
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 14:34:25.6779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1847
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

Since PLDA PCIE driver and dts already merged in upstream for JH7110,
add relative defconfig item for Starfive Visionfive 2 and make document
consist with actual code.

Shengyu Qu (2):
  configs: starfive: Enable PCIE auto enum and NVME/USB stuff for
    Starfive Visionfive 2
  doc: board: starfive: Add more info about supported driver

 configs/starfive_visionfive2_defconfig | 8 +++++++-
 doc/board/starfive/visionfive2.rst     | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.42.0

