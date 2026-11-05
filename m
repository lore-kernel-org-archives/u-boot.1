Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761E5606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Er0NQbfg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=IBQtLW1T
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4227180CBA;
	Thu,  5 Nov 2026 13:47:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P1HqMTSQ3UUU; Thu,  5 Nov 2026 13:47:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 602E380D50
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793886475;
	b=kHq79oD8E5w9QycdmDEdFZhCvNrDfA8LWvIxYet4RUX6GkyJoWk/jRvFW90eSFD/HVrl
	 fAUiIUF6vFknqARu74DxxRI2LKDD3C1qYD3qW/aoD2bcdMlN2/PTVbbXbfrT9MvAqYOcL
	 cHpzupi0KSxKfb4JGZnS+UVgx/ZQYDN1ds5+Kta/opY6tuxF5OL6ZfvaxXx8ARDO62k2z
	 W0/csHhenlY8VHBw69CUa+iQ+4gpoeE3KMAnLXoDEssxzt47zjiiUhIZ+IMkmLPhbZC4w
	 jbJqXG9imaYl6HE7a1v8GjoluaEab5KdFCvMfmf67oKUM3b2B9VfJiCaTsy2FapnjIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793886475;
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
	bh=tKGJJ9PxeFSVED3UmDa1m3Lag7V7TczAUIsyVe4DcD0=;
	b=tVBIQLZ5SSsnaGEyJa9h7T9DEXejWUygGuP4ti6BxD63fxig3B9iBrWM7JoMFUW2lUDC
	 loUkzWQFbtYTaqMvcNxdCOTOpZl6gw0XkSFolDc2J40hbVktbqEOuM9i42Y0UyQcDZJ9C
	 zsE2IHk6GeLS9C166fvXakpL12M84vUob3kYOSbR2SwB2+1hOXzWqAAJukEX5XMhsJyoL
	 xzXBDDutjlQdBh7KEbnP8qM8XpejeNS1RyxA4gZpfOcq874xLhC8eNya+HBB3i2kKnC3f
	 JURVH0ojLwfKgcBe02CIy5TnZIkK6KiXVPzQrxMASicy83eXyvvjwfQkPGIFJFHIJEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793886475;
	bh=tKGJJ9PxeFSVED3UmDa1m3Lag7V7TczAUIsyVe4DcD0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Er0NQbfgsaHJNLrZZ9jv8jZX5G2gb8WgCJDZKwRFSJF0zIMVYbgh772BoEuG78og+
	 pkZ9XIDKl4lIzXg37Qvv4glbLUlaaUAGoXYXD5eI/OqddnjX3z2jvhrKZR+zs7hQz/
	 6OEKKKmZPLWuSSyjsOw+WIS+yKQ6bkakYW5S5DRe37ZFWhs17L2rAD3W5LLPp36Rip
	 qmLRdQgUU8+xBycc2qZoztJKTE4Fda1F+AusUJSLGkkNUfxGrkjw4x8FJNYHQp74Rw
	 RAjfuG6mC6sd2LBY/6wq0iXgLDdUjpSsCm20MQw2ksd81lrmd9rI1V9ChEGlVYnOpS
	 cOxvjN1AFaF8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 602E380D50;
	Thu,  5 Nov 2026 13:47:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4456437B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 29DAC401E2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:55:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x3cn18DIbd16 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 05:55:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C528E400FF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=IBQtLW1T
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C528E400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 05:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1793858156; x=1825394156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tKGJJ9PxeFSVED3UmDa1m3Lag7V7TczAUIsyVe4DcD0=;
 b=IBQtLW1TDAHxbeGwSFxALhDQiO/7G1hxJMva3hNHr8nkuClKD9HFVpK8
 LQSTcynu3mcl0gFV/5EpCSR/2EYYu57pHPaTYfrLnbDUlrBz7WccQFRmL
 PV++QOnv6CJgN471+tFBbZvaoa2Aj57TDEVBOTNMATwjMSF2q2aocpcly c=;
X-CSE-ConnectionGUID: 3l+KMcPbS+uGJO03vHjlQA==
X-CSE-MsgGUID: rhHcEthrRKKFDVQz342JTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="188130817"
X-IronPort-AV: E=Sophos;i="6.27,196,1787004000"; d="scan'208";a="188130817"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 06:55:35 +0100
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 06:55:35 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 06:55:34 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Thu, 5 Nov 2026 06:55:34 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <marek.vasut@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: <kenichi.nagai.ry@renesas.com>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <vjardin@free.fr>, <yuya.hamamachi.sx@renesas.com>
Subject: RE: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Thread-Topic: [PATCH] mtd: spi-nor-ids: Add support for Winbond W77T51NW
Thread-Index: AQHdZVCX6cZLGgwujECbVyfAKfZWurcah+rwgACFVgCAAl1wEIABSMSAgABHGVA=
Date: Thu, 5 Nov 2026 05:55:34 +0000
Message-ID: <fed118db71fb4578a13ca9eefa8fea9c@infineon.com>
References: <20261026134745.81217-1-marek.vasut+renesas@mailbox.org>
 <896390bd13f4439297a31492e1a3dda5@infineon.com>
 <b7fa5fba-17de-4e3c-bf9c-ff2c80e67a86@mailbox.org>
 <2d7719916f1a40288f80e0bfb63492ad@infineon.com>
 <636803e2-ea4f-47c9-9883-6cd070b1c772@mailbox.org>
In-Reply-To: <636803e2-ea4f-47c9-9883-6cd070b1c772@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:47:53 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBPbiAxMS80LzI2IDY6NDAgQU0sIFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20gd3JvdGU6
DQo+IA0KPiBIZWxsbyBLdXdhbm8tc2FuLA0KPiANCj4gPj4+PiBGcm9tOiBLZW5pY2hpIE5hZ2Fp
IDxrZW5pY2hpLm5hZ2FpLnJ5QHJlbmVzYXMuY29tPg0KPiA+Pj4+DQo+ID4+Pj4gQWRkIElEcyBm
b3IgV2luYm9uZCBXNzdUNTFOVywgNTEyTS1iaXQgU2VjdXJlIFNlcmlhbCBGbGFzaCBNZW1vcnkN
Cj4gPj4+PiB3aXRoIFBvc3QtUXVhbnR1bSBDcnlwdG9ncmFwaHksIFNQSSwgUXVhZCwgT2N0YWwg
YW5kIERUUiAuIEZvcg0KPiA+Pj4+IGRldGFpbHMgcGxlYXNlIHNlZSB2ZW5kb3IgcGFnZToNCj4g
Pj4+Pg0KPiA+Pj4+IGh0dHBzOi8vd3d3LndpbmJvbmQuY29tL2hxL3Byb2R1Y3QvY29kZS1zdG9y
YWdlLWZsYXNoL3RydXN0bWUtc2VjdXJlL3c3N3QtbncvDQo+ID4+Pj4NCj4gPj4+IFBsZWFzZSB1
c2UgTGluazogdGFnLg0KPiA+Pg0KPiA+PiBEb2VzIExpbmsgdGFnIGFwcGx5IHRvIGFyYml0cmFy
eSBsaW5rcyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgPw0KPiA+Pg0KPiA+PiBJIGJlbGlldmUgTGlu
ayB0YWcgb25seSBhcHBsaWVzIHRvIGxvcmUgbGlua3MsIGhlbmNlIEkgZGlkIG5vdCB1c2UgaXQu
DQo+ID4+DQo+ID4gSSBoYXZlIGJlZW4gdXNpbmcgTGluazogdGFnIHdpdGggZGF0YXNoZWV0IGxp
bmsgc2luY2UgWzNdLg0KPiA+IEkgcHJlZmVyIHRvIHVzZSB0aGUgdGFnIHdpdGggZGF0YXNoZWV0
IGxpbmsgaWYgaXQgaXMgcHVibGljbHkgYXZhaWxhYmxlIGluDQo+ID4gdmVuZG9yJ3Mgc2l0ZSwg
YnV0IEkgd29uJ3QgcHVzaCBmb3IgaXQuDQo+IA0KPiBUaGUgZGF0YXNoZWV0IGlzIG5vdCBhdmFp
bGFibGUsIGl0IGlzIG9ubHkgdGhpcyBwcm9kdWN0IHBhZ2UgdGhhdCBJDQo+IGNvdWxkIGZpbmQu
IFdvdWxkIHlvdSBzdGlsbCBwcmVmZXIgbWUgdG8gdXNlIHRoZSBMaW5rOiB0YWcgZm9yIHRoaXMg
cGFnZQ0KPiBhbmQgc2VuZCBhIFYyID8NCj4gDQpTbywgY291bGQgeW91IHBsZWFzZSBkcm9wIHRo
ZSBwcm9kdWN0IHBhZ2UgbGluayB0aGVuIHNlbmQgdjI/DQpEZXNjcmlwdGlvbiBsaWtlIHlvdXIg
cHJldmlvdXMgb25lIGZvciBXNzdRIHdvdWxkIGJlIGZpbmUuDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy91LWJvb3QvMjAyNTA3MjAxOTU5MDEuNDE0MDgzLTEtbWFyZWsudmFzdXQrcmVuZXNhc0Bt
YWlsYm94Lm9yZy8NCg0KVGhhbmtzLA0KVGFrYWhpcm8NCg0K
