Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE16CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:25:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CCB831C6;
	Wed, 27 Aug 2025 16:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=issi.com header.i=@issi.com header.b="NDdzDsdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 726CE83189; Wed, 27 Aug 2025 01:30:09 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B748313F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 01:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=issi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jeyu@issi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPLhs5J12PeSu7baK1qMIO8wuy/uVg5MHai4yO4DBtqzgrPcKVGSSZcD1AoaW9TlDsmLFBv8pJPJKP+ylC8fZnQX9rcCAQZTUIFKBHQ2Ga+7K3e8xLkn7p3wnuL5vEZZ1HucZL8HvasrFPpcxzCF1l5d9yOYIMbjDAT0Q4KT5VF8U8il8exH8bUHSoTEr1aacMpxw1KoHrWKIZ2lOw9wGwMvrOMJpGsbJVduoMaR3Kx3A69d54U+cl7U+UAR6oZhw0spsWNRts7DEjPRbwFKAgWhJVij5huo/cJnIzUSh1mgDWSY/iBKAQO0qgRyN6fS81Bm8M+rKMaz/9LnpN5TMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndDXX37kv8JPtuYmOtv6/w8y5aRDgvMxqzaLJx9ZIk4=;
 b=C8Gbz2HIBAWQJi/TalQcOQ8tRro5plA03x7SqeL4qF9xBk8wW5gOOXQfnpLAKjxWoyv4GmSSTdlt1eU4amr3vrvC7LQE6juexmNkHM5s14jW6ldxlvL5wE/E9CzbiZCPd45av4wksRwuGXc6Kz6oPg5aiPpZDM0WPvsu4TO0rvn1VNku5Wpa+h2KETvwLZcmwImCoH7z8IdU0In+B8YG7YamVDaKa59eD9qmxfeWo6HHUg7Q7mnTsW8gOdZE9l38eg7gJYwrY12rRTigA/ZyXYqMTnr9i2461JKoLoNlNW4kXa3+mbuvKPLgd4qnxJOI9kAfuRYiSRJfKdNChNfT0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=issi.com; dmarc=pass action=none header.from=issi.com;
 dkim=pass header.d=issi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=issi.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndDXX37kv8JPtuYmOtv6/w8y5aRDgvMxqzaLJx9ZIk4=;
 b=NDdzDsdPcnegkYcytOG6RhsDDOh3PAwV9w7D2Y4KN/to6zqOU79Q4cX3ppWYr7Xg9PqsMO8KpIiDafhu0qzm/SyNHrJq2MKQgMtdmSTj0+QGF9QIur2mHTF0CfgmwL2HMG16bk6rEDIgtboGA0I3qj0E1H1/sx7LBxBkyTkgh9M=
Received: from SJ2PR19MB7366.namprd19.prod.outlook.com (2603:10b6:a03:4c2::6)
 by DS7PR19MB5998.namprd19.prod.outlook.com (2603:10b6:8:81::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 23:30:04 +0000
Received: from SJ2PR19MB7366.namprd19.prod.outlook.com
 ([fe80::c7d:b2c4:4c09:489a]) by SJ2PR19MB7366.namprd19.prod.outlook.com
 ([fe80::c7d:b2c4:4c09:489a%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 23:30:03 +0000
From: Jeffrey Yu <jeyu@issi.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "Mutya, Havish" <havish.mutya@amd.com>, "Kumar, Love"
 <love.kumar@amd.com>, Ji-Ho Kim <jhkim@issi.com>, Anand Bagchi
 <abagchi@issi.com>, Ron Kalakuntla <rkalakun@issi.com>
Subject: [PATCH] spi: add support for ISSI IS25WP02GG flash
Thread-Topic: [PATCH] spi: add support for ISSI IS25WP02GG flash
Thread-Index: AQHcFuBqPASuF+Kk00qnh1sWnuI8YQ==
Date: Tue, 26 Aug 2025 23:30:03 +0000
Message-ID: <SJ2PR19MB73666B89F24BC9AFB44F18A3B639A@SJ2PR19MB7366.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=issi.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR19MB7366:EE_|DS7PR19MB5998:EE_
x-ms-office365-filtering-correlation-id: 2a16765b-a18b-4299-4fd1-08dde4f87be2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?x9QHOsi1qOSmHRFeXGG6bD6sJ/7WeR8u+qLAK+ZWyFd7tveH5uz9lB8shB?=
 =?iso-8859-1?Q?b77Hh3SXZYYD/vbf61Ul6tWep8JbrweBXmm7KYbVUn7xaE+Mb/kioYlYeR?=
 =?iso-8859-1?Q?paqhmZ8Be9TxLNpn7LG4W4ARlZoZD81BoT6gTX8rq/r991aiFtUwmkXSn/?=
 =?iso-8859-1?Q?APtYTyrIigBRi1xlGyffjqS5+2OCVVCBjg4/o4+HXXblS5vdXhwSny6fFN?=
 =?iso-8859-1?Q?0GV+bmszE62Gy/YWzGCFhOs9OPj7wOvStJbr7AvE2uobKXCHx0XIBt0cd4?=
 =?iso-8859-1?Q?KMQcijYGaBts56LL2SaijUK8rTD+Kr4ATnTkEn9cMgpLE1y8q+geFxGQL0?=
 =?iso-8859-1?Q?M7zxZi/BNyqqIkpx7lEYSM/qgo79Br4TadU18dg60rrv4QGhuiL2CRkIcu?=
 =?iso-8859-1?Q?JYtDPeC33UPM79JJjyEinRLD7PrOZT3zMNPbzKBdIqC0O9CH4LdjOotfvU?=
 =?iso-8859-1?Q?gY3Jhnu1VWlmtDXBaIanygE10pPXxIyHmbEdj1XWvf0LdFqEVTYLqIqBLK?=
 =?iso-8859-1?Q?olD5GXfGmDCIlp3LeZfIbu1EOekoi1gWFuly3ErmYr6KEetGTdBtnwD1Yb?=
 =?iso-8859-1?Q?LnDA2gK/am7LN5/RUPRlDoSmdx+oQhYV9et1YU3DboS90jJ/V61HRu48nL?=
 =?iso-8859-1?Q?ZS1UqvUP+PCUAeITR42GmSPcgsw9qBWKeY63/LnZrvbF7hJbYP2+YnCw0k?=
 =?iso-8859-1?Q?jq5mMf/UXACvlIhxws9KC+miBTpl0Q6OYjUecwX4lAKFXvc3kcV4YS3EYo?=
 =?iso-8859-1?Q?FJ8GyiYX+vs4f+fbTPAowifwO7WPlRgx7127+iIY3icmRK4hyxx8hm3G2Z?=
 =?iso-8859-1?Q?gTyUl0gavjZuyffqRAHL8EydAYuIuuZrnBWVHg59fzd42NENUzvTeBKUVc?=
 =?iso-8859-1?Q?EOdORlE5hJiqWTFMRwtQnmpvDy5AeSaDEQJhkhTF8/5YhEGwYmtYn4+Mj+?=
 =?iso-8859-1?Q?fRKNuurfShCnvnzN5DmPEe97cPT8hOLNngJ0IoXtXqXLlAk6BLKhHkleT0?=
 =?iso-8859-1?Q?UlIXqiwFkK5dDTXS5pbjKVbcRfue3nBxSVsmad0DBYe0bIGbCLd3Pol/vi?=
 =?iso-8859-1?Q?GpZTvHzqUVdgTaiMR4COhaSuaQXHIh6eBsEDguagwpkdvOdbAvpaNsvvY5?=
 =?iso-8859-1?Q?+ufNDplviLTqFh6lYNEGOgu3AQLXDijbDfu9SJoFIouDjy772gB3T/r20N?=
 =?iso-8859-1?Q?C+BEvdoh2toIcfhJZjbY8YKdTgOQK7J9bXQPRZTjyBBvhhJiFsc7QarpTf?=
 =?iso-8859-1?Q?z3Dw8Z6kPx1xj9vudMZMqsJVsA0J1btMwBWXPhyXuEDL4XebBoRC2wis0M?=
 =?iso-8859-1?Q?twF9wwzecX6Xn50Bo61ehqCn0XNuSuLqGq4CBXqGFqUzs7fKEPew/3WWC/?=
 =?iso-8859-1?Q?hag4jFeGrum4JGTK0CH/Ivt/2CBM/nd9VZEsPt2gfze4toHiwHAH+s2RE6?=
 =?iso-8859-1?Q?qC4WCYp7wycxi+YPae/I8byUtDW8LwSY3yUNyLeJmRv89WJ9W3diY1fsFa?=
 =?iso-8859-1?Q?0gldogDNIjFO5UBSWYDXrydqx8wPNHstEAJs8/C5VKU0rqox08ReZW83qV?=
 =?iso-8859-1?Q?4hR8xpI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR19MB7366.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?58L3PtbOdggHoVoC0YrPDHiT9+6jpD2TJUW4+Ue04W1iTVIualeURA+eFX?=
 =?iso-8859-1?Q?pqr6kQG/niEMhqZYSKq6nBZXbhmGwb8xJDLSCgmAXt/oiTuTZz7Yia7OJK?=
 =?iso-8859-1?Q?cpwWEcxIzBgiAqmLx133Cm0KAWoFHYYudjo21iB5bTJ/YahVIUZAUnIXmw?=
 =?iso-8859-1?Q?VFd3ZW5lr6lMZ3YuA6788WeWpkR/NamsPSVgbbVFhFtAnlSP9t0AtVQe7l?=
 =?iso-8859-1?Q?PLcXRz35bqmVvLkJx6pO/YQYstGL0Ysw1nf/4dPtYo584r/d0yIG7tQkyP?=
 =?iso-8859-1?Q?SK12TwrDUwVd9e9H7Ev7Z9yDqpvY5Na10snxXBmSX+y2AZ3NY8Dy/X8OfH?=
 =?iso-8859-1?Q?BxpAGoF23TZ6Xf3wfemF4YecjhmaBoONE894ZeNr1Fw3flS8AMnbnPrG9a?=
 =?iso-8859-1?Q?5vxvBpG0VpdoSHIoCXg+GNDAzpYdBCiCQ2QA/Hcuxet6anZV5k8NNIBctA?=
 =?iso-8859-1?Q?a/6sOcPKNvfcKVeoxrsgWYmzQuYiMvUlPG7FnzgUYP+IwWVFF6rN5Qh7Fl?=
 =?iso-8859-1?Q?kAS6SABqQVdnu5i3TuywFcDAzSTcTWtxMx9FcX5UaT3qdgHVIO0eMVK7Md?=
 =?iso-8859-1?Q?1R8WjAzXayMEndKFd+cg9QFLkf56dSRSObnlBG21H2d6JGWp/do1t9tLx8?=
 =?iso-8859-1?Q?+71sUgY/FG5bO1cqCHYPaU1NgI5nk4riN0FMVv0A7RnjGjW+XdzuyHG4TI?=
 =?iso-8859-1?Q?54KxYzvw+M8tikcyMwfCaGg/4LmglQwT1lWHQ+4lauCVOtdWlPqdz4WI2b?=
 =?iso-8859-1?Q?dBbUxkZWLvDQYfSJFOIA4nliTA87WhjAyG1V8b49Ev1BxRxA9jCGKU0r3e?=
 =?iso-8859-1?Q?Tv8t8K7RP+NHvS6C74s92G6kMo5oX/ZU+gKgXKlXWTLTuYwUZhzyVYIFyZ?=
 =?iso-8859-1?Q?Xul2kJkcqLETfdw2B7mFOZ9xaHvyn6qPYPyTWv1TsjRkjruQ31EcBXdrO1?=
 =?iso-8859-1?Q?Kd+lt0+1xSM8agZSwYXRTuu4UNRHnmepExJ/cVrGs5IegpxXGRUzHMgUnm?=
 =?iso-8859-1?Q?KSzYivnO2Iigjql7bnrgtyr7DiuXtY8afe/bHOR3NHhYD39G7ZGULKaraa?=
 =?iso-8859-1?Q?g9sacc6slS3ueF9YoMezXgagyT4+nfg0OH8JSjOYSELW2ontiHO+KShywU?=
 =?iso-8859-1?Q?OFXZIQJHSGtfZZ0O2vUNlcUSWU7wRSITCSCkNEh88ZAvKBFbbAKqnjTXJ0?=
 =?iso-8859-1?Q?UYr/LbKYQWLXKK7onOA51w6+r6R1VTVDs1U9MRi9KojQmIv+WhwWFyBI84?=
 =?iso-8859-1?Q?XfLSjJrfQ9th4eLW5gqIpCxxuBLQQu/Dkz2K00/y7JBJVDTvf/f1ijiwdG?=
 =?iso-8859-1?Q?jK3IP66q9BTxvTPBizDoX2huOc1eps6/Y5QF9Qr6JIMZ7p4uZdjq2mOUcq?=
 =?iso-8859-1?Q?B9XYrka9dWD2npdy/2KuXj6gGSjh99vlr1z4BN2mBHp1010rWxI+VqkZ4r?=
 =?iso-8859-1?Q?piqeoo5/IpcpTeS6Lw80lzOCjwEDWOyZFIZuiU9kCoPBR3qcMOLqJ2Zgh8?=
 =?iso-8859-1?Q?1egWFefcFQOjjmRlZA0L5udxm7TtTZleaSzIAIoWkSbfn8zFSKV21udPBE?=
 =?iso-8859-1?Q?HLz54A8mQQ9qkCyng6jrOdI4WK7jXi7vkUpimCo8Irlffmbdupbf8zj4nQ?=
 =?iso-8859-1?Q?paYxwFvlEdbbQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: issi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR19MB7366.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a16765b-a18b-4299-4fd1-08dde4f87be2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 23:30:03.7609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6af618fc-4f7d-45f1-a2f2-8c59a26d2c10
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2twPuKWkYabPp1/7+1Ed68+w9+lZVTec8qv/4xQ/b6lqjuuL0css5ujXFNdDXNCt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5998
X-Mailman-Approved-At: Wed, 27 Aug 2025 16:25:23 +0200
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

This patch adds support for the ISSI IS25WP02GG QSPI NOR flash device. =0A=
Tested on the Versal VMK180=0A=
board in dual-parallel QSPI configuration.=0A=
=0A=
Signed-off-by: jeffrey yu <jeyu@issi.com>=0A=
---=0A=
 drivers/mtd/spi/spi-nor-ids.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c=
=0A=
index b4221a82e01..2fbed72b138 100644=0A=
--- a/drivers/mtd/spi/spi-nor-ids.c=0A=
+++ b/drivers/mtd/spi/spi-nor-ids.c=0A=
@@ -249,6 +249,8 @@ const struct flash_info spi_nor_ids[] =3D {=0A=
 			SPI_NOR_OCTAL_DTR_READ | SPI_NOR_OCTAL_DTR_PP) },=0A=
 	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,=0A=
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
+	{ INFO("is25wp02gg",  0x9d7022, 0, 64 * 1024, 4096,=0A=
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },=0A=
 #endif=0A=
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */=0A=
 	/* Macronix */=0A=
-- =0A=
2.43.0=0A=
=0A=
=0A=
----------=0A=
=0A=
