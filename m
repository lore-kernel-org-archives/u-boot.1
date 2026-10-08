Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222F4CA600B
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 08:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E180281221;
	Thu,  8 Oct 2026 08:37:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OiQdTIZaEX-5; Thu,  8 Oct 2026 08:37:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A8F07811E8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791448676;
	b=s/2hHjUsw+VLOooantMjzdlmVdpM9vDCuG6pHIAfZHJ8F7F9jgc40Vtdmd2+88pcsytT
	 sr6TTknPWN/5Js2SVKzqtU45bpQgfnJO5W84nU2ZiTiEesp9z3QD02fKT49L2LaV682HD
	 1wEYk3AWa7WPT5PXGfTqE9G+qymVhKUtJjPXMue50fSogwzlPXjeOoEEM3REqqr9bmXJJ
	 ZAdvbHLxiI0JsOn7ihs5zoLNqMklmHGz4iMsxHlfoMEJrURm5B0EHjJdR0L13rh+jN9WK
	 8yDswjSPjG7lnLi/2ljJ5fuVrcmt+yWIL1Kbc/I4rDVRAsj+s0daHTKu+/Otk9I6/HA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791448676;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RiMK3bz1Ixks2B9Fjko8FEXzM8VUFV/Vch+9ES2bO4w=;
	b=AVSXPmhLSq0rf6Id5Qh1hX6xcZHnImLIHRXu+ZogFcjjACwbin/xIssd3duonNyFFjuj
	 3G96E9ktYkBYPICpj5LXWyDBe1z7X7hBwMEPGuPgxl5Kh9xg6DXQBqKBexxELr6poW1be
	 4pipbEMVzkrwqf2/3gfYt8a7tqBjFPrZv9Y5dGoqHUOM37AUKc21730mT9eg31n+m5vgQ
	 xQConIGSs5gTSvw2jbxKjwd84RScPcKLbnRJxTnQW2PJgGq2vS9r39bwsiV2jOfa7xpJk
	 lVogLosma6OjM7kIHpkt1aK1D2FVo8FR0ZlvjgPVjycLbTIjOdqlIrULfnpk+peNoYw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791448675;
	bh=RiMK3bz1Ixks2B9Fjko8FEXzM8VUFV/Vch+9ES2bO4w=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBMKZjhNi6R1B98MpdS0i6LWbr06yNxDd6Y57paneiCvBCEsz7s+wdAqlkRc45MWd
	 WD0s9TKkoLWyZAZGQQ95drgI07YO8mJsoEVaK9FrrqKVBR7BZWdFos4u17v5Zk2fez
	 FjWs/7pttDqaB5VPLeq6Q+r1HYpOQ3wt3e3TmFnnFw60Mlvza1AdpGPR12L1UasFYB
	 4SkmT/hJg6LN0uRouqrVP8EMzVdk2W/BtPtjWKM3vpfWPX8NKr0nc8ZaASWTWY7kMv
	 xrLqSySSEGWZySVs64YP4+SVt4OAKZUgvzVUEFICm4EGbWEvG6gW/RBkA5fK9eoDkq
	 Tn61rHjBCQHaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8F07811E8;
	Thu,  8 Oct 2026 08:37:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 942CD338
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:12:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A2A24043C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:12:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EFe3MSkroB7S for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 08:12:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 393B140427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791447135;
 b=B1WN8MdhrDz1aFs6tnfTgpu3rRET+6r1VJxDdsajGeCPC6B1GqbJ3W8MZOiQsUlCZEYL
 mSsmw+2EgxERU0rgIm98jp/+fbu6k+E/yK91waMnFPK0BigX1C94Jl9wt1IqzMZ73cj3D
 4Jyrz54kUbc87zX8klS/7aB9kIoHbkjUqhF29MaUsruWo6lzhTci6H2qSKm+EcNeJsV4I
 A+29MC8xErrIAkex5qmlbeRclZSXJuATi/N9L642u3vXkv+8NHU+Lr0UaRFCadZbe9FzW
 Hvyx83bf3ffYt30JHV5p3ZCi1dHqI7Dd3mGx66hlnLKRx2cA99clHcz0gUVMz8UDU9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791447135;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=RiMK3bz1Ixks2B9Fjko8FEXzM8VUFV/Vch+9ES2bO4w=;
 b=ljWOMCowQXVfMNsoCTGedfPp5C6hVvA6ToCYbGmTeaKx3pWGDs+CrO2koC+JtF+ldRN1
 jJU1Jtax1HJpCaWMGDZFF/OoYjVHY85ltIbuV//aSQHwMIRQyuvWrWrEJ/yq5Ns+KhlvF
 LURWYf9GndMFaH62p/7CB3/7YHwBk0DkfGxbMhd4/Cr2iuZb+LZO8fQJ6Of/nEmvt8bWI
 jVA8MwZJRVe+uJq5y2mqipP7zf6l4Ss4cADm9mmVC4+3ykopJbJhKWQvCtY78DA/p51uU
 //Ljel5hN4GVgnK0ZqtRUhVDceXNL5ITIgUFh1ZiDOQgqW9TwDi7Ka/21e3JkxDMw1g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=covUpJdR; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=covUpJdR
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 393B140427
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1791447136; x=1822983136;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RiMK3bz1Ixks2B9Fjko8FEXzM8VUFV/Vch+9ES2bO4w=;
 b=covUpJdRArMCQyH7IaC7G9Pclj5OoUgfZH1fj2je/6RmJfsAtB5gEOP4
 XHfGwf4889ZTGBd6D/2vuDglar9QGIrDA0whCpN41sUyINGvX6vTAZQfr
 hSQ/bmJ2BURLjni9PXSoZRN/JQzJn2gUOtE9ckItR/9b3s5Zgp39EHvO5 M=;
X-CSE-ConnectionGUID: DD9d9wpuRd2vD4zRJbLi/g==
X-CSE-MsgGUID: m4+bCGHmS8W/xehLFHanmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="182795068"
X-IronPort-AV: E=Sophos;i="6.27,145,1787004000"; d="scan'208";a="182795068"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 10:12:12 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 10:12:11 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Thu, 8 Oct 2026 10:12:11 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.u-boot-project.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <mwalle@kernel.org>,
 <miquel.raynal@bootlin.com>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <marex@nabladev.com>, <tanmay.kathpalia@altera.com>,
 <raymond.mao@riscstar.com>, <ssunkkan@gmail.com>, <flaviu.nistor@gmail.com>,
 <ehristev@kernel.org>, <jeyu@issi.com>
Subject: RE: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Topic: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Index: AQHdTASDutTIbXosAECSukQXsADO1bbzX7yw
Date: Thu, 8 Oct 2026 08:12:11 +0000
Message-ID: <637617942d4043cbb3a371fca5fe55c1@infineon.com>
References: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
In-Reply-To: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 08 Oct 2026 08:37:42 +0000
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

SGkgVG9tLA0KDQo+IFRoZSBzcGktbm9yLWNvcmUuYyBjb250YWlucyBvcHRpb25hbCBsb2dpY3Mg
bGlrZSBTRkRQIGFuZCBtYW51ZmNhdHVyZXINCj4gc3BlY2lmaWMgZml4dXBzLiBUaGUgc3BpLW5v
ci1pZHMuYyBoYXMgc2luZ2xlIGxhcmdlIElEIGRhdGFiYXNlLiBUaGVyZQ0KPiBhcmUgbWFueSAj
aWZkZWYgZGlyZWN0aXZlcyBpbiB0aG9zZSBmaWxlcyBhbmQgdGhhdCBuZWdhdGl2ZWx5IGFmZmVj
dHMNCj4gcmVhZGFiaWxpdHkgYW5kIG1haW50YWluYWJpbGl0eS4NCj4gDQo+IFRoaXMgc2VyaWVz
LCBhcyB0aGUgZmlyc3Qgc3RlcCBvZiBjbGVhbnVwLCBtb3ZlIFNGRFAgbG9naWMsIElEcywgYW5k
DQo+IGZpeHVwcyB0byBuZXdseSBzb3VyY2UgZmlsZXMuIFJld29ya2luZywgcmVuYW1pbmcsIGFu
ZCByZWZvcm1hdGluZw0KPiBleGlzdGluZyBjb2RlIGlzIG5vdCBhIHNjb3BlIG9mIHRoaXMgc2Vy
aWVzIGFuZCBmdXJ0aGVyIGNsZWFudXAgd2lsbCBiZQ0KPiB0YWtlbiBwbGFjZSBpbiBmb2xsb3ct
dXAgcGF0Y2hlcy4NCj4gDQo+IEhlcmUgaXMgdGhlIGNvZGUgc2l6ZSBpbXBhY3Qgd2hlbiBhcHBs
eWluZyB0aGlzIHNlcmllcy4NCj4gTWVhc3VyZWQgYnkgbXkgQU1EIFp5bnEtNzAwMCAoQVJNMzIp
IGVudmlyb25tZW50IHdpdGggU0ZEUCBhbmQgYWxsDQo+IG1hbnVmY2F0dXJlcnMgYXJlIGVuYWJs
ZWQuDQo+IA0KPiBTUEktTk9SOg0KPiAgICAgICAgICAgICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAg
ICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4gQkVGT1JFICAgIDczMTEzMyAgIDE0Njk2ICAgICAg
IDAgIDc0NTgyOSAgIGI2MTY1IHUtYm9vdA0KPiBBRlRFUiAgICAgNzMyMzAxICAgMTQ2OTYgICAg
ICAgMCAgNzQ2OTk3ICAgYjY1ZjUgdS1ib290DQo+IERFTFRBICAgICAgKzExNjggICAgICAgMCAg
ICAgICAwDQo+IA0KPiBUSU5ZOg0KPiAgICAgICAgICAgICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAg
ICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4gQkVGT1JFICAgICA4MDQ5MiAgICAzNzQ0ICAgICAy
NDggICA4NDQ4NCAgIDE0YTA0IHNwbC91LWJvb3Qtc3BsDQo+IEFGVEVSICAgICAgODA3NDggICAg
Mzc0NCAgICAgMjQ4ICAgODQ3NDAgICAxNGIwNCBzcGwvdS1ib290LXNwbA0KPiBERUxUQSAgICAg
ICArMjU2DQo+IA0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZWJhc2Ugb24gdG9wIG9m
IG5leHQNCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVsLm9yZy91LWJvb3QvMjAy
NjA2MTItc3BsaXQtaWQtdGFibGUtaW50by12ZW5kb3ItZmlsZXMtdjEtMC1kZmFhYTgyY2M2ZjBA
aW5maW5lb24uY29tLw0KDQpJIGZvcmdvdCB0byB1cGRhdGUgZHJpdmVycy9tdGQvc3BpL3NhbmRi
b3guYy4NCldpbGwgYWRkcmVzcyB0aGF0IGluIHRoZSBuZXh0IHJldmlzaW9uLg0KDQpUaGFua3Ms
DQpUYWthaGlybw0KDQo=
