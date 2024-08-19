Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC975C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 19:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCB5388D22;
	Mon, 19 Aug 2024 21:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cz3PrPJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E435488CD7; Mon, 19 Aug 2024 21:34:24 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBAED88CD7
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 21:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so503675666b.3
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 12:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724096062; x=1724700862; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XD+YZ03htDVoBxt0ZNMdWa9ZvwJG1fmW1JSa5Tzfq0w=;
 b=Cz3PrPJ2xLYzHtN+ctmgJ2L0UfMLn8z7HA1sOEFWWMGdn8W4LIiVqnXpHZl5svSkuS
 cKnAUbHEEgHaLdyRM3UDaRIN28/dsIoWt3TxRukby7HiIMFkktVmExyRq8ZKtgQ+e0ax
 ktK7AjAeWdao7FMKvMHsa5o+/jCS431zhsrmzzZWnkAJVDu+9U9j2osq1gMmhYPWtQAB
 i74ASd5x1UJXhjKgVNEQ/Iq3M3Rau/MKqu1zR6Xq671nWK0kBN5qJuUMu8f/iBMzyEro
 /Z3UieuJ0cCVKRRQwA5Fc1pGBhuj+0RuWed9EaYm3qgRSSeZbrlCXJueKr+o71dFp7YE
 x0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724096062; x=1724700862;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XD+YZ03htDVoBxt0ZNMdWa9ZvwJG1fmW1JSa5Tzfq0w=;
 b=jLubAgZFbXDbIi6wCqdwDzAFzep+axLmrA8KlNCJxiXcf26IiG94PNYdtYCy3h9qh1
 D81UAEKYYLA+ekBb9bKRRsSbixvDR1vWMceDC+iFsXGxnukxuuY69zu+EXdlWoTQldOt
 TfjpzzOfSVYdoeGeqU+qR3tcFTDawqsDY31XnbKuTMn/HRNoKQvwL75Mizn/n8FhfdVt
 ytidW0wwH5yW4BIiq8Zxnbv3sZSpj7G6nr+8dXmI+HTyt5ra9OooZQiYfJroZ6Kv8Vka
 tmwhzlJuL2mH6LBbmO2nzxMynswkElzyD2n2FWYc0GW1QoDjLDpJHSo46AAm0D8VIPLt
 7LPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6vEiBJBjMl/M9t/cCBAKSg7PIuZ8ELa+Y14nEhZaYNyWOtIiFk1y/orsKquCLfT7sqs7sF/M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe5yfvuKI9Y+5N70K3vEotmy5oQ6B6n4oEta3LturqOriarMSG
 RfFi6TswG83724gZgy9HVhro23QBjT+Y5ds8P7veZZ2ogXP/S38nTxMDZH3X/xk=
X-Google-Smtp-Source: AGHT+IG1AwFyMb2PyoaSznDIkd/UETWbCADAFLQOLIa2f6OC1dzDk6KMp6oBf0n5gh01cj0mMhdgDg==
X-Received: by 2002:a17:907:9712:b0:a7a:c083:857b with SMTP id
 a640c23a62f3a-a8392a11c5fmr904381966b.42.1724096061874; 
 Mon, 19 Aug 2024 12:34:21 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383964976sm667783666b.188.2024.08.19.12.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 12:34:21 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/4] clk/qcom: implement clk dump callback
Date: Mon, 19 Aug 2024 21:34:16 +0200
Message-Id: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiew2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0NL3SQT3cLk/Fzd5Jxs3ZTS3ALdVCPTRANDS4s0s2QDJaC2gqLUtMw
 KsJHRsbW1AJguT8xiAAAA
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9111;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KXxZuq9P+ussJpaGzhLu9Y08ZkhUDYRBoiYE8wsFpuo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmw548dHlpXhg9A/MqQGyFS627yaRgUZ1uiWwgZ
 bLdXuCXyy2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsOePAAKCRAFgzErGV9k
 tr4+D/9wH9WNaI4z0MyhPEWn82Da9pH0SfaLE/8mtC2YTXiaaD9euBrsxZ58V1zPVV+0qIN68O9
 vOgtpU0UNPGYOQC3XGEMXRGrNRV9rxb0Mz4s+eY48l5e1nstuEh2ntogVKPRg1o6sGz6cuBPPy2
 Us8Iero78hIFn9HQFRip2K0ld8cqb/4StsblJVVz+wNrhHtTlDjjue957j8hlwWsG1HzZ+GsBjv
 N9rXucfOSk297Kp393Q/2inuWfrwxmX6ag4sq0ZzV3W1ikRz31b5cQL7/IYaM+i0RxhkDZpffsk
 s5uwMMaWIDy91rk3Jx/gR3eDnGdvsR5+pakhSGeNNxKfgs5G9MT7zb//ha2OS/80b5GPPdGXWKO
 Lubj5O4hr/RoJktKBSSNoc3JJbN/zwWSU2fIeHQUxTubRsAIn3UwoopJqL12/tjQU2YkHGOYwxU
 nUgy6h9g7Fs6ZAXHJJghwy2Q0WCJrcIfzaFnoPRe6CiTgZgHkK2xsOIz5p251DmUXTx3+Nijtwq
 bQ/6Jw8TK9ABPQ4g8Gd+ID27t2hkY7ckAumayes1qVXBCPVmBYko4B4ywdfUWJLciT15wtIoHCQ
 flrzfzVMOcCZbQewx7oWkE6nNms3Y/BlKZRC+Ier+N6RO6SGzytS7RpGN1gzdOVUmUBJ1LArvQ0
 mD7gXbfePnpVEeg==
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

Add support for dumping a few of the clocks used on Qualcomm platforms.
Naming the Global PLL's, Root Clock Generators, and gate clocks.

This helps a lot with platform bringup and feature enablement by making
it easy to sanity check that the clocks are programmed correctly.

== Usage ==

Enable CONFIG_CMD_CLK and "#define LOG_DEBUG" at the top of
qcom-<soc>.c.

If your SoC doesn't yet define the debug data for clocks, it can be
added using the Linux driver as a reference.

The "clk dump" command should print the states of all the gates, GPLLs
and RCGs for your SoC.

== Glossary ==

RCG: Root Clock Generator
* Takes in some fairly arbitrary high freq clock (configurable clock
source and options for taking just even pulses and other things)
* Output frequency = input_freq * (m/n) * (1/d) where m/n are arbitrary
8 or 16-bit values (depending on the RCG), and d is a number (with
support for .5 offsets).

GPLL: Global Phase Locked Loop
* Crystal as input
* integer multiplier + exponent part (2^-40)

Gate: Simple on/off clock
* Put between RCGs and the peripherals they power
* Required to allow for correct power sequencing

If you do the maths manually using the equations from "clk dump", the
numbers should roughly line up by they're likely to be out by a handful
of MHz. They output is formatted so that it can be pasted directly into
the python interpreter.

== Example output ==

=> clk dump
 Rate               Usecnt      Name
------------------------------------------
 38400000             0        |-- xo-board
 32764                0        |-- sleep-clk

qcom_clk qcom_clk:
Gate Clocks:
GCC_AGGRE_USB3_SEC_AXI_CLK      : 
GCC_CFG_NOC_USB3_SEC_AXI_CLK    : 
GCC_QUPV3_WRAP0_S0_CLK          : 
GCC_QUPV3_WRAP0_S1_CLK          : 
GCC_QUPV3_WRAP0_S2_CLK          : 
GCC_QUPV3_WRAP0_S3_CLK          : 
GCC_QUPV3_WRAP0_S4_CLK          : 
GCC_QUPV3_WRAP0_S5_CLK          : 
GCC_QUPV3_WRAP0_S6_CLK          : 
GCC_QUPV3_WRAP0_S7_CLK          : 
GCC_QUPV3_WRAP1_S0_CLK          : 
GCC_QUPV3_WRAP1_S1_CLK          : ON
GCC_QUPV3_WRAP1_S3_CLK          : 
GCC_QUPV3_WRAP1_S4_CLK          : 
GCC_QUPV3_WRAP1_S5_CLK          : 
GCC_QUPV3_WRAP1_S6_CLK          : 
GCC_QUPV3_WRAP1_S7_CLK          : 
GCC_QUPV3_WRAP_0_M_AHB_CLK      : 
GCC_QUPV3_WRAP_0_S_AHB_CLK      : 
GCC_QUPV3_WRAP_1_M_AHB_CLK      : ON
GCC_QUPV3_WRAP_1_S_AHB_CLK      : ON
GCC_SDCC2_AHB_CLK               : ON
GCC_SDCC2_APPS_CLK              : ON
GCC_SDCC4_AHB_CLK               : 
GCC_SDCC4_APPS_CLK              : 
GCC_UFS_CARD_AHB_CLK            : 
GCC_UFS_CARD_AXI_CLK            : 
GCC_UFS_CARD_CLKREF_CLK         : ON
GCC_UFS_CARD_ICE_CORE_CLK       : 
GCC_UFS_CARD_PHY_AUX_CLK        : 
GCC_UFS_CARD_RX_SYMBOL_0_CLK    : 
GCC_UFS_CARD_RX_SYMBOL_1_CLK    : 
GCC_UFS_CARD_TX_SYMBOL_0_CLK    : 
GCC_UFS_CARD_UNIPRO_CORE_CLK    : 
GCC_UFS_MEM_CLKREF_CLK          : ON
GCC_UFS_PHY_AHB_CLK             : ON
GCC_UFS_PHY_AXI_CLK             : ON
GCC_UFS_PHY_ICE_CORE_CLK        : ON
GCC_UFS_PHY_PHY_AUX_CLK         : ON
GCC_UFS_PHY_RX_SYMBOL_0_CLK     : ON
GCC_UFS_PHY_RX_SYMBOL_1_CLK     : ON
GCC_UFS_PHY_TX_SYMBOL_0_CLK     : ON
GCC_UFS_PHY_UNIPRO_CORE_CLK     : ON
GCC_USB30_PRIM_MASTER_CLK       : ON
GCC_USB30_PRIM_MOCK_UTMI_CLK    : ON
GCC_USB30_PRIM_SLEEP_CLK        : ON
GCC_USB30_SEC_MASTER_CLK        : 
GCC_USB30_SEC_MOCK_UTMI_CLK     : 
GCC_USB30_SEC_SLEEP_CLK         : 
GCC_USB3_PRIM_CLKREF_CLK        : ON
GCC_USB3_PRIM_PHY_AUX_CLK       : ON
GCC_USB3_PRIM_PHY_COM_AUX_CLK   : ON
GCC_USB3_PRIM_PHY_PIPE_CLK      : ON
GCC_USB3_SEC_CLKREF_CLK         : ON
GCC_USB3_SEC_PHY_AUX_CLK        : 
GCC_USB3_SEC_PHY_PIPE_CLK       : 
GCC_USB3_SEC_PHY_COM_AUX_CLK    : 
GCC_USB_PHY_CFG_AHB2PHY_CLK     : ON

GPLL clocks:
| GPLL   | LOCKED | XO_BOARD  |  PLL_L     | ALPHA          |
+--------+--------+-----------+------------+----------------+
| GPLL0  | X      |  19200000 * (0x1f      + 0x0            * 2 ** -40 )/ 1000000
| GPLL1  | X      |  19200000 * (0x37      + 0x0            * 2 ** -40 ) / 1000000
| GPLL2  |        |  19200000 * (0x14      + 0x0            * 2 ** -40 ) / 1000000
| GPLL3  |        |  19200000 * (0x30      + 0x0            * 2 ** -40 )/ 1000000
| GPLL4  | X      |  19200000 * (0x29      + 0x0            * 2 ** -40 ) / 1000000
| GPLL5  |        |  19200000 * (0x30      + 0x0            * 2 ** -40 ) / 1000000
| GPLL6  |        |  19200000 * (0x0       + 0x0            * 2 ** -40 )/ 1000000

RCGs:
| NAME                             | ON | SRC | OUT_FREQ = input_freq * (m/n) * (1/d) | [CMD REG   ] |
+----------------------------------+----+-----+---------------------------------------+--------------+
GCC_USB30_PRIM_MASTER              | X  |   1 | input_freq * (   1/    1) * (1/4.5)   | [0x00000000]
GCC_USB30_PRIM_MOCK_UTMI           | X  |   0 | input_freq * (   1/    1) * (1/1  )   | [0x00000000]
GCC_USB3_PRIM_PHY_AUX              | X  |   0 | input_freq * (   1/    1) * (1/1  )   | [0x00000000]
GCC_USB30_SEC_MASTER               |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_USB30_SEC_MOCK_UTMI            |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_USB3_SEC_PHY_AUX               |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_SDCC2_APPS                     | X  |   5 | input_freq * (   1/    1) * (1/4  )   | [0x00000000]
GCC_SDCC4_APPS                     |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_CORE_2X            | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
GCC_QUPV3_WRAP0_S0                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S1                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S2                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S3                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S4                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S5                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S6                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP0_S7                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP1_S0                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP1_S1                 | X  |   6 | input_freq * ( 384/15625) * (1/1  )   | [0x00000000]
GCC_QUPV3_WRAP1_S2                 | X  |   0 | input_freq * (   1/    1) * (1/1  )   | [0x00000000]
GCC_QUPV3_WRAP1_S3                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP1_S4                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP1_S5                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP1_S6                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_QUPV3_WRAP1_S7                 |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_PCIE_0_AUX                     |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_PCIE_1_AUX                     |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_PCIE_PHY_REFGEN                | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
GCC_UFS_CARD_AXI                   | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]
GCC_UFS_CARD_ICE_CORE              |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_UFS_CARD_UNIPRO_CORE           |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_UFS_CARD_PHY_AUX               |    |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x80000000]
GCC_UFS_PHY_AXI                    | X  |   1 | input_freq * (   1/    1) * (1/3  )   | [0x00000000]
GCC_UFS_PHY_ICE_CORE               | X  |   1 | input_freq * (   1/    1) * (1/2  )   | [0x00000000]
GCC_UFS_PHY_UNIPRO_CORE            | X  |   1 | input_freq * (   1/    1) * (1/4  )   | [0x00000000]
GCC_UFS_PHY_PHY_AUX                | X  |   0 | input_freq * (   1/    1) * (1/0.5)   | [0x00000000]

---
Caleb Connolly (4):
      clk/qcom: implement clk dump
      clk/qcom: sdm845: add dump data
      clk/qcom: sm6115: add debug data
      clk/qcom: sm8250: add debug data

 drivers/clk/qcom/clock-qcom.c   | 117 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-qcom.h   |   6 +++
 drivers/clk/qcom/clock-sdm845.c |  93 ++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clock-sm6115.c |  63 ++++++++++++++++++++++
 drivers/clk/qcom/clock-sm8250.c | 115 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 394 insertions(+)
---
change-id: 20240819-b4-qcom-clk-dump-e25a0198f6c0
base-commit: b7d5ce05b1b52136af09cf34541c6a91079a4b86

// Caleb (they/them)

