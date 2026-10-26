Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C7606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OWtOayu+;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Uc1bx3M/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 888B3403D3;
	Mon, 26 Oct 2026 15:38:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eI4RikvBVLAq; Mon, 26 Oct 2026 15:38:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CBB4D4040B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793029131;
	b=jrYV8L505+XFKOgwnxBJFamrY7ZZb/esB8ghsiAA6jxvfOdRWykGEXnRmSvy+FhtEoPL
	 Fj/yfpZtH4V0mqg1b/BN0Ho7J9t/27Y36rBpfVN9Nqo82EpmbZcM3xK/2HT0btDwlCMb9
	 MjFfS+pvIRawt2Q6msSHyJyeORWre67s7U13+ycVs23szCDSTMMm3kQDH4I4WqtrLTJAU
	 ALzsj3qriQzLreZbVKtyrRTtl8ShoX4iAVtRgkz+ouZltIj4kKLL35kkHfVQ5ewBj61Bb
	 ncgovj2vEbwPNrq9N+w30XwzMT0R5BZSq25j5JGYbG4adRjaaWx26rVpYWhzn9doUlg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029131;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hzrBk82D9GgfnC3eYZTInK2+Y2YdG6wyENLa+gfaSqQ=;
	b=gyuMyZJodLD6f5Vb5SaHWUQW33VfWAX0Qu1G/6Ge/WOWOCOWMrSMzAh2cARsRqMioCLS
	 Dx/bEMpnLUmI8rYllWZOZj298oA4yOLnX59+hZAi69otBtbfpirp6i0L8D3X9WpYrcrUE
	 sD/+lyjvd7LD96f+u/p4R8M2r6xIz45T9OuJ36omyQYdhJhk7bcoSfcpk/Kuy/Zmblfc8
	 ROwLdKlB5AIHFGmppsNFfWL1RQaTgOT+ms2w+bUdz4NwPXHxdEPKSFrLRNoH3ajhwc9IV
	 svL3ZZ0cFTxAVgVEqOq4xD28SmoRm0KMfphAnrxX9EusOWpgO4mnYbudfH2du27o5oQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793029130;
	bh=hzrBk82D9GgfnC3eYZTInK2+Y2YdG6wyENLa+gfaSqQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OWtOayu+EXd6/Qqi41D6a3TDR8xVg3LMtQT+o123Ey/qjernPmgdarjTGoAleNEi5
	 tI/1HO+M0LmYBHLLIYMuc5Cc3swHLhy+rfqbIOo8tXsvTGbvV7M156RVK7+aftozkF
	 KQgX+zd76rPYOd26PNvk7Prcl8V006XMOnn+CM5zwbr32sWkNm2SVpxjxk+s8uSayP
	 tlmrhXiaIALh6/V1WXraaCodLwStfz8oia8hp/imUFJsqem5Lit9sMIO3kRfW+4QQO
	 RVhjkBwHRWKL0vJxmizmGcQkOe1sBvx3SdGie0olHOYlJ+cHUqD8wlavM5tSm318qZ
	 j3Vf9NTTEDaXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBB4D4040B;
	Mon, 26 Oct 2026 15:38:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 685693A7
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 644F280DE5
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9p7bn4FDz2p for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 15:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A2CD80DC1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793028990;
 b=f/o4LwpJqsZ2qD8lMudqikdqcdTXpclNoMRf4kRYbK2fI560TVI4ANgcxP14+bZKUM1y
 IUOvkvuF5EnL+pf34oHhoDsv9FzlpJNCBJiZ6dYQV3TeT+OK5tQkKJq7oza0cTqKk8AnF
 e8Bo+C7IHoc5PLTLiBvLLVuyeHB/3AIL/9Fwzi7XH+JOTX9j4yIvfd7gKLWfKk1cfdeoN
 AeK8G/Tr8u6h2csUwVo9ZEmb3io8HgPwUabbQ/uULreMxLJuIWMOhAiuRMfsqSRF6VPvE
 czDHrbXQ/3mSLqwUmDmKDWb4rYrUwDqZfkZNqrhO2Cqqsc0ZDnLmai5PNTenvB6yoJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793028990;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=hzrBk82D9GgfnC3eYZTInK2+Y2YdG6wyENLa+gfaSqQ=;
 b=dQAsmkTn1kMyqBi0n32PY49jLRhVCOUAVrmaKx8BgT3C1y0rrrcRC66+LNjaC5mfbzn1
 aLQJZGWSZamJozEKXz0FYK8Z7BxC7JmzPID9691tAawzneHKhp4j3BV7yz4HkGgMchssX
 5n2bNx8n6EhEVD8KcEtzXDged08J1NfEfAcI2uGj6cNIat1D8AVSre4E/PckcmkdAt7Ns
 TPVJA6+ONGIMjjakeBdAvQLMeJHwI7GeaGheNajY/YfmS0byuogAavYkj//D4+M0H5rPY
 WTvlAPC/Yki2bbqwdacKZWlM/tAzq9w2OiJINqXOJw+KrBxoWfUnVr66AQrN/Uu84Eg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="Uc1bx3M/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=clegoffic@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Uc1bx3M/
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A2CD80DC1
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 15:36:27 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1422010f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793028986; x=1793633786;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hzrBk82D9GgfnC3eYZTInK2+Y2YdG6wyENLa+gfaSqQ=;
 b=Uc1bx3M/DEpLbKO5pqrrzaKJPczsCi8nbhL7vD6gu2ls8kLHPiFLu0Zpbn9aMXhjWm
 SaDECaCeguLpfk7C+iN6WqLlEEWxQhai8vI1nmmONuY1h2eUnAofTFHq0A/C4T4DpMFy
 t2qpYyp2k0sAllTgG39wB4db61ZcxB9fa2YzvKs1WMITVTRMnZJElztr7wC2N9wpBWAK
 g3jA+E8+bEhqV4cy9YJiuUqE7e52KdMcIW8zoyw5GWAV7FmF6mMQaD55Z8Q7ls0gfrUP
 KhijQ7lFTWIKTABpAgRZOXMEoaIxiEtOCEFkKsgDniZKEVFQdCLkQ7kS/mKgklW37qW7
 5IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793028986; x=1793633786;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hzrBk82D9GgfnC3eYZTInK2+Y2YdG6wyENLa+gfaSqQ=;
 b=SESCsKNEWcvETZxa5liWJ2MDAmVmocSqcSYMOfcqP8k8BkgC3nHyczHVRXujRd52LB
 y6uIDH25A8jP7VWemOmKbMCkAJlVnPJU+JqdFlRrocVCS6AG96DWmYQyrAYwmP7rnVOF
 QB8nrv62W1PjUrzBbD6zFauKSdcNLzk72Fg/KQQAB6c3aZnFBJYiOwfiYcMqTMTFMf2X
 RMGzvaSfJsLJmwgOLmRargrwt7NKPAtdH6+iN0xP5BLDjKbKynJRAyPEAw+WkgmzxrCu
 ys/tkHtAtHEKGGsNCqfhUOO4ZT8Q4Oet5nrFzxQl3KzFNmobdyW+D6hzIbc46Xt2UEid
 59Vg==
X-Gm-Message-State: AFq9FYIno3tdyiBeQZ4ZDvcbNYmwFj1MHky3SmIekzybe4PqbT1rpQfJ
 FWUOTj24ZxRvh7VH5y71nWZmlAFKchhFT5/Znzh1HlbQkPk9UvcXXSOWhUaWb28ha3I=
X-Gm-Gg: AYBFou1EH+Gxs7i6C33stgHq59BVLgVIO/qrpte+Zs/wX9moCw68H5SN/sWJ4JHMFYw
 qgQrzy7RichojjOj7MWXe7yoQY2iSVwu23AkuG9Kzv3w2peASrmVxhSZnXZrPxao9dK7dgvu8Al
 w5AtLWkfLYjoHlzuzqLfpyWJMj3hY+arGXkiC0ItLOyxEZPbrdlHTSM6c8AsmmVQZRuJ/YStmvi
 5wRXyVdoXpsl1izI/X8y4jFz9Ek5RNVOlT9ApFjv2QRr6FBdXKENjryYDSOiN00HSHHkHtlA400
 o9eZt6dphya3j2bdcDApRyb8Gy+FV2B0E16OOh2D0oqdttV0Fx0GkzEGz1eCdB50q1Ur7leGkGr
 agsPnJJxx8JP41Gk3LfydtMKjv50ZPIRIVqkOV9HSW9xtdk7IzzWT4QOi9tajNwlF6p+8OZudPx
 YmmdEFTNbOMS5OpZo3Vp86PBXat+9u5EGbnhs39U1s1psfa4jN2+yKXI6kv70cCjCBBa/U4BSyy
 1vXwByusx8jWO7jZuZVpSTOGfQpR6Pb1FIJiMBLQqXAcjYLczSSwvCTF5AEXWGFrwLlSoC22ZzM
 +SOcWsegnB2eQaKHezgAz8piPpE/u4U+CTWvujp8TTev
X-Received: by 2002:a05:6000:430d:b0:48e:261b:a49d with SMTP id
 ffacd0b85a97d-48e3eb764camr12450560f8f.15.1793028985789; 
 Mon, 26 Oct 2026 08:36:25 -0700 (PDT)
Received: from localhost (2a02-842a-9b20-0d01-a06b-e180-2ea9-f6eb.rev.sfr.net.
 [2a02:842a:9b20:d01:a06b:e180:2ea9:f6eb])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd37f4sm20060480f8f.44.2026.10.26.08.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:36:25 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
Date: Mon, 26 Oct 2026 16:36:21 +0100
Subject: [PATCH] board: renesas: gen5-cm33: Start the generic counter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHRz32oC/yWNQQrCMBBFr1Jm7YCtNFKvIi7ayU8ckUSSVoTSu
 zvVxX/wNu+vVFEUlS7NSgVvrZqTSXtoSO5jimD15tQdO9faWJ6IOQQVjkj9DgsIS17SjMLiz2H
 oT5PzbiCLvAqCfn4H19vf6zI9IPNepW37Aiwu7K6CAAAA
X-Change-ID: 20261026-clegoffic-gen5-generic-counter-cd7f953b6d69
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>
X-Mailer: b4 0.17-dev
X-Mailman-Approved-At: Mon, 26 Oct 2026 15:38:48 +0000
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

The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
starts it before the Cortex-R52 cores are released, so their timers never
advance and a timed wait such as a Zephyr k_sleep() blocks forever.

Program the counter frequency and enable it before any other
initialization, through the RSIP-M alias of the counter frame.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Clément Le Goffic <clegoffic@baylibre.com>
---
Start the generic counter from the RSIP-M U-Boot on R-Car X5H.
---
 board/renesas/common/gen5-cm33.c         | 14 ++++++++++++++
 configs/r8a78000_ironhide_cm33_defconfig |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/board/renesas/common/gen5-cm33.c b/board/renesas/common/gen5-cm33.c
index f532daa16d5d..1837283c2bef 100644
--- a/board/renesas/common/gen5-cm33.c
+++ b/board/renesas/common/gen5-cm33.c
@@ -58,6 +58,10 @@ DECLARE_GLOBAL_DATA_PTR;
 #define RSIP_CTL_PROT0PS			(RSIP_CTL_BASE + 0x844)
 #define RSIP_CTL_PROT0PS_ERR			BIT(0)
 
+#define CNTCR_BASE				0xbc000000
+#define CNTCR_EN				BIT(0)
+#define CNTFID0					(CNTCR_BASE + 0x20)
+
 #define SYSSS_BASE				0xc1320000
 #define SYSSS_MODE1				(SYSSS_BASE + 0x1010)
 #define SYSSS_MODE1_MASK			GENMASK(11, 0)
@@ -1280,11 +1284,21 @@ static void gic720ae_init(void)
 		writel(1, GIC720AE_GICR_VIEWR(i));	/* View 1 */
 }
 
+/**
+ * generic_counter_start() - Start the generic counter shared by all cores
+ */
+static void generic_counter_start(void)
+{
+	writel(CONFIG_SYS_CLK_FREQ, CNTFID0);
+	setbits_le32(CNTCR_BASE, CNTCR_EN);
+}
+
 /**
  * mach_cpu_init() - Initialize hardware and start other cores
  */
 int mach_cpu_init(void)
 {
+	generic_counter_start();
 	mfis_unprotect();
 	pfc_set_avs_pinmux();
 	mdlc_mpg_start();
diff --git a/configs/r8a78000_ironhide_cm33_defconfig b/configs/r8a78000_ironhide_cm33_defconfig
index 3f09a7c25568..37d700096ff3 100644
--- a/configs/r8a78000_ironhide_cm33_defconfig
+++ b/configs/r8a78000_ironhide_cm33_defconfig
@@ -65,7 +65,7 @@ CONFIG_SIMPLE_BUS_CORRECT_RANGE=y
 CONFIG_SKIP_RELOCATE=y
 CONFIG_SYS_BARGSIZE=2048
 CONFIG_SYS_BOOT_GET_CMDLINE=y
-CONFIG_SYS_CLK_FREQ=16666666
+CONFIG_SYS_CLK_FREQ=1066666667
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
 CONFIG_SYS_FLASH_PROTECTION=y

---
base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
change-id: 20261026-clegoffic-gen5-generic-counter-cd7f953b6d69

Best regards,
--  
Clément Le Goffic <clegoffic@baylibre.com>

