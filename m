Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C1BC4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9786687B99;
	Fri, 15 Dec 2023 05:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="glXeHS9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC1D87B18; Fri, 15 Dec 2023 05:19:39 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0174587B3B
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b9fd22bb1aso218344b6e.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613975; x=1703218775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZlb5cTo9Y600ZNYwgX1jCcQ/k9/3pgvNvnsK0OBBN8=;
 b=glXeHS9uvBbq+s+rMCphuTmNbkeuWialRvS9i5E+bnaYuTRoMEVq6e2bIT5ec9VMbL
 d647xCZotwBH0eafkSbtnKXrQI5tAfhTDT5pCc6+ndZ8vQlGyE8BGboKUW6aYwvV3xNP
 /imSTZqud+7pK3orxGMSdHDrjQRN4BFrFLMK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613975; x=1703218775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZlb5cTo9Y600ZNYwgX1jCcQ/k9/3pgvNvnsK0OBBN8=;
 b=A3J0M6Kwld18JEfb1B/vSQxEY7eMhLKjR+pK16Sb8HPEA1sCN5KZJaL72dj7dx5luQ
 IDOIhzTxTLGJt+8xj4uhQSo5epaNrNjhiUb5G8ybK2mq54H+W7RjGBXwzpXAs/K8VdM5
 240GEpBKXLtHu/uGvdGJ2CzhS5Ad/c+H54tccvREy7FlYxoLwdzOspu4NXxOy6py2yTQ
 SxuXBGJ+KPD/kuQ8IL6OD1d+9PuRto7yoj/DiJ+mtxWuquCocbGvZ7Wzsnvh+FVt9GvF
 xN4kdxeY8foG+3eoWhIv+FONDRwGrFIbomAdO0QE82l54Qrbyr2V1A5iNfgRSGjZ0P/0
 TRBA==
X-Gm-Message-State: AOJu0YzLmLwZXuoBxW/rECSH4g+5LeMAJBeT7dAqEHvyrQCnwqKnyrjR
 Q2IgiCn9fOp6wWoQxT3LWTnbw5PmQubxenKsRSm0yQ==
X-Google-Smtp-Source: AGHT+IEwWmlZZ4ctP746weixARd+RniDe9s1YtLYbJBJvNrMpbBneA+uopHV4Y7GDmL4duohTMyCIg==
X-Received: by 2002:a05:6808:159e:b0:3b9:e0c3:c1a2 with SMTP id
 t30-20020a056808159e00b003b9e0c3c1a2mr12480809oiw.9.1702613975678; 
 Thu, 14 Dec 2023 20:19:35 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: [PATCH v2 10/16] pxe: Use strlcpy() instead of strcpy() in
 label_boot()
Date: Thu, 14 Dec 2023 21:19:08 -0700
Message-ID: <20231215041919.2197788-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

The intention here is to nul-terminate the result string, so use the
correct function for that.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split out the strlcpy() change into its own patch

 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a92bb896c63e..2c87aba7ed33 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -593,7 +593,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 
 		if (label->append)
-			strncpy(bootargs, label->append, sizeof(bootargs));
+			strlcpy(bootargs, label->append, sizeof(bootargs));
 
 		strcat(bootargs, ip_str);
 		strcat(bootargs, mac_str);
-- 
2.43.0.472.g3155946c3a-goog

