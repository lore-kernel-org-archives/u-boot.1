Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C409C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2529B80BA0;
	Wed,  5 Feb 2025 14:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="skcNKxE6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 502F780780; Wed,  5 Feb 2025 11:15:54 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A528078B
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsaDKF4ifgmNEaVMSVerj6QdJVhGkokEM3rf3srKtAKXOtXGumDCGz+/iEt7N0wUV0rHuy6ArrbZ3oEXS+MskCbR6/EoZhZ+dpKXh4mc7pzNWfi1oysZT9Zm7NTcYKInagFS74e1Pca7japM3EPhYqHg1CN6RraS0abMyOIEHl0ZKz+ISOUtmofiZBbOiVJO/HZrDthXnIDffO50JK5DhMqDGsDYVz5oaGMC558NLqJV6EJe1YzimBPNKvV4f2XoTsFgb6N18KBRo642c5SDaEBLfAQObNaMcU1ZSsiX3ewFzm64FYsPBCduGZKNqzVEApIK+pmXz5OZXxNDFADEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34wIgJz/wak422r06Oc/YeeP5pmQskdhQ2cJUoqa3oY=;
 b=n0yGfsfjl1S8hQZ1jmrNz8tvgbbtWj6COLrwAXCT+68GnI2ZCQQwClzKWTDHStS+vlI+UhZNCk9GXrqU5OFNPh08sxrQpqMCe4uwl6NxRbDivXh3kEnS1E485uBtcAexCQMnNT/hQA3WyQNFZhKhKyoEwzjMugWUpwrMkbwbOJPd5MrJEwxhotB5Riloh4fOqr+mkzbr6ZQ/bRY4n0Y/RE/X+scXm6QmP+qvILKLYnRZPUZPkeEhYvkbFDCQZWC/Y8A8MRafiI0Dj3VnhQ9kjBdUVjqEaDr9aFgPVXoTVANaMKscnAgGyyI6K0L+2KduI01JQjA0k45FjgYONrLkmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34wIgJz/wak422r06Oc/YeeP5pmQskdhQ2cJUoqa3oY=;
 b=skcNKxE60NNatrwBOSOdf2To7h7zWED+bK1pxZWQ2Hya9gzKREqIt2At9uFeIml1myjEMrWt7OopsPiA2HTng1ju0gyz/IKvpUSiEfrcaaHm/ovh89BlBzFkrVaLpZevTIvl7b4QjAXvzGALKJ78+5gNzIvDObdVnDZzyn1e1lLgrb5qpBLQosGIG6ra9TNrWo27gDM7zrvcbthFar7psH7CnMSagYESDau3SujdrnVe1OVbheJ/qEZ486JpRugR7UrtlEPH2tp4oxOb+la58HpTS8I3dTXz5AViCeCOCvToR9s2V5fkHeCtKg22jhKuKi89Ab5cZbDaZpMuWZUj7Q==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by DU0PR03MB9635.eurprd03.prod.outlook.com (2603:10a6:10:42d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:45 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:45 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 05/20] drivers: net: macb: do not include arch/clk.h
 when clocks enabled
Thread-Topic: [RFC PATCH v1 05/20] drivers: net: macb: do not include
 arch/clk.h when clocks enabled
Thread-Index: AQHbd7bqbZ3i7h07JUyAGHxnPeCOww==
Date: Wed, 5 Feb 2025 10:15:43 +0000
Message-ID: <2a2ea020033af7a2b7d92ce15d0111578cc09036.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|DU0PR03MB9635:EE_
x-ms-office365-filtering-correlation-id: c1933e50-45dd-46b4-6781-08dd45ce0dfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?LcPGGUyiZGEeCwL+3fU/PZ4sKJvvYenpZnnpX6vLkFPp9ISgGIkuefs0Vu?=
 =?iso-8859-1?Q?Ce+7EWslqTaD4fgcmmxbihTiyxUhE/2wZR7RxYUKxd/u24rnK4lDA1GnvU?=
 =?iso-8859-1?Q?TWZ7zcX/kcEbuEdn72kiTRZy0XCDy1KTDysaD9QS81ecL63pSnsr2atDZB?=
 =?iso-8859-1?Q?Mo62qLao86+UZRrLXiu1C07YN7p4Z2T2VHVbmlU9wz2z6UK1nvKRPfVlE3?=
 =?iso-8859-1?Q?S2RXEchu2HF6hC7Yy8Ti3f8ZRbgmJlofkIieqAwQ+DAD1gTCSMcrLTuGKJ?=
 =?iso-8859-1?Q?9f1/p5uMIj8ze4zU6gd1BCSt9HDMBBrNORFB8iMopGl27II2VkchJfUEhB?=
 =?iso-8859-1?Q?mWS2GCAJXDgn9QqV88dWRdyjaDonAzuXvShM/P9i6Be/NTCxk57SgllSLs?=
 =?iso-8859-1?Q?lZCltBzK8mK5ZvbNHEVMrcAHq7h0gku07UMqHq/lwJKA5YUKN5KK63lFeJ?=
 =?iso-8859-1?Q?agjRr9eTzU8P2/qEpBDqm8gZTvrB1Ml5o/xfN3t+Etqsdt0fS/mCVEvXU+?=
 =?iso-8859-1?Q?bWyXF2tqM8Ot4cKIkRZ1/Ew66MRB3VWhcAIkK1reZONBdIpsPIA/e4GTe3?=
 =?iso-8859-1?Q?nZ3YHdzJcxLUwVkwrlS1Yvr9uBfgAv04eepLaljI1/qnVhKJzEzuw0G2wR?=
 =?iso-8859-1?Q?r9bK8emyyYsnXq9U3a342Bz+Blr8UGXjM/XOZh9feMYZheMPrhT5wxd/BC?=
 =?iso-8859-1?Q?KuF22lljz4dJSw5LkRft5sxW6d+fuOtF4YE7jjTWmVsQzqz3wa8f+aNK/C?=
 =?iso-8859-1?Q?Y6NXtmVSZtzTryc9sfo8UhQC0GAMEpux0uL6pCTjCTclDhOVVBCQSse0oa?=
 =?iso-8859-1?Q?CbfmyA3PH+HCR22r5Zvmhef7103xi5uI3vbkUFcdbzeRcQnFq37VNhwzPb?=
 =?iso-8859-1?Q?DmSzUNZ0TKJeHzGjC8G/o4KGvLpQfo/onCwMkEtucdZuM9/ubG6uN6wYi6?=
 =?iso-8859-1?Q?tnnYxdd8+X1Sz1mtRnYzF5cCxyrW77as2Qk/ok9QSGs4hGk+cl+U0WmIch?=
 =?iso-8859-1?Q?JclU4CL7IhOCU8oUqeK1CAypanvcZZFE5bz4KW7iReJfNgEzOiOPdrKHDb?=
 =?iso-8859-1?Q?expQz/UB9uA69JIERYOs0FVSM8v0JTam4dRzPA1sVt48R5PzhBaxboCVLG?=
 =?iso-8859-1?Q?DMkHnfd6VScK35hSCSRfVA/olHe/Yiwt78k/7F+z/uwwlxS6mhIoaFOiWB?=
 =?iso-8859-1?Q?W9q/gs8Zh5XWxXooOUEP58a5OfPpBgC6qlzksvf7Bcm3uRZHxtRjt6h4FZ?=
 =?iso-8859-1?Q?rX2be2otp2FSA8yA42m9lOCdQbbnanqs2BgkmcfdVofYdiio5g/+drX15K?=
 =?iso-8859-1?Q?9WOVVLE4XJM9vJNaS26ighDdpN97wkAV9tcRPGXwFJH0uVi0HNjkGiKWsa?=
 =?iso-8859-1?Q?ZKIowv1hNgB7ciDDuCjeW8v+VZxrVho/JiMWXzR+gR62hc/qEkkqEruc8d?=
 =?iso-8859-1?Q?e6O4baJUS6RmjSpZybXHfQmW4ZJM4XevGtGfadyfFaOzTYBrAVuw3zOesz?=
 =?iso-8859-1?Q?VsEFSNRttgd1la/Y8WB6eM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V3tIAvs5Y20wnTMTTSATq5Z3jreRWK0rG5993MPBp0xDCm+UZext8bDzDl?=
 =?iso-8859-1?Q?I3ujVEenziSEyIpS6vVCQT9/qUz0Ac38MTfOfAYAkptGk+MK5CJvytTbA0?=
 =?iso-8859-1?Q?hEqUlOSWL4p+5ifcvgKOuNEljWwGQZPyPruQUnrJwm8ziOu/7jNkeeVDpq?=
 =?iso-8859-1?Q?cmJ7QOrSaWg1Zzq5eq26qfILAs+blDl4zoERkspIofWsCaU/52auywwEhQ?=
 =?iso-8859-1?Q?fNOg3COwZTtUpLyI8P8tSH/DmvbXbWaKzWpkLRoStJu0p88mXK90k8CJhC?=
 =?iso-8859-1?Q?9/KbYWDpxx2OsKTGYpFnTIWJdJPGdAmLXbzWM0ZUf+8l9yQ/dArPpkdwcN?=
 =?iso-8859-1?Q?9PIUcKHBvEeu315aYqwIbJMYz3uo8L5MuYcCT4mDgz+wbiT94F9v5HiOFl?=
 =?iso-8859-1?Q?aqOg9pBwKjJvLdwe31D0AYlmd1lGsSbAwCvr44/ZX0C9nUqT3KHCSh0Rr0?=
 =?iso-8859-1?Q?EqT3Jjy8Ru5OPIfjdWCahRXR5uwsyNQe2JtEs8VCbVPhDgnzB4DdYRP9AL?=
 =?iso-8859-1?Q?fp74aHHNKt+qnpeilCL2mfcKnLH8sEw206M1nfdIMI1b1iE/PEnM3EWHgQ?=
 =?iso-8859-1?Q?vCQXsDv1poqtyObAqUspQFmNpyCzXCPnlHl5vRmD/4oxr2JaxUAaiXYnec?=
 =?iso-8859-1?Q?lEXqEYtdoBDjjbMIsjtB9+qEVLznJUlmIbY2Il22UgDsFoRI8yUzCd0D54?=
 =?iso-8859-1?Q?0X03jlJiP7adrRnQKpQHdVTeBNripnP/wXxD72eWzsr5fzxSkJQ0q0cuLS?=
 =?iso-8859-1?Q?h+UL359RxHU5+Qbp0kgZ/cm9P/JEu30pdndK2PwtRM6EizsGn+2NW/4bjp?=
 =?iso-8859-1?Q?0ybpnGVVX5+7b6zx6EcmZRT1FbPzqa/i31uAmoplhrWHRSn4V1vMqCSk2g?=
 =?iso-8859-1?Q?Mj7sM6bfSZrrjb20MJNVyIRjtpzrrzmsIDam4YBCN4N1Cf81k/k44w9JE7?=
 =?iso-8859-1?Q?2MJiLMmoPRt5r7xsg9i5EF4Htij7NXjYFhxW+ZZSrlEcZOYsHfolWUdx3o?=
 =?iso-8859-1?Q?UzF/XewH6Zt33zZWvI0qVHIbPm2tKVE5liVbl4MZT2ipSvNBDYKFF31Sch?=
 =?iso-8859-1?Q?6cchVIo+XDAvLB965FyXLTyKexJ6fWjdqlztXAgevuG/km2pd0MCeAbjsu?=
 =?iso-8859-1?Q?zksZbBmmL4HWbVMbvLwp8/ZaIExBodT4G2br7FFOxLELy3FWtZgoSezeW/?=
 =?iso-8859-1?Q?oygSuMg6GYB6CsisOfMR6g6++SBOuVQH26YHmrGQzx9fM9UiD3TKaXz/rF?=
 =?iso-8859-1?Q?QxrUwm8x866ySrWtm8XMqjo7qFr+WjDrJE2pSPy7x8uTSzpY41HTUjRvO1?=
 =?iso-8859-1?Q?Pr0H6nFMZe95AvjpteRXni37l89qXj4bH80Lj6q3+sGv7L7sgIa4vjjpA5?=
 =?iso-8859-1?Q?AT1VeWOxYZ6AkazHdv6HG7nK4DYUKsxV2IDDFswYpU7OyMDNvzfWxQI+FK?=
 =?iso-8859-1?Q?XXMNDp2Xw2OdxEA7a1F4u59OWtDP7X2Wvb/vENxFhwE24imERE1yLG+ZJF?=
 =?iso-8859-1?Q?WQxfs4o15TSi9ZvkX390P5l6y001uL54hdS3LwXP/T9xOrlohqKYEtyCJu?=
 =?iso-8859-1?Q?fhopY6I+4L7hfp0xx/a5ZlIOt8DzLrmOGLjBeHM1aAHGoMm3g8Leu64YKH?=
 =?iso-8859-1?Q?4goRwe8Sx9OXp0TL/JArcpweAEKre0mmvcoTy3uZ9YvbiM5Z9ON2iCBw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1933e50-45dd-46b4-6781-08dd45ce0dfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:43.4705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DTAB4jdmBPHjaQbCIw6XdDSCBIl1hhnxy98fIcYKrLiroO08thzOLkUDDWeXEgHMs+m71uxp0tBSAiZ6AHGVu4tSh6tDdwTCkCHZ210dfUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9635
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

During initialization MACB should request clock rates to work
properly. If CONFIG_CLK is not set then it uses special arch call
named: 'get_macb_pclk_rate'
This function is arch specific and should return fixed rate for macb
clock even if clock subsystem was disabled.
When CONFIG_CLK is enabled there is no need to include arch specific
code and no need to declare 'get_macb_pclk_rate' call.
Added conditional to include arch/clk.h only if clock subsystem is
disabled.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/net/macb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index bca014c3cb..a6a9a9b5d7 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -39,7 +39,9 @@
 #include <linux/mii.h>
 #include <asm/io.h>
 #include <linux/dma-mapping.h>
+#if !defined(CONFIG_CLK)
 #include <asm/arch/clk.h>
+#endif
 #include <linux/errno.h>
=20
 #include "macb.h"
--=20
2.34.1
