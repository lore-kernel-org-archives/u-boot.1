Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A48C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 15:41:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E808760D;
	Mon, 25 Dec 2023 16:41:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pMBhUNVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 777C38760D; Mon, 25 Dec 2023 16:41:48 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EC48753E
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 16:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ccabfd9762so22187471fa.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703518905; x=1704123705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bztCqZtuZeWJbD9MIA2Nj/8rhjf7X26SpwotbAnqAAE=;
 b=pMBhUNVH3qEYFHRkj2j8sySwmYka0aCizvI6U4pUOY1eRckTF0eb/1E2xqunPy4SJx
 1moUftl7MCff8M7eSVFDTmefB8osx8ywtKcnOTaNbOKbXmD/isL64/uMrRW0gC4EPsjA
 4KgR/04NQ/uQWVHB1I+lTlXfhmGzgZ2hPKxpMsE34bYq5ioxpLSscYUQkq0OeuLwCzC4
 HhKnmoNaOUl+lnwqQ5QhrxmRP0bXOAqhC/hk5vmodLwci/d6GCMKsS0GpDn3lHL42nTy
 CgHcJumyA28CcBEU5JFE0yRLNwc30dgHkDWM1Lf2rLEmu7wWYc1244KAMQMmBVY8xm3b
 GC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703518905; x=1704123705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bztCqZtuZeWJbD9MIA2Nj/8rhjf7X26SpwotbAnqAAE=;
 b=C6b+CGbPhavIE2YROHQOYWfO+oZj4EPxRQKFYenZrKM+YomKD/QFZjmchuPdLf9nvo
 VDu658lZxsGOlT72U9NOfaIR8loPfyK9sVZLAKYT41bTExUKSeq1fJZ9HlWrzW3wJUq5
 ZFwOtPsMm4b1G1O9Fy/U5Sl2MEgqXB3of66DVXZIGBGynJXKxaq5LOhhBjDPoC5MoZXD
 ehBuHnGB+TK0X5qEI2Ec108xybVgnaoYFp0p4pxhmiN03Fbj29bum8LQiRHCRGFax/Cb
 uK5NscMtTNGnlmHj0LuiytEl9WO1iMHxQEvJ0vpTa4w0bHA6umt+T2OP4eMSrT+mXt29
 WBVw==
X-Gm-Message-State: AOJu0Yxl586X2/jteiAlpreU2yu5eusGi55W2bdUYXljaxOuO2Z9RkSs
 3XYxCL0nzkeTecT+MK97ShWLh6IUWV4Bk2YnQdj86lcb3D8=
X-Google-Smtp-Source: AGHT+IHOqcRsn4ZxTBU3Xg0pG/S87bNB0MKzs+Z02jW8jt5edxbUeGePAlV6YBkToDPpJWPYbCGABQ==
X-Received: by 2002:a05:651c:613:b0:2cc:c6ae:9fa1 with SMTP id
 k19-20020a05651c061300b002ccc6ae9fa1mr887576lje.16.1703518905096; 
 Mon, 25 Dec 2023 07:41:45 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a2ebe91000000b002cca6eafc44sm1425644ljr.113.2023.12.25.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 07:41:44 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv2 1/9] test_net: print out net list
Date: Mon, 25 Dec 2023 21:39:21 +0600
Message-Id: <20231225153929.8284-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231225153929.8284-1-maxim.uvarov@linaro.org>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
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

Printing net list is useful in CI log files.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 test/py/tests/test_net.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a4..cd5b791a6a 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -96,6 +96,8 @@ def test_net_pre_commands(u_boot_console):
     if init_pci:
         u_boot_console.run_command('pci enum')
 
+    u_boot_console.run_command('net list')
+
 @pytest.mark.buildconfigspec('cmd_dhcp')
 def test_net_dhcp(u_boot_console):
     """Test the dhcp command.
-- 
2.30.2

