Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D034C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 04:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9AD340A1C;
	Thu, 23 Jul 2026 04:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1bokYS6XQZjy; Thu, 23 Jul 2026 04:02:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87DDC40A0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784779364;
	bh=vZAt0uLEi3l6DB148bjRoHna+Y8p6SzoYTWWtvg0yL0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzWM8fWwme7Vna0cEqkDQQFv29Vsn27F4T/fZKGLdp4wcvl/8tbMHl9/ahrFITLum
	 KAYDRBoLJZLMfAwgHC7Xb1BWdWX5vvZkxpW4YkwNRoG0P1QQEHfDmVL75fylZmlSQ+
	 l9FtspHvuReImLY4206ebH5d1ETmeTcLlmtGWYkquC44/+fXUJxJiNJGGSJc16LimA
	 kn2940xaUiwqMw1L7X9waA7j+3s1reooCkHA0Y+YdvUWwCdmby+MmTPmvftQXfdPSj
	 27OGS/WC1GeVqp27k1TfwB0fR0Nke/mJlMNdIDydgcY0MBw3Ij2cj0IJy27wZuPrIm
	 kUc+vbMurj7mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87DDC40A0E;
	Thu, 23 Jul 2026 04:02:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DDC713B0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 04:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF48440152
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 04:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwmvudKal3wR for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 04:02:42 +0000 (UTC)
X-Greylist: delayed 382 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 23 Jul 2026 04:02:40 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 39E0140026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39E0140026
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.36.163.20;
 helo=gate2.alliedtelesis.co.nz; envelope-from=ronan.dalton@alliedtelesis.co.nz;
 receiver=<UNKNOWN> 
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 39E0140026
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 04:02:39 +0000 (UTC)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 95F8B2C0241;
 Thu, 23 Jul 2026 15:56:07 +1200 (NZST)
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by
 svr-chch-seg1.atlnz.lc with Trustwave SEG (v8, 2, 6, 11305)
 id <B6a6190d70000>; Thu, 23 Jul 2026 15:56:07 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 23 Jul 2026 15:56:07 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Thu, 23 Jul 2026 15:56:07 +1200
From: Ronan Dalton <Ronan.Dalton@alliedtelesis.co.nz>
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, Aryan Srivastava
 <Aryan.Srivastava@alliedtelesis.co.nz>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, Chris Packham
 <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] mtd: nand: pxa3xx: Fallback to 1-bit ECC when chip
 requirement is zero
Thread-Topic: [PATCH] mtd: nand: pxa3xx: Fallback to 1-bit ECC when chip
 requirement is zero
Thread-Index: AQHdA4/R++bv1CISNE2gmJ1HOmMinrZ53heA
Date: Thu, 23 Jul 2026 03:56:07 +0000
Message-ID: <545ed007e60c1e15986e3c363c96028a5062674d.camel@alliedtelesis.co.nz>
References: <20260624041243.1045912-2-ronan.dalton@alliedtelesis.co.nz>
In-Reply-To: <20260624041243.1045912-2-ronan.dalton@alliedtelesis.co.nz>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.12.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <834AA8D94DC1524594BD214E45D409AB@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=NY9F1HD4 c=1 sm=1 tr=0 ts=6a6190d7
 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=BhaoXNk7gXQA:10
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=EQRKZpKypqwq-JPeUqUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=alliedtelesis.co.nz; 
 s=mail181024; t=1784778967;
 bh=vZAt0uLEi3l6DB148bjRoHna+Y8p6SzoYTWWtvg0yL0=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=KzHTe8G59jr4SW6JY4UMUj3lGZIkCJ4HnMA2VR2PnQ5VGFhusU8+woPbuuAN60kZS
 iFKxnxKnIWcDvmo8iUb9W+PfgPZ53LpFk/SyZFin79fyWHwMkdUSKmsxllsyRyXnZr
 u13LFypNmNqz4qsw+65kpkQO66350c6OvyuSGtbjavTn6nS8ULzlvHrT2oCqbR0siN
 fZ84UghONvntj8Ke6cWeysTlDIToh1VxAw3Fz8+1edTtJ4jK/C9VqYkxGVh5AW/LfA
 3ST24wh/fpby7INZJskROz7AUc16X3GjZ01kFwioKekhWM8ZHykNYzezVtedtmNxnb
 GloCi43Joynlw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=alliedtelesis.co.nz
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.a=rsa-sha256 header.s=mail181024 header.b=KzHTe8G5
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

SGVsbG8sDQoNCkkganVzdCB3YW50ZWQgdG8gZm9sbG93IHVwIG9uIHRoaXMgcGF0Y2ggc2luY2Ug
SSBoYXZlbid0IGhhZCBhbnkNCnJlcGxpZXMgeWV0Lg0KDQpUaGFua3MsDQpSb25hbi4NCg==
