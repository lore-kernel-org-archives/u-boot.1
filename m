Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88A7CA5FAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 13:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 199F640A1D;
	Wed, 30 Sep 2026 13:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhDtpQ7lN54W; Wed, 30 Sep 2026 13:43:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 15D2C4085A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790775789;
	b=Sg8m+o9L3tw1+eR3jGuDKqxQDpx6Jugx2apGfsY4L1s8RWqLyW6gE+Q8Teb0d1uyEEw+
	 aaIaG2CdJKa1KXxZ4ILjCBsHRhTWRFsYODRsdZbu0o/GI/Q9ni47IBiNUk2kX8ygvEnOK
	 /AYe5sTl3pyNJoSkPGotSfcMz6ndDZQYzrUNwDBtOvZUuAI/rgZuF7YQHPbQQCpWnHs0c
	 7K6hXqAmk73zqKgHWrQgF/lNDPnFzFMBxZXGs2rM27zETtfrWdz4pWEZRDTzRoCpeln+y
	 nLEUIY4/E7YVHeJPDbSLTKxsn6SrLknfjDcAZ0sH1iIWO5zuAPwn1ZFoY9mnH85aLaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790775789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=O1VWjzcCK6bdpsq4UjWXVcPhleQNRlqAPuaWdUpT+28=;
	b=rUOvdgUjXCsnz3jA8qR+bkpm8VcAonCI821UTVDy1FawFnVUsxXmMUStmPHnELU6+5Ut
	 P1lYU3B+e+WAe4spkxhFUP9Z7ZNtadbJqAsrfv3UDhjJ2S0mrPB7ozZsOL+r+TCtnNggp
	 GsGzNl7FGJb+HzR8OH83kn3fwbxEmSSciWk/30DIYYDZ0zdhJM1nsIm+1ND5mMBMhwQyp
	 FoU7gYLI9QamF1XIna830PWP7TCcB5+WWeXeXU3WZc5W5LseaQwKmnxHWO6Wcc6TeaDQs
	 HIIbnlQXuZU1jDIA0r+lpmiDBzGVQzDg7+7e5d/Rv9Posp/Ie5G52IILXcinoLkFolg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790775789;
	bh=O1VWjzcCK6bdpsq4UjWXVcPhleQNRlqAPuaWdUpT+28=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aM25+Yn6mTZbY+SHaagk6KJly0ciDY2E9nVhz7MHR6B72hNjOGvnl/AvjC2iwRB0I
	 GPJVlCCfdObMf1HVlObmb1gDPY2a3SIKEPKPtjw29tpN7oRBnBF04p3SEOr0lbCMFS
	 r68u+q6yn9T0aGuZseuAOiN3FHM+n7Vq4ohHA70p0Hd3QVk3ZKvbkRSIvx1jHSSAMu
	 LVoyHoknfoRsYugcvjR8qFQuuECkGzUtqrWcsCIzabrhYK8U1CnFySnY63KfDFX/ip
	 FOUl0WomsJc37PfqMIxdsTpkKjPIVjAQCRzuiL9pl/3G2MJz7W9jmJPlCKO3sI4u8X
	 K6AFSAZflYvJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15D2C4085A;
	Wed, 30 Sep 2026 13:43:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id ED87D32A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D29E980E15
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ocXi2tUzb6NM for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 13:43:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 63F9A80E00
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790775785;
 b=gSgg8GlPugY6Sw91C+DF90dEZFUdiSneXhBDp/SQ+82i3X2H+T31JJTKwjSdujQhQ9wG
 YjfOZS+V4PdXF8Z7rEYWshRExR+pnSGweqXsONh/5t9ndghb2AyvxBJtN8+sXH5BBUE/t
 WLKAbmnBSwVKCrBpQlBWasSpa3DYQPxXEJtBvIzmvqatSqEGiIpRvmDW1jZhx2CgkdqD8
 h+PViUOkbHoigXp0Get6eYeROueLFnbo2FWKzEu/OiXCYPD6OnVpPm5KKioUAAr4f/Hut
 4pzXytFFdA4pEKKM4BJzZq7LLqyPsZ/ElZ7yOjmqWACNEF0/DDHN8syteWYACLGRTMw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790775785;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Last-TLS-Session-Version;
 bh=O1VWjzcCK6bdpsq4UjWXVcPhleQNRlqAPuaWdUpT+28=;
 b=i+ZX619y95OdcZ38aR1CJ31hHks2AfNoZkSV/5vkWfrOqSnBQ9EM99TFcJ3aNhB77GcU
 ZxPB8F104uptMg/FIjQ4H9u12+ktvugNryX1ck0/nAJOHQIigGTwovjCPW9MZMZt2AcMY
 SNHaeFu77N7fECC57Bp0G4uocbY/zQQVuAQJyaDU0rZ/UcSmZ/Ye8M3aBzUcOf2GAdD4b
 gCuh3KjCjuYzOzD77ACVaRRaT5e0W37p2+++KNts4pFXpY0idcvxVf56OUoOOe6mRKxWg
 fkdnVtqim1EihVkiRhnGXhteax1rMBAd1efL5Mv+Jfcji/5XddFCHnSZ0n96k2TpLlg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ZJ7Qr4HN; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=ZJ7Qr4HN
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63F9A80E00
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 13:43:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A82114E410D5;
 Wed, 30 Sep 2026 13:43:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6D09D60749;
 Wed, 30 Sep 2026 13:43:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4B708103297D4; 
 Wed, 30 Sep 2026 15:42:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790775779; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=O1VWjzcCK6bdpsq4UjWXVcPhleQNRlqAPuaWdUpT+28=;
 b=ZJ7Qr4HNy9SZASolx0a6aV3wGXDn+eiHWtZjuzGnnyZK39ZmH6j7P31tdM9gGkwwRa6RqJ
 abIdat7sVWBF3b9hiwy5tP+dpGpiB3C4/XyuhNrdECb6KVGZVQGS0GOUtdeagXLDQ3iLOP
 Z1YrLdNI3ehZvVbOtUf1cKuenNfy5qIZnfsx+AGlzv2IvlotVsWqPEtpaVhJy1XIhsnto7
 miKOhh+yziy59QhwPRzopmDoQjkWkxaW/uonkIZZ34aiH7RaXPzyAA1DsslZk59wK5r2xP
 PyyuiChz4Xh+LpTuVVj+iJv9sf98mSJMm62eXoHSU1TYbws23IMTdIR4GnKyGw==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v4 0/9] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
Date: Wed, 30 Sep 2026 15:42:33 +0200
Message-Id: <20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBAF0KsY1mKGgUpx5T2Mi4JTi9FioDaap
 ne36EKNxuWf/Hl/YImip8RWs4FF6n3yoZ2Cms+Ya6p2T9zvpswQcAmlUNyfrkbyRO4SyYbQcWu
 EIm2XztqaTW/nSLW/PsjN9pnTxR7IddnJjcanLsTbY7MXufeH7wUHDk46XQLCDuQ6n4++XbhwY
 nmgxxdhAH8QOBGFUdoarArQ+E3IN0KIH4TMhMLKGG1kVcMnMY7jHSvdvopKAQAA
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Lei Xu <lei.xu@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5023;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=aso19PTZqxwOxjN/a1K6qB5/jrxT/IpaB/4jUJN0MWU=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvRHZCHBHLZr+NFEE2jCymQtIXO7o4DsdtMqyB
 1O10q7F/LeJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar0R2QAKCRArAF6gG1qP
 AwKOEADGaLl/jvMM9szFwF+NRp+fF22ZJXgwKib9zigV/t9mhOhRsL8+tzyQCjiJqHBSskBojkZ
 lGxkl2tVv+B8OgFH5H7coUCTNEk3oQfaV8WRR2UVctuXL5AVdF/stsWR/IkGq9QM9fTlJ2r54wx
 OwR6+4fDa1ji8mXqcRyQYP9MbgbiAfJMwCQfOzpA3Q6l821H6EXfRkPYmswMXvX+E3ZXCLW04vF
 olk9M8dX/D34FhlYan+IXE7Q71a+IDHsjYresNpIfQy/e4het0g9OgARVcail4alzjuVkNLKs03
 SZV6dniSjyECikwrPWzzMFHtIRuF2q1BDtrgGLPzHMU/M7RHUkvqe8wab1j4H9yPrpdBqE6hp+z
 5M4toJ+d2Haa+QqzYRSgLoWE3rB0kRr43daZ9IxvI3ZCGbnpIu555rV5h0+IqvQXXjPmUr+8q5j
 vslcuNozRfaqertanjnwS6oafBgeY9BClbd+ApBkBLkXPbRb4j0d+NXX/G8l2/YWiOlJzuBcpmD
 yRaB96NMk7/WsIpQ2nNnj+h5u9evTLVdjP2cDO+pDHV1TNB7K1NyNVk1fqJbkjFRU5ZK+ha4PGS
 SioY6eEhbmkjwpZTfgnYXgHvG3Sd8lNGQNQzcFaTEVeDoayvDzR+drVxQQiA9QwweU305REFK8Z
 cHJus6lJgYz428w==
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

Patches 1-2: introduce the new common etype and convert the imx8cst one
Patch 3: introduces the new nxp_imx93cst etype
Patch 4: updates the imx93-u-boot.dtsi description to include the new 
signing nodes
Patches 5-6: documentation
Patches 7-9: add test coverage

Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
---
Changes in v4:
- new patches: move the fake cst run_cmd() mock into a _MockCstRunCmd()
  helper and use it from the imx8m test
- binman: test: nxp_imx93cst coverage: check the CST configuration offsets
  generated in the missing-bintool case, reuse the new mock helper, and
  drop the unneeded force_missing_bintools='mkimage'
- doc: imx: ahab: fix the i.MX 9x diagram box characters, and reword the
  mx93 guide signing description (two signing nodes), key location and
  CST_DIR example
- Link to v3: https://patch.msgid.link/20260911-imx93-secureboot-v3-0-542a99793af0@bootlin.com

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
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lei Xu <lei.xu@nxp.com>
Cc: Joseph Guo <qijian.guo@nxp.com>
Cc: Vincent Jardin <vjardin@free.fr>

---
Jérémie Dautheribes (Schneider Electric) (9):
      binman: add nxp_imxcst base etype for i.MX CST signing
      binman: nxp_imx8mcst: use the nxp_imxcst base etype
      binman: add nxp_imx93cst etype for i.MX93 flash.bin signing
      imx93-u-boot: wrap SPL and U-Boot nodes in a CST node if AHAB_BOOT enabled
      doc: imx: ahab: add AHAB introduction
      doc: imx: ahab: add i.MX93 secure boot guide
      binman: test: add a helper to mock the cst bintool run_cmd()
      binman: test: use the cst mock helper in testNxpImx8mCSTSigned
      binman: test: add code coverage for nxp_imx93cst etype

 .gitignore                                         |   2 +
 arch/arm/dts/imx93-u-boot.dtsi                     |  54 ++-
 doc/board/nxp/index.rst                            |   1 +
 doc/imx/ahab/guides/mx93_secure_boot.rst           | 297 +++++++++++++
 doc/imx/ahab/introduction_ahab.rst                 | 460 +++++++++++++++++++++
 doc/imx/index.rst                                  |  14 +
 tools/binman/etype/nxp_imx8mcst.py                 |  60 +--
 tools/binman/etype/nxp_imx93cst.py                 | 112 +++++
 tools/binman/etype/nxp_imxcst.py                   | 120 ++++++
 tools/binman/ftest.py                              | 106 ++++-
 tools/binman/test/vendor/nxp_imx93_csf.dts         |  18 +
 .../binman/test/vendor/nxp_imx93_csf_imagename.dts |  24 ++
 12 files changed, 1188 insertions(+), 80 deletions(-)
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
change-id: 20260814-imx93-secureboot-b914e7b6cbbf

Best regards,
--  
Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

