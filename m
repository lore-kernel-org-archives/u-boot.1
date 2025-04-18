Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD72C369C2
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 01:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D726F82CF1;
	Fri, 18 Apr 2025 03:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vYB+FgLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D00A482EBE; Fri, 18 Apr 2025 03:34:56 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC2D82CBC
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHhEzplKe+7C7OFSWGUTL8eUz4iv1n6KIYAA9mIlUHKVr4zPrUTYTMCHWVjkffcWZxBs86QIWziJlIa3Y/nyorXTy01X2xB2qynmmGWNnbxL43GypUCYejtOzFYJmYJLm4XeiZWIns6JYiUwkqa3kM2MAmRdwud6VKH5FjlH1D1m6KVz+gdveReDbYHEEF8wszRp+o2C/jBs13OteKlkvnbC1vOMnSLMewh5+lc9FYp9Azli1aNfiQn7QE1C+NwK2RkOhEG3WQe/A6ESkUlnHEsxd1xN+UNTe9NuW85jCG6+dXMu3TQCP2u8fRrsDEqdaX8WSBkcqHnJBW3I7kq81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jLhzwlu3EoAxHBfa6Jfcr0lz26Di7TZmI2bGeij1E4=;
 b=CmJa7IONPcY3UvwOTkdGMT24Gt73ioZ2NX3DB2qHH9UHsdnbO6vaxv68QRtnfuPqTWQ5kPUHSM6L2Q/IW9yT6erCqE17+rToyiYqqznBNTds7yLf1YEir3F/qY7BUWCLZsbxyfo3pmhEkLyi6f6Xigve5w1tMxytH9+672762rDqrab59ulKtADotyehTxfTTiOD7ZBOaPu2posFDgtlTiBqOf/EeFxarOAz6J7Daq3MJLyoXHboTpv0a/S145Lmf7Qvgk5+nLWkshsFmjsq7WH6XuPJMf3mT0hOfCzfuy65L41hY2mZr8uc1qibkmKia/UPwVXwtas77bTSWvweDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jLhzwlu3EoAxHBfa6Jfcr0lz26Di7TZmI2bGeij1E4=;
 b=vYB+FgLnvZyIQstgVAsJDWs7QT/Ag9ZKRNhlInEmB1CjV35scnNR8PJQ0w5kjCYQRXL64Ymqgpuc8eRLAoXYjsCZxnJ392qbO1+919fx+/S0QOFWQfCr13sM/ZRkvdmfxyJ6M2mGWQjMQgrLBR5GohbjblfNNJyVd2HK1SV8AZHB6lzZngbM/u3kKslsZDoNYaegg42RJ7yrbOXwLEZmnrqTTeJuFSW5mpKJbAQa2ANEF/j0d3JA4SJWPUxejvIy4fIEw/ZO6K1dJxOvLuqug4UHF3QidrjwUI0UJ2kCetcQmj+cV+rG8AkwwmKjKUMGaDsOVdnoP+TDs6tsCi0ZAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9559.eurprd04.prod.outlook.com (2603:10a6:20b:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Fri, 18 Apr
 2025 01:34:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 01:34:51 +0000
Date: Fri, 18 Apr 2025 10:43:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>, u-boot@lists.denx.de,
 regis.ray@landisgyr.com, pascal.dupuis@landisgyr.com
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: Restore the init_stream sequence
Message-ID: <20250418024330.GA5954@nxa18884-linux>
References: <20250410090021.14446-1-othacehe@gnu.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410090021.14446-1-othacehe@gnu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c963e4-475d-4a9c-89c7-08dd7e193678
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2+vFW0bb9rKf+MfP7ZXoikByeJY4jx9IqxDx9uwwRrlSELkR1daFa8bjNvXT?=
 =?us-ascii?Q?2llF6ajPDABdIRE4XMy+cwEFc5l59958z+PpOLArhHoOve6k2nmEr6W6tiSQ?=
 =?us-ascii?Q?DKzOBTTR29isMpgdopeUEsfTu98tN0MRr6d6lMLgSBHjQDP/dF7VX3EPkIyz?=
 =?us-ascii?Q?323tF1ro0Q+9DGm7M39mY+M87a1+4X3JItAuMVRNpoo1W8KHZGj0u9khfiVb?=
 =?us-ascii?Q?YYmR5VHugVU/rppG0xZVGBjTjz23dPh4KkNwzlFFEMGdbHTwtlSJiJJJTHc8?=
 =?us-ascii?Q?OgLknGxvasYwGf2TxD+ewAAz5tuUspQo/bpkTA032xwFofSyI28rvMcGDGum?=
 =?us-ascii?Q?JSl+RKHmVKFlS8j8zqTvFdRBikNRVfIAr7mSPLcZuQ4SOnzMK5/nZZ3klOWi?=
 =?us-ascii?Q?aySRByyfz5uVzwF+aGdu8eE6TqWm04DSgd+pebbIxJoxRg4yjKfaua/S1ITw?=
 =?us-ascii?Q?r+vaC586ZFSVmHY4+yq7OevHwlpBO1dJwXW/BeCZyooh739GAa3T+xcxC3hP?=
 =?us-ascii?Q?Nh1s3WmLjwLvUX4AQboTasBRhHc1UqDXl6JOAGHiOEoWpVreKPA7r69JZbli?=
 =?us-ascii?Q?cJOaL1HIxpXSCuOrbV65wbwMp/nZcoekbIFVbtjs9Hkfu1xZkLCwQAjrsblM?=
 =?us-ascii?Q?8dQRlsYUmWmJqmUTi+uXl/Sd/FaZPYcyJKl06Cv69SbKxyUP8fI5h8S2JeW7?=
 =?us-ascii?Q?2mwID7tIwlQ4RRIW8/UpIvBznQLk5lessY36LO9xIAHpOsX3B4P2h8bfLNP5?=
 =?us-ascii?Q?eDclfmqXui75ibNYv7dlPnlXx9J0TRGCTpOWZmPiRgBGL/qcYMYCNBMMejW3?=
 =?us-ascii?Q?m8ePbidy88vgdQaShFqhFOpTMUHD78CM7yzpf1ocdObhgpk9o3/sVims9YN+?=
 =?us-ascii?Q?mIgAsIthU29zi3nl1G3KdFCvWbjiT3rxmtTUHNGewH3RoEzOfhHX6aNoOnIs?=
 =?us-ascii?Q?UGnMewHF+BGf7r+9FMvqv5HIqNeTCxnH3XTfdMHIrzi5sLyTB318fcwiblZH?=
 =?us-ascii?Q?+UrgXhNnL1JoRDC+ZTJ5C1wnt7xs9s6R82UXafzPwoEXz4IAp01O/PEnvCK3?=
 =?us-ascii?Q?SXdssaQSy2ZwJh7hDH4Zbsahj2vwg53aiTjHfZuPYHWMIF0b2cXthyfWCJTr?=
 =?us-ascii?Q?29NjM3tYaG5SP+Gggw9o1/iWmdHC2IyVNPDvI2DGPbfOhDYR9X1ynt1ZA0C9?=
 =?us-ascii?Q?Uk3J7UFyPUX0+ifXdnrRcg6GwcwYV/8YYOpsHrK17QdCjYPQd1b4FXBuyhgs?=
 =?us-ascii?Q?8ApxzfTeMXA6E0gvqcjtw18IkauYt6Jx+enMcUgDAq7E8vZWubw6oUscBquP?=
 =?us-ascii?Q?SbNq6b3fan0ojYP+WXdcjlWpw3BPANZAMCoQAfS57RHBT7dNU8ftzmO+JST5?=
 =?us-ascii?Q?th43t1AGuqf2L6H2ov6mX2QxqoqRwSdYcDGQZtRzBmNLHczERiMhHRH5EpOR?=
 =?us-ascii?Q?qJvmdSfmI20=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oVOQoDXRY/lzz1yHSeXpV1ud0RkTFOBb1dlYITPD5A36P75fQ4iGcDGhSfxh?=
 =?us-ascii?Q?q4uFIVO63ETzukb9G499NF1PYF7yS4B+7iOlU6v+sVyFqDelz64/l2FPnG6z?=
 =?us-ascii?Q?ZQ0JFZZHEE6H/7HjTSaZ0UMFB6Etzr8iNqcDs5Zq5v2+4p6Uoar6cf5eNSQl?=
 =?us-ascii?Q?iDuYydIxb/wCZ5PBGiFnoNAr0HJ+vS87YmauXni02SQOMGsNaMcLdpNJn0L3?=
 =?us-ascii?Q?wsidF3x2RyNOI3Y34CgJajKTiiQG+y2doPdnVtdGxmK6zhLwf9rl6dPE4Wb/?=
 =?us-ascii?Q?uoQ8Gk1hh9wk7nzTcZ4h0Ap78RyOT8W6xxZY6OmqpNxLA5uGWEQCDKw8nJ9x?=
 =?us-ascii?Q?b2p/fs9NI8XZLjS2qWussDVXHuh1jUxPQJ6abQD96qQnULFO3BGYbZ9nIMYC?=
 =?us-ascii?Q?bvE5oCTXaIKyu5NIdwvL+JiwIQa27uHQiQpJhi/FyTMxRxhfdOfG6mO0EdhE?=
 =?us-ascii?Q?sq2kjDqogSHrxPiDMDR5PY3JAqCmy0DVmZtfoeGfvrIfN9ZaixOK4dkwQND3?=
 =?us-ascii?Q?W+wYTqFO4wS1g1CGbkA/wpF4znd/yHyPTEsPd6Z/mcouOrmTIKRWuHlAt3Vz?=
 =?us-ascii?Q?OID9SkOMyOYKHTgCwBDuw0CAeobjzvmjHVuTTpgokeL/DjPEAbiw6OSG+rzN?=
 =?us-ascii?Q?wU/sPw6mek7bP7aL4aZBKUUjy99ZGBfAjOEqEuZCKlDOFqDYCJ5qpzV8kB+z?=
 =?us-ascii?Q?CIWty3zz9nfPCK90Eo1ekfbI2a2YbFPsRF0opkoLpKS3qJuvSWjpaFJvXnZ0?=
 =?us-ascii?Q?Rx9Imfa4IrkdBzemqz0rW8FNoAzLn89xP5dTXeVZ9vn/uxNxSb8QNxpEwIoS?=
 =?us-ascii?Q?IV3hqnoLVgn6wJpLOWLMiJge/N1egezReiavt0M9npKZF7p2xEG9LyEKeD0u?=
 =?us-ascii?Q?v6kX7el1uRQyM8o8RAGdsly7V7ednDNINgxo4w5O/tfCaKvBbZ+XuNE4qwWE?=
 =?us-ascii?Q?RCUPdblr5CmokeJH9VS6Fq3s2NmZwIauLtRs9uucXIvkdJ8VfMyMC3IlUWWs?=
 =?us-ascii?Q?JhtkUxlLqYR89tgLrkE46M23Cw8wW0VXgFwLSVWow4z0uXNiEPJr4rZhf91q?=
 =?us-ascii?Q?uDKV8g2c+r/9Q3qFl4Jer9TWTbQ7qR92/M+Dj7KfD7hKCxbnta+yx/6xKcmk?=
 =?us-ascii?Q?zTwAwZziIycGPamSducrgSBURdaBmsRVuyYvWYZ1SWIWdhBPdxfmAi1baR8r?=
 =?us-ascii?Q?//eBgwKjZfOfH1+AuNETRbBHT3j7y/Qs4SNoiqZ7Eonfi49afEyr/bHGlFrR?=
 =?us-ascii?Q?4xqh/iSfd4ydmJSKD7Tm4ENDxqTH2EctckkFzMaN3frlQHu+limh8bjQ6ga9?=
 =?us-ascii?Q?mLGRBXKpFlEvbctxYs7KQB0TwbDh+nKjlBrFw7FcFKt2E9P7Yxm9jXcKXXJ1?=
 =?us-ascii?Q?84wYpPJrIuj2AbIdYYnMHkIhZ4hVqqX9ESHRSGSgptQbY9jeWY24036K6tCL?=
 =?us-ascii?Q?OFwL3ZLX/3I+i5X29U956KCUkYgbh4fZAl3b/vFLWoYmSeotWtRCiuhwVuFe?=
 =?us-ascii?Q?fzcGb4GC9NldcjzIiQmR3Md1Xv5mGFOM/O6+ESkHCgui4DRkVZ9ITpunrp0/?=
 =?us-ascii?Q?5CGRFzzGfYuYw45D4WK307lBH+KTjukFQj8c7sTr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c963e4-475d-4a9c-89c7-08dd7e193678
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 01:34:51.2389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ5mlliiP9YzvqQfAbf4eUIusQI5T3BTEUzwnvKiAylzDhMWoz0ttIDgrfQdhhvA69mcEscDOlfXYHF3U7nk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9559
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

Hi Mathieu,

On Thu, Apr 10, 2025 at 11:00:19AM +0200, Mathieu Othacehe wrote:
>Hello,
>
>Back in 2019, the init_stream sequence was disabled with db52e19ced because:
>
>  This is not required. The MMC core sends CMD0 right after the
>  initialization and it serves the same purpose.
>
>That is wrong. It does not serve the same purpose at all. The init_stream
>function role is to keep the CMD line high for 74 clock cycles which is
>required by the SD specification[1]:
>
>  A device shall be ready to accept the first command within 1ms from detecting VDD min.
>  Device may use up to 74 clocks for preparation before receiving the first command.
>
>It turns out that one of the devices I am speaking to is requiring those 74
>clocks sequence before the send of the CMD0 as described in the specification.
>
>It was then broken since 2019.
>
>I guess that most of the other devices out there are able to cope with those
>74 clocks sequence missing and can respond directly to CMD0, which is why that
>went unnoticed with the omap_hsmmc driver users.

This patchset looks good to me.

Reviewd-by: Peng Fan <peng.fan@nxp.com>

But before apply the patchset. I would like see whether Jean has any
comments.

Thanks,
Peng

>
>I am proposing to restore that sequence, which is also used on the Linux side.
>
>Thanks,
>
>Mathieu
>
>[1]: https://academy.cba.mit.edu/classes/networking_communications/SD/SD.pdf
>
>Jean-Jacques Hiblot (1):
>  mmc: Add a new callback function to perform the 74 clocks cycle
>    sequence
>
>Mathieu Othacehe (1):
>  mmc: omap_hsmmc: implement send_init_stream callback
>
> drivers/mmc/mmc-uclass.c | 13 +++++++++++++
> drivers/mmc/mmc.c        |  6 ++++++
> drivers/mmc/omap_hsmmc.c | 13 +++++++++++--
> include/mmc.h            |  9 +++++++++
> 4 files changed, 39 insertions(+), 2 deletions(-)
>
>-- 
>2.47.1
>
