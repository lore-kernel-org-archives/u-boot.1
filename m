Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92019D33996
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 15:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B312890E7;
	Mon, 28 Oct 2024 16:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="V/hutogf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF88890F4; Mon, 28 Oct 2024 16:23:46 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::727])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B66289098
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOhxowqjed0tR23WrKzMuNTEEvFrNb5VpUUC2L2vEgo7BhmbOXjtbS1ytISDkEhSQM3g91if9/sBt65l9kqD683P6p71OFeo0UC28an9Q7u8+Xb5bOSWCmSjc0qEVOMitjvgbvzmpyH7tTGwnzvx134niBWAZ0pFZYhhCFaD60uAHQaqiSkskA0xWru0nipX+4f7zCIkOsUUrJpt9B+xuOK/KqgG39zU0OmlntArCbFXynPDk6DEt0Y7mf7H9D41zW8BUJ87pcN+0HBhjw0VTL4EASdXqNbbq3sbUHX1vXnmmLw0d0DLPpifwdD9zh6Pa217br3yY0kGUmqgBL2wHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQTiUgS53ESYz6vDTFlxUcRHPVfaI4lOk+aduiQUhbs=;
 b=m1uJvqTEeiKFOUo4+ph78MCYmmbFdN5LCej16zqOYfC1ucksXiN3VkoG4E7lfb/hBzdWhTByC9wURxhJckgXu+7I85yB+w/0fI3pUFxHTOr2j7G5Op2gZeFlk5Zjy8GB1X8nwVlRxtLzwb9GcXoijb5ly1VuAqxJJJrMu/NJ6Ishjaa7/HFSEpL6Jjr9t2u0/adOH2wb3+o5f1fZMJ0+WWYOMx00ibeoYmDp/fzhJvglwAbfHt4BVe8qTTCvTWVfCKHoi5F5fQ7mbajOYCxmIFsrKYJYPYKFjca+jvVHGneFSdljFlhOp/WjG8dNLRy3rNbgV0P+eSU3tDZZg80Yxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQTiUgS53ESYz6vDTFlxUcRHPVfaI4lOk+aduiQUhbs=;
 b=V/hutogfH8G1OUDT5tugwASx7zZ37pPhzFpfqjiwG3q9KTZ+pj+vmBkQOtQ3ComghlR87P4ptpReohgOaYyQt7guCInbBxCUEjqWpfVPcyw6LR89prgobgm9srv2wfnVARhI/CTAtlLMeP2fWNqqHSA2v+twWbCC9Yo+q2CMkOHlvTZr4qXDu01WNUatNezro6FQZv/hA/3HaJsNz0sQ6YzzFRtOKHUZdys+xzr9Wezkdp4qqXALlco44QFysWmKW08caGwcjZZGnsLJD1Drw/MY8cYQK3uFUJ3ihz3f4EQfuZ2GCk3F3SCtzV7SZgHrUEOFtrKzshCT39VL2lNUTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5697.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 15:23:42 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 15:23:42 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, u-boot@lists.denx.de
Subject: [RESEND PATCH v4 0/3] cmd/mtd: add missed featuries
Date: Mon, 28 Oct 2024 18:23:31 +0300
Message-ID: <20241028152334.1814929-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000045C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::43c) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: 1599d558-eae8-47ae-671f-08dcf7648152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C8aelpujIwRKdqljMfgzh2Xvtql9g+IKZglzBtJL/3PJQPb6sIw7t8m7606N?=
 =?us-ascii?Q?AVNmDaN/BkhVr8GJsVgIfU1Ub+2uFs9H0w4kUKYtvwPzIiiWfqj6KR3u9crT?=
 =?us-ascii?Q?sfPkCTTksUmOoPEz4TAWELR7T8mPkW1rtWvBOpLfnp5QwQGKJRFR5tjRd3NG?=
 =?us-ascii?Q?ruJBXD9s5njS0pH8F1RFn5yu5SKbc++3xQriOl3ZzuAM3rtk5/eCO4F2lRaz?=
 =?us-ascii?Q?8l2NTZzLegiNC4jKvTQL3Js/CPJTGR0HUEsBAMs2QY6vQtJijnv+PAhcK1Iw?=
 =?us-ascii?Q?j+riPN163DUwTrPty6jBdtoJEq2WBBktdWLcAb/R4gS/9+HbfFxLf+oDeRyZ?=
 =?us-ascii?Q?YizRDtVoj3Lt8azAWaODaUg8yhnyGM2qm2kbxURTdQgeOl/zV61u6NbfChy1?=
 =?us-ascii?Q?XAV6AfXA0PbZHQlzrIld7ts4Aajy9OFxSh+y2whG/3JXMTcFeBzLa3nGFk1X?=
 =?us-ascii?Q?ixT8BN8kw2SJuF55JFfj00xhx2vkM42C3Uka6AICBojWRI2QlqmwQioh42sR?=
 =?us-ascii?Q?ggLSO5wzLNxMPceAzDnunxXtLQslmcvbR55wn+MVqfp1liXboBEbi9X5Ylq9?=
 =?us-ascii?Q?64FgnXASThBAEQDZVY1rB495+1wZ15rjlU2wf2r49ZerEUMYiCXLTKO0B/yM?=
 =?us-ascii?Q?ThsXDE+2C7OMpNcupnXyqzPV7GQoyGiOukv6isx37RaGIiDR/hCFKV2RDFPs?=
 =?us-ascii?Q?/bOR1fFQaz81K+grHWeN7K1ahFOoEwzxwwRd5NcGJ6Y5MU+IDllBqMy9Kxhr?=
 =?us-ascii?Q?HTgfGi+pZTxpaWt8WLKfaqlB+/f+EopyfARcuY86EecSbj7oYIA0wATCZB9L?=
 =?us-ascii?Q?vK72oy1JKmWjbRDlmch301VYzOcKcEyOIkkrn7nRvvlwPj6sKBLcXavvi/1n?=
 =?us-ascii?Q?xYnY16fBCNXJ3X0M50RGTNg+H/yxTew5tM6hBXvndoPBOGc2StM/XhRhF9PW?=
 =?us-ascii?Q?NR50Ll5D5NBBToJVUK/WtPZTTmaxGanH2dA+8vk1XLInnPtC36hU3V/L1txd?=
 =?us-ascii?Q?s9XkAFlk1KRGXDSVhwqT+SKcnd0mqGsIuyAxszopap3Fs5YFyPF94QUjRkxr?=
 =?us-ascii?Q?08UZb9t0cjag5YjhrOjE/5hpLPARx0CSKfssGOY1+a6mBS6o+bvRdb7fNpTO?=
 =?us-ascii?Q?zzVv3l6NQ/EhP4ob2Q9AU0/Zh1BJGtv+xD32IXDaHU1c4hHbgxVC6RJ3aB2l?=
 =?us-ascii?Q?vDu2/T4CN8zyMkrkLx7klyb0m4IlM6XTllDxx5lKp4Fxbw4dIrNbsyT3o4zP?=
 =?us-ascii?Q?FhSC2jYVhuOFfQMBlyYNFylkLJMQgic/MoNwWYy3tA8YCpE/VOP6KBBge5Yl?=
 =?us-ascii?Q?ZtRnZ/3h3IcN0TG8TdRA+/bwigvZoOz6PumtByQ+JSJwoBZ0XjiTzPLHuWrR?=
 =?us-ascii?Q?zvUBYHiMUJI0pRhI0598Ft8Ocv0I?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlLPrhYj20twFGqi8i4/tNrMDYn02ZRqt0+5cQBht408PsCv6SNlCxyHkzkI?=
 =?us-ascii?Q?1iDVd36BlrY0FxglV65kVcB/+BCY4Ou3n66JvKdew7ink6OtflOG9RBnBzRC?=
 =?us-ascii?Q?opX3H/TCEsgE3FRxrBvdfMM2K7/g3eZ3PMXR1qTCW7qddNJNHIr1DPKzZxwT?=
 =?us-ascii?Q?GBlDiRaDfif+rPie1OJb7GXblhBrsr1L450I7b3HzH/467e5JGNoYqkuEmMG?=
 =?us-ascii?Q?gAHYs1G8MV8huoccm52N3rF1vLm8ilUqFPynIkE0GfsoUqlYE6juzsZNqP5v?=
 =?us-ascii?Q?FAvcL85KDfQE/6vleElBQH7YJz+eA1T23fFV/ZbkwdtnCo4magZ9Ude6beEt?=
 =?us-ascii?Q?Qdk2k9OhSb3wb0M0JxxAEOcId+Ifo8s3NuedCoF2Ae47FETkHNIA3h5ilaqJ?=
 =?us-ascii?Q?oTDeSZiFFu6lIPLudM2kIMlZY8s2ZfOfr/UQtySX/CGo2umtN5Xo+UfQunyq?=
 =?us-ascii?Q?Ee/mluXAVcLm69g7V/6Q9B5mRO7trTffiAQDKtAdMlqCjPNwEHHhwKjc3bbu?=
 =?us-ascii?Q?AKPfcQBIib+BJ3QZ1nO73ZHs+catCBdkSTTnlXivWFkJCDh3uHrKO1tiZKaB?=
 =?us-ascii?Q?LWOD7JpxXGf3h/RUW87MbbFveuXS9rtHNo5r/0Cy0ShtlzatwEpKy4Pte1PS?=
 =?us-ascii?Q?eGjvBr6eDuTf5SZqBwWRQj182vAcF1FC+WzyLdOBvkn0s5lQV6VJLLeedfAq?=
 =?us-ascii?Q?mOmmGDpUh215xoX5ELOSfh4Ks92NG0La+OSx+SZ3CG2ZD/4OSOWmWtY/CJ1A?=
 =?us-ascii?Q?g+yArggNeW0j14Ir7VoVcHXL80LN1gbm30N3We3YjnW99R/kCCk72bXpw1dk?=
 =?us-ascii?Q?URIIPIBG0QNLF4cqwsDOwD/XAjJW1afKzezvlt5oil47WLtdJtc9DfVu+tPR?=
 =?us-ascii?Q?jUkEHKxJx3/oA7oiUdfh0y92/u/sR2hSlIpX2dWjwfdb3+skixJ0owvXtO56?=
 =?us-ascii?Q?Ba76REDgqOIojE25ujqJH+ZEUDG9QDIB8124NDTmcYlNmG6f6lHazcgzklc2?=
 =?us-ascii?Q?IPpHRxQ2UbEcqGYlHyBJJnO7zrfBi2NZoYk/QmnQWCtMbpDmqqWYiWQCNwSK?=
 =?us-ascii?Q?IZPGFp5il2mGcNHf1mqtxeRzuvqO5YNKLaCYvv67MnnTfOkqQUH0saKEsJ46?=
 =?us-ascii?Q?l0b7o3JVhGnoCqpBM74TCinSjzyCEFnWK+5gZEucA8xvIk65zC781pn9bRM8?=
 =?us-ascii?Q?81W2pxIFRaliapdJZt3+ssaou3c55fmbKA8AqMrxRqHO93EAViTvwQUpEngk?=
 =?us-ascii?Q?rLfbMb06ZF09VSKhZmxapYQrj2HPuocTsaHGB3YykbNvdXQLrFImCEJ4niwR?=
 =?us-ascii?Q?S34D4cA2pdWMA1jqqlkN866RyP5hzR7Ygkz0OnNvnjffp9Yy8Zc0whnHgW0J?=
 =?us-ascii?Q?8xnJVOcSmtFXqjcu5sWQGt41ngdIspDU8GbpB31IhjnohAA7mXB2nZyRTXX2?=
 =?us-ascii?Q?ZlO7LmdBHcugUPiasN0MWKBXhfxcE5sldplPK9V8AnPP6S7zMlJvl+5mKqQe?=
 =?us-ascii?Q?5eynL1ZPUJdEsPUWacZNXa6FSpFpQg8gm+ms0yyZCPHONCFWQ1CSloNi0eqF?=
 =?us-ascii?Q?RBD3AUVk1EHrC3GnidsxUJFj+8NlEvI3Bli1aauB6QoAKX3YB3KJmW0v/crQ?=
 =?us-ascii?Q?LWT7ebHfQ95t7ghPJCNVcS4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1599d558-eae8-47ae-671f-08dcf7648152
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 15:23:42.0550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlE2sKZrawEwDo7Rbx9qyIU34pfkhkfAxlS+Gc8+kYJyi+GH58Z2um8h+h2hbxunKHmWuppGo8tJBWwldcXmKhOBiI3oFsmLlIjpeAC5MRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5697
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series implements following subcommands:
 * markbad         -- mark block as bad (clone of 'nand markbad')
 * nand_write_test -- destructive test of flash blocks (clone of 'nand torture')
 * nand_read_test  -- non-destructive test of nand flashes

Changes v2:
 * add cover letter

Changes v3:
 * rename 'mtd torture' to 'mtd nand_write_test'
 * rename 'mtd nandread' to 'mtd nand_read_test'
 * improve features description
 * code fixes suggested by Heinrich Schuchardt

Changes v4:
 * fix missed renaming
 * replace '#ifdef CONFIG_CMD_MTD_*' with '#if CONFIG_IS_ENABLED(CMD_MTD_*)'
 * improve nand_read_test output
 * use do_div() properly

Mikhail Kshevetskiy (3):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 452 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 490 insertions(+)

-- 
2.45.2

