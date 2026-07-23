Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DCCC531CB
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1A3640A3A;
	Thu, 23 Jul 2026 13:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EPgqcU4J-0dh; Thu, 23 Jul 2026 13:23:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C890D40A28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812988;
	bh=zYoZyYPVc3nihESnqRQPo/1W5LbfbR2xoRI/aCNwlP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s4EtcNkqpwxRrFq7T8WRLQrCC6qjj5PLV81Gz+f9SnXgo1b4/Jk6x7kWbKKkiDzBj
	 2Z+Hf2GBvpzZ7sWHes3QqbxiFb2/CJhLHUZ7+n6bfaRMbSud2pL6yPmJXXzga4TCxj
	 pOWrC3Y4+PdxhCwtL+miF9iILyHI6lbnj3g+CpB8IsDq0TeLSpfgwLwiYN+JwFGIVu
	 6PqiEic8ceYEsS5pDXaRfxtToSqTrG+axkZfpl/NUmlxv8phAq1KtjAnV85i3RTS+d
	 TGf+0F8iV0ABncCD81W1a6XN4Z9aatYyTbGQlK3uyWMtlilCv/U7y2EJL/nXzFHUOi
	 o5nOLauxN2U9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C890D40A28;
	Thu, 23 Jul 2026 13:23:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0841696C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E29196082B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pb2FwraAafNv for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:31:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=william.bright@imd-tec.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B0181608B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B0181608B8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B0181608B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:31:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C34483E76; Thu, 23 Jul 2026 12:31:08 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F2458494B
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 12:31:05 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-472326ca506so333193f8f.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 03:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784802664; x=1785407464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zYoZyYPVc3nihESnqRQPo/1W5LbfbR2xoRI/aCNwlP0=;
 b=RuWrpSRC6wAcxgpN0z7NSiUnM6ZdshLpCf+T8qGGRSugjW1bSHvPndtKOxYrOgc0tx
 5eXhXIbZr8YhdakYd7Lg1Dfkpw1gL48oMJG5XJC322xUglmEhbU8blfUt4Ogqn/FZxa/
 Aeq5Rl9sO5Lxp6264VvGOPTqYzJNCS+zcw7JPWmcG+GLNjr9Z1axY360+c5e3y27OjDW
 LO2neZkPDktHOC6S+qOJPxuNIdr+14dbCv7nVeSTHoOtL6OcrmkCL2Wsu8e0Awc5W7EH
 owFbG/fWXYDdzblHgV2nbM1Yvayk4nXOA4Wz3uFkZsfUh8WQAmZYK07Lmmkw4gQ6us9c
 hI8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7H1m8YEjPLw8bhpeqs2R4vdl+CQg+X4EU79YAn6uAtkxkKAo32wOJeErm+XLWaVYicJ48YAk=@lists.denx.de
X-Gm-Message-State: AOJu0YwtzrzyFKn3/pc5/ch26IKqgk8yZ9Z1+JFRkDkPRt8b0AKOcu1E
 91cK2dW1WqeaokWGhsvsajapDmChJHI6+gB/zWxmzmNrVPjorxErdwWApjnE7bnaNhQ=
X-Gm-Gg: AR+sD13Mhib+5xuZNPshBHG+roRfnb0Ox0QcHNBR9KT1n/pvg4x9rd+vwDFn3l/M7JE
 AGq/6D6NBYoZqbCnB26XwXpuW/sjoxm5wRegd0o8MlEp+yMbrgIUsGfq4qY5KxaI2zBMCd7gryN
 itZmc5c6/YvL+cgEy550M33PWAUaJcgQwnK1xHjeXFy6fz3uc1REbLHWb2qoVcL6qetReXyEFFQ
 0d3cP1hFUYt7jPOYM/OPOqTr4v8yYpIEY4rWTmrPmV1Id70jlcFnrLVdP1PIEXhAFX2iAaIlJQk
 qIHb+SSmPzDeScZNbEFPf/cOobxPRs/FYVnY4qRLwoj4I4303t9/LBuEDBu9SenfIGlRs2DVHv6
 aBmMEWbZ/OK5yPAplgpcndL8yfiFs51EyZpHnh8xPE4xwjn+n6j0ggF8Odpe4gGyjLpNiXZ7FDZ
 z/0C4xDLOyGJryM4OoLQhSr9Yn/zCVHDQuWtF9RixsVlja2cSSkBiQ3UcLopqPPAu9Fjqy2vRQ0
 c+H9gkfHqzb/qbiEcxd4u8hYC5kClFjMPKRAHHZGZNqNQvBzXbmcw==
X-Received: by 2002:a05:6000:4013:b0:47f:2de3:b351 with SMTP id
 ffacd0b85a97d-47f8d729e3fmr3389012f8f.26.1784802664460; 
 Thu, 23 Jul 2026 03:31:04 -0700 (PDT)
Received: from [127.0.1.1] (host86-157-235-39.range86-157.btcentralplus.com.
 [86.157.235.39]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm13439289f8f.16.2026.07.23.03.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:31:04 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Thu, 23 Jul 2026 11:30:52 +0100
Subject: [PATCH v2 2/2] configs: add sm8550_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sm8550-hdk-v2-2-78f0ce2adb3c@imd-tec.com>
References: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
In-Reply-To: <20260723-sm8550-hdk-v2-0-78f0ce2adb3c@imd-tec.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1784802664; x=1785407464; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYoZyYPVc3nihESnqRQPo/1W5LbfbR2xoRI/aCNwlP0=;
 b=b5f+rQBjy5YqiNEOphGQO++3sZVxJAA2ZaH3Vjgkc8L6ry2EpZ1YMFO0zNT8IoU3OV
 TsEQEKqVnEY/jql0YzTGDRbEVzFxHVGhHlzkjqaYGMoCKedByyZZz31YcZXirZORHoZ9
 jHHm5tPcSWJ2v8//8gcyx2J8dB2C+jokXPd7JXG7fMeqfE0J7uHQ2sWvuEbgd/jJZnJw
 QsSBsoPU02/dp/xcOifUY/QTQgGBtD7oEJN55zherLVVnCweRvSnn4/qFsaOqr6/4lX/
 f7av/dfPXvHAi3WSZxzkFSo7/9KGW8nTNR3I4F8ryT28bW/JFLJzuPvbwj7TTK1sMrhD
 gkJA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=imd-tec.com header.i=@imd-tec.com
 header.a=rsa-sha256 header.s=google header.b=b5f+rQBj
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=william.bright@imd-tec.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="b5f+rQBj"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Introduce a defconfig for SM8550 based boards.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 configs/qcom_sm8550_defconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
new file mode 100644
index 00000000000..5d2fe13df68
--- /dev/null
+++ b/configs/qcom_sm8550_defconfig
@@ -0,0 +1,20 @@
+# Configuration for building U-Boot to be flashed
+# to the uefi partition of SM8550 dev boards with
+# the "Linux Embedded" partition layout (which have
+# a dedicated "uefi_a" partition for edk2/U-Boot)
+
+#include "qcom_defconfig"
+
+# Otherwise buildman thinks this isn't an ARM platform
+CONFIG_ARM=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa9c000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+# Address where U-Boot will be loaded
+CONFIG_TEXT_BASE=0xaf000000
+CONFIG_QCOM_GENERATE_MBN=y
+CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
+CONFIG_OF_EMBED=y

-- 
2.43.0

