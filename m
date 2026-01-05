Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5228BC79F8B
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99B9783AB7;
	Mon,  5 Jan 2026 14:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZUyaRGzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFAB83A26; Mon,  5 Jan 2026 03:36:36 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2477839F1
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 03:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCQDl8tmc16APTlqtzsHhQRqeFF4AEUd4faTK3y8Kz2VTyFh2d/TOKrODsraE2YrATKpqPxM8UyqdLrI0Lb94RLK2tsWbYAeXKRTFlC1HlJvFIswKzONwAvp/JKhMQcpX3CRxKmLYNNlKnTpV9tcLZkpVbVAn8mnBdh6aOEPWuZBxTRTsGR8f/ZKQ/t2/MtYTDc8YDMlEPKDv6nDPvlit31ntqhUOkL6I/u+8Iy4+oXPxSGdHaw7+mefz66y1ZtwAPclV/5jGjEc4Bm/Q8t7kvbSpWk3ed6NG6tg6KxumKocIEGGd8Fs6nrzth+R4U0aih8jm7X0yMjdIAPlQcvnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxgZnTymkPdHlR7Hr1Z6/5vBBFhyAgJtjvwMEKOia40=;
 b=fu0ndSNNE2BaayiovPyH0TTh24H4DCMnx57cRsMPMP29UJ/0F3yIEm0WY0emIBuz0h1ifZPnsMmQCFbXsWtWeII2UQCJZLP/lI2X+O7T4JYFFA0XSB5uiFZr3SZMK7YTUhxPQl4aT+qgnWY28Gw00u/8qsiQtF1qyNzTGY9w9F9R8xPqL8jk5SgAhVLZ9SpB9tppYHqOCTiPApULNqhElvDhAyBx049IdxQrrqANmFaq3XQAKIrBHIn3mJd54J+Oo5lovZZakbvyCrI5ZDYxezNvz7R0fB/LmgWhduSYHXONo5iME2S1wtXxGckKlD31huSV3yHtodRFMPxFes3U6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxgZnTymkPdHlR7Hr1Z6/5vBBFhyAgJtjvwMEKOia40=;
 b=ZUyaRGzq165cKaaSmU73nf1jTbTWTcrY3zlSmhgUVK/KGJdlXtH7m8W8LOrFzfI+f44ItAmFu1mibxuI+BauxCRNZKclPp6w7/50Z4fJ8ODS/ygtByjXFtBJonBhmLiTnS7wHB1qZbgVPEPtphDvz9eaqt6Hltkd8NjvWpFP/sEjXsLLQBBFTCfkf5df77JCdf0ugtNCKuWhKCD9iSJ1upDoWyT6btOu4H0XlwpR2vEA6SH0aw/9aJQxUAMaZlXuFnfQU38hkhPvIDO+yYx+/LYDlEuLhYpK/bsiSfnaXce9X4Lr8P+hGLkwMlFfU0t0nRw49uW+BZVG0KQp2Hfu0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by OSMPR04MB11294.eurprd04.prod.outlook.com (2603:10a6:e10:93::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 02:36:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 02:36:30 +0000
Date: Mon, 5 Jan 2026 11:50:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [GIT PULL] please pull scmi-master-2026-1-5
Message-ID: <aVs1BjbeFktmzmPi@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|OSMPR04MB11294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2faaea-dc62-4b0f-f585-08de4c033bd2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|19092799006|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yvyWvwv6QqPXNMph9swPavmejdlkf8/ExDEBjbpaa9UGY9tPJs0CKjH32pVV?=
 =?us-ascii?Q?KqswuFCb39RorOiOPyhgyRaFDyIrGCQJdhaUtUaJRZuUhLmZLR2GihzHx7Ib?=
 =?us-ascii?Q?D8KtBI6DCAi3Nkmn0YUrg54fA/BfaQe5AbBvUNLMMkvHHGmMZ91ilN+LfdU/?=
 =?us-ascii?Q?Z21IEZ/0dJZ5BkZ/zbAmh3phw28ESB3DhQEtBwhPqKgCOG31uM+JDZfUk5kV?=
 =?us-ascii?Q?4YdKWkqoO/wGX5d90Pz/do5N0Fpwv1I8yyDrFwjW9iq33vPmmMvC3RaWlG36?=
 =?us-ascii?Q?2AArKNLZOHy9wgg4A/iuFJnS0dW6ZjaDNYs5RL02EM7RyYPQzw8snXhLiClh?=
 =?us-ascii?Q?0km33rmJHvySfsos/OxFcQscVu58y1zMIeVbvOmr0LQQZYzJiWV8vPROqeRt?=
 =?us-ascii?Q?X+fQT8dqJqSs2ZxCxl2slAnpqIwMLe2V1oZwaktyfCh7kgrvDiLP/kw5X7QD?=
 =?us-ascii?Q?fQA42DwZuEHinXAdaFPOIRGZcvmCftBIUNCQCnq5tkdfTWN/LQ027bxtUFgf?=
 =?us-ascii?Q?4nbYHfmF/XkTNLKTS4YJoXP2Pw6QayeT27X9zubm62dPQkiVwGd5awrkeASO?=
 =?us-ascii?Q?LydeZ3CwXoUdkUeWHmZiELgI0u3KNEMqnKFtaH85xs59Nvm3Lbou3TO1K6PH?=
 =?us-ascii?Q?66zf/Vc05oQwG2ILqtWGp9XVGvQVNBji6vEw5KqAQmr/DRl8d51GRQCea5Hx?=
 =?us-ascii?Q?QvPAWAzFykWVWuSr8HNxQuOlGAUDd7yOEa8P5UZCm+VPXQUVPr0GZyjXBtj4?=
 =?us-ascii?Q?8JLSsvuXr9KXNxby6ive0+bVkcdr4cIcRHNsRgyaX3+0+zJMl2x6PM/6gKRX?=
 =?us-ascii?Q?OJDrEvH8s+WAb0+KfwuIrF0v4btbVldtHORYLmL5PPKhb4ekBHCn8pvJIH29?=
 =?us-ascii?Q?sVESzw+KpvYa/PsD6y6jAePwBoHspN3Rq7fYP0WKOjUCTBfS9oSfvowuE0ao?=
 =?us-ascii?Q?UgQbPIyyt2ZK2tOao6zwGVN7wq+/TTcr5PCvyK4x8TAnykFJcZT3fAEAJSzB?=
 =?us-ascii?Q?vdSYjW34WUVyY+czw5ULSiu+5D8zq/Xoo0Kedw33hn3DKXI1T2wuihwfaviz?=
 =?us-ascii?Q?59ruvm3HjViCVcrXWEFXMEOnSQLPgJY2zSAjfd1ZRgQiVcskYV5AHH6EOFxn?=
 =?us-ascii?Q?mwhtEa9QjaRIGZxoQx8C2M355Q4bYLgjPxaKB88OKIh1Um6ylzyTkz9FSg7a?=
 =?us-ascii?Q?Q0iAh+sc40+33j+5qPW2JjYtiuImW0wacB65PjCijBXWHReVsMenl9JF2c8P?=
 =?us-ascii?Q?sK0EUJxfk/KURZUpCJQHaC5yLLt+Lkk/tiSLwqIaDruR3VQBeMgGpxVD/b5d?=
 =?us-ascii?Q?2zEYRNY86JFa30ms2VGgSbBvOjpGFYckh8lKPzgFs+mkWdnKiR5k6fjThkrT?=
 =?us-ascii?Q?uZK1/GNJw3l+QbrAPb6TFTft4PIWynz3TEHRgej2jtVQr3lkAnrrIwXUvuJY?=
 =?us-ascii?Q?Bwczs915iBKO6Wg/CV7abBZeVuosKE0vshJMixqc1ycalkqh0joKAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(19092799006)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uie2ipjtriVDcUj2KsTs+qSCRLj3SsoGgqpaU3hTsx9qel/xk0ZsDsSF3J0J?=
 =?us-ascii?Q?9uZE0/SwSn3QtPFiiyRF2aeoWgxZ0hnryEPSeVh/RgB/X5jqtfWFO/aFLKqo?=
 =?us-ascii?Q?m+eC+KvSYxDNbIOEwiEe8yCzR/rnRW5GF93b1aQQsemlKxOdGRymgKVPYBuS?=
 =?us-ascii?Q?KQr++rLT3+vvnBCQf7x3z196WOhUHAWA3yxp1MKrw4wEFaWmWR4rJapv7Gjh?=
 =?us-ascii?Q?axdcKbW6/vWQZG6RO1BaQ8kIQ5/Z/BkpDcPUbW1o7IW9dRk6BzF7JPk4NaqP?=
 =?us-ascii?Q?vaF8iPC/QK2bKIxAYR9LChB7GCLM3+l7JYFclH7tpyF52/JHKPeGvJZw8NeW?=
 =?us-ascii?Q?pIyG9p7VNlPIlrE0ZRqJCeC1WL9lMVgosbyIjTEBjlgboe+hv7THG5tZJ3zN?=
 =?us-ascii?Q?RsGEIOyHqM/k888OsT+yz4IT7yzfDdabrWssj5iJOxhlWvvOlV1oS+3itQq2?=
 =?us-ascii?Q?QT3SvpaNuiaPPrU8y1iy16+6c/4B8KJwWP1qTOOeWqADMBWY4MyL5tYU5R5K?=
 =?us-ascii?Q?0l7p+12Go0YkFr7tfw/USxCg4XTwj5XLTY3OzoHad3PvCZRPcre6e6lm0kXT?=
 =?us-ascii?Q?7wL3oeAWaR0fT6xmVDN2nsWWdS+HMBgcL/ZVRy8OCiNWLMFE4LQAcTCkz+MH?=
 =?us-ascii?Q?njq2GfI2MZJyiZB0hdEKSIn1UIoX47rYL13ecMzBmwtphJ7/jYHF0HTVSL/O?=
 =?us-ascii?Q?GuLMAc5g+3XK9x9gIQdINHlFkCjTMNfv3Y+m2EjK3CC8xcqxDhwChVaBzzYj?=
 =?us-ascii?Q?5Z6ji7cJOwMDauE0wIgipW/a4jcuzLxRrAlFQupHYxTXeUXBhAfUQatPl/a5?=
 =?us-ascii?Q?VePOg/WSKoo391W5jwFsIH1vQ05kz0P3p2h+xlc/XTcsV6+vipRPxwrDe2hC?=
 =?us-ascii?Q?wFahJcchfUOZnf2B5asR4/zuxyQJ1sY/lL+5fqt4+MK+10CnvEZuAX0v0HbO?=
 =?us-ascii?Q?dcYYW6JylL0toTXQ/b7dTAY9RG3Csyia6g/vdPCVnPur4aB6gYurrM6235HG?=
 =?us-ascii?Q?VIl2FKLjUjmw7w9shxeApqUTbT+IMrnRr6iyiceZiaife9i8XV9bMt7SbyUS?=
 =?us-ascii?Q?n/KlhelhZe746sUdrtLnO8jy0bWB2sje+NOIdtBTB+JhFzvM+F1H4v6FaWK5?=
 =?us-ascii?Q?0BDYFK+PA97UgjcrFsagkFn7j1LmT1NnRifTC29GX5LTMiyGgpPTY9eZP3gd?=
 =?us-ascii?Q?JocEI6IlYdepEwX5QLJCcxt4MYdlFIpHQX5UXINvdPrBu2vrukaZfe1pd1hj?=
 =?us-ascii?Q?3StvtoQVu8iuXh33n+tXRRgv0vGyqBPgdriBf2y/64Qy5x609tBFrHWEeCZS?=
 =?us-ascii?Q?ynWFksiKhTcIrDZVWF041UWS7kU46sLM+D9HDSplss5QZfbvspWxmeWJOJ+z?=
 =?us-ascii?Q?OexjoT2enStxTbW1Oo71i6zwS4KCPBXbDaUOHj1jQXU/lfqlwTENpT2Wzaas?=
 =?us-ascii?Q?G9CZ7C94SlGCHKdD6RSZau6MfW3RaF9j3FSTC6VXXuzNqBLRIwnWXMCfOtTa?=
 =?us-ascii?Q?l5vZx5Uc+nB4JJqtcl/zL2UQCIuk+X7G19u17RqS/RqG5JX8jiSZhIdhmOU5?=
 =?us-ascii?Q?7QEYyZhrtmab13RWvBsQ89Sg3HmbcR9FBwWmda7phW+oQSkUdsNU+bBaxSwS?=
 =?us-ascii?Q?lHunO0mfelUet4J0xxeQ27+8pvckQiOq5BXXHYwcwzoIBIsYsAPZMCj9LH3M?=
 =?us-ascii?Q?pr0Z39rqiRRKalPjWAD+Mn7GPRSsjKRbXYNitC6P/FLgYdJTJWFTwQrGQiE8?=
 =?us-ascii?Q?AX5xMkGT2g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2faaea-dc62-4b0f-f585-08de4c033bd2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 02:36:30.6906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOUWNZm5CXqGxqjXLNx8qRXxxXhgWC5K+lJMXT4TRVi9T8btTWgyOoUtfay7mLBl34qQqjdbXHVKHztEmfN1CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSMPR04MB11294
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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

Hi Tom,

Sorry for late for this updated PR regarding Patrice's fixes.

Please pull scmi-master-2026-1-5

-----------------------------------------------------------
- Fix non-CCF priv initialization in scmi_clk_gate()
- Fix typo in scmi_clk_get_attibute()
- Remove duplicated scmi_generic_protocol_version() request
-----------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/28902

Thanks,
Peng

The following changes since commit eb18217b63b79dfcec704d420fcc61e77397c88f:

  MAINTAINERS: update my email address (2026-01-02 09:03:42 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/scmi-master-2026-1-5

for you to fetch changes up to 4c3aa5356dd141c07e764580807c33eaae990038:

  clk: scmi: Remove duplicated scmi_generic_protocol_version() request (2026-01-05 10:04:48 +0800)

----------------------------------------------------------------
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)
