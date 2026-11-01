Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0D606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UN9cVZQ8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IhJNF6if
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B740540693;
	Sun,  1 Nov 2026 21:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFXp73EHvsNN; Sun,  1 Nov 2026 21:06:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06DD7405DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567179;
	b=raDSUXA2beBJhdE8KbQMyfaxbotFv9eKXmbWcN/wYhVgwlk3FPkitTefOg1y4Cwk6smf
	 iYauKdsnojhTCMFq8oW7bU+RlF6ivUpCwlpYlyDUiJypyzk8AGh45xTnqrIsoJ8uFri40
	 O28Unq5h3aUZWDLTIJ1mGaY8VT6fHelgLXL2B9+bc1WLfA2sQJVRsuxZz+Qdl97hzUrp7
	 AHiddlq+iG9VOEmOsLfoQLtzpOUWfG5qHegAcFxL17BOYtQf0R6s8FwkbJ/5VnkSi8E7l
	 9HTQH8lPoR/Htpq/16Nfcr6poD+TH3n8rjIh+Hkgd0rco2aIIVPqr0V4M07lK7IXnzg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567179;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XKtr6qAcH/wWHi6i2LPwvuF/y8MGguRsIwstEWFuurg=;
	b=tQcCJOAmGxPvJPSJmwCaGlsTW5LE12NNIUV5EW/LVslcUD/iPpBp8cCGiME5UFCE+++u
	 f7HKK4qQXfcgAxxLxswcQviNIkLv97oaePVlpj5RUPu+bPuP4JpyBjGxohFQ34qn0gWxs
	 ZB3/XbXZLs3x3S3Q2TVQtRyOuijm+bzxd/hErhQmoanHw5nmnJQOoIFzj85DkhbHc4kSg
	 DrApWhZUy5No9WnuEEw2VRdoNPlwx+pwXFlk6j4A8C3C/ZIE9d4OthqfFgXAgp/Fgaw9K
	 xbm/Rto1xd0woAJammAbj62CtkxpX1EcyjDcx4D6A0r7szS9m0JZ0SoyKrlyE9q/6lQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567179;
	bh=XKtr6qAcH/wWHi6i2LPwvuF/y8MGguRsIwstEWFuurg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UN9cVZQ8cxR/H15hSQubOvCECPW8DCjHxw5oIkKiiOTbcAfTJw+M6ZvGaggnawGvX
	 nd+wi8A0EI/7RW+TqARmFionw0+a7sCyXTNJ9vHRkJEIbZflN2PoYx5wwuv0pNrPrQ
	 FzSDha/mBElluZ+msD4jCSrD7lo45kPZDZONwZy2pHcJ111XZ08dhXnkFyYbNOsQPz
	 3Q2P+9km3CdVjSN4B2Wjzp5BQIs0PTBPbEi0xC33c1wItF4kUXu4YHhhH05ROslPAE
	 5jukVfxjHa4b5GwyT0rfa4bu/B0l+vISqofFfGDm8ss0hKVFS7Oem3paVeMepHCzVw
	 DjNUcqDEHgf/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06DD7405DE;
	Sun,  1 Nov 2026 21:06:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C231EEE0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A6EF960684
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zmoqLsmkSsrD for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 21:06:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA83D60612
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::234"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793567170;
 b=Uzb+NcHSgkVQJo4ZOK6RhqueM1odzhvrqvhq63LJ0e3KpEd6n0i/vs9JaseoFgz0rA9v
 e58XyPJelrBroSpYnGW88Bgitr7dFHNhahIgLE5cNmL0taGmwWyTM5NeuLE6NHYNWjX1H
 R4pPj4+JfCzEfd2RlkWB9fV0oVcBOas8Afr+22QFcTG7nuog5ex8ZxEANK/dkdNDjx2uL
 /q12FOY8ne4RHVjjYLVxXU3qzYCZH0tX+/PZVsoFn/JkSWZAeYymV7JNQ4Kgd+XnehlG0
 CXzp6Qgx/MNKJWt2AZIpxgh85QELXO79pkvgpEj1mSsx8nrIWfi5T3fdrWRwHkc8ADA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793567170;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XKtr6qAcH/wWHi6i2LPwvuF/y8MGguRsIwstEWFuurg=;
 b=B4qbMZRjbMQiLwynNd1kIa041wtrWV7HZuVZXNNa3yyJK1A4mFPcC/Vo+Akb8IXkNYaW
 00wrbyuGXsijzhx7o/CVtK677wgCp4eKJk8N9ZjwCdKXto9w0+EerYhStVT0kMmGhRZWB
 SnpEfubTlX+Rz2+amXRsLWWYqeCuPvcZlq5xIiSWl3KYbm5BsxWkSNGwpXlPSSU3aXohF
 G/GURijp4Ou8o58XkqK6fDip9dtS6DvVFi5ch+6JkXatuRwHu9g+crXlbjjgxfntM79ft
 WtrEqRe2FKL48n23J12AQLWgwNrFWl1HPYIM3u1xHwL7HmEiHC4bb1u24GAeTu6Zr1Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=IhJNF6if; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::234"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::234; helo=mail-lj1-x234.google.com;
 envelope-from=indrek.kruusa@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=IhJNF6if
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AA83D60612
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 21:06:09 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-3a98f260f85so22534141fa.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 13:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793567167; x=1794171967;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XKtr6qAcH/wWHi6i2LPwvuF/y8MGguRsIwstEWFuurg=;
 b=IhJNF6ifFEl/+OocwWtS+0YRM+0Wm7KE/1LPv20b/LSDuwOdM7md7T1aWm8ach0rkZ
 mVNXln/W56J49Hl+dLGiaC5Kd1pSyWH/Hp7SVlemFY5ayA7LZHKM4yCxXi8iqZstmn8L
 4vM0evhp1mDRLomHVZVYVFRoaQhBIWauSnKdCiBVtSTRXflT4YCCeD70rG5kE2mWWgcj
 JEm8gXwuOctqSiyx8pPIPlT4TA5wU4WGVY0vF2sYf6ONdhM9beUvMXtsfJQV/lLzw+th
 k6aZqhDeDoU61Wyv8JDcrRd3gLTBk7LOjZXiyOXq2i3NUQknXtxFAzcX1rHKtEUMukK6
 v+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793567167; x=1794171967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XKtr6qAcH/wWHi6i2LPwvuF/y8MGguRsIwstEWFuurg=;
 b=XNuPEHT6uN6ThgW7mEQQsBe3uYwhQio0lypz/qPwmtItv+dMQ9fRAYBU4mAVI5EjKD
 XRuVXOO2lety7XBGF7AamjHq0+xn3tJJJqUnHkyY6pyWvgPIqv8rAzLOAvHz3gQoIqTl
 KuEC30db6dAZZA5tC71taSDK9zVrUplw9eC4pEJrjqtBgxRJNQw548DDpmRcElB1OYxt
 GdzGNPGkzMXEDJlIXsM5JGyiOfhzdyTWOA+BdF2JhCdXk0B5Y1Lw6qxI8FrRj8oejCHv
 rz6/kfETnEqaebP62w6PFWW9Wm+eby/7mvw8EXRE+xMdbWSY+gze4poKec9Gopa4riji
 ZVfg==
X-Gm-Message-State: APuU4Z/7TXjYzRS8DmNLG2OXHxZr1OCfbFZ9nJgkT2nh+u1Iq7sgzOqa
 s5MUvI45veWyWlPRGqUzct3DETI6cFdsf95r7x1os3s8GCWUg0ydofkPqxrtj2xA
X-Gm-Gg: AYBFou3wUXMojgAQkxA72qyu9aZT5S5x2QiKXUdz1jeMXtzWP5WWXzq+NU3dnh3dC8t
 zUIJznz04WwgYjecU+zhcp/L6Vy+1a+jSlosZmvxvkQtLRA736DbYQ4y7sIgAFjZes1SjP0UJy1
 UTcq5uDRY/zOJSzSUufYAY2htC2CJjloVkMDr/hlLyRUzsZLOzFPeWDDgmcYWloJKJZND/WHGvA
 64R2IvpsvDPfGuryLBTmtmbgLBgUHiTeZKlpbg7rDjRO8T/XifDllY27OmBSXl2t+kjc/leSFBo
 6W7F02NtAsUIAITIUC6KWe/SLnPqk18SntKzW7KELeoxDulipvfAzHRyV/Y57+SaiFE1ntsHO/q
 tIOwudWcpLjp2f9Vj6lEpQzCL+XS10Kdu3LzZgpoNjT/pQWU8lhv+1xb5UhYx4Nmmoqxy17J83o
 NIM9VoD+qZ22BhfzlpRSG2fT7+lWCHQ3pZjg4F7oIT07mWMhpNcmlltomj14TQDrWiOQCUXY2M+
 U+p4ZZjwjvKVQACFB2cmre/GZ+5qe9gN2vwiR2XUCjjcEpkgawG5zgzV3zIgXBlMVl4PnYYev4E
 q0nwsObdat9P4nLQZG+ZWQcABTONfE9TN8DAVApKrKLkPNU1GfTmkqjnm5sCDz29JHc=
X-Received: by 2002:a05:651c:1551:b0:3ab:1862:25fe with SMTP id
 38308e7fff4ca-3acb7a2bc74mr20088231fa.4.1793567167180; 
 Sun, 01 Nov 2026 13:06:07 -0800 (PST)
Received: from ik5070.localdomain (82-131-69-225.ip.elisa.ee. [82.131.69.225])
 by smtp.googlemail.com with ESMTPSA id
 38308e7fff4ca-3acbbee0094sm19882441fa.20.2026.11.01.13.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 13:06:04 -0800 (PST)
From: Indrek Kruusa <indrek.kruusa@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Indrek Kruusa <indrek.kruusa@gmail.com>
Subject: [PATCH 10/10] configs: add the MangoPi MQ D1s(F133) defconfig
Date: Sun,  1 Nov 2026 23:04:49 +0200
Message-ID: <20261101210449.1235102-11-indrek.kruusa@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MangoPi MQ D1s(F133), 64 MB co-packaged DDR2.

Signed-off-by: Indrek Kruusa <indrek.kruusa@gmail.com>
---
 MAINTAINERS                      |  1 +
 configs/mangopi_mq_d1s_defconfig | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 configs/mangopi_mq_d1s_defconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 6618000f168..4cca82da801 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1550,6 +1550,7 @@ F:	arch/riscv/cpu/sun20i/
 F:	arch/riscv/include/asm/arch-sun20i/
 F:	board/sun20i/
 F:	configs/lichee_rv_dock_defconfig
+F:	configs/mangopi_mq_d1s_defconfig
 F:	include/configs/sun20i.h
 
 RNG
diff --git a/configs/mangopi_mq_d1s_defconfig b/configs/mangopi_mq_d1s_defconfig
new file mode 100644
index 00000000000..689f661ee89
--- /dev/null
+++ b/configs/mangopi_mq_d1s_defconfig
@@ -0,0 +1,20 @@
+CONFIG_RISCV=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun20i-d1s-mangopi-mq"
+CONFIG_SUNXI_DRAM_TYPE_DDR2=y
+CONFIG_DRAM_ZQ=8092665
+CONFIG_DRAM_CLK=528
+CONFIG_DRAM_SUNXI_ODT_EN=0x0
+CONFIG_DRAM_SUNXI_MR1=0x02
+CONFIG_DRAM_SUNXI_TPR0=0x00471992
+CONFIG_DRAM_SUNXI_TPR11=0x00030010
+CONFIG_DRAM_SUNXI_TPR12=0x00000035
+CONFIG_DRAM_SUNXI_TPR13=0x34004002
+CONFIG_TARGET_SUN20I=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+# CONFIG_SPL_SMP is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
+CONFIG_IDENT_STRING=" Allwinner D1s/F133-A"
+CONFIG_CONS_INDEX=4
+CONFIG_NS16550_CLK_ENABLE=y
-- 
2.43.0

