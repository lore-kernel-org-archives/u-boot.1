Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB0EC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 19:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B48687ED0;
	Fri, 10 May 2024 21:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Af5AxG0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C7DC87FC6; Fri, 10 May 2024 21:58:50 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3923687E0B
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 21:58:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44AJwbV2079370;
 Fri, 10 May 2024 14:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715371117;
 bh=yd/PWIPx6site7soDFbemrob6v/s3xDJHQAnlbZswUc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Af5AxG0c6M2f+5YB1UW1vkckkYFBDC3IU3XdLwhLvY6gLaH+u8LN3QR6jy/f6cjC8
 3v967UUDK7khweuX3+1kqtS2FrXgmbEHCe/0rLB8NsiGJcl6kOhEHmuMVdWlO484jW
 gV2yc3IYI4Zu5uhl+4dIm2g+GkbPIZECEjHbCSxs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44AJwbTJ027995
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 14:58:37 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 14:58:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 14:58:37 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44AJwbZC043850;
 Fri, 10 May 2024 14:58:37 -0500
Date: Fri, 10 May 2024 14:58:37 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Roger Quadros <rogerq@kernel.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, <srk@ti.com>, <s-vadapalli@ti.com>,
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] arm: dts: am62-beagleplay: Fix Beagleplay Ethernet
Message-ID: <20240510195837.oebzog4czpn4wzxs@spearfish>
References: <20240425-for-2024-07-beagleplay-eth-v1-0-6c985de1c316@kernel.org>
 <9baa5ac5-8ce9-4aea-9a3d-ec1d68ea5505@kernel.org>
 <20240510130830.GT2568172@bill-the-cat>
 <08b22e06-f316-4ef6-bd42-a4600f1f8035@kernel.org>
 <20240510193325.GX2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240510193325.GX2568172@bill-the-cat>
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

On 13:33-20240510, Tom Rini wrote:
[...]
> > 
> > [1] arm64: dts: ti: beagleplay: Fix Ethernet PHY RESET GPIOs
> >       commit: 0b1133ee36ecbf3b02f69cc4e8a169f1b6019e40
> 
> Ah, since it's been merged to -next now, Nishanth, what do you want to
> do?

No biggie.. it is on route to kernel master anyways, was planning on
OF_UPSTREAM migration for beagle once we settle 6.10-rc1 settles into
u-boot.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
