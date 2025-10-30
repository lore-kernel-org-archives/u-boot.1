Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323F0CCF9FC
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 13:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2316A83990;
	Thu, 30 Oct 2025 14:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eEAbSbum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5224283893; Thu, 30 Oct 2025 11:01:43 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613228352B
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 11:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dd54d7cdso3353535e9.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 03:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761818501; x=1762423301;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CW+8k0poKLG3E3LW60dHU9Eszk5NC4yNnK4x3i9bgzM=;
 b=eEAbSbumRgNnV7ORjDMEndKdStOebCCOq9JvzBgC1GyZW0aLi1wfd8J23rs79OlA4S
 3quZDGzGUHthBihBbXAWkSUNKE4Kv6PpAfgwiOw9S8pGD0b8+HQOtwKbIFfyvD8umv3U
 6UVr1dJ1/xgV4GZmsCwkHbtOuXIWQ+4ZUCuUohwrEiTAohFoqRfWAuhbbP84pZifU0Yi
 iDkrjdz6/6B6XQmbbSD+7cVUwsckbV77pIowmRst7W0Wq8kn9AP3QQYSerwr7Bcxq9Ku
 N8lZmKfclHBA5AsOdEhWN9ktH4IaXNZI6N+IMrdhk02phVcU93T6opW7loUkP/XqvsIk
 eDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818501; x=1762423301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CW+8k0poKLG3E3LW60dHU9Eszk5NC4yNnK4x3i9bgzM=;
 b=WMds/QPzB8QViHewo0LztC6OSiCohROAWmWBKnW6J2fV6/RnM8U4ZBIdRkeDUzvbUi
 wd44LnRYMXrWmSnKqm+RSfq9Z570KQxu7slK6Wj1DnEj+vsHvncFnwnDDcKyZxpx7UkS
 Tl+Pqbh0ushDYVMMedO4DROF3YIbXaqSukHcPoFeenEUf3lKQL3TS4xh2DFCA0zLYvN2
 h9j/kfl+cLAJiCcxhOAdT+uObPcGCkNkXlZzC1LL1hEhXxOgYuUrkmmIKMPoQImybtpd
 5G8JcOT6Y7rtpU3vhZk4ArtjwqHV6Dr3KUrNtd6Tipo+Ym0PMEniuTi3SAMSslBhhLh9
 B25Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4wtm1fVp/Xmd8ATkEe1jwMMblCwxk/s+imh3tlWiQNe+FLEmjlrxDZfpznDC6HDK9jurOfu4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5Qh4SzJh6i8DEw58loHw6E/JuPWI2RDk0OHKMH6yUeYvidl2b
 iF/Yl44M+rp9z31vbqNDCdqv9g6ruXA7SHSvBarUS06/OKWDnkCN7gpUvf2pddCP4ic=
X-Gm-Gg: ASbGncseL1iZR6OW5hol5j2O2FP9yYmjcyjE4cwXnhfZ9JJYSA2hoqbQEC0W4KgfLbz
 i8svjhRjYVDU++WjtVMfGqN1ejJk2EiVqkf1E6fq2lwaIF8CMbEWpeQvqtKxgPQQo/MjrryMSte
 nv7lG3L7bjkq1iHekwz971VZJt1N8IpDgqz68p0sJETTFwXVu1N3G9UxxDLMfRe2dfSCc5kvdoP
 YeAnn1OsR1EFAbyTpB7lcjzHCmr/DGXBlzo2wLuHtAD0S12zmhwtJFJylftQ0knPavcTt6jOH41
 TTLQrIayqqOWRgsbp4aBF4aHhtlUb8JzTLBo1OPnSARkyoyoLuwVG2BngcfnjdkUEf1K6adZb25
 BwPDItkR/gyVeNaTqi0oOQ/S7sDQ1Toaq79/4WXBuwA9zWM30NIR6YYVjGKsoMYhQoxxz3fLogw
 ==
X-Google-Smtp-Source: AGHT+IGA8NnH0JI/+B/JAA/o0iZxni5UN9DJ7nfs+m8a9UVL2LsNpS0fkdpapqleL/Mw4pvcpKL7DQ==
X-Received: by 2002:a05:600c:548f:b0:475:da13:2568 with SMTP id
 5b1f17b1804b1-4771e3effb8mr53846555e9.25.1761818500703; 
 Thu, 30 Oct 2025 03:01:40 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-477289a5625sm32165435e9.5.2025.10.30.03.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 03:01:39 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:59:27 +0100
Subject: [PATCH v4 09/13] arm: mach-k3: am62p5_init: Resume on LPM exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-9-4cef18af0226@baylibre.com>
References: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
In-Reply-To: <20251030-topic-am62-ioddr-v2025-04-rc1-v4-0-4cef18af0226@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1035; i=msp@baylibre.com;
 h=from:subject:message-id; bh=3G8H86tTql6z2DYWlv0TI6S1jr43r0AnKRT72oHrRSo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxmc+d/22XO6dfqb16q73RaYIfs5x3MB5bcevD2zKGJZ
 j0fn5w83lHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQAT8XFl+MUk1ROy5WaFKO/O
 2xGH72/s0YlffeVGdMrUby7G1ossZ2UyMlxkUxEPn+87Z0vnTcUaV+4gp67oQJ9t16c+Ceeemyz
 fzQYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 30 Oct 2025 14:00:47 +0100
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

When exiting a low power mode with DDR self-refresh, we can directly
resume after DDR setup is done. Call the common function to resume.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62px/am62p5_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 1c47debca61598ecacae03d83b4001a72dda164a..f69bb8b7bfd4eb244803490b1cd1c36ab8ab608b 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -253,6 +253,16 @@ void board_init_f(ulong dummy)
 	spl_enable_cache();
 
 	setup_qos();
+
+	if (wkup_ctrl_is_lpm_exit()) {
+		u64 meta_data_addr;
+
+		ret = wkup_r5f_am62_lpm_meta_data_addr(&meta_data_addr);
+		if (ret)
+			panic("Failed to get LPM meta data address %d\n", ret);
+		lpm_resume_from_ddr(meta_data_addr);
+	}
+
 	debug("am62px_init: %s done\n", __func__);
 
 	fixup_a53_cpu_freq_by_speed_grade();

-- 
2.51.0

