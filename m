Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E303D0D7BF
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 15:39:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B625389291;
	Fri, 11 Oct 2024 17:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="rAcgYJfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA22B89085; Fri, 11 Oct 2024 17:39:04 +0200 (CEST)
Received: from smtp052.goneo.de (smtp5.goneo.de [IPv6:2001:1640:5::8:30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0E689291
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 17:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 12661240DE1;
 Fri, 11 Oct 2024 17:39:02 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPS id 2BC80240562;
 Fri, 11 Oct 2024 17:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1728661140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+o9dG6Vf8rp0ZJhGsvHHjhHY+M3CsvJe5aha1HugvTQ=;
 b=rAcgYJfnw68o3ArH8vdY/ZZM8mjPBIL+AMErVmIjvGKb7umyzscrBrwBgsjj7XtiSsyvc4
 JdtTyy0uUAYxJzmyBG2W5HzYr+hepnpxZEoVpRxl0H402mDl1SJlCF2mDL5z0kWL8dZNdo
 63SoPFNd4WqhD9Ozp+7SDOeGzAJpgJ+YllVe/hgCplKFyLUPTPi438AdG4k53u2TwRrMDe
 1ED363hPPFVu5Mp76CpfqPcKwMo+H03uSqTceQQCTkNcDuWNn6C0GcJbFcE91gg+4/u6V3
 +vy2fpQrFbTTt2DqcBTvva5qFRMjj4cL0vpvqBYAjER8Fq6TcEDx40hddTd+Jw==
Received: from p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 (p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub2.goneo.de (Postfix) with ESMTPSA id CF8E324052C;
 Fri, 11 Oct 2024 17:38:59 +0200 (CEST)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Fri, 11 Oct 2024 17:38:47 +0200
Subject: [PATCH v2] clk: stub: add sm8150 compatible id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-clk-stub-sm8150-v2-1-552bbeffe7fc@devpi.de>
X-B4-Tracking: v=1; b=H4sIAIZGCWcC/3WPS47CMBBErxJ5PUbtX4xZcY8RC3/aYA2JwQ7RI
 JS744TFrGZZLfWrVy9SsSSs5NC9SME51ZTHFvhXR/zFjmekKbRMOHDJAAz11x9ap4ejddgzBdR
 pyw1ClMJZ0r5uBWP63Yjfp08ueH808PQ5kgFrtRu49TQsmIZ18o88CwoUIxgBWgkZ1PGaRlvyL
 pfzWuFsRerzMKTp0AWIWrogmQ429tJwo5VHIfv9agS6195GxTxZZS6pTrk8t7Uz22z+HTYzymh
 vtGBCq0Y1x4DzLe0CktOyLG9UZWrqOgEAAA==
X-Change-ID: 20241009-clk-stub-sm8150-b7a29e0f43ba
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1354; i=lehmanju@devpi.de;
 h=from:subject:message-id; bh=FN2uEGkUX2b5dQ3xen+s9m/Cx83gOCfYVVgML6u3JeY=;
 b=owEBbQKS/ZANAwAKARK2S7xC0EEDAcsmYgBnCUaThbdcyF1P9rgct7yH9S5RkE3wPc4e7lrjJ
 TgGYWgM1VSJAjMEAAEKAB0WIQTCqoxFzEvlxm0XalUStku8QtBBAwUCZwlGkwAKCRAStku8QtBB
 A+EKD/9TsvP3uF4y/byM1OGcJ3KkDyvs045tdYUz7ZWZzqL0TFBC3UhvLsHzc7Ub98/aaEPFQsN
 ShHYBVRk+7kEq84GoJ5euGi5f3k4vwjuoa0aRZum4dy1gq6wOmllX/11dbr8WEZy4A3/K8uLnIR
 39ZrKWef6Jtx5mpeRQFX9nLObj163S16yLtxl03ZyUamrZDGCZN5zb3zxSuokXhuvH0sNvvsVfX
 u2AX47Q8LM82Vh4rPCTXE5woMURBMco5f6O4/mD0GGlKykCgihX/ByL7Jy1X8+K55nP9wQE5PjZ
 d8SCLIsms7HE40JTZX7mStTLUveNIZf7VCkGah74y1ByMt2aFgKzllScCUGXH3nrRwqBekBgAg4
 hnjCW575ebPORHvmvdjCh1EEifWpbgckHtOQFZjIyFf9oUaw1vHkHZkyosyFoEiwTtDLMSjJ3h2
 tjyVVh6HdV6uz5FAb1+clzcqsv8dNIvgy68x4mlsiXPNz8RZlIAAJaRLvRC3uzGdiKqgjSyfrzF
 3bBuSxq+f6Imywk+VIi2UNhnYpBCdSNJUYHZMj8WTWAhySsgOX88a50L748uVndmymYLabN4zDw
 n5cXPARC7487M4EGy07UUtmE54K2KxlX2EHl6x2S+/AA53vLBvq16XoOhjqGoEar9pWQkqxmKTK
 7u3onSv7nTILttw==
X-Developer-Key: i=lehmanju@devpi.de; a=openpgp;
 fpr=C2AA8C45CC4BE5C66D176A5512B64BBC42D04103
X-Rspamd-UID: 48440d
X-Rspamd-UID: 100319
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

Add support for sm8150 clock controller to clk stub driver.

---
Simple patch to extend the clk stub driver to support binding to sm8150 clock controllers.

Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
Changes in v2:
- fix: syntax typo, missing ","
- Link to v1: https://lore.kernel.org/r/20241009-clk-stub-sm8150-v1-1-697313752979@devpi.de
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index ea817031fa6c0cc1ea21000273b5651be5d05e65..5fbbb07b7f7b93e619baf596064c4b3a3bfeecc0 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
 
 static const struct udevice_id stub_clk_ids[] = {
 	{ .compatible = "qcom,rpmcc" },
+	{ .compatible = "qcom,sm8150-rpmh-clk" },
 	{ .compatible = "qcom,sm8250-rpmh-clk" },
 	{ .compatible = "qcom,sm8550-rpmh-clk" },
 	{ .compatible = "qcom,sm8650-rpmh-clk" },

---
base-commit: d0f74bd417daf6492975ce346843ba0767caf51c
change-id: 20241009-clk-stub-sm8150-b7a29e0f43ba
prerequisite-message-id: 20240909-b4-clk-stub-v3-0-ef09307534d5@linaro.org
prerequisite-patch-id: 01b791d83c26250b3ff485045b88d5889f911bb8
prerequisite-patch-id: 66febbc73195c71535e2423d14f1ff6994ac36cd

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

