Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0662ACCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03DA8365E;
	Wed,  1 Oct 2025 23:29:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WzGTzKpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E15983631; Wed,  1 Oct 2025 23:29:50 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 038DD83544
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-930a6c601b3so26281939f.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354186; x=1759958986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OCbcYsUMfuKia/vAbPndgBEFHyhm5wDNIcytQjQuuQ=;
 b=WzGTzKpChrR0ZPetWMJmHMzjb/voX0pc8C5EmPCQJRnFpdxrqN1KVGrdLZ7bWHdQ8p
 /QYVJXUzbmeBnhfWqZa085TPtePGMVOZrItkrZ5OxJJt/ieTU2vlT4npl5TggUSmk1zA
 b/D3qi96yh/XmrW9fNkfhT6pKs0jYkBe7UIFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354186; x=1759958986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OCbcYsUMfuKia/vAbPndgBEFHyhm5wDNIcytQjQuuQ=;
 b=ISwqXjOajV9iNHZZyiqLKVEmph++GM1uI/m6jWAaLYC2RjFPZ61PNBsLUNPxXgEIDj
 MbMZZp88N4HQAKPHdXO1bHYPo8iaKJlxsMnOJo9cvXPoVCIBQQeuKG9CLS+kDHOFyMHX
 c1Dzg4LsiigTlt+xAgLGDZv09Ebz8cfKMIy0F97BO8N+O2tiMseZgyA8MqoCaqp7+qMD
 SP/hCf8ev7KoWiC2vcEI5cqk11aRgHTIen8aTWaPdCDk015CP7kD8QV22E4S+fjG1i/4
 HL1la+ZmaIKUwNqCsAUydCKMErNG/CbzqpoZpQHzg0RiEALzSxBW6FJUM91+L1QvmM5X
 KNrA==
X-Gm-Message-State: AOJu0YyiHnlMFXDounCq0wno4Hqu6aeEbrixy8Z+cBDEC4WqpjMY5CwE
 DM57142kLb3kbnXATYc63U4li3K1PseXMtIJEls/vGnhbprq4ta2rlVpOFybhOraIsLiBDWdBOx
 Mg+fyH4mc
X-Gm-Gg: ASbGncschFuY0H2beFaANyRzgWrAlLdcFGy3/KwsG9LL9sCp6OVfO3NudlVltLFp+21
 iZ2KzbbtEe8qwFD+q3u2dKIPWxPAtepoepaaLlwMdpyi+W2luREmCIXa0mXvbunJQdPKoTrScdR
 IhhVno+o7iycFu6Ms7y53oZmbysygow2OvWVYHN84DMKYh4SW2JNP8Ne2QM4DnOmJ5RQW5RRRsz
 7GhdoeH0U8PlxFQe722WqctAcTAh2l5a23/ye1+pDsNCMMTEaVsS9RQuU4YZKZr2Inh/NRflwQY
 cYO65VQMm0w6kd/+dPEJoys2xCy9nbBs6keZMqqWe5slKE6/kIApkCz3LXHxPRgDiffPX5PEDrz
 Prom8AEsLh7PrJsG9UjGga46rL8GvO/4Nis6JLY9q
X-Google-Smtp-Source: AGHT+IFfOQRT3wNanHOHjvW2tlEDHEfMkDCnNjX8Toz6eGv6iqhJ23YdJfFbyYzUMnxBJ9H1Xy890A==
X-Received: by 2002:a05:6e02:180b:b0:424:a3e:d79 with SMTP id
 e9e14a558f8ab-42d8160eb1emr63030015ab.21.1759354185980; 
 Wed, 01 Oct 2025 14:29:45 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/17] boot: Add a flag for whether there are global
 bootmeths
Date: Wed,  1 Oct 2025 15:26:33 -0600
Message-ID: <20251001212649.3263574-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

The current 'doing_global' refers to being in the state of processing
global bootmeths. Since global bootmeths are currently used once at the
start, it becomes false once the last global bootmeth has been used.

In preparation for allowing bootmeths to run at other points in the
bootstd interation, add a new 'have_global' flag which tracks whether
there are any global bootmeths in the method_order[] list. It is set up
when iteration starts. Unlike doing_global which resets back to false
after the global bootmeths have been handled, once have_global is set to
true, it remains true for the entire iteration process. This provides a
quick check as to whether global-bootmeth processing is needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth-uclass.c | 1 +
 include/bootflow.h     | 2 ++
 test/boot/bootflow.c   | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 918d78ec2c9..e95a8a801c4 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -208,6 +208,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 	    iter->first_glob_method != -1 && iter->first_glob_method != count) {
 		iter->cur_method = iter->first_glob_method;
 		iter->doing_global = true;
+		iter->have_global = true;
 	}
 	iter->method_order = order;
 	iter->num_methods = count;
diff --git a/include/bootflow.h b/include/bootflow.h
index b1efeee3259..157a16d44b9 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -255,6 +255,7 @@ enum bootflow_meth_flags_t {
  * @cur_prio: Current priority being scanned
  * @method_order: List of bootmeth devices to use, in order. The normal methods
  *	appear first, then the global ones, if any
+ * @have_global: true if we have global bootmeths in @method_order[]
  * @doing_global: true if we are iterating through the global bootmeths (which
  *	happens before the normal ones)
  * @method_flags: flags controlling which methods should be used for this @dev
@@ -278,6 +279,7 @@ struct bootflow_iter {
 	int first_glob_method;
 	enum bootdev_prio_t cur_prio;
 	struct udevice **method_order;
+	bool have_global;
 	bool doing_global;
 	int method_flags;
 };
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index a65fcd3d4e3..c766bfcf683 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -308,6 +308,7 @@ static int bootflow_iter(struct unit_test_state *uts)
 	ut_asserteq_str("extlinux", iter.method->name);
 	ut_asserteq(0, bflow.err);
 	ut_assert(!iter.doing_global);
+	ut_assert(!iter.have_global);
 	ut_asserteq(-1, iter.first_glob_method);
 
 	/*
@@ -406,6 +407,7 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	bootflow_show(0, &bflow, true);
 	ut_asserteq(3, iter.num_methods);
 	ut_assert(iter.doing_global);
+	ut_assert(iter.have_global);
 	ut_asserteq(2, iter.first_glob_method);
 
 	ut_asserteq(2, iter.cur_method);
@@ -422,6 +424,7 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	ut_asserteq(2, iter.num_methods);
 	ut_asserteq(2, iter.first_glob_method);
 	ut_assert(!iter.doing_global);
+	ut_assert(iter.have_global);
 
 	ut_asserteq(0, iter.cur_method);
 	ut_asserteq(0, iter.part);
@@ -487,6 +490,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	/* at this point the global bootmeths are stranded above num_methods */
 	ut_asserteq(3, iter.num_methods);
 	ut_assert(!iter.doing_global);
+	ut_assert(iter.have_global);
 	ut_asserteq(3, iter.first_glob_method);
 	ut_asserteq_str("sandbox", iter.method->name);
 	ut_assertok(inject_response(uts));
-- 
2.43.0

