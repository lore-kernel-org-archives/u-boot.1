Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBB2C369DE
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 12:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DD1788A0A;
	Thu, 26 Sep 2024 14:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nskint.co.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nskint.onmicrosoft.com header.i=@nskint.onmicrosoft.com header.b="KXIOXS2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3CDE88CB9; Thu, 26 Sep 2024 11:26:21 +0200 (CEST)
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c407::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C86818891E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 11:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nskint.co.jp
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=k.kurematsu@nskint.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM149kBz2PY7qhDpOFk4Bx7AMRRmT/KADL9E7o65Y0ZUNj7DJLLP8gqbxDUWsR2LvlOIFsqJtgjcPhfVZC8MQNKn9scaq+sWgR9Am0cGsvIvfJResgwi93WDf/LA7cP5GwFoVnxcBAuxNlY6EHP9zQ/haTxyuxw3eR/zSY9JqjwJdpSlNmgQwDJLWAeibqB+KJylspeOaGN4ZuaKKbzRUSl/l5zFtJXshG1oxly6EAtAP1SsjmlLWdxq4GVHx+oz7uxsT0Gyj5aT8k/yrmiX6GrOQrqFk4HOT8Dfpz+uT40UHEbDzllNBxrT/yYMlp7jYYjO4PuZYBBcRBVMPaFqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3f1Rx2Tazl2Wd6VdQSpYfsVWx32mDOOp0Jkzzs2wAQ=;
 b=DX5uYNT5Xab+fERQwumoqfZbcB+r/jjf56+Brz8mDpgWTFuWBgAqTFPM70Zm1sUpNq47KGp5flIuxpbHdwmRNEtBXP7LBbilwCbVzn2niEKGqXeaMZ2XzweZqKGjp/3oxIT18KzImbx3WyHEiCpRUyfqhvpP4JtgSp3UJ9/MuhT+0pEzTnHidvQE3WjbxEcSEYhMwHugMzc9giZeZkQ1BmzO0CjZUF3+mAKgBp7TWGWY58zTr2ce6k3Ub+IcZrCnbKEQlPV1Y/6quWKu0/GgQoA9xjQpWsSMTSJ0cQ7JC5NVynkWeBnbu+Q2MROadT26J2yQkDOfbT8hkAYyYoJ9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3f1Rx2Tazl2Wd6VdQSpYfsVWx32mDOOp0Jkzzs2wAQ=;
 b=KXIOXS2iWjIvMCdhusO8inwSIQca0ABtvEi/QisnpaYmLrx2xrUvWOjUY7AzzT3Sr0a2iINvEJiyKdinqweNRAJWg7S4Wcu1zp6qysoJD3ramVCh2J/ON3g0ah50ZgZB++NKRRm6GaIgPdU8jJVjo/shS4D4mfhY2zQIzWniwyI=
Received: from TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:10f::10)
 by TYWP286MB2053.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:162::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 09:26:05 +0000
Received: from TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8585:d563:db6e:848e]) by TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM
 ([fe80::8585:d563:db6e:848e%6]) with mapi id 15.20.8005.017; Thu, 26 Sep 2024
 09:26:05 +0000
From: Ken Kurematsu <k.kurematsu@nskint.co.jp>
To: Tobias Waldekranz <tobias@waldekranz.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Masahiro Mizutani <m.mizutani@nskint.co.jp>, Yoshitaka Ikeda
 <ikeda@nskint.co.jp>, Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: [PATCH] doc: blkmap: Fix typo in command example
Thread-Topic: [PATCH] doc: blkmap: Fix typo in command example
Thread-Index: AdsP9Y161X5HAWCPTFK+Z+ythlJe+A==
Date: Thu, 26 Sep 2024 09:26:05 +0000
Message-ID: <TYCP286MB233485B48812E07222B95435DB6A2@TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB2334:EE_|TYWP286MB2053:EE_
x-ms-office365-filtering-correlation-id: 92e1467a-2288-451e-8594-08dcde0d3ef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ep/norViHsnMyVuZkr58RGhmQBTenhQvLPpf3Dvvy+Mi8DQwgXXlZQiAgXDg?=
 =?us-ascii?Q?Nw6zhewppg8a+ibBWNx2fvLVz0Pw6I+n+FNh8PM4ndnk6UVZNFfStN5ZsnNa?=
 =?us-ascii?Q?aKdY9wy3dCL8JqMNUNMecG0prXXGMuw9rg5Nq6OhK+6eQ0G+Vfy22ovvjdWz?=
 =?us-ascii?Q?f5gLpdxqXtRmcJrLkGtTL/qg0spKqENFRChYlgqgTbpsk5T8OHUHqDe7lGqL?=
 =?us-ascii?Q?2XWgSfmUlh5VnPSnK3y/WanJ+4KqxS9MGR7g9KZwkKoSJTs/dSxYVcTy2/9b?=
 =?us-ascii?Q?Xr5ZWu2fWOUwH/phQ7joi7TFfnDXYxV/JwVom3kBndMIMin+b1D4blsCd64C?=
 =?us-ascii?Q?SIeAA/7JtoUfWxvLVrORLV/qby1uTZUie8w0PDEY0sQctzo/LyWSr5O/mdX4?=
 =?us-ascii?Q?210Z5vFeEfYLW+Mtbpq4XcXuDccdUFw5E27z3TJVlz6k/YSX2PWezlnXxwVa?=
 =?us-ascii?Q?DVl8gownKXoLHDevssA+VSlcdK0RpusTIKLd8+548xgv2prssS4/WMYu6L/w?=
 =?us-ascii?Q?NqRnUJuEYjZ2hocP5L6xbV8iltI9CUk2vm6kz9DGFtXjxBlm9vJqe7l5yxLx?=
 =?us-ascii?Q?TOzWKzqQe2tFMUqhQSz3zV7NFs5L5KkS9hpm0oiV7fLL/c6+pi4FrOli7yFE?=
 =?us-ascii?Q?ScOPWw6Tlr3XlwulKgpuzEk4uEkcFOi18DDQwv2R6xDc2cwz7sYYNcxgOVFd?=
 =?us-ascii?Q?6o2eRmrzb68MxtvNHTSyxMGebGW1wK2LMvbm7DnyqAYU7qF5Sjsh82wvPRWv?=
 =?us-ascii?Q?ljxMSqiq5IBCcZoGkyvrIoRAner0AIJTQMaWXSqzETOFYvDpRaAqewTCJ1UM?=
 =?us-ascii?Q?1UCRCLpPubULCclJ3zHj8ShEwdfnwVxXfdPnNvX4Wlu7L/Y5TR6jEoa/GDbA?=
 =?us-ascii?Q?i0aeSj7US8L1zpwz0h4pfZ3vHJMWLaCeRoarJ+zbgxwKKEsLnchDiFK+PRgZ?=
 =?us-ascii?Q?WkvqcpinDgaf0Pe2UdYzMD7Gu6QEdNCiklAX0qxDcCOIjHwNREqmDaWoxNgT?=
 =?us-ascii?Q?/EgyyLBx8c+Z/R+kKYGzAzBVocEFuG3JdmoRBOX+olAkaqkF6qIOCNjeJO8L?=
 =?us-ascii?Q?mBQ9kAAU7YXGxMKhjV8/42TaHo0YKStvSin0Z1N2pdSDeRTjwg9Gjn/Lb1rs?=
 =?us-ascii?Q?O133fbjuwW472mduNWPvRRFjgPS6CGsaXFTipjSk8PkfFgXmVOh3CPLcjxGC?=
 =?us-ascii?Q?rp72xC5msKdd+9cdpixzKHSUVenpZkTAdCm6YrdrjNbcl3DcTU7tU7SlHA3I?=
 =?us-ascii?Q?39q911Nf0SOcxLuVruiWfXTgtZNRy078n+PEg57JHWFDDkML6ACcC3nBOb3P?=
 =?us-ascii?Q?MnsZM131dpVQfB1cY86QCSTdi1/hCDKDpqG9EgKCWYwRRfEagaZKXJgtdciL?=
 =?us-ascii?Q?97M0wolFjFFm88ibIUMeKfalL7NL58fcMfSD5k/Jtb2uMUvtEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lvRNKMfnthPB6kMgj6bNB6TmI1/2b97yQGYjfJRa0mAXpaF4ZD2u5U0D1MYt?=
 =?us-ascii?Q?/mX/9FJLuDJ7n2afMaG05204tzXNYSigNmIM6RZ5c+PLgrT7/v91BVWbcfQG?=
 =?us-ascii?Q?SFt0oSqMk8VJnpO9iSb9bLWD2CBfkP3dpPjJ3IVK6JrTezr8oV5VqfKcesN3?=
 =?us-ascii?Q?FOiKFS+xCfSTnWXaOfUzR+nc4GFYQbYU3YAIgmP3BEuFX02MHmrLukLbBGva?=
 =?us-ascii?Q?31g4XdQKxgqgKCTWx8AA9MnLb794dJgr6eHEXjavBqH7fLHlzp3MhB85/ofJ?=
 =?us-ascii?Q?O1JDTmp1XskkOvSL/hFCNkiWbRDYzBxhOLT89cVN73/eui8Hhuvva+cDb2Ci?=
 =?us-ascii?Q?ikc5swR32FBfTB3zenlrx9PJkU2GNb6avjimTBhHF938hSGUAL4qymFkQU50?=
 =?us-ascii?Q?lWUbWjwBWYmZHEjFMKE5Phy/U+8hmzvQE3KPNM1IoMLGBfx0tbMxkXK46rkn?=
 =?us-ascii?Q?c6CxkEEPNAcrh5GRY8I2/UtLYtL4QPVGmzO+bAOOXeGPaasXPD5usniHHSbP?=
 =?us-ascii?Q?JmZrjFZDC3lsquu5AMHF7tfKcl2PysYZ0mgJvDttXHZiBPZv5X+4mJuNwgnb?=
 =?us-ascii?Q?cJ0wZsjRie1c2IBcR59aaJBWTx5IhW7M8dC7An/03a4tB4JX00V4086/PnuS?=
 =?us-ascii?Q?DJ0f+QrLFeha7d4t82lwc3X7xiKJpUgsjJQ36pwt8oHuGVfyDVnUNXxZ0U4y?=
 =?us-ascii?Q?fq0Q7NUt/YtrZsc16ZWOYYdnoxmTmnsptEvF3ptleG2OXJbLzIEGFaBsJi3o?=
 =?us-ascii?Q?eCaiSMTZxxFZ4z5USD0GZ5Sq5QO0I0AY9ojsWCmTQEpNOmLiBOUFA9rCCac0?=
 =?us-ascii?Q?QuB0lBHZcFjI49H61dG/EVstF7Vv6ccK7vhXo+cHkQMV5j/oF+ZUHSQRoXf9?=
 =?us-ascii?Q?Eo0ii/oVkF6Any+X+kf/Im1kun57eYkEC/Io0wTVbWhrUYXaTEmwpaglbkJq?=
 =?us-ascii?Q?BmAFr1jHDvW2lKTa6gqntwiZpgDGb1jUEVa9E6kjeKfswzN7UReUipl368it?=
 =?us-ascii?Q?lVhBpHYMbENyw2zLv8v7u3/0ox7fN4R6lr/C21Yp5sm0R/fWhoUEJEM3PAZ7?=
 =?us-ascii?Q?hs4FjTdc2HFwHoPBA7A5ZHRMLQSVL7bgsKWXer3LeC1YOMwz5ziRdKIdEHhx?=
 =?us-ascii?Q?McLTMLm0AK+OCKxvU0qn/mBSFhB6LSFj+k+Zl/zltKvo+CeKHhc3yJu9hnDa?=
 =?us-ascii?Q?NijghNh2QhF73YcjTxGcmailwbzSE+QLD8LcgjBbFhSCjSXs41QlsiVHDVf/?=
 =?us-ascii?Q?fsq8RAhasq0XGiQNR5uriLS23S6+M2T9UpRGxQloO7NX4YDSo4UbvbLcZGc/?=
 =?us-ascii?Q?CGwXgzQrh/UxaTGc1Dq5/V9bv/cUqOENQ6DiOGI12B67eR8S2ur0Adl5OpS/?=
 =?us-ascii?Q?i6LDstyHlecqRPW/27aqQZp4Jhhiku1TBP1kmOm6qtPFrPyp+6HxNagp7dg5?=
 =?us-ascii?Q?wdpb5v8JsLs3gmbbKCgeBbuPhDUZQCqnwOTW2VBsYssxEMwJsdHkmNFpM/pN?=
 =?us-ascii?Q?rbAgtrRHdCMwNyQ/8GA0iN5iXC+sUBDfIZ58Ieo9q5hA8kOpvFGe2RohwCUy?=
 =?us-ascii?Q?MyCLk2TsKOyknDIdE4VaTAQGZKE6BWfz/nbjaD+V?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e1467a-2288-451e-8594-08dcde0d3ef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:26:05.1370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /URbvjxkHXqV3ZoZC2HUxvbvt1gwazKoaB5C2ZEYgFNQ1o4PCf+8yonI6wbpZPIC1QBx2eeo6ZM2A2wMMtP4oWTfAaH1bm9tybV3ViBpV3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2053
X-Mailman-Approved-At: Thu, 26 Sep 2024 14:26:32 +0200
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

Fixed a variable that was incorrect during the calculation of fileblks.

Signed-off-by: Ken Kurematsu <k.kurematsu@nskint.co.jp>
---
 doc/usage/blkmap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/usage/blkmap.rst b/doc/usage/blkmap.rst
index 7337ea507a..75f736c259 100644
--- a/doc/usage/blkmap.rst
+++ b/doc/usage/blkmap.rst
@@ -54,7 +54,7 @@ downloaded file, in blocks:
 ::
=20
    setexpr fileblks ${filesize} + 0x1ff
-   setexpr fileblks ${filesize} / 0x200
+   setexpr fileblks ${fileblks} / 0x200
=20
 Then we can add a mapping to the start of our device, backed by the
 memory at `${loadaddr}`:
--=20
2.34.1

