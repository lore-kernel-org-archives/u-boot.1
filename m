Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56A4D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FBE83C6E;
	Tue,  9 Dec 2025 10:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bD1b8YOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2491283AEE; Tue,  9 Dec 2025 10:00:46 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E54E83885
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 10:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOZYCkwlG2dYfOvGlq49IataJHlddgLFvW+D7fYNz8n0ZC0C+Iobh2xlWTDV5wV5ay/g4Ften5CZHRglAbpbV+sXkW799TUm+gXxgrAzqiI4CAbghMBAdF+G5fikknUThuTFWQUEObki4tCbsxs1UW83DUW47XyD4eqTWCMVlhHclG9+p4yDw4p7df3SjU6rZOB5nuucGLyY0XXfu35W+2eIhZZXhg4sOFDjPDXGgr+l6rMGZsbWaS9WSi7kcv5KQF7qKKpkF7PDNYQLABA3hpdHdjX3U4tgOAFTU4iYFl7BJaMZdLQnpLt8afKcn1SQOmziCOr/zSw4+IMIOQxq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcPr87IqT6yBG5gPfCsIkP+Pu+7pgTlx2G0drldLj8w=;
 b=bvSIilsCL+Fq6Ji7Tx31eV6myaw5U4yS5DbGAzb1lEQDY/qMlUCQtHkCEXNEvreeUA1fn/N0wT81c4ECQ/n/0Z4khnc0m1gt17IhKxKHmvgWqj7gbdm5bw0Kmhtn4SzVb/Fl10m3R3G7Z3OhSpM3TwHZxZvXqpl4qTPEqkrITW1+G7iKDmmLX1paXp+gFSvdbOQ894B2PBqT8rLAWpOMfPZEYaefOZB/O2VCkWZHGJ1FEMGkbiGiCm+F0P7yB9fN4Xj9qLcKugnRnyvZn3yloBkZf5xnE4mObEnbbYOg/MK8AH7gT8rLFyhtnYN4dkgxe8T7sD8tg3hFyEhUNDC8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcPr87IqT6yBG5gPfCsIkP+Pu+7pgTlx2G0drldLj8w=;
 b=bD1b8YOwl0aEWAp/uwR4KSE0I3K9Y+pyolNRkV6U7XKsofrmeGmBpYeBEqNK2W4nwFsAxV39xb/NB02WOIHlLetDr5NO6ytkPIkurufUyXbRiCktlcM738SRa759JsR9MhvlMaA1etWJZyEa2yseRTxhcf7eO/9tKsshX/O1UDlj5vNDNF/aZANwnPFfGoja+lFvbBMBAQGdhUKqqyALsred9dOU1eXpF0QvIdizxePMHWH38Z3VrnOXH/R3MEd1/zcCXTTa7/LwnRYbf38FC6J+1BlQE0YXSpo64agmvyW3WeeVRnoZqslzbRBYxZhCcdbDLcRn30VzHhnRmM96fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7838.eurprd04.prod.outlook.com (2603:10a6:102:cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 09:00:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Tue, 9 Dec 2025
 09:00:38 +0000
Date: Tue, 9 Dec 2025 17:01:47 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH 3/3] clk: scmi: Remove duplicated
 scmi_generic_protocol_version() request
Message-ID: <aTfle+svXOr7Ttlv@shlinux89>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
 <20251208-sqqs-v1-3-290f0594e30b@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-sqqs-v1-3-290f0594e30b@foss.st.com>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f1a38a-f27d-4752-8051-08de37016bec
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|7416014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NF6lQfHzHQUXow0FnSnC/7w9wPHNQi0vsim2CWkzIBWT/JeYtqEuGXVlg4WF?=
 =?us-ascii?Q?ebUENevkRDEbruzzJ2C8Ai67E9uvgf1asbLypzKTaFRoQaiyRws51i3CjdJH?=
 =?us-ascii?Q?smBGwfRQMLkTRrwgfSHFTuTS7/1XMTbNduwgKCYt1J0f4nEJt6b3n0qL2wjK?=
 =?us-ascii?Q?Xol0dRY4774lxLWCfaEFuZrD1ZVUO6ErxNnxIkl2dc0zGkCyswd1pvhS3rEl?=
 =?us-ascii?Q?vaBwNDTVCN1oe4Wd8ZGcNluFSbdIgPhHrt/zHqvbdrhDdV95zOrIVbJUsz/q?=
 =?us-ascii?Q?sjGQtlf5QzZOEEQDo9+9P+TTAk7oouN7Xz6kjMyo9PYZiA5jMW4DjOxyJeEp?=
 =?us-ascii?Q?31adzQMXV2wT2P564naLIxPpFV8JW69R0IiSbia6L9MU5hq1B2YUWMCvvOBC?=
 =?us-ascii?Q?Jcs7AbimeB7Cz5fdZNe2+ixmA1NR79cxjJbSu8hHKvI0OUO3sUyI04Vb9PME?=
 =?us-ascii?Q?ivEWJ6JitSp5n97NDbRJobYBx5i730PNY1NgJzp3PnHaxXWmZsLRl/P6Mb5T?=
 =?us-ascii?Q?RKBwYHvfgl9QKzQ5WrJreYBQt6CB5ZQEL3DGkZ5JpZJxaTiHFh6d73CUtJYL?=
 =?us-ascii?Q?s6gSB5NWk5fUZs9RAKRB2IdpENToon6CSU4DSbyyDLc94PB0q1iIkV5DCSMX?=
 =?us-ascii?Q?42TZEqzw1gN56w83hjhxKZpoXNUSnYPcpYbaTXnL7bmJf6A6nYXrntBIpgBO?=
 =?us-ascii?Q?hMlKlZ3QLCnPwSQ324eaLPKwtTjCc3vgXBA+mBR+3qE8T8C6iopN35iTiPEp?=
 =?us-ascii?Q?u+wJEuMn0u5XUMY7nVIRPSo3dhTmAdZN1aSmBWJZ/cy6Uwc+EaRyeN9kPqnm?=
 =?us-ascii?Q?rXYAfIiYkXiGdr2XKFChxJIBDM1ng6h3RgYkN8aCjW+JTwcS3Q8R1owueSJQ?=
 =?us-ascii?Q?M8YAwPcgLXQ1z+Slzwo59xrx9H8XQDIIaPLiFWSDWty+UzdUCoaHbRG+i2QY?=
 =?us-ascii?Q?9Suz/LWyFYpuWeYArsJWdglx9BIuC53X5eqGuE7XqK1a67QAAR+HoJBWK69o?=
 =?us-ascii?Q?P5qvqMfRKn3tEjI4kqU00zEbOhIP5yoVbxctwuqvN/P8UoEWfsIXP7wtDXB/?=
 =?us-ascii?Q?ESp9F4cn+GKJfQ+VS/0VXzSHNdlMAs7UiGbzbjM4JVHuCR62TMJVmLVoy9xy?=
 =?us-ascii?Q?BY7MAUN3nih6gZtZUbsF/qoIXOkuvsaqvkq2W8rX6VZuTagyJ6XlpcTrW7fz?=
 =?us-ascii?Q?iASdPjuuxEvPsr04eR5GjtWRTUoi9fplnBAM4pdk9HBnAU9vkhGWdlumqrY7?=
 =?us-ascii?Q?OiX6pV6+gsRK/A0exNKBCNX1dlnvD2s8dz8aA31tpNOyAQbt4DETJzn3RO1r?=
 =?us-ascii?Q?08aT6qebSOkuAUPF3IL3nkOBlEuNnAg4t9j7wWtNKEsYY4ffwIletiytb+q7?=
 =?us-ascii?Q?WzmuunQfL5PSnfcQGJ8ZJIK2ek+Hb+clgE3AaKCkPgfLKQu23gLLrMNFtnj4?=
 =?us-ascii?Q?z0CRQdwyqK8l0hequpwgEyOCtgd7++ifKraVfc1dwngYl9cBz8B1dvuFULhS?=
 =?us-ascii?Q?aZRnyHgu0Zc+OJB/2lFoovOwXzkEOXIXCVFh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(7416014)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nv2N/9SxLvngD/vr3hpO8BWMgfncA0BPMPvwbelHv7bPCtb32vQNaOd9Zo+x?=
 =?us-ascii?Q?1qEYlGWv4Glvu2J2UEpbKfFS1/zI386sbn/DsXqiIqPElUyB7UZJVqe67U4I?=
 =?us-ascii?Q?8k9cxBwdos5zadFOD9Qx1MZz2N6xrCWIeeAjoFj3cdEMvdj5ZXtNlEX+t+04?=
 =?us-ascii?Q?XRL7dBzaTxK9VtOZz8cxUkJX6kdKbVfhnou1575Wy2nxvjIzCDsESnjIgzPD?=
 =?us-ascii?Q?QlMaroC/tggo69mF7lkkf6fcDq+ruAYtxoY4FoT3382APwk5L8o3ps4LQwCf?=
 =?us-ascii?Q?w/EvFLdwNtUzLolry7xV134Dez/SiCf0oWQu+T+TGOZb9W8Ei62uD4rT8NpX?=
 =?us-ascii?Q?nu850dVh0dzbh7FhKGKqfRhgMP8u5/esFsKGdwhBCJQy4ocrkqML6iVeL1iO?=
 =?us-ascii?Q?8Jd62FZq0qAOnkLrun0RiSj7i8v55CM98S6zMxhp/2+fPyR78Dd52tVV9J03?=
 =?us-ascii?Q?3VAhQFB/s94zNS7AVtEw197bWWMqpxh5iV+Ogui2tvqwrem9mGCubHEOh90w?=
 =?us-ascii?Q?c46dyUexPK9QGaXO8GR2n6o8m8D2oWMRrwUEjXgAxYoB5C1AIDwSpJid3meo?=
 =?us-ascii?Q?ronSXt3rKeSy8OuF5nsacGtpplksRH7p2Y5aDqBiPxv7w4j65H9ac056or5k?=
 =?us-ascii?Q?nrKr55KUynebCb5/f0YDtfsS4/40rZ+v9oyEtLoDMg3VwlxPcrxM52yGSCFM?=
 =?us-ascii?Q?DSfG/d5g99TR/H+CLxV3CaCB1wT+W2g9mfKuT7SPDnLF2uZ3UwjNdo8gTglO?=
 =?us-ascii?Q?KTkPVtOFo97XcCA883j4ffAcWxqD6P+yU2E1uLlSQNtv815kYudijgTb0O11?=
 =?us-ascii?Q?ONEnOOHBDr4l2MOgeAHcR+MHiW6NygY1OI3luKsjfz4iyOW/3g3gq1dMbskW?=
 =?us-ascii?Q?a1FkwMVXJvanZwP+IVSIefqyUGXYd6z3iwF3MlWt5IT+0AZxWIiQ3zjl04Ts?=
 =?us-ascii?Q?/+LUe0eCNUpk/Cmgp8kt9ShFE1qzgEy7FqsiVEriX7xFwDJKOCMNBN2QAuAL?=
 =?us-ascii?Q?7C+jfUZXAwFA4u+YBxqdIRmseFuinGGLrY+uk/wnM/rXHJib2qSd3ZcsilbO?=
 =?us-ascii?Q?BVG1o4BFtOz8WpsOs4RpHBylAkJ/mIvG980mkgK3DvU207ytCY0Nq8Z3WIaz?=
 =?us-ascii?Q?Q2fJNGdySRcSJEJcJeuBf3HP7XKVOUeWJZ7RUj9kfFSLH78Ioqw//Mo96zwS?=
 =?us-ascii?Q?luWQkTiGOSm75uYp4tgj7LuM04HoUdrWNshkOD4s+BQA05uv1WQXuViWZwrT?=
 =?us-ascii?Q?qxpR2bV+uDPVtz2KOOVJmdafeFE5RMjfCC+Z49bCG+enFoTKhpHptMw3KKJU?=
 =?us-ascii?Q?qd+j9cpFe98zWS28ULPEy7yat2l+VxcVmCUL9JEhxH6LcHBQ0na2EkcpNjFN?=
 =?us-ascii?Q?hmZB25E9otnWBIeV2eUBLhhOBFTO/Ndg3DYi7jY0cQr3FsDeF9aQw9XybGyd?=
 =?us-ascii?Q?HUwlhDUcmb1Yxc4Qq4TTWyaIhkYMuhViU9lOmPdpC9Z1KQhd7Wk8Ug0i0OyH?=
 =?us-ascii?Q?gDIhoh42ybeAL9AAVaNiFtqYoCTJnkvm2UTBNVSwia2ijSX3Mu062ZSm9sjU?=
 =?us-ascii?Q?CgsXUUd0bJvgYVzPQlzPT2wfCQWifNOoA22xOsMO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f1a38a-f27d-4752-8051-08de37016bec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:00:38.0183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW6f84nNHQMByfuPJqN1BHw0sCV1HgdrM8TgxfnMTmvZnHnQ57Cq67RAJTs5ixnxbWpWFELheLlhUYOfA7JKXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7838
X-Mailman-Approved-At: Tue, 09 Dec 2025 10:26:50 +0100
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

On Mon, Dec 08, 2025 at 02:51:27PM +0100, Patrice Chotard wrote:
>scmi_generic_protocol_version() request is done twice in scmi_clk_probe().
>Remove first call which is useless.
>
>Fixes: ae7e0330ce22 ("clk: scmi: add compatibility with clock protocol 2.0")
>
>Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
