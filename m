Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CE3CA0EC5
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85D988B39;
	Fri, 30 Aug 2024 12:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Uv0Sx0vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617DC88B08; Fri, 30 Aug 2024 12:17:40 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5768817C
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3730749ee7aso1123378f8f.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013058; x=1725617858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a68050JC5rK5hfB2a9j4UawOLTypKRKojFbd/4GMZ7w=;
 b=Uv0Sx0vgJEwPhBjz8HMAhx7BK6yoWmuRK2m3AzRVa0M8kGf5YDqYNuWLuMheIrVAR/
 PyGETmUH2aJI5ZaHcFgxY5RZHE7DW10Yukp1SZxPkj4bMGW52yrrTcY3W6A6aXaAKSs8
 zzF2SkO7C/42sd27QX3HCbm5ZPcbCPn7geY1O0gaZqEAQrJPB/4d93V7RA20xiE/JOUE
 F8OQ0rSY7GzX/V557GWw20PArup9Gnjq++xoj1yeEOY6gDBZe8Agt+FqOyhouVqm5+L3
 sfsUl1jlSH0JIG6bsC4pvIufBgCm6xyV6Z+puDIh+wB5AAsoNU+smc+/rS2e1oT21eI3
 OYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013058; x=1725617858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a68050JC5rK5hfB2a9j4UawOLTypKRKojFbd/4GMZ7w=;
 b=RqbQbu29ry0PIVehxs1+8SuXNCnXjpe3O/gwxLfT4wcjOiAtOjleZPJ/2hElSDp8Cp
 5uLjWDNXwjyjEzkgxfVhHnJj/bHRbj/xwxrbtUtAlC3qPGAp89lHKFedXc7r4/QWMLqF
 OprKUwnttesOPXD86jWF6bnVtPpRyeLUwn67mBd1aG2k94RsE4EBbSwjwMbzhAkUUTQJ
 d3upl2kcY9XyoN95T2vKH9mD8b4jWmxY8VFlSMHlnsGTMDWn9Hbe9qPx/XMUEPQtrCjj
 PTvpNhE8S2rAAXVPqXBXCduGJYuGIFebgzAck0IucUqVy7iedGb7MtgVC/hhaAlTX8S1
 416Q==
X-Gm-Message-State: AOJu0YzJfhhn093IhCARIukK6SVFYYIY32VeyKdgQzdW+ypUMxg5bv6O
 TfLwFlBYI/W+s1P1MUvLrmivOPepWbmWPum2kD2Ye6O5feeQTU7IeJv3/CQ6RiPrNFjkANme+6M
 1s3KZMcsX
X-Google-Smtp-Source: AGHT+IHZZM+3aL6I7lZ66jsu0+Cm6p41R4/WZbzbI9+RuxL9xo1tn8SaKd02p5Av4GWdUoblHJZsKg==
X-Received: by 2002:a05:6000:184a:b0:371:8486:b29 with SMTP id
 ffacd0b85a97d-3749b57eb87mr4472251f8f.47.1725013057720; 
 Fri, 30 Aug 2024 03:17:37 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:37 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 13/16] test/py: test_efi_loader: add missing dependency on
 cmd_tftpboot
Date: Fri, 30 Aug 2024 12:16:56 +0200
Message-Id: <6790fe75b02b4a5cdd05c30f6704c43c0c8fccc3.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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

test_efi_helloworld_net() and test_efi_grub_net() depend on
cmd_tftpboot so add the missing annotations.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_loader.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049..7c1e0ffa59 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -149,6 +149,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_helloworld_net(u_boot_console):
     """Run the helloworld.efi binary via TFTP.
 
@@ -178,6 +179,7 @@ def test_efi_helloworld_builtin(u_boot_console):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_grub_net(u_boot_console):
     """Run the grub.efi binary via TFTP.
 
-- 
2.40.1

