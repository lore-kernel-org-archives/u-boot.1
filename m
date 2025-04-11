Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25C1C369AE
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E951B8416E;
	Fri, 11 Apr 2025 17:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cfW281KU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C712884148; Fri, 11 Apr 2025 17:03:49 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AFA8415D
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39d83782ef6so2023923f8f.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383827; x=1744988627; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5kpOlHnovRDvFVWgYIlqSGWad/OVxsVIYQ8LnXuhMJI=;
 b=cfW281KUZXbhxXGKWOKnHOxKV1hqQ9UIeE6MCFq5rx0/k+E6NWsDKNzxRRvbJBKxJY
 +fY0QoHxBFHoT53moBASa1TEONKO6nhqO3IR12RjewvEdcoIARCrxQ+25YPs1EGO4ndQ
 l46ZR7OSijVVUyfoHCFEu/zybsElx3qqUBUKZEQHTPvF19tF3EQkkb38TuFpY31HXIGB
 XUFPGifEo0rmiPn/wdJ67Ob99fNalOwZQ3VlkJV/N3jk2pMa2Zz6vensqrKr7ZUy8kmX
 ZqfXL9+fmeLZFhNW0kn1Bx+GytSGEwQ6t+vX64a9cHTVC31po+D/5a4ajBlAiSvM9Dfq
 sWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383827; x=1744988627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5kpOlHnovRDvFVWgYIlqSGWad/OVxsVIYQ8LnXuhMJI=;
 b=PAEmRxbmWsqZH6gy3QOQbnPWDNXgTNZ31V2+cxU/cWB5DSUKjqc6AI9+FWjuBhefTy
 6T2Y5w53O8DgKuo2oLQ7RNTWIjrRPjC89DbYVWurun6zYfsUoY21fhu+PkfvpzGHnbXt
 xnMmAlwSfaJOblXlYlfGJt3gnvMCBbIiEqdcYv1g84PA6A1Sq1mb1WSZZs3KWWLpavyw
 KSO7G7IlPUhTk7TfwJHw8LHOf3doq6ZUHwQ5ijU+P6svcqS8QndWTlLqMUWZ5R0zqO9Y
 4fGTlK3tj09MaxaQBtjoE/e8jCAiNPHUPQ6a5sl0xSg5u/5KZlv2ggpPg3DzgFuiptZz
 i9HA==
X-Gm-Message-State: AOJu0YzGeXz6XmAC5wKnsDzsbsoMUnC6UCyrpht+F4vDS33IPp/IgLjM
 /vBuuBOO8fy4GmlXaTfCgNY3uHWu208bJcdLHA93b/1jomRx5GNvePoRkJ6dyY55YDuCTn0FrHq
 FuH8=
X-Gm-Gg: ASbGncvdCb2srVt4PDx99hQkKwq9C8YrhYT4m3KJ8RySSYAWgAyqo4QZk/j0KakhGR1
 l07czcMAmgyU6PBkNyvc6a1l0gOiZobbUmh7bUhvLnyDMnsSEfRMD6ZXW3HgjiQTD/3VOqLPVOi
 gbuD+HavtKSTchDGOnXpXEl8lDl7ZIYZqOfoHbXqXBZ/e55yrl/M7d1jY9jP+MLXAuUnZKBSZBy
 9j6OtUX+qchW3ziVvT0KBGBK81vrFwh/wYoD1pr90XPUR6VMNpL2XyUeIZRIpAbJWr9N/jh9fMJ
 FHKqjQByjdzgokSfwelrfNYQqv81wbOXs+gZE1PuBExmgk4Qz+ip0qkATqE0mW4WESt4pQcA3bD
 bZ666Zyq8tGNRfywOgw==
X-Google-Smtp-Source: AGHT+IFgzkUwKyW2UEQfjEK68emfJDL3qlpraHcL7NdJpnyoovjNIBkI28UrZuXPYaCM3rSZGw9sOQ==
X-Received: by 2002:a05:6000:1e42:b0:39c:30d8:32a4 with SMTP id
 ffacd0b85a97d-39d8f4dd007mr5280839f8f.26.1744383826346; 
 Fri, 11 Apr 2025 08:03:46 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445270sm2201005f8f.81.2025.04.11.08.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:03:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 17:03:37 +0200
Subject: [PATCH v2 4/4] qcom_defconfig: enable capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-b4-qcom-capsule-update-improvements-v2-4-27f6b2fcc4a9@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
In-Reply-To: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=8ZsO0tnpKp/bzY43lbuvzaH22MWYYKMdoIEhD0J9800=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+S9K8FWiKHvMZwTNoq6ODtDYsn2ud8Yg7qDFz
 V+qrd7uhcCJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kvSgAKCRAFgzErGV9k
 tjcCD/9upTV19lr31/JlTAbJPJdvvx3SmLLj6MMw+8kbUe5CCEsKCGD62bDlh8D/ygC4ShM9D41
 oTifKef2ptc5J8PHZ4lWVZKVk2dpKb0kjfjqHGkhRHlHBLj/PPhWtZqJ7FphdvifhKzKogz6T8I
 KHmBp+z9A5pL7epp91TFzamq3wdsBbetRfdjtdOxWS+T9Feh78Hbq7+//DjqZfgA4UZteottwQE
 wWrREhkyU8gvEtzMlXnNJnGwyDDURgvGbGFVB0Tj++OIvDO+QpzJC2Zn0s/U6h+kDGTGxpKISmK
 vkmi6CtnpoAtmowvfEZWoVBsDG02C+7pzh0xPIfnxg4VPAe970iMfRv0rvV9oGnO/fjJ0d/WYqC
 8oDU9WhwLLTJ6NSlWDtQrKNYS7o1j4S6UBbQ12ooqkEnhib9yvma5/n/Tdei25QAo1pzxo1xPoU
 5LhhvL0+Y3FzpEP7YjhrjK/4hV9kjf/5Sm6QClL1MqN7sDo75oRGn+i/drn+0N8XgB+3G3D/fJb
 AcaC9qE1UfgLUu6MLLB10oZQh9Mmm6hrfu8G5g/Uy7RQ7DpME2CgHFf5dpoSn6JvGaixW5fNH52
 qSJ30ZeVh2EXsSbAPWUoBcIE1bIriHBHeq2ShYQvckn3t7+TChneEgBLMHlJ1DLxzKFnTYnhTxt
 bDEVMhZTYYkJ6rw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

We can now correctly identify which partition U-Boot is flashed to
between uefi, xbl, and boot (including A/B support) so enable capsule
update support for all boards.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcm6490_defconfig | 6 ------
 configs/qcom_defconfig    | 3 +++
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index ba26924da161b1c4b5378955185f314b05cb1006..5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -18,10 +18,4 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
-
-# Enable capsule updates
-CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
-CONFIG_EFI_CAPSULE_ON_DISK=y
-CONFIG_EFI_IGNORE_OSINDICATIONS=y
-CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 537806450dc4a61d3c617cdd2b0cfb8eab1c343c..36e2f45d22aeec6d8c4d904d22bfc466ca1f5b0d 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -5,8 +5,11 @@ CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTSTD_FULL=y

-- 
2.49.0

