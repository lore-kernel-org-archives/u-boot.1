Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4150606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T5mAlj7r;
	dkim=pass (2048-bit key, unprotected) header.d=OUTLOOK.IN header.i=@OUTLOOK.IN header.a=rsa-sha256 header.s=selector1 header.b=QbkRIRDt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C88AA608B2;
	Wed, 21 Oct 2026 12:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hbSBbT3aJb0U; Wed, 21 Oct 2026 12:46:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1ABA2608F7
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792586770;
	b=Bj9Sl1mTu1IxNL1wvFrDF1+ZQYVPBL2R2EHSD9ViaqcdEEmerrlRwSB3L6eP0T4lzMS0
	 ACcdg6o7xzqNRmftYyDwY6PwWgKAC7rWl8NCe44/dITirRzfo6RjF6iHAphsluVHLrX4P
	 kTkzQPGfFga49R5ceJFtxYhOIgxhKICjIUDqR4aIcmgys9Wl8iTB/IT/b1wi1APxnR7Fr
	 NqjC20n7otOXeYMryfW/bOD/hQN/ZGgpL01oOX6cJDPJgddf+cLMAEiMwh+Uu8oKHpHIO
	 nu/UvmH5jBxw7b4xHt9s8n0R5IOxcaYuOBLk2E2ATNATCveVsg5QHXS4z0zwXkM+QeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792586770;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:X-Microsoft-Original-Message-ID:
	 MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RjbBr9f9IBQk3QLgShj3d76IHPvkVXBCJ6+5LVQ4ucM=;
	b=lIm+Ov8Bow7hRLyCCZYu7GbaDEtHNqBhjb3g/BCjzU/7bulv5DYufbTTeQZrTmPjeVq9
	 xTsto678/ceZbkSbk4kL2D0kTiQtYS+u0USwTyKGJ2gEmphYmg2L8MZcz9sypnftUhtyx
	 /7bm3RzJpZrPc5mhGr6iRvwQGdtdTXlkKwo+qc4RH6mYkUQmwm/ldhe12WaS4FTO8kdB8
	 gevrTGs78kRLyL3HYE3d1Mm/U5gHhuKzg4JBZMp2rjQ5i1FcUsReznYhsGOh68Wljx4v0
	 1IW348gSvPchCg6754hjbRBgIL77Q3bTvNEUBfgvo/ocmwdd0mFQOfmUe3Ohuqe65/w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=outlook.in;
	dkim=pass header.d=OUTLOOK.IN header.i=@OUTLOOK.IN header.a=rsa-sha256 header.s=selector1 header.b=QbkRIRDt;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792586770;
	bh=RjbBr9f9IBQk3QLgShj3d76IHPvkVXBCJ6+5LVQ4ucM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T5mAlj7rUIHPZOJIB1DQNCZWUAnKKhmu/PFtdmceUPc3gNj3Fp1vvp9v9KoOQKdfJ
	 7djTjWk8zQrbtvQb6rVXdGR/j4RNlgePJj0ctKpBOKneEJmtf52JgjPWsIelzRouYC
	 yZ2aSaIBirbbKUYYnUVpUXkFWP7yQjjoJGClqmCap+EQPx98A7wkwthVjSsYVI849r
	 vtEUOqAGF1w7X/0o42kijABkkv8WY3Kcc0uHoz6EE3uCJTSlN5hZTowY+5LQVCDT51
	 BF+QggLNSadbezxNyaP4dAU0egKyBXpjg3/nOD7PKEvYyO4PqC3qStuWMZl2Rpxy0p
	 tHkY87M6eYz9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ABA2608F7;
	Wed, 21 Oct 2026 12:46:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D5A211AB
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:50:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D304760773
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:50:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZYGPzob5ZPQ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:50:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC72C60719
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:d406::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792583445;
 b=T7xBaXZ+dVpzerWwMHQUqad5F5ePGyKA/70PAVTO+qivL7TFi+deUeVBfeeJ61m7UJeW
 DfIqmh22Npka11xZMm5FEqzJI+ZonKZNJqYfG1T0ualclJajc8OJGqgI8B/8RyaQnrzhD
 VflsqP1zkNaKp8khvYJb5Xn0/Ah2e9trVNhRGtzmuVJ12xyggGpHTgk5hJXjVcclgIIAk
 GCxXmZBDWzix86VJJdQ/xofutnRknNxSvie+Ai1TYWt1yBWFCFp4oxq0c9HehF60WZTWp
 bmcGdx+bKxxgdMe1lSM0ZHBZ85KotNeYPHj59UMdIHL2J5nvSBc1P1XSrohwLAeZYCQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792583445;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
 X-Microsoft-Original-Message-ID:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=RjbBr9f9IBQk3QLgShj3d76IHPvkVXBCJ6+5LVQ4ucM=;
 b=OUjfVG+ZmZQQumbVs8UzOC9A61uhnsnXy6xtbbhAKiGzwZ8ku+rM3NCBM0l7OxXjRfK2
 scVGqLhYClXUomDszGsYR0jMMkt0UFDCFt3T1ekgavDvoDKCwXnPWRAVNNlRXS8h7By95
 PfaBmqGH1+Lzfo4gStE0bqjiN+/0ZTENz2jSB59N8gOenFtCbu78rIvxF1bBjPb4aoLDk
 7t23SwqqmHjq7EJSI0bBxrus30p1aUCNJOp563PzZGowDNBWLnU+eczEGdROA/JyMspx8
 QNNJpbUQmHj7r9mHLWIFJdRx04CBsWn4DTdPhph9II/5YIIcFpi4KLYAVJVg/50gjLg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=outlook.in;
 dkim=pass header.d=OUTLOOK.IN header.i=@OUTLOOK.IN header.a=rsa-sha256
 header.s=selector1 header.b=QbkRIRDt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:d406::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:d406::1;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=shujath@outlook.in; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=outlook.in
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=OUTLOOK.IN header.i=@OUTLOOK.IN header.a=rsa-sha256
 header.s=selector1 header.b=QbkRIRDt
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC72C60719
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:50:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZWtrNCP8pCNMDDDTJtl3hUHIlvEqcNYNVaHo8tFEvBEnNUHjvhSY6dUaBtOlAXNS13Pg69UvlKCz8aYEA5x0xkvvJ9skIDqhW9wBTVsJ2g3dv7TEHzCVo4JGW2TrKYXxQ0+hdPJ4a5BvxEcmR1FVLy3Za/e2FLeuo6tSeZbsFbDMWPBt7o6ncKeLhaECmHSNyGZb9pfHKrPOAnDQWT1eXGGSTu1fN1yAYwp6GI2d4s6Yv8mo4Uh+1dDrI8qJ3ZP9Tloixm2Hno4xMhJwV9jUMWbUPD23r9TrDYi+QSdiwYRNFZOHNiC/6mopUqkebr9t1OTaHCPPpY5D1s+SA5ZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjbBr9f9IBQk3QLgShj3d76IHPvkVXBCJ6+5LVQ4ucM=;
 b=iizSRSA78NYIRomrqj7NxEnp4jMMx/csK1X3KgjOWf+1YOk+sCAGatdGCOhoAQAxebG+1X9av5Zihe58Xq+HGMx1v64pXqNEBkow1xmj1OL3jGsNd2hjtgoIKJaO+hYchu02vixrygY5Uv8o7gfUVkFOmWe7NplWZ/juiahRWpPyexra326I3heAEx0HjaGutXIu1Q7pOLKTRZYTE0jMhDnjE3dzC5LI1t0de+lFFM59Oz3ZS445IEMurKpfQzBROHaOUI4CUvj3xe9CEjbP79smKRrrjXDIQcpdKkSusxcwskKdoHVoaP0XP5bn064YqVYKbkzhaUv0bXHQF1wXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IN;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjbBr9f9IBQk3QLgShj3d76IHPvkVXBCJ6+5LVQ4ucM=;
 b=QbkRIRDtNkqsG2fPTCGjyTTfq/CUPIy6NWzIWCZd9IO3tfW+XmyBroTCemJQiUi76vic133PXcHMv6BCSd7bxHlcVyZ4+hvYlgB6KT5u1y4x/rMArwdHQMdCd1o6QkX+UMmK4E3pAVNMhPTCRcDDzLLiSXF7jktr4we+2hAmyUZbK7S9hlJJC1ebcylwaWg+ITlYxDoA2W3KbYPVJIlsaSRt/XNAllgKqmTE2IxK/0DccEmhEJ6DjkPQgJAvy4rGy4gspt8u9TKb3NGMdNKX1WEr3pnK1tLn5US0OO97v1N5GRp4W9eA6zdFHU4IWD9sve7VUH0UljE4uXFFSIj53w==
Received: from TYSPR01MB6204.apcprd01.prod.exchangelabs.com
 (2603:1096:405:53::14) by SI2PR01MB4179.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1aa::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:50:31 +0000
Received: from TYSPR01MB6204.apcprd01.prod.exchangelabs.com
 ([fe80::fb31:bf3b:597e:24e3]) by TYSPR01MB6204.apcprd01.prod.exchangelabs.com
 ([fe80::fb31:bf3b:597e:24e3%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:50:30 +0000
From: Shujath Mohd <shujath@outlook.in>
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io,
 sumit.garg@kernel.org, neil.armstrong@linaro.org, bhupesh.linux@gmail.com,
 n-francis@ti.com, casey.connolly@linaro.org, trini@konsulko.com,
 angelogioacchino.delregno@collabora.com, marek.vasut+renesas@mailbox.org,
 padmarao.begari@amd.com, macpaul.lin@mediatek.com, jstephan@baylibre.com,
 hayashi.kunihiko@socionext.com, shawn.lin@rock-chips.com,
 j-mcarthur@ti.com, michal.simek@amd.com,
 igor.belwon@mentallysanemainliners.org, tuyen.dang.xa@renesas.com,
 alchark@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, bmeng.cn@gmail.com, dlechner@baylibre.com,
 ilias.apalodimas@linaro.org, kory.maincent@bootlin.com, peng.fan@nxp.com,
 visitorckw@gmail.com, j@jannau.net, raymond.mao@riscstar.com,
 quentin.schulz@cherry.de, philip.molloy@analog.com,
 jerome.forissier@arm.com, Markus.Niebel@ew.tq-group.de, petr@acrux.cz
Subject: Re: [PATCH u-boot 0/8] ufs: Sony Yoshino/Tama (MSM8998 / SDM845) UFS
 bring-up
Date: Wed, 21 Oct 2026 17:20:15 +0530
Message-ID: <TYSPR01MB6204358F0E03286B7530CE78C3662@TYSPR01MB6204.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
References: <20261004-b4-ufs-sony-v1-0-54e71c95ba62@protonmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0193.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::7) To TYSPR01MB6204.apcprd01.prod.exchangelabs.com
 (2603:1096:405:53::14)
X-Microsoft-Original-Message-ID: <20261021115015.49866-1-shujath@outlook.in>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR01MB6204:EE_|SI2PR01MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bcab5d-08a8-4045-9d22-08df2f6981a9
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|23021999003|13031999006|24021099003|39105399006|8060799015|260925184616899003|19110799012|5072599009|4140399003|25010399006|1602099012|40105399003|10035399007|31055399003|18071099003|440099028|4302099013|26104999009|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pQjQNQDT6CXsY/kK98wz1X+cMsgL2SW1U/oMAfYlzaoyT4Dgv9kjaIxAnBen?=
 =?us-ascii?Q?7HRZVx3ZMx9cwe/DzYbweBdZ4J/gYEOCq7SR14z26JXu3/7yUcVt2qJepvkU?=
 =?us-ascii?Q?nL5k2xttQcZ5q3qVX+4ut7GxwLacf9RY3SxTAnQdNXRfXF6XBAmBc5KKTh8o?=
 =?us-ascii?Q?Z69qXwzaiXt2va1Ch/vRdLTjJw15C7G3iHmE1kRQvHRZnVyRFMNj/OK6BSpM?=
 =?us-ascii?Q?KobI7eiHsm+m/MnzyTqothW1RClG/qbKQ/A7CUdjxFFVXBnDcugRHXoi3wQw?=
 =?us-ascii?Q?ztc1SMUsci9tSBWmmq7A6+oSOXZHYeTEqZa+TW7h3I87wxsImGtCFrM7Ssen?=
 =?us-ascii?Q?OPYCBd4Jqz8k1B45MX673Cs5uAhhe+LalK6MByKkk8GRdTQAH65w2oghz804?=
 =?us-ascii?Q?PDqICqfQdcu24MjSXQTUU8Mmh+xGuRcjlFIqmK0U9BIovfoMw4bgCkSiih1D?=
 =?us-ascii?Q?5N+18uT1TlCdFZX2bO5ipKWTmnxzQtMeuwa2IsCmGBLZIigJ0Xf7Ba/uE12q?=
 =?us-ascii?Q?noyge5sYehM1jbVmL2GDk8pDn7KDEvcdTq9ldsZ9HuTI3ma9GmB0XlaliWVD?=
 =?us-ascii?Q?Zeqt4GrS+NVBwfvpozqnI4GrkjkIAR105gyn0Gt8/MqvjhUjdmUOK/rf9NiH?=
 =?us-ascii?Q?sy+NEuNUH3ViKc/qZ88hu/VzWZbbJkMmGWITK5gE+55d9LnklA+I+uCfjczK?=
 =?us-ascii?Q?VgyxkHDTUvu+CQOy8giujYpYtoU6wrcgC1joTEuhx19Go/xXztxHEwCsfQ/o?=
 =?us-ascii?Q?xtWvR3n+eFdeJTvMakVeEbt2wwaX6Wyt+YCb8wk1i3G+NF6mnSS8FFSo0plD?=
 =?us-ascii?Q?jP65Ep9Wh95T/sq92BeqcDP/10h02wl/FNZ6Zu0lVYklaMJEmuNM9tqq4QMq?=
 =?us-ascii?Q?b9mqvpR549030lnynANfs52GNDcTlecs0xYBhW8EkpRdj5z3TMbfc/9TZBKf?=
 =?us-ascii?Q?gvETo0+SyjttByxBbTItOWwBFWVOM55/91wB1dgiZ4TpKOJAY1UD+Hvw20aZ?=
 =?us-ascii?Q?S6CT+JsRJ+Pf+iI1EPLNb3WvcglCFh9po1SRgD3HLug5iz5MldGmsulj1ac2?=
 =?us-ascii?Q?kxVpP0ShgzmIZKhXLqGh2NZdCp9MeA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X2e6U2/8kZdJI9SVYPHH8zDwG3pYobBrO+dc/zczyJvANSIcYsNInOiQj3Ol?=
 =?us-ascii?Q?lyuVkxpDn/0usb6bruFQbqyn9FeY9JhO0UXbfp8vX72CFK1c8xQcxcnBnlwa?=
 =?us-ascii?Q?H/mPUztpx5MdxnenbOVK4uIxXHMQBR8TDAFILx0DSNlln+tPbXvQtxWIbVNv?=
 =?us-ascii?Q?T3Ik1+FHHycYjqwarhfk2I74d0OgjEE8FKCG4JxjEk3QOqWQVIffCQZ6iCkU?=
 =?us-ascii?Q?D++7ImYvmNl6fI2UYfEDAurQZkmBrEZppvjNxLXfy0xZfeSqHmu+wmwf6kiL?=
 =?us-ascii?Q?tBwNq+X4iTYsF0jSHrhJRE6n7y2I5pyt05uHPWE0O7dgNxUTUMK/bz6S2eeW?=
 =?us-ascii?Q?QWUEOLQV6yt4zM41yHFagqgKFr9LLldYB5E1lCkvInCC0+a0K/NMy+RBu4Ww?=
 =?us-ascii?Q?XCoN4SXCWciJUY8l17dmMee48u7Qtf8UXYhsQOtYdq2qXuTkE7PnIcfwQSNP?=
 =?us-ascii?Q?PVBZhl2+dkRKKX+snPxQFoVddbJGTfCQvI2EiY4vLC2sd/i2ayj2zxmCj8zn?=
 =?us-ascii?Q?XBvN0NTN3YEoQE2Rdc8KgzA7kbG9CxjmwNeYtb0juCA8tbWcAxaqaLEbAqUx?=
 =?us-ascii?Q?m3qZFEjlmpcAlMQtR2/9rQJuxOPvFhGQ27qPJhvWVMmmoKamVoirp7qfIBvA?=
 =?us-ascii?Q?LHRCVJTvaR/F9t02pD4TTpQ8I9Xt6mqU2ysdZf1g9doMO0VBviJpuojaVo29?=
 =?us-ascii?Q?saorvt0cnS0u8xLMtmpp0yVQ5MDYq0FJTHiOlgYv54Mt8vJyW29Q/zCBUcCX?=
 =?us-ascii?Q?KYQm8Epa3fQ09kvjqI96DLaJWgGpvkeUYmhm3kmP7KJPQQyRcVjtleVHT/LB?=
 =?us-ascii?Q?kPXMY+VnJay/ZIwPczaV/so43UDQ3NwJ07pkJgCweSQxfVWoufbULi7NdEU5?=
 =?us-ascii?Q?+0gUGZDL41c8ICXAnc6Vm1V3NVMtzSjZqsCu7J3JrSVb4yfSwOy5i6Zy7kLY?=
 =?us-ascii?Q?+vFVYiC5bigjgAClXFk8uK8nJRsiYVP22n6P3ht1mqxUmjlagawbqGkYV4Du?=
 =?us-ascii?Q?c2zVsamGanDoVr0S7BuG/DE1C0lV4XugJeMf9dFQkXxltsOfgQogL9c5pVxL?=
 =?us-ascii?Q?uPQFnFztpGtNv4z9QbBpospxRRPifmVT2evC7ZGWYY6lxkf78iml/IMHXCht?=
 =?us-ascii?Q?HIhJucRXJYie0MJF9NaFV/AyDoVCdC2T2fBObM5KQMN41tXEM8VVXSAXbaWt?=
 =?us-ascii?Q?KqVGUI2AVcyjO2yU3Od4bhIr2epJ6vrgrcdNawEsBoxXc3j0SvAraVIdjOAU?=
 =?us-ascii?Q?5a/W8uvyZPVhzFZ3L/mDlxW+Qx0c/ybqxOnum7Ob8F2MqbSpDxZWYkD6T2kk?=
 =?us-ascii?Q?37Pb2XMfknf7bSF87riVAhxztYoGDbAGkpfb1vUdXnud9g5tRKJMsomsFDfc?=
 =?us-ascii?Q?PRrB4nBHTf33WNO3Aw+Zh+nHKtP1?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bcab5d-08a8-4045-9d22-08df2f6981a9
X-MS-Exchange-CrossTenant-AuthSource: TYSPR01MB6204.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:50:30.8279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4179
X-Mailman-Approved-At: Wed, 21 Oct 2026 12:45:42 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Petr,

I submitted a patch to enable the UFS host controller and PHY on Sony Xperia Tama devices:
https://lore.kernel.org/all/PUZPR01MB514158F5EDA660AC85FA8D5BC3BB2/

The patch provides the required reset GPIO and regulator supplies and enables the existing UFS controller and PHY nodes. I tested it on the Xperia XZ2, XZ2 Compact, and XZ3 across multiple reboots without observing any UFS data loss or corruption.

Based on my investigation and testing, I am confident that the historical PURGE-related concern does not apply to the SDM845 Tama devices. The UFS controller initializes and operates correctly with the appropriate hardware configuration, without requiring additional UFS quirks in the Linux device tree.

I wanted to share these findings so they can be considered alongside your work, particularly for the SDM845 Tama devices.

Thanks for your work on UFS support.

Best regards,
Shujath
