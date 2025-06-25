Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D26C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1604982E8C;
	Wed, 25 Jun 2025 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PAH/SOba";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F6482E5A; Wed, 25 Jun 2025 15:21:38 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7059182DF2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so4457624f8f.2
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857693; x=1751462493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zZ5v4Vpa7CEYpwxAITHXRuPqXdh/9/ctvBxOwqT1vo=;
 b=PAH/SObadhYeyZIe3rGEq97pIYXeY+b1FUYGVXkzbrcD9KFyCH8bsxwd3VoUVoenAV
 vLenb7jvj8tXfOIqr7fU5rt2S51m3Tycmwfa2l5ms1oCg7w+nmpV1iT0ZQuAm/c0wMUv
 Jl6DmGkE2e50wrmxaYdoNIomNyyWMWr7WFrYp5F9HxpAP2/pN6WftXMKwLPBIOq0o7p6
 vi2F2X3G86qXTslinYu7GPH+oclHl/43XJqerDIgyz5ZZzLOtzlHUGUsnRzzv3OW8ate
 qQ2oX/5Jm9k4RNHZ4RnijRV7X/WgZQ5u/WxBC5e3aEb/YINc4idzHWpgoBEnZUpezZ1f
 Oc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857693; x=1751462493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9zZ5v4Vpa7CEYpwxAITHXRuPqXdh/9/ctvBxOwqT1vo=;
 b=LfxrVrKzz4pxyZHf+AcS68QTCqka+ovikKjrEfZ6XqOgsONeIuPbnhArxzGzhwB5by
 /WL/EcDsOw7Z1KcCoCggkTonKhZyXlO6iPa7WPeAHhLeCgfRTd8Q5FndnGVoA+f86fFW
 /l3OdjnKFNUyJrhfTaXjaq8rPMWy6T0ca11FS+35CqIUQCcTiAgy0Myj9As2kcUA6OSo
 jD6FHe6ORTlg2Mg7NokxYksS1p7Yjnqy814nUNSpKk+Eg0hilBXFdQBfraJftWK53JYA
 XbmIUIjZJhSIGpLT+kBQ82B6vGOb8VEr1ZMzS6vSQlcr3lXsl8PNcoVAO3L0EIiOg3Zg
 FZ6Q==
X-Gm-Message-State: AOJu0YwNO4/D7ZS7hqzoMb+4s/W30hHqRTZHPhvJG7FALhwPxQFBwVXY
 V3ewh5o177voKEJnafgpoH6BacPZBZz9tfTNzYMTOG6WGZeMaXsGST0NBdptwBZgD0ovQK9Avr2
 opFzRvcw=
X-Gm-Gg: ASbGnct1GJg6GDQK0rHfWss+dXJpm1hGvFht+jq8dkOybkBUOD20zk4MMMN7YqpENbp
 DJKm70iblMgu/fyNAq/qtjb5Zs5Nf15iX7dgaEyiz4dx9276PLJfa4jk5MQhDTAKu3XVesg7FhB
 ZBP+BShj5CMm/6wn1Q1flEzwUP5hDLLEawllKaa6VruE6ui8k3VQRpINAeiYywese61oyOeWcY5
 5uDjdqoRhcXecE9fwG8I4+fEC+J44CJi5XUbrrH77QKgaT1uKzu/uAMolMYCyFyXP1PLjulihq9
 JtcaUMEj7wgb8FDQZfP6xki8AxdNAcCpHaJ43yBaPVCjSRU5i8optcMII20uBI8OZY0QupQ=
X-Google-Smtp-Source: AGHT+IGlcaAc9jFo+EoZdUfyZveZHy6SmU+KJd6hbByXIl2X46i+Gk/+l1oRg3BZCwrh1iBHq5KrzQ==
X-Received: by 2002:a05:6000:4406:b0:3a5:1c70:5677 with SMTP id
 ffacd0b85a97d-3a6ed61a962mr1727011f8f.7.1750857692454; 
 Wed, 25 Jun 2025 06:21:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 06/13] lwip: dns: do not return CMD_RET_FAILURE on
 successful resolution
Date: Wed, 25 Jun 2025 15:19:14 +0200
Message-ID: <20250625132108.3292932-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

The DNS loop checks for a non-zero IP address after DNS resolution, but
the address is in fact never copied into the context. Fix that.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/lwip/dns.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 13da52b59b9..4689ecce513 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -38,6 +38,8 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 		return;
 	}
 
+	dns_cb_arg->host_ipaddr.addr = ipaddr->addr;
+
 	if (dns_cb_arg->var)
 		env_set(dns_cb_arg->var, ipstr);
 
-- 
2.43.0

