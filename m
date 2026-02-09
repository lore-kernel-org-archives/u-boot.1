Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452AAE7E0D0
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814478388D;
	Mon,  9 Feb 2026 19:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HV1N3hv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1910883C67; Mon,  9 Feb 2026 19:17:14 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141A880325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-382fb2bb83dso29127711fa.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661031; x=1771265831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ewu4gZbpqRoMXQEIip1YU4vR4cnSN8S9zck95o52pRw=;
 b=HV1N3hv5aDIKd6vAgalbbfYzihSoxf5KJll4DMWuwLkdi6oIzEcMOFLCu69vq1oyVv
 ac/wQwz7YHXaY/RPNZwYm215bg0/jKwvPFAkYsjDGkskOuddxFtpWHmQpHANZXDNTndx
 pIRgZr7SLEFsyR/nKy8qOMPsQ32SVtfK0VqR++heUq6iw9ciQfoxbsD4LVJVKuHzUtC0
 4aGouBwspeUptAhyuNuDUMugfRXNu8r09PUxuxTg/tfiQe7/bL/+Nrn6B5w/ee3suaeh
 fLE2a5GnwQIE6fen9Tfqh7cbjZ988lYfd7GUKct+BzyLeVyXxuM9Upek0Ljh94H5LVub
 VpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661031; x=1771265831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ewu4gZbpqRoMXQEIip1YU4vR4cnSN8S9zck95o52pRw=;
 b=J51o5usPTnBTrhdzz9FpFM/o8ageOA+Eir6zn3j+BZXmtv2aYExXFoMHVhTqgcB+d4
 V/ELyWmokEuwTBEP0Tn8wyB/zPOMFd+O2ESD+mfj2EmVgqTqzJfhR7wWVupwuk7CAGtC
 wamy2lzxkvOyZNqlvwqHCJWigE8W1cBhZW2qI/c4C3NAdXiRCPrP6gC1woLVAt+XMmug
 G7qqSmMbyhaqfQ/ungyd7YlAmBgu5V82VzlS/dXzvL0D9xXIODRkiv50b7RL03MIo6nR
 oYMmOM81O5LwZZ2GP80+6Fi7hkNVtVUYK38j1KBWcLbmmZ8uMi0bQQDlmqbO3wadqrfE
 keAA==
X-Gm-Message-State: AOJu0YxU1SztqAGogXFIG4Hvw6oLYTDXtrZ6uJqjuTcEb4l5/mRAxpoC
 Xh1qFEmdV3XWyNoIacGqWqwr61btJfanPl5YJ2Sh/mEjsGbW30O3fzG4
X-Gm-Gg: AZuq6aIGluJicqC6erj6QF6G4GZrHkZSBS7vj0Ps6/jfkmAP9rsQHhxXu0ef3zlQ4JX
 ReKWs2GR6sRkN15XGuIZm5klyZAu+4SQ+9nF1pHGHWOHzRN2xC5OVBgm9ZE9EQCafUPfvpjOjWZ
 +jSE4m6OaizeRFjnBQ82FGygjmfS+/qlBy0NmajJQ0S85V4Og5y8ccYyz4Jk3buq6D4Z2DhgA1j
 NJMhGa3la0mzv1g5xxH9f6PRD9WVjYrx2oQOQGyyNTHWtlP2v4lnNuYpd9B0Dzp/eRC4IIROg2E
 SfjAYmpf0IeGJfvzy67N6GB+hmBU5tNNIGO19YiuuCck1DHM1UULZLgys1/SlAq6EwKxKhfk9HK
 fXyngY09ZhOt68DJ8+J71RhOFimGdv1nNF2posp8EGCn9N/Kk+6IIybjyWnRsZ+4JMwQqapdKuo
 K0
X-Received: by 2002:a2e:a543:0:b0:386:8e44:5d4d with SMTP id
 38308e7fff4ca-386b6b03afemr45820231fa.40.1770661031153; 
 Mon, 09 Feb 2026 10:17:11 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-386b624d4afsm27446681fa.17.2026.02.09.10.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:17:10 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] video: panel: align r61307 and ltl106hl02 with schema
Date: Mon,  9 Feb 2026 20:17:00 +0200
Message-ID: <20260209181702.33190-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Align r61307 and ltl106hl02 with recent DT schema additions.

Svyatoslav Ryhel (2):
  video: r61307: adjust property name
  video: ltl106hl02: adjust power supply name

 drivers/video/renesas-r61307.c     | 2 +-
 drivers/video/samsung-ltl106hl02.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.51.0

