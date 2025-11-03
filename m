Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81383CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:22:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07CF683955;
	Mon,  3 Nov 2025 14:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TDKnRuSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5F2838AE; Mon,  3 Nov 2025 08:39:04 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970C68331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 08:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9Q+Q3zS7HHIEXBlPNqAt6xUya6xmSHK8haxokLl5nigHKUUNxX+gw5GaKu1rJ08Zf238Mi47izCSTrzXgGx39AS88h/CsT/Dk3chb/qO5Z1pbPNrhVS1e2jOw9y+Ryq2fP1vwfEH22NW+NMkhB1ZkcLPL3DdXrc6G9JQDyESTqxDd2BWg6Szs0Wy8N0Ws2EeQPo8kxmtNGF9RhmVTqWll6K/5SLx7H3CHMF3dkjyCs2357+XoKA1pKNDPi4HF+9LEst9reBPmBY45ly8+7EvirNjHbbhH0XiZHTR5QHAnUosz57w4J0/c//ZJvzTtk/L2mtPkVCMRPozPLIvDG5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj8PS75ZW+CAfY2Vk+kWG3qcloGzgoS2OVczYq1umDM=;
 b=nmQg3pdRVjl6XL7D7+EG1zXpyy67t0zw5RWAsphmVLY0bNMImcJNQsptgwVF0oPq9clvm48b02MsNbNQmv4lMbinKbBknNyUcdriKN9Ai6V+NKMwUzv53ks32MBVbbQ56YaCknbZ6X5DWLUOPG3qd3PfZBQcNjdzcwzt937fhFBMy73/COTM5KZydHgFeZe78++TLU/BNsjt3qQyY60bOR2qEh99lazAWbfSrwAQwIc41iykpLwXDB3YVh4lmuJYso3rGH2pywMbL106vrQqsU/KFZw/spQX89dmyjr3zfwU7mgvJjbYF6/1MGiAdTC6jouI743RNwU5YOuzlAXWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj8PS75ZW+CAfY2Vk+kWG3qcloGzgoS2OVczYq1umDM=;
 b=TDKnRuSfFj0cwxxZ5QMMnGjhTCDzkvsM3YJqE6iquyz6rf9T665V4jmZgJZABO95H3Y371VnT+HzSdMjzOQ0+3oyyl6Odp+Gmcvej4rq2H+GNxjtF4RQRHGp6sadmWYAXa+gwApRn1xLDpUssDwJQhYjMFKxbc0dq3ctaeqr6qsnT/whdmFFT/5866OG2TiaDSgItm3EW5V8vxt2jdIMC23t42iKaTPhHl84cPq8LRyiqHpKpz5cLXjKeRnMDWdHclguuzyD89ZmO6GbdjB87h/5wKtgabLlN3J8S/Gc/amM/WXJwuMSg3WrJgUyxM5J+xlWG6heouPn4C1R5YkpEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 07:39:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 07:39:00 +0000
Date: Mon, 3 Nov 2025 16:51:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Dang Huynh <danct12@riseup.net>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] Revert "power: regulator: Add vin-supply for GPIO and
 Fixed regulators"
Message-ID: <20251103085135.GB1698@nxa18884-linux.ap.freescale.net>
References: <20251101203429.1603832-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101203429.1603832-1-jonas@kwiboo.se>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2P153CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096::19) To
 PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df75a8d-1765-45ea-1af2-08de1aac0dfb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6MR4+AA/gdy1jh6YbtbnMKZGOBzpb1u6FI8A/rBzubotbQVyuw/YI6WDvvH?=
 =?us-ascii?Q?QlzFGhKwPybVm3DxJESKxg/3aziPxp48JkJTIEd+obFRTh1lyuBhS9bW2yA2?=
 =?us-ascii?Q?rwzEptsKLFQ2uGwMc8Flvr3aRohm9nTAGszT1XnAzbY2Kt2NM/VNzBqDyz41?=
 =?us-ascii?Q?+2jX2ZodYc9qyILOuOMQg3ibbB6f7N1jbhgzRdJCPTaT2rtOanwagVtoy4XU?=
 =?us-ascii?Q?9sV6ZImB0VHpgN/RBl29H1Q2onA47x3EotID85dJ8M8juZb1ZnEiZSc77h83?=
 =?us-ascii?Q?vx4+yN2HvcYFaw7briBjSRdLU2/pozxipfHSPRWqPBN3Mxc6loBy6SR1PziC?=
 =?us-ascii?Q?MHP1Sc0NqZPmRLjMKa5UNWp330WjX1UgPQgH4Mnn5yi8hFA/4iqgBtJHH9fP?=
 =?us-ascii?Q?x9/GSMZE0USlVcRcIxauGty68tzUY5T3D+QI95EXwcoWeDBbJDkF5JX2dMFr?=
 =?us-ascii?Q?IVYnOxabGN3V78hpCtDVNywiohN/dfBARbXLoWQ7OdIBN+dCd/t8Dmht8X/B?=
 =?us-ascii?Q?zh85oHimffBO3a9vqm+USeOE6NfJcen68+4V/nugHFGzZSAWENkfEP4vDPfb?=
 =?us-ascii?Q?2f32EZnhwt2i6cgtPItJCh481gtJUtyd8ekJoeVCcwV0WGTi/p1CFWjA/dLK?=
 =?us-ascii?Q?HsN1DstL3BSz8Q59rklS7H5ueJxcT06Fr0B9e4XlIr3u62Ab6ocHHL6jZk4p?=
 =?us-ascii?Q?x2HNCuiXWmpp/kxDeCVm+Vh0b7YjlaiP1gjfFtmhMBDyltnTKIS5QI3RmiMh?=
 =?us-ascii?Q?L5P78pkgECgAvuc2EFZECpFxAd47zXXmPxphjHIJRSsgZNLwDX/lZhs3O121?=
 =?us-ascii?Q?WPyZL+oECXAUVhd0VMfQTkF8o74sUEdS/+k+ghz8GyQRYU4zTTCjDazUwaL7?=
 =?us-ascii?Q?IqiPESoAyXqB5e8hlTmAqwzHdbOwGziK64h21+PW5Cm5Bzs2P7gQxRh1NmQM?=
 =?us-ascii?Q?1UrjH4IRATV0KDsAsPygwqMFUA+14i9icVezFIQQA1yHpMgQfy6bqXaHrAF0?=
 =?us-ascii?Q?9hCmDuogonI4s1QyK86TvHFb5RxPoBiPFcUL5wJkROyi/xFTYAQSjQWa0bDS?=
 =?us-ascii?Q?5NxGC8sqaZcHJ7luKYRSSvusOhL45cGhx1UiHVD+TCrM6u4b7yVjJX8+ttOY?=
 =?us-ascii?Q?+uCFIzVnQUFnfKflzQrisHzig7VoMaTodgjg91rULJvwIKGgyGaEgnWsfGYE?=
 =?us-ascii?Q?PFzR32lANcb+hu7ZAnpLoCYeZRWhPL/xc36XI6zB30b2M2YQjQP3ZrchMs0F?=
 =?us-ascii?Q?qsdLlljEWjG0pbhiod/XaGpQuqQQFbdyTtpLkmdU0WubFSFFsFy2YVk+BNu3?=
 =?us-ascii?Q?gkZcEvBMhpuK6QOC46CM63pX4nNe7+SavRY4aniVsH4XGZjlNVkG5mJMWYUg?=
 =?us-ascii?Q?d4lYnrBGTWjiItzRxBKuA5bGfpi0DQZngJyExTBaTyd4NEnuytbYmYfjDIg4?=
 =?us-ascii?Q?JTu13wdMZBpKerDSeTlGorx8lbAIHlyE1nJgqOFYs9SG3knyvKMYBdzeR/Xw?=
 =?us-ascii?Q?gQF9AHJQIyo9Pm7aAhsyuELRFUl/jxsme28D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xkAUm3DvInZjTsNhoPAYzEHvmjarNvVe1A1/M9kvJjDW33H60OMbGpmcHaWD?=
 =?us-ascii?Q?JZjSK+R/O1jqGLAecnennI940dB+TxImVOgb3C+qw0c37JWDJEFraqlyMurp?=
 =?us-ascii?Q?jWU811REy5OlZ6y00BV66B88puSCbSlBO2pbZ/d2as9zsTs5QQxM/Y5bH422?=
 =?us-ascii?Q?p7nXNJdVOgU4FMhll5J7Bf8BOgngFHer5oB/OKOrIZKzndE3xnR5kZcB9ZBY?=
 =?us-ascii?Q?oL9KsVhIiLEzZZzrxOLs0YT5pr+/TH7LQG/UblXtJKGpVFhZmWgB9Pf3hr8x?=
 =?us-ascii?Q?5SxGDLuHmCuyd/PlxXcwO4MmoIgNfNE6mKdwYGAcE2B8rhJjrFDRvnJT1u57?=
 =?us-ascii?Q?evXpmFsyScWKaTL8T4RtHsmInGRi1+EUF5Fk0kB4ZvVz4lvvrDXkYsz3ku7j?=
 =?us-ascii?Q?yCDwFRrfS2xpY+Wx/CXQndiWPS0Ieqm5tjC9oNFPc/8elysUZoin8EP5nDkQ?=
 =?us-ascii?Q?lZRYv8BsGRcAOgKpWHYR6l4miEVC4PvrIvjI/0MKgLVVkGRsh1nHrXfA14Oz?=
 =?us-ascii?Q?X9nAlT0xNsauZ1Y5sgGJOrzj734ZQJ+jK3GQyTy0dLHwkXmfihmll82pel6G?=
 =?us-ascii?Q?kptKix5fRGvuNPShReuFOY+8fvPAS1BtQrNnvHVwPN2pOT7vY3HwVEHyrwxB?=
 =?us-ascii?Q?mEMF4Yp3p+8zxF6mUXphfriVlMH7ew5/iAIMIl8aMCJzZ8jcq0LuImQLK+t0?=
 =?us-ascii?Q?vI86veB1fZhZ7NDkDh6AYPPL8b1cK/JFjLrQYEiHyMyBOjJSpxWY+3OPX0Dl?=
 =?us-ascii?Q?1bsdSl224MX1QUJ2ccNbgMAakDvymUck9ZvT2rcSfpELPre6+JSzt/dwbjz9?=
 =?us-ascii?Q?RrTmmshUcXlPIKqvOoo3cpfSTKm2NZaYOahpLtWdw0QmyVZg++tXpUEPYXey?=
 =?us-ascii?Q?ZjRYCpEPdOtMXlcTnbkoKguWIYs/TB2smrSpheRI219sUWl4zR07kq/KaaN/?=
 =?us-ascii?Q?J8hWNu9kZ/LTTb3jsA/nBzTW87zIsFngpzInHMuqLq2SBiM4ijTdq15D7248?=
 =?us-ascii?Q?OlNsO0WJNZM7O7q8zkftvLeyfPaty1fqZj/3u+j0y0US4P7X1FADdLBzYQot?=
 =?us-ascii?Q?5/lmq9VhM3rt39D6Fu4AVjhomaWRjeMQ9Kx1UjH8KmKl13FcTuB1S71ziuPN?=
 =?us-ascii?Q?0KsJ/E9IAoDdqvrLtXD7VSZz0uC/Huz9g9/sGfi+3+T38Kiu9JzOO8rVi+fk?=
 =?us-ascii?Q?gOBhNepF9i+xISyJASfg+KQg5Pl5TrSW837watT8/u0xZo9pvV4loRi1O5F6?=
 =?us-ascii?Q?SBNVCKaBvNcrD+Xe/mwlm2QTa/bJCoxoOFYat4/tF5iNH3Wg2E/I++VwOdeY?=
 =?us-ascii?Q?QR3bw1R87GXlintFwC09h0ptVMcCGMiv+cNrYREFR86usoOAyy/dYy9quVx/?=
 =?us-ascii?Q?igT49tWvEWCEHSEkcqwBCAhUmDPMlcI7uJAgjzucUUdinkQo4gpkKLkXGQlK?=
 =?us-ascii?Q?z5Q4HrNDOMxArXhrG0UK83BGombZQdqT2KwKD1ym1ITlnm7WXKyPB6o93phx?=
 =?us-ascii?Q?iQMex/664UhU7m4XdqdGpfWbqsnv5vmZejYWY1lkqzMiAjafASB7OFtFjM3E?=
 =?us-ascii?Q?dS9WARDQRPkGCQKOJK6ugW9KVkU+jpfHQhfQ4hbM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df75a8d-1765-45ea-1af2-08de1aac0dfb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 07:39:00.6596 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZTGcMM7Lyy8Y6glcekCeXpb+tXB0iVw0xbRmrOJ7T6W7CoD1eiFiHTIHFu+5x0AE5LsBy7IIvnVLED0MfPHTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:21:42 +0100
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

On Sat, Nov 01, 2025 at 08:34:26PM +0000, Jonas Karlman wrote:
>Rockchip boards may depend on a working MMC regulator in SPL to
>successfully load FIT payload from MMC. Typically, these boards only
>include the vmmc-supply regulator and not its vin-supply in SPL control
>FDT.
>
>The commit f98d812e5353 ("power: regulator: Add vin-supply for GPIO and
>Fixed regulators") breaks loading FIT from MMC in SPL on some of these
>boards due to now requiring the vin-supply to be included in the SPL
>control FDT.
>
>The commit also strangely enables any found vin-supply in
>regulator_common_of_to_plat() and not when a regulator is enabled or as
>part of regulator_autoset().
>
>Revert the commit to fix FIT loading in SPL on broken boards.
>
>If a board needs to have its vin-supply enabled, two options come to
>mind:
>
>- Add regulator-always-on prop to the regulator in the -u-boot.dtsi for
>  any board.
>
>- Implement full support for reference counting of regulators and then
>  update the regulator-uclass to enable any found vin-supply when a
>  regulator is enabled.
>
>This reverts commit f98d812e5353408ef77a46bad1f1cdc793ff8a03.
>
>Reported-by: Dang Huynh <danct12@riseup.net>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>---
> drivers/power/regulator/regulator_common.c | 10 ----------
> drivers/power/regulator/regulator_common.h |  1 -
> 2 files changed, 11 deletions(-)
>
>diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
>index 3ed713ce5019..685d8735fa5c 100644
>--- a/drivers/power/regulator/regulator_common.c
>+++ b/drivers/power/regulator/regulator_common.c
>@@ -44,16 +44,6 @@ int regulator_common_of_to_plat(struct udevice *dev,
> 			dev_read_u32_default(dev, "u-boot,off-on-delay-us", 0);
> 	}
> 
>-	ret = device_get_supply_regulator(dev, "vin-supply", &plat->vin_supply);
>-	if (ret) {
>-		debug("Regulator vin regulator not defined: %d\n", ret);
>-		if (ret != -ENOENT)

I understand it might be not proper to enable vin-supply in
function regulator_common_of_to_plat().
But I have a question, there is -ENOENT check in the original patch. If the
board does not have vin-supply, there should be no issue. Or I miss something?

Thanks,
Peng

>-			return ret;
>-	}
>-
>-	if (plat->vin_supply)
>-		regulator_set_enable_if_allowed(plat->vin_supply, true);
>-
> 	return 0;
> }
> 
>diff --git a/drivers/power/regulator/regulator_common.h b/drivers/power/regulator/regulator_common.h
>index 799c968d0b66..d4962899d830 100644
>--- a/drivers/power/regulator/regulator_common.h
>+++ b/drivers/power/regulator/regulator_common.h
>@@ -14,7 +14,6 @@ struct regulator_common_plat {
> 	unsigned int startup_delay_us;
> 	unsigned int off_on_delay_us;
> 	unsigned int enable_count;
>-	struct udevice *vin_supply;
> };
> 
> int regulator_common_of_to_plat(struct udevice *dev,
>-- 
>2.51.0
>
