Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F590606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Az70OJkJ;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gEflWjAr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78C92608F6;
	Thu, 22 Oct 2026 16:20:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0mN20Rpd4jcL; Thu, 22 Oct 2026 16:20:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 03E8D6084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792686040;
	b=iumrHsDeXzlaGz72nf86ABsGy7/s55qcslBRiHIP9tplnjEjJa6JSadBVOatyHgqHjMR
	 NT0T2MQf+6Akql96XAa9jBhsilrjC10pJOtvjf9mZ5pnvXUtfkTjW5Vj9sNskCTDHLk/H
	 ViqiXJJ7dOR7JWxuUuWOnyELcO5GtbCpeOPHX0kQ4zM6izUNgkM4s0gSPS0xpZfDgtvf4
	 tVoiUTV67Jc8oezvj2uNLyNZYkx7xU8V4qYY6ofEbxtqB09YBCmRy4MF7xiILR7jd6cKR
	 pIWJTfNP/nj2HIj3cYJYqw58Iw+uB+sCsFg1cpU5ifa6FV9SRJ0nvyiRQrxwICq5gKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792686040;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
	b=bY78ppdyQ4CSJD2tg9QMB4ox4+ehR4Lp1mvdyzFddkgXUAaCyUSrS8yt0lK54ghw5/Og
	 2iaQNWA0bERYfVQKh+2MjrD8qhx4rXR382Bv5ZgOeHY9KKTy/2tz1tXf0Ocruw2H7RxQc
	 LFePd9uvbfh+FYdCnTMsSsQzX/icUq6JJK6kHUsecpuNnb6fU1IohjBjgFBkFjehs3vy+
	 0RrmkgCPPZ7iNj0vXcMH8DFt3M3YZWkMPMo3wjE/ccrcfcVGClkHkrp76fNtN8WQ0C8f4
	 zx4de/RbXKOP+KqcTSMzLxZWRIHD+AskURudHC2Jv9wYbQudYPy+vvpWyqikH1IVNsA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gEflWjAr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792686040;
	bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Az70OJkJdsX3Qt9968aua+NpCuHsv8SG3yoqYQI4jNGGnTyQ7noQn0Y3JtADWUEhW
	 rIneDS35DPv6QH35y0QSaOpv1mJuugToBoMRL5m7biAFV7t/yMBjYf4W4K00nuQdm0
	 J5NK/v4gdcHLgJ++lZKlfv2x4NytnRtB2FoGwYwObgU2SkrfYGhkzvKxCM/7VpGhRu
	 DS2ZXh/O8o3dkBZURjTzVGM/GQ7l++pHhS/rGaS6el6c1sWN/4xvnLwUl35ORLLSE9
	 pr9omPf0LOoa6m3QH45S0SGtmvKhKDFW0l4IjFLx66MmqFOYOxrARvFaUd1+bIsSy/
	 ZzbvMPn+KA7OQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03E8D6084A;
	Thu, 22 Oct 2026 16:20:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0332F3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD57E6084A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8eqybwUzWrrM for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:20:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 227FA6089D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792686034;
 b=JEJ9OZQQst/1GlWiSiTN5Ah2kGwmzo+3Bx9DjkABNb8UZRoGRH0AlXyGlFzDvITjuZhw
 f6niAboOtQIFiqG0rDRhG2cJunvSFdzzbW5EINO360SZDUEifqE6xGc2cggbJREHDkpNL
 Tk8hJgIQcf9mbRB3YYShWJmHu6d+s1MsGHvVWHIN7OD5zrmtAQlrTmRjhWZOirUQo5ZSC
 MfanZhIOXF9ajrr6oxM7hVHQYfv6Hk6BGBrdQkiI7hV8By4EoY+AOqbQ8XYfdYZQN8URC
 X4V0Dj9uB4LWRvhQOpPh2FOgabMj2QwbWlAxAGBAV/ZDr/CdEGGijh3Z1pWvofP+0yA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792686034;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
 b=HA+7pX4a+NXPTTmtJnU6N3shFfOHUMAAlw2265rcQ8PTHRVfQB1O454wtVm99XjXVZEE
 g9icf1fvfFcGZPkogYwcc7Ax6EPqpHpikoqY5DBbdKBB4v2A2/2z+qDU4AIkApJUTdipy
 ZVJJVj0X73qek2UCf1hzLpjlZTVnkOyetj3s/oZdMT2stNbRzbs9JMIVHL/+2fg9CcMHd
 XfiisL1UWnO8IsQA1pf9ZJ3NfEnOsZoTmJtHOUKN/bURsaitNd8n08tf8S1vDvFFbDVQ8
 7RkdGL62/KiK7KLDTeHo3Wyg4y6WqwTet7FG6aP3NRGsy8UnoI6vjGI1s05POs7UgUw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=gEflWjAr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=gEflWjAr
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 227FA6089D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:20:33 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso21623655e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792686032; x=1793290832;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
 b=gEflWjArXydWqCl2yVAFggiuQIxj22gEpWo+UA3mjjiYtBRz6+WwQnXCcjLH8KYYwc
 bvASFKtlLHNVPzyXM2avrPUbL8uuAvlbbJx7+qix342G8v8wEemZRjaC1GfS+yGjebKy
 +4JTIllbAI47B7QThyJKAT4nrEZiMwDIbMPa2xkO82v06UCVULpHU+pC9wNZqFHGx2Zy
 glhE2aLC2wIeUxKkfX92bM3xr3s65VZx203ah518KI/iD+iCs7/URX18vSRePLM7PqE5
 kzAjW3ve+VlZvQcvAmY6aRX3OdYqJ3UgMoJ34R6CiDUN6nnO2DFju9g9YHWRW4dWW2CN
 9jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792686032; x=1793290832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K2jFAEKWkENNtsCV3CcUqwGAw7ytDfhxgnsfKmwKD2M=;
 b=CBVgx/bkkoFq61K2U8r5wJQ+U2NgXLv5VRjqlOk77wX8P+puIIrT6gJVsQwHBWrasi
 SesTr/CU+mlQNDh5OveAr28mroaym4EJ9ivvaGiOzDLRYQzg0w8WUctUpATrX/B9J9ML
 psHUehoonfQM8cutvcixzO1c5bkUeYqA8BUPcmBJzSsNyDQJyAma0hYw7kH/V6nA7/x/
 Z2fq+3D6iYkeoQp9bhzzdJl9f+Ut3tbT8yQJkoEJd36+gCLGXM2U8V5WfF4CR8k6KPEU
 hjQfP7kKzt8Kj5dd4DaH0jTFmnxOBSm+FG28QuID8kieV+IgtCU75Z3Gz23WpKy9jgA4
 0ziA==
X-Gm-Message-State: AFq9FYKuoDjbUPUJz3FWI6JP3ZyAP1earxV6wi5bRysxaojX8wFklFZY
 BpS1t+g5QL9GmgYu4Jd5alb2796A4QxH98hiGaCs5nJQX4SNpzKI7kKeAAH96DKmPuY=
X-Gm-Gg: AYBFou0ojnsSLNwACgiQ0Il9+WAe0WhSg1tryaizNA7iFr/kcCR/vD5HmxHwnNxFWuG
 9vnV+Lmr8h+udyaIyHphqo0k4j1/i/V8gUU3rb2P+0iLNCjLOTbfnM4NparcPtU1mQtUjv8W/Hf
 bEQncZ1zzkKq8FDXTZgK/7bzJIRkMG0Q3ixP5l+kxiOfDoXGRDqRLJAlO7suKn2pHocTtY5HFpQ
 qXLhhLvbyGGlJ++Q8cBnib+PPz0ccpaQ71GLrr034iagrLu6P6nyjIsvXSJe5TE+dTDxsZuqF2m
 LGFvv2i2z2UnsQt3JXdlWY13Y0qHrbNz3K8dzqqKxk9oacqrLF0ZRZVFmTrlpv2WzOF9XG4Dscw
 S2qfYrTvlp2syk+DOaXDxuJo1t69Jp9YwftWMk4x9ZTEosEmYqa8KsGWKAFk3OnezB68Bd/5rot
 CXdVTncE2BK944pIhWQ6R247YtVYw5jZb42oQ8LhVTyMrn/BUhsrT3HzoJ61jF5B+v6ruECo2vu
 3OUPQCbSWgIsdtby1xWeDzsWZmTFupXUVRyRIF74IAzmnJK8iK2+q4chqn19oZl/0q9Z/oc4Csq
 9scBX7FCIcOUhQP0SIRUzojIqLp8vA==
X-Received: by 2002:a05:600c:2d56:b0:4a2:fd2:9855 with SMTP id
 5b1f17b1804b1-4a20fd29d25mr6618025e9.13.1792686031691; 
 Thu, 22 Oct 2026 09:20:31 -0700 (PDT)
Received: from [127.0.0.1] (mob-83-225-32-96.net.vodafone.it. [83.225.32.96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029928fsm6905905e9.3.2026.10.22.09.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 09:20:31 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Thu, 22 Oct 2026 18:20:15 +0200
Subject: [PATCH v2 5/5] test: py: cover fdt fit preparation and failure
 handling
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-ccaione-upstream-fdt-fit-v2-5-4140e0c4d5a9@baylibre.com>
References: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
In-Reply-To: <20261022-ccaione-upstream-fdt-fit-v2-0-4140e0c4d5a9@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 E Shattow <e@freeshell.de>, David Lechner <dlechner@baylibre.com>, 
 Ahmad Fatoum <a.fatoum@barebox.org>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Boot scripts rely on fdt fit either returning a complete, verified
devicetree or failing without touching the destination. Regressions
could otherwise leave a script with an incomplete tree or overwrite
memory before an error is reported.

Add sandbox coverage for successful preparation and failure cases,
including overlay order, compression and FIT load addresses. Check
that verify=no cannot bypass required signatures and that
individually signed configurations cannot be chained into a new
combination.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/sandbox_defconfig     |   1 +
 test/py/tests/test_fdt_fit.py | 371 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 372 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f307972a762..cd44c42d954 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -65,6 +65,7 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_BOOTM_OPENRTOS=y
 CONFIG_BOOTM_OSE=y
 CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_FDT_FIT=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_ERASEENV=y
diff --git a/test/py/tests/test_fdt_fit.py b/test/py/tests/test_fdt_fit.py
new file mode 100644
index 00000000000..3a039b32515
--- /dev/null
+++ b/test/py/tests/test_fdt_fit.py
@@ -0,0 +1,371 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 BayLibre SAS
+
+"""Test the 'fdt fit' command
+
+Build a FIT holding a base devicetree and two overlays, with configurations
+which combine them, then check the devicetree produced for each
+configuration and that images failing to load or verify are rejected.
+"""
+
+import gzip
+import os
+import shutil
+
+import pytest
+import fit_util
+import utils
+
+FIT_ADDR = 0x1000000
+DEST_ADDR = 0x2000000
+
+BASE_DTS = '''
+/dts-v1/;
+
+/ {
+	model = "fdt fit test";
+
+	test-node {
+		base-prop = "base-value";
+		order = "base";
+	};
+};
+'''
+
+OVERLAY_DTS = '''
+/dts-v1/;
+/plugin/;
+
+&{/test-node} {
+	%(name)s-prop = "%(name)s-value";
+	order = "%(name)s";
+};
+'''
+
+FDT_IMAGE = '''
+		%(name)s {
+			data = /incbin/("%(fname)s");
+			type = "flat_dt";
+			arch = "sandbox";
+			compression = "%(compression)s";
+			hash-1 {
+				algo = "sha256";
+			};
+		};
+'''
+
+CONFIG = '''
+		%(name)s {
+			fdt = %(fdt)s;
+			%(sig)s
+		};
+'''
+
+SIGNATURE = '''signature {
+				algo = "sha256,rsa2048";
+				key-name-hint = "dev";
+			};'''
+
+def make_test_fit(ubman, basename, sig, compress_base=False):
+    """Create a FIT with a base devicetree, two overlays and configurations
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        basename (str): Base name of the FIT to create
+        sig (str): Signature node to add to each configuration, or ''
+        compress_base (bool): Compress the base devicetree with gzip
+
+    Returns:
+        str: Filename of the FIT
+    """
+    images = {'base': fit_util.make_dtb(ubman, BASE_DTS, 'fdt-fit-base')}
+    if compress_base:
+        compressed = images['base'] + '.gz'
+        with open(images['base'], 'rb') as inf, gzip.open(compressed, 'wb') as outf:
+            shutil.copyfileobj(inf, outf)
+        images['base'] = compressed
+    for name in ('ov-a', 'ov-b'):
+        images[name] = fit_util.make_dtb(ubman, OVERLAY_DTS % {'name': name},
+                                         f'fdt-fit-{name}')
+
+    configs = {
+        'conf-base': '"base"',
+        'conf-a': '"base", "ov-a"',
+        'conf-ab': '"base", "ov-a", "ov-b"',
+        'conf-b': '"ov-b"',
+    }
+
+    its = '/dts-v1/;\n\n/ {\n\tdescription = "fdt fit test";\n'
+    its += '\t#address-cells = <1>;\n\n\timages {'
+    for name, fname in images.items():
+        compression = 'gzip' if name == 'base' and compress_base else 'none'
+        its += FDT_IMAGE % {'name': name, 'fname': fname,
+                           'compression': compression}
+    its += '\t};\n\n\tconfigurations {\n\t\tdefault = "conf-base";\n'
+    for name, fdt in configs.items():
+        its += CONFIG % {'name': name, 'fdt': fdt, 'sig': sig}
+    its += '\t};\n};\n'
+
+    its_fname = fit_util.make_its(ubman, its, {}, f'{basename}.its')
+    fit = fit_util.make_fname(ubman, f'{basename}.fit')
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(ubman, [mkimage, '-f', its_fname, fit])
+
+    return fit
+
+def corrupt_overlay(ubman, fit, basename):
+    """Copy a FIT, changing the data of the ov-b image but not its hash
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        fit (str): Filename of the FIT to copy
+        basename (str): Base name of the copy
+
+    Returns:
+        str: Filename of the copy
+    """
+    with open(fit, 'rb') as inf:
+        data = inf.read()
+    assert data.count(b'ov-b-value') == 1
+    out = fit_util.make_fname(ubman, basename)
+    with open(out, 'wb') as outf:
+        outf.write(data.replace(b'ov-b-value', b'ov-b-evil!'))
+
+    return out
+
+def load_fit(ubman, fit):
+    """Load a file into memory at FIT_ADDR and clear the destination"""
+    output = ubman.run_command(f'host load hostfs - {FIT_ADDR:x} {fit}')
+    assert 'bytes read' in output
+    ubman.run_command(f'mw.l {DEST_ADDR:x} 0 400')
+
+def fdt_fit(ubman, args):
+    """Run 'fdt fit' and report whether it succeeded
+
+    Args:
+        ubman (ConsoleBase): U-Boot console
+        args (str): Arguments for the command
+
+    Returns:
+        tuple:
+            bool: True if the command succeeded
+            str: Command output
+    """
+    output = ubman.run_command(f'fdt fit {args}; echo rc=$?')
+    return output.rstrip().endswith('rc=0'), output
+
+def get_test_node(ubman):
+    """Return the test node of the devicetree at DEST_ADDR"""
+    ubman.run_command(f'fdt addr {DEST_ADDR:x}')
+    return ubman.run_command('fdt print /test-node')
+
+def check_dest_untouched(ubman, addr=DEST_ADDR):
+    """Check that nothing was written to a cleared destination"""
+    output = ubman.run_command(f'md.l {addr:x} 4')
+    assert '00000000 00000000 00000000 00000000' in output
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+def test_fdt_fit(ubman):
+    """Test loading the devicetree of a FIT configuration"""
+    fit = make_test_fit(ubman, 'fdt-fit', '')
+
+    with ubman.log.section('Default configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x} {DEST_ADDR:x}')
+        assert ok, output
+        assert "Using 'conf-base' configuration" in output
+        node = get_test_node(ubman)
+        assert 'base-prop = "base-value"' in node
+        assert 'ov-a-prop' not in node
+
+    with ubman.log.section('Overlays applied in order'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert ok, output
+        node = get_test_node(ubman)
+        assert 'base-prop = "base-value"' in node
+        assert 'ov-a-prop = "ov-a-value"' in node
+        assert 'ov-b-prop = "ov-b-value"' in node
+        assert 'order = "ov-b"' in node
+
+    with ubman.log.section('Chained configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman,
+                             f'{FIT_ADDR:x}#conf-a#conf-b {DEST_ADDR:x}')
+        assert not ok
+        assert 'Chained configurations are not supported' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Length'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x} 4000')
+        assert ok, output
+        ubman.run_command(f'fdt addr {DEST_ADDR:x}')
+        output = ubman.run_command('fdt header get size totalsize; echo $size')
+        assert output.splitlines()[-1] == '4000'
+
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x} 10')
+        assert not ok
+        assert 'aborting' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Missing configuration'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-none {DEST_ADDR:x}')
+        assert not ok
+        assert "Could not find configuration node 'conf-none'" in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Corrupted overlay'):
+        bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-bad-overlay.fit')
+        load_fit(ubman, bad_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert not ok
+        assert 'Bad hash value' in output
+        assert 'load of ov-b failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Missing overlay'):
+        missing_fit = fit_util.make_fname(ubman, 'fdt-fit-missing.fit')
+        shutil.copyfile(fit, missing_fit)
+        utils.run_and_log(ubman, ['fdtput', '-t', 's', missing_fit,
+                                  '/configurations/conf-a', 'fdt', 'base',
+                                  'ov-missing'])
+        load_fit(ubman, missing_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-a {DEST_ADDR:x}')
+        assert not ok
+        assert 'load of ov-missing failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Not a FIT'):
+        load_fit(ubman, fit_util.make_fname(ubman, 'fdt-fit-base.dtb'))
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x} {DEST_ADDR:x}')
+        assert not ok
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Usage'):
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}')
+        assert not ok
+        assert 'Usage:' in output
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('fdtput')
+@pytest.mark.parametrize('compress_base', [False, True])
+def test_fdt_fit_load_addr(ubman, compress_base):
+    """Ignore FIT load addresses, including before an overlay failure"""
+    if compress_base and not ubman.config.buildconfig.get('config_gzip'):
+        pytest.skip('gzip support not enabled')
+
+    fit = make_test_fit(ubman, 'fdt-fit-load', '', compress_base)
+    utils.run_and_log(ubman, ['fdtput', '-t', 'x', fit, '/images/base',
+                              'load', f'{DEST_ADDR:x}'])
+
+    with ubman.log.section('Load address equals destination, bad overlay'):
+        bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-load-bad.fit')
+        load_fit(ubman, bad_fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+        assert not ok
+        assert 'load of ov-b failed' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Load address equals destination, short length'):
+        load_fit(ubman, fit)
+        ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-base {DEST_ADDR:x} 10')
+        assert not ok
+        assert 'aborting' in output
+        check_dest_untouched(ubman)
+
+    with ubman.log.section('Only the requested destination is written'):
+        load_addr = 0x3000000
+        utils.run_and_log(ubman, ['fdtput', '-t', 'x', fit, '/images/base',
+                                  'load', f'{load_addr:x}'])
+        for conf in ('conf-base', 'conf-ab'):
+            load_fit(ubman, fit)
+            ubman.run_command(f'mw.l {load_addr:x} 0 400')
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#{conf} {DEST_ADDR:x}')
+            assert ok, output
+            node = get_test_node(ubman)
+            assert 'base-prop = "base-value"' in node
+            order = 'base' if conf == 'conf-base' else 'ov-b'
+            assert f'order = "{order}"' in node
+            check_dest_untouched(ubman, load_addr)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_fdt_fit')
+@pytest.mark.buildconfigspec('fit_signature')
+@pytest.mark.requiredtool('dtc')
+@pytest.mark.requiredtool('openssl')
+def test_fdt_fit_signed(ubman):
+    """Test 'fdt fit' with a required configuration signature
+
+    This restarts U-Boot with a control devicetree holding the public key,
+    so it must run on sandbox.
+    """
+    keydir = fit_util.make_fname(ubman, 'fdt-fit-keys')
+    os.makedirs(keydir, exist_ok=True)
+    key = os.path.join(keydir, 'dev')
+    utils.run_and_log(ubman, f'openssl genpkey -algorithm RSA -out {key}.key '
+                      '-pkeyopt rsa_keygen_bits:2048 '
+                      '-pkeyopt rsa_keygen_pubexp:65537')
+    utils.run_and_log(ubman, f'openssl req -batch -new -x509 -key {key}.key '
+                      f'-out {key}.crt')
+
+    vboot_dts = os.path.join(ubman.config.source_dir,
+                             'test/py/tests/vboot/sandbox-u-boot.dts')
+    dtb = fit_util.make_fname(ubman, 'fdt-fit-u-boot.dtb')
+    utils.run_and_log(ubman, ['dtc', vboot_dts, '-O', 'dtb', '-o', dtb])
+
+    unsigned_fit = make_test_fit(ubman, 'fdt-fit-unsigned', '')
+    fit = make_test_fit(ubman, 'fdt-fit-signed', SIGNATURE)
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    utils.run_and_log(ubman, [mkimage, '-F', '-k', keydir, '-K', dtb, '-r',
+                              fit])
+    bad_fit = corrupt_overlay(ubman, fit, 'fdt-fit-signed-bad-overlay.fit')
+
+    old_dtb = ubman.config.dtb
+    try:
+        ubman.config.dtb = dtb
+        ubman.restart_uboot()
+        ubman.run_command('setenv verify no')
+
+        with ubman.log.section('Signed configuration'):
+            load_fit(ubman, fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert ok, output
+            assert 'sha256,rsa2048:dev+' in output
+            node = get_test_node(ubman)
+            assert 'order = "ov-b"' in node
+
+        with ubman.log.section('Chained signed configurations'):
+            # Each is signed, but no configuration lists base plus only ov-b
+            for first in ('conf-a', 'conf-base'):
+                load_fit(ubman, fit)
+                ok, output = fdt_fit(ubman,
+                                     f'{FIT_ADDR:x}#{first}#conf-b {DEST_ADDR:x}')
+                assert not ok
+                assert 'Chained configurations are not supported' in output
+                assert 'dev+' not in output
+                check_dest_untouched(ubman)
+
+        with ubman.log.section('Unsigned configuration'):
+            load_fit(ubman, unsigned_fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert not ok
+            check_dest_untouched(ubman)
+
+        with ubman.log.section('Signed configuration, corrupted overlay'):
+            load_fit(ubman, bad_fit)
+            ok, output = fdt_fit(ubman, f'{FIT_ADDR:x}#conf-ab {DEST_ADDR:x}')
+            assert not ok
+            assert 'sha256,rsa2048:dev+' in output
+            assert 'load of ov-b failed' in output
+            check_dest_untouched(ubman)
+    finally:
+        ubman.config.dtb = old_dtb
+        ubman.restart_uboot()

-- 
2.56.0

