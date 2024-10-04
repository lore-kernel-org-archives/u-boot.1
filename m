Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6395DCFA773
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6B6088B63;
	Fri,  4 Oct 2024 14:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SF26s3Gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A056088C44; Fri,  4 Oct 2024 14:46:58 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47DB688B0A
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37cce5b140bso1430639f8f.3
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728046016; x=1728650816; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2qN03ts4n+4G0T7mtOJ1H9gCquHYGWabLf670mbI3M0=;
 b=SF26s3GwlKhX1gLOdYfBho6nncITlNOHtnw7qmWnSimRjBa0RMxPhakY4bSrEHaDXr
 sVahVo59OZ7TebjcwHzRrV6XyXV4oT1hVAhGZJmpJxx2kVw7Rz0xUwHkIUpbM1Z+u6OK
 +wYJ05NJjvFibmFNP9A1hyfHABTw0Zxc3AjAxpVsCvgp7kL2sWwzNmkWYb26dhOpvSG8
 hrF8UhIjDMMaTlr/dKLDtxGdrBm193m237gtx3z3iQyOWDRPSOlYj6Gw1FX88mzDnVVt
 nNxVV5p+LO+vL1bzlPkMOUK3P2rZ1Wel5p+2sEpQ7yMpomw5gFPcgIFr+YGd8KQ9AxXK
 q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046016; x=1728650816;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2qN03ts4n+4G0T7mtOJ1H9gCquHYGWabLf670mbI3M0=;
 b=e471F2akqNc+qNhRuJvt6iTGozV7TGzv8fTWph1pb0AVkGbHIqbb5vgu9NDlHPavnX
 OTx2godlwLnCiS6ErgtnCfyeGS2IzGUp8vi5HQH5o8H28BQWREqyy54H5F3uMON9Nv0b
 /axr06uxcZlZHOQI5XKyUTrvgLSfx+1iUnzmjDVLVVZmS7SMMomui0jPgVSLvB99menR
 zU+dl2p5+8P2UZvV7au3Ot0XnwC1wjFHG8QJ7lRoJQ4nsKcdFFw+TXM2vW6+er1zttUp
 xhAz70rjIgJ0GlQfaK1XmR7O9I4ME7lCUyOp6iBW9/N9YxHukW5miApogDK84o2TxWCR
 XEmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5aEwif6xOVY+gmq8XZL1sPNmRdB9oudVl50gS/elXTCi4WtHMyiNiyZT7HT+ZMQG2G8zP+CM=@lists.denx.de
X-Gm-Message-State: AOJu0YxTFs8Q+54qGv6YMKSTe/k5n7wQ6ui2KvokG4H8G7H2c7KhawWV
 zXoXL+G7+pzsmdol7Ah7x0ZUKPkETnpe9mquB95b9lJrGAHqfRXe6/dvZCqHwPw=
X-Google-Smtp-Source: AGHT+IHzOXmAWaNl4H4ZvlosS8iNwh5TiX/D30zoVRQ80ICX3XCtC7eXwUZPK2VPTAlZf+CHCwEHhw==
X-Received: by 2002:a5d:69c3:0:b0:374:ba2c:3028 with SMTP id
 ffacd0b85a97d-37d0e8df955mr1665169f8f.36.1728046015579; 
 Fri, 04 Oct 2024 05:46:55 -0700 (PDT)
Received: from [192.168.2.2] ([82.195.86.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d082d116asm3177348f8f.90.2024.10.04.05.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:46:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/4] Better smartphone support (Qualcomm)
Date: Fri, 04 Oct 2024 14:46:49 +0200
Message-Id: <20241004-qcom-phones-v2-0-c7ab67ac3043@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALnj/2YC/23MQQ7CIBCF4as0sxYDlLboynuYLhoYyyTKVDBE0
 /TuYtcu/5e8b4WMiTDDuVkhYaFMHGvoQwMuTHFGQb42aKmNtK0ST8cPsQSOmIUb7Mkr47HvBqi
 PJeGN3rt2HWsHyi9Onx0v6rf+d4oSUkjbK4PeW2y7y53ilPjIaYZx27YvNM2v7acAAAA=
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2304;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=cFJj5D6FXZachDdXCwMv92hWCttlCSKsKsH4nlnvY1k=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm/+O8V0KqDV5g30Q9VhaXKM+tIPx2MGabQ6RiD
 OdxXM7/RI+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZv/jvAAKCRAFgzErGV9k
 ti7LD/9x7TiN0XJ9NgXrq3IwLlI8WJTAG8UiPJlbveNsY17spS7+Lcatg8kWDXN1dtDDkRLWuMw
 QeOG5+SaMfy+qaSokShU0DrkTFzcXC82K40Rx9eJZdtt4AaPwdL3EI3jWRtlx+BgzJ2YrqZlEfn
 rgrnAl9CuBfkmfXF+Dvgy2IAHvU/GHOf9cIsIK2GoeP/OWCPN0pUrY2uV8CcPjfVxikltQgF6V5
 7l4EIg2Kp+a5tpBkfVrDVJsVbGWLnn4JjPtYqjOKDL9KKjdCxsbgOrZlc3SETOJNLrJFpxJMoU5
 1nGJy6wlKy1EIAj7dtF3lQ3ajwSshp/ZsFLeEOknjX9L1ZKyfEryw5vj7VvXhEpvCJ668uLp9Mh
 2ytPIA+L87yOEUJbwSeePlZgMBmWens927jmq4/e8YMIEvS/irnsJSbWmwuItb753xrliswNYWy
 v5jCMJfyAx6//Lb2w2gkqaNkEn63pYIlx1UHh0iCll1yWWL96zsNILbgoqPnkNYQSup7OhIuQWs
 JHMsGu95OPqLSjd5y+pI3VqlZu9M+4bs5r63lsqH5IuiHcDi7N4qItcFL20UBYkFFstZtz71dhB
 oEOajJ4oogJXrIureTBG7D12WHgJOPy2SSTZXdpELEl+vOMDnWbF6lI0j5KEbbK8wjD40hKE3XY
 WRb152g9Sk3l3rg==
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

Improve support for running U-Boot on [Qualcomm] smartphones, with:

* A boot menu which can be entered by holding power during boot
* Hang on panic (so errors can be read on the display)
* Serial gadget which can be enabled by holding volume down or via
  boot menu

In its current form, U-Boot's boot menu is perfectly adequate, however
once an option is picked U-Boot will just drop to the CLI again.

On a phone (with no keyboard), dropping to the CLI effectively makes the
device unusable until manually rebooted, since there is no way to run
any commands...

To rectify this, let's revive CONFIG_BOOT_RETRY for the
hush parser and make it run the contents of "bootcmd", as well as
re-reading the value of the bootretry environment variable. In tandem,
this provides for a flexible menu system which we can enter and exit.
See qcom-phone.env in patch 1 for more details.

Finally, provide some rough-ish documentation to describe how Qualcomm
phone support works and outline some debugging steps for when UART and
the framebuffer are unavailable.

This series depends on CONFIG_REMAP_PHONE_KEYS [1] to enable navigating the
boot menu when using upstream DT.

[1]: https://lore.kernel.org/u-boot/20240714194948.1271135-1-caleb.connolly@linaro.org/

---
Changes in v2:
- Fix CONFIG_BUTTON_REMAP_PHONE_KEYS name in qcom-phone.config
- Add Tom and Simon to CC
- Link to v1: https://lore.kernel.org/r/20240831-qcom-phones-v1-0-08614edd8e35@linaro.org

---
Caleb Connolly (4):
      board/qualcomm: introduce phone config
      cli_hush: run bootmenu on retry
      bootretry: check for bootretry variable changes
      doc: board/qualcomm: describe phone support and bringup

 board/qualcomm/qcom-phone.config |  12 ++++
 board/qualcomm/qcom-phone.env    |  49 ++++++++++++++++
 boot/bootretry.c                 |   2 +
 common/cli_hush.c                |   2 +-
 common/cli_hush_upstream.c       |   2 +-
 doc/board/qualcomm/board.rst     |   5 ++
 doc/board/qualcomm/index.rst     |   1 +
 doc/board/qualcomm/phones.rst    | 122 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 193 insertions(+), 2 deletions(-)
---
change-id: 20240831-qcom-phones-c789d14de657
base-commit: 00292c6b39b3f7dcb34e8c3ae6ef276ac862a146

// Caleb (they/them)

