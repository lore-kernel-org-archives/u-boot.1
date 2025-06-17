Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88980C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC1482E0A;
	Tue, 17 Jun 2025 12:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eKWyP7U7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E25782C87; Tue, 17 Jun 2025 12:07:57 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7333081760
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so70380485e9.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154874; x=1750759674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLRcqehQyeudcAfUgQyUPGb8hXSikCjgmrSVEgvIiSM=;
 b=eKWyP7U7ZlDRIZpKAsRpLNFnerTlteYSdCofvMLrcAJzJbJlOweO6ukb7o0agzU71a
 iitx/p0z9yTgx8SXEOrm+djtWJWGsFVWHeYvVUq6Bjkc41SgVZQDnQFtNI007bmwYLnY
 T+/1wfYVCGeInGcSYU+a9ymDo7eCspV6TwU4+l/HkhGNDutdaGZFgktTMoFMz1ntuFXd
 OvxUqAroXm/wfkdtLgECTOxKSqHKMLvghgryUr+cHvV7FH3d0rodr1+KZI60vJ82NQPz
 XpsPikhVOddF6xxO3MxWstel9pZ2I11XXBA9uBPnY6XFKxagUq1CW0XrmiK1ETbrzraC
 Bf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154874; x=1750759674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLRcqehQyeudcAfUgQyUPGb8hXSikCjgmrSVEgvIiSM=;
 b=w9xwTS1cdaAZ6b165e21zk7/3C4sFIzMS9q5+NGvRJO8/Biclw3IbtpThW2xRrzmAy
 Sol9mKkW/DROSHi4IwAlmvQ68Q4rMdb8NuvWpi5wF2rOcJh7F3FJYhgQ2LMX0rtrhFsh
 MduG1HbgeldVR92A3U2bPp+XKud2KIP4ifMck3bWqHsCMuR4iFhyVLUI5RoRVW86jR5a
 NjoTw5RQqYdZcg7MrmUWY1eSSgPqzV+hPu3Yd1l8Km91mr6ROAwPgWFfyNL/ECMFS6A7
 41uLzwY4zG6nbpkEen2gPnKTITmJ1DuZ9JjFUI7at3F6PmPJZECBMJ84lR27V/naapE9
 +e0g==
X-Gm-Message-State: AOJu0Yxl69Fs2dMgoedNfPE4eBTgHwk5zdVnp+uyYKcA1lg4hc1DxGmO
 9dxT8Ylp8hE+n+EpwFdMkXdHhFROyWHucie/+uqY0S5VHPlkrh3AttqT1GHGhVi8bouMtxEIceF
 rtFfB
X-Gm-Gg: ASbGncvmNKSkiJrGn8UECXJI8qLX6g62w8gydyrsJJFgGN2LXKyouMz3hy2hbtDEegu
 MOckPGjHn2F+JGrjnqrTG4dasNEAasd+/V6kJm80CfTtDHTSuHRIV04PD1YsnCu0RcmpyQk1l1u
 vzWnrCFA37+b7xAeeAij5KLgiTC/PGBqXONf02dZitP2FVokb+7tiiZrE2i5LvG7dmXk70wg4Cq
 qEOwZrlvU7WFRXQDGw8BRjyTemz89sa4ihBukl+WYac9C97UJ/7rrB/83lH9y0na2qeTNjTVKE3
 pxa0DnEUuu7/jRopRm/F0Zw2oYz1OB44kZRxqVAw9Ev7+6gTQ9jEeTSAUKGrJOixSITNpeOlKID
 txpbPbg==
X-Google-Smtp-Source: AGHT+IFyijex/jg2/pUunQj2RYXtLJRr7kvGgxzg//ZU0SoYJkXLFi9MkdqBXZ1M3bC+MDxeA4/Jsg==
X-Received: by 2002:a05:600c:6989:b0:442:f4a3:9338 with SMTP id
 5b1f17b1804b1-4533caf91a6mr110011995e9.21.1750154874420; 
 Tue, 17 Jun 2025 03:07:54 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:54 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH v3 13/13] configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
Date: Tue, 17 Jun 2025 12:04:03 +0200
Message-ID: <20250617100720.2544758-14-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

