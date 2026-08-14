Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D6CC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 11:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58293810DD;
	Fri, 14 Aug 2026 11:21:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDUsIeAsW_QF; Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44A938104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786706485;
	bh=2IMvBTq/x4iKiflfWT74el0W1kkCKs2kfjCisPQeTOw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y7qVGlzAE7/w8wI6Hqpwp1F3rJaRvklkm8LwjdAjMt5YSxMfaJ7muhdVh7QFEdy1B
	 rBThU0Pj3Ec1wFKD4IY0zyZ6qE72sGfeGjlgdoyTpqip6fY2N19CaeUW64DwuS2KzO
	 BRw+76YxdBFYBQIjE3XtdPeI3Mub0tAbneuMaGE+UgI+0LK5KY9DK8cIJaD2XWXuDp
	 vKT7DE3sdHbJD+4wXnG0HrWlcZVRLHQN317LJ/j4YtBXRwQ6nM4fIHP1c6PmqkkypN
	 pUxov5/UH4TYlpSrKqCz7S/a51lmKwGlGpWqs2FmPf5hIVSqGQAfE6nTeOgbxhKo7e
	 xUY/Q669wj+Yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44A938104F;
	Fri, 14 Aug 2026 11:21:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1984B139C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AF5A8104F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2c0F2gRUWwFB for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 11:21:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=fra.schnyder@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CA8C080EF8
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA8C080EF8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=amIGo1Tx
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CA8C080EF8
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:21:22 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so530348f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786706481; x=1787311281;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2IMvBTq/x4iKiflfWT74el0W1kkCKs2kfjCisPQeTOw=;
 b=amIGo1TxZZK6OagS0ATqOjHVgV0xVhnvmoWZikDqsiA5pYoPocyRm16VolWVL+xWVg
 gRraDT+4DkEk15qAr59Fos3jt56ANioh29oSH1bBXCz2+y736LlzJXgVKNIxrfjvHqAj
 jclwArmxZGQ5TXD/Y+jSCYrIBXaZD/zmG1wjKIt7pU5XkNsdsQHWCor05f7qvts/yXx2
 HT7GZYzGAS/twstiNWf0RwCx+DQFwIfKi/jtSDNkRxJSZcjwROJDqFJJIKLMvU5sX+zc
 GXnICQfvtXaM4ioWOHf8VoTa6E+M5+qbe4G9L4KN1SVEZdOxAAUdzEgIzBWezK6VymYk
 BdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706481; x=1787311281;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2IMvBTq/x4iKiflfWT74el0W1kkCKs2kfjCisPQeTOw=;
 b=hCMSsz2Wk16p5HHATozXT7xnyT0qK9uBRqkt6KULQQslFrBLpjToWmwfGAJCp1cSNT
 Ed78YTCymWiIoG9dirZwDuXxly6loZbuJcsObTaBBb4QKL/dTnm6XzmgnDdpXpFlwaO9
 z4+YweU0DLvB8cLi4rsUeL3/9BoEVUSeiUZG+PwQkEYDs3uGJc9JrZPPlgs07gfyO5Ik
 s7v5kpKjelByckKDp52C4gsp8RpvjYgYnlPv4bawKg/HbBBlyeDn8BGpaIGyN+qf3IUS
 dFRV2SmQli81VumJD3OCqBACMVYwpR1jd+B17YsTHhKAsk/d++Ge3DP9birJTqtYHK3g
 /alw==
X-Gm-Message-State: AOJu0YzLOHfPsrBBy0BQ1gq6FwHp45NzkXbR/XJjY7eBWumCIMZezz1R
 ueD7SCxCeEdnQnBcl+DcPciZsAOKZvUwOnPmY15jRqI03/5IleQXifyM
X-Gm-Gg: AR+sD12k9v1SXMKKeXtgTaKn4NlKCRzOJxvAR/9EujNxSKRsr7NXhxLaTl8qfPNOGOF
 AkkcxJwecqHH7ju0nRissLL0T6kLMJ+uUmJ8NWaYueyGwklTzqhs4YHSP0JqleWWmzyOzGVkA5U
 DLbeeXBSqi0oVixbE+FN3TheIz4RL3vJhvqrfo2MtEbHZA3fV1bbZd6OTrUGwCDZrCARHfeh1fF
 8PGENGR4qhj2YCRUmirpydGtitmrtaXlz6/n3aNIAJf+rjczRv1XfSEOQywdGOjntq6Br3nRw3Z
 JVl+8ul4jTCitAtZw2iRDG7LUNknoW3hcYzwBmUuRbWNlFWl/z7VjZVQtCFBqjgZR2gQbOVb8xa
 hz77QaVUNPINvd1dF3ixQh4DuVb9afiYgr99hHjAeTt47G2EpBB82I2l1mzV5Jc30nWRmemJFDa
 EUkN58scoxSFTSOiXsXIJUslHAQHpl9uznbGer/wzOqMtVmMfwveiY8gEjq0YzGBR0hf4XLWXB3
 3LvaLsKRkEkCDUtTHkvIsr/aK4cbcknY1ELx4dIj+2qsoin+Ou8OyaO707NKaHX//cyqOwuSMD7
 6L54M/x8U8v/vFs1xtNPD7L4YI8a+lqTxchFhg==
X-Received: by 2002:a05:600c:3b1d:b0:499:79b9:e226 with SMTP id
 5b1f17b1804b1-49988057986mr54086085e9.0.1786706480446; 
 Fri, 14 Aug 2026 04:21:20 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41692355e9.14.2026.08.14.04.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:21:20 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Subject: [PATCH 0/8] toradex: Decouple from Toradex product ID table
Date: Fri, 14 Aug 2026 13:21:15 +0200
Message-Id: <20260814-get-rid-pid4-table-v1-0-b8605ac094d0@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACv6fmoC/yXMSwqDMBRG4a3IHXvBqFTrVsRBHr/2SlFJ0iKIe
 ze2w29wzkEBXhCoyw7y+EqQdUlQeUb2pZcJLC6ZyqJ8FK1SPCGyF8ebuJqjNm+wgtVV82xgxop
 SuHmMsv+m/fB3+JgZNt4nOs8LTTBNGXYAAAA=
X-Change-ID: 20260811-get-rid-pid4-table-1eca3797ebf3
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.15.2
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

The sysinfo currently uses the Toradex product ID table to print a
detailed board model string. With various new SoMs that are released by
Toradex, the PID table grows and needs maintenance effort which can be
avoided.

Rather than printing the board model based on the PID table, rely on
the model property of the device tree and the data written to the config
block during manufacturing, which already describes the HW correctly.

For example, the printed board model string will change from:
 Model: Toradex 0075 Verdin AM62 Dual 1GB WB IT V1.2A
 Serial#: 15412798
and become:
 Model: Toradex Verdin AM62 WB on Verdin Development Board
 Toradex SoM: 0075 V1.2A (00751200)
 Serial#: 15412798

This removes detailed SKU information such as the number of cores,
memory size, WB capability and temperature rating, but the PID4, PID8
and revision of the SoM are still printed. The detailed information of
the SoM can still be looked up using the printed information on the
official Toradex website.

Therefore, the 0243 Aquila iMX95 is the final entry in the Toradex 
product ID table.

The decoupling also leads to changes in the DTB selection of the Verdin
family modules, which currently uses the Toradex product ID table to 
determine whether the SoM is a WiFi or a non-WiFi module. From now on, 
the WiFi DTB is set as the default. 
This change is safe, as on non-WiFi modules this leaves the WiFi and BT
devices unprobed. Further, the SDIO/UART signals are exposed to the edge
connector on non-WiFi modules and can be used on the carrier. However,
no Toradex carrier board makes use of these interfaces on the carrier 
and it can only be achieved with a customized board. For customized
boards, it's expected to override the default selection by setting the
'fdtfile' env variable.

Link: https://www.toradex.com/computer-on-modules
Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
Franz Schnyder (8):
      toradex: verdin-am62: Set WiFI DTB as default for new PIDs
      toradex: verdin-am62p: Set WiFi DTB as default for new PIDs
      toradex: verdin-imx95: Set WiFi DTB as default for new PIDs
      toradex: verdin-imx8mp: Set WiFi DTB as default for new PIDs
      toradex: verdin-imx8mm: Set WiFi DTB as default for new PIDs
      toradex: common: Decouple board sysinfo from the product ID table
      toradex: tdx-cfg-block: Remove validation against PID table
      toradex: tdx-cfg-block: Remove product ID limitation

 board/toradex/common/tdx-cfg-block.c        | 41 ++++------------------
 board/toradex/common/tdx-cfg-block.h        |  1 -
 board/toradex/common/tdx-common.c           | 53 ++++++++++++++++++++++-------
 board/toradex/common/tdx-common.h           |  7 ++++
 board/toradex/verdin-am62/verdin-am62.c     | 11 +++---
 board/toradex/verdin-am62p/verdin-am62p.c   | 32 -----------------
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 12 +++----
 board/toradex/verdin-imx8mp/verdin-imx8mp.c | 12 +++----
 board/toradex/verdin-imx95/verdin-imx95.c   |  6 ++--
 configs/verdin-am62p_a53_defconfig          |  3 +-
 10 files changed, 73 insertions(+), 105 deletions(-)
---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260811-get-rid-pid4-table-1eca3797ebf3

Best regards,
--  
Franz Schnyder <franz.schnyder@toradex.com>

