Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDE7C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EAD83A61;
	Wed, 28 May 2025 14:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fEr9nZ1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB90A8397A; Wed, 28 May 2025 14:33:40 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C9183A5E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-735a6faec9eso154178a34.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435616; x=1749040416; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kokxPTOiNCifPxRaPpPOEH5wI101j8LBa23p+gWgshg=;
 b=fEr9nZ1CBqw6uk88dXD9XHVBQFhqHFdUAkWXmy4m25XEfc6TwulVlu3GFxMUIC4IUy
 OykZugWrGORPEEDkwdW1eo7s1yNW0Rt2K/U1CYmOkATkTtpwFCTzt4r2Su9sSVavluoL
 V20InwDZa93NGJMMxDY/RM6gBl68yE6S79O28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435616; x=1749040416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kokxPTOiNCifPxRaPpPOEH5wI101j8LBa23p+gWgshg=;
 b=sfrKfT07UY7oGUG82fU8ZI2kqy3D7rU9TvruBMSEbCkI5cVH3Zf//QoiBCulNlhDVg
 UEYkj8WDjaye59PBzPaVIH3S9oV91jR9pmx88qTB/wX1xQMecDynx9MhXTEQ/V0SLVu1
 amkpDPkyeEknVRhVDIA418tfSV4Q21EDxLQ5ZLpLLaVHxJtySoRkFAi03PAry3+FvLLw
 avnCL0lWWtG7g8WWqq/T97zaGeDupR7NIZVVhtIOXGTjCXPdQiSWVjNwhZiFmuzZv2ue
 rXYrIp8Lw9ncDD6yNQ1ZrFgDJ/KCMsUdNHXoRWuehkC637hBPvTuitv9H5kLSKbkwUky
 IHMw==
X-Gm-Message-State: AOJu0Yx49cOslNPwot88rUn1GWZZ02SEQQvxJYNNN+RE/8kRq9JCo92J
 Gfc1O8TDdpb8XY2zDV0MiFmn/5c6Rowto89i4ID+/eD8HZwKQJU/ZSSd9H0KCDXLX15QsXFSk+I
 Mata6HN6O
X-Gm-Gg: ASbGncv08BhMDId46J6h7xz8llV9NhIpqlJ9lZVMBiBJIecJpHjVGdQzmOUO+TWFGxk
 hNepYsHOL2R/Ia1amUat508o6qH02DVzH8UWEvBfoK+qD5Znr5YgFCoRhMfJLzcH7Im9x32kDoQ
 N3FzTZZaKeFBaufx+BZgB+btdMuK8t4Q/JeB54b4EWZejGjDBKUjG/DQJwrT0AJXe88hBZw6+31
 w/GBZ0Mm6crEI8RcZ75aQyczdVIgQLOWKnzOTrO96OwSTPLKAkLY5Qop7fWY/naM45gdZjQ2qy9
 2Fwe77jUUK1tTlhDNOx76GNcw38BKVlwmOMdek32CpZByN631nvLmh7dqkb8yJfGq+/gV63ZfxO
 0xSwWojmr5lMe
X-Google-Smtp-Source: AGHT+IFxj6V9lCdJsy0PedSp/sbtpAOtu/grgH9s+AgduUmxiJHWgzXiCdhTU7lxqzgYaQ8uIutj9g==
X-Received: by 2002:a05:6808:6f8e:b0:401:ea47:2c4a with SMTP id
 5614622812f47-40646829b0emr10243980b6e.28.1748435616645; 
 Wed, 28 May 2025 05:33:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v5 11/25] bloblist: Drop bloblist_maybe_init()
Date: Wed, 28 May 2025 06:32:13 -0600
Message-ID: <20250528123236.1138632-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

The bloblist is not inited any earlier in the board_f sequence now, so
drop this function. Just use bloblist_init() instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Add new patch to drop bloblist_maybe_init()

 common/bloblist.c  |  8 --------
 common/board_f.c   |  4 +++-
 include/bloblist.h | 16 ----------------
 3 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index c7322b96bcb..ac3fd3b64ee 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -580,14 +580,6 @@ int bloblist_init(void)
 	return 0;
 }
 
-int bloblist_maybe_init(void)
-{
-	if (CONFIG_IS_ENABLED(BLOBLIST) && !(gd->flags & GD_FLG_BLOBLIST_READY))
-		return bloblist_init();
-
-	return 0;
-}
-
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 {
 	u64 version = BLOBLIST_REGCONV_VER;
diff --git a/common/board_f.c b/common/board_f.c
index e9ffa2d7fed..006a1717c29 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -910,7 +910,9 @@ static void initcall_run_f(void)
 	INITCALL(log_init);
 	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
 	INITCALL(event_init);
-	INITCALL(bloblist_maybe_init);
+#if CONFIG_IS_ENABLED(BLOBLIST)
+	INITCALL(bloblist_init);
+#endif
 	INITCALL(setup_spl_handoff);
 #if CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F)
 	INITCALL(console_record_init);
diff --git a/include/bloblist.h b/include/bloblist.h
index f32faf78560..04d72e786f2 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -476,22 +476,6 @@ int bloblist_reloc(void *to, uint to_size);
  */
 int bloblist_init(void);
 
-#if CONFIG_IS_ENABLED(BLOBLIST)
-/**
- * bloblist_maybe_init() - Init the bloblist system if not already done
- *
- * Calls bloblist_init() if the GD_FLG_BLOBLIST_READY flag is not set
- *
- * Return: 0 if OK, -ve on error
- */
-int bloblist_maybe_init(void);
-#else
-static inline int bloblist_maybe_init(void)
-{
-	return 0;
-}
-#endif /* BLOBLIST */
-
 /**
  * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
  *			       the register conventions according to the
-- 
2.43.0

