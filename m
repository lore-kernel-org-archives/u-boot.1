Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0E3C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB39588581;
	Fri, 21 Jun 2024 01:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ITgpSa7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D787883F2; Fri, 21 Jun 2024 01:06:46 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687618839C
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-375f43e005cso4348845ab.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924803; x=1719529603; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=ITgpSa7EkFcZffTD+rMmmKWqKJWVIiz8tm5Da2Wxgt/KEJCfq+MZGg6CCgx6fHwVWb
 +B1KmVO4z82HLEalMNrwKiuaCGlkkTxyGWtKEcvpe7DstmZmDcbOJnNRO4TuuoCY/Cbp
 ZoPlM8q2/OYQ6iBugcen6DCQ/Las38W7SJ/Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924803; x=1719529603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8WYab1vLvZBJbf0Xi3jX9RE96p1eZZ7nMT1fkj99CFg=;
 b=lSjuR1pDRU9woGPIjkM+GTmRiS3fg5KHRHHMLBo4yC30YJ8OcHxRJd/8zLSMvNhg4x
 g+tSExKvyGtsNNzw8wElRizGsOn6Nju6NSXGMNeuZ1J1GI3C+jR5nltZwL7QDNRAZLhw
 I5oHfCrd2oHlroROaKmADV87OLMral7BLdCczlfolbE43zdNGSCdkXRua4LROPYUvwFi
 NQtw2h5a0E3swhh+bWDmSQYN7comcOnCLUmfgrLcU1AUv+EixqgOPJmN9knzWNQdCOie
 BZI7AVPTMlr3nQlHq/W9ivzOgEEd1CUvyZRlpZWwbxMAa2Gfp6+FwCA4vvm9AZ6F9xwH
 mtSg==
X-Gm-Message-State: AOJu0YzPd5BfdafzavAAionXJY9t2tSXaeInETYt0Vv9KJKRQ3DnUaBh
 gBDDBiSJJtEf3N/pJsqfhvMuexRmK2JNU58iWc9bcOgtL4n7OfmHUsusA2Eosny0LxcvTtdB6vQ
 50Q==
X-Google-Smtp-Source: AGHT+IH6LdXLFeYAMCAKSyza1udYYFIIjYNYY5yFji99o7UYMGUYK+YFJxKXSyOUW+idmfR9jHFa6Q==
X-Received: by 2002:a92:c545:0:b0:376:2a41:5f42 with SMTP id
 e9e14a558f8ab-3762a4160b1mr14799155ab.10.1718924803002; 
 Thu, 20 Jun 2024 16:06:43 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 06/18] binman: Return failure when a usage() message is
 generated
Date: Thu, 20 Jun 2024 17:06:13 -0600
Message-Id: <20240620230625.1797397-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

