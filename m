Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA38E95A7E
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685B086F20;
	Sun,  8 Oct 2023 01:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jN7UKAe9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF80786EC6; Sun,  8 Oct 2023 01:13:53 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF94F86F09
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fa2dbd793so150708939f.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720399; x=1697325199; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDB8/R8mlMj3PKz0t2koAkI/TFpsW7xWQU/JEpFrTl4=;
 b=jN7UKAe9yFm/bRqjB9UlKMYoBtk0sSrmMwPCAk7L0fKahTjzg9iZc0raxpFRiszu6Y
 aYrNmGwTt6ESWIWKwTeQYnxMgKYU9LdhO/4AUeht5sZTJB93Kn4AHFsk61SJzUnE1ai0
 uxfoefUTuZgEslCoTsOxMdSw92PV3z2X8R8a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720399; x=1697325199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tDB8/R8mlMj3PKz0t2koAkI/TFpsW7xWQU/JEpFrTl4=;
 b=s1tE7U3qoDOHjdHBKO3lSiJZaMtJgrihRYLZ6ekCNsnrd3ktUNlt1Y6cwx82BfyUxc
 6gqlTtbzHXzl4ePhkVPS9+gGntoQugPaVeo/0qOtfZDWU3/phxO2g2sase62WbVGees9
 lJ93D70s2UPyWnYXFRPsafR3yoV2wozPTHlt36L5YDoBcuRoEQ919JB2AQ5Niezbz4iO
 eN+djtHposXAovlK5j31WSfsZLresOiwsjP7UYWabHlqAqGIBnN/FUfVh5x31h8SC1Zq
 PWKWn1Jy1V+L0nyn1voXqfgMeC/XVubXMLwj18aLW4rvAIZQyLRhsgw25DDzgFdkw8qt
 dIuA==
X-Gm-Message-State: AOJu0YyNXDpRyrNW1AA08kkJATEtgX6OaHHNLYh1ITJTA7neN4hkABtC
 cd17Bqg5+0iq0V8mwrRpwdzX4N8X6nh8D3EnJQY=
X-Google-Smtp-Source: AGHT+IEd2zeHnIX0xClnaTFb9fEZfwZa4hnxL/horiB9l6IcTGHt7tJXII+qiW1PIr3froBgN0xirQ==
X-Received: by 2002:a92:d24c:0:b0:34f:22a6:7f64 with SMTP id
 v12-20020a92d24c000000b0034f22a67f64mr11884449ilg.1.1696720398851; 
 Sat, 07 Oct 2023 16:13:18 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH v2 18/27] net: Depend on CONFIG_CMDLINE
Date: Sat,  7 Oct 2023 17:12:37 -0600
Message-ID: <20231007231255.277623-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

At present it isn't possible to use networking without the command line
enabled. Add this as a condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
---

(no changes since v1)

 cmd/Kconfig | 1 +
 net/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 96ea40109abd..c952b2e286cd 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1687,6 +1687,7 @@ if NET
 
 menuconfig CMD_NET
 	bool "Network commands"
+	depends on CMDLINE
 	default y
 	imply NETDEVICES
 
diff --git a/net/Kconfig b/net/Kconfig
index 4215889127c9..25d494e1db46 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig NET
 	bool "Networking support"
+	depends on CMDLINE
 	default y
 
 if NET
-- 
2.42.0.609.gbb76f46606-goog

