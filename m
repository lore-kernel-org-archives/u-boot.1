Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C240E77197
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 00:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C90803DC;
	Mon,  6 Jan 2025 01:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VZOkkKtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB7A8056D; Mon,  6 Jan 2025 01:27:23 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEA45801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 01:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUFqY4sThMqAmkmlcWXyjYZfmXsnLNI3+gaKNE5KynZwwEQ5K+iL0pzsJB+/28CmTFHU3z4OXBtIkQAztC0DC4MEW7o36jhNL9tGIWq8taO8KGuNysxX7cl+ztkPg8RqBIkgsNNkKZNiMnF+YF0LdXv4+i66VIZw+HGifJb2HMPUJ8FLOOC2VdwKjUbTdH1nkgboJGaIJNhUlNZZ51IG1+3IvQiDj9+5Jep7AnNvRbNPYmhEKlPL5BxpOrM+cqzR0ITEVy7ASrx9/I9cT0tCx9ExhjKLcjPL+a551KCdzbKGwgmPop8WadJ8vNaD0Gr+jvvOfAG6mawxbCimjsp0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zOIUQtgZ/GUo2OhlmU1zJTa80KiE5J3HoqA+uJcUnQ=;
 b=h3Q/VVhaWXgXg51PLqQB+ct2EW+lf1bmxRg0CG2VGReM9WxbjZrJgJMc7PLeBDHFveR5KxyQCAZmPUkvEpa2Os3ZDppMW0WbrIva8oKrsm4sT/HIah9B5t+pRqnNPY5EYBD4aKt1/6rf+VWf22wmtz1UpZufqIVwAZhmoYA43u8pgo5bKnirvGSsv4jLoWI5bH/+pl8IPggsQ8mCghuku9VTEOE7vmIjEHYH9T+KLPBWHgcQMcL0BDcm95/nVallZGNaBAiqJzYs5y2TPoG8Gun0dPshHYR0C9uQbX13BFuvur2m4Fk1nOgfs+qPhkCwS9ugqsfWCkdROyUAl1eykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zOIUQtgZ/GUo2OhlmU1zJTa80KiE5J3HoqA+uJcUnQ=;
 b=VZOkkKtdV9BpH9d6XeLhEoZuTisAhnlVzfaXRd7Y1ATtaoRR6IUMirjGctwhNjkrLVkb/M98ed3fgMdmULbdlnv4GqlUlxgXDjpjLXVKSCTEMJpJ2buNq6lLc7lic54EIohXlgcMDxV3jfS011QRwD13LMXFYBefAZ4ZrlFLooPGEtZL2gD6qVXoUS3bajMT1+50CuP0MzuA+ewDx4auGur6slL52Z9ux5n3avyD92QI5lNOhbKwGBwJapAaZW8CD6PfWRZTrGAizuk0fo2iCHSZOIukgFhtraDZjeKnyVFCTTFlXeJDog9KNCh6WPEdklgvE1rm7ku3Vt3DsFYUmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 00:27:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 00:27:14 +0000
Date: Mon, 6 Jan 2025 09:33:11 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Message-ID: <20250106013311.GA8414@localhost.localdomain>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a0a5c6-05a5-4f74-4561-08dd2de8de13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BH5cMZC5jAQxPD3pm4jcomN5HczeHLngjcCeYZOXeITuBA7Mur979AQhWB95?=
 =?us-ascii?Q?AliE9YbYcWE2d1r3mHWi/Af4lDPXdYuev9VXLjubKM2MV18/Mj1bwqow9G4p?=
 =?us-ascii?Q?JtEzHyuhvetdQo/ARtxQ1/0GoKAZrimwvnSgxvzsguFkOfqEVqJub8GhlCjK?=
 =?us-ascii?Q?+5pxXBtAD6trHOP/1U2yJd5cQmCF58RpiZKaeYMqCGvnTzUVnRMfdeTfmM1X?=
 =?us-ascii?Q?53oT4ng87uOAqM1L2HCiiXfFRcagH8Rc6A6EXh0d7CkZr8sDAMn4CLQYTgs7?=
 =?us-ascii?Q?IUaGY9b14OpaKmfey3Wr7FhsX3CG8LhV4GYjxwpjVubpAoRzHtGGopP1kxz1?=
 =?us-ascii?Q?idRkR657Vpw77hvl4UJrJJbhGGPcvD3nTAvlXmaEfi3fhshL2aa7KAL58tw7?=
 =?us-ascii?Q?glTJjw4S3/3YLA7zBsWquDi/6hfV8ScfZjUL/qI2I6a4LcF2KgGImGMikB/Z?=
 =?us-ascii?Q?9Ab9t5r+eXf9jTGCmLctUhvzeFIM96GJki4qdQmdLQQ9SUjrxdBRl1su9XPT?=
 =?us-ascii?Q?31gJoTvPNj17SMPB3LyVGKe989fK9eUwlo8i/IJbfqeJWbpGyri1HcB66xSr?=
 =?us-ascii?Q?n0EtBlOdMhpGJvNYzhDofLc6cD/DTHU0fQ3R5vXa6zCj5apnW86ZVRivvsw7?=
 =?us-ascii?Q?skFZ4wPEXc+x+gI+pcUuY+ri49NrR9wfIuckBr9XJPyASWB9NSQoRLnymPdO?=
 =?us-ascii?Q?/hLhsuLtAKvZV5QSzRNeqaYlnwdPU0spwTwHp1P+GS7lBTMJ+dRzPect7bzp?=
 =?us-ascii?Q?u2kMylljA4ntHJaFTbR8f02pqqRyIJ8xwDAC0y2LJ151RC0UgsunMxf19D8X?=
 =?us-ascii?Q?AD772HRNF7Tyz29CU81nrhhQjej7CqzMsaJSUD6MUV/kRDK7mwNe5Od9iz8J?=
 =?us-ascii?Q?aMBks77IbYP0+Jl3dEahhX9LNb3dtSN245wfrxnUexJd0AfEZLF/GrMh4qtP?=
 =?us-ascii?Q?uQLjg36bbCM5tgGEqAPSbKSNrnLb1t1POd13DI/VfXeyYB6nZLiiQgIIYKQC?=
 =?us-ascii?Q?Ayeq9jWte6pQhu71//AzuZm/wsUkJkFnRBCwszF9cH+AV5FEr48dbcsgrWoj?=
 =?us-ascii?Q?jPKH+ySiR6+Z3EHQlczT9u6qVSHHo8zkj2zhsCS1sQQhhBgIPyzAf7ow9Joa?=
 =?us-ascii?Q?2XOXoby4N1Wdlvww/3U71JTz/woHaNPP2eh4vcGvcCuF2DEN4krr8S4y49sQ?=
 =?us-ascii?Q?fMgCfceMGGkp4HGAlNVUMJk7pkXixqmPNZPLC1FW+migiLbu/lDrtR7kgDsh?=
 =?us-ascii?Q?l7g6U/nQ2QygtbtkILZzDdt5cfqPal1bqbNMGDv/NxqNWcgVVzQYjn2qZg3S?=
 =?us-ascii?Q?lzj4+617olYs22imL4UbajrwH+pFQ1MvUaWrFwakx0Cqi45aLoqSrUVHN2p6?=
 =?us-ascii?Q?QT6kf0gSkxzFbcZrS9MP1dZx93VVcTqATlcUmX2ioRtbJJxGWHdOVqkK5CTa?=
 =?us-ascii?Q?8oG87whWleZ3uufjCEoe9mwIYt/l7I5L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WxWNaIJF9QxB2Nk0HZRau+mKZHLoPbR5K/Nwakh6n4jBaTdvdmYjCPsR/Wf/?=
 =?us-ascii?Q?Jx5f/PsoAZFNE5sKR6Eu9+8BbGkqPRpUIkaPfw2E4YRvFGY6kET76sNfwe75?=
 =?us-ascii?Q?u8D2rPCzdPOSs2MgFcO/QjGCsLH3CclnL2VsEzG5SrH3uMJ/EwPB+Fx9cYna?=
 =?us-ascii?Q?MzYmsKNj1VG7ywnYs+/CTDv0ZOK3JXvNMoM8NvPFgo+nQ/Y1tAlh+X0OooMk?=
 =?us-ascii?Q?cVgprw10L02j2nP0Pc9spJMAjKJMImIWG2ZaYecSQNrlXYA/QDyCUXriIhLb?=
 =?us-ascii?Q?rp1zCXDS35jkSWeCAzrGjW2V++Kph8h+HgrhAQrUgLeaZPF269UapuiawdTm?=
 =?us-ascii?Q?hRbbUYaQPGkOqDm8FySrLxskv8taAMBfAcChM1iuV0iWLwdJPxp1SmZC6MwN?=
 =?us-ascii?Q?Jyn+udZM6LR0cCG9EcXbORgigoUe7a1mNpKusXOZJU+fgcIK9bxSgdcaPcVS?=
 =?us-ascii?Q?lA6QYYbJD6NSZl9/PxHVabodKq6p31Jsc541QKqBEm1eGooqa2FH/Okgz+y2?=
 =?us-ascii?Q?lCElDqaWNB7OfDInpTNuNl75cN1+fZUbw4bZcvub2shsXBF+QNgWVSHQUpFo?=
 =?us-ascii?Q?X9RFHMBAi1TlmJS5qBVFHaTQpXUI3PdOx9wjbtO+Li9fQz3mICh2DQ2SXfJV?=
 =?us-ascii?Q?cTJXRCR3r25Za5kaNa1GdfPqWMY/hVEXAJB3jm7utKQyUnS4b5T0Sg/sxSCV?=
 =?us-ascii?Q?DPo6a6PU5zHmjjnscfUwxPfXcbmSbjDOauC/dZpx9q+ZHdIBQqKOYhvSlTgt?=
 =?us-ascii?Q?qF8J9pbumriiaNceMEYRTepsqVsT9VRs78+khiG1g4zUpVr6xhkjqIG8qlJ7?=
 =?us-ascii?Q?edIpW7kcWChuy9uKFLA4UMtFx2hqifAN8wWwnts0RHGT8MIla4QEWuct/J0k?=
 =?us-ascii?Q?KAqhmeosE4TtYsPEVp+HoiVwH/aFCWtNi6lrjWOvPy5zdbAi1Fek4uKkvn8/?=
 =?us-ascii?Q?IqTD86YZEmtk/DQEoujdABHVzX3RoyfG74Kij1sDrWwzrK14k3sljYrChKrS?=
 =?us-ascii?Q?Bqh4i9KUPyEZKtgoBRH6eC9fo/6RW7WaD57v8gWjOmMAxAk8pVCpIiiOqI0d?=
 =?us-ascii?Q?VxTpiZnB5dCJ4v4fZ1Q6C/Qju5cT3kR8EYxAyWNm4n0MbNEHVwYnLdpw74lP?=
 =?us-ascii?Q?UDNwN0mcpfYP3R41KGK6HJ/zH+C1IgiSM4jhFlfwIbV79uXpWKYKfnQBIoaj?=
 =?us-ascii?Q?OuYE4zUXF80u9MH9ue0u1Bxj/v6QdUWTzW2uo4xFf7EcORH5R3lIm/9vmC6I?=
 =?us-ascii?Q?LRwYhNXTFG5sBbFRDYCKd91iE4XyQjHzn97Yhuqi3SHNlMxSskINgu8HKqMo?=
 =?us-ascii?Q?3LPWg8P/J1TJrBUZe5z0agdZ+ljc84+jIaTQm581EN2NfYG4T6IxgFtr31Q5?=
 =?us-ascii?Q?ddIn04KZz3w/rZXz3juDFupnL1iiFQYAxzXmwOvJLdjO/ncycWiwpCr7VQ0Q?=
 =?us-ascii?Q?g0R7ZfFs/ZzzJI4B+4ZMBzEeWYsckAzWucNmDSEh/cIJ22cGF7s7PYRU+vnm?=
 =?us-ascii?Q?iBLHie5rzenqIwCa3+WZFedCyl4IcjhYcLNikd1JplboAPUTNk14xdL8Nnea?=
 =?us-ascii?Q?NQZ5nqYmh5aSNwuiV4EnArkdwGTXtATQ4coDywr8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a0a5c6-05a5-4f74-4561-08dd2de8de13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 00:27:13.9699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uf8fnOqOMSSl8SulO424NTQDDkfOndnu41YYkTO3D/SImRWyTwdjRNZVFvjBt7mviidJFFXpd5gkRMEvgpBWTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

Hi Simon,

On Sun, Jan 05, 2025 at 08:30:55AM +1300, Simon Glass wrote:
>Hi Peng,
>
>On Sat, 4 Jan 2025 at 16:19, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>>
>> Switch to bootstd for NXP i.MX9/8M boards with a bsp_bootcmd as fallback.
>>
[...]
>>
>
>This also switches to a text environment, great!
>
>For bsp_bootcmd is it possible to create a bootmeth for your use case?
>If you would like to take a look (separate from this series), I could
>help with any issues that come up.

I just give a quick look of bootmeth, seems needs extlinux or bootscript
(boot.scr). But both are used on NXP i.MX release as of now. In NXP
releases, we put all script in the U-Boot ENV.

Do you have suggestions how to move to support bootmeth.

Thanks,
Peng.

>
>Regards,
>Simon
