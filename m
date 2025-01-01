Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3893E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B431804BA;
	Wed,  1 Jan 2025 23:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R282XHXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D0780601; Wed,  1 Jan 2025 23:22:52 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9388042F
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so154476285ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770168; x=1736374968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJSwt7iPb37W7QrEWh3bwyDmqdzJboNVSN9IKIl0imA=;
 b=R282XHXePWZ2DEpQlfizLeLA2r+qBqiJF06sThR6ChitdJmcm5XqVHceQc/5Ncub2i
 cJiqeZS/Y2gjsIviezIbyGdcn8jblA2UT3Q/QwGqZ4sLydgi5523QdGP0boKByEQmOP2
 zrq2R30FAjFu4ETeVIe/GoJDAaxWQ68fnEY90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770168; x=1736374968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJSwt7iPb37W7QrEWh3bwyDmqdzJboNVSN9IKIl0imA=;
 b=QdJvZfn+5PYk32i7Pdx2WhNClouEuA/kKtsJNrac8vb7IVz/BHUO7smQG4ecgzn7tF
 1xiEpbE27A5TMtgj2OnbTRM2Fi3V/ofgamrKNwJPW0j1mvZBrH76k8FIHXieezryxzho
 PauDYAGuoujeX+kk+do1pGPVk6lwNYqGVa/HcE8kDBDmIxYAKAwXUU/uwHruWDLM5bsY
 Fqdjk6IxBAHnHHKDUa0zV2iZrY4HWMHvpE4KgA0p2iBLcB9ys7im6qZt8TkqsYU7TQQI
 fIzPI5OsD1PVv87kOalEQPbdUUFet7xDLw0tLUyGRlh1Yl01jQWI1JPDXhYRaVZJnBSl
 z1qA==
X-Gm-Message-State: AOJu0YyBlNt4c/m71VzXjZKZsQrmk5V9Ja2vGY29vI8D9es5K/vNPrAh
 HF18lsg/uvcFpH837EMqZX0vo7cHznS0Ln/XHn2OYteSPlayLrA+ZatI4XH9skKsJi+oa0kYJ54
 =
X-Gm-Gg: ASbGnct71D7eZn/JrycxoJCpx0tIh4II3OHgHOrBHV7Wbbe9dKQAzd7Y+9iOPITkWj4
 pKfwi7M1vzOwKSFUJaONN5wU21giAZrQv9m7hjJ5n0rqUMvsGALDtq6qX63NzwHhSHLir2QKdHn
 kwTFFoq5koiwVW5eODJPkpgVt3lirModDosEi2YcP5/PQfO7ZHJVKdyCPrl0wLN7qnFrfRv3rjj
 M1jP+Cdw081Cm6adL2PJc58DDdk0VaD32Ss6oCRLE+UFQrIEE+Fg7s=
X-Google-Smtp-Source: AGHT+IHZ1OQ5tr3ZKVhHfYBwI3ZOFiMYXq8gEy9WZp3t/N51Sdop7yTz3C7D1vkpZ96ZF7C+G5FHcw==
X-Received: by 2002:aa7:88cc:0:b0:72a:a9d9:55ff with SMTP id
 d2e1a72fcca58-72abdb0170bmr63889248b3a.0.1735770167996; 
 Wed, 01 Jan 2025 14:22:47 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 53/67] upl: test: Show the handoff FDT when debugging
Date: Thu,  2 Jan 2025 11:09:39 +1300
Message-ID: <20250101221003.1944600-54-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Add a few lines to print out the entire handoff FDT when LOG_DEBUG is
enabled, to aid debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/upl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/test/boot/upl.c b/test/boot/upl.c
index 89201e445ff..e1454ba3469 100644
--- a/test/boot/upl.c
+++ b/test/boot/upl.c
@@ -6,6 +6,8 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
 #include <abuf.h>
 #include <mapmem.h>
 #include <upl.h>
@@ -341,6 +343,10 @@ static int upl_test_base(struct unit_test_state *uts)
 	ut_assertok(upl_create_handoff_tree(&upl, &tree));
 	ut_assertok(oftree_to_fdt(tree, &buf));
 
+	if (_LOG_DEBUG) {
+		set_working_fdt_addr(abuf_addr(&buf));
+		ut_assertok(run_command("fdt print", 0));
+	}
 	/*
 	 * strings in check_tree and therefore check are only valid so long as
 	 * buf stays around. As soon as we call abuf_uninit they go away
-- 
2.43.0

