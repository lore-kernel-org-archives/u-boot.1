Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF770C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 21:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6343B88D2F;
	Mon, 19 Aug 2024 23:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HV6uURce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB2088C19; Mon, 19 Aug 2024 23:07:25 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8984088D28
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-27010ae9815so2862747fac.2
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724101642; x=1724706442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cWBIZ5DcxQwkW6srlBX6ICczr8sT3gnfbQB8yZKDcVo=;
 b=HV6uURceW3GxWB5FEfQEPuuAB+MG+pnBXVB6EAqcTVJsN88z4sGK/eUfzqVw/htGkQ
 IeWP/aYN+/VzKyx48MO6K6Q2VWq4sHpbHJA1BtviLCqbPwp8PaCmZGheIHfUiBlJENKY
 l2j5qe9IvWDRs73JSqgtgChaPhW+41+4HueUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724101642; x=1724706442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWBIZ5DcxQwkW6srlBX6ICczr8sT3gnfbQB8yZKDcVo=;
 b=dZth6nvSVXevWx5Ce47V9k/OeJAcLkkNWCF4j94IxVASY3dclEM6RjyrEkTVNOm6FR
 ZXo9FQgnRarhjM0t2LI8k+rWxwiQ6v7ZnkKyGWOnqC6RYj7v5HA2Ze0UhG7XhV2gvwS2
 Ymf/ro94KutEoSsaYJjRsUBs/0OHGiEVKhZQCU0k2/Owq9nOVIfwjjGZ7KpSqeQVlywV
 /Q8tuxYbr5GJL85QqIcmNWFLOrTnnthNObTBlSHLhB4tZvCQ5pCaUXTa2tw8hq9xj66V
 M5v+UTyP4nUI4kRqqJqtiEu1S1q+Uy7hazFhpy9wB7qEGuG/D6i+nQfBFElHxou/a3TR
 +6pg==
X-Gm-Message-State: AOJu0Yyz/QSg9+K5ZCnsUQBfUIwcPDq/06uhKcb2/iRGVmZ9ZI9QSyaU
 GiJBI8Sz5s/rjBMcBM09+4M5KwMWbvvxwtJusbmXR/UF7DHdM7s8Rt+qxoxVzbmCgVpyOXAAYrj
 m
X-Google-Smtp-Source: AGHT+IH35SALhXLUU7xRLdZOA4c9emaKa+YRyFmUnfUhmCzyzdU6YdFdVKB9Uoiwu+DorqadsAtmDQ==
X-Received: by 2002:a05:6870:3913:b0:254:994b:5e6b with SMTP id
 586e51a60fabf-2701c588fd0mr13796515fac.44.1724101642310; 
 Mon, 19 Aug 2024 14:07:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-236.totalplay.net. [189.203.97.236])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca662064dsm2431341a34.64.2024.08.19.14.07.21
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 14:07:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] Dockerfile: Update to namespace for some labels
Date: Mon, 19 Aug 2024 15:07:19 -0600
Message-Id: <20240819210719.71747-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819210719.71747-1-trini@konsulko.com>
References: <20240819210719.71747-1-trini@konsulko.com>
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

Using "MAINTAINER" and "Description" have been replaced with
org.opencontainers.image namespace variables.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 tools/docker/Dockerfile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index cda87354566d..f0e36994cc23 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -3,8 +3,8 @@
 # to build U-Boot and run our test suites.
 
 FROM ubuntu:jammy-20240227
-MAINTAINER Tom Rini <trini@konsulko.com>
-LABEL Description=" This image is for building U-Boot inside a container"
+LABEL org.opencontainers.image.authors="Tom Rini <trini@konsulko.com>"
+LABEL org.opencontainers.image.description=" This image is for building U-Boot inside a container"
 
 # Make sure apt is happy
 ENV DEBIAN_FRONTEND=noninteractive
-- 
2.34.1

