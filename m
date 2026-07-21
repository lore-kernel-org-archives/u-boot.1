Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55571C4452D
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7333180E50;
	Tue, 21 Jul 2026 06:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yzL941kM6U7V; Tue, 21 Jul 2026 06:16:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4197780E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784614605;
	bh=UNUeUhIfktQI9l4LwFUOAv3T7bDgu7YIxdIA5SENr3Q=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=n7xAvYBzj5KFVfNft0jwln0QsheF8gdhEmgtAcuxDPkX0XewEV2c459VOfaCKOFkn
	 DEySNyzLy46lrRgs/J5035Ve2TjM+KGkC9JotH3GpClUZw4k2bgG0wmPWLeDKd9wdl
	 z7OdgXmI9+lgORL7wM9dK7r/QB9Txns2gm5lbpmL5C55rUo0id/aY3tz5i26A5pJoM
	 jI5YV7VVJmJsRDJvfNn6LpeAFZt5bhqNDndS6vlfLR5LIzOUUI/U1asWBffl1/gd3Q
	 uCTG9B0mxhykXI2L+R+31tsJibuaY6CsafvSKo7DiTaUd4x04ZcEXkBCzrdjeKFAgp
	 IJduKSPVBRZVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4197780E3E;
	Tue, 21 Jul 2026 06:16:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5847CEB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A68C607D8
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TEk6yMlJVPdh for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:16:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB673607DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB673607DB
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB673607DB
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:16:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A996844F6; Tue, 21 Jul 2026 08:16:39 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2077E846A4
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:16:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kao5KolYf51op+Z7H2IvqTG38jyBjVzuJDQLgowXQwPhjSFrMxLh1h80Yt4t4YJarymX3wP5dA64/k6WQWyyFN9bXeBlj1rm0jgkpGUWHtseCyrpPPgzW/a3AKcEQzTh29CiI3FHZNOIk3h6mZGF7ithaupOKbDzaag6y6q0jwGrPA5RGQytuQrxdfK3tAAl0+pLxbizB8FhUMC8exBioyj79zuBakCEnZB8ot4iT2DEqohvS5pBG1TNlrem58vay8ZcvBuWMy7ZeKJu6t6GDPKU/D6NFpZr1qmRZ3uvrhoxqb8OVNt2tjG9qO0cwEfA3I2EOBUA72nXs7YQMiM6eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNUeUhIfktQI9l4LwFUOAv3T7bDgu7YIxdIA5SENr3Q=;
 b=st8pM2VJwCu9GsRxHHld3wS+BoDbB2P53XiPgBc9RDCyHSYp33myrGJXrHzrWGAWQ38Jplqg0JB9qCyUTqNkezarlK3WnzP5KdAW1IoZKoE9DCPun7qBH/Ge8x6X9SXCm+0PZKW5iE+cPrrtRuH7VnYSVHEgpmvdlfmyiE1theM7hmozN0SNjadQz04WmtIfi0iVKIPdIHNexqtWVN0QxIkXZcgH1G8KKbjvXaptB2i1I6UqiptAP+jNTrNrmOlBw473A7FO0ti7I9wTl1zmyQmOCO7f3CSmLLGPMAIvMnxstDZy+xCPpHa46oSYrGpm0R3TgHgGnMVynwYS7qGT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB7031.namprd03.prod.outlook.com (2603:10b6:806:337::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Tue, 21 Jul
 2026 06:16:33 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:16:33 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH v2 2/3] arm: socfpga: Add SPL fitImage config match
Date: Tue, 21 Jul 2026 14:16:12 +0800
Message-Id: <20260721061613.8615-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260304033029.10825-1-dinesh.maniyam@altera.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0131.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae098e0-b4a0-4beb-e7f6-08dee6ef9cc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|11063799006|10067099003|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: yLetPgVytgj40vchruelhhudPc2TUxaZow/Bkpq3Hrm+KWOnOHl4fw9yNg81vtTFIdJh+jWeetffVV3JnpsAmBWycYncfRi8UHJQZIu3bL8ZkjCA9DIaRgkOE9xVvx0ffiyqDfHdHImzyLBKU5xPcmwzQNFGpTCDFAvS3nDljZBC14Ai3Qino/HpL1jkbLs3+45kD2oKOuAP4V3T2dYEpJbWrhEuvqtcWe7jo5E/z8bY1Qm1EbFHpGhGsYkQZooOX25oEUBhwLxpdtQrNwyT12KKSMFtbu3lTfh15ShW89/nG6VGBP6yfqTuecqfoP7soScIXb7m0zj1JjA00Rpz2Kw766YZrBUby3sFkZcf4UfVplrlqwHHk79c6zOB6A/cG2UzNYJlK5Cpn9cXfqgVZUf+iJBw45dxaRnOi9KcqP/hiNAdcUI9Qfr0M3uamH939vRfUkmyZtEH+SN8sY948keg84iiGwa5QCKyXDeDUX28hK/6TkkW/h1DcxduVmqY3+WPhTEnZ7cNGVPXeMBvYnqhK0r174xG+vEyRvEouqrED5EqHM/43ECmNC3TmrhyF+1mNW8VorCtMbA7IPM8plhgXT6YzBFZaqqYapXyTKwHZvEoJxhRIzOpWYP7ZlIzzEcy+HeCAxOfYI3CYMuTzZP1Xsy2LLVz+Efa1Upzy5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(55112099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQNTachHUZ36TkAeXmYJ3NeVlc0tTyyFs+PzNC/VVtKVr4KrGsXFrxRvKTkj?=
 =?us-ascii?Q?+MpScEErmHuC/Usm4pO+TqLHW+6H5thNms1DTRbYKDP7dnRVylHh80kFPJtJ?=
 =?us-ascii?Q?H85mrBA+hUwSYgx2Of2SOixxQg56SkYLHZBAs7Y9/PW3WHbFZRInpSoi+1ej?=
 =?us-ascii?Q?AZLjBVidNAD/D2G1pfQX5LXWw8YSjAI0WAu6WkosH45H8CxpjbpFY4ozcx6U?=
 =?us-ascii?Q?BDLyHTISas+1h0ukcomPO51gW5BKEvVk0G9CjuS/AfBB1njbueOaMbz4D2Ts?=
 =?us-ascii?Q?Bo20Olt5wJ7v0i1avyGJNhRtogogmWXVusxO/GnM2pDQnO736b+cnQplUJ3a?=
 =?us-ascii?Q?NxIhwfKqb94Ghl6J5ATA/XephZqrnXuXongqhuTtbDd8tO9drGO9Xj1D47r9?=
 =?us-ascii?Q?VomMXwKn22gMNP9QxH/M9NlNUS7Z8+psJxjkebuBrDlC9KSC5y0VZiCVj/gv?=
 =?us-ascii?Q?OxoxCt4MNSfxmbAfV5TSD3LBd87l2Fn5KJc+G3+knT4PPPoCmUuas/Fl30iq?=
 =?us-ascii?Q?CzYRS/OpY4o00D1YtI8+5ngeSveS087bHtBRLt37C70o2hNojwQAMsWuYSLj?=
 =?us-ascii?Q?kQtcJIFnX6Fwsu9JVaqA7jM/kzCQaklJmEKdmYvjRBQQkjKl+YoWYcJJxK22?=
 =?us-ascii?Q?MbGpsLZfo65yfzkyg2iMIcvLaDNsQklCUdOXz3l0mMyPI7fB/sLMKTlgxBDs?=
 =?us-ascii?Q?H/htrVXK7q0gRkNGIT/fcj9eLYsKnXBqPrpUdcAmuQGMnmmFIX8hVXW6dj6O?=
 =?us-ascii?Q?KNlZaUp2k34vETiaYgpsIkhFapoJVFEFUO7B5vsYwnHs28pxcj5MA/k995n7?=
 =?us-ascii?Q?3Vb9PNitk3ts91n94KD8Fg2xtfpsdYRI/xDYu4+OSJClRp88+J2ttYB9uCx0?=
 =?us-ascii?Q?sSaRLCPuFvfvVJncDCcA2lg6DUWBkkWgIextQqB5u+GAE3/nh17anujMgtHZ?=
 =?us-ascii?Q?3PbkjpGFDpdrTVn2uT7XrnmxECPBgrgBRhzLZodyCn8jlflse3xl6hbyV8qz?=
 =?us-ascii?Q?4UPT+IpnjxjiVryKwxA7aMXEleFuVhj9MGidWZYn+n/dqNzyIb4VxFKjTChU?=
 =?us-ascii?Q?F5YoJSsasA9dp3nXLhAtiyJw4652cxaUYW9dkC0RJKmyfVv69bCaHIznEp3+?=
 =?us-ascii?Q?wOYVCzKiNO9v6+9RBTUGOSXxb4BENy3dQa+VgO3cj4oBrtRKVUxLoinP8h4n?=
 =?us-ascii?Q?nUUMbX673GZ70JHrFjbi0j9onetUxUmDZh6dgzgDqHAvwOJyjrv1V9gkP1IM?=
 =?us-ascii?Q?3jOtTp8mmRKc87GZuEJ6lnosG02xWEVsoF2c/vwJ1A29YIn/HrehCPGrQh1d?=
 =?us-ascii?Q?rEtcB4HOHRK3pFmVnLlqvryJ4O6TZU4UV1LWB27JRUL8i9QrkuEzO956t0K+?=
 =?us-ascii?Q?J+lSQvRrKwy/CtAw/FYnii2ynpo5H1C5GeaRZcXNpxKqffwnaHQiU2raehmA?=
 =?us-ascii?Q?d5Jgk/Q3dnUvSCHhsvOiBx7/6StQxRaBdV0maw0dL9niMstwdyVsuRuKopVD?=
 =?us-ascii?Q?UHprCw+n7g/sHO3Uywn0lBZ2sYtO6ok1Uwmy5K92CYHjoVDda3EbAsQ9wBrG?=
 =?us-ascii?Q?sVYSS12Wrk2xAi8P905IvL5nL+x+xxeMxzt6TvSGl6HAibtpW+iErIUTc3Nz?=
 =?us-ascii?Q?jIdP9ZxL8j0byExTZa5wQPRgfGFdGW+yXnD02O6qD04qCm0P6hbT2G/pdUSO?=
 =?us-ascii?Q?6CMbgZpM6Xnb4Nqxyn6UXmG0NZEQU4bOsy7ZAPKYllQfF/7M4OHxQl/l6rnU?=
 =?us-ascii?Q?ojZK1FRIgFBysCT7j/xaM8TT9V98c/g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae098e0-b4a0-4beb-e7f6-08dee6ef9cc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:16:33.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ik3fCZ6y76DEeh4OEH+0D0eXb2dw8uTjHRiBPF+4G829O+Y56L+IColikbFlT4P8sS8Yx01vHwHvf3RseMOkI55qDXncNyBvNj+5hoyrE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7031
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNUeUhIfktQI9l4LwFUOAv3T7bDgu7YIxdIA5SENr3Q=;
 b=fURKBBbcpokvn8Wbn4SjjralIXJ0GcAs66tGWqfqEQYya9OhN4pPPTH76XALeFGn+OtKlt/OKGlhELW/FP+xd91LIL7FSGynGE4m7ZMjnRrChsixw7yIyHw3pFG81igAsTCZ6/7ApSVXrdOHidUqGHPWbXLa1B8U8e26KcsOfQGhqf8r0yZcmV1jqKU91qpflnT49qpuFc/0RHAat+RBItqnKZM2W8AumhpO8dyhaw7wftJY2BT3u4B+iLC240Rqed19XO+/QwrE1V95mYKSFX8fF4ii8Fe+4qAi8YmDq54L31Q6ENl8Yb5g+vX0QVQIROrYiVNFoq11jUrz3KyEdQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=fURKBBbc
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="fURKBBbc"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: dinesh.maniyam@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add empty SPL fitImage configuration match. This can be extended
if there is ever need to support multiple boards with single SFP
image.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>
---
 arch/arm/mach-socfpga/spl_a10.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index a0729ece4b4..a6c4ca39f71 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -30,6 +30,7 @@
 #include <mmc.h>
 #include <memalign.h>
 #include <linux/delay.h>
+#include <log.h>
 
 #define FPGA_BUFSIZ	16 * 1024
 #define FSBL_IMAGE_IS_VALID	0x49535756
@@ -315,4 +316,12 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 
 	return (struct legacy_img_hdr *)addr;
 }
+
+int board_fit_config_name_match(const char *name)
+{
+	/* Just empty function now - can't decide what to choose */
+	debug("%s: %s\n", __func__, name);
+
+	return 0;
+}
 #endif
-- 
2.43.7

