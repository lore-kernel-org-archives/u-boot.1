Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CAECCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 06:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16285838C5;
	Sun, 12 Oct 2025 08:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fd6Di5xp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 160BF838C5; Sun, 12 Oct 2025 08:44:30 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE3583885
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 08:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-9032edd72c1so399079639f.3
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760251466; x=1760856266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r299/a0HOwx0REUActoOKiZ9RCDAHitnvBGKcmR0P7A=;
 b=Fd6Di5xp/BCqMDWnAQNm6ETYlD0TsIyhzGEZ2SP8oWcUIm3jyKOf1MWUuvIuGJy+U5
 A980qct2TJeIWmaGYdaFLiHQdRCaBOTw5UDy7clWqxlZuupnAN/GrGhgWPVeKHvB/wVJ
 sxJCrTHQw85aGELhAIrvP74qHRm7EKe6F52CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760251466; x=1760856266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r299/a0HOwx0REUActoOKiZ9RCDAHitnvBGKcmR0P7A=;
 b=kr5HOyemURKlxuT7tSxTkreAzWBb3/riPW6El3F6wy0BBgVTapmtw3C6Z/Tfwj71oT
 fRaNRx50VfFryK8Q/RzODh2+Hh9PXeBpWTUQK7UCiFOR7IFhSQNadRH1EZjlwNkQTRW8
 mjYikXPahXt2D5tO0Zl0eC1h1mS0Vz/GXNov9zbj90UJ/LkFiUuLhzQ8wqnZayRbnySw
 9aeHz81sPXyhtw43FlHP4CAG01s6jg1xKH6/R88E32+tx2VYukly8hg7Hsa4lR+hK4vw
 jPqhh+S3siblCCZhTmsjgxbS0kEjL+TF8CGd8nJM/cuLDbveifopauBRvpwMaGxL/37P
 8bsw==
X-Gm-Message-State: AOJu0YzBaVDWH4afvCVrVAtSpT3FHGdSRBsyM6Pz6mEi1+MZsTjCkr2G
 MGN12/bPtTZ19tMrwWQnCAwTKBH66VJyX7y9B7xeTrVl1YzL8xbpAruy0GQVe9bfjOISmy2k2cH
 Pl6r+kW9w7l8=
X-Gm-Gg: ASbGnctE0vBX9OpF73jbSIArLQzpKAC4/xWHbxPUT2x0+Xi1gO6FgyDMDTXdETmwgOO
 zSHqsIuN633sDtyfNuwGuvg24l/tLapeHKhLvzk49MweWAQ+qxSxppFLYX2f3p74PX64bQkmxXa
 Ab4UD82slkDIN9XrSOvVyu9UC9vCOAsaEaPzc8o9965fwBbofOlWy3LyveX3YagAv1mq6MlE4Mr
 szmeUa9lvqVgh9Ln2+QTo9jzHld2Asa092ovHeL+qpgezP/O9zUmSCJUpkUkDDQlRO7CnZsbcyL
 3Hz9Uc8p9XyHpl7iKL+OFM8l6x0aOla/8UNbE/3ZEPMRaEQt+Xd+GntuURCBBRo2++9Q2BWxkJG
 YHnaz5d1vIQU51y/a1p7XN05o6YR4uavZiCk=
X-Google-Smtp-Source: AGHT+IGHNY+yyu5ISsgtoJBsoIfjkdFmQ4tKZUrclx5pdVYkEPgUpg2RNYHVkoB5oh9GsQQTt7qARQ==
X-Received: by 2002:a05:6e02:378f:b0:42d:8c18:94d3 with SMTP id
 e9e14a558f8ab-42f87419d18mr219163275ab.29.1760251466066; 
 Sat, 11 Oct 2025 23:44:26 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42f90343080sm38109625ab.22.2025.10.11.23.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 23:44:24 -0700 (PDT)
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
Subject: [PATCH v5 1/4] boot: Improve comments related to global bootmeths
Date: Sun, 12 Oct 2025 00:43:53 -0600
Message-ID: <20251012064412.2892979-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012064412.2892979-1-sjg@chromium.org>
References: <20251012064412.2892979-1-sjg@chromium.org>
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

