Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8969DC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451EA807D9;
	Fri,  7 Feb 2025 19:31:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gSHAjhZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0335580A0A; Fri,  7 Feb 2025 19:31:54 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52DB8092B
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so75116239f.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953108; x=1739557908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MrJf+yQe/+4IUxmyDs5V0ijofrf14ftJ4+H5c9rN94g=;
 b=gSHAjhZ+6WLR2n5RJjn70+mfyjT+XoVRvhEMw20WGLgylruMRH6Dn7w/B1AhDKgCj0
 0NMVPA9shYJtQvVnkYXtExyuK21NZrWnHctJDeh5R4z68FnUB+MhRwGH4udJBgHxZZVS
 eSOLpisU+3piawD7Ok41rx+PieMdma0IN6bIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953108; x=1739557908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MrJf+yQe/+4IUxmyDs5V0ijofrf14ftJ4+H5c9rN94g=;
 b=J5nzzAiF9gNyy6qJh4KXTVXfv85CahYSPOYsp+HEUX1xB6ySx1EMyPdKOMHTuVmqIM
 BDu4dnmv4Ea6QTcTEPRqLuT+j+0ixVsl+DbguUYModkJ8N38/BRm6crVG/7z+1Eh0YCu
 gfALO5L609te++x8VPylJih951s7bun6MeEKMoZGSHsuq1qU8JNH03mNKU0AbbWPHxzA
 c7//hqFcEDfSVHpQBd/optWtrTFp5X7abI5WrJIdlCgyYv1NjPoKXKjX8KkKN5NUo39D
 8VDwvtC3SApgVZaBJh6eBGi51Vs47rTxeOGsrT3/nGIemXTa4ZmYx4/BUtvVC7UfB9KD
 V4qg==
X-Gm-Message-State: AOJu0YykePAs45CqzW0UpiNnuVgc/GzYibOF3FcGvOmgTNXKUyVWasWu
 71l9vv1Ud8U6f1z9MoOneR1Mp8N1kF5uBa3HHCsFdOMan31BYTlcZnZ7B3jJodj65SpoiMdqfSE
 =
X-Gm-Gg: ASbGncu2R7xF1hoUtrn70wG/P+OY6XwtC2+F5HPxr6qPB42TT2Wmuuqckc2fxD86LFr
 fBReP/3aJlgQKNHJhHy/YzptblE9Fy3urh37I8ChnnT/3F591JzDr7WZQc9ym7Oh+u60OJOrQWt
 y9KLHbgcboueQZfyUmLQ3kfPi7XG6/HZX8XLcQQDQzKkJsRPZtkWTGmHbzXhq9CANHSGyQuDsdZ
 hQ01G2BuPSCkOv7ARn91s3LPmyp0IvfXkL5whWpcOs/N++xKknWmxx4lq1qDizaZ+BVqktEagJs
 sA9j2VWsFU62Fz13cyqy0PsjL+V6Ycyt2Q3h292biWjMQPOwj2O3
X-Google-Smtp-Source: AGHT+IGx4acaQs3wUyxycdZ8hG/UOGFFWQd8XMht+nQU0mNdM0O4KmQ5tKg7O0PIA1JmHdto87xgJQ==
X-Received: by 2002:a6b:7e01:0:b0:84a:7a0d:cc67 with SMTP id
 ca18e2360f4ac-854f3a72a05mr656635539f.8.1738953107912; 
 Fri, 07 Feb 2025 10:31:47 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:46 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/29] test: Move env-test rule into test/
Date: Fri,  7 Feb 2025 11:30:40 -0700
Message-ID: <20250207183121.117663-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

The Makefile rules for tests should be within test/Makefile so move the
'env' rule over.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 Makefile      | 1 -
 test/Makefile | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index db663979206..74eafdeb646 100644
--- a/Makefile
+++ b/Makefile
@@ -893,7 +893,6 @@ ifdef CONFIG_POST
 libs-y += post/
 endif
 libs-$(CONFIG_$(PHASE_)UNIT_TEST) += test/
-libs-$(CONFIG_UT_ENV) += test/env/
 libs-$(CONFIG_UT_OPTEE) += test/optee/
 libs-$(CONFIG_UT_FDT_OVERLAY) += test/fdt_overlay/
 
diff --git a/test/Makefile b/test/Makefile
index 47a07d653a9..17716ef384a 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -19,6 +19,7 @@ obj-y += ut.o
 ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
+obj-$(CONFIG_UT_ENV) += env/
 obj-y += log/
 else
 obj-$(CONFIG_SPL_UT_LOAD) += image/
-- 
2.43.0

