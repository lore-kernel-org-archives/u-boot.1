Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB44C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3050282F6A;
	Wed, 25 Jun 2025 15:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P6dsEVR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D8982E50; Wed, 25 Jun 2025 15:21:52 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9AE582E26
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so44571035e9.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857700; x=1751462500; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLRcqehQyeudcAfUgQyUPGb8hXSikCjgmrSVEgvIiSM=;
 b=P6dsEVR97w+VtHuQlmWrOYXq8IaGrXptb/eUzROc/Wx0MjPmsY7IReUDYb5AUT4OsN
 lla4HOy5Yx9AgeF4n0p3//8dnY47QJf++mThsxE4mjcs753i/cb8PEMOru3HGLyxLah2
 ziQyiRRisTyxdSDb0uFw3zVU8DQ08Eknw+3bgI4nxhnrofjj0XzuAWJTGr7er947DntE
 6SklwNMBIHC7uH72P1R/DFO0IHcfRqdsYuICPsLUw+6xiLXxIMRT8vjS4jdyx677PPEb
 O64N/V5y0XPFNoAsgpsjhv/jlsw9zXBWwlWwoFB17MScwykgfRa66+7p3QXUD0+reR1e
 DC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857700; x=1751462500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLRcqehQyeudcAfUgQyUPGb8hXSikCjgmrSVEgvIiSM=;
 b=CItFlGQBYA/gxabXxnQvPmFDT5LTMiSO+iBZdSyPbzA3S9Hm3bly6mTROOlz6H0coR
 b4CcHXj8zYJUXJa+8pikvehuxfqeqLnGycmJuoH+zRTJIEjnYVaV2sI/Ro36TxCIMFBK
 xmStlba0ytCn6sa/7SYXASw/dupSugO9FczgoyB/lPrcg+0pZz/6TZmc2MUXjQ9Pz3gw
 udgmbln8ODFWQlFm622m+tO+hf2ynRLVR3N3s6/V9+Se4zO1KgwSU1hkYoCSgnWOwaHk
 kRAZSVAiYo4inWgS6NXFZ95+CddSkHx7fUyVyVls58lBcyA4U5cF0C/hERpYy/4cnOvV
 eNYw==
X-Gm-Message-State: AOJu0YwLYDbvkUVcd9dSaDZCJNTOFz+9lDCmpUHGV2R103JgiWGmD8yc
 jx946Ks+xXXPa5yYdhbchmcueOqEzTR2wjOY3mnxbS6MeC6jqzjBbGkE4ZpP6Qm1ISrtesLp6cn
 /GszxDTI=
X-Gm-Gg: ASbGncs3v8CMcyjHkJMYlFERfK/OuNrH2cl7sXzmArgtUHrN3Ys/esA2LBspIax0jy3
 0ykN4TyWuBqm71EUGehc3pe+rxoLtJIganSPuBwQwPtqV/I1mM4N+69zN/C2LAlGAAHGRSrKE+k
 xi7VYuNitt6v4dC+ROSlDRxtfg/Ua+eyTj90Ye9elOAnUl3DI5y4nGbMw9LGU/07nuM+ZeU0GUr
 9opP7ZYE64Q7rIR/QUAT7dzd8UPYiCnLrMVWt9GvbrOt/H4/sy8SMLXFN8WrDZa+5/8R6qpRltw
 2M8sObt8VaeCOggszgaeaM2P7AlWl8HHPgGjhzMelRuylU+DajExrlYkWk/QLAPwysVxanU=
X-Google-Smtp-Source: AGHT+IEV0gCSDn/N0XmeE98yupxp6KGTUeIi9WyU/zQwW7Q1FTBYEeVexymNc88KIqeG6/ug+0kQDg==
X-Received: by 2002:a05:600c:1c9a:b0:440:54ef:dfdc with SMTP id
 5b1f17b1804b1-45386747a86mr8715365e9.8.1750857699925; 
 Wed, 25 Jun 2025 06:21:39 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v4 13/13] configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
Date: Wed, 25 Jun 2025 15:19:21 +0200
Message-ID: <20250625132108.3292932-14-jerome.forissier@linaro.org>
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

Enable the sntp command by default in the arm64 QEMU defconfig for lwIP
since this config is meant to have all the features supported by lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

---

(no changes since v1)

 configs/qemu_arm64_lwip_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
index 814e98729a3..e8f976efaf7 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu_arm64_lwip_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_QEMU=y
 
 CONFIG_NET_LWIP=y
 CONFIG_CMD_DNS=y
+CONFIG_CMD_SNTP=y
 CONFIG_CMD_WGET=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_WGET_HTTPS=y
-- 
2.43.0

