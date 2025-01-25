Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0B4C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 21:32:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9759D80C7E;
	Sat, 25 Jan 2025 22:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LctHqy4X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 600D380C7E; Sat, 25 Jan 2025 22:32:30 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7D0807FE
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 22:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso90358539f.1
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737840746; x=1738445546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WaoetDe/PuZM47uvtaRFJz77eo20Y57+Z7jI9zqp+5Q=;
 b=LctHqy4XedrHzCI3F1bJwD2eKLrqOerEKkktsElAeSIPUJEItio+BohQSB823NsgL9
 JRexGPTLGCQWlk6syLmTeB2CcYtSIPivR4tPUT281EqxbSsuTxpN85oc4mkbhCHWEWyu
 QYuttKDNRuCJKlpOCvMSSAAmqhQTTgDY/lQ7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737840746; x=1738445546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WaoetDe/PuZM47uvtaRFJz77eo20Y57+Z7jI9zqp+5Q=;
 b=UAHdGSPFlfKytxbjW81YlQaZpPBoBUmIFEAxvIwcTqiMCpvYOUsttZMfjJXjm4sBtq
 9WFkq3WaUuQLMtpxhGiW1PrYI3X6BMODqE0+74Jnko4XuaAGLHcKSOOOBp3vXbIXKG16
 M1CjBgrdO9v/hH64msbbF6wetNWL/9ioUwgSq29jWJgR4kM3thokBUqYjqg7ovKh1K+a
 qwxTIfsKi8rzpBe7h2Fv+PanCe5uCXgNUnfuwIji+EkL2K1h6Bf7k1kyXOOGRY/6skMS
 Kr+6NOLmr8SkENuCaMEkS82pwa6j60pvc6eNcs9Ho/uvxp4xvVqFMnuNL6Qsch+aWxsl
 m1eA==
X-Gm-Message-State: AOJu0YyAC/lrY8XbD3wBUy5BvHdKwGma495Vo6mcBg9IHY0gSKWokYkF
 +83j7X4QAkdN7i+RDEYlbnwxKU7BOSi5DYur9yReKYCBKbPzizxZrrQaU5ELClsgU64oq2Oh9KI
 =
X-Gm-Gg: ASbGnctswAypgUUYjb5OTmQSYW+jlacJQxbLWsnaHnCR/kcd8C6FwaeoPTycULu6oZW
 P4+T7n0GQR0ApZ8aTZt9pXLYPlaSdDxd96x1uDNXmB3GIbghiBh0rCmyUsAccpvlVoHTvU54vdx
 MKQkIzXFOekKgheoyPdHCkj1XMp9SWW5OsIO6cHORApVMRNjb5kS2FqcYBsMqADHucouFhSOd+H
 tH7K/UvQfTxLQYCetsUuKCtZPyUh1hrOrCh9jeIL9YepDC3eO8Kp9hsW6GChO14wI2B3J9snsQN
 /YQVXuW4UxsRz4gKWhkrc0gWQMGHBNSyab6OUssbUA==
X-Google-Smtp-Source: AGHT+IGs02mTSM53c7cG72G8LTP9GeTo5c5eMU+DnX0l3tal0TgmxN6ThK/X25lx3GbAFycPlGezZQ==
X-Received: by 2002:a05:6602:7216:b0:841:9516:4e2e with SMTP id
 ca18e2360f4ac-851b6287ceemr2836056539f.11.1737840745763; 
 Sat, 25 Jan 2025 13:32:25 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521e01754dsm164103539f.32.2025.01.25.13.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jan 2025 13:32:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Love Kumar <love.kumar@amd.com>
Subject: [PATCH 4/4] test: Make net tests depend on CONFIG_CMD_NET
Date: Sat, 25 Jan 2025 14:31:39 -0700
Message-ID: <20250125213150.1608395-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125213150.1608395-1-sjg@chromium.org>
References: <20250125213150.1608395-1-sjg@chromium.org>
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

This fails on samus_tpl as there is no 'net' command.

   => net list
   Unknown command 'net' - try 'help' !

Fix it by adding a condition for the test.

Add a blank line to keep pylint happy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
See here:

http://sjg.u-boot.org/u-boot/u-boot/-/jobs/19821

 test/py/tests/test_net.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index bdb7e6f372d..30c6e41334c 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -91,6 +91,8 @@ env__router_on_net = True
 net_set_up = False
 net6_set_up = False
 
+
+@pytest.mark.buildconfigspec('cmd_net')
 def test_net_pre_commands(ubpy):
     """Execute any commands required to enable network hardware.
 
-- 
2.43.0

