Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE42DC30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 05:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BE85888A0;
	Thu,  4 Jul 2024 07:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 008F988886; Thu,  4 Jul 2024 07:50:35 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB1488001
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 07:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=minda.chen@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmIMvKQHIfvRFyNUdqyWPvRcDlW128joCOWR9c0p5qUfgq91rLk+2cjX14a11BQyKuG/J0O71CChxf7560FiWPHWBps9scZLCmbS3tay2Cd613hZ0BoTtpcDqxBM8hLkMjlgv2AXUD0VEzQT1Gt3ukFgtgV+tsd9MwJFd0c/gfA+Gij3j0p+7eI9XPGjrAWWTutIRWLO1w7WUcbdIRwsOY9te5rKmXGk0Qg/4VtWR7K1DunegzzPfbcRYfdLNAtxS7sBxMcUU3YURDh+IXZoifyD3XRE6kL3+WY7ToCcsJvzqFKqnFqP2CzNc86/Wg5qlyz2mfR4X5ABziJd2E+2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDdHzCQc5qDfJLE11ZEBBo2WEIlPcVFBVFDTts/pLlk=;
 b=T30U/Hyz3yWQxejZh6lDQRPBe+zBolIJtyrkQJK2Lc10SBiYglkAimSuMyYPyROrNkK57A8/n3xHKKtF2asjBTH8VXpawTdN3csUJLhRtCHW3fjltpWQDlrvq0JV8lHh0uV6J+eBPTlRs7cCfTCXJqJMHCZ4C3f+/cdWYgqIYodxyEPDs5v0Ej5wmNtouYJez0tDCDZi4Q7cxi1kLoHLLLbfORREJyAewK23MEkwgss8+jecjCETWGP+eYl49DQquilcEcYkDyws0nEd+kmbbl3OrF+Y1+iMBYwmMZx/PitfEskrc4QpGjoLzsy7RviX3BadjQnDKTFRV1b5UdLHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0766.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 05:50:26 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::358e:d57d:439f:4e8a]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::358e:d57d:439f:4e8a%7])
 with mapi id 15.20.7719.029; Thu, 4 Jul 2024 05:50:26 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Sumit Garg <sumit.garg@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Nishanth Menon <nm@ti.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, E Shattow <lucent@gmail.com>,
 Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v2 5/8] pinctrl: starfive: Setup USB default disable
 overcurrent pin
Date: Thu,  4 Jul 2024 13:50:11 +0800
Message-Id: <20240704055014.55117-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240704055014.55117-1-minda.chen@starfivetech.com>
References: <20240704055014.55117-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0766:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af5b365-1739-4b5e-5774-08dc9bed3454
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|41320700013|366016|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info: 0f0wr6s6iizWmXQVcQ3VC2lMC2z/bPzEcpL5zYXOSYZYgDPCfPDajQOUpZWdHOojWJXLrfvM3kBBxa8330Jarg6cWSQXnYSi03SuOOTN8SPwXvNJF1rg5Nfu/bCq2B0FyW8ZtP2JzQdMPNG14e1GFK+f3oSJB1BBUsNdlUOd7bsh8R8rRwEfZp9D1sTMmfj6hl2dfk8iVDOTm2/0fACWBrPK731tsa4YXPFV/uyGCppcGjb7jAOSwNbOQxKrCfNdequ4dqg/S+gwe0eauE2xeK4NTY1t/pzHETFvL+9AIHIz9Kr5itbkQcfO0sv+x7+pAoD1O82cuW2kwllBjQWoxhPNv8EUet5Q9nAsPbwXtFV8ew7jroW3LR0H9BJldhgwtnSKZqu17syUD66n6uA4tdTSZnzBumUX+BsOFIPriSOnNLtb1I04VjGnm00St2EsHFAml0Mu+tLcnRKqXfHWfvlJg2QHNRD7XvfFsIjYxeuPa69tVUoBStpJiOgQrS8tO3Fa1pnvdkpV65rIdPRXMKTCq6NQt40dMWsImMxA9Gf1CQSLvUGR+bcoUtkieaxJ6MK7Ke7X0dSB2ebd6F+2DP5Zsh80QzPdkUPFk+U2RyjnAQV97cxcOzuZw1eLe1mCiHxzeZ0ctPMbGQ8AkoHCzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(41320700013)(366016)(1800799024)(7416014)(52116014)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPbR7X5H/lRsRMNKOS1LfJ+hudWCKaysAfsHlB4pHZbpn0zAl2WH2hu6PH31?=
 =?us-ascii?Q?8pHY8UYcn3V3fWOx6A+puX1vPaxjwjPp0fMuOO0EO4Pj1EhUUsbD0B07vyve?=
 =?us-ascii?Q?DwLDRyY9djbdSWLYgEqt0zjKS/yza5NDs8JgC8blG5/VkMVaGMxicvWomoci?=
 =?us-ascii?Q?F4Y3VODfUWxwqyxgLAfWxb419N/jiY/5Mro6hcE5NrjGZFItRDdmsjw8RKVr?=
 =?us-ascii?Q?3KMgC0Z0rgXGg1AK8678WTlsJ1UPdNC9p4izeqdClGyvUZ3nhwUWVaflnd8Y?=
 =?us-ascii?Q?Jvlg4S+t3LZIelx0V47FmcdXyaSTfuw4LJPWwqf6evC/LhRyYw6laZApHxV6?=
 =?us-ascii?Q?MTKrhCzNj0/2epDNcV43zbQdGJ8HT86lYD6c/89tWkjr8iXbE3CZY8wdjz+9?=
 =?us-ascii?Q?V7nT29pivZgT4Lne1+siXqXBTNyDzLCDQq66036vuUtVA/0cZCxD2tAj+bd8?=
 =?us-ascii?Q?xEe+TyKFftptuEZ7gIY35EYqlJBp20S2n6KvOz9Y65bs7NohQ94S4E4f+ggo?=
 =?us-ascii?Q?Fa/mF9q7LFkXiOKNlNWVaEalzgrYg+gma2AwErznFw1xVJvv2mAbqq3KDre2?=
 =?us-ascii?Q?Aunay4y02Fq0iHvwdbP3ktAO1AKNf6pEA8Piy28Ud0KfvooE+MSISegWeoHR?=
 =?us-ascii?Q?GOgD/dkNTS8538pEW/Dk7NY7WQucBD0fExPrvafTqql37jOtLYmrsRSo4qP5?=
 =?us-ascii?Q?2NRpyAev34QbxginFY1+UPBEbwJYiuqTWkjkK3wYBEh0M1u+JgBn11Lo7fPP?=
 =?us-ascii?Q?XOsGjxuLJMD1sFaiACtNaVA1/9CSaOF4y6NuZw7TsdMXtgInoPGS9bIPhK5c?=
 =?us-ascii?Q?bYUhLPuWkb/azYhYYQt7QAJRebgOiuouIRZkPpjaLx7a3Yc6/oQna+1XJ2WY?=
 =?us-ascii?Q?m/dC4W8E8Vpc2tQ+lDrD1apEB4iyr4HAbJKw1FSxx4/0Flgdx3RMEkSz10DC?=
 =?us-ascii?Q?2xG/THLomcLPWl+yr9qzuF70P8oPxy436XZkqCdLVUUpwlIzjQkrV0UqpFbo?=
 =?us-ascii?Q?w7wHiDoF+Gl79LjIvM/zo3JsXLvTkWePJSW0OEPhjFwIZV7FARZCv93Ur2Xc?=
 =?us-ascii?Q?nKpA+zn/Q7JYc0U6vdkFzsl/yy+z2uqEOFeGuQZP6N5iJou7tc6lVRTtTPgk?=
 =?us-ascii?Q?/I02wTk7mAPYaIS2917cRMgD5+H68oY6WHsSxJMxsZb2vMrcXiQ0MVWX1qpx?=
 =?us-ascii?Q?OxBlkeMpcXsBHOaaMptvrirwnfqE/Y+Y6fHJi6sbwh7rMGW6L3pQ4b2KH1TD?=
 =?us-ascii?Q?A87YBPz5WmYPavCbYbsGyyKiN/wLwmYiYWOi39g/+HK5jAsFFxX/9lYp0gCm?=
 =?us-ascii?Q?tU+SsfH9mEYsrLYNgkQjIOoPpM2EHLVoSP8IGQSR4HnGtaEyAL6gYrrZq76Y?=
 =?us-ascii?Q?JlFh9HYnng/tdpOyUtF5qkIVIIqMLP6Ulzal/fjqpi8ttGTK+wvjEEpIj1BV?=
 =?us-ascii?Q?aKuAyN6DWAp6aarwMref1qmbogDu0j2pOYbuCshCclvz4tuWSrRWeL/mFfJp?=
 =?us-ascii?Q?wXVzLeBnDJ56P5SnY1rEcjFZFCUEnaxO/g/O/0YbT5vF6FUvj5qYYorOnqSJ?=
 =?us-ascii?Q?U16XWLRiC895/C86c4MOAch/mDSaoCqe1TBPM3F79uwnpWUNUtGutJlo9Da6?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af5b365-1739-4b5e-5774-08dc9bed3454
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 05:50:26.8167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdaleIJCB+A29Aka6jX7xNWR9iPTGgl3tHPC+5kq/mFpqDX91+X61J9wEZNqsIzzyDeYxxALU7cimjn79HwaYHBvIt2itFQHiMPisei5cE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0766
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

For some JH7110 boards, USB host overcurent pin is not reserved,
To make USB host work, overcurrent pin must be disabled. So set the
pin default disabled.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pinctrl/starfive/pinctrl-jh7110-sys.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
index dafba65eae..1102985ab9 100644
--- a/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
+++ b/drivers/pinctrl/starfive/pinctrl-jh7110-sys.c
@@ -378,8 +378,15 @@ static int jh7110_sys_pinctrl_probe(struct udevice *dev)
 {
 	struct starfive_pinctrl_soc_info *info =
 		(struct starfive_pinctrl_soc_info *)dev_get_driver_data(dev);
-
-	return starfive_pinctrl_probe(dev, info);
+	struct starfive_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = starfive_pinctrl_probe(dev, info);
+	/* Set default the usb controller overcurrent signal. */
+	if (!ret)
+		clrsetbits_le32(priv->base + JH7110_SYS_GPI,
+				GENMASK(22, 16), BIT(16));
+	return ret;
 }
 
 static const struct udevice_id jh7110_sys_pinctrl_ids[] = {
-- 
2.17.1

