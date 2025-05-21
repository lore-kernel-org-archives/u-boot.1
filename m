Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F901C54E65
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 23:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8359582FBE;
	Thu, 22 May 2025 01:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BsjBuoTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B72382FB8; Thu, 22 May 2025 01:01:40 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1840D82E31
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 01:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6060167af73so4657510eaf.2
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747868497; x=1748473297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzjTRa+TRr1D+qIQAWmZ4aDtCQmTTS0C2B2R1EbujYo=;
 b=BsjBuoTPi5Lqpq04vB6RRFxLfCSi1b1QOgcYD4otNBsb+cSt5rVvten7qbxLPLvMd9
 SkeTPBVLQtjMT4TY6bhZ1zX1M1rJFP1yYAlXbs8obmdZxpbD1FAuHmKWaCNb2BUfaysF
 Yp1DnO9shJagm+X6C3lOU/BQtbjPaR13JCcxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747868497; x=1748473297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzjTRa+TRr1D+qIQAWmZ4aDtCQmTTS0C2B2R1EbujYo=;
 b=D/CYoh5b4kCmRg8EZbZtUBn20MHhRvItMfl6oIGWtdxnmiuw3e3T8yDdkMosyBqfi7
 576ZkD3NGz6k+7N8ySmiDcswjOclvEDa6dqj7ereu3Dg6ASlMAqvOmbpP7956mGzsmrC
 6K/2Y/9omWOXHbgEFNePAmF7wgnfhACKPyZMm8SaJb5O8jCaYGTATtgr+pcH0wOXkbDy
 NDApt3f11pvLbEwd7xETaR+SZplK0eQB8y65hGAYsBlTj/6JSysEtD/NVm7HFHkQOgwv
 bUyEpXAGCwdROX8jiprsFy3XqMid5x9hQjcZWdIedSq/j7OlOb6BoDHfgtBn2BCc79Qs
 1oNw==
X-Gm-Message-State: AOJu0YxvzgmtUvV53BlqV7i40EFghzkdg3rV4Qs2lOnuuD7qPOVVrVsW
 SEa57x58h9f0y9w2LQGXyg+YaXB5hpowy9Hit4HG0q6fGsefWt+ii9bcDFzrE47uYmRSEpPB6Mq
 8Awbgl0o=
X-Gm-Gg: ASbGncsls54MHOzvcbflUsmRNDEGlW7i2Xfmg+jZHBPkQZbje+7nmGBbG6JfeMqLHdf
 i+4Kee5OuC3+7rrfuFRia/dh4CmzmxhvvmFMXiqZIPPBUKuqbjLwIg4KmRnE7ZpXs/G6MgdnrtK
 I2KsAxBZ9uGHFKmnTfGtqovWRod4w8br+N0YHKCXR8a01hQtJqDn3r+DWXVvYCI53leFWImAgpd
 c1G7PVN5v3aFt6DC6RZDk5GTHj60vZtpA6/T8XKjZgR39aAtCsS/vXt7nmScD9HVQa+a39G6ZkM
 WBo//bO/YzbbA4HkM3lpnPoWxeX5k0AziDi4fxzPQXC1XsMbTiT652rhNVPhGtWeF3rhfqAlPRd
 +lmUHO36GdrsZr2c=
X-Google-Smtp-Source: AGHT+IGFA5mGkPZ6a9XCYbdgABdir05ywLnJU9Sf+6cUALLUA7UP9NYSnKAFxLvf3/HptIbVYLv1lw==
X-Received: by 2002:a05:6820:188e:b0:609:dd17:795 with SMTP id
 006d021491bc7-609f37bd3e6mr16073975eaf.6.1747868496831; 
 Wed, 21 May 2025 16:01:36 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60b7e43d07bsm473895eaf.26.2025.05.21.16.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 16:01:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH 09/17] include/dfu.h: Audit include list
Date: Wed, 21 May 2025 16:51:14 -0600
Message-ID: <20250521230119.2084088-10-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521230119.2084088-1-trini@konsulko.com>
References: <20250521230119.2084088-1-trini@konsulko.com>
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

This file does not need a forward declaration of 'struct list_head' as
it includes <linux/list.h> so remove it.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 include/dfu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dfu.h b/include/dfu.h
index 12f9dfcdfcdf..80593a906fd2 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -173,7 +173,6 @@ struct dfu_entity {
 	unsigned int inited:1;
 };
 
-struct list_head;
 extern struct list_head dfu_list;
 
 #ifdef CONFIG_SET_DFU_ALT_INFO
-- 
2.43.0

