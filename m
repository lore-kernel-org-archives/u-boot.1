Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F64D41C37
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BE1C83045;
	Thu, 11 Dec 2025 14:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eo7W1m93";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F9683A26; Thu, 11 Dec 2025 12:32:04 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA9B8334F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 12:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5UvplzQPDXZl54sQsDgAV33qLoXPyU1Q1IV2Jr13ebSkiT+J+GAp4ZkoJgMlKYQ43cmOo6pZReyDt4lH5xPKODmdSrl1x7g/jZxoCRjbZG06VWuebAmklL2DwbH3n9osVVH3HUsr8BP9ED7ea4BxoAmQ563w+L2IKhbDTwHGp1ykvw9trtWraLQ7iiiaBac9IAZQQz7ciCypLKNZDF41CtrHo3KLD0cZehW2fvnVmQjYauwKI8c8/H4HriYhlkH7aMjukN8RCehpAWCsyZhcompWJgC+M9sNUFj7ZmMbDcsRpnmRyISIKxVRLuYk1wAxADBS9PX+V0UIt/r7GfY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nszTeHh7sebBNOKojl1G2onwfM+p02k1mbQGFkMbARI=;
 b=RZImhAe0l6+MhSuAOqx4B6Wbf+r186My44l3n4Amt2lI8lAASnPwcNxGjzcXiNqcyyiKXAshn49BfpYOYbYnNLpJXJzNQfbAe+if+vcXZPiGn+t5H803KVJy4hNkJAcbI5/t7Kd04ySZcSQ0TZYYUgAGWHBpYqWZzL3z9RCq3PqhbV5NmHwM4xbypeST3fSONRiZIzNSkuqMz8FWKxVpbpB5k3KqUTFkVQraXBrhSb7jxwDoH5Ufzgl4UlfFSy+VnjpogLswVUYxBsZuIKO+aR4L9wYALVhwyswncn99kismG/YQyaihkOlXvxm5lcaCwaQ0BbmJl4qXDFxe4cDvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nszTeHh7sebBNOKojl1G2onwfM+p02k1mbQGFkMbARI=;
 b=eo7W1m9312HFy0VnPwxtqmW5iQ2LDWCPT48QJ66PhKvl0LOlHoMaltPX2LxYZxVdKat1D5Uqk1hlyfj5FM+mu6znfe4eABJUGKNxU4TGFk4HwFoiZO47Z4C2PlrZqaL0nzhNF248RZwiBeDHTY0UHHmdUQ+RzWE+qj/ok7fw45HDsPO/BfB/zOf1BZcolLsqiC0a4Wqtv5TS5hg3UTDAIQjMwC3Y9SYziVBjQ5RD0ujvVLVJhp0uL2zc7MTMPANu3kDbIvEp8Syd3KSw89UC2ZloEYYtbl6EffZFQPYiw7+SQtDNUuH8HS8xuRynbYcb2f89Em+Rm/BZMA7mKOEgEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 11:31:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 11:31:50 +0000
Date: Thu, 11 Dec 2025 20:45:17 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
Message-ID: <aTq83QLQ6aa70y9i@nxa18884-linux.ap.freescale.net>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
 <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
 <3d8c5338-9a14-4f27-9dd4-d84929f9c6c5@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d8c5338-9a14-4f27-9dd4-d84929f9c6c5@mailbox.org>
X-ClientProxiedBy: SI2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:196::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: a06f8511-65f2-4483-212e-08de38a8e046
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8l9wN1MDxucLqd1mOAoYLvJY4TA+WeU3bIAHx0OfukXF/MNRZQhsRls1l9M5?=
 =?us-ascii?Q?KnVX3WCXZABawKZOFg1GmFRZynpqDzz2J7tkod8ymVKsvzwq69ks5wOzBpai?=
 =?us-ascii?Q?nYptx/OclikRToJ3rcw+lO9LckniRsQo6CPbhxaRcokA55s1rgIUghNLvYnx?=
 =?us-ascii?Q?t2GK46KOTzR7bPc3AEB6zGhHQ0PzIEtk0Bn+HxDASUK1exit8L/rfVhVuvvm?=
 =?us-ascii?Q?hIlT22BlzMP6oULL87Gcyjf1CKEexIZCxekmOjQgZNtmvwpkHqm/t9X4yF6K?=
 =?us-ascii?Q?e6fSyUtM0fLarGDXwSXh+BBCAChvK1tlDVWUuWCUJjKYFpKJ2XyhhiP179FR?=
 =?us-ascii?Q?PKF9eFJEmoZnooZPGGf1aNKhgVp+X9wZQZgTJDh3U3Eh6rx2mykNzgzq0QzS?=
 =?us-ascii?Q?Y9n0T43XS4To15FJqtjN6IQ402v0U8axrMYAbLZdrMWo/6yf0Oq6XZdAb9Ds?=
 =?us-ascii?Q?iSDSW7EpuAJrT5tI5Z45cVd7/XOenIAeMuLDDOQ9kE4sl+/9IsXTI1h3Q/Df?=
 =?us-ascii?Q?f3ERI50iIbTln14kfMq8vA/IvDDyIlFWDxBBPz9siPIkibMrljUKx4jib4bc?=
 =?us-ascii?Q?+wV1+seBhdKDT9KnhGTC5nq4JMiYsvYG8hQEANZ/+HXe6QGau+jr0ZIoQrFD?=
 =?us-ascii?Q?7oVkNZK8GXs93kx4yYVHhz5tlsszv/xltiNrmOCLbaDYADaGA+HLssdcqtWt?=
 =?us-ascii?Q?RB+vzl+j+Ejf4HGNXF5JwK7Tv39HNXdhG3Rd2nkZQLaz26F6+sMsroSUupBM?=
 =?us-ascii?Q?40AAtVK2XNc3Ev00QxLWZKBMRha1nlx6nEMfFvK23fhSTiVgOV3sOVDhJXGQ?=
 =?us-ascii?Q?HxwTsoNW7D8nlPtyAKSGvWUykalZTsEDyMG7K84+/TjNZtO1UsDXGkpILOGQ?=
 =?us-ascii?Q?dNyVb410IKcNUa6yHq0wEGOFh055RZuG7uYTYt7LOfKjw4O74wxDItrDojBV?=
 =?us-ascii?Q?BkzHb7++bAuC4YJwbUn5wftkG3NMDYKXAEStEslF3BQd2z64PxAdvDQ5DVtb?=
 =?us-ascii?Q?w4uod9cRfVcqeAwhk/m5thaILHlU3jU19fPB0koRsQgoM+tWr+3b2aeJ7e10?=
 =?us-ascii?Q?z0MeRSv7IyVT1aItruL6a/UBKHTfY1WAoQ53qDKUheef4Oh7Vgr91duybRVL?=
 =?us-ascii?Q?lfeJ7+bu224Da6HptIxFhuDCPm1mUIjWfXhRxPG6eSaW3H0LV9ODzIDtAHeq?=
 =?us-ascii?Q?1yiigJCMTm/bvob9VE2/s8qIql5xXj/nHhoawRXC3PIPcX8hv1Z3NsGla7IF?=
 =?us-ascii?Q?USVhjoUhDB5KcWlZh8elDumf/c5pMENKWj8xFxzb5C/uMmyGuTzaBKrXIENf?=
 =?us-ascii?Q?1Hyf1BwBMbLusjqCFc+980QVygyy0NIPB8JpoUvgNsqD7HLOr81t0Wheunlr?=
 =?us-ascii?Q?PApoemPAEMUFR1b57FhDK0LfxY6FgzS7YsJckP7oNXzkAKlLrog1Jfm+kgac?=
 =?us-ascii?Q?kAFZqn9fNKFziac6kcMFuCmb+uBS+BuIF/uDnm2cfgjhgRqBQvCVh1tX0vpo?=
 =?us-ascii?Q?DJ7F9TPaf7UqbOihMrBqkDMmeUV4cBzvxDd8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNKobpc1DlfSUZqFo9ANC4Y34k7PuwB1+TfjrD9ISA2PA1EsqrkqbfxRtLCp?=
 =?us-ascii?Q?F2BhPPoyN7/qL3fLF26/U31xbwbMMsj3mRwl+BioKmLitU3e82npO4UMmYgd?=
 =?us-ascii?Q?NNws2f8nksGk44J8/tCIkM3EDizy557IGTk+CI9JI+N43/oCge82eQE8Bcru?=
 =?us-ascii?Q?EWDHL3l0SZ65a5+UXGptdoaguHKIJbd/QkSb25nYENKhD3K6UUXganGeCaQX?=
 =?us-ascii?Q?WGGRLZUYjr6VpnlOsw/qUJxsFh9fCKbqviKu8N7dcSVUJnquR74SbZIwKK+x?=
 =?us-ascii?Q?myN0GD9PoCeNZi4fe4YmPAEE9vc9JYsu41YtSCyauoEUEk9TvB2gZh2BqnQe?=
 =?us-ascii?Q?39/9SIUVo6BpcE8iWvXV3Ll9QGhY5z9e5vsRtKeliM4QtOo/+bt527XcQH0r?=
 =?us-ascii?Q?8PZBwvfOO5YFhuAwCSlOMNDKltS9ByNm5DzqbzAKcNqETDtG5DewcrRmstYq?=
 =?us-ascii?Q?wSPvp5nWrVw5PInChuyxQLivtpyY5HCldywc28PujorZlLbzPQtgA5mhe86Y?=
 =?us-ascii?Q?XmwYcUzw2cVHOlANadi+dTUItKdwZQb5K2vcsbiRDCGbu+crAXSIjChnTD4r?=
 =?us-ascii?Q?xV8NEmK6/n+ySQqZ8x6pZcQPoZ3fq8OsAcvx6yRX7PmUeIjYN6O0WtBBoXT+?=
 =?us-ascii?Q?ltG1gbnDoyuhcXd+EbSCsj0ZfIlUzR+IgGFzbJIl3yMuQT9MiloSLtsgKhBy?=
 =?us-ascii?Q?Ku/2mgkbU/BYTnb2GmVOEILuuLcvch+CfpqSju3rEDeeGUyADH5MO0Xp3riB?=
 =?us-ascii?Q?xoioIsjMXdnGDoXOpbOqE9Fo9iNBSaCJhWQbQ8IEZoo304ECs7Nyl9XIrqlF?=
 =?us-ascii?Q?obmqXQ1H3xbIA6bPUc9d9t6OwHKPfOtoVYCzBNfJgV8qAPwUj1noMm8ghoWv?=
 =?us-ascii?Q?7cBxKz6nOjPiuf9xfMFTkvcV5Dy1jSVrmmxiUaXMpp0lNs/lNO9EF3UXb7M4?=
 =?us-ascii?Q?Rj0zy0cxvViQ+pevj2Z2e6WQv6GGX0Nh18c1S/t2Mh9UhnpRXortIOeYXS9d?=
 =?us-ascii?Q?FblGSTVDHiraiRHAQbQLxmfttcLOCTTNhMs8NsGUJJxA/hLDFgS+9VIsakvV?=
 =?us-ascii?Q?uqtE5f4zEYgUj33GBfYYB+QDL5RJZ26mlg3I8P+ickZNaPbFhJtG9emNdc2c?=
 =?us-ascii?Q?6DJLOKpd/7lPOFwurVbYu4frYXv47rjHvXzEpoCuoHNWR1AYoopVRGACxC/J?=
 =?us-ascii?Q?HhpjDK9DrYAzKvFuh7L7wuPWpr2rekAf61BnJvr0SzytqRP1RmJjZKweW1qz?=
 =?us-ascii?Q?m+L7TQJ7Mieav2vKszBC/BXOGT8dodHLgy/eGtgO+2fQo2LaI6sYUP3UZYWd?=
 =?us-ascii?Q?LRPVwRyq6xWIwJgPeDehiegvf2beN3Rdo4f1g4gBmLllMwCDxAQx4JRMnFY3?=
 =?us-ascii?Q?khUroJa2W6sO18g37/XOAGsZJJ0YIPangIjZhzr4Acn0Fs3xTnV/YSFmds6C?=
 =?us-ascii?Q?ylToH/u9bK4TZ73/CJOIucbxcYt1b9E39XoHyoWo5hcPqUKhNcT/6n0zANAi?=
 =?us-ascii?Q?UyYA2jnsMcEIr1VkkVU6srqacbUNqk9La6JJ+Q4tuCHz2pzAVLZp9nfhmcyu?=
 =?us-ascii?Q?opS8REgfurtW3Cn+Vh2MqE0cxv2qeX9J3P+rPUAO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a06f8511-65f2-4483-212e-08de38a8e046
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 11:31:50.3462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6E95Oq1Ds1IUefEbjGAnUnVYCzMN6gEOVo5r8RRfH8KPJi810QH7OGrHvyTzhQ/oFAp1jHP/ZjASURF+FGRTag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038
X-Mailman-Approved-At: Thu, 11 Dec 2025 14:55:31 +0100
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

On Tue, Dec 09, 2025 at 12:54:15PM +0100, Marek Vasut wrote:
>On 12/8/25 2:51 PM, Patrice Chotard wrote:
>> In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
>> data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
>> retrieved.
>> 
>> SCMI request is performed either using scmi_clk_state_in_v1 or
>> scmi_clk_state_in_v2 struct depending of the unpredictable value of
>> priv->version which leads to error during SCMI clock enable.
>> 
>> Issue detected on STM32MP157C-DK2 board using the SCMI device tree
>> stm32mp157c-dk2-scmi.dts.
>> 
>> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
>> 
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> 
>> Cc: Alice Guo <alice.guo@nxp.com>
>> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Peng Fan <peng.fan@nxp.com>
>> Cc: Sean Anderson <seanga2@gmail.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Valentin Caron <valentin.caron@foss.st.com>
>> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/clk/clk_scmi.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
>> index f6132178205..e1c20f2c47c 100644
>> --- a/drivers/clk/clk_scmi.c
>> +++ b/drivers/clk/clk_scmi.c
>> @@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
>>   static int scmi_clk_gate(struct clk *clk, int enable)
>>   {
>> -	struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
>> +	struct scmi_clock_priv *priv;
>>   	struct scmi_clk_state_in_v1 in_v1 = {
>>   		.clock_id = clk_get_id(clk),
>>   		.attributes = enable,
>> @@ -156,6 +156,11 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>>   					     in_v2, out);
>>   	int ret;
>> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
>> +		priv = dev_get_priv(clk->dev);
>> +	else
>> +		priv = dev_get_parent_priv(clk->dev);
>> +
>Shouldn't this be doing similar resolution like existing code ?
>
>168 static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>169 {
>170         struct clk_scmi *clkscmi;
>171         struct udevice *dev;
>172         u32 attributes;
>173         struct clk *c;
>174         int ret;
>175
>176         ret = clk_get_by_id(clk->id, &c);
>177         if (ret)
>178                 return ret;
>179
>180         dev = c->dev->parent; // <-----------------------------

No need. The current clk code is indeed confusing.

In drivers/clk/clk.c, clk_get_by_id is ready called, so the first param passed
to scmi_clk_gate is the clk that registered during clk driver probe.

Regards
Peng

>181
>182         clkscmi = container_of(c, struct clk_scmi, clk);
>183
>184         if (!clkscmi->attrs_resolved) {
>185                 char name[SCMI_CLOCK_NAME_LENGTH_MAX];
>186                 ret = scmi_clk_get_attibute(dev,
>                          ^^^^^^^^^^^^^^^^^^^^^^^^^
>...
> 90 static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char
>*name,
> 91                                  u32 *attr)
> 92 {
> 93         struct scmi_clock_priv *priv = dev_get_priv(dev);
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
