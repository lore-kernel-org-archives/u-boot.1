Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACF1E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F6587442;
	Mon,  2 Oct 2023 03:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bipOWjAs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026F687135; Mon,  2 Oct 2023 03:18:03 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C25487241
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3ae1916ba69so8922657b6e.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209372; x=1696814172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spYLSsXkWbQLVCs1v7fwmZoRkg58aBXWIr65dQdWTxQ=;
 b=bipOWjAswZn1lnpyJ90eoSMgY7i8/xAxJkw+erioFYPsFp7Hx827jrz4lsKmX4ACwI
 PjvazXFJIAdSKOi4VRBwJt3X0V9Fv9dmy2O5Kf4MSt+Niv2WoKWrNMdw2tyoCVQvF58a
 5hcm2VCqbZQegr6H8eIipk6YJXMbLMjwWkL3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209372; x=1696814172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spYLSsXkWbQLVCs1v7fwmZoRkg58aBXWIr65dQdWTxQ=;
 b=JXkfbUENXJ4/JjbgkfQM0S/1Caq+Ypq6LPnupXUo7midQaAe8rySMq5ESSLnA9E4TG
 3+juJNHk5WDQ8fYT5kwd2tbcQ4YqnA1zDgN4TdrU5AZoqSRrgqC7iPW/mvAV6Lfh5vjC
 8UdDPelQtf+tHgDiJX0HRG7lg4bUP/AeugIy559jAPJzDFWyLDBo813W4Vuxr2OY6GGz
 vd/dA6QC1Z+T73nM4Ex0mqlB2z1hijYgV0S72yz2daw8wIRTd3t1Fu55IackG345E3SO
 5ioqrw2g8QcvCYXa83IrwcoTXC0nZDuklPZt0c/wGMW+lBP8Zs7dbr1AaEnFPJw+GOPr
 uuJw==
X-Gm-Message-State: AOJu0YwTK4zaAVi12fsGJeZZsTDPlyh0YmVIV/9Mx7KjQWLE6no42ZZq
 9eriQ+q3UY/n17ZGRt1+Q/xVW94ruQr/8fOjhvU=
X-Google-Smtp-Source: AGHT+IFsS0hAsZDZylZwLpTp+MqC4faIhUcfNqd+x1AS/3NV5DY4c6U8xEYrs9tQoRPuwZ8INOOHEA==
X-Received: by 2002:a05:6808:1a13:b0:3a7:6213:6899 with SMTP id
 bk19-20020a0568081a1300b003a762136899mr13345558oib.24.1696209372435; 
 Sun, 01 Oct 2023 18:16:12 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH 09/34] test: font: Add dependencies on fonts
Date: Sun,  1 Oct 2023 19:15:19 -0600
Message-ID: <20231002011553.463514-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

The font test needs two fonts. If one is not available, skip out early,
to avoid an error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/font.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/test/cmd/font.c b/test/cmd/font.c
index 40682e5ce495..1fe05c1ead51 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -30,13 +30,17 @@ static int font_test_base(struct unit_test_state *uts)
 	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("font list", 0));
 	ut_assert_nextline("nimbus_sans_l_regular");
-	ut_assert_nextline("cantoraone_regular");
+	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
+		ut_assert_nextline("cantoraone_regular");
 	ut_assertok(ut_check_console_end(uts));
 
 	ut_assertok(vidconsole_get_font_size(dev, &name, &size));
 	ut_asserteq_str("nimbus_sans_l_regular", name);
 	ut_asserteq(18, size);
 
+	if (!IS_ENABLED(CONFIG_CONSOLE_TRUETYPE_CANTORAONE))
+		return 0;
+
 	max_metrics = 1;
 	if (IS_ENABLED(CONFIG_CONSOLE_TRUETYPE))
 		max_metrics = IF_ENABLED_INT(CONFIG_CONSOLE_TRUETYPE,
-- 
2.42.0.582.g8ccd20d70d-goog

