Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5738C47074
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6284871BB;
	Wed, 15 Nov 2023 13:44:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="qosrZKeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5F3687197; Wed, 15 Nov 2023 13:44:39 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5416871BB
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpww0G7M4sMnntQu055IYrf/c6I8gzl0t1HIUNUw10t8V/rsBwBJi8ptsVUgd60J2JJR4aZOH88nH+/tvSNHrjy94Q5vgw83RNCW7wnY/oXKKj4ExejrkaJ3nC5BY360vXIpvtTY7HsLDAyBkE5XtsDoiv+10uTM/cGpKiLbrQikiHfwUWyLDF5NgOBLY/0dj5iGEKG4N+tZaLpJxk1tVstTuUrLyW5n55DjLoHbVH6ABCyjiC3UhOtHzYDa9VPd09MjImwrwwRCSdIYiMQOtTYFY1iIS6l6TsS8VNa5s0zshKOwoKc4lG7Gy0gScKBs4bxWP10pN0ZI9fksEzJrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QyzByOpswYWSGcnTTX2Ydz8oKAnBXwYa0XwwwawiTY=;
 b=HK5JJDQ45AjhYRqViba0smEE7Exzyp2HOt0yeuOh58YQqQZvJ+i1MKK4SOJ0TSAE04ZsgYy0EaIp3T9lFuymHnWL1tWOrURAwzPHU1MXuNqt5RgItw1uF6HfWX0s+qb808eH+IjLb2lr+EEl+7PsDct4x6pk2LU28NXHPTNbN+GX1uIW8XZqZG2f1lGrJXSredxojnuGtutIlROpDvDhfc5i+iQbYsO6JcqNhO+T6kF7nfVN9leImTWii5UnL/tWKkIB5Lm/LaMhexIKaHWFd+qai9xZJOjHbldAcVcGZAE/0UmX8Nm9U96sRcNAftlwNtiawiTIf3o07Q3Ir0wWXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QyzByOpswYWSGcnTTX2Ydz8oKAnBXwYa0XwwwawiTY=;
 b=qosrZKeX9MAKMMYlq9tLGMoJDavS3cX65uIwH5fV3Ktz4VGKupdrb49vTOTVefiSi/Vjz3Xej6L10XWsitXP8dWSciShN+kvqWd5joAVwfQ+ALUFLG19THwBvz8g8vo8Pd1yJ493Z/hWZpzfEh44g9v/beusZ9WkFCxssPWnc3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by AS8PR08MB5911.eurprd08.prod.outlook.com (2603:10a6:20b:292::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:35 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:35 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 4/9] fs: fat: simplify gotos from read_bootsectandvi
Date: Wed, 15 Nov 2023 13:44:19 +0100
Message-Id: <20231115124424.125823-5-christian.taedcke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 88fe08f8-9484-4027-f601-08dbe5d89f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WesNUEbSzU4+rCeo5ZQVyC3BARtY7afUFv+0tRiq1uln3ExrABJ7ufKarRm7+T1T3dn6I84E41LlKIrK6HQIn+MDX9hglxC5LSD4QWgwkc9JblmgPditeG1c83uKLhlly1XduUXFqxAFG6wBO/9tpo0eTRN/snkqGXVdirDuf0UfmjuJzQ5kAsjcydVYoCCI2CwBxGzpYNKQ6qrgcYEb555FxLuckOalePcYL2b6FFyEgmKq86Vh7WvLNeMUQ2Ig1/DsmcDvuRWGdVR4q//+3sbc5hQHQiw9SCS7O3Cp9xgE45OQsUZRZsNQ76eVIeGThuneqhH5XQopL9D3jacABxLcaDv/qYqiHjwvDu0fmCOb2/jjU+a/e9EzAX93dB1DWCYUu3gj9sYEv3/jpW+SefgLUzPH9k15+rPpTz3tXZu1LSEcBMYbpY8SWuuDdWMy5meWNitXt6gqXuWsFtKdzw5NK4dBVtKePyJLj+RNMkl6gXEahwb6Mk5WKLLhYQSU6XDIFCRG4eXBFb0EDa8eeRW+U3lRBh0wwP/98qDj5lSqCfNxBP0mkcwAU1jHqAQPCXkq6YF20dDA5UjKOvcu8jsvbJTRgEgHyE2QXfIwxpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(66476007)(54906003)(66556008)(6916009)(38100700002)(316002)(66946007)(36756003)(86362001)(6512007)(83380400001)(9686003)(26005)(6666004)(6506007)(2616005)(52116002)(478600001)(2906002)(6486002)(5660300002)(41300700001)(8676002)(1076003)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2+djrOKMR+1WF3iHSYoAyJk+MyrtfpvPbHVhiSVI83i3wawabeYN4TTY64eM?=
 =?us-ascii?Q?moqcDoJpvRG5/NurZlQj/zjDI+3+cr9y13oxz656IzaqIhadvHha4nWiF5z7?=
 =?us-ascii?Q?ZL8Iwtehx9yfY37pycMJj9v2bw+9VjXsJf+toWxkGRdPJm5fYJIKwoemB9FH?=
 =?us-ascii?Q?QSFZ28N5Q7fAl0FTG7mfAfAz5piQT9ywUc7ZiDSArbfafmGhYWPEJkqpblim?=
 =?us-ascii?Q?YpByuL57h2vrFEOZO67WP4vQtNqwMy12Mfm56XwRD/fyvbviMPANqzgQT8/P?=
 =?us-ascii?Q?8yqZmdo/p7H0lD6w0ukfM0NqmLB8lU6QjIFpzI2pA048iI+/8WllC54fh8lz?=
 =?us-ascii?Q?RPNR+u3V8gryKVcLMccIFaRj8gmUahf3J71JjFvVKlsC2BLleeAOClzPxNgM?=
 =?us-ascii?Q?iPmUSLrHOzYkQ4WNr2fq/A3DLO7y+Ub2vtcUi6VPj8FF8WeXv4e3MymkY/Vy?=
 =?us-ascii?Q?Oy4QvumqBVS5aaNtMttAZZ3LXC+1NdaJ2/WWrFpqs0e0mf4LBH4WhFvPSAj/?=
 =?us-ascii?Q?UYWWxPwSSxyjsFWOyTyGq3VBdySpkaYdeTF07nZnJjg8AMQKE62Tm9Pvxu9H?=
 =?us-ascii?Q?1TOBe+r1fuoDzqe4XvdVsmw3BMTjsXSUobnlJmXvl7akAprtpoXAHR8uB2oJ?=
 =?us-ascii?Q?P9JvxI5Yr/IAVuRa6UefHvtji50wfbq9TGu2oXyjPjOXLKUh2f3GMyoY1+tU?=
 =?us-ascii?Q?jEh2pWaYAJ0cLheuiKEi1w5+ewd6PTstGmlJYOCVHRwAMhgtxc/4BcTMbg69?=
 =?us-ascii?Q?ny2wmBoVIzO5t3CN3Bct0rAK9xTB1x62Bcx/QCl3iiSUbvqdBeEb5xNfk1HQ?=
 =?us-ascii?Q?nBw2cwDm61rsSZ6RifiQbtKUUIWSPXnSuwTFdC5XAtjf5kPP0A3zrsvd37sN?=
 =?us-ascii?Q?HAj5V7+2+4dPfp/qeRKnUFsv6vjgx2zs86WRP4cNkOCfTG4UX/dvwjIC8m6d?=
 =?us-ascii?Q?+qZ3VOlRzE0wBEqp+L2ydZbhOQwfdkIeVB90vrCvc9JaRF4Om0boqTQs/yIQ?=
 =?us-ascii?Q?Pu5T3YOECNKU403QsVXOef3Dl7liezWTflq9aDYbg1L7sSGXya5Cid9cSoVx?=
 =?us-ascii?Q?+PvEpGI8HLXxIAjsTmePcQ2sFxuYSj5abxu8g9HSjIiOfwONPCs3Y8G43R7M?=
 =?us-ascii?Q?u0ntTu957xJ12bAqh6SMy4ousE6WW42NhRzW+bp4uiQGLbnhzfiPdqJ5cN2j?=
 =?us-ascii?Q?dDGnO3OmbyA0Z34cNU/P4xsL4/8R3+fO9GONsJrqo47wuB2ICdNgAj2xawUf?=
 =?us-ascii?Q?xMiXrYoujEvEjnAq+JVgx+fFcqStAs3QePcEoD5bjlD8LJooqQkHor8srRJu?=
 =?us-ascii?Q?6jCjWgDfAPVPTyENbE3QkDlViD+VSZM8hQ+XJSL9/ie9bUkMdpzm16aCTqs8?=
 =?us-ascii?Q?lhTUWasqNvLixs2Hr9ioRX9w7e0Ern+oDru9X9Fu1JUB+Fpfr0BKwglC4ikU?=
 =?us-ascii?Q?QQ7A9FX5RHdtX1f8XHg6gQFFwFymsmLTgyls376MlT0eFcb6XmQpMYN0lpnh?=
 =?us-ascii?Q?vsaCBqF2XxmpPBNFDCjqgeUXY2VjGdUcnOGm/CviGoatNPp97p7KQkfbsJoY?=
 =?us-ascii?Q?lFPoC3lZMTZEI0YctcMtfB9uxNlpJQtBaVeAw7kxI1KybO+kk18ZJ+/MoA9x?=
 =?us-ascii?Q?oJg9LyYW319tAW1t6kb29rgaJ7ZTLHH/8FfXkdFbR4b7?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88fe08f8-9484-4027-f601-08dbe5d89f87
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:35.6377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K49nwIeVvbOI5BaDvS32yRd3uRMoBMVbcEeq9J0GOr9XNdNFiX+Dzieim5QbpftDyg8KThyLU50nv6dEuo9L+14f+rMh1O0y2rhyNgPemsT2OSWghh4zWMYF13lSb/v+
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

This simplifies the code a little bit.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

(no changes since v2)

Changes in v2:
- Keep one goto label instead of removing both
- Move changing gotos from read_bootsectandvi() into separate commit

 fs/fat/fat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index c368c3b076..77f225ccd8 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -531,7 +531,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 
 	if (disk_read(0, 1, block) < 0) {
 		debug("Error: reading block\n");
-		goto fail;
+		ret = -1;
+		goto out_free;
 	}
 
 	memcpy(bs, block, sizeof(boot_sector));
@@ -556,10 +557,8 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		*fatsize = determine_legacy_fat_bits(bs);
 	}
 	memcpy(volinfo, vistart, sizeof(volume_info));
-	goto exit;
-fail:
-	ret = -1;
-exit:
+
+out_free:
 	free(block);
 	return ret;
 }
-- 
2.34.1

