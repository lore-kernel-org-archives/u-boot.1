Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B468D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0FB83A2D;
	Tue, 20 Jan 2026 09:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="WZsVI12F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 457F483A3B; Tue, 20 Jan 2026 09:12:16 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9B81839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4jybo31Wjpb+99VWYxa2+PPWJRlN9/eG+e0/g6iYcpK1XXxeU/wSnXNy7Ln8iSlKNih/fOpq2OLingY66XjKys94Hmx75kgLC8dgP9YZVvhuaINnZpmfwlaAX3eDgJRg89cbxFQIQkqMewbbRElrR7CVIRPc0/oGMP8ZG6FxHIwDtA6X6LujoORB3eiEtklQWu+ioBCbJW2bcdmnO2MSMNi7lnmEZub1snuxWo2Vpz4K+Nxt3NJnnOGc8zW9AGR96PAbTAftEX0rA2j+0BmmUwWPRgItBCN36YKNgde2JRtB6O98qtEoeFiiOcikuYqwW0SeaF09sisGuiVD3NC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6F40ib0b06QUn1BZBqD/nWjphfKO2TI56eFD4xrqsU=;
 b=gccmCTI8CfHgS9e3X06J7NHIGHbN+aWDfAflq86ZEMcJGMJPEx1zEUgTVnArDG0IbtwzGuiPk24VAsFStbz3wCLjksVcQX0Iazwy4xo0UrsQFZztZO1007igSGpc1wF0wxz5pC0Q1GA+jmoMiieOzPyA25lOfGldEtG9enlqIJBhyBWJJbzGK26EwWrZ7auSeDRRmpuL0CT25QOuxe5dOQUwRPm88E7EDtSD/WlMxgJrVGibcJL2H7/pvm0TwuzGAfe80Y9uQ5kor5sjk9EU75ELbNonACrRE9FAPZf2LrODb5x5G6SCwPbBc+n4D/vUkV8ApuKN21w2o+PVUQOQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A6F40ib0b06QUn1BZBqD/nWjphfKO2TI56eFD4xrqsU=;
 b=WZsVI12FE1YFQqWcnsKWaAbOBYmN4nSCleyOS3E/TfjQ+9k9VCo0YmXsIza5tcb24TLDtd6LfFWCpfsY4vKfIPP3E52awp5T1hagqKIUJ1gYzTK2xnNyMtyqUwJArK3a7+CE1quJKVGYlthQYZsmCBcFghptLmTir8GZNTHVT+nAB5QD2u8QzChmfYB6A4tu6LKeS9FX/0jTseYX3XE0sfJpfblnPBowwD3/VjjH4MK3hSQxd/0qw/qqClG3WHAbxqzqpqUp07r9HcpXA8BMk200c1wRblKqHJzC6HgP9EjKKe1cWrQqoYX4dLjIX0NkSlO41UH8uom2kmpwtYHkAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PA4PR03MB6750.eurprd03.prod.outlook.com (2603:10a6:102:ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 08:12:09 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9520.009; Tue, 20 Jan 2026
 08:12:09 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v4 0/6] UEFI Capsule - PKCS11 Support
Date: Tue, 20 Jan 2026 09:11:57 +0100
Message-ID: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0187.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::9) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PA4PR03MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 85079908-2e6f-4cb1-d3c4-08de57fb9ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|1800799024|366016|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jbr/9XjPUSm/tVYnpk1ldyUIwYf+JVN4q+Y+7b+N3UhAWq6OJ4Gjb1SO0t3U?=
 =?us-ascii?Q?sLImDsbSWa3mFkHjgakhR1q4fT5FhfrGuIamJQingzViM/hOBc4ZB3wz7sC9?=
 =?us-ascii?Q?yJ25OaR1qNCwaognQ8sIRKz0TSKND0Mv5XTx/XZ11faFKHMEoeK9RVZrdl70?=
 =?us-ascii?Q?6R3qLyApVBlk+/KfmZzs/hmPG/6sYUf5ScLP+2IRRuGuLRirZHfIK9tNPhAd?=
 =?us-ascii?Q?DBtbYsahDaUxOOWnITzVwIUmS3F/iZAHZEYa4D/1lQ4qwos/PzpGXdv1cgdB?=
 =?us-ascii?Q?U7UuXocx16cktjFPXdTXVxDIHLZMjufj1pY4ckjrtizR1IwZn6h3s9aszvkY?=
 =?us-ascii?Q?rN8AoqzbSYI+5mVyBVp16hXMJZepNL5wOM11EV3iAjEp05Q6lJkCYBmMGGXl?=
 =?us-ascii?Q?hK1okZlCMLij1OccGzCuwRxjrqUBWnfQ71Ym7hDDoh+7eQ4NG3JkD2TI8zCC?=
 =?us-ascii?Q?kN/6uCJzv8zM92GSHUOnrPRWvis2eLqBaSHp38nBJI7XpjA07CACNLqZVZH8?=
 =?us-ascii?Q?Pmkq4rJ64HkFp+bqDrjmxat+8u8s0wtg/yLmwX8bKCsCAo8BbKxRjOCzEXOo?=
 =?us-ascii?Q?6UfhC8XGaz5CxG77M8MsTWQojcs1rCkIbZ/XnWru3a9h/lQoswoNPwgDkmwn?=
 =?us-ascii?Q?ha7V05bZGYzNa0kHx6sYERf3IVlZMopvgWoSgxBpRui/PVJnoJy/RYwHDV7I?=
 =?us-ascii?Q?L70G4tHoxpJn6BMhk0EMmMjWQWH7qoHOZOgXPbecsVqoJIlSBbvSxPGTCQjL?=
 =?us-ascii?Q?EJQQ1Oi8tp+5JoLizrOVHn3Iy70Q/ztTrF10WoGpWGd6y5zdsEcIgyJn2qbE?=
 =?us-ascii?Q?jonQnNJ/ZGC3/jgedUcR6gyJCRYjWP7L2HLXTnFBLvx7xcmlwdaBZM64yhgC?=
 =?us-ascii?Q?d5ZTdVD4JRLxSv1xcX2pwh0OGPVSfHg1ltiTJ/dUE80i8aU9um6bpijmycBs?=
 =?us-ascii?Q?jsFJIQM5celq3lQap4BnSYGfOmb4fDlcFh6iWai2hgUTnuiKY4nJE4uKE4w5?=
 =?us-ascii?Q?2MRLYMhKzDrpZhax3+uo226OVZzGsze4qqmc+N5p7T7rPqQfW09O3ihRckHA?=
 =?us-ascii?Q?vU1cBeuvJXo19RW3SENpRM+VC5MxQ7KE8moxjmwADVwcTKGqV1KKw1j2o4wu?=
 =?us-ascii?Q?8OX/7UivW0DTAV7S160geohivSE7mUYVPNGzM+tYHM/95FX5D7n+r66Lvz+o?=
 =?us-ascii?Q?OsIrVhKXpqIZimODp6d5CF8NC8B6UKRIsa+S6chE0wS7yqzAmsn/Wx6ocTcl?=
 =?us-ascii?Q?bbJrWglo0Bm8apEa1tKfpEl/gH7F5QLlkaUEOI+BmakqL5Il/AhPcRIwBUG5?=
 =?us-ascii?Q?FM9uTPvsP2nqp/MSXlrRF2WNgkFe5J9PwwZ3ScIHkE+XEW54EdyRUIIHp3fx?=
 =?us-ascii?Q?BM61bo8BQnMIH1r8fL6TUXRVWxrkWqG1+lnKGOLOttX/h7O/IBHFz0toiiBN?=
 =?us-ascii?Q?mP637HRfyLCyHiUQY0SRDE4Lcsejvqu2NukEihZ0OTSMV59ENJW2JIsqt2rh?=
 =?us-ascii?Q?xBT3SerGXfnenn3OpPM5kzAiQ49xqAUtAsdPuEB20VozKyMvsu0tI6PPSLwt?=
 =?us-ascii?Q?FEj6+IqUtv8poho+xeDRs2DPxjihltLsVGnMIZv7aGDlbT0E+8EC1QTUb4xc?=
 =?us-ascii?Q?lnSsD7Ybnv46P1Ot0ai2hlk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(1800799024)(366016)(38350700014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1cywqvADAwQk6w2Zh2gwwuRmIQMHX4lrJuqsx9fEBXNoVaEqfS+9BJAIrc4?=
 =?us-ascii?Q?Wye3xjSqyB2hqvrI5yS2a58HcTD9BqNDgzeLdL7mo5MJ7adef9brYKWQ4gnL?=
 =?us-ascii?Q?lCLg7C9RPtqM0TmsVO3/9g9TZK87NYykjCjIMEh9b3szOezk9uW0SBaUpRFW?=
 =?us-ascii?Q?ZgcOthbm54hoqfrsGKHCaAikpkxWpMq+5lChoLyzLYEnT835zxX9qBehftL/?=
 =?us-ascii?Q?zNuwUPcA63Wt+w1T5A20iNqCzk+4cTdV8EXfvcVNxLUMkxfMkfgAWcwS1cYz?=
 =?us-ascii?Q?O8au9Fqs+aAzg/VcDkYVHPC9MLPjzuMBZxJMvNm49Bu5zCgEQI4GqE/3K9+X?=
 =?us-ascii?Q?8XzEsqzfYo1Qgpoy6qcZlMpXTNqfufzDmL9W2Ict2LFaHztUNdqYAxnvlvOu?=
 =?us-ascii?Q?y9FdL8SifqTV4/yegjbLxTEwZo9wCCRii2amHXTr4orY0EGSSJ5H4aGmqcZc?=
 =?us-ascii?Q?a72y6PMKwUJ19FMBFVk8vQm+RhoNQxxn7hVwqNufJ+GJiFUr/eA8j696MtvM?=
 =?us-ascii?Q?9/ypgkPlzXnwG8dMWUKVGxz6YHHZkvhPvmRjPjvVjtoVb9GNr31tNWtXlwNj?=
 =?us-ascii?Q?mRtLrxuZ6na4945u4iHvGURzis4vBYqkGAgqiy3zHOeEtgtN2LazUehZEmgA?=
 =?us-ascii?Q?KQiPNKCYiqH2q3ZjYxWW39vp6e60qjz0UPm4p0Q/Cw4lJJnSshXtSkmE4VVe?=
 =?us-ascii?Q?prS9ASScyUg5yorna4/+qKNxbKF2GfZ9ErN6L/gWy4ggnUo9RuniywcQtXKa?=
 =?us-ascii?Q?/OMbm4vMVOnpTFYyORsIZRUDf0sD6mPtiwhillMJZ7HSJN0mOdK7UauievLm?=
 =?us-ascii?Q?U4U6zi8nv9jbQTi9LgYnw5vEleZ/nABSk0br5d5JBTMgfR5blUx0wxlMB1eQ?=
 =?us-ascii?Q?txLmZDymiEuSfqbcLtia3iGAsCO+54jZm1ZZTSpee+WVGXP4HJFdynLul0+M?=
 =?us-ascii?Q?HmuHM6CW9c3ykEuDkckqn0wZTLk9MrSR+EmEWKZZtMaR+NGKkQ/yYgQjfxY/?=
 =?us-ascii?Q?g7qfCR+y7wwDukGqUb1cxp0fqoBBfen9Q/Lyp6oVwWIwD7mMV+P8X6W2vAb3?=
 =?us-ascii?Q?qFObwb/Jb/XDX2KA+N7axTTHndLQsi7VvShDfifcMZF+CpajhK5TswSVrFkR?=
 =?us-ascii?Q?o4qp9PqR3ZUMSvHs98oArcJVcfTsnEM5uTf7hra9yMoCj/iYBtt9whm7THqz?=
 =?us-ascii?Q?kGeDOpOak1UBzB43yAhGpjXczBmPLG+YaGNRP85hbJjJqt2rl3XCW0kSHEYf?=
 =?us-ascii?Q?1CQqfKMUrtN8uQ0FrwxVf+8m6mf4yIPnyUSQcP2xCW54li1se2iJYi5Jl7ah?=
 =?us-ascii?Q?rjXt9lVntdY1vgQj4ybuGcPa4iTJ63QtuwZjBMI2NBzOdf4T8updlxhGpTUJ?=
 =?us-ascii?Q?xWT+CpOVJ/k1ufLOA8fP7e0c4up6myJFwF3ObkUz82/RMhQrViefG/FeCsdf?=
 =?us-ascii?Q?LerlBlXcffRkLkncN1+D+B7SAitwLWD8zXdCfJJyo/BMu3kgEqTJJxqOHv5L?=
 =?us-ascii?Q?Vaa6srUbZcYgIwfW0TGf/9sOrJS0F9pLSZZDFKiJkCqxrfT/L3oDyaKUHlQu?=
 =?us-ascii?Q?hJZDo6muVJAU0sOyJGv4cgJpnOOeMpajPKBQN2SnhVywMD9cX6UjxHXrPCTq?=
 =?us-ascii?Q?Ga/rDlJSNXH3A//u4vM8n/zNExuFo6rdLsfFD8kmuKDWqXi5E1ifxVllhN6t?=
 =?us-ascii?Q?ZqltVGzFbUpQzoggm9IfHqDX+pAYQuGjyVIRyZPcVSd2QO7EwAeuECzB8qzB?=
 =?us-ascii?Q?cc1ixpmtiA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85079908-2e6f-4cb1-d3c4-08de57fb9ba3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:12:09.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80x6Xo5XAQbZgfalPVYacj4chniPE+Bsf9igqtcPGHjND//4/CgdXZaAHIP4otRY34oFQqK78mcdS9vr12EYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB6750
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

Add support for pkcs11 URI's when generating UEFI capsules and
accept URI's for certificate in dts capsule nodes.
Example:
export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v4:
* adapt mkeficapsule python support to dump detached signature
  for authenticated capsules
* verify detached capsule signature with openssl after generation
* use p11-kit to figure out location of softhsm2 library
* fix missing long option for dumping signatures in mkeficapsule
Changes in v3:
* fix write file encoding, env setting and extra line in binman test
  after review
Changes in v2:
* allow mixed file/pkcs11 URI as key specification in mkeficapsule
* fix logic for accepting pkcs11 URI in binman device tree sections
* add binman test for UEFI capsule signature where private key comes
  from softHSM
---
Wojciech Dubowik (6):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates
  tools: Fix long option --dump_sig in mkeficapsule
  binman: Add dump signarture option to mkeficapsule
  binman: DTS: Add dump-signature option for capsules
  test: binman: Add test for pkcs11 signed capsule

 tools/binman/btool/mkeficapsule.py            |   6 +-
 tools/binman/entries.rst                      |   2 +
 tools/binman/etype/efi_capsule.py             |  13 +-
 tools/binman/ftest.py                         |  53 +++++++++
 .../binman/test/351_capsule_signed_pkcs11.dts |  22 ++++
 tools/mkeficapsule.c                          | 111 ++++++++++++++----
 6 files changed, 177 insertions(+), 30 deletions(-)
 create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts

-- 
2.47.3

