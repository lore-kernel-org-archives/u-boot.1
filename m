Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F18ECAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 14:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B9E883335;
	Fri, 19 Sep 2025 16:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bob6m4Bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4030B82C84; Fri, 19 Sep 2025 09:47:21 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA59801DD
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 09:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVfEmAvOHk08Zu9ak8PLuuwKILRB3hUbBio9mnmY5WLa3FnDLrFinkDK/lXi+yvYxaqdUQBjx1xz00mILIIIRVm6qV+5yagaPwkkBpulHtlH2W0OHIunIuYugwBSXRB50OuFsX+FCMYVyx0YpPkW8AIdkyHN7weKHRF4bnE21MSW5wpYnnWlZn5HOFkiVOBztuD0VfPv6A9mNPxsta8vZqEOXQq+GmzHhgKzv6vVtQGUadHK7rn0APgbJupRo7MT1fO1NSquY9gWG4tBGBJxfpk1NZcTkZIRMkQijifH8snAdqnmU/uG3k2ZQkwuA50X5AcNiD8p/dN+NzH7iPG2EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yubi09a4+XhuEhLKBH4MN97KnVZgS7QwNlWognJ1JVc=;
 b=uiraL0vPcSIvT/2krTrCFxw8uhLpF5xTKeZ21s2qO/yBWQqH9g/j7MTpL0etAxpLpXfO1bQsI7MjajdWba9Bw0TIy1oDlfUJrXoy9Os0BMeXpPFuYd07P4DpsRl39rHakgYhOTQqq/cb58QWE+8Gp3jW7UaKy601yCjGOiqJptCVCr+qz0mRoGVTC7XlfUWmT6oyV25GXxdts57AUqflwvz1QlsWrNtBSTKjV3VPTyqIyijWMvkEQP/qeMI0wuxsxEkZ/bAaW8oRVuSyGBzpKFDeMJ6Py/L6TMRYzcqOKkhAtChySRnFEkxy0L4KsfmGkXfjtbi1D4eWu+8iEn07Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yubi09a4+XhuEhLKBH4MN97KnVZgS7QwNlWognJ1JVc=;
 b=bob6m4Bl4jrxDqjkG3Gt7gy0/mJVzH3pJcfRYmuGSS0ptPSeE43GVS+xlM3Qu6qE2VHs8k1HV0/AAlQD1uM7MVICI0u4azaYPEeD0YuyyOzUNRvz6YzytKJVFLvTk/r6l1F7XhVUl7RYcTNyMtfPVRH/RL1hr+h8xl7WpQHueyxMe0ulvOXgsyq5mOCoBVYJGxKrvr+n88Wg36Of8ed/xW7LboY1YsD1yaOUktXN/jQVaozohx8FcYEzGimN/04LhrR595zQEf8/QXnjwvl33u517CgUSnok1rGHqja0R3EdUXZB7jUSbixuopb/THZ8J1+noPNFrGq1phpzckTXsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7339.eurprd04.prod.outlook.com (2603:10a6:102:8b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Fri, 19 Sep
 2025 07:47:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:47:17 +0000
Date: Fri, 19 Sep 2025 16:58:58 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, jagan@amarulasolutions.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com,
 marek.vasut@mailbox.org
Subject: Re: [PATCH] cmd: sf: align erase and write on erase block boundary
Message-ID: <20250919085858.GJ9196@nxa18884-linux.ap.freescale.net>
References: <20250919070156.1497268-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919070156.1497268-1-ye.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d86a1d-fb81-408e-f985-08ddf750c190
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZHslmbWE6BkyBXsQEiP2IS3mM+OT8UKmwS6BayVRD/5W1x+mM8TtTJAmo3DI?=
 =?us-ascii?Q?Ws54XlcsSk7bmYkREAc3WS3GqXMJn66SJs30g7bKgH1bYvptz+kbEj+Y4H1o?=
 =?us-ascii?Q?rg4+LO670cqgqEcM7LDCHavHfOZwNtRazn+cDquia8ULLKC53bbeGviddUIg?=
 =?us-ascii?Q?usMJ/1B7+Q7F/aia+odfbWNaz7CW73V485zNiFAcQf11CKZttukBoQQS2l6A?=
 =?us-ascii?Q?VA3feSlZul6wNQJ2br2s0vcd6ms7krNOzXmjIqs1IJTrdeTVEqp8fxln/gbD?=
 =?us-ascii?Q?mBznVMDv8/lR/OgyY/JobWVLxZxNgZODU0UvvGWumCgKKk+1Lob3mGVCkwvJ?=
 =?us-ascii?Q?5YPG4sIJJAqyi2Aq8mZ+AIy5lFl9CCIzEY612wr0CUwxrL5FWYw3n+5eB20o?=
 =?us-ascii?Q?M2AbtkanJkD0fzq4wBbax4uvMo3F8IbVQlAp5gBPWbIqaVhKi/DDZ9VEuVnv?=
 =?us-ascii?Q?JGSVx8WTDPZDpp0xUt5L0RA7U920YA/Xf+0c7+25hZsSy9E4lwu0w1akUAcO?=
 =?us-ascii?Q?qHqXFxOaZU5CcW2e0jKL8N9elhzAcb3+xzLQMpgtKDRuh5nhPXxDQlFU5W7j?=
 =?us-ascii?Q?PeD767YZct2+QNGqBGh+XOeu+c0yJKKTCeBhU04ToGKbb4ILVbIO9Urk2FtJ?=
 =?us-ascii?Q?b2UDTObzykW233GapFu5k4QoAQcHFJ6P2TlQkU/U4qPyPt/1lvYDCSFtHlzt?=
 =?us-ascii?Q?lMpKuN0tXnYaFWYhTUyovMdG7kXOV8pdq+yt628XnITIuBZ3da2hISNbtv6u?=
 =?us-ascii?Q?sx3ayTLYK0xIBBLgSgRhLkJ6VYoGxMYZFUgW7GX3Gg5tVUKRwCw7ODovYRPW?=
 =?us-ascii?Q?dFODPbY6XCKbn4qFGbE4uIjtI1Tx5aaZFcyMYNNj+JLbTgw6Rfty32EVk2QY?=
 =?us-ascii?Q?ZDHbfz+t7YW1g9kt5cSQ7c1pCx0z6sg8v3t2UlRaMkrnYAeIOeH3jyPFrvsX?=
 =?us-ascii?Q?0myl2Tv+NZQE8C/Bk2/hd+Yb9kF6yDZpRORsI8XpgUSak7KUjS9KoZVdC9yC?=
 =?us-ascii?Q?TR13+RVcaGVwO9fuHuwoKcCgUPpH79myZa7p3B9gokiD83XGnBd3RWd3918f?=
 =?us-ascii?Q?q0Yw/DgRyCkmHDkon7mejpsXxKCo9cmIw+2SlYm/4QaIajkTQT/YAkH82nJh?=
 =?us-ascii?Q?UjkrS7ORIA/4tq9NeI4uMzSGrYubh2xgttTBlbvNSUN/DLliLySdr1HlAupu?=
 =?us-ascii?Q?W6Ts5vfVK+1ndwOracsjvGMl9taR2evedM2XzAUs3EwZIEYyh6YDFrV7vPsU?=
 =?us-ascii?Q?1Dk6QaPoiwFjJkVv/PiJ6Oprp9smCtt6DF5xt7Sxj++2QvcBTZHmPloeK5W/?=
 =?us-ascii?Q?CQXVbaWS8SYooxO3lK+zftLbUWN0YRCIyWCcfIFCown+cKB/EFaxP89F9PVk?=
 =?us-ascii?Q?u1EkdWxr4UcZfdvd51tFKxLxDaPtnG9WzsFe99tada3FFU4uUXmB7SYnTQGC?=
 =?us-ascii?Q?94bFSp5sDgM6OOBCYkcHp82s9qcpU57UxqJn/7jLB9phAJXKMGp8DQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b0B0avm/ktPpthI2jJ37wF6ATAMzKVFXukC1zwWJ9CdvmmHeB1/0FyukCbq1?=
 =?us-ascii?Q?LV0WCf4s9YGiICN7t7+5LpSkqXtYy7izfq3l/HkSgpaxv4t/4yz1/M/NXDG+?=
 =?us-ascii?Q?UO/spPfGyOTJBih6uRkQj8eDMr/wDeuk8KEcs1U/5Iw1RNWfZLASyC7z3OTX?=
 =?us-ascii?Q?b5MF9E1edjiVivChh74b8NZW2D7Ae+hXjPG5l+qLWqKsqtZshTLSr456OqKK?=
 =?us-ascii?Q?Z2bxAL8iqoq7UqAUT421+dh3/IxOs8cLtKui3G22MpCL9+APCHBMBSPkBTRj?=
 =?us-ascii?Q?dVK9ORZ65Auu0czye/tJS7y/OF5gcytfG34N6KqSCHQp3jblAepL758M+5Fc?=
 =?us-ascii?Q?rPdS7hNNs64eJG0bqj+N845WP+5s/kJCW1HBWpJYI6U6oWPmPl/3UIk2VnPq?=
 =?us-ascii?Q?oij/KdgQizZeOUdtz8/dcnX4qNjQrzboono+RuVM4xw57loSrVN7tVT8WK68?=
 =?us-ascii?Q?+Cp9+O0Fr2TBQSpKUC2gVOXAJyeZ1TTuyPNFjpAQ6hOflzCzto9HR/Fw9Idd?=
 =?us-ascii?Q?MQ/GjZkKV4gbDofHjAEhjUq6sENRiwDUr14xf8ZLZ2RdRsrwC2esl1Djf3++?=
 =?us-ascii?Q?ac9py8ZdBh9UjIU0BpNhMPUN64K/8A/9kS66jCRL57eJVEv/orE2w74TpyZ3?=
 =?us-ascii?Q?xVp8XLFHvxrUCpPGQhlJJhzv1QnbJESf2VkSzeJxLCPmJOy4dcCu8HF4X+Kf?=
 =?us-ascii?Q?d6vw1kLeGrm/5qFKt8lx4K4zZ45PdG/kTThZU8CY0waCLeHFAqEWZkjKQvyY?=
 =?us-ascii?Q?ASbn5bnl0Wgo26HA0lQTvRoDxskey1WLk8+YRvAhyqtW4/norZqr4RwSCde4?=
 =?us-ascii?Q?xLtP30xJX3N7rKfQEy8F4xT0YqyRhqAusFGN6eteVNYuupG/UHJA+gqiiM6C?=
 =?us-ascii?Q?JS/gH/aJ56lH5uKrXBU72cuZQzr3+n4Y7T4r2BawU1hCUAUPtPt+OHLFJ3Xy?=
 =?us-ascii?Q?aSuBGIzA8vP/OXCXNLPLFX1Pdp7wb/WtenJLNQ5kF5K1wDgHuGiOp+h2svxc?=
 =?us-ascii?Q?+lp5jwkch9IVUWXUeEcVP+NgEQwK+RUeci8pbsyqEA7ldnBoU1mDfnKxGoXC?=
 =?us-ascii?Q?i94JIl35Cv05RPg0VPJ5dVODGryGI6DUBs6pPjYIrc/GQ/qRp+PGKrmHvDnX?=
 =?us-ascii?Q?p73F17McFInQURWXmkRUVBGM9hA+raoVeWTVstT4khjpJ5MFzb5D0FAA0bTT?=
 =?us-ascii?Q?JrAj6CbQPStNJgebosdlE5x95kyBvjIm969nGZoGKDGw88Qn211eXaumnhTm?=
 =?us-ascii?Q?6GxxfT60gR1haBTt3ykIDXKFC8bt5DH3NeGZux32aTOoVNRYSW3ROjpv6geH?=
 =?us-ascii?Q?TPAXvbzK8UmD4B7HdcPgBgMHXA/rIrm0Hs24IdOKMydSRSgP7gUnj5geD2li?=
 =?us-ascii?Q?t+5gb4xL+wsil9F+UZEyII6PDFgGUS3w32WMV40+gdA9BoBQPZz69EUBX3EY?=
 =?us-ascii?Q?OIRT076Xuw9azFjwuwUr7Dc8y1dQxCGxGuT+TdK+Q5BDjlEWAuNKppPBHCSY?=
 =?us-ascii?Q?NpMJ86wYFPNLzyZz3f1r/wDiCoQcI/ZO/xHho9qTf6o1gjVw2mA/nDl6/C5a?=
 =?us-ascii?Q?EXoYlkc3yKUaVGiiWGPAV7KGqUcaY9mGhvTAFDe0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d86a1d-fb81-408e-f985-08ddf750c190
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:47:17.4645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+R0eYeBtFKdRuLMPrJ0Pz8sbU+daJ3Kwmkspt6lBFBnNjKTrSsjknAz/gXclaNuwtMSBZCgtaJoMPqqwECIQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7339
X-Mailman-Approved-At: Fri, 19 Sep 2025 16:47:28 +0200
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

On Fri, Sep 19, 2025 at 03:01:56PM +0800, Ye Li wrote:
>From: Viorel Suman <viorel.suman@nxp.com>
>
>Align erase and write on erase block boundary in line
>with how read was aligned in commit 622b5d35613.
>
>Fixes: 622b5d35613 ("cmd: sf: Handle unaligned 'update' start offset")
>Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
