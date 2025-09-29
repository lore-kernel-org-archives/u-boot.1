Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96182CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0378350A;
	Mon, 29 Sep 2025 08:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YouGV2Ru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F6180819; Mon, 29 Sep 2025 03:35:25 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B923800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdwww73q+3BnaS6uuPY+pbkAN+1cfMac3KQcnO0OMjwcGcbbf+K8gUSvx3vssTrPYRkhDkt2nvEEkUJbU1554dE/X9VnReV3NpKPof134FIvZyKt+0Ygl4nPEuWxkPU9rZDq+RvOyyeXwU0RDAHE3rTBC9pEDapm53fExHY8M1mpI0pW5HXqC48LhLK75wLnDVdz4bdq74WbUFrukxfhi3nw3qzlqVfCFbjrE1VYkp17eb/45752OYu3NOkBmKV7obC9GBrvyLoYCKpT6LRhwuf3MGqGgQZwRwdjlMNNeY5Bs62bdhWJvF1Vwk4QcNjx1oNoSuBV2CvS2FTjVJwGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rYMMnywYIlsAfrXfPtcN8JOtYGaLrLGpGU+Jc+LbeY=;
 b=uoS5YbkoznDIc1r8R/es/aEaSPZZPAYcdWzdzcNaZYzRME5ZepWpHMULXyiW8pbHrCFqtSzfogfxCJHORgJyg/US0WQmKAsjqaP/DebHNcHAqXF/WsuH01o78612hOxMUBCKS387eN7YGrRqf0EvBNdpbfri1+FvTKnyOxKtykjU5P/Ppu7nhysySEedB6UdT5bt/NhuoBK2PnLpyPP6nlbxs/5VhUij0xu5Tw3KloThhAh5m6CoCQJBd9HidQ9I7vhV8ROt7wn3rcLLFoxjYiyqUmVEEm4qaXyA12z4HJj0gS/PSoZhIvl46fFhEtMuR/OK0MzyyLMPaRbhEMwmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rYMMnywYIlsAfrXfPtcN8JOtYGaLrLGpGU+Jc+LbeY=;
 b=YouGV2RuVL+rzygei07Dg2chN9/wAygfe1+LPwmNC9KqUjCHxPZtVC1AC3IMUnNadwNudnC5XtfQtijOOfXRJbZJIKQJTcUwnETHu8KiCRYd/iAAHv2ZG0U10jhEQ8j0QMll7DgPNHkrwQRFoBmMpnq9eWEKb7AbzCv48fPI3ZnWaj1knLrPqyi1vAGq0JDqnhYevcq/h+yZt2e0vPBrX0RwjMf5nyh4vDb7WZkhFyZTHM0uxWhJWXfCxdAdkPi3zLM64I/mQI0YrC0m8lvl9FajeObPsr8Pk1CE5chX0IdnUQ+gkCGdl4qYpUMeZ4sIloFL5I9WD8X2y24LFWFihw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10780.eurprd04.prod.outlook.com (2603:10a6:150:21f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 01:35:21 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:35:21 +0000
Date: Mon, 29 Sep 2025 10:47:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] w1-eeprom: Make use of static keyword in drivers
Message-ID: <20250929024718.GE4184@nxa18884-linux.ap.freescale.net>
References: <20250926153148.3680967-1-trini@konsulko.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926153148.3680967-1-trini@konsulko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB10780:EE_
X-MS-Office365-Filtering-Correlation-Id: fe43f5be-2fed-492c-e5f8-08ddfef87425
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4kseXeNTPDW4Ecxdp3ilhCK3tbp4+D4+C7CGcOXLk65RFRatIppobi7Lzwx?=
 =?us-ascii?Q?Ou7zHiJajxHd/+ADX0wNKPXQXY3GbE2ttErPyfmMKO4i9UrEpzc8vJ3gEPXP?=
 =?us-ascii?Q?LnCV2fV9cmSVPDbs8fLXaBbpeXVMI4PsKRE5dUeME5ACzEnR4ubZ9D//a4I3?=
 =?us-ascii?Q?LTGCuYcatTKL5IMfy9ZbIDgUjMJKM5ydmNl/vGVbjCEaNu68xDpLted6Ib40?=
 =?us-ascii?Q?VnLfcxId2TvSYHq1CNyFJt+UXOA5CfFfDG2V015anl1xewViv3yroMXDQ115?=
 =?us-ascii?Q?Xxejmg4uXwa1r7+8k8H/F32g8BzS1qdVE7dqDP58E5/nYBMYmxzQd+x32sh1?=
 =?us-ascii?Q?ovknu0BhYrepaH+lezArkLceZsJEN6olZv5ZN281T6cI6fnOCsiYfwjNcO3j?=
 =?us-ascii?Q?7eym1sGw55+isjks63yrgejUUHi6/6mu5CLH58nUnmxVZLIJpwrn8Z1zRcsh?=
 =?us-ascii?Q?pM9/ce7P7JIv8+ZTca1tyTK7qTBUIUrc5p1T8GelMWC4hQdPKt74Rt+up5se?=
 =?us-ascii?Q?teu/p/oTrqC+7ltIO4qB/kAVGw1DD1AZnFG6st2fVBAMgb4QNnVMzxDb39NJ?=
 =?us-ascii?Q?73Yjh5Yo074h/TzeUYarp1u2n2X+mtwXYpCA7xBVboq+Nk9znUkGcSu1r6zE?=
 =?us-ascii?Q?sDN+wgdcd0SsKGrQx2ChVs3NC6zgZYVcdybT1ghpeTt7illDpFmljHo+/30M?=
 =?us-ascii?Q?Z/8KvKM2K4L8OijSVokq092ONk5fv4veGywm0IQa8OVLhGFBjyumcRI1GU8q?=
 =?us-ascii?Q?dv9DOTR//FXIsFoaVRu60QqLF1ntyJUGL2/eRI/PlQJeDT9Ae/Fi2R+rWdZf?=
 =?us-ascii?Q?/Iutli9RTKa7UP4lS6HPoejxMoem3EsvhLLz7mcToP9n9QfR4O4u1+p3aWwX?=
 =?us-ascii?Q?mCID5EDdqJwY8/TVF/dtUG5ocEsXhlFw44dy1Q+F6/DDEuGz5uj2nVm/pkFK?=
 =?us-ascii?Q?cqfoTGlpoiNv1baTLIENRcsXo8myRU81caDWJ5Y9E+ygovSst9Ygo564xDwb?=
 =?us-ascii?Q?YZ0L8CUiZCDQ9Wiv+2K/Uu1im6QJaJY7Zop7+6ZukwMfeYFOy0VQTtKnyT1k?=
 =?us-ascii?Q?3xjr0/Ezo6JNLnrT213P3odFf7Iwe9dTPNAQuGyw69cyaaTLtj8EJZ1Bfcz1?=
 =?us-ascii?Q?wExe4OmKRed5HQKJIT0lcWhkxd1oZxj+NXkMV3rKrdaHAJx18nzxejHlceDn?=
 =?us-ascii?Q?7TRURNzgkpMgwLcdG14xd2kUGY59GXGzRlpZI+U4tjVVyCCIw4VNpgCLJwBV?=
 =?us-ascii?Q?WTUYw4VlNjtcwEX4fG9LYTfRVop2QjXMLljCBRWh2Ve1y6C8/ILJdWyi45Rd?=
 =?us-ascii?Q?TRGhba241OT9aK//8q818w5t/6VeCw7a2uI2f5WCwDnyYqSutVsGXbcKn5qj?=
 =?us-ascii?Q?akveWBeFCmUbfiH9FsHrrpwyUPpcV+UGtOMP6D4Z6KpV+WisrOn9dTbPwZAN?=
 =?us-ascii?Q?N+ILE9onQAUgQvi6PnQ/8PzFAhQUYbOHva+mBnyX8U4pXmSxn7V8Ef9bmjH4?=
 =?us-ascii?Q?NaBzhNWHIK0uYxlb+7eUxh56/Tu9XNM7Xl5k?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zsT6Rq72Z93Ry+IRbzHtAro/i7Ve0bys7kpsfZiWqIlLeksOpBChlJWao4XC?=
 =?us-ascii?Q?ifWvPJ5SHAySn1LaT0idY1oTPWKekAFdjA0PWf/GIhBeXA8pC2d6XioC5ojU?=
 =?us-ascii?Q?vFYxnmjD4V/37dRvFQnj+9BR3mSjm84YRS/EyU8uxEb6OKddEVYLTRGZeVZA?=
 =?us-ascii?Q?gr4KsKoHp5qmOjs1widjD/g4mm10ixsmI98JfIH/xtw9yjHTubtaRTC2zfhX?=
 =?us-ascii?Q?Krk54zuTUrlJEUYTX4IibpdwtXLYYWJe/wiSdajCCUpMhHI/wK0scy6lRGOa?=
 =?us-ascii?Q?W+Pb41OHy1LSBwIO76bqgBcZo7BShj/LrfUoa8gGwyZBdicRnGDoJ5/l/KJZ?=
 =?us-ascii?Q?/tQ7NMlybyg52IE/iu1BJRL5ZJI6oqhYBG03nbMLcydxG1Hn1h7SyNk9JIqp?=
 =?us-ascii?Q?jGbNIhNp81IpI8rZj57f2ZTlEmcDSWUqHQmDVUssCSh7G7VuAVJf6yiewfwO?=
 =?us-ascii?Q?gTUKbbgp45CHFp8d138igSTBHE4fk1R3UNF6hacSZD37iwI4PQpgSPo4n5mn?=
 =?us-ascii?Q?iMLhVxmOfdxaxfqOLzePfMQKrDMzXrytKbKpVnHFBDl3hztZGgQYcRpB3nxN?=
 =?us-ascii?Q?I/vLHdsH1N6wrAXHfGkXTr5DlEXvNYG26g3xRkmzRYHpNcLY1faLsn2SNev3?=
 =?us-ascii?Q?mKeAMnFFvNgKbKL5lvHEb85LdUpIgB/xiWwkViqE65Pdu05BUCAdXn/7yCuS?=
 =?us-ascii?Q?0niceeH/nT41dP+lX5BNuMqMuGPbqpbti8k29pYAx4nJCmzT2bFOXCdg51kj?=
 =?us-ascii?Q?Jzryx+h0njf1Vl0TwQZduJzA/DZb7ox9rm43bJII6A+z3pTJoGMLlHBhIWdb?=
 =?us-ascii?Q?evBlHde9DIJx/RwPVC/eM3HQlAmoxrruVSzlxb/JyGBIUeWqDEASRJaomk1J?=
 =?us-ascii?Q?CBiIc00NmbOl0Sm8qPiSANpZeHop82ZeqjmiIIKjaMH+0CKmxlE4rAl7weX6?=
 =?us-ascii?Q?RgqsM7b59YFpc7tUjpVEil4T1sEdy7u0CTlTc1s7LV86Amo5v3G0LvUckGQH?=
 =?us-ascii?Q?wD/OTEQh2nGzlz5gL/4N8sZn6NzJsnwfgCBcPSST2jDUFlrjjMLqhQr9ryES?=
 =?us-ascii?Q?NGCYy0aUM51c3M+P7N4snuHkszkM6cbyDr86GTX5n+ri3GMwd/ljk7vDUF47?=
 =?us-ascii?Q?dky+VeeJeWZbbmke8xEpA1lcfD9IP6k5Cg6PLCbT9nM6YRdpygFPt2djD9/S?=
 =?us-ascii?Q?JEviEAcxPH4ZcOl9eOSlpNt7LOmSIgiWVjkPOCxmKBxXe6mGJfg6JvkzPuGe?=
 =?us-ascii?Q?2KoVNj6NGl3nAgqKq9ZLbU4HW8hkTXzEfTBbn46+cr/CZYr4D5hV3inz7FIz?=
 =?us-ascii?Q?t26SLT2L5IH8InJHWW7KYn2TWXeAbVE8pPViaVHanJwKUoRXbk6XeNTunzN7?=
 =?us-ascii?Q?uHn2zCfq+bsRJ5O9fa89g3H3joCa/nFHomhz5zZCULvk6Wern2H3naobvsN0?=
 =?us-ascii?Q?8Od9SJthPhiNzHTT1MukbltFb+aVUvQMkHMi4qw54tYgy4b9jl+EiHjqQcun?=
 =?us-ascii?Q?DtURtCCmaOaNUPGR/sF72kw1/LfmQUIKy17wVwWuWiGRKNTpu65j81RDYLJN?=
 =?us-ascii?Q?fqWPPRkrh+4X4pUgE2WhgGxzzPzTjlrFq8gm14kw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe43f5be-2fed-492c-e5f8-08ddfef87425
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:35:21.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWGusKhYnMl5HNQZ4bKOo9de40bCpCoQDdZY4SHCzKcOCesAUY/BunKxjUgJcPgWeBH6z72QsbQLtaVpuuuKwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10780
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Fri, Sep 26, 2025 at 09:31:48AM -0600, Tom Rini wrote:
>Both the ds24xxx and ds2502 have a family_supported array which is local
>to the driver but was not marked as static. Mark this as static as both
>best practice and to allow both to be built in "allyesconfig" for
>example.
>
>Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
