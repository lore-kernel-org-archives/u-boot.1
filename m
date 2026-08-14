Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D86FC5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 17:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C605640CE3;
	Fri, 14 Aug 2026 17:07:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PvWgJ0swASIx; Fri, 14 Aug 2026 17:07:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 616C540C3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786727269;
	bh=YB6HcVp4lkFywFqVQIL7b6OsV+USUzaDxWSaFKCjomU=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=0A538DihVRUdzvcAgjitjgZF4K1Z0CLkdhgExNFq4HGcyX7r12InswtYx8Dg9KjGL
	 a1TwxaUCU6roIxlAXPB1ZxgySnrEwgp74XXpXjpttCFKfysNR1S0hb4Ljld5+eOMWu
	 3Tlkna/uXh0XtawGgQWpGOSAL0pbYwnyCWiHzYKpsY9B511iqfDJfAF7MlRrMtDYfc
	 ypcgSZypd3EiwM0/ZTwAsLfxRtU6norgBnvUFB+g6tLFk5cq0PfHPqZu3QpjfF1t0N
	 7jM4nmWzOBOkExyIiFHMOOriHIgD1NR4J/eyNpwLuiofNJvBMnp/nTlfbWlmMwFBvf
	 MUvUQI4sIWqfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 616C540C3C;
	Fri, 14 Aug 2026 17:07:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F009D139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5DDD6080C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rBIzqirxYlql for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 17:07:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 08DED60671
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08DED60671
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08DED60671
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 17:07:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 8C2E14E41233;
 Fri, 14 Aug 2026 17:07:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5F8BB6046D;
 Fri, 14 Aug 2026 17:07:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 076D011C4EF24; 
 Fri, 14 Aug 2026 19:07:32 +0200 (CEST)
Subject: [PATCH 0/5] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
Date: Fri, 14 Aug 2026 19:07:09 +0200
Message-Id: <20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBG4avIrA0YFau9irjoxN92BE3JaBHEu
 xvt8lu8t5MiCJSeyU4BP1Hxc4RNE3Kf1/yGkT6a8iyvstqWRqatKYzCrQHs/WK4sSUeXDnmgWL
 2DRhku5dt97euPMIt14eO4wSs9EzgdAAAAA==
X-Change-ID: 20260814-imx93-secureboot-b914e7b6cbbf
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Denis Mukhin <dmukhin@ford.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex.vasut@mailbox.org>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1876;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=AV559eXKesam3h3gEtkJWNEaRzNcBwTKbXAZb4Jk8zc=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqf0tUHdY5xvdy/aepcYt4c5UhyXRhjJU8B1LR+
 pbOSwVbMgGJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCan9LVAAKCRArAF6gG1qP
 AwQ9D/45i8Q0wjzmwezKDH7XenB73Ylo6/Y6aZyF6+uMLFO62xGRbS/65x6DfFLNMxnWofF/ViZ
 S8gZpfr2x6qF/O3Lnz8yFQ2Er+FZMb3qEBsFL3zKKvy7Xbr81EKVDEe9426h5V7sbKRWVOINslC
 tCcitXhBjGBwybQLW3n1rHDUAjjSj2oTc+6AKkxCWQgt18+Pg3xzpasmKCyxncG+YpUYiq+bNlA
 aVCK+UwOmxubtJAjxN9QN28VjdwV+7OmwsYhRn6ARrqJ1jZ0WBh9rqGdBzt0VfXuEqbEBZl8kKb
 bQ+SwJ5bZ8BcD53nK3MOY16oI4h1a5jLY6euhHTqylvO9w0Q0MQi4MdHyGrOTchbWOHzcNu3Y2h
 cKSwqak25V0PRhksq+ajngTGSicqv+HH0OBfr3hY9e8Rup+rGYs4dzF/DUIwNO+R0UDhYYpkX5Z
 LqtrXkTjiNMXmOiSZyOu+8xnGR5FlC/UUWAn1/Uti/1igeVHgvvdKT7vSEDXVbChxmesqregazA
 qhZPDEeotzI6fYmb0YU/MgKFPmona293egS+Y3gO6niJtd2gqaPLuvysMTXlRDRvwUYYQiTEwIh
 Hohm2coFXghezeq4SZa0JeoR+d2WKhLdBKIT0ANq7hvvfz2ql+RDIA+21fhEM73s/CN9elU7GBy
 bQl23JLQk/Y1kXQ==
X-Developer-Key: i=jeremie.dautheribes@bootlin.com; a=openpgp;
 fpr=FB14AD9086DBB842904804092B005EA01B5A8F03
X-Last-TLS-Session-Version: TLSv1.3
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
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29_via_U-Bo?=
 =?utf-8?q?ot?= <u-boot@lists.u-boot-project.org>
Reply-To: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hello,

This series adds support for signing i.MX93 images by leveraging binman 
and CST, the NXP tool used for secure boot. This introduces a new binman 
entry type (etype) for this purpose.

The implementation is largely derived from the existing i.MX8M support, 
since the two share much of the same signing infrastructure.

This procedure has been tested on the imx93-evk board, using both ECDSA 
and RSA-PSS keys.

Patch 1: introduces the new etype
Patch 2: updates the imx93-u-boot.dtsi description to include the new 
signing nodes
Patches 3-4: documentation
Patch 5: adds test coverage

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
Jérémie Dautheribes (Schneider Electric) (5):
      tools: binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
      imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
      doc: imx: ahab: add AHAB introduction
      doc: imx: ahab: add i.MX93 secure boot guide
      binman: test: add code coverage for nxp_imx93cst etype

 .gitignore                                         |   2 +
 arch/arm/dts/imx93-u-boot.dtsi                     |  54 ++-
 doc/imx/ahab/guides/mx93_secure_boot.txt           | 269 +++++++++++++
 doc/imx/ahab/introduction_ahab.txt                 | 445 +++++++++++++++++++++
 tools/binman/etype/nxp_imx93cst.py                 | 143 +++++++
 tools/binman/ftest.py                              |  78 ++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         |  18 +
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts |  24 ++
 8 files changed, 1014 insertions(+), 19 deletions(-)
---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
change-id: 20260814-imx93-secureboot-b914e7b6cbbf

Best regards,
--  
Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

