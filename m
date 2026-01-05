Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5731C79FB7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B69183CBD;
	Mon,  5 Jan 2026 19:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vGqv3uWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB9883935; Mon,  5 Jan 2026 17:49:54 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0740783D71
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4537407477aso91269b6e.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631790; x=1768236590;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AD/XPm9+2BV4EB7uoLRosPN7LckPFN+lbUl7hGzuIAA=;
 b=vGqv3uWgfuwBAivGg3u3D1LbilQGXg/oZfwU2gqJPDw4xYBaCoPrImwegjPuDn8SP2
 6nYsPGJ02mKC46MZjnrFGW1KnRuN4mZKd7fSFR4TnfNo5X9BmmDD+VSp/jail45VLdBl
 8iJaLNGwNP1WHc5H1UbKx14iHIFdT7+kkwo65tUKDuia6o5+x+cEi92o6UQjpL16Q0XD
 zgIZeeAGVN54+w/USt4s3hzdalQ09cfsHe4hvOhoWYUtgdg0aQFVFMRqWJMRyIio1+2r
 wd0abnYMSyV/oYHURaO5SusYfznjgCIXioYzJe7hEuiXidh9UUUjSpK6GSlVUFZ5Cv63
 4VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631790; x=1768236590;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AD/XPm9+2BV4EB7uoLRosPN7LckPFN+lbUl7hGzuIAA=;
 b=bdOjTPT4XWHzzV0JiDmvw5FLF9YLhZm8ph821xQYzvN6QwsURENt0RvmuepvQuiIPf
 Flqb1XU2kxj/mRjLFRt2R7UDYYIapxjJgCIFNasG2ybFA0FRkoafv/2/EBNx3e3ZlDCz
 YOZFb9lKWUQA/G85o/nB+dKATDMFfqy3AvBvMi0V4VID/8N3rl5/6V1WD4U6wpkLA+F0
 xi6C2fGCiRyja5RUFMEqmTyXO2lMocagAGaRvEp2JbsjrXRsqT6c/uEO8UwXYogtVMKE
 CgQYdfCPwtfk7OJiu0bR6qijzr/HyGsURzWymS4klTn4S7qnja1akklMM5suq4/Xoq0/
 gNNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJfE1UqDoYw1REiXbpLF3dQn423Vjvh6Nq8g2iwNt19xzEMF+jIJRN4bHsioVq309rC974P3w=@lists.denx.de
X-Gm-Message-State: AOJu0YzuGw8CTOu1L3T7GBxvDffkmssqYXzSO3e8PBFTBgqLs9QiBTPQ
 c+kRdWQRUqwjQ8qyKkXkjwt2pNC9ItHxIMF8UzDtBHGmbcGhI5T3ZLK/1u7lUchVOs8=
X-Gm-Gg: AY/fxX6EWFqiacsE/GoGob3WNzo8Jmk4naKVios1pA6JoLOyE5s7nKHqG+iRZHAoIvS
 gE/m8nrghP/FGDoU8AqF8Z6Miys4bC5jHl3pBS3YadEJhple/HhJFSQ9tRffWRR6W0SCxb58Uj/
 K1BezjxVo39kpjE5IoOOeg33L8kYyrhJ9E5EnekEhlse+2oKL714RCwwkiYKhynATFTkNky91rP
 oOeQtcBjoJdE1Ni4zSoaZgXYBocZaUpe6yKHk6tONrpmU96TqpSYVldvxtLq+Wbg3zHU5ZFaK2l
 0zxoRIc3QDWx0HCwh9Mu+HsD951tiqNLBgEYJ5CRt8FZihnMcbJZOU9ZnQLYW7Uj+7Z5aEid01v
 S5PUTHIKOglHrDnOUHaQ/tPxEv7NvfsOp4bjs4bpAUKxVm6YSFHVXxMUwpMHJNCrj/9V3foM2Fb
 olLxww03gc53tCBA==
X-Google-Smtp-Source: AGHT+IG9QWv8QfYC+EMTm4HKCdp8BMeeIszhlh6X+QNRS1wWSQNGoqVkCvI9SoVRf8jThsDMTkI+Ig==
X-Received: by 2002:a05:6808:1390:b0:450:89ee:923d with SMTP id
 5614622812f47-45a5b0fa9c7mr166328b6e.31.1767631789664; 
 Mon, 05 Jan 2026 08:49:49 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:df5e:737c:7b32:e5d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa0078968sm67524fac.2.2026.01.05.08.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:49:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Jan 2026 10:49:13 -0600
Subject: [PATCH v3 1/3] test.py: check ubconfig exists before using it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-a-few-test-py-improvements-v3-1-fea38243ca5b@baylibre.com>
References: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
In-Reply-To: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=OJ7g6DRMrG2zOYeaVHrNrn51GDtwcdSEN+3WfdXRmBI=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpW+uX+6AAHivSLVnjTNZUXvjbg2rf56aQEb+J+
 XQ519G3SAiJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaVvrlxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A0FYH/RcT1rA61OE1HRiZQeqrzjHRCEj1dmVRbGGMAHB
 z4IGnsZz4eFG0e4XN1t0yqFZva8OXJU9RR+sm3w2wP2RwHnXg14mpSblfp8Ui7iwaFlaqnKQ2hH
 OZoKqtlcR4VjbwQdcLy/YZNNjlhmfZqCtfs252AuaRvEZhi3qoCqzs6xVbir98r9ElPxTZwCtOA
 HFzOES517BtddNVP7uBbg4ylgEHQTmW9Rggj0ZaRbZ4x9jnVlYnCQFBb5W0fewOLLNao3JBNKWH
 S9AB/uI7wgSz4NCWhU3U5TlP/tNhuxwSyBn/XDtbIBuaIXEuzfNdlYsnjeTM2yyyYvxQvL4LwaX
 UfMU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 05 Jan 2026 19:19:09 +0100
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

Set ubconfig to None and add a check in the show_timings() function of
test/py/test.py to ensure that the global ubconfig variable was actually
initialized before access attributes.

If tests fail early, e.g. because --build failed, ubconfig may not have
been initialized yet and results in an exception in an atexit handler.
Adding this check avoids unnecessary noise in the output.

    Exception ignored in atexit callback: <function cleanup at 0x7de475ea6b60>
    Traceback (most recent call last):
    File "u-boot/test/py/conftest.py", line 669, in cleanup
        show_timings()
    File "u-boot/test/py/conftest.py", line 616, in show_timings
        if ubconfig.timing:
        ^^^^^^^^
    NameError: name 'ubconfig' is not defined

Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # sandbox
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes:
- Drop `is not None`
v2 changes:
- Set to None and check for not None instead of using 'in globals()'
---
 test/py/conftest.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 8ce680a92a0..37d9347a85f 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -28,9 +28,10 @@ import sys
 from spawn import BootFail, Timeout, Unexpected, handle_exception
 import time
 
-# Globals: The HTML log file, and the top-level fixture
+# Globals: The HTML log file, the top-level fixture and the config container
 log = None
 ubman_fix = None
+ubconfig = None
 
 TEST_PY_DIR = os.path.dirname(os.path.abspath(__file__))
 
@@ -613,7 +614,7 @@ def show_timings():
         if too_long:
             show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
         log.info(buf.getvalue())
-    if ubconfig.timing:
+    if ubconfig and ubconfig.timing:
         print(buf.getvalue(), end='')
 
 

-- 
2.43.0

