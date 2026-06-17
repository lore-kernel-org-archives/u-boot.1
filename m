Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74269CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8C5848EB;
	Wed, 17 Jun 2026 09:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UsS82511";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B94838BB; Wed, 17 Jun 2026 09:49:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE369849A4
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso52081985e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682577; x=1782287377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=znjt4HvLb4pvKX6Gcw6K36cGBOgZKJqIlmHQc2lpq+E=;
 b=UsS82511rJSFhSavE0AtMlgLKqk/ygcP1VXjxZpSd+15S+AJQS4jKOihxuUi0TwxLR
 MrplpuN/hsJWV7iZcZexB33MSpLiQYrQTsGqSN5xcAYBODPF3lmb7SkYu02ymKuKTYi1
 zCyHzIhoqLRz1+Rv7jCUtXHTEpLyI03BQ2lEB9qwlElTZkWtPNxXjZvkjpUNJPU7k0PA
 uJCBy0a01HDBSN1UFb87vt2jWnBmcBuM4inOcefjixyEPyft2RwPaaZAlBprutT2ewJe
 SXs7mODIzqq7Q8Y5JTielOYMP9KFOSHjNv6pi0RiAufLlCPYd2QSWGZ3WD9obqR0iZrU
 YLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682577; x=1782287377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=znjt4HvLb4pvKX6Gcw6K36cGBOgZKJqIlmHQc2lpq+E=;
 b=J3qL13j8ysZjv8TnQSPrbIueS7C6TE8VPWVOjcEfmjka+dmWnp5YfOjaD9Gnzq8m37
 XGRNEY4VtFI6cLW7MI5Gt87Qo+STZd9wtu5FtKPYOSJI7kaFxpxlisLUvld6RPrRuWge
 P6gp+l7XaOFloXfczIZDFlkOGPKaX2w940m8dV+KVp9VDIhBG2QYYliSFs5WjfGl+OSt
 3pVOvcY/A45tRgeI6Vwe7zjQcK+1PupDZtKsrTtIB77XfS0dbH40sPnbB+e+H4EdiqrX
 7uPDhdqa49IKhDjQTuPsOY3wO6Y0WYCebZB+M6pMFfc6Jvqi8alptuSpkx7mjZ9ZvNTu
 Zw9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uMMIuRiIQNaFIFqwxM9escgVqh0yp2/7ZPHbcSll/V0W/NnM4Keprq+kGWX0s+Ga4rfpFmfI=@lists.denx.de
X-Gm-Message-State: AOJu0YyuOuW2+OfZwAI1C4qLIbdk0C5LDOyH/ABMrbCuCaLypxt6hzWF
 PizWP2daGWDKyNZAOwt/iAGHEVhUjDVr0jh3pcOoxl9yL8bBO/0I0POmGvQxw6oDacdN0iuxh9W
 omRXK9RY=
X-Gm-Gg: Acq92OEGuNm58VUlmbj2jF6d7SjMJ2WNwE0oQXLTFFwZfJeOWmMM6RYwpuZfb7vHD9J
 RYUAQkOm1RbnrLz2it8UU3P7Ys3XihUNUnB+2GxqV0IvacorVJFRmuM6QiryMlq3SdNYir9QxPk
 0lh+bATF7Oru0jr1CMpwib89s1426GhIvujPsH1i2iq5hk2ae1d17Ki3VKYzxplPEKzUdRfTLcP
 PdAykvaLLRYt0EW2xo8NBR193REMtaDSLx5jfbH5qa9iHKM6eAtvpk2+mwb7oBvsuTeRr8j8MPy
 OHlgTMfraa0Ru0USyc1qnfCrkB0tVKr3rbrtHc3eGa2TAJhdyUlQlg0NR/nVO4r5KkWIJglXR58
 n7dIyEWXJHk+CEPXl1dal6CCqUdspbnY963xjdmjXOaef9h/Zliau035p5/gcknkN9qGpfrzb0z
 GzGsdlShPH9/lc25u7zUHy3Z2vmL/p820mwaV/V+QRtD6UV3YzNneWVt08XqOxBun89bh0zm2GW
 3N5g9jkjVuSl2l/QqI2y8mgcEwGD9VNXL3CDpdYLlKutjrV/im8DcnA4LpMCAblyfzDXBxW/3IT
 ckbreHyAbVxtfgN35b0H7SKi9AR0l/oA7nkjSR5EVpOpHrGbaBfobrn94MshMpKfzY5HYyjPtny
 0XrP0HRnrPH62+37R/IpDcdrLPcQTrEXcifMEf8gOePUW3jx9H/9VlFLVpRA7mayPx42h20KZbZ
 KIz+kTrqlRgRH4IXoS7MBDPlAUCaWlqpwW1g2uZ5YoWNQ/9nKMjMsK3sDggGZKUJo/QK/rtTfMw
 2bs5oN/pgd4EpryfQ==
X-Received: by 2002:a05:600c:c08a:b0:490:bbc1:d508 with SMTP id
 5b1f17b1804b1-492333a16f7mr35283435e9.1.1781682577236; 
 Wed, 17 Jun 2026 00:49:37 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:36 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v7 6/7] configs: Enable RELOC_ADDR_TOP on arm64 QEMU
Date: Wed, 17 Jun 2026 10:48:24 +0300
Message-ID: <20260617074846.84362-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

Since we added an option for relocating U-Boot to the last memory bank,
enable it for QEMU to get some coverage

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5bdbd6fb59a4..ae6dd770f3e3 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -14,6 +14,7 @@ CONFIG_ARMV8_CRYPTO=y
 CONFIG_ENV_ADDR=0x4000000
 CONFIG_PCI=y
 CONFIG_DEBUG_UART=y
+CONFIG_RELOC_ADDR_TOP=y
 CONFIG_EFI_HTTP_BOOT=y
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
-- 
2.43.0

