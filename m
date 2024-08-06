Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2339DC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 271BB88AC5;
	Tue,  6 Aug 2024 14:59:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E4obG7gD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13C5A88A8B; Tue,  6 Aug 2024 14:59:48 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262A888A8F
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f8f0197abso22497839f.2
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949180; x=1723553980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uJjzM9tGMPYpEbEk1+GUvH796d8fS1/TGJduXx4EOAU=;
 b=E4obG7gD0JcrN4bDCvbyR8+dNu812AnILoqGsFUNaPPbVOuLikHDjBUAozB9JVECE7
 l3gNu1zrMzsLTfa6zkURpf3OB/wg07c8JDYwLniST+Z0IdPqzR3jQU46RYnKZPt9EgH6
 tp8rIU0YcLpE5MJyMc4wopZb0fToisMne5f3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949180; x=1723553980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uJjzM9tGMPYpEbEk1+GUvH796d8fS1/TGJduXx4EOAU=;
 b=ey1xnOyoeRO7jKfzf6ewa+GgCJ7kZybrBIausMQeQD5pDLueWTu3n14b6AX2nhrCwY
 qymVqzYbsD8lfflvtRfwG6h4+p1iPcqHgm+K+kwuCM5Riz/nCbM+B/7twb50e2hvtIKI
 LmkX3D94cZsjzE0D5BSJbN4LVIk/e6aFwjw/1N45eq68Qv6E9aIfx1vwSou1NNpwjcyG
 O20RwfnwCj7sEo+wEZgxESUTfKkzHepGK+gvaGB8Ow8mqYo1DHTCGcem8DkKXp0Axrr0
 +7qsjcwW2loR3SFg+HnUT6/KEt/lvQxWCZwcCEeMQis7PGRPkmfQa3kyWB5QKkStcIRE
 c1gQ==
X-Gm-Message-State: AOJu0YwDXybzvkEEkFLhbe44EdvsXDb2Rdw8o54OJoFAPetbX/BkhVGn
 b0E771KfXyc/EZyz04rgdjXNEER1RDbfaXdulzvtQcLOh4eOXyMTWD2EhuUguH4OHvxOLWtKvC8
 =
X-Google-Smtp-Source: AGHT+IF731sPQHFVByywORri9ApBCePmWnksN9SrccqRAo3PIH9EPoB1UIiSaOUk+NjAw7VV6RAzyQ==
X-Received: by 2002:a05:6e02:1d88:b0:39a:eabf:c28a with SMTP id
 e9e14a558f8ab-39b1fc11eaemr221889505ab.20.1722949179704; 
 Tue, 06 Aug 2024 05:59:39 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v2 24/39] test: mbr: Drop a duplicate test
Date: Tue,  6 Aug 2024 06:58:35 -0600
Message-Id: <20240806125850.2316956-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

The test currently runs twice as it is declared twice. Unwind this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 81ca6f15b2a..f1fc44051df 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -483,10 +483,3 @@ int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
 }
-
-static int dm_test_cmd_mbr(struct unit_test_state *uts)
-{
-	return mbr_test_run(uts);
-}
-
-DM_TEST(dm_test_cmd_mbr, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
-- 
2.34.1

