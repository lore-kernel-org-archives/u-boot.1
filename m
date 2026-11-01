Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D50606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZXaTy+Ou;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBT1VAGR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FFCB405BF;
	Sun,  1 Nov 2026 21:05:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qa0q0UteAXxb; Sun,  1 Nov 2026 21:05:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BC85B4054E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567134;
	b=fAHYngdiIVFe4Ovq4+Y+ximQQxxlp4hC/BaAc6oxlqykQ2bRuUpOQ1xxElh/qdVqrx7n
	 TFR+wAOex3oOJazDs4patEYD2voVcCU8498B6P88Pouh1+QrmGwaKY6Inj1RlcUdYGdVT
	 ZoZSuDG9hFA2zQh9q1lQ+5iWaYIVSbr1+Y5eRQztsjxF1fOT10COW92kBhs5/fhOMlFde
	 zA45IybNx/pYM+x/mPPcptcwpQbOVAb2Z/0Mom7Cr5N4ib0iMVyAbN4hHZ9sJotf9JpeJ
	 ocHS/C/YCJ/Av/hIKj3tZSLHwhZjfhhu5Cxbt+E981NfTea8/CUKL+VqPYhoHhaYyTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5f+L4Y5A7MkBOYh9hwAKnbuFZV04uX8RQigYXpQe5k0=;
	b=nVqLPZhlgFmjy5f4FpyAsSWR6nz/yMZObvHlLGQghAxff2GTVyukOdZzOj0Ktm+QzvX8
	 iRZ8v5T3aG1J76Hm1o7bz2oEqsziAobuVnMdb5MDpcCIAJIDjinrkQLwscwWn3/CNePtQ
	 x4M1nWS/HSAaZQk4u1YU+pQlXJnYOkmVR831jqZR2QMOTMRK53tZhNah93rLtz3pIQaxr
	 xK3w/+wboepNf1NeDM9BeVlOncn8+o4VcUM9k9JDMl7OYSfbtoFrP4o155q6CcIa9HN25
	 iWtl8aEhg410sTAFWaHuypRogmzNzmW3OM6Ql+9VYu1AR1IjWPAZZA5Fyk+fnTLHTCQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567134;
	bh=5f+L4Y5A7MkBOYh9hwAKnbuFZV04uX8RQigYXpQe5k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZXaTy+OurLuVbuP6Cb7T+Kewx74KqGBkRMOCHBWlx8FiaTXbeI2b4Zj4eQtd50gUB
	 FPlMvTEW0pfTir8NmaVzgnQx8QkrZ1h2gHbUs4g8Vc5qDchpVUQfrE1PM6hIDoSdRU
	 5pdkft1o6HP6ewoG7SEilEUVXaHM4/o4TljN7oeH6COUDS78w1p2igj1byQ9Pe1Rc3
	 mJHEBOYoVO6TuseDkq9XRU8bzpQuiLJD9LNaupORqUHg6ZvTXLuP6YlOex+HnmWFoo
	 BBoUWOcTldJzBJ3Omyeq21he3nrGLtDt44EgGhG+36DZA0Ct/sDdE3v9fGwuOlB017
	 0L4c+nuWlLuKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC85B4054E;
	Sun,  1 Nov 2026 21:05:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B1A0435
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8C4844004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Nk6y2I18_fH for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:05:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8347D40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567132;
 b=krlQRfWTgemimQhS3PXKEK7bV35fxlNRPnpLWCjyD9nY3TBnWEnirHcdupU7d3f7yuWW
 SsBd5SFkj0xJu/j4s4x/SmLwQYzoYxPylmevAIcaSIaBcbrDDGIWsbHpFhoqEIbR1rSOv
 r7MdYSR8+lGThxUQ3AlkCi2F2M+ZG9SBOMTFtfYHsif47sXxJPYfr1DOPJ/hmqpGF+s2D
 sTnPSsVfQz/50e5xMD7W6CZJjqz3PC+qZuF3S0RLUNGvB27wrKol2peOTy0toajvWu2xp
 eS+Iikh3zsttkvNxES42Y8MQu4+Z65/8XqhmIgTZ6IJtwF4ID4QaFc0MOriYHQ07UcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567132;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=5f+L4Y5A7MkBOYh9hwAKnbuFZV04uX8RQigYXpQe5k0=;
 b=DmZb7yLoPnILjq8O0tmNal/vlLoVZEvXv/f2+/psMJRqWikj82TW5eoR7ewXYSP4A9lj
 uPgx4F0HpksDe004BuxeVrbxwe4UEIZx1Nq1F0KoQPa85b8rCaXRfqCa9+LgDf1FpFLAM
 42UJJ70GORzCiZpj4IV9wZoQCdAIwv3ijY3W5Vv5TzCgT2uip9cpdR3zeUiJeaGC6csNH
 zj9TCDQnQ71rak9GH7eiS8l4QSbcyqxhfCvyyme/wiXlWeZLk6XPZMYXyCuKH32OOS6ZX
 gpJYcs9sqh8mIbvDEz4H3/B9ey24dog1jhxQKEWgl4GrkNPkSS+gHAsdnHnxfiyTwyQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fBT1VAGR; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::22e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22e; helo=mail-lj1-x22e.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fBT1VAGR
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8347D40042
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:05:30 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3ab46699a09so18312841fa.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567129; x=1794171929;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5f+L4Y5A7MkBOYh9hwAKnbuFZV04uX8RQigYXpQe5k0=;
 b=fBT1VAGRMHPMDwF5VCBiCVsX+NdXF8oa1hubHmLohVK44sFkwMkWad0PWTaH/FDVd7
 SKlpIQRdh1Go0SzPD1WHF9/oIh4Q1Ms00bvBFd63DMENgMql2ks/V8yeUbZBBSlWBVqU
 SFhzDL1qeiTv1BOdyFU6jPR6N9iBmT5gIlAVkxszrZF2vpsoxeez0CJq7Ida+3CBTHBQ
 aqJoDvTLgdOIqtaWP5hKTNyZ65X4SvZSOPzeZ7w8icDuOUe+wZU9v4HEX7nPyBxF9GCd
 oobNNrUpDGAci5uWp1701oM4wZrM+rE/8vuwsq6YQax70spNqUYZ6xPBl9G8TmyrGfBi
 w5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567129; x=1794171929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5f+L4Y5A7MkBOYh9hwAKnbuFZV04uX8RQigYXpQe5k0=;
 b=obzqQXkdByQMyL6wsqCG3mI31A61fE3MiEtG5Oq5iv2ITlxIcuRWqSXs8o+oH/NH/2
 3aJFNMFCOD4F4tJzaMGlQ1Izub9aqAd1BHbJgpEEGUcMGu176Gmtwr4XpkUG/ezlxtaf
 ayOWDfslES5y+L9ZEgQiHU/v3LvPRS1huUdXa+UsHCgDTikxCNYTIl2VV+lfEIpKYyo2
 zBJWzdl/I6SSQd9xcrI9wyKlUwvhtFWiXRvqztrwRrAZ/IoR+ywF2tgHvUkPnkylZ3Qf
 xGrMwAWGWr+76Lex5ob0bGCrXF4Z5iP0rLNE8yFKZiE/adSK/ar/L55wUHAaodPoN4p7
 IEww==
X-Gm-Message-State: APuU4Z+7vFzdq8fFmw+0jXOdaK9FO3aZ5F/dBRTkM2DQJJ42znTU4sXh
 PQvKO9xBqI+ZdYeQudACGEqScUuGi9CourSixHc6j7M10ZRDRJuJnpeVJLU1irXk
X-Gm-Gg: AYBFou24c8p6vKH3IBPVfHBNDvOy2bWIN7oIJq5xaKKqBxqj/5uFCVy32HiX4urVx0V
 keWuv3EnNS9sFFb2CP4XfXqKqgNdDaoHlek0HGhlZaI1Hjw+tELuatXJjRowdZdGG+U2YzgMCpX
 EXzPbOQSvtv3L22RC3pqrao8D4tBVtww1jwGQgQY22/KMpADmy7G7vM7MfbvCiHD8JwVEatSz8F
 Pub1OirmXxP5nMdSlk0Nd42gyKH2B+9SmWQOevp1Imf7rR1sfW7jiC/1sBCUyWCyUdBHxMvwt3H
 aeTA4TI7rdwJNsxvedx7uFnybus8TWCCNlguzQv/augoGN8LgGfuJZJO8EEO+aQ2inymsDsFYjh
 XfEoSk8hgAvwmEw86kdiWQTEiQ68w1UyLb5w7pLgnFAeMBEclvi9fdqkvAZEPNvcgG0oU8WrDv0
 SFL3afp2KKleECkt3Wg+QCOBSXbV7PLukqkdCNRMOxfh4jfnIienkvGtHb+eWA9f0axUfr12Ia8
 c6tflQaghbpOkyghZjQ48m5lrBRmeYnS7xUGje2Qq4qHkAZ9k/Of9DmD+q5c9krjhP7pBG8Mc6x
 Yk/nZK3CprxSdoSBdnTl9+N4uoaqT95lB+VHSUZjXgHS7qs+P1zB06z+ESQeEu8B4ow=
X-Received: by 2002:a05:651c:b11:b0:3ab:4ab5:56ce with SMTP id
 38308e7fff4ca-3acb7b4edb0mr19240131fa.28.1793567128690; 
 Sun, 01 Nov 2026 13:05:28 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:05:26 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 02/10] sunxi: allow the sunxi drivers to be built for sun20i
Date: Sun,  1 Nov 2026 23:04:41 +0200
Message-ID: <20261101210449.1235102-3-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
References: <20261101210449.1235102-1-indrek.kruusa@gmail.com>
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
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Accept SUN20I next to ARCH_SUNXI for the RAM, clock, pinctrl, GPIO, MMC,
reset and watchdog drivers, and keep WATCHDOG_AUTOSTART off for it.

Declare SUNXI_GEN_NCAT2 here as well - the ARM sunxi Kconfig is not read
by a RISC-V build - and add the MMC base addresses to arch-sun20i/cpu.h
so sunxi_mmc.c builds.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 arch/riscv/cpu/sun20i/Kconfig            | 11 +++++++++++
 arch/riscv/include/asm/arch-sun20i/cpu.h |  4 ++++
 drivers/clk/sunxi/Kconfig                |  2 +-
 drivers/gpio/Kconfig                     |  2 +-
 drivers/mmc/Kconfig                      |  2 +-
 drivers/pinctrl/sunxi/Kconfig            |  2 +-
 drivers/ram/sunxi/Kconfig                |  2 +-
 drivers/reset/Kconfig                    |  2 +-
 drivers/watchdog/Kconfig                 |  3 ++-
 9 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/cpu/sun20i/Kconfig b/arch/riscv/cpu/sun20i/Kconfig
index 7f459518cfe..1e08317cf12 100644
--- a/arch/riscv/cpu/sun20i/Kconfig
+++ b/arch/riscv/cpu/sun20i/Kconfig
@@ -4,3 +4,14 @@ config SUN20I
 	bool
 	select SYS_CACHE_SHIFT_6
 	select SYS_CACHE_THEAD_CMO if !SYS_DCACHE_OFF
+
+config SUNXI_GEN_NCAT2
+	bool
+	default y if SUN20I
+	select DRAM_SUN20I_D1
+	select MMC_SUNXI_HAS_NEW_MODE
+	select SUPPORT_SPL
+	help
+	  The D1/D1s(F133) SoCs belong to the same ("NCAT2") peripheral
+	  generation as the R528/T113. Declare this symbol here, so the
+	  sunxi code can take its NCAT2 paths.
diff --git a/arch/riscv/include/asm/arch-sun20i/cpu.h b/arch/riscv/include/asm/arch-sun20i/cpu.h
index d20c0139426..c57c58495dc 100644
--- a/arch/riscv/include/asm/arch-sun20i/cpu.h
+++ b/arch/riscv/include/asm/arch-sun20i/cpu.h
@@ -15,4 +15,8 @@
 #define SUNXI_DRAM_COM_BASE2		0x03202000
 #define SUNXI_DRAM_PHY_BASE		0x03103000
 
+#define SUNXI_MMC0_BASE			0x04020000
+#define SUNXI_MMC1_BASE			0x04021000
+#define SUNXI_MMC2_BASE			0x04022000
+
 #endif /* _ASM_RISCV_ARCH_SUN20I_CPU_H */
diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 1c1cc82719c..74ce009bc2d 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -1,6 +1,6 @@
 config CLK_SUNXI
 	bool "Clock support for Allwinner SoCs"
-	depends on CLK && ARCH_SUNXI
+	depends on CLK && (ARCH_SUNXI || SUN20I)
 	select DM_RESET
 	select SPL_DM_RESET if SPL_CLK
 	default y
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7f12e39dad8..8b75bacdb38 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -460,7 +460,7 @@ config SPACEMIT_GPIO
 
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || SUN20I
 	select SPL_STRTO if SPL
 	help
 	  Support the GPIO device in Allwinner SoCs.
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index b3731dfe4a1..2586a28ce02 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -842,7 +842,7 @@ config ZYNQ_HISPD_BROKEN
 
 config MMC_SUNXI
 	bool "Allwinner sunxi SD/MMC Host Controller support"
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || SUN20I
 	default y
 	help
 	  This selects support for the SD/MMC Host Controller on
diff --git a/drivers/pinctrl/sunxi/Kconfig b/drivers/pinctrl/sunxi/Kconfig
index 54314992299..9400d45990b 100644
--- a/drivers/pinctrl/sunxi/Kconfig
+++ b/drivers/pinctrl/sunxi/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-if ARCH_SUNXI
+if ARCH_SUNXI || SUN20I
 
 config PINCTRL_SUNXI
 	select PINCTRL_FULL
diff --git a/drivers/ram/sunxi/Kconfig b/drivers/ram/sunxi/Kconfig
index 1775cb0d780..9f2dc4a6e66 100644
--- a/drivers/ram/sunxi/Kconfig
+++ b/drivers/ram/sunxi/Kconfig
@@ -1,6 +1,6 @@
 config DRAM_SUN20I_D1
 	bool
-	depends on ARCH_SUNXI
+	depends on ARCH_SUNXI || SUN20I
 	help
 	  This enables support for the DRAM controller driver covering
 	  the Allwinner D1/R528/T113s SoCs.
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ad61ebf344a..becbd86d59d 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -179,7 +179,7 @@ config RESET_NPCM
 
 config RESET_SUNXI
 	bool "RESET support for Allwinner SoCs"
-	depends on DM_RESET && ARCH_SUNXI
+	depends on DM_RESET && (ARCH_SUNXI || SUN20I)
 	default y
 	help
 	  This enables support for common reset driver for
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3c56c541505..ce0cec964ed 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -17,6 +17,7 @@ config WATCHDOG_AUTOSTART
 	default n if ARCH_SUNXI
 	default n if ARCH_STM32MP
 	default n if ARCH_SNAPDRAGON
+	default n if SUN20I
 	default y
 	help
 	  Automatically start watchdog timer and start servicing it during
@@ -427,7 +428,7 @@ config WDT_STARFIVE
 
 config WDT_SUNXI
 	bool "Allwinner sunxi watchdog timer support"
-	depends on WDT && ARCH_SUNXI
+	depends on WDT && (ARCH_SUNXI || SUN20I)
 	default y
 	help
 	  Enable support for the watchdog timer in Allwinner sunxi SoCs.
-- 
2.43.0

