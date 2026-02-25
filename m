Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F547F55434
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECCB83F1F;
	Wed, 25 Feb 2026 01:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nigI3lpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5C383F14; Wed, 25 Feb 2026 01:14:44 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8803D83EDF
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DYvtTe99b/G+4f3MygiYoJMeD3BEJAe+s/rB/ByX9y/KxR8rX7y3sIXLxrQZtEaBsqG8Vl+mFHfPTEdJficvKr26UkMxLYzv982cUFnLkoK68nHYpDljbpo/HaRIf4+0O57RTZAyJ0/GBq+fq1VsGCcJ61WkwFWD9uUyK4RqdzAqHZNRZVqX+WKoGE0Wbw1knFuszBxqEMXPsn8GVPOC/9LrCabTwJ1KIN+NHdVD5JHrcoqMVGy7zEytTDkyqc67V4FQefPnp1W1GN9Txn3OTynQLYSLl/ARQG/MSEhuHzqRjD1uKUrLsro0IpuJiIuIYK+G3eZvM7s80vzwH7cS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaWeiiHIdR/JyHdvJWOZ9qxc1KTeEQrEUA002dqou6c=;
 b=vTEa9HtY7WIWFuBTI3zL4hTPOYLkNP59GnMNT75zNRHN3PdJeImhT6SAB22jKRG0f8zQ6gQYsqloEOzsTcJueLMAKL/GxfftQto2ZuTQ0eGYZXnQB7yVGz9E+IEZs5ijD17XcPxv5Y2exZeitqfKxYn80XMadh0P5OMjoyV2wPcKUJofGCfBeg2fJvx0oPJREbNhoDdZD8F4ZvWZpFmH5J+Vc1ylrmBAwdOyAk5tchGmEYBbnTg4idmpL2Vj+fi6jE0+WjoBXP698Z+1Ue2oDJNR9xtvHu0kTGIIxEedSK9Sbk0ZgDdlqyiFyvTMdeQRZcpCojMSmsvwnDJRNHeaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaWeiiHIdR/JyHdvJWOZ9qxc1KTeEQrEUA002dqou6c=;
 b=nigI3lpEGZ9nMZJZ52GfqPunIRUj114Ucya/9c2GEc2iUkFYHCyPe7He1kQ3PaaBge9kB3JTpcC/x/wvrnO/p7TiJDu7knEhiFCylUmcL0i5cm+yJmQTibANCLXLpPA8O21feCKKTe6cNQ54Ci+hY922qKA4mlnv6jymA2NgSMXWok+cmID4Rc3OC9XxQ59iM1D5AbM49u+Jrolj+52WqqOTvKrwnT7uaX+GpVdyZ9OPS+0lEQQb5hLeGjigxfG+M+LnAMvRpj98vD4yitCx6t5m5A3sd4LhluXTycWiwRKGMkpDx4LrWKOeG2aSIG+7FnTiVNduGPRLa3wxUS2lgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:36 +0800
Subject: [PATCH 10/10] pinctrl: nxp: imx9: Guard pinctrl match table with
 CONFIG_IMX9[X]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-10-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: b82589bb-0a2d-4ebf-ec0e-08de7402de9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WFhwaDI0ZUhYblRBYXJzWGltMm5KNWpGZVVUY3BJM2VQSWNTYWlReTd4VUxH?=
 =?utf-8?B?TUNqWHYxOHE2a2xGeVg5UGl3emdXZEl3Ni9neUowWXBqbFBrMGsreXhud3R6?=
 =?utf-8?B?Z2FyMkRZOXJyZ3VqTDRQZy9zaDl5OEE3eW5Ba0puWU5EZ296VDRKazlMc09B?=
 =?utf-8?B?QStIemN6cVl6dWtwSUI5UUNvbkpVdkFVMXowNjJZcXMyTDFYR2xXY25HSWVH?=
 =?utf-8?B?L1dRRHZRbnRXc25hOHVGM3R6WmdadVBMaTR3b0tVTVdFQ2RhNnpid3gxYWpJ?=
 =?utf-8?B?YUc2MGo4akIyaTlqdGY2eWJxMTc4Y2tjbFQ5U1FGNmJ3eFhkZUZIUEwxSzA1?=
 =?utf-8?B?TFFra2ltV3BUR1crYmNrNUxQcEdwRmVQWkNmcWFMSWNxSGVsRDl5c3VhQlBJ?=
 =?utf-8?B?WXhsYXBDZ2R5WS9WemNlbjZUZVRlQTBBSmhYbjJoYkI5cmZIUTgyR0tMKzFx?=
 =?utf-8?B?aDRHYSt5anZRMGFyZlBqVTl6eHlWc2IwVi9aSkFIRmU2Qi9haDNkOFdoN0ZD?=
 =?utf-8?B?djhBd0VsTks3ZVg3TkdwcFpMOC9RL3l6b3lCZUMvRWFFd0N3VHpUZjFERnBq?=
 =?utf-8?B?TmhtVUt6Qll2eGhnYzRRSVlUakkxN0JEdndGL054bWU1SGJOK3F5Sk80YlZK?=
 =?utf-8?B?OU4xOS9OaFVHbFNFeEtxQk9TenVuNEo2RzByUGhUcTY4alNZZERxamhWNGNq?=
 =?utf-8?B?Zm1HQ3FQYmFCcWdvdDVWelJGUU9Qd1p5YllSeHFxV3o4VFhrRi9WVXJxQU9V?=
 =?utf-8?B?THRudXJMQ1gyc3JwZEpzb25oc1R2MndEeWkxaG5wSHBNZ0tNTDhVU3V6aTln?=
 =?utf-8?B?RXlaaEVHL3poREhjNmZmMjBWV25zNWx5OFVycWtxUFJWbnZHUWNkaFMrSG1p?=
 =?utf-8?B?T2VodnprSmRML3VyYnRnUjlLanhWelpOaWgvelYxWDl5ajdhQmNNbnRhSFJE?=
 =?utf-8?B?UitucWhMU1JZQVJKUWdxRDBKdU5TeVBOakxoaG1HbjJYSWlrY0s0Rk9Xemtw?=
 =?utf-8?B?WFFCU3dabHRSMUp0ZDNsSTF5QnIzYW9EdWxSSG5YM1RXVHZZTUxQZUdiZVoy?=
 =?utf-8?B?WTBrclJMVnBjWTU2SFVEaS9vMk56em9JK1QxOThSRy82SkhSTlliU2o3VVBJ?=
 =?utf-8?B?TXU0dkkycnRlc2ZyZkZtSjVUVDJVZ0p2aHlHODVYVDJHTDZ0TEIwR1VwV09S?=
 =?utf-8?B?TFNsaUJiL0VKaS9lYWVubWtPdnpOQnZFMkJpdHRGRWE3QUVxL3gzekp1RXdy?=
 =?utf-8?B?SXFSRzFSRnp4dlU1bThtZmdLa0dmc0poVXdUQjgzZnhCVFUrendZNE11b3Vl?=
 =?utf-8?B?dEZrbTlQLytyeEE2c0JwSm5vZjUxOWt4VE96RmtqS3Q5QWN3MTNQY202WC9M?=
 =?utf-8?B?cjQ5WFVrRlVHcGZqQlExczU3QmZ2QURKeXdIVVQxa1hFREh1cFQ4bFZ1cER5?=
 =?utf-8?B?QzFxa3VheUt6QzlDZldsSFRtUTZVYXZsOUNMN1Z4RGtiTWx0SmFzUGFSVDFa?=
 =?utf-8?B?SXBPMGxZdHdldnpPcmxmbklOUURycmRHb1E0aS9FaHdZTlRFcUpSUXZsTElp?=
 =?utf-8?B?VklINE1EcnhLNzZaU3FiemxBa3JETlBtczRsZ3o3bkpXK0pBcm96cU9pV1Fy?=
 =?utf-8?B?UCtqV1p3SVJ4UW5POHV2RHBBTmVkbnE4NjNNaklqTXk5em5GNDhzVlI5eHdy?=
 =?utf-8?B?VW1PYWcvcVFsSzMweWZaMGVGY0FLS2FNVDVmbW9zZTFaeGhhNGN0ZUpaYWxR?=
 =?utf-8?B?aDNVMEwxNGJWUEk1dXVJMllsbHRhd2srVTBFTFRvaGlEODM1RUgyUlV1WXR3?=
 =?utf-8?B?bHFFaU90ZmJnQlluVDBja1ZOWUdzOVpqejlMSTIvUzltaG42VTA2VGcvSitw?=
 =?utf-8?B?QjdQaXBzY0pCYmFCQ1h0TEZ6M3JVUHFmTGRlVXNiOFRlTURoWGVtOE95T01I?=
 =?utf-8?B?NXduUGd2Sk13REp6Wk9saUdxbE9ZTWFLZVdkWUc2eFZMSFJlY3FrUGQ5VlVL?=
 =?utf-8?B?SWpBVUhhSkI4ZU1mdTZYK0ZwL2dvWnBuSW0xQk0vVmlmSDdRSVBmVmN5Mndn?=
 =?utf-8?B?RVF2Z21XVW1DSFg4dTdlTHd3ZUxQUnZjL0Z1a1F1Vnd6L1ZQK1hadWlxYzNT?=
 =?utf-8?B?QXFpY1VoUTNMUjVMdGkvWnVGYU5rM09JU0FLWUZQZkdZeGhBSVl0bGpSeThh?=
 =?utf-8?Q?CACaj6nYhtP3rsgf/CUDLEY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y250b0pHazYyeWJ4OVY2OE1IbUMwR1d0VGxUcnkvRnNjTTZJM3lFNERLbDhs?=
 =?utf-8?B?QXpDL2tkYVlheG9TdnR5djEyaWJudXMvcGZMajNocURaTiswYys0cSszeUpy?=
 =?utf-8?B?ZFRFVU9vV1BxTXdRenlHRXNhaHQ2all2U2xoNXZwU1EvZkswbjVIVllHSjcy?=
 =?utf-8?B?Y0c0TjN6QmZNMG0zNEdsRU5oZWtYdjE2eEhOWUpVeTdLeFhNWWZac2pEdVI5?=
 =?utf-8?B?bUUrZGZta083S2hSMEdKa2N2aUpHL21sVDZHdHRIS0d5KzZvWkRkeHF6UUxl?=
 =?utf-8?B?NHhwNU9QT0dKb0luVStqRlpTRloyQ09tZEx3QStkUU91Mk5hQ2ZWaHJyMnRi?=
 =?utf-8?B?S0JBWUptQ2sxdU9LMU1zRzRWZTN4Tm9DL1p1MDdKdGJuaE4zQ1JmY0J1eEF6?=
 =?utf-8?B?WUxWZ3dLcS96Z3YyRk9WaE5Vdlk5WHRBanNxRDNUUWF2bXJoS1d1RlVVLzRE?=
 =?utf-8?B?cmhHckpDa2NpdGxDWDQ1MWtSMjZmWmEvb3VWei82OXpEbDN1OTdvcTBqVkF6?=
 =?utf-8?B?eDlqTnFzV0tHV2Nka3ZVTXkyOUhHVHZIb1cxOWpiYWVqRzhHbENvdTBmb1FJ?=
 =?utf-8?B?VmpTVFA0R09qcEc5ZWdpVm5QaVVwMC92ZnhZc2V0RlZHYTVtY1FYU2k4aTVQ?=
 =?utf-8?B?cm1UOXk2MS9zRzdJQTNTNkZUelNiRGVPWlJtdUlmVTVOendLZk5zeDJlWHBs?=
 =?utf-8?B?UmJLdmxrRkt2bjRUS0xOc252aGN5L3V1VXZlU000QUgvaUgvSE83cXVIVUQ4?=
 =?utf-8?B?WkgrcElzYW5hUHJjd3V3aStWMmw0Tlp2anZJeWxMNGtoU2NTaitDWitOYXQ2?=
 =?utf-8?B?N0ZIQUt4Q1o4M3hhK1Zxb2JYWVlLNUY0VWdZVUl4OTl6MHJYTHdtOTNwYWRw?=
 =?utf-8?B?cVFjUFd1N3ZlVWF0OWdYczBGT1JjSkl4N1lRTFBrR1g2STRZVXRMaUIzOTg1?=
 =?utf-8?B?K3ZEMzVLUjBXQWdGM0JnNCtOMzBjMmlJdFZjS3dtSXR2dkVnOW03UTh5clZy?=
 =?utf-8?B?MEduaHRiSm4vdjVSdGF2NkxrclpRMW15L2wwMEhVVGRTd3lpUUM0Mzh1ZmRD?=
 =?utf-8?B?ekgzQlpndnhaOHBjWTVGQ2h4VDQwY0ttOFViU3VHSnRVZlVoaUZpQkFOS1pF?=
 =?utf-8?B?RDdKTDI3RDFhQ0NOanM3NWZsaEFrdTBQVW5CWFcxS2prOHozY0VkV2xSZ0JN?=
 =?utf-8?B?UWhWN2ZJY1lkT3RSRm9JSEdCNGdmT3BLbGtEMXNLRTJUbWp0clErOGFidEdn?=
 =?utf-8?B?K3NZWkVqNVZnckdjdk10Ukd6b2pIUVRDaXQxbXlybGJLV3M1SjNTMHkxYnNp?=
 =?utf-8?B?S2F4V2tUT1FWK3pZSTkzREVHY2pmc1hmUjljOFJqUUdqdXBFYzF0YjBZTkZW?=
 =?utf-8?B?M0tpYVpITDlUZ0V5VFJYcGcvcFRVRTYvOVc0QTJRUTJuVHA4enYxVWZIYWRz?=
 =?utf-8?B?STY3a2szNWgxYmUrTU9DSVhtU2Q0RGdWdFB5c1hoZllWSVBkR2M3SjJZQjVU?=
 =?utf-8?B?aGgrSExyOUNvTmJqYyt6djU2ZmlPOHUwS1pTV3hzTHJGaXNTM0MrRlBXUGp3?=
 =?utf-8?B?YUlFZ1ZGOEJLYVhodVJLcXE3YkJuZnZreE5Ncmc0WmpjYW8wOVNkOVdpT1d0?=
 =?utf-8?B?ejhveENsOTlpQVFnaEd1eFE4ZllkcGJqS3hBckZZa2FHcWFuV0huMFlDWjlO?=
 =?utf-8?B?T2xiQUVBODFLWDN4Wk50WlhoZ1pZd2o1SVdId0NkdlZiWXQrMWlpbHRnSm1x?=
 =?utf-8?B?cUsxYVkrYzNiQS9ycm1yRXMyTXl3TkRDYnhUOU5uYXd1aElJRlVxZzM0QzYr?=
 =?utf-8?B?eFF2bFVIcFlybGdya2dVNm5lMWJsTElELzVoeVRIV3dkWWR6a3VaREZmS2Uz?=
 =?utf-8?B?Q1BScG9ZMmdDWG40bmc0YnIvUTNub1RMNzBCZTY3dUpsWUJHOHp3bW10Mm9G?=
 =?utf-8?B?VEdLbG5JRjhYS29KTHNhS2phK1VkQ1NCd282bnlpaGJNOWYvL1VtVXpJVERG?=
 =?utf-8?B?SHNkOFJ6YTArRXlqdW52bXhlcllSdERvanh5SlR3d2tDcy92N1MxY1VmeEFB?=
 =?utf-8?B?Q3BIMUUwSjBoZXZ6VURpMlZ1Y055OGtSaFJRc2xBL1dDZlkvWnRqekNmZ3BE?=
 =?utf-8?B?TU9ocSsySXkzRFU4SWYrcUVMNzMrNTdkQjJXdlBUVmNFZzRNazJiVTI4Um93?=
 =?utf-8?B?eXBoWThhUUxLOTIvVFpCQ3NnOGZKd0g3Y3hKamlLTlV6RHgrRWhRYnpaeHlp?=
 =?utf-8?B?N1lsRlJwSGFLNlVvOEswRnBnRVdFM1FqbkZNMitXQVpIT0N1d0VGRzJiNHkw?=
 =?utf-8?B?cEh1b3VDOWNpOENFN3Q2ZEhTdkdreTRPWEU2eFBkL3FLM21CcG5TQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82589bb-0a2d-4ebf-ec0e-08de7402de9b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:40.8045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS74ifBpe3CbVVhwGJ0juoimqNQzotpT2lzv6Ly5r+5Ht9ZBF4RBhiDmRzeH7CAoWjxan00zOwRF6poQ2J0zWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

The i.MX9 pinctrl match table currently lists all SoC compatibles
unconditionally, which may lead to unused entries being included when
building for specific SoC variants. Guard each compatible entry with
the corresponding CONFIG_IMX9[X] option so only the required SoC
entries are compiled in, which reduces unnecessary data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx9.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx9.c b/drivers/pinctrl/nxp/pinctrl-imx9.c
index 1b7e43901af..de22e29e953 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx9.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx9.c
@@ -17,8 +17,12 @@ static struct imx_pinctrl_soc_info imx9_pinctrl_soc_info __section(".data") = {
 };
 
 static const struct udevice_id imx9_pinctrl_match[] = {
+#if IS_ENABLED(CONFIG_IMX93)
 	{ .compatible = "fsl,imx93-iomuxc", .data = (ulong)&imx9_pinctrl_soc_info },
+#endif
+#if IS_ENABLED(CONFIG_IMX91)
 	{ .compatible = "fsl,imx91-iomuxc", .data = (ulong)&imx9_pinctrl_soc_info },
+#endif
 	{ /* sentinel */ }
 };
 

-- 
2.51.0

