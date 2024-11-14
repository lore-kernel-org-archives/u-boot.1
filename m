Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0886D637DF
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 03:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC24895B5;
	Thu, 14 Nov 2024 04:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="G3B3rcKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AB7895BB; Thu, 14 Nov 2024 04:36:57 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD2189583
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 04:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mM2a9IjgMswWsbICofWe2qD/e9bvm2jCm3HrJyPbn/BPFmIE5CQOYcW09eiVqDYsBRFjMbOhWuPnWkvnsBAYTjSCCSpjsH7i3pYcIMjPNdn/MRBahI4sMKDNmrTWenpU7J4pMtE4AHjMYeVPJwwHJJTtdO3E4w8dykRPYs29wNTQgdL53cR6g/uETWNB+WWTdxRKgXFhuHSikrVbqRO9PvdpMC9P+TduU9uwj6hws3dumbojV/bD3fT2cla4t3mMB2TvijQPMpjgWnxc9AEkOzRpRP3dkh5wKn5pS3UWDVGBBHLSSZZ7T3nsfg42D5xM+EQ9CGPJBf8ZT8kZJ2i7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXGxm9Cmq+Vw38EvfvbXOWMPrHk9Hsb2yNjWA9g3NyE=;
 b=SKEa7k7a66pJxrtPj5mcE11i26OLeFSiPV3Zl8JC7Gu6W40+7D/qzYc54e884WxbkdBazici8dDnriSpzBcFgSkKujExsSu+X6IcuJNE/DiC3qANEJXuKuaKSgHNzpZa3qdJk4Z8Tg4uqoItnmQ79jrV3RZUlcaGBXv+R25s+QU3S5fvYrkBz4Ui9wV801bC0CABjT5v8LH9m+eKVxmTXTlMMwq3/rNEZbS/+DnDIqKdiyiQU4ZV51UdwktXbtU/6XExykMCYXSUavP4cB91UzC8OOsoHu0LxkoWAh2EFivth/vSqX4hm6pDp7Pe2vSMSIkYK73A2oAgDHu64a7tyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXGxm9Cmq+Vw38EvfvbXOWMPrHk9Hsb2yNjWA9g3NyE=;
 b=G3B3rcKjLM+mZMx8Z0qUaZF7jTF1jdV88kZb8dbmviou1qhl3tGIA36yS+fp5p9mQtb7TyEDD/6w0oaIhK4uZcsGsmKvbspz6czXbePI0H2UqWW+2GB2bIONu7TyNYtkik/Tcnzmi7W6vFQVOXBQxmTePbnQJbVbdxA+XFeO4Ql5RVRoZmekvsKYC6L3nuUUBnIcvIKIDcz62c35UcXZ9FNX/NbeGtD1zlxSgLnYBYPYb/KXTg0Ve+y0d188FMm+YO/qvzSTYqw4lqGCYwbYKfrEuRaLNgeB3Fj+LgqXKVgYYhdtkm2bGhftzvM3avbXQW62vzXlBY91oZiD0Oql3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB10338.eurprd08.prod.outlook.com (2603:10a6:102:30d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 03:36:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 03:36:51 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v13 00/10] net: tcp: improve tcp support in legacy stack
Date: Thu, 14 Nov 2024 06:36:33 +0300
Message-ID: <20241114033643.623355-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB10338:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c56731-9905-4276-078f-08dd045d93b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?plWH3hfPbvZvo1eot9IWt6VZ7Cf/xEN660iHrQfxRkeY7owiKnQA2UX32zs+?=
 =?us-ascii?Q?eY+yBYqyrx4TjE4myVQpe3Tq3bo83cu4cjVlDIsLUgMLKDoZm7tF83iQh3Zo?=
 =?us-ascii?Q?Mzt4w4Os13NCXG0vGkfdJEBUyNaeE/Ck2mRwAf5PGjALMCkjZDdmL4xTbidV?=
 =?us-ascii?Q?KSDVai5Ql6piLP4NECyu43SaZy1m4sBLvt8AOqzJ/ckz5YCgGWXQIYvy3WLb?=
 =?us-ascii?Q?bg+mWa7vNRglhsRSga1ErAHxiidpDRfDlUlezw/PpikaGFheRwxpZi6y0DSD?=
 =?us-ascii?Q?+ylj2yXqMtiasskjSARprOr4Wt/a/YAN6yDBVDjQPBZhVGOsW+dKscMpe1dx?=
 =?us-ascii?Q?UQLKxqwBh5JVrWqKpjquRJ6f9VLhO5mBchdxhUcgtk1+fM1O+NaBpnnHuNVt?=
 =?us-ascii?Q?uDW+2koeGJ+HmDEhnkA/1N8116b4VPp2sL0rJEjQDvOzHcolnhnRwQKoL2BH?=
 =?us-ascii?Q?xSkd7IlXLARiqeCU9gyi3LI5lu7GkKL++WebVtTPjZdbSsch7fBlYdloHaV1?=
 =?us-ascii?Q?XG9/DSL/SKxKeKKAR2E4xE070UEdVBAdenzVuC1yY/hvz7YmxUUm6dFqh0fL?=
 =?us-ascii?Q?QsYoDF2Z4f+zBVRi2iqFgEGVmi3gQTtT4F4D10u9l97HgPPWHkmNe39Lp4NW?=
 =?us-ascii?Q?k6DlvWrqvBqa/s1PbBog0qLFDAu9VIRV56EUmzFetjGQcBH63NIyrWLIR8w7?=
 =?us-ascii?Q?JhKvUWpzs/bBbpnc6flZOZ7EYcTATFlDmXetLxjWDa+vK8K3m8vTaADPXUjq?=
 =?us-ascii?Q?2WhxArlrmWE0cl5DLN2vBDkzvNOe6wgH0d3cjOUe1Vom9vLeE8KrUeLRNPFM?=
 =?us-ascii?Q?e7JefX8zVUYHFXVMMh/rwGewh9bVRXzhZzvoqCBenscqn4NEOChUXPzAcmdu?=
 =?us-ascii?Q?q9vfkfbFULca+2dXv4j0J7diLPcef0bo/4w7ip2Hn4wYRa91DtDrxckFEgYH?=
 =?us-ascii?Q?PVXHHHd42+ihfWmeYfjxN0QIXVx7gawDlE64ZyLl8NjDKsLEncYY2bFX7j6C?=
 =?us-ascii?Q?xphbGNZytkiFbM/mVFje66kcO0ICSeVusagpggWdODgv8MyRscHI5N75DKAT?=
 =?us-ascii?Q?O8iTj36Y8KS91KZ15RvoHCZC3qDAiJ41v6uDfMqGa+rJC2+YYnVkNK/NJ1zh?=
 =?us-ascii?Q?AAnVeRlLMGGDsfTVWu31meYBUeRfSQ/7gRtadqX3A/kPft/7ow4IvsoWLhfA?=
 =?us-ascii?Q?HShLcbWZPS9+k6ojapfI92qogt1RUQDHNWqouYqnWyFbO7UdxLYUXEh9wnXR?=
 =?us-ascii?Q?lAtTm+vJZaAnWlGVeaGMpIi9fN2Ve26lXbJIOQ+KHjZcIm98E+PQGiUUd5mj?=
 =?us-ascii?Q?JDr3zORI38I4l0R8zJ0ByxPZ+RDTBeUBV08LLYj+kbKgaqCYz0cYZAwI1snQ?=
 =?us-ascii?Q?7/UKQiVmAc3JqNDqQcWXEF0YOOVX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ofSPZExXeGnoP3NgiPyLqLtMT7FmsP655+6eRROHTvd9lH9TmHtrpBtYS9xy?=
 =?us-ascii?Q?u/vzqip8+dEGzki3UcePDLFxcNO+Lu5eM0Y5hB6xu2+Uv51VuTgKLJu14aWL?=
 =?us-ascii?Q?tykZNEHpgTD723eT7Iikiji3tCd1xxhSxoEhd3P1LtHcXldpYD51cAzqfb4g?=
 =?us-ascii?Q?0mBo15vFhjyqsXxwzpFcMZUGMXoUL1DDaK/O5tJcCDL1XCaaJ/EV5FHs8N8K?=
 =?us-ascii?Q?bi0E8EojQLSgu/3mwKHW1UvVgJwNWwl1Y/dxE5ZEzkv+vVXRv/YX/fKVpOOV?=
 =?us-ascii?Q?esBGGw8946zgeGfEYKGorM1rOdFDY0PJqtrvd0PsCQJRFr3M0TwcK9bptGH2?=
 =?us-ascii?Q?5/QGUvpfFwoFYFr3+yKDRVw8ICvfXR8JYx7YuIyrVaPJbkyy2aFJQGis6OkX?=
 =?us-ascii?Q?3QyEf/6TuYjRoNWJH+wYv3FlfVFbnhT963Q9bZu2ZzErv3typyFa/dc733l4?=
 =?us-ascii?Q?RDJqf1JHAoGAr52jDNINKXjYtfqH1ROU9VloSDb6ON9U509/IOOdS13NQw7B?=
 =?us-ascii?Q?uhjsOVOA0xdITBWMUdmL5bRqIBAQIBkLDDnbYsTCKQ6TBYSEPWON6TK/07Gv?=
 =?us-ascii?Q?tc/yRwuGu4jL7O8GZQnOhgTDW23r0d8CpqfwZRxLNeC1mYjeD73+iaD6HzUP?=
 =?us-ascii?Q?gIEmHwUIBRWADQO3RKwk6trQGdJcIfBRcW+DbGWtTdFIFtTOg+VsjZPQN+BC?=
 =?us-ascii?Q?XJxsIppAvw8WHy0+nDBM6a94v5ksUJVz5ylpiMFZGicYO53cGxkhkxfTSW1n?=
 =?us-ascii?Q?HiB8YPo2skkrFVc8DrmVzd4vBcNh+I5mLW4sYqXcfaNNJ1VBriH0Tx3Ycunc?=
 =?us-ascii?Q?7Yj5MRhS8na+N5H27CYyZGYPgo+xcT+Dvj/6DQC0Vhw3MmFiG6Q4fCBQJeRc?=
 =?us-ascii?Q?5I/Af5iOXC75syHcGFqejTcdmyokV5vLrZY4I7VgMu8xTNF9h2jItm5AFLsE?=
 =?us-ascii?Q?tX7GluoiNaYzIV79yNCqzOtcOBTZY5/uf3uk2BtAg9aQlffEYT9S7cvOq75M?=
 =?us-ascii?Q?xb34Gy7hnIZK1+QAxn/WECdJsKpaf/vfIMQxOoGlPRAI37oeB2uSllsPyO6a?=
 =?us-ascii?Q?zMQwVNjtuG7iVQqf7G6RdkJBgZ5siq/UXvU+TKuvZpm7kM32V5a4OVRtjPAJ?=
 =?us-ascii?Q?zQacnKrfE1hUTSwEBWxezxPq92oGi/oWjXJxV/YYbMBLK0XpceWeoC+szyd7?=
 =?us-ascii?Q?Wa9/gkt0SAsKLXogLJLWXD9cVbviv7fBYtLj0EvpcHePq/dDk/wJ+yl29fkG?=
 =?us-ascii?Q?++vAzeeNrj6SeD9uxVm1CAW8fQ/VysAJQgUkwEnuIRSbwfdlfatyc9twPZes?=
 =?us-ascii?Q?PONpVLFXHNLI9dfeno3CBoOG1eL07EBFRBd+YJeQIOcCCGNd5DP+768Acghr?=
 =?us-ascii?Q?m1j01DtuUznb3T2h/AymecTgplQIKTX2VOmT6HhIV2gaM4LJz5PbQG91HQNY?=
 =?us-ascii?Q?f2y1MUOHOQKWXAaq0TRLn7nb3XorVzAQpEw5iwi7tKkCxtUZqVlHKlkw54bc?=
 =?us-ascii?Q?XEHxXjxmBhbW+jT0tbyskdRcFqTwh1TTQFJE3z9x7haPh6uIGMNUJVCIxpk3?=
 =?us-ascii?Q?T79PAwJMVdUBENDvyoXF4z/0OEKbKChd2+0rTl9LA6HDOjwd1ZH3FkSt3+aZ?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c56731-9905-4276-078f-08dd045d93b0
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 03:36:51.4974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+GL5+7EH2u/ff2BYHjX0sc/U6BNwhgns6Get5vLQ6JLhFjIZl0LL7xjNoxapvK8FAD/MTjOj4lXWSfcJXKfDSZ5fktQrtb+uwOnqPH5fxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB10338
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

Legacy TCP stack is bad. Here are some of the known issues:
 * tcp packet from other connection can break a current one
 * tcp send sequence always starts from zero
 * bad tcp options processing
 * strange assumptions on packet size for selective acknowledge
 * tcp interface assumes one of the two scenarios:
     - data downloading from remote host to a board
     - request-response exchange with a small packets
   so it's not possible to upload large amount of data from the
   board to remote host.
 * wget test generate bad tcp stream, test should fail but it passes instead

This series of patches fixes all of the above issues.

The benefits:
 * A lot of bug was fixed
 * Better and more reliable TCP state machine
 * Tcp clients becomes smaller/simpler
 * Data uploading was fixed (now it's possible to transmit a huge amount of
   data from the board to remote host)

Modification was verified with
 * firmware downloading via u-boot wget command
 * fastboot over tcp
 * netcat linux client
 * Firefox/Chrome/Edge using example web-server implementation

Changes v2:
 * cover letter was added
 * some patches were removed

Changes v3:
 * better cover letter

Changes v4:
 * fix bug in debug output
 * add more comments
 * code style fixes

Changes v5:
 * old patches were occasionally sent with v4
 * add back web-server patches
 * fix bug in debug output
 * add more comments
 * code style fixes

Changes v6:
 * fix the wget test
 * improve description of "simplify tcp header filling code" patch

Changes v7:
 * fix include ordering
 * improve option descriptions
 * fix a lot of extra brackets and comparisons against NULL / 0
 * add empty lines before final returns
 * fixed a bug with zero size httpd uploads

Changes v8:
 * [tcp] add function to restart rx inactivity timeout. This may help
        in the cases where remote peer waits for u-boot data, but u-boot
        is busy with long executing action
 * [httpd] add function returning underlying tcp stream from request id.
        This (with the above change) allows avoid connection break
        for the long processing post requests.

Changes v9:
 * rebase all changes on top of origin/next
 * update test/cmd/wget patch description (bad tcp ack/seq issue was already
   fixed in origin/next)
 * tcp: add rx/tx packet counters to a tcp_stream structure
 * wget: use tcp rx packet counter instead of own one
 * netcat: use tcp rx/tx packet counters instead of own one

Changes v10:
 * netcat: fix bug appeared after rx/tx packet counter addition
 * rebased on top of v2024.10

Changes v11:
 * fix spelling in cover letter

Changes v12:
 * rebase on top of master branch (3df6145db0e)
 * slightly change tcp->rx() & tcp->tx() callback declarations, this
   allow us to terminate a connection if something goes wrong in rx/tx paths.
 * set net_boot_file_size variable in httpd_upload
 * set filesize env variable to a proper value netcat and httpd_upload

Changes v13:
 * rebase on top of master branch (8573ea41058)
 * remove netcat support
 * remove example httpd server implementation

Mikhail Kshevetskiy (10):
  net/tcp: fix TCP options processing
  net/tcp: fix selective acknowledge
  net/tcp: put connection specific data into a tcp_stream structure
  net/tcp: add connection info to tcp_stream structure
  net/tcp: rename ack_edge and seq_init to more common rcv_nxt and irs
  net/tcp: improve tcp framework, use better state machine
  test/cmd/wget: fix the test
  net/tcp: simplify tcp header filling code
  net/tcp: define a fallback value for rcv_wnd size
  net/net: fix include ordering

 arch/sandbox/include/asm/eth.h |    4 +
 include/net-legacy.h           |    5 +-
 include/net/tcp.h              |  258 ++++++-
 include/net/wget.h             |    8 -
 net/fastboot_tcp.c             |  193 ++---
 net/net.c                      |   45 +-
 net/tcp.c                      | 1297 ++++++++++++++++++++++----------
 net/wget.c                     |  465 ++++--------
 test/cmd/wget.c                |   58 +-
 9 files changed, 1444 insertions(+), 889 deletions(-)

-- 
2.45.2

