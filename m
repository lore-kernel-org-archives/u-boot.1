Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7665BC624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD9FA40863;
	Wed,  2 Sep 2026 13:41:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mhBfkxHoKsB0; Wed,  2 Sep 2026 13:41:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788356513;
	bh=ktzjfN+mZOEAFEOywCqhorxHn890pGKfcirJftWV4zk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=krwdJsAgK0onGFqw6csEO+IQtGwC6hzFKrXMPRGOfgW/nvg6RMMfWJlVtvI2Ccva9
	 au4mLU8HhlLrM490FSBzTU9f3djmAnP42UHYzCeFAWMzxDYeUtagD0R23/78WupLX+
	 yDYcQD8ngso+t6FbHtBphF/8RTtRNDMrM/9+1OmNv61KheONLLVs8i0qsGHqBuaugG
	 mbNkf0WTnsOKQGzE9GF8fLZTyUD2e4TGHZefTzo4LKXO+6Zcb2koCYQ6ESL/NaummG
	 a/BTTvl9y4UPx+bMm6A9dCANiDSBXCo+tG69upV7zX+Gn30IGUDGGoxTyb1ZNyXw1Y
	 VSMGa9p9WndnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E598440834;
	Wed,  2 Sep 2026 13:41:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DE550230
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFDAD80EB4
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZA7CNBmVFcjB for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:41:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=BXXU+bWc
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9653A8098C
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:41:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4AC151A194E;
 Wed,  2 Sep 2026 13:41:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 145E06053C;
 Wed,  2 Sep 2026 13:41:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 73AD411C792E0; 
 Wed,  2 Sep 2026 15:41:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1788356506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=ktzjfN+mZOEAFEOywCqhorxHn890pGKfcirJftWV4zk=;
 b=BXXU+bWcZgBg3XcTrsyHQmSjdBAc8cMESWVWZABf7v2qJqKjtRZIgjAJ3LkInu/0OigyKp
 6Qqn22kEDqdojAh/Wo/554qR6bCx3VSEu7FX/L000JWfE2xDSQH3qIvv5hSPVFnp63VMug
 98GwAs06tSVrcNKAazsmheduoF7PQ9rafIpSXTRDV16x+2THtzlAwhDUYxomT2+EKO07j3
 apx+WzB2oblm38/KXO/AbcjzTN2fy3nzsYU+hfrlt3EjPqn8SY6hsyl6W5qycbl4FTDIwn
 MyLwXx4SsUzI3TJNb7aoAIq5BNP/5/Rs9umoahPENcbTudpI4eHogWsqxUB3JA==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v2 0/7] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
Date: Wed, 02 Sep 2026 15:41:27 +0200
Message-Id: <20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2ZptIfx48j0MB7ssskaoaYFgC
 O8uxbvHbzLzzQqBvXCAS7KC51mCuGEHc0qAuvvwYCXNzmDQ5FjqTEm/VKkKTJNn69yobKUzLmx
 O1rawz96eW1kO5a3+cZjsk2mMntjoJIzOf47PWcfeH/2sFSqklIoSDTaYXmP8kuFMrod627YvZ
 CDzqcQAAAA=
X-Change-ID: 20260814-imx93-secureboot-b914e7b6cbbf
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Simona Toaca <simona.toaca@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Christophe Guerreiro <christophe.guerreiro@non.se.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3864;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=xZ+lrd9+oWuHXLytFMa+AdiAUcUVkFHzNaS9Jq2Bvrc=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqmCeU39nVS+/Pfebv1MJ8ybwddwsLUgNPpPbV9
 0UXJY+oViKJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCapgnlAAKCRArAF6gG1qP
 A/J7D/9MWk72hAv2/P3Cl9cBePC7Pq35ABstogeOtbToVh2kQUxF69YHcJVDURomGV6r5P9zGFX
 D9cVg4gSNxoDCBoBe5x5rH3/CzTMfgOwsFcL+R+DE2/FuSS62s9GXcTieuuRioA5LApiv/MWUhR
 d4u30PNBF8066K3JCNeY+uJE+N5uAQuyn7ICV3Jhs6zfUDoOr4T862d6d6GG22RUdbpMGjkA/9x
 n/B9nk6jR+auKIyAY9tJ5s4d4XKgBe2ehtFZZqqHodJIDpghEhOdRoVWBUE11HtXELu1ZG5vDP1
 MawPl/i1DBb59ybsdfF42h0/gyBNjfhE85g6tUzKlNtXW5SiWLr67H+o2jIDy3dPRPH//QC6enF
 k6T0nnlqwESvimsMEOKyXFUqHpQGLoVzRttK2XQFDEfwl7ZT89FPgQebFT2JTdprgYW4oRNNhzw
 arb2ROY1RxvQHoceBxYu6f2Uesp74kVquLu8z6LgKH0FlH0f+CEBiu4mN4zH9654CYQAN+bN3hu
 b0SJ5z9c7llcgbqyXS0sVbXN+WQer30k3e72F8JzT1bwzqSi+R1dZ1i62YRcJrOzgQQRY0yD++p
 y536Rv+3UGfJgUlp6NqZvwDK8SdtFjSm2/0HW1ziYfWhzwH5+qFfNy21lj+/7O/NhrUpQwREzNK
 rNFG6j7YnwTO5DA==
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello,

This series adds support for signing i.MX93 images by leveraging binman 
and CST, the NXP tool used for secure boot. This introduces a new binman 
entry type (etype) for this purpose.

As the implementation is largely similar to the existing i.MX8M support, 
this series also introduce a new common nxp_imxcst etype to share the 
common functionnalities.

This procedure has been tested on the imx93-evk board, using both ECDSA 
and RSA-PSS keys.

Patches 1-2: introduces the new common etype and convert the imx8cst one
Patch 3: introduce the new nxp_imx93cst etype
Patch 4: updates the imx93-u-boot.dtsi description to include the new 
signing nodes
Patches 5-6: documentation
Patch 7: adds test coverage

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
Changes in v2:
- Following Simong Glass' feedback:
    - Created a new common class shared between the nxp_imx8mcst and the
    nxp_imx93cst etypes
    - rewrote the doc in reStructuredText and mention binman instead of 
    imx-mkimage
    - took into account the other minor suggestions
- Link to v1: https://patch.msgid.link/20260814-imx93-secureboot-v1-0-0c3c78020d03@bootlin.com

To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Miquèl Raynal <miquel.raynal@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Stefano Babic <sbabic@nabladev.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: "Jérémie Dautheribes (Schneider Electric)" <jeremie.dautheribes@bootlin.com>
Cc: Marek Vasut <marex@nabladev.com>
Cc: Denis Mukhin <dmukhin@ford.com>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Krzysztof Drobiński <krzysztof@kd-solutions.pl>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Simona Toaca <simona.toaca@nxp.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Christophe Guerreiro <christophe.guerreiro@non.se.com>

---
Jérémie Dautheribes (Schneider Electric) (7):
      binman: add nxp_imxcst base etype for i.MX CST signing
      binman: nxp_imx8mcst: use the nxp_imxcst base etype
      tools: binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
      imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
      doc: imx: ahab: add AHAB introduction
      doc: imx: ahab: add i.MX93 secure boot guide
      binman: test: add code coverage for nxp_imx93cst etype

 .gitignore                                         |   2 +
 arch/arm/dts/imx93-u-boot.dtsi                     |  54 ++-
 doc/board/nxp/index.rst                            |   2 +
 doc/imx/ahab/guides/mx93_secure_boot.rst           | 294 +++++++++++++
 doc/imx/ahab/guides/mx93_secure_boot.txt           | 269 ++++++++++++
 doc/imx/ahab/introduction_ahab.rst                 | 465 +++++++++++++++++++++
 doc/imx/ahab/introduction_ahab.txt                 | 445 ++++++++++++++++++++
 doc/imx/index.rst                                  |  14 +
 tools/binman/etype/nxp_imx8mcst.py                 |  60 +--
 tools/binman/etype/nxp_imx93cst.py                 | 112 +++++
 tools/binman/etype/nxp_imxcst.py                   | 121 ++++++
 tools/binman/ftest.py                              |  85 ++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         |  18 +
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts |  24 ++
 14 files changed, 1896 insertions(+), 69 deletions(-)
---
base-commit: 4a4bcb0ada8d43390e2819e62f4baee723631f5d
change-id: 20260814-imx93-secureboot-b914e7b6cbbf

Best regards,
--  
Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

