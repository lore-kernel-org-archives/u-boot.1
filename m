Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0338CCD1AA
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49F7B807C0;
	Tue, 21 Oct 2025 22:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Rj34bRZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84C5882B20; Tue, 21 Oct 2025 22:54:24 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89ED6802C1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKzGJ0lzevZmzO8iNx6xEWjZnBQqcO0LmG9S2hfrKD02EC8EX8mjOF9i8wr62kYvnPyCNam56eu+Ex8F5/y9mpgqGXO9bjGy1NzzEIxRBoPpTglD/A8H870OVStp/rz1EmGH5t0HyUJJSq0WYeq8G5nNM5nk6c/+xoM9sZzpLgjub/zeH8EPnVBW41ZKX9VO+2bcx8giwwplVnQ74W+Z0azVVW0ktQ0SZwAXxgyQXqFY2Q5KtZm1Py7c35H9rvH2bfe48K/UiXW8xUCK56MKfzYp0hnNC3XlQeSXMRuXGJPtUMfB8ru7bn3rY8TQI3RqCvXyFLyJKUxRSg7nNw7wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHpTX24dCV/HqnVrEb2y8zADsN5zuWF8MTTsFhcHPVA=;
 b=DDSn34c8CxIQZddMnhigR4dnRp40r7ZhI/j5ND+YGa6TMHQGONOhWdKe1Rh2+OWq7DQPpDfEoPav9IiP/XptRMZ5cMRZ2OmtRXg2eB8JGt8+s3mcq4WgG7IzZRzFkbuO88PcdZCLdyHfrgl8bwTBqxwOTI1UCYLp7O+MoAsnVexaGCepQXIPPSMfBRzGnvq4mXG4Ih126yBCgKfStf1L4sJsloGIYd7RE82Ybcj+pWa9vfq0CXqqimliJXB9tK6fa1MtHrPkZ8bnP8S4SIdIrZg26BJ8ker3q4mtetC/dwn9t9k6f9GxsHuowqA8YBgDySWhcEAEDoYq22qHiWe+XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHpTX24dCV/HqnVrEb2y8zADsN5zuWF8MTTsFhcHPVA=;
 b=Rj34bRZd4y/IYmtUveG0PjMSYw8t1kP1T29uUHYkSujYiZApDb/r+Jlt6yDOjjcjQGRDapijqmipDCs4GNSW7kXgPVobNps7Ze7TBv01ScaqKAvx7yqic0vYvhBNZLnusEuaPnUNxAE40rpyxO9fHYC5csplOyLbhoCYPixVlbjrvXbTcD340Qgu7e0Kdb12BTLLF1SQdBWI/DxA0YUEk+nN6Blz+pngQNaQkmdZEnObSECQm1csQcWnei2XSXCs/5h9SCC7MCWee7MvTEv///83OZKbmf2MHTRF+WJi7C2rI+q0Wj2rN9KcRB7Me4w+0uC4FGYPIBsg6O3TOHwExg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by IA1PR03MB8100.namprd03.prod.outlook.com (2603:10b6:208:594::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 20:54:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 20:54:19 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 tanmay.kathpalia@altera.com
Subject: [PATCH] sdhci: Reorder interrupt flags in SDHCI_INT_DATA_MASK
 definition
Date: Tue, 21 Oct 2025 13:54:10 -0700
Message-ID: <20251021205410.2878-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|IA1PR03MB8100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7388972d-6927-4ce6-daa1-08de10e40132
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+1WrcVDomdid55Yw42HMYiGNYtvHq0LvhnbXBSrs9GSAGNg+lYJbSRRqNEgc?=
 =?us-ascii?Q?pBG8JYMbcCqRAhujuAgUzuNIQ15sCWHeKRHUrFxNrS5Xb0l25snfkhX1kdvW?=
 =?us-ascii?Q?rkXbBPo4fGZ2bcOX/piPz5pEYqERzxOb1pric4JSz+zltK4EnSM66i26Rqtw?=
 =?us-ascii?Q?csBToj2Kb8AiZkp0XYEx9zibqAAEI6FKbmcQ3UQpsRWeZLDetlEJK6oLEgI7?=
 =?us-ascii?Q?b4fPYu8eRYHn9c/jQjePorurJosEHdyjBncqJVktoMcvI5jhVf+pLck6rQYm?=
 =?us-ascii?Q?iPYIfh9OziQD3v0Pg3ass9gu0CH+yRELKlLIjqxHfhbh7Bt3uNst+N22VsKY?=
 =?us-ascii?Q?r0OH1Xhczq5ULCBlhKHM1Y0Efu/JHnuM5r741DhraBTwx5q+XbzbyIACYdJU?=
 =?us-ascii?Q?G9qpWYD+TzIJswtMkM0vdlSHlUD+rAviKNjuzV5wEem6Ovv97ctk42XrpYiR?=
 =?us-ascii?Q?Y9s5mJodz1FF0mYO6FpWVfw4YGNMrnhJRDd/6jnKz7HxfB8ML2F/5PpvoCuZ?=
 =?us-ascii?Q?9xqL3aha98VBvRCDJZ+UpcPZDg1EhYociPtK33QruCwy3LwEADa5xEehyK/t?=
 =?us-ascii?Q?8T5yRIgy6ZJbV6lYD7Rj/985BT5GTaSRq/fvXsiTE6fQrYFQfoZPb2J9FcjY?=
 =?us-ascii?Q?O+INszdLgXP5jyIkza7jMoIf2VOo0EH9hHbWBg5lGEBZWS+mx24pFkfwpyK8?=
 =?us-ascii?Q?OoPYlL7TqUctifK8oCdRIjik9Z3vYhxsFo/3am4CPDlJfGhaexhlDPJeAaeD?=
 =?us-ascii?Q?7LwANt3pOvlnpGvkhlGjLVA8dgVE4raxXXXsw4g98+Lc7YoSLJIK2WEFzTgY?=
 =?us-ascii?Q?DzEl3n1DwlYqE3AQHC02wXjG2vXSTz0pcxUW25pZa/O4lxlCeykfZAUh50xr?=
 =?us-ascii?Q?AXXU4iSvx80zDqpuOl5xRgBAehISHiSR6LSwEr3LfZcGsx76CTZxu30QN0LS?=
 =?us-ascii?Q?QBOg1qaHotPftkann0Qomv0EtVYTS2pPfNaPjbA3y0hXW7z86nUrZyBMGVwn?=
 =?us-ascii?Q?2S+5rxKkDyuby0v4DbzzC160uPgqY6zagPgHpzRlF+LiPEQjI34X0jY4LKnY?=
 =?us-ascii?Q?s6eZRo/PcYYVd1yOu3LuuYnRCH+kQAsmpJ6EE1Nrrt6N8tIcpsaYzEQ+FL7l?=
 =?us-ascii?Q?F23fLljg+9SAMj5sgKGbuNTqWdnIx8iVQZdqsydlN4iD41rbe9Mwky7FIzBg?=
 =?us-ascii?Q?NJRBSJc5RAxVbpgPjKExAbBpVeyus9Dx6JRROTsmEXq4u7aTG9/+2wfR4QY1?=
 =?us-ascii?Q?F5j0zGUrPz2aSJ/VdEnPGHTOZgTaxDnR7T9V80y/OS0W0LIXPHd+8sUXmddT?=
 =?us-ascii?Q?J1vl43qN7+G2/cnzUYQHRHv84rgWc1cFvyCSMdLiYVSbUGbhEM/wCSCtVkQW?=
 =?us-ascii?Q?NXw1MPrqSW60/MzTF8lxpx2Y9WI9fX7/utUAR0kk7pJdkvnpf6Gq+++vYdFt?=
 =?us-ascii?Q?U5sX/+ZuhSGoG8ykSmEdx5kjy5ZdJAd6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CUs54Metyuc2xxq++BIcEK/zenjDM1KWAlPDV3itUD+jc+oRNa0AWA4GOGvZ?=
 =?us-ascii?Q?rUNz5EZW7DUZM7skEUJFtz1r9BL17Fz8Dpn+raSp3LpTWNwaMIeueudsankX?=
 =?us-ascii?Q?Oe5IVBVUHNJoCzsglap3qudCmg2InXUhiIAzUBBHSfmd4ZrMTb+kfWKbkexl?=
 =?us-ascii?Q?qDWLKq2GnwUi2H/o1Dd8iF3RzUUNgumAeQVK4FOsIY7Q284/gocGyTbVNjbC?=
 =?us-ascii?Q?VRnNMBeoaWBYAdZhgSbtTSXJr6pizYlvyj3dhDcTtXEU0+hiSuHk1y0eWUzy?=
 =?us-ascii?Q?EbmksauINZTf2EJ4SMsMM5i/aBr+AERqosh6ERj7B6oomilqGILnCLSRyCZi?=
 =?us-ascii?Q?4a8UC7n5K6JJWgNV9Ioz/HUqo8HAqjLaGmVxlYvvDxc+hya2YnV7U0O7Xd5K?=
 =?us-ascii?Q?anNzMogWDSXzEv59dTh0mJFjEx46RnjB52r+7Mt0JHGnp5eGda1GfV0eHesu?=
 =?us-ascii?Q?hW3y3K2Wh8CROcQF05vfiddJdps4Qq52QkzZAkoEX8xnoqCUEpY1c2F/8Ipo?=
 =?us-ascii?Q?abjiADcGEVBepA1zW5XeJCuFNr7/tNx/WpdEUsCCUi/f+OBqEHNjfH+C3DXu?=
 =?us-ascii?Q?X8RZTsGitKNkvhVHLTDWlDtBwZXBz+FSQm+HSm7Ro30nL/INgvJnxtgZEK2o?=
 =?us-ascii?Q?vzbNZ/mzwegHFpzBHxb2RQGLDMyEE2OpkkJ+TP4FVyuTYKvY1ygvyNrgaxSg?=
 =?us-ascii?Q?p/pDO7+WsE6RE+YYt2/BkCTw0uEqlw1E714iKv/P38hYNrnKLIa8ONsxiV1a?=
 =?us-ascii?Q?3XkW71IMatTJZsKaUbeKl+8TzPYKv1p+AXe+2N+roh8AyUq3PUa72qtn9Dno?=
 =?us-ascii?Q?RJqub5W7tELuFvGNiWS5Qw+6dPIw3Regxc2ww+4wCMyxqVBvI/uNUd3O5iOA?=
 =?us-ascii?Q?514lz7vqu2dMn175Z++XzehuIfLodV7LsvlSWZgOsMsMFHQOpSYPTQnT2Rx8?=
 =?us-ascii?Q?JwluZsSYpmVIPA0/QW53gBO8EP6yzbgL9xiMbxLDo4rPP0K/W/Z11POZPeVy?=
 =?us-ascii?Q?OOpcLaiJTo2SoZ9wr+qsVVrSpjDDMzyVXNpEcr2ZRbXNPVAy8VkXjYX+rtEn?=
 =?us-ascii?Q?6oFJ1NBHnFdNtmNZwENA8eBfhMB9MM9DAL6va4J0PKb3W7/trefe2XnYQjcE?=
 =?us-ascii?Q?NUDBXqqk42rBE6nL13EgIx2gg6hi/MVo5aqyJGgPXKptmek8h5GiVnmGvnoG?=
 =?us-ascii?Q?zKHrNN5joAMZVwIYrHDNRAxYox2iTXzlG4RE9wrn7h23ltGNxdZ+bJzN35Wo?=
 =?us-ascii?Q?D4Hi7Dr4RbrleZOfyDTFcRXsEyfewo6pj67BB009qYnYvsY8sZ4QbpH/VQt+?=
 =?us-ascii?Q?BbUtpBT1jB/7WuI5vqnEtNjuVbXXZ6CM66nAJ7F7Eshc4bbhetIvsCX9Nknw?=
 =?us-ascii?Q?J8Jgx6aU6lG8hQKrwOvQcGUaLWuZLG7qjXtu/KwRYn+EUQRaB57xTpO7Xktf?=
 =?us-ascii?Q?XRxIqzby79TS5lGDX1ft7naqo9Z0oTq8XWG7L42duJpYGnAJksMn7MF70dr7?=
 =?us-ascii?Q?rqcRuy/teilU8LlIFS3kLZuhRVrNWdBzpEM/NuzTVwxIYx57bYbo6bST9zrv?=
 =?us-ascii?Q?+TzAs7DFOJrZmDo1NcaqvOz8U3vXCpCLPbu8VEFSHLA4nGiyhX79YUnk9q12?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7388972d-6927-4ce6-daa1-08de10e40132
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:54:19.5247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lu1YUXnqUyYaAdeB+MpygeUyN+H0eksNXQ25z3K0mv2QsWWWQaMM0Z3IV7bpFyau6T3R4G8VmYXcChjwNS2cgkFo2mecI9biIRMkqJcOeU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8100
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

Reorder the SDHCI_INT_SPACE_AVAIL and SDHCI_INT_DATA_AVAIL flags in the
SDHCI_INT_DATA_MASK definition to match the bit order as defined in the
SDHCI specification and maintain consistency with the register layout.

The functional behavior remains unchanged as this only affects the
order of OR operations in the mask definition.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 include/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sdhci.h b/include/sdhci.h
index 2372697b743..d9c0597a0c1 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -143,7 +143,7 @@
 #define  SDHCI_INT_CMD_MASK	(SDHCI_INT_RESPONSE | SDHCI_INT_TIMEOUT | \
 		SDHCI_INT_CRC | SDHCI_INT_END_BIT | SDHCI_INT_INDEX)
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END | \
-		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
+		SDHCI_INT_SPACE_AVAIL | SDHCI_INT_DATA_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
 		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)
-- 
2.43.7

