Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AF3EDF026
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 03:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D7283A47;
	Thu, 12 Feb 2026 04:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="owTaouck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76D583B64; Thu, 12 Feb 2026 04:41:12 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFE1683981
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 04:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0ChscO6Qy+qUUddKfPrFrXfz9bvSUB/yM623HjR5kFrDg8UCJWNeseGDqjaMUMUM0GD1p6X6BAM/7dZp4hIbaGhD3N8rrax9A+AUQgoy8pGFYMTqwkzcHHHp3ItKluL1AolRyry8fzyeblAKFLx5IpQk89lZsE8t2r5IpqE3YOqMv1Vs91MVAPDKxcp702SHmo2SAaXyTEmzzAqxBv8fpjGoUSW0/b1EHMCJZ2AQHDUW4nCjgR+IxuXpJFe/A0zRXFOdE+eijbDuR2HnoMjjT83jTaZDmuzKAx84wpKyhG5poCgYSw+36F/WfP9D+pQ4/UunPze9DOzCprUa/k6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy37DU9LhxcmKc1jYQz0nF4DPaXrLr6ivOjoPVbpfE0=;
 b=AD9zTnCPf8s7GfQXJcFP793hfZ0/bSHrntqUlZeGrvJMqylUnh9Se5/HCMcneBTSHEs1J4OjXZTpskoIlA9BgCwBgzVv5R+EzIaD2KVHHKQAAhVGLUWFgOM780SfpoA0TWHELP2ecHea7wfth2Jy0Bt5kS/o8NLWVT9xXPDpt0T0qtp11Z8l7aBiLgDz2hqxgOMm8Mxm4Nvh29KG488FeaMEL7bp4d9UKioeBvKZ/5JqQQ7BDA1Jz+mdNgnc6fybRoHRPTsVWYpR9JzJGkvUkpNkQq6jzsMwO6v7B28juqqiRz0r2EP77/GVhB3Q8K0vsJdh4Ch4KsBXaRRAaSxp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy37DU9LhxcmKc1jYQz0nF4DPaXrLr6ivOjoPVbpfE0=;
 b=owTaouckK+Lt0UQkljslY85+AIReXybQEYhqXfJ45yrIKXjc1hGiSBSk4Ta9qwaePe+pk2e9pDxpxuaE3GPwdeQqsxAnXAUJRn6x+9IuIDLHekXbBy7udQ9LICHuwvySqB8p3hrDjdjbVhQ62d9BAEKLagcBi/lyxkdLaVjxXXsyOgTxBSWO3yYweLk+5hIHbvRG02JuKT6ZpAtDO6T96qv2nDsfVwwDyW8Gk4hgQQsIepISD9UGgaZQovZp9YqE5AJxWSbbRVaRNOur5EO+0uj67vmDQbtlRi4N9nB0SCnaqtrDiz4i7lRxtAeoVnnvHg8y19BA9u91xjRjwe9KhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10722.eurprd04.prod.outlook.com (2603:10a6:102:483::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 03:41:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 03:41:08 +0000
Date: Thu, 12 Feb 2026 11:42:53 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: William MARTIN <william.martin@muxen.fr>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 herve codina <herve.codina@bootlin.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 "Ye Li (OSS)" <ye.li@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 dl-uboot-imx <uboot-imx@nxp.com>
Subject: Re: [PATCH v3] arm: imx8m: add boot_device and boot_instance env
 variables
Message-ID: <aY1MPWlsprTWKn+S@shlinux89>
References: <20260211103109.92178-1-william.martin@muxen.fr>
 <PAXPR04MB84597449572BC512CABC27CD8863A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <97f029a0-ac83-42d0-87c7-fd09f88f1807@muxen.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97f029a0-ac83-42d0-87c7-fd09f88f1807@muxen.fr>
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10722:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a33b2c-2846-4f1c-2666-08de69e88eb7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?Jj21U5NBQSUpDCBN102tjOhdD71MNf8uZEfpO0d8wPrNZbrOdGcY9xL5JJ?=
 =?iso-8859-1?Q?LhyuYgxeAETwCYxeu73WacWa6r+B3Ro695HLYgKB613Gmz/rTc93a5jbYD?=
 =?iso-8859-1?Q?hV46dpxTuwmWp4IWZErCxR5wva5Q4+xHc4Trbrxwbb65uMfGF/HJqwEhox?=
 =?iso-8859-1?Q?WWxigUPgYR9j1rrg59Q0kJeeeDBobLb9e2rdMZ7uwvyLD6897nqcph3I4e?=
 =?iso-8859-1?Q?G9Lv7q1rJG+ZsklewUZgMCeZp1ekVodFWiF9BJHx+o0tg+9JEjlzYlCaav?=
 =?iso-8859-1?Q?7lC6NeWXGcRafxjnigIupqv/YRDg36MFrulgGEuxdfkVUeqlNJoz0LzpTx?=
 =?iso-8859-1?Q?jdHmx+l3wqdJtw8EQW/NHhINvq0aPlkqCkAvIdSNKarO4gJ89Uds3bWU7M?=
 =?iso-8859-1?Q?TBOdkT5bqiCdA53gaxfiiCZ/JNk1QrNumhkcLCAb6TaCuCxr6lagrlLxMn?=
 =?iso-8859-1?Q?QOrkDSNjaSskqW+m0oQjN2bKlRr4DJepTBvaib7p9XI1ZgAXgKgBQzDJIm?=
 =?iso-8859-1?Q?kdGKXf9S8TKgF80CJwapOsibpfb8XcT54LTkhrXFizHBlwxrAZn6Ygvyng?=
 =?iso-8859-1?Q?T3Oa5T+TAjpNmCq49mYPFnvFoOxcNKPp2LE+aQHcfGRh7Cf8TCz81G5XeU?=
 =?iso-8859-1?Q?QChmFDcUsSvQl5HElWC8FqGpppMfp6zDKmWaYbobmbiSjlRND/qdSGjumH?=
 =?iso-8859-1?Q?WYNziSpN/QssW8fFX6lVzIJ3UFyfb0eyfsaT7lzxr+f+DtzkpwuI5E1FWs?=
 =?iso-8859-1?Q?s8e0IxCh/Vc12mw5SPM8dUHEc2qm+6y6cjkIuzmmFpnMNVzoanTNXYPewH?=
 =?iso-8859-1?Q?FT6D0eiF2281TTIa3yFrTaRof1nq65y7VkbvrEW1MaArgpWQLrT1Jz+Y/p?=
 =?iso-8859-1?Q?NIMaqqJjjDwy6oFpVgqKVSWctsSi06qV9XDJNf3rQ7u4aMOucI4fudfFMC?=
 =?iso-8859-1?Q?OQTY1c++BV6CBbPG/QzYGsnD2mOUpEBF5Emi7MBFNh1nPjOVG+GLi7jU5j?=
 =?iso-8859-1?Q?M6Pm9hLLbmuDROFD00lhgno5vGg8YTHsXaJaFzkZYGFxlkVD9cdoISwc4D?=
 =?iso-8859-1?Q?EHHXBlLQqBqDDYE8HLJdLzb0wL4aia5H81bMPz+yjsJAfV5LF4a3ADzmjl?=
 =?iso-8859-1?Q?fNqcJjyXzUNg0TDiAwrOC5IMEUaPUTd+0yx64Kbg4pyvPwkh7ZJtS9FVGq?=
 =?iso-8859-1?Q?4rXKbOjzGew9d/69Q/DECW9jjhrUpTxiHFeUkbHNEYXBSuviJXGHwyTo6i?=
 =?iso-8859-1?Q?EivUUa5jCmGBonmvjM7j7K75VW9ZadXyll/NSiQ2h13+1Bmc3W3z1YOHro?=
 =?iso-8859-1?Q?vIY+GFHUnv/WeTcQK2xDLv7bJIZr1Mt3fWROPPrRfGCCW/wdB1WYLiPSvj?=
 =?iso-8859-1?Q?REC9rMrahtAYlHL7LoqWGlKojAxkIJYQFH48MptumsonXNjgSh0uR8bl0G?=
 =?iso-8859-1?Q?XcKnZ7fXMMFffy/OotR+PPuWBwH9YoOfHc/rJ7Ys8ErE7F8Gb8bG8qJpsG?=
 =?iso-8859-1?Q?Yher8ZEBOlVYfmn/2YdsJUkDRL2UO0aIBqcJqUM6NI2HSf2V4nW/JJ2rlG?=
 =?iso-8859-1?Q?8vpokZ1RM29r4EHKAjvW1WfIyON/VQvVZP385qLNXoJ5hCZoZIahpEFA93?=
 =?iso-8859-1?Q?Nhgz2W1abBhPiCw0VWuoigtkO739QMV+VRuASuof9ZWUKJ4z9FyAM9s8p/?=
 =?iso-8859-1?Q?SCERTmrThFNu47g6b7Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OP8iqvB9qabKznYKEv/QSSLj/ldrnOK1g/BOj8f0t1P1MUPIEFgEYLuZtZ?=
 =?iso-8859-1?Q?XwH1E56tedd45j96JPMjqXv/hcIMgd5Ru1EHa+4wiZSGsbwK+/+ay4eKfo?=
 =?iso-8859-1?Q?pTk6DDS2QNgey1TrhaZdExPCBEgtYCXyLRwdsUZBY5ot2ZtOgj9/o5PJ/2?=
 =?iso-8859-1?Q?ELkjAmcvZajL6AFkNCNFH52Bei0qRbRC+kSRK8D4pvEPupje1v7+UFeeU/?=
 =?iso-8859-1?Q?qWDZ/+ZOdBrMDJy7nfCMBClXYRo3VDspFmpXcAO8faJZzCNKnp1e1MsR0o?=
 =?iso-8859-1?Q?IUpJ9JbrSoYgF7IjFYXJUlO4d4WhG5xZm4ei1DaaIYocZ4T3Xg9HarEG0A?=
 =?iso-8859-1?Q?SpO4hj4UE2RdKddpsnbVDr3P8eoMgWQfNHCZe7diKvtqpYAex+8UmSmJQx?=
 =?iso-8859-1?Q?ScpC8uOelhNUtW3PHlrSNvW85jPZjnmCQtcLIENcW8Nq43tvs95Bb/Wqui?=
 =?iso-8859-1?Q?LgawpE8MwpzzXchSbGfd9oEloys/TlBiMJKetk0bdaGW9qY46dDRrd34Yn?=
 =?iso-8859-1?Q?Utk96gODnLKMBjRBX2EX2J/RT+7t917Fw8ElrxIyZee6RE0BktqeuOzshG?=
 =?iso-8859-1?Q?YtR6Re08fgvQKBmPQkq5kuA4UKf2L0wtD8Ia75eGUgU1AAov424AISIQQa?=
 =?iso-8859-1?Q?st5LdDfyYRS/JxF0UORo+mV9KkDS/LvwyJWSbSLbTHM8DxNetaYGCXqzBU?=
 =?iso-8859-1?Q?HoQDURxWRSfcUmYX9g2PuvpDRVjfmLcV8j5PUCXSqeQqM9+un+1ATy8xj6?=
 =?iso-8859-1?Q?bAxlgHTeWNw74ncMsMi0zG5jCbUDK+oc64bMfzmbE0L8LnP99lHQiNWW+s?=
 =?iso-8859-1?Q?EikV0QKfGu2hb6RCA1QaUbuogS9/6o787KCxHrXlnaxeTN4Zg+3XBGp13z?=
 =?iso-8859-1?Q?0JDXEXL/Z6+4Bb5Yx8EQDeViy6i/wa6I1D7H6/L+m6x5wwskQeqHsdEFwV?=
 =?iso-8859-1?Q?YJv+ug5yvh3FFL28s9/gFlECo4DhaB5Bi4CX6v3g63rDaT7V/3DHx/Z6ux?=
 =?iso-8859-1?Q?Hg1gm/YB6VFC2TgeRezjod2doqOpL2wFIGT+KBD0DhoS/oC9WYdjdWAx2a?=
 =?iso-8859-1?Q?uz59DwSIbheGgdWXxExlsUgkgWjbKy1N8zgQHiANhfprTzOg8cn7Xtf9Lm?=
 =?iso-8859-1?Q?cgYdHTNUa/W6uo+0DJvYQp/PKe0TdgyYh/30fwRjI+4RjzfCzBW82BmC3S?=
 =?iso-8859-1?Q?TDL/SKW2CerZ1AfIVVzB+LxZz8CebaRJaPM8LGbXLcaA2+UTx8ZLSU3yxx?=
 =?iso-8859-1?Q?SXSH/tM1+aO9AQ9WUMZ52hIk7aC7ux0RYo1TDts+F1vdoxUq2eky5w5P9O?=
 =?iso-8859-1?Q?aj40RcsOjBIpaJpiZnFblJIacuSBwXSlHcvwvbVdgup2q7cwMFRu0TJXja?=
 =?iso-8859-1?Q?W2Y9wnA2jnQBYmi8MtxAzgwngv6lMizIwmPvTvJ/E5AujKqdyuqGkPo493?=
 =?iso-8859-1?Q?+kXJmzB4yocb43XNOKFaYvz0T2jSBns/vXbA7WM6aPXN1uJSgbvqvuTBTd?=
 =?iso-8859-1?Q?0pQwezo3FDIbbrahHJxhrt9CowOi4fe1hj+Rcf5Gbf/qCebqIa0DokPpw3?=
 =?iso-8859-1?Q?YhDxBd5scVHsIEvqknP+jewxZ8DBclL7+vUw7xKjKa4PMIVGAzU/n/EUTs?=
 =?iso-8859-1?Q?gHh7LZOQ6pXGQgF/nB4N2mOAlB/oj1g2cFEhGmr/Ub/ZCLQmeC/B7GU/ZD?=
 =?iso-8859-1?Q?c6fJOsemgVMlfEAsyvOcs42JkuzBjPbZPMFyLMHiO1YgXzRoDN/O5lahXE?=
 =?iso-8859-1?Q?HqXZDotbiZp8p+5TKRRMkRwQ2oNs0+bYgJ+CNHj1jFtSRsn6dyG+fu+jaT?=
 =?iso-8859-1?Q?b31W1JgL+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a33b2c-2846-4f1c-2666-08de69e88eb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 03:41:08.3774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPbin2puc9mQob6a98zleJizAtaRu+m4KAUMrkw34BJi9dQTNjZpo4cFk0YE/qLfQWPK96D6tK21GuM50/NnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10722
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

On Wed, Feb 11, 2026 at 02:18:28PM +0100, William MARTIN wrote:
>
>Le 11/02/2026 à 12:49, Peng Fan a écrit :
>> Hi William,
>> 
>> Thanks for your patch!
>> 
>> > Subject: [PATCH v3] arm: imx8m: add boot_device and boot_instance
>> > env variables
>> > 
>> > Some SoCs have supports for 'boot_device' and 'boot_instance'
>> > environment variable. Those variables help to choose the right boot
>> > media during the execution of the boot command.
>> > 
>> > The i.MX8M SoC doesn't have support for those variables but provides
>> > internally all the needed information to create those variables.
>> > 
>> > Fill this lack adding support for those variables in the i.MX8M SoC.
>> > 
>> > Signed-off-by: William MARTIN <william.martin@muxen.fr>
>> > ---
>> No change log here.
>I will add in next patch
>> 
>> >   arch/arm/mach-imx/imx8m/soc.c | 72
>> > +++++++++++++++++++++++++++++++++++
>> >   1 file changed, 72 insertions(+)
>> > 
>> > diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-
>> > imx/imx8m/soc.c index 1fe083ae94f..498b565183b 100644
>> > --- a/arch/arm/mach-imx/imx8m/soc.c
>> > +++ b/arch/arm/mach-imx/imx8m/soc.c
>> > @@ -1472,6 +1472,76 @@ void reset_cpu(void)  #endif
>> > 
>> >   #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
>> > +static void setup_boot_mode(void)
>> > +{
>> > +       enum boot_device dev = get_boot_device();
>> > +
>> > +       log_debug("setup_boot_mode = %u\n", dev);
>> > +
>> > +       switch (dev) {
>> > +       case USB_BOOT:
>> > +               env_set("boot_device", "usb");
>> > +               env_set("boot_instance", "0");
>> > +               break;
>> > +
>> > +       case USB2_BOOT:
>> > +               env_set("boot_device", "usb");
>> > +               env_set("boot_instance", "1");
>> > +               break;
>> > +
>> > +       case QSPI_BOOT:
>> > +               env_set("boot_device", "flexspi");
>> i.MX8MQ does not have flexspi. It is qspi.
>> i.MX8MM/N/P has flexspi.
>> 
>> Regards
>> Peng.
>
>Thanks for your feedback.
>
>Does the use of IS_ENABLED(CONFIG_IMX8MQ) to change boot_device from flexspi
>to qspi is enought ?
>

if (IS_ENABLED(CONFIG_IMX8MQ))
	env_set("boot_device", "qspi");
else
	env_set("boot_device", "flexspi");

Regards
Peng
