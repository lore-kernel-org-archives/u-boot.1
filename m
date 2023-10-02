Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A6DE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5598871A0;
	Mon,  2 Oct 2023 03:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JN7iq1JW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 463E987107; Mon,  2 Oct 2023 03:17:24 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3578E87215
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fa387fb96so506234539f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209369; x=1696814169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1CZ4oNuHFyI4faPd7cDlzaEevH4Mv+IwSEcZwYcgyM=;
 b=JN7iq1JWo/G8t+LWIVxen0vwhr0MVPv7BHYUNrflPY5Q96kBOKhmT4JA5aYRVqSJf3
 hiXoFF0WdyRNT2FprcEbr7J/yaJAK5ZGdbyTtUx6mtrc40bwAlhqtmBh4kyNrkNI3c2z
 vpEPbVdZ6Euh1vfLhSDAZfX61tQefvVS6ntHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209369; x=1696814169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1CZ4oNuHFyI4faPd7cDlzaEevH4Mv+IwSEcZwYcgyM=;
 b=aLseCA3mPE8Fl6eECCVRY2tsF/QzHjctm8uqOxeqLXDNVyRvy8wu5/uSbhDVb/VZMO
 dkFFb9cP72v3mSJM4ef/Ow0QW4OTF6bC4niFUnDlYrOCVIzV4RHfV5OpvJ8usEhGIclz
 TH+LvjxF1Q8VM7cBArM+hUN8uo99pwOu7tgfJRMhnaZEZt2y30TLrkpEBOQ6/NNkfMvr
 SN2DP0s6TEf7dOsqHlGoZqS4l++aQ8kYBEM86A7X8qpm+zkZAjwDTqa2oChEyy/jKhwC
 FtylK3Eie4UnTTaIVtP60gZZO8m2nF2mQeoU4lJOF7QfwIOYfmj4/xoqhSDdorj77IW7
 m/cA==
X-Gm-Message-State: AOJu0Yxyhv1H9UiIiDKp/AKLS3mkg8sBs7FJlzZtXXFwzFwrXRdHvha3
 /OPe8kLwBf8toHc+mfHbPhBp/+MUWbEQ1KeRDKw=
X-Google-Smtp-Source: AGHT+IGzIBHt7x+w0tEc8nu0non7gxyP6wQJ5Jowzj/FJN+FUoF/VL+HdPGao1Hm/WrgIfTC4qGgkg==
X-Received: by 2002:a5e:a71a:0:b0:77e:249e:d84 with SMTP id
 b26-20020a5ea71a000000b0077e249e0d84mr11789333iod.5.1696209369331; 
 Sun, 01 Oct 2023 18:16:09 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 06/34] test: Handle use of stack pointer in bdinfo
Date: Sun,  1 Oct 2023 19:15:16 -0600
Message-ID: <20231002011553.463514-7-sjg@chromium.org>
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

This test assumes that the stack pointer is the same across two calls
to lmb_init_and_reserve() but this is not the case on x86, for example.

Add a special case to handle this, along with a detailed comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/bdinfo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 8c09281cac0d..0f09a5a3e1db 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -114,6 +114,18 @@ static int lmb_test_dump_region(struct unit_test_state *uts,
 		end = base + size - 1;
 		flags = rgn->region[i].flags;
 
+		/*
+		 * this entry includes the stack (get_sp()) on many platforms
+		 * so will different each time lmb_init_and_reserve() is called.
+		 * We could instead have the bdinfo command put its lmb region
+		 * in a known location, so we can check it directly, rather than
+		 * calling lmb_init_and_reserve() to create a new (and hopefully
+		 * identical one). But for now this seems good enough.
+		 */
+		if (!IS_ENABLED(CONFIG_SANDBOX) && i == 3) {
+			ut_assert_nextlinen(" %s[%d]\t[", name, i);
+			continue;
+		}
 		ut_assert_nextline(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x",
 				   name, i, base, end, size, flags);
 	}
-- 
2.42.0.582.g8ccd20d70d-goog

