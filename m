Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61F0C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:32:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B71E88418;
	Tue, 28 May 2024 10:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o/tm7f74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8042288445; Tue, 28 May 2024 10:32:03 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9242D8841D
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-354f51ac110so569404f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716885121; x=1717489921; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WjM3JlERCtWo665sqxgg6ZomFIPb21Rxi8wtDzJVGYI=;
 b=o/tm7f74zpMvHRMrH+/lMJGihY4k977tkL4Stp0Z7LuOHqNywLCmEuhEnCfncU3j/8
 5g65pJKqNAQVtLLCa3cr5aAgqCph0/TXbNIBGlZLP7OxjW1VgCWM24OMfKv9x6KUn/5y
 v3JO3/s3KP8KypynSnYC+OoJFWclTnlYvce8HIkoBX/2ppgul/GyWQINwO4JzKDOc9en
 tJdv57e3H+wNO+0eXIGL7JxjnuLfKvPeXOunwZpB5pmj10EQvR0UO3Fk5i7TwPaZ+Ivu
 9lYDz7XBNpsVdUTu9BzbyETrlroztWJbLc2vTYQto4Zl5LL6ZcxAkcIQKVeAqhZiJpdC
 Yn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716885121; x=1717489921;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WjM3JlERCtWo665sqxgg6ZomFIPb21Rxi8wtDzJVGYI=;
 b=rKrHkUoTTsvWoUorRllZb4NdMORLsYP0+ig9auD1JKH5euOg7iN2POe+3Eq0xVuSuj
 vt6sr/lfvwI99+CYrssF6ia/5ddtefQxbeRkgxovHenTsyFNW/QMTjW9XZyUEcmqPIeU
 8A/5i8Qs7HpvTN92OmN29bLa36CgcyN5b40Zj6gfJ1P0FJwlSXu/i3aU6Vwe2ZRfpp2S
 U9cAexrJfjMJY/V6TzfrG3EaSRahXcs0oNfEWfBx/bbLeNv9fwYVYQs3Vn96rt58vBt8
 rH8K1Gpui8Umx/tyM9cWOG6bNdeQN4bQKi3VmtWPw9IiR8AsP5LGR1PJeOlpGeJ1SEg1
 FaOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGiTwgoms2GZsdo+YcNyNfRNqyfuwFapPOorN58vobHGzLK7YYN+2Uzw2W4sNkIw0cElTSBkMPFJcBW3ZO8FaMSgLFRQ==
X-Gm-Message-State: AOJu0YzuKRgdjcgcfLw1dJ/RindhIPMwMyfIu9EVZvV34DnMVkj76TGJ
 HBiy2JoyfdGzbzPkyMqx8Yr3IcgYQT/RTWmtYChcMm5zGUFPXKQfP6IxazBD1eo=
X-Google-Smtp-Source: AGHT+IFOvwEjD3r90wV5H8HWkJSMBdu+uLcoUYSq0YA5NQrdDn2WPcEj+kB0gRa+VuQZ/s5ahT5Jzw==
X-Received: by 2002:adf:e681:0:b0:34c:b80a:233c with SMTP id
 ffacd0b85a97d-3552f4fd1b5mr9599297f8f.15.1716885120941; 
 Tue, 28 May 2024 01:32:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100ee7f1dsm167122035e9.7.2024.05.28.01.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 01:32:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 May 2024 10:31:53 +0200
Subject: [PATCH 1/5] pinctrl: qcom: add support for bias-pull-down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-topic-sm8x50-pinctrl-pinconf-v1-1-54d1e9ad7dfa@linaro.org>
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=817;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GfDI4Yxwh7BhOxD+nmN4/U4x9gi7NnI+ngQWnJCB5wY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmVZZ9mrQn/yi7yGaUSXnyktqbTrifppAUHaRQAOJr
 fcHdy2eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZlWWfQAKCRB33NvayMhJ0XFSD/
 9X2A05I+fCuxuqMANhND13tPh6x8z7wi1lXHwM68bDI2JBFx8PgwxIfBl5RKaseUn9uzjejI0gVI1A
 SHQFAhXOmAA0dRTjm6F6bny359W07cL4ZTZS/a7YSWL597NLgFKZCaHyZql0s4exIvDskZziUXwCLz
 798Vq8Eg63O3AAFOl/pDBpFg7QGireq0YBYg2ZCyc73J99GQ2v5lxmwLgYImzIaR7M86+YCQ0BBAIK
 OvI0D3PPNcBzWsBygAI+FaCUoqYoPJU+rx6mCgBmCOXWYKY4Twoc8x4bC0rZOBwCWmHMe13elrq8Km
 DForycIGrmNjFhT0DC+dB9sSAS2dsrlrea2xyR7xVvwIgPqe1n5ZSnz5C3LjxbE8gIyH7SzjKbn4uH
 SKOHV7uWU1dKbuSrLIdM/16Jn2Rc1h5feA+Q6AITvYvX9O9WkfjBGuMiLwwDsBTU+SZgyMmxT/NV/r
 afIXfqzEmNgcBmaEGylJ0edIKmelIeixrNx5xnLJiDOaPPhFW43fGVhJcN4SzcjNFXheZu2AHi8V33
 6taz1CkxrTRkLOOCx4eKMe0MYwhVk+04Aq6DycjJgCzg+N236XUQ6jUPDxI5GFR/S+mByGOY1WSlFy
 CU0kE5FW+o2OTekI8ELJ+OJSDewYeLm8xGZttJFyGNB8Z9TNUGKLDlnrHR/g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Add support for bias-pull-down as an alternate of bias-pull-up.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
index 3c3336e7635..4f4e9a83949 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcom.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
@@ -44,6 +44,7 @@ static const struct pinconf_param msm_conf_params[] = {
 	{ "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
 	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
 	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_UP, 1 },
 	{ "output-high", PIN_CONFIG_OUTPUT, 1, },
 	{ "output-low", PIN_CONFIG_OUTPUT, 0, },
 };

-- 
2.34.1

