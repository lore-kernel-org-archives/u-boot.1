Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C51E7542B
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 06:22:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9B8871E7;
	Tue,  3 Oct 2023 08:21:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X5AA0zER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCF1871E2; Tue,  3 Oct 2023 08:21:48 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E375086E15
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 08:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c28e35752cso6392411fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696314105; x=1696918905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=133KeprTV/vR0eagW5kUqY7IWB39BGwuNCAQ+zim7o4=;
 b=X5AA0zERXKuh2K57tXfpKg2cz5O17AIHhLXcopby7ud1Bfb3du15ntdx9dGbKrmXsY
 zrrCYR7WvbS1qKBi5zf0Jh1w1OqGOFn4MY2YKNkkXwJ5Dksd6tMBO6K+EVtZieaDVU+v
 9jlGuX468IEAkytBLCxfQzQHWJ8HRY6f8iXVLyDgHvWSs6WHEJIeDLk48qEGEN9xcTXC
 ZdHtBq6QBQqynyjeorqKFuf4tG5WecHd8X3Sg6Vb33GLDN+Pl485XpohdaTt6B6CB5Ao
 h2WCpGHET8lKRUw0+Ix/XPny36Dte7Brqlut6R52J5uqMogVyv5xFWSgf5lN2plbkCk0
 o4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696314105; x=1696918905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=133KeprTV/vR0eagW5kUqY7IWB39BGwuNCAQ+zim7o4=;
 b=xEaAknFB3nbabNy/7rNmkoVt9BY3mv7WXjKbxCUK3Dshho/fNyEGA1uWLIli2Wlt50
 oyYRrXbWMjVMh9381aqSEr07VuV2f+wUJG8v4XhVlZIv1Y0Tj4IGq47Ze19oCttW8W+1
 eTft0D/dOjNNJf4z42nieuttMjTXAh9rnYAL9iKOxxJx/fJHXDr+yreVKDV4S3q1slEl
 6sE0rn3BCTG03cGRdY+mUEiJsxySKU874mf8pNHNixfdCe5ctMJ00Nl6FMGdusMeXtOp
 la2njS85aTJYZdk5ARU6Bup+4d6xqeRYFJMIHODXw4KS/RvJgUM7bc+5doZ9yP/BlmBQ
 F9rg==
X-Gm-Message-State: AOJu0Yw9GmL1ma40DFdMOZWfoj51cqMheo1+fLXBEEke5Pnm0gsjHatg
 9coOyFcwOp1f4vxcFQG5X8o=
X-Google-Smtp-Source: AGHT+IFhYTBjBHfhMFUCotjzWbttuBEwyUSRv7QwC4BeM31ftQMsgwzwjgEm4n5Yl4dNQShK8vtj3Q==
X-Received: by 2002:a2e:a404:0:b0:2bc:b75e:b8b with SMTP id
 p4-20020a2ea404000000b002bcb75e0b8bmr12156803ljn.38.1696314104955; 
 Mon, 02 Oct 2023 23:21:44 -0700 (PDT)
Received: from xeon.. ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 n4-20020a2e86c4000000b002bfba0d26bcsm103594ljj.8.2023.10.02.23.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 23:21:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 John Keeping <john@metanate.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 2/4] test: dm: regulator: test counter in
 set_enable_if_allowed test
Date: Tue,  3 Oct 2023 09:21:24 +0300
Message-Id: <20231003062126.42026-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003062126.42026-1-clamor95@gmail.com>
References: <20231003062126.42026-1-clamor95@gmail.com>
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

Emulate use of the regulator by a few consumers with balanced on/off
calls.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 test/dm/regulator.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 86f4862d9d..33115daaf5 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -194,6 +194,24 @@ int dm_test_power_regulator_set_enable_if_allowed(struct unit_test_state *uts)
 	ut_assertok(regulator_set_enable_if_allowed(dev, val_set));
 	ut_asserteq(regulator_get_enable(dev), !val_set);
 
+	/* Set the Enable of LDO1 - default is disabled */
+	platname = regulator_names[LDO1][PLATNAME];
+	ut_assertok(regulator_get_by_platname(platname, &dev));
+	ut_assertok(regulator_set_enable_if_allowed(dev, true));
+
+	/* Get the Enable state of LDO1 and compare it with the requested one */
+	ut_asserteq(regulator_get_enable(dev), true);
+
+	/* Emulate second consumer */
+	ut_assertok(regulator_set_enable_if_allowed(dev, true));
+	ut_asserteq(regulator_get_enable(dev), true);
+
+	/* Emulate one of counsumers disable call */
+	ut_assertok(regulator_set_enable_if_allowed(dev, false));
+
+	/* Regulator should still be on since counter indicates one consumer active */
+	ut_asserteq(regulator_get_enable(dev), true);
+
 	return 0;
 }
 DM_TEST(dm_test_power_regulator_set_enable_if_allowed, UT_TESTF_SCAN_FDT);
-- 
2.39.2

