Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B451AC61DC2
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 723A9406CF;
	Wed, 26 Aug 2026 13:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPF4ki4k2N-k; Wed, 26 Aug 2026 13:02:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787749325;
	bh=hzv2zB4axJjrKZicmGdMlOKGJDQHfbmJt9BweXlbjww=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FgIOAZfSHtHkNDDcwpJK0HxM9vQ1E/GAgC8izC/87xb3H+H9jhkn7xE83E6IQkdue
	 XSO+DtustsCIrOG5u/fqhbMNQA7/+bc9BxXbu2LJchDI00dgRgHTjkoPMUYzoUmWIU
	 Bym2xszU7urHpSy0CCTfpiwv+CXV7ZenVfdMfKp0BKtp1tM4ZmDZeNpUapzjWiSxKa
	 hSJjIbTsVa7SpAo3rQqRSomjQqjciuZ1YuAJDEfgtXo6q7ELbFz63uXIxsPafvK+za
	 +38+yXJFUtHA4X6fL+mqAoZGlxWBIVlFPlD1mEntQyCOxHTz7HnvN4rj79ucBxnazY
	 jYbPfA9zNprKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC34C406CB;
	Wed, 26 Aug 2026 13:02:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 97C103AD
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89F7940695
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihNgXFJWiU99 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 12:48:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c003::5;
 helo=cp3p284cu006.outbound.protection.outlook.com;
 envelope-from=lucas.alves@lumal21.com.br; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=lumal21.com.br
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=lumal21.com.br header.i=@lumal21.com.br
 header.a=rsa-sha256 header.s=selector1 header.b=k9bDam10
Received: from CP3P284CU006.outbound.protection.outlook.com
 (mail-brazilsouthazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c003::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C58A40693
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 12:48:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBUylAjVH0VjD2Unuptge+XrGcPf7ne5kTKr47I6zHPhJqkKETq9HAdnSP4nhxqx/hdNUv4SBwGl4O1cKFGFIN5eZQgaF/APsFL/rgsiXr3fOZ89X8bw28WLPPNa7r1y4lSSM1XwlfKx8jnFOLO1OyoyA6/JwK0R/NyJ9EN8qLIhSzxBsvfWFkmlr/OitUrwQcVmQTvxGgxDQfCt2gh3L+gVuFg8Gf4x17OVmqtmRF0d/1SmlcUcShRCV5+Ohiv6OH3ncDEPC/PHQFFysYFtBmQvhQeYiQx+oh6lMnHWzy6mbnbUZD40LYlPS/5wMavyQ086k8ZrfWLInyFDpgMg9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzv2zB4axJjrKZicmGdMlOKGJDQHfbmJt9BweXlbjww=;
 b=G+aMBE/rehSwdhvJNQczgeoOPSBT+3jFAL4116v5tetMM8ID+ZltOyltttMSAqJ2tNirmSIj1En78YDzDHojnV+omNnUAjV436MExnTBqtGFDc4rZf4mLzyzeuHyk/GT35raqIVw9i7lA9rdiMbbGJ30HDRvyT/CSsJnb7Xuqr5ycHhY3H6hWeAnnq2dud6cREsD4Xc1SxPLXjHN0ACqTwGujd/wFCXzZeF7LOu3n6Wnvuc61UF1PegNtQoGoP1x+nnBUCMSIFCx8TUUtGs/iY17Rw9MY2gLA9YkHklEcD3VEgJsFBjDXVFtsX+GRICruM1nTN/gskJG7Qztzl7UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lumal21.com.br; dmarc=pass action=none
 header.from=lumal21.com.br; dkim=pass header.d=lumal21.com.br; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lumal21.com.br;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzv2zB4axJjrKZicmGdMlOKGJDQHfbmJt9BweXlbjww=;
 b=k9bDam10+4SnPSjbzSHGVaoKay3m3T5orIhjbCEgNN/Yd0Ry30YFw/E0FDkXPBUjktBRqBk9LsapRNsEBJAgFq7xp6HAkzF6T24qQKyGmTqQmu3sbjaM6jlSMIhicQ1LZrSfh61pSMtmOJQTwGo+tjWBOrQCq6KVxsMjhVMk17m2f/NvFAu+ZKHblDVHVERGdrQ/UB1BWiAe1Jc+pXhWQ6Nv72NWa9fXSDMeybsk9fYywG0KkZD8G4f2E+IQxPDTjeq4pt12fynnDFZ1/pgB2qSAiDyfWmwmcBHx7TyyYSzT0uimauYoiGBSwFbZYvdfrbTWFISjnXKFz+mZ6Koc1A==
Received: from CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:2aa::9)
 by CP5P284MB1919.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 12:48:02 +0000
Received: from CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM
 ([fe80::7b77:a104:ca62:b600]) by CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM
 ([fe80::7b77:a104:ca62:b600%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 12:48:01 +0000
From: Lucas Martins Alves <lucas.alves@lumal21.com.br>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "trini@konsulko.com" <trini@konsulko.com>, Lucas Martins Alves
 <lucas.alves@lumal21.com.br>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>, Tom Rini <trini@konsulko.com>
CC: Lucas Martins Alves <lucas.alves@lumal21.com.br>
Subject: [PATCH] fs: jffs2: set part->jffs2_priv to NULL after freeing cache
Thread-Topic: [PATCH] fs: jffs2: set part->jffs2_priv to NULL after freeing
 cache
Thread-Index: AQHdNVkh8GTmrDFojkuWs3sFM6PVaA==
Date: Wed, 26 Aug 2026 12:48:01 +0000
Message-ID: <20260826124754.25813-1-lucas.alves@lumal21.com.br>
Accept-Language: pt-BR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.53.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lumal21.com.br;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CP4P284MB2402:EE_|CP5P284MB1919:EE_
x-ms-office365-filtering-correlation-id: 77b8189a-f5ee-47b1-dbf3-08df037043ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|6133799003|10067099003|56012099006|11063799006|18002099003|3023799007;
x-microsoft-antispam-message-info: is+lBYnCvHD3oXdKw/GCJTsl7bVwkAiA1lQuaVQw/2mqzLnLtIV4fhY3otxhL0s26DBqiBGAW9iCqMOTqXqfHV9b5a/9gktO6sh1JVSo2nKCmhtd3bpT9ZDUzS+vxpvvVyCdb204e6T1C2xtXu5WmBezoC6g81yQsk6UM+OjQawyceS4dASJlzTwf3Lel7tPrGUqpxSjCVP+FR18Ixa8Oz+tmLqSWxXAj8sjyloByZgIv6fPtHm8N+5L6lh/g7zb/mYDTzPOCuUa4uQoLwrsTzZ+AFvh/NaiNkZNsIER5iAGQjmtT0JwioWVvEipLemt3W1DFI6b0t4PgIh04rdupmpj+09rTw/pOhypMdRodR4GzvyfN/YWgd9FHzAO071BeDYQM1Goxb/I7lklLZ3efi/kS/tFiDdqH7B2FS5pGlaPWJkd5BvVyDOGXxVHT6Cm3IfvezrlDvBzDzdWRDexNUp5kmgx7xGTuwJ8PO5cxVL4OszMZk7a5edG8iWSFjpGR0dMVMWpAHBzDW/UzRJA1Vi9buVkhwMgK/hwt2EFcLcO/u56hFHRD8ObrAG5UvEmlepl7kjRefAlB+O9Y+x6M8hWPlzvK8wqu9uiKo3y4HsbQvpwmIm9EuojI/oyRuRoBbtRVtOesA0TkRSSiRPoHRZTH38Xe3DjbmEDGuYgoYegFeriUx7kUGbZiy8CV2YFXLlZcc3F1EKG+6lJ8EJzPFlyQNq3ZDQqU9f5MH2YYjI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QviuxjHKoR32AWof8ClK/z3XLAUP+7epU3TNsDkmhGWnPG3gnr8Z/6Dg9n?=
 =?iso-8859-1?Q?NAT6yHmOJR+Ta9U72K/4E6+PGanEtZsugGfh0EtR7IkjcEJ4UHmVLpZG8Q?=
 =?iso-8859-1?Q?2eBPL/aBBEZKa6WhJTPZAyVGN1byuNeChRFkn+0SYdlIs82sae8lBizEur?=
 =?iso-8859-1?Q?nMt2YhVUD1GL57Yx8ReJi1ajnsHmST+aBWNKAxfkwbtc6HDCyCzlcA4E9r?=
 =?iso-8859-1?Q?9bt7i3ZRZh3NSxfKtW5eQmhhlica4ndn4MrZsHOKBMno+CfXK4DFILwjlV?=
 =?iso-8859-1?Q?09fXbMXZCWxz7dsBCLzw1VaEh9UOFrIzbFz8F/4VIuTih9fBYP/AdanAMQ?=
 =?iso-8859-1?Q?Mgjk3WaDeOZuVh5Asnmqn4HDUnKIlMFTn0ZlzCYXtogzv3NcakLNV1SyxS?=
 =?iso-8859-1?Q?jgW60ULALrhfGrlZB9yK5iAYnUU0v1aBncEFksfq8XRrT8x/8SfKSwwBFH?=
 =?iso-8859-1?Q?OwXoIexxmQV9bYKqM7WKC69IRCTBsZsW2qenrnrOLQ1Dar0FGldSzn9GCC?=
 =?iso-8859-1?Q?RjlISxu/1UsskRY4XvZh7XndYdjq85wa2C+x7/hZEBZ4DnrgzcI8Gp6+SZ?=
 =?iso-8859-1?Q?Q1xa4zR+JiuYRIvPx5dDbCRw8cxa4BcsU1SeZqGfrhKr209u+T9+tbFlzu?=
 =?iso-8859-1?Q?x+EBPZP8sYlePcTQruTZix3hLAnXkDIaHlvghG3Z9HnxMY7P2h1PQVDCyH?=
 =?iso-8859-1?Q?+QNaxlyMDk2YDo9ALol5qM3QYBnQzRbcM9I8C2swaeE6lQK2h9ytV+NQNt?=
 =?iso-8859-1?Q?h8h4QT6eS4kJyPqwqbMrUhx98W56FxTOB09wbVbb92eDXhTyzhp08LI322?=
 =?iso-8859-1?Q?62XC7iedeuKz6JqeHGjjfwbl9d4DOyHh7cbYVfA7qcXMTfTodjXSRQ4p+B?=
 =?iso-8859-1?Q?rtoZgO3oMvErx4DPnOHKlN6UD2h74Hq4YUKP6GHrjtxJWhiHinYaQd11kb?=
 =?iso-8859-1?Q?1FY9SCkFp6TveSoAYEkJr85senMDe7O00Zqs+Gs2tRlGMvMykopHm6Ze4r?=
 =?iso-8859-1?Q?JAWcmsIiDutP9SfJkU0bb1yvjqJCe5p+Z+r6t5izIs94R9ZxkKVLXQ802X?=
 =?iso-8859-1?Q?tQPNC+QD5hrxSF/OSvnm95FXiL+UH03MdXuWXNTWBOOVb3CA1MEfTUASy6?=
 =?iso-8859-1?Q?okYXkWognSxO0fLV1SRULDMH6Emi17gH+hBpUzKU2A7OOCLSkGoVJxM8Lh?=
 =?iso-8859-1?Q?I4WutKJ8nKzl+iL+lwWzcCC0AvYaULL3Svvj4Oj29GO4Wc0EOOz2qDYfSp?=
 =?iso-8859-1?Q?g1m9yT11uUW8vBGkVADQyDJR0zBDE1bBQx1uvEd2BD+PQLVYyavAmWLylO?=
 =?iso-8859-1?Q?p7rZOXkPDJNz0K2sAzl7t1dB3Oavrfbeb4iy6wU+EyAu4VIPYDgbGzP1xC?=
 =?iso-8859-1?Q?snXabsrTMZ0JeVclDbFBN4BlaRHT3lZie9Tf+ZdiwKleD565Z10BOnR4vV?=
 =?iso-8859-1?Q?z25fMmGxZdWbt2X/vb4ZPKsq8lY1zNOfFkEFjgo/ypkd3m43qzviTzwnLf?=
 =?iso-8859-1?Q?OaHKtwLQtwXxf/FUstCuCtfXcLSvsuf+G+ZPhXTB7t4BVtgCHvQh4ONv8J?=
 =?iso-8859-1?Q?i6Vc/ScI4+X5waAjeHbtB65UnBGKUhFaCCIp+gl/UogdLadjDNzXWj++rr?=
 =?iso-8859-1?Q?wNiCMN21UePOvhMOGmB8wjffUJPOmDQjxhWB8SrIIS3eo7Gu/Afl4MCsmD?=
 =?iso-8859-1?Q?+vFi1UJwxd1HN8DPc1+CXbJ4hW+CL0jxZ6/Jfl3M5FiM0ECEaBFFkADG7V?=
 =?iso-8859-1?Q?Hvc1Rcy/yCQZFBVnYf83DFkeM/iPIHtp3gKnHIbo1ih0tefiHadfrD5OCz?=
 =?iso-8859-1?Q?Qn1lMAkRvQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lumal21.com.br
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CP4P284MB2402.BRAP284.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b8189a-f5ee-47b1-dbf3-08df037043ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 12:48:01.6256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99055dd4-6575-473d-944c-c3b1a5a6649e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3q/mvaUWLpFM6nBsCRjRp9ogZxB2m5uhIHoroW48lmOWtY3SDc6ysAJYeh0dQ36fCAXGxMObrMOOUy3ywhIRS6gIQlheSmJXaCNLEogLeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CP5P284MB1919
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:01:55 +0000
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

From: Lucas Martins Alves <lucas.alves@lumal21.com.br>=0A=
=0A=
When jffs2_free_cache() releases the memory allocated for pL (the JFFS2=0A=
private list structure), part->jffs2_priv was not cleared. This left=0A=
part->jffs2_priv as a dangling pointer to freed memory, which could lead=0A=
to use-after-free or double-free issues if jffs2_free_cache() or other=0A=
JFFS2 functions were subsequently called on the same partition.=0A=
=0A=
Set part->jffs2_priv to NULL after freeing pL to ensure clean state.=0A=
=0A=
Signed-off-by: Lucas Martins Alves <lucas.alves@lumal21.com.br>=0A=
---=0A=
 fs/jffs2/jffs2_1pass.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c=0A=
index 137a9585b0b..3c06817955b 100644=0A=
--- a/fs/jffs2/jffs2_1pass.c=0A=
+++ b/fs/jffs2/jffs2_1pass.c=0A=
@@ -647,6 +647,7 @@ jffs2_free_cache(struct part_info *part)=0A=
 		free_nodes(&pL->dir);=0A=
 		free(pL->readbuf);=0A=
 		free(pL);=0A=
+		part->jffs2_priv =3D NULL;=0A=
 	}=0A=
 }=0A=
 =0A=
-- =0A=
2.53.0=0A=
=0A=
