Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B309C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A4388548;
	Wed, 26 Jun 2024 18:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hfNpJg06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B059884C8; Wed, 26 Jun 2024 18:00:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 655A3884CD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4248e28de9eso31807415e9.2
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417608; x=1720022408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=hfNpJg06UV18mv20S4CFtAd8dx12Pcim1BmaX/H5ndz4M76maMiybkSEP/M632L69C
 lN3n03VyVnKgpFuCyPk0KvLkyeHIyBcL5r/SgmBVPaxs4fLrYzmIY/ux4wxJ/mKHoTvS
 9L2Qf6iv4/W6637fwKRbugheE3KzxbUhsT2rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417608; x=1720022408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=jVt7UaSG9OA3OFhxKhMenx9R94DRDOh7V6iAwG5m64CGaMzrZlDV3Sy1rBsWN0zbSx
 f2tBR63SF/9No9wERQsftaFXBrpJiucrbo62qJjrV5Dk9u11QP9WiBr9/UK1bdtG5JHn
 I3EHO9zfpYA6pRyL9/6piXChMkEAtDzOLbgzeUrCNjjQkMksl0NcQg0Oxis36twdWq0P
 4/T2cP8qnByzUfoN0FGYEJFdaDTsMLyRj79ofpbCv8BiU8ohOuCeeNEMSR4PvBEZVhJP
 RtpkoBEeqxNxL6GR7CNu2GvDKULGaHHz3yfAOVKtFzR/oZifdfKl0ag6kMdzDE8upVCq
 2sew==
X-Gm-Message-State: AOJu0YzXRS8KM336uXMD02HKtQA9bsOKgXHpFnleIWQNSgMIIv3cxuMp
 l4io19jObOIHtwQFnrjVE6G322KzDFoS/Sdnhl7cPVvZiMMq7ptvTzGVy/7wvIm6KGKRTxDl0R9
 Dhg==
X-Google-Smtp-Source: AGHT+IESB5s41QTISMWZWZoPuRXzf/EhWAylx0ClGkrT1vzqGI//yujQKnZXhNS8Mz6KrPvQH3iRWA==
X-Received: by 2002:a05:600c:4204:b0:424:a5b2:4460 with SMTP id
 5b1f17b1804b1-424a5b24569mr29300485e9.33.1719417607753; 
 Wed, 26 Jun 2024 09:00:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v5 04/16] binman: Return failure when a usage() message is
 generated
Date: Wed, 26 Jun 2024 16:59:33 +0100
Message-Id: <20240626155945.278640-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

