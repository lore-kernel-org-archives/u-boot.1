Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7DC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:35:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1417784CFE;
	Wed, 15 Jul 2026 16:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="paRPxG85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137E084CAF; Wed, 15 Jul 2026 16:30:42 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AFE84BB4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 16:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15f020a223so738480266b.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784125839; x=1784730639; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eX7ahfRP/akWOeiK1gBbaJOn4byW/1w39K1oF3HaEs4=;
 b=paRPxG85mlaCUMnzHlm3p3mFrRNRREmvYx38SVttQmJvaJpX617lW0frYPuZJ8mBpM
 uV7fEgDMGMj5Y5QGirTNXsfJaZlwJVRpeao8JZiysqiiPM0x95+9QquovtiXVz6GS3PY
 IL9m+rinu9bzdb0JjEzSVzoigy6za0XFaeIhpuwc5mrRUaD/ddXT2uy1QhuttERGE5WR
 KVO1Ah6caRZcII2/w4aCyHK0d41YbVTQ//QXhEs9dfaqsDzuT2jdbZG7V3nQuKIX7pN5
 bXR44/+rej7DImII0G6fehHLAqA9pU7vb1I6PqpTLJspwdg1XhMTXsXjzNvEqh1rWvVR
 sDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784125839; x=1784730639;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eX7ahfRP/akWOeiK1gBbaJOn4byW/1w39K1oF3HaEs4=;
 b=o42uwEnKWHG9TjXZVqSL5BYPEf56vyEF0sQS+GUe/uqW5IeeMonmSUE3cGJU7smdoa
 9JAFb70fxu/VoD8LM6oQMnQwRpubKs7CJ0BcNyrDWJf6GGkrmw2Rk8LYnJnYSONZ8Yr1
 Kj2JTPHjJPMESGDBgfoHrkLd0rYlmU3xJchupftYSka9lIo97nclF8GaOA3maOoaXpIu
 EoASgpbr5CqJTQhX0CeshW1tBRgy9TiL9o/WnDPPq1DbreQ5XdmZsBVIfEnYsBfP/mOz
 SF72JOA475ieLg52+advbs6VA6F532vNMJfdG+dA+A3kcBA0dAoPhCrdAZ5CY9pf+jkD
 iCsQ==
X-Gm-Message-State: AOJu0Yw3UN4jnLlTFQJFjkIxQMcRhw4dgC2KcotMDLFnJ7nCmWZtfHHM
 5hrADzz8crjkB69TDhYNHsPuJmvKq0t8HOc2P6iFAYUnOwqJ8/4xmu7mmNGq3SlOtyA=
X-Gm-Gg: AfdE7cl+JNAnQymY1LAiMBBbYMBDFWPlVKf93/s5uI2uPespKLdSuyojhLcHWdvm20u
 MAbfTpMx7q1kufmfa6gI8YIlnsm56avl0uz7d0Zmyqkv+Ov10xbQ/1sw9YgtMhP3zw1R5VPDmNa
 Ht+TIbsPIbBnOpidI066Gl8aI+2x1pUFXp3ll4eqc1kVQToUi7xQV44C29GbQW2fleRlL+UV/0F
 b6o5Zlpp2SmOSpiCLjghSwLvXhI+5cL2KSlfxz37dsAAQWSXpX0FlVuntFmdi0bSLuH1GlzZxV0
 IElRLl9y5CHnVkDa1QPkrt0IE2lZj4jgS9UAfcsofJli5te/T5BX5YvHB29larkjESAxVxaQ0KM
 Ycn0gIeCwml6kp5jNpkszyiZid2to5cq8Qx8Ceu1KAbbKihs861t5yFmMraw/UTQvk0iUbmOV9c
 sGpWRo8TYjyYZ0tA2aXWsEjue1f+HAWKXUM5KQcxN2zWQ/BQAbjjEDB13vB1XWsIqoOCaZeOGLe
 WOtgA==
X-Received: by 2002:a17:907:3f12:b0:c16:13c3:b1ef with SMTP id
 a640c23a62f3a-c1667a0cd22mr393049266b.24.1784125839468; 
 Wed, 15 Jul 2026 07:30:39 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871262casm44827966b.6.2026.07.15.07.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:30:38 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 16:30:33 +0200
Subject: [PATCH 2/2] clk/stub: Add qcom,smd-rpm compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-clk-stub-smd-v1-2-af9232571ef9@fairphone.com>
References: <20260715-clk-stub-smd-v1-0-af9232571ef9@fairphone.com>
In-Reply-To: <20260715-clk-stub-smd-v1-0-af9232571ef9@fairphone.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784125833; l=663;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=/UGUw1Dvp7b/NoIzVXP+Wqnq5XvGdZKtZ/vaJ5579ak=;
 b=/+2+ahHD1w8S6Rim6zVPgVxoFtnbXpPEYMjPOIw3ypVlJpMHVZ79Oi1cFKWljuid3ooROWH+M
 jhSRxcAWV3rAYbmV6Ns2oGKPX5FumeqUxS1mn+KJgNVuNmuHvo4tQyO
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

This node is the parent of rpmcc and rpmpd on some older SoCs (e.g.
msm8953) and needs to bound to nop_parent so that the children drivers
can probe.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/clk-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
index 6daf0efa8d0..5bfee3efd25 100644
--- a/drivers/clk/clk-stub.c
+++ b/drivers/clk/clk-stub.c
@@ -15,6 +15,7 @@
 static const struct udevice_id nop_parent_ids[] = {
 	{ .compatible = "qcom,glink-rpm" },
 	{ .compatible = "qcom,glink-smd-rpm" },
+	{ .compatible = "qcom,smd-rpm" },
 	{ }
 };
 

-- 
2.55.0

