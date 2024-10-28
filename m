Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB8CD1039A
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0992A8909F;
	Mon, 28 Oct 2024 13:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gvOf6sfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70DF5890D7; Mon, 28 Oct 2024 13:48:29 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7976F88C53
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c97c7852e8so6078644a12.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119706; x=1730724506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMupRZYQYt3dwVcr5vg89SYPtTxp/HxeirRgMEkb2EQ=;
 b=gvOf6sfCi92Zl34HN71r5PL+te/aSDzQrFGsv52wbAwc7JYRmMEVJRDoX1/PDRFTaL
 /K3m2qxSmrOvhdTZZBNawtekl2FWKF1MCFLvcrqosw6GFuPPMDhUcqbXVxDBMQxNFRaY
 QHyl79M1/VKVVxxSlAek0a+ndos/4yBsWkINQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119706; x=1730724506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BMupRZYQYt3dwVcr5vg89SYPtTxp/HxeirRgMEkb2EQ=;
 b=N/U3ZQaRiWiH9wEkvx0+cgUHeT76S1gbI0+JSQXr6zm49ffvUlmbjfdjUEGeJYxV5E
 IZ3PDDKX7opCLSC+RrKekhtW7Fa6RTfDq1Gcn6mseVkDAys5tmem0pfC3EDn7lWcSyRv
 /0EWqVicKZp8TOYmPsi6o/3a8Yw+CsauPO3uZC/xV+fogVbJKo1lQoH5qLpEojn4KE8B
 RSEWb9S4i6ZV1ze0QdXY+9V1jfMxHkO2l2lXM3aHO88ynyGhnXKBIv7lh+URBQIt/R9K
 3eNORDOH+e/jkqcdbEqRKmnAMTHV5q9tIefn9niv5rsPk4rEvPINvTx44I3YkrIJfYuL
 sZnw==
X-Gm-Message-State: AOJu0YzZdJkWwdUxRzEWlLI7AmQxwvBHy6E3T7irlGZ1dN3eTVNOnUjS
 5mwpYGMvIq5gsHPDSzn3ELPCOLEf+ZA4szXyHOeFAqKBuw+2IN5LTpsR+gYQzc0ekFxrGfYSGqm
 xqQ==
X-Google-Smtp-Source: AGHT+IFfXfzJjiqDb5o5KPPB5gOfo56T1xEd3EghKceIHCjd5bArni9FXi3MohCZGKoqZsHgZ0SQ5w==
X-Received: by 2002:a17:906:c105:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-a9de615ad79mr778560166b.52.1730119706389; 
 Mon, 28 Oct 2024 05:48:26 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30d6fdc5sm375593366b.163.2024.10.28.05.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:48:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 02/15] test: Allow saving and restoring the bloblist
Date: Mon, 28 Oct 2024 13:47:53 +0100
Message-ID: <20241028124815.47262-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124815.47262-1-sjg@chromium.org>
References: <20241028124815.47262-1-sjg@chromium.org>
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

Tests which create a new bloblist overwrite the existing one in sandbox.
Provide a flag for tests to declare this behaviour. Save and restore the
bloblist pointer so that other tests remain unaffected.

Note that when sandbox is running normally, the bloblist has been
relocated to high in memory. The existing bloblist tests create a new
bloblist low in memory, so they do not conflict.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/test.h |  3 +++
 test/test-main.c    | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/test/test.h b/include/test/test.h
index 92eec2eb6f9..21c0478befe 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -29,6 +29,7 @@
  * @of_other: Live tree for the other FDT
  * @runs_per_test: Number of times to run each test (typically 1)
  * @force_run: true to run tests marked with the UTF_MANUAL flag
+ * @old_bloblist: stores the old gd->bloblist pointer
  * @expect_str: Temporary string used to hold expected string value
  * @actual_str: Temporary string used to hold actual string value
  */
@@ -50,6 +51,7 @@ struct unit_test_state {
 	struct device_node *of_other;
 	int runs_per_test;
 	bool force_run;
+	void *old_bloblist;
 	char expect_str[512];
 	char actual_str[512];
 };
@@ -73,6 +75,7 @@ enum ut_flags {
 	UTF_MANUAL	= BIT(8),
 	UTF_ETH_BOOTDEV	= BIT(9),	/* enable Ethernet bootdevs */
 	UTF_SF_BOOTDEV	= BIT(10),	/* enable SPI flash bootdevs */
+	UFT_BLOBLIST	= BIT(11),	/* test changes gd->bloblist */
 };
 
 /**
diff --git a/test/test-main.c b/test/test-main.c
index c825f9c7797..e1e8c6cde4b 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -4,6 +4,8 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#define LOG_CATEGORY	LOGC_TEST
+
 #include <blk.h>
 #include <console.h>
 #include <cyclic.h>
@@ -379,6 +381,12 @@ static int test_pre_run(struct unit_test_state *uts, struct unit_test *test)
 			return -EAGAIN;
 		}
 	}
+	if (test->flags & UFT_BLOBLIST) {
+		log_debug("save bloblist %p\n", gd->bloblist);
+		uts->old_bloblist = gd->bloblist;
+		gd->bloblist = NULL;
+	}
+
 	ut_silence_console(uts);
 
 	return 0;
@@ -402,6 +410,11 @@ static int test_post_run(struct unit_test_state *uts, struct unit_test *test)
 	free(uts->of_other);
 	uts->of_other = NULL;
 
+	if (test->flags & UFT_BLOBLIST) {
+		gd->bloblist = uts->old_bloblist;
+		log_debug("restore bloblist %p\n", gd->bloblist);
+	}
+
 	blkcache_free();
 
 	return 0;
-- 
2.43.0

