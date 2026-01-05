Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ACFC79FAF
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E63C83DE4;
	Mon,  5 Jan 2026 19:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qATlsS+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB3283D71; Mon,  5 Jan 2026 17:49:59 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F9B83DFF
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4510974a6bbso63789b6e.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631791; x=1768236591;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dTBvJZOh8No02li6xvYxZmev/YZC34c6NplQUEB+yI0=;
 b=qATlsS+XS6A0Vz0FdKqFRt8KUQz/e0fs+j5u9VDzkXVyiUfQ1JdnRlOJVoqo9ioeVd
 NH+cawZ+5j7WOeDvGjYTUBPG241jTejMu5kgS5xAP4O+Ci1es9IdNVFl2zB7mGdH2VJY
 hr9IiWq+GmkIHxDWzNQCCbFgHLurMLj7vtqK+gyDzrL469A/vqjJkRDB3zlspWL1MOnT
 qWHnXBHpM9dOZCaZd+URw4BJJ0PatVZIQqPeweZT3AXdlYHAQNrHNwaZFjEfnqIvqkyr
 rBNSXQK+cuCHovJ4pz9yLjm9Z8ZoYZ8DNjOw2dimSrWU2em/nGWd9gQP0obvG7u5isXH
 bNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631791; x=1768236591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dTBvJZOh8No02li6xvYxZmev/YZC34c6NplQUEB+yI0=;
 b=h4Dx7EZzTf+MzKKU9kOAnYYSzc1cKDCNXktaeoB3AtF//ajv58m07kSUN7sZ973vsg
 jKIGCQiQWNvyVsYeoTQcwT+gnwhb+Vc9EhoHi/Ey7A45A/BvoY4TOpqv+m7Vc5YC6NZk
 CTvD/h0XovpsdBfa+Z2z4NFwfmtmQF9EuQQpMyF2QeoOS9bBCwG4/xD4paUhLeJgj7cf
 TuDUDIqGGodSfOCxowfCGVGgLf02NkD4HnRwlyQVi8TnUUdH8E9PsKJAD7jWJQEU5oH4
 ifnwURexpcbNOdul4rD4fyHseciPC/TOooOUrcn2PkkdpGSnSZ7PywpxHE2fwFxUwUJc
 tr4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNQBbFYG8/vWTNDw2ZctVi2SDTqleRyk+3f6OBNy8myYwnDZSSslGCami1zZtvee6d4oj7ZIw=@lists.denx.de
X-Gm-Message-State: AOJu0YxHFtE+M0j3jHXlX55w5KxdAcy7qLoSeZsN56KZcqewUJWXQIUZ
 H/6H6j2CZEKnssAuB03eaO5ldbxLXs+bGeKAE2YQIcpXVNUs0vf18EwNNuZsaFuG8Vc=
X-Gm-Gg: AY/fxX5nK/D9PU4L4hlhO295GQVvd0gC0NBcSB4H6rNHSrzcHBXhB+OkadhpB0DHVkw
 JBQGhO6AUTw9dbDViiB7GW/jxJVC6Djq+XfHZUpQyDgX/DnLRDE6DVf1NnwMARXm4iY8ShU8dHo
 ZUIyVxy6You+k0ZgUOaW+SENo0PMYCbz0fHTFUDhJtmtz9qGjTiAqzrH688WOKM4wnDhiBQ1PJR
 tpqd5LjcjcLfh8bQYSovPF8QJla2kKeuDx9yQsl3hxw9qQ1lDEaRZmS40rYnGkM/uILlviGIALQ
 afazZXPAlIIWrzhrrukh+5LizE4J2petwPgI7aXUbWOlAPWBQmZpLYstJKQBDzlqWG8cYhR+QX4
 Edl8wgb5Qnt7DIK/z5WFUTAm0ZuK5zilTnqHK8tKh16zg7qbXqx949cLY6Td8ticluaQCqrZKtT
 t1rndD8EDuz9BsLA==
X-Google-Smtp-Source: AGHT+IFHCDF/mcQnwLsQCVAzXeUSv/WejWEyZGkHpEK2t1CnMXeYCqneISU19VwbwHvXIVHQpY4YNw==
X-Received: by 2002:a05:6808:2394:b0:44f:fc6d:1c39 with SMTP id
 5614622812f47-45a5b151e21mr162503b6e.57.1767631790638; 
 Mon, 05 Jan 2026 08:49:50 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:df5e:737c:7b32:e5d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa0078968sm67524fac.2.2026.01.05.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:49:50 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 Jan 2026 10:49:14 -0600
Subject: [PATCH v3 2/3] doc: pytest: mention additional requirements for venv
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-a-few-test-py-improvements-v3-2-fea38243ca5b@baylibre.com>
References: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
In-Reply-To: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Simon Glass <simon.glass@canonical.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=zuksSk0YDI/AOIoYx5xIycGEN2GxRVzFm2HCryNtcvU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpW+ueEuNZvErjqfGfS5pQ2cATaHf7O39H36K2T
 TtVaVa54S+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaVvrnhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AL/wH/3kNI6X1UQeSwEA1/EM/KGS65V75HdoNscM+4pj
 NoaSD0VdwAOjgTXUomoSIoEqSy/jk/0tOUsrfK5atU7Fb4S5ZlSvVpnY1HDocuCwFwYuxRNjHCK
 ibsLEFqPz7S1bDndRqW3iWY+Aj9vqF+Zc9h0Z7LIOWZxzl2zKksgZfU0/aM/qcpHzP7SVhtYrAh
 7ua32L8vaHJGwPxrIv0vSl032/AqsWOemjVZ81ZCJ8yxvFEuPBKIiWhkOpIUTcWMHd3M85DMSD6
 uufY7HeNjGFnj8FjN0adL8DuwQHoQ7cP6MsVwTGYYe/tflWpEIcxILwkttwz7aW01GdsAVIqvhR
 S+c8=
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

Add a paragraph explaining that in addition to the requirements.txt
for test/py/test.py itself, users may need to install additional python
packages depending on the U-Boot configuration being built.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org> # sandbox
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes: none
---
 doc/develop/pytest/usage.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index df3821da20d..f8b32c07edd 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -90,6 +90,10 @@ environment.  This can be done via the following commands:
     $ . ./venv/bin/activate
     $ pip install -r test/py/requirements.txt
 
+In order to use the ``--build`` option of ``test.py`` there may be additional
+python packages required depending on the configuration being built. These can
+be found with ``find . -name "*.requirements*.txt"``.
+
 Testing sandbox
 ---------------
 

-- 
2.43.0

