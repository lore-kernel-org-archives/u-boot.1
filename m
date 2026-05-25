Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFA5CD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B45846AA;
	Mon, 25 May 2026 04:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jSFYBEhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E45846D1; Mon, 25 May 2026 04:53:45 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22B5846A7
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGf1GfSGSRsqy8gRJTJUBdsS2CJEMX/8mxVz+Gl9AvTcftzsJojJLNe3sWDgDLE/RsQQ4uYAaWPnKORNoEA8UkxAtQH9+ukUxHPef/oBfLWlTttBlCHZb5jXRvGMzBqLSO24mORokMXYpwWXOA/S8FsZqUm7OyFzNv+v8cA3URfWV80CjEpM8P5PParLGo5oEfBWHBFO1BI9/3JL2OdXw3L/M7TPGGcZHkfonPRbLOfbsXCxdO0zw9bijGSqQWj4ytXW6Oqn8TfeLK5xH13IFrl6wIaPRUDl/Qkdgq6NBLuOxh7oPoL4RbrBXG5kHxMf8SlrBJKfi/gLR6OfES82Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wedjtt4Vj/lk11y18rUndRhHn5LOP2RInusHp5hSzwE=;
 b=APUbBMCBOJTEm0kUeP7A0Brmyo+Svlr+4aZUCYfun0ESfn9narDq+wNeN5X0qVViPZsenxjOYZ40pwT8AA63HJlKTF/8/Cp3d4qwHBBfr/FEPzYtUA+o/98hF9L4A32Kcvh7XdTlJIpjuvHt2rqXQNVaMF9WJeILBGunUmBk2p1iaZ4aBq0d0t7UsNWHcF3joCEuAUDuNdPCVnJEtqoFun8NQgiSoY/7mAKfI1Xt6hB4EB1fj5GMGhl1nDwl6sMAAc3jZjmoxrI470oWwu8g4JwjEYfcKTdFlaj+ROJOrZSl/tp2U+RnWa3gMS7Qix9DMmohZ2zPC3v1YASUwzD3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wedjtt4Vj/lk11y18rUndRhHn5LOP2RInusHp5hSzwE=;
 b=jSFYBEhDesRKVoMpXpm462Qrkqs4dobWI2L88ngU7XEYXMotCxbmXtar+69Ar0/FFlRhtibPMzhtXKXHMH3Ne+fw9DqR8eRYr++CQMceeJIHHW+JyPhSn2Mu9ZqvYWr/zWlAvbSiZxzh5HWsAD7+9XgJK5cDRX1zmZhb2CwiP7CWpUgChkIAogC0qPBiXbYOkFQ4l6vl8PFm9Dpakdv+gUi/9NDhfuCmVUXfQgGSRB1+PLZW6tfVnFdhX/l27niGsZ4aMXf1w/lND6xeK4Kzau3w7oMlOIwrJTiD0YLew11MUTgU7s8I8MrObJ8ruSJKF8cUsofGZlxgN8T+OmE9aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB10643.eurprd04.prod.outlook.com (2603:10a6:800:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 02:53:40 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:53:40 +0000
From: peng.fan@nxp.com
To: marek.vasut@mailbox.org, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@altera.com
Cc: u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] ddr: altera: Use dev_read_addr_index_ptr()
Date: Mon, 25 May 2026 12:10:18 +0800
Message-ID: <20260525041018.2369852-1-peng.fan@nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB10643:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cec139-e3a2-4531-e8c3-08deba08d380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|18002099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: PSYB6NAeAnN9bMndOgX9JNv0gGW8pbI4oFIGkBPtOIjAD1qLJ8grlTh8sSLocq+YszCgRTL3XSKuhpZYk87r4Hgw77l/0wt3fXwWMsbD/a3LAqBX5mMEHSK5Gr94JoRrFOBmS9k0LaX2IexXHi0zlULoD2IkCSSEpxjchl6zYpS0HoUXcQQX7BiuI+3vryoK7nKFvEs6KZGHHmwKvrsX4xAVHqH8GZtNVulkodIbBhMV98Z7XxXKy8hBnIeqOPRTPQfzOkZGsb+PlEA9q6dM9I07wnXR9G48rqE5x1sYlRJD6aJfVGFR9Fr5SB+S2kpzBF4e6ZaQjIguizCMKdRQiyj6zoz3l3HKhCQMBzJTZhJIC34DnHM4y73wgsxoEDsfyMFDubgdaHliB7vQk8hhASbaf1rgfOshTs9X77CLjBlDnbMgDjTDQYsa8heLpM6Hm1NrDZAvd58lbsX4RVqbOIpAIiWgpgwdah0YY59Fb8CUt1ZmSyoMQ7egtupHUClcNfQ9zBtQfKI5Ql0hD2goLhlju/GqiYFQ8JLHEEj860ePDBolt8T+xaF/UXWs0RAusE1IskfaGC6+PSJwl2D3/SPnClqmZEEj5yxB1xff08mLiu5WGnTxDjr2NpKkkB7JlulwVSsBFu+jUsPg2ehdruOqbDIspDJ7k+1fKmMlFLxplvxADFWgklVL2nOAgqVwdt2F5wi46pKvjqHgUAJadLnbLMJYtCnFkYFMm03IfHtZ20/su/eAII2blLv6g1ZR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(18002099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0O/PNZvkwRefkidIYFSRX75BcDPB7Sx5z+BLYOc4+NuUlbONcRap5549BMp?=
 =?us-ascii?Q?jz/i/S0iBvRXTmEiUSb2oewwOC3Ull+uTxAwL/XaSBjiUQuEI1MzCsyTCU6e?=
 =?us-ascii?Q?mpHm0oNLVhmZ3H6EYBecOzzaXQ1aDBOoT3jaVmKeT0PLHcWCJ+cLtFi980UF?=
 =?us-ascii?Q?n2I8jqSVgE3Trc37k3z9lhR5nwzYv2iundWPaTBakv+RF/DERMvZ51yfHrD0?=
 =?us-ascii?Q?kMd8MBvSnHXsWWYrVOzvLc87hECkn3qsjA7SLugHZ1rsOLubxoqWBS7hDBGn?=
 =?us-ascii?Q?4hf/0mbTArOOnw39Y6cAMwn2IXL9TFn3QtFTVxZjjetsonzclpwdjmtjw3hg?=
 =?us-ascii?Q?KISbB50Ax9HEEVMkwkR++z9NXl1Wnf8xOOgzrXNUqrjYgluzAQw/z8oRQYlV?=
 =?us-ascii?Q?ZdQmEQbYFWdhu99odVJdfukLXnn0UMlxhopkrD0doD5ZypHRULvmw7jjwgLd?=
 =?us-ascii?Q?DPGI4SRekG67vG0UOd9aYehhVfZV1mqTR54ZEa9fuVTAh4p612l4OL9yiIji?=
 =?us-ascii?Q?QMjvJOZZRvkT3S8ik6JuiNpPB2TKR93W4pz/Fjd4GbwV8lHrWK1dka8Ewi4I?=
 =?us-ascii?Q?Ysk509/EcxmlFlE1rz75LeXRznIJU62/eFsFFnFBcYIyIJu5nufGY1OPSsYa?=
 =?us-ascii?Q?Wk7LyAvc2ft/iyVgrYFZpHF3FzbW1V7g+u+LOwhrCmfEf48ioG6n4/0v0mV2?=
 =?us-ascii?Q?Lg6/AnhBOf5liZJ9zyrBikH4LRATeVpFquu7s1WsDQBoTH9Ym6fVVcLxvP1W?=
 =?us-ascii?Q?+1qTErwWRHoPtvA41GlLokqftT5necw0kBHxDBBX7hrVfHod5FUw29O9w9rE?=
 =?us-ascii?Q?S1avL3FIdlrcoVCW+7EdwICxmL3DXyfd8GUfrlpucUZvHLswL5chUhCdiAKz?=
 =?us-ascii?Q?xzCnSfJihnlPe1xB6QIJcfWZYZJgviNEi4ZWuq0G/EuIPB6/d/qnT0mSxxFT?=
 =?us-ascii?Q?vAW4Bnr2zmVBM6d3swP+6d1QUBAPedU2BS+tt5tn0pPcHQb9K5dyQZdKtRfW?=
 =?us-ascii?Q?/IIu2OZ3o8RRcpJXOvjonezVYM5nd//neXTwDumXPhtLHaAHf/cKJoSF/CX5?=
 =?us-ascii?Q?qhXZlVNaepWCfwz/OopklzzrPdJqR+1DvnrTKtEWxPu6auufIFudu6sA79f9?=
 =?us-ascii?Q?tao4kk3n62Zk+H8VRWPSt580w86ziDuPx3jEAtWNtfsECIpYSy2nHsC/1ExN?=
 =?us-ascii?Q?OxxMb/dlH2x3ynmCyfSUT85ga1lhxPfpmNWhdVxbnRhk5dPTyLsPqadIGM0E?=
 =?us-ascii?Q?7YZPvK2LUYqk+75s/Jgui3CMWPV83gu+pkrybKBFnNlznIbv8jPiw2DQsWzo?=
 =?us-ascii?Q?LO26GQAJCm+W98O6JC4gWzyFza9tcUx3vWSy+2NRcAHKql8kH74NqUvXfWox?=
 =?us-ascii?Q?2E+dy9RjL1n5A2K2fWjbB58+8Hu6lMrv96H4MUzFgGTuUKT1Y5k/jxNvXlNE?=
 =?us-ascii?Q?Mrj+fw9LfCGj6PM+EjrAmauA51DMlgiWgva1ZZu448h61Cvg03luF1kwVEth?=
 =?us-ascii?Q?O2DhVLUQhdzrzaduxtf5aYJAr93PrrtjX2aaX/02T0QXd20D8azkDBBsGAvg?=
 =?us-ascii?Q?4yQ1+kQjLOZi95Fv1fUtsYxKloSrAtfLsqfrclwhZfjdIkdIb0/8nBrX7Twe?=
 =?us-ascii?Q?YATExk/weDhfLgCXHt6wm9/QfGXnDhjpC8ExZ42CGIEo6x06E8jkIwgwX3nh?=
 =?us-ascii?Q?Yn5NO9INFRrDDsJvm4k9n0IpsUdmiYyyzN1zmFEoEfPFk9xKSk3FuAqviWbr?=
 =?us-ascii?Q?y3WIpXjmog=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cec139-e3a2-4531-e8c3-08deba08d380
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:53:40.6503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wA4MYlag9PstXLcMbv2smVQh8ARA5JeSut4HSQB44cMlfk2XHMeI+M9DYXSRiiC6HAvty9Dxlh48d477tX2wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10643
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

From: Peng Fan <peng.fan@nxp.com>

Replace devfdt_get_addr_index_ptr() with dev_read_addr_index_ptr() which
supports both live device tree and flat DT backends, avoiding direct
dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/ddr/altera/sdram_gen5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
index 3c79bb11802..f684ba47972 100644
--- a/drivers/ddr/altera/sdram_gen5.c
+++ b/drivers/ddr/altera/sdram_gen5.c
@@ -566,7 +566,7 @@ static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
 {
 	struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
 
-	plat->sdr = devfdt_get_addr_index_ptr(dev, 0);
+	plat->sdr = dev_read_addr_index_ptr(dev, 0);
 	if (!plat->sdr)
 		return -EINVAL;
 
-- 
2.51.0

