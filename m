Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE5BC79FB7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 18:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5701839DD;
	Mon,  5 Jan 2026 19:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TZ6j9xRD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9531D83935; Mon,  5 Jan 2026 17:49:52 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E706583935
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4507605e19aso93322b6e.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631788; x=1768236588;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=16A18qsDZDKL5CtG+j74h0JvN5k5CXtAZppVCScBrKA=;
 b=TZ6j9xRDczX3W8krzgCQff08l2qb8RTkT2e/4J2EQtvkDklVB4uMMdtNO7dcCq+VIU
 nlJnPglHMekcx9XKKodb8N7k+fssw+i/dq/zHnhbIj95EoxzX70GpmmZCaSNbSyAAyYP
 doLWO1V+fIB7jP+/rIEJSSdHws1R08bTDxdv8NO/6MibFrZUP+PF5xV+l+fBQd4+S6DJ
 O2GjsyqpwZE7vW7zK3tSlQ5c/hpnMUMVdkZS4AbfR26bPG1hDg7kUy5S+iILxo3xUElo
 WLb0Lkq2wZYIhnTsyWX5yDQNJml5Ky4oPHtUGYAdWKMRGODZHgNYyGmn9rgh9p2otGb5
 F2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631788; x=1768236588;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16A18qsDZDKL5CtG+j74h0JvN5k5CXtAZppVCScBrKA=;
 b=UmU3RWJrszl+wXih0VBZIX+0NgJiOuzDqytInGapnUAFibPUnCbU1YTfVErg+CEiye
 2XqSgr+wjGVsPuh7sQGTeYwIm5+BjM76Dr/gB9EheL1nBgCBAKUg3ADptZRBK4fX87Br
 aiQFVD/VF32nmj2TldS6jEPotbOoGshZJ9l+uXGm6dG/PRRwEFJ5dFeBNCVNdo7Jg9CR
 bLjOipnsu5u6hEq9If4LIpEItBrKGzFJamK4CuJEg8lCTvQfeHoxZZvG0bfd2qznAZAc
 Sc+GLmXhXtqEZfE7JvX3wlpa5V/6nKd62Ttq65HvGkCEx/fDA/RxLAWi0nHMGSv7KyE8
 d7Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXIjcr1XmlSaCvjAg4ExmcYyx7T9bZF3qS+D3+sz4niTVXp+GGtZxt6ShAssvOpeucMgRoqWk=@lists.denx.de
X-Gm-Message-State: AOJu0YwI+y0G6+7V9sofde7MRKgq02AQNFxK6WZ1MDsbjJz+ewDZDZe2
 tXnKnnfvJl8lj341XjIGZUHoNeiqQyIodssCh6LfkMSL9MEgNUvbLdnsKAsz//EV54o=
X-Gm-Gg: AY/fxX4a+G2lFOBBJVWzRoITpC/WcwvEqNIaAi0FcVfge/2zxO4vIOoFYai7YnaP2XB
 Zb/O4vidFXCGsid2mLTnQxuu1iJ2w6B55ITIbUP0wqdeQkkBi/vj69m/5Q3gRXepcN1+HAt3blF
 CYONjplf61m5mqSpcJIDm7aZ5sOTJ+M9EOkN5i75PgjZrL3N4uTXABM8rHKYlujskk3e2PlClep
 D7IAreahzkoCJHF5uQhGwf0zwe5NcIL1UXWq0MTdwaX5ICOG7T/vICLOTd+QDD2Me1MKdId1p4g
 2990Ia8b59zHJkhmXXCcOxXbojCx6YLLcYyQbW418+YWzVokkqDMUd8lQUxjThGQJjcy0/majH6
 +S+iQk+SXcPUytOaBSp7Z9wSHuzXoyfpH6odv6UqBT2w6+GUR5oTu1N59lRilkFMbMDw6wQj6yW
 4RkvslVaRexwzN3w==
X-Google-Smtp-Source: AGHT+IGVwTjZKZZqXufLsQV0EMx4U0BTeOj51YuOF1zCYzOw5QgJGV8+Lffh/MzdiUNXa12WHOkSUA==
X-Received: by 2002:a05:6808:c1f1:b0:450:ac57:48a7 with SMTP id
 5614622812f47-45a5b14cb23mr162910b6e.59.1767631788650; 
 Mon, 05 Jan 2026 08:49:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:df5e:737c:7b32:e5d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa0078968sm67524fac.2.2026.01.05.08.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:49:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3 0/3] a few test.py improvements
Date: Mon, 05 Jan 2026 10:49:12 -0600
Message-Id: <20260105-a-few-test-py-improvements-v3-0-fea38243ca5b@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBCF4auYrh3TKRDFlfcwLjowlSZCSdtUC
 eHuFjYmLozL/y2+N4vA3nIQ590sPCcbrBtyFPudaDo93Blsm1soqSpEhaDB8BMihwjjBLYfvUv
 c8xADUI2kyTQFy0pkYPRs7GvDr7fcnQ3R+Wn7Sriuf7EJQQLphkosT4ZkeyE9PSx5PjSuF6uc1
 EdTePypqawxmhq5IFNV+KUty/IGXJKwphUBAAA=
X-Change-ID: 20251121-a-few-test-py-improvements-b91babfc3e05
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ETtWiZI9te9opsEEYCTjBfIWyZtfLEh5IqN+4RJxk40=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpW+uQwVkI/9EvaKIYh6aF++OrMRHijKL+VLa6O
 un0PB20WCKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaVvrkBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtDEH/i9qGzPS8DSDarCW1fB4Cxhc+yux6sgryFjrlab
 /3PwFSJ8H0Qzr2w0hyqYWoJhKVdpqjLMomPEFxWLJZdKAiZf6y0m8E9cKBI0iw/XZEPjxoFpCki
 mz9mvAh/qWUDgby+Vpk1exCBpQ72SYfMkajUhea4JH5WlxuPK3UnE1a5LIacRqTdlLJwkU3ddS/
 3Ir5IxmByuICEkRdTy2LHdaQ/EKdvWZv3FUDOHirzrZm/p1AYG01SWiRNsLjcguMvuWwvAx4Xkh
 biUMLIYvHRJcY8ut47udv+najI709FyZNPwTK0om2ulK/c8nVzhJCcR6/v8lDaQy1qX+jrITHV+
 oC38=
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

While trying to run the test suite for the first time, I encountered a
few minor issues. Here are a few patches to address them.

---
Changes in v3:
- Picked up review/test tags.
- Drop `is not None` in Python code.
- Link to v2: https://lore.kernel.org/r/20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com

Changes in v2:
- Dropped patch adding setuptools to test/py/requirements.txt
- New patch to add setuptools to scripts/dtc/pylibfdt/requirements.txt
  instead.
- Changed test.py patch to set ubconfig to None rather than checking for
  its existence in globals().
- Link to v1: https://lore.kernel.org/r/20251121-a-few-test-py-improvements-v1-0-bacb4148fb0d@baylibre.com

---
David Lechner (3):
      test.py: check ubconfig exists before using it
      doc: pytest: mention additional requirements for venv
      pylibfdt: add requirements.txt for setuptools

 doc/develop/pytest/usage.rst          | 4 ++++
 scripts/dtc/pylibfdt/requirements.txt | 1 +
 test/py/conftest.py                   | 5 +++--
 3 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 9579616d2348e206fc5f0a04cc3348e8e89d0a4c
change-id: 20251121-a-few-test-py-improvements-b91babfc3e05

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

