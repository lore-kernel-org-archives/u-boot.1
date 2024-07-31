Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C461C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:49:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47AB88A38;
	Wed, 31 Jul 2024 16:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AbwPqM2i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96C8F88A5D; Wed, 31 Jul 2024 16:49:18 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE9388A4B
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-81f9339e544so219890739f.0
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437355; x=1723042155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=AbwPqM2iJtOD9nIn66ePpAiBblcBzHmQx5yYePMuBo8YlvmxmuJztZgePv5lx5cXSn
 nasAMWPhAQVGQT1ZnPt+agRiZe6mTsGjkA6hVxM7YJFRzGvUw9SoDy17732791LYcS4S
 FbsK4ldYTE50SnMCyiHaMN6lL1up8lV9z5evs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437355; x=1723042155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=LrS6pscauXZhB6LS5jCPIynnkh20Zk+uP2gvYGyGT7sJbBv3K3FkoCEH9o2gs9NYiq
 z6MqmSbRn/mo/JlhS+fqxaoKHJquRhuv0ZdZyQVZNvOxWRoeMjsHjaGAuXZOmrMtepD0
 rrNMfcJHpQg7PcipTVA5N4629v3tW/RwIU1q7nIoAC92DLc+NG0D7s9/0v5tiOGSe/HY
 GpASzjJHm39gpZl4jYFqNF1vL8o33gE/vhhZejA+MkSd6CIln5CBAYXv0GSdJO63aBNI
 rz+/gPDR9spsiYnzu+qalOXfWJqSZG0bGI/xLSWmKlHc06geuBZnsWUS6inBn026FUFC
 AVQQ==
X-Gm-Message-State: AOJu0YzOiDgNvcb3U5JRBCRIF52gCvhjcO5QQcuA4POQyI0DKImkyHly
 rkjXs4kN+30u4j35+GstnmQD2swL+5cwucMEqnKZQdOy80TKR3JwVDrP9uKlZfzRAuif4W1Kq74
 =
X-Google-Smtp-Source: AGHT+IH84SFFZ+lKqtzrWO/4KAnTX00NHY/sRv0OS6lT5lWm/2p4nZx/0XI4dHwYxh/BdDrci//yZQ==
X-Received: by 2002:a05:6e02:13a2:b0:398:f487:5a04 with SMTP id
 e9e14a558f8ab-39aec2dcde3mr179306195ab.11.1722437355103; 
 Wed, 31 Jul 2024 07:49:15 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39aec0db8b2sm40671855ab.50.2024.07.31.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:49:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v7 4/8] binman: Return failure when a usage() message is
 generated
Date: Wed, 31 Jul 2024 08:49:03 -0600
Message-Id: <20240731144908.795290-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144908.795290-1-sjg@chromium.org>
References: <20240731144908.795290-1-sjg@chromium.org>
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

The tool must return an error code when invalid arguments are provided,
otherwise binman has no way of knowing that anything went wrong.

Correct this.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: fab430be2f4 ("tools: add mkeficapsule command for UEFI...")
---

(no changes since v1)

 tools/mkeficapsule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index c112ae2de8d..f28008a0829 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -977,7 +977,7 @@ int main(int argc, char **argv)
 			exit(EXIT_SUCCESS);
 		default:
 			print_usage();
-			exit(EXIT_SUCCESS);
+			exit(EXIT_FAILURE);
 		}
 	}
 
-- 
2.34.1

