Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62036C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 21:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 669884052C;
	Mon, 14 Sep 2026 21:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p5obml9-2DFM; Mon, 14 Sep 2026 21:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7688D40527
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789421612;
	b=cGzhA0QHKGpUx+MSqaz4S6N0PMO5OKrC8JyZx9HvtCTx0SutL/FuG/Gc3rFtAqc2EpVE
	 OKbe96B01pgfM4VnFhcQ4mhE8AsnE6F/EhNYM8v8lc9TDBXINSUTXjNEbk4tXpXwEUrPR
	 cE3AKAREELsXp+5UcA+H/w/giVY6JBoZNN0Qte8yFexACWrpvhRsUUKzxGEDdl1or1A77
	 0q0zwSkxrXdrRgcH1FNPCQSyd4xZIZwB8Z1lKCXEvi+DUWKXTe2GKae06Kpao4GtCYq5x
	 C8RmBwJ+fOEJAp/QU7dskV3K+vlBgL5y2Et6IcRVjGKtocuC7+EMC8i/FLdlK512+pA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789421612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=icOlLTv3UppVqdUFRXh9X68td6y15gd8BIzSU7bZ0kQ=;
	b=dhXbP3LFulF/Eh2VbkCFC/lezYVC0ce1Lod6gXUQNGEDbC5xBFXLmgjNCC9XfGkPZug9
	 NIYNnlBDoc34e7nm3LeaeVpZbhfMQ8XeZjiSrS8KrJk4jrNdbnQKc/5sgdQ8wr6qXm6cO
	 EFc47qTuY3GTX34YD4pjfFa4QdhIu4rVrRH+KGpq0FBrWxi+o2qfyTq4t+D2HS0r9Sclc
	 dh0hA8wiFaX/i1EDK28zWattkBLtZPgEy35MoquBizHt0wkZFOegmKB7sEcR1Up3D/R/d
	 OfHxS7NYelCTFkyu9tbwpBozV6jnT5e7BDr7P9iJV3uNhujdLw2i4pARDpA6JNvUhhQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789421612;
	bh=icOlLTv3UppVqdUFRXh9X68td6y15gd8BIzSU7bZ0kQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ks2+qoUWek243dOV/s7Stuv42viSJDK0naghtK/sAK4Ck2/XfWs8wwOquNNTD5UkN
	 mUi1/c1vZ5BA7m5DUH9FKBS84e7d7FGVTbuB0QqIlTpjXsoNsQpfH9XRqx5wdOlxnO
	 dR6ZPZ5ONdsx81UUF00NTt1/s3zSpaTXsOyhJO/xki3JaSa2cOiFjzmPjzUp8wDIgd
	 1KEJOmOoMtvOyk9sDfBJtgjoT2YLe1K9VFmpmIc6zuF7xM5fWQhfYbVJ5oUsoXA+6L
	 /xZL+PVo0lN5RPIJLcC62ku9QKF7/yJV4hndyMuD1U/dMr3zKpZLk3ie/IwOWMLoGB
	 Bvc37Xk1TTrzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7688D40527;
	Mon, 14 Sep 2026 21:33:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DF45493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3007680B80
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oN-3bhmdatRK for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:10:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7698D80AF3
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789416640;
 b=LjaF+8FaFT8yefaJfTSa3AMstaueoYPUSJGHax8uelzzvTjsP9M0Yvzbz7hxx5P+Vu66
 Fx+vSV+CEj1tokmovpsxDAtMQ3Sn97Zgfpk6SsRquPyvK71labx6372KKIi61bxSyclwv
 nVGvXqnpga9TwEPJauabOeLSNR/n+l8/cPLVBH5hh9Z4pIQCTXaMfO96atQwRiVizComh
 hQwFhcvhYM++W57wDo1ZMSgbrCFBpxvEoZDxcelbo/lFCf20pYp1zLXcSd6UOR6xQsRjM
 rM/bxyt7j9sz6kOoGHIiONcKLj7LmpoflAhzsKihk0z5xJPw4Y1g+6lL1cmQt+CM5xw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789416640;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=icOlLTv3UppVqdUFRXh9X68td6y15gd8BIzSU7bZ0kQ=;
 b=AVy3kRhQLCqNAH41ZHKGMU4oYctRrdD6fLsExniSrBByLL3qdSUUldc/ej6djDFuzT4G
 KXainw5dmHcnkCyRC5s80u3obq3bOkbaCXJq6y5uDyikOoqWJ82PlSOaKWnsIoWyU1Pwp
 WAYmfG8yRWn28xwfnOX5RGRmrLLHc9+J6WWfIiDDCsTVRC2uxjphMt7YLvKm5otwT3a4d
 Tzk6mNAxwxo0Gf7WAR0VUT08lTnXZtRyfIAa++iaQ1z5KTTh3M1VV3WqNDYvC3qc2iXjj
 ijgZAh5Mf6ULuq3AD6jkfl551hx6RCfu4dspQ5zvabh5+Itkd+vDQ3mtdL2ulKg7Sqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=THpfTDr4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::11; helo=mail-pj2-x11.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=THpfTDr4
Received: from mail-pj2-x11.google.com (mail-pj2-x11.google.com
 [IPv6:2607:f8b0:4864:39::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7698D80AF3
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:10:39 +0000 (UTC)
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so2628197a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789416639; x=1790021439;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=icOlLTv3UppVqdUFRXh9X68td6y15gd8BIzSU7bZ0kQ=;
 b=THpfTDr4v9D3SO2gIfufvaUY3WZ1q1ZDhucteXBLC2yFgyISoRLlYFlnRLPSJGNtaA
 q1FNFjZh1iAvfayDvBpY3o6qWxKklKl+rT+caOgo2sG2ZudAzl1wh6Y1C86iiskvuCZY
 0cw3O2uoiOW/LJu5TXqtAwoXTc/olMEOjO0Kvnp1mTh9zdPkeyVyOqlRQqgopNFd0WnX
 06t4Mj40TM/VZoH4ZpRshQttgKdKbwymJb1C7Ljh97BS67Ii5OK+r1MMyFcRxBMZfVjI
 0mqywAMPK404cgLqIemgsZqOFJtAonfoElJHEOPklHCowsjXl7Lz07bpTgZS7g/oM5GS
 ZkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416639; x=1790021439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=icOlLTv3UppVqdUFRXh9X68td6y15gd8BIzSU7bZ0kQ=;
 b=YEaUCF3ILiCztNDs5F3qzrT0wcjQnAdDzdk1eXVLug7DZ6eBpsefLYjI6f/Rni+JPh
 rZSHdwbiQkaW+OFLjmwUTusgaO/WZ6+l/PLJgANBXYRrdej/WOssS/yKDYfEWKadES0+
 dFHu5DPXAc0xRP+tzxfJT3Lu6OwPtIpmwlqHz7sNy2ki0sBXzw/PsqEHYSi35+x2fdap
 MQAf0VQGKmpuGzl9t4aasHiHdvbvqcPWTDf0M9KvomsffX9/+rScBFl5j/Ml5ofo0gu6
 3J6+3vN/nwHVH9MTiUmsNSQE93G9JufEq5XYD8/cifGkpQ8YkDcKfKTWPcsjhDb5rB3X
 it4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBywk+L5ff93tyXnYDeSN9nlDMFcXfwGNm/QjOrg0dU5V5zQusthQGuZU+RWc1XQKg8Qu3RDlvQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kD//Zk39pDpwiCzMPvCqfvhTnt+xIxQm1l2VX3PfO5Unblv6UE
 bJIC5IDiRm1Q2zvTrcUOIim+p9i0yOJK8oSoMYA+LxhMzrcybxkTRKh9
X-Gm-Gg: AYBFou1w+bktk0Z2oZBLYke6RqMwZNsMy5LY3yR+HOEP0hkOkLd4O/vvTxuusUM7c3N
 NFEHHiZbkFzU3p2xkXAlnM2K6IaxfaPue5enBpBsGu+egUMUd4fG+q2C9FyJVHQpHif80M0LtJ7
 9fLY34Q2Rt4mRLeBotuWXEjCW8hTgsv20m24UWJaRk1HhcDM16X+SFAkq1TnSj01pBZg5d74JeP
 6Ap6CyohtGvxLcsNxqyeEZiNP51FjfKcs/Xar0Am4DkdBPqKbeFonv7m4piX3z2LkKHAoi8v6uB
 7WRS35/IAaEy2mZZmK5ctoDGTgdFCMb+GZVtoWhdNcThm5Ki5EaF+eAHvU8T1WUGuFTmM20XQxU
 eZ6q+B9l5odBNUI3zO/LLHb2SGFzyf6/TKqi8khX6XDFePN+f5WelyPY37T0mdj0N0lyrNI8La8
 aSngScSZPGLoecmbqfVrsJaNPoNR399hw3f1htfBfxrCC7SRDEUUA+fDU89WAODSJ/3o/9Xx9eE
 SWPAirVrr835DoTnIl6CaQPzTwCms6ODzJsWUqzfa7u+CYvvywb9NarNsAfGzGofEWyNryevuVS
 PDSE+WvZsWUhXPAj7R5a90WYZN4vpMSTPe4ENeIw901V
X-Received: by 2002:a17:90b:3848:b0:39d:f4a8:75ef with SMTP id
 98e67ed59e1d1-39df4a8944dmr5199140a91.1.1789416639125; 
 Mon, 14 Sep 2026 13:10:39 -0700 (PDT)
Received: from 0xiviel.ip (122-63-135-80.mobile.spark.co.nz. [122.63.135.80])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfd9c557asm1005407a91.2.2026.09.14.13.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:10:38 -0700 (PDT)
From: Eva Crystal <0xiviel@gmail.com>
To: trini@konsulko.com,
	u-boot@lists.u-boot-project.org
Cc: ludwig.nussel@siemens.com, jonas@kwiboo.se, sjg@chromium.org,
 daniel@makrotopia.org, anton@binarly.io, Eva Crystal <0xiviel@gmail.com>
Subject: [PATCH 1/2] image-fit-sig: also require signatures on the image gate
Date: Tue, 15 Sep 2026 08:09:04 +1200
Message-ID: <20260914200905.280557-2-0xiviel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914200905.280557-1-0xiviel@gmail.com>
References: <20260914200905.280557-1-0xiviel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 21:33:29 +0000
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

fit_image_verify_required_sigs() and fit_config_verify_required_keys()
both look up the "/signature" node of the U-Boot control devicetree, and
both return 0 when it is absent. There are then no keys marked
'required', so nothing downstream can fail the image: a FIT whose
signatures are absent, malformed or invalid verifies successfully. The
only indication is a debug() call, which is compiled out of a normal
build.

In the configuration path reqd_sigs also stays at 0, so the closing
"if (reqd_sigs && !verified)" check never fires either.

On sandbox, 'iminfo' against a FIT with no keys at all in the control
devicetree reports verification success:

  ## Checking hash(es) for FIT Image at 10400100 ...
     Hash(es) for Image 0 (kernel): sha256+
     Hash(es) for Image 1 (fdt-1): sha256+

Add FIT_REQUIRE_CONFIG_SIGS, which turns a missing "/signature" node,
and a "/signature" node holding no required keys, into a verification
failure on both gates.

The new console message is printed only when the option is enabled.
Boards which enable FIT_SIGNATURE for image hash integrity alone, and
which legitimately have no "/signature" node, keep both their existing
behaviour and a quiet console.

The option defaults to n. Enabling it changes behaviour for existing
configurations: with CONFIG_FIT_REQUIRE_CONFIG_SIGS=y, 13 of the 32
sandbox test_vboot cases fail, because test_vboot's first step boots an
unsigned-images FIT against a key-less devicetree and expects that to
succeed. Making it default y would require test_vboot to be
restructured first.

Signed-off-by: Eva Crystal <0xiviel@gmail.com>
---
 boot/Kconfig         | 27 +++++++++++++++++++++++++++
 boot/image-fit-sig.c | 15 +++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba49..c1dd1de6ed 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -137,6 +137,25 @@ config FIT_SIGNATURE
 	  format support in this case, enable it using
 	  CONFIG_LEGACY_IMAGE_FORMAT.
 
+config FIT_REQUIRE_CONFIG_SIGS
+	bool "Fail verification when the control FDT has no /signature node"
+	depends on FIT_SIGNATURE
+	help
+	  Without this option both required-signature gates return success
+	  when the U-Boot control devicetree contains no "/signature" node.
+	  Verified boot is then silently disabled: a FIT image whose
+	  signatures are absent, malformed or invalid verifies successfully
+	  and the only indication is a debug() message, which is compiled
+	  out of a normal build.
+
+	  Enable this option to treat a missing "/signature" node, and a
+	  "/signature" node which holds no keys marked required="conf", as a
+	  verification failure instead.
+
+	  Say N if the same U-Boot binary must also run in setups which carry
+	  no keys, or which enable FIT_SIGNATURE only for image hash
+	  integrity checking rather than for signature enforcement.
+
 config FIT_SIGNATURE_MAX_SIZE
 	hex "Max size of signed FIT structures"
 	depends on FIT_SIGNATURE
@@ -259,6 +278,14 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
 	  device memory. Assure this size does not extend past expected storage
 	  space.
 
+config SPL_FIT_REQUIRE_CONFIG_SIGS
+	bool "Fail verification when the SPL control FDT has no /signature node"
+	depends on SPL_FIT_SIGNATURE
+	select FIT_REQUIRE_CONFIG_SIGS
+	help
+	  Enable the FIT_REQUIRE_CONFIG_SIGS behaviour in SPL. See the help text
+	  of FIT_REQUIRE_CONFIG_SIGS for details.
+
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
 	depends on SPL
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index a0c50bba4c..06ec0f39d8 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -201,6 +201,11 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	*no_sigsp = 1;
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+			printf("No signature node in control FDT: %s\n",
+			       fdt_strerror(key_node));
+			return -ENOENT;
+		}
 		debug("%s: No signature node found: %s\n", __func__,
 		      fdt_strerror(key_node));
 		return 0;
@@ -684,6 +689,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 	/* Work out what we need to verify */
 	key_node = fdt_subnode_offset(key_blob, 0, FIT_SIG_NODENAME);
 	if (key_node < 0) {
+		if (CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+			printf("No signature node in control FDT: %s\n",
+			       fdt_strerror(key_node));
+			return -ENOENT;
+		}
 		debug("%s: No signature node found: %s\n", __func__,
 		      fdt_strerror(key_node));
 		return 0;
@@ -735,6 +745,11 @@ static int fit_config_verify_required_keys(const void *fit, int conf_noffset,
 		return -EPERM;
 	}
 
+	if (!reqd_sigs && CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS)) {
+		printf("No required keys found for configuration verification\n");
+		return -EPERM;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

