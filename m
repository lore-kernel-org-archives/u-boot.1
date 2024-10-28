Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E285AD3398C
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 14:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C55689096;
	Mon, 28 Oct 2024 15:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="TmZ4VSa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCC4890CA; Mon, 28 Oct 2024 15:31:57 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20715.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::715])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BF748907E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 15:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWU5fLj8n+jsccXfeTRL9jkHksi5Xc7FaRnhh7Qg6G9dsVLaz5VznxSSyxmr4EN0kA4WY58Y/tIBz3Q5gJaJ2AyY4WkuqJjv9N/QllPpD7EQfkT0H0Ey1ENiGkFWmV28NQMkCw6PAAUUtGbviozRwXQtZOcPfQ+PhknlbSoDiGTPXmL8G04D6E/hqWHVGehhkCExjROHxL0Qwh7CQSL200FmmFQGpelSBzJJEAI/05JgEWi/rO39/2el/5ypZS0OszpGXEtEPjZoFuWmUBlwu+yBuXpmcMT/9rcFyym09b19qW5zAClGpRF1TWXOVeK1ur3Fwsz1pF5u43lp/X9H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux4DzOHjFXALTRgntL/CgA/2pBors8TMXAauWl+X/3U=;
 b=wk9TcJjtHLOG7HhsM/v+wYNvSLPssoeezIXrPXowyB4gxkUsz7bm3RPPv5lZLkRii7yCx7Jv85Mca1hhz8jegSOfQIcL4vSdSd4KSf2GY0ApDM09Zhcj07nmywESLAD+5orackODAnr4wp3wOUFJaCaAhxgsNOPIpf7d346A+LxJVKxUGcNQjNFxkrYMMPZmGjSJI26DdjY5YjV8RvusbPjD6QCvtciVoiHxARSte1rR5OanbvjHgPpkHxh5J0zpIjbQ/T+48eO9UmhLLrh/2Ii50MgCKb/hLLnkQXhzPvT5ik8C96Kt0RImOtiwhgvvisyikiEjcUIehIze5CoxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux4DzOHjFXALTRgntL/CgA/2pBors8TMXAauWl+X/3U=;
 b=TmZ4VSa84Pbl6zCVvGBDQ81apQDVvh1aqr2nvlikQyj2b2SVHvriXSA1OyWCDVarFAm9m0UqWx12YVWnlkf/ANfw1A7SFC9o27ZnMqaaGlPKuqz10YJ+L6FkFebrWNX7j9JrAImrZJhP8+70411ddtKr/CoKFAFw9xEYaMS3wmlOHwnQek4+xrPgHjaLqoXkhM4Vn6Ri64l4XgwR68BI+qlj2MIj3DBc5hF6gjTfAHVTp8QrbTpPITJLk7sL5panv4zug6GT6+V3UueGOBNiNZtsgMsRcxJqnDDw0w9ELPwsepLy/SsmhYErmy2/WZW2evGxYGlAXuxgJXsEeEvThA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7714.eurprd08.prod.outlook.com (2603:10a6:10:3be::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:31:52 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 14:31:52 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v12 00/13]  net: tcp: improve tcp support in legacy stack
Date: Mon, 28 Oct 2024 17:31:30 +0300
Message-ID: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 256e5c78-4174-4aa0-0233-08dcf75d437e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nSTYzo7WE5TgfpLljNCHVP1OSECYtb7TTL4U/b3jUIxWksGybQlyTFr1kPpT?=
 =?us-ascii?Q?9tQDRMo/q9EHO3WRrcxWz8H0x6hODVWairQuynVnp5TbSNlKbO5GiyrxVwRo?=
 =?us-ascii?Q?eKfRYGL5eYeK8oXhGp9uRsT6i4JCEfb6vR9uBouvCohpAlqeagKlEWcrEjU9?=
 =?us-ascii?Q?fLpOjeV+1ZXHaYq2kVNubLaIgK6vG3cYlqFc3qJsSq+ncEnbZvZtbQGrtogp?=
 =?us-ascii?Q?jLAdX1wRvs6xcL/de5fKRJg0h1Xqw/7bJJ3XsLOoQSn1iWQpiif3wO1Wuf7k?=
 =?us-ascii?Q?NUdlTEMPvTxVNqED6SpTkACA6B7/Wf1PWN58EEFMETRmo39Jt83+U1vkCjTw?=
 =?us-ascii?Q?X8KTeCAQQ0m0PuM7Hc/stc9fbPVzSoKfzfQqnjndj5X8445COoG4v2wmzAwC?=
 =?us-ascii?Q?hbQdefJt9fquND8H+gq7w6NxMq7AEqHGSqQGQmHxMBsVn6IA45TcxUXLkD/y?=
 =?us-ascii?Q?eThGPQDciN3/SGGpwhiIEqJ6ov8lSe5tSgLwb1St4/rB+KBD9ArJp9chc2bT?=
 =?us-ascii?Q?Ohq9Nq7yfpZnytVzrVUs1qOj+cHiNMiKsNwTPXaD5Y23c/GDU7rHcp96bbMn?=
 =?us-ascii?Q?JOfUUqI1JjCKg0duSNlsVsAkChC1tzImc/zHIOn5Ibe9jSCM/L0BywS5HDMA?=
 =?us-ascii?Q?YQbBlh6kymOD1I4vwx52IEhUjc5eFGm8U+qTY8ana8bysJoP25/qd3g5QUIM?=
 =?us-ascii?Q?v/6rEKLnRRqlaGdW6P6W9JOEHyzUy0ecj7thN07nbOKN+OV2f+GSN+CzKeUs?=
 =?us-ascii?Q?WwopqhxW3IRkGF/xPNeXW6K6HmM45fhDr4ZwdpyMM68FT2Avcr9L0kzTmhH1?=
 =?us-ascii?Q?jopZr0BCrW5YbHM81OVshDTZLGjYXgm1Rqb/mq1PLinj7gg4ZCaECrM2jBiQ?=
 =?us-ascii?Q?ffoDMUChwP17lBy2GHZ+E2k9Lpd4X8W5gErfPA1tViUa+v5yB1++CnVMvXAr?=
 =?us-ascii?Q?tei1MROryvKbwqQPp/FtEWIbBQNbcv20Dg5kpi9Romq+2imkw5dl2fePzMBG?=
 =?us-ascii?Q?Z++JlfoVsYrKx/hHWVnQ5y3t9r5IDnin9OuUNDiWVJJdTmqG7BXjV3lTjvUR?=
 =?us-ascii?Q?05RalDApa9jujRgCRVBWMS/a4cAm5QYolVBIjiF/5twkkv9Ws7PpMY835rAa?=
 =?us-ascii?Q?GGSUiOFJAT6aB643pHcYAjJxH+vCuKIruMmjkI+GEBmPsSNmCUbbRhMyAFSL?=
 =?us-ascii?Q?m1W/jXdu0/X0mF9gtcuvE+63TQKdp/EaQYM/2bNPQ65chmWVPL373sNvdy2E?=
 =?us-ascii?Q?BCtN9f9WMi8NJg/ueKpGfRlRg/e4b8kGKyR/UY6PgQ76VvqV+F1y+SQSy2xJ?=
 =?us-ascii?Q?dDbxMIuS9wBaEFJNhR2VN9+7tqFslDlVRPwP9C07rLh5pXFGbdHqXsZjyfXg?=
 =?us-ascii?Q?UXQcsRq0mltSkSV7HROu/ImPy/ph?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RkkLkLWOgdi2D18WpA1wiJbx9QybkZCHx1+gSFMBtishNFdSHEKLlN3QbdAk?=
 =?us-ascii?Q?u+ooh+U1cziiQwxZ6bMgJgApJyRDWKN3Iib3Nhih3wL6/270Rab4iu44aVcU?=
 =?us-ascii?Q?uKO0FlZcB2IX5syKW6bI7WKUf1tHodNOQqu8n/agiCN5kOXBqTMqud6H2cwF?=
 =?us-ascii?Q?emwjg3RTpaLJer/2+xa2OE3s/tXQcy8tCUXPRJNPNVZp20Ckl2vATpVuNE4P?=
 =?us-ascii?Q?EwEkMSjtACwC971h9+bIpkDyEfGtI5eRSxewn7JbjzNvLO6faWohvua7Nhb5?=
 =?us-ascii?Q?NakkA8qXtDiyB/MSgsxpNVMqL8mHBlBcxf9qHnQbhiDsjJfFbZr+6g/VqGka?=
 =?us-ascii?Q?oJTr4Hlm3MYJ7AXIDIGHMa/n7MqeHkTeagm+ZIEI11nC+8UEHqnB9FZGB+Dd?=
 =?us-ascii?Q?8UyPJZRaeFlDjik8mXQU4gXy2VRDT+T8v4xHzon0vDNQpILA9GMgYTqTaxlw?=
 =?us-ascii?Q?GjZvu3poeTLgvV2TdjYxkJK1v/gFWbOrjiZWZsDfzFd2lZ/dTQMyhocdbrQn?=
 =?us-ascii?Q?LpRLRJDk/4fiB3u9egNxMTtPbBtxC8JXp7fQxN3lJlc1cNJzE8XjRXCN0WHe?=
 =?us-ascii?Q?Zb4CnTm7+H0z2b9XbZal9+oxez22awrWjKdQVGC3aEdj32YijvhxiWWAq3ES?=
 =?us-ascii?Q?OLcwZ1mGmebx6gkAEZmRWfQNCxIPcNxJyYSRVBCI6qU3miMqAVMCOeyFvcfB?=
 =?us-ascii?Q?/aBe/X5FiMUt1oxWTu5lNcIQ9/06s6nSrNrpChWACrbSrYEDa4+AwBRdz7DB?=
 =?us-ascii?Q?2NYdXD4B+ivFd2UrmOGSOOg+hxw8cSE4m/3pJS8bL6PLZ9L5BiB6xGkJuvMC?=
 =?us-ascii?Q?9G9bZLgX7sMKusFV7fx6RN2sCs0cQ/1S/RE38Ov1WpVZEwkkLSyNuKU/o94y?=
 =?us-ascii?Q?5LgJMPryOXeNezcQbVrBoNTyxqEqWP8IdV8L3TUZs+VZlCp0HvJ9eOeCkFHs?=
 =?us-ascii?Q?kIsdnPzRYBsry2nlydlZCxhlKs1pIi9EQDcY9+Skp5I/bPOAwHe2Toi99Lpl?=
 =?us-ascii?Q?9ojgj/XGJBn2uh2JJc9WPUEdaP3IVoKreeTXcitfLE2crqQhL36jHqDs9mcX?=
 =?us-ascii?Q?HcdIwGERGs4/cPfgNckZ4cYM8/piTiSPt2XGzpeuMMKKl0topAYVFf/n+kRV?=
 =?us-ascii?Q?xDXGYYyEbaTU+ZArKI8DEYZbr9trwh5BtBSQSBCINmsVbE2vOjFdRBjI5zun?=
 =?us-ascii?Q?HmNZ2kXmhp4htYSNht63T7QfI4+QjizBtdGI20NmSyVw1F6HK+ZFfgC7C+7T?=
 =?us-ascii?Q?Ei6cHXbbCQP4Q2qMEGDPA8Ss/kaMBx5cQjhmhmtY6bNDqm27whCFTWEsDHyy?=
 =?us-ascii?Q?dgVMCtl42rAod6b9tpm+RQKQQ1bjNF/5ADPzz4TpQE1xatkheucR59Tj4xcM?=
 =?us-ascii?Q?z6KFNbQSTah8rPFK7O1hdPNpt/dh2M1U9M0+So06JslJLYxd5bOOfPQ7IsRl?=
 =?us-ascii?Q?kaaN3xOtM3b0+UQJvmgTFITyC+XXofMldzZ7A+OU62oUe5DtPkE76ZGh0TVk?=
 =?us-ascii?Q?L0dE4zVd1BlL4u7SA2D9daFpNGBYDRzsB+FE8jOGjCGIvYy/VH482RBhxVpo?=
 =?us-ascii?Q?PpkOXoWeuFYtplEHSt/iSvyYVMEJqaqdJLPublGPi3tEPepx3b5kpiil985w?=
 =?us-ascii?Q?9HTOZDS+YOYa40hX0xRv1w0=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 256e5c78-4174-4aa0-0233-08dcf75d437e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:31:51.9644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iQN2nM8SdbMx6apxfi69EC8a50ymQvvaHUjg55ABkzrR3x8R+uEnHk2oLTnYIlGCVgbehRXbUw6q13AFby2pZLk0iVsMOy4jKcTLEuTo8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7714
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

Changes v12:
 * rebase on top of master branch (3df6145db0e)
 * slightly change tcp->rx() & tcp->tx() callback declarations, this
   allow us to terminate a connection if something goes wrong in rx/tx paths.
 * set net_boot_file_size variable in httpd_upload
 * set filesize env variable to a proper value netcat and httpd_upload

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
 include/net-legacy.h           |    7 +-
 include/net/httpd-upload.h     |   12 +
 include/net/httpd.h            |   71 ++
 include/net/netcat.h           |   20 +
 include/net/tcp.h              |  258 ++++++-
 include/net/wget.h             |    8 -
 net/Kconfig                    |   14 +
 net/Makefile                   |    3 +
 net/fastboot_tcp.c             |  193 ++---
 net/httpd-upload.c             |  173 +++++
 net/httpd.c                    |  735 ++++++++++++++++++
 net/net.c                      |   60 +-
 net/netcat.c                   |  194 +++++
 net/tcp.c                      | 1297 ++++++++++++++++++++++----------
 net/wget.c                     |  476 ++++--------
 test/cmd/wget.c                |   58 +-
 19 files changed, 2766 insertions(+), 907 deletions(-)
 create mode 100644 include/net/httpd-upload.h
 create mode 100644 include/net/httpd.h
 create mode 100644 include/net/netcat.h
 create mode 100644 net/httpd-upload.c
 create mode 100644 net/httpd.c
 create mode 100644 net/netcat.c

-- 
2.45.2

