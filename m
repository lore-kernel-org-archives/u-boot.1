Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33656EE6B60
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 21:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4CF83A64;
	Fri,  6 Feb 2026 22:35:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tmtDU8dY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B919583AA7; Fri,  6 Feb 2026 22:31:31 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D7F83642
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 22:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-669f0b0290fso1431783eaf.1
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770413488; x=1771018288;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v5YoBULdfSkfBOruZYXQ0J9X8SscJSaBDFWGzOxJpJI=;
 b=tmtDU8dY+Yyncq6qgZEOvZm2/9j/xOWYPdO7/cyIhEsguwmEDFYLDmxjn3dXcc2WmL
 tWOD7JgUWHkpIEQY6a7Nlnz0E82Yxj/tLWs5ArSmdmHMLxwu7mnQNDVDIOq0oxpCaOzT
 J2V0UaFpEaIu2GvKeVlNhiUqrO6HeIQFOxSxpsQq0nwOipkHtWYlpMUCyuW86nB82Shu
 +fz6B9D/akKJlcf2WMtAGr9CssDXiFpCQ9xnVz5tEyZQcjCNi/iZAE4lQCMR/EzCSjK0
 +CeG98MWV2QEGDr2DnS63C/am2l/17dMQXW/f7bvOppOkSuB2pRefZiT4i1RWuPHI0fY
 dXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770413488; x=1771018288;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5YoBULdfSkfBOruZYXQ0J9X8SscJSaBDFWGzOxJpJI=;
 b=kN6VgBBOSw59U2gpJ323sb3WgPErZ5ciD7Tbd7v/FYD3xPaLbnOggjMA+Ot53YF6jr
 zcP6HCq5egKFFidsVlyZYFLXYOTrXIBNagUaGr5+nNnbzSGGsv6Y5dXzHrmmvtIPkLPe
 gOt8uCfTmL7OJ6S5tVKgfTNj60+XhLaKIDbEnYFw8KWKEQZSUgcnKZuj/WSjnIyKBLtA
 FcSMC8CMw5FmMHfTsK5zSguzPSDyxd2vA+3g0B/MiG7m9niwp74hmV8ICmXP9AhqDUd2
 5vZhLYdYjPdiCkfr1EP6z7V6hGDUESsFdIVQaMTa0FO0qFa+IPD1A9zJ9dRqhjUIL6dG
 QN9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURD93lyGVHrQND/GgAWBZ7FbFjNDxeXGSvEW4I2AqK9oYbWghwA7YxITzO9ldxfK7yPv2NgTk=@lists.denx.de
X-Gm-Message-State: AOJu0YwuZFzLbFyE8sT/xWk0Wz1UOQnOZSbazXvYlOFgDP1uRcl43G2w
 M5K3ynahPktFLGEAox/+XBWmjB4B3mgjdjlCMpnsQP/LtPAMdurZWUUcdQmjrcbZABMl/pwsIr/
 l4Nrr
X-Gm-Gg: AZuq6aIG+5nCrilisKGKib7RGEFaqFBTBl0XDKt7lvWfMZ+9TIHr+/bBfWblvXNjLUB
 H8Z/7EpktU8Ma+EVPuOIMmg4bTz4T4GacQW8fD/Z73q0p8jFG5kgn1liBgE6CpM9czVzryGXMmM
 ukoskSaut9XQV+gRmxM/1ZK5dL41T8IpYGSTLiXC/qYobO7b2/HwKrW9RZzhkKhIKr5cTF/TKC1
 Btw18oAEbJ2o38E8M/OLksjK1NIl7YJPLNb2cZKJtcoSp40o5JDCZpr524btYw0AZwsyaUxzZE/
 hFPZtZPNGAVwXvAKRsebzfZlLumRVnlvnphP7K1S2otYq73Aci/mWYpdqQHrUKyTYnMxT7QinRX
 OuTDDyc5Lo9Uys5wfH8blWDm9CLLNQTtlelwsIJaOo2saby1gb3QRVqtplPe5PCnddZkQTmpr53
 2W4m5rI0ExsiR0vAM=
X-Received: by 2002:a05:6820:16a:b0:66e:25f5:4b3e with SMTP id
 006d021491bc7-66e25f54d17mr606098eaf.32.1770413488272; 
 Fri, 06 Feb 2026 13:31:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7918:a69e:53a3:9e1c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99643fc8sm2452000fac.14.2026.02.06.13.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 13:31:26 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 06 Feb 2026 15:31:14 -0600
Subject: [PATCH] test/py: Fix spelling of source_dir in docstring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-test-py-source_dir-sp-v1-1-057435f85e45@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgO10A5eRUS0TTWLlkRFEe9uc
 XzD/w8oCZNCWz0gdLLythY0dQVhGdeZkGMxWGO9scbjTrpjvlG3QwINkQU140TBpTH54CYHpc1
 Cia//2/Xv+wEg0tB4ZwAAAA==
X-Change-ID: 20260206-test-py-source_dir-sp-bec5faf6c5b5
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=BxKOmQTQv/3xnFnmajSdSFYw0u8ATrNnocuCk7HdiIQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBphl2n5pCot5ZEi/S9RDWedoTi5/gV73dHcJVC0
 zurrZSwBfWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYZdpxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AqhIH/2+zkfSFFJcjuj/Xb0R48cpwUMuj70MBUy5EKbM
 B3yRkQz2qgxU6NTF1edmuPMq0UQfFnSzXsibS+hrdV4L3DmLV1Wlh/ga+3FHzJQRNDz/26XjRgO
 u9zxV+H4TWq1CQLK7m3ztOkwwiA7HYe2rlH2d/0hMOfsl9yF4f2JPNe7JMMRNlLaN5mB+lGQFWz
 JZJ2HKTQ9iuU/v/jzwfCQK13bdpH0Xn6yInJ6zqeXBWSumO+KE/NHH6/d30TudFWpo8fx99Alnv
 CtCdkjFTtr5uzmMn/IFAD6s/fAiY4uZ/mOzIbf+UMoGCimYpHhxfwtAXkcPONw99Rk7tFFhf9eb
 cIRY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 06 Feb 2026 22:35:07 +0100
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

Fix a typo in the docstring for run_build() where source_dir was
misspelled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 test/py/conftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 37d9347a85f..215aaa56534 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -102,7 +102,7 @@ def run_build(config, source_dir, build_dir, board_type, log):
 
     Args:
         config: The pytest configuration.
-        soruce_dir (str): Directory containing source code
+        source_dir (str): Directory containing source code
         build_dir (str): Directory to build in
         board_type (str): board_type parameter (e.g. 'sandbox')
         log (Logfile): Log file to use

---
base-commit: e5e75ea8c7b8e6d9ce1ca8ec7a25fa8b3f6029a9
change-id: 20260206-test-py-source_dir-sp-bec5faf6c5b5

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

