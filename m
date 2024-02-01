Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F822C48286
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 18:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9BA87527;
	Thu,  1 Feb 2024 19:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="kRlufws6";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="kRlufws6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA46687C56; Thu,  1 Feb 2024 19:19:25 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E28C87142
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 19:19:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=UtT7PiEdwM702bWHHpWrd9+IfjXI/muO4cbUyWy33ewrj6MEGqD2pTlyiMrer/Q+6F2CZ3VKA9VuX8mR0bgxLf3nkCw9d8I563lXsSe5nnIK5ZLcLLD3LzdWnl9uv2UTtsTqUEOjOMicLs+yw1TbpIDKJPy8q++mmP/2XFNJJ3fxRa1LGNxparxm2OxJmPGZ83QJW58T/sRy7zirj0nU7RTznziLB+2TM8kr74ttSK1N5Y8M+qKjV7cnLVItoVgyuAvw501tihNJzmxsHyRBt7vDrxbPFFiV5ezvUSkYT0N7hkLna6N5yiT5Z/d+ukKuyO2fFTUzmPz3JmXrwuq4IQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc/MbLg/nZ9nF23Mu0GcvLHnx70Njivldcr9EMQTJJg=;
 b=PguFj2KlWEXTXhREn6abgAWjQcDiaSn04xJdXiv30D5N00T+0U4O2uEFgbsrcy6L3c9Rsya7VriK7ZsS2YiNDIggcDmWE/UEMcawn7QuW1h8x7OiRiN8eFEfWxb3b1YnaVXxT6mLxvMs7Jb/fwSE9L4LyfR2EmRkxPfoyjRb0pAcryPtz3s8BuJdNWb0GB4yyQqlFhPEN9PW7SULEx03ZUdFqYwKPuZ84Kg9kgGHUsppZk/H9ldhaky42tCgljRegXepEV82dGRXTbptOeT1JbgKg+ISRfII63WlbNKV94GMpGtdhXfxNmqWJ5uLb6AbGjIbrD5cWSxeo9J5Rv/scw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.85) smtp.rcpttodomain=163.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc/MbLg/nZ9nF23Mu0GcvLHnx70Njivldcr9EMQTJJg=;
 b=kRlufws6EL51kXp/dKr4nzr0p0PspR6zpaMJk54b5vC/Mgm8eGeEMYrCQMbnMMue+NbrG0QUtL1kml9LKvs6BtABnpNVrLla9UMUPiuWWKoKPs+qdg/r7LgJ8JjRTPIztvx1RgqB1VKJPJDG5pdzV5Nxo08rNEppt7FhhfNd1TWvyg1VUIVNAA53HQtdSheuAbTtw8RAoVT+EeTlH/Zm5VaxmUbK9bOPH27Dm5JHnj1tPBXUVEwkxdqi02IGsUnr9duEKKfl1O2qEKvVME5phPv/Heod+6yWr9PQzYABUh0CSW+l17zfqFI+Ds2q6eGrjMhQJHeca7t6hl7CH1v4vw==
Received: from DB7PR03CA0097.eurprd03.prod.outlook.com (2603:10a6:10:72::38)
 by AM9PR03MB6865.eurprd03.prod.outlook.com (2603:10a6:20b:2db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 18:19:21 +0000
Received: from DB8EUR05FT031.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::83) by DB7PR03CA0097.outlook.office365.com
 (2603:10a6:10:72::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 18:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.85)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.85; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.85) by
 DB8EUR05FT031.mail.protection.outlook.com (10.233.239.193) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7249.29
 via Frontend Transport; Thu, 1 Feb 2024 18:19:19 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 B4D2820095388; Thu,  1 Feb 2024 18:19:18 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (unknown
 [104.47.51.168])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 84FCE2008006F; 
 Thu,  1 Feb 2024 18:19:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPuzN2yYII7dXLGORsn+RNneMNGGeaA4H8g9bsZU19SvCXNmNTtOpva9rPgCRYapwXugCWPMhKL4K/gduj42UKrasX2t/sy5HX8Fjz3QI2V5/8HCYekWFytUs+IN5Dopc2W2ZiBSHSPVDHYT+/YlodzlrQESzbz2dXbgAQ2//Knm69UprDj8/HkFUqtbOs0j6MITlfJ0vImXnlGe3PncFjcG+iyzswCJ6NBisPSsJyLzYDSNEwByMdognMZuStgIX0Rm0Yehzef0oDr7gh8sm21J2pbH2/+509qX8g70+DnYgyYEEnG70YcKSGkTYr155VwXWwEZRAxZRdmgF2MDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc/MbLg/nZ9nF23Mu0GcvLHnx70Njivldcr9EMQTJJg=;
 b=nsJ05UgjfOaakTRMcCnsaeaUtW5Uv1IvBt+1x6ZNOrOsJ4xRcnZzvPEQhnxvjcODxU9ZxnxKhVCWEX4eqKpLiQwFsh3G+FLMaMhMDLHwBC9YNmb4iFY/hm/MGoMjmnxk5RLVDCwffBxihjGvrtCMM77rQzQOGOnFsGly3KR9YeqKHF9INCAHs24svdg2SfNpUyo8c0YkJdmNrxr8CqBKRkQOqDQ+9MCK4Ugla5EmhAynAXJ3GonPo+5QPG6MljnxITLTFUxlfQqi0Mygr0AydZ7iU0CWnjy1LCgOQisMvRK85XnBqwkimxkJGX3uUagI0QmsKKsu7v5RiPCiGngF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc/MbLg/nZ9nF23Mu0GcvLHnx70Njivldcr9EMQTJJg=;
 b=kRlufws6EL51kXp/dKr4nzr0p0PspR6zpaMJk54b5vC/Mgm8eGeEMYrCQMbnMMue+NbrG0QUtL1kml9LKvs6BtABnpNVrLla9UMUPiuWWKoKPs+qdg/r7LgJ8JjRTPIztvx1RgqB1VKJPJDG5pdzV5Nxo08rNEppt7FhhfNd1TWvyg1VUIVNAA53HQtdSheuAbTtw8RAoVT+EeTlH/Zm5VaxmUbK9bOPH27Dm5JHnj1tPBXUVEwkxdqi02IGsUnr9duEKKfl1O2qEKvVME5phPv/Heod+6yWr9PQzYABUh0CSW+l17zfqFI+Ds2q6eGrjMhQJHeca7t6hl7CH1v4vw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by PAWPR03MB9948.eurprd03.prod.outlook.com (2603:10a6:102:365::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 18:19:12 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 18:19:11 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: qianfanguijin@163.com, Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] lib: sparse: Fix error checking for write_sparse_chunk_raw
Date: Thu,  1 Feb 2024 13:18:51 -0500
Message-Id: <20240201181851.221701-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|PAWPR03MB9948:EE_|DB8EUR05FT031:EE_|AM9PR03MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b6d2f2-702e-4986-a46d-08dc23524e82
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oWOKhOpzU5fE0yxYWS/UBNB1JNLXoNbj+ZtwvvgjImtnjFe04kxfJDkFY3+NUHImTzr8l8GjQSJG2tiAWPpj3MZAIueTnviKscz4EmtEC10OVe9AFc8rIWrqVOr3ts2rSJUkdwFKqNNSiy2Q1b2MLjuvTQ+dzaCarJtbM02ep7apl1plL7V1DXpItCGuKjDsHJHgDdxQL0IGUg7dKyLu2QQ4w08T/UqDjVZo5U1HLfu1//OeZiQzaCx9PA3jd7rUR8bGBP7dneL5ysdZfvYFtuMrmv92lzPoRKy8Hy51ywrcJDeFYVyb7mpaah+TgoMUmYn0i44BUyPg5kMSk3ufZEMPzm+uK9TAM5oGJAmxB7a/1mxy16B37xwmq7hqeBjXjzpCuaGP9fRds0TPNPAhGeTHXC1XvKGmRaArikwFTR6/HgbbT8O9w6RJDe3n9+lTCVhs+rYxb4YxFFCl/9m0HM9ETR5CdGT70pR5eMnK2DEJhbDhUjquhRy9USw8WU0cGPpxDcuQgBYweNLDZ/xGcED1zKTEXkifRl3emhKwQfniE7pckBcGZHMfrMWObctr09SiNOxoweSwQ2vK1+icF4ybcuWUwDqhIVKskeRL7Y4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(478600001)(66946007)(2906002)(44832011)(8676002)(4326008)(4744005)(8936002)(5660300002)(86362001)(66556008)(6916009)(316002)(52116002)(36756003)(6666004)(38350700005)(54906003)(966005)(83380400001)(38100700002)(66476007)(6506007)(6512007)(6486002)(26005)(2616005)(1076003)(107886003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9948
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT031.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4d14e541-a24a-4a3c-adcc-08dc235249d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQkAmP/RyfYx6gbnd9OfGFowQ/HcxdEfNPlnMwfhXSyV8nbKcAqx7S3UYiwzFAGSjJOEO3JdHEYTzNFT0CmEDnoo0BkCixi84hutoS1VSxtgNV7hmpcdbaNNaoh2iUySXN1Lg9t3rVn+yQ/X460AC28dKcWzBAYAtanzi2RAL8d8DNeg+N4ZVtviM2ZxeuGxUUlH8Av3U15svS5SXgKh3D6gnWoJx6v1X6brOCBsRWrIhuLKk8szTnpbAat306XK+ILmrb3sl8pHVLtQZ/t0ritbK3fepY7Q3jZOGEA9gc5mdnZd5fgNHnawXVADB3sZf5dLgJ5TEOBjnCIqwkhjsFr6FEZsI+/Uehmjv3osngbts5N0AoDSYiSFdMaqJ8Ih4XmzA1Amq7kCd0vDRCVlglZLyeDlETSeQ4ViHtSz/KdN7RkpYDoYVKAHlEgBODs8OF32LZtOZ/os7RZtkKeO1R7+vPntADVguavyJkags2Tmz6Z++4PfMpYkD8NH6DQ4fqI3xj3anBPl5BRzmxBwUx3nUyUHfIiZHXPGuOEVTRBtTDbbc/EU+bAvxw6EEkdWCWh2hO3/2WeGEc0f/c6HqU52G0MB2b0VmU0OFnpTrwRlQet84maf0xXnS890NhwrsKmKocsbdJJRdcEzCOsSQGZmvKZixBrWo6g7ytNO5e3aEJ6+0W1WyxdsmQHALA5mFRPnS1g4uJ8Vx+YAxyUSbugRbnL/tHf+K6o+kP77FRMI1xwNCw5eMObmjlO0uOn9
X-Forefront-Antispam-Report: CIP:20.160.56.85; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(6512007)(6666004)(6506007)(336012)(8676002)(1076003)(107886003)(2616005)(4326008)(26005)(8936002)(4744005)(54906003)(44832011)(36756003)(316002)(6916009)(2906002)(5660300002)(86362001)(70586007)(70206006)(41300700001)(966005)(6486002)(478600001)(34020700004)(47076005)(356005)(7596003)(7636003)(40480700001)(83380400001)(82740400003)(36860700001)(40460700003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:19:19.0617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b6d2f2-702e-4986-a46d-08dc23524e82
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.85];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT031.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6865
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

The return value of write_sparse_chunk_raw is unsigned, so the existing
check has no effect. Use IS_ERR_VALUE to detect error instead, which is
what write_sparse_chunk_raw does itself.

Fixes: 62649165cb0 ("lib: sparse: Make CHUNK_TYPE_RAW buffer aligned")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/u-boot/1b323ec3-59b0-490b-a2f0-fd961dafcf49@moroto.mountain/
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 lib/image-sparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/image-sparse.c b/lib/image-sparse.c
index f8289064692..09225692e9b 100644
--- a/lib/image-sparse.c
+++ b/lib/image-sparse.c
@@ -211,7 +211,7 @@ int write_sparse_image(struct sparse_storage *info,
 
 			blks = write_sparse_chunk_raw(info, blk, blkcnt,
 						      data, response);
-			if (blks < 0)
+			if (IS_ERR_VALUE(blks))
 				return -1;
 
 			blk += blks;
-- 
2.35.1.1320.gc452695387.dirty

