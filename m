Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE1ECD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:33:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732A68481F;
	Fri, 15 May 2026 22:33:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aL15n6vL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B625784694; Fri, 15 May 2026 22:33:33 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C29A84812
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dea1272943so178154a34.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877210; x=1779482010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkggH63DXB/H8Omit3u2Gx5HjXEYQf3dPQMSpLjEuC8=;
 b=aL15n6vL7SgWh1ZK+JjYNG5xIneVJen4kJpnkec3R3pg1rofVmfjY0amGAkAkPvVG8
 RXVIrpSPVWisCaY9mQS6mqnsuq/FZatjMb0/fSQSoncoiHQaGL2o8m1+iFZ5QAARTHdt
 7w3kzhwtHRIzyH63No6PiwnoThqc71y+pxs6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877210; x=1779482010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NkggH63DXB/H8Omit3u2Gx5HjXEYQf3dPQMSpLjEuC8=;
 b=af/TzEGcZ0+x/D7DezWaHl4DkjEkUhXvJQM1IN7T3KITwa7gT1ywGJRo0oV47MLisQ
 VmJKnCrZ+9gxhz2Ud+JObPuERlx5jcICSiuKwA7SrnjzgF51eRtx4sf1SnE8NGgm9B2N
 1/wcY89J7/yVq6ZcNohLKccB5mEwm80SnoKx4IJTqyxGjNtSTTjTCihKSvtrY2F/h3Jx
 IbNEOqJ8NPvtT26N5/mAobauaWaqbfBV3P8aAGP2CR21tD9JE8CNvDtIsScbLQ0vLW3x
 2Tjat4DmyOGcnqXm7EMRbBQhZBW69Ha3TNTPW6A+JZ6h/llJc1BQ5ZekhqNRlBAhFNzU
 FmpQ==
X-Gm-Message-State: AOJu0Yzb6vameUdNUt2PaNTZZRBH6eK/P0qb27OE4NM2eaN6w0KPLhwv
 SeEFeQQ9vH6Nixitsl5bbv97E8eMYhshDny0inzcxW3GIDoyG1SF8GGELOCqY7TNzNWbiAgMEzp
 5exgB8A==
X-Gm-Gg: Acq92OH8+vmYY8yUDM6GSDNNqW+DbJr8ElpCm4wIzTOVj0ByJDizgt9W25Rasg2TVSo
 gjP0DgNMFcm7zgDX04FgaX8eXKKqX+XvyiRBxwvKHI8JQ4zvs8Ljufb6aWDEXeTv95gP1rIHIEP
 qTQueB6CoKDmaXjfTXf1LPqrHFdi/rHAP0l+Vlxykp1jkyYDcYdaG62v+SwE1YfCv9SyboqCk+M
 DDTrSP7GR43E6mnqCEcLiUro/RxRayq+L5cI4IYpVfRwIRy6dBRCnc3/xK0GJY16WGgtDBfSRHj
 pD5EO955NTbD9hgqbjXorZQrWBawQjd55bvgouAu8nw0YFh8qhOioZ35k1paMnogiMcKPzjw1JI
 dDcmhAXUVJKTF42HwzmwwQZzKU9AhXGbxF2gUIVawDS+rTTu2a1/m0dyADYUiqR7LZMmnzboLsX
 EekHQ/VlL7Ew7srLdc1nf86nr4f962
X-Received: by 2002:a05:6830:6689:b0:7dc:d0e3:5bdd with SMTP id
 46e09a7af769-7e4f2ba16d0mr3703073a34.19.1778877209759; 
 Fri, 15 May 2026 13:33:29 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 01/11] lib: string: Add strlower()
Date: Fri, 15 May 2026 14:32:52 -0600
Message-ID: <20260515203311.2555651-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

Add a helper that lower-cases an ASCII string in place. It returns
the input pointer so calls can be chained:

    do_thing(strlower(name));

A new test in test/lib/string.c covers the basic cases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/linux/string.h | 12 ++++++++++++
 lib/string.c           | 10 ++++++++++
 test/lib/string.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index a8a6cf4af50..15efe0ff5dd 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -49,6 +49,18 @@ int strcasecmp(const char *s1, const char *s2);
 #ifndef __HAVE_ARCH_STRNCASECMP
 extern int strncasecmp(const char *s1, const char *s2, __kernel_size_t len);
 #endif
+
+/**
+ * strlower() - Lower-case an ASCII string in place
+ * @s: The string to convert
+ *
+ * Walks @s and replaces each character with its lower-case equivalent.
+ * Returns @s so the call can be chained, e.g. ``foo(strlower(buf))``.
+ *
+ * Return: @s.
+ */
+char *strlower(char *s);
+
 #ifndef __HAVE_ARCH_STRCHR
 extern char * strchr(const char *,int);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 302efe048b0..8464366dac9 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -65,6 +65,16 @@ int strcasecmp(const char *s1, const char *s2)
 	return strncasecmp(s1, s2, -1U);
 }
 
+char *strlower(char *s)
+{
+	char *p;
+
+	for (p = s; *p; p++)
+		*p = tolower(*p);
+
+	return s;
+}
+
 char * ___strtok;
 
 #ifndef __HAVE_ARCH_STRCPY
diff --git a/test/lib/string.c b/test/lib/string.c
index f56c2e4c946..598be1101a1 100644
--- a/test/lib/string.c
+++ b/test/lib/string.c
@@ -298,3 +298,30 @@ static int lib_strim(struct unit_test_state *uts)
 	return 0;
 }
 LIB_TEST(lib_strim, 0);
+
+static int lib_strlower(struct unit_test_state *uts)
+{
+	char buf[32];
+	char *p;
+
+	/* Mixed case is fully lowered, returns @s */
+	strcpy(buf, "SHA256");
+	p = strlower(buf);
+	ut_asserteq_ptr(p, buf);
+	ut_asserteq_str("sha256", buf);
+
+	/* Already lower-case is unchanged */
+	strcpy(buf, "abc");
+	ut_asserteq_str("abc", strlower(buf));
+
+	/* Non-letters and digits pass through */
+	strcpy(buf, "Hello, World! 1234");
+	ut_asserteq_str("hello, world! 1234", strlower(buf));
+
+	/* Empty string */
+	strcpy(buf, "");
+	ut_asserteq_str("", strlower(buf));
+
+	return 0;
+}
+LIB_TEST(lib_strlower, 0);
-- 
2.43.0

