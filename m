Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEAEC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 16:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0D180AE5;
	Mon, 10 Feb 2025 17:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FlboLrlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2FB80AE6; Mon, 10 Feb 2025 17:30:43 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB21080548
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 17:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dc33931d3so1947322f8f.1
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739205041; x=1739809841; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mqBK/Hj1Ee8Rxe2yWDEYZYfmtMZlnJ7QYR6fyMdDlGM=;
 b=FlboLrlSOUV9r52/IDXI2JO+PQZtFWcE4cFNBemCT++NmvxzrSjrw5O9i6nZKRdoR8
 ggFK6gFBsLJQ7jmaBi/XXYB2nred0WnNUNSu+keTkOn7tkcV51FfZOMhx7dQjxTSxPYk
 CQoEiO9CYURojBCLzKeBGR4hMwDjHyj5qXpCc/D1tvIwO/L8p/BXn2zlG26zBSaM5oKK
 FlDvRJgl3vqaAKsHrX2avRbdpHCuVp/fBUOsjQCR3lsGQLgpvRTDRFYiQ2mWsWKDRx69
 lOh/Y0V59+uxev9XQJVSqk8TdBAcFz5PGjg+ndC9xi75fNd0HWyppD8c5a4lqs3iqbb4
 cwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739205041; x=1739809841;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mqBK/Hj1Ee8Rxe2yWDEYZYfmtMZlnJ7QYR6fyMdDlGM=;
 b=by07pUWeBW3eqdNAYiwPOamgM5j3sruL7C0H2+QOI3r6hfOupSmR8XxzlhJ8FwBcho
 bs41C4x/U0LOq8Iz2cqu9OL6HUjY12Uy3wTKATwW/yCQeKLElBdCkL+6xz8b3CGpc3PX
 kCx27cimSIhqO9D/5PQEc4CuhyYYM9gSWtOSfYHsPP20oUDLxhVNHnz9sYHGWMxVkWrq
 pXxxGOI6OpZk0styOwJBZGQlASBtdf5Pwm60JgaLrjxRoc51zYsjmdjjI3USqdxHalZm
 7OKC5UFlpf/z8A/UsSdyuMIqO2zZiEnzGGYGaMYjw/8Co3WTiBuCO/pM+aLAvDeQhq4c
 Q+sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQyV+YB3aJ8kjLuuDUQxG7lC+RGK76jqIVLuHfEDl3xGbqo3IAmCOStxu+MbjgzSTGka8NWg=@lists.denx.de
X-Gm-Message-State: AOJu0YyR2SLzaGg5msX/2uYYJCOP1gC94CIyd35ry+m5CTEY8sWgKJre
 SPCug+2dhjgGwgo1XLcyRHmCyJJPVqM/w9TyNvnOYAzoIQS+mJU7ljCwyrXrOjP/YvFFhbcIWvD
 iuMw=
X-Gm-Gg: ASbGncuuyowJRuoncBYm84J1QYLaJjQLkzOyiPi+XowRQT4JII7IVaiYgfbi9nBtizz
 IxVRMBfDvtqXSSSfpZFbz5HkLUFyJXH3MiHfoMUHP+46EoKJBKSX/txTqPrpkPBU36D/MH1X1OU
 KcRwfwHzdMd3MCUQTrFSMCyeAGrLqhqBbp44EJe6iYQn/EI6FMG3qHhdUiPPdffjD3LscCb66r+
 AEkWiRp79RSAw/W+7ZDj21pErRxpWKmcXK0/MoJPq5IuQEHrGDhE6xdZBw0c2u8/yv+ELo/TBl1
 rSD/nGFbu0lltfzpNzNSAAefUm48Aa4=
X-Google-Smtp-Source: AGHT+IFnugvibr+M/77YvNAD3vR7QBZkQZ7aJk/JrybBgBTo8fbRYc1IUBCUO/ie2eU7wwBHkYtqnQ==
X-Received: by 2002:adf:e849:0:b0:38d:afc8:9535 with SMTP id
 ffacd0b85a97d-38dc90eeb80mr7650668f8f.30.1739205041210; 
 Mon, 10 Feb 2025 08:30:41 -0800 (PST)
Received: from toyger.powerhub ([2a0a:ef40:1d11:ab01:7693:a594:d8cc:16e9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439447ee508sm36211545e9.6.2025.02.10.08.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:30:40 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/2] Qualcomm: fix sdcard support on SM8250
Date: Mon, 10 Feb 2025 16:30:22 +0000
Message-Id: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ4pqmcC/03NTW7CMBCG4atEXncq27Fxk1XvUbHw/BgsSELtB
 FWKcncCbLp8P2meWVWVkqWqvllVkXuueRr3MB+NonMcTwKZ91ZWW6+t0YAOCnqoTLEwYKQuSvA
 hYVD7za1Iyn8v7+f47iK/y87O71ENUmt8sX3zH6XrBeq8INwdaEhGAn85n3yQ72seY5k+p3J6v
 sBYBWgahjz3TaSWCTXZYDS5zgTuWj6wFWwdY0KtvTkgWXXctgd694KT7AAAAA==
X-Change-ID: 20250210-b4-rb5-sdcard-bac9ae757fb7
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=656;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ZeG3W7Z+h/jaJZEm+WvcmrtQgC2FBRu+77IOB0TNJS8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhvRVmuu51217HD1357rlzxb+DW39ONH9vwaHtgnHKfW0Z
 bdlrbLNOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEWAwZ/ukxndIKKK8unXe5
 p26bmqcD873LlrFz+O6v/dv28eHUk94M/6w89ime0Nip/iF1WfDz3Ps/b57KjL96ZOeW+UKP/4c
 G5y4BAA==
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

Enable the missing regulators and fix pinctrl so that the sdcard works
on the RB5 board and presumably other devices.

This depends on the clk-stub patches since the MMC block itself
references the rpmh vote-clock which we intend to stub.

---
Caleb Connolly (2):
      power: regulator: add additional supported LDOs for pm8150l
      pinctrl: qcom: sm8250: fix pin count

 drivers/pinctrl/qcom/pinctrl-sm8250.c         | 2 +-
 drivers/power/regulator/qcom-rpmh-regulator.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)
---
base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2

Caleb Connolly <caleb.connolly@linaro.org>

