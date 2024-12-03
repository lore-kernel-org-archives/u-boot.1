Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31E4E77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 771D289698;
	Wed,  4 Dec 2024 00:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gLAKv0fV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88ED388F55; Wed,  4 Dec 2024 00:46:16 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690F88967C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-8419ef7c2d8so203472339f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269572; x=1733874372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+zZG6fLQOAfN627Etd1WaVgdXszogCdbESqGfPpazw=;
 b=gLAKv0fVHduD1h8dYFoc4kuW8TZWIr1zJ061f3iciF1nGBzKLE8d+HfsQXkrH7nL1t
 BG276jLWYY4b2tLgvGGM+ulYSJkj9JpB7fut3AW8cqB5qo1L+PZLU7MFGy6cqbQPm0wH
 unr5I7dnFymlWaEBFwwc6JHRRXtP3sHoFk+BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269572; x=1733874372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+zZG6fLQOAfN627Etd1WaVgdXszogCdbESqGfPpazw=;
 b=XEjaSuose6rKM0HfDbdfy6txrriEy4OHv00OhP7s1NSt5nPYnVlOUMgWmWrKrXcYFO
 26n0wWwIJOJKnkOU0aMfAoQBhLsFGXX/WYoNj5RpqlrUtxa3n3qDF/Oc2l4vVvAJUswr
 66N8ACoNPdhKShXMeVaIqwtFCIovedMVtltF8KH7W4YPCWqAMIyEkYh9PnvtyymFt9Pd
 1CwtbRiRYDO4C95IMIuRgd4QwJg8lfjKtvPbOUZJmcnfO5UCA5gDE4wQZ4I+FQd2FfSj
 BCcp8Svi3qxAd/F2RsG41ixoI3lXpvSUhIb0sLi0wxA4utRVtQhtAkGvnKRJdNrZL5Ss
 YNpA==
X-Gm-Message-State: AOJu0Yw0GQIJcpm1J7Gm//jscKKwTvikDHVrgZQGLlGH4m2Fxupdrfoh
 ff2gcaTqurDeGzYtccPEoeNuu3+9ldUH/fLd0+Mbe8HM2HL2Gz8qzgl1OcGMfr5HzVRO0OzKdMY
 =
X-Gm-Gg: ASbGncsVBquzQDtW3igCFovk3b5SEc46W0irilIX/bS0XyvY1F4/WpSP/j7Gv5gIgFc
 0jlUWlf5E6wuvlf4FXNHOfd6KCPq0Y14ZRrGNSs6O814o9rGeqWKr6yzzscWNjjM8uZOiSXOSph
 WrmmTb/V/9xSzVUyleNXn5oSU0RI1lRfyEFCuyUIesHco4EvBgtLveRcCkSGNmQNezFWnhdIk4W
 C5oapuF+dnlPYNJVGVCIAOlLfM7JSCKjXw+QsvCgoKlWOYdRTjaHBe59/EP3W5WWErnMZJT0Qr5
 fQv5x8pW+cE=
X-Google-Smtp-Source: AGHT+IHyMS9oFSzAOFtvdjL70w4i4lFjhJ6jqd/uvU8RW2hncAJHGCEpER9D3YpVJzbeZG+QYY0JoA==
X-Received: by 2002:a05:6602:1505:b0:841:a678:de3f with SMTP id
 ca18e2360f4ac-8445b42e47dmr553025539f.0.1733269572688; 
 Tue, 03 Dec 2024 15:46:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 01/41] x86: Make do_zboot_states() static
Date: Tue,  3 Dec 2024 16:45:19 -0700
Message-Id: <20241203234559.2938192-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

This function is only called within zboot.c so make the function
private.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/x86/zboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 94e602b8a5b..3035172352a 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -119,8 +119,8 @@ U_BOOT_SUBCMDS(zboot,
 	U_BOOT_CMD_MKENT(dump, 2, 1, do_zboot_dump, "", ""),
 )
 
-int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
-		    char *const argv[], int state_mask)
+static int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
+			   char *const argv[], int state_mask)
 {
 	int ret = 0;
 
-- 
2.34.1

