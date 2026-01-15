Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14703D44C78
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 16:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D98683623;
	Thu, 15 Jan 2026 17:17:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QqKZVUX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627528367F; Thu, 15 Jan 2026 17:17:36 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43ECE80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 17:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3ff4acb6eebso746445fac.0
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 08:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768493853; x=1769098653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mLnI3cVE4EhMtv1xUT6bc2tAj9OmY6aBAXqnFICphfQ=;
 b=QqKZVUX/sIsV40xQvmioIYz8sKWTVYa8YZdh5vskUoHC6jx8a5KsAOicGPB6ztwJw6
 Yi+BNlbcPW6dIfPKmicUAH4EZx5oQqNIiMvPKdxAxmcE9bub/6BP7fvftU26dhHgvDXN
 XpmDtElM34sdYXY9Ay999sgyE5t2aN6WRQO1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768493853; x=1769098653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mLnI3cVE4EhMtv1xUT6bc2tAj9OmY6aBAXqnFICphfQ=;
 b=Z4bjj1do4WHTwv2mAR1hjgoXk2+fMnx8QebAREhg9xgM/SagYnQEcEGIJ+nPnVcCIo
 CdOKZXg3giu8xpK0XsA8Dw9IZPT6GJ8IDZHTE0QwT++kku74aRpT32HaBEXQQAUS7Qln
 xGeVGynswkQXaP+ktkDliXPSlRm7CCMLYc552bUhEZmAAZ+oSRlKKCBMd3JPznMcMPH4
 nBOmmTybzrAWpBJkWMbaIUR1icT9mIVjnGBhG4C6mYFViDZZUWlDI9AyvTMdypfsWPgP
 16lGUcWm+MO8Mx0J9vDMNV2I4l/ZUAZRwc9cF47Hi0qNXrlJ1p4C1jfCdy45wC2uFp0X
 ziwA==
X-Gm-Message-State: AOJu0YyYlocN9cy7igOvyfBdHL2xdFEfssPqcZ+8+i6BycrEkZUdwMMu
 8zrSyFmMPHfafDi5YUAJ4X52mpNr5K6O4Z9tEz03k4r9pHysFkNQhZ31RW8jooAyAMVb3HF/zqE
 lqSvpahE=
X-Gm-Gg: AY/fxX6WnY1xqH9FxtOE3VNLAgJ7kRm/DBt1mp9mfHKP3ZQfpIuswQ4EJc9wEt4zQqo
 P6Wy5WP2z7FqyCY/EEGzHK3Z7xYdYfB0Nw8h1AirUMHbNFFGkMHDOq7kwgQcm62bJzlQgOzLRyy
 EAQTOARZNYjQD+uU5PJ7lpp1ebldIVc+f49mgMmDYkLfEvtg2cqa4hUEn6B68NaVQejawHrtPU0
 uBxDY0rA4ool2FFEdJVprjHyZiXVxn0GGjt5QwqpaVPUBKek7dUFnlmnGYfYKuw0kntw6anZqFz
 j1mPZIgmQEylkUHRsXFMVXXqjiGVS0Dg2mTXeR9w6Ld+nwsQX/JZ0ONjLZ09mK4w/UQNuQDOyR1
 TmyR/aPu5PQuZS8CdFZaYbOKVThWB7oUomaPqjNtkFYYKN+1jX6Cnv5KgFyS+aJzIuP4+91srYg
 A/Vv8VUPHMZCK8fhlebRrILg6KJ0dyEelJIjuuqqtjwm7LG5l0GK9k3ltZHnGk8nOG2Upvd8kAH
 aggNCiG3ZyihhBC1iCH1OOI+bSI/x+1dV5nnBoEFA==
X-Received: by 2002:a05:6820:174a:b0:65d:1697:e6ce with SMTP id
 006d021491bc7-6611795a653mr107951eaf.23.1768493847994; 
 Thu, 15 Jan 2026 08:17:27 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd14883sm4807fac.12.2026.01.15.08.17.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 08:17:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py, buildman: Update filelock package version
Date: Thu, 15 Jan 2026 10:17:26 -0600
Message-ID: <20260115161726.3881761-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The GitHub dependabot tool has reported a "medium" priority bug
CVE-2026-22701, with this package. Update to the patched version.

Reported-by: GitHub dependabot
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/requirements.txt        | 2 +-
 tools/buildman/requirements.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index e080d0f051c0..c3bf31d057a3 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -1,4 +1,4 @@
-filelock==3.20.1
+filelock==3.20.3
 pycryptodomex==3.21.0
 pytest==8.4.2
 pytest-xdist==2.5.0
diff --git a/tools/buildman/requirements.txt b/tools/buildman/requirements.txt
index d8f76e4e73d5..32c14fbac576 100644
--- a/tools/buildman/requirements.txt
+++ b/tools/buildman/requirements.txt
@@ -1,2 +1,2 @@
-filelock==3.20.1
+filelock==3.20.3
 importlib_resources==6.5.2
-- 
2.43.0

