Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3404C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:49:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D048A409DE;
	Thu, 23 Jul 2026 14:49:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 028q5_6tvr0V; Thu, 23 Jul 2026 14:49:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1CAE409A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784818172;
	bh=7SDrRcg2/OtnYTl424cbbWNWAsd9D2TtkUHpcvwcQ44=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qkKJG/MjWf1PpzxaCfhYwJogTjM2mp2R2dZeNH2yQTSpHPmX+CZN7xheBci/KQSGk
	 2yS32x16PTUe1Gj7ot6hOA7mVn+QPlzoIO3Ebxrhi3emCsYmsli62siEo+5wqscVqp
	 vq1gKNYM37AtwNmMFWuEAU9mXK8TJtFcetiJ67MhwS/7yDej5a/s0KiM6G6NC+bua1
	 SGu7Y4u5/90xJUtOv1DgBlp7EV5bP/Uv+G2dFDt2lG5dQ/199y9YfdZJWcH9zLuYWT
	 Pp0PPIKidQhoyA5JsWBx4IUjox5vLh9ciHJSNMX9M2l4ZNUyxvhYeKgGm3hv9VLDIG
	 G7WSnBF6g7lyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1CAE409A8;
	Thu, 23 Jul 2026 14:49:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D3A2707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E8AD403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P5GpbFJe8CPC for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:49:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2a; helo=mail-vk1-xa2a.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 266A9403DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 266A9403DE
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 266A9403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:49:27 +0000 (UTC)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5c2c0e261aeso210152e0c.0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 07:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784818166; x=1785422966;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7SDrRcg2/OtnYTl424cbbWNWAsd9D2TtkUHpcvwcQ44=;
 b=rD28tsNI6+O4n5Da+PLcV4A9jQ8KvqWSLMtnc3l3uJ6BaohHb7CMXaubFpl3sjKbAA
 3IuT+Aa9eLwsOXJdzDFwRvQx89I1ebZ4sOHFDUfaCO+cZbNwKLRgSIt3GXbtLWUsMdV2
 /pAJnLbpwTYlxDPfHJiE5DBxSHEsh11c42A5y43jNYyi702GmcpqLXmSofjwmu4RGF25
 3zTrf2RqjC3jyxKF5Ngj33r/vj/PbcwZSRLQRmlaa6t6TmCti57shkI8iDXoXD0yuf1m
 iGVCyFaK8pNQoTZ317M2ftIloMIl3/XmSE0MudqQhfiW7qJ8WS8ehjDp6NEEHwMYBhEp
 eJCg==
X-Gm-Message-State: AOJu0YyFhYJiUdKmcbsDeZ3mWUlI2x/nmWlAJ/C5NELF+uPRMZsKibsn
 c7oQy9vHD+1zDDim8gct1l5plu1EPXE9/ohsAO3mjC4W+D6CSquQjUh+HmH+PUFO/wEmWR+ZzDl
 jm3BiaQA6Mw==
X-Gm-Gg: AR+sD1337Pl0BeFOFrYqmy/O5v50DMBiN+o1LLdxpBe6kdwIMP58/P29koDLsMwsWcV
 4Hd3C1CS7Er/FQw+0ZL5Vfc658cgr4m3PZGHkljiZ2pmMSL9lXXkVypw4fNALsWBTU0QBbZIb1A
 4S9sJxqzHBML5nUHinv0k1tBRKk/u94xaGW2hn9jET44MnQuyBoGbOBNILAe73dDIvCxU8J+jJO
 wgge3Xg9KNZiDMld5vXU0mwtFrxpf1G9nx5KwwqF3Y00BWanuZH1uRgW67PizqqmvxuzB/qYkdj
 BCDtd0MnC2vO7FVSwb9UX1we+/HJ2VWZ70Z9O2l+q9aXHozGtvI8P2aDUpiYPMNjYiUIqs7lOsu
 gOwW+C2tL9EbiyqMyuFffQoMhBikMX+KAsHKc1Re+x+b9rnfY+uWbcmKeiSBWj3pJJIYIOi8kf9
 7SJFhE4Gfln6z9GMwL0BfNQEz1CAsjnQmNdhv5Gefvhg==
X-Received: by 2002:a05:6123:109:b0:59e:372f:6db9 with SMTP id
 71dfb90a1353d-5c2da1f8818mr1273196e0c.12.1784818166159; 
 Thu, 23 Jul 2026 07:49:26 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:9534::a19c])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9774404089fsm4739175241.3.2026.07.23.07.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:49:25 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Subject: [PATCH v2 0/2] board: sophgo: add support for Milk-V Duo 256M
Date: Thu, 23 Jul 2026 11:44:33 -0300
Message-Id: <20260723-add-milkv-duo256m-v2-0-2e1373dbcb8d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANEoYmoC/32NQQ6CMBBFr0Jm7ZiZEkriynsYFqUtMhGoabWRE
 O5u5QAu30v++xskH8UnuFQbRJ8lSVgKqFMFdjTL3aO4wqBIaWqZ0DiHs0yPjO4dVKNnZK2Vbaw
 Z+rqBsntGP8jnaN66wqOkV4jrcZH5Z//VMiMhDa1mJqo1u2tv1kn66M82zNDt+/4F2hWeRbUAA
 AA=
X-Change-ID: 20260710-add-milkv-duo256m-1662c5cafb35
To: u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, Yao Zi <me@ziyao.cc>, 
 Andreas Schwab <schwab@suse.de>, Michal Simek <michal.simek@amd.com>, 
 Martin Herren <sputnik@on-the-web.ch>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784818166; x=1785422966;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7SDrRcg2/OtnYTl424cbbWNWAsd9D2TtkUHpcvwcQ44=;
 b=czXhqYtYrAufit8byO00FQ86wxkSozlxGfRRkkQmb7dzax0IU1ebYQ92UGRiz5S/5v
 u5SqkWmm6BXmYIRw5oBwh7KNGWzztMdxDetiMye323wGX53WF+2B35e6s19DPabMAmru
 rzTAk+37xmWfEapdCeja/80jRdxmrSgvjOw2U93jds6rQKFN3hvMlVf3WxFI5FSMT/gf
 DrEbBffyddTUykK3+w6lkNHwJ3Sw33G/1cHsDI2yhApZilItrcNN7s/pCs8l0QYgMtkT
 EfKgiDsx1UpwNh2USBgwRtsOiYLdfBOmHd0HB1NhH2L1yZLC7VbBTfMhhks8/XkiUYA9
 FCDg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=czXhqYtY
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

Milk-V Duo 256M is a small development board based on the Sophgo SG2002
SoC.

U-Boot runs as the S-mode payload on top of the vendor FSBL and OpenSBI,
packaged together into a FIP image on the SD card.

The vendor FIP tool prepends a 32-byte loader header to u-boot.bin and
loads the result at 0x80200000, so TEXT_BASE is set to 0x80200020 to
match the address the U-Boot code actually runs.

The following peripherals are supported:
- ns16550 serial console (UART0)
- SD/MMC
- Ethernet with the SoC internal PHY

This patch was tested on Milk-V Duo 256MB using an SD card and the Duo
USB & Ethernet IOB (base board) [0].

This series uses the CV1800B SYS_CPU target since SG2002 shares common
IPs with CV1800B. Other SG2002 as LicheeRV Nano does the same.

Note: Linux device tree is not yet merged [1], therefore I am adding a
device tree here and it can be later changed to use the kernel upstream
one.

[0] https://milkv.io/docs/duo/io-board/usb-ethernet-iob
[1] https://lore.kernel.org/lkml/20260710075917.159969-1-chenyou910331@gmail.com/

Link: https://milkv.io/docs/duo/getting-started/duo256m
Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
Changes in v2:
- Makefile: changed to use 'milkv_duo/board.c' instead of
  'milkv_duo_256m/board.c', since they share the exact same code.
- board.c: deleted, because of the above.
- doc: updated to add Ethernet support.
- Link to v1: https://lore.kernel.org/r/20260710-add-milkv-duo256m-v1-0-0f761100361d@baylibre.com

---
Hiago De Franco (2):
      board: sophgo: move ethernet driver to common directory
      board: sophgo: add support for Milk-V Duo 256M

 arch/riscv/Kconfig                             |  4 ++
 arch/riscv/dts/Makefile                        |  1 +
 arch/riscv/dts/sg2002-milkv-duo256m.dts        | 46 ++++++++++++++
 board/sophgo/{milkv_duo => common}/ethernet.c  |  0
 board/sophgo/{milkv_duo => common}/ethernet.h  |  0
 board/sophgo/milkv_duo/MAINTAINERS             |  1 +
 board/sophgo/milkv_duo/Makefile                |  2 +-
 board/sophgo/milkv_duo/board.c                 |  2 +-
 board/sophgo/milkv_duo_256m/Kconfig            | 30 +++++++++
 board/sophgo/milkv_duo_256m/MAINTAINERS        |  5 ++
 board/sophgo/milkv_duo_256m/Makefile           |  6 ++
 board/sophgo/milkv_duo_256m/milkv_duo_256m.env |  8 +++
 configs/milkv_duo_256m_defconfig               | 42 +++++++++++++
 doc/board/sophgo/index.rst                     |  1 +
 doc/board/sophgo/milkv_duo_256m.rst            | 84 ++++++++++++++++++++++++++
 include/configs/milkv_duo_256m.h               | 12 ++++
 16 files changed, 242 insertions(+), 2 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260710-add-milkv-duo256m-1662c5cafb35

Best regards,
-- 
Hiago De Franco <hfranco@baylibre.com>

