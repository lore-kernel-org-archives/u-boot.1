Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5872ED206A5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC9D88DED;
	Wed, 16 Oct 2024 09:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dNHyDG8C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DC5488DE9; Wed, 16 Oct 2024 09:19:33 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D141C88E39
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY02sW7mAGrcY4S5f5veZ/RJ88NOyYMUqyN5nmt6jLFKiv6zvESJDdeMSFB4MhjX1KiYTCwcx0ySbH94viMPqFoB9kp0sBhlr7vk0z2ak4p/gDeHLHszpoOzkodE5p3Q/7ncYZE+O5fWnLZ2Ivb8U2GWHBizZtNg1vZcTq0bXSrudw4yYSNj3fUR27l6AxGaSKUTAa/WhVq3B0Cgfzo2q+kCeHP/U1beFJFhTQ+qXTj+soDDY8ABcEqfItO/VqRzvSgX7FARZAjnfpBO1UQVUd+tu5b0hSj7+aiEu6k5CDQRCFcn1XVazwLFqGCWcqHGvYgOj3tMNjHlJni2j281xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOKMwWk8l/DBn4UMZEA7nKpR0K5NJrxLccTHojRjIIQ=;
 b=JGzdYCyOO5QfY0unRRfHxm0Aqt06QP3lyvaDPSicwDG4/mQNSgaJnT65Muup96vY+T82bxbOGsuUyhEs6ZIH32a7PhgA6CTGTuHQrzRbeBLXRSXrBbq400p+i/hQYNULIblabYrV3pzwgiiKs8ME0q1WH7reFoq1LAfgDGB7rFNKE0aw7GsqEHKWzWCkh75vEqECjWF0f8e2URPp44rqb3LkugV+T/Ogrl+H7Rw89qbXlHSThTfHeRLD2OG32kq+i0SGJDO3Gus23s0vmlrSI2InO+E27FIRDnP32uKKbCnx2awBdGhEMDDK/SlvPsBuY0LbXRoEFMIUd0Ntd+8tFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOKMwWk8l/DBn4UMZEA7nKpR0K5NJrxLccTHojRjIIQ=;
 b=dNHyDG8CCihhP7W7KdEnEi+IadxOdkPphYx+yCVuydxSmjGdrmg2WNpxFYvESJMrPeWwhUX1XBR2DZfZCEDzPVYXmPUoXmmiWFy0okHDCfNYTNk+N1mSvC0NPyP3Pkwm5FS1YOm7oyahq5OC9euk16132LvWZ8mAy61OiSzK/M/NzQPv3Y7WhjOvzCCfyt7dygdlhrHUqFvP6wr2/AAEpIEFUQHU6i5sXotWRRo6zIcTzA/srzwdpKKkQfJmsJHvGxra1O8/jlGBhv6kth6TmVnh5srQ03IyuyhQVr9uzev0Wj4QRk6sjKSSHKzYEU0et+pQp5g1OHgbvVxlG1gjZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 07:19:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:28 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:01 +0800
Subject: [PATCH 08/17] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-8-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GVXPR04MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: a8387a33-d724-4013-637a-08dcedb2df4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0NYRGlzOTA1ZlhtQUh6RzM2c3dadHdtZVl4Q0FPSXN3eUpkQjNPcDk0MXg5?=
 =?utf-8?B?akZ5bW9sMUoycnh1eVkvSGJaMjFqbXJ3QW9ZSnd4T28yRC96MGZDNUJHZ0hr?=
 =?utf-8?B?aGdlOC9uNDM2d0Naam8rQkg3TThWUUxmU2s1UXFvVDJDUTZQdUNZODlrTWp6?=
 =?utf-8?B?TXhlc1l3RlJpZVo1THFwMndkWlNBcUxscXpJNjNwSjBDWng4cjdIVUNhTGJu?=
 =?utf-8?B?czYvMXY5R1NUbWZGMjBqSlZ4YVBVa2pqbVhTUnJVM1F0WVVIcEI5dU1HNTJp?=
 =?utf-8?B?amR0K05hRXQvQSt4TDRPSGsxaWJ4VFhlK1dTVlNvM3ZKUE9ERHdva3JGVmxK?=
 =?utf-8?B?RVYrTC84MGxOZDN3Y1ZMUEhMYTY0UUxmbmRVMmFSeHQxZ0ZJWDJyMXJBc3NE?=
 =?utf-8?B?UXlDZzArT2dkc3ZpR3ZLU0hjaEJuVVY4YzA0SWJISnlPMm1yemlFaEhvNlAv?=
 =?utf-8?B?NWpsRmZqTTBhWGtKeTRwZm9yVGhoamZtdmF1TStpWHlXY1VsYnlpVlg4ZW42?=
 =?utf-8?B?d1VSd3FLSnNJNzZKaVFQMmM1SWRyaFcvaHNGeXg1V1AyYmt4b2xFMUczcnN1?=
 =?utf-8?B?NmJDb1ZpRmdvbklDUlU0c1J0UVhZdktHdmVqdWN2SnkvZWZrTEx5NnBnVCsy?=
 =?utf-8?B?YU53MFFkNlhGWFdLUFJWaEZsbmJjRGR0MTY2WE1KdXZLeEpKRjJsa1gweVRw?=
 =?utf-8?B?UzkweUdyTHpZVUgreTVQazIxdXhZYTZ5bDB6K0RSdWJmandpM2oxKzFpVk5w?=
 =?utf-8?B?Y2VtVk1jbDNrUkpGVU9WcEEwZEhYek9Hc0paNnorUktGWG5tTFEvQXJmWFZY?=
 =?utf-8?B?OFAyYmY4dm0yWHJCdXdiK1NDOHpRaVp3UHgwaE5ZYlU5RmdXN05nWGJlbm9D?=
 =?utf-8?B?WjE0bGxSc2NhOERVWk9aZlNBeE1sZTIvelZqa0VJSU93RzRPbWVWK2ZVcVR0?=
 =?utf-8?B?allscmNLZ3RYVytHUUhJWjhNY3hoVXBuUjA5cDVZRExrRlZDUTN6dTRZNUlE?=
 =?utf-8?B?bTIyT2lMRUY0ankxMS9SdHVpVHU2ZUdyUVEwRWtxVHpSWUwvbFFsMktKdzI0?=
 =?utf-8?B?MzNtVVRIMHlJRkhmZ3pIU3ZFdElsM2pUNis3TjJGZUhZMzdhSFlWdmxaTDNE?=
 =?utf-8?B?ZEdOckJWUmo3K3RPOGFTZWh4aXJ5RmI3TW9JZ1oxMHh3YTcxVW9OcGhhcVcx?=
 =?utf-8?B?cHVzb3Y4MHlRSWNPK0dDQWtJK2Z4YWNwMDdlY0Jja25kdFo0MlZiNWJMR1VL?=
 =?utf-8?B?QjlOL2VqcXllNEdKSWZOZlZCNURLR1NSdjJvV2hDbTdFYTE5Rk9WS1NYTmo2?=
 =?utf-8?B?V0lzdEdZNUJGWGYwOUtRamdsSm9MMWVaL0N0YytGSnB4UjhYR2dQcnpIN0pY?=
 =?utf-8?B?QVZpbGs0YzB3TG1xbFVBSjN3Y0VXL2FOUTlzQnQvcWIyc1pvRm5vQ3RTQ2Fy?=
 =?utf-8?B?WUwzZGZVNGJnREtsUHA0ZFozZmE1enBSY2ZjQjM2ZG1mUGRkREFSTGVIdzVM?=
 =?utf-8?B?cDJqNkx6Q2F6NzBsVlZYZmQ1bzFTWFZoWDlYZk1kKzR2NS8yMC9na1V6VkM4?=
 =?utf-8?B?aDJ5akFUS1d1dEJvU2JjbDdRNlVCR2hPaGJKSFpOeG0zaER5eVJEd05GRmFV?=
 =?utf-8?B?VjV4Ymt6Rml5cUpoMzdyUnlGU3Z3cXJOQ05UY0ZXcXNGUFZzQktEL0RzYTZx?=
 =?utf-8?B?UHh5NWJTdm4yVEU2ZHpVM0l5SUt3Mm9FVG9lbnF4R25iTFAyZ3JBQXVnMlRv?=
 =?utf-8?B?Mlp2ZzN2WE1QRlRaWStLWVZpRk1VMnh6N3FrbFh0Y0E3b0E1QjBkV25FM082?=
 =?utf-8?B?K25Ib0lVNXYxdTR4Nkh5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3ZrWnhveTZHeU1STVpVTThwQ013czBIM1V0QnF0T1NtZTJvRUEzbHQ3bXEr?=
 =?utf-8?B?eVo5Z0FwS3BNODVncklKbjcrS1ROb0syQ1ZINWpnODJ4ZWV6MUJHWGxVQXpU?=
 =?utf-8?B?eFZPZGtrRk5TSEdRZmxnSnJ2bUFJSWZ6K3NkL0Jwc05sek54WHk0SVZWb2Jq?=
 =?utf-8?B?Vlc1TUxIQ2ZZWVZ6NXB1RTJKUHBpUW9RK2VLMHJLaHFlbUxCajY4R21oZzVr?=
 =?utf-8?B?c1RuMHU0N0FQaC96RTZNbk43T0xqa1MzajEwL3E4TGNaY3Rnc1RMYUx6OENu?=
 =?utf-8?B?S2hoUEp5bFp0Sit6c1h1TTlMcE5VemxvYW16bDJoUU1OQm83TUZIZ1FRdEpX?=
 =?utf-8?B?YUZaOTNxeXprUHVMOWZ2aC80dHhoejZrSDYrWFlpamdqYkU3ZFhYdjFIMDNn?=
 =?utf-8?B?cG5kdjgycms0R0FlWjRENmNxUnEzNUdseEhUcm1BNWVwRGZ4bDlvaENJVFlW?=
 =?utf-8?B?ZC9YYWcxK252bk1YOW83QnhMVzVzTDBIa2JTTXRmcmRzVUhFb1BkVUdxTENQ?=
 =?utf-8?B?UDhZYlBRbGNxcnhkNlRXcCsyZGI5YWZkSWVjVStFc3lrdUk2ZlhuK1pPcC9O?=
 =?utf-8?B?N2hPQlUveENITDg1azNyM0Z2b1lxSGp5bUpoaTd0U0ZGL01xcGVieDE3TG55?=
 =?utf-8?B?emRiMHAxRnEyRW5sMEtLWFE1ZXpyVzJOaG5NMkZ1OUVIZUpESU1RUmdwdGlo?=
 =?utf-8?B?OFp2aFFGMTRXT2tRaUR2UFpXbTk2bm1qcXF5VVBnU1B2dEJZa1FHTnRUelp6?=
 =?utf-8?B?WldmYUxCeFJjWlpieWJKWlNxZklGbFVTdEwwRTFyOFNVSU4zRDFzS29STE1k?=
 =?utf-8?B?emVRUEhVUlRMSEo1eVFBT21ySWVFdTY0QVQ2M3F0dnZKVldQU2NaUzJtR0xt?=
 =?utf-8?B?eDFNaERQcTNFWmk4ZmRxVUxIUXcvYVNNTVpMSEdzZEtnMytFWDdNa1BRV3RV?=
 =?utf-8?B?MHA3cTEvNnpaNHpJMll3eDF5ekNaUzI2SThqa2dYQ2NwdklpRVNBWVU2dEcw?=
 =?utf-8?B?dnZLU0VjcE1ib2RLcVMweFFINzcvRVVRcVRXZmlObUF1cmxvZWV0SkR5bjJC?=
 =?utf-8?B?Z3YwaVdnc1gzbDJQWWVwSWEzL2dpd3B5NWdibFFEaEVrOFpnakV2cGVXeURt?=
 =?utf-8?B?c2RpTkNyb3E4c0d2aXh6TkJWTzM0M1FtWE9HNzFoeVRDR0orQW0rZ0wxRVVy?=
 =?utf-8?B?YW8zZ0ozWXY5ZlorYWtTY1JjMWd0TTZRa0oxSzI2dFFzYmJwcUdzOStoVDVS?=
 =?utf-8?B?bzVRblNTYnVoOW5DUkhtdE04ZzJzM0xVVGl6V0VyMkJleXNwZ28wUGowN3dn?=
 =?utf-8?B?MWxBR3NrdXFWTG9XeUQ4TkdiTStUTTlKSDVYLzl3empLWmtoQjFaSjFSWVo4?=
 =?utf-8?B?YzNuUTBIdGVrUklqQlI2dTF5WjZQRkhZamppdTlQcnE0NHp3REdJYjVsRDlw?=
 =?utf-8?B?MXhNUFBrNzdQL21hamwvVys3TXM2eFFnbFpxem5TTmFZcndUQi80RmNsNW9i?=
 =?utf-8?B?cEJaS2xpQnZuK3FsRC9WdDJQV0VrUS9Ba0FiZlQvdDYyZ0ZwT3pZU2RTYUVn?=
 =?utf-8?B?c1ZWaFVWb2RoRzUwbVllZzNmTjNHSFRBZ1RhaUJYdkE2cndpNk1jL2gxZ1FH?=
 =?utf-8?B?c1JxWU1UKzJSZW1ld2Qzd3BzS3ExeWlza0J2RXluZ0Q2Vk4yemllSXNJbGQr?=
 =?utf-8?B?bThPSk9Kd0ZDRk9FSWVaUE42UzJoaElJcVd2bXNic285MFFRYWZOMjJXWE5F?=
 =?utf-8?B?TWE2VlZxUW5yQzE3WWVkczkrSldQN2lmeDVNSVRqZWN2a2orcFJKT0ZzbmtP?=
 =?utf-8?B?OEh2RmUycldTdXJaL0Y1UzZkckR4ZHBYbFNsQnVIMFpjUm1na2lKS2NnVzZl?=
 =?utf-8?B?N0pmSUlxa203QWNtbmhPampmZ1EvQVhRb3RyTVcvUHJFMzZLdFN2UUR0dzRt?=
 =?utf-8?B?TmRuWk1DdUJOUkUxQzFycjFEcFAzZVR5Z3NrcS9CaTAxZXZTaGNkY1paZ011?=
 =?utf-8?B?YTFzdkZjUnBPWmNtZGtlZFVnbE9oTU9adm5CeFdNVXhpWDBqZitHakF5cFNr?=
 =?utf-8?B?SlZzNnpOMUlpaXpvcE16ZkNtcVYrWXFDMExBZ3RGQkpUOXhURTJML3dwMmE0?=
 =?utf-8?Q?buCOqe1NRZpPmOMixs/P1We8o?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8387a33-d724-4013-637a-08dcedb2df4b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:28.7346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LyHiblrF6aLjbleJEyk901vRQtDOdsD1ddYaTVytQL9Ktu35zUCzCDDEEojOWAJaRstKkuxkx9nuwt2Educcww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. The number of elements of @protocols is
specified by callee-side. Currently, set it to 4 is enough for i.MX95.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/scmi_protocols.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 8a5830d582d8baf4b4781ab860f09f49d335a023..b3ca85e1697dced50f9d42600255044fa9fa4aab 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[4];
 };
 
 /**

-- 
2.34.1

