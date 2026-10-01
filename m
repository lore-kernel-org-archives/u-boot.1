Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8745CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4ADB88121E;
	Thu,  1 Oct 2026 16:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fnJ6nl73UrLx; Thu,  1 Oct 2026 16:26:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1E1688121F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790872012;
	b=VqsobU+JA6zJ2gf+izlqxmAlhIJ5cJnbhfoM72AZ/78SPg4GhNFq/643CqTrashJUg6w
	 TLzTLluJzoedPd3t2w2UaN5m2BgLTMuHgEkaEcanxOLQTDzqWOubMlzZtk9++Lq/NxoOi
	 cW+8qV4lIK7sn4J2lLC5UNC5umWcPji2eI6WcKe+DcwAhvVbNcVE2dk55w1sWXgoy6fpO
	 12hIB9J3BACwVZtmqBcCSnR6kjieHewkBzrqZdu3sp5ryk5zCa9iZaWXM9e7lmF7byWBH
	 ddok/fvesYrocYhJWwOur5150DkdSaayNOt+7TJ1tMVJQwdFyqsHVsgbVIzbie7z8Kw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790872012;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pwIXKg1bPp6BScC2DDYBdAdQVGGBlJ14/vMWiSdW5n4=;
	b=gHe7f8XcgOwoYFko4aV2V4hsz1KBGtR39JclY+bDvJL6QItqlCd3A+5tglXl5XTSUCzg
	 QLOs6UjA+T8K5snppF1Q9lUzrzvXt1cFisrvpQj7WpaZzKdODmzxt73dQ9HirjrJb//V2
	 eAV+/8gzpFFHT7i2klQCIARRX+kTx/O7/0nFjcj7K/RAN2JiFABxwoypCWU8OY/bG4QfE
	 9s1qYtQwqISFgzZO3ojcrn2HrQ7ZHn3AD+rst2hr2yEaS4O/Rng/JUxsplWu/L6QBrJcn
	 tm/Rp17j0n3xybYdEOvgV885O0zhfIxplBFqWexfd+46c11hMne/mxxwFGP75x0OYIQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790872012;
	bh=pwIXKg1bPp6BScC2DDYBdAdQVGGBlJ14/vMWiSdW5n4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=McBoa4uaHFAyYW2mWBuAU3AJadr+BJeh8ZuwwklMMuN0f5fJW+ZFXMCaGe9dw+n3k
	 BYKZwF75V6pRNRM0lY/ArdQzK+dNKxDsdwgkYhs13Rc2PPaZfw8TbkPi/KLYzPqbiP
	 Q3Eati939ljKoqRHqxXMJ8E5aasQwiJo/GdbLIoHMrKPt0XcdtgBtKY95D9ydn+Gk/
	 qGpoRVY7Xpub/bHhzZxceaFAKNNed1OQRpHCsue4SS4L3h2YvAB3VxVpTyGDhtP/vt
	 k2veHFQ4soDueeBMP950AeBJeIw8YeNZmxAbpfSCvLqU3U399Z3hDcJJOHK5IIQcBf
	 W3ofaEAp+3crg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E1688121F;
	Thu,  1 Oct 2026 16:26:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 893BB3D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F48F40185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id da0oxKfktsJk for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:26:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 082FB40098
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790872009;
 b=NWfvlYTVLdMeWBBYWCE+eKVBYVga6RywmJHxl8kKu3ErHubjASSKAcCf5lwg7zICK474
 JLLc1tPhBAYjt/gFDiswjV4AGI7/byogmWDy2eJEXtnrmzfFVbr1ms1CGMxgFubpkuWLa
 9HJyx82OVrL/3nIt3GvYkdFLycLn78zBdi76awKDXTYxBVqMH0BcoujIxEvdi3kF6M+Pv
 PbbkPRzAmYIVgtcEOyjzC/3E7WJV9UB9cQxhQ3Hp+YQ8DVS/m2+KIKkh7g/6EoM09fj7q
 WMuEyzH9LJ+4NZ3+BdMTwoY8M7xZuSEUQntEtAa7EXa3O8l0fM8tWkg94HHoU6VNTDw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790872009;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:Subject:
 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Last-TLS-Session-Version;
 bh=pwIXKg1bPp6BScC2DDYBdAdQVGGBlJ14/vMWiSdW5n4=;
 b=BJ0QQI7kmYK8UylqOoEHwMULlqVig6RjgOju6ULCIwbPp7I1WMUCnwxh7iWjfg/ze3IT
 lyvYEhxfgdp7flPItJFpt6+DcLCM50xtZlw2ewvkgOVL+jO18rdrrk/DgLzsJroKdzfFE
 j8wrzYW9MmYRMZenhn+6PIRZJWMP5W0TGJpnF7XJQTLeP97H1JReD2F+1bmJ0LJOrtFuv
 e8v5YRqSgtykez8YRY+gtzrS+1QL5Uko0tZsWP6W0Er+SCNZrWKvo1KkZdF4qDL5t6U9e
 QyDWYLRxybTI4HT8NY0fYoYsBBzR8rwJgrCKxipclAvdXQwzyzu1/PVN297zxO/BHzw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=CQXKpLJJ; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=jeremie.dautheribes@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=CQXKpLJJ
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 082FB40098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:26:46 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 686C91A18B1;
 Thu,  1 Oct 2026 16:26:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 31D6660343;
 Thu,  1 Oct 2026 16:26:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E5A83103282DF; 
 Thu,  1 Oct 2026 18:26:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790872002; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=pwIXKg1bPp6BScC2DDYBdAdQVGGBlJ14/vMWiSdW5n4=;
 b=CQXKpLJJhezoNRJSqJljvarVHUb8IR2uXnShw8GS7XSfK/R/7B05+MBuGkEyLhbwSKvfB3
 qjILUz/gkrr27lHj1DeYdhdVpFtPnniXDF0lHoPzBVUucj+MHyQSgTl174RNl3PnEV8dtY
 mF07F87jOok32T91Nh+Au6dNY10PQRAw/emAPWU9a1CpQlzTuZAdGUl10hY+umUKTGZf0O
 N4l1DDUSEhDvgXVTBZd2U2d0RqxVQlVS+bvFGY/Xk3WW2Xc1aAESsV0V5Ig336ujpinW6G
 cJz6RMz9KuYYuPMA5mXa+SHgv7JEQAFLaQWQfs7uqPw2lc7MHlgyM29oHawA7A==
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>
Subject: [PATCH v5 0/9] binman: add nxp_imx93cst etype for i.MX93 flash.bin
 signing
Date: Thu, 01 Oct 2026 18:26:17 +0200
Message-Id: <20261001-imx93-secureboot-v5-0-d97dea41bd1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQW7DIBAF0KtErEs1DNh4uuo9qiwA44aoMRU4V
 qLIdy8ki6SKleUf/Xn/wrJPwWf2sbmw5OeQQxxLaN42zO3M+O156EtmCNhCJxQPhxNJnr07Jm9
 jnLgloby2rbN2YOXtN/khnK7k1/aW89HuvZuqUxu7kKeYztfNWdTeC34WHDg46XQHCD3Iz3r+C
 eO7iwdWB2a8EwS4QmAhGlLaEpoGND4T8oEQYoWQlVBoiDRJM8AzoR4ICSuEKsRAbWeEFap3zX9
 iWZY/5vl+/40BAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5225;
 i=jeremie.dautheribes@bootlin.com; h=from:subject:message-id;
 bh=Dcq9Qd19kYJidLf1Txpsd2XCwp9V32hdX5ILMlVJAxg=;
 b=owEBbQKS/ZANAwAKASsAXqAbWo8DAcsmYgBqvom3ZpTICl76P9zgT/VEFK4Q/mz1C2N0sTwDl
 gysO+qShDSJAjMEAAEKAB0WIQT7FK2Qhtu4QpBIBAkrAF6gG1qPAwUCar6JtwAKCRArAF6gG1qP
 A0P2EACHz8Wh82EVuAMtHhosYXQryAYM8MQdeYuKXGbqEvmgCPDG4DVO/WX0Dt+u59G3L00BB2Y
 dV9z+/qisaBjV7ZYuXWKERLcLfgfVqqMGMYNFhBqnEmoLbBtVcsI78gSg9ZY+NBXRlBeXJtKfwP
 wabNdUFwjHqTwETPv3mlQe+5GeN0BFsagSM19p6vnHh5sYhAjjhJYvE5O1bS53GRWELbgi/38SY
 1n4ss661IlNyxs7NYe9WLFy8zKDhgqoYh3yRMW8dkpT1aG1+CcG/3z2K2A+S2Cxb9QAH+MQys2j
 jnG9eMqAerCj4aAk/Mo15qwPY0ngnk3TceOTRNexyxehNjWW0I8CHZ/04pHvHyITufCQVA/7G4h
 lp7Dw5Zl721JM5Y9qsCG4mMigiGYlJikndAhxDHbBeP6Au1n7jo6VRpiqIH/lILQZnn0+tO5XWz
 iB1GHJxUYUgIN8j0I9/BMWSvvclpGrj7Ji3UdwNuDLqbK4K5BBg9DLPrqq3Xy8FUzJ3JC2LywG2
 J4Bs1hTOh64PH+cW1oVGaEcIjAsejZ8EqGCI34pJVEX8jqObTGMNLO0jx9sH/T2kqpjbTsGkRa3
 X5FIufNH0b/75yaChP4r2rJ4rw1xeKTcWHGtKyni/53bu46JWUKvciTMIMNqYOTPxw96roCdiBs
 OTMXeUX925K97KA==
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
Changes in v5:
- test: add short-input test instead of SetImagePos and delete 
  nxp_imx93_csf_imagename.dts, which became useless after this change (as 
  recommended by Simon Glass)
- test: factor the SPL container setup

- Link to v4: https://patch.msgid.link/20260930-imx93-secureboot-v4-0-f968a1b14dc5@bootlin.com

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

 .gitignore                                 |   2 +
 arch/arm/dts/imx93-u-boot.dtsi             |  54 ++--
 doc/board/nxp/index.rst                    |   1 +
 doc/imx/ahab/guides/mx93_secure_boot.rst   | 297 +++++++++++++++++++
 doc/imx/ahab/introduction_ahab.rst         | 460 +++++++++++++++++++++++++++++
 doc/imx/index.rst                          |  14 +
 tools/binman/etype/nxp_imx8mcst.py         |  60 +---
 tools/binman/etype/nxp_imx93cst.py         | 112 +++++++
 tools/binman/etype/nxp_imxcst.py           | 120 ++++++++
 tools/binman/ftest.py                      | 125 +++++++-
 tools/binman/test/vendor/nxp_imx93_csf.dts |  18 ++
 11 files changed, 1183 insertions(+), 80 deletions(-)
---
base-commit: 2b8902913c19eb581fb0d567201c09b8fa46ac74
change-id: 20260814-imx93-secureboot-b914e7b6cbbf

Best regards,
--  
Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>

