Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C48CFA748
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 08:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C476682A9E;
	Fri, 21 Nov 2025 09:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BHMhLbZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98593802C1; Fri, 21 Nov 2025 09:14:35 +0100 (CET)
Received: from mx-relay95-hz2.antispameurope.com
 (mx-relay95-hz2.antispameurope.com [94.100.136.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B53468042F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0413995d28=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate95-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=pJnfnjU8ChlMpYALprMVtsscgEUW/rzP93FIcsQK+m4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1763712873;
 b=iQWOfjarW1p7GW5fcCOFm6SaztUOecG93qS3jr9Oogd+KJOuiRbsRPG1XaJGqEtB9UvDJg7u
 rNFrCUryyClSZ99R7R0WR2/Bs4hXAXjfMwZKQ0tb4C5IWLwBHafWBfNmTVb+dLqES+gOfCQw+X0
 FEDjsQdNg48CTu0KSN3wP10MegwLQPFLZQjN8+LdJXC1XMgcge2OIuzczxYhAuWajLhaAcqbIKL
 Hb55RLiju+nr4yajUZNJ0oDXOuIG6+8Skdhymxelz1GsUV4ZOlUhhYUrUXZyvENM/Dqlpp+B9uW
 vZY2QrCCtExwscsiGLKAd2ldj2hF3eyw5C3w5U/CUQXYg==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1763712873;
 b=sbge6+pcPdZhMT962FoQX18O59WQqLMv3DbEMkpKJRgH+BGbPlxR4qtCVUPyPrulo/LXTHKV
 0xt4/ELPpvLj9rv/mSL1AOrVI5RHNb9CgOIdK14MraAvAGIX58nrLm08z7PcBe1PjwT7jExnaFU
 ZRvaOH/pNFWSPC4hvr2xmGxnrdG9gox2jthHOvZh8Z3Dq5qG5RKabVc30LjuOzQaDFYksMVHTRv
 eQGzq5K99ehuVUsbeDXNA9lfxPUNm0BN3tvQJhy2AemMjMSy9zJg/WZMBHeEgCx+Ari13YN6+2K
 Jq1BWQAt56Y2KGNQKx15Sf8wmnMBYh+3ejxlIGlD/OXZA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay95-hz2.antispameurope.com; Fri, 21 Nov 2025 09:14:32 +0100
Received: from merchelm-W2.tq-net.de
 (host-82-135-125-110.customer.m-online.net [82.135.125.110])
 (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 C5E4B220D80; Fri, 21 Nov 2025 09:14:21 +0100 (CET)
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@denx.de>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, Stefan Roese <sr@denx.de>,
 u-boot@lists.denx.de, u-boot@ew.tq-group.com
Subject: [PATCH 4/4] board: tqma6: update MAINTAINERS
Date: Fri, 21 Nov 2025 09:11:30 +0100
Message-ID: <20251121081138.73285-5-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
References: <20251121081138.73285-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay95-hz2.antispameurope.com with 4dCSg21wptz2F8d3
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: df4c7660cc4533e16bec03dcd07d2b64
X-cloud-security: scantime:1.555
DKIM-Signature: a=rsa-sha256;
 bh=pJnfnjU8ChlMpYALprMVtsscgEUW/rzP93FIcsQK+m4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1763712872; v=1;
 b=BHMhLbZo3VvSPZgR9xhGvluK3Wxy+kssIztI/cvZ8DOKxxGxM9a0r22qFQYB7B8NDXr+Bqwa
 cbwzmBbc/5NDPGZpaI2zpcDnwvnugQK8Naccz6+Fijp6QcVzF5uFCCegoVZVM8jkYqb0XW9flRl
 4jyeTFGgRktJnauX+7SJ7xk7fJKjxFHzj2sN4w0IVEu/goaRZep7GVIEh84jr7o8ShlPEz16FB0
 cHSg24HrStsk89wLSMJDdjejs06bymkYnPw7amZEyxZ0BjD14HsJOZ3Co9KNqo50Nin+hRZJZCJ
 UK4w8+27bNUaH6vvuDFZ+S60fHQjR0O6L71XUvrCI0jNA==
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

