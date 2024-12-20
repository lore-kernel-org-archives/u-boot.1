Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46041E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70EF08034E;
	Fri, 20 Dec 2024 01:34:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X5tANr/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2721080328; Fri, 20 Dec 2024 01:34:57 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0E080328
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a9caa3726fso4981155ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734654893; x=1735259693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pJcLLnJr6WWgJ9zEVWizcHAnT8xRXFI2hFy8KsSpCOU=;
 b=X5tANr/RO7LJC9nPYZfLexenFlFdu7/WOciEMt8sJ1HNaknMmnWng1ARD/Vj3zt+d9
 PRIUIy/x8QucH2GqSNonb0jYxW3O2DniJ49iPnmwR/LPC9t3jr3b3hmz6RgvO/M8N1dN
 YWuItnkaTvBnvQLEw2pWdlO5NoINy16NAGrZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654893; x=1735259693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJcLLnJr6WWgJ9zEVWizcHAnT8xRXFI2hFy8KsSpCOU=;
 b=oCjq5sylANljUjhRHbmQamvcgr7Pbhdln4+OLJuBtqQnBbDc9oyr5lgPu27YGmtdAx
 ekkM68QuCzfbBRtcu5dfKVK2ik5kGpahqwPtLIGauMHZ/3J+XyalO8oXbDvGpxqTzyJe
 9i9lfZxXGMW5ZKKhNm/Bx46OImmIOGcpkKaigPZkYObOYILdpWNFNvFQe1sqMlC4aNIe
 xA5f7eIoPyltPlvZ4QGklJQmzMTCi7yoviAOlnmvs+yYhpesU1xnGUpK/v767RheSdwQ
 uP8scE/stxcV+A3K9Qqea1hCKbUWzNOI/Rk8iG349bsZZeB4RiMUpaeDWayEKtkmDceI
 KG0A==
X-Gm-Message-State: AOJu0YxdbDkqhfyk3E05PhmlRvGHm1L4GyET0Z7YTtLHk7CAKzptEYPa
 xcr+vg7mgnCACFIQ/YLKwMoovf0kw36z5vXCDa4B6LwLKQeBGVWO01bPUowTxpc0K65OsBu1xKU
 =
X-Gm-Gg: ASbGnctDMRLLkx6RPrRa7eloLnrExQK+dZZ6zo7y85CkZIX/nhEydbCW3T1vKQ3QJwU
 i9Tp2faipgjGwZaUmqZD1VyiTaouejPUse0yB5sjcLkK4MVebPbfPwFrSA1XCczP6KLKHpCW7Vq
 XocXMOmSIcKucdDzYvar4QnaRduOUIyK+OaI+yPTyGo33NRa1X44gCd0v7DZ1mz4uPRJqlsDXdb
 rbaS7tPRub7BN9Sv66xGIgt46r3RNGw6O72vIGysWwWV5TLPC4kWnPtcsUp7pbH9XHCxykpfGor
 re3lk7kwXXwZnQqBGA==
X-Google-Smtp-Source: AGHT+IF2zYK2vRe2xwpBtOY6qVYaYNc2kIFXPLoCeCcNMSN/zN7cCkrcniWZOCIOiNS1zR7EDNKuKQ==
X-Received: by 2002:a92:cc8c:0:b0:3a9:cdc1:f8a0 with SMTP id
 e9e14a558f8ab-3c02f9e9979mr38490265ab.8.1734654892781; 
 Thu, 19 Dec 2024 16:34:52 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c20bc69sm548273173.141.2024.12.19.16.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:34:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/5] rpi: Tidy up booting
Date: Thu, 19 Dec 2024 17:34:42 -0700
Message-Id: <20241220003447.2913443-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
ramdisk, by expanding the available space.

It also tidies up some strange behaviour with the provided FDT, where a
separate pointer is maintained to it, even though U-Boot has copied it
and placed it in its own space. This avoids strange bugs where it
accidentally gets overwritten when loading a file into memory.

The patch to expand the devicetree was dropped, meaning that people
should be careful to unset fdt_addr in the environment.

In version 2, it incorporates some changes to fdt_addr, etc. suggested
by Tom, as well as adding myself as a maintainer.

Changes in v4:
- Expand the comment on set_fdt_addr()
- Update the commit message to talk in terms of my testing

Changes in v3:
- Add to the existing comment block
- Update the comment block with the new values, including compression

Changes in v2:
- Add new patch to make myself an rpi maintainer
- Add new patch to set bootm_size
- Add new patch to drop fdt_high and initrd_high
- Drop patch to allow expanding the devicetree during relocation

Simon Glass (5):
  rpi: Add myself to the list of maintainers
  rpi: Set bootm_size to 512MB
  rpi: Drop fdt_high and initrd_high
  rpi: Update environment to support booti and large initrd
  rpi: Use the U-Boot control FDT for fdt_addr

 MAINTAINERS                   |  1 +
 board/raspberrypi/rpi/rpi.c   | 20 +++++++++----------
 board/raspberrypi/rpi/rpi.env | 37 +++++++++++++++++++----------------
 3 files changed, 31 insertions(+), 27 deletions(-)

-- 
2.34.1

