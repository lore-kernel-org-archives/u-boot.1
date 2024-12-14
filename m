Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAA2E77180
	for <u-boot@archiver.kernel.org>; Sat, 14 Dec 2024 18:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B90801BF;
	Sat, 14 Dec 2024 19:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mwObeJE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F0480073; Sat, 14 Dec 2024 19:20:51 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B315F800B2
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 19:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so58474439f.0
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 10:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734200447; x=1734805247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcFPT0MyDz77JGaWifeSzoyOv7+ya5xCinNUtLX7Vk8=;
 b=mwObeJE+pJ3JV+0LQw+9HgTHpdE/rcqbhfJ8yPWBT+jFMIzHf1p+2lcZyuheYDvXJG
 rLM3fStxJ+V1RQPvSiNKs5UAgDnZEuAt6+iIudEi2crsQi3kDjBJEwaj22iSK1o8umG4
 D70nQalhcR6VZImG9l1mXrKjfzOQ44Z6Ygn68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734200447; x=1734805247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcFPT0MyDz77JGaWifeSzoyOv7+ya5xCinNUtLX7Vk8=;
 b=f35AgS4I2KUmMHbobF2LuIYqYdbnQj+bYXNHzX1yFZBvFvSGr03WjMUGpN0VwgXMFN
 WsbRpTMYj7cKjNYoiWkIsqYndaDxsv8/lCMPASsNZ9xrz6xj2vU/h/QzVUU40Ci7sFd7
 YT7PWDuwdvgQ26qXaXCCsJNOVIAM9IMcYEVWHyXEGFb8OnrF5pYXYMtRuesC4mw/Vnaj
 PjA7b89RAjnCq/Nd5OBtA9QAQP63qIYLHoFXvcGdoRl8Rj+CjxAJX9W/5/B4PnG0NYfv
 fM/JFIel5Cbk0b57SFjxyp0j2N5jf3AAhTD8fF0GF3I/jd6hG/7gVmoGbLzcafpSX5Y/
 wfjw==
X-Gm-Message-State: AOJu0YyWLwkaHzcTDhpaP2f/8saX686xEQsZPZ9KJmc4U0n0tZ5wLUBu
 pzswctX4bK31iALshRtXJ3XWUkYD5nQb7pwrw/7A4oClNR266etmNkyomFcw4x2kKWvgemShsl4
 =
X-Gm-Gg: ASbGncvhs6NCFsU4Vtlg17D/HllGWmUXQcu7S1R72+MRz/xEHsX/fi2IvlF6LnAbEDx
 Nyh13YT9S5B6/OKbM16fwQa6e/VnNIHSWNTyW1ZI6hqNmRc5DSsUVXcJhg8kBQqI+FuvIQrj/rH
 0EIoOSDilKVPY1x84cX2ZJMi9szcfjvlnkL3uUY6Qj8oQHGpABt79JkApi6OfnfR2LwE8L2x2qK
 5vvFHqTBz7ZJbqm9OHOv0DGSHUU2RBxY4mU8sgZ8dLmnwqbGpdxG/PXbREYaQXFuPyIb/fuC8ey
 VxAPojc+41/q3fHepg==
X-Google-Smtp-Source: AGHT+IGIApNJiQcNaE1190SLj8e3LhTPVVOUjDQayO/yYzH/2zVXwlDzHZgsC7m1jCs2lAgjTLaxMA==
X-Received: by 2002:a6b:f311:0:b0:841:99cb:776f with SMTP id
 ca18e2360f4ac-844e5b579dfmr796470039f.6.1734200446816; 
 Sat, 14 Dec 2024 10:20:46 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e5dd620e20sm415135173.0.2024.12.14.10.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 10:20:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 5/5] gitlab: Add a StarFive VisionFive2 to the sjg lab
Date: Sat, 14 Dec 2024 11:20:24 -0700
Message-Id: <20241214182024.1954974-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241214182024.1954974-1-sjg@chromium.org>
References: <20241214182024.1954974-1-sjg@chromium.org>
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

I have one of these boards loaded with Ubuntu 24.10 (64-bit). Add an
entry for it so that it can be used for testing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index f379c11a1ba..33ec4b2e417 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -691,3 +691,8 @@ nyan-big:
   variables:
     ROLE: nyan-big
   <<: *lab_dfn
+
+vision5:
+  variables:
+    ROLE: vision5
+  <<: *lab_dfn
-- 
2.34.1

