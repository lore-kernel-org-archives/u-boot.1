Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0621BCCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E968F835B3;
	Wed, 15 Oct 2025 17:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1PavFfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2F99835FD; Wed, 15 Oct 2025 17:44:52 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC815835B3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-373a1ab2081so64572751fa.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543089; x=1761147889; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1hV9/FJ0fiemrVvaC4ywj/U0q25Ve9h2sN1nLsQ7Me8=;
 b=b1PavFfnv1a+UoOqcTNk6woWn57JEDZgeJrmyGjtg45kMgn6eNX4j/tH6vhs2UDnK9
 lC5t11wiPBSSU9Ol7zqHlBuIiUv1+KEwZXcHnKSBgaq9/QO1gJZw+x3h1Knr4gb0IjjZ
 Zz4sE2Plfp/f2Rn0/RSPC+LQdkwRFA1N/2QNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543089; x=1761147889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1hV9/FJ0fiemrVvaC4ywj/U0q25Ve9h2sN1nLsQ7Me8=;
 b=rTmwSIR9fn07Aoll80GDfufg2NeldpxcUEVRy66WbW/upxmv1s8bu2El897oK/j9nT
 gp3gkFPT2p08vxN+d5nJ35a7P/6xyoJUPD9QuWZEUH7P5QudZKYxIsvlpxkhzSnsKNmk
 z2NuTweb2NW7uFmW0FENP+FX6jiIEPqVEQDk0I8jsfolj3oPAHpbjowSAqQoj5o2zfbw
 Zy+tD/L5Fnsw/R8zrrQYglY9oBeUO+gtEVFj/lYB+TOzeztKxk6UatzMUBTTl8pJMmv5
 BuprxjC7aAvBebNjJ5PEq7qoPXMMc9UeJhzRnDvAyvnW4a8p8ESajvyV/HsgQikhQ1f3
 M3HQ==
X-Gm-Message-State: AOJu0YxGbNRx0nzSNlBDnn/4v87X1ZrLZS1XuOQ8Mlp65hU6c92d/1M2
 eEXDuA5nnNUf8jXZOseeKaQF38Mxu0EZRCl24iJef9XTlJmcE0NzGyXtFP9ITTGD48xS5IgtDrq
 8gkSWY0VorO4=
X-Gm-Gg: ASbGnctOS5pwczRaoeM+vtNTUB3iJe2DKzCvZd6lOHx/mrhWNgWSAoiir8X+6x89K2z
 okXW640WCWV2cjnpCMz3pc1YdzriiWt28ne8UsVmZJjmXk7xvI0qoN5lkNmKyDX9AHTurxVGCj8
 n2tVO3PTq3z4AJH3jroVFnMagswMlwALLQZRxXhQmflWF8w79q+fODpOf6FL7EaqboIgvqmsR+n
 TkYApF1A3UTRakpH5B6MPjohnHr/mlX8jkOHs518HMnBRPod4f79Jlk737pd/gzVFZBVwJV1cCd
 uMbak2LU356SdWDV6diWhO94AXgloQUCi6JBVHsR5hnCtfvchILa2N9YW0ousKZhDUJ+YFtz6yl
 Wlvcu8O60Jb5Hf5kQf3zzG7/94Qz3jqyCJ3+Y1yQlih7QZYo7
X-Google-Smtp-Source: AGHT+IGhIpzZNiNl4M2CRzyCsNnsTE6v4mVIxAz9OL1OuSFvuJ4FEc4Be+l4l8fHHfpQcINIREu1lQ==
X-Received: by 2002:a2e:b88e:0:b0:36d:a459:f0c6 with SMTP id
 38308e7fff4ca-37609cf2a61mr80392871fa.12.1760543088828; 
 Wed, 15 Oct 2025 08:44:48 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:44:47 -0700 (PDT)
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
Subject: [PATCH v4 03/11] boot: Update first_glob_method when dropping a
 bootmeth
Date: Wed, 15 Oct 2025 16:44:06 +0100
Message-ID: <20251015154423.908468-4-sjg@chromium.org>
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

For now we only support dropping non-global bootmeths from the
iteration. Update first_glob_method in that case and add a few checks
that things are correct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c      | 6 ++++++
 test/boot/bootflow.c | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index deb5f42ba65..62634a59a94 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -109,11 +109,17 @@ int bootflow_iter_drop_bootmeth(struct bootflow_iter *iter,
 	    iter->method_order[iter->cur_method] != bmeth)
 		return -EINVAL;
 
+	log_debug("Dropping bootmeth '%s'\n", bmeth->name);
+
 	memmove(&iter->method_order[iter->cur_method],
 		&iter->method_order[iter->cur_method + 1],
 		(iter->num_methods - iter->cur_method - 1) * sizeof(void *));
 
 	iter->num_methods--;
+	if (iter->first_glob_method > 0) {
+		iter->first_glob_method--;
+		log_debug("first_glob_method %d\n", iter->first_glob_method);
+	}
 
 	return 0;
 }
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index f3386a1eb31..07bf239485c 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -482,7 +482,11 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	/* Try to boot the bootmgr flow, which will fail */
 	console_record_reset_enable();
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
+
+	/* at this point the global bootmeths are stranded above num_methods */
 	ut_asserteq(3, iter.num_methods);
+	ut_assert(!iter.doing_global);
+	ut_asserteq(3, iter.first_glob_method);
 	ut_asserteq_str("sandbox", iter.method->name);
 	ut_assertok(inject_response(uts));
 	ut_asserteq(-ENOTSUPP, bootflow_run_boot(&iter, &bflow));
@@ -492,9 +496,13 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 
 	/* Check that the sandbox bootmeth has been removed */
 	ut_asserteq(2, iter.num_methods);
+
 	for (i = 0; i < iter.num_methods; i++)
 		ut_assert(strcmp("sandbox", iter.method_order[i]->name));
 
+	/* the first global bootmeth is now down one place in the list */
+	ut_asserteq(2, iter.first_glob_method);
+
 	return 0;
 }
 BOOTSTD_TEST(bootflow_iter_disable, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.43.0

