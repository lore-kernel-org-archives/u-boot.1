Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8F9CCF9E3
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F99383AEF;
	Mon, 10 Nov 2025 21:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DkK1x1L1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD33783ACD; Mon, 10 Nov 2025 21:54:18 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A5383AB8
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1KK6plDUWGA4ts097MLaWuPJ/ZLOfkSj0yquDhOo07pGa3BY7cvPAamJesJ3zJHWqwVNsdN8+gKL8rknpSAt8CujpQ7N1KXxVJOycC9HxoFjzaZzZXX3HmS8aCeFwghQ4DsMlwr+uYdGc4p1jIbdcaF3d/D1OyXVdqW+Mji3sKLmehTgCXrvjvPA6+ZhWfjpSSstNgbc1q+gEm/40GggaVM+RqcV+4t+/SZ6WKqZ2r+a5u8UmGDDi0NYvTr2shnouYNFraJkxEiYA+UF/VhoXuGkpqxti9DyCfABydSyi/rR/SHgXMtaI2PX1Tau47MBEypZ1uqLgmgSFKsv4JAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGhCDBJDY81NKYsPqrHjGr7BcDlWEPv6fir4zR/CLQ4=;
 b=l3240VcksMh9s67osrE3A2ccPTmT2tjYIOQ0Z3Fv4IM6g741z4xgF9wxDobd1GVu+Hpq4Em92fTbzWs1ho5lrybgxOi+VnCZxsrakOThoKO4Dyx6IUbi4LdY9sRUeslvam0tcOO5aGXpHpqiPjCWKKt/Ws4wliJoSQPw9/Vsd3QiiUiqnFqIxVI5jEyfUIj7z/rbPNIUTj3tSxm88xdbokP2dpiOKAIPDPqDjQQpoVTvij9wRj+Q85oGrNonCy9j/07MEHcJhbk8/z3WtC9XX6Y7IWN/K7d2drgMPO20A65L/7CZHR6RBaBBXMJIHYbQk54YRp2UWwChFX14GuXvwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGhCDBJDY81NKYsPqrHjGr7BcDlWEPv6fir4zR/CLQ4=;
 b=DkK1x1L1fZGd4X3vV6OYBcd2zXe5a/HymjdR/zzX3OrVSMtX6hbLKSks/DyEVWJKT0QcWqAXnfgPUUZj+ScXdq2oeJRhSvCabRRWKJShOf+rkPRLxYa89klo6q9r0G2FrbOQsjm4zYHYqNSdtdz+MhIRtzLQgXxtQnhwZQrLLZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB5720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 20:54:13 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9275.013; Mon, 10 Nov 2025
 20:54:13 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 0/2] 'part name' subcommand and some robustification
Date: Mon, 10 Nov 2025 21:54:09 +0100
Message-ID: <20251110205411.4075351-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR05CA0168.eurprd05.prod.outlook.com
 (2603:10a6:20b:496::15) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1e9604-2a10-4385-ccd9-08de209b4de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7hZGcJ110p4nD3lDOvyuBf11PHL4AxUp/wAMUSyEZJbX+6PPyNeBdyz7AEIO?=
 =?us-ascii?Q?yHByRj/9ekIccjrf+5pPWBlWo1AzcaBQhkoFJ3nOEO+GCBlRjXa/S4LLsKPM?=
 =?us-ascii?Q?BGPx6JLKusLBd8PHN88+OUCuMEAJUZqDMDAyh3Tpd/4fZZwL1eyi2cwM9fwo?=
 =?us-ascii?Q?ZQUNf1URKtGmrCn10dLShMich2r73etBuXB2bJevQ6j940wbFpr1WyXzatvM?=
 =?us-ascii?Q?NsXe4F+XjEIlD11UClK8FxyZTouPEc+4cHcR6ze/98HUxch56ysAEs/WdkQJ?=
 =?us-ascii?Q?eA+w+aidu+jizPaB5InuviB/z3+05ZryP9OIU+g6hN8SjRtyzy1nDas9fyy4?=
 =?us-ascii?Q?qQsihIjgB2T+61rpLedEKYWjCgw9CtvejaHBYdxyx3dVVWSdkZij8X6AUWbt?=
 =?us-ascii?Q?yL2r7hhdxh3Do8rCMn3d6HQL0sZE9ZpJt9OUQ3Cjx9u4rFdj6aidb7MrX278?=
 =?us-ascii?Q?kZYlCnlU7v4SKFd+zwohBn7G/ddW+6PAwpPezO5TS+LOSKRimrEnY9SeFnu1?=
 =?us-ascii?Q?v08KfrnLaGbE68LCKpWEGZePmCo/ur/3yBVg4AtvkiopaNUvlnS3gcHuCFwZ?=
 =?us-ascii?Q?7bunPivFkPlJzgq3ttqicvxN9weaeRJX9aoUO5El91sEm6fAW9B0MUvoeCTq?=
 =?us-ascii?Q?28lILH18Xk4g/p2862ZH5kf7aD7qWaXocZLK4SfoAV5m4TrWv2Nu0doZLmWk?=
 =?us-ascii?Q?AT6FQtcnc3QBdGUyuP7SIfEC+kc1LAgs2+Ju2hTrQ2I6lCHQlACNYQwG35Pg?=
 =?us-ascii?Q?8+f5i1oByVUpPnbU9SfIQqzA5lQ5/qAyBOhtwsiLj/4Mf5iAm5Z3sFU28fRV?=
 =?us-ascii?Q?mkjwfntRDhFcVKH+Cg0hPtNPvgtBzcgrkHuZvPlYP9/7HzRLSFNuh41dVgIw?=
 =?us-ascii?Q?zij3/sIZsvmdyiRxnQSLyk7hbzte0jp6Av2U7l9368WoaLdTTyf5trDsdk/n?=
 =?us-ascii?Q?k3X4YyTuDQBTCn3spfFtgRxrpB2AciXyFltpBY7GHuOw99zLWfEIwzZ/Rs22?=
 =?us-ascii?Q?4dWAM0xHpBTE3puy4McPzcUaKrHIC7bnKHcEliCfsf+FXTKBETPZ9yGDucmi?=
 =?us-ascii?Q?h38UX7pXJPt/Jks8aqf21nceMhFawleVQyGcHcaqUSr9Tn9cKAtZJfRU0zX+?=
 =?us-ascii?Q?8HdHm4VNB+si9U+3EbNDmqvF8LYTF1p95Z92WitCM5izbDAjQEJ65z7HWLjU?=
 =?us-ascii?Q?AePny+WxN63Rs0f2Kdy52M7LWDf1g3//kDoAwH23aRY5G1iX5G8inE759noP?=
 =?us-ascii?Q?XorfIEKtgLQRuTkMnTJnLiJa1U5TLSm3goxBiPKVtcP7GYCk5crYO6qpJlPJ?=
 =?us-ascii?Q?AbKePtC2viaYv4C0tIFhVE863F+m/1XEBGOVa3tGgqv1+T/Wv/hNzl/vq4Ye?=
 =?us-ascii?Q?V7EgrlYZCujGuFeyxiECPdWAR6J9qcAkgmdvHn/WCAmMFMJKvb5Asb3Y+hzc?=
 =?us-ascii?Q?Cbg8VvSxErgVN25dveYrT019++l98fBIb6YAhHu5h4CGlfKhCQSZ3aaBBs0G?=
 =?us-ascii?Q?r+ncsyEsbXJY3g9gcfndt7rZEMuQj8lULUE8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KO8IvIES9W8pQ/+LysDxHyVBiivrj6jofoiYNwx/m0J3QZ1lcWn5qbmT2qlv?=
 =?us-ascii?Q?2pA7RGnZWeelG3/gbzM/LAYE8TbC7x6nnVUXty0Lh9QHiLQ2noJY4fzfVtO1?=
 =?us-ascii?Q?YnjWGDD4gvXhoNveIy6Euzz9VvvLsPNVcO9WMUwYhQGmJGS4Vmb7wUjM4rtF?=
 =?us-ascii?Q?J8sbQILcX7z869f5EF754hm9f77x+RFfZFW0rhiXlYBSBbbR3Q7fQI6Ayi9J?=
 =?us-ascii?Q?MMHZbs608HhCJLhDTveu7YY3FYP4AgNoFpDYjQkF8IhIz9ogy17urPjWSeUv?=
 =?us-ascii?Q?fBB4ASKaiY1m6S3x4ReVr+iJm0dvns8K7eSk9yZSDdlgeiJA98wwdgrTNg73?=
 =?us-ascii?Q?45eFS85P0r8eHvRWcB1N2mtlRWfWkdhVO8oOu7mB9lM1XUvDkfwuThsbKsK9?=
 =?us-ascii?Q?CLRAY8/cQeWmaLsd96Ai0/DDK3srhMt6ohKMKKkJSoHQMvGSlUeNzRF44bcw?=
 =?us-ascii?Q?NDhPRyCrG8y9d0KRa5YY0Xl0IIFruw2mMs64Jk5lCnD09JABg3KBtfw3WWgC?=
 =?us-ascii?Q?EL4s+kU1u5Htq8IJAhkP/50CNCmY9306ZXBZ/ERSIRMoNopOVHfMRwLWUJGz?=
 =?us-ascii?Q?rlPueNHefinLyb9QVgUqPn5wPL5LXmLU+9lkQJRz8A8CMLgg8/Uxo7S7VWsl?=
 =?us-ascii?Q?+XKpnBuo/LTmlN6PRamiNUBeUe2jgUCpbC32V1KKmIj1O2Jiv1rLE2CiQeNc?=
 =?us-ascii?Q?rli0dxFLylOmMlcrPHeJ3yB+FXioU0swZiTNd9GoEleLsPHPl5HrZBWpPyUt?=
 =?us-ascii?Q?GbN0Nx6dZpPzRDAg9OqPT2mB7WcBypyjFZqnIJiDtxAeG79jTp9XkkxxoA5n?=
 =?us-ascii?Q?ZuWCp8tmbBsMYsp2cHTXgsWQKAseE0fXBWoXX70wsFktR+RzfHPS7O+1Er6C?=
 =?us-ascii?Q?zqhuu3iVnOw4JIfJ3nEEmteKBYggdmpa/NXQhAquCPkQpXi4IDO/Jd0VJCIt?=
 =?us-ascii?Q?MOm0mBQj7a8KgP0/fQ/MV1uPt5RnnwkGz0dNTYVH2SVoHG4wM8kP7wYxa5PE?=
 =?us-ascii?Q?d0ZA0dD5RIcDUUCc8XxmnBeMvZ8XPKYM8jt6wYDlEbWJk1WnLZGmT/mLObC9?=
 =?us-ascii?Q?okc05WwqVsK87M0D176szN8XqZMMJneuIFZsCCRKqkpd/mhj2Gi1pJGM4EjW?=
 =?us-ascii?Q?5LXnkBbltVjlOJtfnUdw7inmdMrGqNoG7ZVINePhUsJ1W+ZZ52MTZ556tNh6?=
 =?us-ascii?Q?c7Ih/not4CLuGvsO5zpMw/bdBETaF8qQmz8uVACOJAkrpdzSQAr4KIYNUO4K?=
 =?us-ascii?Q?SK+ixERGMlj7bBjRyYNSPjEOpc5GRLxJRu0FeoV5IOvl11uwNGRfJN6yE4yj?=
 =?us-ascii?Q?PZ2lXCXYSQ3DzYro/cWbgHuvM0WA5bNrX3Zx/PpAG3jxKZzVGFr+4nOy7RYs?=
 =?us-ascii?Q?KTKdeOrh7k6GbQ0KO34RS/oL2RAaQXogVieF1DeygomZl1kc5ZRH+fQU1mnv?=
 =?us-ascii?Q?H6gS3vMEdvmtV/m0f68hgdsVUoJe7Z+gcJXV3x6WldYgMJHI8hE5PkTa1Kih?=
 =?us-ascii?Q?3aqmBHAEvdbSkuojGULM2LwRm/VhpH5n5o3T/j0Zy8Rd8UzwzqXEOXt8mfCz?=
 =?us-ascii?Q?fdkvgx97r6zbfEpcfJc+6Wn6kJbGe7QPnVQ149yVNSvvlc8ikXhLkSfZ2JTS?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1e9604-2a10-4385-ccd9-08de209b4de4
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 20:54:13.4336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVDQ7gPNu/AKPmRRNmeh8zuZ1uxUzPXtvnGI3AnsApRWsHjf+jEUH0a52jG8XHC/e+tItkncDrS8nqf7k+9ujbhen4SnGZUM3mhzkBIlCZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5720
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

Implement a "part name" subcommand, mirroring the existing "part
number" subcommand.

In the discussion for v1 of that, it came up that there's a bit of
inconsistency in how much and what one can assume to be initialized in
'struct disk_partition' after a successful call of one of the
get_info* family of functions. Patch 1/2 tries to consolidate
that by making sure all ->get_info invocations go through a common
helper that at least always initializes the string members.

Quentin, I've taken the liberty of including your Acks, as the
incremental diff in patch 1 is quite minor, but do speak up if I
should not have done that.

v3: Make sure part_get_type_by_name() can only ever return 0, -ENOSYS
(in case ->get_info is not implemented) and -ENOENT, rather than
anything that ->get_info might return.

v2: https://lore.kernel.org/u-boot/20251020121100.1742812-1-ravi@prevas.dk/

Rasmus Villemoes (2):
  disk/part.c: ensure strings in struct disk_partition are valid after
    successful get_info
  cmd/part.c: implement "part name" subcommand

 cmd/gpt.c              |  4 +--
 cmd/part.c             | 16 ++++++++++-
 disk/part.c            | 63 +++++++++++++++++++++++++-----------------
 doc/usage/cmd/part.rst | 13 +++++++++
 include/part.h         | 16 +++++++++++
 5 files changed, 83 insertions(+), 29 deletions(-)

-- 
2.51.0

