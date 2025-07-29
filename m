Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E19C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1434583108;
	Tue, 29 Jul 2025 17:52:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tfRpCSvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F716829F5; Tue, 29 Jul 2025 17:52:20 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3697B81E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso59631175e9.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804337; x=1754409137; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tIHGpbh5H27iDqdxx5maHsd8aRW6MX0LXAiA6myMieQ=;
 b=tfRpCSvTYxI0zdtXy4AvfA8UT8M7e/0P1M4n3satc2LCyaRFePsF1Nn65HeQTNtLd+
 MIeoorvDIt6+/TJ+tuyLhclM3aAwgmzZx6Gzn/nwFgsuBfaJNLLPUMCFL4CsWqUjabBs
 gDF7r3TDWvbG/PuPE10ZFSSFhP1y0QoD6JogP/Ac5q1vx6IS28DS+ID/XJ9u6rxz5OcJ
 y5UKvBn7keAGGDHG1CheL1MibkhV+VFowUZUuVUFasYOoVddb69LTWyfsS6ZTMhUaUk/
 NCp8ApVtOKfsma/+bWj602GFz9fF+m+Ax8s1UMpYgs1lrFf/TJkWWGDi+LL3wW+FeOA0
 UeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804337; x=1754409137;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tIHGpbh5H27iDqdxx5maHsd8aRW6MX0LXAiA6myMieQ=;
 b=MtYQq1ax+akkZYxaKDiWkXVzxfkhsPJq1lUa3YnLmaGWjLw+Hevh8duDzkvoouIzGl
 asOwKJB+j2zfgPpiSbHE5XO3assTsOCVfdl5o6W3oBRNVqlvUQL3pBrXwiafVFAfwVSP
 8bIY8eCbT4FgL22lsqMwi0HjlB6BDJNDSGsPHBe1q7/R/ghIv5oIpYgUhPiLVefChQld
 NIiXRuwjzPBDhSlDRcU72rYwnwqrV6AbIpjT1szNRcTaQIpgdPc+YQhbRgnPgpNA4cay
 54ikrp8vo7K3T+bTeJpnv8V9slVQiVwkTutpM+Oay+frEYdi7iJ4lsdfSfJJTfIvt9d3
 Nm6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2XEA9+PR5WGbLnWwOKyOxEWkRqGP4W2OWgjzNRTsH7KnbJN8hTLlyuJ3mdxZlOkclgixYbsI=@lists.denx.de
X-Gm-Message-State: AOJu0YxzDNaImYgsDeTaklb4DwlyzNjceNuB49TlZPHEsF3rTHeK/yVo
 ujsZJaVpG4CveQFhcNyIC8+gTETFDKQtEHqx3tH7E3Dami+MqrRIlGXN9VBCUUvD1PSB2pqTtdG
 hf+RE
X-Gm-Gg: ASbGncsQx1MakVnOBZh2wA05b15o71zKJtsKI1akXkhpgxAZiB8S3eI3fD4Y8J0RgEQ
 UYid00Jnh0VV7dYpWCF12q4XfQkIh1UM79dM9SgjxlfTzA0UyNNXW+qsFVI/4tndzEoBGw7y07B
 ke0JKfL2ugA84p3a16zjLHBwBWyYTUfhdGeFOZyMpSI9+yp0vIJNccnq4aJkpFekbQLizWOf4UF
 NdvQFhc4MILfeYqFG3Tb6Vzn5OJZQ1MA6YCPWf/tGfwcZHnmqNNsh08jBj2TUTazHn+oY42Zyn/
 zdj2TXZ1wFgPzSNhfcIVpue6Iz+sdYreLzfXN8Smi49vEmjOfj79+QpXw5SV8G4VQbKGpfesy/q
 uR1tXPmSvS1HVd4t5VTiS9Tuy23Znnaw/06jc4QfRnZ6NxgbM068nEHHt10XMJCKOoUT5rTxHDc
 /TEJ/ae7L0PdfeVDmLcgdI
X-Google-Smtp-Source: AGHT+IEzQtXms5/iEMGGueJsBY6/JYZwbXTwWsmcqL8lSVShGcF2oMMKLItwpT0/mJDxoKckKmijDA==
X-Received: by 2002:a05:600c:1da2:b0:456:1ac8:cace with SMTP id
 5b1f17b1804b1-45892b9e27emr3713615e9.12.1753804337304; 
 Tue, 29 Jul 2025 08:52:17 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:16 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:00 +0200
Subject: [PATCH v4 02/10] arm64: initialize the frame pointer register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-2-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=994;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=vzLGLPqeum6SV1jaUPioF2BciGorBkrir+9VBG2Aj4g=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4jYUoLIa6jMZBNJucvQ+U3+mrakMD9QAmc8
 h5LR8GLrdyJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuIwAKCRAFgzErGV9k
 tgs/D/9RLfS5eGc0sPBRt8odiKOHlxyZS1vFiTngj09C/71Ue/BkK9IOmJcbgcbEB7taNMFNOIL
 Lu4sqzrBZGYB4e53lomxbje2DPnEWgHAkYEoSa28WdDPm0tdnYmTC/umTmmrmKrA3tFVsrmpJGE
 aeu65SfmFncHnknL89qzqgv/nNBWdLaeXFtHDMAJlW8dXpDgr3X5oiDysdJWARw6OIP2OohzHc8
 8jILHl0XuyXPknuRANKVgci1y1j71nHEBrXZ2mYHRSFEk8LEbkvgdsAIdyJQQn+QVnkdDDVdbpu
 B44/BN0u0mMwdggLCRA6/zUemmtsj7MAGMP74U7RVx+smQNzYzESoYbD0DH6VtmXTheuf1bc9Va
 y/S74HxVbIqqYgO+o5kV/yv0w7wucxcGLc+osYPT8Ai+HwfcJ3+J2ZoNY8uQl9JGKlTtF063Lmb
 NnLYs0uHXuS+U9FyyT65MYWDi+S/fFiPb6/7ukhlBiGYGWn9SX1OISRU9f2LzZFMzTplwW5dWSP
 +89Qwm706Ji6YzGzkU++E7orSoT8Ni1otzkWwd2FYlBG8d/lUBT3sPtKOPYX+x38zTJA/s/Jjgr
 rJ5TUob6aK14sdmUnYR4VE/sjejuMrlEjMJeQaNQjbvkxjTTPnqyyxTE4fqBLRUonEKj28F9lND
 OU6r5LDE0pYTrDw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

U-Boot may be compiled with frame pointers depending on defaults built into
compilers are via explicitly passing -fno-omit-frame-pointer.

To stop walking frames it is necessary that the initial value of the frame
pointer register is 0.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/crt0_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
index f3f279f2c39cd27cc30801805999092d582cef52..3ff0577e9c87076e7fc6626fde3703fe952f07c8 100644
--- a/arch/arm/lib/crt0_64.S
+++ b/arch/arm/lib/crt0_64.S
@@ -167,8 +167,9 @@ clear_loop:
 
 	/* call board_init_r(gd_t *id, ulong dest_addr) */
 	mov	x0, x18				/* gd_t */
 	ldr	x1, [x18, #GD_RELOCADDR]	/* dest_addr */
+	mov	x29, 0				/* frame pointer */
 	b	board_init_r			/* PC relative jump */
 
 	/* NOTREACHED - board_init_r() does not return */
 #endif

-- 
2.50.0

