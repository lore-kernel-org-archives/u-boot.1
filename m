Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AD2CCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F1F83303;
	Wed, 15 Oct 2025 17:45:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZuWyy5vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E80D6800D7; Wed, 15 Oct 2025 17:45:19 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8B8E836AC
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-58affa66f2bso7191880e87.1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543115; x=1761147915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvNySyQbiwr0s6yzqSsuW3crmcfwnUYEzqTgLCEUz14=;
 b=ZuWyy5vd35FS8BhGPONYgWMS0jWe0Q2MydtffHuUWHryzq1jb/i2MQfhf06QiWODpc
 Y8NGBpknRP8cenaZyitJaj14UWPkFhkcK9hFXnXTTrn3eKkt/R3owmJWOcIX4nq6URus
 UY8Wt9xWb72BG5v3LzxHgybZFLDEBX8k3/yUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543115; x=1761147915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvNySyQbiwr0s6yzqSsuW3crmcfwnUYEzqTgLCEUz14=;
 b=eSj8+61tITtDpY4kMbV9g0NpKouEnH2csw75s+G4Ae5AJvG9C7brsS0I7LAs7TAUh1
 8MuaGyKIVEc+Z+lKRJikVELVk3tQlsuMeJXebs2ylG4WpYhxoLkATPKS1Fxbe1ZrUWrc
 dvDdu2CwCTq1nW5G3zgfOmFoHcXN95Fi8iQNV7OO2emSD9I1Vjk6+ewiiHhEVRsRTsSX
 Beau8i9fiy+FMAiGQm+LQA5SOTycUufxbEBBLlbdNxqtalaueFQ5XlZtnYsErQ7Fn7uZ
 HZvmchMOAHUNLX6CElFjsEPTmac68J4/zOJdC2+urpfivN/RdkprxhWHLyZ6TxLmzdd9
 p7tQ==
X-Gm-Message-State: AOJu0Yy1oyQG/+xXmbuaAaj4ElVYuj3gBhbM7VeXxYEnHCmxI8Wv7V1j
 TTFuPEgwxaz3QSBLo+9q8WVuPvBjUmn9UPGOFUXWa9PJ/YDBlmUrFQcr35jDD4/ikPGWsxGtoyQ
 m/l8eTcwlrn0=
X-Gm-Gg: ASbGncvztFO5fEDgpzOHi2xV0aGaLZmSFiOvHzqkA1WZycQpNL8roe7MGwM3V/5gDJS
 JaRFtwKcVWmo4XT4dtzSZ1FlEaxY/IQc8F6mdH5aUsw/KDW5X/Ue4+ByU2Pkjpq5K5uSoQyF8Wk
 HGrh6MtmSCkvSS0HgDUVkqCmXqWtI8aE/54y5qfpqCNqlJsj7nN92uvhvXWnQwNFwkFCS6Emo5G
 sBAbT0dqWZMJJenmy2AqwsS6O8AKwShlTRxm1V0B/A2TwWVlDytHKZzAdb8xVvinndjQfLoI5nM
 o5jTTxRokE3yW9QAYh0V/BIaUYVyfSS5VTOyaobJJtAs4ZliyPyxUyRqnKer0S9eBi1g8Xw/wpZ
 ELdkVOQSfJMDJpUTZjQnpHdzjvUoLpg6/6beePUR2ztUMd6IU
X-Google-Smtp-Source: AGHT+IGlv3nPFk6k8tZ/QTLHnGpLXNAMi5Gn3PSwjZtZctF8GsE1C4v4adb8RmsHuq0mdjdNg8n1/A==
X-Received: by 2002:a05:6512:b89:b0:55c:c971:2250 with SMTP id
 2adb3069b0e04-5906dd518a3mr8051262e87.28.1760543114608; 
 Wed, 15 Oct 2025 08:45:14 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:45:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 09/11] boot: Don't change the method count after global
 bootmeths
Date: Wed, 15 Oct 2025 16:44:12 +0100
Message-ID: <20251015154423.908468-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
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

At present before scanning global bootmeths, the iterator sets the
method count to the index of the first global bootmeth. Now that we
support scanning the global bootmeths multiple times, we must leave this
count alone.

Check against have_global and first_glob_method instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c      | 18 ++++++++++++++----
 test/boot/bootflow.c |  6 +++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 1a4cd0e28e8..38b8af916b2 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -304,9 +304,20 @@ static int iter_incr(struct bootflow_iter *iter)
 	for (iter->cur_method++; iter->cur_method < iter->num_methods;
 	     iter->cur_method++) {
 		/* loop until we find a global bootmeth we haven't used */
-		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global &&
-		    !bootmeth_glob_allowed(iter, iter->cur_method))
-			continue;
+		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
+			if (!bootmeth_glob_allowed(iter, iter->cur_method))
+				continue;
+
+			iter->method = iter->method_order[iter->cur_method];
+			log_debug("-> next global method '%s'\n",
+				  iter->method->name);
+			return 0;
+		}
+
+		/* at this point we are only considering non-global bootmeths */
+		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->have_global &&
+		    iter->cur_method >= iter->first_glob_method)
+			break;
 
 		iter->method = iter->method_order[iter->cur_method];
 		return 0;
@@ -317,7 +328,6 @@ static int iter_incr(struct bootflow_iter *iter)
 	 * normal bootdev scan
 	 */
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
-		iter->num_methods = iter->first_glob_method;
 		iter->doing_global = false;
 
 		/*
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8317dee1e20..20297136e3f 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -426,7 +426,7 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
 
 	/* at this point the global bootmeths are stranded above num_methods */
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(3, iter.num_methods);
 	ut_asserteq(2, iter.first_glob_method);
 	ut_assert(!iter.doing_global);
 	ut_assert(iter.have_global);
@@ -493,7 +493,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 
 	/* at this point the global bootmeths are stranded above num_methods */
-	ut_asserteq(3, iter.num_methods);
+	ut_asserteq(4, iter.num_methods);
 	ut_assert(!iter.doing_global);
 	ut_assert(iter.have_global);
 	ut_asserteq(3, iter.first_glob_method);
@@ -505,7 +505,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* Check that the sandbox bootmeth has been removed */
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(3, iter.num_methods);
 
 	for (i = 0; i < iter.num_methods; i++)
 		ut_assert(strcmp("sandbox", iter.method_order[i]->name));
-- 
2.43.0

