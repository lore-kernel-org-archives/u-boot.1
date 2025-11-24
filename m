Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D395CCFA466
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 07:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FB683D0C;
	Mon, 24 Nov 2025 08:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jG3nOLlJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACAD183BCF; Mon, 24 Nov 2025 08:57:35 +0100 (CET)
Received: from mx-relay02-hz2.antispameurope.com
 (mx-relay02-hz2.antispameurope.com [83.246.65.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D15F83C7B
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 08:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0416cdc3b4=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate02-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=pJnfnjU8ChlMpYALprMVtsscgEUW/rzP93FIcsQK+m4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763971050;
 b=G2zw+MZjZERcSPqQQZe6eLEET1ml4PFEk79MZ7kRncIrMda7szfofZyBOFyFy0ETpdtL+izQ
 ATeeZtL6hkRNvr/dVdfudCsCL2jmS57qub7lBLNsIHeSHA8p+SEFQ/V3DJjtpGoVS44/pVPsFIW
 7O20ew1w7SpJo8jPwMsM3BvLnGQfeAUVGvt8bdJQDjW7TmdoWNyzLxcET9gz7cfG68N5Hsns8JW
 HYIZtld1JBb+7oc1PphTGgUkS0Zg1odwOH/M/TB2bo6FxbnCC+y42/toFyesUWyDuX/U9WpeSmZ
 rmHKwOjNLKHfKxr1wDTz1MqmkS86OXzrGrzhqjPClb/9g==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763971050;
 b=UFLKMCa8/unLYEfkA0YXLvs+y4Eb50QWYuXefRpZ19AVnGJtVxPXaxxFTMJmAkUGGc8iT81X
 yAcFDoyUFCzCT+0FbcBY6+M2LBlDZ3nFTHeY3lxHFMoU0p+9+kDDn9RgZxP9lQUR9MWBpXn8sWc
 oP6F1hykTmeL8l0641Bj8fEMEdhpeVOZCZyE3KXChY94OQSr4UCm1SCPyAmfTQOGW1IjC1CfEBw
 22McrUcYpieQEMVG2H20NUszi9I9KDpGM4vh9l+FBOS4e2oHQuvOWAfKCHtdZOA67Ur093+f+jG
 3+JL9BwQdHQfMyhotfDG37sz5BJ0YYVYu0xiDRR1wgb8w==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay02-hz2.antispameurope.com; Mon, 24 Nov 2025 08:57:30 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 04A7ECC0CC9; Mon, 24 Nov 2025 08:57:16 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH v2 4/4] board: tqma6: update MAINTAINERS
Date: Mon, 24 Nov 2025 08:55:26 +0100
Message-ID: <20251124075540.14930-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
References: <20251124075540.14930-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay02-hz2.antispameurope.com with 4dFJ7x3KB0z2gMP2
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: b19fc052beb3447cd96043ddb36b4ba0
X-cloud-security: scantime:1.910
DKIM-Signature: a=rsa-sha256;
 bh=pJnfnjU8ChlMpYALprMVtsscgEUW/rzP93FIcsQK+m4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763971049; v=1;
 b=jG3nOLlJnkBU//wZEOGuEjXdE8CrkMFY4dO/CDilnHTm0QxLrb2qXX+3hDKKNpyHQhOw18F9
 nR4+aD6RRamdAeN63EVUXCsaonlR5nZY5vUTggDFoDylfaPEr9ljCmnmxcxYj5pgAjpQROU7MZr
 wNSHI/XCVqWig9x8qi5SEtLTan3E4706goWSB/p9CF5jkB7AtK5BLaIvZEk+2/51QPiRWxoy4ka
 f1EfU4VMQs+KREn+Dybm4kdjrjtrqDUWo6T8EQB2opo76ocBuP10Xkpo9aCIrLBmGZF8Zs0q/5i
 kMid85LRUFBj3PP/zkz1UhcP1M5mnKmPk2CZuppwVDYkg==
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

- change maintainer e-Mail address
  (old is not suitable for plain text mail)
- add TQ mailing list

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/tq/tqma6/MAINTAINERS b/board/tq/tqma6/MAINTAINERS
index c4fb6ec206d..1d3f7d2cf63 100644
--- a/board/tq/tqma6/MAINTAINERS
+++ b/board/tq/tqma6/MAINTAINERS
@@ -1,5 +1,6 @@
 TQ-SYSTEMS TQMA6 BOARD
-M:	Markus Niebel <Markus.Niebel@tq-group.com>
+M:	Markus Niebel <Markus.Niebel@ew.tq-group.com>
+L:	TQ-Systems OSS Team <u-boot@ew.tq-group.com>
 S:	Maintained
 F:	board/tq/tqma6/
 F:	include/configs/tqma6.h
-- 
2.43.0

