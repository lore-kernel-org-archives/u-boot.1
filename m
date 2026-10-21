Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995E606BF21
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sx6ymcEO;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CmDbcd4O;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=xIDfu50C
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96DA56084A;
	Wed, 21 Oct 2026 16:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cnw7efjcsG1P; Wed, 21 Oct 2026 16:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 520A760AD1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792599405;
	b=NH2h9IpSMPyb1kk/HIm8d0qsctCROKNkKcrJswM4cm/0kZkUVZpe60DPE/2tMRHf7Il1
	 U4k/hmZjrJplWJaqshiCjy6SBUn8bxWwF0Npo8vXbbamPuYPe6ns8JwIRdtsbnCB3Y+pe
	 1h4+tq2VNzpAcUKZyOlctW8xvlgBnQXbrw2qO/L1WKDcTyIKpIzRBYlIq2B61CBapJi6C
	 UEiR4n7wyy6P0ocvW4/SuoDekKSzQ78iM67htyu60qQODET7F8IC3O03FbZMallTat/TN
	 90n8bZEAidX+SNHcov0pnILaPR015xdMuFScbRPY4G/uBo7EW776EPfyYyipDLnEtEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792599405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BmzijSSEiiwygALZOKTyV4GIv0IEhpsJWA1+Q23GPKo=;
	b=n2hGCOoTrDOB23gOoR+ol8u9+fRNl1K5IU8Gp8PZapOdvIoXIpDUojJF56dgZcHJvGB/
	 NtwE6LNnhK21GTNU3nbUoKF8++5pfQ+V5gR+852AtdHQFoiMIKBBWkxRxYEKmZFLhgGVj
	 WZpbyn0FjYS8h+kmwMAr4IeVD8G+3LK9UOK6SNGuq6XxflUJQ9m8QD9N88mAKKVhFdmVi
	 gEDWRLa4mbhL1WQL3EhMY6xp+6/aiyWWnOtlmhfaTbaSpskhVcDWidn3Uf4Ha+f1gjuTG
	 9vLzsSzFv7QEZn+U6IHo7YdTuNP9OzA/uWmwnlVdIj8wLvSHH4GL3DShkyPfAqEbwLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=CmDbcd4O;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=xIDfu50C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792599405;
	bh=BmzijSSEiiwygALZOKTyV4GIv0IEhpsJWA1+Q23GPKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sx6ymcEOjyZ7fqvjM4gi4C2wt3a1TaPTbwUW2dN8TQnRIojURE1ho24AYXpyCXJjM
	 ZRoe7Z4LNhyJT1p3N2dHb/132xT0Y6Q9toLMqEDUcZeYGZ38NkPGbMng5R2bLKrnd8
	 8oXJvfSEeqqD1tEAjAcA2Wi1k72T/DLW6XzjR8kJt4fwzGfcyWmRIQoCDOBJA/r2s3
	 wkvlbnCMJEUAO5r3I3hUlWjfZM01ULyyLMh/sqpM/UI5euZ4q6d/RopSjUmi+/GhBw
	 ag6nOfCaojItuKDEulH9Krc+zZtpQt+hLSjMnfk1FKmVdyUFYwgfypbQGY6iFwVhUe
	 OJf2dKD9KCObw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 520A760AD1;
	Wed, 21 Oct 2026 16:16:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with UTF8SMTP id E19711E17
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with UTF8SMTP id D3F47606C2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024)
 with UTF8SMTP id S0zpdkdWl9-h for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 16:02:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A528C60848
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792598521;
 b=FL20cWOlnIMQ/l1e99n64IMrfjH6SgW5UyanyLXOVZIfW3ZQ2h4hww8ksJbgDwQ535gI
 wwGKzmyOU4JDhIrHw0N14ILeP+qzp/XspDVvVlmX+g7nnHV6uVo7+c+hH4faDCnPDLjnQ
 L99AktZNj5sDYRjkjNHOCnhKqFzvwOgfGmRcVMXxyiMTGGL1n5mitlFUJuIE7olqaXvZ3
 qIqMQe8QIICOZdSB35yZY99mabvXs8FkfQ5j4wdMqPUKfm9vuWE+ajagl+3d92iZqnYmN
 WKCx6lIFT9VxPYjgnA6KfI8QUGQz4SAu9R4iuf6elVJNlcWRLmXCUPmamk0YBGDJFOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792598521;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=BmzijSSEiiwygALZOKTyV4GIv0IEhpsJWA1+Q23GPKo=;
 b=ceTi0AR4VE43Vi5PxUZYa785AsDmTcDFtWrVYJ5ZLyjMz/15tVB+jHfW7y4jA//PKwiM
 mJQpOrzHtkVvEupOLkQAtXZOE4N4/jDa36l2xz3p9Ea57a9evLr8zqk/xd8SFCXXtvMeY
 vEnP+Rn82PuHMNlYWeeACJ+guawJH58pYF7KinHOgOsi1dTclcQ9hk/W7adfc6Vq3DCF8
 Cros/3WpaK0U4PIpYXbkv4z9HFOl+OR2mMfO9YqNbvbplUnKQiV+DzHSes8t02vJ7W/NO
 ZPE8OyRVvjcKWvj3IXnRPd7/jDnqS3IgT1RuavBEEtSFNNsTbfK0O4/1iUINXTpGVgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=CmDbcd4O; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=xIDfu50C; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=CmDbcd4O; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=xIDfu50C
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with UTF8SMTPS id A528C60848
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598516; bh=BmzijSSEiiwygALZOKTyV4G
 Iv0IEhpsJWA1+Q23GPKo=; b=CmDbcd4OQkp0qUNShwVyZPODrGZBHkW+OBk8oORYvvEHiPjKL4
 3IkW6IirJSgNMasoLo41s0ZeMa2HuhQCXu1E5joskp7bkX0A9D3teV2TJpyzDPu9Xp+57kurmXq
 mNRNkUAOLRGoaan+jeGIYbNUj5W0hM5iR5Q+DbghdE5yjlhFTpLEDXLST8mdKTSxKlmc6KI4K3o
 kOdtN9oHQIPrF7xmdOAe+9F26JPXveIMSGhJx4m0InhzWJ95jHT3hlxlvo8YF1SHRLyolP4KZk0
 qs3QLD+UzBY8ebt6QgZ95Ysz6yo77Im7rWo33poxoaMftHRZlbD2WOUnZFZFCXv6ssw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Date:Subject:To:From; t=1792598516; bh=BmzijSSEiiwygALZOKTyV4G
 Iv0IEhpsJWA1+Q23GPKo=; b=xIDfu50CaS76nnpqeopL4M8rIbDM5wA6TeZhJRd506vjA8p/Xu
 t7rVWBgl7EigVZ3DSeZ8ckz9+qiGnIJX32BQ==;
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.u-boot-project.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v3 24/26] powerpc: mpc83xx: Remove MPC8309 support
Date: Wed, 21 Oct 2026 16:01:20 +0000
Message-ID: <20261021160145.10430-25-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021160145.10430-1-brads@mainlining.org>
References: <20261021160145.10430-1-brads@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 16:16:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

No board selects ARCH_MPC8309, and the SoC is unmaintained. The
CPU, clock and GPIO match tables still accepted it.

Remove those stale entries.

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 arch/powerpc/cpu/mpc83xx/cpu.c                            | 1 -
 arch/powerpc/include/asm/arch-mpc83xx/soc.h               | 7 ++-----
 doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt        | 1 -
 doc/device-tree-bindings/cpu/fsl,mpc83xx.txt              | 1 -
 doc/device-tree-bindings/gpio/fsl,mpc83xx-spisel-boot.txt | 4 ++--
 drivers/clk/mpc83xx_clk.c                                 | 7 +++----
 drivers/cpu/mpc83xx_cpu.c                                 | 4 ----
 drivers/cpu/mpc83xx_cpu.h                                 | 3 ---
 drivers/gpio/mpc83xx_spisel_boot.c                        | 1 -
 drivers/qe/qe.c                                           | 1 -
 include/mpc83xx.h                                         | 1 -
 11 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/cpu.c b/arch/powerpc/cpu/mpc83xx/cpu.c
index 7583121eb12..4117f3aa6af 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu.c
@@ -47,7 +47,6 @@ int checkcpu(void)
 		u32 partid;
 	} cpu_type_list [] = {
 		CPU_TYPE_ENTRY(8308),
-		CPU_TYPE_ENTRY(8309),
 		CPU_TYPE_ENTRY(8321),
 		CPU_TYPE_ENTRY(8323),
 		CPU_TYPE_ENTRY(8358_TBGA_),
diff --git a/arch/powerpc/include/asm/arch-mpc83xx/soc.h b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
index 0473389bc7d..eb82bb9e810 100644
--- a/arch/powerpc/include/asm/arch-mpc83xx/soc.h
+++ b/arch/powerpc/include/asm/arch-mpc83xx/soc.h
@@ -9,15 +9,13 @@
 
 enum soc_type {
 	SOC_MPC8308,
-	SOC_MPC8309,
 	SOC_MPC832X,
 	SOC_MPC8360,
 };
 
 static inline bool mpc83xx_has_sdhc(int type)
 {
-	return (type == SOC_MPC8308) ||
-	       (type == SOC_MPC8309);
+	return type == SOC_MPC8308;
 }
 
 static inline bool mpc83xx_has_tsec(int type)
@@ -42,8 +40,7 @@ static inline bool mpc83xx_has_second_i2c(int type)
 
 static inline bool mpc83xx_has_quicc_engine(int type)
 {
-	return (type == SOC_MPC8309) ||
-	       (type == SOC_MPC832X) ||
+	return (type == SOC_MPC832X) ||
 	       (type == SOC_MPC8360);
 }
 
diff --git a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
index 213123dbab4..6c38a3254e8 100644
--- a/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
+++ b/doc/device-tree-bindings/clock/fsl,mpc83xx-clk.txt
@@ -5,7 +5,6 @@ system.
 
 Required properties:
 - compatible: must be one of "fsl,mpc8308-clk",
-                             "fsl,mpc8309-clk",
                              "fsl,mpc832x-clk",
                              "fsl,mpc8360-clk"
   depending on which SoC is employed
diff --git a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
index 5acb2c403c9..6e0052869d3 100644
--- a/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
+++ b/doc/device-tree-bindings/cpu/fsl,mpc83xx.txt
@@ -5,7 +5,6 @@ MPC83xx SoCs contain a e300 core as their main processor.
 Required properties:
 - compatible: must be one of "fsl,mpc83xx",
                              "fsl,mpc8308",
-                             "fsl,mpc8309",
                              "fsl,mpc832x",
                              "fsl,mpc8360"
 - clocks: has to have two entries, which must be the core clock at index 0 and
diff --git a/doc/device-tree-bindings/gpio/fsl,mpc83xx-spisel-boot.txt b/doc/device-tree-bindings/gpio/fsl,mpc83xx-spisel-boot.txt
index 52d8bb0a5cb..bdec12d1035 100644
--- a/doc/device-tree-bindings/gpio/fsl,mpc83xx-spisel-boot.txt
+++ b/doc/device-tree-bindings/gpio/fsl,mpc83xx-spisel-boot.txt
@@ -7,14 +7,14 @@ The SPISEL_BOOT signal is always an output.
 
 Required properties:
 
-- compatible: must be "fsl,mpc83xx-spisel-boot" or "fsl,mpc8309-spisel-boot".
+- compatible: must be "fsl,mpc83xx-spisel-boot".
 - reg: must point to the SPI_CS register in the SoC register map.
 - ngpios: number of gpios provided by driver, normally 1.
 
 Example:
 
 	spisel_boot: spisel_boot@14c {
-		compatible = "fsl,mpc8309-spisel-boot";
+		compatible = "fsl,mpc83xx-spisel-boot";
 		reg = <0x14c 0x04>;
 		#gpio-cells = <2>;
 		device_type = "gpio";
diff --git a/drivers/clk/mpc83xx_clk.c b/drivers/clk/mpc83xx_clk.c
index 4b2f1705b64..924c0d452a3 100644
--- a/drivers/clk/mpc83xx_clk.c
+++ b/drivers/clk/mpc83xx_clk.c
@@ -47,7 +47,7 @@ static inline bool is_clk_valid(struct udevice *clk, int id)
 	case MPC83XX_CLK_MEM_SEC:
 		return type == SOC_MPC8360;
 	case MPC83XX_CLK_ENC:
-		return (type == SOC_MPC8308) || (type == SOC_MPC8309);
+		return type == SOC_MPC8308;
 	case MPC83XX_CLK_I2C1:
 		return true;
 	case MPC83XX_CLK_TDM:
@@ -66,7 +66,7 @@ static inline bool is_clk_valid(struct udevice *clk, int id)
 	case MPC83XX_CLK_SATA:
 		return false;
 	case MPC83XX_CLK_DMAC:
-		return (type == SOC_MPC8308) || (type == SOC_MPC8309);
+		return type == SOC_MPC8308;
 	case MPC83XX_CLK_PCI:
 		/*
 		 * FIXME: implement proper support for this.
@@ -78,7 +78,7 @@ static inline bool is_clk_valid(struct udevice *clk, int id)
 		return mpc83xx_has_second_i2c(type);
 	case MPC83XX_CLK_QE:
 	case MPC83XX_CLK_BRG:
-		return mpc83xx_has_quicc_engine(type) && (type != SOC_MPC8309);
+		return mpc83xx_has_quicc_engine(type);
 	case MPC83XX_CLK_LCLK:
 	case MPC83XX_CLK_LBIU:
 	case MPC83XX_CLK_CORE:
@@ -318,7 +318,6 @@ const struct clk_ops mpc83xx_clk_ops = {
 
 static const struct udevice_id mpc83xx_clk_match[] = {
 	{ .compatible = "fsl,mpc8308-clk", .data = SOC_MPC8308 },
-	{ .compatible = "fsl,mpc8309-clk", .data = SOC_MPC8309 },
 	{ .compatible = "fsl,mpc832x-clk", .data = SOC_MPC832X },
 	{ .compatible = "fsl,mpc8360-clk", .data = SOC_MPC8360 },
 	{ /* sentinel */ }
diff --git a/drivers/cpu/mpc83xx_cpu.c b/drivers/cpu/mpc83xx_cpu.c
index 56b192ca153..5d5611bd0e4 100644
--- a/drivers/cpu/mpc83xx_cpu.c
+++ b/drivers/cpu/mpc83xx_cpu.c
@@ -99,9 +99,6 @@ static inline void determine_type(const struct udevice *dev)
 	case 0x8100:
 		priv->type = TYPE_8308;
 		break;
-	case 0x8110:
-		priv->type = TYPE_8309;
-		break;
 	case 0x8066:
 		priv->type = TYPE_8321;
 		break;
@@ -284,7 +281,6 @@ static int mpc83xx_cpu_probe(struct udevice *dev)
 static const struct udevice_id mpc83xx_cpu_ids[] = {
 	{ .compatible = "fsl,mpc83xx", },
 	{ .compatible = "fsl,mpc8308", },
-	{ .compatible = "fsl,mpc8309", },
 	{ .compatible = "fsl,mpc832x", },
 	{ .compatible = "fsl,mpc8360", },
 	{ /* sentinel */ }
diff --git a/drivers/cpu/mpc83xx_cpu.h b/drivers/cpu/mpc83xx_cpu.h
index f86b36114ab..002e753734f 100644
--- a/drivers/cpu/mpc83xx_cpu.h
+++ b/drivers/cpu/mpc83xx_cpu.h
@@ -49,7 +49,6 @@ enum mpc83xx_cpu_family {
 /**
  * enum mpc83xx_cpu_type - Identifiers for MPC83xx CPU types
  * @TYPE_8308:      Identifier for the MPC8308 CPU type
- * @TYPE_8309:      Identifier for the MPC8309 CPU type
  * @TYPE_8321:      Identifier for the MPC8321 CPU type
  * @TYPE_8323:      Identifier for the MPC8323 CPU type
  * @TYPE_8358_TBGA: Identifier for the MPC8358 CPU type (Tape Ball Grid Array
@@ -61,7 +60,6 @@ enum mpc83xx_cpu_family {
  */
 enum mpc83xx_cpu_type {
 	TYPE_8308,
-	TYPE_8309,
 	TYPE_8321,
 	TYPE_8323,
 	TYPE_8358_TBGA,
@@ -73,7 +71,6 @@ enum mpc83xx_cpu_type {
 /* Array mapping the MCP83xx CPUs to their human-readable names */
 static const char * const cpu_type_names[] = {
 	[TYPE_8308] = "8308",
-	[TYPE_8309] = "8309",
 	[TYPE_8321] = "8321",
 	[TYPE_8323] = "8323",
 	[TYPE_8358_TBGA] = "8358_TBGA",
diff --git a/drivers/gpio/mpc83xx_spisel_boot.c b/drivers/gpio/mpc83xx_spisel_boot.c
index 2be8c73ae3d..220e04218e0 100644
--- a/drivers/gpio/mpc83xx_spisel_boot.c
+++ b/drivers/gpio/mpc83xx_spisel_boot.c
@@ -129,7 +129,6 @@ static const struct dm_gpio_ops mpc83xx_spisel_boot_ops = {
 };
 
 static const struct udevice_id mpc83xx_spisel_boot_ids[] = {
-	{ .compatible = "fsl,mpc8309-spisel-boot" },
 	{ .compatible = "fsl,mpc83xx-spisel-boot" },
 	{ /* sentinel */ }
 };
diff --git a/drivers/qe/qe.c b/drivers/qe/qe.c
index 25880db37cf..107a3e78f99 100644
--- a/drivers/qe/qe.c
+++ b/drivers/qe/qe.c
@@ -120,7 +120,6 @@ static void qe_sdma_init(void)
  * we just need to know what the SNUMs are for the threads.
  */
 static u8 thread_snum[] = {
-/* Evthreads 16-29 are not supported in MPC8309 */
 	0x04, 0x05, 0x0c, 0x0d,
 	0x14, 0x15, 0x1c, 0x1d,
 	0x24, 0x25, 0x2c, 0x2d,
diff --git a/include/mpc83xx.h b/include/mpc83xx.h
index d570ba61b7f..b46c038f16e 100644
--- a/include/mpc83xx.h
+++ b/include/mpc83xx.h
@@ -51,7 +51,6 @@
 #define SPR_FAMILY(spridr)		((spridr & 0xFFF00000) >> 20)
 
 #define SPR_8308			0x8100
-#define SPR_8309			0x8110
 #define SPR_832X_FAMILY			0x806
 #define SPR_8321			0x8066
 #define SPR_8323			0x8062
-- 
2.47.3

