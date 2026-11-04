Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D4606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NMD5aabI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=PaGzdC59
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4028B404E8;
	Wed,  4 Nov 2026 13:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OIJolokobs2D; Wed,  4 Nov 2026 13:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 291014047E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793799073;
	b=neZCkyNch8zJG+rkdM43ht6tljtAeUjlVsNcRjQGN8fBL4ttDySrU+nzuFt14MehoEVN
	 ad483BVFnq9RVJnEAiTwAziXUCrA1nwYfkNEzRqoTlgX450w+EoynaKuilnE6ayF5ptvk
	 b3sDGyDzRqKzwWsCnZZTAcJW05o4t6z+6e49xw8uIiyKzDazlTPzBbckMdTlP56xfmZx7
	 6pa31jM/ucwvnMY8LHeEWIMItILqYWhlFYN0bKDeojYSHIeSsYiMFik6sGV4mMyU8u8K9
	 fAVG35Br54isYmKud3FYxHKNOMXLM29OG2Jh6tC4cuhpniwe3OEX/9X5iDTSasjU8hw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793799073;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=puWW6a0GJcai56UuFhnIq+Zu4PkGr80fAhqgNjc9++c=;
	b=K6NOwn+2vgPPqSRZV6g4lxxOy1vTcA0K+KW3FWueE/q8SI4jWBc+YenwB/+Quq6koYEH
	 eQSKzdGzzjA9QAhKVtbMmWSgaTpzjI+ynVxjXOp+1yuJyxs3uTc2uSLsk/W/Ev9z2jvwG
	 eCkPWRfxFtKGt73wzqrrycgvh/laj7fTOT8QYpNAPgAOQhZgXr6NzoGQy7HpOZTcBqEtK
	 yHBjObG6GEETKAVGVZJp9BzoMt8tkVlwdhmVknVu393ncxju3x6GtwyGv0cl+xkLmNGM0
	 5EyBAhzQdlNBoExHdR6IQpas/+Kbf4y/oK63iJjG4Sp5EQ3lySE4Glb95/7VCeFfH4A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=PaGzdC59;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793799073;
	bh=puWW6a0GJcai56UuFhnIq+Zu4PkGr80fAhqgNjc9++c=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NMD5aabI4+b6jzqmTa2MPVI4clXRQWvIBNVb/RQMOU0+h2hEpCG0eZvDeu+9wV1E1
	 kR8LZI/jfzaxfaHeL1AsVgeu0wJvV8xsZa/hYu7Ay1l0Xi3E6MIuStyMzXgTwF46Cm
	 aGddwXapRCQ73N82tsDC/OQUu2eIXnfo4aZF9LOcj5rmNyMTljM3A+tpRI9vMweWHG
	 f4bDZAtz/FrGG0Ye/F/JrkBwFwBuMZaITaqfeJGUBvtn3QQMHksRAPMsrRfWdOSqgc
	 SgstyIjnIntoY40a/skDiW65TojqSf1TV0QzoBDxAAKwSKD9TvpsSsR18U35MkhjSf
	 t+4OFH/FyJVJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 291014047E;
	Wed,  4 Nov 2026 13:31:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 447FF2AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2655940575
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:40:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrIYEjE585wq for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 05:40:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B70D640500
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793770809;
 b=nlicvzvrq2l1HHCFAzTCIfdQhKGGnN/RhzNRrk3d5amB3+AzdEJJj0IuH4k2+qulVnjO
 O/KKUP1Sfbq2Gz/stxc7/KtYWzUVjdI0WAY9XwqANaNj9sFpDgwO1t2eRQbscZC06RCxM
 BOuA7H3Vy+rCtf5UxoxSZ3mg6SANeMzGEHxnE/Wial1ilsB84Kwa1nvaeiY8qc/fMwPCz
 OKr1RdyIZP5yk9QdKtOxhBTTdmJnHkGyiKvIJoHqRutV2hMIzF37WDFPAyklbcAXV68BZ
 xPN5ZGn9nJ1rw34ZgdS0BwAS3EL5rRYnPrSTRF8rPVr1+3Eap/Y9Rl/NsiTAkZ76VkQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793770809;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=puWW6a0GJcai56UuFhnIq+Zu4PkGr80fAhqgNjc9++c=;
 b=du/CEWrRuIMnQvAli+W6HTcFPYH8PjaE5fg0Gq9JTKVBZiB6AWc70025jKw0O6+HL9qq
 jpUTUhTRD5ru+SO2NJ8Ynsp8iZ99fAljxqZxdvJeCXf+QKb9IG0MYd42w6ASsmuPQNxDr
 ur9SUgjDiwww/NgkHi4xGdgv+dD+R3bNuRuyQaeRkFfNHCbcELbLwb8GnYEhF39aSqKCU
 n99rFhSs8L8Z6JcJBrOVaEKBqAlcznRT5+puaLgdsy7gx4J+RJa4vE//zN62iQstDiJhm
 nHKPX1ZUTCL3hKJRSVs86d4Qyijlj3KRQOaF2eswrhVN9Uub548Hnl6SJE/lPLgnl9g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=PaGzdC59; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=PaGzdC59
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B70D640500
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1793770809; x=1825306809;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=puWW6a0GJcai56UuFhnIq+Zu4PkGr80fAhqgNjc9++c=;
 b=PaGzdC593ml6sLNyZfQGxos8dKl7mwnz4J25eorHHXyV1sYnZFto7Dha
 ige+tQzu9uVKIYx7hjocEy2KK+lmqtm9ozVfIGi9kGyFlbcKI5jV8mwej
 cHmkQFeRBgTWaYD07jqaiFWoL6p/BtPEPdEaHYnhk7dRldU/DhVKdIvve 0=;
X-CSE-ConnectionGUID: DQgcrJ2EQ1yJtx+/c63HoQ==
X-CSE-MsgGUID: Bfe6azKJQ0Gb/iaf2xEUSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="187901783"
X-IronPort-AV: E=Sophos;i="6.27,194,1787004000"; d="scan'208";a="187901783"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 06:40:04 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 06:40:03 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE815.infineon.com
 (172.23.29.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 06:40:03 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Wed, 4 Nov 2026 06:40:03 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <marek.vasut@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: <kenichi.nagai.ry@renesas.com>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <vjardin@free.fr>, <yuya.hamamachi.sx@renesas.com>
Subject: RE: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Thread-Topic: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Thread-Index: AQHdZVCX6cZLGgwujECbVyfAKfZWurcah+rwgACFVgCAAl1wEA==
Date: Wed, 4 Nov 2026 05:40:03 +0000
Message-ID: <2d7719916f1a40288f80e0bfb63492ad@infineon.com>
References: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
 <896390bd13f4439297a31492e1a3dda5@infineon.com>
 <b7fa5fba-17de-4e3c-bf9c-ff2c80e67a86@mailbox.org>
In-Reply-To: <b7fa5fba-17de-4e3c-bf9c-ff2c80e67a86@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 04 Nov 2026 13:31:11 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQo+IE9uIDExLzIvMjYgMTA6MTIgQU0sIFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20gd3Jv
dGU6DQo+IA0KPiBIZWxsbyBLdXdhbm8tc2FuLA0KPiANCkhpIE1hcmVrLA0KDQo+ID4+IEZyb206
IEtlbmljaGkgTmFnYWkgPGtlbmljaGkubmFnYWkucnlAcmVuZXNhcy5jb20+DQo+ID4+DQo+ID4+
IEFkZCBJRHMgZm9yIFdpbmJvbmQgVzc3VDUxTlcsIDUxMk0tYml0IFNlY3VyZSBTZXJpYWwgRmxh
c2ggTWVtb3J5DQo+ID4+IHdpdGggUG9zdC1RdWFudHVtIENyeXB0b2dyYXBoeSwgU1BJLCBRdWFk
LCBPY3RhbCBhbmQgRFRSIC4gRm9yDQo+ID4+IGRldGFpbHMgcGxlYXNlIHNlZSB2ZW5kb3IgcGFn
ZToNCj4gPj4NCj4gPj4gaHR0cHM6Ly93d3cud2luYm9uZC5jb20vaHEvcHJvZHVjdC9jb2RlLXN0
b3JhZ2UtZmxhc2gvdHJ1c3RtZS1zZWN1cmUvdzc3dC1udy8NCj4gPj4NCj4gPiBQbGVhc2UgdXNl
IExpbms6IHRhZy4NCj4gDQo+IERvZXMgTGluayB0YWcgYXBwbHkgdG8gYXJiaXRyYXJ5IGxpbmtz
IGluIHRoZSBjb21taXQgbWVzc2FnZSA/DQo+IA0KPiBJIGJlbGlldmUgTGluayB0YWcgb25seSBh
cHBsaWVzIHRvIGxvcmUgbGlua3MsIGhlbmNlIEkgZGlkIG5vdCB1c2UgaXQuDQo+IA0KSSBoYXZl
IGJlZW4gdXNpbmcgTGluazogdGFnIHdpdGggZGF0YXNoZWV0IGxpbmsgc2luY2UgWzNdLg0KSSBw
cmVmZXIgdG8gdXNlIHRoZSB0YWcgd2l0aCBkYXRhc2hlZXQgbGluayBpZiBpdCBpcyBwdWJsaWNs
eSBhdmFpbGFibGUgaW4NCnZlbmRvcidzIHNpdGUsIGJ1dCBJIHdvbid0IHB1c2ggZm9yIGl0LiAN
Cg0KPiA+IFVuZm9ydHVuYXRlbHksIGRhdGFzaGVldCBpc24ndCBwdWJsaWNseSBhdmFpbGFibGUu
Li4NCj4gDQo+IFllcywgSSBrbm93Lg0KPiANCj4gPiBJcyBpdCBwb3NzaWJsZSB0byBhZGQgYm9h
cmQgaW5mb3JtYXRpb24geW91IHRlc3RlZD8NCj4gDQo+IFJldHJvbml4IFNwYXJyb3cgSGF3ayAs
IFJlbmVzYXMgUi1DYXIgVjRIIFNvQyAuDQo+IA0KSGF2aW5nIGEgd29ya2luZyBib2FyZCBhdmFp
bGFibGUgaXMgdmVyeSBoZWxwZnVsLiBUaGFuayB5b3UuDQoNCj4gPj4gU2lnbmVkLW9mZi1ieTog
S2VuaWNoaSBOYWdhaSA8a2VuaWNoaS5uYWdhaS5yeUByZW5lc2FzLmNvbT4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+DQo+
ID4+IC0tLQ0KPiA+PiBDYzogS2VuaWNoaSBOYWdhaSA8a2VuaWNoaS5uYWdhaS5yeUByZW5lc2Fz
LmNvbT4NCj4gPj4gQ2M6IFRha2FoaXJvIEt1d2FubyA8dGFrYWhpcm8ua3V3YW5vQGluZmluZW9u
LmNvbT4NCj4gPj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+ID4+IENjOiBW
aWduZXNoIFIgPHZpZ25lc2hyQHRpLmNvbT4NCj4gPj4gQ2M6IFZpbmNlbnQgSmFyZGluIDx2amFy
ZGluQGZyZWUuZnI+DQo+ID4+IENjOiBZdXlhIEhhbWFtYWNoaSA8eXV5YS5oYW1hbWFjaGkuc3hA
cmVuZXNhcy5jb20+DQo+ID4+IENjOiB1LWJvb3RAbGlzdHMudS1ib290LXByb2plY3Qub3JnDQo+
ID4+IC0tLQ0KPiA+PiAgIGRyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jIHwgMSArDQo+ID4+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYyBiL2RyaXZlcnMvbXRkL3NwaS9zcGktbm9y
LWlkcy5jDQo+ID4+IGluZGV4IDY3NDg2ZDdhOTQ1Li5mY2UyMjMwMGI2MSAxMDA2NDQNCj4gPj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMNCj4gPj4gKysrIGIvZHJpdmVycy9t
dGQvc3BpL3NwaS1ub3ItaWRzLmMNCj4gPj4gQEAgLTY3MCw2ICs2NzAsNyBAQCBjb25zdCBzdHJ1
Y3QgZmxhc2hfaW5mbyBzcGlfbm9yX2lkc1tdID0gew0KPiA+PiAgICAgICAgICB7IElORk8oIncy
NXEwMW53LWltIiwgMHhlZjgwMjEsIDAsIDY0ICogMTAyNCwgMjA0OCwgU0VDVF80SyB8IFNQSV9O
T1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+ID4+ICAgICAgICAgIHsgSU5G
TygidzI1cTAybnctaW0iLCAweGVmODAyMiwgMCwgNjQgKiAxMDI0LCA0MDk2LCBTRUNUXzRLIHwg
U1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkgfSwNCj4gPj4gICAgICAgICAg
eyBJTkZPKCJ3NzdxNTFudyIsIDB4ZWY4YTFhLCAwLCA2NCAqIDEwMjQsIDEwMjQsIFNFQ1RfNEsg
fCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwNCj4gU1BJX05PUl80Ql9P
UENPREVTKSB9LA0KPiA+PiArICAgICAgIHsgSU5GTygidzc3dDUxbnciLCAweGVmOGUxYSwgMCwg
NjQgKiAxMDI0LCAxMDI0LCBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FV
QURfUkVBRCB8DQo+IFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gPg0KPiA+IEl0IHdvdWxkIGJl
IGhlbHBmdWwgdG8gc2VlIGhvdyBpdCBkaWZmZXJzIGZyb20gdGhlIGV4aXN0aW5nIHc3N3E1MW53
Lg0KPiAgRnJvbSB3aGF0IEkgY2FuIGZpbmQgaW4gWzFdIGFuZCBbMl0sIFc3N1QgaXMgZmFzdGVy
IGFuZCB3aWRlciB0aGFuIFc3N1E6DQo+IC0gVzc3VCBpcyB1cCB0byBPY3RhbC1JTy8yMDBNSHoN
Cj4gLSBXNzdRIGlzIHVwIHRvIFF1YWQtSU8gLzE2Nk1Ieg0KDQpKdXN0IG91dCBvZiBjdXJpb3Np
dHksIGRvIHlvdSBwbGFuIHRvIGFkZCBPY3RhbC1JTyBzdXBwb3J0IGluIHRoZSBmdXR1cmU/DQoN
Cj4gVGhlIHNlY3VyaXR5IGV4dHJhcyBhcmUgdW5zdXBwb3J0ZWQgYnkgZWl0aGVyIFUtQm9vdCBv
ciBMaW51eCwgYW5kIEkgZG8NCj4gbm90IGtub3cgdGhlIGRldGFpbHMgb2YgdGhlIHNlY3VyaXR5
IGV4dHJhcyBvZiB0aGUgVzc3VCBwYXJ0LCBzbyBJIGNhbg0KPiBub3QgY29tbWVudCBvbiB0aGF0
Lg0KPiANCj4gQW5kIG9mIGNvdXJzZSwgdGhlIElEIGRpZmZlcnMgdG9vLg0KPiANCj4gRG8geW91
IGhhdmUgYW55IHBhcnRpY3VsYXIgZGV0YWlsIGluIG1pbmQgdGhhdCB5b3Ugd291bGQgbGlrZSBt
ZSB0byBmaW5kDQo+IG91dCA/DQo+IA0KTm90aGluZyBwYXJ0aWN1bGFybHkuIEkgdW5kZXJzdG9v
ZCB0aGUgaW50ZXJmYWNlIGltcHJvdmVtZW50IGluIFc3N1QuIA0KDQo+IFRoYW5rIHlvdSBmb3Ig
eW91ciBoZWxwICENCj4gDQpUaGFuayB5b3UhDQoNClJldmlld2VkLWJ5OiBUYWthaGlybyBLdXdh
bm8gPHRha2FoaXJvLmt1d2Fub0BpbmZpbmVvbi5jb20+DQoNCj4gWzFdDQo+IGh0dHBzOi8vd3d3
LndpbmJvbmQuY29tL2hxL3Byb2R1Y3QvY29kZS1zdG9yYWdlLWZsYXNoL3RydXN0bWUtc2VjdXJl
L3c3N3QtbncvDQo+IFsyXQ0KPiBodHRwczovL3d3dy53aW5ib25kLmNvbS9ocS9wcm9kdWN0L2Nv
ZGUtc3RvcmFnZS1mbGFzaC90cnVzdG1lLXNlY3VyZS93NzdxLW53Lw0KPiANCj4gLS0NCj4gQmVz
dCByZWdhcmRzLA0KPiBNYXJlayBWYXN1dA0KDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbXRkLzQ2ZWUzZTJiYWMxMDE4NDlhZjZmMzlhOTk5YmI0N2QyQHdhbGxlLmNjLw0KDQo=
