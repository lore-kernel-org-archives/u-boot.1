Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A885C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 15:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6A882F30;
	Wed, 21 May 2025 17:15:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cAWrxbJ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82F8D82F84; Wed, 21 May 2025 17:15:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611ED82F40
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 17:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so75655685e9.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747840553; x=1748445353; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jMIvtD9k5poERnlo7FwHqHul/XfuSUbcYixvi5dD2uQ=;
 b=cAWrxbJ1YpfvOhnEA7BzbLFQMNupmV9FCtmM6hO4uDW0AahO2UYVFaMog8+18lTwQp
 /I3S+l6DxS/7wnKQospdvlL7pZWdpnFFe/n9OaAp8276o8UD1tLY2kzUAXpBbEKhlvAj
 Tonq9Z+Bx3bC33SorvAFHU1RAYKIVdoRNYdwnpS8UpGRV7AonkP2nHcEl8hODfw1GD+b
 U8n01tmVnWuYMDH04JsqE+nHcklf9lvozMBoOqJgnD8cJCvGolTlkoiqawJx/X+CC93N
 xGHXKZmRXkmH8MAw7SiTA8imgB/leQe9S3CWyqIE4O41d/sAno9+j1mPOCEi0zANeLhv
 twKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747840553; x=1748445353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jMIvtD9k5poERnlo7FwHqHul/XfuSUbcYixvi5dD2uQ=;
 b=mfqTbHy4Z7LGEq14q/ShpBnYOtHxIqlWp7lb+oKhlHY2fORK5rX+ZosItwTGOjtKXT
 vIFaUR55bZxxFLbUdbYzWrA3m70mRXAh/YsLP5KffHr6N4WapL/mmOx2M44SjV75KTWe
 CrcAFdfxpBOcJgq5qD4lSZgXHGChJe/gJGXsZbkaKZoShuVS5YgBpJZITlSaSzYxILm1
 VzvqLzY3GFtDthM207tu6g42mAIZ7sdPcqOWo+O0NQrjl/P/fjwlBuZk1u28C108PGUJ
 VcvWWLc3LB4ChWuIuwM7O6S+Ips2aPZkQe1Y35CNrnOnneV3hAkPVhTLgWP/9Fn5Cwn9
 7m2A==
X-Gm-Message-State: AOJu0YwDxGUpgsAD0wqv1YfTn+8/0dMkVEvZb979Pv1KYJ09QLSGo+MB
 Vf/THIdfkiCCcEfHPk+VPWp1Hd+NG/9nefFEPA2/VQWqPu2XmU9iNWe1rsKUQa++1AEajMFDpU1
 jvf8HXy8=
X-Gm-Gg: ASbGnctwsNQHHXFNXYRe7pL0FUsSRPXjuuanNwweXyPgTcHXJzWzoLyaVi526rYpuvr
 JU5glgSOmBn6FG+wEorwVwy+kwf5nXpARmlQwB1ldzP+HL6kSJIq7cW2yr4zM/jEZtr9G83nPRF
 vQPxCbB+18h0szunrApfW5TcdmWw5lCQJHDzCgWaU8pHWoAbxCrpDak6blSujfXYRGgQhUMM8fp
 qH5V/VBHTgs7wtF99mZNLqoE4k7UCoAzEEtU6+ianWyFJIPGnzNWrgtq8VcxNqpbyLbkj03z+yp
 6vR1MvUlGME9IBEy1y3kZDrO8YXMyhafYDtRhOLgHNe7AtY3F13l10X1NKlJ
X-Google-Smtp-Source: AGHT+IHWWk7Jkt16nvFfUe8nW4O/Klk0nU29BKYof7sOxvBvF1OPSwoa+vVVmLg/Ly7BdQZmIb9sIg==
X-Received: by 2002:a05:6000:250c:b0:3a3:7042:3ee4 with SMTP id
 ffacd0b85a97d-3a370424026mr10947326f8f.35.1747840552660; 
 Wed, 21 May 2025 08:15:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f65b:56f4:360e:9fce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a3632a2bffsm18505226f8f.32.2025.05.21.08.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 08:15:52 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 3/3] configs: qemu_arm64_lwip_defconfig: enable CMD_SNTP
Date: Wed, 21 May 2025 17:14:43 +0200
Message-ID: <20250521151516.16729-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521151516.16729-1-jerome.forissier@linaro.org>
References: <20250521151516.16729-1-jerome.forissier@linaro.org>
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

