Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005D2CC6B2D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 02:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F5D460852;
	Thu, 15 Oct 2026 02:35:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QI-g5-KpGIIi; Thu, 15 Oct 2026 02:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7889560848
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792031752;
	b=tZHWpBKakvupv9hTIvIa5MsYfbcDBuGWGyCjkbtfaCnQi7QWo+EV8F36LPWUD7/V0pHr
	 sfGOQ+inOhdq2vkYRaAbBpw1O3Idcg/bVuZ8CwikwCGdR6ZKHfxPj7Y8zkAXDUYNpbQ7s
	 z7Oh1gBEhHfGisI+hgwejNHAhtTMvB0DYub5mLLged6sEn/TqoJpnFXbdEhCyyaiJNrLr
	 n7lWAjuMDmmWCHZHhLVir+Syv/4UIAfswUwdwqgGvM975kJIVcQ5w6W/VaKr5VU4L0f1o
	 WjzKPcNGlWA0uPO6I3lSp6eBjo7Auk4NlkqoSn+cs1dKcvWNE1D5P+gcCfjg6kRMlwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792031752;
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
	bh=VsLhCU9c9Z9BOW0B/giD0BegET/kCVJi6McKMQlNHiw=;
	b=mh0VcUAOQohzcOzegTLXC6404g5ICga3TbUGocVQMMifxaSV6KeL0HJPUJ9Ig3uaqn4Q
	 g4GT4dUnedg8nk8Fb86EntjHfVT5F/b/kHpL/0ocusKe9JqF65G1nQxf/NgAPjsc4r1cK
	 SRlj6EmOh0RF810oMo8eNf/pJnONT0FmzV/R9kHORWPKF0TTiy5q8U7+Kps1+5kHmvpDu
	 wfJBHOn7DU+3BsVpvCgiE0RsZC/XOpKoZLOEMIVJm3IGyJ58FW2d2eSOxJXA7NWhMEJHC
	 FyLO+gKI4uRnPCdM9vPL1CCvQxEGL3dLr/rLM5UjjlpCU0OUG0n5rIsRdAXAnRWrD6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=infineon.com;
	dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256 header.s=IFXMAIL header.b=oB+gZxot;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792031752;
	bh=VsLhCU9c9Z9BOW0B/giD0BegET/kCVJi6McKMQlNHiw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S91Iv8UJcQgr/XBrLcdmo8or3WZdFvD3aZrZzfmGaj2DcMCz8ThPkuTtwYDOw6te/
	 nFE/HXzAH+a+CQkJLDVTkgOyilx8+sXvn23X9dZCj5on7Q4JT18RG3uRWwkLx5dHD8
	 3xWdrwLzeh2VhN62ipBgo7dI7v3Hy5WIEG/TBCR0mqMpe8hM2JjcjDq1YLR9/GniC7
	 ffgIOY1wPS3fLEvBj8sUbXGzSs3Hw38lG3c5Q+/QfJ2k4NNtSV5cAVMf0R3sJOXAMz
	 5WK+/BmzAKK0/yxQD4Tb+2ICpiZ2IEaw6909Lcm+O2LwSdF76iqlsOs7SEgr90gsx6
	 KllZWxFpeWo/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7889560848;
	Thu, 15 Oct 2026 02:35:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 79DC9E4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77CB76077F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:37:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2VWdXKMTEdI for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 01:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11F9E60767
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792028228;
 b=TRY2LT5VgelQN2y/w7dQUYs5G/dFUJJphLmpGRrR1L2MdkuHLECw3M41FWkBodzc2rka
 0PnsytsqMXqR/ixTgv69B3d4pqx2NkxTIc9oSbIDJ86aGDb2RseiD2FLNzh1CWT2lFrpx
 uYyu+wKXSiqkVtHVHi9HkIMbOSgNfnbQs8GdzVYUgtXti928uoYvG3X3DsifDMB9zFwFO
 w7V7nBJqIHCk1veAFykDCkNXI4fZ9LfM0dF0f6Rhjiv8QLBqc7S48cgyzquyQyZAy15wz
 Mcd2tNSh+8CFdsW8P8Qfvjyj420OUCLor2pWEkipUkobxXyVid3MK5iiC2wHQKocXig==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792028228;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=VsLhCU9c9Z9BOW0B/giD0BegET/kCVJi6McKMQlNHiw=;
 b=f2E2ON8OK6pzhx+5TNDTsvGTVmonZFzwyPq2BU0NqsQ+uftWs7tmEw29wS4KNgjJu4mm
 Ix+mTqQE8WGCPZvCvWyiwnpm1AqMM9XV+dfFnU0+84BVL1qddCM58qDqHD0oKpIxfQ6ml
 PHR8C957GOTzvTZ6TgkrQj6cmXYH5rHBhRf9uBy9qydtDW/5oZns4G5mpl2Cmq2cy21+K
 BIhUF+4WYmwxOTIvE+msGgaZ4RrqEDICE7xHAFMetKLNRX6jc8xLeWgf1hJ6YtIjv2E5w
 s75zLkDSoNrxs23hr9q5jv/YgNxRmzEaBpUPFfoJiqHIRfAS4DuIOg+2Lf7vJGJOgDw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=infineon.com;
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=oB+gZxot; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::6;
 helo=smtp14.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=oB+gZxot
Received: from smtp14.infineon.com (smtp14.infineon.com
 [IPv6:2a00:18f0:1e00:4::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11F9E60767
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 01:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1792028228; x=1823564228;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FPPXFNm4V2AcUTSlR0Rihp0PO61b4U7Rfjcc8v3pqj8=;
 b=oB+gZxotv+g5uOvrTnTtoBxYSZ5nkMSNvIzEzTx3K9o080yTpD/jAQgE
 trDI8Zc4s7WRGvwrzGFWJdjiEk0V0LRUMEcZAx75nZIRyxtoR1BC/OK10
 zsKtHtxEQmo/egWqIJgyOqJhEWgZ5RHNgeVyFDMkU1TjA+KRrqvVuUPGw Y=;
X-CSE-ConnectionGUID: vBOhTpU6TredNbG2T/kWog==
X-CSE-MsgGUID: j7wUNYlASsOLrAFDjYCDqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="151186125"
X-IronPort-AV: E=Sophos;i="6.27,158,1787004000"; d="scan'208";a="151186125"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
 by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 03:37:02 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 03:37:02 +0200
Received: from MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be]) by
 MUCSE815.infineon.com ([fe80::b54c:c0bd:546c:c9be%12]) with mapi id
 15.02.2562.053; Thu, 15 Oct 2026 03:37:02 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <vigneshr@ti.com>, <mwalle@kernel.org>, 
 <miquel.raynal@bootlin.com>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <marex@nabladev.com>, <tanmay.kathpalia@altera.com>,
 <raymond.mao@riscstar.com>, <ssunkkan@gmail.com>, <flaviu.nistor@gmail.com>,
 <ehristev@kernel.org>, <jeyu@issi.com>
Subject: RE: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Topic: [PATCH v2 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Index: AQHdTASDutTIbXosAECSukQXsADO1bb9t7+AgAA542A=
Date: Thu, 15 Oct 2026 01:37:02 +0000
Message-ID: <889ad89837b346f2ad1d36324179dd30@infineon.com>
References: <20260924-split-sfdp-id-v2-0-aafc70e0b657@infineon.com>
 <20261015000349.GA337194@bill-the-cat>
In-Reply-To: <20261015000349.GA337194@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 15 Oct 2026 02:35:50 +0000
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

> On Thu, Sep 24, 2026 at 06:10:04PM +0900, Takahiro Kuwano wrote:
>=20
> > The spi-nor-core.c contains optional logics like SFDP and manufcaturer
> > specific fixups. The spi-nor-ids.c has single large ID database. There
> > are many #ifdef directives in those files and that negatively affects
> > readability and maintainability.
> >
> > This series, as the first step of cleanup, move SFDP logic, IDs, and
> > fixups to newly source files. Reworking, renaming, and reformating
> > existing code is not a scope of this series and further cleanup will be
> > taken place in follow-up patches.
> >
> > Here is the code size impact when applying this series.
> > Measured by my AMD Zynq-7000 (ARM32) environment with SFDP and all
> > manufcaturers are enabled.
> >
> > SPI-NOR:
> >             text    data     bss     dec     hex filename
> > BEFORE    731133   14696       0  745829   b6165 u-boot
> > AFTER     732301   14696       0  746997   b65f5 u-boot
> > DELTA      +1168       0       0
> >
> > TINY:
> >             text    data     bss     dec     hex filename
> > BEFORE     80492    3744     248   84484   14a04 spl/u-boot-spl
> > AFTER      80748    3744     248   84740   14b04 spl/u-boot-spl
> > DELTA       +256
> >
> > ---
> > Changes in v2:
> > - Rebase on top of next
> > - Link to v1:
> https://lore.kernel.org/u-boot/20260612-split-id-table-into-vendor-files-=
v1-0-dfaaa82cc6f0@infineon.com/
>=20
> Sorry, sandbox still doesn't compile:
> /home/trini/u-boot/u-boot/drivers/mtd/spi/sandbox.c:156:14: error: use of=
 undeclared identifier 'spi_nor_ids'; did
> you mean 'spi_nor_scan'?
>   156 |         for (data =3D spi_nor_ids; data->name; data++) {
>       |                     ^~~~~~~~~~~
>       |                     spi_nor_scan
> /home/trini/u-boot/u-boot/include/linux/mtd/spi-nor.h:656:5: note: 'spi_n=
or_scan' declared here
>   656 | int spi_nor_scan(struct spi_nor *nor);
>       |     ^
> 1 error generated.
>=20
I noticed this and sent an email [1] but seems too late.

Thanks,
Takahiro

[1] https://lore.kernel.org/u-boot/637617942d4043cbb3a371fca5fe55c1@infineo=
n.com/

