Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB1CD98E4
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F3484910;
	Tue, 16 Jun 2026 16:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DE6XzrdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A1C84908; Tue, 16 Jun 2026 16:25:08 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E08A84869
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-43cce34c881so3975299fac.2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781619904; x=1782224704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FT75yj94r+aYpHxkqZCksmOkk/Kg4ALEHgYlJ4XXwUw=;
 b=DE6XzrdGxBXzlFKZm2x7QwUAfqvJc9eert8GW/PPRYCPTrgbf87K9c6fpRPLNMy9eJ
 8pHhjAAE2fGVO69Bap9NsHUDeHSaZCcL8I+8wnWi6sd9FqcqXnCjPhQxH+AuIpoxN5sK
 gpUW+W9fFQnWbshSokdtQiFUUHVmc0Knro8xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619904; x=1782224704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FT75yj94r+aYpHxkqZCksmOkk/Kg4ALEHgYlJ4XXwUw=;
 b=WKViwABZOz2jEYlUPbltbrXOmqy/D8zO8Qtf+WcETlBz1+OdHapXW5OwDIc1iLNgLP
 WuifpzvGe9STF+vvci8EXAmwxCDN8SFQna2CfL//wVwOtAqSPe873l5RSK9Hl38GsnYL
 INVZasxAgF22y63xQBmqi7ioNMYTTbECjua8qVJb2BumXYmU6YyMoVqVsvuiXWROlVPg
 +SLF0K6cKg4yNmHTQV/jwjhhwyCRuSRg7Q+AnSND5YrD+PzD1jiH5mHp8g7z1iCfoPu5
 IE/C4BfZ/okZ+s8tSjkj1UaXR/4t22rW71Wi3+X8Ah9TztOAefr5YjDvjxmjimFV1CCK
 TmIQ==
X-Gm-Message-State: AOJu0YxLtKYPOyL/b1q215WGfgfaYeBZ8zk/J6c/Ym9emfB1cvDIhKI8
 PH1GXtxdTS2cEdsffuk4cgSvz4ABsDBQeBX8BMXAc2Lp1xeu5zj6Ur/+SKRpvN9DD6eDQ6sQfki
 J+OU=
X-Gm-Gg: Acq92OE6obGbgz1d+agXlMQyrScsU8cDpMQDaPdCeBuL9iBcCNl49HdKDd1u8C/pTcU
 CUYhmQ6AvSbh+qyX2hz/j6vrs114SKffpcZv3JWj86T5+Op63BlwDwpA2eo9xHCo29Qpb6aPeor
 I0UgiSrB5d3u/GWCs9IF0+1vPND4IyzNjHVBWZDfmIeooDlxqmxkcPbSN39d6xIKMZCWWEGsQ5n
 CBpqkpW7WLv6swTxdsENuXR9Zhvf4zoQfWRA7Runz8rIpsW4z4GgOcAbD0Y2ktFenAdw1E6tsEN
 gsfKbpXnlFA04RvcOONZJ2Q+bhc554yAo0KiZRNw3Vq8hAKvgRbNZJaSSX9PPKDMC5qddNIoZwv
 Q24LMJ6AUx4nnI4cty9r6+gR34qiTcxSa2t/3D+Q/eAoMkXCQ6lNnrzxqG2ECOWcC/wQ0qx1xRr
 r1gP1RtuQndDLWho7TVw==
X-Received: by 2002:a05:6870:70a7:b0:441:29df:3db8 with SMTP id
 586e51a60fabf-4430b2d1421mr3132932fac.6.1781619904318; 
 Tue, 16 Jun 2026 07:25:04 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430900e368sm2215230fac.16.2026.06.16.07.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:25:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/5] CI: Add an sjg-lab job for the Intel Edison
Date: Tue, 16 Jun 2026 08:24:19 -0600
Message-ID: <20260616142444.48193-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142444.48193-1-sjg@chromium.org>
References: <20260616142444.48193-1-sjg@chromium.org>
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

Add the Intel Edison (Merrifield/Tangier) to the sjg-lab CI matrix.
U-Boot is sent over DFU into the board's eMMC u-boot0 partition during
U-Boot's brief do_probe_dfu window, and a reset then boots it from
there. The lab environment handles the build and the DFU send, so the
job only has to name the role.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..b207a113383 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -797,3 +797,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
+
+# Intel Edison (Merrifield/Tangier); U-Boot sent over DFU into eMMC u-boot0
+edison:
+  variables:
+    ROLE: edison
+  <<: *sjg_lab_dfn
-- 
2.43.0

