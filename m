Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F54E7717F
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C86D80217;
	Wed, 11 Dec 2024 03:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QPYIdDbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BA280224; Wed, 11 Dec 2024 03:25:55 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DAA801FE
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:25:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e0d4f2874so308135a34.2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883951; x=1734488751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wD//6qUD13E33s5IgwrlujRBUb7JOa3FlAV6BL5PnSE=;
 b=QPYIdDbYPx5UILLi50A9aNDLxzsNwHouQkVA9sAP3GpyiJI5haTBSdTqpRhuKXnrVl
 vDQniNGCprXBN8ug6MEpvDKSWtQBSjvWHTqQ6GHmNh1emNfx8192mvWsVDCe3hKXvtm+
 S/p/ckowd2TD7dzhS93kV8ChCM03P95opd+I47dCL3W3Z6/cVgiDazzv/CrFzuGhKg4b
 RXrSHNen90dE9l0zerQWl5WlZjSVkeeBt7pCz153JUcjfAe6KUrZvLTgXJY7vKPEX0iG
 tp5qAJ0Y7R/3u9cUiJ4/2B7gn8LXZn1zk8WiK1NC8Tg5Zsty7vGe5C2VIqmxz9T8I0yN
 XbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883951; x=1734488751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wD//6qUD13E33s5IgwrlujRBUb7JOa3FlAV6BL5PnSE=;
 b=FygWh8qhsdga2REj3qayJRXXrSBBgvXKJana3kt82g1TAHxSGz6p98gJuBNm6xX1Pk
 1V0Ow/WlnZWc4Vb1nInDrKnNmroY/Vns52VZG9lI1Fy+NKHk8Fbd+d4uBDNtTvmNaYdP
 DYrikLju8xyNM4A2snWKPVvsBjsiOpOLkXFHUGSrq/h3ye08lW1JuJU0Hhdpqxfm75mI
 ht5dFVbLU5rMbUGqQtH59WXx+YU6LlOz0FkIcpmeQnzYuA2gU3CQ+Bnno4uVcXhCSTpa
 Pwn6NF/+vOAewZMexsBWyaNYMkcNHlRIp3fZlwjuvnPTQeV0Ouw66KuFoSDy2Ju4REHt
 gTUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVevSSdSbKv9S5vPtVypwiBaQ8eRF1VcX6HaztQM4SR+n/HbdxyY0ea5eG5kdvFFN+ZWbiYub0=@lists.denx.de
X-Gm-Message-State: AOJu0YwA/2cU0wZdlEKjnB7NkxKYGYvPOQGrngPaXTe8H1rZYh0XR9Y3
 oRqkaSLhLqJy5nacje+Pe8GVY9Bnid4QQ6rwvtczkx7oNO+dSsmzw+HKjE/hkaw=
X-Gm-Gg: ASbGncs72Vdb/HCbkVQo+tzEEw67iPYJez7SR82cXluhuIIK6+Yyz7c7Xe76krdSLwx
 rv9t3LKXq6oxoorLUPAQoQ63pKgBR4x5WSmHe+uGduH4cfF46ev23sLZ5HvZWzGCDPIYYn5b0va
 fYVb/n6Ufw6vuFmMcIYL1q5/XdnU6HhUAZ5fI7OYML5xg98XKN7VSqfqrnO7wuDJ3PhhjwUNEJ2
 javb/yAvC0Bir8GEtOPdlashtATx9KsJoW7BguxVyGVj027hmwvPwoHdSs=
X-Google-Smtp-Source: AGHT+IEVorD4aoZSdnoYwpBqXYgBZIaG/3B67rbvN5MY+Qd+++3b29hX231Pd2nj4U5rTkrz8h8OYw==
X-Received: by 2002:a05:6830:2a9e:b0:71d:e0b8:5f0f with SMTP id
 46e09a7af769-71e19b58040mr551076a34.29.1733883951601; 
 Tue, 10 Dec 2024 18:25:51 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71df6987f26sm1403158a34.68.2024.12.10.18.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:25:51 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 0/4] lmb: Improve style
Date: Tue, 10 Dec 2024 20:25:46 -0600
Message-Id: <20241211022550.2995-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

This series is intended to be picked up for -next.

Cleanup the LMB code a bit, after fixing the false positive error
messages. No functional change. This series depends on [1] (which is
"lmb: Fix reserving the same region multiple times").

Changes in v2:
  - The original series was split by actual functional change patches
    [1] and cleanup patches (this series)
  - Collected review tags

[1] https://lists.denx.de/pipermail/u-boot/2024-December/574606.html

Sam Protsenko (4):
  lmb: Fix flags data type in lmb_add_region_flags()
  lmb: Make const flag_str[] in lmb_print_region_flags() more const
  lmb: Improve coding style
  lmb: Improve kernel-doc comments

 include/lmb.h | 125 ++++++++++++++++++++++++++++++--------------------
 lib/lmb.c     |  87 ++++++++---------------------------
 2 files changed, 94 insertions(+), 118 deletions(-)

-- 
2.39.5

