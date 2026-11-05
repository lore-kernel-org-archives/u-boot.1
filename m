Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCFC606A32F
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I7qHDuDl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=a8t81B8L
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C929E40754;
	Thu,  5 Nov 2026 05:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FRx6xaYgukRv; Thu,  5 Nov 2026 05:42:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A1D884079D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793857325;
	b=SoZHTFmws43knxxciaumeb1ygbKA4HvvH9g883PbVhFMtzfMg+s2RZuFhy755+EQYUo/
	 evuloPK4Uob0lAWxKOR5b2t0BeX7e9GlPBErdEItSO7E7aeGIwAYW9sU11vaKbdrTcS+i
	 WJBXYk/jNGDNRnB/tuE2Mx4ctNMFbUc1/MdWufSBaKQTfwR90mqguFwqHgfJenzT1Lqhf
	 MzFVGIyKNlfpHZqtmmQ+lP5BHt9HO5nzEuQeWtV7xn7tGr+3Z54KKpTgIj8AXiD+rPA9i
	 OvdN4Z1VcxC3XR422pVSe6uxK++YS9gjuYo2+8PL8KmoGRvmEzCvctnWNoo1F4PCGkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793857325;
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
	bh=Fi/PoLXW6V3g8/1YP5eqGCBCIpEQYQ2ZDHXp3+P0vD4=;
	b=TZYeYiZvknqNzLXh5zTVxaRsxAgWWOX6NtbOLFqpgJXlhgV4g2ZNOu8OqOKmNzqeeTr8
	 LFt0+3sStTFHIpGm0g8GTdHmJIIMfAZ91PmO0dLLvTEjINL3tMwO+7WoqRekaOHPTHKBG
	 jMxtG6l6AvkHEiFdcZmrQQqDgZqeN2zUx4o8KFA0ZOPU7OaeezWdWN6NjDvAPSQ8A/fBX
	 w0Sf3j53qBKm3ghbyammAvjTY9FBkzflfC00y+0bfzbQXAxB3KMmxOqgixfpJ4/rlGkiq
	 0rrnI/iIdcTk7kAdQJeI67DOKhGgCbAIpNgwoe0bxqTTBiJ4MOw9FW8QBdP8yqMn6wg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=a8t81B8L;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793857325;
	bh=Fi/PoLXW6V3g8/1YP5eqGCBCIpEQYQ2ZDHXp3+P0vD4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7qHDuDl1eES6Y0JGDcuQAUc9mMAoeTEsN5QL8AIn+uB4t2W6SWIIhd/QoU8dJY8s
	 6EWVKTTiLXvOl4SD3kTyXtyOrs8uo0aS5YYePMyllsncqPRxYM+cBI/adQXu2q2ocE
	 Ca/aujouiqQnHK1EpXG5ZuTyfSdq1jTIkhon3jWsKM0/NkrLSePCEtrQLL/LAQocJT
	 V7nSkS7WlDf9j2MqveY8+uu6rvzB6Zal2vYDyXGcKHcYOw8Ar8vIh1lX3j2BGvKDv+
	 dVpfYdaT8nQuLS7Tt019X/vg92PmN3tYSt0Mg+1ChWMQoVvnG7rNL7OLCKOzQsj/ij
	 fIQb1Qs3umL7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1D884079D;
	Thu,  5 Nov 2026 05:42:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FF5931F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:31:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75638404E8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:31:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-Iuvxd4C6RO for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 01:31:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4791C40497
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=a8t81B8L
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4791C40497
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1793842297; x=1825378297;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Fi/PoLXW6V3g8/1YP5eqGCBCIpEQYQ2ZDHXp3+P0vD4=;
 b=a8t81B8L6kJx5CpjxmD0HRhIQtL+ZbJxfo+F/vsdP1h1VVscHmZKZPTD
 Q42JiJfqrQ0nmpHsNf6MXrt0nKAIyh/yyT3dcfw+02xcZHqPwac61d4MS
 hyfw/FD8NlksFnVmFA//uS5HDylSt1Sv6Tz5z4r5nERKmdcoDelBiro2p M=;
X-CSE-ConnectionGUID: 44sw3zU4RQOuA1in6/4zMw==
X-CSE-MsgGUID: qMhUivyXRjWx6PnLgE5Ptw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="188090651"
X-IronPort-AV: E=Sophos;i="6.27,196,1787004000"; d="scan'208";a="188090651"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 02:31:33 +0100
Received: from MUCSE820.infineon.com (172.23.29.46) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 02:31:33 +0100
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE820.infineon.com
 (172.23.29.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 02:31:32 +0100
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.056; Thu, 5 Nov 2026 02:31:32 +0100
From: <Takahiro.Kuwano@infineon.com>
To: <asrinivasan@oss.tenstorrent.com>, <u-boot@lists.u-boot-project.org>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <ssunkkan@gmail.com>,
 <jeyu@issi.com>, <yangshiji66@outlook.com>, <boon.khai.ng@altera.com>,
 <flaviu.nistor@gmail.com>, <vjardin@free.fr>, <quentin.schulz@cherry.de>,
 <s-vadapalli@ti.com>, <anshuld@ti.com>, <patrice.chotard@foss.st.com>,
 <jbx6244@gmail.com>
Subject: RE: [PATCH v2 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
Thread-Topic: [PATCH v2 2/2] spi: dw: Add supports_op function to reject
 unsupported transfer modes
Thread-Index: AQHdYcYBcXU2l1jI70yDViaZJRbFIbcexp4w
Date: Thu, 5 Nov 2026 01:31:32 +0000
Message-ID: <d21eac35392f4df381901521301f576a@infineon.com>
References: <20261021-spi_fixes-v2-0-78af1e8c8c3e@oss.tenstorrent.com>
 <20261021-spi_fixes-v2-2-78af1e8c8c3e@oss.tenstorrent.com>
In-Reply-To: <20261021-spi_fixes-v2-2-78af1e8c8c3e@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Nov 2026 05:42:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBUaGUgZGVzaWdud2FyZSBzcGkgZHJpdmVyIGRvZXNuJ3Qgc3VwcG9ydCBkdWFsL3F1YWQvb2N0
YWwgbW9kZXMsIGJ1dA0KPiB0aGUgZHJpdmVyIHN0aWxsIHRyaWVzIHVzaW5nIHRoZXNlIG1vZGVz
IHdoZW4gaXQgc2VlcyBhIGNhcGFibGUgZmxhc2gNCj4gY2hpcCBpbiB0aGUgZGV2aWNldHJlZS4g
QWRkIGEgc3VwcG9ydHNfb3AgZnVuY3Rpb24gdG8gdGhpcyBkcml2ZXINCj4gKGFsb25nIHdpdGgg
dGhlIG5lZWRlZCBTUElfTUVNIGFzIGEgS2NvbmZpZyBkZXBlbmRlbmN5IGZvcg0KPiBERVNJR05X
QVJFX1NQSSkgdG8gcHJldmVudCB0aGlzIGZyb20gaGFwcGVuaW5nIGFuZCBmb3JjZSBzaW5nbGUg
bGFuZQ0KPiBvcGVyYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmlydWRoIFNyaW5pdmFz
YW4gPGFzcmluaXZhc2FuQG9zcy50ZW5zdG9ycmVudC5jb20+DQoNClJldmlld2VkLWJ5OiBUYWth
aGlybyBLdXdhbm8gPHRha2FoaXJvLmt1d2Fub0BpbmZpbmVvbi5jb20+DQoNClNvcnJ5IGZvciB0
aGUgbGF0ZSByZXBseS4NCg0K
