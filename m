Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9901FE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 23:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8438036D;
	Sat,  4 Jan 2025 00:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sXQBM/lP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31AD780079; Sat,  4 Jan 2025 00:21:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0993680295
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 00:21:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 763CD3F1CC
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 23:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1735946489;
 bh=gQI25kcFvNCTE7vEAT3vHZmHh3IkjR8epRagzTCtf9Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sXQBM/lPsouwq88pv60mL3OkDgfhmIDYQNqcofRwXfrynMJNM4gLnA5Zj/QFCW5xo
 qLfPJ5qMSHK1MqtNWZNnZCbmM5sPf+nNEp3f7ar4tzUaQ5bS7pJRrLaIED38pmiL6z
 yQZgNe3ndo7QDNw1i5CrmpgOLJj5izdzBB96DkwsSnnZXTV5BxtT5HVaPTvm/YnvH8
 GNjqNxUstfrQwhhr1UG7wuUX/+ef7QVf1/JyyZk3iUr7JT4H5iKvJI3mxMyS01smm+
 LyfH7+XJ7jEeiBw+QxUsC9GyqKssGUdQ7rFdrRlfHWnax3RYWQpkeWRdAzOXr83v2S
 U4kmvVN+6Pkbg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so98389765e9.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 15:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735946489; x=1736551289;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gQI25kcFvNCTE7vEAT3vHZmHh3IkjR8epRagzTCtf9Q=;
 b=e+z4MQGkTnJdApznXgWPR08m0VkvFO404ur5fLCtsefmjJAii1A/a9pjcwMAyHroGn
 utD2tF0qpuqfM/QRttrU4gdGwMOxJuxr+PnzSFqqNvnPb1GOAfoyFBxhmMvMPdvo8GWK
 3XOHPX0LctLRgi3XCGKClQTLnmssSZSoF+ufCUsBd9nJyuSgeBMSNGjMlWg5kQJ2wNio
 ZFFYw1/GkVOyWwmvTRPz4dsGA/Lcm9f0nMgagOhyFIKcJZLd6sdHIKeFWXGN6D8eVJSC
 0mpnVwZlU4atCVGrlcPzNTQAwE6Rq6Ug8ua78SRryXAxG+v3msP9WH/UsRK5tc/vpP+T
 5ksA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJHpClYqE0l2ZclAXUpmg3hfkMM+RkJfh72bHG4CFY9ye+xKvG5vTLHjkEzT5mu1fiYhAWj4E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+BvZBaJyswl6TWF1m3IIY//g6CdF2eZQqOcOCHD/3kaEgC2WC
 ng6yY2vFNXVctTXFbVHUNfi4FDt0R3VeEMtGYbiYLBLw089v5SjVuL+lzy3J0W7CJiXxI/4sEm7
 UXJ+U8tPE8zgZk2G/URU3++28BTfCcKccM+6dggLQmgfCQ4U72MriFIF6WAyn3/NbcvU=
X-Gm-Gg: ASbGncvnhg3BnCayHxskOKUbqlh70brhU18BLi/jE5VMVAYxZqYjcHlfHCJsJ1NMcJh
 bJfGdozprdmS78plpZjU9YxYHIUrhyStxGPgpmYeo54loIoN+GtP4esUeVWW+FXburz0iQfQV9S
 DzRftK3NMgHHo860zRXhRGzqt9EwQbCxvvdmN4tl1inynPq/2cCtgJXLZBjw6hQa8hS1K8/oxdR
 cX+PySdLLGrAMc6l1EWKgTSshbeRjuukaJqXXckuCqipYgl/XUrf6l93MIj9uygpFJDWcW/G7lO
 5bt4JA==
X-Received: by 2002:a05:600c:1c95:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-4366835c1b0mr470858115e9.3.1735946489055; 
 Fri, 03 Jan 2025 15:21:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkyZ/PyPNV7vG0zLdg/CCZe3HPgYKFL1epXPj1g0AE/chb7tF/XoLKncQtC5OfERtdFcSi0A==
X-Received: by 2002:a05:600c:1c95:b0:434:a1d3:a321 with SMTP id
 5b1f17b1804b1-4366835c1b0mr470858015e9.3.1735946488688; 
 Fri, 03 Jan 2025 15:21:28 -0800 (PST)
Received: from workstation5.. ([2a02:3035:6e0:45ea:405b:a98b:b831:787a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm536283125e9.28.2025.01.03.15.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 15:21:27 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/3] net: use strnstr() for lwip_strnstr()
Date: Sat,  4 Jan 2025 00:21:15 +0100
Message-ID: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
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

Using strstr() instead of strnstr() creates a security concern.

* Implement missing library function strnstr() and add unit tests.
* Use it for lwIP.

Heinrich Schuchardt (3):
  lib: implement strnstr()
  test: unit tests for strstr() and strnstr()
  net: use strnstr() for lwip_strnstr()

 include/linux/string.h    |  3 +++
 lib/lwip/u-boot/arch/cc.h |  2 +-
 lib/string.c              | 49 +++++++++++++++++++++++++++------------
 test/lib/string.c         | 40 ++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 16 deletions(-)

-- 
2.47.1

