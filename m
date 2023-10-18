Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DEDCDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E935B86FB9;
	Wed, 18 Oct 2023 16:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2UtK6cd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39EB386F94; Wed, 18 Oct 2023 16:02:36 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB6386FC9
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso894062766b.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637754; x=1698242554; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n8i/wjqdC71ztvySiOjCLW5YIxJJAW1Xh2eZaF5DKIY=;
 b=A2UtK6cdJJg3G6fMexf3oodE36sw42B8xVlEMA7SJGAdgK9WIn0Uwfz0W1ArRpepLK
 u5rkGPnyrvwlR0/kZBCpO9pZeYGWZw8yXtGJO+Kn+ch+iaddUcHi+xbs3mZq9EQrpyvz
 UzyIVGE+ePe1iNWEoEHtvuYQQxuxncUBT2bJDs2tNknlppW6LEVhspah5gtmaG99zi1p
 AqmGbdawsdi4XUr5/039TtDvhA1nb0IfCm1QosLNMjYcpgENCYb2gbV/J9mzis6XqCu/
 T8zWRD2k3hhyrQLu+O4FaX8xc7uOaQs6NQeQipGz3iKWwzc0CHVzJXw8fDdRxNoymMmX
 HlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637754; x=1698242554;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n8i/wjqdC71ztvySiOjCLW5YIxJJAW1Xh2eZaF5DKIY=;
 b=TxpCKXGD80gCweqOowjr+/OKA6n5Wbv31ZCDnPQAPRqcjsEVqiUaOQQk+IIj4hHxvD
 NDxhdqjMq/aSi4hhtzG53Dv1+Mp63m3DvmUsodi3E9yZnVBdj5pGWQUpjVbvy0ZNJsGS
 diNzG0IfxxgyaBemoLC1UTpv1f1mHyDTWj3wkwnNmuBkj157WurXs0vBB53GJ1rfGj59
 Z9CqFa8yVr31AiXhyy0Er0U4uIxwsuDPlUJrjzd15p4NntmmIxYFBymnWz10cRD3G0jL
 0cnOjpaOTkSj33rR/bhavynE6/tj7drxC5WafL0/sK88GF6ec1noAgfWX7n8v/ImT3BH
 tqWg==
X-Gm-Message-State: AOJu0Yze9wZfOlXK9lGzGqkU5v9APsZ60tRsV5pVQSjLfUGhLnA6az9Y
 JUWnSXISgAeU00DEGaj7xYU=
X-Google-Smtp-Source: AGHT+IEFU7wQ08p4N3CALIbnqVDGb8MM3KDhum9XMaJUl6qgDZX/sf+Fyloya4dl0694CDwuqUQwrQ==
X-Received: by 2002:a17:907:3da2:b0:9a1:b85d:c952 with SMTP id
 he34-20020a1709073da200b009a1b85dc952mr4880553ejc.12.1697637753612; 
 Wed, 18 Oct 2023 07:02:33 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 mm27-20020a170906cc5b00b00993cc1242d4sm1736022ejb.151.2023.10.18.07.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:02:33 -0700 (PDT)
Message-ID: <94cf9627-5318-2152-51a8-a17265e0d6bb@gmail.com>
Date: Wed, 18 Oct 2023 16:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 8/8] rockchip: configs: sandbox: enable rkmtd command
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Enable rkmtd command for testing with sandbox_defconfig
and sandbox64_defconfig.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changed V3:
  New patch
---
 configs/sandbox64_defconfig | 1 +
 configs/sandbox_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 1a033b22018b..1a01f51a0b75 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -58,6 +58,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y
 CONFIG_CMD_CAT=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 01830c7bd255..cc54e6dec5af 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -84,6 +84,7 @@ CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_RKMTD=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_WRITE=y
 CONFIG_CMD_AXI=y
--
2.39.2

