Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CF6CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF8589393;
	Wed, 23 Oct 2024 15:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="UiNVN328";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4715589341; Wed, 23 Oct 2024 15:29:43 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D3089325
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d4ac91d97so6446927f8f.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690176; x=1730294976; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=UiNVN328029EG/Ln1FMpSEaAPjslwN1nU2DLIFgZMyEiNC6vJXJpGudPRujR4wT7x6
 H3wtj+L7aqHBNwvQQffQ0D3MVhGQ+Im5G2cPb9oLYeKOqCEQWQQeRy+QE4u+lq7pRlvr
 3IP4lyn/7IyI+zBYN6nEGHEvkKpoeshAvEn56LvIc6/zS6wBOXtzBUDHHIEsShrs8q5L
 WJtFq8argAXY0XKraDUqTJMIGuSy2ehKv6LGHUHc55RtuV111a0DyC2k2OJpkAiuuYp2
 T59DrMu6EEpXg97xgRPd8o74k1RyKs8LicDB/P8cE70PaWS0J0wWganr2L0Wf66DupEL
 kZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690176; x=1730294976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
 b=vk66K4x64dWb04k0rHgUqYgwS2TVwqGGxEeeieKbB3nXPxjPzAUp/yDclioF+jegt4
 zmsTaSYDtvYlv2fK7BcGF+nZTMtrHmwgiGEx+xgMX6Rvve3sTNYD3VsVOEUSjNMPWYE6
 LUYeErdQHdfojPySKs5/hkcoIRL3nzsYglJwc2KkE5zwjV2XCI/uF7jpMo+P6LqyiF7y
 sc1mmLonAqIvnuAe1V9R8y4XeITXpCx20C9hxUD0ce8n5HiL+bTm9mapxIwH36uw/vLz
 1Q1BPFHQtAP0SEYvQb258MD8+GAQzlevSDaG1frTXEYKAgXIWHdf/kzfK7y8bh5qrmK7
 S/hQ==
X-Gm-Message-State: AOJu0YxzYtlxuLGzRY+RsSysUD3LIpkppmtGzJ2wAisGHTGT+QoUKs8K
 KYUWC4llfrMa/gLeTxpZveV+l9HsiJr8uz8et4+jE/NZqmCo+CxS3r8tc3Tm+L105CyRKvFB2z6
 +
X-Google-Smtp-Source: AGHT+IHqZNaihzROUm5dl1UtiJlMamDilk3Qqw2uaiF6gCH1kBkI4rqjSi2iek7CuoB3F2rkvDG/wA==
X-Received: by 2002:a5d:4e8e:0:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37efcf9308cmr1948521f8f.59.1729690175878; 
 Wed, 23 Oct 2024 06:29:35 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:35 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 35/37] bloblist: Fix use of uninitialized variable
Date: Wed, 23 Oct 2024 15:20:18 +0200
Message-ID: <20241023132116.970117-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2

