Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4821BD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7641083C23;
	Tue,  9 Dec 2025 10:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lu5BbWu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D1EA83AEE; Tue,  9 Dec 2025 09:57:03 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9198683885
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 09:57:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpM8LeIi31eGeygZs9suFPOqC6mgjMTOD64G8/qFbxfHjdfLmeiTVS8Pq/vY7oWlBHiCkeL2iUzxcGQZxT4f/un9zefn6W8Hj4iE/61uXdbd5dzCn9Lx+nsSCH2OgObXuHgnWh51X1ANtLmqzaGVipr+P28lSETEIK3oATD0eWMyhJzPSKKfQdo1GG8ddv8qhjMctZn0C8gxRU7sA9zu778qzTIwbCjM+g3gKBeViPq7kk4/pwkioZJeDS4wVDj3/+CtCEZ17d/MNzihQeJ35VkROEVvW8Eq6jWxtUXUjY2cny22LbHQvwARliPHWkUV8UesEhlzxpHFzRDvk2o/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHZRgBG6puAMizDcyWyPI2QX7vCtL8tla5lEkC60u4c=;
 b=Pbg4Z2lO7dqfMX8EI+dtXf+EnWJFs+B36FGjOrAMat1qLSqkKJ99MMv9nxaMhRr40u9pO7fNBSJ1ykZbIPQXM2OAS6zRGFNxjGtGVNH4xbkRkZX30dv4z7ggmqLT7yFbqer8AM/mS5cNdSsc7zkNCLFBx3hjzFCN81vqTa+cwnvg4Upi/enkAvsJ+h/YVWHzNVvk32tH7mXXwa0dGsR0M7RkAY6fkn3oZrUHx5/R11sOh0SVYtuhssTnQEyVEF1e2EAsb78R6vARb1MiqgK7ITnnz+6Y2YQhSiw9Mfr68ZQDndtrunX8H3AIgdPg2XFojVUEOvvTBbnTnuyaWBAmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHZRgBG6puAMizDcyWyPI2QX7vCtL8tla5lEkC60u4c=;
 b=lu5BbWu2cw5x/yayb4npHNRugw+GXyxthRBVibrEU9xRrwX6BIWgF7gmGuxkM1+9kXgCFsCXzl3USMVbsOmAqOGzTOuy/iUttZzp7xPCtsR9ByTT0FEQ1N6kIgPzslUMECcqHqPNXqAFBLB0GU6/T7bMpwZApeHUbhCiosTB5AP/akd8ZS4DtCiSogviNCv+rsiyWezoGb2vSlK04THWByUfN5it3KWXSE4B7YRbmnLWJq+h61z7TuNk6Z0UMDNGfEIBYk/+o65cBM8YNHXk0rNM2e71/aqIHqxP+hCIb6sOgvuQ9Nz5uh1DB2QunpbV5sC+I2QBb7wTpK0O4yhoRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 08:56:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Tue, 9 Dec 2025
 08:56:57 +0000
Date: Tue, 9 Dec 2025 16:58:04 +0800
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
Subject: Re: [PATCH 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
Message-ID: <aTfknJlpcV6UESFa@shlinux89>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
 <20251208-sqqs-v1-1-290f0594e30b@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-sqqs-v1-1-290f0594e30b@foss.st.com>
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a829a7-c02e-4e3f-5c17-08de3700e8b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|1800799024|19092799006|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+znikQ3L8C/HF4lUhQYT3C0ZCHiSzyYKdyng3A5V9ZGV5LTjUrFvK0Wd93RT?=
 =?us-ascii?Q?JQad5fVffoUalpRrMBQQNFybhssH+EzFXIrbGQwsF55TbXjY5sB6ARfFOuqI?=
 =?us-ascii?Q?0VDUVkd0AOj9HIa8dm7eMVRvtcgagq4ouCb8mpk4OdwU81LVhj4OrIAJ1ZFm?=
 =?us-ascii?Q?5Zf3yx5BHttZv0PerA7ijWgDVp5Ykqc9iPD6bv5Oe1jJeb1fQkHqkGM7Z29y?=
 =?us-ascii?Q?GqQkiynWnhWuiFKvToMG48dh4h8H/FGvMjWUdTjV2O7zauUKMBoIbMNWUJjS?=
 =?us-ascii?Q?zog9yOpcNzKqJZ4K3kjnfgcN1XKMepgMzxfeD5Fs2kCB3pfP8CCRA1A60YD/?=
 =?us-ascii?Q?XsbWg5wsFHsN53TpsUqyjzYp0pKFNQt3+12SpL8Lo9seKzoODxIn4Hh3t9KE?=
 =?us-ascii?Q?l54P3BW1eMxaEFmcgftuTDwIjdlXdjouaDce0019IdbMevxinqGeVd3flxU0?=
 =?us-ascii?Q?cLHdQbVOepvvP0W4kMvBffg9dSa1adYkXgEYYq47EQwIFqt4bDCM4/wajhAX?=
 =?us-ascii?Q?OVVG9bAbLfa8+U4es9kFYT9Dnvieb5edrdmMB63KykpSm1YgISeQh7hIaTdN?=
 =?us-ascii?Q?CqyGh/xoQV/p4rjLi2xfI/8DprdtwEnJPg89oacGQNap2+onD5SFj50WOjlK?=
 =?us-ascii?Q?ZGgTKWZWD7QzhAAJPJizdMnyyKMYgLcitOMyHmEJKP0jkXRvKbefEBvHsVdW?=
 =?us-ascii?Q?q51KS+X2ALYegjKfchV1NLU+Um5l5MPYfRtkyyXH53OwrRKv7lE2RPsjxH1G?=
 =?us-ascii?Q?nLTa5WTO2lqGTpxLvdnADYRfOCx9NT0Abnmi+8xThYzv9ysyOSk6kXKl+Nfp?=
 =?us-ascii?Q?Dfqb6u0RE7m+0Ihey8Tl8yNKgQF5ykN9QbgL1J3WM9ovG1tsXVKH6ejgNTG9?=
 =?us-ascii?Q?Wc0iN16ukjhvbT+hUG7Wlar4DjaBusrUW3IHF0jwFh5pTwNe2g8yhO0UF7DK?=
 =?us-ascii?Q?dhEUiu0U6tKrGJWhYDS95qZ30ZHqgckIuRu2hXt2Z5SunT+HFm1LWo+gGDVQ?=
 =?us-ascii?Q?Wn4NSryrFrghoTQ4GTktE36IpAfSwsO6hyLHGX9anwUOUdA7v8hdAlcs0oXl?=
 =?us-ascii?Q?pBDxKQFHHb5ap7PzLwXt0Bxs/s4K/TPmjF1sLcZNomGvylrqCwS5v22Td8K2?=
 =?us-ascii?Q?yi3B1LHAtDlyHUc4GqHagRWQUSYaFXUXA/Kw1iRtZNv0aVpRDEcDdIDc/ahC?=
 =?us-ascii?Q?y9nYLtfiy7fs/OTbWfnsohTHhLZiUbOhx6hagslQ1pmFZNrf4VzrXVu158Rz?=
 =?us-ascii?Q?2MAezk7hKx4XJHI5SH9FeY0PtXgwai/BD6perw+MmcW0evag0Ih1otHyt64D?=
 =?us-ascii?Q?Sb8SAblr97xNW39hztPIBscmRT8rQxLR7Do4N7q1a/vWz+V/aUMeWBPE41fC?=
 =?us-ascii?Q?dGhJLr2IrSJyHxw6dcyT+q82S5Qfzxl+Jyxu73+Sp8kkcLQSLXRTCWeEnymf?=
 =?us-ascii?Q?yGBovGQyMNlpvNQSmlDo8g66iB11j3sU7OXPFYgX0kj2PvrtU55PJ3QIKQeo?=
 =?us-ascii?Q?WYO/LjUi1iIRa25gHjLZUC39D5i00FoLk/jG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(19092799006)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UDZbgZ2NgWyQcu5MbFZsCskBfBMSwWFsbJmffmkCROOp7aG26/jGt9uHKf0g?=
 =?us-ascii?Q?SxKWJ3lLYtkL4KjIRN0Nt0cFUHz5RijIxEfVzZtsGh0Lt8Tc4Q4M0HO/FLVk?=
 =?us-ascii?Q?AAxkyuBXEqBN8aj/yFPqKGp27Ie5vujIZcA2PyrpJu6QXxd8r31XLf6/WbKI?=
 =?us-ascii?Q?9b/yu1sE2kcxIwN8XI/Vykok88S284iWOx4VR60LtDDFsk08SJYfwyo0kY5w?=
 =?us-ascii?Q?M9xs4Oou7y9M+wPC2IW+H19Qwq4otFr7426nb6GmWKdYHO+N+yX05DkjiWBL?=
 =?us-ascii?Q?74oS5IXBH7MACytObB8Oqff8RxAJWnRgD0qJJpTDwT5F6HasC77QrOeUUx4b?=
 =?us-ascii?Q?h9QYmpw9sKlXcf/vn712GcVLTRVG4Bo9PPv70F+ccnciAVv02iR/8xdK+KTf?=
 =?us-ascii?Q?2KVBvGBzkp0zTs0IKSkBb4fz6Br9+SynbeIORv8MOkUSWkr5uRjS3xlTxfcF?=
 =?us-ascii?Q?GXZSt3k8d2oF8ky6eqxEG/oYXjCGOP4QhZO3JggPvv2wPiB1mw57+FUQq4Hj?=
 =?us-ascii?Q?oanbs658cTVXmNlNKDdEiMeeVr+fIdW5hpWAQdgF96QHyO4a54puVi4CXsOY?=
 =?us-ascii?Q?Dwncspq/F5LWWxRnFO02PDIBwKbWNjloeJZ7/i10mld82IAzZ1679pYsWKam?=
 =?us-ascii?Q?tYVm9l2KxIXqvP+BdS4WCw8x8QjHb+Qc9taPftQlESgCrSFVkaKf4XrIGJXn?=
 =?us-ascii?Q?ygMU9AuKgVr/Wfi3qij+8rtvEom9w9yRH2ELktsjO3Dd9yknu/jcj2AJ2H44?=
 =?us-ascii?Q?13W0pq3Y60E+WnVHtUxZBEpZSsmxSv4ZBaOoRK6mTeSTHhqZuszUNGQy1lDB?=
 =?us-ascii?Q?1sEYTcQTw45bw7jb9uLPBPIyGdRD7W2vo6LW4U/aFTN2f+2vYNvrUxb/aUnY?=
 =?us-ascii?Q?bly6fo0Yq1jXC43RWFGJ3QCpaT1VrMJw+doU6A6xcKbiqUe+HvPs+k6W/0F7?=
 =?us-ascii?Q?J+nRSu/Js4wdAK1x9ucNiC7wN9XfYDmt6ot4XQvbE9Ztmh+LruoGIJobTcwm?=
 =?us-ascii?Q?Pmuikrp+EM2xbCaTsYYKMiOkjzFPMCnJDjw2C2aG4tyKXb22uVqbF3eAxGGX?=
 =?us-ascii?Q?CdhQGIWZrs5jmU8CLB04dSl5L27nVOPGBe5IRqj0TsG6JpMlNvWPFz6u7vlo?=
 =?us-ascii?Q?L/6U6S6OC26OHD1Xq0la0FghuZ7JJolJIlbutY3GZbMR830tgPCUve8RIwm0?=
 =?us-ascii?Q?DxY/Dcd2XEZLywA9EQa9AZs0aGk8TLyTc/IvPvv8pVxpbsF7e2R/QsqVQzy8?=
 =?us-ascii?Q?NTnadLpzJ0HoI8QgVIfX1q0xDbtbzpc786cSPUmzfjh75G/55toqzHRhk+Fc?=
 =?us-ascii?Q?OaJfKyL6h0H206KWz96aCXGPFtmL1qGN6FlTguNYncnsiC+bM1WZ+8xWN2PN?=
 =?us-ascii?Q?+UaBcv0tG9T6Y4YiGFy/MR1Y4cmClaY0D0YvsrcICTEsqL6Y1lid82UfVZ7m?=
 =?us-ascii?Q?CaHltwEkskT3VeHFSd9PuOlO9UPspDd0yqNXmyX7G7CGzdGZg++336EHKqM8?=
 =?us-ascii?Q?TDVSVndqyNLA8dcro7sIbTq5YRewn3E80djIfvl9+rXQ+tlqW1fzsy1xL+eD?=
 =?us-ascii?Q?/Q3VCzuAKs1nJwdejYxWDAgmkUiXv8+ocrWNkDba?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a829a7-c02e-4e3f-5c17-08de3700e8b8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:56:57.9244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWD2qVtyocDwpbn/IPrYZd4K3LZsJMSbiz9qaOElGgpUxNRuwnSzgfjBDaA5dfgic7MkSeqS7wccfs6vMf7d8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558
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

On Mon, Dec 08, 2025 at 02:51:25PM +0100, Patrice Chotard wrote:
>%s/scmi_clk_get_attibute/scmi_clk_get_attribute/
>
>Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
