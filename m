Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDB0E92734
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 16:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDA3083E36;
	Mon, 29 Dec 2025 17:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GYBlYUAA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AF3B83E70; Mon, 29 Dec 2025 17:10:52 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 506B383E21
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 17:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 674D13F7DA; 
 Mon, 29 Dec 2025 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767024649;
 bh=zWVNJaiTXb+pVeLaDvcsIF9cQxfG8EmZ+H8DMBHAF/k=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GYBlYUAAvg20NzUIBcsntWir7XR9/POHXnUIxmZrx01INeDKjtLnvX/RjGWZyOoSB
 cmf4DurHQ9qmu0Kx2sc0+2ZT+HZCJpVZmjoZ3Dd6+X+vWNUPpaPojFji1FhzYEF127
 lWarYf8k78f9q8KL7b0nexWu0Iu9trqylkvHC1WJ7jr6Tu6Jq+5dgIXELPUqrVxp+8
 aVYhcEnl+bAdr4CXRgFUAqDmx/kWPK5YS1im77p7Xm3Vdaregqn51RbTESeg+knBBz
 W+fqZ9ikGuYcGSn3lOl+1uNKiQY0ldqcIxr/OEfmP8KTstM6PYjMfh/SRZY+kFDY//
 7dzNPfo2G/KiLkkc8VJwND5u91bXHZlVgHSHd4vByF+Aqkt3rg9OE/PdTRcqty1Oc3
 EumQvRj/n5pKsqCeLGmp/bgi0Uh3OlchnvWhwjjYyPhBHRwFYpUEYZ0GGGFB1xi/Eg
 zZLZ9AaV3uRpJUfrdWxg1dfjSjkZLUspKJrW6wxb+up5GyWBKFklw1HD/BF6UZE+iD
 aBwQ3mc0DPJkc1TBsc1lkZ80snrfArwDy5lPTHm6DIli4cNdLY5PBvuB3m/WgQXc0u
 2UssvkLG78lnouihQOz5UkW/Zj38pKZWwFYMUCW2bZOgmbGVPcBQFWm7vVK3nLAH9M
 742m0yCaNk+NY6prcRLuZayg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Yegor Yefremov <yegorslists@googlemail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Javier Tia <javier.tia@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] .gitignore: add vpl/
Date: Mon, 29 Dec 2025 17:10:45 +0100
Message-ID: <20251229161045.177883-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Directory vpl/ only contains generated files. Git should ignore it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 2bf86a6b5d6..e5d22dbe8e9 100644
--- a/.gitignore
+++ b/.gitignore
@@ -70,6 +70,7 @@ fit-dtb.blob*
 #
 /spl/
 /tpl/
+/vpl/
 /defconfig
 /generated_defconfig
 /Test*
-- 
2.51.0

