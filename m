Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22580D609A2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:09:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D75D83923;
	Tue, 16 Dec 2025 16:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="GudgkzsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E9183A71; Tue, 16 Dec 2025 16:09:06 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266B483923
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLcASVUSn+n3DggpRECEWGwTBFKhZjogYwqBBH3qgpFJZt55914x0fZQucC6jOW6oZVXC15E9h/Ol9irpKDofbPNprLByKaxPEvz2BZQzWZQEYZaXHx1mc9oRV2Y//AWBBEnNjo0Xa2qyvjLxItJUfpKV4Qk39YU2Iv/uG+tbr9twhc/nmNAh4cggm7/oMGrTrstgGnObwo7pUTFSsIJUtZsg9fUv2lOF9j6QhiYkvvKHdtJEoRX8KaV0PihCisRtZF7nJFKuzKlDb0cvIz1cc1Lt0gjmgbm52rBRpPkGNoT4vppDtbgKHCzns95oyuDf8J2KnHJoD87dzhXw1EhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZzvwmrPAzch4f6cSpNm03wyJTYSLww7m26Lulje6hM=;
 b=fGjjEkRZQGVj61kr+dB+SXGouLUOJshZYEAy6bTTipn0W50tUO8YYJWYiJl4vQZjRCirk2thzPhQDEDq4WhI7OuIWxHB/EbYZU9x1Zbi5XsekhIUmUK2/3bv/WH0qEv7hxqsaMUPILkWeHp7qW1C+ASwZGPkoRA3+M7ZdVzF5mWOCnMtEoVWKuwhVzU2hnEeA+WPH9Xm/pOA6TYpc96JRYL2PMyM52fvTXGfKvXS4DI9VgQNmn5Tfh+ylAnpifes7qCjNFXFwO0i4SW1jJV1fk/bJWIP09jM7xe2p2lIhspJGB+qpnSPY2tGLHmOhE8Xv/KvndgG1rZLmLaTphatbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZzvwmrPAzch4f6cSpNm03wyJTYSLww7m26Lulje6hM=;
 b=GudgkzsY7RHx4uzPyeyQe6g75dz+0o3T1ecynBu+FJya6mXTmFdvPYUB69qVVWT8Z1BqjIk2JJi+9FbiXredMImj9qRvR3m5zvTWw63rMtW/RT1L/LXVpE6qVwQoWwHKFCaaZ9GYhITtulPW1cGBAnqeSTYbpG/htV30clFfV7w9hNkHBKBZRWqgspWCkwY8eNPOULx2TAfy1sVWa068lFPg0n/Nmbht+jDD97FIibX9/rZmPWJ6bi+4V8UFRlpYZcJzHBovfVQWJYKaBviDIVqznF0GeJq2OXpB6vODTEH35A8VOkMxfqa6971JxH+l+ctCn8hdq9Du0r+7kcg1/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7414.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:08:58 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:08:58 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH 0/2] UEFI Capsule - PKCS11 Support
Date: Tue, 16 Dec 2025 16:08:27 +0100
Message-ID: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0154.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::9) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db20969-54a2-42ba-5e24-08de3cb509b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dws+H4BGRCzUDcc9fOpNPdhUyyEglu6x69m4f8XYWXanTDKZOMF+qH1fVgKn?=
 =?us-ascii?Q?XWLl5nJi3r2uod9Gsx0qS4zduGP5NaXWdg3Ap0qdsNct3GYP31Uso+5iKP05?=
 =?us-ascii?Q?LflV0Q/RBKPrvUACy58AQKvZaiZ3WTIN+btfDDxa64X1uoHsxmKQV+Xp6x4R?=
 =?us-ascii?Q?TLCRWVQen+wp+xWRRdn1/DbNPWFnS2OJMgIMoXbja+P7f31JizMMzfNZyHvT?=
 =?us-ascii?Q?6eXzmyppV7uiqRyuTGtY3r+9yeaZXgiMgos7xkEDn4bLa3y+o8SDyiPBBSVQ?=
 =?us-ascii?Q?OYADG941VU4Hb8UPZu3zfsHONbe37OLwgdqc4/Mlta0WHPZPsgosmSntVddL?=
 =?us-ascii?Q?PM7p35X1XzXKPACksyF9wHYAo9iDKvC6czDXJNGL0qBuwmuG+v8FB3Ywj0en?=
 =?us-ascii?Q?sQYzxaA8HGpl6+SYea2M+crLlzm7R1SeALtRhQFTRz4W4NM8Q4Objk3EJtHU?=
 =?us-ascii?Q?M/Uj+fURHmxy3hlv1fZshZOSHWhBSDJ1FRFCd5WyS5InCWz5nNhkVhsiJl23?=
 =?us-ascii?Q?TLx29GVk1M99grHDe3xNIjq9IQ/T5GeLrmwTizyDi/Ezu+WF21e/IDWnhvp6?=
 =?us-ascii?Q?sFdckLPWYC04Ih67iHc0XJWq6tDfA7gRhDp/D93HwCMMZt2DnqjcBr8TNJ11?=
 =?us-ascii?Q?0EZMwI+2EN9I/HNg6CTEvaotOOMBFeRdYW8JJ12pGD3GCnYh8TQe56rzKicN?=
 =?us-ascii?Q?z2oCoHV+6aI/x+ZFNchnncjTLEybzP/dwR+Uo//unC8rKZ5UNDNPXiEPMt46?=
 =?us-ascii?Q?AASuEsm8rz3bDGRKXp2/TXeLGn/YabOJs/hoOBtDTlKtcfTh5A0bhXwnDm/O?=
 =?us-ascii?Q?e7JZdHRF60rPwRWHzjlrMDJQVPVrE90vzQR0IEMsY6DlryRXAeeo8oD6d7Md?=
 =?us-ascii?Q?UAhQoZb15mz73hwgLY1UT7o5FR0y+4iTFMLbQQrigj94f5jCg2sZnOCWj7ls?=
 =?us-ascii?Q?vkKcjCSyQjwQMcmhor5+KCITdiGi9l9oxM0KIL3VrbvqmwwINMgSbT28MAHS?=
 =?us-ascii?Q?iBN4R2Kjp5UaVyGZPWoyu6O/UJAIbk+LW7sktlH/Cdf4kFVl4ATnhOh1/AwI?=
 =?us-ascii?Q?e/IPAgC1yQtWCCQQSfPUPadkEqMuaYniZvitNcOds4qQnIqZ4fdH2+a7Tcy8?=
 =?us-ascii?Q?TECmBxxLRGvsRAudj06ink03mkJjyx9iuYZoozRdBgQYlDUcC0G9BEctyvv7?=
 =?us-ascii?Q?jOyxLZJhQdLbQNWyGk/LJTaKhuILFRlg98nhhicAHn28QjMOPEPp6M3141nh?=
 =?us-ascii?Q?NVAkCS3loe50yWf7ZGDzI5YlPAx2ISLi74xISFioBmLr2nH1nIQ7IFZ902Rx?=
 =?us-ascii?Q?HN3a8UgFEJ8dzzG896GLoVonFIeL0BW7RNeDgZVTG4j4JjNuE5Uf7dshqmkU?=
 =?us-ascii?Q?vqDsqY2VwihICBtqSoqrrgiCpoLwsKCBrzX1KIvLq8wXdcE0hNNBSGWNCUV1?=
 =?us-ascii?Q?iqzEy6Q/ktxsJA0grHeyIJ10drdbnRME4J5cr9rClHBIIzPimlXwlSuFbz4N?=
 =?us-ascii?Q?OAMZsZzvqZ0jWDpm/VcYAfmae0rH5q54STkF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xjDIh7pc9U3lWvb7JAHlELeN1fxqP6L8YjH3CaWp3/crxRPIvEx7h/xfSv/o?=
 =?us-ascii?Q?RE5+dp/nqxq3tnHtoFqPoW8WMTSLDsQAoFBcm59OawYb3GDuyAQW5By5qvSP?=
 =?us-ascii?Q?lUjPFsUP/EAA0gd46ZwS6xh2qm6ZHLj1TuOm3TiQvu4p7wkysfaYxotGfcI9?=
 =?us-ascii?Q?1UTOCHhf510zTCdTVUXi+7Jp/O5pvbQoM/l9Ux12ptx8H6uoWg+ku72YvK/p?=
 =?us-ascii?Q?K7qnZ0anTKG0KMMPJeiLqBC5asGwy4gpToqN9LSCWMX/l8ocGY+ncrsknW8F?=
 =?us-ascii?Q?hBmY/aPhRH+iElZva+jnrhui9DrxRh6Z+WN5keHrzADIennzt4GrkfzVRfob?=
 =?us-ascii?Q?6U2hvHcl/W+nB9R5FI/TGef7P3P3YIL43Te8jAlIh1FOGaDHbsSDk0irojwO?=
 =?us-ascii?Q?hGdLsobs7msyAuNKfEij6Bph79klXWBZiBchcL6nBtGlQhxBs0qxlUPH9lJ7?=
 =?us-ascii?Q?hi3iiz9v7mf2Wr4leNyWoVRl7F/kKFEjjwP0ml76Zg8te3rSwcwrJG279COJ?=
 =?us-ascii?Q?a5pTzXt4fnVXAEYtZQFKlweh0TG3NCYyJ8Tx3LnfWCwTp/tqHhUnH6ypMgXy?=
 =?us-ascii?Q?H+4/Mq4TuKZ2BB9C6GhgFo6sSZ8OHX1LzX/3RcC5Jj2AGnwA6QfYWrNYwyFS?=
 =?us-ascii?Q?t3Q9otNNnzkhcr4C69/3PyIg28WzJ8DW+oiwTwEqOUnJInZCAYgRVeTsJuyt?=
 =?us-ascii?Q?C+uvqQ8rx/1dyJV18D2iypjEDVWobRqFBLo0JFbB9Lg8u/hBL6jQP9rbRZKC?=
 =?us-ascii?Q?5BHfSEQnvnIqEEyZp8vFnLRfX8PrEgRl1XNN5P6xITsHD7s7FF6yWpVmU/jk?=
 =?us-ascii?Q?L5Det1mY/ug1PHgvVnrUUx0iuXH48LlplmmC7YJ5AeOFjUIcTB7gDCRIBElP?=
 =?us-ascii?Q?ZgrxR69UfWeZjIqwGlqoMLpQO9vmYLreVaiQfIHHFaLMYBHKbyPfwQ8I7egR?=
 =?us-ascii?Q?jM24AQn+z0FrKCxYSHApcR+k0wpocsrmxlFdtI2GRDk+nJJgLoju4qbs1fwo?=
 =?us-ascii?Q?d3P5N4fme+cAOxPMqwXJNoka3isohA/gyKhqe5RehiweBekFeSGdxF+LNq5S?=
 =?us-ascii?Q?Ce1Lcj4ogrF4eIs1J2U5EH1f1YEZyZJsid8PpECfzHNIN9I95zxj+4Ts6SEM?=
 =?us-ascii?Q?fnm/w+Bs1DHoAq6fGVQ7O61/xRtEnXTo7yZJEv9hvzMH9svtPEngAOd9ObTD?=
 =?us-ascii?Q?QqYun/teHVNiolLDHt4FEu9up4NW3kyzT6c4qXZrfvqoeWgE/LitpEWGcNNa?=
 =?us-ascii?Q?MuOPwzrlMj2X72PvKuRFYQLNx+pkHI1ccTmuk790gsalNKabCOYRUqGwWrLh?=
 =?us-ascii?Q?X2kTgjojNOC+x92oZrxkunHYsKhh+yXeeIVBYKGU1puoRmqicHQl3vzIBEmN?=
 =?us-ascii?Q?2lxDG4m3Q+oimOvuIflwa7Cn69fs8NPY2l9DUdlCPgCK387TbYUISFbKvFKt?=
 =?us-ascii?Q?C5ueIyfqWz4sTlmarXqMHw4dR/vjWwDZ+iezZ5eHkYEh9kdYSNHjdPIIf9yS?=
 =?us-ascii?Q?kYUKIz0sbvegrthxhIoFgocVqDTdN+A69aYmik+M4Eo9+LxxqYOrU7lcgpUc?=
 =?us-ascii?Q?hRb7dtzd4q3A088MMopjBxfQuvhqIz1BgvCkAo7b?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db20969-54a2-42ba-5e24-08de3cb509b7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:08:58.3796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQXsCkj5aRezutTLPVmjhd2o/3TM0Q6FVtVwv8M1rmpbu/kBg4zT5/hlvszx0dZSKFHMseD9lR0QonaC9wLwag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7414
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

Add support for pkcs11 URI's when generating UEFI capsules and
accept URI's for certificate in dts capsule nodes.
Example:
export PKCS11_MODULE_PATH=<pkcs11 provider path>/libsofthsm2.so
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap

Wojciech Dubowik (2):
  tools: mkeficapsule: Add support for pkcs11
  binman: Accept pkcs11 URI tokens for capsule updates

 tools/binman/etype/efi_capsule.py |   4 +-
 tools/mkeficapsule.c              | 102 ++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 30 deletions(-)

-- 
2.47.3

