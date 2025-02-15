Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789E0C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC9E980C83;
	Sat, 15 Feb 2025 18:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZF3yNpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A770380EEB; Sat, 15 Feb 2025 18:55:59 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A100D80077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5450681b606so3012945e87.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739642157; x=1740246957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JsZBRqlP/WcKv56yvi1JYYSVYkDFgcx6kjwgqP9+KYU=;
 b=CZF3yNpduY2yjk7sByR1bFqqPeUgnxl7OrJORz1rTO2UXPaXel1oWU2W8ukqXp+qYC
 UWzDP0egkFmhsqp4TrnppntZ++87tdNmWLGCUmwa5tJ795fNKipbK9Jgsmh6aFf17vwg
 bSyyySIgvqL4K0pNpXmK0iGHrAOZUV7ifx5SfMcQ9OG+kqvNyjOoQjpa6zJ0ImwUA2n8
 XCp+9/xeCqClOg9PNxgwsfYuEs7YxdcUH7YniIxjb54ickPyVTHnUwWv9Z0yPdOFQo6E
 oy8OnDWGwaTSCDRuxWMiyG7Hu/B+SAhd9Wx9tKhYeNZjnnZawUvm3/yyE2NjiGKf0bGZ
 NIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739642157; x=1740246957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JsZBRqlP/WcKv56yvi1JYYSVYkDFgcx6kjwgqP9+KYU=;
 b=wjNDBPrceltxK48eC+nPxYuu3rB4PS4yw6FtuqhRSXf1veaFJ41gRsF/wF0CRWd7GQ
 cJiwgyunptwHmvCOKjrYsbgxUlKpZcg6UeZDQPXOQ8fiQ+kTtmwlVZK7n8JOePjOMXPA
 10a/UNdpmkap0Oe90RWC3MkBFP6JVQnKmfk3J60N2QPe5j8jcguEtpWxcuQwq3Ci7GJY
 reMLxpCj5MiWkbCEaURSYjOE1Nvw1xG8Rx0bB0uXiakiQ0NrpiWR4sEV2AutFPbYvz78
 2DwOH2zERGpKFCP/5B4Pwh29kQMItbxHJ8P0ZBoZoJy+yX5EPUxBsU1l1LaDRUgf4XNd
 gPDg==
X-Gm-Message-State: AOJu0YxNVjyYSzSuPhLAmmWkxpBgUdrs6eX43X+9IjnIfdstYZRZ0R+x
 iBsIRt51R0JyCevgbTXdWsrw1PGfH7IdTL3Otg37J1Eg6opoUWhy
X-Gm-Gg: ASbGncvuhpav2QremNx+2B09aDa+Kpvva5JbdZysK2KxouNwxOINnLLc3xHtMCDTm89
 Rcvv6XN8F8zw5vur+GfIH2GDakRJj9KQwATZLBzkvIOLLLG7TmPebMTtFSUVTRi6s775Pd+5ifI
 nD4hUVjt2wd5X5iUgUWkX1soHZh03Ep0ZGg42rabL0li4epAcZ59sIQZFfew4ox3+Yt5L129abI
 FNObjKNf6Dz/NZIlYRYBNQW+6HnCk/poZnPaEYvEW4jeqwnpu2FSTLcl18I6Dw56lVy31qKBknJ
 en445nQ=
X-Google-Smtp-Source: AGHT+IEH0/Et5MLaUi/UWQosAkKxEyYVBFBLSknrNES7aTKgJT+AaKtJWd49gizm27sdzOEaWX/eTQ==
X-Received: by 2002:a05:6512:108a:b0:545:2eca:863 with SMTP id
 2adb3069b0e04-5452fe6fac3mr1133262e87.42.1739642156587; 
 Sat, 15 Feb 2025 09:55:56 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-545315629c8sm231764e87.223.2025.02.15.09.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 09:55:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] core: ofnode: add of_graph parsing helpers
Date: Sat, 15 Feb 2025 19:55:33 +0200
Message-ID: <20250215175534.203539-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add a mostly complete list of ofnode analogs of of_graph
parsing helpers.

Svyatoslav Ryhel (1):
  core: ofnode: add of_graph parsing helpers

 drivers/core/Makefile       |   2 +-
 drivers/core/ofnode_graph.c | 217 ++++++++++++++++++++++++++++++++++++
 include/dm/ofnode_graph.h   |  90 +++++++++++++++
 3 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 drivers/core/ofnode_graph.c
 create mode 100644 include/dm/ofnode_graph.h

-- 
2.43.0

