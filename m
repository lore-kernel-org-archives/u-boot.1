Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6174DC88E77
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 06:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C5AEF607D1;
	Wed, 16 Sep 2026 06:23:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERsEjl4izro9; Wed, 16 Sep 2026 06:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 188B2607CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789539811;
	b=WNVb0PUhXQyzVdvFrhrB5JeVoMiBQ6YmkaRTCLHyGtmvzzZ/FmfBSyO554/wykFxigaU
	 9rONkKxLgsQOnAVq9pAGsb9Tc++i6hSHSOxnkV7g8NamblntBuLdL1DVT17EitxLC/Fep
	 oBWF8Og16p2GrX6BtxYto7K/Fbgdpdq7leW+VJCRS5Z+jM6zZ2JxRVlTfH3F+qoQqA1Om
	 0WibUd2KK8bCOkMLhocoXWrNCV9+/70g6ECCneOTk6IxrT5DmjNR7JkMvGl0rUXtm+DVX
	 0lC6W/rhlTcdWfB3srurg/IM+cvFAkd9ir3wCuAy4nniU6unA2uDjQxdS/NRH9fAZaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789539811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Received:From:
	 To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s2qvxSG8JZO0eWsXyt4mCDgzy38X2DMiUGxXA/5CvJI=;
	b=dqy/oTHjzVqYcADVI0DzdVmGpR9OtxExrX0SPvTY5n2auUo5y9dtA+Jgha4YfU6ExRHK
	 Q78X97iWwAZu6muBx+wwYVAG9ZYMAEBpP359jvELXoQqP3Q2YzHGiJHa+PcDtphaip2Eb
	 knoBPsXrfH26bPVva8jytAQdKUDScdSVAdqHi5G/yG7nalz+X7OZZsiCDm10Wwc3beGvn
	 RPX0kRlqwhBG75ZyoHIDDWMD5WTmriNsFqtVHdaMWgt0GRrA1gl8BxPPyJKz5kwL0cVoz
	 f5H1ZxZAcBg5EDUJuBTaDgjpguqm9O3Tw7WLXPEx1GMdLEKxbqxuRXHbOYKZrR+36sg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789539811;
	bh=s2qvxSG8JZO0eWsXyt4mCDgzy38X2DMiUGxXA/5CvJI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irbvh/Nzlna5pYm/lEWqd0VjPTSed6DB8z5gy9+lBWOEzEEdPYfdRhWibodgvOPmJ
	 xuP/57AwLbQoeQT20PzzKQx/lqboiuXLKyS6FbimKtheX9Ky+Sm6ErQiPW185cCa28
	 Cc1Vk+Y2LklQJtgpwyvcDaeuucNmr1ygkPVR5Y7Kq74Hwr34thCYBX6Xa6Q9KF2KWX
	 5gQq9UJXgpBcgmesrTyRZ0xq5V2+J90FS6yU8bKKSF3LCtQvSztLANZ3Q0yBMMZURo
	 E0GENA9F2iw8qd0FKq3VMMgxetAcTwoD/bUmcG0tiCjyGQMToM2uI2Ag/59WZ0UqO/
	 JpxUBqguYT6zw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 188B2607CB;
	Wed, 16 Sep 2026 06:23:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 77FC3422
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 01:09:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DFC740639
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 01:09:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rtw56-cs5g3a for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 01:09:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A8FEE4040C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789520985;
 b=nPoTx+mkOLX5XyzGJK9HcvSNmyhT4/I01SaL9SjhCgYHi9MerAa+W+Bxm4AGL2ZX+Yel
 s0bSgoLQ/TZgt64nONyZz/FMc9fK7VtgDsXvoEAxghYM5R2OI0LnxZ3qAk16ol7pd8gk1
 oCFfyHOPFCrmcJ7fEdCJ9TAMY27dccGvvgZPM4YtoZPCriJQPz9/dOXeG3v6vhDBq8Wxu
 /hDu6Qg8/frfxTOCEJ8lVF5u0w3ebu2chLHNLeVCrIwn8RzpC61SoDNHUcGceQOt7f8zw
 vy0hvgh+Z9pGQ7NVuM+w1Zl+LJFv/VhOg5GJ6QvGM/bKHvc5wlLOtucIw2R7342NJ6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789520985;
 h=X-Greylist:Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:
 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=s2qvxSG8JZO0eWsXyt4mCDgzy38X2DMiUGxXA/5CvJI=;
 b=UBLc5jfm4lzj0d3+D+l2EDlT5Vjx1qnp8MgzVwg5lDgBikyRjil1kXqlb6IQA/mUcZ1s
 ySLo9fLu6en1Ui3+mPMkSDFOdqBICbWyRKSZewxnUvHJxWtxnGy7c+AssrfPBKTOF6mGv
 FJVpeDj9M0q8zRUTiGC1/GFNBf9Px/DPWsp8mDslBjxKCmjbenhR9RKWcK91GUXCZqv3L
 kNBlW+iUR3JVoIKW/t0qAQ7YMzsTrDY59LadmF78toC5ZIU+TYOajkXP6r7OJ/F4yiyi3
 kBvSubXfx1L2bUFf+51BXyhHYpkErB2xFgv5ZEB6vaJGZrzByC+mOrnlxKFcLimHoyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=JgoOmsf7; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 16 Sep 2026 01:09:43 UTC
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=JgoOmsf7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::6;
 helo=smtp14.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8FEE4040C
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 01:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1789520985; x=1821056985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=s2qvxSG8JZO0eWsXyt4mCDgzy38X2DMiUGxXA/5CvJI=;
 b=JgoOmsf78e+CT0pJirj9Jxpprzll/7kZ8hv0HrkWKXGo8lmxk1yJc5YZ
 A9OjnbndXc4n+Fj9FDug+gewqEShrqJ/kqeod/FzZK+syTEkO8xdSl1RO
 ZxOzgsxGL5k8mwm8qdFpCqskdMwRQdnHHMftNmJ7Z9yq/v/6rICABayCt Q=;
X-CSE-ConnectionGUID: 3YIfExi5Q6aBPRZNaXE0yA==
X-CSE-MsgGUID: fm9alwfYT6KPaEenrcR3OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="147212456"
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; d="scan'208";a="147212456"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:08:35 +0200
Received: from MUCSE816.infineon.com (172.23.29.42) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 16 Sep
 2026 03:08:34 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE816.infineon.com
 (172.23.29.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 16 Sep
 2026 03:08:34 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.046; Wed, 16 Sep 2026 03:08:34 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <mibodhi@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <ssunkkan@gmail.com>,
 <flaviu.nistor@gmail.com>, <jeyu@issi.com>, <dlechner@baylibre.com>
Subject: RE: [PATCH] mtd: spi: update spi-nor protected property for some
 flash types
Thread-Topic: [PATCH] mtd: spi: update spi-nor protected property for some
 flash types
Thread-Index: AQHdRIr0x+n7M7FqWk2OMh/UTHy0nbbQUaSA
Date: Wed, 16 Sep 2026 01:08:34 +0000
Message-ID: <528baded710e4e42ac12d0ba657d9237@infineon.com>
References: <20260914-spi_nor_protected-v1-1-80a925329712@gmail.com>
In-Reply-To: <20260914-spi_nor_protected-v1-1-80a925329712@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:23:29 +0000
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

SGksDQogDQo+IEFkZCBwcm90ZWN0ZWQgcHJvcGVydHkgZm9yIFNQSSBmbGFzaCBteDI1bDQwMDVh
LCBteDI1bDMyMDVkLCBteDI1bDY0MDVkLA0KPiBhbmQgIG0yNXAzMi4NCj4gVGhpcyB3aWxsIGVu
YWJsZSBzcGlfbm9yX2luaXQoKSB0byB1bmxvY2sgdGhlc2UgU1BJIGZsYXNoIGF1dG9tYXRpY2Fs
bHkuDQoNClBsZWFzZSBtYWtlIHN1cmUgdGhlIGxvY2tpbmcgZmVhdHVyZSB3b3JrcyBwcm9wZXJs
eSB3aXRoIHRoZSBIQVNfTE9DSyBmbGFnDQplbmFibGVkLiBUaGUgSEFTX0xPQ0sgZmxhZyBzaG91
bGQgbm90IGJlIGFkZGVkIGp1c3QgdG8gc3VwcG9ydCBzdGFydHVwDQp1bmxvY2tpbmcuDQoNClRo
YW5rcywNClRha2FoaXJvDQoNCg==
