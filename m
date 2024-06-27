Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34ADC3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 09:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC3188579;
	Thu, 27 Jun 2024 11:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NVYGCWwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B778855B; Thu, 27 Jun 2024 11:19:36 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067CB88247
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 11:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3608e6d14b6so4863645f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 02:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719479974; x=1720084774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=NVYGCWwqAOiEsYmDrrmAj1xQ8O9e8nApfkI+8Q/IPZY4R3eOuQlfWeH3po+625raVI
 PFZj5c5fvSZRMDS4tEDnlTudWNH7TD0LNsGftrdJLrRrBnk1/tJwPIfLhHeQPCb7ECQK
 +6pqBAL4q76HJO4cUNOTXrL07nKZhADAPSumQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719479974; x=1720084774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=CbHeQMXhW5vnduFroqaRkDwvDDoNnK7mAGbn0faBlwXBiSjR1Hamy5UaFMs/fxq5Wt
 KWZsEW0oPWneKsgfKy46tFHLhX5y0WVKR5cioJZjL7nyi84iS8QyTe0nWBXb61D2CVLF
 wjeRAYsCd2+L61amjvyp1vQQAlaWBY0B5DrdTEsCQXGZa4djykhf0GFAhFhmb3pLHXg2
 OM5O3hzeM/Q+0b17T+Pga6UYuWlatAlDE0yaVT1dj5L5H6dPxh/iZJESdhI+VVkiTN7H
 ilYREXgWtL+XdmfrHgFwh47EnPhcpuciUkm67kUx+URDUi3l/NXeTIwEZYcLQ6hi0gyY
 gVfA==
X-Gm-Message-State: AOJu0YwJ1lDcHXi+gsHoJW+Pp9wqTmrMeiEqDBxhdO2OEB9TVQmMK9WH
 JAaqayUzXbNsQi7AU11Zyn9r+tJbWGq5EFpqHKeOVrdJb8VhoWKH/eFLWszvQhbaB38v+uFFusn
 oOQ==
X-Google-Smtp-Source: AGHT+IEuTeVaGQBBJ4qN7GNt53rTyJt72r51a8AwSXnzsZPeMwIMQweaB9N/91pfxEC47yfonJ2DdA==
X-Received: by 2002:a5d:64e4:0:b0:366:ed80:d045 with SMTP id
 ffacd0b85a97d-366ed80d1afmr11014463f8f.47.1719479974404; 
 Thu, 27 Jun 2024 02:19:34 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367436a28f7sm1199818f8f.117.2024.06.27.02.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 02:19:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v6 4/8] binman: Return failure when a usage() message is
 generated
Date: Thu, 27 Jun 2024 10:19:22 +0100
Message-Id: <20240627091926.374633-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627091926.374633-1-sjg@chromium.org>
References: <20240627091926.374633-1-sjg@chromium.org>
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

