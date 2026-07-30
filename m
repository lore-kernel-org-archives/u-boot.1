Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBBAC54FCD
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 03:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37B6A80BE5;
	Thu, 30 Jul 2026 03:02:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lxny9KmG5oOh; Thu, 30 Jul 2026 03:02:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43B4B80C12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785380558;
	bh=M/el/PIDV4Jdwrc+nZWv+kLcDNBxj6rv7gs9JW/V0qE=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=ruUtpjwErGFdZArVTU4ZrJN8b1Wcy5O6aunpWab9uk3kWHkfTPRh7V+TsgSMt2K9m
	 qCQFqfCeX07UZVsM2+LRDDMmbtzKn1wkXVvNGGdNZ8OniB+MYyJDesFaf9Ww+UjGwi
	 5vYXbHRi7/WxiBtH2Qt6xrm/y+TGSq1krfZQFQW13K++duZo5yfq+Cm4TYrNDGU1q3
	 ko/qy3VR9j5Vma+IbDea7LfiJPEAkqYfvWPCobKTiA7xuQBNlkNkTycEOz1Sbiwin1
	 pwhAmpXwx1GATiPjzVnCxH9CijRg+F8deNYvJTDDkZ69X5U4Cfq6dNPCWWVb99f+nX
	 3MU5IRDikWXjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43B4B80C12;
	Thu, 30 Jul 2026 03:02:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C0BED350
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE1DD80BE5
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qP7GqCBIvNwJ for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 03:02:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 72EF980C34
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72EF980C34
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72EF980C34
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 03:02:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7FB8498B; Thu, 30 Jul 2026 05:02:27 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A98803F6
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 05:02:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlXBeZ0aOadtiWmaX+IWSSAV1fGV3GWJzheayU5mF9ey5LP2fQx8296VGM/JcDVrld78ysalzPblOB6Fp0JBrrxVhGVbgzaTp2cKRaDgUSP2XY3QMLmLZ2tEUCLG8PILBW+FXtYnZGNIZAYKS45gleyUoMBj167WM37ECiInWA1xg1k/xf4yzcJI4aMNNXS5JaQ49++jWrO4Q5mpOB0eaoKRH0iJSU4nWRR8aDW4HgSuWk0tZI5od7o+8QQYVHN3Fv+SmuALzHmjFRopQO+vuPmEXkAmI3scIX4NM8d27qY2Arr/6r61kEe6YLeoNdUN5gpKGfquK2LKHKPMMfWB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/el/PIDV4Jdwrc+nZWv+kLcDNBxj6rv7gs9JW/V0qE=;
 b=FipRoXmMtxnTca6/o8rUzPWqRCoYUxsODDxBqwz1vWDZqpao9gSO0nyGko3y3Wtox2ej5h+AwKDEITy2JqIJBUz1s/ocRzEcq6hcSHMTn5rRH7q+qvDfVb5UYN8eqIl6HiWjZIxva2yrLTLzBwCUxaMF6LuuadZEtlzuhtawwNSxdhFgzVcpHw88u7OuAmpWFkHynf3Z4VNW2Un5N8HcotNBU2tOyDaIOR5bHRtL5baT+Gbrmyrir4a3R0ntu4fhqbJSCywm2Nj8Jy+jb0jZnr7P3bStmLCx9gaptLxRyvexxfDbuOHtrGVad4WniHur9sR86fMCziFX58nf+pDY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DS0PR03MB7773.namprd03.prod.outlook.com (2603:10b6:8:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 03:02:19 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0245.012; Thu, 30 Jul 2026
 03:02:19 +0000
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 David Lechner <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Will <btdai@terasic.com.cn>,
 Shi Lin Teoh <shi.lin.teoh@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: dts: socfpga: Add Terasic DE-25 Standard Board Support
Date: Thu, 30 Jul 2026 11:02:05 +0800
Message-ID: <20260730030205.25260-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DS0PR03MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 607ce35f-d00b-44f7-c754-08deede6f7b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: u3QtGCoJTMTZxDYNu/Lb4slR68roVDSWd/A8PvmPIf/2vOMhGFfcGPdkx6L1/6H8J9SEqsRKZZvYL1sJI6jI01bu4YOI8mXiRnOTW1xif9mYOi9SDuAGPzAkbF+YCCWAdODQrbIUevGDBLnGMo8XtD90VklAjfFkPkiXTxnqYZhAs2BeRPz8J9NfZpuZVbG1fGDHB8KvlZUXvH17pic/NZqvY3RZ9+gH4nasaNdH8wiJ9T1ee2d1nGxM8bD+NTzmi4o82VUvhRWSyRXNK2M8UILPpHFf9ySRc+t3kQ91OtWAm1DMtwft/NygZvtTcY11QKMrPI2s8jbo6XjScN/ZI4KfxNqi+n19QABcZTZ/p3dL9ZezHYE5uhU3hlZOqxyV1nULRt1iQ/hUqXtJURs7sNrPuoiS6f75EZRjBYml5L/kcQzgeZAKrwK8j0V36iO4mC3uuPnmAfiOVbJQVfoetnF8X1MV9o3DNC2KLEOA/xT3mzJq6lEoY/p5ZeRR8jh7Htfo84KItMDOEGKst9L9+KKF1yU09DXYVgcazVgmlHb/GwXyJCQXGUAwmcoyg8t6pOyEKOhth1qtUd0lukRFT08TVsfvD+9hLzHR/87ZvizKCJaSX2udP7m49+LuOm0B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/mapQGnMmgfQHDbOmGJuUWQ3dnMZYr0Bdx78IccQMBomPuRz16j6Rd48meWs?=
 =?us-ascii?Q?ER9svEYP9OOXo4Pxc0ktLUutMyrbzQ+Cn/J7GSpO3LMZ32w3IIsoEhcPvKcB?=
 =?us-ascii?Q?fB29Q8rEZOommL5GUCDQPzaeg/jyIgwMoj0LfoUvHoyHiMbqYo4BB4AynLj3?=
 =?us-ascii?Q?5UkpwQdyAmy3jMJrPzcDa1fBmK9yxed92t7Z3PWXGJGrfI1xNbND01ndsBKf?=
 =?us-ascii?Q?FKoLYH4JIx3rlAUp0ubqtTSBkqMg/QRvUrfgQSLHfTFFM3P6cPz4GhN14Btx?=
 =?us-ascii?Q?S5UhY2q3kuUWVN+41LY2EH0BGX3QRVEwwfy6kGHsGgt9weZNtTK7Vq7xy5dZ?=
 =?us-ascii?Q?3o3DW0HSWe/v/wXGDbdoyYITF8uy548l1Cjq/ZLLyMmjudpULV9SA6WstXQ3?=
 =?us-ascii?Q?qKPn8CHvTEzqQ1thrZHDRNa09bc8pIK662SJXLIlsT2OLHwsaYo7D/AqVHZq?=
 =?us-ascii?Q?0B4u6YLzbHfkknBa7iSKC6gs/7AV/oPDk9bp0Cz4GIX+Wchh8wK8hdl7ucUo?=
 =?us-ascii?Q?oZm501UFzQHuE9UP0ODTqB35JD1dJk1pLI1t+j5Bi3oUze6nGuwvOiVnYBcy?=
 =?us-ascii?Q?Qtg6T9jln9dA1a6RYEDP8IoX/1ikxGqHMhjcPz3GwFjUhkR3zRU0TmLBL6kH?=
 =?us-ascii?Q?BFuLqM4z7T3D9b5lMSOIU92QwToG9+JcY15gmRSOWE8Q5my+P0qDMf3cCgU8?=
 =?us-ascii?Q?/UMJiF5BlFY/L6bfQGNXVJkOy7AuCjbZ519iC+08s7tNQMDPkxLjEA1VAYSS?=
 =?us-ascii?Q?J82mLjdTA9S4x120kQ9vH9+96/quZisdtr/0jh5/GGfKdnhqzxa2SuBRKiXm?=
 =?us-ascii?Q?Qdc0VgBHUPWz7p7ueXKbMDATIb1anUvHhn80IGhhixewXG+eW8HEFA4DvhlN?=
 =?us-ascii?Q?UmkaDSjqDjaHBsoG6z5Yq2PVZ0+EctK7rBcO/1SQ4ZPhypNuBDYZtkWmp/pl?=
 =?us-ascii?Q?joY7qe76Q41sWBugOnJXQoFLtR+/bvblGAp/Br///3jgYo9RRqxIb3suET+O?=
 =?us-ascii?Q?lYpDZcQvfOkV3MbtIOJSxfZ0K1OriiNYXV8Rn9W/OIiRnj7Iw7ow4SDOLr2n?=
 =?us-ascii?Q?nvWoSUCBuvIc0oTGsUh9mMQfjnhfqpSWBih1IYx8HKPFY73/IgjTB2DaeOIf?=
 =?us-ascii?Q?WKVV89x9taGNe/CLM5Q1tpvhmxeTJy/2mpVE0K4LVEehxwToXaonyuR70HRh?=
 =?us-ascii?Q?6SLcbqoU9USqHgwJXqbX4vhEIczfwQBAh7DL1elQ4VC10vYy2leio1wokU6y?=
 =?us-ascii?Q?lCfT7BW9/+XBSfKx+Is46bRH3mtDT1tddKDH71dphp57W/YZR0kJIkL/X1Lt?=
 =?us-ascii?Q?JE4EhO+SxhsYOeN9fgopIlblVCuBolv6HZ/qQP/17tNBzw+4mDTVKbtumMss?=
 =?us-ascii?Q?Ww7Hq4wZswy9hXpuB83QrXLwG2XrdScm3l4csD8Q9XNM3sJFNPy/3Z1k7s7u?=
 =?us-ascii?Q?gvCNorQ/PuMfmhEvFPF5kzz4BtRJ2StvBSVwF9+uJdKL140TSzG1GISwc8lo?=
 =?us-ascii?Q?fmy1XOAxZYxuL2poGi7OjtHDqok0icAdeV0wXGD3pR9oYXM0N5yvqpNCL0B8?=
 =?us-ascii?Q?5sBegZ3oybRIEQLFNV8TF1dgzkjq1Mt28ojbKbA7oCNJ14Qo+lDyipWEaAFo?=
 =?us-ascii?Q?9B4/MaoMkcSnHNguoEGS7v4H8gixCPkp1wrnjvicoNYmg3tuhzQsxRULPu3+?=
 =?us-ascii?Q?Pm+t8VEQDDDXym+oFEDJyA5NiFWdCT+yTzoVtSJSr69G5G1Ewsg2B5wD3k7a?=
 =?us-ascii?Q?R7NkYVqhS+xveGPd+na6FgZkMZaiw9o=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607ce35f-d00b-44f7-c754-08deede6f7b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 03:02:19.4388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSUAXQJJQtW059QrujOTR11bI41hg/gGv2Y0Q2f7kevoL+0HqQdlsvpB9fc0n02nQ4xVIiuoaSemiaG9SwhTxi0JZHggE8XQ8iaPQd8502Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7773
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/el/PIDV4Jdwrc+nZWv+kLcDNBxj6rv7gs9JW/V0qE=;
 b=rlT9C2PFjI/wuomQk5QI7F6WNZy+escf0Y+6xnKRCIsx0HTpu8OP+9+qRS/2xyc6J9tDn1sWTF6x7JE6cpTGYLSTEvyfJJ2mKLO1ZUbkXg9m5POo3edubzDyRj125+2HX8/dR7lxF6dPzj6DaHppAnG1fZMzvLvwf8w/pMRsuEcdr+5sLwnVYi+NP93ygLu3qLe1hc+CP68X57TayWFsomEK22tReXU5pSnNAB0vkAG7Qh88S1PdhlDjvk/KBGmnTmYtLiAV/zR12KrtdOCxc0N8vxR0ZnQo/uMQTNIRFQfZOmR9+4GWi+/P/3Gb26Pb9p3N4JFjCYrgiTeg6C4Uyg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=rlT9C2PF
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="rlT9C2PF"; 
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
From: Alif Zakuan Yuslaimi via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: alif.zakuan.yuslaimi@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add dedicated device tree support for the Terasic DE-25 Standard board,
which is based on Agilex5.

Following Terasic's Linux device tree for DE-25 Standard configuration in
which UART and board wiring differs from Altera SoCDK boards - enable UART1
instead of UART0, route console through serial0 alias, and expose a single
HPS LED on GPIO port B pin 17 (active-low). Enable only the on-board
peripherals present on this kit: a single RGMII Ethernet interface on gmac0
with PHY MDIO address 1, gpio1, i2c1, spi0, and usb0. The second GMAC,
extra I2C/I3C buses, spi1, usb31, and NAND are left disabled.

MMC retains UHS-I SDR104 mode consistent with the Altera SoCDK reference.
QSPI NOR flash uses the SoCDK-style partition layout on the 256 MB device
(dedicated u-boot and root regions); the QSPI controller is disabled in the
U-Boot SPL device tree so that SD/MMC is the primary boot source. DRAM size
is fixed at 1 GiB in the U-Boot additions.

New files added:
- socfpga_agilex5_de25s.dts: Main device tree
- socfpga_agilex5_de25s-u-boot.dtsi: U-Boot specific additions
- configs/socfpga_agilex5_de25s_defconfig: Board configuration

Build system integration:
- Add build target in Makefile for DE25 Standard device tree binary file

Signed-off-by: Will <btdai@terasic.com.cn>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/dts/Makefile                         |   1 +
 .../arm/dts/socfpga_agilex5_de25s-u-boot.dtsi | 203 ++++++++++++++++++
 arch/arm/dts/socfpga_agilex5_de25s.dts        | 157 ++++++++++++++
 configs/socfpga_agilex5_de25s_defconfig       |   3 +
 4 files changed, 364 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_agilex5_de25s.dts
 create mode 100644 configs/socfpga_agilex5_de25s_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dada5f9eba2..3772af89c91 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -415,6 +415,7 @@ dtb-$(CONFIG_AM43XX) += am437x-gp-evm.dtb am437x-sk-evm.dtb	\
 dtb-$(CONFIG_TARGET_THUNDERX_88XX) += thunderx-88xx.dtb
 
 dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
+	socfpga_agilex5_de25s.dtb			\
 	socfpga_agilex5_socdk.dtb			\
 	socfpga_agilex5_socdk_emmc.dtb		\
 	socfpga_arria5_secu1.dtb			\
diff --git a/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
new file mode 100644
index 00000000000..4a5d9a4dca8
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25s-u-boot.dtsi
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * U-Boot additions
+ *
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include "socfpga_agilex5-u-boot.dtsi"
+
+/{
+	aliases {
+		spi0 = &qspi;
+		freeze_br0 = &freeze_controller;
+	};
+
+	soc {
+		freeze_controller: freeze_controller@0x20000450 {
+			compatible = "altr,freeze-bridge-controller";
+			reg = <0x20000450 0x00000010>;
+			status = "disabled";
+		};
+	};
+
+	/*
+	 * Both Memory base address and size default info is retrieved from HW setting.
+	 * Reconfiguration / Overwrite these info can be done with examples below.
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
+	 * Example for memory size with 2GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 32GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>;
+	 * };
+	 *
+	 * Example for memory size with 512GB:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x7 0x80000000>,
+	 *	      <0x88 0x00000000 0x78 0x00000000>;
+	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
+	 */
+
+	memory {
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		u-boot,spl-boot-order = &mmc,&flash0,&nand,"/memory";
+	};
+};
+
+&flash0 {
+	compatible = "jedec,spi-nor";
+	spi-tx-bus-width = <4>;
+	spi-rx-bus-width = <4>;
+	bootph-all;
+	/delete-property/ cdns,read-delay;
+};
+
+&flash1 {
+	bootph-all;
+};
+
+&i3c0 {
+	bootph-all;
+};
+
+&i3c1 {
+	bootph-all;
+};
+
+&gpio1 {
+	portb: gpio-controller@0 {
+		bootph-all;
+	};
+};
+
+&sd_emmc_power {
+	bootph-all;
+};
+
+&sd_io_1v8_reg {
+	gpios = <&portb 3 GPIO_ACTIVE_HIGH>;
+	bootph-all;
+};
+
+&mmc {
+	status = "okay";
+
+	no-mmc;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&sd_emmc_power>;
+	vqmmc-supply = <&sd_io_1v8_reg>;
+	max-frequency = <200000000>;
+	sdhci-caps = <0x00000000 0x0000c800>;
+
+	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
+	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
+
+	/* SD card high speed and UHS-I SDR25 mode timing configuration */
+	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
+	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
+
+	/* SD card UHS-I SDR50 mode timing configuration */
+	cdns,phy-dqs-timing-delay-emmc-sdr = <0x780004>;
+	cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr = <0x80a40040>;
+	cdns,phy-dll-slave-ctrl-emmc-sdr = <0x4000004>;
+	cdns,phy-dq-timing-delay-emmc-sdr = <0x38000001>;
+	cdns,ctrl-hrs09-timing-delay-emmc-sdr = <0xf1c1800c>;
+	cdns,ctrl-hrs10-lpbk-ctrl-delay-emmc-sdr = <0x20000>;
+	cdns,ctrl-hrs16-slave-ctrl-emmc-sdr = <0x101>;
+	cdns,ctrl-hrs07-timing-delay-emmc-sdr = <0x90005>;
+
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
+	bootph-all;
+};
+
+&qspi {
+	status = "disabled";
+};
+
+&nand {
+	bootph-all;
+};
+
+&timer0 {
+	bootph-all;
+};
+
+&timer1 {
+	bootph-all;
+};
+
+&timer2 {
+	bootph-all;
+};
+
+&timer3 {
+	bootph-all;
+};
+
+&watchdog0 {
+	bootph-all;
+};
+
+&gmac0 {
+	status = "okay";
+	/* PHY delays is configured via skew properties */
+	phy-mode = "rgmii";
+	phy-handle = <&emac0_phy0>;
+
+	max-frame-size = <9000>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwxgmac-mdio";
+		emac0_phy0: ethernet-phy@1 {
+			reg = <1>;
+		};
+	};
+};
diff --git a/arch/arm/dts/socfpga_agilex5_de25s.dts b/arch/arm/dts/socfpga_agilex5_de25s.dts
new file mode 100644
index 00000000000..6f7666e7a8b
--- /dev/null
+++ b/arch/arm/dts/socfpga_agilex5_de25s.dts
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+#include "socfpga_agilex5.dtsi"
+
+/ {
+	model = "SoCFPGA Agilex5 Terasic DE25-Standard";
+
+	aliases {
+		serial0 = &uart1;
+		ethernet0 = &gmac0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		hps0 {
+			label = "hps_led0";
+			gpios = <&portb 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&mmc {
+	sd-uhs-sdr104;
+	sdhci-caps-mask = <0x00002000 0x0000ff00>;
+};
+
+&uart1 {
+	status = "okay";
+	bootph-all;
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	disable-over-current;
+};
+
+&watchdog0 {
+	status = "okay";
+};
+
+&watchdog1 {
+	status = "okay";
+};
+
+&watchdog2 {
+	status = "okay";
+};
+
+&watchdog3 {
+	status = "okay";
+};
+
+&watchdog4 {
+	status = "okay";
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&timer1 {
+	status = "okay";
+};
+
+&timer2 {
+	status = "okay";
+};
+
+&timer3 {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&nand {
+	status = "disabled";
+
+	flash1: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "u-boot";
+			reg = <0 0x200000>;
+		};
+		partition@200000 {
+			label = "root";
+			reg = <0x200000 0x3fe00000>;
+		};
+	};
+};
+
+&qspi {
+	flash0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x04200000>;
+			};
+
+			root: partition@4200000 {
+				label = "root";
+				reg = <0x04200000 0x0BE00000>;
+			};
+		};
+	};
+};
diff --git a/configs/socfpga_agilex5_de25s_defconfig b/configs/socfpga_agilex5_de25s_defconfig
new file mode 100644
index 00000000000..6b99626f2ab
--- /dev/null
+++ b/configs/socfpga_agilex5_de25s_defconfig
@@ -0,0 +1,3 @@
+#include <configs/socfpga_agilex5_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_de25s"
-- 
2.43.7

