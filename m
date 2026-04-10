Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63525F4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:33:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74EF9841D5;
	Fri, 10 Apr 2026 15:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FyoDxm7a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E178419C; Fri, 10 Apr 2026 15:32:58 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57948412A
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso21568845e9.2
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827975; x=1776432775;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDYUu1aHVrYp0+wxOiCzVg/9i2lTGsLfGTX+3LGFjyo=;
 b=FyoDxm7aUPBP/ZzadbrVEPZLij2AIGR75ybTeCPdOM5HtowmnVBhlWWZKeaMcUk/sc
 9HTDnnn8QeDWmdD4xQ5WdRm2hisTePa30ptlQY0jeRyIYxDrAgY/XXapq458IA9vJ7S9
 1o7/ZxTP5c+Bfc1fWMkDYPHVDdA8wbfSYdrmkq4T4LujNIo1wFabw4jPxINHdqN2hqL/
 fkuL9SsBnPV/4xqGilGiszpKjfptZbW3puk23iL8rDLuvO0yCuPhQsX15rMXMyYAnuVI
 JvmBZOQilCv+gCrjrNFzMyH7gO3JrfHIiYOmYvXyPybBBfKEDgIK3mud4/djkSwp/qXp
 FmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827975; x=1776432775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lDYUu1aHVrYp0+wxOiCzVg/9i2lTGsLfGTX+3LGFjyo=;
 b=IPFPwuRqSr8zaW57bNXk0McD1VmnI9xrV2y8g8YAKu7DY4oBZSbDJExQI8Oy1yWa+z
 HcIwkAPZQjdBiSK6CJ5WZrOeKfklGicAMLTLMyFo+DG7mM0SbX+YpXMH1ZO50qwKvZ6Q
 3+t2ud6RU3hYSur14Vvc1oTwDSpZLb4N7AmoHmVi1pmBsG6oJ6q63s9U/exiG9SwISGH
 WCHGnFilK0/1DQgfWFQk0Qqk0rgT9fjoElhokhDOXb8ru2UF26VKpThGr5NkrTYdsHLe
 EiPaSgjrMwxtFv/us9QVcz4yT3xCUuHbXGkgGZPExdHdQdLWCDgFs2Wz02JVmxz4sleY
 J7uw==
X-Gm-Message-State: AOJu0YzhMgbzt8RSn+8LWJ1LAW59OtPJj3myo/6ybSOB2cUqmdAvD9mo
 KjiLSRN04xxzdgw5bXoSJAc1KH8VKU7OWFMVgm6GLFZOIMezYlOJNiL+JUbpgL1dS9s=
X-Gm-Gg: AeBDiesCvdY/mSlY9CpdFSlg5U6nC2zWlDGPEWp3uMRU+pyX103cZ7IHnjDnGMFcRHW
 qRiQh8Tx6rC7qLROIN3SQFl7RuQdHWvNJ8rfVJE3BTI4gokSF4SUrzdDavHzOlzP36G22FgFtUz
 n47J8lQ/qxfAiMXC6RzXOThK7PQ095FcGzdBnTlsv+4c/vbR5058tiPAQpiaklnp9dlFfIwxxtM
 5hs+onPxZy+vlfBVptlacK8Cvi2S08E6qYQsAUaWgFYjN8Yyl70HoZ6H9o1J75T9hGOhPw/RFHL
 6bt3zMkFkbNIMBXvXth78vMWtxirgrp2tBmlievGnc5HTWQUcENe+yohO4AcnhM22Z+3Sk3iYgZ
 Djp5ChdcvsYeNgZGvYbx4P3rrHzmyxJtIFfBz54c4xnGcR17b/ytD4bu9d/tJr09xDpOkrMAYiq
 Y1WCxhLFGoO4yBYu50CYMK
X-Received: by 2002:a05:600c:4e4d:b0:485:3193:6ddb with SMTP id
 5b1f17b1804b1-488d6808507mr42183305e9.3.1775827975158; 
 Fri, 10 Apr 2026 06:32:55 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d532ef00sm83626245e9.5.2026.04.10.06.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:32:54 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:44 +0200
Subject: [PATCH v5 04/12] configs: am335x_evm: Enable SPL_OPTIMIZE_INLINING
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-4-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=msp@baylibre.com;
 h=from:subject:message-id; bh=I3wCr584w4qrMpmEFlt3u8b1PmfLml6qkprQmPgETBk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbvy/fua/zgtk7yp7J/YLkDbVfvR8cup/77LvD6xdae
 71UZilTRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExk51+G/zkx+ZIJip/Vn205
 Hh4mXeH8ZMY+8dcB7t5Sm294587qvcfIcH2uZcXP8O7zm9pX6Beevq+m/FW64dl+9wln15vF3M1
 5wQ8A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable SPL inline optimization to shrink the size. After enabling
OF_UPSTREAM the size is otherwise too big. Enable it before enabling
OF_UPSTREAM to maintain bisect ability.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index bd188c252780fb541afbbe61a243bddaab79be93..17c0f840d3ad3cb6f09fa914655b304e90d0066a 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -23,6 +23,7 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_OPTIMIZE_INLINING=y
 CONFIG_SPL_ETH=y
 # CONFIG_SPL_FS_EXT4 is not set
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"

-- 
2.53.0

