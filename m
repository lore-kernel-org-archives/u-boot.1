Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F1606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BQ7AIWkB;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=P7C+Uvxp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F29F60842;
	Tue, 17 Nov 2026 00:06:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TP0A7nspQP0I; Tue, 17 Nov 2026 00:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 430386081F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794873995;
	b=gokg8ljc73NdH5jE3KkWdWFEoxMlcGqvMBGAu4ot/csjnsT5TceWsvrRvR3d+iyFMiyX
	 oD0yWYodtVT3zkHEkChPLpNcjNYUoSP9N8ZIndX3EvisaNAhvEamZ9SCy4O6bIkmqNzXr
	 nUMFtMQbbxG5kWWq1pEkrqBVsUV9n2K9Dxz0D0sk4HouISW4sWHiY3TAn8tBwQ4S0Cyt6
	 58Uc55ybcK92txlal5O+XKbl/Bn/O9CrI48RAyoQ9M7VHJv6W5VUXB0a/sivH44WKeV3M
	 973OTfzN5fBNkZxkOkyiIeG7udZ9EZnkLPC/dAm5u4QumRH3/b3yNx4IKS9e7xXDGTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794873995;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=eZc6dIsqg6lBmnrOyf8et/F0vqYCwJP6JNOs9kQ91XY=;
	b=rN9U4x+FSCXmgkKhP7fKjeAVRS5gli+lANbWR0gN8Dybfgznzr7CsnVmAmue0Hs0diHD
	 CHZtmxRDsr2QYzD2Jp8F7FLkX24ddeRK8Ez26knOs3HtBUzPDx2R4o9pmKbEQ+MrD/exk
	 LajlBVCklR/iyfcLmYttuHm8fIaAFgg8yXaCUE8fqteC8rzlkOStdBe9fVDSgGXU/7Xtl
	 cFsIUk5SgvVzn4xPGhJ375GM/KqsT2i8nbtzkYfx+gG13f79jmAcFX5jSyeaOUVHATTCK
	 IDZe94W45CIoJWaMWC8LZjLrxNCocttSvvWJd6FrrTYHhkuQ7n59aOWHDvBir2WHosQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794873995;
	bh=eZc6dIsqg6lBmnrOyf8et/F0vqYCwJP6JNOs9kQ91XY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BQ7AIWkBst8qCg3M9odcE8gLKrQesGrXgwd7ZjVexAGH200LAtNKclvJg1UVniCJt
	 LkTvqKamA6gGRz3LvbNBfhZWApsOYjM07JvK2z1iVFGozjn3135R1aobD73tpUmGRJ
	 OSH2JCMtKNIP5fgsB3vEdlxFDZfE4kBwvQdXHZOrKLAkOctvMYBPsF4XeyPEVd6Qwl
	 MzyscoEN6+xsXDAQr/Ir3PlZBwyrSUYSDyNnQRsHRSaTXx3gZ3MLjbhzRHnVdOGLWN
	 pBm7DMuWI3Wp8m7OXeQ+5dkrj0fmC3DrgZ1fEboUng/V3oEVS4KgJW+W4MMKQ3xBK0
	 ExeKRGdAn+yMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 430386081F;
	Tue, 17 Nov 2026 00:06:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 815A91E7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7245F40572
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLUWpOqVgSry for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 00:06:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C63640568
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2e; helo=mail-oo1-xc2e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=P7C+Uvxp
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9C63640568
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:33 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-70059e4dab6so2903378eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794873992; x=1795478792;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZc6dIsqg6lBmnrOyf8et/F0vqYCwJP6JNOs9kQ91XY=;
 b=P7C+UvxpfoyS3CkEnxlQMum8b3EidztrK1AsIXBlKsWNu23wGQPdjaWwVxXwL2EJ+K
 0lAyI700FqgiZgx9ktjShsYKgEbsOA/U3c9ssh80qTv+pOcqLeVsgTFQTY614Ks/7CyS
 wR9vpgJaAvXJoI7YALxWWqEQCt2yKoZt7FJmJLqNYpwYkKpGkkxXzBpGJCWiVwn6vjZV
 S529QWP2y7CsXUp70YQOEx5T+w5X112GoZaj4Gb3MFeS7dxWvBGVUgDdnR1M+UU7CN9M
 lopB8SLLE9wihIYh00Cv1ocwMe1RoA7gvI/Coa4IVxt21DHmKcOQn3DXwqwrNYgpzmBU
 dtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873992; x=1795478792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eZc6dIsqg6lBmnrOyf8et/F0vqYCwJP6JNOs9kQ91XY=;
 b=R0ih15L8wCnCOWomzEIn0kwQCCnbVdXaiZz/LZ+hnT4LzYF9/+SDAhFNRPbbhW/aV7
 vAR/hW7QfKio/FQ3l+rdx5FPgqt3iBbEnpK+uKSjTYTGZGVrOeU/9BmIl/Uxzw0j7eBo
 BaqjG+0CFzNpDSqgvQwqT1zUK2OeqiHkVq0sM+Pw/BaNX15s0MD7+yyO4W4rJZotFI8i
 UBh5DAtxKXV9BsRSulcjg7IS88Z7ZqT0FpvVmtWeCBrbZRORsgqVYW/Dro1mZp7wyRZi
 e4WwrFy4YBi+Go0OBl7KpxPvtOtkhUxaX2PwYzG9vu6ylk1wFU47EcJBTuf5lPEu+KKx
 m0SA==
X-Forwarded-Encrypted: i=1;
 AL+hErEwja7MS8bNY9/uJzRbpUq5xNqIcJBQ1iGZDv/e934orD37BRAM9WZjfMAik0QOsAfv3COFZTM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9CmBbu+6zo7Z8M6Tp4Z1lK4pGNDJNY8FEgejxeo0xWyQUGDnDb
 agu0q/9Z2cL1TjnWObCSV1clM8vX5Vx1rWC601HTV9z2xMmphxf7kZKLNnK85QRcJiU=
X-Gm-Gg: AYBFou0G6/cGRBsGCo6U6zGsIyBIK3b2CZpd8LjhOQPrvWF+BT7Rx+uRGvisIuwUL6m
 7aXsFqokZzOgfZyVxNJgZJHh4oG0ghbq7yCHgJ7uxOmGIKZt/e+tBW9cfrIHg3hsMNT1lsx18Ur
 joSawmUiWLFppZGlXGEH44X/F8mKpfGAhbx+NzkCT+Nrnrk+mAlY91uC8mAJXKUf6hnTH6ha8+r
 0A5fjOCnZqfcWjMoC9goOvgR3NFhSEdIAuz7zo6klb+9iUvzq+ufPhOyrfQuVrlAroycpF6HJy2
 HbQ/Fa37BkBkDQW8zwF0oJpEgBOJWsAxa021xoHofTNQjzgXRqXsxO5ujDcR6OQTO5RhD96cE/Z
 VYjYu00qiIJAWKu+6uMLZGnExoQNTpCUv5pQ8g8AmC4sCvOyNqotz07thwCks14vOSE+hlctO9s
 XkT9RY0hckXpA0NcT+HfW7EkJKlecEclZ2/xAADhEKJXBtlo3EIKulG5R6l+QRqEdPeVrFHdubk
 Yu/KXPl4GeqymrEqOtbTTXnmPlIQtyiYKCPf7zfdMfQ7NmJd2+XLiUDgRGfe2iwqO5Ul8z4SjrW
 ePLsVqdTNX0yrXag3xKNqq/mHF/K1TrTYMyT1uOvZKz46rDPRKSMDn8=
X-Received: by 2002:a05:6820:1391:b0:71a:efbe:ef10 with SMTP id
 006d021491bc7-71aefbef76fmr3517865eaf.3.1794873992060; 
 Mon, 16 Nov 2026 16:06:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862beb11508sm5097254a34.3.2026.11.16.16.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:06:30 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 16 Nov 2026 18:05:54 -0600
Subject: [PATCH 2/3] board: mediatek: add a Genio 520/720 SPI NOR boot
 config fragment
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mtk-genio-720-spl-nor-v1-2-7a926f80dc78@baylibre.com>
References: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
In-Reply-To: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2063; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=xoPxexqT4qSQi2L0aAwRqyhUvtxpPwpOyXKsf94X2q4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+5px2N40T2KmW3Lf2IdzlD0RF7RXHkabV1Q6p
 clkWjF+VRqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuacRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A78sIAJlTzVGfQtU2d+/4Q9AnWcWAYE6uypLnpqL2pMd
 F+exS1ToFbejjCQdAG21q7V3fLODmXvcINPnTwCEyVxxszX9aZ4mb1YeXGR5r9mUe0OL6Hhn+6b
 6bYvkqV01jv172chbn3jJntOhpNoH+dY+uKSfJdibxqXJjWQHz+wF6XoW3IJR41dt5T3qKNUvB2
 60JkzMpLjiZax8i3RwR8WtpNJpr6uy0Lg+AN+YID3qitb2FGGHkl9wGemktwrGWPShiMQA+cZD1
 bd9pAgX5b96CQz3cbRo+WQLP0uhr1pDbHY6i6nAmreoAIt1BKIyGOxXYvqLaMVtzyelBZstbh/D
 wSR8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a config fragment that builds SPL for booting the Genio 520 and 720
EVKs from SPI NOR. It sets the BootROM image header to NOR and makes SPL
load the firmware FIT from offset 0x200000 of the flash, right after the
2 MiB reserved for the BootROM image. SPI NOR has no partition table, so
the offset is fixed.

Disable MMC in SPL. SPL picks SPI NOR first anyway, so MMC is not needed
and leaving it out keeps SPL small.

Use the fragment together with the board defconfig, for example:

  make mt8391_genio_720_evk_defconfig mt8189-genio-spl-nor.config

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 board/mediatek/MAINTAINERS                 |  1 +
 board/mediatek/mt8189-genio-spl-nor.config | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index fabeb18300c..e59d6efc6e6 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -7,6 +7,7 @@ F:	arch/arm/dts/mt8391-genio-*
 F:	arch/arm/dts/mtk-genio-*-binman.dtsi
 F:	arch/arm/dts/mtk-genio-binman.dtsi
 F:	board/mediatek/genio-boot-images.config
+F:	board/mediatek/mt8189-genio-spl-nor.config
 F:	board/mediatek/mt8189-genio-spl-ufs.config
 F:	board/mediatek/mtk-ufs-rpmb.config
 F:	configs/mt8189.config
diff --git a/board/mediatek/mt8189-genio-spl-nor.config b/board/mediatek/mt8189-genio-spl-nor.config
new file mode 100644
index 00000000000..cf6072b0a85
--- /dev/null
+++ b/board/mediatek/mt8189-genio-spl-nor.config
@@ -0,0 +1,12 @@
+# Boot the Genio 520 and 720 EVKs from SPI NOR instead of eMMC when using SPL.
+# Use with the board defconfig, for example:
+#   make mt8391_genio_720_evk_defconfig mt8189-genio-spl-nor.config
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI_LOAD=y
+# The firmware FIT follows the 2 MiB reserved for the BootROM image.
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x200000
+# CONFIG_SPL_MMC is not set
+CONFIG_MTK_BROM_HEADER_INFO="media=nor;arm64=1"

-- 
2.53.0

