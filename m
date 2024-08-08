Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E29C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 15:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA8A887D3;
	Thu,  8 Aug 2024 17:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="puHRSefx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D958857D; Thu,  8 Aug 2024 17:48:49 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35AF88B81
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 17:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 381ED20ABE;
 Thu,  8 Aug 2024 17:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1723132125;
 bh=8Foh1MYixL5BOgLyjMVmlsJrd973L3xNFL2UlhqmHlg=; h=From:To:Subject;
 b=puHRSefxP5IuXv/T4QOfyi4JCleJL/6sV1V8e4iETLa8MEx3g6fhXXBSez/ay30ov
 60+cqK8MF4OfLJ0ndNgpXWfe72wwBGMYpJmMHdmOajn2EDQcUH59VMw85TWZC0MUr6
 F3oStuHUOZTD6DgMLv1IgGdqu6W+1nLgD9u++rftXACeIcxKiTd40z/4+cT7HWdAgl
 aPTZSy2/oTWeIzbsE846ur5uGiczbPksoh5pef7SVpTPBbqZDIgRSmc7B1kG5eVN/5
 EioVmKmPmTlo8fOK7qz/UXVYKo5mDDRb7WngVuuIn6k/q2E8GFLZ33CY8hEqEIoXr2
 QZMXGezEws6sQ==
Date: Thu, 8 Aug 2024 17:48:41 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Dhruva Gole <d-gole@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>,
 u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>,
 c-shilwant@ti.com, m-chawdhry@ti.com, vigneshr@ti.com,
 Robert Nelson <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, t.remmet@phytec.de,
 mkorpershoek@baylibre.com, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V8 2/7] doc: ti: k3: Add TIFS Stub documentation
Message-ID: <20240808154841.GA354629@francesco-nb>
References: <20240805142937.443737-1-d-gole@ti.com>
 <20240805142937.443737-3-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805142937.443737-3-d-gole@ti.com>
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

On Mon, Aug 05, 2024 at 07:59:32PM +0530, Dhruva Gole wrote:
> * Add documentation to briefly explain the role of TIFS Stub in relevant
>   K3 SoC's.
> * Shed light on why TIFS Stub isn't package with the DM firmware itself.
> * Modify the platform docs wherever the TIFS Stub documentation applies.
> * Also, refactor and add a few new labels to help split the firmware
>   documentation chunks. This will make it easier to include them one by
>   one wherever applicable
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dhruva Gole <d-gole@ti.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # verdin-am62

