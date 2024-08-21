Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864C8C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6572A88DE5;
	Wed, 21 Aug 2024 15:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yOMaz64l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E5388AFF; Wed, 21 Aug 2024 15:42:02 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E9D188C36
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso556008566b.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247719; x=1724852519; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VGpHi3k7vxgehhynkHpyKJwxi4oKfB4A2A00OXKPkFQ=;
 b=yOMaz64lma1hQ0+Gt5CgMdElox51jZtnVyBitVGl6NvVmTuRWyklxImOrmwqsD3xYC
 LGVcaLqh6/Q1W84/a/VQjQXnjBnf7rwjs1wqMs2mxBSvIXqX84EaEYJsYQK255NuFmeY
 NXA0Iw/mLc/lgHAufmAUkAE02OVXH7AAyOjuEUceM/a6s9P5xPF82ucP7uH1adqOkAZQ
 MTmKJK30kZjuhrZasD0UafyDCfMinXHhHFqlIcrhxmitRK4qDTzbktP/Atn3wfIJpVyh
 Zbfra3N7AwxLidGI4lgrZSdfJWx7xo7f78GLzrxxtf9EQNN97axpLHFCTql16lK6z8qx
 3Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247719; x=1724852519;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGpHi3k7vxgehhynkHpyKJwxi4oKfB4A2A00OXKPkFQ=;
 b=wjTgODezMYlCn5sKcCnnp1Vd0OLBd5uCD0eBpdaJdRReSR2EsRO7RyUqvKoOvz7NPc
 O7v24bEyP8vKrldHxpNvN9R6RqnobFMDUq1urWi4ObeXiFLrgH/iVa6h8fQXs239YyyD
 x2v2ZGzHy5LuWMQItcPDAfgV1NMl9e9Whd1LOS9mJBgHAuX64ve4uf3jQhpIAG52PGNG
 PqZklpeuYNZrK/gG7RZSuSUlrHkd3f3UF6b7jqC16TpwDc+4RuW5vF35uLCqnjMjHRPK
 jxAj6zbq1QxznhNSLn6wMt4SHd44YvPRET9SWyLNJ69jL8f3LA+/2vyrgQdg3UYIUTaf
 WunQ==
X-Gm-Message-State: AOJu0YyYxzvh/Kq2TnmE45KUz4jNc/HfUkc2DCE5IqW05whgtX84/Uou
 QvsSOrpkiSoyoRX00nQTJ6PEghMnyz/il1CvQOq6oIHOYo7ZMLMN86AVf2+SA9g=
X-Google-Smtp-Source: AGHT+IF2/DupIr7S3Tf/n9l6fXvTAbuD5E3nSTqZnLUH17vrwUpiB2tHgdlyQp8XysNBhZpXN+tPXA==
X-Received: by 2002:a17:907:d864:b0:a86:6cb1:4d49 with SMTP id
 a640c23a62f3a-a866f0fd56emr197816466b.13.1724247719583; 
 Wed, 21 Aug 2024 06:41:59 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:41:58 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:50 +0200
Subject: [PATCH v2 5/7] qcom_defconfig: enable SC7280 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-5-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=670;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=yS4s6QOgfiWQfzfc4REiZuaFQ3cRc+UaGAPzZhg/0tY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6dlBkL0sqAHkV82+rSk3ED8IQyQvi4gHZz1
 YfE45yCF8SJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXunQAKCRAFgzErGV9k
 trAoD/9/6KH2Cobld2UEMHFj+Lh80HJIGWdNHdhodfzYtlvCFU8pC/pmYwgBd9Opd24rU+Xh7dU
 8f+9HBKcRKgLmbuUy1fAn84B+kgl/IJtVeHpaP6LRp12NuJudZYl+woPx3mAgz9Wqv/+74nKYok
 lVr1q9hbq4ZuMItcuzU5fWoyh7iC3th7KYUhh6939F1PQ8FFeF/5+9jJpRBMpuNZPFETxhlBTwY
 YDXZL75cWg6ImurwaM4Hj1zQpHnR8V8HDa5GTTDNMxHOBFYCL+cJ3Bfd0FjqXFsL2/zjefqsewa
 0rWWQPMC8az8WvyczZAvB5JTq+M3VbP7kEWemCdedXmHiJ33dO6+jabm0ikvLooz1z7G6rlwZxZ
 P7Rgc3ewW+RHOYbVYFLRKCdFVOFtiwOcEke50gPqQr/sbz0p39olzaE+D8WdNvgjW2uBRzLJDnR
 EqyAYWncrWyAANXM3RSiICge87zZ/l4iUb8t8qm/8dYAs8KgPk6YNYVgLxtQqfVFNqnkHlmyy43
 82JCgSSVggB9phNSVn/poUjlMlaImqGWB+zHDgf968J0a7mz/uFRgVgb8cjuG/Y5oX0xhNMkfqW
 2VymGoOrNlNvBNHyYEoEWgOMRiPvB/lL7PwbM9FFXmNyMMkx6FkzFgyopVkSWvCzKZQfgwBaUev
 z00CkhnUndrSe5w==
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

Enable clocks on SC7280

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 24b71ba7be29..1a079264a554 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -44,8 +44,9 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
+CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y

-- 
2.46.0

