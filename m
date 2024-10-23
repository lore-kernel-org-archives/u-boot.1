Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92B0CF5389
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5AF88FA7;
	Wed, 23 Oct 2024 15:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="Tb0wDcyZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C6D8826E; Wed, 23 Oct 2024 15:27:45 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 775C088FA7
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=ezra@easyb.ch
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso5409941f8f.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1729690054; x=1730294854;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PI1sI8wTvMSqJn8lE4BS+Z6c2SWDOBVT8+JIL859iJg=;
 b=Tb0wDcyZhEybcmwNzLbRQa92QENrHwS4gxkUrNwA7fkB7pL72MJZDCkz6VrFzwszQ8
 awpTMY3prr1L6fmshYD5ZZ8tEiCBgEjOYxdDeKPpnylM+sBAHkuGWt6c1J97qYXkygK8
 tyb9s7TkmL18FjWubf7hyNZtpnIvx8zjGRnrD15erDAPxqgjppr0/btX4n0DPcNQxG4f
 /K5fW9y5xFnqFgW/VzJhYoKP5sjmLakPgIeFgxB0FuDrtvtBmzZO3uXgnxDSwUjoSNQw
 ndNjbCm4X6Ol3VJu05f/2O4b9/5cgOE6Pe+8GTEPwOoVLHnvkBryfur1v7iPPPZH6a7c
 C6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690054; x=1730294854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PI1sI8wTvMSqJn8lE4BS+Z6c2SWDOBVT8+JIL859iJg=;
 b=nbMXK06aQSm8MkvoRs2/3PO8NJxZgZMRSDrvvoZvGj8pPHIVLrJ2nrowOA+32o17oM
 zEgZZszy5q2Z7f6ClcRiQIkQn1Ovr0U3JmhwqSjScqYJqWtEBJFgZ9V3ObKMNNvRw1kC
 tvW7uxsB4ZtUzlui9FcXnIRxrCtpRt9xuLDzaYdstjDzbKIb+zuQouZ+yOxCOg6Dm98i
 fag+YjdYwSn69pZZW6fdUC3eDim2CKDFhEpZGOmoBBD9G+SbmLhcM4lZHRK3pj0WnQo9
 jRXNeoBS9+BQvd/ABl1kXDtj37fYVuYlBCkziLzEYDGxbZCjVetQ+M8u6dUge73HTU6h
 KzLw==
X-Gm-Message-State: AOJu0Ywd95F6gOlHsTKjNhfn3iasTBpQ660GGzA5oloMRyTlEQEkBoTa
 gzy+TrfCScNFLd9m8ZQ3K/2PiFhktoCEd3ppGRsESYAhRum6B8ZaT8akzbkCuxQbXAsq5Is5UMT
 4
X-Google-Smtp-Source: AGHT+IF705ohW766fbjX9tVLtbQgHPRj3l1i/pcdvwyq19g/czby6xhXSwpdXnne6Jzj84bU2VPhHg==
X-Received: by 2002:adf:9cc4:0:b0:37d:5133:8cba with SMTP id
 ffacd0b85a97d-37efcf10de4mr1650942f8f.20.1729690053578; 
 Wed, 23 Oct 2024 06:27:33 -0700 (PDT)
Received: from localhost.localdomain ([77.109.191.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43186c3a43fsm16330445e9.34.2024.10.23.06.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:27:33 -0700 (PDT)
From: Ezra Buehler <ezra@easyb.ch>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Subject: [PATCH] mips: mt7688: gardena-smart-gateway: Increase
 CONFIG_SYS_BOOTM_LEN
Date: Wed, 23 Oct 2024 15:27:31 +0200
Message-ID: <20241023132731.420801-1-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
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

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

The default value of 0x800000 (8 MB) is somewhat limiting for us, as our
compressed kernel may grow up to around 4 MB. By choosing the commonly
used value of 0x2000000 (32 MB), we are definitely on the safe side.
This rather large amount should be fine, as we have 128 MB of RAM.

Signed-off-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
---

Are there drawbacks of choosing a hight value for CONFIG_SYS_BOOTM_LEN
that I am missing here? If so, 0x1000000 is most likely enough too.

Cheers,
Ezra.

 configs/gardena-smart-gateway-mt7688_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
index b7f4a76ce6..2c69e91339 100644
--- a/configs/gardena-smart-gateway-mt7688_defconfig
+++ b/configs/gardena-smart-gateway-mt7688_defconfig
@@ -47,6 +47,7 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_LICENSE=y
+CONFIG_SYS_BOOTM_LEN=0x2000000
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_MEMINFO=y
-- 
2.43.0

