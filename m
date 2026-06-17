Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C396CD98ED
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 07:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C57B6848D8;
	Wed, 17 Jun 2026 09:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zWFh3GFC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 934BC8499D; Wed, 17 Jun 2026 09:49:32 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C86484949
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 09:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so52985345e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781682570; x=1782287370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfSoFhbhzIHLd6RIhusR0izwABmozL/TqeSumqb9iQ8=;
 b=zWFh3GFCAvd0W7LJpZBBzuC5kxF4tK4pjf5/Z1POCe0tG72vVxU+zrMXkj5WOAiln4
 tex40LCYK+erqUJjKzRy9LHNtXEoBcGu/CXbME9KLy2XnmThtwTkRP8eggw+bTWkuqDK
 bPbh3ecRE0lPqrv2oMNuZIrUB9WqTPC9rB9AKXHgi/R+XAz2vuKTDrrLLJZ/lEwfVRWd
 456Alp2xeo49fdgUyjs582Kgzsza79PvrLu+MchtQtKS3q+yWofJDITHmPkToUiDn5OC
 bNOUZebD9VGetIYV67Iha5gFoOTMD28BMq6Jg61JZuuGTZwCxJnvHLH5VH1QeAeIVuXD
 P7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781682570; x=1782287370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DfSoFhbhzIHLd6RIhusR0izwABmozL/TqeSumqb9iQ8=;
 b=I0FKY21Ld4j/qWWLC1UEZkcyuIVR2b/vaj9UCOKXLDMq1GDSbreKXFm7EEG+qbcj1z
 fm0grGJ4V4rW9BlNzALq5H20NDPAhyYX+saIbG272lAk+Jyb3vIEt2Dhd36ncKj2KRhU
 fnRWpGeffeUfbS0HKLrw8p5/4SDqv6BHTTqxCWewuo3qgrfSh8SpQHaiTxtYKHuSvZbN
 sHb/xR8FAVWiAyAomPBtxz8W6bBAkzAdmWJwL8U72jqABLwjD7871aqfL/0zJ7JBsLvY
 ffvIa0Q5joEM91uaYeGdbqFC06hYrk45O7U7tlE4eSscluMJRc0OSzVsCn9/DBRWvjXx
 HzXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GfmpW/Obkohq0WmeQZpfRcvQVBDDtjvjH7LOgEFa1BdBKHFNJXM+dyVUs+S26MYGAk3LDa1w=@lists.denx.de
X-Gm-Message-State: AOJu0YxI3rQXvrrDjLFye1oJGKpZtAryysOlHZK//Bqry8++kQyBezro
 7wrGrybt/DnzT0yL24NtJPIpB06yMtiUiGxeDN/5V1i08e0mN74BcGz1snuPepmnOtux8QzdicI
 Fv5obtHA=
X-Gm-Gg: Acq92OEi456p/YZ9g/zKuhPfeCNAkeyw0CEtz/WLdCL47QpHQVmy4y3Xib5VNW7xTAg
 tX3/EXyqscuutKX/18Zk6l6Wl8l4KrSMKkyQaEIB0AB5Qbvt32xeIkoQdDdHfbNq4KffL6nYl/u
 D42EyBVUvm7j5DP4QyMOtzTgpgCh8eMNTasNpblISnjdwezR1dCtz9ud7ztEu9Nnlrwcay52IFh
 J/7M4fIj9IGm/iEHxtNdVhBr/k6Xf3stz7s/wJUZeZpEVOlqxU3S1Lgt7OsprcmnLHnCiZj4HFr
 Bhdw4pIJPVtTFiyZVwtxdVRqctxBUb5YsBBFTTmoA8690Z2QiH32AZqWlR+WKsSM+n7Wn+8U4tl
 2C4NiFhcCpRrz5U+BlhWB2s7qeO1VYlSl416wM3hDSIugyhYqx3n/AtImo46RhwkTxjTxk5O48K
 0GDGq7ZW0f3mTIA0qHQR4z/o1yJ2caGCLB1ef9dQeGy/hmkoAnsA66Q5V9KS/JP9X4vHaQp4Ztx
 Wt1cgVP98wyu5BU5IgznA1I2lb/ZCCR8A7p2/W1u2Tbn8pTvp1JF+9ZK5HrgC8tetTzYhagOxZI
 2wDGe3zPCJpw9VAnkY/U9S5XlHCeh8KIHd4iZVenL7cEHLrK8sPVzG9cMEPgyzGYHjvIrOg4SVD
 zZaOgNdkYu2t8uNvFZehFouj2R47xEUYJwCkUGfe6z8YQcWH6TuNAM84P7WB2U7ATgOA05XDkU0
 YQEu+774jAeDQ2n2dL8QKY/Tf89+GA/mvXfk/lX23Mize9ExKKza1e/nZ61le+klZn8/Me2Yerq
 RptBvWlh9jaMPSf/A==
X-Received: by 2002:a05:600c:80c5:b0:490:be44:32ea with SMTP id
 5b1f17b1804b1-492333a192fmr37252135e9.7.1781682570142; 
 Wed, 17 Jun 2026 00:49:30 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm132512615e9.4.2026.06.17.00.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 00:49:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v7 4/7] rpi: Add a local get_effective_memsize()
Date: Wed, 17 Jun 2026 10:48:22 +0300
Message-ID: <20260617074846.84362-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
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

We are about to change the place we call dram_init_banksize().
The goal is to have all the information we need to pick a proper
relocation address in gd->dram[].

However, the RPI boards, and specifically the tested rpi4, seems
to hang if we relocate anywhere above the address returned from
bcm2835_mbox_call_prop().
So store that address and return it on get_effective_memsize()
which is used to calculate ram_top.

Reviewed-by: Simon Glass <sjg@chromium.org>
Tested-by: Simon Glass <sjg@chromium.org>   # rpi, rpi4
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/raspberrypi/rpi/rpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 885c660a289b..1da5df92351c 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -39,6 +39,8 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 unsigned long __section(".data") fw_dtb_pointer;
 
+static phys_addr_t discovered_ram_size;
+
 /* TODO(sjg@chromium.org): Move these to the msg.c file */
 struct msg_get_arm_mem {
 	struct bcm2835_mbox_hdr hdr;
@@ -335,10 +337,16 @@ int dram_init(void)
 	 * the u-boot's memory setup.
 	 */
 	gd->ram_size &= ~MMU_SECTION_SIZE;
+	discovered_ram_size = gd->ram_size;
 
 	return 0;
 }
 
+phys_size_t get_effective_memsize(void)
+{
+	return discovered_ram_size;
+}
+
 #ifdef CONFIG_OF_BOARD
 int dram_init_banksize(void)
 {
-- 
2.43.0

