Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EC7E7718B
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 00:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2ED80317;
	Mon, 30 Dec 2024 01:15:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="n7oCd+x7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEC0804CE; Mon, 30 Dec 2024 01:15:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 157C98021D
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 01:15:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nb52nLK54pKq3RRJLMb+7j2f/wdodd+C7z7C4Dc/zMFPn07tnUHabNnXe1GzyaFB3ZFqWQd7UK9pqhj7c4DGB/56a7eenbNXm7vvHB+qMS825bV8zA3PnhAZB4XkgaxDAnXBcDPLhHO8KLto+3KIAfhuGoHH3o62sooVWPUtxPgMc1F2kRd2ZSTpCNPi05xtCDv2H3gjA9i/N/4LO+qRJdeHw8TbJFYj1BPIK7O5/mdOy+qq5rZvAGBIu9Im9m0i3zJONYODHzM1zezGpGcSurdhmKipTVZEm+q368ONdztxxdYemGKKenAtiN9/95aWNQMcWRUA5XBh50BYzTua6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGxwLMm7/vWXWbkbZbU2uJpLjQLurfgQeaYfQpIiGu4=;
 b=aWkFKXsmcMr4FVMjQFPn6Lt6vHhfW+PW60norQp2pxNffW9oXqSkYBIG7C6LxFsKeqvHHja32T4clhFDjAthoWfNNyW4ZfJqrLX9WqbQAxEB+zVuVRbAc5L5/PhYEomFJ2HArG64hRKFp6r+Qx0LxQUd/tw5KaSruLaewmgsLWvsG8/chFKmZ6AHBWjHXNvnKL/OlBq2bLkIwBs5rJB952slm5+kW4kWmIdGnizonMLE05bKNe7X/QRGfS75LDhAmVRppGX5ALec9vXG0qPxnQPRtcCaX9/U4qg+B5X52tUtAu01a0CLk3jkXu2JPJCVc1vjN4btR6zTAYE68PLljA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGxwLMm7/vWXWbkbZbU2uJpLjQLurfgQeaYfQpIiGu4=;
 b=n7oCd+x7mQ5qgAQNf+GU4YRwG82lbQ2BFxreNgZdFNapPuqMSAgSZBzb8Kta+Bdbz+aA6qZbEGyr7CPYSMcnhM/iZEOp2AqE31rpFEAT5XE2+V0QN2uNqDe3yLPJNzMPL1isZRdu9fSMm524xT7wxx7ziKtGpZPBZK7EHr0WPs+yJpjFK89vTyQfUcg/fMDzvQ5+Ny64YXtYDDsUevFWOEcMdPJyrNPsEe6CFQtkqPZe/Cy58wjGTKdIb153104IuctCGKEi68n0UceIxnn48ngZ+qETRUyDFl5Be4iYktVP9uCYUNFAxRgzntF62i5L+v28aKnmEzgbtgfrjF/x9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Mon, 30 Dec
 2024 00:15:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8293.000; Mon, 30 Dec 2024
 00:15:08 +0000
Date: Mon, 30 Dec 2024 09:20:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ayrton Leyssens <aleyssens@idtech.be>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: iMX8MN: SPL not starting U-Boot
Message-ID: <20241230012054.GA28662@localhost.localdomain>
References: <VI1PR06MB89261150B5D747962890634DAD0E2@VI1PR06MB8926.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR06MB89261150B5D747962890634DAD0E2@VI1PR06MB8926.eurprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c44ef7-b77c-4f52-8fc2-08dd286704c2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uPR/ZlcSCVtl5eptF6L7W0nNsfMQCauBAJgSxX1Rv5NIEu5q81fFWImY1V+a?=
 =?us-ascii?Q?t3V7QJmt0M60vIFuKYzV5ytqfYXKuHSAJLFRTiz14pdJCO2Kj1D2JmYNoRcF?=
 =?us-ascii?Q?FP51OMVl+WjtnrEw9ensq/yzU5BJl4d68xvfX1toauHHZwdxR9m6zAIpFKAs?=
 =?us-ascii?Q?bXkgow84dIUKk23LeXthAkdGBC9QFcw6ivcB0GdfSS1ytYiCTHbbbewUnzrK?=
 =?us-ascii?Q?D0JHN5m9ehhNRjNTtRtUBmHsfOCYAabnac/ryaNmNNixy6SWzW1fEevZPztE?=
 =?us-ascii?Q?GUC+fmqCW/Gd0gNETOnW6Cxp+YULz58Uapz9bQSfsL4sqIP+awjvr/ZV8WAC?=
 =?us-ascii?Q?dBX9F8ZUhGdo5sbQx0lGqfzJ7poufZnDshA9Gh469YLi9IEWDFVbz6+pQpdQ?=
 =?us-ascii?Q?KMXFtDOHFxPmYVFsxjDdr0B/LpTBSb5NeeZfPqXdLUfiaQtO7mG0CYZJG6aX?=
 =?us-ascii?Q?GjbmQ/8ZMS2ANNiWRpwddW26OUQ4GKJCtQX8cZEu7HG4PBdSYn+5UFPGHsiw?=
 =?us-ascii?Q?llkAxo1RjJyxjcik047HB2rEx0lvxWbTgn7Fti4k6SPKkHu0yHhN06le0HtH?=
 =?us-ascii?Q?qJklZewPrN1bXIvRIYQaTIeeioOR+SgxYY0jnsTFQ9fdVw4VPBpuaeab7w24?=
 =?us-ascii?Q?Uqp5VLBvofeu+BFCuUByT+qXAt7GIG6bRjTdxz/zYyPXE5cG26QpQJDWi8pU?=
 =?us-ascii?Q?HrThwbJQnfGm6EH6RRPvJrpkqnTACaEAWkuZnGIT/J4trZ8RWVzgtsWFS/hS?=
 =?us-ascii?Q?4aOUH/0hARiOBPIis3hazNLs7ICpgb9LtBoMfXVaVkpuuSRqwnHCqlK5Mw62?=
 =?us-ascii?Q?ckshmEwYTv4eR1VMif+Cvj5ipiThA26VG7zsPM5tMj8c0HaUzUoBTE0l+Xt7?=
 =?us-ascii?Q?As3KUh2FSOLLmia/SsLrt9uci7hlkNz9iSbYkC9WkJL53Z8h6JgnKZX0uMyI?=
 =?us-ascii?Q?IxRb0KdXkjM9hoIMsW9f7FZMDWNx8xrXDTkXQzhQmCF8ywUZ1R9pr3exTOp3?=
 =?us-ascii?Q?+PUwRg5BYnGrkl00KW/ECkh+8YDEPN8e+J21e0iMexjW0TUJIkQqpffKwfw7?=
 =?us-ascii?Q?Gfw7lfReepU+IB+VKjnaDsfv3srMeV0vJrbB/SjoqSQ20OdnRZlPkV0VgPzx?=
 =?us-ascii?Q?g3JRX4Eb9KHlHhgG3ZZa8uDSI7qcryD8Ntu7iveRaPI/FD0Rlgp3D3/cjZBT?=
 =?us-ascii?Q?Vv9KuuCvm+8isKzjcI4B0u964se5F6flXXwZDjXV1/8PH4w/wlv75cTZAF67?=
 =?us-ascii?Q?3X8gNUCGhg4Ppt9AfgttANJO8lUOezUEneGQnD2Y0Mjf/uy/75aSsSmvjZnu?=
 =?us-ascii?Q?cwsl86Ch8KZeM+77xuqsgETiFHX16QzGSeDwifxgCb4VB8lZOQ3tdvSkHJip?=
 =?us-ascii?Q?dCP4bYdfM6tQ0ziBJtJS6cretOZUclVWHJXb5urWf1jB6lZlB0cTHn5tT/ip?=
 =?us-ascii?Q?HkSBP+NunV56k2XQNTuFG1rif39y9tzB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EOjEtyrqDgMw5cn4ZYcbO/NjQmjwH/5r1BaOxD18i9OgOGgRoQ4VYJ9Z80cZ?=
 =?us-ascii?Q?ZikY8ijiOTkc/c9+uPhsDrJmjtQpGgrZzuh8R5l5EWYwtodFvcjl3pfZbuYR?=
 =?us-ascii?Q?x663WAtRzva2x5EXIdjz1RajBBg/4WLs4qqbqBWSPs1XwooCKgrFVgAr3ZxI?=
 =?us-ascii?Q?fsWJwGjJFKiYsNlgeabBFPJIP16mVnu7uXxLnZAQa9wKfbGOwZmQkb9Oa1bu?=
 =?us-ascii?Q?K9G8dwq2R9bKqsyjR1Qjew5wNEh9kcsz/f+qx16WUjNjG2uoOH2pbU/+s2W8?=
 =?us-ascii?Q?pM7sEqMg8uurmR+2kXMMrddKq7+J4lZdqMWE7phMcfxZXZHyYZyQmRSVEHeO?=
 =?us-ascii?Q?e91luEr1cUmrsx97LYK3qOoLrxjBppLTkmULtOjK+ytZ1l/rBi9OinFjEjDU?=
 =?us-ascii?Q?Vw4quKiGREsEAbhQuH4I3XN9SKjQNheHiQ+k5FsXzehpkAKx2/hu5ODoac2+?=
 =?us-ascii?Q?vYlGy7P1dGRWJdVaTmbgRqyxTxjip7vj9+D09BtRLh8YxYxYbSUwxC3+V5tI?=
 =?us-ascii?Q?s4Jq+FMs7YkdboUr0g83q6vpoB9QIkTADQUniSiuwXRA57DwyaG6NY5jfWT3?=
 =?us-ascii?Q?VwdAaeJ+hRLdp6C5/yKYhRLYzVJ3fIubLZ9N+5+Tk+wRaqgP/DS2GEK0C0Ie?=
 =?us-ascii?Q?TreM18RHrCHSqT+cWDP3u7nbww0Kw7dqrh1nfNtwG7c/ZKSSSGchcuqEOd2M?=
 =?us-ascii?Q?9J09W4QXdX9vDLgBJw+6SYRh8RfM0swdKzftuFnv3qxpRD46sAYBb2c/Diow?=
 =?us-ascii?Q?Gh9IYhz7gUBpWSZ09t2SUGU1eySHjYd5j5IrM9Wgr+ZgStJumagCIQu8d+/O?=
 =?us-ascii?Q?YnQBK+f4rWa21lJhDVW4xf3/7dmTwW8lPKQnCYngojnG2gU/fJQYlAi4meoP?=
 =?us-ascii?Q?0nWCCJHYcTq9IUJ1qx2mkYvKK7X3y25UDj1ms86wmoH4n2ESE29cvFzrp2AH?=
 =?us-ascii?Q?dGW75uaFE/zMo5dgWWyJNVGmvRJxvVyddDA6V6zyRKcK5r1yDytsbOBhCk76?=
 =?us-ascii?Q?zxOnL7rVGOmhVMJScPFRJLo25uNh8j1as4LaY3Fo37KJSmqde4QJusocASva?=
 =?us-ascii?Q?yC/WhOohgvEpqBhmK1P0aeb7wX1z+6gzsZyvmT/YS5pAicXItgjRyuYjrl+n?=
 =?us-ascii?Q?VWZQVIOciD73BAQW60hdvp+jgKymfrwphXAVQX07UqQOUKDj5+Oxj7U2KYV3?=
 =?us-ascii?Q?Mrx4bZSOMSrAT5zidqo5pPURZezQmymeMmGT/r19AkUnbg20jo0jMTXpCj7K?=
 =?us-ascii?Q?1o2LfKZsIbkg8jKZ7NvZPUz8taVCZ9uhMI7G7Qr9tIzhyZzox5kTzg2UdzyT?=
 =?us-ascii?Q?pTxBXZhafWsq1GGxPoUKfOv35OscMFOtAym3jveLB8rH5e367G4DN77dSrkR?=
 =?us-ascii?Q?kSn62Okd0lgAqx1TOrvNCP0BQG8G23spj8as50wh47CMVmNzcs9fdUqkPTRf?=
 =?us-ascii?Q?6sq9/GPElfO/Eg6yOv3/lNvL7ZXNJecflqi1X2tL2R1vG+gj56gq7tEbwp1w?=
 =?us-ascii?Q?tpUuN3MNkHt8UCMD8xHdr5JhIHNqJPv4TCbeIYFkPkGro3oU1bc3VA0m79HX?=
 =?us-ascii?Q?puIzK5sM4NDKsmsj27MixKYjIqja/pWIFxPzmCAu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c44ef7-b77c-4f52-8fc2-08dd286704c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 00:15:08.5807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g44gqThWwW+s09nfwWbhPfaZaEmE064cXLpWFA7WTmBkx2C8L0WdjeBNuaJGhczkfEZz7L8aO8I8aP34LWzMtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200
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

On Fri, Dec 27, 2024 at 10:53:55AM +0000, Ayrton Leyssens wrote:
>Hi
>
>I am having troubles booting an iMX8M Nano board.
>I compiled U-Boot and flashed it to an SD-card using Buildroot.
>
>The board starts my SPL, does the DRAM init, goes back to BOOTROM and eventually goes to the SPL stage where it should jump to U-Boot (common/spl/spl.c - board_init_r  os == IH_OS_U_BOOT).
>It proceeds to 'spl_board_prepare_for_boot();' and finally to 'jump_to_image_no_args(&spl_image);'
>After which nothing happens.
>
>I added some print statements to see the contents at the address it wants to jump to (0x960000).
>The contents of my BL31.bin are showed on that address, is that correct?

SPL->ATF->U-Boot.
If nothing prints when executing ATF, please check your ATF

Regards,
Peng

>
>Any help would be appreciated.
>
>Ayrton Leyssens
>Embedded Software Engineer
