Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7F4CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:14:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1D6848D8;
	Thu, 28 May 2026 19:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hQc2FP9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBFC84886; Thu, 28 May 2026 19:11:43 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F85084878
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e615efd7d7so4954494a34.2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988300; x=1780593100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbQSqalrJsBVWHko+o0MIe5jEV8qUgWDJRKtFf9Aid0=;
 b=hQc2FP9QGolx26sgPn34ZWTnzfBR6mlQFcwEGqcAjOUdxl75CTS5kTS6QEvFIuput9
 DOj+ySezmnjbzCzpGV+BOgs+eSyo/qioo6FJdQzUCgWdbMLFsU5su/v4O3P2AAPZBPCz
 7P9xuoe2etCxPxNKt32Yn2xd12mZy5v4XcCiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988300; x=1780593100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbQSqalrJsBVWHko+o0MIe5jEV8qUgWDJRKtFf9Aid0=;
 b=jG9PUlAMiKJEQKNUQO1enHtYNRHwV8KY5SyhJWkzOLLmUO+hqPphGs5FCG5XsijjHS
 KwzXqWWTpDQEz979FfL47gH43hizLIRuDoOjPaa1Qx3dnv8lI5R2VHIx9XMLRKzKDylR
 Ykvznbi3N0m93WXcLDPlChcOKcKmp0kCdcPyIyOVmvQT1rypp2heYk7/rpSgqKAcZNT5
 /qxC42BVOs/7hcVgryYPV/87fFW1xrAoDtmMp6U1Yzwmughfre/qjb0C4Vqk92jfydb/
 jVI/tWzVOGLGq4q8rA+K1gHShOmFt4r6H99XDAQ1wKWKR6GeTHWPyCjmR6UsNKyRm7dV
 Wsyw==
X-Gm-Message-State: AOJu0YzD/6ariO60DV/5PQAcDRyAJM9QfLcuvCK0r5baiLPnIhuC+Z0m
 V59y7ATnPIdhUBcWJ+oxt3m5s6DPmZh0y5Zj2rf4jFZzlVS3TBr3viEGxYiZatDaldnoH2yYYSu
 oMok9R2hbA4w=
X-Gm-Gg: Acq92OG+6B980GQlo8VrUXPBgU7uDzEqNhkGR2OpCblh0OFk9WFw41t/7ow1VQQtIMi
 WzwKOhPcpRuSv2jM9wCIN8tjybi39vlAiEPIZIg7X/gsMiJzVPeXGCqrSkYO1AhfBR9OTgbFMRa
 ZwstQvNGltsGyE+1ygjk2XYD6xS28hqAxKfVdAJP5CjZD94A4lB7hg/3Gr/PttRVTTr0JNQAGqP
 +gsokyQ1uo4MLLzUio3qNeZrN/tuZH4Ls69cWPcClqbay1BUjAkTLKTUXfMC5aMFKlNgPOV6JWp
 GfM8MBJ30cIN2+pNFIMy8rJhcPjGCkd8jux7XlvjNKfDz0HNX6yfwketlmI6DkS2JC8yk52MLiu
 Pq+Ixjjt2OF2a0BQXM7chBP9WCGpu8b7PJUWo1aOEDVBclIxJDYx20wHXfK02Hqq21Xp4GO0Jvj
 T38chv9W62xlwTtMY4xFtq6/XIoEQL
X-Received: by 2002:a05:6830:112:b0:7e6:1e3c:912 with SMTP id
 46e09a7af769-7e61e3c09a4mr9432789a34.2.1779988299980; 
 Thu, 28 May 2026 10:11:39 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 19/22] gitlab: Add an VBE board to the sjg lab
Date: Thu, 28 May 2026 11:10:26 -0600
Message-ID: <20260528171043.910264-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Add a rockchip rk3399 board which runs Verified Boot for Embedded.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 245e422d72f..234b1cfd07b 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -797,3 +797,9 @@ qemu-x86_64:
     ROLE: qemu-x86_64
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
+
+# Firefly-RK3399 board running the rk3399-generic build
+vbe:
+  variables:
+    ROLE: vbe
+  <<: *sjg_lab_dfn
-- 
2.43.0

