Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C26C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 00:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 696B0863C9;
	Thu, 24 Aug 2023 02:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mAb8sicQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CC74863C9; Thu, 24 Aug 2023 02:19:00 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C12980275
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 02:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O0ImjK049693;
 Wed, 23 Aug 2023 19:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692836328;
 bh=o4gDXuHBmOa5NQlZaZUjVgIrFD2y3nO12+hv6bNu4SU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mAb8sicQ1kL6umkEtpPRX57bnXxbcT+suPCwu87YVB2EussHqKkWDnoJH7qpNQFiJ
 fTGkKAaO2IuoKcdJRoE00AGDkx1CUj9g68/M4Ej3V382HcSevOWYvjhCHTSR5m65ec
 +W1+Il/7qPQW1pXjUQElUC33qoduGDRbC2v47zC0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O0Im4o067430
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 19:18:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 19:18:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 19:18:48 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O0ImjB124053;
 Wed, 23 Aug 2023 19:18:48 -0500
Date: Wed, 23 Aug 2023 19:18:48 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Glass <sjg@google.com>
CC: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230824001848.vgzl7rcphic3gu2n@carnival>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 17:57-20230823, Simon Glass wrote:
[...]
> > This is how we have a common bit of rST for how to build N boards,
> > without having to do a literal copy and paste N times.
> 
> How about using this?
> 
> https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#substitution-definitions

I was not able to succeed with complex includes such as:
https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rst?plain=1#L89

am62x complete build procedure defined once and reused in other am62x
platforms.. But the am62x build procedure itself is reused from common
k3 build steps.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
