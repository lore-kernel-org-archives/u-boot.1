Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D953CCD13DE
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 16:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00D0A88AAC;
	Sat, 31 Aug 2024 18:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X3tyiUD5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C1788D7E; Sat, 31 Aug 2024 18:48:56 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B068C87DC7
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 18:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bb8c6e250so20294435e9.1
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725122934; x=1725727734; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7nLmjWeLEaBF+e+cuznp9+YYS4lcM/XEDjUSdmuqLEg=;
 b=X3tyiUD5N0HysnmbobdMrKpVIFoWRq7SoWLylCPc7us1GeY4v4tT5gsGSnB0Nq988i
 DJF6w0z3n9sU47VUUZSS2oiCgB8lWqNH3eivcGR41tlpU3QUsCLBgCKwIRCvesV4GfLz
 cdp8WWiaso5WwOffpMzSZIAbKcYI9aoF+MFZzX1h5ejWjEowwkzvdSzBMa//Z+VvhzZT
 jLb50kQv6D6RpwaY6ydj1Gk33SPaXOxjjX+/UglcVJ2K3macU2bXABZ3aEb8t8IcZM2Z
 yabIgKmasIKJxGgzw1aphdH7ysgwxSHhffrPWOv+VpAmJZv1K3xZkXH2di70Li6O/2n9
 VC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725122934; x=1725727734;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nLmjWeLEaBF+e+cuznp9+YYS4lcM/XEDjUSdmuqLEg=;
 b=g67mrW5DKp8Hx5yI8X5m+AcBig/RmyRVNaGmFeak8/WeN0RUELqh6EsIJriyR2F/qV
 vXYNri4ql6EvSCUxNJxB+gZnpPPGyRjFQYWVVtSdm3g1jrByOTkrCDOpzHPrunFHCg0i
 ySW03vKzmaJvmWk3yPuX0HCVI1CErQG/opGuy/AT2qHOvl8A3y69Khee5hlv7SaV2AqG
 93+a9vaHpRvkzb8HhseKreNN4AvxL8z/QLAWXFZoyf7p5NMGLlJReOiNMGFdIGgxjmSR
 3h7CS63Ki5PLBHG+oSUviMfuZ64IPTF3V6IqJqGSN44A400N1cDpw3FS961JQH3LbQbh
 Kf3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoKmLb1eoj4qpXRfHv6MLfdjAE0LXnCHLF6RpvCrEJvI3bkG65hl5rZ6/+wsa4QwN5FKkatHc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/Wnqp+sQ6HhTGCruh931Fm54Ml1/tAwFsLN43A1z62wKO/Yqe
 PIh0AM2IqOefPuszHdumBMPsxDVYL9vOf6WZmSqQPo32dnTM1CGIRhzno32JmiP3ANhNCWJoNkW
 blRw=
X-Google-Smtp-Source: AGHT+IECGPPEtw18GOQ/OF6kSwz8IX/npSVDUdz+Um6Kxy0G5MvqAzu9sYuCG48W3s6VEJPEORtUqw==
X-Received: by 2002:a05:600c:3145:b0:426:6667:bbbe with SMTP id
 5b1f17b1804b1-42bb0257a2fmr74067855e9.9.1725122933821; 
 Sat, 31 Aug 2024 09:48:53 -0700 (PDT)
Received: from [172.18.168.79] (ip-185-104-138-67.ptr.icomera.net.
 [185.104.138.67]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba6425a77sm116699105e9.45.2024.08.31.09.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Aug 2024 09:48:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/4] Qualcomm smartphone support
Date: Sat, 31 Aug 2024 17:48:50 +0100
Message-Id: <20240831-qcom-phones-v1-0-08614edd8e35@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJJ02YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC2ND3cLk/Fzdgoz8vNRi3WRzC8sUQ5OUVDNTcyWgjoKi1LTMCrBp0bG
 1tQBr8C6mXQAAAA==
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=R5HUaYQi4k3Zu/3SIQTH27iH38wpZ8WBU2lGn0Wwqb4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm00lzBZFV6ZnjmjimC1Cs4hcotLmIOGt4Llrlf
 DANjpTm30+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtNJcwAKCRAFgzErGV9k
 thZtD/wKal+IuPAklMRwuUOWI7xzdOlg+9brd8UpFrg1HwClKNlL9g8IGrMhMI+RkB9aMcRY8H3
 FQSzJN0BR6xP7Lmw1cFxjYO5/8cBhn8KgD31fJH0X7yliiQTvNYvvJ0JDUoUTUziMxWsHQ/wYdw
 Hw1vnrnrgrvJyr4WlQ3J4lM2kMxflBy/oTftp/P9eNBO3b0Plzpk1XKC8BmKHwKF7k6lKWSFFHW
 Onn6cf+LI5pSlhj+zvk2JUAvtirgqJTVK0hgKWN46MUfR0viLn8HQ4CIZ9jSKeVC2vqyeSk8WoU
 GSxp+/jUllVfbGsuGlUJ99apDSAQxbgzX/NMfymt8b4TRJmvcKH/fmWc8E/HgAirQ0uihNp1/vL
 /rY7eQq0aLRfN4IwQuM/tmmfyFUyFEtFpPviX6BRy1gIRAUxrD7xYObKSkJHb8RsmiaiQRPAldW
 zqWe8MNlwyebebGXLyvYMjlW2avJswl6/sZ0B69co6CQOy6kiR8hFYTax+4h+QuyIcQ2CENpeYq
 Zu7cvJEAmIsXAE5+YZYqAymI+etcv9rTTuMvrtQXBC3ywmHimSrUQtkrQkmUkq3SjxtRBJo948K
 Yum8xozts10NmsnNfYBTqqDH9ZXLXDEAgj8N9xWrnd+NUBL0FLki+GW1XA935+Jiv9vhvXR2x3J
 Bxo0j0JqYcbBo/Q==
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

Improve support for running U-Boot on Qualcomm smartphones, with:

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
base-commit: f0ec3e608902ca1f573e5b7017da6bc804483f55

// Caleb (they/them)

