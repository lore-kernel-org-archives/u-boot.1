Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A4EC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:05:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC30887CE;
	Tue, 11 Jun 2024 22:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q2iORBnF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C23AE887B4; Tue, 11 Jun 2024 22:02:33 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B322788789
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3759e1ca122so12540555ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136150; x=1718740950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4PckMd1VrN3KC+ErpFYV2XSdLhICyhnWuN5RSX9y+Y=;
 b=Q2iORBnF6HuID51kVC1KXrlk/os5uaEF+HB8QSv1Rhng550uE391h2FZHxhMK51gqn
 oEslTN1p+RV4hyd0mlSAZ0ricHE5Q0CnvkCigLW9yL0Wg3jSBsrL1Q8X6LGrtOeOU3sO
 WgFijom3T/wj8xi2UJMlPEgLkAj0rJhJYXjlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136150; x=1718740950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4PckMd1VrN3KC+ErpFYV2XSdLhICyhnWuN5RSX9y+Y=;
 b=CtKmWUotlLsLHYmdICHNnLF40wkbsinQt2SIWRhyzzezparUZqEXwPkOthHImvqBMx
 I2B7og1pO4xCI3t+8RGOFesrtqiwbKIfXFdtdkGOe4CWLG11jVbuthH+pGTuqjXaWoRp
 ul2aNqiNNIROIcPlByvMD04T1r7xLhjY1+f8DE2HlHTuFNT2Ke2QkLOO3DQoPnxi/YV4
 l1Y6rEYxsmvV6QSMarPEF1DremyqpglQlyUzQU+gKkXObpyxEncwdnaZsc8dAkGZbddr
 jy3aFxkM3/H+2nJhFJmhqvJL+MYs+9FPQ5c9MtUok4jpianL+YphTnWMzObf4t4G2Z3g
 7Fjw==
X-Gm-Message-State: AOJu0YzMMUVKczGaOb9hF2dqx+0Zb1fldm9LTEFtujhuPWueK+aDEr+G
 rp5Wr9zWU4tEr1f7PjCgmhpgHA1YTwWEyK4CLxxE9rsJ7YtQnCeBd/RPEYE6bp/BNKK+cZXzoVc
 BfA==
X-Google-Smtp-Source: AGHT+IEoAsGUQLZ8kV+U3Tju18j7aPt5AVUq15xdmn3p2/1Lc01JjnzYzP6GJ15RT9krOAZI9fdQPw==
X-Received: by 2002:a05:6e02:1d17:b0:375:a8a8:8e7 with SMTP id
 e9e14a558f8ab-375a8a80dadmr71719035ab.8.1718136150481; 
 Tue, 11 Jun 2024 13:02:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Gendin <agendin@matrox.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH 20/42] test: Make bootstd init run only on sandbox
Date: Tue, 11 Jun 2024 14:01:34 -0600
Message-Id: <20240611200156.2245525-21-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

Tests for standard boot need disks to be set up, which can only be done
on sandbox, since adjusting disks on real hardware is not currently
supported. Mark the init function as sandbox-only.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index c169c835e38..58205066ec8 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -470,6 +470,7 @@ def test_ut_dm_init(u_boot_console):
         fh.write(data)
 
 @pytest.mark.buildconfigspec('cmd_bootflow')
+@pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(u_boot_console):
     """Initialise data for bootflow tests"""
 
-- 
2.34.1

