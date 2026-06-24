Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F94CDB470
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87240849BB;
	Wed, 24 Jun 2026 09:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o0xlChB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6C7849CE; Wed, 24 Jun 2026 09:56:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A28848DC
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYFA8ayFhrqS3IwSeJq819jvjKeCAWOixy1rMMLCr6tFkP+a/97TIU1h7NsMtfTXn0CL5+Au8bBSmwdxZt4jdDlnXKJdSZqmojC+BjMiq3hGwO896AvrSrs0Icw44PMphc4fVz5S5kTAXhpaX4BP4p0ZRT8CUGGP5/EQaJJefZVm7BpF9oEoe/08L/m/3NWPWdR+DlAzxzgMSoDmhBXpQIvramLa1aeC09FoZ5j9EfNwFuCL4rx32zDrzYu04nnklO86qq/KldOYEa2pqsI0H2pIQhYA+yzE1YKfN+INLPZj78k8Jtj5Kof4aZPYpA974vFQ4zh6mX7KxndMefcOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPbiVR8lunmuWFUnKyJIG7r8CBoGFQzZBSuWuy+s/BQ=;
 b=w5TaYQmDsYlA8a71B4DfjVppQ+H1YRiPuMcqe6NCFPipe10+eBkyi0K9wk2p4+ZTs5mlXflCqDVZe75s3lWp9frDQ0SQ4vTWb6huIhoCRHdqg67pY53Ri/wwPaBVAOIgX213Kl0lygLeShkNkmLR0BVEIIlfuDdaI0LqWrjbCRtKoEASqjXVaLIu3vo2cai8+Mh6H6O/RlDcUpCVipA7pN28bxfmi5Eow9T3w9lA582SZRzYsiV0CRJO2Rl2F0vTrOPn5HgHliTOdFYLU2MRLjKPTrv+vRKa14JhFg5CsFu87S3Z/6XFUhrS5N8S48dINAf8tyuMlr9reLY1HKQvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPbiVR8lunmuWFUnKyJIG7r8CBoGFQzZBSuWuy+s/BQ=;
 b=o0xlChB3ht/tfvrqSqVuKIpncZAKY3ldx3qWLkpIuzpRwXWaMP6uxbIyFnqoe7Cb6H8UWiQlu4vR3WjWqERIv9zeqHrefNvdv7yFPFlGIvyAk1B4eh0RxOPrR9tOcFJLl7zpNA8YPfZ52TN/vuZqYpNo/EIoI6/eW3DpF8WY6jooBJb2Kb1WJvMhLQHbEZyhhZvT8ZSfZ5QLjBxZfUAhRAVyU7Ysp3P2jAx7wFtspjAzuF7rdFHY7VLjwMn00fk2Rs+568JA45TcvS5tY692c0Bb+rimHH99FRw0H+voH613WrJCcyJ0Bi5mRRu5jNRlAsVFbZ5kTAFy9FuvNKbHbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB8054.eurprd04.prod.outlook.com (2603:10a6:20b:2a8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 07:56:45 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Wed, 24 Jun 2026
 07:56:45 +0000
Date: Wed, 24 Jun 2026 16:00:05 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: INgo Rah <ingo.rah@linutronix.de>
Cc: u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>,
 Gregor Herburger <gregor.herburger@linutronix.de>,
 Benjamin Hahn <B.Hahn@phytec.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Teresa Remmet <t.remmet@phytec.de>, Tom Rini <trini@konsulko.com>,
 Yannic Moog <y.moog@phytec.de>, Yao Zi <me@ziyao.cc>,
 upstream@lists.phytec.de
Subject: Re: [PATCH] Board phycore_imx8mm: spl: add 1 and 4GB RAM timings
Message-ID: <ajuOhZRfB0kP3nCg@shlinux89>
References: <20260623062429.532567-1-ingo.rah@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623062429.532567-1-ingo.rah@linutronix.de>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: d43aed31-b7cf-48d9-6f8d-08ded1c622e7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: KJ9MaEZWXYPbo+W56kE0pBv2oUkFdSB9WOBhQd0xvkp2lG8IZg7jYqAr4W3GWiP3zZt2y8Q1ihDivoYVXIXY9JqJyn+Mn9D6OXlIdQicQPX5ja2jXTDso9KaJleLV1Yb6UhMlOANVEGcvVtTt8s4lLT3e/5aAUhzyGcInjx+O71WOUmSpRqsnF6Z96xBxmf8HRgqp7a4d10GNAmjynegcqJHv0TCy5roJENBFIlMKauSnAPCuRD+RJV2Rmt3ALDflFODNuSJ045kq4ADWH5NRPD1pT8wrB1+nf4aTnc7gjPUgguk0f9SqYW0Hym9rQFwT/6y63unEdXyeh6A0vkN9/W+koxsvz550Hl9ugeCC9XxEVovveB6VOgmha+k1z/q3DIN6N4H4yaldeJeNaETpaN3Dlv1XihevCjwiGo/ibNgWduGtCh/mMDVFMfdtS9GzMmYCscpQOWnw17gkqWfl7Oz8Iul9iY5ZHXrlYRk7ociPzhPnDvB5UqTiluzNZ2iHrk+w80BrRN1o1R93sNATI2zG0hdANqdOIAmKvkI7Tw3TUk4FSWkX/CBd9pYpURP9jf0hjSiFEed/0z84t7xQ7kvLJhQUo49watzT1a9U63RumF9oL+lTb9TxAlPw9pKVZwFhr+jSxX2dj8vD05TV5oFFbGeBcVMscNFQFQ/P7s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t8wrh1oOxGxNUpq+BCaG0+R5kIfyIW48b+oY0Xvb9lJiupq7bbrKnz/ADl6M?=
 =?us-ascii?Q?If/V8Kz2mLxKzpJgkP5TONDE0GAcfEVLgV1ralKUUuiNTrMySiCUTWhT7Uhh?=
 =?us-ascii?Q?n2lmVbs+wZZpYGACLe5aLIOxK+XkFUfmmRMH/14dq2eW4oRhq89ioPP211Y2?=
 =?us-ascii?Q?hYjbLNWPUT44e6lK1gEFeyzyaFBuFKO9NRAA05Q2veC9JwvOJ0XqHtw73Ml7?=
 =?us-ascii?Q?0YmVjVeAbx+sT4glvR13HOJYQ8fJptx2r1cedvtZQk/oO8RkE35KVCnmpWMo?=
 =?us-ascii?Q?H9+9LTDo29F9tN5wyILUMFZ7MJ3EVC/YOb+N+K67r5xOwd5WqO0TakSQPR94?=
 =?us-ascii?Q?yzEbQu/MOs+/OoWYKz30I1CsLRuGprspNHiviJJGjEwZHbjouWyAsk0ozvpz?=
 =?us-ascii?Q?pPtUvi2l6tPLtQaQKtAZMXSOf1q1+P0qDXkRV0Z9eotQnxrNxjNVfJrywlXU?=
 =?us-ascii?Q?HJIG3yLZ3FQFAm8zWgQqzxWXk5XVMCYBmYloI+RuCEr6tzyPR2+OrgtGM8hN?=
 =?us-ascii?Q?P1ED4dUoQvIbVHffbbOJLlfSwe7cuJUvwtfNx+57M8ZP115fR6eQQf+NADlt?=
 =?us-ascii?Q?3iWP5xT2cYUg3KP5U3Z/cJRMbXxHsgmUEpXMMRi2HlMwSfBpmyZWj4vPsIpP?=
 =?us-ascii?Q?mjSaV+GJmrwEMBqPYUDueIQCSmEpoWZ8Z+xe0ckZDVWTsTke4JWT3yRfOj5W?=
 =?us-ascii?Q?CQG4/WGU9U+uGywwEEru96jiuzZ4i+PTmhdbu9lgYRZfb/EbQCFiVKu+FWVw?=
 =?us-ascii?Q?wxp/XLDuVvTlEBbhh630Qp8/oKmKn4KXambDnx0clZxr4VTDUuDbFU+ccQ9A?=
 =?us-ascii?Q?u008lj/E7aOqaTaDYC/+qW2BSMw4fxgVK5E/PkwtnrU/wMnfsV0R2dM82yjl?=
 =?us-ascii?Q?zPLhFvVxNweRm3+18J0Wl12xVNcEmM0r9AKb8ESgZN9GPOiQFEFWKxEc3JRD?=
 =?us-ascii?Q?CshrwqQI8LWV6xAU63s+PWaX3cwqUmkkdzYlXqxL/i3VmBwBWaS4X2di2MsO?=
 =?us-ascii?Q?igdhqXJ7+UgxLjdD1bWC8qFN+8N/kW6OixOO/dUipg73rWpmKRlGgltErvCI?=
 =?us-ascii?Q?f0prEeHGx38rx29y8Cz3Hg8mRiCNBuS1xnrGouKbvIbtqfOcU/kE9Itexq1A?=
 =?us-ascii?Q?fDuhSZ5yCSSIIYMazkH+db4ne6B+aqdinuPMvKhgoBqHVuZHD79oRN+R5Asp?=
 =?us-ascii?Q?2lR2OmWkSZmmJkpQT3T414qCqjfavAvExbtV54H7DWePVeFvUADeFVJj8qz0?=
 =?us-ascii?Q?ty0NHxegmRNYL+FSBUWJF+M+0VyR5pGo4wBLxnJo/96JqwyltKaoPnaB/+vX?=
 =?us-ascii?Q?ZBtZyxX9gv/5jbSz11rQdX8kR8QJfB0g1xp0xmQzVwmv5SZQ6NJZoE/WYKFc?=
 =?us-ascii?Q?0wV/+KZflXIcwn9Hdh7eiRfZZnkLS6K5jPYCD6+aod/pbBUgffzMNQ2ab471?=
 =?us-ascii?Q?0elb/KbgWeDJQX1ZKAal7W/x30k2dNBApmPwIlGio2ivVN8dvapaAPBhKGyV?=
 =?us-ascii?Q?vX4vsa+kN8NLCVHv4aG5vIEeMYGLGUPJUP5DVf07tl/WEmhphbi+HvC/8xSX?=
 =?us-ascii?Q?6O0gLcIh35TPdGNifnFXU79WA0I/LGtq/C5iqSz/ZQoZCgu/kzfVvLE1JzGq?=
 =?us-ascii?Q?9O+FJOxGIcRoPIqRyRNY9LXcqzB3K2Szbz8d/tXGQEptvfWdtAa2schvlHrP?=
 =?us-ascii?Q?WAgNz4zHQZWMpBCvbaHWdH2AK+bT61KoyzYH83zhPaDYP7nkFFyneAxwM7Bz?=
 =?us-ascii?Q?7/yK/MoNvYLFf6BKL5Kf6llnG5txZYmzBv97d+oyax7mYTe4ZLwz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43aed31-b7cf-48d9-6f8d-08ded1c622e7
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:56:45.3995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+wyPBnU7IOrg0zjEcxv2hRomrfFojTTTOmVoedmAY8mDcf+U2o1IaDGl4bZxzH8jTx0nHqdE0DD+myJTlnHK3KQ6dgip0l1YUxPK6JHRpsmDCDRYFu757dE1F3Kb+Xi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8054
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

I would write subject:
"board: phycore_imx8mm: add 1GB and 4GB RAM timings in SPL"

On Tue, Jun 23, 2026 at 08:24:07AM +0200, INgo Rah wrote:
>The Phytec Tauri L is sold with other memory configurations then 2 GB.

then->than

>Gather the memory size from the EEPROM of the underlaying PhyCore module
>and set timing information accordingly.
>
>Signed-off-by: INgo Rah <ingo.rah@linutronix.de>
>Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
>Reviewed-by: Gregor Herburger <gregor.herburger@linutronix.de>
>---

With above corrected:


Reviewed-by: Peng Fan <peng.fan@nxp.com>
