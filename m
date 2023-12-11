Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BB2C10DC3
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 18:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF5B8777D;
	Mon, 11 Dec 2023 19:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IT84Zr/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE9083CF3; Mon, 11 Dec 2023 19:08:23 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507838776E
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 19:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 520D43F1C6
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702318100;
 bh=IokHJ3+tMxUJ9uEPzBc9zN9xlw1/92Gis4zNvMniboA=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=IT84Zr/buYcZ0FuPL725J7F/LG1vh77LZrfNAvEAXEhA6nwcJI7KgkJovA04UMq5U
 JHyztwmZpT7G/ensueWdWlDwzQkjqBy8AE7ImoxLHBJeD92/H/gMnuUdUwEldtWbKx
 DVx69TT92Tz3g8NWnqFe6PvEXUU8Kc1tRYpekgF9IbGA9D0m8NZi5KliV0vV0a5b2e
 7lHL19anzrRoA7A2vJYQqZ5JnXgCJHScpK9xckmQmn7F13ZcYF96XUfkcdHBAsILtR
 aP8IdVFjU/eksQols3xs5pvjW9zAKY45087dXMAB46pyLhKDr5czhJdnwbd9PmLWI/
 4AYXuDkm4r59w==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c2a43b0f3so31728645e9.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 10:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318100; x=1702922900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IokHJ3+tMxUJ9uEPzBc9zN9xlw1/92Gis4zNvMniboA=;
 b=mmWImUzr30lkmzAm0oiMscjg8hPnsPXQ7xv/WCR/i6wTyZKIN7hV4Hfi/GJcTdZnz9
 rMeiqQZExZe6QNpu+IHkyb3ltkOev7u9uNJCHk7V2LBM6AolHKSxWxe4bFQK5kPbDs4q
 1LrpixntY4dsJY3nXV61vbmRpY+Fz/Fj5ugdaJUWNtI9uWRfoeb9OoQRqOdOVoZXI+eD
 2jm7nrarcqlK3qE8RYcAVy2kBbIAolgyp6GphyXocfi8Y7MJrvXiYJ8klpomZQ+lY7im
 b6PcjFJvyobJzibyvSPgPHfQxFMQDl0hjMBo29tsZNzMk0WSYBuMajKvOlBxMgnrJwL0
 3XrA==
X-Gm-Message-State: AOJu0YzMbLBYOJIDs+EVy5CVjCVngWnYAerybkOocZlc7XhiL4zETUVt
 gKhsmMDUXRlVXfsExT8KQdHcRH7UcvcUHVBU0jjHV47IY1nDkJCsxhbx6xFIyVIbq1VNOn/E35p
 48JFEQ1rxWbxmsNOjtuI4zzf5dYt/elQ=
X-Received: by 2002:a05:600c:3556:b0:40b:5e1a:db8e with SMTP id
 i22-20020a05600c355600b0040b5e1adb8emr1772301wmq.47.1702318100016; 
 Mon, 11 Dec 2023 10:08:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnXeJEPFd5DEPMY6abagRBe4G2M4+w4WbGpk5soQS10K7dyqHex6s3NYGbrwXVxTEBF3/NnA==
X-Received: by 2002:a05:600c:3556:b0:40b:5e1a:db8e with SMTP id
 i22-20020a05600c355600b0040b5e1adb8emr1772288wmq.47.1702318099618; 
 Mon, 11 Dec 2023 10:08:19 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b0040c31bb66dcsm13461321wmq.20.2023.12.11.10.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 10:08:19 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] test: Using variable 'old_dtb' before assignment
Date: Mon, 11 Dec 2023 19:07:31 +0100
Message-Id: <20231211180733.86629-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Avoid errors reported by 'make pylint_err.

v2:
	mention pylint in commit messages

Heinrich Schuchardt (2):
  test: fit: Using variable 'old_dtb' before assignment
  test: vboot: Using variable 'old_dtb' before assignment

 test/py/tests/test_fit.py   | 6 +++---
 test/py/tests/test_vboot.py | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.40.1

