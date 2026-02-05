Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F7BE9129A
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2676383CB9;
	Thu,  5 Feb 2026 16:16:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZMmPmLYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 663B483CB9; Thu,  5 Feb 2026 16:16:52 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B05D83BF1
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLUwlTkSOvh3gbzB5K3GLazcridOuUvkJqI6k3ZDfevMumr0FwVW5zYBAXx4mdeCVNa8Ee1bKrPNxBm9jooyW9NWFjyLNHOv1Pvki2KBntlwwG698u+L+37BjqZT4XY4keVaCWkHvujWONmSDJWk6IaWggKfG6c8cZdBAr1l/qPDxI84wrOd4QUw8malOHeIzvH8PSJYIzLgf/0rsIEDd7wPL64oFGsnwUg58RdYr7jTx3HuE4cmG1s175+PbLvXVhOjIDp09dmtYjWMilXmEdLzyuzK7WyaU5fxrSO27j/zQRXvbJz8xh4VCRQzmRhCEbM6t6ZzR1MhjQGpM1FgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAMt91qyezw63FxDXgrd5S1y1ROIYLU3XzNSjmA3j1Q=;
 b=hP48McbhfY7/F9xAYRLk9MlYIe12qlbxPHm3Xajx6cSqcF8pHxZHf6d6Blw16rA8Jzi4XrhQtGgAA2isI5BulAYXPsefBmX4iKybTh6Np2fZhFZIiv7xUpkNFOhSUC+OQ7148LLpQCFy3Mkeq7bAarljUM+dLFHRGTeDld+2uOQ9XPxW9vA+r4+vqc1vsqKV/oL5/TfXDBs+Y4MERmEZ4yl8tcjekJKN6z13hZA0aN1Skdi5ztzxmAmarTHDPl2fTS54sGhDFqxejfmeCTDD0PAvA5afwCNfMU1Sart+r64P0tctRvXQ2BPUtSXRxH1ufARyTSvxzZPftbZvceVsXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAMt91qyezw63FxDXgrd5S1y1ROIYLU3XzNSjmA3j1Q=;
 b=ZMmPmLYavfXMdRlqvbwKo24v0HI4r3GXsCw6CVm4oP7dKhvsBbwUfgI2u7YRAF4dXOC0m+h0mcGNbCyrJwkRQeARs8MBHh4t1QkOiZ/c/xEGUaevwSKULo7njinCfHzdTWXLIik9pIKoW+jXgXPFTBYvStEg/gr4qK2xiujS+4ih0tG9WSjPwoGXywqoEYhOh/7q+akXbg2zjuuyjgBLfILxKtljURspCC4ULn+SIyFKNhcx8tBjVBjElQgcJUt5oSWqPlKs3VRHH2rKDIcaFMoHDlRwqVOHfEWUPkTC72uyT3uNEODMXmK1gFWxR/bRy5HIN95X3QzleSKaazIyvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB11038.eurprd04.prod.outlook.com (2603:10a6:150:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 15:16:40 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:16:40 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:18 +0800
Subject: [PATCH v1 12/12] board: nxp: imx952_evk: Add i.MX952 15x15 lpddr4x
 board support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-12-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB11038:EE_
X-MS-Office365-Filtering-Correlation-Id: 7695ddb9-1c95-4b69-fcb0-08de64c98fdb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|13003099007|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkNyK0R0WGtVaUd0UHZ3amxVTG5Zc1FnY0M5ZWV2MVhVVFQvNWF4TEhhY3BL?=
 =?utf-8?B?OCtPekxoY0hlbVRXMFZVcUpEWDdmWVFFc0ZFMlA0TGtLYXRGWkJsUkNRN0pn?=
 =?utf-8?B?SmltTjBtVTdxSFZZZ1NIbjExR09BcVVyNm0rNXpOandQcG5JTXZJTzRseFQ0?=
 =?utf-8?B?Ky9qb1R0U2U3bUdzL21tVlRqUk50NHVWM1RpeEZSMGhDdS9IZGZqTkJWb0JT?=
 =?utf-8?B?ZUZrZDk1WWswTnhsWEJPYWdFbUkvOURGTS9aUkpTSU40M3d1M3JGbFIvVDdk?=
 =?utf-8?B?dUtSVzhWdzFCaXZ1QXJzdG5YZU52ZitucjVaYmU4YkVkNHk2eVUwTUo1YnFm?=
 =?utf-8?B?N1I5VHdXQ05EL0JBN1ZGRi9WWlpyUlFqcWZWakVGbzFOYUhLbHdENVBmMzZr?=
 =?utf-8?B?ZGcvU0hlSStxQ2tHNnQ0MjREeVR1Wmo4dHNFK05SbnF3ZGk1djR0aTdGK2NY?=
 =?utf-8?B?UnhKQm1WWHE4d3plaHZnSGF5Z0NkTkpFNXliNWs1a2RQUnI0emwxZWVUVmlk?=
 =?utf-8?B?T3RuS2F3VlRJWDFBY3FDcTU5QVgyaUpoUW0zdWNDQVg2cFhTQ3NhbGNtc1dY?=
 =?utf-8?B?M2ptZzNrL2pGM1VBbzREaS9CRkV2NjNGM1VlbG9qMjNwSlJJT3NyZ3g3YlVU?=
 =?utf-8?B?Q2pmMUV0cE5tTDVtWGJCVkN5dHNxRFVTbkNMM1NKZWhoUmlnNEVxZFRPcnRI?=
 =?utf-8?B?cG84S3BVUVJVb1pIRFhpYnNKUjMveW9UaVVUbG9nNGNmRyt0dDU4TkI1aEta?=
 =?utf-8?B?MVlOcGtkRWo4TnB4aGU1RDY4S2NvcCthTXh5TGhCaVF6UGRydWdOOXpudmdq?=
 =?utf-8?B?dW5DRHVDSG1pOG43K00vaWJDNjUvWVZlUnhiK0ROWnJadWhHaWhVYkJsa1Zt?=
 =?utf-8?B?V3MwTUVBalR3cmVwWlZ2emFSRUVPdjlCOHBYZjFtUXgyN0VobEFlNUthQkF3?=
 =?utf-8?B?bzVlR1UxWVhMaFYxRzRZTnpBaXVvL2hRaC9rTUVBUGVpM3BGYWVLZTMzU0ty?=
 =?utf-8?B?UEtlTFBaNXFsaFdKSURCVU9NM1UrT1dUMndlblgvTVo4NitKTmlHbmF4Y1lj?=
 =?utf-8?B?RzBNemZSaDE0R2VERDRyVW1sM2hqRUNmY3puSUZkSWdoOFZkMmJYQjJKM01N?=
 =?utf-8?B?dnpOaHUwNmlTTnF6U1BpQ01Zb3BVV3lEdXY3RGRKZ1NYak5uRDRWdDN4Um50?=
 =?utf-8?B?bTUwTkZUNmlUek5CUmMvcm9HVXpaZkV0QzBaSVpWamEweW42QVlxbnZkUEwz?=
 =?utf-8?B?K0RUY1VlSmdCZ3pCOGdGMjFBUm1LeEhNRWd4YkRqYStOblFDbjZ4bTAwT0d0?=
 =?utf-8?B?dmZ2cEEwbVgrMjcwcjAyRVVoemVPdXdycHNoUW1vR2VoV0wybkFQVXlnOG8x?=
 =?utf-8?B?bmhoMGNiaDJ4MExVc0lyU2VSTkxFSGFXL3ZBNjg1eU1mTSt4NEl1M1NNU1NN?=
 =?utf-8?B?Wk5YTVNqK3czSzR5NUJjaGpkZ0hoa0pWdWFxNnUvMkxZYXlnTFc4NlZvYnJv?=
 =?utf-8?B?SVorN29qalVzcmcvajRoMXBmYjhoajByVkw2dXhXeDF6Mkgxakp2UzVtSmdh?=
 =?utf-8?B?ak1ka1BvWjl6TnFvRXlQSEUrWEYvc05lN0kwSnJ5Z1pNazl6d2NqaklHeTU4?=
 =?utf-8?B?MC9DWkRLVmkzQmo1T0ZpVFEzVkFUenBaNjgvczJSektuVnllblIvQUMrRkZU?=
 =?utf-8?B?dm80NkI0MGlCVXRwNHliWFViOFp2Z1VPNGw3cUNuUVNwLy8xVTFpajB4R0h3?=
 =?utf-8?B?Z1B2RW9zMzIrc3BUUmNjQnBCWUlDZi9YRFVwZ1ZNK1pKOWZZeUhjdjdvL0wv?=
 =?utf-8?B?alFURHNXakxySENKbXJ6NlF1Q0w4ZWhBSlpZODVJS2tzNjU4VGgyblFMTDNr?=
 =?utf-8?B?UlhWdE9uMWVnbW40SkRaZWxGWlRWUTFaVXBLWmJ3VUFad2JYK1ppOThqbCtr?=
 =?utf-8?B?YkpsNWY0b1U1aTVZVE1WaVVwY0JaZml0dGZ3TjNzeEFOQzFLcHJzT0FUL1Z4?=
 =?utf-8?B?L2tXMFlQdHo3MVlRMWM5WlFIYUJKWlhjMzBBbTdRcGhSbzZrWkIzb2Z0amZQ?=
 =?utf-8?B?RDZ5WEJ4VWZMeCtVWitqUzdDQkxqc25IeW54WDdKUmdzeXZBdjFudWpvb2Ux?=
 =?utf-8?B?eU5mRU5wcUVlQVpjbTFPZlU2L3QvRWlwcFJpY0RZbmhSK09TalVsZWZrdEZH?=
 =?utf-8?Q?a3ajCchrEsO6i8SjI0wJlCvr0Qt5O7Nd9tnv1U//JdP5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(13003099007)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFTblhuUHBhWmJ2WXJnOTB6NEMwT0tqbHRteE9IaW42cWdmN2FmaFpKSjVV?=
 =?utf-8?B?U2NlK3d3bVZtQzhad2UwMUJtelN2Rk90dkNURHNrbnREUitnd2RxY0FCdUQ0?=
 =?utf-8?B?ZjhDQnBTNmRqK1BWc1lmblBEamxrL1gyQzl6c1k2dmE3RjNBQTFhTWFtNHk5?=
 =?utf-8?B?dGtwbDVsMURVbDkrRFVyRGRrMExZUUdFbXNuOFlVZFBYSUFrbXNia0ovUmZ5?=
 =?utf-8?B?dzBsc0NGN3QvQlZLV01HUExpbUMvODY0allnUC9vYk9jQjlQSnVoL0NjZXdj?=
 =?utf-8?B?d3QycS9PQ25rNC8rM1pCT3l5TmtBbmlIT2JJTldIK1VISytMNWlOK1RJMTRJ?=
 =?utf-8?B?VWJ4OEJUR29obGtOdG96RzV4M3p4L1VuTVY5Z1hUemtBa2F0b3RXOHVLOHRY?=
 =?utf-8?B?RzJKZWY1ZkZBMjBPTllqbCtSSmcyMWR5U3N4YWpHTlhwLzQ2c1JDVWg2U21p?=
 =?utf-8?B?M0NkRHoyYjdjeUY2WjdMOHFORWxUQVlicW5mR3NkaTlNQ1dTNDY3NkpZTHNQ?=
 =?utf-8?B?WmV2eFZ6Y2FoMEszajBxUXpPb3kydjdtclJnckFhdUZ3RlRsMmhRQzZBS1lY?=
 =?utf-8?B?ODRtaXVVajNuV0RpblNidHZhSkVsVmdObkVRTVRMZEJocktWVXhzR1ZVTnJn?=
 =?utf-8?B?L1lnTVI4c3d2Y2g3cEFMbDZsWTk0cHAva29CODh4R2g3VlRCTG9JSDh2b0VU?=
 =?utf-8?B?UmpaT3JpRGc1NG5qc1MzMGZBa1gxR2NnUmQyRm1lY2E3M1V4VHZVeUU1OFk2?=
 =?utf-8?B?ZmdFaklXajUvQ2ppbmlRc1U1MjJUZTF2cHRFK2lVVDRVT1Z2RWxPdUVUUEZY?=
 =?utf-8?B?Z21lOHluaGgzd29PTG1yaG5LMThCZmhWY08xK1VmT3hQeTRON3NqYS9LaEND?=
 =?utf-8?B?NHNHMWtFWk5ONFg4RFpHOXNXbWtJQ25JcWFYYTNGdURBSkhzNVNZTUVrRllZ?=
 =?utf-8?B?VmtrTHdrU0RFZkJyKzhEQ0FiUmE4ZDY5aURhMHBxOU1BbklxcTRzamV2NzQ0?=
 =?utf-8?B?czZDUE9RZis5UkFFM1IzYWRpUCtueVFnWlJWVElEbDZZY0t0YStpbVh0VVRa?=
 =?utf-8?B?NkhjY3U5dlVkZlBSOXRSRjVFVU9oVG1zRGJwU0N5aEh0aVc5NWUyNXB6Sjg0?=
 =?utf-8?B?WkhSZlRpdHRJMHZQaDJzMTdOYUQ2SVhOZTRxMHlXVjNESVdWakQwN2JXdzZF?=
 =?utf-8?B?VVdjSzhnYnJac29ic2tqSkpOdXFkSE1Cc0VnSTlCRmRZMlpIclF5NWdBTHpB?=
 =?utf-8?B?b0IwajNFUDIvMm9PWjFoY1dIc0lMRzZEdWF4S09hbUZSbnA5K0RBdWVrOUpL?=
 =?utf-8?B?ZUlLR0YrdTRUclZweDljTHRzMDR6b0E0TzhwWE1sOStyUmZrbDhXZEJuQWMy?=
 =?utf-8?B?S0xnQkxoNnFhemJIVzc0OHhTaDdmSUdoRFcrMFg5NzhIeUEzeDgrTGs1YlFy?=
 =?utf-8?B?cW5naUZrcjh0S1JQSjM1b0t3emNmVXp4eDhmOHgrVjNiSHRYUjFKQVdnYTE3?=
 =?utf-8?B?Mmpnd2hqR2hja1pjamZQeVMzMjB1VWd3RWZpRkdDblBDaUFBaGNNeTVYWGJW?=
 =?utf-8?B?RDNzYUVXckQ5YS9hdVdnQjlzM2x5L0N2NUFwZmZBME0vbTN6WTJSQ05GTlJx?=
 =?utf-8?B?dUdaZUtVSjdNditjbTh5SThtMFV4SFRUL0NMSi81RUt5elBZeDRHSnh2YnJG?=
 =?utf-8?B?N3hIWXQxaEtSLzdNVHhnc2hFWlNoelQ2NGp4OUVSTld0TGR1MGZxRC84MnVi?=
 =?utf-8?B?c3VuWS9WaUhpNkt3V0hzdlpZdSt5c09RR1IvSVlqU042MjJjS3g4MzFRWHNO?=
 =?utf-8?B?aEloaGE1QXV3UEJhNUczNlNRVk1zb1ZMQ2lvSUJhNEdMMDFEaC9xZlordXNr?=
 =?utf-8?B?Q2ZJNTlrTFF5T01WSGthTlBqN093Qk5rVkd5TGxiMFJmM3IvQ2pLSDlmVDlq?=
 =?utf-8?B?amlQVGdhRGFXdENkRXpvK0FlOTEyNUo2WFJnSjd2emFyVWppd256YXNtVGxO?=
 =?utf-8?B?aFpEREpYVXowUE5OTGZnWVJTMGh0TUtVTk9HUC9MY0taYnQ3Y1RhVE83M0ZZ?=
 =?utf-8?B?U0dTTDNNRVJ4c0M4SUxvK2UyeDd5a09ReFF1alVQRFo0WUZnMHVCWUF0eTVl?=
 =?utf-8?B?WFREUUE5eWFmVVBhNE9zelBIdlBpcHVWOHE3aVhCMzRsMldJS0t3MDhIcjJp?=
 =?utf-8?B?U3hpOE1UN29BRjFjYjZaa3Ztakh1aDhodjBYeHI3Z0p3eUdpQ01kWEtNQ1JD?=
 =?utf-8?B?V1ZOakFHK3hld01kdEREamhsRDV3SDMwRktldnZnMlE5em13bWNKUTJpVTl5?=
 =?utf-8?B?cXEvdHN5KzdmYVkvWElJcWJCOThIVVhackVPRWxCSzNOejlDTkVmdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695ddb9-1c95-4b69-fcb0-08de64c98fdb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:16:39.9826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BM9TxrsUGdR7Q2m8XTCW51VnU0CWzTGGW785vWz94HT94XCwNK42ItSinIaaIBAMuegmduNrAb1eqQGEj4iczQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11038
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

From: Peng Fan <peng.fan@nxp.com>

Add support for i.MX952 15x15 lpddr4x board support.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Makefile          |   2 +-
 arch/arm/mach-imx/imx9/Kconfig      |  14 ++
 board/nxp/imx952_evk/Kconfig        |  12 ++
 board/nxp/imx952_evk/MAINTAINERS    |   6 +
 board/nxp/imx952_evk/Makefile       |  14 ++
 board/nxp/imx952_evk/imx952_evk.c   | 297 ++++++++++++++++++++++++++++++++++++
 board/nxp/imx952_evk/imx952_evk.env | 137 +++++++++++++++++
 board/nxp/imx952_evk/spl.c          | 115 ++++++++++++++
 configs/imx952_evk_defconfig        | 178 +++++++++++++++++++++
 doc/board/nxp/imx952_evk.rst        | 112 ++++++++++++++
 doc/board/nxp/index.rst             |   1 +
 include/configs/imx952_evk.h        |  31 ++++
 12 files changed, 918 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 0f6e737c0b9..bf6820de655 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -223,7 +223,7 @@ endif
 
 ifeq ($(CONFIG_ARCH_IMX9)$(CONFIG_ARCH_IMX8ULP), y)
 
-ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94))),)
+ifneq ($(and $(CONFIG_BINMAN),$(or $(CONFIG_IMX95),$(CONFIG_IMX94),$(CONFIG_IMX952))),)
 SPL: spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkimage)
 
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 716940930a6..2ba088c49c5 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -162,6 +162,19 @@ config TARGET_TORADEX_SMARC_IMX95
 	bool "Support Toradex SMARC iMX95"
 	select IMX95
 
+config TARGET_IMX952_EVK
+	bool "imx952_evk"
+	select CMD_REMOTEPROC
+	select IMX_SM_CPU
+	select IMX_SM_LMM
+	select IMX952
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/nxp/imx91_evk/Kconfig"
@@ -175,5 +188,6 @@ source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
+source "board/nxp/imx952_evk/Kconfig"
 
 endif
diff --git a/board/nxp/imx952_evk/Kconfig b/board/nxp/imx952_evk/Kconfig
new file mode 100644
index 00000000000..96f01323aca
--- /dev/null
+++ b/board/nxp/imx952_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX952_EVK
+
+config SYS_BOARD
+	default "imx952_evk"
+
+config SYS_VENDOR
+	default "nxp"
+
+config SYS_CONFIG_NAME
+	default "imx952_evk"
+
+endif
diff --git a/board/nxp/imx952_evk/MAINTAINERS b/board/nxp/imx952_evk/MAINTAINERS
new file mode 100644
index 00000000000..cc004f9467e
--- /dev/null
+++ b/board/nxp/imx952_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX952 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/nxp/imx952_evk/
+F:	include/configs/imx952_evk.h
+F:	configs/imx952_evk_defconfig
diff --git a/board/nxp/imx952_evk/Makefile b/board/nxp/imx952_evk/Makefile
new file mode 100644
index 00000000000..1581721dc78
--- /dev/null
+++ b/board/nxp/imx952_evk/Makefile
@@ -0,0 +1,14 @@
+#
+# Copyright 2025-2026 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+# Add include path for NXP device tree header files from Linux.
+ccflags-y += -I$(srctree)/dts/upstream/src/arm64/freescale/
+
+obj-y += imx952_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/nxp/imx952_evk/imx952_evk.c b/board/nxp/imx952_evk/imx952_evk.c
new file mode 100644
index 00000000000..8b4b2083a20
--- /dev/null
+++ b/board/nxp/imx952_evk/imx952_evk.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <dm/uclass.h>
+#include <dm/uclass-internal.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <imx952-power.h>
+#include <init.h>
+#include <linux/delay.h>
+#include <power/regulator.h>
+#include <scmi_agent.h>
+#include <usb.h>
+
+#define PD_HSIO_TOP IMX952_PD_HSIO_TOP
+#define PD_NETC IMX952_PD_NETC
+#define PD_DISPLAY IMX952_PD_DISPLAY
+#define PD_CAMERA IMX952_PD_CAMERA
+
+#if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
+#define IMX_BOOT_IMAGE_GUID \
+	EFI_GUID(0x58a661f3, 0xe7c7, 0x4173, 0x80, 0x21, \
+		0xa3, 0x1b, 0x95, 0xc8, 0x6e, 0x9b)
+
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = IMX_BOOT_IMAGE_GUID,
+		.fw_name = u"IMX952-EVK-RAW",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0=flash-bin raw 0 0x2000 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+#ifdef CONFIG_USB_TCPC
+struct tcpc_port port;
+struct tcpc_port_config port_config = {
+	.i2c_bus = 6, /* i2c7 */
+	.addr = 0x50,
+	.port_type = TYPEC_PORT_DRP,
+	.disable_pd = true,
+};
+
+static int setup_typec(void)
+{
+	int ret;
+
+	debug("tcpc_init port 1\n");
+	ret = tcpc_init(&port, port_config, NULL);
+	if (ret) {
+		printf("%s: tcpc port init failed, err=%d\n",
+		       __func__, ret);
+	}
+
+	return ret;
+}
+#endif
+
+static int imx9_scmi_power_domain_enable(u32 domain, bool enable)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	return scmi_pwd_state_set(dev, 0, domain, enable ? 0 : BIT(30));
+}
+
+int board_usb_init(int index, enum usb_init_type init)
+{
+	int ret = 0;
+
+	if (index == 0 && init == USB_INIT_DEVICE) {
+		ret = imx9_scmi_power_domain_enable(PD_HSIO_TOP, true);
+		if (ret) {
+			printf("SCMI_POWWER_STATE_SET Failed for USB\n");
+			return ret;
+		}
+	} else if (index == 0 && init == USB_INIT_HOST) {
+		return ret;
+	}
+
+	return 0;
+}
+
+int board_usb_cleanup(int index, enum usb_init_type init)
+{
+	int ret = 0;
+
+	if (index == 0 && init == USB_INIT_HOST) {
+#ifdef CONFIG_USB_TCPC
+		ret = tcpc_disable_src_vbus(&port);
+#endif
+	}
+
+	return ret;
+}
+
+static void netc_phy_rst(const char *gpio_name, const char *label)
+{
+	int ret;
+	struct gpio_desc desc;
+
+	/* ENET_RST_B */
+	ret = dm_gpio_lookup_name(gpio_name, &desc);
+	if (ret) {
+		printf("%s lookup %s failed ret = %d\n", __func__, gpio_name, ret);
+		return;
+	}
+
+	ret = dm_gpio_request(&desc, label);
+	if (ret) {
+		printf("%s request %s failed ret = %d\n", __func__, label, ret);
+		return;
+	}
+
+	/* assert the ENET_RST_B */
+	dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE | GPIOD_ACTIVE_LOW);
+	udelay(10000);
+	dm_gpio_set_value(&desc, 0); /* deassert the ENET_RST_B */
+	udelay(80000);
+}
+
+void netc_init(void)
+{
+	int ret;
+
+	ret = imx9_scmi_power_domain_enable(PD_NETC, false);
+	udelay(10000);
+
+	/* Power up the NETC MIX. */
+	ret = imx9_scmi_power_domain_enable(PD_NETC, true);
+	if (ret) {
+		printf("SCMI_POWWER_STATE_SET Failed for NETC MIX\n");
+		return;
+	}
+
+	netc_phy_rst("i2c6_io@21_13", "ENET1_RST_B");
+
+	pci_init();
+}
+
+static void pcie_setup(void)
+{
+	int ret;
+	struct udevice *dev;
+
+	ret = regulator_get_by_devname("regulator-m2-pwr", &dev);
+	if (ret) {
+		printf("Get regulator-m2-pwr regulator failed %d\n", ret);
+		return;
+	}
+
+	ret = regulator_set_enable_if_allowed(dev, true);
+	if (ret) {
+		printf("Enable regulator-m2-pwr regulator %d\n", ret);
+		return;
+	}
+}
+
+void lvds_backlight_on(void)
+{
+	/* None */
+}
+
+int board_init(void)
+{
+	int ret;
+
+	ret = imx9_scmi_power_domain_enable(PD_HSIO_TOP, true);
+	if (ret) {
+		printf("SCMI_POWWER_STATE_SET Failed for USB\n");
+		return ret;
+	}
+
+	imx9_scmi_power_domain_enable(PD_DISPLAY, false);
+	imx9_scmi_power_domain_enable(PD_CAMERA, false);
+
+#if defined(CONFIG_USB_TCPC)
+	setup_typec();
+#endif
+
+	pcie_setup();
+
+	netc_init();
+
+	lvds_backlight_on();
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	env_set("sec_boot", "no");
+#ifdef CONFIG_AHAB_BOOT
+	env_set("sec_boot", "yes");
+#endif
+
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	char *p, *b, *s;
+	char *token = NULL;
+	int i, ret = 0;
+	u64 base[CONFIG_NR_DRAM_BANKS] = {0};
+	u64 size[CONFIG_NR_DRAM_BANKS] = {0};
+
+	p = env_get("jh_root_mem");
+	if (!p)
+		return 0;
+
+	i = 0;
+	token = strtok(p, ",");
+	while (token) {
+		if (i >= CONFIG_NR_DRAM_BANKS) {
+			printf("Error: The number of size@base exceeds CONFIG_NR_DRAM_BANKS.\n");
+			return -EINVAL;
+		}
+
+		b = token;
+		s = strsep(&b, "@");
+		if (!s) {
+			printf("The format of jh_root_mem is size@base[,size@base...].\n");
+			return -EINVAL;
+		}
+		base[i] = simple_strtoull(b, NULL, 16);
+		size[i] = simple_strtoull(s, NULL, 16);
+		token = strtok(NULL, ",");
+		i++;
+	}
+
+	ret = fdt_fixup_memory_banks(blob, base, size, CONFIG_NR_DRAM_BANKS);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+#endif
+
+void board_quiesce_devices(void)
+{
+	int ret;
+	struct uclass *uc_dev;
+
+	ret = imx9_scmi_power_domain_enable(PD_HSIO_TOP, false);
+	if (ret) {
+		printf("%s: Failed for HSIO MIX: %d\n", __func__, ret);
+		return;
+	}
+
+	ret = imx9_scmi_power_domain_enable(PD_NETC, false);
+	if (ret) {
+		printf("%s: Failed for NETC MIX: %d\n", __func__, ret);
+		return;
+	}
+
+	ret = uclass_get(UCLASS_SPI_FLASH, &uc_dev);
+	if (uc_dev)
+		ret = uclass_destroy(uc_dev);
+	if (ret)
+		printf("couldn't remove SPI FLASH devices\n");
+}
+
+#ifdef CONFIG_FSL_FASTBOOT
+#ifdef CONFIG_ANDROID_RECOVERY
+int is_recovery_key_pressing(void)
+{
+	return 0;
+}
+#endif /*CONFIG_ANDROID_RECOVERY*/
+#endif /*CONFIG_FSL_FASTBOOT*/
diff --git a/board/nxp/imx952_evk/imx952_evk.env b/board/nxp/imx952_evk/imx952_evk.env
new file mode 100644
index 00000000000..6ecaf9724c1
--- /dev/null
+++ b/board/nxp/imx952_evk/imx952_evk.env
@@ -0,0 +1,137 @@
+#ifdef CONFIG_ANDROID_SUPPORT
+splashpos=m,m
+splashimage=0x9FFF0000
+emmc_dev=0
+sd_dev=1
+#else
+
+#ifdef CONFIG_AHAB_BOOT
+sec_boot=yes
+#else
+sec_boot=no
+#endif
+
+jh_root_dtb=imx952-evk-root.dtb
+jh_mmcboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe;
+	setenv jh_root_mem 0x58000000@0x90000000,0x300000000@0x180000000;
+	if run loadimage; then
+		run mmcboot;
+	else run jh_netboot; fi;
+jh_netboot=setenv fdtfile ${jh_root_dtb};
+	setenv jh_root_mem 0x58000000@0x90000000,0x300000000@0x180000000;
+	setenv jh_clk kvm.enable_virt_at_load=false cpuidle.off=1 clk_ignore_unused kvm-arm.mode=nvhe; run netboot;
+
+domu-android-auto=no
+xenhyper_bootargs=console=dtuart dom0_mem=4096M dom0_max_vcpus=2 pci-passthrough=on
+xenlinux_bootargs=
+xenlinux_console=hvc0 earlycon=xen
+xenlinux_addr=0x9c000000
+dom0fdt_file=CONFIG_DEFAULT_FDT_FILE
+xenboot_common=${get_cmd} ${loadaddr} xen;
+	${get_cmd} ${fdt_addr} ${dom0fdt_file};
+	${get_cmd} ${xenlinux_addr} ${image};
+	fdt addr ${fdt_addr};
+	fdt resize 256;
+	fdt mknode /chosen module@0;
+	fdt set /chosen/module@0 reg <0x00000000 ${xenlinux_addr} 0x00000000 0x${filesize}>;
+	fdt set /chosen/module@0 bootargs "${bootargs} ${xenlinux_bootargs}";
+	fdt set /soc/bus@49000000/iommu@490d0000 status disabled;
+	fdt set /chosen/module@0 compatible "xen,linux-zimage" "xen,multiboot-module";
+	setenv bootargs ${xenhyper_bootargs};
+	booti ${loadaddr} - ${fdt_addr};
+xennetboot=setenv get_cmd dhcp;setenv console ${xenlinux_console};setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused;run netargs;run xenboot_common;
+xenmmcboot=setenv get_cmd "fatload mmc ${mmcdev}:${mmcpart}";setenv console ${xenlinux_console};setenv jh_clk kvm.enable_virt_at_load=false clk_ignore_unused;run mmcargs;run xenboot_common;
+
+sr_ir_v2_cmd=cp.b ${fdtcontroladdr} ${fdt_addr_r} 0x10000; fdt addr ${fdt_addr_r};
+	fdt set /soc/bus@44000000/mailbox@445b0000/sram@445b1000/scmi-sram-section@0 reg <0x00000000 0x00000080>;
+	fdt rm /soc/mailbox@47530000;
+	fdt rm /soc/usb@4c010010;
+
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_args pd_ignore_unused;
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=booti ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			run auth_os;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_args} console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			run auth_os;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
+
+#endif
diff --git a/board/nxp/imx952_evk/spl.c b/board/nxp/imx952_evk/spl.c
new file mode 100644
index 00000000000..d36c3a46b5e
--- /dev/null
+++ b/board/nxp/imx952_evk/spl.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <linux/delay.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+	case USB2_BOOT:
+		return BOOT_DEVICE_BOARD;
+	case QSPI_BOOT:
+		return BOOT_DEVICE_SPI;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+static void xspi_nor_reset(void)
+{
+	int ret;
+	struct gpio_desc desc;
+
+	ret = dm_gpio_lookup_name("GPIO5_11", &desc);
+	if (ret) {
+		printf("%s lookup GPIO5_11 failed ret = %d\n", __func__, ret);
+		return;
+	}
+
+	ret = dm_gpio_request(&desc, "XSPI_RST_B");
+	if (ret) {
+		printf("%s request XSPI_RST_B failed ret = %d\n", __func__, ret);
+		return;
+	}
+
+	/* assert the XSPI_RST_B */
+	dm_gpio_set_dir_flags(&desc, GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE | GPIOD_ACTIVE_LOW);
+	udelay(200); /* 50 ns at least, so use 200ns */
+	dm_gpio_set_value(&desc, 0); /* deassert the XSPI_RST_B */
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	xspi_nor_reset();
+
+	board_init_r(NULL, 0);
+}
+
+#ifdef CONFIG_ANDROID_SUPPORT
+int board_get_emmc_id(void)
+{
+	return 0;
+}
+#endif
diff --git a/configs/imx952_evk_defconfig b/configs/imx952_evk_defconfig
new file mode 100644
index 00000000000..59de9ee0333
--- /dev/null
+++ b/configs/imx952_evk_defconfig
@@ -0,0 +1,178 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx952_evk"
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_SF_DEFAULT_SPEED=200000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx952-evk"
+CONFIG_TARGET_IMX952_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL_OF_LIBFDT_ASSUME_MASK=0x0
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx952-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x30000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_OPTEE_RPMB=y
+CONFIG_CMD_OPTEE=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+# CONFIG_BOOTDEV_ETH is not set
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+# CONFIG_SCMI_AGENT_OPTEE is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_PSCI=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx952_evk.rst b/doc/board/nxp/imx952_evk.rst
new file mode 100644
index 00000000000..9f20db2403f
--- /dev/null
+++ b/doc/board/nxp/imx952_evk.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx952_evk
+=======================
+
+U-Boot for the NXP i.MX952 15x15 LPDDR4X EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://nl2-nxrm.sw.nxp.com/repository/IMX_Yocto_Internal_Mirror_Recent/firmware-ele-imx-2.0.5-50c4793.bin
+   $ sh firmware-ele-imx-2.0.5-50c4793.bin --auto-accept
+   $ cp firmware-ele-imx-2.0.5-50c4793/mx952a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://nl2-nxrm.sw.nxp.com/repository/IMX_Yocto_Internal_Mirror_Recent/firmware-imx-8.32-c0491e4.bin
+   $ sh firmware-imx-8.32-c0491e4.bin --auto-accept
+   $ cp firmware-imx-8.32-c0491e4/firmware/ddr/synopsys/lpddr4x*v202409.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: lf-6.18.2-imx952-er1
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone https://github.com/nxp-imx/imx-oei/ -b lf-6.18.2-imx952-er1
+   $ cd imx-oei
+   $ make board=mx952lp4x-15 oei=ddr DEBUG=1 all
+   $ cp build/mx952lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: lf-6.18.2-imx952-er1
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/14.2.rel1/binrel/arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-14.2.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone https://github.com/nxp-imx/imx-sm/ -b lf-6.18.2-imx952-er1
+   $ cd imx-sm
+   $ make config=mx952evk all
+   $ cp build/mx952evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf-6.18.2-imx952-er1
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ git clone https://github.com/nxp-imx/imx-atf/ -b lf-6.18.2-imx952-er1
+   $ cd imx-atf
+   $ make PLAT=imx952 bl31
+   $ cp build/imx952/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx952_evk_defconfig
+   $ make
+
+Copy flash.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX952 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 01d3468a47d..8cd24aecf33 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -19,6 +19,7 @@ NXP Semiconductors
    imx93_frdm
    imx943_evk
    imx95_evk
+   imx952_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx952_evk.h b/include/configs/imx952_evk.h
new file mode 100644
index 00000000000..dadc883027f
--- /dev/null
+++ b/include/configs/imx952_evk.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025-2026 NXP
+ */
+
+#ifndef __IMX952_EVK_H
+#define __IMX952_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR		0x90000000
+#define CFG_SYS_INIT_RAM_SIZE		0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM			0x90000000
+
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55, SPL could use first 2MB */
+#define CFG_SYS_SECURE_SDRAM_SIZE	0x06000000
+
+#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
+
+#ifdef CONFIG_ANDROID_SUPPORT
+#include "imx952_evk_android.h"
+#endif
+
+#endif

-- 
2.43.0

