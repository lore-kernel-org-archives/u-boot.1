Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C36606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vcPBVH5y;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AapXQz+2
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2867D4096C;
	Fri, 23 Oct 2026 14:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TA_FOgS37v7y; Fri, 23 Oct 2026 14:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6347F409D2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792767333;
	b=Hp7wtRBbmQrPuTx3UOzC3o+2YulYJ4+MLIABRyfwDP5L11z+VBee7z1s7liQvYrLMjnw
	 K8DrGQCpC/KdDRG3PzPnmPkMj8NGEAKUkkDENO1O9i80IKKQdnnhmCTgKdvMcCLQ+QSxW
	 wh0bdJ/tN4N3RxnhO9cGDrRwTsS0GIHUj8ZJ49Preble1TSysFWRamXLFgXiBSw+QKmrs
	 J78lc1DBQL8RSDf2VSg6uK31G+p0p5WUFw0p+R5M61lKh+IsiA4OUeVnRhjKz6gYQF4yA
	 +NyHz7Aw8wNHXMJGqnCx4pTyq/oX/oGR5m9RnG87QJVZsb1H/KWB67w21pvLh2Sg+Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792767333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zxAAa8NZI+6b856AhDNkOtwfi2cEISI8iHG+hzMhuw4=;
	b=YJn7wo4h9pvfa7j3UPReh2tPRhaM84pV+5BleewQtb5s62Rb4bvOPw9Pl4Nd1uhn0K1A
	 So8VOyp7QK1tpRASjJo5vbNGGVPx4fhdvlXZ8uOpxrDc9wDr1kar3BvwJKi6UoieMPjq7
	 zopT50nuPnKIWTV4/uHXc7NkOp8kHWcFygk46Guc5SgEtJ+LkUMpoSs15/mnyk8ISadpd
	 f6r5GxjDySaK2iZbp7UWsX697VrFfMnohEM88v8E6UL9MJ2JFaHNPJO2+3cTxZyg/xqYv
	 9RR9udG0ivXHthjNE0QqIArCqKqCaIqj+1BQOTD+VHLHInkXboKYViQ5DjceTzv/fBQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792767333;
	bh=zxAAa8NZI+6b856AhDNkOtwfi2cEISI8iHG+hzMhuw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vcPBVH5yUhTGnulK7RVGxq0ghZyuMz/+0+qz1yth/s1sjsvsiF5fc+JBv9Lu3Bd0T
	 5x/3Un9bJDW4/wEkEQdBTOA+LYJnLHccw1oW78OCbRzz77NnkdnnVRdvH9Jcq7nf7W
	 5MS21dDPtDaqiOw3fMawgSFnf9LZ9Ho3vDLg6XbEXSR9VRDlefufEcnuoVsyMIj+T2
	 398gPFmX0NRfGrJj/kFqvLZRLcoW9n72QK0hbJRSxZ8oQm1StDxq7XXtdwzuLO6W4s
	 GQbE2CoDP7+y0Gj4NFbnwYzgMFejou5wlTs0yfs1NBPDdRq2Ee+/7ErsaXXmLnib9m
	 YLHgqUUDaC6Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6347F409D2;
	Fri, 23 Oct 2026 14:55:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11EDD356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 039658148F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQqvka3FW-PT for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:22:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD6A081499
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792761759;
 b=NRWUMc/3qePYOGgtU7CDKcdVP9rrGO5S8WcSVTEp9Omoo0mLYvhCZNCDw6SePtj+h9vI
 ilHYi46D4Q44Yp02dYHMjuXUwajCg36Aa0tz1KMeBljsCaahEyOZPfvG+jxLf9zXLAY4u
 ccS/N1Wh2a8SqxNRuKIlV2wiyUGKXvA66K+0Bk7yTwQ5gYEvH26MKy3VhmcHwN/lqSM8k
 A24NkJW5mVwKqam6VVp/MCb6yIx3KQErgi1ibwpnvvFvmcowX8AlOTKVKX0qbB6Xv08XQ
 Nw+x9vGfSfhrUXog3M9kMN3+mmqv91tfQGuGpk0pUj89yEqqOWIjYzo2/CGDbozj5TA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761759;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=zxAAa8NZI+6b856AhDNkOtwfi2cEISI8iHG+hzMhuw4=;
 b=EodziLKqSXzgHr8LdJ3VV4eVccxdm3+NiJomVrpmUoL0z5/rko1lwRgfPJSqTz0+rSY8
 HKpwiQKfJsufbicuD//NZxCrZtU9zVEJmLMTbsgMwmhrlhQmusfR5To0FwmuFY0W24zls
 n4a/7QbevVzUSqtZ5b2xIJTVN1Y36m4P8dvdapR4plvPUStIvT4E1JwCE8rvFgGqUYRm6
 9LhlAurh129ri8Pixvp6GzddpHmm+hEmjXWhkYmQRVR1Ic7/SDFt3bHGiMc4rewJamCZp
 AeupvYQhU1UkzzOZZ5HkTsXmvoXSvZOzFAhXGh/6z5Fda22qg2n9kGZjd2+J/AS4MTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AapXQz+2; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2b; helo=mail-vk1-xa2b.google.com;
 envelope-from=rnunez@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AapXQz+2
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD6A081499
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:22:37 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5eadf48fb2dso346874e0c.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792761757; x=1793366557;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zxAAa8NZI+6b856AhDNkOtwfi2cEISI8iHG+hzMhuw4=;
 b=AapXQz+2shdc9ILtURdjKxUV9GKZuubSMt0u/SIIxkY1ZAGlZaor39GGUCBCTp3Eqa
 I8rUyobPPZMOMPPA4GnuRMHRvUPaNZqk9qthSpzloisOXbqVtjNuEI7et4ZeVBwkrKrz
 H/KSdQKICxQzRlTJHddTS9j4uEVXaZC0WLYAOLC2xY5svAGuZDkYK5RlheSIdpChIpZS
 fMrcK971zHS0itLcn4MzRLCSniCZMpYuC8tXSSQ9++RwmFjALreBKt+NdorrKtdRMhgo
 55gm+UMCy082w1IVJQJSA7erMUv75nn9SVHxO0W1Wku51KGrSArNDEweaHehRC/iW6wh
 9w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761757; x=1793366557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zxAAa8NZI+6b856AhDNkOtwfi2cEISI8iHG+hzMhuw4=;
 b=bj2yYxSWwdEXGpTprmQbNhn06sC/j7LPhbfhSlrBj9Sj0fyRHXCDElF0GB5x1/+KE2
 kk9oEjAxSxaY/nKIxaj/5E9TlQrmdKtIUfAi5VHyP7wuvfJyUjTPFxRmW3AkNNBdp+OG
 EphWoJLYCSMGq5O8yZHb01pVYfoLxLyABf+GAU17HfEI2KF3q0kb13p2708giY5CYC4P
 wDxEYFX1yiv7gdmylf/8Og9CIApo/wMWS12Kt7XG1PBo/5cE8N+Bi1B2OK32py0udC3e
 Ak1gH1o+HFLkCk9h96gs8zyaK+D40YHvGHWjv9ju6HGrvyvZMucrD8RqA6jK7B9ykWXi
 VQbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+WdBJj/kOrPtOjDWGew7SyFJ8n4iBU9Ha36xh9NoL4XoxIaD6LPcyjVURTNu8zw5i3pSHERE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJ9VId0r38DkBV6xtkm4+E7JLKE1SVm1otXrQOs05g5VgkEcpCP
 a2xt2efV+HObWOlCC/WNPduynHxExQfebO0uSG2Hkw9OGgypLWmEwYeaJt5Fvs05pqM=
X-Gm-Gg: AYBFou2QT32J0BeV7VhCy5BJ3R2k4PwdEXwZ7tNL+8xqWcczbM4K//IQWrL1xxru7d3
 OzGD9Y82rkDslTAzzJPgS5Lq0ncLVmJiz8oC6mZd2hXtK5huJ/u7LD4L8GLa7YkvN7UNeKlEXvJ
 CvuV32CPjUx4UhVS72AUMWgHqC5AB7M0mBr3StHPoFu917+SwrtKKwJzPQKl10wRiK9uSWtwkFp
 B//KBSxjiwOrZO+D65gAVI0A8bCB/5pfpXZK26PmyuAmUmWoASc93C7Zor8lthFv4PzlBEsnJ6m
 1ctiNRuJMKZFfHXCYX1ZXmfLkdpTpg6tPfzf1POkVR+F1fFxdn8KrvqNmpVZG8I2UMapZCzYO+O
 5C4WWaudyPaf5cwZ64W+X6X4fyM06xrBzRFJcrrhs1YS9AUqBAbhrV0dJY/KKMeXgms6Jgq0Lrx
 Sp6HVhpau9s6+e9pGveZgTG8gHgoyw2XTvpVpNl7HyV+HLsIM40OsJaaaPJDKT0iyvvzg24W2L/
 utSG5g9U3JBaOk9Ew+uJ5SGCnxmAsFCqb9aq6v5v0P2hMoclCBK
X-Received: by 2002:a05:6122:614f:b0:5e9:6d96:aa38 with SMTP id
 71dfb90a1353d-5ec14aa9163mr683639e0c.9.1792761756709; 
 Fri, 23 Oct 2026 06:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([2804:7f0:7541:cdb4:5471:ddc9:4fc9:2])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec1fd11d42sm90891e0c.2.2026.10.23.06.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 06:22:36 -0700 (PDT)
From: Ronaldo Nunez <rnunez@baylibre.com>
Date: Fri, 23 Oct 2026 10:21:57 -0300
Subject: [PATCH 1/2] mx6: implement memory translation table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-imx6sx-elf-support-v1-1-73e378c6d5e9@baylibre.com>
References: <20261023-imx6sx-elf-support-v1-0-73e378c6d5e9@baylibre.com>
In-Reply-To: <20261023-imx6sx-elf-support-v1-0-73e378c6d5e9@baylibre.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ronaldo Nunez <rnunez@baylibre.com>
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Fri, 23 Oct 2026 14:55:32 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This enables the translation of auxiliary CPU Cortex-M4 memory
addresses to primary CPU Cortex-A9 memory addresses on i.MX6SoloX SoC
during ELF firmware loading, allowing the Cortex-M4 core to boot ELF
firmware through bootaux command.

Extends to i.MX6SoloX the work done for i.MX7D in commit c0f037f6a2ae
("mach-imx: bootaux: elf firmware support").

Signed-off-by: Ronaldo Nunez <rnunez@baylibre.com>
---
 arch/arm/mach-imx/mx6/soc.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-imx/mx6/soc.c b/arch/arm/mach-imx/mx6/soc.c
index 02df86156d41c3890d7a8b02361588961ba1b477..78f6b3a872d404399723fff053676a4e11af7bdc 100644
--- a/arch/arm/mach-imx/mx6/soc.c
+++ b/arch/arm/mach-imx/mx6/soc.c
@@ -795,3 +795,34 @@ void gpr_init(void)
 		writel(0x007F007F, &iomux->gpr[7]);
 	}
 }
+
+#if IS_ENABLED(CONFIG_IMX_BOOTAUX) && IS_ENABLED(CONFIG_MX6SX)
+/*
+ * Memory map conversion table as seen by Cortex-M4 and Cortex-A9 cores.
+ *
+ * Based on Table 2-1 and Table 2-2 from i.MX6SoloX Application
+ * Processor Reference Manual, Rev. 4, and from the
+ * imx_rproc_att_imx6sx struct from the Linux kernel remoteproc
+ * driver drivers/remoteproc/imx_rproc.c
+ */
+static const struct rproc_att hostmap[] = {
+	/* aux core , host core,  size */
+	{ 0x208f8000, 0x008f8000, 0x00004000 }, /* OCRAM_S */
+	{ 0x208fc000, 0x008fc000, 0x00004000 }, /* OCRAM_S alias */
+	{ 0x00000000, 0x007f8000, 0x00008000 }, /* TCML alias */
+	{ 0x1fff8000, 0x007f8000, 0x00008000 }, /* TCML */
+	{ 0x20000000, 0x00800000, 0x00008000 }, /* TCMU */
+	{ 0x20900000, 0x00900000, 0x00020000 }, /* OCRAM */
+	{ 0x20920000, 0x00920000, 0x00060000 }, /* OCRAM alias */
+	{ 0x20980000, 0x00980000, 0x00040000 }, /* L2 cache used as OCRAM */
+	{ 0x209c0000, 0x009c0000, 0x00040000 }, /* L2 cache used as OCRAM alias */
+	{ 0x10000000, 0x80000000, 0x0fff8000 }, /* DDR code alias */
+	{ 0x80000000, 0x80000000, 0x60000000 }, /* MMDc x32 DDR (CM4 view) */
+	{ /* sentinel */ }
+};
+
+const struct rproc_att *imx_bootaux_get_hostmap(void)
+{
+	return hostmap;
+}
+#endif

-- 
2.53.0

