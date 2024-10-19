Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C9CD3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49796892CF;
	Sat, 19 Oct 2024 17:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGADPG/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D20C88FB5; Sat, 19 Oct 2024 17:22:42 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD0789072
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a3b0247d67so11675365ab.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351358; x=1729956158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jDU+vWyqDGWjFEyZwDSX/AzTNM5IiSeRGqVNsA3+LXk=;
 b=VGADPG/sCD87VAuoChwWmJSlnsBedCGX17MlmIljps/JmMMn70RvvSPnbe0G+w+Ci0
 PHYk8UDshlGMVZ+WAgm30m2Y1y9YwwG3KRV7kE5znbjYtzoel5jKjB4JQ6I9OS29upN7
 9625c/BYPIIwpZFiboloBbKiQ0axpbAJBhYMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351358; x=1729956158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDU+vWyqDGWjFEyZwDSX/AzTNM5IiSeRGqVNsA3+LXk=;
 b=iBOJE7BhK8EphyOOdHknpJoklec9CoCH44AXPbpnOWeIrmkdUe1yC/LDQWQ6Zisl+4
 IFIGuTl8K9Sww5A3hW80sjv5auvU5jHA8Pr1/cc/SIixP7QGM9LDTxhHasUkbXVQKo25
 uWLhMUlZ+a92kfn0E3VID9gQYX0BFcBNIZ4567hh781HW+yYvvME3D8yrHHd5Ws8qjhv
 OCl4px3xq/+g+k3q+155SRVqSwislHFxM1m+2ZJ38yaBN1Yp6svc1OK2LXzyAtZM7+p8
 K6qeKek48hvqYeDSnfRkOiBEfW2GcdWLnor3YRtUMeNhHZFlYBsexXMqjDj3QHbpPXtg
 6QKw==
X-Gm-Message-State: AOJu0Yxj5eJoVz3O/22/FGKPMdaiB6rvX33LoLlbszmTcPYPBZi24gR4
 oQLS7V+wl1WvQHnMY4eXstUrZllU2IDxMjQiVAtDCkSeZ3uGBrdjxjSGEUwQR4heaXCS968fsGY
 =
X-Google-Smtp-Source: AGHT+IEkHZGXkhwqUpx7B7woFGP48zVBAVIT5miTrG4MooUYrqgkPy2dirEbx+DpQhKsuWdgLEIePg==
X-Received: by 2002:a05:6e02:190e:b0:39f:5e18:239d with SMTP id
 e9e14a558f8ab-3a3f4073c05mr61951805ab.15.1729351357659; 
 Sat, 19 Oct 2024 08:22:37 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:22:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 08/31] alist: Add maintainer
Date: Sat, 19 Oct 2024 09:21:48 -0600
Message-Id: <20241019152211.1014896-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Add myself as maintainer of alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to put myself as maintainer of alist

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 573403734b2..65e21ba9965 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -58,6 +58,13 @@ F:	cmd/acpi.c
 F:	include/acpi/
 F:	lib/acpi/
 
+ALIST:
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	include/alist.h
+F:	lib/alist.c
+F:	test/lib/alist.c
+
 ANDROID AB
 M:	Igor Opaniuk <igor.opaniuk@gmail.com>
 M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
-- 
2.34.1

