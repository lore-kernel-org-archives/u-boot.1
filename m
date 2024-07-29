Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A7EC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 11:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 351B9887B9;
	Mon, 29 Jul 2024 13:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="uuzk46yK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF2C887BE; Mon, 29 Jul 2024 13:50:25 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643E388651
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 13:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0B60B1FA15;
 Mon, 29 Jul 2024 13:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1722253822;
 bh=WwQZFnBFXgnX3Anodb7b885NbTgxMUurlJYvrKVIg8g=; h=From:To:Subject;
 b=uuzk46yK4W9+ALX9o+5HU6VrI57sPiTvDoaPm4MAqdmm9/bxe6S9sGoOdqPhmsrmb
 8rcLE4cqZdB+xIDhaBsZz/o+drTdl4AuUGJngtfezejal0KpWoHkccMX2KFmVkPKB2
 HLYefG7HOruKzJaRBnVKVwm0E9jigqJ63dRocqWqc6784wFBuWBhTJBYKbMOsSKZHU
 kgV3DUGZpdQjR1/W6pr8uFBzBVlllFdQ+LKlnNghgW5/KS9bH1TYBIdcOQgEjkD/Q9
 SWInWozvLEt0AggUKistQEBdJ9BZ9vaaNQr00DWi3VywCQ/DNy1byyWW9uninSndud
 kWqO/cWMbh4+A==
Date: Mon, 29 Jul 2024 13:50:18 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Neha Malcom Francis <n-francis@ti.com>, c-shilwant@ti.com,
 m-chawdhry@ti.com, vigneshr@ti.com,
 Robert Nelson <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, t.remmet@phytec.de,
 mkorpershoek@baylibre.com, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V7 3/7] doc: board: ti: Update to use the new boot
 firmware labels
Message-ID: <20240729115018.GA38030@francesco-nb>
References: <20240725093546.4193107-1-d-gole@ti.com>
 <20240725093546.4193107-4-d-gole@ti.com>
 <20240725115823.o3rf7uupilp4ki4k@unwanted>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725115823.o3rf7uupilp4ki4k@unwanted>
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

On Thu, Jul 25, 2024 at 06:58:23AM -0500, Nishanth Menon wrote:
> On 15:05-20240725, Dhruva Gole wrote:
> > Use the new boot_firmwares labels that help make documentation more
> > specific as to which firmwares are used in which devices
> > 
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >  doc/board/beagle/j721e_beagleboneai64.rst | 4 ++++
> >  doc/board/phytec/phycore-am62x.rst        | 4 ++++
> >  doc/board/phytec/phycore-am64x.rst        | 4 ++++
> 
> Francesco, do you care about getting this in doc/board/toradex/verdin-am62.rst ?

Sure, I am ok having this added, just adds the required changes to
verdin-am62 in this patch.

Thanks,
Francesco

