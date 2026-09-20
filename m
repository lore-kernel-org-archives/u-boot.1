Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DEBC982DA
	for <u-boot@archiver.kernel.org>; Sun, 20 Sep 2026 15:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C51E640AC7;
	Sun, 20 Sep 2026 15:49:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abXN5qIfI5mh; Sun, 20 Sep 2026 15:49:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1881540DA1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789919358;
	b=bRc4OxdJ4XeR3Z+za9tAuBRRlvv93KE865zvlsFJaGm2nT8oBZX2xOEwYeOaf1g0ryBk
	 KiAxz6ezf2HjrIhNyqerN1MRCb27vv63BgbC32bZ9tSm8Vg6A/IO50m2XT8dlK+SjZcuX
	 XyJd8lz8OU5sj6Vy2InfZwPH6XOQ24s+Ksn2668gP00dGtj/5Ix1JlPQC3bkXeoCFvTgn
	 2jv4fLTIksqUP18nbHNhGMrlLP/FGAj4aKTGnTbRwpNahFqk+Ufc+Fu5Hliu/IJ2dEL3t
	 DeU5ZPybvuwsKPA4fwn4Pbao8WSrAmxxhbHHmuZDrFGBZ2lNJDrsFTaet5n6OtfaOJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789919358;
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
	bh=E/i7ThiA2y6dJMnYXL7t3S6A+WdROOSHA7Avvaywg9E=;
	b=Vm+xljEL6+cb/eAABUQG7apkJxQRkm9IRbE5tsbPfkSrb0m4AO8euNfJ4X1FZQfEsppO
	 I9PZho81KeO8qfOFPy58xcyZbDAv0ayEZL85IQhJ02YmSIvChSRIX4DV1twaI1VbdCzwh
	 +ilZTH6RYsoLalFMExO1Jpmq1LF6FhFbHfnDQB9hpLH+yjOAT05rdXu07StznLuEVftPU
	 9bD164WObFdZt0yIuo2yKR8mGdsLVMUU2T6s12V+BQfxiFbYG2jGgUEt2Ux+B5r+hX1TJ
	 t5ktvZ7dZcErKLB5aIn4eRZQmjKP+bpkeZAM86LUQNNyfHvjHAzYgyemeqUmKCDccDg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789919358;
	bh=E/i7ThiA2y6dJMnYXL7t3S6A+WdROOSHA7Avvaywg9E=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2lbxkosyaXtKCMJwKRF4nT/r6RHW130VwP92OVtGVU/4I5q7RLnleVsmmSzGyJlc
	 7IsnvuXqMe/zCUmdy6sw8GMvuGmGx1dkVg+GSXXNHEvYxjEvqM5FK7xhMMVOc9dLfl
	 /hSOctEgQEZcZK12BZ3Y51C+i+ErhHIUEkTs+TbbwHCenoaK6PMNtPZqHlYesyj7Jr
	 FlU8Gry4yfswil+pCVDMbvQ5cTCL5oMn/8pBnxDCkPGuyLtQzJJ31A2pJERW8u1DUp
	 msTJJBtDlZnJZjWjUWD7vQwmTjukfuTetU0YxdzViiFpbhgwNBuRiE5EVuKFAV1wJz
	 tZPEF5NQoZ7NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1881540DA1;
	Sun, 20 Sep 2026 15:49:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4CC03DD
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 01:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A6CC6065C
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 01:17:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DlCDQdDnhgRU for <u-boot@lists.u-boot-project.org>;
 Sun, 20 Sep 2026 01:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org ACEEE6063A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789867051;
 b=a8Lmg8ABTmL0j0ZlOnvpjsTxPUAbLiiJQGahkJI6aiKXeuLzZnqmZe5uu+LnEtWXtcTh
 wdE/MoniPpbUfYE9EX4yFXuQfohFMTLXn8z8JoZRNE3tP30hIr+O9d65Z5ikfza58pMko
 arCzFM5N+wFv+zEvL0f1Yu/iDH4IHZ0atAklSvLhAgLnqSIKvysILwqw/HNKIxOMJ84Nz
 VS9iappI9eHDXsXi/mD2h4feuQkYwqO0Q50ZFzhakWYo9RsQwVW1sbDg3DScHKNlZIby1
 FpkknIg9Fes2SrBCt/BCTUqyrywfKobi/iQpPW5SA41sOhK69foiPD87FvzgbTChhKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789867051;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:X-Amp-Result:Received:Received:Received:
 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
 References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
 Content-Transfer-Encoding:MIME-Version;
 bh=E/i7ThiA2y6dJMnYXL7t3S6A+WdROOSHA7Avvaywg9E=;
 b=kaLoPFj5nIKJTOPkoZ0eMns0RLJLE0wL4AjCor5lut9Vi9Rzz0LoGtfFL1ac+oYJbbA0
 8rDbfeno1TKL2eOkIWGekRe2rFYvWIqx/veqTE/vml7PAG7WfjG2sWlEzd5ctdGL6OTLD
 R80/bnQCMxbqyrydJTz2vvmNKYcN0l0zq0UXlwjPejylpH8WeVsxUcG3cY9duGXwo2C3+
 Rv/ij9qus9g7LlNSEKFYBpHUv7Zq/RM/VRQtzADogwCQYbwDPvw36osdV0n8+IkOCFybZ
 QNRXf5OnFHXYI0lBGzqrTIjXJd+ICRO24/MLagm0vnALrF8KV2Rj32GBFiTBbZbgrbg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=infineon.com; 
 dkim=pass header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=RLFhwDkf; 
 arc=none smtp.remote-ip="2a00:18f0:1e00:4::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:18f0:1e00:4::4;
 helo=smtp2.infineon.com; envelope-from=takahiro.kuwano@infineon.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=infineon.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=infineon.com header.i=@infineon.com header.a=rsa-sha256
 header.s=IFXMAIL header.b=RLFhwDkf
Received: from smtp2.infineon.com (smtp2.infineon.com
 [IPv6:2a00:18f0:1e00:4::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ACEEE6063A
 for <u-boot@lists.u-boot-project.org>; Sun, 20 Sep 2026 01:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
 t=1789867051; x=1821403051;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=E/i7ThiA2y6dJMnYXL7t3S6A+WdROOSHA7Avvaywg9E=;
 b=RLFhwDkfGHyrrIFNwThruxH8obukNfZAGRPcsdQ7o4CXF2HeJK7BgTlS
 z9+NKHnRpsCEfH+18maHqATzEBRDYX2cWQtys4fEwqjzL02rkiiS4DaUM
 gLEWFCkFpN4DYMt/pxZvt7rLNmD5PiLmtAQvEBYUajjQjMX/o1BocmWic M=;
X-CSE-ConnectionGUID: H4uvWVpaSM+y8te+bE/Xlg==
X-CSE-MsgGUID: F4o6Lx7xSJqgZx8/7PmS9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="179701060"
X-IronPort-AV: E=Sophos;i="6.27,111,1787004000"; d="scan'208";a="179701060"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
 by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 03:17:27 +0200
Received: from MUCSE815.infineon.com (172.23.29.41) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 20 Sep
 2026 03:17:25 +0200
Received: from MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14]) by
 MUCSE815.infineon.com ([fe80::ed10:a720:3031:ca14%12]) with mapi id
 15.02.2562.049; Sun, 20 Sep 2026 03:17:25 +0200
From: <Takahiro.Kuwano@infineon.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <mwalle@kernel.org>, <pratyush@kernel.org>,
 <miquel.raynal@bootlin.com>, <marex@nabladev.com>, <weijie.gao@mediatek.com>
Subject: RE: [PATCH 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Topic: [PATCH 0/4] mtd: spi-nor: split SFDP, ID database, and fixups
Thread-Index: AQHc+i4ckY2dYg4zk0686DcglVkgyrbVcAUAgAHWMiA=
Date: Sun, 20 Sep 2026 01:17:25 +0000
Message-ID: <3f73f1ee1ad84367a2b1927134d2dcda@infineon.com>
References: <20260612-split-id-table-into-vendor-files-v1-0-dfaaa82cc6f0@infineon.com>
 <20260918231054.GX858934@bill-the-cat>
In-Reply-To: <20260918231054.GX858934@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.161.6.196]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 20 Sep 2026 15:49:13 +0000
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

> On Fri, Jun 12, 2026 at 02:40:48PM +0900, Takahiro Kuwano wrote:
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
>=20
> So this is a good idea, I took too long on picking up, sorry. Can you
> please rebase on top of current next? I did the merge fixups easily
> enough but drivers/mtd/spi/sandbox.c needs updating now.

No problem. Thank you for looking into this.
Yes, I will rebase.

Takahiro

