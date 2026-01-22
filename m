Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289AFC44508
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 01:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 350678313B;
	Thu, 22 Jan 2026 02:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uXURBqpZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A84A8341A; Thu, 22 Jan 2026 02:22:20 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B1180077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 02:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9qhkA8Z0DYnnaaQTb5ODX88zxXs1FaJP/sv9j1HpZ+mLsq3EP7a7V0K3Y5P1QlzaHa2fsENIv8fB+YuWxs51XOA2b6bQEDPcZQiShkGe5xdOMh3CgUejAsjAl412Vb0ZLZdM+lftjkqzxGpPlJQIm2SHOE0ZNyaXvhdFszMnKJ7aKEvfhX1Cvf2IHfaZPhLUlThVowfnBUQb/+NVZ80p7kUneTy1Wq1qX/UkB6jmv1tVJ14lvOWklI10lWlbFYPhfRo9V32Rk3KmBt+tZfEwAjPOLLZU40ljXPdFVL7I0K5G14D2rQGRl1R5xWjQFRNkxgiA8EPcVBpbCPxhr6aJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxV72jJot9QsY6sGYM4wj18L5krynVORtRvMQOmDXLA=;
 b=JNQza7eSgEc5E/I5e69/thigz1VbpWEhajyHggIt+BMdoIcud1xk+0DkYUoaN1x1XVognAPTpGf5na4CatnTCyk9tnaoeLqFXtUB3G28z0lHFM0AxRXei3qlmDfltAiXM5kv/OQAdYIb8vNsA1rA9EeLRaDymHntidvMcIFsIvpGVGXuoJQPMGUO9/8xyKhIhEkYkaWSz912GvqW4WhAb7GTMBp04+VLdELFNHsIydVzULIIcN7HbAleyvc/ura0HG59gKT0G5xr2yD58nUCSA/ooBpPMSk/LFs36A7KvMlhdiD67Y7hH40tO0TBbK2zwixKvA5n0MGc1U8J6eN4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxV72jJot9QsY6sGYM4wj18L5krynVORtRvMQOmDXLA=;
 b=uXURBqpZrid/1R2gN00zXcpoGDHivVNfMbsZVjeY9s/mGXlGJB2QGQlp4Oy/xTAqzmptqpu0Cbz3Tt/+XACrLkMwr7fvV5T4VkeeSt9BcxIVXBEtPWc4eiiHdq/hC4QN4MG+ymgNYrMSptbpXbE0qUJlSbai/vNxdJXptWMWHTicbmqoYsP5ZzYl/diWdHmgUuGkySf9c/yqDGDzNRFGKaECNQt/CRQ1lBYI1FfH2T61xiezjBUTznU7ARqZUkm4E+8b5aXJcA5Ljx0a7BKmzyOulGrlLureHQ6zRs7YZnJgNBTVqPpk+JQYA1Hi4YqA4xLEqIxvWNAEEMoGnwlc7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7153.eurprd04.prod.outlook.com (2603:10a6:208:1a0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 01:22:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 01:22:15 +0000
Date: Thu, 22 Jan 2026 10:36:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yanir Levin <yanir.levin@tandemg.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 Eran Moshe <emoshe@gsitechnology.com>
Subject: Re: [PATCH] mmc: Fix retry logic in sd_get_capabilities
Message-ID: <aXGNM3mbeHXneUIk@nxa18884-linux.ap.freescale.net>
References: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR8PR06MB1055045DDF7D84047F34D2D6DFE80A@FR8PR06MB10550.eurprd06.prod.outlook.com>
X-ClientProxiedBy: MA5PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 1830f481-d64d-4e3b-d56b-08de5954aca0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s70zsw6PpPofPYsBr6JpQiLg6m51gAEsTYPzP1JefYUvZOauRoaNgHgBLoUF?=
 =?us-ascii?Q?VIDYTZL2GnfSU0a2INLhbtV3u/bFz2FV10npJqcDHEKaepE3deUTPpLx63J/?=
 =?us-ascii?Q?XlEIGMAXFtvS/8b1PqBqBUqsQ/biHkmHceZMD1x6h2Hb/nYwnkzzsfVX+kBA?=
 =?us-ascii?Q?MIe8ZHKWTOZkPhDSMAfpAhXZ4waq0aBLZpmMv57BuNTtltjlg12vimaRTceW?=
 =?us-ascii?Q?HNJ5SLQ3RDRqyEBqPI5pd6WU50PjKR96Lhju7HdkFp4KKvOshDeoMT/PSETZ?=
 =?us-ascii?Q?f/wvACKRGexqrriB7L9ZO/6wRTzovght5EdFu+dcx++M5eQV2/GyrylQU29D?=
 =?us-ascii?Q?69xJTC86rVxqtb8MUZPlZ5dOo5XUDXNaIQloUb4JwteDhhzXNhbqA+/QPo82?=
 =?us-ascii?Q?oUTLCm5Skf1VLX0SjX6SxiQkm7C1r60jexFcU9cBl6huQNQeOmF1lGLFFfFu?=
 =?us-ascii?Q?7JKX0sXGCzrdzqIxDWyDtqIjzcvaFcKcD9Ll/V/FoRg2L+FLzQUly5lBBw+s?=
 =?us-ascii?Q?LJLlJOVSxOUXgaEVXZEYLIhhV1sbCoIdd1FKIlGCNBJXUXX/ZHO2InqTNvtf?=
 =?us-ascii?Q?dWWV1MkPeaQrMnd2x/LjJbgCi816HnRmKyHBKR3j6DdBFtuvPNvJn+iwv+1F?=
 =?us-ascii?Q?VFTaliho7Pjnu4O0fcNVEJZ+XtRitHNspjPrPFTQ5b4EHR10AT5gHkBs/Anl?=
 =?us-ascii?Q?uhRtblaHEZAGHIVDHDZic9qHp7Y2Vs7dH+2onBEa5fWn1KE/0rn7aG2KH3Pb?=
 =?us-ascii?Q?uSMA+LzfGm7t0BE8xCUIhZBs4gL7HgUTxURTnGslO4I+vKMC7kvOuJ9YP4d7?=
 =?us-ascii?Q?2WZ8hw5uqsoimfqmnFlKGb580ANJn2SodVTBy6cpd1XJFUSq8UXf9buyCuDG?=
 =?us-ascii?Q?ZjcaHSkf7YmoN7RzKezsyFkRGyPb8vjsaMttESBTBaul/l3xILtf/taK034P?=
 =?us-ascii?Q?lUzoh9sjgtZ35Xsh0mo0yD+9XqWtbZNpQmSJjPH1aOdjmRmNWLUHVxJJWfmk?=
 =?us-ascii?Q?dEH8YbT/Ps6zjS6bBsDturKne0nEtSRF8exuADWAymOyiJ2Be7DhnvtKdhB+?=
 =?us-ascii?Q?JYtH4bzarDHu3CGFxQuCSYc6hh6ijPdf4bzF2UI8LxFYHErTWAN4PraKejyd?=
 =?us-ascii?Q?ZComNbMn6OdaRaGo10v/tF5vJMfvYgBswezJCJ7ltnDXyanGFUR3TnQdZBF7?=
 =?us-ascii?Q?fZyfVcAbsjfucNlZmxXRBdQiKPplmK0tMSUGQZyB1wd2thrQ6zhElftQiOpS?=
 =?us-ascii?Q?lz43Z36KQ+f8sSkX3lHBObJ8kwS+x5lg/BpFfWK6MD3galmd0BtR8PmUIyLf?=
 =?us-ascii?Q?A4fhJVXT3azg+BF1pveN7Zctq20YlPS56RhRM0dsMFtLaptzcxTd2f9oApRg?=
 =?us-ascii?Q?qMtdgJa4Gb/q0WdhFtrPZc1fLr2A/1KRJ3f+F2cyMtpVGDXQLW4VUGPXu06L?=
 =?us-ascii?Q?sgKEwPfiBHYBgag/8vJthf/LkFvhIBNZ2TdNmPQj02E0wsCpHyYli6XBg3Do?=
 =?us-ascii?Q?sCiaUypkR0fjmBfQYoAml0Pk0xng+vwVjd/1qghEEsle68D5LfWJrp4wtZY+?=
 =?us-ascii?Q?/zI3PqUgX8LT51hh4Ioc8anRkOvMgPHzQddgHU6QjMt+bdyXRgXlsn8o+cU2?=
 =?us-ascii?Q?sdAnsCWdF4sTtzSadGQOh8c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eqQZm25PV84a/SZFiXWhE8/705m3BOvl+lHORoRpJl39lQMhVG5SeRJaLIyM?=
 =?us-ascii?Q?gdDHT/6n6oDw83K79I+SPz7Uxx4zNwXQqP1gEvjvxlkIKDLioY6a15TBn1/v?=
 =?us-ascii?Q?ZvbjR7UHlr1M8FfyyLMul9t57DrIln7FoNgOl88AaqwkUZY4yvAwX7yyDXq8?=
 =?us-ascii?Q?QiRtNaWTlaZ+d0tscykEmPCx63iZJJBrHOTTjZcZO5nqkXFGqvuTbnqoENfs?=
 =?us-ascii?Q?EtRguudPrq27DLaBITkyX5xG7Y1AppVT2hUOkhPy5+AodKkNGZOtDHJjIuSa?=
 =?us-ascii?Q?HGfxgE1VYV0vluj+9GxhSG9Pk7zqEpXUWI7yjXkHkxwstyPnYXY9BRHlYiaA?=
 =?us-ascii?Q?ST6r4f4FOha+ybERxJGbcs9DiGWwHYbLjEZ85s3GA5CGW/YMkwTgTN5CcH3f?=
 =?us-ascii?Q?ZRf/OZ3d45cNgTseiJ4iiq81NVDpMu2x1W/1yTBiDjUfrWG78cq7fru9BF/R?=
 =?us-ascii?Q?JCt7WjVLR7RYyLVYOMIb4Fua3wtzkMFYG5PPjHyq7bju1PClKgxmFKbl8r9k?=
 =?us-ascii?Q?tg6oS7OarzvxS+72B4tt/qDja4J/ApEUdoAxuYpCQ2n/c/sQBGmwYHstYjOZ?=
 =?us-ascii?Q?Chgkg6T7e6bx5s1fRFqnbQcw64hGOQOh4GULcmunihPLG5ZqepK74dxqhefM?=
 =?us-ascii?Q?dWIqVI/RL6FR5kRlF5/tGIkk49eFWxlGyeq1S/VRBOT/SclzamhDf5LF1QVi?=
 =?us-ascii?Q?FLZ91rZrdyhHRTEy11QD49ZlvLDXwM9VPRhcZUOwh9fW/sKh7YK2pzI8e26b?=
 =?us-ascii?Q?tQ04Q9+PuDCbMjrUVfXIFLF/PefxRypwlOjC0vz8r3sQsMeORBFFpag6YZJn?=
 =?us-ascii?Q?2k9qCAvjMuysWFp+ZPXbitdKNzesJL1OZFX7lz7RuT0/yNd9LSPRJNF2Mt6M?=
 =?us-ascii?Q?eT8qpKqweS2BknNHXFOBIQ35KSKyFtPmKTygLJ7v4/4Di2vOIBXetJnOf4Nu?=
 =?us-ascii?Q?lEPVKtBFLcyxlQCzDtiSNkuo6h0kinkh1ouXCWXnnE1LHNIc54wxCwU1kWJ/?=
 =?us-ascii?Q?Q5RWLDX8v9DtTyBF//IC92rY2pQde3aNmBy7Nj5b10bnbPe3J5H21bZx3tZw?=
 =?us-ascii?Q?3Bze/lLjqS14ctjEydrUn9+aFwIEqKcISfpMfMzw6fm0vga6fMFC/TzsaB4Z?=
 =?us-ascii?Q?IGY+xnAAWrc7Qa6E1B+XeDBmZkVomogxtjIIRBVe5E7PAxH0qoc1b3BbFqs0?=
 =?us-ascii?Q?KdxE0jsKbhFnq9GNIPdU+EPc8BDgJ1iU9+f4jDN932CGPf04llaOnyzDRb8M?=
 =?us-ascii?Q?jv3MKtUAgDTaKNU6CmASaDRahUiH8A0InRPTUjtjibNbsMl0MxCfiOcPqHVM?=
 =?us-ascii?Q?RHU12GVVghf7hWmYpUBhGm/6dLnoqde1L3QwYoOCGZUOtEdyrRPB8hTbEdVS?=
 =?us-ascii?Q?BMQlwI2S8aiIlTS7J+6+aMRfq1NgTj0h4XANwOTLxlmrgkNXaEZ1AU3JxiV0?=
 =?us-ascii?Q?BlXUv7cJD+dV2pBS7Ht4Lm3m1ANvZ67130oJ2Q9J85b01bq7ZWtYdkZ2jiC8?=
 =?us-ascii?Q?hwSkfzWKDffImPn7y7ileZxGIx3+NaRuT2zpNwHb4Uv6ioXpiRqzwaJ81r3P?=
 =?us-ascii?Q?YcEt90t3MgUUrWfkoOwgNn2mpRJozHhasgNO71YiDR80MqCgTbuZ2WgklhQF?=
 =?us-ascii?Q?BeHu9GIqDePjwWbXG/8SfYEHff04ArBpFgpEzbn3DAosOk66BHcLLuqlOyco?=
 =?us-ascii?Q?9CSL+SZAn9SBGz0WT0xlUnVWXJM1w/dOKvuMLzlqtKD8raExU2YNvNCuQud9?=
 =?us-ascii?Q?//oIEGivqQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1830f481-d64d-4e3b-d56b-08de5954aca0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 01:22:15.2333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: px7nWVQbsY/Wb6vuSHzqQ/Km6aG4xbHj3CadlavcgtA+xqZ472DtJp6fsO1acOMJVq6eMYFBCVDWwoXXjCQ6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7153
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

On Sun, Jan 11, 2026 at 08:21:13AM +0000, Yanir Levin wrote:
>In sd_get_capabilities an ACMD is sent (SD_CMD_APP_SEND_SCR),
>which requires sending APP_CMD (MMC_CMD_APP_CMD) before.
>
>Currently, the ACMD is retried on error, however APP_CMD isn't.
>In this case, when the ACMD fails and it is tried again,
>the retry attempts will not be handled as ACMD, which is wrong.
>
>The fix performs the retry attempts on the sequence of
>APP_CMD and the ACMD together.
>
>Signed-off-by: Yanir Levin <yanir.levin@tandemg.com>
>Reviewed-by: Eran Moshe <emoshe@gsitechnology.com>

This patch has format issue, please fix your editor or mail client.
I picked it up this time, after fixed the format issue.

Thanks,
Peng
