Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93712C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 15:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E74C787B1A;
	Mon, 15 Apr 2024 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ngKvZ+Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0C887B35; Mon, 15 Apr 2024 17:03:46 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729AF8780A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 17:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4181f9b4270so10775835e9.3
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713193421; x=1713798221; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AR9c09AdGgZ7rZzZBY4QMTmIRdordhdbnxp8CarwFHU=;
 b=ngKvZ+Fz9qoMcJMQdaXyVl5Xl8UnP25lBX9GX8Ku/cPAc2KRRj7aQovII4nhktdSA0
 XyY4zO7gQROra55T6bKQZF3hCvYfrQ7X8uhAgHlurG/J10TqelPPCNIeWnbZBLXRlG0u
 mRbU/5OB4bmwysczPWcTa/3lnrXSFTYDDsFHwgKlQKvhpiEemgU2d5fFI4vumevdvyDj
 K6GnkROWRdWeIyWzsVdxIm1BE9Nfk7wSUQGOTB+ZPjnqGkFtOSNNh6n4iprTF6gmrpzu
 pGSmPSBh1sTVJDaUUgAbyDRk4WXzWidopU3N9ujhta5xF5nNvAD68FmP1ALAj/dzKtzL
 FKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713193421; x=1713798221;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AR9c09AdGgZ7rZzZBY4QMTmIRdordhdbnxp8CarwFHU=;
 b=M8qnyrcgvKNy597Abs4q3vjYDG3Vt5W0LwgY0gqVNS2Zjq151OO6Fd0xR5Dcy+nIeL
 Cf+GpUEmmTF/qKLj7uUzF0enT2Guxetv3xXmtZA5cexRyd3iAJlOWnioOoVBlg/R2RtD
 10RUhioUvjDiAX+u2y/f+34ohOSYX1zzswbzvDGikymJLBdPtkuOztrtniCR27seLEfP
 cbcpGzOj1WzXAK6/2rY30KCTN45rkeFlnPtmV1MByFLEY8JGaMu6hFr0xGRkS6+0WbK2
 8DkSH376nmeAHnrQksO6HfjatxHQRlg37rnWPJ5Zck/rleoUEW3r5VLZ7Uuil4Ma7u1T
 P8tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyMlre+Y5tV9jh4kqg9i8diNsxSlZwQvG6t1nb4XxaxODe0EGddf5Nq4qXW69pp59NDgchcQoY4Le+XVcRz06VRIdIDg==
X-Gm-Message-State: AOJu0Yy0KuQNcKxmmLZp6fW+KY87rAcy3ulxmXhNbTGoG2mXuLKZFCDD
 fzWPGr6QbtCtg/SbK0ewAvXyV/n2r6LIQIS3M58vnI5debnWsJXpgxtcG2ZqG2o=
X-Google-Smtp-Source: AGHT+IFfymlW+m0j/+ioLWYB1LNwQWRqv4x4l0LeIiHWfu7jZzvRckyX2ohXdscQYMaTJ+RwFJE2Yg==
X-Received: by 2002:a05:600c:1389:b0:416:6c39:5a9d with SMTP id
 u9-20020a05600c138900b004166c395a9dmr6851698wmf.39.1713193420852; 
 Mon, 15 Apr 2024 08:03:40 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b004182cd07133sm9040333wmq.3.2024.04.15.08.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 08:03:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/3] qcom: serial_msm: calculate UARTDM_CSR
 automatically
Date: Mon, 15 Apr 2024 16:03:37 +0100
Message-Id: <20240415-b4-msm-serial-bitrate-v2-0-b7a048adc6a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMlBHWYC/4WNQQqDMBBFryKz7pQkJFW76j2Ki6SOOqCmTERax
 Ls3eoEu34f3/gaJhCnBvdhAaOXEcc5gLgW8Bj/3hNxmBqOMVVY7DBanNOGh+REDL+IXwvIWXO2
 0Mq6sILtvoY4/Z/fZZB44LVG+582qj/VfcdWo0Pmq7irbtTWVj5FnL/EapYdm3/cfeLJou7sAA
 AA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Robert Marko <robert.marko@sartura.hr>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=eJLnmgtbB0r98smCsMhvCu5LhrP3X4FmPY57YOffVp4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjRZx9MG7lbaDVMrLLflq0dcmizJoyI323L34vapxc5mL
 8yN4zI7SlkYBDkYZMUUWcRPLLNsWnvZXmP7ggswc1iZQIYwcHEKwESsohn+F0iuKNldl/3t8CL/
 WZNPmLy9PPH3M9OLkveVqkoX75isoMfwP3ZHiZrTW+sHxnzqmpK3ps8xtnypfJDf2Z5//spqhd2
 HuQA=
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
Changes in v2:
- use CONFIG_VAL(DEBUG_UART_CLOCK) for debug uart clk_rate.
- Link to v1: https://lore.kernel.org/r/20240415-b4-msm-serial-bitrate-v1-0-5a89f84fd9e7@linaro.org

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

