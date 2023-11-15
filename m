Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066DFC47072
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364FB8721D;
	Wed, 15 Nov 2023 13:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="RLGSGhyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7CA687197; Wed, 15 Nov 2023 13:44:41 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65188871FB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxgYW83/5ODXsbXiwcKuWNnh7UI8PVEv5mDRPGOeeeV/cSZ0HOyKXPqM0SLEyNit5D0EFSJd6QHSu3/EfTc+fUXBgZnNSThnbMaHfwLCTE24xT9bwOyGEejlc/Dgjzr3G3y+Q3i+5Qqo1+2gddbTmpGQahIArWrh+wTMBVrduottjoRrVaPRU1EvBcU62Bg8p4lSzVew/Yg2i1eH+RuupRBJrQGV9hSmVfbWIVmbc1D0zJQNeL8RwjvJ4RiAO7HKAaw7LT42ESdu4SyoPa1hs+gRncMrVkeyU2ag7HTb/skOEfkb8TuGgF0620M8Kr25dCKovlXhta5Oh8YYWRE7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SqmBDvRsCVAX/TUj+re1ySFIkrriHJDcaLFI3PrOvA=;
 b=mTjFm87H+RVJwxu4DwqkxyZP3PURv8EuRHkd6prXPCCC/SEUgemoKJ81V8Xqz0AUK4/rfnHOag8sKBNfrmQLQDw1RaMkpTyO790ax5u5PSedzi1K/ZPLkc4waU2bcpAg7MozywFM3Q9Kde7PpwmzvvFhqEARch6H7cAXo394/o1RJe5ZzybunFjL7TwT2pZR+BGcH5hnzt/88Rz6/bl+jXl0nW7wuCyXxSthb4qU70LgIstTMxssCX5GMkjdyGUMeEKDX+S+1RMaGJDoAZXzVesHnoVfi4X2ZR5DLl7ZN1USahxr/2aXJ7enhEMMZ9b3Gw0X0Qt9oZhYnRKnMq/H5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SqmBDvRsCVAX/TUj+re1ySFIkrriHJDcaLFI3PrOvA=;
 b=RLGSGhywzi+ZK9mBzSa8jJqi7Yu4nwtuDApORSZxFa8fQ8Anu6TRVnUqKq0AvAFql9YN/nbSfPqrjX/PkWAQGN2uZfUpy4p5rn0Jd30yPevQYAEn5r5f0CUy+uuxC54qjLMOBPNTSbiAOOlTJIKGZFdaBcmM5gsK91erozTYgis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by DU0PR08MB8614.eurprd08.prod.outlook.com (2603:10a6:10:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:37 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:36 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3 7/9] test: fs: Add fat12 to supported fs of some tests
Date: Wed, 15 Nov 2023 13:44:22 +0100
Message-Id: <20231115124424.125823-8-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
References: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|DU0PR08MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 221c6632-95cd-4be2-8adf-08dbe5d8a03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z01/yvp47N3XYx8sBPPYnNOlw0pei6BBJ97RPsxJ1MbAnigHKCMc8wt4dRS48+WrHVDMpt0xrHml+MJigSTtSffs9jz2OlvCqogWiUe+t5LYRTX6CwWfv1VAGdQ2dLJUEduM29RMInhZJLYp42E+06TI40R2tlaCaT37Rpv4ylENZs0F+c7IRQ6pUqqzFCTAsVoysHPnk2e4otLQ3JZG2pcfwUHZ6fvjFpo5O+WpvwvPTcII8/BbRCI6ELiYfBdlZMFCFM/zGWkYiYO2PKXhNaeJLoUTuU0OfrGpmID3tP0y8t9Tgj9bcroeRtiq2mjP3AF+/qEDhfuSbVD0bnpM8ADxvVSF/CL/6jGD+MHeQxua/ZOKlzwX/Mrb5GllExVul58lL0uLMi5R2Dv+bZj87OD7QWCAVobLAUB9cY3scX+mj1Dv29c6KX4Fslq1CvGYE4osL14DlNKpOP6e+kgCQ7NyRjN9jIPRXYSpUfzhLDBC39jpv9VAUDhSklTKALXulyAIpeq/pJ0GhUDj+l1wCr0hYyBgImuxXZN54+pmmT8BC0fUBZVVZ9kYGpMDB6d3eD/KXgyYlrS2r++/Pr1SeV7ekhHF2p8mNyAK/HuN9LPvFBAH1G6P1amx+UNncHEs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(2616005)(66556008)(54906003)(6916009)(38100700002)(26005)(36756003)(316002)(66946007)(66476007)(86362001)(83380400001)(6512007)(52116002)(1076003)(6666004)(6506007)(9686003)(6486002)(2906002)(478600001)(8936002)(8676002)(5660300002)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ziqt3upJmi5R4k6X1/XWKG5T+Rrjr4LL2gLfwaYLUDRwVQkCyS78EiRH/UGe?=
 =?us-ascii?Q?0GWvdNrivYBlz/kpKs2LqcBrV4fYdr1WFz4jx8+kONW4VDyb+Jk86MuykZen?=
 =?us-ascii?Q?uJtzpmk5Hlcku94BpQRpZdQ8f9rnzjMMygKhKtwF/vAIGZzasGP8KmtvScR9?=
 =?us-ascii?Q?f8P9U5CCO61Hc5MQOoN7Pls+Pb7JAc9QeJh/0UWKBwmV6mML1GkQ7J2GGhXZ?=
 =?us-ascii?Q?ZD2dPhAmNbIlVC0c5MSxK0IMqzpF5e1SAIzAW4O5AO+wwd7biQkIIqvOWvVO?=
 =?us-ascii?Q?z9w0I3JMOMK5utxrjij8+2s1lHivI6rVd0qS9RBMYEu1Z9qcTNKc24op/UMZ?=
 =?us-ascii?Q?1rD0iTxOjfQ0JT7YTWw1JTvs1Layauuj4XGvG7mf2nxU8SVt4FHAsx0OCdOn?=
 =?us-ascii?Q?Xo/eoPYO5xjA8UYUXXrGlWnMcyAlwu1hWtAoAxI8udsKOqmf+RSCVCi3lIYe?=
 =?us-ascii?Q?cnzkOOY33uZasOAuJsGGLa5avbnZObRsdFo8IRuX2UNJ8Sf0F4LSLxjL74fy?=
 =?us-ascii?Q?F93hcaGscLTVNZXZAQjf+Hb3YtHcaDAPjtG/g+FkvAlSBpiOecTYpomS558U?=
 =?us-ascii?Q?duH+TSbmuBodjyybR3bQaTqNTQI0zVp5DmsJjEEUq5LVdgTM9NlLRt8i4bvd?=
 =?us-ascii?Q?dGlyFuo+8rtocEBuXbImTbBl2swsw3Amr4S4x0ERvQjQAiqfmTGP30LdSWdE?=
 =?us-ascii?Q?FAvogUZqP4+SWTLFa+clI3mxqTsq6WDk6uWTrWlzX9bj3xxz/+9itiZU1YSz?=
 =?us-ascii?Q?2B5A4xu5VSBsxdYHEnatLqw0V57Oo0q0yMGe8TxXlMftPk36xpK1voILDEQu?=
 =?us-ascii?Q?34ZEzThhoozt2mLR0XrLfiZCAeAy1ht5/LK+2+6gn7m/3fhEw2rrNB0Wb/Kt?=
 =?us-ascii?Q?iTQBsX1lc+XHB2HvG2n50e6ft2sdeB9LS4KrhewcBJGnk7K2X464oczZ9YuM?=
 =?us-ascii?Q?4CNyy79Yf2vUtC/Xj5BvjQ8Em8y5AqO6bPy0NPvFSnilnoyofeMBI5zb5gqQ?=
 =?us-ascii?Q?fzZzI4s3Ce304eCgB1LW6GqJsZYKkYCs2zad21qAoCVPl5Qiati3kARaLINw?=
 =?us-ascii?Q?vCl2RTeGysa9GvJolh3YOUp+1+VGuhRzcDCzC1et07E9GKidqIq5W+RyyK0f?=
 =?us-ascii?Q?NmUMHEX+w0JtAS7FPmtYfwITOZYlqG5I2toZLC5RDghOxJGxfn6uyXYb2nxD?=
 =?us-ascii?Q?ZLP4eGeFkqGG9vm4NNVmeCX3mN0b+QqRy9JtTw5JQaQ5qCxDzDmbxAz7oF10?=
 =?us-ascii?Q?z8jdsJNRUyaavKmMdNKiLKXpKCHpDyJRqfv4i1diiWRPjIewn3hb4GvYIfie?=
 =?us-ascii?Q?wik2cJ8vrI8dysApESjdX5F/4spp4Wn4NAHrjSV640o9vgx8z3X9teWhWsh4?=
 =?us-ascii?Q?q0eqfITTpI4HjATpsSewUJOCLfW1u9uMgoRowNawisYSTys+DuDjnP7wXOEi?=
 =?us-ascii?Q?pbHvJ2USkL0Y4AWFYfzyVAdXSlNllyzmMQjGj4WC4GhrLBbMeG77huRmRY29?=
 =?us-ascii?Q?zbbRDABC+8arLdMxRfuABHQ7YRH6qmerFaI6vc0sdYdvPPYTN2NjQM1VlaH2?=
 =?us-ascii?Q?61nV3XXJjuTbUVbWF/NLqfyoHpTO9zlvXKZIraXJQ/FNoDxAxh1zEFiCX3Ji?=
 =?us-ascii?Q?fcEpjMqdq8q8hFFK8yJZ0N/WQTgm2pgzqKCIFkpo1JVX?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221c6632-95cd-4be2-8adf-08dbe5d8a03f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:36.8495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMiISKpFHOlZPbXoAcGwL+kjbKQ2z/TQ3zOWK+oYGuquYQBWaub9o6pQyfGEcqJDH6zCBh+hkF0v+SDGb2dnJR8510wPPJakWFLY37kAxKG9bHHLH+ybtkGFtxIh4xCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8614
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

The tests fs_ext, fs_mkdir and fs_unlink support fat12 without
modifications.
The fs_basic test uses a partition that is too large for fat12, so it
is omitted here.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

Changes in v3:
- Enable some fs tests for FAT12

 test/py/tests/test_fs/conftest.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 0d87d180c7..fa637a22a0 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -12,9 +12,9 @@ import u_boot_utils as util
 from tests import fs_helper
 
 supported_fs_basic = ['fat16', 'fat32', 'ext4']
-supported_fs_ext = ['fat16', 'fat32']
-supported_fs_mkdir = ['fat16', 'fat32']
-supported_fs_unlink = ['fat16', 'fat32']
+supported_fs_ext = ['fat12', 'fat16', 'fat32']
+supported_fs_mkdir = ['fat12', 'fat16', 'fat32']
+supported_fs_unlink = ['fat12', 'fat16', 'fat32']
 supported_fs_symlink = ['ext4']
 
 #
-- 
2.34.1

