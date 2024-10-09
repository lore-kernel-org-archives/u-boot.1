Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116ECCF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFFE891B9;
	Wed,  9 Oct 2024 12:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="baO7JcF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2808891AB; Wed,  9 Oct 2024 12:51:09 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84D768902A
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=da2mCgR+P5k0hH9uDM5BXwZ2Xea+2wRr6T/onJkmqc51JvseY9wIfQzXdYsbMxIF7f+OgG++UPqmNsAYbEDYVKOQE5lY7uQtJcG73ulczEm/3OzLr9OKxZeR2vhRroi6vEintDR1W5wP3HlpBlpIdbisECHXjWY/o/keuCJ4t960brYdtw0Wh9Cz6NuDR3o8CNP1KyAazP2EU3Pd1fEOCEANznytvumO+yPIYo736iYgPdo96aYNitZ5TI+WlVrvDUt7BCWOFu5usCUJlS5G7+Tauf9HpqKj/ehyMaQXSGPGuXgVvaJaEa8ZXXL5jQFvnnXv87GmIzAekVFv9H+ZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U0CyWUC1CEUnyBO34NV6EHK0UXlmTXIDUY1rozJxFRk=;
 b=bqwzcq5YDHlQHKVYRWeP4LcSLxsPNdLWzlr4kzJAcfrbxURgpmIYRdryJSpEthGmQ8k9KiL/xP73hCdk6VqGQL4nU9ASypPpNPUK49cspAelbULO/UvAWSdw46h/QIOopdxaI3jVTJhaY0w0ESeWlQaXDNnc+pl9AURBBDwOb5leFVhhTF84ESi2UfN1tDCPpP2rXh2m6tazX7bkWOd0JmgAyuWKyDHBGGIigQHlPuCze0F2pNTWhOvTsjwvQIoye9agBDPXWqBgttQC+S2FpRP3eRxIzJ/MdRReq54BvA9Bu1DYaUb3S8WJ3UNT69EVaCYGcfG9MOZb5mdLSqNSjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0CyWUC1CEUnyBO34NV6EHK0UXlmTXIDUY1rozJxFRk=;
 b=baO7JcF7gWtjv7TLhfOQFfrizoExUn/QtIakcV+BejIzynVHwpJ6ciyqygrRe8vqUCdPri4uwEO+CHBdtjXZ5ipBa+QVmCbwb7WWH7XIu6nB+czUhklWDYaS1ZiM6brncSxz3i4Vt4YF3q+Q7OHigaQJy03SJ1VPHTFaG5iCJbOMoLUiLfon5AKuVZ//SeJvGJa/4yzRRfMTpG1c24kmb0GtU4uYQgOFE2/Z6SGo8aiMOWZDfP5DWNerFS1cHr6ReYTCw8HgEPSzy6NKOzQDyNA95n7eOx7k3hiWEUrwHv6H/Q1U5VnT6jP4RWbO3uEhjEGERYJVCC4O/fAc3Z4OmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10026.eurprd08.prod.outlook.com (2603:10a6:20b:632::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 10:51:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:02 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 00/13] net: tcp: improve tcp support
Date: Wed,  9 Oct 2024 13:50:41 +0300
Message-ID: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10026:EE_
X-MS-Office365-Filtering-Correlation-Id: c7570f3f-bf3d-4013-a50c-08dce8504496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?weqxKO1kHxg8jDaGidJtWQbU7NtMvWlQP4wlCDxxdmnxDdrIgP5NHm0HhKoO?=
 =?us-ascii?Q?c3pE7JODIgbGc4Iv0luh0dhkqk6oMW4McAabKwnV1COi/9ds+K6cR44xkf5Y?=
 =?us-ascii?Q?pY74Wnie/O2eq++DdY/DgRqak+wY946GEkhdz3DNawCujxGq3odv9pFBhW6c?=
 =?us-ascii?Q?RFrKKpV/5tgbdear2gAD1XjdmzT8tnSVJKudnBgROudrDhy9ulMUdEHDzJWA?=
 =?us-ascii?Q?qLEBvhoVPq9T+IF00Rcaskds53ygPg3KFF5Db6zm4nUQqQFBM2zCwsmvvARc?=
 =?us-ascii?Q?OOeLybYDdk7J8agpQBCadqZM6/FxCENBeHrgiY8CVWlDdp2Cm1rUEjqwWol1?=
 =?us-ascii?Q?HhP/JWTQqjNk5d2cSItJ7/oFefQFlxOBDrolfiD99mvvPTI4/jnNxnOO2HTo?=
 =?us-ascii?Q?0d9wrSfAnHQmAYsFvtRnOMPG6X8kNrOuZ9TCP3tFdwSI1gJiRUu34gWoK3Q+?=
 =?us-ascii?Q?2Z7X/SIh5WKPoUAyQOIxgxD84dZkknTrc/DXBBJmh9xM1hTLo4PPv5sdPWrT?=
 =?us-ascii?Q?H9/W6cX5GpEQQlTUFM9snqJ+u4TTs879RSUiUtKfHdmPFn/3dkaynI/lmZAu?=
 =?us-ascii?Q?Wn/MMGyEyxYHKdLNdYdpIaePjSWX6n+a7fbJNsUtW1xqmateqBltzmf0LQ7u?=
 =?us-ascii?Q?PCRcNG+NOBKnW6VIqr8OIcJvh8KAgubygs7c4pM3POEe/8W4EztND7A/H13t?=
 =?us-ascii?Q?b+/4H7lGLfZ4fwI4hmTuXbZr8lFnoFr1Sf9IZZ4tAhtCYHANqRs//5p+V59l?=
 =?us-ascii?Q?0lv56pqXcmnLzzGYNgViFdUPCnThiGL7shpscc3E16iw0TkcY6Lg7u8B5zjY?=
 =?us-ascii?Q?EerYr+CcoJ3oQDxwOIDtw1IdUSx0VNKeO/uEOCPEcEll/B2BknDHz4h4bt00?=
 =?us-ascii?Q?PV+ZzN6y7UCm0Q1oOZEppQrES+OcnOB1ZELlHGtLbMw2Tf205OIllchWWp61?=
 =?us-ascii?Q?XZoS/SU15b8xuv2Ofepu7YD69OlIr4FkihUkEHPvggFLY1PuTwVc1QYaguXv?=
 =?us-ascii?Q?HAfgb9sjHW6kckJDlJvOeyVznjPVD0rNaAeZe90FjknQHNrFAHrFdrPd39/r?=
 =?us-ascii?Q?5/ZwTgFfKFb8ApdSYo/z9vwIDwxjk//1fDaPKKFdovzAJUf08/wQg3UXTy+I?=
 =?us-ascii?Q?hMHWnwdKSDVhIPxHVfGK6Ec0WsIvX3ukOwk10hC8Van+pv4E+jushQfvFlGF?=
 =?us-ascii?Q?l4rbMz+3Yhg54+Jjktdbujc30D03w+lYFe7RszJRPxqbY43x7Tc/SEgLoRQn?=
 =?us-ascii?Q?p2avbgukKEtoHXXnfagvyn66MsXpadLMczMy16gYzxEu6RQKQdKg5oSJnvwe?=
 =?us-ascii?Q?b9iYO1zTrk0/7y7A/PwjqJUjoLhzasFsoYQCtpJamuSEtOQdQLlri0nr+NUs?=
 =?us-ascii?Q?aQycMyo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QmW3KDXmp79PzPvv9OexLwZRn2ZXrLA736IRbjdpXACWZRLfwbDh/+zOIGit?=
 =?us-ascii?Q?kEsPWnNPfmjuA6RdErYwQm5ajBZCOl0IjtKSc1klu2A+Lj7d/qK5w8HlGYYa?=
 =?us-ascii?Q?LIe5UEgAqg/p/B60wwlOS+YoNGkdaQl1joDIPmrve8sNZR5E1BuOEWoJlEbu?=
 =?us-ascii?Q?GK39Thb69Gwq87NRPaX4XuSct0I91TuSDOw6PAu1rKAu7wRGhlLvjtq5H7b0?=
 =?us-ascii?Q?7b9uSx+JbL9g9kg0x69Ufpr4LU4GoM0eys0+o5BFArGg6b1vAnL8NQ9LbOWz?=
 =?us-ascii?Q?uu/CbgPMInVJJc9aFRW/H/HkxMpxIijuqlcy5YMe2rvPdEAKza3Amy4jvgq/?=
 =?us-ascii?Q?GFngH/2tO9x8vLIH6rXNgFCH5YGEQeO94DjwPm3KtGxkh3xG1OcXUQf9K9Rl?=
 =?us-ascii?Q?ZMdmQ/OBK3C7/3eRzGrTayL3dg1/GDB9o4oCJx6w3XoK4RC3S0pQ7oQnnjOv?=
 =?us-ascii?Q?UKnCJPYdqgoU0EOiolgnaZc/kC3xTsKmX06kqVbeehES8AG67GQiHT6hkq0A?=
 =?us-ascii?Q?O8PxwgW5lstgZIa/qlZaYJPJrUH9w0wU1rGaYGWUsX0MEXEtpiAYeWN1NTXV?=
 =?us-ascii?Q?+CWlZn4Q2nZjJnR4pxRX96I5eQJSmK1sD5vQvC2oL9B9jqJ+ZehQpvYD1x3R?=
 =?us-ascii?Q?ay41GGq6sPUwTgrisDdWa/QvvCmENcvvRTTW5fIB6A87VXLyNiUPsRN/MhDL?=
 =?us-ascii?Q?ejWF+u2JfseAyJhi2XErzhm+WpgNCCdtwbzkKF2BFqHWzL2mtuITUUGW9/zb?=
 =?us-ascii?Q?Ua+/tIglVqWavOYZn2C2arbqe7ctMFu7O/u0wW6ndocWiZw7pyKdfVlmDnBs?=
 =?us-ascii?Q?SuffPN1J+pLmTW0AT4cveKRr8rVI9PrIel7p1EsazGaSG4gEXiWpwRn7SfaC?=
 =?us-ascii?Q?HD5KHxNpTgbY45/VmKe9ZjSOfZlmbD0LhghaTs0pzkySgNz+3Loj+vw6l3eS?=
 =?us-ascii?Q?5uq4MyCLBsGNjQflHdnD+JtbWE3Ezot4ZapIbH4uBZ+KEwwbWqgkvzjuhfTa?=
 =?us-ascii?Q?HPL9e9Bv4fllnzQlM5RqWkzKcqSg6/PvIK8uUNSYA9Tzjk/Hc7HwEcrm+tQ4?=
 =?us-ascii?Q?Sq7fzNkO6XWKNmd8HYVZXvQfrpDVPum/LYUOiIyHXJ5ajQQfQWuyhDi27HDe?=
 =?us-ascii?Q?C/ScnhZ8eyNFyd17ZhizvuOfLkrOakDYD59kL0/0AdwqQZai2oM6wFqHbACY?=
 =?us-ascii?Q?vDL8ekNCPKxgKPTzu3SRVWAIA+Cf5pz11C7Vxy79qSFKOvWP8IUDBVWH7FXx?=
 =?us-ascii?Q?6xcjR3iMmLnxElSD0GHqV2cUEGhp65PzFBqEfe1K13Rl8ZZL6dE40IFS6DiG?=
 =?us-ascii?Q?7mb6Nygyl6x8KvEE+jQWzkdAR8nysuE3cs1JbIu13BEV/LQi7bykJdgxaB3w?=
 =?us-ascii?Q?RvpH1KzUx3sRydw2VYuiruubfRJSEdz6ym+Jr/x92z8dobITUoc7aG17UrXx?=
 =?us-ascii?Q?+EBdAH0bav1f1Y4pLgoEfwvKWJvu6OTfXJRDaoUlbxOXlDtpbvShFMpjA4aR?=
 =?us-ascii?Q?EmqcW3VOrgwd0KpzlU4R5q9VEQoN12HJG6Exuo2SzObp1JgiujHQVn61GK1J?=
 =?us-ascii?Q?yMl0zxJhpd4mf9hHbak5VuDziQNzhNloipPHOvyf+8OTfP+jXzFele4AhAr/?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c7570f3f-bf3d-4013-a50c-08dce8504496
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:02.7943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtBPOs5Bg5ZerX7HO5vikqw5TRemguq3TSicjN5Ocgy6A8GUPwWRc0IL+tl9RZc+9CMY3baxsqtohnAtCx0ShRtwEo8Qf5GCcj6K+HT8kpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10026
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

U-Boot support of LWIP is not ready for a moment, but we already have
some kind of tcp support. Unfortunately this support is really bad.

Some of the known issues:
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
 * Netcat over tcp was implemented. Netcat supports data downloading/uploading
   from/to remote host in client/server mode.
 * An example web-server implementation. This code can be used as a base
   for web-based firmware uploading used by some vendors.

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

Mikhail Kshevetskiy (13):
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
  net/netcat: add netcat over tcp support
  net/httpd: add httpd common code
  net/httpd-upload: an example web-server implementation for file
    uploading

 arch/sandbox/include/asm/eth.h |    4 +
 cmd/Kconfig                    |   35 +
 cmd/net.c                      |   55 +-
 include/net.h                  |    7 +-
 include/net/httpd-upload.h     |   12 +
 include/net/httpd.h            |   71 ++
 include/net/netcat.h           |   20 +
 include/net/tcp.h              |  254 ++++++-
 include/net/wget.h             |    8 -
 net/Kconfig                    |   14 +
 net/Makefile                   |    3 +
 net/fastboot_tcp.c             |  193 +++--
 net/httpd-upload.c             |  170 +++++
 net/httpd.c                    |  735 ++++++++++++++++++
 net/net.c                      |   60 +-
 net/netcat.c                   |  191 +++++
 net/tcp.c                      | 1266 ++++++++++++++++++++++----------
 net/wget.c                     |  476 ++++--------
 test/cmd/wget.c                |   58 +-
 19 files changed, 2723 insertions(+), 909 deletions(-)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 include/net/httpd.h
 create mode 100644 include/net/netcat.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd.c
 create mode 100644 net/netcat.c

-- 
2.45.2

