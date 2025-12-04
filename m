Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28478D2A55F
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 21:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D14C8394E;
	Thu,  4 Dec 2025 22:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="IUbSSdPI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC9A839E8; Thu,  4 Dec 2025 22:50:57 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8097283942
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 22:50:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id B53FB1F967;
 Thu,  4 Dec 2025 22:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1764885048;
 bh=R7MC5rScK8yyrVM+GizKcPP0s1tOTuNKpifColxv/f4=; h=From:To:Subject;
 b=IUbSSdPI5YTL7B2T/6uMDI5QUlOV0zxbjpxI8+3SBSzyDu3hXwlZnl1bYvCK9F7Jd
 AJXvAaqN2qz5St7BXyIH8TRW8EMe9ppMviEZ2uaHoGNNH9A9rEILH4s8DUE6w+qU/h
 xWoj6ftcqJhIPGEMrAj1VxjTEDoyWGJkhibfIfVLf2XAUEJH9p2zH/usn22qCltf9x
 NtdkICeE8d+D5Mwp+G3K8c3IotqQ/PTU4tZsQY1EoDiXN9M1v/lpO3lhc20MBW2xov
 ECyFY1p+zLMRoFsinPmBjxvfQ3mBcjfoltLlDYFDMGTPuF3sZq+qeRTCfXJUqLKvQa
 /J5/F4ugR9Opw==
Date: Thu, 4 Dec 2025 22:50:44 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: toradex: add aquila am69 support
Message-ID: <20251204215044.GA13173@francesco-nb>
References: <20251107082427.7480-1-francesco@dolcini.it>
 <20251204214115.GF303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204214115.GF303283@bill-the-cat>
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

On Thu, Dec 04, 2025 at 03:41:15PM -0600, Tom Rini wrote:
> On Fri, Nov 07, 2025 at 08:24:26AM +0000, Francesco Dolcini wrote:
> 
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > Add initial support for the Toradex Aquila AM69 module.
> > 
> > The Aquila AM69 SoM is based on the TI AM69 SoC from the Jacinto 7
> > family and is designed for high-end embedded computing, featuring up to
> > 32GB of LPDDR4 and 256GB eMMC storage, extensive multimedia support (3x
> > Quad CSI, 2x Quad DSI, DisplayPort, 5x Audio I2S/TDM), six Ethernet
> > interfaces (1x 1G, 4x 2.5G SGMII, 1x 10G), USB 3.2 Host/DRD support, and
> > a Wi-Fi 7/BT 5.3 module, alongside an RX8130 RTC, I2C EEPROM and
> > Temperature Sensor, and optional TPM 2.0 module.
> > 
> > Link: https://www.toradex.com/computer-on-modules/aquila-arm-family/ti-am69
> > Link: https://www.toradex.com/products/carrier-board/aquila-development-board-kit
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > Co-developed-by: Parth Pancholi <parth.pancholi@toradex.com>
> > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > Co-developed-by: Franz Schnyder <franz.schnyder@toradex.com>
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> While I am glad to see docs in the initial patch, please fix:
> https://source.denx.de/u-boot/u-boot/-/jobs/1323274#L236
> as those lead to CI failing, thanks.

Annoying. I was aware of the doc warning, and I ignored it because it's
a copy/paste of the logs output and I would have expected this to be
taken verbatim.

How can I fix it? The block starts with

```
Output:

.. code-block:: console

```

and after it should just be taken as it is, without trying to parse it.

Or I can just remove the log from the .rst file.

Francesco
