Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE57CC3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 12:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2750F88743;
	Mon,  8 Jul 2024 14:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X6A0CdZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 195E188715; Mon,  8 Jul 2024 14:20:33 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2885188729
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 14:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-58c2e5e8649so7236343a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720441230; x=1721046030; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nIIvJbrAbNJRYWo+J18YgLbk7RXm9zDJv7nP2Beyq5g=;
 b=X6A0CdZoJRhCTg5A3RthKbfydGdzkBxwo3Rhxs1FptPscpaAenV5b9oX7H7hbGzcJr
 xMeqj/aeY1cZB9AwzAKpV5VK7QOF6JVPcEAjc6Kjfmdw6Z/EWqUN2y4gw+Pw7pzqLdvr
 LR16hT1VBNed9erfbxK2ejNUWa+FgpeimyitJMMpxUsoEPN8ips8XfYM5EIc3ukD74hx
 5STqidEkzlGYUv9SXLK6eNu2okNQ26tVGZ5q1TYY7PE9DEfFYLQbm5WRlPF1mC5Immig
 2KZS2CjtHGEZOiXHm03ql7r7C+Vy12HN45t2vIW8TkcIh0ljvq6NRad7Cb2E3CTnd95C
 w+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720441230; x=1721046030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIIvJbrAbNJRYWo+J18YgLbk7RXm9zDJv7nP2Beyq5g=;
 b=vBwFNtfzWOkD37+biE5TLM2QVCiOZGS96mYrYKJ/ZjhtVayvjuyGLW/k7Vofr+6uxD
 dFfVlXD0mAO4k+Ci5ADkcTbZVYLX8Yg85oEmt57A9NeXXyr2ZivEJo9L3Jdxl4B96oJ8
 VdEzT9IWFLfeuNqm9INhg4R4V70Y+DCCVrcd0BFvAykBXhSF2x+zsZNcWEe0wwVAM9mC
 vZJerRGyiewZ82pXvtxZxjiAqm385NJzL87A++7NedHrQgSy8I6qQ678OziQHClu/EPB
 UWVbN+jgQNY1aAOgSu+7ln/pe37Dfgqhz+zZ4xMeZeIrGWOrxq3FvYto7Fh1QPzPVkQ0
 CC5w==
X-Gm-Message-State: AOJu0YxhMMmtyiXz7WgWIPNUNuZtp4mOI4EuoRTePvHEupN9P+hnKN6j
 5+qEttqL42FHHbIMLII4Y600d99wRN1h8qBnz9nLcylZhv9n8Y5JpkDuxh+TWmg=
X-Google-Smtp-Source: AGHT+IE9YmU1+7bloWuT9y3sdd/C80Jqz62vInnIRvqtrxMzNHN7zOb4QvOcbc1x5B4X/djfW9EpMQ==
X-Received: by 2002:a17:907:724a:b0:a77:cac5:ba7 with SMTP id
 a640c23a62f3a-a77cac50c8bmr1012511066b.8.1720441230730; 
 Mon, 08 Jul 2024 05:20:30 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77e8a7eeafsm188364766b.47.2024.07.08.05.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 05:20:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 08 Jul 2024 14:20:26 +0200
Subject: [PATCH v3 4/5] qcom_defconfig: enable rpmh regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-b4-qcom-rpmh-v3-4-846cc6c5b728@linaro.org>
References: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
In-Reply-To: <20240708-b4-qcom-rpmh-v3-0-846cc6c5b728@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gRFw9sllDNNt4nSyWXUL+01p1obRypQjKFtWQBwneRw=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmi9mJYkZWjCHOSgViCHtcZwpgieiWDilKumW2w
 cQivHUhGv+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZovZiQAKCRAFgzErGV9k
 tml0D/9g5Tkeng2Bizw/yuBfdFsBPOdIEu9C+hPnSstIDoViVyhZ9OuuSK/JECfaTntl7iabSBQ
 udEwu/8fBA78ZA0XHnjkmx8ujtpat0eKBMNGoaogS/wchW4mH9Gvn77ndv5Sjd5/6V0dS83z7ve
 tZP4v5rO7sPlL71MZV5ywD1H9/wynzc18G/HxoYYTtRBU0tk4GTD/8+mg+A/lEiu0HbKXsM+h6F
 Hw91gMW+C7eyfSQh5oWlDGo+XIKnaCDjGTuG9uLRXO1a99jOzqP9ywykLUnIBG0PzE3EYC43pbY
 5U1VRdhwBYSNSVC7C7MWgTqA5lpuVdeMA1Mw4KudyCrWL/TuvfL9I8Ke7agf7BkpCt/HKJJruGO
 fdoYat6tSV03AuhwH3Wb0ptiLVjWzf2BuVVtqzJQKBfvfXf7RvdhxOj3VKk5be+Y1uplnlUnqn8
 XkIC37jybl2g4eEpB9emBDmXAwCrzxgIhDja7PzGRjjf4Js9EKyYabBvj5DBNxIL4tpGuk/+5kI
 wbkmvJS9GjxS3On21Cu4PovjtNxr/P40Ywi64zMXNNNmlGBJuLB/2olnPbyEep0gyARtyXnD4fo
 cpUbTVyjOvZwQKrghBpCyIIbR/KFAYZ00s0+Mn2d35i4MqeRXlD0AiaS1PGthj/9gZTVd8qWDou
 W4DS6OMRDaetuXQ==
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

Enable RPMh, cmd-db, and RPMh regulators. Additionally enable
CMD_REGULATOR for debugging.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcom_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 60a8e38cc6bb..8a55bb9af708 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -35,8 +35,9 @@ CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
 CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
@@ -90,11 +91,15 @@ CONFIG_PINCTRL_QCOM_SM8650=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_QCOM_RPMH=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
 CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_USB=y

-- 
2.45.2

