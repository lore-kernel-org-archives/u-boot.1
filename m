Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17107C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C7387160;
	Wed, 15 Nov 2023 13:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="tnlfsUoN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A500287203; Wed, 15 Nov 2023 13:44:39 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C7AE87197
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD2Qd+bHvG3QqtX4DmPV3MdR7I2vH1aWsxCr+sOj2jnXHxIJjBMF7To6qFdPhYiuxT9ipfb+l/boFm4VipBMvw3246fMGgj6xyB5VZ0xJqcdf5HVOXa/EnTvSFewVlDFI+16kbxSPM0JQEVKLT/OdCaPF/fkOX4VHyQ7qzZ0/SWES1s6HfJf2rt/d+ftWeLLOT3AsmPQieJo0HltHJFtiYWqi337OSC3WfFvS0TUX5j6+3rTHiNbDZ5kkkK/3RRSyIS2fdW0cODbEy99y+QRx5IpKnZXdxWiQikCfxmfXXwsb9GsAmiBNt2PGkNOnXsqIFtMkbEzTGnjSYuSa4Zi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bajOy97ohS/9FiAb2NXA5PlGBl2TXpLlxSJyQZkvc9k=;
 b=HogFouxrUNiCEmOEeDi8LXT7gNq3O+TxluDsHwYxf+iyF/mrnvLCsSRQu273ULSQNaoSaWqIJMEXbMWjI9m96wWa745hKWHBzOhLIp3e/OxtRRhow6f+iMQ/rLS11BAudHMQHAUIMUlHm7RNo8ZvYfWWG7jHgW1cu8AFewK7PMsYgDrA8o+8IdLHK14/ekM0HMiUEUKueRmr9ESPyh1b7nfOuUknjrFIbM0EFPpK+EC1RHGOkTqiNGewo3TNadCXuQJsOAFqX8mVSMobuelPWpSSkz6v3IZChLOsBcgO2gPRBDpv8Q4Qo7Ov1FQhZ81TGu03kLO2NwqudsefacmcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bajOy97ohS/9FiAb2NXA5PlGBl2TXpLlxSJyQZkvc9k=;
 b=tnlfsUoN2j/mIgRx2MDZWis0zpGwp7x307W5IFwj4RFMQCtdcOsXiTP5NBz4VRjAxh0xT12ZeEcJk3X5Ke0Hglnt1HyRzKUEQqWyvJgDlSpUkxujFDHAw3U4tKlZvg2Rmbj9oy91JUcBNUUacmZ8Xx58/ChgF+ymLRzIsoF3Cq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:34 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:34 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/9] test: spl: Remove usage of FAT32_SIGN
Date: Wed, 15 Nov 2023 13:44:17 +0100
Message-Id: <20231115124424.125823-3-christian.taedcke-oss@weidmueller.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|AS8PR08MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 883d3d2f-75b0-4687-fc09-08dbe5d89f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9nn/i87nMHKfLuNB1GLTMmMQ3sIfcRbaDI5Fo4Po6y2KzkRzE1av2SdkGwDuSZT4lkODQ+B1NOnSke+5SMTTncCEbp6cT/Mj35oODabX7xcYE61uuZB/725YlIpYhw4ZEiJLU2W/hkTVpcm8p7OUxrjdra289R4Oa3NLhcUQ6eqZtQKGS0UrYANdNrmHUKO2p/hfRvaInl3++8MnJMH4lOwN1ihlaBT3OKFy/2t6LU/0Ekg8c1pJQ225/X17Mvo755ATZXRb0i+ZfFow37fzPvPeAEL7HysDAjKYszipxMIusK9aU7awJMvtcDrj9FozCBnJC2tTdbvJcVpzZi+8kmWHhS3sgTP/nCzBv0/hwHNzGXU7yA4gJAP6KxOShkpUSZFrxIxrUVPZvWvZjgnNvmgkygkLYmkEdOj/5NL5wh4ssyLrcpDd00/pK+pNi9ucEolwqBl98X2fWFZbfk7Kqo+xxokSMoqQx1VWrW04Y2NUjTe4hEYadcOb62wbe/MlVG8gKNYLgMIQp0h8xS2+S1TK3qBaQJ4dccr6+/S3aNF3z4l/0nDfAlqoHbZOhhbp9mht/iL7uOD14CfOqHK/YFNaUJ7cHUbRaVSnBX+jSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(4744005)(478600001)(2906002)(6486002)(5660300002)(41300700001)(8676002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0vncYr1X7kHBtjtcPUWsYZQXg6TqKuuHBff/zNc4SfzOFSsz42fdsvh/NzP8?=
 =?us-ascii?Q?5b6jk9hXjyiSjhfimqUVgNjJdObWV2K4jGNj569+VnMYmowZzaYrhMvwthqg?=
 =?us-ascii?Q?QXeKbMr/HRR+MfCyHvrnVDsG84O5P4JZse/H5A/Puhe4by6+2xURYCb3lypf?=
 =?us-ascii?Q?wr7wNxhT+TTz6f3uTMPY/fMZENpNSb3F8lDkxFLILkhwbS4/WToJou2hXffq?=
 =?us-ascii?Q?L80VsPtMjFWHsj78qXaBqdCODXJ5Bltjs6/bbQwlmslR+ArKVWo6gBZ2tewx?=
 =?us-ascii?Q?ujqOJ/nFdS4MZhvkL39IZX0j0l/A98Lf6ttmx6UP/Jd23GhyfxnQnpY1nrLx?=
 =?us-ascii?Q?ijvWUx62W77p3p+iSGgEeaWWzDoeOA2c/tewHSTElNEHC3vaIGlmTGFSiF/M?=
 =?us-ascii?Q?EhrqHgp/m1MVzyG6qSm2MV7F25e2zm9qGhvETB9TdDBiPtf4iAs2oSfFpTQY?=
 =?us-ascii?Q?UxKn9BonSYnltcb2m1I7AyYreJDm1S56tRTGWn7mL9eV/70A2kFUW4H+yITW?=
 =?us-ascii?Q?hjbZNtkUPe65oE3QxIHQ1RbZJuLeAt6vDqBAMeJGaLxReup+04di8/JKq7Wy?=
 =?us-ascii?Q?tP9GtQX5LQj/W2FnKBZgRwCTMeLy/cVMYZD3UPiIfyJM4o44AmFkqnZZCFRk?=
 =?us-ascii?Q?RWXDbU/pYOgJebS7XWlDA9gZnOZI/geljPkvw3NlflvId97r4mLgCvsYFVlP?=
 =?us-ascii?Q?UjAI3mjNn+F5NOK+epGFdfgnY6CLbKYZcNiu4foTj7laIkXjXZVF4WvFDjxj?=
 =?us-ascii?Q?zuO6e0Vbq0zGK1ZXrTz9zPTP1ymtMGQ3FC9OITDSRA2cXxq9NvKUQWqUs1Gx?=
 =?us-ascii?Q?ned1vOARPYmHYt1ynYcb3/L2n4WSK7kNaibeT3Biqys3FmV/pjGjnR6Q+P6W?=
 =?us-ascii?Q?avs0OBmTnuv3v5rfF3QBGYqwOwdchO9lgqvZ8xwru663VcW4ewF2lUZXhieL?=
 =?us-ascii?Q?idnGPdGHvO51cww1HnklFqJCxZddV+ndqixsgjILsR275PQBU9kN8TZ4oDfg?=
 =?us-ascii?Q?XOlMP5IQVm7/mzDOCTUK+9htk0O3ozc0im7dN+D2z068EpcS2c3w0ApNcaqH?=
 =?us-ascii?Q?TNBEO39WFUnhvfmFJG+e+OpQxLMpgZPjzk396vMr9m8Y73936vTpFBoKs/DN?=
 =?us-ascii?Q?TySizvU89EDUfK4yph9xg3gYbEdotWIXLSlJcIzONQ3ZVES5DfqS+fwDEcS5?=
 =?us-ascii?Q?bnbUvdBoVzETnSlKynK1ZjhawgLa/my3A9zG7nGjLeaFMb+KiJJ4jolCUw9Z?=
 =?us-ascii?Q?vk2zqWZ87w6/8fSn4+qtMQEk3AJx2YKnTb6WOpGq0gXLWntLy5z+4yFmOjV6?=
 =?us-ascii?Q?4Nkx+6bg8zzbKjMZnAYWGGg6AWQCelS7TueBFLAvJ7ZzhjAKvWj4o2TPOE+A?=
 =?us-ascii?Q?Gxibr4ZGRwmRatuvvku50QBjLbgPUrvZVlv8XYuVoMQE07H22l61sPS8wj5G?=
 =?us-ascii?Q?Ldz/fAm0OEipZ01CdxplAxHD7M2C65+Lz9PHGayAV5c7nkNEFbcpd53JghSX?=
 =?us-ascii?Q?Wg0Tj1MTepyheexHISPBcOv0lTT34IeS8+6h2pUPYXQoWyP82Tm1exCpICQ9?=
 =?us-ascii?Q?Jesc1SjeNGNIKLavT5/1GjvV+Hd7t+P/rDN6J0Gu2HJlMJV/pZ0HJGFRuitL?=
 =?us-ascii?Q?PLVRyZ1aUkKx+A5+zes+7tSwirVoIi3oSQ19Qf3Bv9ra?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883d3d2f-75b0-4687-fc09-08dbe5d89f0b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:34.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDijgg9/qU8cItSn8uvecg+luQdNM5BKoHurj/KlEYCp5v4p8HydL2aTrDmLs2GAB2CXvdjFRDs7DslVO8H8/mf6HO5Pgho0ZF/0jezVOvqlNcu7F7azjBZITGgC3yA1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5911
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

FAT32_SIGN is removed in the following commits.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

(no changes since v2)

Changes in v2:
- Move code change in test/image/spl_load_fs.c into separate commit

 test/image/spl_load_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 297ab08a82..90e640b5de 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -220,7 +220,7 @@ static size_t create_fat(void *dst, size_t size, const char *filename,
 	bs->root_cluster = cpu_to_le32(root_sector);
 
 	vi->ext_boot_sign = 0x29;
-	memcpy(vi->fs_type, FAT32_SIGN, sizeof(vi->fs_type));
+	memcpy(vi->fs_type, "FAT32   ", sizeof(vi->fs_type));
 
 	memcpy(dst + 0x1fe, "\x55\xAA", 2);
 
-- 
2.34.1

