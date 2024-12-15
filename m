Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C5CE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 01:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000A580092;
	Sun, 15 Dec 2024 02:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QRuszdub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 378438006F; Sun, 15 Dec 2024 02:01:51 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B7998006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 02:01:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAla6YJkyEXEX36PnyjbtjwIkAxqExO/OMQsB7Lw14XFr8vTqgeVz8V5TdoseFdKiRBYcu0FFw1/z6QSvgJGpXJpZrSJdQD/9OBSj2jiTG0rnUXgAvLya/BYPdccK2OXbp+gUEC5Hu7GI69Hr3Hxf3QXZxZy4+o+m5byqM68b6GCw+wkesrgLF5ZpEoCCwaJBlj9u9oiJnipYnsSoyrrVUBrjGnyjOIDlzgQX1uM3nd8rLckOYTEXv1ipf331J0YWLDTcfxm+Lb8k80vxVu9OO59lLoZs+b0IyfDzH9zmFq/QycpBY2nW2BiW7yKq0WPJA76h0Qhe613igHhDdXmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFv7ttG5varjN1eI6z498DY/eO6Qljc/rSPpsbfoQYg=;
 b=gD5wi8hI7kRg/oYPZlIlw/Ca9lL4TnIASZAaQVOgyqh4OfaKvSJ6iXbqIKp8tW9Z7iLwzqiGPRG+tndlZ8+gYec76TiaO8bwTJpwE5ToU8WhS/B/+iwEfccUiNSY1U6eKmJfS4yystOSeCecPCh96VY6GrlVJLTUk9rELLE9AO+eSZWf0oGn+WFznkdsoMLNlx743Y19zkeS/9/fb3mUrSAaW+RCXCXhgiK71LdbeRqot6gVVbnpO0o0W3O6O+UHFq/oVcuzVW/har/xFytjU4QtUDG09K4WnjRM3MK7kjP9pe5sYBXTwsOFU4UrFG07YHvjO46mpbp4BVQGXa522w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFv7ttG5varjN1eI6z498DY/eO6Qljc/rSPpsbfoQYg=;
 b=QRuszdubl57aZhCvyugegLIHLLsXrw6s9+zHJVwvDa9HUJJP98hLPR+gCOa6DsvXbc/6bX+T8KpN/IuDb7+kg2ZjczmjEdX5Ve8SufLBcYXJ3JPmZuaGXUM4Py2T6HaYKkqzky4O5WS8waxb9IAlOII5rpbOMxqvFSXDwn4nxCEo+x1bLl1vVXtn3dHdwA1Y/LVpgpTCWLs6eVX/nx9V68pqiahJWxe3sEhN66H1J2uXb+cQTzyy7erts9Dw/Vu4E97WEfmvvckB4KFjtgutylLsqSb6xvzjXXRiZcdJOrFlHU8auOuhhiJZ6Wy98XmYy8dNCyLzd7iNIkE0pmImBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8307.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Sun, 15 Dec
 2024 01:01:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 01:01:46 +0000
Date: Sun, 15 Dec 2024 10:07:07 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Shengzhou.Liu@nxp.com, trini@konsulko.com
Subject: Re: [PATCH] board: freescale: Replace invalid usage of sprintf by
 strcat
Message-ID: <20241215020707.GA20989@localhost.localdomain>
References: <PAWP194MB2055C82705BDFCD5C0C4DF8EDAA42@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWP194MB2055C82705BDFCD5C0C4DF8EDAA42@PAWP194MB2055.EURP194.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:3:17::29) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8307:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bffb725-9870-4cd8-c4a9-08dd1ca40c24
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?abgwgLbnMVx+8Ii+jvizuvGjhROfX6GQTymklPyv1P27iakM82MHu/vVca/z?=
 =?us-ascii?Q?Ia/z48AFPgihyuoWYbGst0fvEdZvPJLwAvmdmRglLtdePgIWrHTJTZRoCcXl?=
 =?us-ascii?Q?hMGQN3sr3OmKIy0QMbTS+0KNOAK9WhpJyzLyTTojW1LRC6s0eOA3xvCM1+cb?=
 =?us-ascii?Q?wVcA44nQgFPYQOEN7CyTAvmSp8lQOxODGz2AVCFquKu66BDLb5Q6E5Af6c5U?=
 =?us-ascii?Q?I1SMiYXHbe759ovxd0fW6Tf9oRh/41SL4uM650bZITSZLq/yk4LUv6l5kdL9?=
 =?us-ascii?Q?kBWOC9cIV2yt6tykZo11SQ746i8QsW4hv06mHBg7gCKTuce/y77+/W4d1YLi?=
 =?us-ascii?Q?js85boOefmsic/9OLPSweNkuxV33EYaemhIVPkYR7ifcSoUfteM5Tytrf+7x?=
 =?us-ascii?Q?wI9DU9ljXlRAX4o4scXgocprn9Dge7YxeuxaFejpJL3y0EtexpTUU/wmiHvp?=
 =?us-ascii?Q?fFh1bakRmVO1I6lGs3+GX+t7W4gj9PMGDFmh6RyzgqGIUmTj41g8G/FaMKNw?=
 =?us-ascii?Q?QqbdIAeuCzPxWMlj8C2ATJrXJHiuWdVChJMByPSYLGY14OrBN1/FshDCS/5V?=
 =?us-ascii?Q?fiRGbxOD8Vf5SVKF0ETsOtIounsvHqDHRM1cMV1j1MzgSTw/bBgwrf2FprjL?=
 =?us-ascii?Q?H/vwOa84FuE4i9uIRYPkt+9Vao425OGDesRkhshFTPl1B7FtGmIQ0BAC3Ome?=
 =?us-ascii?Q?QT58YSVGe6h3zs4j36jeY0IhKeGuwrWoDGR5Ls2Ty9w2CoZJhjUuYlOlUZEs?=
 =?us-ascii?Q?NVNZXgMRoK/kRUF/PrINFnzCdaAq5DpWuhuCUfBzb24e0tRnchdp3LoWvYDy?=
 =?us-ascii?Q?F/m8o/fbaVQOIjHnocPw+OlGZJ32pnLpoO/GpYPUkpQ/B5Ue7U4scasE1UJC?=
 =?us-ascii?Q?kIiLhiRTp+/d3kp6FtuBp+rOAwwu8SELv/afZO+Jatsyc226fMw9yf8lHP5U?=
 =?us-ascii?Q?WOhDfh0EutNYEuGv8/qP7KCAcczNoaCNrWHDUhTtXX14M//bDel7Qhz9VQ8y?=
 =?us-ascii?Q?1usNmy1FAZW1YmUCMp85Yk0Btk6tD9TSukRyrohA4yDqdcgoJQ3te0zddJ2/?=
 =?us-ascii?Q?MjAdk4H6lmYzRr0syothfpaO6HxR9SLb5weXfqJqHOdsXB2rUQd0y36whW4Z?=
 =?us-ascii?Q?e/BdaZlBBirwgJHFGrkJLqXsVTm/tFheqCrBxxpI/p2O1sPCMzMY+CN9ahMa?=
 =?us-ascii?Q?y8KBbaFady2emzL/mQQtr8WNRJNlk/57BM8PkxyCm8ujkgIgoiFvH6Rygq0e?=
 =?us-ascii?Q?7WPMp975A52pPBkt7a3loc03UwDyB0lhA9JXaL32/b9JkZGtmX2B/3VAiclv?=
 =?us-ascii?Q?UMOJdDvLwQN9t+d4H1Vyhsc36PWwu5roaFrtkwbwCY+JT655BAjG/pYfvQvo?=
 =?us-ascii?Q?NZ2K5qIcswca+R85NS1ydxpW+gMsPGp3OnOsCCEZxFwZUmK7gtDCWnJ/jHHG?=
 =?us-ascii?Q?wKFOsS4jVTvKjsyqNcYmWedg7CNCE2pK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoFGmBVIzE30pEoRIIPT2t2Idvh4Z607ODYyGqSfbs3rkWfutj9J1ExTnltd?=
 =?us-ascii?Q?bGLS+m5fEOWWKTsQPg6KVxortrHuInZyORGHHemIbuJwX2GGbbUsWGaKizAR?=
 =?us-ascii?Q?1HTcU1Gzung/AagVvbjR4MXZnRoPtfwjgPOypqmIVWJPmgbbqwZauGVq2BXf?=
 =?us-ascii?Q?/oaqsSZ+oeAd3WgkKzyRobMD1qiJhTupPzqes+8sg1V7AnWvI1Mxoa7VGnVx?=
 =?us-ascii?Q?g9X4oXH0mg2hmD98Doa2xCvXJW5/GpgpfE5ivR96g3YGGk80XK8sxlSPnZGz?=
 =?us-ascii?Q?7mP0VOev57hqSIS45zDix8ao1kOZ1HBkND3UtSWzx4LwDgg4wPUg3HybePHO?=
 =?us-ascii?Q?WsdmW32WB80HgfXTgsG/xDNnwostbvkEE2bCvyAc2UIOBpgss8+Y1OOn8hTy?=
 =?us-ascii?Q?z7mPyUNJmn33gmD0VyKONGVbgLxDKBg5ru9Va8S9eyp99tiFZuxztzAsikgF?=
 =?us-ascii?Q?nGSks8FmmV/HVQXX7hdyKmU81TIDgn9teFHFKaLauVoFGKhJWFuXUbxBQJTM?=
 =?us-ascii?Q?k/Rcqol704x4InQ9b/lAd3sbdqPDLDBZiSj3h6hhTB1KhQ2ukWi2Fl7J2AFA?=
 =?us-ascii?Q?sIj7dCVUqHg+gcIO26sqiri0gcLgqMgJ/msTNDI0Rwtht/pLN7PJ/fnk4ItC?=
 =?us-ascii?Q?9lc2E61RCLOSXOxl7J/5zd5drygja0iM3UBEmU09AebERjHwgOUSdsRvLgM3?=
 =?us-ascii?Q?2hj/pnzwpbLfU+sykxwwnAQ6tFVTFER7dYzcOqjkG2IDFk20yP/D68AZVH5y?=
 =?us-ascii?Q?dPGiVrgha6UUILX+kwcnivFViTKi2s0OV4CbjC4NVMVVcavGeNFnF55xjNP9?=
 =?us-ascii?Q?ttlIN5yajjjZnn45GL36Rq8x53h/5azPTzgfJ0kpWWQSBdfj8R9u3zfOaC+a?=
 =?us-ascii?Q?k8xucbciNS7a7w685rAoTCUO5x5z1cULlpp9dNUvE95ViG7ELnOx62zLLSx6?=
 =?us-ascii?Q?wjjybY05uo9ol8hmYmSto99HdVShZ1DfZkViO1dxq9isqJ7kimEhImJrGNIf?=
 =?us-ascii?Q?bcfziezb7XRDKlLBSMJLUMD8s0D4yCS7RJetS9yoGwcmR/35Bu1vF1a/j6QI?=
 =?us-ascii?Q?ipAqRp9lB0WvaCrSDILQIy+Q77d7FRhhYjc3OytVCl06N7iQRBPkQSsYoTf+?=
 =?us-ascii?Q?sZ20mmetUcMxSaixrPi50qj7gVylRKiLmuDtk0j7R3e5eSR83TbL99ZpP4o6?=
 =?us-ascii?Q?V0xT90NugW78TLvu+wNYPsMCNr4qbaOCMGSATM03ESI1dL5dtTTsRoQlHOXC?=
 =?us-ascii?Q?I3gMmka0PIjFByI9QVbaN6lzqntSfEl9RSalSr/rIpYVgfbobvla+M87fbC7?=
 =?us-ascii?Q?nLAcjzNtXVr3iehMnX0psrkJDP44TCjs8Vxk3LWomyxLGR/wZcQEooJ7kq+U?=
 =?us-ascii?Q?kfXD9b24WfblCW8qhP9TyLXmYS+uozE2VgJYwq7iuEdgTB4KSZbdUAuMWU2u?=
 =?us-ascii?Q?BSMUi52I5Zsu8hK8qPdL0CvdzitInU3wLODNbRqmX1H4g6ixdJCDTYF0ATBR?=
 =?us-ascii?Q?M5FN56OAuag7tpVFQpckDsGlvw+HsfaRQiGf1z/j+51W1bNBIxUYgKeq8oyj?=
 =?us-ascii?Q?nXcIY0YCimNrZODZh7S0UajCD8AqUPoTZmXQOsuS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bffb725-9870-4cd8-c4a9-08dd1ca40c24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 01:01:46.1950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WENeGxad7AaB8qUSEjavmvv920E0p3hNmEm9WIwfdr+TY4od0OR7ngx+DdiN07aAeB4eS0xecyjGmqGPXZ+A+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8307
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

On Wed, Jul 10, 2024 at 11:37:35PM +0200, Francois Berder wrote:
>buf was used as destination and as parameter to sprintf
>which triggers an undefined behaviour.
>This commit removes this usage of sprintf and uses strcat
>to append strings to buf variable.
>
>Signed-off-by: Francois Berder <fberder@outlook.fr>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

