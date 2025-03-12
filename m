Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57736C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0472807D9;
	Wed, 12 Mar 2025 06:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E/TfrkF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCA3811C1; Wed, 12 Mar 2025 06:14:54 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5278580756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXd1ycDyuh8Q2O+ex6ntZSvTm5V4q4roCfaoUsZ8dJ0yqxlES8QQLw2VnvmWeEJKqHl27kovdLqdeyai4o3Qd5LA8MWY6EP31R7aGy+O65paXhdC0Ze+X/eA2OXZplTUO+8gnMuaX8zdAWrrmyFNtF5X252xi+nSCOZsTWDIiVqu6xr3TUd5/jglH1SxiDTBFAa2iSox62eKSHkIQME6dGo1kKHBwMtBNbs6AuN3aA4SK8fEZwppUt44ssCp9AQjyZAtAH+f3K+nCMrpl0Y120nB04xqzKY0XmIEvClbJ4xdBHMAwfu5GENXYilDxlGtn9UGxMpkZekJvX4+HIdvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0i/NVlExZDjFUM000LAbuYTH/BSE6omu187YhjtDxM=;
 b=xR/Z/WYsPMN7XLQ9ZGJUvBdNNgV/qBuxKWl5ha0LzGEYpVgEDRlMXzZFOVggIfYgIpQ/aJeLV4gaGf5fbFNKaZp8lglg+RR8nzXCvjpGGZdVBfL9lkmHp3yML08S9mVBMh2TLogw8QPB3OUWfunpjST3YWVtSPUXqsP+3BfdoOeoU5RlrragpUu5QeVfDJJx8RGBZ6sr70S4fYgBq0kEsNaAgDsBrsqFYuBUr3EI8mQ14dD5/HFdorRLzb7Gm3rDSGm0U5hf1svEVXuRGGerc8dLKJf8hpoa2QWXzHukd+lKJ7GEW5Szau5UrVcvJph0koyegFg6gBwnscbb3y5Gog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0i/NVlExZDjFUM000LAbuYTH/BSE6omu187YhjtDxM=;
 b=E/TfrkF0az51lil+Xo6hSUUB6tFHHo7isV+VHVfEounVu1iZzdS96KpRORTN9GwnC3NZnNf4HoSLBcA4zX38JXjgCT7f4iwZTz/WW8c4lKVbGKYelyWt7HwPX2H1RPYXHp6EiYcaf7ZTCCEYcXuDJZEov0IixBNgyNa39eee8jqIZWurFx+69OfyyVgrmUDH5sW/fT0dJaGlSgAx1O8XmVrt1cr6n/opUUeRIvfikc9O3CErmic4JCh+eqqi1CHcFCFZe/YOZIfdJYjgPGxQuS0R9ppVuFvFqV4p2N4JKJimP+nrYeGUJtQg4LyB4EXCTyRp4gZinXkhFkDwg/ofKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11020.eurprd04.prod.outlook.com (2603:10a6:150:227::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:14:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:14:50 +0000
Date: Wed, 12 Mar 2025 14:22:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 04/10] clk: imx8mn: register UART clocks
Message-ID: <20250312062229.GC11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-5-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-5-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11020:EE_
X-MS-Office365-Filtering-Correlation-Id: dce71650-5447-4f6f-116f-08dd6124d0a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3fbdtSS6Yp35pUewRLOphFd7g0eWXCKlpCESZ3XDioiFHfeTYIgctXSJXqlw?=
 =?us-ascii?Q?gyqVn2ziH1v8UbYMbJ0oQa3JbYfqVH7g62uAWkPf3McJfmZaDoc5+a8JSMAI?=
 =?us-ascii?Q?b4C1puZsIGh5Kzb527oBluSNjSQXFEMVMyHmwnPCzXgdWiotsULjbN8MBpca?=
 =?us-ascii?Q?2i56eFg939jAnY5r2NapdlfW22mu2uxvB7L9E4wjEI/4cnA29hSOLEdysjKW?=
 =?us-ascii?Q?rS9qW47ryffo/RoZmc4jOZk+I1gyaDVzjpKAHgxTT69pIzc2fGDT9xyQtAyG?=
 =?us-ascii?Q?9lFoDyAuxfXoFSQF7R5ItrMiVnIhtRIaE/M9XKME5gvKLsVlKi0gj98aF6IT?=
 =?us-ascii?Q?inAih1FhAKLLWbpczY1PtT0pe4b7q5+gpP2etAd201G4Cjw8AaBERaGPZXTe?=
 =?us-ascii?Q?0NOetuconyemDQVaI/U1Txd66saYcFzgSpUzruFPJ+pUQsYzauTtmj8lBqh+?=
 =?us-ascii?Q?YuBYA8D5/dyeMX1XSnf2wysCiccvaNfJlmG31iDzjdv0DBgqdfBSZEU8tkjZ?=
 =?us-ascii?Q?df0RWCp1RGUDpV1AA5z4ixZYq7x45dtpgb8qt4GGISRfcgOWxrJGDNu05yDt?=
 =?us-ascii?Q?2qBXl7Nf1R4QG/BaAuE1sSiV8gGdPrPjOx03yzmaQ28ZDvtHXHBjW5M1w/Ds?=
 =?us-ascii?Q?lSmuRtdL9NWVFp2+MQch8+aTnJ7LR018FlOtsoN2vLGXFlyBzIs+WhUSgOqb?=
 =?us-ascii?Q?NT1FW/aNNRhRiLb3nz7KpDuj6K60ooT+9wEQg5S5tS0g1K6U7pVIz0FkWhmG?=
 =?us-ascii?Q?FZDrZkELyg4IBPQLG+Ps+GPrBU84qyCoVLaz5SlTIMKZIrF8sCnKIvaFzYyn?=
 =?us-ascii?Q?HwejLHghK6cg4ueVK+ER9ricA/BPTVqaEdMe8z26ko/zH25IQmvBFrpgBY1R?=
 =?us-ascii?Q?NFt3y/kDZnxx9ECWRFnMcK5//rxGuDcrhKzqHGY0oMlnNxDWU8aqmtADqO2Z?=
 =?us-ascii?Q?b5v5KtzOZCJRohgLV/3FAtAwRZn0BaXZkmfV8b0oT6egQeLk7WnAw2kxmkEK?=
 =?us-ascii?Q?7WhpXFIkkZQHVFBCADefYamOp07eKl2xcsx804WWRV/T5k98MbeldYiy8YtN?=
 =?us-ascii?Q?w2bD4koVGwpGlhjCktzVN2u3choBN0HS9KaNaUAzQ9Q8FCL4IKLiC9cLb1ie?=
 =?us-ascii?Q?tsUGEyBvlVqcNDPLp7tYc6Hj0xfTauc0bgaP1BRnP3posZzje4G4e3fxoWGZ?=
 =?us-ascii?Q?WFFYyaqXewUajUdsDAA20e6Tx8mi2MK5qK8tZvJnD8BHiCkCkNibPHbEmDrw?=
 =?us-ascii?Q?EPx3O5LdPQ0C6R+GoGeCnszQ5nZ4amCilCpW3FutFkUEkgW0UTbem6gtaVP5?=
 =?us-ascii?Q?yei9ejXWelWPgGT5GZGCFpZ7M5kpYZGenK4qu/HF2QeRPkvZGej2HwmK2iv6?=
 =?us-ascii?Q?lXBtSR+teW6BTGumBBq2mKlrUMZR1ijjcbsBYbn6glyIl0K9jgDuMJK8AYRM?=
 =?us-ascii?Q?bgSEgauys1G1o5rT9eyo1e/IrFsaqw7X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5rmVAjMmTR2Jo9TSeSJnY5KaIjZB9asotmfkHSoCp0Wcwglh9uko+Zw/dMaz?=
 =?us-ascii?Q?fstRoPk7nTraM5UWhQj2PPt8KyXPcqiys/h0urAnlFtZTUBKFpCmv4mEpwgL?=
 =?us-ascii?Q?Unrfvg0DuITRHrKKlKkKSgqx4RXbWjmmsyr1Tl6wCCrt0Y21Pofrsia21EJZ?=
 =?us-ascii?Q?8DgrfrwVBa3s/6IPocd3KL9YFi1qehs00Ovq9H0m3nzQKSrge+fp+x8OpADu?=
 =?us-ascii?Q?QWubWCdqHzosziOTpgrV1Qy9QNBft1NpOIyBPglsNkhb91MFA+UNJ4b8FjA3?=
 =?us-ascii?Q?jolvE/bqfHsr62iSiGhEcanM6ZywMMm6L6qjPd026NiNfvwmjTFuV61ouI4Z?=
 =?us-ascii?Q?4pdwvNpMD7zVLJnKD+lT/7T6O5+lGTCV2Y7L3EujMaFJGj9SUKTRGShDwinT?=
 =?us-ascii?Q?23bl8BA7EwehWiHo0R2CfhPRZ27HdBK70tGpnFbMBoP+PX3Ql7MF//AlKVSe?=
 =?us-ascii?Q?bbNWDji5UYem7M8g+6KKQKZC8PU86n2t52W3HpObYqiSWNUnRZpZD1NC4Mt1?=
 =?us-ascii?Q?V0VNVb0NcRDLAC4MtGiMgW3O/l9R/G6u4moT4w98LboxDIS0RicJQ8b3UqMY?=
 =?us-ascii?Q?Pw4/m9ZMqQ8Mo+GS9EFnWnLWQ39iX3sVWg1lvttv9xFdDN+k6JxfwyOMuegF?=
 =?us-ascii?Q?DxXiRrpqHFSbpGMhLQba28fPwhv32r0EGcHacHYKbbOoDJLe2M5/JdDD/irP?=
 =?us-ascii?Q?PUVItMauiy4P9X+Dipso/BWaziWTyfBEtq7we9aqUOM+lYzsd7MBv44803xK?=
 =?us-ascii?Q?wwPFAFcZ2/C1t6kYYyaEZmRSNEf+RmcXBZiNBwnO5eVmAcK5L72eo8EMa1ez?=
 =?us-ascii?Q?Mgzb1ixWgOaZKMFYiJwllF1n1nTH0OvzbGJxjdwKO/N/ADbwntVdRtlLBEW4?=
 =?us-ascii?Q?IVUg4mUCztWPEnWOz2uuLd4EtNpxx1ayx5cX0DlC6qzCbvXV6WLsF7iwwOLL?=
 =?us-ascii?Q?f4PJgD2Zh2PZw2rHo28vPu/9GiAwlbO/lM/JepD/+1JYStjP6CYKqog1+kNd?=
 =?us-ascii?Q?yta1amepwdkM4ULvUG5q6D0EJ6imxynBOUD84u3kcuOCCjwPKODIHwNxxROR?=
 =?us-ascii?Q?wbqH8YTNaqai+lOYYApbpjfzmnTX5JNLOQP0+c7jpNsqyb89Wtf2Zdh2Vmb4?=
 =?us-ascii?Q?OI1j1rvgiLS4mgBcqKkz0fvGHsTHDdBrg66Og8yxQgzQ8DQ9W3rqoQQVRLhP?=
 =?us-ascii?Q?vRonqzQ327MTpj8UucwOzABjzKMVgPEkoFMCAPUrPkUJEw64SppyWoPk0tWD?=
 =?us-ascii?Q?Vy9urmhQRmbODpwnxpiShoN7MRqcGbw5kogD60A1fgepHygr5jQ/S+hGwO2I?=
 =?us-ascii?Q?R/HV4Y4sK/AvPgzbahsF6Y3lHrK3Cgdm+bIPHTpXI855oqgOMgNgjtPR47+/?=
 =?us-ascii?Q?5PYjDQGxtZ60pdbK2S7nrn13wOsRt55VBHBOi6NjyL3BooNjUAsCaVCyHzvm?=
 =?us-ascii?Q?wFEbCvezSRj2hcN7OwwNIBttAXjt0zwQ9ai9Kwmn5QgNSUG1wYnn0rXDxwZI?=
 =?us-ascii?Q?2tdfy9QR/hrAh42Ef75mb9u1YBMumBwMXQTyTjoMW7jEmLHWSyEukhxI0Die?=
 =?us-ascii?Q?PQmGqHuJDtYEiF9qxpghvkQ8BqfG6XSqUEy/L24S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce71650-5447-4f6f-116f-08dd6124d0a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:14:50.5810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBfu7D3S37cf5qPbs96InyXX1QhM70jCqZowLg6P/AZQ9WjawODCCnFKvve7fMHwDMGdvTQw/Q+E5W6yaaRZuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11020
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

On Tue, Mar 11, 2025 at 07:30:24PM -0500, Adam Ford wrote:
>In order to let the serial driver enable the clocks, the UART clocks
>must be registered first.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
