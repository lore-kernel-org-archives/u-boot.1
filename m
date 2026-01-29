Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D09D73EA9
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 23:57:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA178414E;
	Fri, 30 Jan 2026 00:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P2e/D36l";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n/JAZpPJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4478413A; Fri, 30 Jan 2026 00:57:01 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 447C98413A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 00:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f2GJn6S2vz9tyL;
 Fri, 30 Jan 2026 00:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769731017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Oe6Qgsuhk74cRkWKJNOlLr3iUIb/yToXZwmrDf6fsUI=;
 b=P2e/D36loes0enG6AfyT0Vf+0vgfNrhGkjMSG28unwAWftW1v4fcfoeZn2UIb5ofZQlGnx
 Kn7yJr0AsVxCeTj99Hj0veMv1P8HEJDI/P+TOdfogeErcHBtyZQLeRiI7bdTghqC9msbmI
 T6mAC+aj832fR17CPmdS/wAxgpgem8N0OJUl8KGPQJjfFQ3SNqVQLwKth0OrVKg4z735u4
 6YaSo4DV5//aXcE8kcufzbizi7e2IrFPAn55VjAde5Y80C/KpQL6KmU3gSURQ4YtZtcVtF
 wv2ilFASEBAPzg9c1pxxrLWx3oNXPVfmClzRvJBcl+iq4tOhsQpetW+pTudakQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="n/JAZpPJ";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769731015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Oe6Qgsuhk74cRkWKJNOlLr3iUIb/yToXZwmrDf6fsUI=;
 b=n/JAZpPJ/up2sZnaIO3mujwig2KXSKtrKSEBzpPQxcoYMjxy0iZal0ATfnV7ILpAFxusAY
 aAOtxOZkh+DfUTUjzlM5Nxs2dB2e/HtqPqdbcml23rNM2KCEwt4WP2kh6z24wsLT/p8z/P
 NfwVWKySYj32QwspuqapyJKamhRMUr56LiUoTIyFqjuBl5rtr41L7Q5Kk8OXe9gCY7YoCL
 S1X3d9cCztNFOW38Te4c/iV/f9u7rGFT98uzjawz7ZqSrEieW38o54JV19zojQ/2zGzz8R
 yz44XAE0KtZkDGgAFgzxqC1dfIdX8BGHiAVlce6h4TNfqpE94yUmnvAcYMi75g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v2 0/2] test: cmd: Add test for zip/unzip/gzwrite commands
Date: Fri, 30 Jan 2026 00:55:51 +0100
Message-ID: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 40b0ea2f3d86050da3e
X-MBO-RS-META: ez1388i8iwj31k41xhoiseeswdqtypeg
X-Rspamd-Queue-Id: 4f2GJn6S2vz9tyL
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

Enable zip command in sandbox so it is always build tested.
Add simple test for zip/unzip/gzwrite commands so they are
unit tested.

DEPENDS:
https://patchwork.ozlabs.org/project/uboot/patch/20260128194049.278542-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20260128194117.278566-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20260128194152.278586-1-marek.vasut+renesas@mailbox.org/
https://patchwork.ozlabs.org/project/uboot/patch/20260128194226.278605-1-marek.vasut+renesas@mailbox.org/

Marek Vasut (2):
  configs: sandbox: Enable zip command
  test: cmd: Add test for zip/unzip/gzwrite commands

 arch/sandbox/dts/test.dts   |   7 ++
 common/Kconfig              |   2 +-
 configs/sandbox64_defconfig |   1 +
 configs/sandbox_defconfig   |   1 +
 test/cmd/Makefile           |   4 ++
 test/cmd/unzip.c            | 123 ++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py    |   6 ++
 7 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 test/cmd/unzip.c

---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de

-- 
2.51.0

