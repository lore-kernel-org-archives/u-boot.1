Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117FFCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97CAD844AC;
	Thu,  9 Oct 2025 11:30:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="go+Gt6hQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD6AD844A9; Thu,  9 Oct 2025 11:30:23 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932E08447F
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-92c781fd73aso71771539f.1
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760002219; x=1760607019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r299/a0HOwx0REUActoOKiZ9RCDAHitnvBGKcmR0P7A=;
 b=go+Gt6hQoTxFATPoX9rUfqy5ZQqu6qaLnKeqfxPZIF1wpUMpPurO0bhU3MSVxqFbKm
 jTspXBXKgBs+jg/55lgM23tkhiTcH7OrABvCYOiAgNYYiacIo7ndP9RCRR7p1iDANCjG
 ilNP2ZjziTYYUv5P8gXdm/ACyoA7mulbbAoDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760002219; x=1760607019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r299/a0HOwx0REUActoOKiZ9RCDAHitnvBGKcmR0P7A=;
 b=SdVWK5bc388Ua/pXDupfU+mD100TPRcqo95CfRnBNpFtxOt50iTWUkLvJIr02nhDei
 IxY2MyOElM+9380HLXnMFekn/sqWc6OiOfxQtaLz9RgJyuzZtZYpuffc/yJMHHm8NcR4
 o9NmrIQ8dG0cf6Y6QrKAmO2DMR7soiHobinKjXs1Nl+H8cTe8RYhSTIyvqHfGLIo2Ss+
 zGyq8VSvgkJyocYYK4lgUULCD+5vrMP8AUdZtsyo6DNfgjwQpNb0eDJp39zTgi4snKpw
 ECIQ6OUW4TwZMKwNukU3zfu/IzAKEp9XLGOT8C9NgSe4mN9qHbuZ2P5XPhQeZws3vDGC
 3Icg==
X-Gm-Message-State: AOJu0YyTww6zFMVTwxRszGTxm9AmWKN4/dsAAlm3C8BJosp8mtxlZ/p6
 GVq5QPrek8JYsON9xebP0Bz2m5+q3vOkcm1FCheNjapuob9z8eqrnvJ/beRFsWjP5KftYnePxYN
 0eRlTf04e
X-Gm-Gg: ASbGncu9eTCrok81H4S/4ZrPx0fQ7OyXA+HmlDzkruDBxHWDn0OI7nBUs9dnE6c22op
 4DCGsxT4WbH/0xNVNY/d2ZmnlhAvE+t4tG98lGJpbB7Xuw01b68hJhT+QJQQFepkEjDxOgRmQxz
 yvkvlGK57dY5iP19PJX6XaUqINns3G1izL5VZgAovVIYIK87mKlheZf/JQTfqBVnaE5WjJyeBYB
 mXAKOjlysiZOHeIuvsSDj0/am1MhV+yXahaXkVsL49IVcPdyanPLanOK1uy2VO4bX14xY/t33go
 97AbMBkRpraDPGqpO7e98qRli0g1ghz3CTWs/Mr/hku4mNjExpr1KRchKqRxOWRU99q6nSstFXo
 ldVS2U4pmGEe+blQqJ3oQemGzzLXUJdlpGW/BwtuP
X-Google-Smtp-Source: AGHT+IGVCEpo9RU8zGadOdwrQopTRjZmmKO+wOpZqdBLpoOMRZFClZPA4i0phfjZB3bmrKzWxIxZPw==
X-Received: by 2002:a05:6602:48b:b0:936:dfca:f6c with SMTP id
 ca18e2360f4ac-93bd192a620mr744300039f.10.1760002219549; 
 Thu, 09 Oct 2025 02:30:19 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea300f7sm7839341173.16.2025.10.09.02.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 02:30:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 1/4] boot: Improve comments related to global bootmeths
Date: Thu,  9 Oct 2025 03:29:52 -0600
Message-ID: <20251009092959.260121-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009092959.260121-1-sjg@chromium.org>
References: <20251009092959.260121-1-sjg@chromium.org>
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

Add a few comments about global bootmeths and first_glob_method

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v3)

Changes in v3:
- Drop the spacing changes

 boot/bootflow.c        | 1 +
 boot/bootmeth-uclass.c | 1 +
 include/bootflow.h     | 3 ++-
 test/boot/bootflow.c   | 2 +-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index d79f303486d..15df7069209 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -344,6 +344,7 @@ static int bootflow_check(struct bootflow_iter *iter, struct bootflow *bflow)
 	struct udevice *dev;
 	int ret;
 
+	/* handle global bootmeths if needed */
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
 		bootflow_iter_set_dev(iter, NULL, 0);
 		ret = bootmeth_get_bootflow(iter->method, bflow);
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 188f6ea1895..bb2dd8447cf 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -204,6 +204,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 		goto err_order;
 	}
 
+	/* start with the global bootmeths */
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
 	    iter->first_glob_method != -1 && iter->first_glob_method != count) {
 		iter->cur_method = iter->first_glob_method;
diff --git a/include/bootflow.h b/include/bootflow.h
index 32422067723..2ef6eb25cf5 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -250,7 +250,8 @@ enum bootflow_meth_flags_t {
  * @cur_label: Current label being processed
  * @num_methods: Number of bootmeth devices in @method_order
  * @cur_method: Current method number, an index into @method_order
- * @first_glob_method: First global method, if any, else -1
+ * @first_glob_method: Index of first global method within @method_order[], if
+ * any, else -1
  * @cur_prio: Current priority being scanned
  * @method_order: List of bootmeth devices to use, in order. The normal methods
  *	appear first, then the global ones, if any
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 8de5a310add..7cd83dc7443 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -401,7 +401,7 @@ static int bootflow_system(struct unit_test_state *uts)
 	ut_assertok(device_probe(dev));
 	sandbox_set_fake_efi_mgr_dev(dev, true);
 
-	/* We should get a single 'bootmgr' method right at the end */
+	/* We should get a single 'bootmgr' method at the start */
 	bootstd_clear_glob();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
-- 
2.43.0

