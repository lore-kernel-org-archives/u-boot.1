Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EF0CD8C92
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 13:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7DA084942;
	Tue,  9 Jun 2026 15:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mHVgvKgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C4B84894; Tue,  9 Jun 2026 15:22:57 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C406848BC
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 15:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso46054175e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 06:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781011375; x=1781616175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfSoFhbhzIHLd6RIhusR0izwABmozL/TqeSumqb9iQ8=;
 b=mHVgvKgDhneiDIMewi/nbkQezfgBvd43In+gTlflyRNjt9BOWpjAPPmolkwV1qKsPV
 enTltvuWdipMz9L4mmPPyowcmCcruNJEkzP+kdua32DfTwNUSeyBT1TbRms9DzM//8zk
 q7RCwwAGQm4Lyh7903HINvncySL9xkgXQnfOafVeexqrnpJvBzfiAC1B9O6QsddM7Hxn
 cv4uyP/ZgPejLJvu4OSyETrzsqRNJT/+F99/TJtm4Q2QV3emQfHgKLUv8q1YVkklTPmj
 rlZztmJ0J5OwaDM9wf06jR/lJ8FJV2mdWMdm6A0JNX2YaUOgpzRHeVBecppiP1JgR/7x
 5s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011375; x=1781616175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DfSoFhbhzIHLd6RIhusR0izwABmozL/TqeSumqb9iQ8=;
 b=bRp8OEv52H+Bzzrz98rGCbGOyhOwnGCFfgakkHkY8acDwzmNyZf4R9YaAjbUdjNj9l
 RKmdY/IzDCK0onGYwVJD8VbUJft8bLUwwz0sqUomcZuexzxXAKG+eUzvE6t4GROrO0l1
 mMttaSIj2Gu9EYCFBb3OyjNXbzIoI6E0+ioge1hUYS8211VNigG8MnTAq/4ynVVZdIYj
 SIAjGKx0Bs1C/UOB9lziuKss50nsTaNKGJpuKrpBOFmhAz/HaWKWbAmQF+q4V0SBYwzT
 Ch2wCPgbciDRiCiLb70Aj25W3IDQkrTDrGTgKyX5wuPBcSEYRVfzriGL8gFKzpCEBxdS
 ZT1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xa0TLXDHetPf6ru/et+QXA58DTDx0duOG/wX+kBTDnfHBoF3CQiIdUXkP8+6swVffTBn/bi0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7srT/kr1SPEGV8JdiIqEicOJTFTZhtODzPZzpz63hgIplGoHr
 BVUfXcgm7174nVOqf+Rm1kIyT9sVnrg3djs2Gq/L4E0LpM9FcretNt8Rr4jd1BAf4us=
X-Gm-Gg: Acq92OFFxyJQn26A+RW3/5lxzqffOJP/kjoogybLy+IqfQdAFBmsts7DVVhV3ZlCcRS
 Jdan223x2/m9NZhbGi+MvPdqNzyyl6qm3gwDaqN3VIONWZCZml9FTBU2ePQwYuFm6vhge7Etqx4
 Hxk2KJPOi37TDfnlOgDdlWxopehfGMYi3221P6qmurNHT6HfydH4HqKM6cSrrHac0FIXMxU/jCq
 vuwPJIrf88w/6yXttQ4SQc3lifPdb3RqhFJKDDpiByeJk0uv2GbdfVpqdWRXxN0aWUkMb8wt4rN
 nJis6lY90umG+SbFv2oKsRHtoI9qeF8dMarETs5uqKp336Hx8AaeuLP6uIr9Xkv4AtIC7FF+Xki
 cuwH+bjlz84KneMBitjE4K9EKlM2ycXMRaNaGtRGNRtHwlmk24gGLql5lcU13IWjRMoIFFFJ97l
 UGDKQ0/VXv9HKuhACu08kCgCF6p3tFepFauiWu6T06jmwrC6eAc4CFbsE3BB4ceva2wzXh57J5h
 IRHKfgVPRteekSufIPxFE7WjUv1MxUpAihWD86IW7Bx7ABg+uU+qnkYGrrpVnvAxol55lOFP4ll
 uFFMyDqW/eUyiZnSTzS6chfD6taTPe6ChKMs5zk6a4bldYhfL++oZVGWclxB/8wjoPRbDb0vnVp
 /YrG16C6QXk0ikkp2sdXT6BP4uN4jbKVegU86I91WWFAGwwuFiQDUtBZA6mmiqDjpC3UuZC0Y9Q
 C0SAyNeWCPvQ+jxEa+R/DiVy9dx2lYSCVHf4ez9I+/Wz/nJCXwaQAOSpsZ25uibfYDrfZmr3qT7
 nwzSD+8MTLnEttKRgWbyGEUYrNu+9JOle1d/g0=
X-Received: by 2002:a05:600c:34d2:b0:490:bbc4:76a6 with SMTP id
 5b1f17b1804b1-490c25eea30mr353324785e9.21.1781011374607; 
 Tue, 09 Jun 2026 06:22:54 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3446aesm68477564f8f.24.2026.06.09.06.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:22:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, christophe.leroy@csgroup.eu,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v6 4/7] rpi: Add a local get_effective_memsize()
Date: Tue,  9 Jun 2026 16:15:46 +0300
Message-ID: <20260609131611.46399-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
References: <20260609131611.46399-1-ilias.apalodimas@linaro.org>
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

