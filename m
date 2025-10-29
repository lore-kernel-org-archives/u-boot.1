Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35676CCD1BF
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 01:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B24F82A9E;
	Wed, 29 Oct 2025 02:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V6wOpswc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OO0ANaaJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6496C8352B; Wed, 29 Oct 2025 02:31:33 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4302680422
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 02:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+usb@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cx8pq0LmFz9tN2;
 Wed, 29 Oct 2025 02:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761701491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LPZ3550ElmmmvhcrrQpSl3WbjmntePtgHwPPwdDNLik=;
 b=V6wOpswc7lu/VdwKEYRwtHFwW2ESwaNtBpoPnSSq2PB9qKrL2DC+04fxKgCd46664FcyVW
 C/k2+JoX/ZW/whIsquU46HWrf3H3f2i0EUpj7Gm7G5qrJmN/YWXQFXT8mF6i94JBDuK1Cq
 JixkvWQmU1i9uAu9ckXl2KvkODLdnenVaT+CzQnnrRQPTY/jaDAbr9O+bEUKiCdzKT+UFD
 UeoKpmhvM+wuG9z/E1u1eF8EssxGgf05HaCOeyNqadTIl9JGA2b4pg9l2zXoOSNs1MZ5nC
 mNAOZ5/IyxY/ujVkrkNiW3LtDXuoET/wADcpvWl/0ytfyZ/DsUCv5uNsY8+ANg==
From: Marek Vasut <marek.vasut+usb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761701489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LPZ3550ElmmmvhcrrQpSl3WbjmntePtgHwPPwdDNLik=;
 b=OO0ANaaJ3bqX5qGL2eB0ygSkTXn3+hwMDqqszB4aG+qrKw3+pELVxCRTIH7sLCWEUEj8rc
 inueJTABBn6Ch6dL6uKcansWml3ij2vNOjOXwn1c8JWs76wKiirUdX4lZ207RS72Agp+Dc
 rjaHsC7tXLVXXq6uuz2kZFH18MgTa7tIkUCalXmJ95ykkrsga0xI1BJQjPkzyMqei99zvF
 Bw/Sv3x5jxPkR5TGl6C/Cc+QsOezKKvbcmCcOVmeP0rkL9TqNw7Y3M8TJEO/hQZwH/Smqu
 2aQ7FfPOH8FBLOeoKxS2WChKSbK6z6ut6p/eQDKjejzmyTkLTxOFECE9Dyo6nA==
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PULL] u-boot-usb/master
Date: Wed, 29 Oct 2025 02:30:47 +0100
Message-ID: <20251029013114.113745-1-marek.vasut+usb@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 763dm39fktnb6kkjxpf1xyh9jubdrdq6
X-MBO-RS-ID: 0945aeba10bf1e74c26
X-Mailman-Approved-At: Wed, 29 Oct 2025 02:42:35 +0100
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

The following changes since commit 23987e10905146def3ab61e55ec912c6e742efdc:

  Prepare v2026.01-rc1 (2025-10-27 16:10:23 -0600)

are available in the Git repository at:

  git://source.denx.de/u-boot-usb.git master

for you to fetch changes up to 41fd18219fb6625171180a21d0e4f17e9b7b5aa2:

  usb: musb-new: Cannot test unsigned member to be negative (2025-10-28 16:35:05 +0100)

----------------------------------------------------------------
Andrew Goodbody (8):
      usb: ehci: exynos: variable node should be signed
      usb: fsl-dt-fixup: Return an error code on error
      usb: ohci-hcd: Null check lurb_priv before dereference
      usb: ulpi: Incorrect operator used
      usb: xhci: exynos: variable node should be signed
      usb: musb-new: Null check before dereference
      usb: musb-new: Limit check array index before use
      usb: musb-new: Cannot test unsigned member to be negative

 drivers/usb/common/fsl-dt-fixup.c      |  2 +-
 drivers/usb/host/ehci-exynos.c         |  3 +--
 drivers/usb/host/ohci-hcd.c            |  6 ++++--
 drivers/usb/host/xhci-exynos5.c        |  3 +--
 drivers/usb/musb-new/am35x.c           |  4 ++--
 drivers/usb/musb-new/musb_gadget_ep0.c |  5 ++++-
 drivers/usb/musb-new/omap2430.c        | 34 +++++++++++++++++++++-------------
 drivers/usb/musb-new/ti-musb.c         | 28 +++++++++++++++++-----------
 drivers/usb/ulpi/ulpi.c                |  2 +-
 9 files changed, 52 insertions(+), 35 deletions(-)
