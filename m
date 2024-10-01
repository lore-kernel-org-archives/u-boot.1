Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6390CCEACF1
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 18:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D675D89275;
	Tue,  1 Oct 2024 20:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="B0i1hf6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF6C89275; Tue,  1 Oct 2024 20:21:21 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::718])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D604289207
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 20:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4yIsm+LcjkIg7xKjDBx3nHTl1RDCmjUfsNf7V4PyhG/6rX3O28B2m6hzETAjf4siImUH2dko9TEs7n44YZ689AqXLEzmKd9UotHHA3wbegnPzbzJKW0fs6k+qEO8lpp5W5x/I2ER7azzyh82zANw33EuZHbxwLAbAXthbt03mx3ST003zUSXdT+OvKDVtfwJDR4JjNO7X89h1j8OnlI8gZ4kOTvnml8so+jYLp2P42PS0v6yNOmhJBOTm+qF4CZfJMkjmOBp3zme6utNtqGo7Dd6RUczDDfYpdQ5l3nvZ5QClF9tKgkGH9jKxTK6FYLnQeRDD0hvcFiDOgnW4dlIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqj5bPf2ucuWTU6Jc6Z5zPsMR0Mw4+3L70uuGV1Tobg=;
 b=Xr2heo/NJaOP4f5jwUSyhiaki5NKmtCVrEr4zSI8rWnBQsJlzDcKpQcXHFublb0HTGDpo3KWftMO8+zde3ZW4Cfkm5JAqsog6vovD8hhrAqM540181g4wNrVIz+Jo60dYNhF8YnJ/4Xvwt4kCDagTShXLkTwTyBrJYA2xds6s//owVHor6OAQpllpMuzhAOQU8Cs97YN05/nhDIZqyLMqeO63emMaX7kErrTXeGvsurjFCVMMxOdETA6DLfUCLvXUT2bwKZ0qECJhAZVP13DdicnBP7ik05Ozpj21bWcQgD4oI67mcPp3lEbBnNVG0wse+SfGM5NBcXuBCRBPFczTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqj5bPf2ucuWTU6Jc6Z5zPsMR0Mw4+3L70uuGV1Tobg=;
 b=B0i1hf6xSvX158zpLBbyW6jTGWC993q8tpXuHj9T3WvkBUB4j4QnWkW6mQOol0chdOZogNeYAk2z4l9m4fsTRzFXkSSVpj0qpPSLRhs9dKhQpXF7jZFHxCWG3pYpuBbI82yftJchnbauvE4Xmge9tuwo4Fkrq/wKOB6Cz5VVRl4c0ewQIx2ZJfmM9WzIrsJOZPmqUjqYea2RT7Fq4wsRq1SqL5NcFV4lQa5OUDA7dqRrduAocBazexLKEg7e68xQaXYi+On8S+5WMwGybjuDG5mzuoLbWpMBIMQhq+ArVxNVf3ioPudcHIzzU9BDKdyQBPwkgACT0hrwM8jGBPJFfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9188.eurprd08.prod.outlook.com (2603:10a6:102:30a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:21:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 18:21:15 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v9 00/13] net: tcp: improve tcp support
Date: Tue,  1 Oct 2024 21:20:54 +0300
Message-ID: <20241001182107.907828-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::311) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b88ba27-54a3-4dcd-1a80-08dce245d63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wsRlQC4syRp59WREKHT7VdNW1JzHc8OKJaqU3f96Z8psdq74OX+D81IGoe1k?=
 =?us-ascii?Q?SiHQT7CuX3Fo9LZnjP39JB39eQmtu6UH9wcO4hD/lL/7tBFntuMZwtZKTtcu?=
 =?us-ascii?Q?hEw4Dvhi2vADvwXbbDxBNVVYpfDIJ7+GpaOCSTSRSJJqIIqzz12orb0PkRbC?=
 =?us-ascii?Q?DuDXCFDOeir17DlnKC+8X1T8gqYCQ+cx6i7j3Y2l/0b8G0m5xVDIpQqZUaz8?=
 =?us-ascii?Q?FPmaCoEqsQayMozL2OTSKtf9VVz7D9Tik1L/SRPnnGY2PpsclDKLEd7j67k/?=
 =?us-ascii?Q?24DFaP2wDFHnpqTtlNtngF0tuwYo3dcruvAw1cDQLVWI845MXMtBKZdBG8Bd?=
 =?us-ascii?Q?Vl1o2NjyyCehlJCc3zkK7Rimo8Y1ZNUmq7D6hRmKkqSmiaoyYysGGJtOurGp?=
 =?us-ascii?Q?onHZQJG8IG7qBEBdcW7lrbdbq5cvI4FrYUw2EZ9SugIIicrg/SJZKP5n0M7v?=
 =?us-ascii?Q?iBSnkxCkrABPxTl4DD0ztzgPhgLiwc6aGdG2G9N7Vrm2ovy74a9huL+xvOJT?=
 =?us-ascii?Q?PhfE1qLlKQJehoI7w/OdI/KA3bo3OSFaSCPsRCu0pmhNHyMli0xE8cVJ0CD2?=
 =?us-ascii?Q?Z3xXwmGHYPfCdrOeEzhB8aqVsrpiDVgSDv4KnjVZl0kwrq2OSa/MIjTt8oT9?=
 =?us-ascii?Q?rxWMwHhsWpALgI9mXu7cX27t8DSAp1cghsaJQlu5AhvxWmcWVdAiAegN7Gsi?=
 =?us-ascii?Q?hmx2Ab05vqbR1RjLKoXaPsiUHgJYEBAj3ND/fYBGGNwfReLF8Le2mtaoxlpr?=
 =?us-ascii?Q?WjP9UYRR+HIE7UHUwZ5MO7+9bQZrK5eU0tORhehXf4s7nnPRINt3FwJ4uXlD?=
 =?us-ascii?Q?v5a5NyLQcPYphS2huTuaxT5RKrzSbRsB22FsWZGTlH40e1SafprTbEU+jw3D?=
 =?us-ascii?Q?232RopiVUY3HP0XD51fMd/A0OxihPfYbwAscBERkn2Q361+q5xfBjkxseWSd?=
 =?us-ascii?Q?me1zc38+r1Bkj6GWwE+WoV4rjBkwhLQG+elyMe/qDevLDxONO9wSinA0019L?=
 =?us-ascii?Q?NcqEQgVZxLuLRNQurBWHUep+L9MmJtLCGLbLEzWUf/F/qcWgzeAq4TPWX1DY?=
 =?us-ascii?Q?vaynT35NMQ2IUXfXriYCmzl2hRAuFgnQuAKln5lCywIziMFbHMdgggbHdOcU?=
 =?us-ascii?Q?xrQixQ8bXV5nh/0jRJ9jjf/W0BplZdNIVy5iTauY/rtXsU210YQs0D8ZFeLM?=
 =?us-ascii?Q?gAcJqjyHyHFGXxNvu+9nSY+KQoiqu0oRKy8fBE/gQDVov6cnuzup8V3i7/WQ?=
 =?us-ascii?Q?3sVjvIkyLnY7BkW9118g06SH9VMaQ+hzPE+m5NUuGFtcwALiLjRh3+sHfn3z?=
 =?us-ascii?Q?arHxXPohu+9J5bYTOZ6MpOpSvqwiZ8W66ExLTXf3k8gWbkh5duh6QdNpbhzx?=
 =?us-ascii?Q?gWz1S9s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2FVb070AFKnQ4evwQjThWhmsDp3n6DlBzel8WMm6DKsc04ruSvgCwnosD3HD?=
 =?us-ascii?Q?gXPqHwaCkFQEmOEJui+++kmlRl8iifekJO10tX7K2+A8Vu377RyAWYhjtHIP?=
 =?us-ascii?Q?806MJJpd/6ZpQy/3U3aKi+YL7OsMsTLBVTEtUZkuPMWEWcRcot69nRSAY1JX?=
 =?us-ascii?Q?n/eMhLIq+EbEIHY4nLCrgKt/ozY6bR9GavgkQe7FdZodAphnL++ilViHNA3C?=
 =?us-ascii?Q?u/2aHvtGTxSjFx5qTApNS2iG9PIy/x8j3Zyd2FyCTT0k7AMXm8Htq0X1gXRW?=
 =?us-ascii?Q?CAiwAYjmQG9Xsw+tycZ8o29c/ZWcvxSc0Pl6r0smzxIEczmGjDVrlXk/Fxdl?=
 =?us-ascii?Q?QgdoCOzYMo9MNsG0dCyHBn/647mmHo2J1H8Ac3N7O9OttH8ExJsL3DcvWghO?=
 =?us-ascii?Q?hG5dGAqUl7+eT3xYovtU+TP226H9pScV+ekdHMPwsFbYEVRanjwGIOqds49u?=
 =?us-ascii?Q?pXBLAzdJd6VvaZJXYUdeRBvoUSOQPVBDuQA9G1QiROnX7JtBnCLbPYvJz6HW?=
 =?us-ascii?Q?CTuDGmXAgWLpTWnOeUoSwNpgSEmVc+aE0XoUeyGy6Jz7UBOsLbugg5sqVkZ9?=
 =?us-ascii?Q?AAoI5NW4B/Mh6CapGmgd3rDk/8IJW/0Q0BixEpPfQNJQN8n2WAZ6WmtQOocY?=
 =?us-ascii?Q?Ie+dLNr3ae5ySk3uViq10A9gbA3PCnnR9Jm8bJ0VXsNt8btZYxCbYL6ooTvx?=
 =?us-ascii?Q?qraE0AMd11NttfO2vdCX/MzefazVy2cZGB5c3uKhZyfZ16CshZ8goTacj1Zi?=
 =?us-ascii?Q?cpFhACwEh7xFh0l9uuJ4Y90f6QxsSu5gZhP4lqmxpwdjJsOygKx8/vxMFaYG?=
 =?us-ascii?Q?iOMh8ppa2b3+Trm9v5lqbrSLHloVSzcxrkeO5qlmP6nGmuHLLvor7+th5hUd?=
 =?us-ascii?Q?XV0p17pdbHy8rPCKVW1FJrH3fZpbXdiFpNvDDhBaz34nWnNKBwPRVfXrDrxA?=
 =?us-ascii?Q?MCsFdwh2Urj/X9FvAvE9iSMx8cGXlUNR4IYm6GRx4sBS9CYtyqwsZsCfd+nF?=
 =?us-ascii?Q?KrMXItrAMSq6lv3DU387jtrVdAlxhdNQ6yN8JLxrAiyMCcGqnq1GfMr+QmKe?=
 =?us-ascii?Q?A+ZjoAwZ5RIQgdjJ2rdRwbGM05aHcL0qfvORJxgkJoxZ5A4qBJgp6zBr7BRu?=
 =?us-ascii?Q?gOTGzQSQE+kxfkgk1KT+Owv+GhfWpA75MGFVOIsOd20CA07IhSfHX+GAlUvU?=
 =?us-ascii?Q?7f9QQTuotYAPKOdFbcl/M9M6eZZcMNb36uoBRi/q/PWkHyFaqHhSfie/UDL4?=
 =?us-ascii?Q?tTAOWjogCayK6NYVWxOMIMb5k6u5pT1W0GXy/KCJxiud3kRCtNhUim8KY0cM?=
 =?us-ascii?Q?e+c7Y6Jd8e5AZXzMD2AIxV2Qf6vxUUypkONtdczKkWzXmg5uYyX0B83Sp39j?=
 =?us-ascii?Q?eEz5U6H78z4h/bqm3E202r4eTE/Njv2wIiXOOk1e2o9EQSo+yr3cMvyfWHut?=
 =?us-ascii?Q?ZdUJjOsF4lsCnOo5fpftzq+Rx+ZYKyiIDPaljq2qNljxAglTpr4DFUmTeAT5?=
 =?us-ascii?Q?LysYVtb6140TttgRE9V4FrNirw+3l1FhuxQi3d5FDmKepqRL1N8eKTCLLnUY?=
 =?us-ascii?Q?4fpdcKlkJRDvak0eFCEe+3yBRlxIsZ0WrtgNicS3ZxqpLLgVCgRx8eeqsMHg?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b88ba27-54a3-4dcd-1a80-08dce245d63a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:21:15.7318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/R7A+r9aTi/JtXS+ZRRmY1dKL3GVNzADBQe1cHCu7/EsI7dY3P73HJp+SThN+1Oe7sH9N+Z/CcpMQQcP7de25B3WLuA/yrcqoQRrDazAog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9188
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
some kind of tcp support. Unfrotunately this support is really bad.

Some of the known issues:
 * tcp packet from other connection can break a current one
 * tcp send sequence always starts from zero
 * bad tcp options processing
 * strange assumptions on packet size for selectiv acknowledge
 * tcp interface assumes one of the two scenarios:
     - data downloading from remote host to a board
     - request-response exchange with a small packets
   so it's not possible to upload large amount of data from the
   board to remote host.
 * wget test generate bad tcp stream, test should fail but it passes instead

This series of patches fixes all of the above issuess.

The benefits:
 * A lot of bug was fixed
 * Better and more reliable TCP state machine
 * Tcp cliens becomes smaller/simpler
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
 * codestyle fixes

Changes v5:
 * old patches were ocasionally sent with v4
 * add back web-server patches
 * fix bug in debug output
 * add more comments
 * codestyle fixes

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

