Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC687C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 001458076E;
	Mon, 20 Jan 2025 22:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CNhGe5wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D467B8076E; Mon, 20 Jan 2025 22:53:53 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B20D0806DC
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3cf82bd380bso23610205ab.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410030; x=1738014830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vv7PesRV3h0tuXX7B22wAEKvVoiVOUuQoFnUgsikxg=;
 b=CNhGe5wfMGdnRztxO3IIgC+2pBkX4VKtMMav+afAKoj9clL3/QvNSbSUCeQDxL6GSl
 k11x+hd9AFCAr3nFsZYpQfc6D7jkdgPfXEGLgXmT5gnOUB+cbEqryjzHRf3frdvLebiJ
 CBy4vDD+RpgPsMYD/PDK32+0jsyc3mSA4xXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410030; x=1738014830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vv7PesRV3h0tuXX7B22wAEKvVoiVOUuQoFnUgsikxg=;
 b=YgR1zzQHDBjcNRzJRAc0cuNUpMxy21X0AfVE6+L/IZSSAmt32Z1eUn+JuO1tyqHClv
 Lk2zvJguV7uhXsoKF7Ast0bY6LuZYkYvI70NJNCtQLjq31pCqmNXTdwKLTTN+j+cLnnV
 U24MsxJ3HIrsA9M6ur5xlOqNQdEGCqParmkLEWtoYT4qmtvHmWJbxTZXKSlLpBOSRjTd
 G+FrVmMTiEGB0zBRshaY6qDTbIRy04hgx0JWzSV45O1qNU647vqmpaj5NxHOPmOu4Qgl
 TIN7N1+TkTnl9145QJtvDzle3C6YQckwbtNUmIE/hrTuwLUSLn0PHtkdQfLaaeDwOli/
 B1gQ==
X-Gm-Message-State: AOJu0YxlRceYfIgB8ydb0MfpCNzyIjVG9ehYHAjvH6JVudU0++7V8vlJ
 V0McehkGuOkiEf9NkRBqZmWUhKkhy9G4pGaD+gRLNZNnFiJYMmIu1KleZy2rFDfd4DteXTuJgOs
 =
X-Gm-Gg: ASbGncvGRtjxne/IC7l+/4r1nLu3IvckCoMX2AjI59qJTjvyIn+3BUsDyOslVP8rniR
 N4YdSv/cKhxYqRH0E7eDMSJ+q1v0GjuDTR0rgmTl0lLTE3ne/aunTeK4js0XKMGekUpoIzwl8DD
 BeD27QDLvJ1tyg3eVTs2sVpOtbtoAD37zdLmaYK0m5uj+2awzOv2LDbYCxL2Y4aaEQe2l9Jc7JN
 pDGwd8D+gZaBmNsjS4cICBQJ5bVCiYUZdi3FlDtD8nI8+IUyAiaysGeN2pToUVOwk67NBDlecRL
 o4OofyhMFGREni+4gRD2r5hb+njH0xo=
X-Google-Smtp-Source: AGHT+IGiiX2uyXhg25OvKDQwhJpZjzPwngc4GMowCSL1he4OTcofelZhygSHRIQnNTK+p8Yy/emHZA==
X-Received: by 2002:a05:6e02:12ec:b0:3ce:afa6:93cf with SMTP id
 e9e14a558f8ab-3cf74495d71mr100922715ab.17.1737410029927; 
 Mon, 20 Jan 2025 13:53:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/28] test: Fix a stray asterisk in ut_run_list()
Date: Mon, 20 Jan 2025 14:53:01 -0700
Message-ID: <20250120215340.617194-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

Drop the unwanted asterisk in the comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/test-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/test-main.c b/test/test-main.c
index 22b9b46d9cd..815f54bebd5 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -701,7 +701,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 		has_dm_tests = true;
 		/*
 		 * If we have no device tree, or it only has a root node, then
-		 * these * tests clearly aren't going to work...
+		 * these tests clearly aren't going to work...
 		 */
 		if (!gd->fdt_blob || fdt_next_node(gd->fdt_blob, 0, NULL) < 0) {
 			puts("Please run with test device tree:\n"
-- 
2.43.0

