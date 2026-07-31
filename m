Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD59C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 04:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 32A9880F38;
	Fri, 31 Jul 2026 04:48:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRMGVobyq5ir; Fri, 31 Jul 2026 04:48:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BD0C80EFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785473288;
	bh=G9ETY+o9/T0BoD3pqpbO3SnNfoDSc6j1d2PC5H0P+YM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7FlH5MuXUx2yD32fYRwr0sWS/ACRu3rsCG4wV7ItyeQxXuMbBLdOcWJJxM2Jifz6
	 zhi0GoszJtsAIYpUz5pO6vDqnLURhgJndesnVdDGviv+HJgfxZaS7GusfCAfHVWBYo
	 stBdYAXs1ZIFHJn317av0+0xavMKY5yTg2y4l1+wm5xh8+Nw8lZNEG3m2HkIUIKWYa
	 EXnRR/m65hxqzs/sH3iTr/1H+P07IofuBnRgvnqetMCH7xUIvTqFhLlUeJ8/WZJzO2
	 JfTOSbJ9xxn4VUObCp8MLUs9X1Lxl/IAkeupAma+U/HUXC0+i4XfjwbgxyZaFdX6TR
	 foKbcRF7+Px2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BD0C80EFA;
	Fri, 31 Jul 2026 04:48:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4C6D227C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E0F440067
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:49:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jc-s4yBUWmRn for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:49:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.10.52.204;
 helo=smtp9.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3086B40076
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3086B40076
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3086B40076
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:49:19 +0000 (UTC)
X-CSE-ConnectionGUID: 45rgpNqKRumvZlWa7wH3GA==
X-CSE-MsgGUID: yJoyr1GcTSyYZpIg9cuHXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="102943980"
X-IronPort-AV: E=Sophos;i="6.25,195,1779141600"; d="scan'208";a="102943980"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
 by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 05:47:59 +0200
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 31 Jul
 2026 05:47:58 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE817.infineon.com
 (172.23.29.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 31 Jul
 2026 05:47:58 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.045; Fri, 31 Jul 2026 05:47:58 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <festevam@gmail.com>
CC: <u-boot@0leil.net>, <trini@konsulko.com>, <sjg@chromium.org>,
 <kever.yang@rock-chips.com>, <u-boot@lists.u-boot-project.org>,
 <festevam@nabladev.com>, <vigneshr@ti.com>
Subject: RE: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Thread-Topic: [PATCH v4 1/4] mtd: spi-nor-ids: Add XMC XM25QH128C
Thread-Index: AQHdGhLZ/a563f03JkOofxvCynNiXraEOfFQgAJ5+gCAAFYJMA==
Date: Fri, 31 Jul 2026 03:47:58 +0000
Message-ID: <455ff3e0fd3446ed9a967db944b91ef6@infineon.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
 <a49f6530d95c4ea1908efe23d16f8843@infineon.com>
 <CAOMZO5AUHUEXvM+39N8oybY_W-+cRZAw0BDENGH1e6kB3PTbfw@mail.gmail.com>
In-Reply-To: <CAOMZO5AUHUEXvM+39N8oybY_W-+cRZAw0BDENGH1e6kB3PTbfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 31 Jul 2026 04:48:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1785469760; x=1817005760;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G9ETY+o9/T0BoD3pqpbO3SnNfoDSc6j1d2PC5H0P+YM=;
 b=c7quv2K1w9DuaxioAJ2g3fOCF2qZm+cQTVQYsv+vYQoyDLy9K9sI0plF
 KwOaKslPnVglkSfeYnYhZdMGF3zHzpEI+vkEcIvPJS+cLM/HiPWNqpOVy
 d4WljA7q+xpSVR80RDFlu+D6DTO+vtSKkb+0sH1oxRymlGplrHZwe9uX3
 Q=;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=c7quv2K1
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

PiBIaSBUYWthaGlyby1zYW4sDQo+IA0KPiBPbiBXZWQsIEp1bCAyOSwgMjAyNiBhdCA1OjU54oCv
QU0gPFRha2FoaXJvLkt1d2Fub0BpbmZpbmVvbi5jb20+IHdyb3RlOg0KPiANCj4gPiBQZXIgdGhl
IGRhdGFzaGVldCwgdGhpcyBjaGlwIHN1cHBvcnRzIER1YWwvUXVhZCBvcHMgYnV0IGZvciBteSBy
ZWZlcmVuY2UsDQo+ID4gY291bGQgeW91IGxldCBtZSBrbm93IGlmIHlvdSB0ZXN0ZWQgMS0xLTQg
b3IgMS00LTQgb3BzPw0KPiANCj4gSSBjaGVja2VkIHRoZSBSSzMzOTkgU1BJMSBwaW4gY29uZmln
dXJhdGlvbi4gSXQgb25seSBleHBvc2VzIENMSywgQ1MsDQo+IFRYL0lPMCwgYW5kIFJYL0lPMTsg
SU8yIGFuZCBJTzMgYXJlIG5vdCBtdXhlZCB0byB0aGUgU1BJIGNvbnRyb2xsZXIuDQo+IFRoZXJl
Zm9yZSwgbXkgdGVzdCBleGVyY2lzZWQgMS0xLTEgb3BlcmF0aW9ucyByYXRoZXIgdGhhbiBlaXRo
ZXIgMS0xLTQgb3IgMS00LTQuDQoNCk5vdGVkLCB0aGFuayB5b3UhDQoNCj4gDQo+ID4gQW55d2F5
LA0KPiA+IFJldmlld2VkLWJ5OiBUYWthaGlybyBLdXdhbm8gPHRha2FoaXJvLmt1d2Fub0BpbmZp
bmVvbi5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCg==
