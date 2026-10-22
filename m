Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A6606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mJF2AJxY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HuL0yq56
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99EDE60796;
	Thu, 22 Oct 2026 19:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id igx4VM-YVkDb; Thu, 22 Oct 2026 19:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8AA87606A5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695746;
	b=f+loz4Pg29uKDTmmsZ9knrrDTj8WA3av+SG6a6cVMhCJ0sNTO6NjOnxzA/IYO4kFmjnR
	 ePHnLgwedEeZt/Vuuy7M40oMIYGRFrZ+WpLb8K9wRYsYcu6869laD7XEJFmxhZXb1qLJU
	 32SWTJ2i/adlPYyBSJ1w8Z6VbJRI6YJKtDmRHvtDl3mxwcJkZJ7N0brbdnR5jzjtOziN5
	 OKMjjUYyNDkBqMZSNMmWbAPsNjtxGYUeZ4mgWFFhRejF6k/6GElo9opuXIvsQ5IkqU/g7
	 IimsqqJ6Hv/OYXFnjZrwrBbJKDRG8YZUgguH5sERYpf3zX3B1A4rfUcFpFD3kRUp82A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gQLtYlArL26TQeg0nHJrT18bVFCbYsxXqMSWQWiHJUo=;
	b=qF3jxDMDHf867amLGh5J+aVst8WXPkAsE5wQhMy5t6tlPV+NGI6GuuJcwELXvZj5J/at
	 hEATRk1ZQRHhu6F/TC7g4Bs2nrV78bdQYlsME5fknbSdrQalzqve0mI8ZiEv30cZff8rM
	 7OTcpZTLUtMrMFRaMRucFAOF8ARZ9z65ZCncnVj7MSoqs6kDH/EOdSAMB3U2Kg0HsnJzM
	 UnXYPANlpTBFLnGMuWpQgUZhXS0/Uv7sGuaq0bIcEj3ADzoYOftAlsN6z5iZ6UulYRFDD
	 5xhb++R5pCRsfWx/IPRmWvHrpuvs9PPntA2wXXvaEDLE3qmg0d0PoPeJOEdw6A6mN3w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695746;
	bh=gQLtYlArL26TQeg0nHJrT18bVFCbYsxXqMSWQWiHJUo=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mJF2AJxYehyKEl54nkEAPGpillNmSJlsadAvyeDQOqLE6wdzrpHPVbBoBo7umR472
	 UnoLrF0S/zfQeAQpX2qc3F8YPyp/CPzsOwSkQFqfW8T4h+SzabyGwhYhNaAP77SKWw
	 4lsm3XbtXHXNjOCso486Aw/tpuKpQKQhdOZQyX8vKLdFrEY49mA1bF/edhZvl9Y1Z4
	 WavjxyWj1LeBAz+PubXyZv4sfR5WSFYQzd3vX+tAUl4Yn+zNXm9fjXmsG6vfq8u7C3
	 3BZUFXGS7svDXIkl8eagpaAgnnlhLvZ9Vg9rJwiZYuwF/OnEvTUam1sVdQozMOfE5P
	 6iKtSqyZcC3Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AA87606A5;
	Thu, 22 Oct 2026 19:02:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8D193A7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F1C081069
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y37O7rtMj1gv for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 62FE4811E5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695744;
 b=do4MgVd73AqBcMdtZdyB3maOntg9uQGMCJr2+XMvzfzhxO55Tsj/K5TRINI4YS/EkUhG
 asWAtMJXtDJJKr4IDS0cOgwwCkl8TucBDCEQVqlnFzjG9Ojztc7xWQYInshSEPU+EoXru
 0dx84JRCaN4s8m6v+1/qndGeuffs6galZFk+tgdfqPvZ/9QiH648VsVPeGsL6oxe900Vf
 QN+LYspc5HTAYzifDPe7Gkue8SjcHcFVu9brRGEjD60YQTz1tliYDhJqvUYu/6dXXb7Pg
 +OCAQEABbI7+3DXM+aRwA/B5k2Kx9MaODxk+j/GcDn+0TdzX/4IoQK6HQqvpwL9cuFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695744;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=gQLtYlArL26TQeg0nHJrT18bVFCbYsxXqMSWQWiHJUo=;
 b=HEK1pXup6xAsTDDgTXUOSDpxMdnQmOSU3PpzpgKy4qfdsJ/MxAXuHVtV/hXwpITh8yoc
 2VYBL7O8+Q4/k7fj+Agg7wKrOy+QVMNfcxAPFSwbsow0YSPsqXwh41LMQ37240oTG9uix
 bdMhORQQydzfDtSgaFghojMhOUbVlukB32sJPnA2ir0JbMKaY2+Eag2MY/e06W+hKUEbl
 p1KrbicPesT4SU9INaypSUbmQ+T987C6qDNEBvqIEzVeba0M326nKM1uMdZTkfpwuXfSG
 +UwPZtzX3yhKRMG9WVMoul+ck5yz9EMWYJOAOeovrY3lejXq83wgw/uyGFn5EoEPvTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HuL0yq56; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::429"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HuL0yq56
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 62FE4811E5
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:23 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso906587f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695742; x=1793300542;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gQLtYlArL26TQeg0nHJrT18bVFCbYsxXqMSWQWiHJUo=;
 b=HuL0yq56IXDZSYVtepgAJ0lCx+32V3JMVsq2xHmJQ/O4CtDGGc5SFyl/A8CAMttHaC
 gwHBfHXzSrFXDEXA/BrEg2+bDm4e6UB1mJCmhzMO1HIT6sGI1Z7Gn7u4FP/SFoHWabzP
 m7qMIuiMsdsA9l7SlmeH26F3VY49+9CNu1Em7KKtqZqzCx+FYZ8peuH5FvNlxiPFZGo9
 pU4dsVmFw7tJCu6OgdBdFFW6Pu3Edr6aAMgB8OsPT3cYMRk3SgxFl1CNipiVfg6LFUGg
 mywYOcUSkp62FtHET4sQ+C5W2+UqE48gvTg2uGdqEFT55LmNWuGlNXL0nbxx+44PXFc2
 qxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695742; x=1793300542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gQLtYlArL26TQeg0nHJrT18bVFCbYsxXqMSWQWiHJUo=;
 b=PsEkHArAR+vKGJ6OFkqNeFFNIBUjfGioE/oOMdZeYJyV2ZUTkmTATBaRJgfC8caz7n
 N4Zg3VsHWcQULBBK98am19I9hQfNerI036eYCJr3awDGZOf3ggji2bWqdnZAvnLds3St
 NZ+KAftuKvwnljNRNJqLlCKrctcbnvMIqBltsotlhrJQ6Fv5MiGbLuuieTMbIKn3fcp0
 xTWG81wAD3kM1z6IyjL9B/wrRlZ0dag+v2mV2N56rmiUFB5pYt9PFKU0Uwq/SGiGZ8zq
 Wb4+bCYPd8j7ZABX8cxI1rPqgQcKpkWdObccoy1fPSVHYGoU3v1nKc/9TO1SUxhSnMOz
 wGLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylHhoefSiQjz/Ru7xYoJMUMjnZG+ykMZfvEgEfVSvOBbewH5oXF2cy/Q777AOV+E5rnZAa9/k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKpLkISCZLq6u0MtUnE0JtaQFAiBGlO0Q+0FTxQDAndsocIsE+I
 Px5LsqJxZcyHRRFT2/vTESbX+wasmsYCbJ93premPmf6md4WJpOFacfY
X-Gm-Gg: AYBFou1LHBUMRsppGtNaANVAPRUR4J+hboZSaaSkUb+cpF9OSvSOaoiQapZUIxniBzR
 n03ySCLvs/f9yNjtyXl9sY+GaA/RqnuBtoiRfVjt98d2H9jpCnEexpRHR87IhoCr/bIxGHcHOc/
 XaZQq9WdDf68weu4pPwW9K0SuA6kBl6PNyoCHkVJ/5pMFIoVBZMhMF4M7aWn8jWOg283NfZvKuU
 6kbROSjy9ZQ5FYSct6WV01PlZ3rWB6IDrM2o7yXa3oL0v/IQ7B/HCSwkCEQlwNOXx0Ux+vz/r2q
 OnyaDDSCsnLiSXl7ovfyBgCBSPxYphKS/ew+GZ/2GKbDc4WzPKdrYLaszb7QVaKUitgESoakW65
 u+/mzyl0J2ECyZxrT3/SDgGCK3fap0d2nym4Zo8DpTT4bVdfbG/5EJO34a6p76VFO6GHlG7Jb0L
 l8ZCqkgZyMOWxWsmOJNSikDLMsxlrVLZJGWqpACCriOc3zJMal0+hIyDEc58060l+XgiuVjRl2h
 lcl0opUCltm9BcuUj01gWJ5BY7Ep5t39EcOitGWQU7MFchok47a+njGauFwQjDYkX7adOUG1s1L
 zpLQ+yMLC/1Ba3piVkk8wdjJfb755v9Uuq4cMFHw+oXT4ke0VoIxYRyykJYN
X-Received: by 2002:a05:6000:1789:b0:48d:deb0:f1a7 with SMTP id
 ffacd0b85a97d-48e2d142777mr8139534f8f.10.1792695740718; 
 Thu, 22 Oct 2026 12:02:20 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:19 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 00/16] arm: airoha: add AN7583 SoC support
Date: Thu, 22 Oct 2026 21:01:42 +0200
Message-ID: <20261022190206.666950-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds AN7583 SoC support. It is based on u-boot patches
of Christian Marangi airoha openwrt branch

  https://github.com/Ansuel/openwrt/commits/main-airoha-6.12/

AN7583 is not included to upstream linux, but actively supported by
upstream openwrt. The patches were adapted for latest U-Boot.

Since I'm not seeing progress, I'm again taking over the series [1]
from Mikhail.

[1] https://lore.kernel.org/all/20260902085311.1550804-1-mikhail.kshevetskiy@iopsys.eu/

Changes v3:
- Rebase on top of next
- Fix MAINTAINERS spacing
- Improve commit title and description
- Don't pollute dts/upstream for clk but use dedicated header
- Update 7583.dtsi for new scuclk node (reflect new upstream proposal)
- Fix some minor checkpatch warning on reset header
- Reorganize patch for better bisectability

Changes v2: (from Mikhail)
- fixed arch/arm/mach-airoha/an7583/init.c compilation issue
- added an7583 specific helper needed for clk-airoha
- patches for proper support of clk, reset, network

Christian Marangi (13):
  dt-bindings: clock: airoha: Document support for AN7583 clock
  dt-bindings: reset: airoha: Document support for AN7583 reset
  airoha: add support for Airoha AN7583 SoC
  clk: airoha: add support for Airoha AN7583 SoC clock
  reset: airoha: Add support for Airoha AN7583 reset
  net: airoha: add support for Airoha AN7583
  ARM: dts: an7583: add Ethernet node
  ARM: dts: an7583: add MMC node
  net: airoha: add support for Airoha AN7583 PCS driver
  ARM: dts: an7583: add PCS nodes
  configs: an7583: enable PCS for Airoha AN7583
  net: Add support for Airoha AN7583 MDIO Controller
  configs: an7583: enable MDIO_AIROHA by default

Mikhail Kshevetskiy (3):
  arm: airoha: introduce AN7583 helpers to get SCU and CHIP_SCU regmaps
  configs: an7583: add mii/mdio support
  ARM: dts: an7583: add mdio child node to switch node

 arch/arm/dts/an7583-evb.dts                   |   85 +
 arch/arm/dts/an7583.dtsi                      |  526 ++++
 arch/arm/include/asm/arch-an7583              |    1 +
 arch/arm/mach-airoha/Kconfig                  |   14 +
 arch/arm/mach-airoha/Makefile                 |    1 +
 arch/arm/mach-airoha/an7583/Makefile          |    4 +
 arch/arm/mach-airoha/an7583/init.c            |   66 +
 arch/arm/mach-airoha/an7583/scu-regmap.c      |   30 +
 board/airoha/an7583/MAINTAINERS               |    5 +
 board/airoha/an7583/Makefile                  |    3 +
 board/airoha/an7583/an7583_rfb.c              |   16 +
 configs/an7583_evb_defconfig                  |   83 +
 drivers/clk/airoha/clk-airoha.c               |  159 ++
 drivers/net/Kconfig                           |    7 +
 drivers/net/Makefile                          |    1 +
 drivers/net/airoha/Kconfig                    |    8 +
 drivers/net/airoha/Makefile                   |    1 +
 drivers/net/airoha/pcs-airoha-common.c        |   27 +
 drivers/net/airoha/pcs-airoha.h               |   17 +
 drivers/net/airoha/pcs-an7583.c               | 2202 +++++++++++++++++
 drivers/net/airoha_eth.c                      |   94 +
 drivers/net/mdio-airoha.c                     |  221 ++
 drivers/reset/reset-airoha.c                  |   60 +
 include/configs/an7583.h                      |   19 +
 include/dt-bindings/clock/an7583-clk.h        |    9 +
 .../dt-bindings/reset/airoha,an7583-reset.h   |   62 +
 26 files changed, 3721 insertions(+)
 create mode 100644 arch/arm/dts/an7583-evb.dts
 create mode 100644 arch/arm/dts/an7583.dtsi
 create mode 120000 arch/arm/include/asm/arch-an7583
 create mode 100644 arch/arm/mach-airoha/an7583/Makefile
 create mode 100644 arch/arm/mach-airoha/an7583/init.c
 create mode 100644 arch/arm/mach-airoha/an7583/scu-regmap.c
 create mode 100644 board/airoha/an7583/MAINTAINERS
 create mode 100644 board/airoha/an7583/Makefile
 create mode 100644 board/airoha/an7583/an7583_rfb.c
 create mode 100644 configs/an7583_evb_defconfig
 create mode 100644 drivers/net/airoha/pcs-an7583.c
 create mode 100644 drivers/net/mdio-airoha.c
 create mode 100644 include/configs/an7583.h
 create mode 100644 include/dt-bindings/clock/an7583-clk.h
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

-- 
2.55.0

