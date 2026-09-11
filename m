Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BAAC88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 16:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 189F7606C5;
	Fri, 11 Sep 2026 16:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XOA2UCvakiQR; Fri, 11 Sep 2026 16:44:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BF2E9606E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789145039;
	b=ON10Fy9I6gh7bicElzhAaHRspa8/0DlMRJmIhbLk4x1vlAuArhM+s0PseHOmlVoyck05
	 S78R4wEqIJkF9jskUnBe9ZYMApfUYHhPgXw9uNtb9s5Mf0TzhPQ8TuHSZ2/kAXp1PDr5n
	 K5WT2xWm7eIxlqGRFjqXMX/RMTXgNt+ma+V7swkd5iOxmvIZzUqQQlR/yvlhB8yYaiW1k
	 3+xLil736zaLAKrTcQQDKcKauK/3FuGNcY2bER2hVkOJ6+WXGcmfFKg9MjvunkmLN8293
	 XrkVGXLG99lwQzl1I8h+Gdece1gYBKpHQMVa2BpqH4mNdnmLcEoBpCA1muMK3YJgZ6g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789145039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cmBLV4qHiqZgkiS+a+2D/1rKKBOGxYKBWgvVTTes8Uk=;
	b=RvtDXizhK0yRLYgwid+c8aijwDOLpBlKXjBty+AKJpgU2WfNCiHeAyCNVNvCavhKqOdv
	 colFXa4MLr2mMC1zS9rjMgN4WF0qowzFOwI0M8IsqAXFhoauxme6Y4gPafilZ6UE/kLWQ
	 HBVw+8eZw5OLvXLUo2l4oNth7fZ1FufMhp5wupKl3zCDZ8mGbEENZGj516EP6afSiDMyp
	 vbPnXhVsEnG57vaFijFJ2wcI/kFeMTOEf52Qyb6/EtGFIZw47eM/uQGFeCWqSDmQymlQy
	 +/pCKaSYmRKOllUTaFhJn+ebo56gGE6BWVDPQUt3DXfFunKa0RuubhhaUybY5ZtMgAQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789145039;
	bh=cmBLV4qHiqZgkiS+a+2D/1rKKBOGxYKBWgvVTTes8Uk=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uSdeu24urY3c0+ZEETHE11XuZRQNVdK03gaqRhBFzPilBL7z1h4WiV5XzNH/Q2gko
	 7ZCO3cqNVwanrZZKIcN1f4GP75GDUf9csEShlGtZCWlFua3/2D4KE5ifZLhibJX7fL
	 1PMulV+dZ+t32oWdHmg6ixRRUutEmBnrxN4beZI2Pj073ohw3+XNZrhQ6VeiqCXhDd
	 NfQ7dr5VXDCUiWttFIm5oEz3RT81DQEEFq3kCB4YfNDWycCC+pg6a22kCtU2cCv6jF
	 ze8fOSgzscmrlo9JHLSQL6q3+yo4wtOAvDg3OP0uHBU+YNRZNIfPOrLuaV/OWm/Xxb
	 YsDDo0bW1QyVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF2E9606E8;
	Fri, 11 Sep 2026 16:43:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6489CD5D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4ABE240177
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Py5GBMxyw9xe for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 16:43:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 41BF94024D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789145031;
 b=BDy9PYoBCj5CCbd9rgcTyJXb4GVtxBOuRIKgvMwr9RlwEegXekGZKXOfXHBpFmjQmrLY
 m1aBE2is+M1LXCGAfrUdqOXhFKUBni9/qUlV2L7T61lg7SqAHGxm5RRy54HS7TXc358L1
 drmGY3j/ROclNR5GkbJh1//KlN5F5rwUIoB6Wp+9MUn//DTQ/LimF540vdw4dXD9Gn3bR
 MZ+OHRemMHrc1kVajN+BS8flxfvj+VHVtjAPbQO6GtiwA/rwL5xo0HsFR0jfOgF/CDtkz
 wQpAglDsNktFeISpMtRROa79/bkbCJj7XdYl1rhF1HXoXADJQlD1R2o7uu+8zEV65lA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789145031;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Last-TLS-Session-Version;
 bh=cmBLV4qHiqZgkiS+a+2D/1rKKBOGxYKBWgvVTTes8Uk=;
 b=J6Wv0ZiN0sNhNcDTiKMforC0bRh/0D94aXXHH0qnu9uvWHhsKlBMsZyHUJLyi/AZ/5BM
 fKbNOE9tARsGLTuXyDfi57FPxiqnKbpdSXcy2LtxxdQUdRmcKYIeMWYQoqwAxVRKvblyF
 RDekigslSnZs64VjKe6OcQy/94Iur8WU9JStRZKHITuRrjsQXBM2+G6fyNoaMES5OTgWF
 2sufgK5AJCey5ebjSor0qTwZMjQ/DBOIn2uIeGg4f7LK7WIRAmLuDAIExdq+P6Bg7p36c
 5DhUlInSLoDqrTf/6Vcwmj+e7Jn1wNPWKl2EomXmKGRv0K4YvgRLzR7dmZBzWRdBsNQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ctS785vH; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ctS785vH
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41BF94024D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 16:43:50 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 01BF8C63A0D;
 Fri, 11 Sep 2026 16:36:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E893B601A3;
 Fri, 11 Sep 2026 16:36:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 92B7C11C7A9DC; 
 Fri, 11 Sep 2026 18:35:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789144558; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=cmBLV4qHiqZgkiS+a+2D/1rKKBOGxYKBWgvVTTes8Uk=;
 b=ctS785vH7lltbGMmyxAYsAYOoD6cL5ILw6UWR0MyzRJr+MAvbSxDMZd83MBwDBLdFFCXCy
 mxml2axLYCpFqXyOsJLzeyqa3lxokBCfu+hN5c4pH8SQRZ23AoNUX1UMpTgom4Nji64UXI
 UkvRUwA7uGs49ZvvFeyF/FuncIBcV828OMpEcWdY7No6IAJSVfINCXk10hjTipkcuSw03/
 x40QGs81+A/RTMB9NUh4LCFtue9kTI57BUaNstlJGS374TXR0iTYwmt/HdTx+mxHAkQGoJ
 m1m2Bke03X6JAN2uoAbJoUTb2z1ZoViYHzqOa8xIGNZGMT5RJZ/P3h0RFqiadw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v3 0/7] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
Date: Fri, 11 Sep 2026 18:35:03 +0200
Message-Id: <20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ6CMBAF0KuQrq0ZWqDUlfcwLmgZpEapaaHBE
 O5uiwtjYlz+yZ/3F+LRGfTkkC3EYTDe2CEGvsuI7pvhgtS0MRMGrII6L6i5z5JTj3pyqKwdqZJ
 5gUJVWqmOxLeHw87MG3k6v7Of1BX1mJzU6I0frXtumyFPvT98yClQ0FyLGhi0wI/pfDPDXts7S
 QOBfQgJ7AfBIlHKQijJmhIE+ybWdX0BVTDZDAcBAAA=
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
 Christophe Guerreiro <christophe.guerreiro@non.se.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4067;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=unP9MCg2Z6sO89edT+MKSxJjkCeO5fzASZ0MazxQac4=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqpC3emPwUfanUoYj//rq01/41BF4Yz219MXdUE
 5/bBnzovryJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCaqQt3gAKCRArAF6gG1qP
 A4/6D/43d2HzC6ttLPRfGL4xNpEVJnMHTZ12L4T5sxnWxQIKZ8tjDaCKBT2jv2EbOV804wcPwcV
 TfWzp/6wQhV/LQRj5mBkFSqpAgTcQoMNjJL3zuDztywsxUWILo0D2gmG2SS7plmPt2tsA0mG+Mc
 7iiiPjfoScsCMjooAqhFtTV1X62Yar6VVky94Gm6UTHl1F+JKd8OH/n8V1Q+BEewEVWV1ohb7sr
 CmandYFBNqsKdDgU9R/7bwNJrl1o5gbMfBmts24vwOpBV/4MFnelFmvDI0FDfcNudo6fXIUW5+Z
 CWaZ4Die2o9k+LQFRbR+O/8N4/cBQNt8/jSObS8AFhnxPokQ9WyJcwk5ckAl2mtiWtPAJKjwfvB
 azIV6fF2yQJsT3Ske7gozjriZ+JF2fW4ylEEgs2BRqufmbTCq0rTwPbaz5wDdjXZ0kAIrfK+P8a
 4Ovco/7vjQxLxbDy1cnJ5YBSHkGA+15H0zy5+mT06Tko+3WecFyIhRI7WX56muhsrmZKowdBQ5E
 6iG0cvPBf3TIVHhP29fKSDFSU9gPawhXNpMXglAVGc6rJiksBKwm3WMOurBHYFpT7lyA2xe5A/A
 fIGqQi1W8/R/5QgqpH5D2NM6DRPHxd+Cn/Avw5GvDoPCaYvFGXU9zJNgsJ6j3r3M+LAhKklU7Rk
 wknwlC5LI/z8Zjg==
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
Changes in v3:
- doc: removed *.txt files wrongly introduced in the previous series
- doc: fixed some inconsistencies between what the doc states and CST 
  v4.0.1
- doc: fixed broken bootflow diagrams

- Link to v2: https://patch.msgid.link/20260902-imx93-secureboot-v2-0-5947b92a5072@bootlin.com

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
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>

---
Jérémie Dautheribes (Schneider Electric) (7):
      binman: add nxp_imxcst base etype for i.MX CST signing
      binman: nxp_imx8mcst: use the nxp_imxcst base etype
      binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
      imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
      doc: imx: ahab: add AHAB introduction
      doc: imx: ahab: add i.MX93 secure boot guide
      binman: test: add code coverage for nxp_imx93cst etype

 .gitignore                                         |   2 +
 arch/arm/dts/imx93-u-boot.dtsi                     |  54 ++-
 doc/board/nxp/index.rst                            |   2 +
 doc/imx/ahab/guides/mx93_secure_boot.rst           | 294 +++++++++++++
 doc/imx/ahab/introduction_ahab.rst                 | 460 +++++++++++++++++++++
 doc/imx/index.rst                                  |  14 +
 tools/binman/etype/nxp_imx8mcst.py                 |  60 +--
 tools/binman/etype/nxp_imx93cst.py                 | 112 +++++
 tools/binman/etype/nxp_imxcst.py                   | 121 ++++++
 tools/binman/ftest.py                              |  85 ++++
 tools/binman/test/vendor/nxp_imx93_csf.dts         |  18 +
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts |  24 ++
 12 files changed, 1177 insertions(+), 69 deletions(-)
---
base-commit: 4a4bcb0ada8d43390e2819e62f4baee723631f5d
change-id: 20260814-imx93-secureboot-b914e7b6cbbf

Best regards,
--  
Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

