Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3098CC3DA49
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 00:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8C987D87;
	Mon, 15 Jul 2024 02:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="Zyt3Y+ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B9987CFE; Mon, 15 Jul 2024 02:17:51 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bd])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D363C87D87
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=contact@jookia.org
X-Envelope-To: u-boot@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1721002668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=aI06//VwC3H6ZariQ8POkJOjrGgPkon1pRW2ZWokH6c=;
 b=Zyt3Y+gaF7+t/ebl8IQkGfRBAZ0ZCchiSXL2aN5V5Mw0MiXp8Cs1LVmBCfn32Y1yKqxTuS
 StqBMVBZXWZUTP+kBx6rIjwUfLyJgU2WSTC1meVrff5P1VT5csulIFFq0Cyd5XyMA0h6d+
 dq37V/KAr1k+dX2YHhr1TzCn6jJ5ne+8GqwYv8/evgkiEDISFqYTMFg/YgXIyLMFpNAU2Z
 yaH5SGHVaU65OU39RPO863lCKbUoWFXjLNPQJUUTx66YOKkMxMLou3HtINTMt00LhiBS2r
 fdEkCeeXnJwqxEtonpkcXB57A1/L6QdVUAJ5PlAUiC5Kn1JigA99RDUSVheoIg==
Date: Mon, 15 Jul 2024 10:17:30 +1000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: u-boot@lists.denx.de
Subject: Orphaning my patches
Message-ID: <ZpRqmp9-lq3q--PD@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
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

Hi there,

I'm orpahning all the pending patches I've submitted to this project. If you
have them in your patch queue, please disregard them.

Full list:
- boot: Pass baud rate to stdout https://lore.kernel.org/r/20240411-stdout-v1-1-66ebe5bb152f@jookia.org
- pwm: sunxi: Add support Allwinner D1 PWM https://lore.kernel.org/r/20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org
- spi: Various Kconfig fixes https://lore.kernel.org/r/20240427-spikconfig-v1-0-8a54772522f4@jookia.org
- sunxi: Support UART1 and UART2 on the T113 https://lore.kernel.org/r/20240411-t113serial-v1-0-41ff858a1235@jookia.org
- sunxi: video: Fix lcdc polarity display flags https://lore.kernel.org/r/20240614-sunxipolarities-v1-0-15bbbf57dfff@jookia.org
- sunxi: video: Support driver model LCDs https://lore.kernel.org/r/20240614-sunxi_lcd-v1-1-1dc9257b0112@jookia.org
- sunxi: video: Support LCD and HDMI output on H6/D1 https://lore.kernel.org/r/20240420-d1_de2-v1-0-297efca674ba@jookia.org
- Support SPI NAND booting on the T113 https://lore.kernel.org/r/20240411-spinand-v1-0-62d31bb188e8@jookia.org
- video: add support for MIPI DBI interface https://lore.kernel.org/r/20240614-mipi_dbi-v1-0-946eb82f8533@jookia.org
- video: Add support for NewVision NV3052C SPI panels https://lore.kernel.org/r/20240614-panel_nv3052c-v1-1-4d94f7abde6a@jookia.org

John.
