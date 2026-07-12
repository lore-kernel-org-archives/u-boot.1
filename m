Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567F5C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 14:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF949848A1;
	Sun, 12 Jul 2026 16:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qmnFV0A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B6884A3C; Sun, 12 Jul 2026 16:07:35 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE0F84A29
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 16:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so4288960a12.0
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783865253; x=1784470053; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OH1n70kzMz4UJg5Nlco49MXxe1oXmY1Dhm9Tf86YZ9Q=;
 b=qmnFV0A/xX86fwX2maAnDoJBGbjzG3HXLO0QqsaxqtpKUP3xQwHK+abphuBjATQzHf
 xLIoVakeMEIp8NoroONV56TRAvFR0pSPdO7f1+oyU2gxfFjBN8JdgsDrmaEHoW6RXWFl
 UbfdNAAYbiQGARDAuttD9YiUM8ehnaMwDPEXrM+6iNexpcpnHW2IYyhdNPCe3PTujnt5
 hud45Sm7DwhimmCJlIhpk2fdnI2MBejXNomZaE2kbqJaoHygSvHOd+PhSlPm4qLPUjFb
 L72FBOwb+Da0j7htVlMIyyuHuJNV6pFZO0shdOsHXnCwHJfBZ/q8z+uF+XUDPfmkKCql
 gFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783865253; x=1784470053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OH1n70kzMz4UJg5Nlco49MXxe1oXmY1Dhm9Tf86YZ9Q=;
 b=A8g4pr40B+bku8Bo+PqARgeWNNiLr2xFd3JBkg4Wz4vhwRSjncYYd1IgYE5p2aq4q2
 qfELrbJ6A8JsRtWFWKB/IQQsXCyHS+MZV73JHPHSwDe0tq5yHfso5h4QF5Ge6Z+ciXqu
 OPEjTEM8xiwUaxZlO+ihkQnRkkSzCD72TnJ0Dn34TOYVdsHU+74FnZQszE0i2nNbi0rT
 4+C2IOzEM0FWy1X5dwUYtMrOEvFGVu12Denbf0rM92mzNaxZLbg81pX9YaEIQDvlLuY6
 M6ZaDEyCdszismSuIZHnzMRbBpQyHmBJdbxjq90YXekYeNPdq4323c00yIdVs3VefgR8
 Be3A==
X-Gm-Message-State: AOJu0Ywuw1RLTsdRZrTQUJLGBab4fo7FeU45JQER3G+4AsCLXMoOV4FH
 Pf88fz5r6thdhAgzwfpOOcs5OfGUw5q16h/xzLJnIFIIbb2oKY1nG8pK
X-Gm-Gg: AfdE7cmQRwAAfpLYfzUZT+buLBh9JlQjZFL6x/cPiXkZ2dkq3uQHMICk4semFFuXpvr
 plBNSQyj76+32oxrKjTHswkdSWLbPvJuvGRmVlkhtVN/6+sR3A929nZI2Az9zsLS1tqSkvJBOKw
 VH7+NlAlnXvnI4yext/PclMhSHHKnm3F0osw7IiPWMLevWcyAOtuIG8kb19JKY6Jes82D6+5q4n
 NF/YQPhxJ4kuzdukzZOIKCIX7DeACmWJe0wCPrSeCrhy5eyP/g9tT7a0UQYdLd2vkPPFC54Ku+v
 w72GyaQwkvZ4w7ErfiJekvxWK03YcYW3ytA0UHdeuDjF7GBp1Vf7HxrjfEADyMyuVmms6ZHI6V1
 ixUxoa/Kh9QQsz9GEvAwTf97sDHV0b1zfidwQxrcmlpEcN3sYAzdB0TNXA12QAS8W/kbxYivkT3
 rn1ANt1WnsrMM/iUsI5mPox+bTv/ExqHcgHng53KeQMfRIgGDPSWm2DOwH5feIGYeSV/WvwTVgv
 LmSLqPh
X-Received: by 2002:a17:906:f5a1:b0:c16:1579:762b with SMTP id
 a640c23a62f3a-c161f3b54ecmr216799666b.52.1783865252979; 
 Sun, 12 Jul 2026 07:07:32 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15e41121d2sm492856166b.47.2026.07.12.07.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 07:07:32 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 12 Jul 2026 16:07:11 +0200
Subject: [PATCH 2/2] doc: android: refresh AVB provenance and pin libavb
 reference
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-avb-libavb-1-3-v1-2-44a50dfe2f23@gmail.com>
References: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
In-Reply-To: <20260712-avb-libavb-1-3-v1-0-44a50dfe2f23@gmail.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
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

Note that verification is performed by the libavb copy vendored under
lib/libavb/ (AVB version 1.3.0) and which parts are U-Boot-specific, and
pin the README reference to the exact upstream commit the vendored copy
corresponds to instead of a moving master branch.

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 doc/android/avb2.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index 4aca7a5c660..178e8a2681e 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -22,6 +22,11 @@ Verified Boot establishes a chain of trust from the bootloader to system images:
 
 Integrity of the bootloader (U-Boot BLOB and environment) is out of scope.
 
+Verification is performed by libavb, which is vendored under ``lib/libavb/``
+from the AOSP ``external/avb`` project (AVB version 1.3.0). Only the U-Boot
+integration in ``common/avb_verify.c`` and the platform port under
+``lib/libavb/avb_sysdeps*`` are U-Boot-specific.
+
 For additional details check [1]_.
 
 AVB using OP-TEE (optional)
@@ -135,5 +140,5 @@ partition table::
 References
 ----------
 
-.. [1] https://android.googlesource.com/platform/external/avb/+/master/README.md
+.. [1] https://android.googlesource.com/platform/external/avb/+/a1fe228b86543a21739c51352f5ce72f134fccfa/README.md
 .. [2] https://www.op-tee.org/

-- 
2.53.0

