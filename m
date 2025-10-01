Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CDCCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:29:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01EE083526;
	Wed,  1 Oct 2025 23:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mmg3Pywq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33059834D4; Wed,  1 Oct 2025 23:29:38 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B86C834D4
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-42d86db0eeeso1731065ab.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354174; x=1759958974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NPW/UiKSxM3DG4GY7mg/EyDUip/bzZgKp6nnv/gyLr8=;
 b=mmg3PywqSPsRXlzZqCGEJ6GlzdAhEB4mWPJJm3XM3h+2wOKfjBTkIlmxQnTe4jEs2e
 0cpqs3CLOzRivzcfhHLksHN/yErflJVtuL17FF47R3lWDpmmrZITHcCVi8QP/aT3g+QO
 OS4UD6ioi+/MaEKxpt7VEXGYz0IzdebApHcNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354174; x=1759958974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NPW/UiKSxM3DG4GY7mg/EyDUip/bzZgKp6nnv/gyLr8=;
 b=m5gUztR+Ps+R+2dWKIKUaFo5GO9ubiEiJmrFB8LZjHCUe0oG0QQ4ZbnxXlivDosl51
 /9vstsuTrzfM3KRP+SqykuXx7mpq7rphhb9SSa/FPfyQE+4wxvxjBwPoKpEiHPCJjDjb
 oyJTa56/V+eeFGPz+NEVzKLVTGyxqr8LZc2Xznxm7nXBxP9cND1JnmSojQx3F/8WUmVM
 54GD+RRCN5FIgeTnDjHJDg560yYN/GCzEFSLh4SFZzUNmUxbMXbSEa/YWmyT4zMmn73d
 xlpeLxZYBdwGrcVIigF7Lufm648CoInJZFr+raUOFcjlJgIJi29mAFpCnj7vEUTIm1We
 G6Hg==
X-Gm-Message-State: AOJu0YzKty3E9sepB+vGHrPvx3rmLMa8eDwfLi2HSYBYXxKGcAxEoI9V
 caOX3WvoCkEeUZu9NBi+plJ/rr5PgpWgMym7g/Ehrh8Vb4fO4EAcbXkmyBV14txSEmKc7n8peVE
 txr0cNOu/
X-Gm-Gg: ASbGncvujMN2CqPGwE9EYQ/8GKvDEkpfue43VeHXok2VNAqJaB7CwVfHZ0IQbhQB0If
 o1yF4Mc96ysTkgb90m41hRYfgJkv5vOtY2sys2f4lpdgJ1ex5vFcxeQpIfAS+OBsjoywIl6pp1g
 dgOu6JpmPtYeymoDWlZLzAEMGABLAP9enXTZ6bKcST6eWbRjcDZSZe6MjokUi7hQCqE5AJmOla4
 rw3VCV53svRythhpW/i9gCmCm1deWfurDJp7+2oxW/H/pGbVXiMguO0JWjpq801IsmnJBcuuIPh
 4aI82twNbLMvU7Xn5kVCTPCvpuW6lal3OrxlIQFcLz5J8+aq1qQpRYkPrV6Gw/xgYBtcM9h4yCV
 WVv0xEEHSeMHDFIZW7v+AM2NmGnUAJmvW91wMx+rXLyAcpbBZ3u4=
X-Google-Smtp-Source: AGHT+IHGiSGqOtKH/eKyxDWAGJHYCtzXtYul6gGjK2NiwB9zrT9zUdUwp9spps+ZP3yKAiLhyokPUA==
X-Received: by 2002:a92:cdae:0:b0:426:dc47:c8cc with SMTP id
 e9e14a558f8ab-42d81680000mr68261895ab.23.1759354174070; 
 Wed, 01 Oct 2025 14:29:34 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/17] boot: Improve comments related to global bootmeths
Date: Wed,  1 Oct 2025 15:26:26 -0600
Message-ID: <20251001212649.3263574-2-sjg@chromium.org>
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

Add a few comments about global bootmeths and first_glob_method

Fix a broken line in bootmeth_setup_iter_order() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c        | 3 ++-
 boot/bootmeth-uclass.c | 4 ++--
 include/bootflow.h     | 3 ++-
 test/boot/bootflow.c   | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index d79f303486d..8f38a1ab940 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -147,7 +147,7 @@ static void bootflow_iter_set_dev(struct bootflow_iter *iter,
 			if (dev)
 				printf("Scanning bootdev '%s':\n", dev->name);
 			else if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) &&
-				ucp->flags & BOOTMETHF_GLOBAL)
+				 ucp->flags & BOOTMETHF_GLOBAL)
 				printf("Scanning global bootmeth '%s':\n",
 				iter->method->name);
 			else
@@ -344,6 +344,7 @@ static int bootflow_check(struct bootflow_iter *iter, struct bootflow *bflow)
 	struct udevice *dev;
 	int ret;
 
+	/* handle global bootmeths if needed */
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
 		bootflow_iter_set_dev(iter, NULL, 0);
 		ret = bootmeth_get_bootflow(iter->method, bflow);
diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index 188f6ea1895..918d78ec2c9 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -156,8 +156,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
 				}
 
 				ucp = dev_get_uclass_plat(dev);
-				is_global = ucp->flags &
-					BOOTMETHF_GLOBAL;
+				is_global = ucp->flags & BOOTMETHF_GLOBAL;
 				if (is_global) {
 					iter->first_glob_method = i;
 					break;
@@ -204,6 +203,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
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

