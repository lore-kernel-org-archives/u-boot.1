Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B1DD41C18
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:11:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40ADA83E16;
	Thu, 11 Dec 2025 11:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sgj/rNZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84192839DE; Thu, 11 Dec 2025 10:11:58 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67C8835B3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 10:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYnUBDPLeE1ktFWLHJQXxjTHTNeQhLXvzmKv3wt89+N6mKXKQ5vWLPmE78ntam/qqY2G0Q5L6+ZpFdtxwe9+MCcMw9iwe0e+40oRna4QXJ4V/Cz1Q/ddS8JFOQolQjcX644VnSuUM/npIu5xbRkC8+mr/EfUfhvOjFjuIfHQs+wuCKCRoNaul5w+f8dttlzcxhNlmhLzegMCWBQoZSpty0AW72umvTF058ObpzIKI/LcC/iIwe0KyQJGtk+VUjWoPlopZD7zOflz3unO+ziSk0qCSizVXmiYp3Qw1uhuzvH4m/2jsnpKN2vAi4MBwEdy4kOKOn8tmtORCm4k/HxZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPsvU8Lha7TtNlLXstS5cS7XCTBYP+/efUdHBdtDv+I=;
 b=R2fbELlTCpKaQrNOiyNnLcXiYu7J4V70gOuyQAlsQOusaCSdqqxGZz9cyQzkQPz02+WISaurt6GNgE3XE8cj/zgdWhwnfvuq05S2OLQ3qTUNTcT1R8HbxJbmpsCH3PeuBWEi+GEEHfd2GnxbuLSntzkaSPf4OQb3k+UrvI2uwOZATjYOCZb13U86pymFJkQ8rwt5qLCkaTnamR1yFv2k7sf7M6c7fjnykfRBibnZJtBjO7ogTqJUKF60yzsxokS8py6tY9LCbCj3PELudjV8SNTGPzwfsU4tp5eGhjk9dvWYhSg2hVaiWkK2EAM9Mxs5xLH4qJ0vjDXoV6rciqBgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPsvU8Lha7TtNlLXstS5cS7XCTBYP+/efUdHBdtDv+I=;
 b=sgj/rNZMjA7jAf3/KfaEKayRQVQNRpgrB9fmhwz6EvCcgS4CbrRG0aa51VmPw1saatTKvqOgyy7QndB2pJ0GetidCiS9egFPCdQbpEMcFt69MfOkJAsbdFaXz8MbSSsQJgX5Z1VhKGec52r/C0iv1tsY1nGqmBRVX9Rk6J4UpgrWe2gJhrQ3PLc/ENYQEgknb5FBCIwMHLahV7THt/B2gJ5CiaslCzo8fM/KcjtkWXlCNTHbc3AMwOri8jbBSDfNLWMjuUlDznlyex5rEgRyOQ9AODLrv0pjOUlTOspuGK8Glw0hOx0306XYCCMAwCLHXRWtu0ockLCUspJAo1j7Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 09:11:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 09:11:54 +0000
Date: Thu, 11 Dec 2025 18:25:26 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
Subject: Re: [PATCH v2 8/9] mmc: sdhci-cadence6: socfpga: Fix DT property
 naming convention
Message-ID: <aTqcFl-L3RygJJnZ@nxa18884-linux.ap.freescale.net>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
 <59dbf39453510052ee1bfbbb3c822799e991c00a.1764760325.git.tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59dbf39453510052ee1bfbbb3c822799e991c00a.1764760325.git.tanmay.kathpalia@altera.com>
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b656437-094b-4b86-b0eb-08de389553b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o5lzpBP3v6eXKpruAaaoaBP9YudB2ls5FeN3gnYfNmmeyCZTuLAQONidj/Qz?=
 =?us-ascii?Q?dH9kKkBpqXmSpJuGoFFIzbrmoUdvHlYL89Doc+1K13PAhHC23KU6ywwaMwHQ?=
 =?us-ascii?Q?SWzDKRp4XYU7EEn3dx0/03pSJjnwUWXq7/xxGTKIjp9JewQZ20DLjPllUf2l?=
 =?us-ascii?Q?QQET/5s1OM2gMBNnKXIakvvhnV2FCEHYKbcq8gkZS64AuxZP+8YlIitjY5Q4?=
 =?us-ascii?Q?kIkdiwV0fibWz8aQcp6lyxYAoUvoiZx/wlTCbu5WgYOLN86kY/hp6BPy76aa?=
 =?us-ascii?Q?D07QJ/fFBNY4eoQODhWPceIaXQ+KZwJzudc+EN/o5Dj/4gWP/igwSfEpPqyI?=
 =?us-ascii?Q?lN8VZzJ6YF5tfVa+O3kZCbn6WEhTH4XBBuhZtcbgFnOG2ayE3lgdinWg1G6m?=
 =?us-ascii?Q?z/mAEubDu5u3n9J4uxjKXm7xzA5wW/vaUa6lqkaFNAigc9gaHQ7yEvpdT7FR?=
 =?us-ascii?Q?fqJ2rToSKuXs+uObuDl415SUm37yMwvofvZZjONb259N2htdzLzoDNUkgeiy?=
 =?us-ascii?Q?tn1ZT6keOkpDXZAt0ioQn97oVvqWKKO4JK4AQblMlZvZcKqJ5zkBA2WDrb3I?=
 =?us-ascii?Q?2qYnjXhqrERaORqbxg+HrsxuMyWkFHHCjU/SUcWUgvfXihAxxx3+YBH1DBkk?=
 =?us-ascii?Q?3FB2vFIJ3NfinJR1mBJWLnDxmyskndzzOxrSjAlnqF23165OJXkyuHxc+txF?=
 =?us-ascii?Q?F0qC9ODUVtmguKhyRatyDa/bNH6y8p4L04OKzD80eaGlBB02AWZxxpEepdp/?=
 =?us-ascii?Q?sAPWT8o8XuGBN2/MFL0MnVP3uLNC9cu5R0mIXbuDN7KJup1DnxOZHLx+81zw?=
 =?us-ascii?Q?ib3G8pnXXSMp8iothCTyY3Xb71jKcf5PJmZTDbw/pGe97vIZjLOwtnVhEGch?=
 =?us-ascii?Q?Bxmw8klg2nKlBq4pmyvsDAa9ZsY2HLF71cOvtgA9od0uMm/yzTUe8+LUlfEV?=
 =?us-ascii?Q?4/HUfwzDzBuyDvFZTzBTuNHQdqv3+6i23jIce3oiX4vRRf+sqNQW2zSsSR0w?=
 =?us-ascii?Q?iQJc4e2z6ke9KujIkYpeDg4UPuoCoF6wNmJowalApOV1n/501Dgo/iAoZvYI?=
 =?us-ascii?Q?SvfJ2x7+kQ2nU9LjwrRGhNwjNxBys9HKYSwl9dpWF3HHiTbKd/2mixs4UOrK?=
 =?us-ascii?Q?opZRsYYu2QYDU/PyAwqcyrXuwixOQHi2ApGyiRz88AKG5rNGGTLNW4KBZmVF?=
 =?us-ascii?Q?ng03OteRUK1ZPtPIijwbfLcrA9gJgbhnKta6mQLoKJS1fa+EYJ+GhfKTv4Xt?=
 =?us-ascii?Q?shxP6ue4jUxGw36YD1zfzveD4E0Ok/U1fuHQGay1W60NrS933QbWJdSsWR8g?=
 =?us-ascii?Q?x8jjZ8vrmi2MYLhsLA552t2rgq67VgPi/lBwKe9oPkpl+QEeqzgf+502ii3K?=
 =?us-ascii?Q?1D+p9U2ink76ERojRYndrZRD3cWFwYQTyUaFHE5EhvkZAhDXldn4l8njlJeJ?=
 =?us-ascii?Q?IggWKMIG9LkIchndwwJCAFqhuLnyxBBmjLMIusA82XVXgQuW5xVTCwPL1nY6?=
 =?us-ascii?Q?yk64B3hlewwMkx//POJsYs/CLsgB2krv4TiV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UuEFyc8B2rR1jRHTCeCUI0fwnKXU+x+nyVI7o7UgY4xl0Ni+H2b3CwroQ0Fu?=
 =?us-ascii?Q?M4C00BBK+B2Br/cfSdsggqtmwlQKi4ZJUfTMgL3PUn0mwVc1bOaW6+zcu1ir?=
 =?us-ascii?Q?WOFPDlUEb4ye7ZZWVVXwqqYJeSOPxQqdMDwB54iBOJ8M6RjOLAAr1ezYuM1t?=
 =?us-ascii?Q?Sa2bAIZCP1u/qzXvZyoeF5QgRGVrEXGhizPJsSO6ryp7cfw0lrljgR7V0Nr7?=
 =?us-ascii?Q?B8KiQNXP2Pg2m+M/3D8iGyBMj90kaIB4fM5LwDSrkFUj2K5TqvUdQo5OgFJs?=
 =?us-ascii?Q?VsIVt2Vn370XBOjg+GNf5LKCSO+MicuQYqUgk2X5lLhO4lyT5Zu0Bzm0hgAg?=
 =?us-ascii?Q?7Yt2agdrm8aqYARQx8lPV+GTPdF41ErBwsnl7Yg1bjmIzdtoLMUcefjBdgmj?=
 =?us-ascii?Q?HrC/8cu8hwSngfnJry1b8y0uAMTPsammVW1/ZPA3TLU59Q4sBKZv6HjwsjsZ?=
 =?us-ascii?Q?dukO5A24sxD+z9UCbuTZpBicxufLMkkqSCx3L4luOSNL8TqBNKiRYOT0WDf3?=
 =?us-ascii?Q?qc3u5thW22WA4//NudcjH0euSQASTWjCUJSQSjtFa8VqeqNltrg8zCozdDxe?=
 =?us-ascii?Q?IICogPfjhD7zGWqf/tCSPy4GThGPiXdI4fHYlTYraUptnmFgPTUEYqeHNIxf?=
 =?us-ascii?Q?NkW2dFWmSLghlKQ8vw77AuajhzrqosgD2WKRJmUVzrMOnEqQKyEXIhlPu3k5?=
 =?us-ascii?Q?vwcxDTeij9vZJHD0Wg/MgwevJiYvmZPVzXjTX9xggTp5LJzDrheWm++A/AXR?=
 =?us-ascii?Q?QHXrBOb6spr7WPwucpmKgJYv77ZuUs6J7DML7nTjHOeG3FFkGSyQL4MMRQJM?=
 =?us-ascii?Q?SkXocGqfv0Xxhhr1xL14dUBY9cNIPZ1N0YS9slVXvGH2QIZX6zLgMuZFK/x6?=
 =?us-ascii?Q?ko1jKPtwo6H6ws78MEpwCY/EbD+BS0QdLg330yuMoagQa7Ib7ZQz2CxH5IC8?=
 =?us-ascii?Q?Qke0DjjsPIfGAAeIf3YqBedfbM9Se3KJ9yFqg99kcMNquuksJztGTVsQrCjD?=
 =?us-ascii?Q?VsPE1AldmLLpcFnjZnqUJHuhsfnajxLojr1vKx//g+cgljjDDc8n636tuGi+?=
 =?us-ascii?Q?9I3hFXMV75KEZVj6+JFKYGSN1JQx8OlsykkFYgtrVjvQkkr0YbCiWp1cgDgx?=
 =?us-ascii?Q?2mRIfkgROOAFhebTXKdWyxiV459Fm4jikPi3NLouEj6BBLqFTqmyRw/fm7nO?=
 =?us-ascii?Q?YnI+sab/5+X091tjhJ6ht1SMUSiUqGB/DUaukTqsg8JC65W4mp6FEvKOan3M?=
 =?us-ascii?Q?o1ZWHUAWB2blENvLBg+78UhxD52fxtbxuz954n5LscBtRYqubxPQ2Winn2xS?=
 =?us-ascii?Q?45lTjGpy84uKbJ4iPTmoYf/pnpL39bF5cb7aNyyhjEumHSMZjSi0xOHdNtrW?=
 =?us-ascii?Q?Vla63+5SrwT4pgoyALKETeIOz+bsDm38tM+i+eFDSGFL2jWtuuYinlvbAnHo?=
 =?us-ascii?Q?Tqq8X/6ioNitCpKkTXChL6DfAVLKOnt8tobRU/TdPu2NNpp5b/tpKIrZ/pEN?=
 =?us-ascii?Q?TfysdiCBXeLJk8RfCprUkMm11vp6jnrFkad48754r8CsWrF8P8DIQqEN4KUv?=
 =?us-ascii?Q?wlYjbUQzq4fJoROidQWvU8EgMH+kKq7S7MjdFybY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b656437-094b-4b86-b0eb-08de389553b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 09:11:53.9899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B48qRyF2idN5/veVZ+PP/XznPHE4DnhNrMx8mPLjKU6SE7R/7Jgk1LdGZB4qIiSnTHLNrhXAWnJfbquyuWevuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

On Wed, Dec 03, 2025 at 04:21:38AM -0800, Tanmay Kathpalia wrote:
>1. Replace underscores with hyphens in device tree property names to
>follow the standard DT naming convention. This affects all
>"lpbk_ctrl" properties which are now correctly named "lpbk-ctrl".
>
>Changes:
>- cdns,phy-gate-lpbk_ctrl-delay-* ??? cdns,phy-gate-lpbk-ctrl-delay-*
>- cdns,ctrl-hrs10-lpbk_ctrl-delay-* ??? cdns,ctrl-hrs10-lpbk-ctrl-delay-*
>
>2. Fix typo: semmc ??? emmc in eMMC SDR PHY property name
>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
