Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320AEC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D2E288B82;
	Fri, 23 Aug 2024 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cztrQrO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61311889EF; Fri, 23 Aug 2024 15:49:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9FC889EF
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4281faefea9so15102965e9.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420963; x=1725025763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUf12qyXBpIPIp7vkWsoH30nB/Xckz+vhe6qcm5h04w=;
 b=cztrQrO7sbumw8OB0ygJ9uSATVYNCsssvZHHPTbtClG9thaOyvxhE5f+Piy39lyFAP
 +INW/1WerJKPOpSdq3H/s8Im07rlyne+KEDkKp90+77OaT7AZdULI0jinsGtk9G1krUD
 0L8jhJgNVXmVFVfIaU9V6y1+b+isZZXJPo8vnOUvNb/fVnhjdf81jTQuwo2gvlVkRUiu
 pWRiYqNwu499CKK/n8KVbGc5bTd6JmnVFL+/iCoEEKSwxooH4pvfmzf4CoCn69DwLk0Y
 MLuc/s3V7pfRhmSwV/fEHhvqFHHzrKs/W/8x6l+WtA4ZwFGmHyCrSg/3J0kB2zqRI+yo
 DwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420963; x=1725025763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUf12qyXBpIPIp7vkWsoH30nB/Xckz+vhe6qcm5h04w=;
 b=LgkXtqftBnSzkRtLv5JRIkBjSmcp47Blfqvo7xqrtgqXo2M4ZiT0EOGPlGw6vxYNXm
 m/c1fxt4EnYenvR250SG+uL93uGU420VX8nUQLTIfaqxjm7QIHRiQiJ2J7Dc/+cMLr8G
 2N3uh0Ri9WZ3X58uZy3ZJhboONHa0b5MdgL1oW1o4i7GzMmoYHyEGNjPzWN4xII5U9PU
 wQgyUmVf3bRw9QA4YU5Y5CpOEidObkVg3qh0RoAk9NXxW+D7OG9FzGRjdBD/Z8e2TbqA
 ArITJoZsvYXZCvNA0AK2uUkKRyD7+O2OC8f/KJlgykrkqtQ+bBUxotgZigGg/zYpNdOh
 6rDw==
X-Gm-Message-State: AOJu0YxUSpboGPMQ9EsBUEy0S+YYspeh5+y/89QAQ4KCVJW3hPjOQAd+
 20FoCe9Yj1LuHHCy/2fajC4PbJZjpQeFBFBFf0f9AquokuEhLqW0DM5amXgjsjoZsPSADA66Mg4
 tyDtiFi/A
X-Google-Smtp-Source: AGHT+IGpQlemFmlVR8PVyOKrBi9rHP7GTAv6zOvhE+0/mdzvla2dI/BQwqktJiTYeG7pFbK3139YzQ==
X-Received: by 2002:a5d:58ea:0:b0:371:8ed7:49e9 with SMTP id
 ffacd0b85a97d-37311875227mr1457735f8f.26.1724420962651; 
 Fri, 23 Aug 2024 06:49:22 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:22 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v9 12/37] test/py: test_efi_loader: add missing dependency on
 cmd_tftpboot
Date: Fri, 23 Aug 2024 15:48:16 +0200
Message-Id: <a224049fc0ef5827a7a58e378b0b3170e15d02f4.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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
---
 test/py/tests/test_efi_loader.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049b..7c1e0ffa594 100644
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

