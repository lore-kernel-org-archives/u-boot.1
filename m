Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE7ED6DDE3
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABB389221;
	Fri, 15 Nov 2024 14:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jf+bGSVQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A67A88B6D; Fri, 15 Nov 2024 14:48:34 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F214B896C9
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a6bcbd23c9so6131775ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678510; x=1732283310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iNi2V+RVQWA5DgX5aBIc2csZ5EC5UdZ2f7TtHz/ncy0=;
 b=jf+bGSVQf/vtrTcGkmjrrtBCPXazwcbp/lF2OuLVsgNBK9+Xb82tRMq/i4hvWpGbLE
 qii+BUvhwJ3JllN2g/H0HMjbcJRnwplE/aSFNX0lvveZDt7hGi8owOP/5KksZlwdkgde
 6e6XFKNfe9P6Ktfmu/NKEZnBhUrhhYrH1vuPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678510; x=1732283310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iNi2V+RVQWA5DgX5aBIc2csZ5EC5UdZ2f7TtHz/ncy0=;
 b=hZKsdSd2pgUJU+ywKZBnI3B+IMRaBBI1iL7RaGEy9pt6ae8gd05EFZZ93vJKHkeeJa
 G349X/floEpC9JytzLpPU5GMfPnnuL+PmIbE0/JKU68jEBfv0HqlcpjMQdAXSInWH7nL
 L7nw4+h69fsHTYTTP3baz3xiMjri+nUrLWZ+5V0t3PgKMClQFK0jTtvvbSU+2lnGG9iG
 vgKyevQlQxMJi9R8Gl8ii5GpZ51I+yR0HyYcC4XvHoh7ZSkY0A2rJFosWLzD0bhsFrcu
 4tLO2K2gIUZTjeP4NRWerAsf++Qaun3mN9/KOD7QkOg5fpqw1sJOEAPFfe30Nqvb2lA9
 eW/A==
X-Gm-Message-State: AOJu0Yw87NWJ3wQYM2GWdn/H20xrIgUW5rVT38fQrFO3ohZwZYg8KMX6
 RCp5yXIkMtosla67Q9SBo4j09QS99vVFpRVzEUBn9ZSpi0sKpeX+QtaaCgW6XEOAtBLDXzAAI2c
 =
X-Google-Smtp-Source: AGHT+IEcs9McuYxwaij2YL6eei5hTZKTdgh+I+bN2FuZGHo+2VRZ0yUqwX6GgA5vVPlkoJ+BTtCf/A==
X-Received: by 2002:a05:6602:140f:b0:82d:16fa:52dd with SMTP id
 ca18e2360f4ac-83e6c0bee1cmr349558039f.7.1731678510215; 
 Fri, 15 Nov 2024 05:48:30 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 6/6] CI: Add platform variable
Date: Fri, 15 Nov 2024 06:48:07 -0700
Message-Id: <20241115134807.3068947-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115134807.3068947-1-sjg@chromium.org>
References: <20241115134807.3068947-1-sjg@chromium.org>
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

Add a list of possible platforms that can be used by gitlab runners.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v3)

Changes in v3:
- Drop patches which remove grub and tracing for arm64

 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0aeda53bc2d..e152060b046 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -3,6 +3,7 @@
 variables:
   DEFAULT_TAG: ""
   MIRROR_DOCKER: docker.io
+  PLATFORM: linux/amd64,linux/arm64
 
 default:
   tags:
-- 
2.34.1

