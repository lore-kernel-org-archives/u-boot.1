Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCA0D16260
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2320789169;
	Mon, 14 Oct 2024 15:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="O/28ZG08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CA2489144; Mon, 14 Oct 2024 15:12:44 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 012F48915C
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so2795877f8f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911561; x=1729516361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
 b=O/28ZG08eBNyZsG43O++evhjd+aA6vmYNsitMQAl9+3Fr/aK/+11RAlMqhnds/k1EW
 WiCMw/SFPDKEanZ+PH3Wvwvp3U2vMyPLq+fbmPNuxXV+MSKHPgyV1iX4l3z19BrbFhGN
 IANzj/pm48dUV0QWWWcLEPUCYHSY8KfFxEc/VrgUt4LXsyD9Gam8Fm0wUd5W2UeEUPg5
 PutEF2N4zpm6ALKjpqjbyLvQorCovjGFmdEZ0CZdnLolBJnigKQNJnxgAqDRp54jo/XM
 R63A1knVK0dKRBSCNQDZRKOyZFKG62JkkCFnxTY3GZNXwFiHLklDIFxJ+qvm+E5UcZj4
 jRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911561; x=1729516361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGbPCelhRUxeOr5cLsV7ibzfbl/a6GdxpM4a69SHovc=;
 b=DSX7mQVLSUkHmETjtQcdzBaI5PMv2UauXdZPkl1fln7y17vReqEAEmVmjy9B9AAGn6
 kRphxZZAb2/EIzsHZ1sIjafaKFJ3cafRnQB/rzRAT7W87IyUxvPrNI62rtHifs/kMXeh
 3j4Haw8ZVptA8Mr85eEvUt4pRqiD14///mzqmTeX8Voo3O3Ogba2Sb92bnCS6IwaxavP
 WcVr83D2V5XBKJGoUQE+RQA5MrblSGb0vnJLhgjn0bu4cAVKZBNGqsii++aXNTnzHO93
 c+nzxFLgL1B3EEzTxVUlzEzCfnSkAdibQg4cXjyEkzgnJrRV0o4/OKjkbXXE8J93KBmg
 oNIg==
X-Gm-Message-State: AOJu0YyU5BToUWynPkTFbptPMNzikM3MSRFfIL+dNEQp6KHLiwekAkj3
 f9e5y0EVEDMyCmQ4xafmlmz4hWIGNFUYenU9fj23uppkTwygmN0RvCON+pBy7C5UqBENb0MAR3E
 W
X-Google-Smtp-Source: AGHT+IHKr6hifCSkvsXFUJgWIjAVOn3J9Df84gca5gSHqvEfgm4wWvDJ53aO/2l1UY/IvPW0f5YH1g==
X-Received: by 2002:adf:a111:0:b0:374:bcfe:e73 with SMTP id
 ffacd0b85a97d-37d552cdf30mr8750775f8f.28.1728911561241; 
 Mon, 14 Oct 2024 06:12:41 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:12:40 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 20/37] arm: gic-v3-its: Implement of_xlate
Date: Mon, 14 Oct 2024 15:10:36 +0200
Message-ID: <20241014131152.267405-21-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Translate IRQs by implementing of_xlate() as required by
irq_get_by_index() to parse interrupt properties.

TEST: Booted on qemu sbsa-ref that has a GICV3.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changelog v6:
- Update header order

---
 arch/arm/lib/gic-v3-its.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index 22fa46a341..0d5545bfb2 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -4,6 +4,7 @@
  */
 #include <cpu_func.h>
 #include <dm.h>
+#include <irq.h>
 #include <asm/gic.h>
 #include <asm/gic-v3.h>
 #include <asm/io.h>
@@ -163,8 +164,28 @@ static const struct udevice_id gic_v3_ids[] = {
 	{}
 };
 
+static int arm_gic_v3_of_xlate(struct irq *irq, struct ofnode_phandle_args *args)
+{
+	if (args->args_count > 2) {
+		log_debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	if (args->args_count > 0)
+		irq->id = args->args[0];
+	if (args->args_count > 1)
+		irq->flags = args->args[1];
+
+	return 0;
+}
+
+static const struct irq_ops arm_gic_v3_ops = {
+	.of_xlate		=  arm_gic_v3_of_xlate,
+};
+
 U_BOOT_DRIVER(arm_gic_v3) = {
 	.name		= "gic-v3",
 	.id		= UCLASS_IRQ,
 	.of_match	= gic_v3_ids,
+	.ops		= &arm_gic_v3_ops,
 };
-- 
2.46.2

