Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A23CFC28C
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 16:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B2883A1E;
	Fri, 21 Nov 2025 17:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UwZaPK4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 245A18398D; Fri, 21 Nov 2025 15:36:48 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2FD483966
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ec314aaae5so1306779fac.0
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763735805; x=1764340605;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JeESE/krr5d7IyQoH3nHAmm5DA6OjuZCZbuc6V+BXNE=;
 b=UwZaPK4l4SNKiwNgonew0DqBtaNeTa0rLpQkgDJE2CQreK0YFNGAFYTIOsbiwrQuut
 OTcn0n7xq9KYnG561sqCJ21u+l2redMvcLMcvFftgKRHlIqDZqwl9SyTvfx/wZW2oN8q
 Icws9oIkGe7WkOCpFHZVQtsl9gYPmtKzyTOo1F1oFljcZ+ZqDgUkASGrgRXINcCbFmpi
 vmlHBH8eQqdKziKx2koAqdtA/7JNeFPfuNtIPhtx6sRwi89kMNSDmxMsAnYJX38xyMDL
 rNh9VrmZI4aX0r9vXl703szw+QpXD6PxV3rAkpHtT4EtWrhrzgYXi+Xe15MrIEzfx/5M
 7icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735805; x=1764340605;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JeESE/krr5d7IyQoH3nHAmm5DA6OjuZCZbuc6V+BXNE=;
 b=jhBr9U6evcLKp9GZ6UMlLovUBW99X6ya8oO38TuBNVBFae53nm5ueI1GV5HW77V2xi
 mn4G7kOm10U0Teafj12h77i/fHPe6LYCyzgfl9jqNiZIClmqIgShw2ehdNeL2hDecUwL
 Rr3ZTgL6wFslXwrJp7Q6/wKiixkv8CpyPFx2JE3Qszg6Uig1mkzKS8oWVi3RlOUgFH6k
 2OWNCp02AoEXTZ2uYo6foda5IfIwNSjYKGDM3YodWLqQTewj5iyyciGihAvRfjzSb0oT
 ICtsaFxYftdJLWlxdmxdtitjdKDN6tAY/ydkz+Xwq8gLttNNo78GELJx6Z1v5aM6miqa
 tMZA==
X-Gm-Message-State: AOJu0Yy4Gvhn9JOI1+eOLD5tOCbbD8lrlThq9pwuv++P7A6Y6pVSyEKC
 zKcy+8F5IlIvnZAFacISpBm8UYAaYdnQe68LNjOhuU2BzcqEOdHqhQQxqYfCNeZRReoDrqXOjjb
 p6IWI
X-Gm-Gg: ASbGncttTGNl3/CGoBZxFVkDpALVHUpEkHhXMf7bC/B7LdEHWEC/aQekVo6dEMhlkbr
 wYqIlivRMJGogAp6pdGAeE9x2UA4rWdr/QFEMZ7HpAgNR3c0YOOoI26KEw7mz2FNB+Wl4TUSYkH
 iQv7hVL5UvXT5AEs35gyLXivZiSW0ov/1WFZRX2fRbVuPMq9mGc30X9meFoRg7QolPPzJiE0f3E
 OB5Az7xihZCOast21gduFXIHVh9Ifp3wnNvfBGKcNqUvttC2lcTidRK0b0bsbL+clna2BuhIfcu
 9CvBYuUuQ1uyJKG83uc1LJRdow4VSGbkR/53pRQXStUdTQLYgU5hatOQc9VpvgMn6xAfYwISU9r
 OrUMYaba1ySMG7zLlEPeOuHun9AJss7zuh5IwReNHnfHEo5GcpWvROALWyrT+NgHOW/Bstt2y1t
 1cfK/JcsMD4Yzkcw==
X-Google-Smtp-Source: AGHT+IEz8igz/9xtPSfk0B5n+1Dl4VU7GFGbhulrmFtEtEvj6EEBxtHPdCrdoxcTkD9C267s2EsTLg==
X-Received: by 2002:a05:6870:504:b0:3ec:3b3e:4f38 with SMTP id
 586e51a60fabf-3ecbe5cf0a8mr1064631fac.36.1763735804721; 
 Fri, 21 Nov 2025 06:36:44 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d761:af7:26f5:f16e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9dc2171csm2730064fac.10.2025.11.21.06.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:36:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Nov 2025 08:36:14 -0600
Subject: [PATCH 1/2] test/py/requirements.txt: add setuptools
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-a-few-test-py-improvements-v1-1-bacb4148fb0d@baylibre.com>
References: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
In-Reply-To: <20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=hDlyMWtFc+JEmeFxrIMeof2lwql1etBkoab0Z2qTNFA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpIHjqHtDIlNDX0j1/v0cjVthUmYAKBgtnWn59I
 jGHG55LkBKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSB46hYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuIkH/3IEeOZTrAmN2VqfnXOEal5Yxhtx+FtfYOuYzwu
 B3fo+eaYFrPqT30qoi60+3uJn7lEa6WlVzBNWsc2d+fJovLRi+4vKO8AYoznKWtBz/dbcPTq8Lk
 EOW9oJrkiC7k3ON5iSFOt46OWcsKeEiVm5cymHj1h0LxYcm0Iykog24JbQa/9uXrWJPAVgl7Fmt
 yFzBwX0EKXew88HyxjFaPNpd4yktMTSQNBmLU8NMIZTHdT9l/PyX1x3ZC1EN4qHCZO1B8v8t7Oq
 TaKwJyKwBjvT3MWvxAhtv6gLeBmk5mPDLznq9HUkOZw4wE1ZBwdDJYjXp5XA/mZE3rlJTg1cx8w
 KXrg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:59:15 +0100
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

Add setuptools to test/py/requirements.txt. Otherwise, attempting to run
tests can fail as follows:

    $ ./test/py/test.py --bd sandbox --build
    +make O=u-boot/build-sandbox -s sandbox_defconfig
    +make O=u-boot/build-sandbox -s -j32
    Traceback (most recent call last):
      File "u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23, in <module>
        from setuptools import setup, Extension
    ModuleNotFoundError: No module named 'setuptools'

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 test/py/requirements.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index f9eac7901fbf6bd61bfa211cf12285ceecca4fc1..3db6aef0e22286ecfa41d6fa4926b6a1baa814b2 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -3,3 +3,4 @@ pycryptodomex==3.21.0
 pytest==8.4.2
 pytest-xdist==2.5.0
 FATtools==1.0.42
+setuptools==80.9.0

-- 
2.43.0

