Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AF0CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3210A83A91;
	Thu, 30 Apr 2026 23:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="WACrN6M5";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="QEkxeu0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89B93841D7; Thu, 30 Apr 2026 23:33:33 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1538A83936
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.stl.internal (Postfix) with ESMTP id EE3E51D00091;
 Thu, 30 Apr 2026 17:33:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 30 Apr 2026 17:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm1; t=1777584809; x=1777671209; bh=ub
 Kf6xI9bXRuuxmYMF6cyH7Rr2x39Yay8o2o6GYX1TE=; b=WACrN6M5JXhvDvG+xD
 bbgzaNLeq2kTxFBVamspE4vB6LduTMF3rpKNZqc9SaO9guM/ELD8kAKEWgw+n6IF
 5qFwLZIv3YGzaSsWvUp9fETHhFuNj2InNxzAIOI17ifpPBnVRTdr7LiiLgC70TlP
 8T9x/p/0ZfiGLgApqZVmpRHWkZnJYkOGWU78diiInOGcoqSABO+kJGWoW7BIxgj6
 RgV4/0EYYPGb4n73aFB7yHGo33M8MOHRhOy6Xa41ICpDj781BhrmfOKnp4ViIvEl
 RbL7+ZV39X3rFGBDNxB6Bk/6IeKZoDQPbi7a3MNeHppYvEgIT2yB5OI7W6bIU+vV
 Pxiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1777584809; x=1777671209; bh=ubKf6xI9bXRuuxmYMF6cyH7Rr2x3
 9Yay8o2o6GYX1TE=; b=QEkxeu0hCxZMNrTHyqMKIUW6M1vYWZwyzL+1hOaPVTSi
 nDUSA7R/v9gvBOKsiG6W8VE5YGjUe5yZkxRrDkjnmGQMqb70NFMkV/KWWMU6lyeI
 TSSsQI+ETMZqctwfSk8fIFkXHJ6OVVFi6hXXBCfOGi/qfyl9qeUq+3O7OACMQjJb
 kM2VfvjC3YHiFikIP2T+nLYppQblLcv59OQJGLlvv/qcvlcvf5gvvEOvCg+EQh5n
 toG6yaophChFtUEyZmdq71RKKxZwhf7hkOhLST3PhZj6lFjdUVSxAiTLtNW+gA2D
 1Z95WcoOV8GKfVx+eAALT8b4TDQB0aoPlEdc7S08eg==
X-ME-Sender: <xms:qcrzadpv4MOa-_cABGm9sPrjCLpO7nx0X67t480LmSt6VjNjIz9gZA>
 <xme:qcrzaWo8NJeMnsE-8-sQ-xhfkG9Z6imRnnK9zrUjjRH-DV0xgjBh3Olvzbcqzj0QA
 F5CB5pLT8vOdTmu9qe-LucZGO45pUM7HdeQOCZnPCJhEenWqUJDxBw>
X-ME-Received: <xmr:qcrzafMCJ1sr3di5DXSv41J5gcLMqtyKexIlbcGk16PXorUp4VJL-Y1he43byHzaaerrO3ete1K8cxDiOE9z9IlaA4zAI090dGN2jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkeegudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
 uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpeefheeltd
 ehfeetjeefvdehteeutddtteelgeduueetjeevteeifeeuvdefffdvieenucffohhmrghi
 nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtg
 homhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphht
 thhopehkvghtthgvnhhishesohhpvghnsghsugdrohhrghdprhgtphhtthhopehjsehjrg
 hnnhgruhdrnhgvth
X-ME-Proxy: <xmx:qcrzaXyhZic4R2-fzgNpomZ0DsJE2pytHd8NMVXULAZPva2GDfq3sg>
 <xmx:qcrzaYtfWQ-THyVxkJs6B9pie-OWwAE7ReHjs5rOB2QqPy8D7xqdrA>
 <xmx:qcrzaQ7ensE51zF76FaZeCy_l3PW1FCgC_y-yJjBKCCOtNmZ1QXmIg>
 <xmx:qcrzaXQz-IyFk9pBD2_6y8FMaRFwIy6UBvtzKpTT2zPMCLvKTUHbBg>
 <xmx:qcrzaaJCS0Ka_W16emRKNhXUElkxJnKFwkj6jJSSWV9QRiRZi8Mgc9cU>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 17:33:29 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 30 Apr 2026 23:33:25 +0200
Subject: [PATCH] spi: apple: Add "apple,t8103-spi" compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-apple-compat-spi-v1-1-6fb3a6fc499c@jannau.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1gaqFkWvIi5CTTXgJ7QigvTuF
 pdvMfNC5CAcYSheCHxLlPPIqMoC3ErHwihzNtSmbo1tDJLqxujOXenCqIJkfd93rvXeEuRMA3t
 5/uU4pfQBL+x1QGIAAAA=
X-Change-ID: 20260430-apple-compat-spi-a4f997c6ff4a
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1226; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=2O1qab8j0MiJpT7XPgOQgkNNi1dJK4EAvwIxsmVCJAc=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhszPp5bP3ePlf3ZWSugH9T1V554WFt3i+KTYv9z6usfOD
 Ulej371dZSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZhIUArD/7p2v5TiUvOag9p7
 V1rt+rd0d1ViJYezgcnKhUUVDRcFORn+J6+wLbBp/1XUs236a5eCwO8BG5MNJzFyzBG4d5rNXe4
 dNwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
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

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,spi" anymore [1]. Use
"apple,t8103-spi" as base compatible as it is the SoC driver and
bindings were originally written for.
The t602x (M2 Pro/Max/Ultra) devicetrees submitted in [2] use this
compatible as fallback instead of "apple,spi".

Link: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/ [1]
Link: https://lore.kernel.org/asahi/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net/ [2]
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/spi/apple_spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/apple_spi.c b/drivers/spi/apple_spi.c
index 5f94e9f7a74..088d02e3b90 100644
--- a/drivers/spi/apple_spi.c
+++ b/drivers/spi/apple_spi.c
@@ -270,6 +270,7 @@ static int apple_spi_probe(struct udevice *dev)
 }
 
 static const struct udevice_id apple_spi_of_match[] = {
+	{ .compatible = "apple,t8103-spi" },
 	{ .compatible = "apple,spi" },
 	{ /* sentinel */ }
 };

---
base-commit: 88dc2788777babfd6322fa655df549a019aa1e69
change-id: 20260430-apple-compat-spi-a4f997c6ff4a

Best regards,
-- 
Janne Grunau <j@jannau.net>

