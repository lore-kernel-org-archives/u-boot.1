Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF2C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 17:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D008187CC1;
	Thu, 15 Feb 2024 18:12:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Dx7HbTwx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="DgB4OawJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DA787CC1; Thu, 15 Feb 2024 18:12:47 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3552087DF1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 18:12:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=AdFYN+1dN7UtAwLIgmiWYl4knf2kaIwon9+3MguZz4oje/3nM+lnKTSHI5k15fHKeZvfOZbeEfpr9LKpSmuQMsuz31adFeOX6/6xYlfvGDgVX2mur7AkZe+QNsDE92McysTBhySsY5I6pYx0x7dFQoSBHNeQsgnTAR3LrerB7VQO9JNuHax/VEfTHzfr1LBN/JuVXGV/1azm5y9//b4d5VkAIsuorIhkE6vZcNqdmRcsMQjTRYoG5xlpA9CCyw4RTPSnrIVteFzZ4U3sg73CHJM4X98rpdQ5W4ni+S3Lhgs41hjwDNGPr5dCtY9XOUvcVobmFH7bgQ4K7UwyikbVBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGY7c+MJ7Zdq/l4paAUX3HApML89rLv2H1A2nx3EmzY=;
 b=IB55lv+shWQA8Pg0udi7bJ2lxp6I9Yo/fSOhidBtyPs+i4OPVHLCP1E24QG4ukZorZB0IUc9WyanCnsx/MPfyTaAZrHIDI/PHoW2thbPg75ARkuQI6TraERa0XBhv9lsCIJF1KXDI+4A+X1+Frjw+jK0Cqdp+zSpNo0ZREjvZo1FtdaPuwrCVubD+2BCVxbPUbhQehsweli1lIn9wllQGmvumSl9dutr9FK7WXPzYwnmU0FmvCyD9j8hibZ98FurCBRms8xB9JQl43ilhoDONrrstWYDX9GWVj8XGxfLvC0jnnqDXWaJ+yyI0iQYxc8DCIzJKRdPqQpfEmhs1l9qqw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=chromium.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGY7c+MJ7Zdq/l4paAUX3HApML89rLv2H1A2nx3EmzY=;
 b=Dx7HbTwxNzjPLzqkqA6iEQF5M4Fted5HDvFJgN4PL9Topsa/4JBzs+027So0wTHZG92AJnl8BswyodpBu1BnPOAkdUHBW70L7mnrzNJklSUo3sNCUG3EamsB4idBij+5urWG7geGdGm7AaP/PJF0sxOCPQSetR2InCaNc82Yht9D6xeICnLOIEaxEcXhpgQgGFAzsA1sz20ochZSnH00P1eA6Ai5EKZ8GIFZBjNEc+KO0SSpTnul6ay6dsdEXe7w+BDuj2dlaO0CQV3+ipY2cMxU41C6GUH5VYOBwfkHvqAfO+xLuamhBp4GzWyeVN/0yiMWZ06za8h0gLAmOxqsZA==
Received: from AS9PR06CA0090.eurprd06.prod.outlook.com (2603:10a6:20b:464::7)
 by DB5PR03MB10075.eurprd03.prod.outlook.com (2603:10a6:10:4a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 17:12:34 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:464:cafe::38) by AS9PR06CA0090.outlook.office365.com
 (2603:10a6:20b:464::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Thu, 15 Feb 2024 17:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 17:12:34 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 1D1832009538A; Thu, 15 Feb 2024 17:12:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (unknown
 [104.47.18.104])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id CCAF22008006E; 
 Thu, 15 Feb 2024 17:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnAIUDWc+aXhkIF9ING26d2bEhjmLCGLVclVIL5iKv1EljrnVYxmOiaIjr/T38CYWnylsFQND9QNS+5obvXuKtmIUF+Eg8Ybm9R/xo3ud3pwUHoDaKr8rpap6r3E0pn3C9W7eiCqkw8ZM4FIKSBhV3ZqS5CGhYUXZfRAjH6K9DRRBVEnMg6V905uHoeBnnabIOah8eYcPFbPSzAlIIcgTg1DdotVvuJrhcr3l9vhPvvFpDwlvYGDdJcQjlZHBfEQ+dWWhvP4LxHl6dRkTaQxJwbrrxrwuI6mKP+Cny25Kr4Wwbr7pS4XPMR3XMLCIo5Gv3v3u9JFqFtle61mmn+AVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vGGHewIweCY5GGDSrFRhB2bvhd2e4/+5U5HB+mphTg=;
 b=kG0WCPgUi52CboiLCCMGD0pFRU8PZragoirnut0gInJ6oPB00ATSgO3HGqwr/aEYygEsnzRybVN2BsWJlpHFX6xwAKMi+fOUmOsJxFSxBn89b6iQtbmZYifkL57q5NZdogNh86XDcBKhLLQ9FFruV+kwCdc6o7bzE05WfnYSO8kWOcyU1RB25mX6QMSvwxNUs0MJa9RxWuLkBWLwhMoq4az3LqvuDBlyKDuULSP2oY0Ks5yeO66rLgf4tnhoU/tIBNbhYLc82Ioeu+LrFchjgpm4+HF18VxtjtngUhiy3IaIFqW/I4OdgLV428YUxzdAcMOl9wHcWHv2AJzAWhbXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vGGHewIweCY5GGDSrFRhB2bvhd2e4/+5U5HB+mphTg=;
 b=DgB4OawJpVYH/hAbaDVvIkms0ISRfVteeEXU6lv553HvrApwSmFJ4AKnLvciUPLJTyeSrOjK9uz6JWmcGdrycg3+UQ5SMl4EjpLe7w8vtPF59AcamdJGVLONdgk9monBC/2ygVyGdo35ujaa8lXpVqFV2FIb+2+tMd9VNVO00EDDKGZHofjFME3EqiK4ZZEbUJNZAR4Nq1+YMaeP2xf3yThfp9LaqFo4Rb0mc2WBBeKN6wFaWNJK7CBGidwJqXsQomV5Qm6JSbpCWNWNoNwecGxA+t/WbBvcGb2rW2GhuRUlJOPeEpUxW5hOtddhRW9WgirFTjvTBREOYoiMAXIPjA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AM7PR03MB6659.eurprd03.prod.outlook.com (2603:10a6:20b:1bb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 17:12:31 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::18b0:3c00:30cb:711c%6]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 17:12:31 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Simon Glass <sjg@chromium.org>,
	u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] boot: Only define checksum algos when the hashes are enabled
Date: Thu, 15 Feb 2024 12:12:18 -0500
Message-Id: <20240215171218.3728744-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0222.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::17) To AS8PR03MB8832.eurprd03.prod.outlook.com
 (2603:10a6:20b:56e::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AM7PR03MB6659:EE_|AMS0EPF000001AA:EE_|DB5PR03MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: d36c5030-2d10-41ee-c3f7-08dc2e494d45
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: l9RmlncKpkDdUh0RUUrMM/77reR3gs3aJuJiz5Qc+u/GaH/dvkqT7MfC0SWYWoz8PIUKdyrwEdAN1Qa6TRusuwX6UDjjzgeBbG/TXWO5QZtH2Yca6Yynj5Hdi6/4UwifONsIwQ1LB1Qno4YTtt4uF+Qi3ukMSE8acZLSZbYMEOT7SvDTEpKytIlc7m7Qs4ID22kLyHIjv/RpeAqJKYPx2nFke3Y4ezOe9YDYeRb/qrz2kygmKs1r03l8bscR2RVdid9vmQM/TRzgAu/ckHEfnsiSFu/uv3OS9LuFy1OMXGgdbQ2svMmDwB1YS7FtNvA4Slgg+x9jYLLwlLgf4m+wIkD9xbUcwPDXYTll4RtWrQkRmpua9E9mUo39pbhHYXh1m5k6cgdGO+GJl24xCDCNKlKgtie6+thFo3iK39h5wm/vir9D9NE0ILFA3a/TZKGmASKkGI8ISEIjYSbJiErflO4AyCHAVMULWHUsL+v1/BVs6y1k1MbArI6iOOmaxtgTcGw63PLyioScQIlm+jEHOWVcfkFZydBvrSMjL0dKodnP3w2shUts8pT4zAypUWx+LILFkda0OMvo/0of49zbOlMLz5Vyl6OUsdPTTbMTR06IOBoKqJR1Sa4b2UCWKiOA
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(1076003)(2616005)(26005)(6486002)(2906002)(4326008)(8936002)(8676002)(44832011)(66946007)(5660300002)(66476007)(66556008)(478600001)(316002)(38350700005)(6512007)(6666004)(6506007)(52116002)(54906003)(107886003)(86362001)(36756003)(38100700002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6659
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8f2a6ee3-e5fa-4d81-43e5-08dc2e494ada
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Rakwtcv7Bt0fAC4C/1CF+xMeiLicAZWHg0RhTIy61bZCNFsyIaWdRGvWTA+PKNAm+zr37oZVTV7Cx3STHimvoehaUKDWGyKD3uAxbgNOowIOEfn186TI2/lvfyRPWyTjbA25KmFSdd9fot4ZV77f6FCxgOkhwWD0bqnpzY32L5ZhIGBNpKkY1jBgMHzoNmFjHyKyOFCGi8IzbkJWbZx7phVZKvwQmsb+WhD8+zcUjuurfG+xboO/pZ3HJDQtNfL93TCCM+E/ATVHzyVFefRV5G0rcLM3r9b0LDfrllcP/ieI8XPH93gJzrLBiolCbLL2q7i1MwQNPXqAVgb+5TT5TByHUX651HXlkwYxjAgsA8VOc1cVZm85LHvIRDjWs0w0s6IbmEkb3jqEIPet9SZhjnH+WWi1quxmfuwryaUsJVpuyjkdr3j5DafDpLxaX6D1Uzof94ACYp/Dv1bGNahTZp7yyznQevycBmAInpTJ6ZvEQa3DVTullAZ0IKezF2sWh/lAHF+w7y775TwGMdKMZB6WNGWU2lJvjjQc9U8I9eT9Z7NmuD/HGNKggbK1M7mq5QqAaUNi1W2h1UiYD2lkiA4C2y6o6oWVKe2PqxxfY1oOjbmnT/zjAl0p6W7WjVHGivNpJ64XKieaxl905n7gBw1zKvqt7XUKFbw7Mb5xdU=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(39850400004)(230922051799003)(82310400011)(186009)(451199024)(36860700004)(1800799012)(64100799003)(46966006)(41300700001)(1076003)(2616005)(356005)(7636003)(83380400001)(82740400003)(7596003)(336012)(26005)(4326008)(5660300002)(8936002)(70206006)(8676002)(107886003)(2906002)(44832011)(6512007)(478600001)(6506007)(6486002)(316002)(54906003)(6666004)(36756003)(70586007)(86362001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 17:12:34.3207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c5030-2d10-41ee-c3f7-08dc2e494d45
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR03MB10075
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

Don't define checksum algos when the underlying hashes are not enabled.
This allows disabling these hashes in SPL (or U-Boot).

Fixes: d16b38f4270 ("Add support for SHA384 and SHA512")
Fixes: 646257d1f40 ("rsa: add sha256-rsa2048 algorithm")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 boot/image-sig.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/boot/image-sig.c b/boot/image-sig.c
index b5692d58b24..0421a61b040 100644
--- a/boot/image-sig.c
+++ b/boot/image-sig.c
@@ -17,6 +17,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMAGE_MAX_HASHED_NODES         100

 struct checksum_algo checksum_algos[] =3D {
+#if CONFIG_IS_ENABLED(SHA1)
        {
                .name =3D "sha1",
                .checksum_len =3D SHA1_SUM_LEN,
@@ -24,6 +25,8 @@ struct checksum_algo checksum_algos[] =3D {
                .der_prefix =3D sha1_der_prefix,
                .calculate =3D hash_calculate,
        },
+#endif
+#if CONFIG_IS_ENABLED(SHA256)
        {
                .name =3D "sha256",
                .checksum_len =3D SHA256_SUM_LEN,
@@ -31,7 +34,8 @@ struct checksum_algo checksum_algos[] =3D {
                .der_prefix =3D sha256_der_prefix,
                .calculate =3D hash_calculate,
        },
-#ifdef CONFIG_SHA384
+#endif
+#if CONFIG_IS_ENABLED(SHA384)
        {
                .name =3D "sha384",
                .checksum_len =3D SHA384_SUM_LEN,
@@ -40,7 +44,7 @@ struct checksum_algo checksum_algos[] =3D {
                .calculate =3D hash_calculate,
        },
 #endif
-#ifdef CONFIG_SHA512
+#if CONFIG_IS_ENABLED(SHA512)
        {
                .name =3D "sha512",
                .checksum_len =3D SHA512_SUM_LEN,
--
2.35.1.1320.gc452695387.dirty


[Embedded World 2024, SECO SpA]<https://www.messe-ticket.de/Nuernberg/embed=
dedworld2024/Register/ew24517689>
