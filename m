Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1136FC7115A
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 16:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3EB82D66;
	Thu, 19 Jun 2025 18:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="hiIYNaAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8600780C83; Thu, 19 Jun 2025 18:39:23 +0200 (CEST)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d405::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F83382D2E
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 18:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzcKz43LkDiqhz0UScaa/i4oR34O0ND78LZL/W8D0dq4fmM+ov2mvnI9HaxuZw1HLNrdwQykJHrQcIiR+5u2o14YKq1IryqhmoQ3/t1SbHSL9PZtmC2zNUqh7s5AflL+ik5j62gHeGGhcuN6Qv0wtwpVDTUjb/Ky9Jdb0BEDvqbJVZryRN/EiapanTDrnkdYUmvXmtF4h4j31emYKkZKN0aFx88IYifwDk0J9O8+Dnbv39IE9nlpeU6o9759/CxRefHust3p9x/ZvLGJys3pfEL1hR9al/Om0qRuoRzPhhh6AIzsPO907b+f2UarAUzD2xDkp0FIGZFGO2ttnxLC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6vzFvvkdy2+Cr2Gy0uo6vmysBa0Y0WWNtbbbxJM2Bo=;
 b=sq0W+QhRUdXbUcNfiQaNs7PEuFyQyBz2JqGJuwwJhaUn0DPKgxT3aJ7qXx1gI8p4BOe914IV6ly/ORJ4bC96gzAYwuEym4vC7k3go3gpMlksGWU6nTsdnQeFslGKjgwXXWylnvKSJV5UKeWVUkrabJNML/9cX0ZftmuP8nytogolqg2zQy9lAxw1yA8+2kGdB4vltMz1tLQbOPMWDOqb95ng48/ntQURn95GRQ1nA2C+M4LpEZCNCOWD18JyFObBcqSkfTFC5ooDg4erpTqah5WWg+mgNh3TlhcDpkPhcasOKt/oG0+WVNDBDMDPlwbt978Nj+mqeOLb9Np5Mehmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6vzFvvkdy2+Cr2Gy0uo6vmysBa0Y0WWNtbbbxJM2Bo=;
 b=hiIYNaAcrrdbY+y+zlJXICu6kSN9oIm80VjymHzYwhohFlpC4VjZF3pfEG4ZTzgSO4d7hvtAkzWeiMNNdJeH7HrU4rfSul0D9kwTKDy5eAqvTYPJbk2qpyg5WQYRPN+G4MyuHd7JPRbww87wM91wSRZCB+Taqr/o9Oj5okA65TxWy4yRYruC9Ovh1M2xSDu/IpRZ/2vAumKsleha29GOuTkjGpQUkwK9Dq2W5d8tkeJZO5oSBVIv6s0zszBWloFlSFsJyKlb2reZ/8cz2D3nXOXCTMukbn5o/DIT1P/S7IkjliHAPIqfnR2Anr271Bmkm8q0aoW2GfhN+saYWBTBcw==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TY4PR01MB14499.jpnprd01.prod.outlook.com (2603:1096:405:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 16:39:19 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 16:39:19 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 2/2] tools/fit_check_sign: make the module dependent on
 CONFIG_FIT_SIGNATURE
Date: Fri, 20 Jun 2025 00:38:18 +0800
Message-ID: <OSBPR01MB1670DD8D2960E1977E5493CFBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB16702ED24460D23A7ED63440BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID: <20250619163818.4021-3-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TY4PR01MB14499:EE_
X-MS-Office365-Filtering-Correlation-Id: f725f9af-a69f-4241-ffb2-08ddaf4fd691
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrOwhXVdeGZL70p0mfNR3Yw2KwBcj7yB2sGLRa8RUeRx++XqZPbdIRhEnZBwxu6VIuqEpJwWftpyta0PmvVSQYT9QS7I1adCJHoS5g/Z3RJN08AVJiRElsOdil73P7/lI2zSYy0QS+gudFOd4aaPPMnulW5RRIyYPurEytgS2Ir6CJm8r20V68y/BbJYDx/YuNYXn4klvswpHkvPI11fmieyvgFhWVTfIT0PtR+urVF0nYJDPdLIaGapYNCtLKuPC2toVx/yx3zL2M6FXwY8BfgkeVLV2hlh1Ex0xr2fyTaJEiMF8qxTecE/cSUU362hkvDGwhkbdTYP9vQx2Olo9EAgH6xZSvty0YuZUUy5USZrscmCTcWOGWqOfoZ/jTpqoFMsHuvdbbBJeOwjLdylVTwNbVPc+snDsM+zSqoXm0dTMQ+3fwDi9xaHKXhxJg7tI65S5Od1qAOrm2M7W3Sil3Ah/XcRdI+SP88b9jhb9bk+q7Wt+JvX0g34UOiuuSwgbcwnLG9tVhNYIaHFBRQ+06VJztquXy+kzXlkyfRkY/RC/QAKO5DIHZRLZtkHvl0Xa8EcW5VOUeJ4eFoe3UJwhzTmx3W8ExqSWtSkvNAtRuwxGzJREZb4oGHBEcp89dP4nEYHgjf+UFWR69t6kONVQmj5NqrEFs/RhmkY0ku38s61WCh/SBE77tcsyI5ytmCtyYNNDJ0GqwG3RnINS7cqd+KFgV9D/kKlUrBgxuBYc2IN22OSxcnmMKXVktO/9bFnVus=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799006|8060799009|461199028|15080799009|7092599006|5072599009|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ME9HLDI/iHqA8IsEqs4Lzx/4PZHHtnP/pna4PuWaLijycQlerz7BaObG3bQ2?=
 =?us-ascii?Q?lxaCbgUSeL6PwDq6XkEIMspBw5bh9gZgRipQwLqht8dD1BDVuaiJGmLhWygJ?=
 =?us-ascii?Q?dlpmZSSkCG9Tq5sfuVVfCk3YfMjJq1Ig+Uz6v1hTyrdwpJRl5y0acn7JIB7g?=
 =?us-ascii?Q?st6mpjQ8aoUZGWhp70uGNVweG2IAtj5UMS4rMGYY0Qu2DIS/0wUfFabArf8s?=
 =?us-ascii?Q?PE68CMuVAaTW6c50Fv+NdhMknIaKcNedSqy+4MeDSARI4y7yqFp0zaIjjVkZ?=
 =?us-ascii?Q?tFVWP+RfCmZlLrR45sWckrxzIy8+KshTUB+AUYFr9f3uckFQ5jk+CSrm5Eyp?=
 =?us-ascii?Q?lqGYCmmPO+6Wn3zbS/MY3n9dVj64KbHn6HuN6905dd5decEcv3mrGvLVFyKo?=
 =?us-ascii?Q?tmo5HwBzam0gXPv/eJFTIouJkUCndWYaLHH6/Dkb0scTELHlQTXpHhusxUsV?=
 =?us-ascii?Q?nVv5tn+i3hGGZedRTagcExIndcO1RvPydXwVhTPOGpKsBk+q0aPV7oa+YHbt?=
 =?us-ascii?Q?TiZveZzMF8XDHg59MufbxoRPGoJy6S0kwZRadnkO+OXsUa90BDfHrWYdIeo6?=
 =?us-ascii?Q?JSXQpl0nykdsWOTxsQuL8TTzIcdYxi/MzeoSjaJSd/LrNp5PoFwscrleprgp?=
 =?us-ascii?Q?h90QZpnD7X0adyYnoL0+Tda/6DFNTmQLfxHgwW4wEkxgfYnPn8gyjNhNLmSG?=
 =?us-ascii?Q?PHSL1h7rC85Y6RlQTgf1lxqFaOlKCF1Twmg6lowGKqp816ekkKGtY5/KJq3D?=
 =?us-ascii?Q?GPoEVQTGPdjbAMIydII1Q13Er2aDT5b6Z5AOBtQXYAqBgoeakZi7+OadEC46?=
 =?us-ascii?Q?uTkUeR2DGbG8MN1ck5fnC1AkhXRC2S4tNIxJxPLzKbKda+mvttV1tOXW2w4x?=
 =?us-ascii?Q?gn3HL50jZWjeCrccPA1Wc522/lSqd4BSzbAnbDNaPmoxjaljRd4HgKNe4MAa?=
 =?us-ascii?Q?lVZ0rYMvZRd4IT7YnIrC6i5WsmlxycPCszIJlKbPK+w21gwHbQ6V/Nb/kwlk?=
 =?us-ascii?Q?muHIlpB7ivM0J1eWZ8cLzmxZNpxweTpYKrTf8YZPmXJLDDROgWB2Z1zF9IEA?=
 =?us-ascii?Q?rk7wkv401BQtfPkTeG0MXwgII3KT7teqj1XFQRtmN1zXQRmcdADkb5d5Z3WC?=
 =?us-ascii?Q?4MuhLFyy+hM6xKHqyTwlb2VcAEwp7LO1coaSzigwN7YPCyfxqE9tMFA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gQGSC/jFyn/SYW96Rbt/346OfPbLjaXTzGAmosngmd4Ajks2rxROgs7ARBia?=
 =?us-ascii?Q?/ygFdVtoPtRxhkB85oYiiGabVEOJw5n/QxwVJonxm/n/cHzeQknsJHGmCjA5?=
 =?us-ascii?Q?fXfh+oFEHnN8hPa17zV5g9jVfdccjbQApsxZEs7PHjXnUGvhikFki6VXABZ2?=
 =?us-ascii?Q?deZUMytx2tLQKQUfklbldOcZd5r52FfPvpIUsAUAuchgN5ua80fRd8i5gCwg?=
 =?us-ascii?Q?9GK9JCAsWEBxO3X+M+oL+uMSnId0mWTtEI6QpcHbscfJTP0x957Cru8MF+Ar?=
 =?us-ascii?Q?0Fu8fnUj4DUe1Hpt+Oqp1BO90ImPOanO/wtyYSBMhw51jUL17e8Cv6qJ/rfT?=
 =?us-ascii?Q?MddrfttaTSlxTss7MeWlF+m8SzmjR+KwLYYrDVtICrJlZBSbuO+VEtJ7ZPeu?=
 =?us-ascii?Q?pbJB/74rdiEPsnkBDJMeaA8KDHVHDjbFBE0aEKIluq17Ta8CY3GEZnhs/ZNj?=
 =?us-ascii?Q?sgl7cy+qf64b5WKxwqMLxu92d3hOiX5g+ik6SWIoQPbhGfWyAkFTSz9AabpY?=
 =?us-ascii?Q?91A5SrAK9tGts12cfDZ+4JK/LVVJoB/OQn/9gbcRx80uxO+lx3DtRH8etfFM?=
 =?us-ascii?Q?3Bhl+i2QtjQQTk6wopykS6W63T6/oN4w2p1x1U6fB06QxUNWHkMjwOSqlgEk?=
 =?us-ascii?Q?JfZph2r6ZD7D837C4zhgPA+WF5TicC74IAIZKwH70EoYNGPPHna2kho6Y23w?=
 =?us-ascii?Q?kBCbKjpvOzvR7mojV8RJUICR1afwqZ4+ofPUCFCrGfxtWYspObH6iWDyahAj?=
 =?us-ascii?Q?12eUNZ14vnJt/58yjxJA+j2Zk+WEWk/5Cx5Og5ei8ypf4byhybrI/DjTNsdI?=
 =?us-ascii?Q?FTBdosCRBO6Tk1eE1HNLMjjf10fqlvr6olnSjcUOJJxfBBQByCzMnz2fH3yl?=
 =?us-ascii?Q?xTGyrWZUGQfaiivaesMAPJ8jUX5+2xTHZmzAiTh0qqYGWHuQiWrpMVWPxT++?=
 =?us-ascii?Q?V1wlngIArQZfhOB0KqX2m1n5xI1led5WHxUj7pWA5Qrq/CuhjUYjjiJ4Sxc6?=
 =?us-ascii?Q?qz9SCqFnmbktUMb4hOedsBgWVbUAi+pGLfimkRi1wwa8Olfw3Xq29pNdTUTb?=
 =?us-ascii?Q?p8OYGJVVnK3Brt3iQr3vDJhxTroYabvHCrHZj+wWUdUqHJnY/lchgrOuXxkx?=
 =?us-ascii?Q?0lLA6jj8dJaQqXxqUP0F5wTPjZKjmojTVAEyKbThTmFrCH9qqJW8MJSVgzZA?=
 =?us-ascii?Q?TpMJieADhfmawUVbTuChk2V1WELEaM91FPpZopBdZEa9Ou5U72UqvKr5a+PB?=
 =?us-ascii?Q?kXUAv9l/90SGGfcAMkgK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f725f9af-a69f-4241-ffb2-08ddaf4fd691
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 16:39:19.8095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14499
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

The function definition of fit_check_sign() is guarded by
"#ifdef CONFIG_FIT_SIGNATURE" in "tools/image-host.c". If we try
to build it without CONFIG_FIT_SIGNATURE, we will get an error:

/usr/bin/ld: tools/fit_check_sign.o: in function `main':
fit_check_sign.c:(.text.startup+0x165): undefined reference to `fit_check_sign'
collect2: error: ld returned 1 exit status

Fixes: 9c79c8fe70da ("tools/fit_check_sign: make key optional")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 tools/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index 97ce1dbb17e..02297e8c93a 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -63,7 +63,8 @@ HOSTCFLAGS_img2srec.o := -pedantic
 hostprogs-y += mkenvimage
 mkenvimage-objs := mkenvimage.o os_support.o generated/lib/crc32.o
 
-hostprogs-y += dumpimage mkimage fit_info fit_check_sign
+hostprogs-y += dumpimage mkimage fit_info
+hostprogs-$(CONFIG_FIT_SIGNATURE) += fit_check_sign
 hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += fdt_add_pubkey
 hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += preload_check_sign
 
-- 
2.50.0

