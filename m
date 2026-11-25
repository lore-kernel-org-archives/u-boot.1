Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9839606A69D
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U1hbIXFN;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vopgEkIN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B63E60878;
	Wed, 25 Nov 2026 06:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZIkQAK5dLgI; Wed, 25 Nov 2026 06:49:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8F7106069B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795589379;
	b=ZhzCb3FAfWwk7TuR9W9rEoc5L+34Qs1S1w1PMPUzS3z792TmHMFuX9CyUDFcZczZjzek
	 ttvTnox6cyGHpRfF+n9U/i2ebNoT7s/OzqiVpI6xz0kN/cJSDponFDIXE4O5tU0/C3Wxd
	 TkT2mAOkqvGMRDNcipd1xCilSYTnaxZiUU6bccCXxArUI3NePViJhZ+G9UPjAU1vkANOv
	 kSArF9xqr52R/MozN7c4HleUEVk54ST99+F4KGfRKayQPYLnXKlMziLgVwvu4Pw3nQbrA
	 ZSm+YIq5Aq2WEpmIkeGrxHvBF5QswmiWCFPUMvbAw+djGMJDvB2XfmOUrhVhC+yk8cA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795589379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vTfgFwDDZAURM6GEqnvdRPjjURj1Sl3y3jO0c7U2xa0=;
	b=UHBdmbEwaGmRfIWar2Hggqrsrl/Qdlmgm+atWS1RoRMBJd0dlJPcBnmFbo+zV/899nx8
	 bwzpP8J8F9K8TE5rgzZcEifLOcU2LZFA6fP5pVXADVY1GvQVryGMO60zYmrCIwUFXOars
	 L/B1q8/pag5R5vTmLxv4roWtz5WvMHQaS21ljaoeahWqb4nGLuuMCL74HJnjArEHdOowC
	 gIFcWds+cVWdoQAWEip/HgkNhGnOl6fjPiwGO5M0c6zv6tCX5ooVIYJEJ+QjbODS1hVGF
	 BYv/0WmdpD/BekgBqkVxRh9tF1Ed8NrXN55rYFgCf2qG+75YcYWZWWfeHS14uLhGGxA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=fail header.from=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=vopgEkIN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795589379;
	bh=vTfgFwDDZAURM6GEqnvdRPjjURj1Sl3y3jO0c7U2xa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U1hbIXFNw4uPLolSVwddfUae5WBOk7WyyAif8xRydbv2jNn/G2BrKcgLNtH1160Qh
	 5AjdZMyZlEj3uv7+p1kq69baKJIPohGdovYWkpR4vOPCpgb21DV4WI1f0VrRCWMp2w
	 trUq0xUUM3dKPiRvyTMoUHIHojmL1QJ/5+zVIYBfMQSEkvgvvKFCwQ4pc1Zz0IgLc6
	 cXseWjOzUS5vrGmOcHSi9ly9aoTl9m8si+665dAWriKr2B9tT3k/NA6y6bo3XKHskf
	 EPzd8XwgL8+82EEXheaQdRb2oLa2bAmJ+fTnb0eGkWoTsjbwKhg0LV4AdzUzoHH6zP
	 uLf7IQFVxc3ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F7106069B;
	Wed, 25 Nov 2026 06:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5ED8A2DF
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50BF56069B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhqBi_-7pauw for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 06:49:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 92E1960664
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=vopgEkIN
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92E1960664
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 06:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTfgFwDDZAURM6GEqnvdRPjjURj1Sl3y3jO0c7U2xa0=;
 b=vopgEkINGjg1LI3mqoOTVfGOe71GywwwOUjRJAhLi5EczylokmNtVw75mvwqrAIFiDV0vlf4Y2yseZGX3Bd46HH0uyF1wATgVaLGQPkyKwFPLehfTM/ZeSuExhwDaM5awywhaDIlHUAxyCWQ3MVvKiHxH0ZdVsUgBiu6IyEyk/CEC5kf4hC2hzZmOHC7WiNcLy8PZ+f29Yy6PReAWY9JmmLw4r1MK+ccZGW1sClZLXnK4h+ijBLWiCYyRoad53gLTTIsmfzgsQ19VSuVMjfSs4+pa8dnH6MamDrfM4dRZ0tS0FP34NBMlXB3lCNm1h5fggu5BDhs9CqoT7Bo5+FO/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRWPR04MB11281.eurprd04.prod.outlook.com (2603:10a6:d10:19e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:49:31 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 06:49:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 u-boot@lists.u-boot-project.org, u-boot@ew.tq-group.com
Subject: Re: [PATCH] include: spl.h: add return code documentation for
 spl_load_imx_container
Date: Wed, 25 Nov 2026 14:46:31 +0800
Message-ID: <20261125064632.27062-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261120075445.2545358-1-Max.Merchel@ew.tq-group.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRWPR04MB11281:EE_
X-MS-Office365-Filtering-Correlation-Id: 01890713-d1a1-4c8a-1d14-08df4ac04164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|19092799006|10067099003|56012099006|11063799006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Gy3dOd3vIafvvm7+jAuprZ3QwlG+uRWrjkscfiCtYIPNkOiSS9yAf+dkVryCHdZ/dReHrlT6R0Hs86ug1fMtUgbXDpgRM5nRKyL9t2GPUW1EXVWgrx52saOv6mY8Wlzpp/5+kw/n/BmLG8h5wrBSlNgkOJ9gGvX4hE5EkXhsVHuqDsvcj5acmDyC7s7Vw6nkYgnqxJuUgZXVDz++Y26LDz3SaGmlW/FlJMl/KTQjgydfeFJ6hObfg4EyXKlP8JuXGjYaOhhLa5yTj0YnO156MGAxqcnsjGpT4U5R/Ymq+y8MP9Syuxcy1B6SNIYkpXHjc0Jw1CCfCr42mjB5qCczyNgg/SxKJeNakVQCh3kvklR8J1rGhB/pfrBeyERSjCSxeoldaUI8C9ihrKTk7V8hJkaZnvOmv71yJERB/RVb0xzXiY+2HULgnuoJ9tLoDyL6sC2GyLufXx0EYljCdHeRrZGaoWVAkN2Z/Q2NrftaRpYDX+zGw2uMV7fwTZcCX3XdbT5B/MydbtY5tk3DNBwgaEF6nvQVnqMKWuJw/R36XtkqGop333ViP01fypO0gjxtflV5Ha+jbCLAdC5o8+Y3KGWIQiMGdlAWlNHokDHjGt7uRMqces8e0U+0gUcF9qLZTaK8URe2DP9/XrgDoNAaKBKN/Jp+I+fmPgeVuCMOTj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bz/M9uh1wj5Plaz4xj/uSipSXr2smzeXP9a6RbZaFTfu1u6jZ71/kNSZzN10?=
 =?us-ascii?Q?PGREZhyXwPay7morDMkEYSSA5cedtn/gkbCHiBFZQXU/jTUXvrV1SOdN7D9K?=
 =?us-ascii?Q?4dGLfpsQhDd3mBqc6JGwgwuGPGqNKTCeFUXCq5ffSKXqH+fdWK3xcCBS/gsB?=
 =?us-ascii?Q?iH72zVVFv2ZGY1TKqTwRa8TWn4hZEC0qWtFjn1yHhCl+rHgJA4qbSfgBMNCa?=
 =?us-ascii?Q?Kxx26Zgu4xS+4AVOw2SkenzAmv1P2/7qbH3OBdJnJplurIZALKdM03Six4UC?=
 =?us-ascii?Q?R1180mbyOSn7JToP8xqxcZNVU+Haic4x1DcWe8BaLf6p7VV/RfloLNa0COAX?=
 =?us-ascii?Q?Va5Bsa3IVZf3fO1MtkREAzOaZdW0PYyvk9YlF7CX/8Petgz+5M+IQeqPOPZu?=
 =?us-ascii?Q?JvX1omooiRgr+80fD1qsdybBM7aOF/qijVlcSXZaeEpE2xFIlf+BjGbvFVDw?=
 =?us-ascii?Q?069wfl9t3d7oRgSfACUnoBJVdeQvUVzNPdf9B5NINVRhP4rihhw8u1Pl7rkV?=
 =?us-ascii?Q?3UtEtHMwvkOV8JBgEDkr58UYdR75jhzWqlcGVQhumezKPDn+dLBriPDScGnU?=
 =?us-ascii?Q?g8FHUTtL5bQ7hxUWvqR5jb6W/Jfnyua3XF2t0i7vMDhwNeXBnea5zeg1p1dm?=
 =?us-ascii?Q?YOxjExKqM4aFTuk7P201wshl60CydThKuAUhr2YZbRas/1ztnpADLVMZ9WBA?=
 =?us-ascii?Q?IQE3etiRQx1DecXBDwNNXUsZwtpEIu/wuo5XQ3pcdm4X/xt/2WKaTaWsKuO3?=
 =?us-ascii?Q?SwX/0cxBbxF3p3cSoo9Woem8Qc3OUcDHmwXdQDj6ieEmJ5+SHLVm6Feb5dNJ?=
 =?us-ascii?Q?O2+v2EnbCUtVERluvCWfFFFhks/sfEEYsaVPNNjvtbf9A7zLesPYEqXAV3nq?=
 =?us-ascii?Q?kVtNPhnitnaTNt+uLZvZZk4RP5wlOppTqIPiQ0+zIJcrLSNn1ZfUmQZ7mInC?=
 =?us-ascii?Q?Ak2W+CD2b5vGOS6SuWBfu0wPNQT37VYYV1Uxoz51izJfFEjdv/d6xDxYmVph?=
 =?us-ascii?Q?QNbV666uxn6XPgR1ENCEBvf481UEDL4yXdbcEYgEgutZsZs/8aD9SA9UuWUx?=
 =?us-ascii?Q?E40v1AsEyqmenrxgA86xVIocmGd2HOI1k4Ru/J26yIE5YI0Wkv3kd1WvDHd4?=
 =?us-ascii?Q?Vjp3nW+Q3HQ+ufEQwygyDPdsUy8HYFjv4FV6vcv3V2UB4v4jom4pM0S6Kj8I?=
 =?us-ascii?Q?BO4pE5zFpGbY1G7YmgWeHnVST8FAhImBsuADs5IW+w2u0BZ5jXfLT/FsTrT6?=
 =?us-ascii?Q?TXMUn/19n1XAyZjQ6QmvhfcEyK55TrYZMSHJPOyPVVt27BFD/bup2w9HWWpt?=
 =?us-ascii?Q?rdssQXuSHOWBN5yFGRUqsLv4DRWARR8c5+pfeMcNclX0Ucg/OZGhpwX1W0nX?=
 =?us-ascii?Q?xveHaQOet3ZGyJiAfs9SntqEBFR9Nyy50wZN5xETJPy3lbUkMGuGZsCFCj5k?=
 =?us-ascii?Q?wx31BdHf1hx0z/uRWE4s9r18prVbYzXVQShDiyLXaDFMgRR9h+6LbG5tpGiz?=
 =?us-ascii?Q?6a0vLXbNhLDm2AQB/Dy/ZcX/lJjq2p/gsAqahc7MuHw3qFTutVQ7x0CxTcm8?=
 =?us-ascii?Q?Z1o7FsmHruK2doUw/gfOHKnc/QLo1qhUtRfKAqeHqTawEbyAexNsP5Pcya9E?=
 =?us-ascii?Q?abqo8xIJzX7N3RQXe4BhkA7wAypHB+ExuSyBFcwS+kgI1al0PNMfy3Zn1DGC?=
 =?us-ascii?Q?/vT+rNcSlVtQsYcn9f10JAKvTIVuFTa+nK3cHanjHID8IbCMnb8/RgAYqhyD?=
 =?us-ascii?Q?YSP8sQFvYOBgsyWijDzcV3/TW9YSg8MnVbykjj6qYCMuiBkCMH8o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01890713-d1a1-4c8a-1d14-08df4ac04164
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:49:30.2738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtZsSASqlb652SUeSRcaEM1LaPpE37fTi51guiANFK+P6HY+IaeHSaeI7vn0GmjJ3GJ5D2Ea4PoumSnxGepfq54o9nW/YgDiGH+QdLSN6FO3h09K6xkZh7q98Lr6mUZ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11281
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 08:54:43 +0100 Max Merchel <Max.Merchel@ew.tq-group.com> wrote:

> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Document the return code to improe readability.
> 
> Fixes: dd7d0911e004 ("spl: mmc: support loading i.MX container format file")
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
