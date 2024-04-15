Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB26C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 095D4881FB;
	Mon, 15 Apr 2024 14:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NQ3cdrTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B8488232; Mon, 15 Apr 2024 14:44:34 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBD9A881E7
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418798199a2so2266755e9.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713185072; x=1713789872; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v2T1+yxwrxbZKohIbYVTsHTvTuVdlNpmt2mjIfUUcys=;
 b=NQ3cdrTYpBtQ+LbXAoJ+0cnVI3LlpYKaFaShsPhl081mMDEuqM95dn9BdmaWFTb3+A
 VHLU//BkaMO+SXSyURVQ7zr3iPFoy0NzPiALKizdYDU8Lz5puYnLHrtY2mmn9bk6igs/
 PSAZsD+biGlaWMItQ6ztlh5ZMsN/o1ecpwKM6n1gDG6Vv8WGr76tsB1TTx3Dng1vuy4F
 kfiFANzj1xxRG9A2PXPrDxUFEj5e/dQgXXgftP6jok1P4/Rs7ikp7aQzedxZm2iATYaw
 ZL1A7+nBPGj+7k2SOYU6f3FVnGA2HQ2zmIS+XllmD0JQZK3YvRtk+r/99BKDgKcfSmu0
 RBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713185072; x=1713789872;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2T1+yxwrxbZKohIbYVTsHTvTuVdlNpmt2mjIfUUcys=;
 b=RdJUTeHHAAWmlPGapAT/E/fuWaLETEIc/Bf55jVxb9HnhbQ5dmPCau9D4eG5HcBEy6
 +pM8PmHoIChM+voJvo/bm3Ct7JWc0Kb0QMFRTpV8bdpR4ibBBX920vWG9aXglXKh0ve5
 d/o6u/u0JTI5Y8lxQ+C7xNQWwcHK3/PZsvdw44V1OkNkfoK5rdmLs+Yv4abfz0O3XiQ9
 6vSrhK1okEWsTMKlN1j9m/tUyWXjzTVb7dvaEkMHlHiRJohte6HQsdW0mOLHFoUmXHrw
 GVe6JpcbwIkWXYZAouqurG3jKHz35FgcYcnMlnGXBGOGZFhspSEypMpweTAWMgviPtSB
 VyrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVycHUnREVDDVCmjH0b6h39Qiu4q3aEiOT6XKbrBCbvlusyiQ1xLPRjwx4sII8C7IFplKKMiBeMCXaQU2tn+S4zdtiUZA==
X-Gm-Message-State: AOJu0YxUynKOV1dW69u901DVSU9K0+FVsOe99VdFWxyUtW39WBa5ffPR
 mCQsmF53NASSZm3O+r2AxeJoK7+L4rOLzzcmIQVvtKAFax27YledZqWKn1t38xg=
X-Google-Smtp-Source: AGHT+IGf6p71pXvWLsVGbkvvy0o5UDYAIK4OjdhqSnpKzxWRhDOAICdPVoTKn2DesC6AjaSG33ACmA==
X-Received: by 2002:a5d:544c:0:b0:346:d2c0:767d with SMTP id
 w12-20020a5d544c000000b00346d2c0767dmr6077984wrv.34.1713185071927; 
 Mon, 15 Apr 2024 05:44:31 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a5d488d000000b00347321735a6sm7931517wrq.66.2024.04.15.05.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 05:44:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] qcom: serial_msm: calculate UARTDM_CSR automatically
Date: Mon, 15 Apr 2024 13:44:19 +0100
Message-Id: <20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACMhHWYC/x3MywqAIBBA0V+JWTegor1+JVpoTTXQC5UIon/PW
 t7FuTcE8kwBmuwGTycH3rcUMs+gn+02EfKQGpRQWmhp0Glcw4ofsws6jt5GwrJwpjZSKFNWkOz
 haeTr/7bd87yRTOCNZwAAAA==
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Pa4tfKvOR7b90zOF66gGxQC8pzyBM4Ez+75AQJEJWt4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZRb3pyivcfHZ8CBVXn3BsV5C4gY1j8olzB6cxijTd0
 do8/0F1RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhIlhHDP7UIDfO1eQ96Wh4p
 s09dMX3adHbnvbnmP31+zXg/o1s/7AHDf0cFp1PrNqxW0594OqufZ2+s4fY9PnKJS+a+euptyrl
 C8wAA
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

The msm serial UART controller has a bit clock divider register which
much be programmed based on the UART clock. This changes per soc and
currently is expected to be specified in DT or otherwise selected per
board.

This series fixes the apq8016 and ipq4019 clock drivers to return the
programmed UART clock rate in clk_set_rate(), it then uses this clock
rate and the hardcoded baud rate supported by this driver to calculate
the correct value for the UARTDM_CSR register.

---
Caleb Connolly (3):
      clk/qcom: apq8016: return valid rate when setting UART clock
      clk/qcom: ipq4019: return valid rate when setting UART clock
      serial: msm: calculate bit clock divider

 doc/device-tree-bindings/serial/msm-serial.txt | 10 ---
 drivers/clk/qcom/clock-apq8016.c               |  4 +-
 drivers/clk/qcom/clock-ipq4019.c               |  2 +-
 drivers/serial/serial_msm.c                    | 87 +++++++++++++++++++++-----
 4 files changed, 73 insertions(+), 30 deletions(-)
---
base-commit: 42f6978987336cff3d98d9cc4643c54a1eb0f36d

// Caleb (they/them)

