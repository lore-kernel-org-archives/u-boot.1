Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5FC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 639DF87F8C;
	Tue, 12 Mar 2024 15:14:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="DPUjxm4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD1287DE3; Tue, 12 Mar 2024 15:14:51 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA67F87FB6
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710252885; x=1712844885;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OCxS/BWVAJ6BFqQMRfoWtzO+OGTKk7sZNW6gxtHnth8=;
 b=DPUjxm4Yt7i58+H0zfeiX21+vCG5NdPs3G0HXNr3uw2JFrvj/GZCHbn9IlzG6gPS
 pTTNJNtyiNvvcG6zZK3W0dzkYlXLBtRMOM2T1d2N1MWW18/AOkfmYAEirFu0RJCo
 fY4rpkv2ZkDgZfhcu/p46Sy8vpGrz9oF5L6J0gLEFJ4=;
X-AuditID: ac14000a-fadff7000000290d-f9-65f063550017
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F2.F9.10509.55360F56;
 Tue, 12 Mar 2024 15:14:45 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:14:45 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 12 Mar 2024 15:14:44 +0100
From: Teresa Remmet <T.Remmet@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, Leonard Anderweit
 <L.Anderweit@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Thread-Topic: [PATCH v2 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Thread-Index: AQHadFuu10btP5BVPke6LS/sqThxF7E0FcgA
Date: Tue, 12 Mar 2024 14:14:44 +0000
Message-ID: <46437aa36c4a0ea554847d1fcaeac9df565fca72.camel@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
 <20240312085957.902398-4-l.anderweit@phytec.de>
In-Reply-To: <20240312085957.902398-4-l.anderweit@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE6CE104770A3E47B377424B4E8C7530@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWyRpKBVzc0+UOqQdNqOYuHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZJ/sDC9bw
 Vby49Ym5gfEPbxcjJ4eEgInE/Quf2LoYuTiEBBYzSZw5cooFJCEkcJ9R4sfyWojEBkaJZT8n
 MIIk2AQ0JF6e6GYCSYgItDJK7H38FKyDWSBL4v/FWWwgtrBAlMSG3kvMILaIQLTE8w3rmSBs
 I4n/a+eDDWIRUJV4PG0JK4jNK+Amca5tJyvE5jyJ+2sXgtVwCthIXLw5D6yXUUBWYsOG88wQ
 u8QlNj37zgrxgoDEkj0QcQkBUYmXj/9BxeUlTtyaBtTLAVSvKbF+lz5Eq4XE8p8f2SFsRYkp
 3Q/ZIU4QlDg58wnLBEbxWUg2zELonoWkexaS7llIuhcwsq5iFMrNTM5OLcrM1ivIqCxJTdZL
 Sd3ECIpFEQauHYx9czwOMTJxMB5ilOBgVhLhfa3zNlWINyWxsiq1KD++qDQntfgQozQHi5I4
 7+qO4FQhgfTEktTs1NSC1CKYLBMHp1QDo7EiW9f2+Bt7Fy3k+HfDqeDMUyNX7rSauD/bbtXM
 2qPexnLpEbuZcJWIf0Ln/GNTV308GbqkT+HMi8m9a4uOvvji/ZZVTG9qxqZki9OV0/V//njS
 GO3KLvt1m6jLWp7Cfzuk901KXJ0jz6UWvFltyvGQrvtfTVO9hCov7v0SxdR9ZfWd8w/1Fymx
 FGckGmoxFxUnAgAcJve9swIAAA==
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

QW0gRGllbnN0YWcsIGRlbSAxMi4wMy4yMDI0IHVtIDA5OjU5ICswMTAwIHNjaHJpZWIgTGVvbmFy
ZCBBbmRlcndlaXQ6DQo+IEFkZCBzdXBwb3J0IGZvciB0aGUgcmVkdW5kYW50IGVudmlyb25tZW50
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGVvbmFyZCBBbmRlcndlaXQgPGwuYW5kZXJ3ZWl0QHBo
eXRlYy5kZT4NCg0KVGVzdGVkLWJ5OiBUZXJlc2EgUmVtbWV0IDx0LnJlbW1ldEBwaHl0ZWMuZGU+
DQoNCj4gLS0tDQo+IMKgY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcgfCAyICsrDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Nv
bmZpZ3MvcGh5Y29yZS1pbXg4bXBfZGVmY29uZmlnIGIvY29uZmlncy9waHljb3JlLQ0KPiBpbXg4
bXBfZGVmY29uZmlnDQo+IGluZGV4IGZkNDkyZWJhM2MxMC4uNmM2N2YxNGI1NTU5IDEwMDY0NA0K
PiAtLS0gYS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdz
L3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiBAQCAtMTksNiArMTksNyBAQCBDT05GSUdfU1BM
X1NFUklBTD15DQo+IMKgQ09ORklHX1NQTF9EUklWRVJTX01JU0M9eQ0KPiDCoENPTkZJR19TUExf
U1RBQ0s9MHg5NjAwMDANCj4gwqBDT05GSUdfU1BMPXkNCj4gK0NPTkZJR19FTlZfT0ZGU0VUX1JF
RFVORD0weDNlMDAwMA0KPiDCoENPTkZJR19TUExfSU1YX1JPTUFQSV9MT0FEQUREUj0weDQ4MDAw
MDAwDQo+IMKgQ09ORklHX1NZU19MT0FEX0FERFI9MHg0MDQ4MDAwMA0KPiDCoENPTkZJR19GSVQ9
eQ0KPiBAQCAtNzcsNiArNzgsNyBAQCBDT05GSUdfT0ZfQ09OVFJPTD15DQo+IMKgQ09ORklHX1NQ
TF9PRl9DT05UUk9MPXkNCj4gwqBDT05GSUdfRU5WX09WRVJXUklURT15DQo+IMKgQ09ORklHX0VO
Vl9JU19JTl9NTUM9eQ0KPiArQ09ORklHX1NZU19SRURVTkRBTkRfRU5WSVJPTk1FTlQ9eQ0KPiDC
oENPTkZJR19TWVNfUkVMT0NfR0RfRU5WX0FERFI9eQ0KPiDCoENPTkZJR19TWVNfTU1DX0VOVl9E
RVY9Mg0KPiDCoENPTkZJR19FTlZfVkFSU19VQk9PVF9SVU5USU1FX0NPTkZJRz15DQoNCi0tIA0K
UEhZVEVDIE1lc3N0ZWNobmlrIEdtYkggfCBCYXJjZWxvbmEtQWxsZWUgMSB8IDU1MTI5IE1haW56
LCBHZXJtYW55DQoNCkdlc2Now6RmdHNmw7xocmVyOiBEaXBsLi1JbmcuIE1pY2hhZWwgTWl0ZXpr
aSwgRGlwbC4tSW5nLiBCb2RvIEh1YmVyLA0KRGlwbC4tSW5nLiAoRkgpIE1hcmt1cyBMaWNrZXMg
fCBIYW5kZWxzcmVnaXN0ZXIgTWFpbnogSFJCIDQ2NTYgfA0KRmluYW56YW10IE1haW56IHwgU3Qu
TnIuIDI2NjUwMDYwOCwgREUgMTQ5MDU5ODU1DQo=
