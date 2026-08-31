Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E47C61DD3
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 07:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41EAF60612;
	Mon, 31 Aug 2026 07:43:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPXbj9ECc87T; Mon, 31 Aug 2026 07:42:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788162179;
	bh=MbAQjohr9yQ+OhuogfgGdOaSDer/hZ6scXuGCxplQb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFdpvoVwgleShW+yEOTnZy0UGhq/lzxaS7cf3svvw1ZcwUBMeJW1DVz3zoa5oxdZT
	 8mlHz4jahFwHasfU906E3qELK0J3JLGg+6isHJcI9qvNg2lQ39hr7OBB8pCX2H1X6e
	 0h2xc/pozobR2S7M9kxSIGD5nlkatPQqIE+TqvUD7egNcKMXyQQ69ACmw6ukVpThC1
	 IOMKSEkOv1GAVD9RNmJ+jyvo7s6RcPxsOyPLowWGO3jXEdCKHzsL63FpD3NFocfQa1
	 0wdI0UKTQATJ4VMwnN+ag5U4Y/uoPOpuTM0Ou1OMIZAV9tF+XL1OgmoB/l5O6jfm3j
	 ApX5H60TrH8qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B25F60607;
	Mon, 31 Aug 2026 07:42:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D58F230
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7B1540542
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBDgM7TjHz7e for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 07:42:56 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=M92wbzWz
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F7E04054A
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:42:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBxMZfjnmzY8olDC0fJX4V9Q3a1E6rPMB6acoKdIY6yNyQ1giQT6lknRVV7nmU2Y/p2jcGSyjh5CQLtV6WWhw2TD1Q+Ux9kLRrNB5fOf7VI1xk6NFDGB3r8n8ZwRV0v4hE9uVrIH/Mj6N0zqBiTE5DnW0BwJqUo163ae6nEEJ5k538mOtb5GN/qANFyJ3R4zell1zdANU7Tgzmp5jFxHjUxNuepSz5dN5skDZqCk9gNB2JbbVKePI/mj6VL2Dp9ZiwcfHE9zpfl5sA7F27VMcpLzyf933UZ1/vjdK7/18yls/d95nyk16ohdo4+nOwN9AWYcgFIMcM4HCAFDDDcOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbAQjohr9yQ+OhuogfgGdOaSDer/hZ6scXuGCxplQb4=;
 b=NL+2bMBGud3pPOhadGDJjsOursYH3163NMdGn+pFbaM7iwm2Af9iDL0rdWcsJ0p6F42oGt5ZqHYwz2VDNhjt3UIGTSklNTEIWkXnRD6ydd6JFn3tCSFLBYvHu4uxnF9AZE1x1nE1Vm+L1Szowmaw4EGRHRLZvuihF7KWEuDJ6F0O+sQlVwJYN8IjVXq7sXszFu76X56IEgkYG6FuNepHtMZ+coFkx0cfApPPtXDw2gr6zKyQIS92rzcm6cDwgJg8gTHrQF6n+UnCUtp9N9qKim1UY4504TKqtTmm1Ky2ts+lEvnTvOFttuHbFHf6oDn+L0gUciENW495AtciXGnR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbAQjohr9yQ+OhuogfgGdOaSDer/hZ6scXuGCxplQb4=;
 b=M92wbzWzSCqiUSnOBpu/cfx/IK69Tov7R5AteANhz+JLqMQ27spPpq/znzUxTuABJpc9iTaYRJoXnH6GNhiNWKlN29qBqBhympFy4/QNM96bMKjY3wjZT+jqOZ+jSq5SbhVyGDOufttj12Td25sh5qxcXd0Z7EwSiXPlOP7H7OPCaJVA/s2ooOd/YF2l9jXS8+/3wZiy0+BcV0lU/kKZ31CN32cYgvsx99u2Jr/07fupNYAKvqML9hY6qF5Rds6KQETNMzbqjBKbGFaXVwhrco0gSxI7fXH1eutoV6O3LbfAKTxepcaatw/0h2F6W9Q9vs5owY0iXw4x6y0yFhE3eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI0PR04MB10711.eurprd04.prod.outlook.com (2603:10a6:800:267::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 07:42:51 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 07:42:51 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 31 Aug 2026 15:46:34 +0800
Subject: [PATCH v5 2/3] net: fsl_enetc_xpcs_phy: Add SGMII 1G support for
 i.MX95 Ethernet PHY Wrapper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-imx95-v1-2-a5e482080196@nxp.com>
References: <20260831-imx95-v1-0-a5e482080196@nxp.com>
In-Reply-To: <20260831-imx95-v1-0-a5e482080196@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@nabladev.com>, 
 Ye Li <ye.li@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:295::16) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI0PR04MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fde288-b75e-4f6f-abab-08df07337602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|366016|23010399003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SvsmdR0i/iZM/WiSmZjTFbUZC8ZlQSEDw/n4zed0CGVFpxUmdi8YkOGQeLgIQNYC+Dx38UdnQRkATFRA76P9nGBByWC3EmQbdq5nAqdT0yyyFhnE787vqW40h2DiCYAet0lYw8C2yavdjm8UitE4VO4VeulhzCYx/b92+6XxTPJnoGypZbhv0cxHPNFXFSYCexcUbNTX2Jlf5KP9EwbYyjh2X6weSy37uDdZPmCOBH8BPugZ4hOxnqHTTvsWQIDFivLFaCmBBgo/evy80qhy0VWFKtviONHk0NANT2/GARuVYJ89A5Y+HzOzzOXly01nGhiKArUexhrNbrI29wXgsNWbBBvz7OBEDOt0dTsTkYptFDOT+YjCi7YPtXkrkkrQNkSzaaM8NRJcuvcv7Lqd5ep4XoADVM1LqTC/pQh34ySTl7QfGP8zw23MIFcRKY/aKdGu5KrSOfIXnyBvEi3Z3XQ3iSw73e1NwsNlURIEbdDzytBtPdipve1T3T4hggtROrEbDib5Grk/acq86Z8NJpvFDqqWXOuFGXZullBxrieQfqyjJLtSMsy+8EFnlzrB/clAEBggkN02p96cFQRYhZCVN0Irw8mEVT/J8zmY5wjmS+MGOmk/hvR2DCuCM8JhexzcS/3vKfDrst90nxth7uehf8X+uXxo9JbdQtx1jmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0MyMk1hVnllVjFpNC9PTHFJSENUMENzaXlFVjFZNFlGa0g4blhiSmVpUEIy?=
 =?utf-8?B?ZkR6MmxZbFFsV3phZTBLaWlqcGhsSExQakIrcVg4RVUzc0VpaENZdnhiaEdU?=
 =?utf-8?B?MWROSzAvK29yZU8xZ1ZxRDkwWHhpbnBYZnpmdWx4TC9vKy9zSzBWS2dFZkFJ?=
 =?utf-8?B?bUFGWXNmN2QzTzJmendwYkMwMTFDMEc3T1A2VnR2ZzhtZ2crazdNZ0NObUFk?=
 =?utf-8?B?ZnlkMHM0eUI3MllqR2Y3QVZCSDcyT2FsclBRTGxkbEE1SmpWUkV1UXVEN3JJ?=
 =?utf-8?B?ODJsTnhITTFaVkxsTyt4OXdMajVKTkZ0bnZsekswRlhrdHd2c1dQc2VDbmE5?=
 =?utf-8?B?NHV4WEJrZ0padi9zcE9Tdk5hRkNPZVA0V01TYmozYTh6dWdqVG9RaGVDalBW?=
 =?utf-8?B?Zk5CNlFZYWFBVm1yeWRFc09La2RMeFd6d1JsZm5VOFNkQ01vc3hSQUE4OWVz?=
 =?utf-8?B?a0V3dy9PcWJmMUZJSENpK3JMYVZlQnBwU29NTWVtTG1odVdCeW5jVW4vOWNv?=
 =?utf-8?B?TzdMUWhsTGdndURqTUdTWFh1RGh4dzdBL1IxMWJUWWt4d2hFWWtrZ0JhLzdI?=
 =?utf-8?B?RXZRT1JrZzdYUGZhSVZEV3YxZ0NxandXSWV6UzV3NGttckM4Wk1uaDdrOENp?=
 =?utf-8?B?MiszS2hRSDZ6QXFqTjRwMG5uZnljOGlkYkdyVWF5QWp2OU1wVGRQQ2llWHM2?=
 =?utf-8?B?ZVYxVjAxZ3FodmRLcFZDVHJLVlZHN0JPQ1FkTlVOdDVkM0VmK0p2cnAvVEVS?=
 =?utf-8?B?TVI1R2hsZXhHRjd0WWh6OXp1SGF0bjk2UE5IQnlsdlpJeldJL3pEODFSK2x4?=
 =?utf-8?B?YVdKdWwwZ3Vqd08zKzJqejlFa2pjRG9PT2R4MENQd3hSUUJxakZTbHNUNFBQ?=
 =?utf-8?B?Y1dBblh2dDNTb2Njd3VwZEwyMGU5d2NxUC9ObzcvN3ZiemR3S2txNmZPZHFS?=
 =?utf-8?B?eGc5NSthQWlpSlFnVEFLZE1lOGNXS29mQUlYYmpYMnJpaEJ5dmFXaXhWMmZZ?=
 =?utf-8?B?NDV5OXdPNjZNOUs5ZW9JdTcxbUl3TjNJZGJQL1doUmU2aVl6SWZCeGhvZ0Z1?=
 =?utf-8?B?L09XL0trNlBPa2d5U2xqNDByN0xQWFRKTEpQYTJzRmZwRjJyM0ZkaFNFMWNU?=
 =?utf-8?B?WkRERG9LYnNSWitWUmhCRW9TaGE0aVRCdDZwMXZGWXh2QWQyYjQzclR1d3Mv?=
 =?utf-8?B?aFh3d2RGR3BNc210VUkwUVRLaWRYUlgxZUQzcUFUNVlOTDVrZXlOT3kxd0x1?=
 =?utf-8?B?R29kYnF0Q3F3NnhyTTlFeCtKMEoza2MzR2ttd2o2UTJnZEZHeGZ4Q2duMlZi?=
 =?utf-8?B?Yjl4a3hqbXVCNkxyTHVNalRHQ2twK2lUVm9PbUp0alJrL2tHYzV0eGhvU01C?=
 =?utf-8?B?aVJQS2phWTFhMXBlVVNRLzZEbmpxOGcwRnkwWDR6VEIzUHR6Z0lrOWxySlBR?=
 =?utf-8?B?MUljVXJYYXVmS2xmajVCMFRnUS9JUUdqemRRNkJScHpMZGErVnQ5Tnd1a1BO?=
 =?utf-8?B?ejhyZHNvTFdIMjQ0WHBDdGNwcjlYTmZMSWJYcFlOYi9ocHkwa1RzSVZPdUpO?=
 =?utf-8?B?TkNMRFpvU1hNY1IxR2ZSWEhzd2xpOXRXaWN5SUR0Q0dMRWN5VlcwdXpxaitS?=
 =?utf-8?B?MXNlQnlRME1pUXhodzkrd214cnFibmMrbVQ2cUFoZHFwQ0xrV2szMVcvbzJ3?=
 =?utf-8?B?eFBkTE54Q2ZyU2VKYmJ0ME9NUnNhVHR4VVRBQUNhWGdGTk1FekhRWFhYWnJi?=
 =?utf-8?B?L3NaODZ0NFZlZnRlRDlnOWUxSXduQk5ZblUxWUFneUs3LzVJZGtyOXJqcnUz?=
 =?utf-8?B?RmMzNjRYL1lMRXFxZEttck9LTTZMbWhZaVBFb0hSV1FvUG53OFlxKzZudkhv?=
 =?utf-8?B?cmRXeFpxalRlUThEWTFjQ1J4dFA1UEJvcVBUV1BLWW05Z3NTQ1NSM2ZEYXV2?=
 =?utf-8?B?MG9NNi9zbWRGVGREVU1jcUhCSDNLZTMwS3h4eklyUy9GQnJsTmcrNDZ4ZGpr?=
 =?utf-8?B?MGlLWFlOY3BWNEpYbVQzWDRaaVdaNm93ZWR5MG5MeW9YSnlhdloxWE01MnZW?=
 =?utf-8?B?Y1hiV0NWa0hIUmlaU2ZZVXBZNXJEdkpyUjJaN0VrR1FuNVFpUlZuS25CTTJP?=
 =?utf-8?B?NGkrTnlkSGtkbXcwQUxOOExtWjY1d05td01DN2phc1lwYjZ3eE9YMGRyalB5?=
 =?utf-8?B?bzd3NkJiR3Y4T3NBemR0MytnYmgwaG80MWFpWUQ4OU5IVXVMQmJrS3prYTF3?=
 =?utf-8?B?Qkw3OFJxWGlhcGkweGk2b0ZrTUkvNERRSUp4YTRTOTBLNnZ6Tm9LK3NPSnRC?=
 =?utf-8?B?UW8waW93cTB2eHFvamdGWVp0MVlHcnlSckpBdFFPK3BwMjNpcEJ3OE05bmR2?=
 =?utf-8?Q?/xlvX+AHUhnX0x6pN1szJ/X9tiL9OqEHuSq0A?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fde288-b75e-4f6f-abab-08df07337602
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 07:42:51.5804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypGG1TUzpZO8zqTR/+Lo2gZ+2dtfBM5hzwZugKs577QEIJynvgFADKZYwaEAylzsxP4fkhGZ9VZpAFsGVOsqe0WLraqNo10O2XxC7yXLJXDZ1zl74u5b3NNhsRDrw5Ce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10711
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Alice Guo <alice.guo@nxp.com>

Add support for initializing the i.MX95 ENET_PHY to 1G SGMII mode. The
initialization sequence is implemented according to i.MX95 Reference
Manual Revision: 5 (2026-03-30).

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.c          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 517 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 518 insertions(+)

diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index f393af40e27..6f7829858ec 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -21,6 +21,7 @@
 #include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/build_bug.h>
 #include <linux/bitfield.h>
 #include <power/regulator.h>
diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 006a2bd2238..748e0467af1 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -57,6 +57,8 @@
 #define PMA_MP_16G_25G_TX_MISC_CTRL0			0x1007C
 #define PMA_TX_MISC_CTRL0_TX0_MISC_MASK		GENMASK(7, 0)
 #define PMA_TX_MISC_CTRL0_TX0_MISC(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_TX_STS		0x10080
+#define PMA_TX_STS_TX_ACK_0			BIT(0)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL0			0x100A0
 #define PMA_RX_GENCTRL0_RX_DT_EN_0		BIT(8)
 #define PMA_MP_12G_16G_25G_RX_GENCTRL1			0x100A2
@@ -102,6 +104,8 @@
 #define PMA_MP_12G_16G_25G_DFE_TAP_CTRL0		0x100BC
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK	GENMASK(7, 0)
 #define PMA_DFE_TAP_CTRL0_DFE_TAP1_0(x)		((x) & GENMASK(7, 0))
+#define PMA_MP_12G_16G_25G_RX_STS		0x100C0
+#define PMA_RX_STS_RX_ACK_0			BIT(0)
 #define PMA_MP_16G_RX_CDR_CTRL1				0x100C8
 #define PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0	BIT(0)
 #define PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0	BIT(4)
@@ -198,6 +202,7 @@
 #define MII_CTRL_AN_ENABLE			BIT(12)
 #define MII_CTRL_SS13				BIT(13)
 #define MII_DIG_CTRL1					0x10000
+#define MII_DIG_CTRL1_EN_2_5G_MODE		BIT(2)
 #define MII_DIG_CTRL1_CL37_TMR_OVR_RIDE		BIT(3)
 #define MII_AN_CTRL					0x10002
 #define MII_AN_CTRL_MII_AN_INTR_EN		BIT(0)
@@ -959,6 +964,518 @@ timeout:
 	return -ETIMEDOUT;
 }
 
+static int imx95_xpcs_phy_mplla_configuration_sgmii(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+	int ret;
+
+	/* 2 Config MPLL for SGMII */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val = u16_replace_bits(val, 0x6, PMA_REF_CLK_CTRL_REF_RANGE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val &= ~PMA_REF_CLK_CTRL_REF_CLK_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);
+	val |= PMA_REF_CLK_CTRL_REF_MPLLA_DIV2;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV8_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV10_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val &= ~PMA_MPLLA_CTRL2_MPLLA_DIV16P5_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL2_MPLLA_TX_CLK_DIV_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val |= PMA_MPLLA_CTRL2_MPLLA_DIV_CLK_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2);
+	val = u16_replace_bits(val, 0x14, PMA_MPLLA_CTRL2_MPLLA_DIV_MULT_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_SSC_CLK_SEL;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val = u16_replace_bits(val, 0, PMA_MPLLA_CTRL5_MPLLA_SSC_FRQ_CNT_PK_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL4, 0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL5);
+	val &= ~PMA_MPLLA_CTRL5_MPLLA_SSC_SPD_EN;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_MPLLA_CTRL1);
+	val &= ~PMA_MPLLA_CTRL1_MPLLA_FRACN_CTRL_MASK;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0);
+	val = u16_replace_bits(val, 0x20, PMA_MPLLA_CTRL0_MPLLA_MULTIPLIER_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_MPLLA_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val = u16_replace_bits(val, 0x5, PMA_TX_GENCTRL1_VBOOST_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_MPLLA_CTRL3_MPLLA_BANDWIDTH(0xA035);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_MPLLA_CTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0);
+	val = u16_replace_bits(val, 0x11, PMA_MISC_CTRL0_RX_VREF_CTRL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MISC_CTRL0, val);
+
+	val = PMA_MISC_CTRL2_SUP_MISC(1);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_MISC_CTRL2, val);
+
+	val = PMA_VCO_CAL_REF0_VCO_REF_LD_0(0x2a);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_VCO_CAL_REF0, val);
+
+	val = PMA_VCO_CAL_LD0_VCO_LD_VAL_0(0x540);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_VCO_CAL_LD0, val);
+
+	val = PMA_RX_PPM_CTRL0_RX0_CDR_PPM_MAX(0x12);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_PPM_CTRL0, val);
+
+	/* 3 Configure LANE0 for SGMII */
+	val = PMA_TX_MISC_CTRL0_TX0_MISC(0x0);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_TX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_TX_RATE_CTRL_TX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLLB_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_TX_GENCTRL2_TX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_VBOOST_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = PMA_TX_BOOST_CTRL_TX0_IBOOST(0xf);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_BOOST_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL);
+	val = u16_replace_bits(val, 0x3, PMA_RX_RATE_CTRL_RX0_RATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_RATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_RX_EQ_CTRL0_CTLE_POLE_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x12, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL3_LOS_TRSHLD_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_STEP_CTRL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val |= PMA_RX_CDR_CTRL1_VCO_TEMP_COMP_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x16);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val = u16_replace_bits(val, 0x1, PMA_RX_GENCTRL2_RX0_WIDTH_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_DIV16P5_CLK_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL);
+	val &= ~PMA_RX_CDR_CTRL_CDR_SSC_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_CDR_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3);
+	val &= ~PMA_RX_GENCTRL3_LOS_LFPS_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL3, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4);
+	val |= PMA_RX_GENCTRL4_RX_DFE_BYP_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_GENCTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL);
+	val = u16_replace_bits(val, 0x0, PMA_RX_ATTN_CTRL_RX0_EQ_ATT_LVL_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_ATTN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA1_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x4, PMA_RX_EQ_CTRL0_VGA2_GAIN_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_DFE_TAP_CTRL0_DFE_TAP1_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_DFE_TAP_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_RX_CDR_CTRL1);
+	val = u16_replace_bits(val, 0x1, PMA_RX_CDR_CTRL1_VCO_FRQBAND_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_RX_CDR_CTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_TERM_ACDC_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0);
+	val = u16_replace_bits(val, 0x0, PMA_RX_IQ_CTRL0_RX0_DELTA_IQ_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_IQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val &= ~PMA_RX_EQ_CTRL5_RX_ADPT_SEL_0;
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x3, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	/* 4 Configure XPCS for 1G SGMII */
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_CTRL2),
+		   PCS_CTRL2_PCS_TYPE_SEL(0x1));
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_SS13;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val |= MII_CTRL_SS6;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4);
+	val &= ~PMA_RX_EQ_CTRL4_CONT_ADAPT_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_EQ_CTRL4, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x6, PMA_RX_EQ_CTRL0_CTLE_BOOST_0_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL0, val);
+
+	val = PMA_RX_MISC_CTRL0_RX0_MISC(0x6);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_MISC_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5);
+	val = u16_replace_bits(val, 0x0, PMA_RX_EQ_CTRL5_RX0_ADPT_MODE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_16G_25G_RX_EQ_CTRL5, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val &= ~PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	/* 4.1 Assert soft reset */
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1));
+	val |= PCS_DIG_CTRL1_VR_RST;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DIG_CTRL1), val);
+
+	/* 4.2 Poll for SRAM initialization done */
+	ret = read_poll_timeout(xpcs_phy_read_pma, val, val & PMA_SRAM_INIT_DN,
+				10000, 500000, dev, PMA_MP_12G_16G_25G_SRAM);
+	if (ret) {
+		dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+		goto timeout;
+	}
+
+	/* Assert SRAM external loading done */
+	xpcs_phy_write(dev, XPCS_PHY_GLOBAL, XPCS_PHY_REG(GLOBAL_CTRL_EX_0),
+		       GLOBAL_CTRL_EX_0_PHY_SRAM_BYPASS);
+
+	/* 4.3 Poll for vendor-specific soft reset */
+	ret = read_poll_timeout(xpcs_read, val, !(val & PCS_DIG_CTRL1_VR_RST),
+				10000, 500000, dev, MDIO_MMD_PCS,
+				XPCS_PHY_REG(PCS_DIG_CTRL1));
+	if (ret) {
+		dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+		goto timeout;
+	}
+
+	/* 4.4 Assert TX0 clock is active and stable */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1);
+	val |= PMA_TX_GENCTRL1_TX_CLK_RDY_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0, PMA_TX_EQ_CTRL0_TX_EQ_PRE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0);
+	val = u16_replace_bits(val, 0x28, PMA_TX_EQ_CTRL0_TX_EQ_MAIN_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1);
+	val = u16_replace_bits(val, 0x0, PMA_TX_EQ_CTRL1_TX_EQ_POST_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_EQ_CTRL1, val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_SUPRESS_LOS_DET;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val &= ~PCS_DEBUG_CTRL_RX_DT_EN_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
+{
+	ulong begin;
+	u16 val;
+
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	if (an)
+		val |= MII_CTRL_AN_ENABLE;
+	else
+		val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
+	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val &= ~PMA_POWER_STATE_CTRL_TX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val |= PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val &= ~PMA_RX_POWER_STATE_CTRL_RX_DISABLE_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 0, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val |= PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	mdelay(1);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val &= ~PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val &= ~PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_STS_TX_ACK_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_STS);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_STS_RX_ACK_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
+int imx95_xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	int ret;
+
+	xpcs_phy_reg_lock(dev);
+
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		return ret;
+
+	ret = imx95_xpcs_phy_mplla_configuration_sgmii(dev);
+	if (ret)
+		return ret;
+
+	ret = xpcs_phy_common_init_seq_2(dev, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int xpcs_phy_sgmii_1g_config(struct udevice *dev)
+{
+	if (is_imx95())
+		return imx95_xpcs_phy_sgmii_1g_config(dev);
+
+	dev_dbg(dev, "SGMII 1G config skipped\n");
+	return -ENODEV;
+}
+
 u32 xpcs_phy_get_id(struct udevice *dev)
 {
 	int ret;

-- 
2.34.1

