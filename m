Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E08C61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 04:31:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D842A605F8;
	Wed, 26 Aug 2026 04:31:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 220hkS0Eojmu; Wed, 26 Aug 2026 04:31:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787718694;
	bh=oD84ECWS+b+8Ubs2PannE6xmhwNUidFyd4fOCaskjIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lzCfWGI0hx24hli00jxRG4ZrA/Y6HMYyXo6hsZasAQTcph0JE1MH7eNqFFAmAuL4d
	 BiVVJFG4+bkV3HbnQFmQo7pg6R8xjKXu5hTRzfEOT8kLJLOycym2bMMyq43n2Zgauz
	 fVAxv1735j9sUh/Gs4uYJQD9F4BLuEAbJRRn7gJnNGcyyXqbSHfID16hmt3L9ROnlG
	 H3Wx6kYZmVudEn4DAtYAKzuSEk2Mse2AWxMkmD0XiREzHutAY0TxtflJYLhBxrFdQK
	 05eMSgsMggfANI2mhqmi/ivQH71iIlenwBApSypmF6YUiSeX7nFiSWcyuDbVFGSPVP
	 RkryG9Xb/pNxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 658466073C;
	Wed, 26 Aug 2026 04:31:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 13D51334
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE6D4401AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9U5i1s54l0X1 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 02:53:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=EauLDc1g
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01ED940068
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 02:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPtdUNsPYHabXPXl+OQ8NJ+S69j6INmLG7ijH2NhrPqPEbkjfGYygNbP/xGvinMiqrlQ86NeFwgnxIjuGI0Gz0Uiet2JWNFovsojf+c0Vr84M0JBOrTi2oIFBRkm7qAXooKC2YPCET9oGFnG97TKgYjIX/sbK+YTEFVlie1tVxrIMdsEu9CcAMbpzxqyDl+PH1v7pv9AxTJj/2xLRU0lp3XnChtX1ZxW0V0yHWCkhSf8pq41GAjuhgN3Bw8/BjBpmB2gGuZMUBtC5iDLmVqXM/gCks9046kfxa1azGz/SJ9ASaoFLDw3RktsY1cTmj4GV2AXj0BPbnU2yrbSHbbZLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oD84ECWS+b+8Ubs2PannE6xmhwNUidFyd4fOCaskjIw=;
 b=C9ELL/n0pbQ48vx3GJlQce/f4BYOX2W1nj3tgvc2q8QXCbKzybV6w/rFNvA28mJ2jV15KpCEOVmuQ/s3zQvQ3dbT38L5961hThDdkuPHXqpd2ofgA5eYryNqc1+KJa0ZlcdxPWkn4v+VxRFIpSmEEsFngOxqObYZkvpIwIo9pqXsQJuieAMg67V0538I4pn7KdHe/z3dNaow/opEUnQqC6eDYeGBBo3lkXZDlznfiTwpBELewnocH/HOAWcDzkBtLYi41pNX5CTQJVg+qHx0M7N+ieaUC5FU0a1CP9U1yMc1Auibqim7qaTzqtIIFxQ0v06wtRu9JgHhrXoUlC6bGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oD84ECWS+b+8Ubs2PannE6xmhwNUidFyd4fOCaskjIw=;
 b=EauLDc1gkWcGOHWhvnWFCzUn3uxDdtGN6rfIpjM/OGU7+IaOL2vPQZXJ8NUwJT9YHJjY3KOBkXS2TTJei5kvafGr5WsKHXJZbN1iqJbQRqylUS094d1HU8kDi7mcEEe9aIN48ORpeL7S9p9OtiSWIHYMZvrApVtNfc0413HgyBgn8X9Yd6uzIveTXqcJeosN2batRRn7otDCa68A+J3vCoJrb4Pfr+CQa7eWXidSDZcm3JvP5PPDSdqNMjLyb05WgQCePIQIiZgrm1Xn/9zPE26TqvFToPq5FZec4RAx/drHp/f8vS+BXK8+jksPiLierfSj7OmZhDHlc3gy3aMNFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7167.namprd03.prod.outlook.com (2603:10b6:a03:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 02:53:26 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 02:53:26 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH 4/4] arm: dts: socfpga: agilex5: add SD/eMMC UHS PHY timing
Date: Wed, 26 Aug 2026 10:53:03 +0800
Message-ID: <2781fb330eb3af567882b68f709d6445865b028a.1787710268.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1787710268.git.tze.yee.ng@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f22a2e2-7882-4046-93ee-08df031d331a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: MIgR+bBTRDu2U3eOZF8WWEmL1BrV3art5LnYOobHrGrReqTbihzpPbo2RSlXJXIn9JTXl5HaQ2Pouzl/wdgK2YuaLhB4u1+Nuk7N6uGpmlcsaj5JPV1RDJ8V2WRbcMDNX561TpKbARgHABeYsYOCTqon8fxGjy1Un606WBYptN3tf8CSV79icLZJHeEIKYyMYPOeOPVycwI2hcWI9rC9uSMleNS0AiLDHNQxs1rA7JrKJ+zHEtguFmc2UuB8UhdhveIocXEFFxCTflBB3VJRskQiU1OfkLbEMueDJgBle/IElB4t+grr8pUDNht0VLBs4Aw1iIzCb75wVpK8gBaJe5pv4H+VGv9HR2d5nxhYYBAb8/XswGJdMYcoNx+dqysUYGG+IzdgPk12oEdHa6fBt3AtuI4+uldu+fEYqYo/9eY8Uz1K/oxVOF9PUrEnznW2WXj28Rsywqyl3IlKXbtN3M1FbsjPMyQ4FSzusw3FNxjLxza458pu0ZWf/PP9HNcYIFbWZhnpcTtEtXvGGfNbyT8oHHGCK4B5990ogqoH4J8uHMBu+fZoawoEhHJw7y2hDWgv25gi4Kg2rICto/dEOQF6xRzf69mmQ88o0xKYJ3Jgi8ZdURwDyHG0QvML2WyBzHT5cmCvSGXTXaVgZXrOqa+br2dhzrY5YhmRMQGYicU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqiezuOABTcnXU0e9EeolnoS0RIBTrWDdobkpKlhKQInnybNnGFfvPnsOrJd?=
 =?us-ascii?Q?SmLUWx4BuOrr+mx9y4rXPn1ZUE954G+Wrv3cagmzahsgqaFS/BHOzJaT0huM?=
 =?us-ascii?Q?5S9te9VVlqqmnbInwIreIBRUgdqXqY/zpybLqgrobZpNV4Rb/4HMevM6LuUV?=
 =?us-ascii?Q?Ps0fh4+RCYMSkHxKbPRO2Z30LJTicvMx50+qkLIL8s+wffMV01SzhGguZjSH?=
 =?us-ascii?Q?yDMgHuD7dCmgdwS3/haPKfu4SRbyVXQv8sbhnOaU+iynI2D2Avtwb7Qgn9zZ?=
 =?us-ascii?Q?vhbQEzY4lgGUaXpk+9YXOz2J9ah7/MWxpYv5UbVU+7L1DH7UzBg8MUwRgfP1?=
 =?us-ascii?Q?P1R30frc8qPBHfM54JKtciOyuYf190C5HsipU633c2bK8Q8cERqBT3WC3a6K?=
 =?us-ascii?Q?mrmTXdPDIaFYZNQjAgPEdswLvTfcX0ac+PpLzsqZfpaD4ERzZjqDhGByVPIW?=
 =?us-ascii?Q?ZoGrS5MPRFOWEcbAjEecbVpcGo3tVK0K/rZkQ/M8jNJvaXZyhOzcT7URnThK?=
 =?us-ascii?Q?dp9vYIOebWxGn8TnJDk+NogJxG0vtr6p5+Y1RcAiA0AK8wzzyFoBDCymqhhL?=
 =?us-ascii?Q?+zqljwGN5VlhspblahFSeazI0WmWNUsKZvZ+EMiKj7RtcliRKB7JUAJJmbHi?=
 =?us-ascii?Q?tdAcDDdc0OunEUO/yPmFCr5CPo4Vasg/+/66JX6z1aCadXnHFKKWq7I208Ii?=
 =?us-ascii?Q?z8c6IIBdoNnti4qsnl+cz5Rve0CwCRWr8CUv4Qz7IYqw+jdqF4MiqeR7+W3p?=
 =?us-ascii?Q?980lVt3zwE9+MNmFzAnqzwBihtTKrlICH3rp6AqxA6GXUA3K2mLtc1tVYcAf?=
 =?us-ascii?Q?1oaz0oxvspnhGimjdUpTAUIFnZWdXxdX1rbFXXHOfuevqOP2GeEsbE76r0RD?=
 =?us-ascii?Q?arjfMdvuRgYbahjCr8KManhsUSdQpD6+TfthWah/JVOHVT7ZVt7AsiL3VBhZ?=
 =?us-ascii?Q?pY5aOEtfZNRgGIv8Umd2iKL3F4RJZZxTowj7wg83QvN4qrn292g43cKsRFDV?=
 =?us-ascii?Q?fFrhFnnzQNUN2wq1Ga5x3JkOZ4iZsFJvnZ1YqCGDnjDHgDK8Gu1r+6x/8OxI?=
 =?us-ascii?Q?PnUKP429AaIRFLsjdGjv/5mCtB6ZGCinExxbh0KhaySROOyN/itVhB99qM7D?=
 =?us-ascii?Q?m9Y4FTOtP5G3LNqdZv7E1RP7Y8cL9SQn3lzdiWdGHi7lR/7cNJ6X23GNbd5s?=
 =?us-ascii?Q?owcL4FMxyYVYLtH1fWjXETkef51EgRG8gPf1G280pIJm0VRo5256q4Dv+1PG?=
 =?us-ascii?Q?IIz6iAygE9hWu13N+Nd5p0duywf4Xk/7d94CYeucq5RIWRiZK17joY664/Vz?=
 =?us-ascii?Q?gXSKkxVAc7t/J898TRKqF4Qm37hROD6fJTVRdDcCIUeMqxUNjWjJtb75UPMG?=
 =?us-ascii?Q?azXX1dWh05PPFHdpPgHtlU5adRi+wr4gTOlE//UORag4wdMHC7ALx/93Vvtb?=
 =?us-ascii?Q?RDO/2K2cYxwc0JgD8O6Ye5IIveVqDXWrbggCHmWu8hH1WoI7DEO74gK1GQIn?=
 =?us-ascii?Q?Xp1P/DI1qgsppXv5RJVqzMYFSArhaPmwBPgd7L/kDiSW9ghsC2eR8m+3Z5Sb?=
 =?us-ascii?Q?0ne7oUNmkRJdJ5CIyx8CFOSOPYR+Qi95YxkOox6EzRqO9/ezYykot2wP0S6o?=
 =?us-ascii?Q?jc5oWaFLKCAwLTM6LF5d/EGV/YO9S2ZyW13deHkDSgRzyDQSQ2j4Pdfk/Xny?=
 =?us-ascii?Q?dE+JSDaZQ1w+o2JCmWi1s07p0+Bpsu0F5E4BML5B1FS6JROp3B9xHFzKYPRO?=
 =?us-ascii?Q?1wVotcT3Kg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f22a2e2-7882-4046-93ee-08df031d331a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 02:53:25.9309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xpE0TZhg8FKAXAgjDKLw0B/tq+sHREUudTubXftWmiksDMRanJrSWiYcJUYx9bQbVUSqUIsd7U2zItG2GSTGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7167
X-Mailman-Approved-At: Wed, 26 Aug 2026 04:31:20 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Tze Yee Ng <tze.yee.ng@altera.com>

Add UHS-I PHY and controller timing so SD cards and eMMC can run in the
higher speed modes on the Agilex5 SoCDK and its 013B and modular
variants:

  - SoCDK: DDR50 (emmc-ddr) timing so SD cards / eMMC can run in UHS-I
    DDR50 / DDR52 mode; advertise sd-uhs-ddr50 on the SD board and
    mmc-ddr-1_8v on the eMMC board.
  - 013B: drop no-1-8-v to allow 1.8V signalling and add SDR104
    (emmc-hs200) and DDR50 (emmc-ddr) timing; advertise sd-uhs-sdr50,
    sd-uhs-sdr104 and sd-uhs-ddr50.
  - Modular: advertise sd-uhs-sdr50, sd-uhs-sdr104 and sd-uhs-ddr50 and
    add DDR50 (emmc-ddr) timing (phony_dqs_timing = 0 re-centres the
    returning data on the longer SoM SD path).

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 13 ++++++++++
 .../socfpga_agilex5_socdk_013b-u-boot.dtsi    | 24 +++++++++++++++++--
 arch/arm/dts/socfpga_agilex5_socdk_013b.dts   |  4 +++-
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts   | 13 ++++++++++
 .../arm/dts/socfpga_agilex5_socdk_modular.dts | 20 ++++++++++++++++
 5 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index c03f78b2fdf..1cd54e29679 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -114,6 +114,7 @@
 	cap-sd-highspeed;
 	sd-uhs-sdr50;
 	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
@@ -153,6 +154,18 @@
 	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
 
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	cdns,phy-ctrl-emmc-ddr = <0x4010>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
+
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
index 75d51ef06e3..819e0ba9798 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk_013b-u-boot.dtsi
@@ -121,14 +121,12 @@
 	status = "okay";
 
 	no-mmc;
-	no-1-8-v;
 	disable-wp;
 	cap-sd-highspeed;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
 	sdhci-caps = <0x00000000 0x0000c800>;
-	sdhci-caps-mask = <0x00002007 0x0000ff00>;
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
@@ -153,6 +151,28 @@
 	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
 
+	/* SD card UHS-I SDR104 mode timing configuration */
+	cdns,phy-dq-timing-delay-emmc-hs200 = <0x11000001>;
+	cdns,phy-dqs-timing-delay-emmc-hs200 = <0x780004>;
+	cdns,phy-dll-slave-ctrl-emmc-hs200 = <0x4d4d00>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200 = <0x81a40040>;
+	cdns,ctrl-hrs09-timing-delay-emmc-hs200 = <0xf1c18000>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs200 = <0x90000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
+
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	cdns,phy-ctrl-emmc-ddr = <0x4010>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
+
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_013b.dts b/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
index 9605fa4cb00..1bec13d998e 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_013b.dts
@@ -90,11 +90,13 @@
 &mmc {
 	status = "okay";
 	bus-width = <4>;
-	no-1-8-v;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	disable-wp;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
 	cdns,phy-use-ext-lpbk-dqs = <1>;
 	cdns,phy-use-lpbk-dqs = <1>;
 	cdns,phy-use-phony-dqs = <1>;
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
index c06781064ca..6c608cfc562 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_emmc.dts
@@ -25,6 +25,7 @@
 	disable-wp;
 	non-removable;
 	cap-mmc-highspeed;
+	mmc-ddr-1_8v;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
 	bus-width = <8>;
@@ -71,4 +72,16 @@
 	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-hs400 = <0x80000>;
 	cdns,ctrl-hrs16-slave-ctrl-emmc-hs400 = <0x11000001>;
 	cdns,ctrl-hrs07-timing-delay-emmc-hs400 = <0x90001>;
+
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	cdns,phy-ctrl-emmc-ddr = <0x4010>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
 };
diff --git a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
index 032e40fc639..30a5a749d1d 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
+++ b/arch/arm/dts/socfpga_agilex5_socdk_modular.dts
@@ -33,6 +33,9 @@
 	no-mmc;
 	disable-wp;
 	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 	vmmc-supply = <&sd_emmc_power>;
 	vqmmc-supply = <&sd_io_1v8_reg>;
 	max-frequency = <200000000>;
@@ -71,5 +74,22 @@
 	cdns,ctrl-hrs16-slave-ctrl-emmc-hs200 = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-emmc-hs200 = <0xa0001>;
 
+	/* SD card UHS-I DDR50 mode & eMMC DDR52 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-ddr = <0x00580000>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr = <0x81a40040>;
+	cdns,phy-dll-master-ctrl-emmc-ddr = <0xa00004>;
+	cdns,phy-dll-slave-ctrl-emmc-ddr = <0x60>;
+	/*
+	 * Modular SoM: PHONY_DQS_TIMING (PHY_CTRL[9:4]) = 0 instead of the
+	 * default 1. The longer SD path offsets the returning DDR data from the
+	 * phony strobe; re-centring it stops one DDR beat collapsing onto both.
+	 */
+	cdns,phy-ctrl-emmc-ddr = <0x4000>;
+	cdns,phy-dq-timing-delay-emmc-ddr = <0x10000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-ddr = <0xf1c1800f>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-ddr = <0x00020000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-ddr = <0x11000000>;
+	cdns,ctrl-hrs07-timing-delay-emmc-ddr = <0x00090001>;
+
 	bootph-all;
 };
-- 
2.43.7

