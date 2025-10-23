Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DBDCCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 17:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2221B8006D;
	Thu, 23 Oct 2025 19:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="VzGOaAqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F7980422; Thu, 23 Oct 2025 19:54:14 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7F408003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 19:54:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-637e9f9f9fbso2060797a12.0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1761242052; x=1761846852; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O4EC+V8Z3qPI7IUU+gUSwcdr+PD8jQcjbTPRoyg/qZI=;
 b=VzGOaAqGAQH7Q4zUfFp1dvmYebjS3PbtOGzUWFZyLT1hmOOLrhjGHYqliz7pJ3j7qV
 PQX3QZKY2EZAujlNevrZZ3Awunsu3PmCztbi1uG6kk7c9RZBgMyeQ937vqmzVNWRWoFc
 j/zxhK7LhJWQU9/0nBx8KO9+Ew/bkZZ6T0aJ9eyYhFKwMChJ7QO+Yx+lIVhZXqrZx7R4
 vpdFeMdS1tVBP7CQ+XdeILXh161+417l90OCohnHxlMeQwiTLKYr/mF7beM6R1hJL5PD
 ZnNiPgTj8OaKibaGA9zwNVv8hssB2q31n2brcgZyV8+XYCmHjDpo73y51DqUJkkPeRjw
 lZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761242052; x=1761846852;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O4EC+V8Z3qPI7IUU+gUSwcdr+PD8jQcjbTPRoyg/qZI=;
 b=LFYQ+ZeZkuLLCAQsLjWda5/2Tj1NQ6XpuG/i56OvUQrCEiI3ZqRjk8tVvO0PLLsx2t
 kwMD50WMDOlgJf6yhTsg+5pcavRBHgXqYxKJRPhK5+qA8BpKqZ8sw9fkBr7I1Ou+yS2a
 t5wmGUknEi3NPIZTjrva3A+UI3a844gffIHCXhThy8NMMLr067P6lObD3FqPaU5BT+Sk
 3Ur3gYOYLLn2+kbWs5x7peN7uqCxTHXnyZfuk99OtZY0pA9h3ad4XzmiMV7ej+R+qy0j
 jPlG95Ya/J41MjRALmKbhnTKtfk415GutOLNfyLVeowtSxh/mBwjS8dQBimfxVdKJp9L
 AS4A==
X-Gm-Message-State: AOJu0Yx5VAcCRa7v6m3lDggkHMb448k5MTvoU1nlt98rNwGwLmXarnF/
 8s9K6Jq2XwMaj/m9x0ueEgcq13ThqXapxeP+lneN6o4mBJPDAmIoYRM/ZM2uDw==
X-Gm-Gg: ASbGncuKzO7vUUrVpFRceZpUSb+1FQas5SIh9EI0YM216k/9xP21FXJIT+aKlCdLu1M
 ubrZR4embUDd4D9I3x4WBrMSVGT6Of7bM9sCV7XLey2Yq2kl8nDahe3gkAorDVs/kvWjgARrn9q
 sudY3QY04v+0X5sGgePs9tXHH0upFEjTWTz4ou8pZUcoaLhfBqVtvuyTvnpi7cSQ7PBOB09e+nF
 FO1zEA1BlD65STHgVp30Pj+zkr1OcEInt07Xjjhq8yOBRLALOx7CDYE1LX4FsOvFjEuJkSwFC+N
 VEwPhP/2svJ4+oTw29CrMqFPy3YtlP5JBSdtV94au9dCKtevLOZlXjsXUTlUdgyQmo/GMj7OxZS
 qclz/6UZ898ARAWSPe7cvbAkija0xXPTkaM1QWjmGy6GBfbFJyvZfx/qp6g7MnOZgc+jB0dXvZ7
 bEn2nKd5xGcQNQ7mHZEaPr+7fGrr7suOCGJN5czdYhI6nM5gDJh/WyG2InOsXyMqGY+ds=
X-Google-Smtp-Source: AGHT+IGG8hbdBIzlU0YB0HRyb7+NAr4T/0uRDWg7jd56wXYFIh0tp/+akEF+hyMvXSyITrSsj2Egdg==
X-Received: by 2002:a05:6402:1e94:b0:634:544b:a755 with SMTP id
 4fb4d7f45d1cf-63e3e4783dbmr3602585a12.19.1761242051483; 
 Thu, 23 Oct 2025 10:54:11 -0700 (PDT)
Received: from development2.visionsystems.local (mail.visionsystems.de.
 [213.209.99.202]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3ebb3738sm2179146a12.3.2025.10.23.10.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 10:54:10 -0700 (PDT)
From: yegorslists@googlemail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Yegor Yefremov <yegorslists@googlemail.com>
Subject: [PATCH] bus: ti-sysc: select CLK driver
Date: Thu, 23 Oct 2025 19:54:08 +0200
Message-Id: <20251023175408.272070-1-yegorslists@googlemail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yegor Yefremov <yegorslists@googlemail.com>

ti-sysc.c includes clk.h and requires its functionality to
manage clocks.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/bus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index e60aa722b97..a786fe430e4 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -14,6 +14,7 @@ config TI_PWMSS
 config TI_SYSC
 	bool "TI sysc interconnect target module driver"
 	depends on DM && ARCH_OMAP2PLUS
+	select CLK
 	help
 	  Generic driver for Texas Instruments interconnect target module
 	  found on many TI SoCs.
-- 
2.34.1

